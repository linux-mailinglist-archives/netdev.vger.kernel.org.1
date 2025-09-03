Return-Path: <netdev+bounces-219548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DF4B41D83
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1028E3AB328
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF40301476;
	Wed,  3 Sep 2025 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hp2IQGwL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858482FCBEF
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900109; cv=none; b=hQ3saEswtG5/qwHBR5IdQOi2tFvxPgGdD5IuKJ60tsKaz/jYJxxO214aQB7dlrbIEK1t+W/2992gj7BSt/adcRPkrmzxzxdv62ZZRy7PForZbthsVQkXzqJClQ04Mh+JUODP1/KXZ+BVGdrZvvAVSeqTc4xsg06xFJN3bwr+1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900109; c=relaxed/simple;
	bh=m+G7WaVV+dY3lW9Dk4b2VE8MCypkHqSwnNPSHfI/dII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pKV55UmBapZS1W3/5djYV/YPwgLhEmIGOm8y3SwqoAvH+dQ0UzK50KL3jFL5b6YOz4v4AyiMiGXr9u7jQWMrrve7BDgPzxptF1GyS57MUcTwTwgRzQ5nwnkNOVBB7yP9VWFyIhypqLr52fSzxX3+ayMKJZfvtsi/+5vTxjOYJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hp2IQGwL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEnam013895
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 11:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UUGwhya31RGtdG2DzbcIhmEj5fZbAbIzttYD4HrT2pU=; b=Hp2IQGwLApVgwTHF
	MGEhEQ+Lyr8hOsFi/d35BhUbthEXW5ogjZL8ooGXFZoGvdfmNebxepNDymD50l6p
	l2POosajxfVWUJcWoxeSDXBISDyYi8QA9fweGJjDMOf8kpTvG0Ph38nuwvdgm1+B
	lvoX3qMJnn00uJ2r14jLdq9y08i/oYA0l8V4o9hWfYwDS/NxkwIUohyAx2EbdkWl
	nT60OiIqH9IIxDRl9fG1GsfRoGQNa6ttZuuMuO9rUWdWooEZhF6q+SiFvPI3QNR1
	jqUatJkHaiaExaho6rXJv1PsjUHFPcTCMh7A3QIuNe5X0m1k5DB5uNL0PuJcGrJS
	YDC0Hg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy7cur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:48:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471757d82fso5057764a12.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 04:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900105; x=1757504905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUGwhya31RGtdG2DzbcIhmEj5fZbAbIzttYD4HrT2pU=;
        b=KjrDSkDswSY3rBMYmI/1iT6ce1nD/+mTqRhUkCsWd6e55ZNK3+cQeXMki9ZxVKrFYo
         G+sHZ1+o7lQ56Qvk2dmaqkEJHoWwrm5TLCjcYwLByaxpMJFu+NnSxkxIgg1LcWfGv99A
         z/6B6X18Bzbrj0EuN7BrjyHId3a7PntUEUtNU13VOBlZPCGa0+KrFWRTKX5I0j6JFx7d
         FSAO8F6pY7mRSi54OaCZRMANoyMTQVV4MiccHfh+PbKgQoOdEmWFCuUwYFzYCpRwEGEg
         moAFgKLbJghk14g0eK2L4WkcPh3H6za2uPmBsm9Zp/vJIVmww1NVq/l1Da+X/Xmvxf/s
         kM8w==
X-Forwarded-Encrypted: i=1; AJvYcCU28XzFLPasHJVjTro8lbIIYcvQaJ8yRMxoVTR8TeniD100I34Zf8JRN486SY+FExo/c6SPagg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLuTY0x8k8+azSug7b4qX9lSC/xoU0nWm2oi90SLRB4WOq2AuF
	xJecXWjYJMrdjcUmM2HnhIWh1u7uQEz0hPR81m8jnwfQHvzoEPWDT46TIG7NqfcUp25wWaRQRlI
	ID/FX1+4CiL4lhs5kqMeeq2pMo74Ey2ljE/SwM3HvI7n2THbhvcYfbw3YUvI=
X-Gm-Gg: ASbGncveJW3lbJ/8luar1UwDD0/s8GCGE12RTfYYjgImH7AoHrBLOpv/4lChKrKyFof
	83N8mt/WWstk4YgISUKJVwwDf+T/NlE6ErWIECEVXl8Y6u1ckS+YutBbWMK3rYwg60r6jeeJfZt
	3vUWdg7z9DI/VdadYPMpe/MOdyUopSmlvVzJrXp7qt7lZQAXIsRxlbeh2+31+CqsGOmJwDTo0Ar
	CrDfEAHdxHRlws48hrosr4CLYjZ2cndozNpIaVB59N0lPfCP1x9uJ9Vs/g2uB4be7bqJBUH0bAn
	cHHcUbCWFL37CKSr+ieVqOK6Iex+656Q96uJPb9TrNUkXns4KQyHZf5X07x4ZeMbESJT
X-Received: by 2002:a05:6a20:938c:b0:249:d3d:a508 with SMTP id adf61e73a8af0-2490d3e1f8emr1667756637.57.1756900104830;
        Wed, 03 Sep 2025 04:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4CP5U0kCEXOt87Veo0Z/5ICRgJpFabkxzrDfdm8tCdwkui2sXUyJsLashUmjV2p9AyEBN2Q==
X-Received: by 2002:a05:6a20:938c:b0:249:d3d:a508 with SMTP id adf61e73a8af0-2490d3e1f8emr1667721637.57.1756900104386;
        Wed, 03 Sep 2025 04:48:24 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:23 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:12 +0530
Subject: [PATCH v2 11/13] arm64: dts: qcom: lemans-evk: Enable 2.5G
 Ethernet interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-11-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=3602;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=VOarTdI50lYApWYLkJ4J4eWIcRQbRhab5lvIdQs8LXU=;
 b=LrS2k3DGZPvq2hLNlyBNiXBlHDruApu7zJraIj+yAbISt72zxhCS1u6ysOTl6y6Hms3c7xmRD
 ECHDoCEER4oCSSq7UIvTETeh9+V3nnf10IiPEAJi+r68KJ8F9feJ7HL
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b82b0a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=z9nD9lg9_nmlpaFE3BIA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: dDN7-SPAjVs38rdnfA44C2utSMgb1-d3
X-Proofpoint-ORIG-GUID: dDN7-SPAjVs38rdnfA44C2utSMgb1-d3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX7Vxg05/V/eT/
 aao+0cCv5ceRRG7lgGILH4TXV6ZifpWICv8avXFMw3t+TmYZaLtB6v3tCvsbY2I/1pxpg/ZODFA
 ZBAFC53ZRCfWVl60Eo/qJskQlgTHQVoM8PxwAGfJoGcbAuNd5k3tkOwmQC5onagbiJx8p6KUCcc
 HYOST9DwtBkgH4SCl/Wv2WMApmRCTeJaAg1KT0UN9qvmdR18sKqU+JekGEQ1zzbpG28RBM0MjZP
 Zgb++TwtqUc/gQ3zfAxNuylshXZfYofaP9pOOqiu5bs5Ju1np8w5YQe5RZHcVn9Kh3i9WWWJ/Nq
 DAUv1e8aDcrALZDX3d1vR8eKctmVE2ENd43euixRZ0YU0hCaGQ4QBntEYttuCY7HBh2eR/Av7qV
 ORza0VEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

From: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>

Enable the QCA8081 2.5G Ethernet PHY on port 0. Add MDC and MDIO pin
functions for ethernet0, and enable the internal SGMII/SerDes PHY node.
Additionally, support fetching the MAC address from EEPROM via an nvmem
cell.

Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c9e7977466b3..69ce6a60361a 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -16,6 +16,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		ethernet0 = &ethernet0;
 		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
@@ -300,6 +301,94 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&ethernet0 {
+	phy-handle = <&hsgmii_phy0>;
+	phy-mode = "2500base-x";
+
+	pinctrl-0 = <&ethernet0_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+
+	nvmem-cells = <&mac_addr0>;
+	nvmem-cell-names = "mac-address";
+
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hsgmii_phy0: ethernet-phy@1c {
+			compatible = "ethernet-phy-id004d.d101";
+			reg = <0x1c>;
+			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
 &gpi_dma0 {
 	status = "okay";
 };
@@ -352,6 +441,10 @@ nvmem-layout {
 			compatible = "fixed-layout";
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			mac_addr0: mac-addr@0 {
+				reg = <0x0 0x6>;
+			};
 		};
 	};
 };
@@ -498,11 +591,33 @@ &sdhc {
 	status = "okay";
 };
 
+&serdes0 {
+	phy-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };
 
 &tlmm {
+	ethernet0_default: ethernet0-default-state {
+		ethernet0_mdc: ethernet0-mdc-pins {
+			pins = "gpio8";
+			function = "emac0_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet0_mdio: ethernet0-mdio-pins {
+			pins = "gpio9";
+			function = "emac0_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+
 	pcie0_default_state: pcie0-default-state {
 		clkreq-pins {
 			pins = "gpio1";

-- 
2.51.0


