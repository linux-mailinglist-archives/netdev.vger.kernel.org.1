Return-Path: <netdev+bounces-101765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 639FF900019
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F7D1C21CA2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AA215D5B2;
	Fri,  7 Jun 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WJ7M78dp"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D3115749A;
	Fri,  7 Jun 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754459; cv=none; b=k0c3z+v5//iTh8JdUMevEsE+LGGxwunqtxfn3v4JYxoCUTBuoWzVqaiMFGFKrQMlBh5ta6NSCA2Pj4a8PWmtg06LFsQ5iixfRHnA9d6u0baoSclY3OVmOb9QVxcdOo7tbotW1sKUgCyVZ958utJtIZoW7LwUwTMNuv5ilJb1QLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754459; c=relaxed/simple;
	bh=LxdLgGqPLf3s+kJUNXVv8BMrS7yHp/8IVNCuj2Iw0i4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePDcY86tBiWU6Cq9f3rPL5hYBo9eJj4UesuJ6Qbb8e/Iks7JXM3Id72iUdBvGHCKozEydvPGLqq2YUthdp4cWV4znzZG5c4uPF371QDu2yC1fRm5JddQUpni+Pv/j4b/OB/cv7oYeHZagYxBeXibaOBa4wMr1oVNK3Mm0XTLPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WJ7M78dp; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45791dBJ002305;
	Fri, 7 Jun 2024 12:00:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	I5eX1MiABAjtTHnD8DpDo4CymvKlEhXxzp8S24yq7DA=; b=WJ7M78dp/FboYY7x
	k+ktG3Zxr1+h2Rb89+cuENHIKhWeCbpsz/3fmHL2LdyyZ8dcocNOygIYhc7iB7CF
	730ysypsoRx1TnDv1VCSGqS4/bWVJqeR8NI/atQjU2jayD2GIT6cdvZ+KLwetRnq
	9No1oAyDbKKvQ8e5PBt19VVh0iLSQsyas2TGTUDPvEXQOBBSFuSGjxP80wXuASfk
	znGaKzmI8Tb0i6guNCDcMXipdsau1mcnJcv6EbdJlSAY+RLAQOH8DvIjSSYjFBVh
	rQ10wN9sERMXn30Bexrvgkm8V9iuu3T/ATZMhjxPmCdp2Jgdh6aDM+Fkr5ZNSKj8
	pzTe1Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ygekj86cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 12:00:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F0E5140045;
	Fri,  7 Jun 2024 12:00:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 24D76214D14;
	Fri,  7 Jun 2024 11:59:18 +0200 (CEST)
Received: from localhost (10.252.19.205) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 11:59:17 +0200
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
Subject: [PATCH v5 09/12] ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
Date: Fri, 7 Jun 2024 11:57:51 +0200
Message-ID: <20240607095754.265105-10-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607095754.265105-1-christophe.roullier@foss.st.com>
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-07_04,2024-06-06_02,2024-05-17_01

Both instances ethernet based on GMAC SNPS IP on stm32mp13.
GMAC IP version is SNPS 4.20.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 38 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp133.dtsi | 31 +++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index 6704ceef284d3..e1a764d269d27 100644
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
+					snps,blen = <0 0 0 0 16 8 4>;
+					snps,rd_osr_lmt = <0x7>;
+					snps,wr_osr_lmt = <0x7>;
+				};
+			};
+
 			usbphyc: usbphyc@5a006000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/st/stm32mp133.dtsi b/arch/arm/boot/dts/st/stm32mp133.dtsi
index 3e394c8e58b92..73e470019ce42 100644
--- a/arch/arm/boot/dts/st/stm32mp133.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp133.dtsi
@@ -68,4 +68,35 @@ channel@18 {
 			};
 		};
 	};
+
+	ethernet2: ethernet@5800e000 {
+		compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
+		reg = <0x5800e000 0x2000>;
+		reg-names = "stmmaceth";
+		interrupts-extended = <&intc GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq";
+		clock-names = "stmmaceth",
+			      "mac-clk-tx",
+			      "mac-clk-rx",
+			      "ethstp",
+			      "eth-ck";
+		clocks = <&rcc ETH2MAC>,
+			 <&rcc ETH2TX>,
+			 <&rcc ETH2RX>,
+			 <&rcc ETH2STP>,
+			 <&rcc ETH2CK_K>;
+		st,syscon = <&syscfg 0x4 0xff000000>;
+		snps,mixed-burst;
+		snps,pbl = <2>;
+		snps,axi-config = <&stmmac_axi_config_2>;
+		snps,tso;
+		access-controllers = <&etzpc 49>;
+		status = "disabled";
+
+		stmmac_axi_config_2: stmmac-axi-config {
+			snps,blen = <0 0 0 0 16 8 4>;
+			snps,rd_osr_lmt = <0x7>;
+			snps,wr_osr_lmt = <0x7>;
+		};
+	};
 };
-- 
2.25.1


