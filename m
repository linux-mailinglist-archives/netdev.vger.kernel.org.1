Return-Path: <netdev+bounces-217036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E836DB3722C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A337C1B28620
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F79372884;
	Tue, 26 Aug 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDtwhsfl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C2371EBB
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232507; cv=none; b=Ds5kr+IB1FBYhFfvVXltRekFcbyj5jGxJqMVcxwuwccFCgImgVs8N+mZmYf1Jx/MELgDt5BhyPwefiSc0Gzm0JH3xd89xHb5ZuXPfnMlsOR9xCLkMkIS7jQ7wMHWMbqUJFzrpgTppGzXioMRDrrq8uyITilfoTyI7tTkRjJoIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232507; c=relaxed/simple;
	bh=bIBcAYpVmFWgxOVMtIDqpSvu09YY+NiCzJTZkWhGL/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrFhX1hsD2261MZVLDNPHVzKsSogxDTOkSopPKRGs7WdRVLx0s+HYiw4Bu02Tj2vs+4bpFJUeAMueAY3yTBHC3PkBliBeR3FOk7eMbRoNMZNT4z4/1OydNU1KERv1OI2MEPPL2gnCgUV05ZHl0U4WINYaIpIXrYHr11AtvLNqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bDtwhsfl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QC1vKQ005797
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZqG1x0C2Vi/fvgd89OKAZucnUy94PXEwuDfboAV8Cbo=; b=bDtwhsflUNbP/o1x
	AcazB4a+GFs2pD7dD1h643kybLc7UWML5+gP/pqDzrZJkHT/NT39fg7Txeo4Gmrd
	5Y6NCTSYnmiN2/j08mr3GzApkHBH1X2C5RYcSEPka/QWfI+4wOzaBX+irOdKpI7T
	L8hSmKTBmlHaZeVS+fl+iU6mfh+eDj0NORRBziAkCj34ta5fK7AyiHNmuTqHSBpz
	PLuT8u+9aNDOOKZwL9dC/Uq6NYE4h8Yaf0rUoIJ98GM9q6w2lXn8ofOVXRJMpJum
	UGu9QRGpdCAAeIs6I9p+jLlVp9sB8rWFVyTbuAIDxVwsAeJbmBNYCRst4ggNLLNV
	xZCYQw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpevber-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:21:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47174b3427so4209288a12.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232504; x=1756837304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqG1x0C2Vi/fvgd89OKAZucnUy94PXEwuDfboAV8Cbo=;
        b=ruxyvcE/7S3bubbZ0Gox36TuKkYTTxhTkaB5ovCj57SLU3mi8Bfw2X7y/VXB4GD1Uu
         Ho8P29Q0mfz/7wXfUbbL7GPLiwVflFbSkj01ujo5q1jklfIqLac4bW882wMTnVqytb/L
         5wyRxQfubCLt3hWmCHKiUvbXIeaTcei5/Equ66EmarhnhTACAcCkAJm6/ygohxwabQnR
         MCRm94n0N+PzGMdlXr5OlVKH/QRNv5CSTIWpRVuUXfMGsX4FZRQ0QBRxRhsCB4JpjW6R
         JbyXpX7L61RbxC9nexgD6WoSQHA4leAijkqyTI11sz+qovU/aTMmtbQTjleuTw5OJHUg
         hZHg==
X-Forwarded-Encrypted: i=1; AJvYcCU3vMsMc2cY8wa3ChVG11KaooAzRvjWT3WEXw7vhAZtO5kcmGVIBbzs4+Zhm7bd3IYqBwvucDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzioxkUED9K+hokEiSlp/a66NZ0ujj2CsCZSjqJ05qb9zIIdxRq
	fBW1vFXuI/0iXmmivQ6Ley4qSY5F5KLmZk6AguStDcBraTU1p+CPlQ41G+2hqsrlVlZfnHMpfAv
	HzQ2PUQWoTapMGcrvF1BHYqBK4azZmlzYBL9uVnUjE9VpcIOA61mvaaM+vmw=
X-Gm-Gg: ASbGncvwE5bklLaEurXWgas0XtWCwT3I7gd05q2jFefHthoWaPr+cpe+uFqha+dz45A
	2CzeX2TqYFZWPLW/ksFJcR2VvT/P8v5L0JLeNZ9paz5nV2Ny9YONYd/FBFxACyaAiRN2fnkCouJ
	JldPExGTMkxyXDD1DxLaPYcIv4LuFlXtrjFBRRH0viSAPuGxzO6ba116Nc+AAY1l3j7JiVx9Bqn
	+dfR6mqYBfgKw4erjD0mAwkeCxiAKxOBOXWXrF/TCvjKylrQAUrxaIOEj42gzyv5+2v2vNTv793
	FTNKcjPH8KTMnMOz9UASP8wOXOMoKjWurt+tgiWEbamx/2OEOB+xZ3HEBxb6LD035tEc
X-Received: by 2002:a05:6a20:7495:b0:243:78a:826a with SMTP id adf61e73a8af0-24340dca336mr25779260637.48.1756232504000;
        Tue, 26 Aug 2025 11:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi/T/3A+ZcqC2AyUm9So880Y60J/r0weCuRK5mB8bTebqwx94ASLUPJmyFLFQGaQpDcSY+eg==
X-Received: by 2002:a05:6a20:7495:b0:243:78a:826a with SMTP id adf61e73a8af0-24340dca336mr25779228637.48.1756232503505;
        Tue, 26 Aug 2025 11:21:43 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77048989fe6sm9881803b3a.51.2025.08.26.11.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:21:43 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 23:51:03 +0530
Subject: [PATCH 4/5] arm64: dts: qcom: lemans: Add gpr node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-lemans-evk-bu-v1-4-08016e0d3ce5@oss.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
In-Reply-To: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756232476; l=2037;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=40OWUv9iedJbCp6fZ7M8XF7kvnUUAqEsRqjGx3RvYOU=;
 b=y6s8OZMnYzKwwtVKaCt6Eoe6yyzw+1yqHwQFGnEHHe+s9/+8MtfFNQGbYa/ABeAkLkDe5ZYZp
 WUnLen66DySA+GDKrVSluY8ZYNI9Fzmrgkbx8xGWSauNgfqCD6xGISL
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: pQgdaSVp2tt3VPJ0x1wHa7WMEOLqTNgi
X-Proofpoint-ORIG-GUID: pQgdaSVp2tt3VPJ0x1wHa7WMEOLqTNgi
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68adfb39 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=vHYnVJDjh8PKMNTngWAA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX0/wfzG75ecoH
 Q6fflE+BEcIjw4MMP6BBZnJRs/lKAi98C06Sjzcz+r7VrD8BvGq2uX71XMrlqM94nknefrteVZ6
 XI2JGdJGdSQqJItAduvTuUzg9BMIWZHPtV86+i53yhytxeT0SYpZu9vlfJPsYJPGl5EZpzQI1Yf
 sOwkdzTAeO2Ho3upPYT0JwZ86XoKO6hcq1S9zI6RYZ8o12j374w/ZeN1DsHrneHH6P8sjkX7lLn
 GFRTXvahTtJSGfzg73RcbZt3oWqDP4EZtO5LjGPtcEKG9x2gv89wrAIYzn00xrweM3OarCwsy8l
 kzHLY2p7Saq/bBr0UGkLT8E/+AmWkoO0krR/ZX7qBGSMJSKACXSYU8BEJJ8ZLbvH+3VcRjBDl2T
 d+wiDbc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>

Add GPR(Generic Pack router) node along with
APM(Audio Process Manager) and PRM(Proxy resource
Manager) audio services.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index a5a3cdba47f3..28f0976ab526 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -6679,6 +6680,45 @@ compute-cb@5 {
 						dma-coherent;
 					};
 				};
+
+				gpr {
+					compatible = "qcom,gpr";
+					qcom,glink-channels = "adsp_apps";
+					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+					qcom,intents = <512 20>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6apm: service@1 {
+						compatible = "qcom,q6apm";
+						reg = <GPR_APM_MODULE_IID>;
+						#sound-dai-cells = <0>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x3001 0x0>;
+						};
+					};
+
+					q6prm: service@2 {
+						compatible = "qcom,q6prm";
+						reg = <GPR_PRM_MODULE_IID>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6prmcc: clock-controller {
+							compatible = "qcom,q6prm-lpass-clocks";
+							#clock-cells = <2>;
+						};
+					};
+				};
 			};
 		};
 	};

-- 
2.51.0


