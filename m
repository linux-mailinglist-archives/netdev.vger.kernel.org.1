Return-Path: <netdev+bounces-223620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E660FB59B37
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E7B7B26BF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCEC35FC09;
	Tue, 16 Sep 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DN38b5LB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2C35A290
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034825; cv=none; b=mGiqhY1DQqFObENVoNEyGsuSqclukdtz/K9L4VAleOpX3KkKxyTUVcm+1ENnQjir/QdcGWjbc/n4O6PEx5TeuKmHy6Bg8UyYPptKoTl9fD0iWNSMnYRFnBaM/e1m+UzeoQEo7TaQ2vU8pSEGesngjivh6pssAf6sM8d1emvFiLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034825; c=relaxed/simple;
	bh=ikk8NmlgHBIXKKi2HrIINEqMiUPYOyvHsGGRdiTviLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3DDzV7Dx3mBd4rrIGjrN+o0Eh4wBVKhj539Xukt7FNsCkedwZf93es1l5YxRidImF/M4Izyn0KElNBtC/9vro2NVjNgwZMh7mHaiSz0M8Ik9NwTB4xVlWMAldsUnCGUiaogi7dsW16oPFme3IwEsrGczngAD8nojz/dMUc/Qlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DN38b5LB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAGQ7W012287
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j7JNGdMUUlGm7BId+kkego/0ROcY2UfBRQYkHvt5mRI=; b=DN38b5LB59vsrch8
	yW9SRCRjuqsmJMZ4JJccdMU3TIafurLI14NdqCXpeqfx+626iP8oRsfgeyY9BFaM
	LSyxoOO/It8amU6a6xVeKZMKHd7UlTBnF/MekkJ+ZKusyDGYbYdgjeGdHGO5ZZOw
	ocvh+Xg7rb3+2bgtSkSWJ4+/7YUhCRUGCUZexbmqMZsvg2NnG7HlxoeAbC4EfQMB
	RmnJZLWdOY+qYrtaJLeq1yKKEOtFW2M5w8wccqYoqZMQ/jNNg2B+C1ioBFg00bG+
	buf3Pi3Sj8Oqf07WP6DmtjjWTZbjPhf3sAD08PfN21vnJtYHubQlgFlIWruM77j0
	eAtJgQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g12mwua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:00:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b52047b3f1dso7306072a12.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034821; x=1758639621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7JNGdMUUlGm7BId+kkego/0ROcY2UfBRQYkHvt5mRI=;
        b=Op3YWRJDIudzHsuoV8nIbtPFWtfPJV7BGf3I4g4tf1pjIvUEmmo81XDepIVKet8at0
         CjwuMIZ0+TKvsQhgNQ/uM3lRQWxlLNdaYoiDTaAsretkYlop5Zkd5fyR0/e8srsGYVec
         ffH0rjJ1KrX6z4uo+o5uY/s1ja3/HLVUvfM6nLECc8LqKBBfcEw1fSGmzxlm9mMX7h0B
         vif7Xy+cyxWVqC7Ft1LebF/hEgfEH0ZhtBo5DxAvx/Cjb239KReBSjBSbVddybBn1aU/
         wEkKnAdVQ6QzMA6VcaUu2lpWklYnLhPqqI1tuKay6NDs3DYqc1ZL0MAtvEUOSf7tYrfr
         a4+w==
X-Forwarded-Encrypted: i=1; AJvYcCXBLgiFaKwmBIQNLrifydKUkMQ+aTmNxAf0oz73b35weUwkOuO3qFl0p9/WPGthFoNOHnKCtbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBbopvCFeebJs79CbPyaISlYNh+TucFqCuhroM0u2YN6U64uG4
	YFdCF/wDH8YnR9hlkrMRT4i9lFedq0YGzeJPSJAJk6eQU/Z9WkkA7J7DSuP3A80+/ura6PsosQk
	uIO1JN+VJmzL4Ba1NSDLNMx5G1zGr6Yv80jyCo3trSvVD9MtRXmcKp0T6U2Y=
X-Gm-Gg: ASbGnctwUixlFFPb0fPqVwN5yqyZhJi5khG8CfdhPmRfbaBgl7Bwevymx8cO5+vUTtc
	zvb5pKrUdNH2VKtbG3PgkrSfcBTyr3L+Cq6dLTCeb97GdJhDTD4fF1m4qM9TOdtLgLOzt5kN8LU
	oCsZVmtuRtNoGCA+Y+qkteE/DmaYVrAtXBQzPjfGOFJsqR9aWH2IIY71F0i3bVlFhVcDtF+Rx2H
	JJLNf+JbdUIe9ILiDwNY+/UG2crlvqwEo8Vjs/6U2xxr1v/FdkSBMoeMlurYcxHbxMjC7wGr44+
	c1nEEE3BK5ctAzuJV3VM90Py2iDGLoYtHXC38VgnSWJ56f75ByMCsN6lecdA3JAusLfb
X-Received: by 2002:a17:903:240d:b0:267:ba92:4d3a with SMTP id d9443c01a7336-267ba924f53mr55745365ad.6.1758034821110;
        Tue, 16 Sep 2025 08:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGBDIuuLfelQ55BgQOLi2nD2Rf+K0RonFrq6Y7HNrYSLaZsL5oFG0PeXSJdq0iobECYasATg==
X-Received: by 2002:a17:903:240d:b0:267:ba92:4d3a with SMTP id d9443c01a7336-267ba924f53mr55744005ad.6.1758034820166;
        Tue, 16 Sep 2025 08:00:20 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.08.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:00:19 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:30 +0530
Subject: [PATCH v6 08/10] arm64: dts: qcom: lemans-evk: Enable first USB
 controller in device mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-8-62e6a9018df4@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=2240;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=tOp9jkhdAQpAHObbF4iI3LiXECWJrKR9z6goSfT05ew=;
 b=GBvFiMrig98tMfGxvKPpETIVhXCcCiuSkAw30ZBPtONVrXE/Ul3vF771BP2wUiB9+VR3+VZjM
 JZIEiRjSPfzA8tc7Bymh6X/BwzlCc3vtGohXLRLF7ig9N5bq+dHbnf8
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: apPZeGW9aS1Hp6N5vMBWGHoaNRxuaAWO
X-Proofpoint-GUID: apPZeGW9aS1Hp6N5vMBWGHoaNRxuaAWO
X-Authority-Analysis: v=2.4 cv=E5PNpbdl c=1 sm=1 tr=0 ts=68c97b86 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Nk2SLWWF8xhsZ517u1EA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfXzYqGi8oWZlGT
 bycWks2Hb1IBlucchO8w0yapTXVa0OkyRJU78lf3tCHWSIDbSoIMstf1XJVuluIAF73vvj1KJkE
 M2GJKfzwh3anOgz45ENn1eedtCSj03GyKhWoM9dp06KG3HlsKMVNeaOSTO+4eav9MqyXjRAsy2H
 3WEgcqY9lgYcY2GU5Os49o8o9cAmW2UzNOEgUyJSKXfSnOb3FL+xfD+UU6j6WP1vKIuG8BNu9DR
 7OoVpffsKChMSgmZJIjwL2QbJSPmgULnWC/q8NH0PCzad1TIJgOOnXr0Lqln8cY5SeHcwaZK5Xl
 6OVoObeES7eW/kFlI9MiwIvKOS6S7pq5q7CYb20CxpbpIhpf1pOje/kumP5IYmaIhZBWByIZXZt
 ZUO7q/Ep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 5e720074d48f..3a0376f399e0 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -590,6 +590,29 @@ &ufs_mem_phy {
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


