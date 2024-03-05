FROM	gradle:7.5.1-jdk17 AS builder
WORKDIR /home/spring
COPY    . .
RUN	["./gradlew","clean","--refresh-dependencies"]
RUN     ["./gradlew","build","-x","test","--info"]

FROM	openjdk:17.0-buster
WORKDIR	/home/spring
EXPOSE	8080
COPY	--from=builder  /home/spring/build/ /home/spring/build
CMD	["java","-jar","./build/libs/spring-petclinic-3.2.0.jar"]
