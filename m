Return-Path: <netdev+bounces-100620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D578FB5B2
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55994285DB6
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093AC143C59;
	Tue,  4 Jun 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Nf90USpf"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75AB13CFA4;
	Tue,  4 Jun 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511893; cv=none; b=c6UNdst3K+NMq9wXQG51/+mgLqGKtxCBg7d5AkAHI82mamuny8v5L9XmqeQ2iA3K3y7NFl8qPXcN/uSCyT4ft4Ur6KAO9AHFo8efBuCy89XsZBpU6vM8iUxPDAIKWP+hmF8haBaVOYllkK5OY8TM2YzjuUYlr4gw9JMQfaUxl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511893; c=relaxed/simple;
	bh=bA31eNkiZsQYtijBGHnyjL2iv0scepZlMsjmr8nLVBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGhdv2BsQz77aG7TLAuk8YaXstTpPkJeIXu8JeguxIF/H5q5K3ZRXksNM119zsMtvdhW1Y3fcQSav16kltQM78HtLJ0t5ob6ZNPBsabhNCy+YHSXULrszwGwYUdqfSuZfuCdugGe64svJGmSDFFSm/lK7TJv8OfKYO+ID/Nm6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Nf90USpf; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454Ce4as017323;
	Tue, 4 Jun 2024 16:37:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	P4qHMxrfQ6ZMR1lABeCl5ZvenbQTxJiHOHaq1F5dGQ4=; b=Nf90USpfD04PUi6h
	Lqy80HbxBhQc8YP4xXZrqTfCWJkI0BDKJR6Q+pSDrq/tV9F4RiEAocFe9cdzGkwp
	hTME4VeAw1nRimRnG4RlinG/gYvARxunqJmzY+kVUFwD2fiU3GtjHR2mdwpp5ijt
	1SmXDLp2mD3b7sgUs1pQijtkvqcKLSJY6RoKA2L/A4RDyemhAWkXOCYs/r6YzPvd
	O/FxjwTc5adex+sPR/YDdOst0TiCjbETr57AiyhBnIgWP8fO7NDnxachvD0R4EAP
	dkffuDBWYObvyg2Zj9EKfch5phwbxX7D/T/46wqL+6reGHOy+tqSqyEuA7mdSkct
	iZio9A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw91crnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:37:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 65F7940045;
	Tue,  4 Jun 2024 16:37:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 290B02194F4;
	Tue,  4 Jun 2024 16:36:31 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 16:36:30 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/11] ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
Date: Tue, 4 Jun 2024 16:34:59 +0200
Message-ID: <20240604143502.154463-9-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240604143502.154463-1-christophe.roullier@foss.st.com>
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01

Both instances ethernet based on GMAC SNPS IP on stm32mp13.
GMAC IP version is SNPS 4.20.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 38 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp133.dtsi | 31 +++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index 6704ceef284d3..9d05853ececf7 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -979,6 +979,12 @@ ts_cal1: calib@5c {
 			ts_cal2: calib@5e {
 				reg = <0x5e 0x2>;
 			};
+			ethernet_mac1_address: mac1@e4 {
+				reg = <0xe4 0x6>;
+			};
+			ethernet_mac2_address: mac2@ea {
+				reg = <0xea 0x6>;
+			};
 		};
 
 		etzpc: bus@5c007000 {
@@ -1505,6 +1511,38 @@ sdmmc2: mmc@58007000 {
 				status = "disabled";
 			};
 
+			ethernet1: ethernet@5800a000 {
+				compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
+				reg = <0x5800a000 0x2000>;
+				reg-names = "stmmaceth";
+				interrupts-extended = <&intc GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+						      <&exti 68 1>;
+				interrupt-names = "macirq", "eth_wake_irq";
+				clock-names = "stmmaceth",
+					      "mac-clk-tx",
+					      "mac-clk-rx",
+					      "ethstp",
+					      "eth-ck";
+				clocks = <&rcc ETH1MAC>,
+					 <&rcc ETH1TX>,
+					 <&rcc ETH1RX>,
+					 <&rcc ETH1STP>,
+					 <&rcc ETH1CK_K>;
+				st,syscon = <&syscfg 0x4 0xff0000>;
+				snps,mixed-burst;
+				snps,pbl = <2>;
+				snps,axi-config = <&stmmac_axi_config_1>;
+				snps,tso;
+				access-controllers = <&etzpc 48>;
+				status = "disabled";
+
+				stmmac_axi_config_1: stmmac-axi-config {
+					snps,wr_osr_lmt = <0x7>;
+					snps,rd_osr_lmt = <0x7>;
+					snps,blen = <0 0 0 0 16 8 4>;
+				};
+			};
+
 			usbphyc: usbphyc@5a006000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/st/stm32mp133.dtsi b/arch/arm/boot/dts/st/stm32mp133.dtsi
index 3e394c8e58b92..09c7da1a2eda8 100644
--- a/arch/arm/boot/dts/st/stm32mp133.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp133.dtsi
@@ -67,5 +67,36 @@ channel@18 {
 				label = "vrefint";
 			};
 		};
+
+		ethernet2: ethernet@5800e000 {
+			compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
+			reg = <0x5800e000 0x2000>;
+			reg-names = "stmmaceth";
+			interrupts-extended = <&intc GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clock-names = "stmmaceth",
+				      "mac-clk-tx",
+				      "mac-clk-rx",
+				      "ethstp",
+				      "eth-ck";
+			clocks = <&rcc ETH2MAC>,
+				 <&rcc ETH2TX>,
+				 <&rcc ETH2RX>,
+				 <&rcc ETH2STP>,
+				 <&rcc ETH2CK_K>;
+			st,syscon = <&syscfg 0x4 0xff000000>;
+			snps,mixed-burst;
+			snps,pbl = <2>;
+			snps,axi-config = <&stmmac_axi_config_2>;
+			snps,tso;
+			access-controllers = <&etzpc 49>;
+			status = "disabled";
+
+			stmmac_axi_config_2: stmmac-axi-config {
+				snps,wr_osr_lmt = <0x7>;
+				snps,rd_osr_lmt = <0x7>;
+				snps,blen = <0 0 0 0 16 8 4>;
+			};
+		};
 	};
 };
-- 
2.25.1


