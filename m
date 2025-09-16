Return-Path: <netdev+bounces-223463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD9BB5940D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B18A1B2577D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476222C21F0;
	Tue, 16 Sep 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgOgfa8h"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB122C178E
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019633; cv=none; b=WR9aIUR5DCTcqzBJb1mc/8mKOt2KPsqbIf01NKt61HWaTMcqWHUFXbV7Fx+Zgi032jMib8l0vOkHk6mGuVcg5TiwPMfpqIO2gZXxobumZ7Rujy/i7S5yDGnUJrbOIdav5jSZQN7hRW5S+xKr6dzM/eiBl4cEYg7+kHIQErEOxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019633; c=relaxed/simple;
	bh=N+DvkIEf+jK1FXGRrKsm8BXra7/1jp/K2c4WlAE5nwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=si9UhJ1yP/mxfe/TyYH9TjdQU3dwBxgQtch4/FEmYELMKsQzTgagyECm5pXD+PqrrSdguDZp7Amh3J4fcRElfcQa35Dammj0eMU/V4jDzSlVKkbyU1JH3gTeG8U63bKSziG3opXRGQamsEWFwtwZWfyVKy3a+ilPm1KdZEx/86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hgOgfa8h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GABr2K003666
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LGivlFPRUFzyqdDIJCQVoLwxyXyURMZg/RLnf3kJUBE=; b=hgOgfa8hjMENK6i6
	+QafgoR4nyOE0636XkpjRNTaMiGChjXq2r5Lj530x75yYsb4GBvBRt9opn+mXVgl
	0P/tYugNF0kIC8FwbvNLtf/pAo8xqIYQPQzXSVI/M4qvcpfyFtz7Q9BnIHD2LH4U
	JllG+Y7nBfS3i2P5ZogQWogVanc3KC4TVULqt98tZsUoVCMzI5X7697905rvp+sI
	5GB3GYael5rLHaGVXikk76U+XxpPUUGXEA7e+rPh3G188/s0MtNpoV/pLl4pdmrV
	rERJHFwBhz8coVBuMXTEcqKwkfUuPP7BOd6HP2JNNinqARZwW5Q8ijWMxywMHHxI
	EZIwqA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr8ube-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:47:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54a30515cfso3777840a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 03:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019629; x=1758624429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGivlFPRUFzyqdDIJCQVoLwxyXyURMZg/RLnf3kJUBE=;
        b=MdMMnRsB+wJSYQVLHCYxKldy34iy59KfqKEd8N5Uwyww7OiYyhVrGkNFrTdpXqebnj
         7RCXl9M+lAVg1LmwzHu5m7SfH4pwFlDMgbrpdVUfNUAbMOTrMTShOz5jY8EvZ+2fsrL7
         YlFvNdRY+e7863KzPBB+Vim+e5LvxRZ5DisYtxGACB1PJu2pc+X980+2Q20TTafXzLhH
         ah69zVixmnVw5NrYEbLv1JJer/VDyf2J7cflRXhjqYz7AX0kAe464xZyU+9dRW5ftSJQ
         ILkRdRzdVuJ8VgOOMbAiXdZpymvfP5yGpbaFLzjFINATH6w5Du+mVkGS3GYHx6kQHdpc
         L5lA==
X-Forwarded-Encrypted: i=1; AJvYcCWnimU1A7KJP/APArOj/ZKbqVo5exmqfUOUJ8OILU8aNBNvBZD5GOUQM9FblDkhUpFQ5YtIBI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHMQ86jRcuiuxb4m5s8P9+TMVby0Lh2s+Mz5ebTAjQgqqm9V7
	7dfxSP8B/v6SKrz7J2OU8oaAgviCPlSfvcGwgDo06gwxoYfSAMWZC3zBT7eabHCy9ogxVsVLCV7
	ExVQ8VRB6scgnX1vrbQIp1p4dOIWQUPJcMOu2hsB8KhQMmjhOg393oh3zZoF2E8VIXFo=
X-Gm-Gg: ASbGnctmMa/FiGe1vnKyUSmBHACNSiZ+aaW7RmN1LfBdlLnso8t+1/rO2zMWIpo9fEs
	Byg9IMwI5cvmxXC7BAM3hjbIrwRryDz9t8LK1qvMVuArGeMtiS9MOZ1WGKwRkV09UeHe1E5U/Ez
	MioaaVYJX56y82whZQ75H1wEqSs2x39I9508NouBD9QP3LfIfkNlUMDFcny3Q+DmI0wPU0q0IeP
	mDMSkFAcpzIt1E6DGXpZNgylHVW4/kT5QRwmEreCKNAB8CxV77YUNIV9FktbHqeroi03jWmckbn
	sNCDC7DK9kAbLT2/Ywtw9jJBmczgs8QcO7eLQobfQGkt8AphBmW//UOhcMbcpUEY3Iy+
X-Received: by 2002:a17:902:ecc2:b0:24b:eef:643c with SMTP id d9443c01a7336-267d153ffeamr27893865ad.5.1758019628879;
        Tue, 16 Sep 2025 03:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc1gDxwTceddDDEfUu7SxsejvMIJuXWcd0PuczuENGWeN0/sSdi/yEJGXxHPaKCXyi9qCsmQ==
X-Received: by 2002:a17:902:ecc2:b0:24b:eef:643c with SMTP id d9443c01a7336-267d153ffeamr27893495ad.5.1758019628338;
        Tue, 16 Sep 2025 03:47:08 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:08 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:49 +0530
Subject: [PATCH v5 01/10] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-1-53d7d206669d@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=3497;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=DwrtxD3ZLmemkOPdq7lhEGfiDfoe4W0WX7TMCKQ8d9I=;
 b=H2iaYQ4dPJ3r/1SelRl17eicI7eUH4N4NjuTf+lL2vdsOZ0BRoP5r+L88qMDyhHxkQcbVlwdM
 RPiyW7kEcK0ALM0Mc8+tbTFbJh0ui0ZyZ5j6bU39vJW0A0tHPHDItF1
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: SI6CgSYXlZ3a-9HyQHSVv8cPzA6ipPXl
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c9402e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ALy2IlhOjgNbs65Id4kA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfX+Q+hW8Rc1aEM
 oJX/hTjBKivW4yBoY/Pfs7lYR2AaiR2pcEY00ApTftQu0bYoFHY//t0dkLA2qo+P9RFImcQVk0h
 gxGUlOLaK8QW9jL0z/Zan8Qa+p3rI+valebbLMRILhk1QEi354jcf6pvkuNsOwipaXYi3b4uv70
 oFRl37/8PmrrwJczZFQMAs0SCgLsPimIKwskLIK3j6qjBtXv2RMEP7m7aq5epHp0Nla4NP03/vU
 Dv+DutFOVabHaxxxQZwM3HooRohb1+rjXIfsrgVOm2Ns8LTeC5XGllbRw7ks+Eh8Lda0NcYu8Lw
 6Btx655AKzADY7LlxQavLHmFq1OI9PxU45Z7Nr47L94wA/5f+VBIGiT3cvDJSfSySLmf2RjoWmf
 /Tuyh+CP
X-Proofpoint-GUID: SI6CgSYXlZ3a-9HyQHSVv8cPzA6ipPXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

From: Monish Chunara <quic_mchunara@quicinc.com>

Introduce the SDHC v5 controller node for the Lemans platform.
This controller supports either eMMC or SD-card, but only one
can be active at a time. SD-card is the preferred configuration
on Lemans targets, so describe this controller.

Define the SDC interface pins including clk, cmd, and data lines
to enable proper communication with the SDHC controller.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 92 ++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index fd6eb6fbe29a..b7e727f01cec 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3835,6 +3835,58 @@ apss_tpdm2_out: endpoint {
 			};
 		};
 
+		sdhc: mmc@87c4000 {
+			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x087c4000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq",
+					  "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>;
+			clock-names = "iface",
+				      "core";
+
+			interconnects = <&aggre1_noc MASTER_SDC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_SDC1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
+
+			iommus = <&apps_smmu 0x0 0x0>;
+			dma-coherent;
+
+			operating-points-v2 = <&sdhc_opp_table>;
+			power-domains = <&rpmhpd SA8775P_CX>;
+			resets = <&gcc GCC_SDCC1_BCR>;
+
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+
+			status = "disabled";
+
+			sdhc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1800000 400000>;
+					opp-avg-kBps = <100000 0>;
+				};
+
+				opp-384000000 {
+					opp-hz = /bits/ 64 <384000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <5400000 1600000>;
+					opp-avg-kBps = <390000 0>;
+				};
+			};
+		};
+
 		usb_0_hsphy: phy@88e4000 {
 			compatible = "qcom,sa8775p-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
@@ -5658,6 +5710,46 @@ qup_uart21_rx: qup-uart21-rx-pins {
 					function = "qup3_se0";
 				};
 			};
+
+			sdc_default: sdc-default-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
+			sdc_sleep: sdc-sleep-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+			};
 		};
 
 		sram: sram@146d8000 {

-- 
2.51.0


