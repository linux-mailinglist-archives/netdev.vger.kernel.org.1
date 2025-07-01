Return-Path: <netdev+bounces-203006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3940DAF0110
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1915016A023
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0132828312E;
	Tue,  1 Jul 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnrhBQMj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF22820A7;
	Tue,  1 Jul 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389090; cv=none; b=UbVtiRuNN6pZZJJNsi0kO0OZ178kL7F1TRtramQ62nYpPEUBsp1RALG+KS2J52oWbIJqcdfEp/iXFblgSX6U7lhdZ6BiDzXr966v7sv8iw2XYEOu0+8Kr7w5rmV+wrRKKQpvAgj0EyZy2RyR2ZiDvbqsO1PQE9KKvGGjSxP22Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389090; c=relaxed/simple;
	bh=BQIohLNyX6fFH5M+mDocAy98v2BgzyzdocJ6lj2XgXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtcAGiiglfp7E3Cb8hFYC5Ike9zrBCTJMxdTnlvF2JfQmyVHz3HWzv5O3Zk4JDZ+r6DAZz4V48hPNr5Xsbb2I956zsBiT6bXR2kt0jsFgc1E14jd5tvwCM+lxtXf+ZRqUbDU5nkb4+tfIvCKDVRsjZR9tbXrN+7nIQ2C4LBmoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnrhBQMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28309C4CEF6;
	Tue,  1 Jul 2025 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751389090;
	bh=BQIohLNyX6fFH5M+mDocAy98v2BgzyzdocJ6lj2XgXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnrhBQMjibtH8o+b43mbPrGzj/EnBoOCbPRS8XHKnGWFnmMogRJ7/vO5rBrcAQHLY
	 3aVB/5d71QOBFmHnGk6dIk6EbM/ImTxzhjeSVZlBa5SJTnGYigRQcTtYSHkutZMz/0
	 2eLSuolosC1YiX9+CixV0fNRVhzLaxea9LhBvo8vyyhWAXs8iaxg/6ZAGZbImAiEpH
	 IYJ1as6z/GB7yCdtO+E4hJbopKq4zzsPg5T2imJ82fVnAtu8JfR3hSNaR0gmmbsDdv
	 Obb01FMwBf6kIMvU7UF0UTw4dBysctgiSuKJYXkEHKA54nXcC96OYgQrP7janHhga+
	 KPxBMfC5YZgOQ==
Received: by wens.tw (Postfix, from userid 1000)
	id EC24E5FFD1; Wed,  2 Jul 2025 00:58:05 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH RFT net-next 05/10] arm64: dts: allwinner: a523: Add GMAC200 ethernet controller
Date: Wed,  2 Jul 2025 00:57:51 +0800
Message-Id: <20250701165756.258356-6-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701165756.258356-1-wens@kernel.org>
References: <20250701165756.258356-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The A523 SoC family has a second ethernet controller, called the
GMAC200. It is not exposed on all the SoCs in the family.

Add a device node for it. All the hardware specific settings are from
the vendor BSP.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 65779754427d..5787ad72a918 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -165,6 +165,16 @@ rgmii0_pins: rgmii0-pins {
 				bias-disable;
 			};
 
+			rgmii1_pins: rgmii1-pins {
+				pins = "PJ0", "PJ1", "PJ2", "PJ3", "PJ4",
+				       "PJ5", "PJ6", "PJ7", "PJ8", "PJ9",
+				       "PJ11", "PJ12", "PJ13", "PJ14", "PJ15";
+				allwinner,pinmux = <5>;
+				function = "gmac1";
+				drive-strength = <40>;
+				bias-disable;
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB9", "PB10";
 				allwinner,pinmux = <2>;
@@ -619,6 +629,51 @@ mdio0: mdio {
 			};
 		};
 
+		gmac1: ethernet@4510000 {
+			compatible = "allwinner,sun55i-a523-gmac200",
+				     "snps,dwmac-4.20a";
+			reg = <0x04510000 0x10000>;
+			clocks = <&ccu CLK_BUS_EMAC1>, <&ccu CLK_MBUS_EMAC1>;
+			clock-names = "stmmaceth", "mbus";
+			resets = <&ccu RST_BUS_EMAC1>;
+			reset-names = "stmmaceth";
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			pinctrl-names = "default";
+			pinctrl-0 = <&rgmii1_pins>;
+			power-domains = <&pck600 PD_VO1>;
+			syscon = <&syscon>;
+			snps,fixed-burst;
+			snps,axi-config = <&gmac1_stmmac_axi_setup>;
+			snps,mtl-rx-config = <&gmac1_mtl_rx_setup>;
+			snps,mtl-tx-config = <&gmac1_mtl_tx_setup>;
+			status = "disabled";
+
+			mdio1: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gmac1_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <1>;
+
+				queue0 {};
+			};
+
+			gmac1_stmmac_axi_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <0xf>;
+				snps,rd_osr_lmt = <0xf>;
+				snps,blen = <256 128 64 32 16 8 4>;
+			};
+
+			gmac1_mtl_tx_setup: tx_queues-config {
+				snps,tx-queues-to-use = <1>;
+
+				queue0 {};
+			};
+		};
+
 		ppu: power-controller@7001400 {
 			compatible = "allwinner,sun55i-a523-ppu";
 			reg = <0x07001400 0x400>;
-- 
2.39.5


