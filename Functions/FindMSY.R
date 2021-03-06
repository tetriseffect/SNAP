# 
# 
# Life<-read.csv("LifeHistoryRARE.csv")                 # life history characteristics
# SimCTL<-read.csv("GrandSimCtl.csv",header=F)               # simulation controls
# Fleets<-read.csv("Fleets.csv",header=F)                   # fleet characteristics  
# season<-read.csv("seasonNULL.csv",header=F)           # fishing seasons by fleet
# Samp <- read.csv("SamplingParams.csv")            # sampling controls for management
# NoTakeZone<-read.csv("notakezoneNULL.csv",header=F)   # marine protected areas (0=MPA, 1=open access, 2=TURF?) (make sure that there is no MPA for MSY calcs)
# NoTakeZoneNULL<-read.csv("notakezoneNULL.csv",header=F)   # marine protected areas 
# habitat<-read.csv("habitatNULL.csv",header=F)         # habitat quality (recruitment suitability)
# 
# #==set costs to zero
# Fleets[grep('costTrv',Fleets[,ncol(Fleets)]),seq(1,ncol(Fleets)-1)]<-0
# Fleets[grep('costFish',Fleets[,ncol(Fleets)]),seq(1,ncol(Fleets)-1)]<-0
# simTimet <-SimCTL[grep('simTime',SimCTL[,2]),1]       # time steps for projection
# yearMarkt<-SimCTL[grep('yearMark',SimCTL[,2]),1]	  	# number of time steps in a year
# burnt	<-SimCTL[grep('burn',SimCTL[,2]),1]  
# #==find the Capacity that produces MSY
# #==specify max capacity in function argument (10 is the max capacity at msy)
# capacityRange<-seq(1,6,.5) # 3.5 is the MSY capacity for this scenario
# SustainableYield<-rep(0,length(capacityRange))
# 
# for(x in 1:length(capacityRange))
# {
#   Fleets[grep('maxCapac',Fleets[,ncol(Fleets)]),seq(1,ncol(Fleets)-1)]<-capacityRange[x]
#   OpenAccess<-Master(Life,SimCTL,Fleets,season,Samp,NoTakeZoneNULL,NoTakeZone,habitat,Graphs=F,GraphsFish=F,PrintLifeHistory=F)
#   SustainableYield[x]<-sum(apply(OpenAccess$CatchByFisher,2,sum,na.rm=T)[(simTimet-burnt-yearMarkt):(simTimet-burnt)])
#   print(SustainableYield[x])
# }
#   
#   
# #============================================================
# #==find Rzero
# #=run with specific R0 once
# # OpenAccess<-Master(Life,SimCTL,Fleets,season,Samp,NoTakeZoneNULL,NoTakeZoneImp,habitat,Graphs,GraphsFish,PrintLifeHistory)
# # OAtotCatch<-apply(OpenAccess$CatchByFisher,2,sum,na.rm=T)
# # compCatch<-sum(OAtotCatch[502:514])
# # #==set catch in last year
# # EqCatch<-5071
# # highR0<-2*Life[18,1]
# # lowR0<-1
# # RzeroTest<-Life[18,1]
# # RzeroFin<-12700.73
# # for(x in 1:20)
# # {
# # #==change Rzero in "life.csv"
# # if(compCatch<EqCatch)
# #   lowR0<-RzeroTest
# # if(compCatch>=EqCatch)
# #   highR0<-RzeroTest
# # 
# #  Life[18,1]<-(highR0+lowR0)/2
# #  RzeroTest<-Life[18,1]
# #  OpenAccess<-Master(Life,SimCTL,Fleets,season,Samp,NoTakeZoneNULL,NoTakeZoneImp,habitat,Graphs,GraphsFish,PrintLifeHistory)
# #  OAtotCatch<-apply(OpenAccess$CatchByFisher,2,sum,na.rm=T)
# #  compCatch<-sum(OAtotCatch[502:514])
# #  print(compCatch)
# #  print(EqCatch)
# #  print(Life[18,1])
# # }
# # 
# # #===================================================================
# # #==find costs given depletion
# # 
