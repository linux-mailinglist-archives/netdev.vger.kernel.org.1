Return-Path: <netdev+bounces-220742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A435B486B5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223E01B22477
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEDD2FA0ED;
	Mon,  8 Sep 2025 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mjAEl+OR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F082F9C3C
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319663; cv=none; b=Tm1E2Ey+YEao7b7Z1S9xAynWWYligAM2qAbH5M1kHu5RR56PEMyyJpuUg4jsPtpUMGZZFJa7/pTSpWLWKtw2VqYwmnG7ddniyUDBsE+AFgFAqgVal4IBe6kDYYavj0nde55srASRi9k/1qjxSAYGGPoGpmw+2176gJ6QoUQQLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319663; c=relaxed/simple;
	bh=DReB+wH48YHUiIdLLRI8NEeerw2EPpJutPmXdgkgDSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cy+p+LCJcEQX9NoieTyU6Cc6epBfwWhJq7YTroamcofNBXLTal2k/2dAkdK+uvvFCSkozA70NP4b3JP0wifQf2slgvd2v8t6HaQkJaVL5Rh+q9T+5S32vtiYkM5Ug2YuNQW69KeTmbXrYg6i3Vhvvt2Pmwtpmta+JeT/5kpfUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mjAEl+OR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5883lUTm013569
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 08:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u1tyGhzDi96QNYeghxsLZJ5KgCIEwyKJS9JeiBQnTVA=; b=mjAEl+ORbcTqorCA
	SgVdmnkj8ZuZnC9dGdoDdRs6bhocQSysgtPHOjmABvC2TziV5S7s6+UeFRdVHKYK
	f6WDK8SYOc/csDrovQpDiwm6+LIhQcr1Uaq3wCTPudRjifqJ9KcxZVpP87odnlha
	uuHOJDARexhyFS5Ss0m2iFJXSafg6uaR6TeAY6ssCrpa+MmX5VbZIDyl6D8v8KPV
	SZoLwAiwSqp6P7NWGSGdOETgWCB3VkFcfICwwO/022dlNLqxw1448+t18dGlT9B7
	gAxYMrM/fcsznsDeM5hUdMdql++Pd+/gOGrV5MNj9Zc2z0+ncbRk3zBNsTAJo4Cc
	bW7HIg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdrmn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 08:21:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47174bdce2so3273785a12.2
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 01:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319660; x=1757924460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1tyGhzDi96QNYeghxsLZJ5KgCIEwyKJS9JeiBQnTVA=;
        b=KA837wMtwW/6WMIO7A4MJszYv5QTl6fh4mfJp/Ov7BnidbQLeqA5d/PUa+ZvHv8kd9
         xHoiMsWJbc3LIjetEvCpEGTeVbCa9SiLGp4/r0JS00M6sm+xbjJLMhebgb3305lm7WLQ
         v1i4jxISHORMIC6EMztD1ahYVT0NstSeaf8gLzPKDd9alVi8NTVNdz7jFIrzoVkl3knP
         HKyY0LE0PH3GZKreBRGQtonKS7z7TrVbuSy2pLAUlc1uh/AL8hi3BilnpBSt4BGVoUpX
         tUuwCGp0TDnTU3fQtlrWIU1Xk/kL5How+S75Yt59iHDMzEWbrDnQqJ0aQr9B6ZQR04cl
         91Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWcfSXUFcdR34l2I+OP4WtShYywl7lMX8WNNkDc9J6YF38uP9p9UA1PeGqffahe8UnncrUC2bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjYeIqBy5W4HFDl8BfHvWKN+TbN37m8bo2h/SYDe2Haz+8eVDr
	hh5idfJCNQ6uKtm69cz7kt9OSJMBtvIA1A9wYn/5vQ8PGF5qYBYW59MHbAxwxZ+zOAPZ0yacJtf
	qU05BfY2VXn+fSiTJiy8IoFY0nd1jWnMW1hxeRfj8V6cSBEVUDzI1kQhwRqI/5Fl2EU4=
X-Gm-Gg: ASbGncvdu3KDJm2VLwk4s4VfcXAD7JYo+B070NrHB8kU1z97GTXB5bbOCD34Tnt0Np7
	pcwByMBjkHzp2OFlABk67NaZJ23rmVg/A3MdQKsftngLuurT3gn30EwULV6OYQfUpVChZ55/N2z
	HVG9gzmvehq1CZoApsrbviTqdMvleGXGiaus2ONF3Z5fVpEG5eHPAsN8HshOMc/i1x+uUw8KKnI
	lGlozDtw0VDzmCqegHn1DBZhfChcn9P1QaQgQZjuMkRkTqA0dFIL8DYkJ91sy1YSP3y5Ve3EVze
	Hs+wVCu5A33B9Vp1jz2RVTc+B2AWm4dBnR/i548JM4uE8r53MXhTV6X/7YfYStRdH072
X-Received: by 2002:a17:902:e852:b0:24f:8286:9e5d with SMTP id d9443c01a7336-2516e888f00mr114225185ad.26.1757319660227;
        Mon, 08 Sep 2025 01:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOm9oyHz7eArHf7le7cOTQbtPGtuJHkezBgAQ4pxeV9ZrtP5p/AHDFAsCUqrBlCJP/iC7gVQ==
X-Received: by 2002:a17:902:e852:b0:24f:8286:9e5d with SMTP id d9443c01a7336-2516e888f00mr114224905ad.26.1757319659706;
        Mon, 08 Sep 2025 01:20:59 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:59 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:50:00 +0530
Subject: [PATCH v4 10/14] arm64: dts: qcom: lemans-evk: Enable first USB
 controller in device mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-10-5c319c696a7d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=2173;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=z27bhvwE4WO+i5gLrSyuU2f2AH46I3tPsZa6gmg+phI=;
 b=r+be/V+o+GWn6P8M40r3SbCL4X1xTEgUmekg+5QuSjA/ov/k2d1W2GQ6NEfhfIl6xmreh6dB4
 8EqpfDdjqmABjgMphCC/q+/GnUOsifp7fJfv7vLTYuvmQN1p9M1WQO+
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: 5z9IsAMpwHuRUy7SEkqNA_gxnpuk9mHO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX4mJ6Xh/kU2Ma
 EjVy2v6J9+kXfWbOCqtebcjWMYnQlrtq+++6DwK9euf6/bdcUC1J8V8Bak+h+AkdU++/M4ZmzxM
 8C/5L72xHU2bqk7lbzrjcEMW9tmIw+1O7VuaCGlDDoEfTc/K7dY0ww0LGWtKIqDtVrI+93YF8KD
 LgDVMm43+vdheJIqsLy6KPT++TXxpTVUddSkQuoTLQYrELrXfLj6TOTajhhMtAVt5j7+IpCCvF5
 eqvbgwSqIbhyODbU08GOQ79WpF4M0tJvmC4o+A+uZiexMpYwZ0ahMOiuj3uhAbJ9mRs/i6LGNEN
 49VKnUA3k1dElJbHHXb81v8LxDUkBrWZRf2TSJQv452XO0XAG8l246dLuDW0tpmGhr5av7duoHg
 D8KHRpkz
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68be91ed cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Nk2SLWWF8xhsZ517u1EA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 5z9IsAMpwHuRUy7SEkqNA_gxnpuk9mHO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

Enable the first USB controller in device mode on the Lemans EVK
board and configure the associated LDO regulators to power
the PHYs accordingly.

The USB port is a Type-C port controlled by HD3SS3320 port controller.
The role switch notifications would need to be routed to glue driver by
adding an appropriate usb-c-connector node in DT. However in the design,
the vbus supply that is to be provided to connected peripherals when
port is configured as an DFP, is controlled by a GPIO.

There is also one ID line going from Port controller chip to GPIO-50 of
the SoC. As per the datasheet of HD3SS3320:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID
pin low. This is done to enforce Type-C requirement that VBUS must be
at VSafe0V before re-enabling VBUS."

The current HD3SS3220 driver doesn't have this functionality present. So,
putting the first USB controller in device mode for now. Once the vbus
control based on ID pin is implemented in hd3ss3220.c, the
usb-c-connector will be implemented and dr mode would be made OTG.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index d065528404c0..6ec6f9ed1ec9 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -538,6 +538,29 @@ &ufs_mem_phy {
 	status = "okay";
 };
 
+&usb_0 {
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l7a>;
+	vdda18-supply = <&vreg_l6c>;
+	vdda33-supply = <&vreg_l9a>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l7a>;
+
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };

-- 
2.51.0


