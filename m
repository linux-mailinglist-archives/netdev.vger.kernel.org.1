Return-Path: <netdev+bounces-220023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F7B44364
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9D6540891
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF04B33EB0D;
	Thu,  4 Sep 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmGHQiqe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275930BF63
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004032; cv=none; b=N864xzhxdreiTmwe/FlP7btOH3ik/iUgo2kvU/b173WZyyDKiU42XCxGBwhW5CdJyN9sKsWwEvxz5AIDYeb9uDF3hzsVKHhBRe7StKUDBZMIgQ3Toq+9c4Y7qaLmuly1xLQ5YmXJT6Kvb4YxbPVkzyW+EfnLSub5nm/4AXkoy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004032; c=relaxed/simple;
	bh=Zi8P4IJsrN5PCQK4xo00ZPvmwVI9z+jIt40lmIFld5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9UKT+54Hnf1EU5xg2L10w3fIpBTqblEqQoe3AZ7lPcF42oWXmPpZCMK7ZDOHmaDf6aLAm/RW7r+S+jSQ6vjYYwSkOT1dGaJYQTV5BODsnRKUdGMurGgz+UexphHXfl4UjbHhE1aV23ZltY6IJrwECf1U0Pwcx/43KEY1RRa/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nmGHQiqe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X9iB007610
	for <netdev@vger.kernel.org>; Thu, 4 Sep 2025 16:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0MlJyi6xlGQ4JiQQxsUH2044SHYqkJNDG1W6ew662Q=; b=nmGHQiqeJh+8d2I4
	rUfuN7OdmN51/mU2AUJXaA5wRKSY8ZqtGwfYW7k4Mc8xvpnB8IB46mfbB857E8c9
	PXPd0w/tYitw/hGdNS/e6mFWHHGkHCGZmrOrlkMxpBFeElu0ffcD1Dc5ZrltydT9
	jyD3H3sNsH6e57lGnqHlm53VpRvMmD1xfX3xqf92EDYqOeLwbA11TTrB02FEJAFW
	I0oi9PX1SrQuvmiM5ZSy6DVE9ZkdL/aIoDYRvgLckbmbeZCgAioAmBgF9SXEA4ec
	b2ALCUjyhvCOU3wne6vvJaAqJp1/OHQPDqVlmE7FOPAM3989DE8uiumgcSlM0ul2
	o8tUFA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura9043k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 16:40:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7723d779674so1162422b3a.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 09:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004029; x=1757608829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0MlJyi6xlGQ4JiQQxsUH2044SHYqkJNDG1W6ew662Q=;
        b=sQkZGO5mJXE6f+FNylOwmqPdxrdvXqTTJvmCJddjZr/Nw03J38gFKIjGRt/bRCTZLN
         7whC+aNy8dnxpGVCGVf4E5/ecrbM+/QYeBd41o2AtAl5izfYsLkUCTn0eJD7qYPTGjCl
         hmcmM2uP1SAJ3IG1KcsnnhePbxwkTBQUqNtWDMdhd0hvZO2i4TONyfWVIH42/XuGsgvY
         g5bMitaUNYBgAOBcbA5RnKaZRc/1Je7WFlcxdCjEy5is8O02LrinQG5Tos5H4ZR3Tq0g
         onDrsB9medy7b33jvUlZDBvFHIq0QSD3a7Vxi6qTeHmlxkjPkBC14P8atBnYSlsjtimN
         elkg==
X-Forwarded-Encrypted: i=1; AJvYcCUb3BiXcgPn9TFFFt/XqLtPbEl4ZsPLMGS8nHuQPhNKQMld71zW4OflB+a+yHdVKPbdWfxY3DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmZ4pQyiLDazTb+8Fjy+7ss/hcWnZ1KZD0JT0Z7jzJ+YmEtZC
	zIiqfSMrZaYC/GAaL2k7BkDYU3+pTtTeA5tt9FHpwtTD/JL25QeNHYQidPQEFEvDeqwNH7lf1Fr
	bDFJWjHoL/L5XQUnWGNRAKhvJc8NM88oINy2PGlWzLYqyhHeIYVbbX76VmaQ=
X-Gm-Gg: ASbGncvKhKc9hOmbhy1uhGUVAndBQkVTsJ9kRNCF8XptyPraEWCbCSZYQ5l6My24jDz
	W6R65auLpYctdZIdFzYg5KK0M5SpVK+8BibhnK2zpoU210mCgvq4363UmguE2+tGJauQOzJMKny
	K4h2kW6Tl8N7kQUA7p00NHjFSocW7iQEfK1t4pG5qgrpWdPzSWdFK/oXQKKNMX4NPoSvJizS/a8
	JZSbsAIL7W4sT+wqCy3XJqji7J+/PnVHFzU474iKJ13c6dqbMyOfER14pHIo+fmWReppZJPUo8/
	RyyI35oRhndLYRAvANDmJywSr4b6QR60zr6Li8txXUDwJkznyx5VL8uHq+GW4TTHYcD2
X-Received: by 2002:a05:6a20:c916:b0:243:f5ba:aa9c with SMTP id adf61e73a8af0-243f5bae8acmr20306953637.25.1757004028725;
        Thu, 04 Sep 2025 09:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0hqSjTV8JZGJkiN6dTs6Zedyh6YiLXgXgSj90NXrTKN9ydub2uoKmDCtf+fOgPDEeOaq5Vw==
X-Received: by 2002:a05:6a20:c916:b0:243:f5ba:aa9c with SMTP id adf61e73a8af0-243f5bae8acmr20306896637.25.1757004028089;
        Thu, 04 Sep 2025 09:40:28 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:40:27 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:09 +0530
Subject: [PATCH v3 13/14] arm64: dts: qcom: lemans: Add gpr node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-13-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=2037;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=ODJ8lQ3jakhcv7zggi3511Zu7KexUOIuDZjyNJiIUUk=;
 b=nRG6nxDgky9xmJhMRuGpBCnQWH6z2PchN2hWiGAyg9tyGCXJGzJzyqrhHLgHOcwFQdYBB1N/C
 zmuk+DtUnsfARS350Cl2HFKFYWs/15YaQKmRaELoQsOgXSow1uQke53
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: qaJRcMoRQWtXsXkTFbz1sdLNTauYCx4N
X-Proofpoint-GUID: qaJRcMoRQWtXsXkTFbz1sdLNTauYCx4N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXy6sCOnR5Cq/9
 R16e42JR4dlddHBdxXFuoQoFE2XZfa7ru9quAoQcbhMVwioQ6pICFP1WPZo4JyqayCzUA9fz2R4
 NQJJNBj+DpDb6AS8gUXKmmxZ53Iq9YPgyfUgB9Yuu36vqo2PndEXVdM1hDcjcfwdMNMWHDUCy+j
 5K4JkoS714oCiuE15mheT2wJhe5s8M0sEQ0WDICmCxmvkErqlonW+h8zRUeLMAHFUo/EgKcy5NN
 GxX3rm/pJnMK2EbCp9H5D6siqfC05YhfTDU7ILCdR06jr/Lv+lILSNyiGizgU2GkgvDi9IOYQYt
 ltpgmEX2L9+8jK6f1jW2ns5zMj//DRM0YLLwWab6ChQXV9OELWkV7ghb8K/hewMMNDu9Yr+xp+l
 eOY0y0J6
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b9c0fe cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Rye9TsTwPMDKiC_iSCMA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

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
index a34f902c1358..f3a4deee383d 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -6760,6 +6761,45 @@ compute-cb@5 {
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


