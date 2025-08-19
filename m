Return-Path: <netdev+bounces-214882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A84B2B9A6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5945E3AE5
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871B28488C;
	Tue, 19 Aug 2025 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZVEiNzhE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269DD2690C0
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585424; cv=none; b=Co1rQa8PmB5JB8BbHLSpjdoiKgQD2EggGqF7NlfnEl2VYPe+3QJssrbOV+FFF0gJt/kWrJOOloUB9h/qw1BoeYcpFEvZvywPEnYQ95waKz7KGpqQRXwN/HuGdJia4jsx/Du+m5N5zbb7+2TZ1uHpGKdpUUe0j+F5xy/kIaCoIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585424; c=relaxed/simple;
	bh=u+tZpwkQzuSc8msEuFt3VhKgUqTRRkSt/nts4l2YdIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trV/k3Uon6QiqzuO7S5z0+WmQKc6OmGxFWUV3WHAjyWvmG12m4ACQtzuWCm0Pd7KBAbiEOIPUbCrpKHogIvsGAuHsi/DSruFM166Z7Kn+SXIMkIoOyS6KFeh6gs4rdrtDsJisFaQnE+1Vhr6Wm42cQvoDv6Jjtx6ww/uAGvrerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZVEiNzhE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J2OFHM016840
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ae35zkKIC0CJ5nbsXi7yf5SwcQqgHmGyPNS8+VvWx1s=; b=ZVEiNzhE+Tl4Rj0R
	WulZY0o88RbENvsUmd0z/k3HgdH2FwIr7UOWqe4HWznqHxKNw3veSNzHTlo/6KM3
	Z8aH3SMpTRqAr60UMrisijuT5gL7edu97lM1rq9ubQ/LY+yeWp4E/2CI9dScNIjA
	dZqQ5Ayx/Hob80EpiF/kF0fI1T+JRqACqtYH70xH6NgKgQeScquJy9RpNjOscb/N
	eYoulDAagOm67pDis7TBMpcuDTND1IkySdHNx7AUFGOhkPjisi3M86oL4bmbJken
	HPVPmzX+BBiflXxhz1DZcGZI2t423A3J9YTJt/1mSmYfr65OuoCe8WpWRvPSN+Fk
	mR803Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjyffss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:37:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445827ab71so44003115ad.3
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 23:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585421; x=1756190221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae35zkKIC0CJ5nbsXi7yf5SwcQqgHmGyPNS8+VvWx1s=;
        b=I6BmmulPL6G69iKGPtHDf2iueJSd9dQLYz67B3EdRAdGqQ4au58AaC7p0eBcnMDYM8
         B8wvWa3N0WoXhDZwxmku8UiEn2eWGqflFpFpZh/pD7O/arl8admbkvj8CERABJUghVRd
         GCko+qKzXCW79yAmXZK1m2N/QGHN1J0u25mehg68Plvg/pWAcOK2jtkoxd+JO55O7ioP
         QdCrtH+3LlBGwqpdgSOcmdyt8Bxx56GRXUennnjCeF/Oz3eN//TVTnOYw42AExB3zBRj
         dOk6TlNiW8w1QSxM9RyNL+mJbSdl21+zJ2TQpw6vXHwTGV4JlPqu3v3zIPSQX374wdX3
         oQOw==
X-Gm-Message-State: AOJu0Yw2+0jKHWvsGITHJJOx5ajPzZv4Ix7vMJIxDvMY6ZN6TDSVhny1
	0ss2GO++sbnuKsm81dAmL/AStVc13UMnKJT7596k5hETtPXXWujQivMKf5+3jqJy7yEdds/ZHuE
	4Ewsm/0C/SNJLGXv2n0PxCz+MispRiV5FbWDF8GF3+CmdA7FQoTgO6LTQKak=
X-Gm-Gg: ASbGnct28brFBDhlaV+ojKQSCJAJe4XbYpQHblzWWzd4crP/i3QyFyohTKOKVAhRask
	7jSpFhCLNJbk9Nw6mf6HjWWvlsH6repix52G5S2n4RgH7brwemOiF3h942jS94V/2YBAAQ7vMpC
	2X2R4SjrqKvdJsq3A5HN9cxYzYzMDqmTEU0jRZ1mufE4UzQ3rwQJe3RuKXbg1gMxn1X/TMxzn0E
	O6J3E5JeZi+u/E9gyhc2CFjx/iJ0xBgziHB+7IwmLDYI5Jb7sxTb56tQ6ED7WmFGpgvmYdzQdUz
	ItdhwbNxszhpfJq0JYJmfjuJrV8/N63izwScnOMznahYC793c63b60vGmTlh7SRUJuWSJ0lkhVA
	g4PcC72sh/s6NQda0aISkwKvOMPDzYElYdw==
X-Received: by 2002:a17:902:db03:b0:23d:dd04:28e2 with SMTP id d9443c01a7336-245e0488c4fmr19904845ad.35.1755585420872;
        Mon, 18 Aug 2025 23:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHplGjIOsxjG9ywwt+oNjQuHnKblFHJP7DfxgAQ8xey2qyG+dk48tjcBRJvmxvcv4HDGKrHbg==
X-Received: by 2002:a17:902:db03:b0:23d:dd04:28e2 with SMTP id d9443c01a7336-245e0488c4fmr19904435ad.35.1755585420372;
        Mon, 18 Aug 2025 23:37:00 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe38sm98120455ad.135.2025.08.18.23.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:37:00 -0700 (PDT)
From: YijieYang <yijie.yang@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:35:59 +0800
Subject: [PATCH v4 4/6] arm64: dts: qcom: qcs615-ride: Enable ethernet node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs615_eth-v4-4-5050ed3402cb@oss.qualcomm.com>
References: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
In-Reply-To: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org,
        Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Yijie Yang <quic_yijiyang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755585388; l=2876;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=SBNbTe9YfI7ypi1j4e391PPYp7WypDnpFergOj/Dd7Q=;
 b=Y2i2zXFfa34tuFIzyhBVHW5D/Xyb8q0LcUejJetwkYc/LdcqZOdTvNtFXsejUdHPb7YxeCmqT
 1jqm9QwQyuoBnMs4I9qAjEVJHAoEMTcRllDLyPQmrgFZ1i3MufhCX7L
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-ORIG-GUID: xt3qEPSHvY7zuJNB6L_pT1NeAynmwsrv
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a41b8e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=FOSVMqNBLdhn2M3QeyoA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: xt3qEPSHvY7zuJNB6L_pT1NeAynmwsrv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfX07kXaJ2v+wrK
 YYBWDWjItOUdSgk/AG/Mvu52ppkSISicGd0iXEjzJApUVuVFiPonguJfXSf3EEWf8otc/bJFKNP
 GoNcs+kyCqKuAp6tMl/9onRttM0a5LFlDdGfBF+gDfhQ/Hj+vQgKJTParFAb0j0nucg3hCLt93f
 4XvHWRmk/TBK4mrtPqNgd+eIyyKgo6ByH5v5c0KSUDEfgrQwzET7X1R+GpQFPWY16U8jC+bbgfL
 006+mBQKUm405WuWh7LSQZpqRg9YRztSqclW1hD23Pc/R1kQlqawCwNX32N3kjowVnRXICMRqFf
 htvuMXHbphxx+vrN7002oUEHzAqHdBR3UttXmkyYgKPKVre7Zm1mkjz7mCwMxwZ8Tgj/5hNRDG0
 q+2+5jYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028

From: Yijie Yang <quic_yijiyang@quicinc.com>

Enable the ethernet node, add the phy node and pinctrl for ethernet.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 104 +++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 59582d3dc4c4..05d8609c0483 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -288,6 +288,59 @@ vreg_l17a: ldo17 {
 	};
 };
 
+&ethernet {
+	pinctrl-0 = <&ethernet_defaults>;
+	pinctrl-names = "default";
+
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii-id";
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+
+	status = "okay";
+
+	mdio: mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rgmii_phy: phy@7 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0x7>;
+
+			interrupts-extended = <&tlmm 121 IRQ_TYPE_EDGE_FALLING>;
+			device_type = "ethernet-phy";
+			reset-gpios = <&tlmm 104 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <1>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <1>;
+		snps,tx-sched-wrr;
+
+		queue0 {
+			snps,weight = <0x10>;
+			snps,dcb-algorithm;
+			snps,priority = <0x0>;
+		};
+	};
+};
+
 &gcc {
 	clocks = <&rpmhcc RPMH_CXO_CLK>,
 		 <&rpmhcc RPMH_CXO_CLK_A>,
@@ -446,6 +499,57 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&tlmm {
+	ethernet_defaults: ethernet-defaults-state {
+		mdc-pins {
+			pins = "gpio113";
+			function = "rgmii";
+			bias-pull-up;
+		};
+
+		mdio-pins {
+			pins = "gpio114";
+			function = "rgmii";
+			bias-pull-up;
+		};
+
+		rgmii-rx-pins {
+			pins = "gpio81", "gpio82", "gpio83", "gpio102", "gpio103", "gpio112";
+			function = "rgmii";
+			bias-disable;
+			drive-strength = <2>;
+		};
+
+		rgmii-tx-pins {
+			pins = "gpio92", "gpio93", "gpio94", "gpio95", "gpio96", "gpio97";
+			function = "rgmii";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+
+		phy-intr-pins {
+			pins = "gpio121";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <8>;
+		};
+
+		pps-pins {
+			pins = "gpio91";
+			function = "rgmii";
+			bias-disable;
+			drive-strength = <8>;
+		};
+
+		phy-reset-pins {
+			pins = "gpio104";
+			function = "gpio";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };

-- 
2.34.1


