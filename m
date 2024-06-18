Return-Path: <netdev+bounces-104454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 727BE90C99E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C15C1C21D05
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA0814F13B;
	Tue, 18 Jun 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="n9F8ocfa"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBA149E00;
	Tue, 18 Jun 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707093; cv=none; b=bplTfTo4s4LcamX2gIS8O1QkEvWoJuCFrJ9m9SYJnsG8Q7UAw1mzVdFkxjEwzrV+pCMxuEJRrThCNDJW0zT6Aj4TbYIqlHEvj9AEIPNWk+jrv1XNueVuD80QuLhobYb/pa4UAhXA3xPjUoZ42iZ4Rh0aDg0zCcOPOClG2a/H4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707093; c=relaxed/simple;
	bh=wZJLQi/Ekdu9JC9Mi7+yEfD3EfnHwXNBsv+LqAhcRQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mF25QCnbLS7UWSo8ddDbE+g3dJXJHeTBoOlN/h1Lz39gva0dTQp3Ql/HMGKJJk9zbt8SJ9F+WrNcJ7ocTfOO2dTBTU7CyyaSY/m2w3lMbVrL933SwOtyICVyakf8MpCykKDdVAvqlP9ajnp+/yUfLdeVLRB+vvhLYdXTGCcd430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=n9F8ocfa; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I6WQV6017671;
	Tue, 18 Jun 2024 11:37:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Qsd+quSmL/fyABfE+A5sHO3NwXbp2Y5VM8+yeBUep0c=; b=n9F8ocfaChShw9Qz
	rxc4iYvvmqhjnvEeYANU9HmbTnKCn4P7YqMOzzBO76seNFDwB75ZZQ95klzQp7zN
	/uCcQzzc7YrbARdcfHUs4EgCuUZwNjF/Fr7kX7u4WXgxHSVkYJd7FMe7ktMSB6e/
	XEuDkiIz0AzkjWQ0RYEAyQ6zsaxDm5CC8V0gGHqQKdLRetECrmvx6NIQUEHYAh1t
	ed01is+2n7+3bMieQOw48AJ8zvjJMRpTZ6qSF6tf+o7JwPStNtMJOZGg+eGsSspk
	/kpnrNaw7t9oNue9MhMUPzN0H9MT9nR4h6U4u7/1gP2c+ynB9N9sD72fUwnt/M84
	WPFtuA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ysnwj8b5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:37:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C150A40046;
	Tue, 18 Jun 2024 11:36:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8EF192138DA;
	Tue, 18 Jun 2024 11:35:37 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 11:35:36 +0200
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
Subject: [PATCH 1/3] arm64: dts: st: add ethernet1 and ethernet2 support on stm32mp25
Date: Tue, 18 Jun 2024 11:35:25 +0200
Message-ID: <20240618093527.318239-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618093527.318239-1-christophe.roullier@foss.st.com>
References: <20240618093527.318239-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

Both instances ethernet based on GMAC SNPS IP on stm32mp25.
GMAC IP version is SNPS 5.3

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 49 +++++++++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp253.dtsi | 51 ++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index dcd0656d67a8..3ab788baefc2 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -338,6 +338,55 @@ sdmmc1: mmc@48220000 {
 				access-controllers = <&rifsc 76>;
 				status = "disabled";
 			};
+
+			ethernet1: ethernet@482c0000 {
+				compatible = "st,stm32mp25-dwmac", "snps,dwmac-5.20";
+				reg = <0x482c0000 0x4000>;
+				reg-names = "stmmaceth";
+				interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "macirq";
+				clock-names = "stmmaceth",
+					      "mac-clk-tx",
+					      "mac-clk-rx",
+					      "ptp_ref",
+					      "ethstp",
+					      "eth-ck";
+				clocks = <&rcc CK_ETH1_MAC>,
+					 <&rcc CK_ETH1_TX>,
+					 <&rcc CK_ETH1_RX>,
+					 <&rcc CK_KER_ETH1PTP>,
+					 <&rcc CK_ETH1_STP>,
+					 <&rcc CK_KER_ETH1>;
+				snps,axi-config = <&stmmac_axi_config_1>;
+				snps,mixed-burst;
+				snps,mtl-rx-config = <&mtl_rx_setup_1>;
+				snps,mtl-tx-config = <&mtl_tx_setup_1>;
+				snps,pbl = <2>;
+				snps,tso;
+				st,syscon = <&syscfg 0x3000>;
+				access-controllers = <&rifsc 60>;
+				status = "disabled";
+
+				mtl_rx_setup_1: rx-queues-config {
+					snps,rx-queues-to-use = <2>;
+					queue0 {};
+					queue1 {};
+				};
+
+				mtl_tx_setup_1: tx-queues-config {
+					snps,tx-queues-to-use = <4>;
+					queue0 {};
+					queue1 {};
+					queue2 {};
+					queue3 {};
+				};
+
+				stmmac_axi_config_1: stmmac-axi-config {
+					snps,blen = <0 0 0 0 16 8 4>;
+					snps,rd_osr_lmt = <0x7>;
+					snps,wr_osr_lmt = <0x7>;
+				};
+			};
 		};
 
 		bsec: efuse@44000000 {
diff --git a/arch/arm64/boot/dts/st/stm32mp253.dtsi b/arch/arm64/boot/dts/st/stm32mp253.dtsi
index 029f88981961..44fed477a55e 100644
--- a/arch/arm64/boot/dts/st/stm32mp253.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp253.dtsi
@@ -28,3 +28,54 @@ timer {
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 };
+
+&rifsc {
+	ethernet2: ethernet@482d0000 {
+		compatible = "st,stm32mp25-dwmac", "snps,dwmac-5.20";
+		reg = <0x482d0000 0x4000>;
+		reg-names = "stmmaceth";
+		interrupts-extended = <&intc GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq";
+		clock-names = "stmmaceth",
+			      "mac-clk-tx",
+			      "mac-clk-rx",
+			      "ptp_ref",
+			      "ethstp",
+			      "eth-ck";
+		clocks = <&rcc CK_ETH2_MAC>,
+			 <&rcc CK_ETH2_TX>,
+			 <&rcc CK_ETH2_RX>,
+			 <&rcc CK_KER_ETH2PTP>,
+			 <&rcc CK_ETH2_STP>,
+			 <&rcc CK_KER_ETH2>;
+		snps,axi-config = <&stmmac_axi_config_2>;
+		snps,mixed-burst;
+		snps,mtl-rx-config = <&mtl_rx_setup_2>;
+		snps,mtl-tx-config = <&mtl_tx_setup_2>;
+		snps,pbl = <2>;
+		snps,tso;
+		st,syscon = <&syscfg 0x3400>;
+		access-controllers = <&rifsc 61>;
+		status = "disabled";
+
+		mtl_rx_setup_2: rx-queues-config {
+			snps,rx-queues-to-use = <2>;
+			queue0 {};
+			queue1 {};
+		};
+
+		mtl_tx_setup_2: tx-queues-config {
+			snps,tx-queues-to-use = <4>;
+			queue0 {};
+			queue1 {};
+			queue2 {};
+			queue3 {};
+		};
+
+		stmmac_axi_config_2: stmmac-axi-config {
+			snps,blen = <0 0 0 0 16 8 4>;
+			snps,rd_osr_lmt = <0x7>;
+			snps,wr_osr_lmt = <0x7>;
+		};
+	};
+};
-- 
2.25.1


