Return-Path: <netdev+bounces-219543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A10B41D6F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A3C54627D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E0E2FF14A;
	Wed,  3 Sep 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxCJeCLU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D22FE595
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900087; cv=none; b=VvjdUZjvnH7kp/HmZ9UuUm77SOf+higU9Osq3RaC6hqW0kQBcurCN/ItpABg9X8PDPaV4R7w0FBiDwgk17qKr069K272JFSeirLLg3OA84J/7k1HHZbcC/Mw+qX0Bz7SB47qFJU24UUHJt+4rNwj1a6QBpIFkTiTZVb8wbI2dJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900087; c=relaxed/simple;
	bh=U4bFtZO0E9TeGNoTH9Kmx02xb2M+/AGciIvKZhwUtdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZUytgjfGCfzavdocDTERABzrUJpkwI2qZZhwsKjK1BXr5igU/RWcEpW3gjUc0U0j4pYqFxEoiDq+WxMFY5EetAIMwwNvt+QcbRHS3B1vh+8QT5f3jOaVwmkUVaiUlJzSRMidROejBJ5/ILUxU+k3KzcCuTApUBueQlQsOOstQko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxCJeCLU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF3MB004538
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 11:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l5sTpxPlVJZPGNjAHXGJXVpCmBn2OyKsJ9VZWcA4w3Y=; b=GxCJeCLUryk+Ez/M
	+FaAtmESC25n4QKWAL3o0Beq1H82ecSZY79sKj1p0lEO7WP8e8qDvoqp1QmeqSLj
	s8rsfi2LK6rOtWP7Xxyc5Nc5iPb0fZhLyn19UONASu5z5gcyhw37txYw7hf5bBun
	9Rm9xHTgP9BMcEhIYHrJPhXLM1kY9uwkiGVWxgiTCMFnIb0LVrJnLCEVeR6pfUJy
	iX57aOnjb7TIWqpd+rRtf8t/+wfkrN0zGG/zbcj/5vOer9Oup0ODbeUlsHLxwnam
	zDnMN7WyudayOV5cNJ5/NMp+zxjHs2Wkj/fM86HHIeJMhh+9YLIwW1eOD1NnPK9C
	SorNlg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpbntf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:48:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so822840b3a.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 04:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900083; x=1757504883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5sTpxPlVJZPGNjAHXGJXVpCmBn2OyKsJ9VZWcA4w3Y=;
        b=SQLC0FRoC9lfMBqafA37hSwQF+XO2Rdj4rkkYIGD9WdD5iPbzO5k2hkq577Rdr0ntD
         zJnnciI3cl4n1KgeWBCy4dY970PQCt6HXAzqj5b0Jc2cTJCsF3Yk1j3goA3IoGSqQDNf
         zKKAxAx8HSnyT1sVTwnQ5F2utSAuqAfnyRVRS7uPI2/k0fFOxH+TW+qDqE33qFq9FKrN
         T5v/4yYgTj1dddCBa13LN/0SWMxi+MPIMnfty7j4UZtmujP6ULrM+nRh/wWFRYn/UhYo
         yJwsU+xjYltzIe1DJgIMxgev+NamoEqrR+sGn9o14E6uo2DolWsZOmDGIgtH9asO0bQ1
         5NBw==
X-Forwarded-Encrypted: i=1; AJvYcCXuJoNUWiRF2aCbbG9wEddAy5psHU4AnYiiMXjqoi+RYxLNtRHqbPDXh6ry+h5oqU/s+TfyqO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4gTkbr8uh5eZDktuqt2cLM2DBrdgDhBx7e2yS6qTndgGJKzL
	HOx5p0dTa9mB6xRdTcMVD9Ibfizn7qgHKdzkON+ifRbIXjCG8cQifFTQGPvv5pVSyFSuX3HSxRO
	3SyNGy5LIqcRMxhjJREZE/kj9WwcIozLUP1xN5SItmOMpt9Bc22ydV1ApSd0=
X-Gm-Gg: ASbGncs0OpXx0UHeWdrMRzTenVLRHexE6aVQPXKAg/FddTyGlmPv60sBRE+6VHLvcRJ
	wmSTxtKTQcXHaoYV/KBmTrxcfLUwR9xAyDkwhuUilvD414F62ywTPY09J9t9WoIH3gUUaRPkMzK
	w1fWargtWoMqRGaaCvfKEakg/BWAUMiRFsRwwFAurOYVqQLXnKc1/8e/qqX06ibp29OXhHjy30e
	gM0ZmV3nS1F3A5VZisA4Qs8oome4fChNwclKus+5dBMxu71qXx9Nkzw7TL/mtTM7ch002uHddT5
	IrqvPVrgpJupuImSSo+FaYHZqQ2bntPkIiNxzUzRTD+kPyZwVerM2WtAg59iOmioHWAe
X-Received: by 2002:a05:6a20:3d05:b0:245:fdeb:d264 with SMTP id adf61e73a8af0-245fdebd5c5mr6770441637.12.1756900083369;
        Wed, 03 Sep 2025 04:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT5R/fwIha9CqTYkCtjjav55lL8IiszB8UTmLgYdfAKYo+Y5s7OAw4iY9nbcK2D1m3WK8x7A==
X-Received: by 2002:a05:6a20:3d05:b0:245:fdeb:d264 with SMTP id adf61e73a8af0-245fdebd5c5mr6770405637.12.1756900082871;
        Wed, 03 Sep 2025 04:48:02 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:02 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:07 +0530
Subject: [PATCH v2 06/13] arm64: dts: qcom: lemans-evk: Enable PCIe support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-6-bfa381bf8ba2@oss.qualcomm.com>
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
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=2445;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=78aSxSIhSUzc3QmRgVmlUMy8mC77lvAghgjYiBLJezw=;
 b=GTZ2OxSdn8fy671mmP5pAi50chKwgNE2tGq9zqFIKw7Fwtalq57McSVOpo1nsRpM0NLmw6nhn
 eEFxy3T560TBz/k2kl02P5OjwdE975Afe9BjY5bOoqgnxv4F8+2ypaN
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: y10kHY2VLO1eh1ULCODnfrAXE9lDMB0g
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b82af4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=iLH7TPAinAFjDZn0xZgA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: y10kHY2VLO1eh1ULCODnfrAXE9lDMB0g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXxeJTIwKb+iJW
 zPquHidxlLsEz8jaCkO9V5/FxEOfdw5pHv7AaDyyBn4dtK6QQ3F8M55WgHSaNjk6VdZkRSos41S
 7V3DSRJt5oCLq84ZPS0i/LRFKZ6ote0drL0eDJc84vsJPIQal1WKF2ra5nRgVr7J8tjUbqIGVND
 t8NrCqX3+EuQ9ZiuMr/nMOTZx3HBxO+lnsIyO+MaBuKipx9ib1J7Y5tTQ9KlN703Xa//9TxaLlZ
 AIUMmybjStttV+aYn3lMsKeT6dLSmRm1XR2ODAkphijgRC3jUCXpM8i5hqaCX64m6AAcia8SxDI
 lpHDZ5DtfEvVQ+ZPMo4Bn2Dk4Ij9Rn1eIaiiGXh6mA3xYDdDxSmIlR6GJ4O4S+IwXsYPiGtPSgh
 8jmAbR09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>

Enable PCIe0 and PCIe1 along with the respective phy-nodes.

PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
attaches while PCIe1 routes to a standard PCIe x4 expansion slot.

Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 196c5ee0dd34..7528fa1c661a 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -379,6 +379,40 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
+&pcie0 {
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_state>;
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&pcie1 {
+	perst-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default_state>;
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -395,6 +429,54 @@ &sleep_clk {
 	clock-frequency = <32768>;
 };
 
+&tlmm {
+	pcie0_default_state: pcie0-default-state {
+		clkreq-pins {
+			pins = "gpio1";
+			function = "pcie0_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio2";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-pins {
+			pins = "gpio0";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie1_default_state: pcie1-default-state {
+		clkreq-pins {
+			pins = "gpio3";
+			function = "pcie1_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio4";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-pins {
+			pins = "gpio5";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
+
 &uart10 {
 	compatible = "qcom,geni-debug-uart";
 	pinctrl-0 = <&qup_uart10_default>;

-- 
2.51.0


