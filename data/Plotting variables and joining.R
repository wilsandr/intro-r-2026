library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)
library(viridis)

clean_df <- readRDS("data/clean_data.rds")
detectors <- read.csv("data/raw/detectors.csv")

#detectors_unique <- detectors |> 
 # distinct(stationid, .keep_all = T) |> 
  #select(detectorid, stationid)

dets <- detectors |> 
  filter(end_date =="") |> 
  select(detectorid)
  

df_stids <- clean_df |> 
  left_join(detectors, by = c("detector_id" = "detectorid"))

station_df <- df_stids |> 
  group_by(
    stationid,
    starttime
  ) |> 
  summarize(
    mean_speed = mean(speed),
    tot_volumne = sum(volume),
    mean_occ = mean(occupancy)
  )

st_speed_occ_fig <- station_df |> 
  filter(stationid < 3140)
  ggplot(aes(x=mean_speed, y = mean_occ)) +
  geom_point(aes(color = factor(stationid))) +
  scale_color_viridis(discrete=T) +
  theme_bw() +
  facet_grid(stationid ~ .,
             scales = "free")

  st_speed_occ_fig


