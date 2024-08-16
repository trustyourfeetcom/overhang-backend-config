FROM maven:3.9.8-amazoncorretto-21-al2023 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM amazoncorretto:21.0.4-al2023-headless
COPY --from=build /home/app/target/config-0.0.1-SNAPSHOT.jar /usr/local/lib/config.jar
ENTRYPOINT ["java", "-jar", "/usr/local/lib/config.jar"]