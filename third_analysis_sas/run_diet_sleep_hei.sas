* *********************************
*
* Program: run_diet_sleep_hei.sas
* 
* Author: Waveley Qiu
*
* Date: 2023-01-17
*
* *********************************;

%let data = C:\Users\14088\Documents\R\RWorkspace\research\diet_sleep\data;
%let pgmfp = C:\Users\14088\Documents\R\RWorkspace\research\diet_sleep\third_analysis_sas;
%include "&pgmfp\hei2015.score.macro.sas";

proc import dbms = xlsx 
			file = "&data\CM + DQ Study Diet and Sleep_Added Diet Variables and HEI_12.14.2022.xlsx" 
			out = dq_cm 
			replace;
	sheet = "Diet-sleep";
run;

data dq_cm;
	set dq_cm;
	vtotalleg = v_total + v_legumes;
	vdrkgrleg = v_drkgr + v_legumes;
	fwholefrt = f_citmlb + f_other;
	pfallprotleg = pf_mps_total + pf_eggs + pf_nutsds + pf_soy + pf_legumes;
	pfseaplantleg = pf_seafd_hi + pf_seafd_low + pf_soy + pf_nutsds + pf_legumes;
	monopoly = mfat + pfat;
run;
 
%HEI2015(indat=dq_cm,
		 kcal=kcal,
		 vtotalleg=vtotalleg,
		 vdrkgrleg=vdrkgrleg,
		 f_total=f_total,
		 fwholefrt=fwholefrt,
		 g_whole=g_whole,
		 d_total=d_total,
  		 pfallprotleg=pfallprotleg,
		 pfseaplantleg=pfseaplantleg,
		 monopoly=monopoly,
		 satfat=sfat,
		 sodium=sodi,
		 g_refined=g_refined,
		 add_sugars=add_sugars,
		 outdat=dq_cm_with_hei);

proc export data = dq_cm_with_hei 
			outfile = "&data\CM + DQ Study Diet and Sleep_Added Diet Variables and HEI_12.14.2022_with_hei.xlsx" 
			dbms = xlsx replace;
			sheet = "Diet-sleep HEI";
run;
