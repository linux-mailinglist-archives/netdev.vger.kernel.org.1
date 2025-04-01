Return-Path: <netdev+bounces-178640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266CA78037
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA87165228
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9222539F;
	Tue,  1 Apr 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cysH85bd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4332144BB;
	Tue,  1 Apr 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524013; cv=none; b=bQkcxIeq0m/sqQhqKcGSW/Q4WnAayGUO0KtAX0lhGspSJsIudansQhO+neWlqK+ui4FHlJ225VFpuhvFhdauhGFwwgY9oWQy7DRFEff540WZS/iSKnWdETfQOF0a9UfDExjyaGECmK78XSlCdHkxKpAZ/7Dhh1PBLsL9zZ51nDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524013; c=relaxed/simple;
	bh=uEeZwiSPHqYCiFQKT5gkoUooUwDLffj670ZBidf1WNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhflQbdjJrgEVMGtvFEF0bfj560CkSlq0B5HfI5VkczO6a9ycM26MonOrixDex3QAJGEF8p6lXt7875fzcpTIByTPEUhfGMZakFCYvazQE2bN4r5a5ZyObX6/IVBdp9Z8/c5gyg1FyoMC9Klwb4XHOqPF9skn7ObrK8wCzB5ASo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cysH85bd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743524011; x=1775060011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uEeZwiSPHqYCiFQKT5gkoUooUwDLffj670ZBidf1WNI=;
  b=cysH85bdkJmDI8rBJCv2TLRD0nQ2PJP6nrZWpbRGAd9Jeb95M95jxtrz
   pvTwL5jyPKD19ImjxwytCMmuQdubSgcvGBdZsqGrrDwNT+AXNDFlqh6TI
   xOglUcNy2X0Jm1OqmddCUeKazrxETU4/CFQDQsEoZgTEthNXCTcJcQRxj
   436brTvgCAkBE/N7yg2iaasXPqQeAn8iLYv+ahF/QeFcAK+LdZf47rrk7
   vN6LyWACyPSdWefGMka7DWCfZPTvSnEBrV0Fggs2utLRPvFvht58qFcQn
   dBbqaELdoQhrwnBudfTvM9UsoxukDg787yEqqNmlm1AxUcnKiCOGwez51
   Q==;
X-CSE-ConnectionGUID: ggLzNIpETriZ0zPViMY9HA==
X-CSE-MsgGUID: l3iN2sqWSqODM1jetjmnqA==
X-IronPort-AV: E=Sophos;i="6.14,293,1736838000"; 
   d="scan'208";a="39512778"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 09:13:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 09:13:01 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 1 Apr 2025 09:13:01 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <onor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <nicolas.ferre@microchip.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH 3/6] ARM: dts: microchip: sama7d65: Add FLEXCOMs to sama7d65 SoC
Date: Tue, 1 Apr 2025 09:13:19 -0700
Message-ID: <d474fcd850978261ac889950ac1c3a36bc6d3926.1743523114.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743523114.git.Ryan.Wanner@microchip.com>
References: <cover.1743523114.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add FLEXCOMs to the SAMA7D65 SoC device tree.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 267 ++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index cd17b838e179..9f453c686dc6 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -217,6 +217,199 @@ pit64b1: timer@e1804000 {
 			clock-names = "pclk", "gclk";
 		};
 
+		flx0: flexcom@e1820000 {
+			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe1820000 0x200>;
+			ranges = <0x0 0xe1820000 0x800>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 34>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			uart0: serial@200 {
+				compatible = "microchip,sama7d65-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 34>;
+				clock-names = "usart";
+				dmas = <&dma1 AT91_XDMAC_DT_PERID(6)>,
+					<&dma1 AT91_XDMAC_DT_PERID(5)>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			i2c0: i2c@600 {
+				compatible = "microchip,sama7d65-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 34>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(6)>,
+					<&dma0 AT91_XDMAC_DT_PERID(5)>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+		};
+
+		flx1: flexcom@e1824000 {
+			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe1824000 0x200>;
+			ranges = <0x0 0xe1824000 0x800>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 35>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			spi1: spi@400 {
+				compatible = "microchip,sama7d65-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>;
+				clock-names = "spi_clk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(8)>,
+					<&dma0 AT91_XDMAC_DT_PERID(7)>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			i2c1: i2c@600 {
+				compatible = "microchip,sama7d65-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(8)>,
+					<&dma0 AT91_XDMAC_DT_PERID(7)>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+		};
+
+		flx2: flexcom@e1828000 {
+			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe1828000 0x200>;
+			ranges = <0x0 0xe1828000 0x800>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 36>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			uart2: serial@200 {
+				compatible = "microchip,sama7d65-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>;
+				clock-names = "usart";
+				dmas = <&dma1 AT91_XDMAC_DT_PERID(10)>,
+					<&dma1 AT91_XDMAC_DT_PERID(9)>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+		};
+
+		flx3: flexcom@e182c000 {
+			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe182c000 0x200>;
+			ranges = <0x0 0xe182c000 0x800>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 37>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			i2c3: i2c@600 {
+				compatible = "microchip,sama7d65-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 37>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				atmel,fifo-size = <32>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(12)>,
+						<&dma0 AT91_XDMAC_DT_PERID(11)>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+		};
+
+		flx4: flexcom@e2018000 {
+			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe2018000 0x200>;
+			ranges = <0x0 0xe2018000 0x800>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			uart4: serial@200 {
+				compatible = "microchip,sama7d65-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
+				clock-names = "usart";
+				dmas = <&dma1 AT91_XDMAC_DT_PERID(14)>,
+					<&dma1 AT91_XDMAC_DT_PERID(13)>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi4: spi@400 {
+				compatible = "microchip,sama7d65-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
+				clock-names = "spi_clk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(14)>,
+					<&dma0 AT91_XDMAC_DT_PERID(13)>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+		};
+
+		flx5: flexcom@e201c000 {
+			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe201c000 0x200>;
+			ranges = <0x0 0xe201c000 0x800>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 39>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			i2c5: i2c@600 {
+				compatible = "microchip,sama7d65-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 39>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(16)>,
+						<&dma0 AT91_XDMAC_DT_PERID(15)>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+		};
+
 		flx6: flexcom@e2020000 {
 			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
 			reg = <0xe2020000 0x200>;
@@ -238,6 +431,80 @@ uart6: serial@200 {
 			};
 		};
 
+		flx7: flexcom@e2024000 {
+			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe2024000 0x200>;
+			ranges = <0x0 0xe2024000 0x800>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 41>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			uart7: serial@200 {
+				compatible = "microchip,sama7d65-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 41>;
+				clock-names = "usart";
+				dmas = <&dma1 AT91_XDMAC_DT_PERID(20)>,
+					<&dma1 AT91_XDMAC_DT_PERID(19)>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+		};
+
+		flx8: flexcom@e281c000{
+			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe281c000 0x200>;
+			ranges = <0x0 0xe281c000 0x800>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 42>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			i2c8: i2c@600 {
+				compatible = "microchip,sama7d65-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 42>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(22)>,
+					<&dma0 AT91_XDMAC_DT_PERID(21)>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+		};
+
+		flx9: flexcom@e2820000 {
+			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe2820000 0x200>;
+			ranges = <0x0 0xe281c000 0x800>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 43>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			i2c9: i2c@600 {
+				compatible = "microchip,sama7d65-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 43>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(24)>,
+					<&dma0 AT91_XDMAC_DT_PERID(23)>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+		};
+
 		flx10: flexcom@e2824000 {
 			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
 			reg = <0xe2824000 0x200>;
-- 
2.43.0


