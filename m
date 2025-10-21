Return-Path: <netdev+bounces-231352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC9ABF7BAB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 745C8506DE7
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74034888A;
	Tue, 21 Oct 2025 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jlm1/M/9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E1348876
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064422; cv=none; b=sFnGBaYKwNMC9b8JLHJBkfFBIGBuQVdhJ0Kyv+EPr7veT9465zU+W5JN05Il4iQ3lWx2/70CrcVpX+S8hcvz8yRdbxugbGwn89bHG3m24Gw0wW5950R13g2xHtST5if4+xroIF7FZLWZFR2dHC1NM+OnM76SWPrHSmMUL8y0Qss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064422; c=relaxed/simple;
	bh=N06AAKkuTH8pzrgJlItLZ7aLwTleb9b/KCDA1r4DSQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kTsAW4daUBkFMNK77pAR9jlHZpHGpawHyf3D1m/GTBkqkktrGbMz/Q0I8bHr+WPtkOgQiNqfGHPZt83HDKEcZpmzFF/n3SDHD6RdJC5RNbTMb+4iFmhDGTShP/CsnfFouJaxy1szbl12b3VDNuH35eLo5FQPknLHSGpzMZm5dTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jlm1/M/9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7871A1A1594;
	Tue, 21 Oct 2025 16:33:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 467C860680;
	Tue, 21 Oct 2025 16:33:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27174102F2405;
	Tue, 21 Oct 2025 18:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761064417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2+gipFkg5zHDFYtzA9qPB7MSffN6uW2hxVVcE15j2wo=;
	b=jlm1/M/9qSo8FAEyrs/GytfhLY4ugSKojISm4eHOcvVACESxleysO5zIA4EMCsRJNE4Gad
	fUJEnBXfirps3A18tHcO6sYYJB/T7BRJeyJ7fNu874j6IqZ37Tylw0XJIiHKa5FluH9hov
	X7EAZpBQ/2PGn5bNnc2mtnCieGqEwQ+7TBgBwj1Mb0qieXgEVEL4+yEIk6L/1DqJc+0xrB
	6AByMl/rOFH8p26X5HfpzVk0LySJXcOWHubW3Nx2aqlQouFFRaxJ6ZvcAv9MNXKJE1RNAq
	tEFQxIKwvtR5Ge4PKVNyPPv0D0V5DGfe35IbkeuLWJvwuEGj6Oqr7Hx/o4z54g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 21 Oct 2025 18:32:52 +0200
Subject: [PATCH net-next 11/12] MIPS: mobileye: eyeq5: add two Cadence GEM
 Ethernet controllers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251021-macb-eyeq5-v1-11-3b0b5a9d2f85@bootlin.com>
References: <20251021-macb-eyeq5-v1-0-3b0b5a9d2f85@bootlin.com>
In-Reply-To: <20251021-macb-eyeq5-v1-0-3b0b5a9d2f85@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add both MACB/GEM instances found in the Mobileye EyeQ5 SoC.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 36a73e8a63a1..923e3f1f15e1 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -77,6 +77,8 @@ aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
+		ethernet0 = &macb0;
+		ethernet1 = &macb1;
 	};
 
 	cpu_intc: interrupt-controller {
@@ -231,6 +233,7 @@ olb: system-controller@e00000 {
 			#clock-cells = <1>;
 			clocks = <&xtal>;
 			clock-names = "ref";
+			#phy-cells = <1>;
 		};
 
 		gic: interrupt-controller@140000 {
@@ -305,6 +308,50 @@ gpio1: gpio@1500000 {
 			#interrupt-cells = <2>;
 			resets = <&olb 0 26>;
 		};
+
+		iocu-bus {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			dma-coherent;
+			dma-ranges = <0x10 0x00000000 0x0 0x0 0x10 0>;
+
+			macb0: ethernet@2a00000 {
+				compatible = "mobileye,eyeq5-gem";
+				reg = <0x0 0x02a00000 0x0 0x4000>;
+				interrupt-parent = <&gic>;
+				/* One interrupt per queue */
+				interrupts = <GIC_SHARED 23 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SHARED 23 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SHARED 23 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SHARED 23 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "pclk", "hclk", "tsu_clk";
+				clocks = <&pclk>, <&pclk>, <&tsu_clk>;
+				nvmem-cells = <&eth0_mac>;
+				nvmem-cell-names = "mac-address";
+				mobileye,olb = <&olb 0x128 0x134>;
+				phys = <&olb 0>;
+			};
+
+			macb1: ethernet@2b00000 {
+				compatible = "mobileye,eyeq5-gem";
+				reg = <0x0 0x02b00000 0x0 0x4000>;
+				/* One interrupt per queue */
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "pclk", "hclk", "tsu_clk";
+				clocks = <&pclk>, <&pclk>, <&tsu_clk>;
+				nvmem-cells = <&eth1_mac>;
+				nvmem-cell-names = "mac-address";
+				mobileye,olb = <&olb 0x12c 0x138>;
+				phys = <&olb 1>;
+			};
+		};
+
 	};
 };
 

-- 
2.51.1


