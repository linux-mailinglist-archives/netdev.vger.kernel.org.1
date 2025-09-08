Return-Path: <netdev+bounces-220743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E73B486BC
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5593618898C0
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379372FB0BB;
	Mon,  8 Sep 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XZbStJ3e"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A242FB0A4
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319669; cv=none; b=tBQE+vLLudPYX0sw/xnDthjqag/b9cAs2OFiNAlo0A0p+FgUf0raKnS59zzYGyTaHNNSmAaaSn7/a18KSjFULvu1HUJJkdn+SdrMc/8crbC7wZTLvtLSaagz+ZNPYuhHkIaa+KR4R+9qupsPHUcxPE1DFZW6iToAdsE9FP+Itjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319669; c=relaxed/simple;
	bh=uT1RQTZ8HcdDiPZOvVJtf44HkHxuTXRz/oiN9/qCASg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PyB2BxdXZKYRDVw3D+DGiLl82a+B19kVo5kDpbFKm/Z1owX8pItDVAnPQeVlDEtOydTsycGXEK0itWXt8vlm/M62y0hpAWwpBAl+bKe3WGWNjS6U39BXzbS4a57HaIQvONlEbRRqtJTA8wafbff0Z0GcGeiKJyMYrNzKwTq+ETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XZbStJ3e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5886ed4d004031
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 08:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MzF3Foo3tIflXdtMvnJY/IPP1JEHUdPK3n0iEo31wt0=; b=XZbStJ3eSGPBUDMN
	88HUUu+ve2w24Yc3pl4aXO9fi0zOwwhGT7XZ9Rsf5e4CKGn+kkfullrWpPc4bPQl
	IsIme+7CQL5ZVbQVChzJMixULRaF5KzTJaj+k7JQlKolToadcQQsE8eSPt6SMYNE
	WcrxXfdGs9ErxnufjVLVPYNZ1QDpjzKL2hqV1qWUM9D2wB4PKNDqvIKnO3KP70zD
	/HNnEcZi86UiP7OcxK+nMPV6XAk8OvBKIbEhioxKl3vj4XxR8/8APj7j+bQnYJ9F
	tdk43cCDQZPqnDSnq0IKDGYkeoEJIwuHXi+t6GGjurk/h5z+GyakOyFo/PHcAe3Y
	21H3BA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37r95k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 08:21:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24c99f6521dso52270525ad.3
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 01:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319666; x=1757924466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzF3Foo3tIflXdtMvnJY/IPP1JEHUdPK3n0iEo31wt0=;
        b=CuYvcUuRN80ghJcq2JmLBnZBBKUyGNihW6ZqP+DZJrA0JqXn1ABdlBLPnraAtkv59T
         WJwK1aJq3QdOgGCaJ+fOiCtxS+RhNr5bjGoH4oD0hBLfC14FtJPByMrH95vdRdq93BN/
         zO3soObNbeRZ8Qb3EFEoKOwtl+gwoIBGBaT1fCjMpFM04zpfXjnjLRizJpMOfoPMm0YJ
         njzsFvwvvt8XiaJ2gKKZcPeZsXOmuCcjgPsFCORhoCNALQeA1mJwoOlBeDy4EO4ZzQrl
         i5c48XjBXeQHVQLwR3A18+O1QevA7r7EXxd99c/vDyb5XCeScXgmaphCNyDnAlqHYbov
         QjEg==
X-Forwarded-Encrypted: i=1; AJvYcCVFEzs3WKKh9KWnqbYADhzEJ7FfsO/t7NvWvwfweRz9g05JIMG3nDJpMPcMZr9jr1te2w6fG08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUbI5uuOxG/fUPASVt03YzUj75xMKRgys6Kt0SkB6FLva+p5fr
	OpXd7ZcWwTGtaOMAnU4iDPGKh6UY35aeiUHfYkqQCyuX+l7Y04fIBXr/7gBI+Bc/WkJEVVQi6UK
	wERQmO25jV5mkUM9xi1CcE8MZIU4DWvblVzeZpa1JIiOK3a0Itvoobi//QDk=
X-Gm-Gg: ASbGncueTwubHvL8qTGU3L7RaxbpditT9EMrbhBdaCUZoM6nO46sEBJY1jJdSwXOGNs
	KXf03ecvXYhKrRBbK2mAZ2WGq8ToHNDuDDhr3rRFICY+tJpjKZnn1QJd/ZFDexSm2cvHum//oe0
	EaCypdmshC4L7Q1/ltgErMEvVUiw24EqnIAHN91wAt0sGheoSB2Sx6YEXWvxKRvdAHfXbIZAXaO
	9etPlflUYQ5RtpqfL5iy+YkTyRJTijuarNdd+Ov5GVPgJR2kWAs2f5zTiWIgF66ban9yLj/q/pl
	3vL8+dy0xoHtza9eT/atpC60bT62IcgTLpirXMopW3itTY44imEab3MBEPfNCPtoaKS7
X-Received: by 2002:a17:902:e788:b0:249:1f6b:3268 with SMTP id d9443c01a7336-2516f520906mr101902055ad.18.1757319665515;
        Mon, 08 Sep 2025 01:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtEcObXeeS6q2IcvPfNPJBnf2iAPFVQ1ZO9r/1M/JfZ2eGQGxjoJQj/+y2pFDgvex94Mgosg==
X-Received: by 2002:a17:902:e788:b0:249:1f6b:3268 with SMTP id d9443c01a7336-2516f520906mr101901715ad.18.1757319664998;
        Mon, 08 Sep 2025 01:21:04 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:21:04 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:50:01 +0530
Subject: [PATCH v4 11/14] arm64: dts: qcom: lemans-evk: Enable SDHCI for SD
 Card
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-11-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=2103;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=MDJChDydQoup+AQ4stXZYHqRNLvdQ06UIqjeVzxFUuc=;
 b=wR7ahREHx0KuEoAte6tk5BSWjlaOXiHNgFfN4HxxkzQLWC8yORbt6Mhc908CDcr+wTYG0tDBY
 Tyb+ex5UVqTCq4C2nujd/yIBpqTGi0oLGZIpiaBFQtZBevShEWwLxaU
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: xWC-E4FkrWkPO5bhbRas1ENgLEPFrPqN
X-Proofpoint-GUID: xWC-E4FkrWkPO5bhbRas1ENgLEPFrPqN
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68be91f2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=yrLL4yFEfc0NwOpttVsA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX+NVtjWBeHZ4K
 aEaXDVhwXvHEETVvnCDkwiOEnk9JIZca7Kg7d1Cf5SBY3+OAg9v93NeZG5+B2wiYYU4jxgqRpdD
 wd552UR7eQQDNrTlYCTQBsZhvYakFzXJpBgVPWqUke0azISGnN6keB2qPKqlYqGipURhGGjUAMd
 w7H3huDMW1sBV4UmBwhZo+wq4sXjrozDUcVoI7tlg22hxmULXXhuBFc+5k4IBhgfLYx7b0JccU2
 EpGa20KWq3LNocqOBPHqAlnuUTmkE+l9VYYlIe4SQCpirdRTEfdQTr+arTbLlcm5mgpcyuNix0P
 MwSyTA+UOj/yjUzwRZgX6vFmtdJaGq9s4YCdC1NOJZpBLhGFm0pdgFx5vC0p1fe7k6plUdSCp4W
 2zqLg5hK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

From: Monish Chunara <quic_mchunara@quicinc.com>

Enable the SD Host Controller Interface (SDHCI) on the lemans EVK board
to support SD card for storage. Also add the corresponding regulators.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 6ec6f9ed1ec9..60e365a13da3 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -16,6 +16,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
 
@@ -46,6 +47,28 @@ edp1_connector_in: endpoint {
 			};
 		};
 	};
+
+	vmmc_sdc: regulator-vmmc-sdc {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vmmc_sdc";
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
+	};
+
+	vreg_sdc: regulator-vreg-sdc {
+		compatible = "regulator-gpio";
+
+		regulator-name = "vreg_sdc";
+		regulator-type = "voltage";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
+
+		gpios = <&expander1 7 GPIO_ACTIVE_HIGH>;
+		states = <1800000 1>, <2950000 0>;
+
+		startup-delay-us = <100>;
+	};
 };
 
 &apps_rsc {
@@ -461,6 +484,22 @@ &remoteproc_gpdsp1 {
 	status = "okay";
 };
 
+&sdhc {
+	vmmc-supply = <&vmmc_sdc>;
+	vqmmc-supply = <&vreg_sdc>;
+
+	pinctrl-0 = <&sdc_default>, <&sd_cd>;
+	pinctrl-1 = <&sdc_sleep>, <&sd_cd>;
+	pinctrl-names = "default", "sleep";
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 36 GPIO_ACTIVE_LOW>;
+	no-mmc;
+	no-sdio;
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };
@@ -511,6 +550,12 @@ wake-pins {
 			bias-pull-up;
 		};
 	};
+
+	sd_cd: sd-cd-state {
+		pins = "gpio36";
+		function = "gpio";
+		bias-pull-up;
+	};
 };
 
 &uart10 {

-- 
2.51.0


