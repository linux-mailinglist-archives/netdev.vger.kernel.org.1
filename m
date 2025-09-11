Return-Path: <netdev+bounces-222242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F706B53A8B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009FBAA7508
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4585A3680B4;
	Thu, 11 Sep 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnlmQ4PE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D7368087;
	Thu, 11 Sep 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612437; cv=none; b=bWI0za6mvoClnVwmFQj7BN5GmJTRsbidL9iXlsb4R9dUSP1E1KZ673afsH2+DTjTZWzxrsueLzOBp96L4dR3wZJi6phs+dCGoo3KNAUXjuqOgK8b7GZNoUfJP82e8MDvyZ3Omkes21Q44c2Zumx4cSbYK2wYPA5Cd2KatVsuBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612437; c=relaxed/simple;
	bh=k8chtkdd/C7iCwiNiHHjJu/kaYcxaJejVp0B1FUTyf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jLICspaKQwBsMWxzjdg2K7J2L7gr0B5UUysVoXyH7FyPZwse03qt8Tluono4mEBgoZxq9ERq4GBagCGKugLoCVsyNLcX8QIIQGEozAI7wCvjgFCkQGpRK8PkX/8mRHsTIdoApIj0sEC+aWA0z+lUenXF7e0v9QtiGR/PB08SA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnlmQ4PE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5CDC4CEF0;
	Thu, 11 Sep 2025 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757612436;
	bh=k8chtkdd/C7iCwiNiHHjJu/kaYcxaJejVp0B1FUTyf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnlmQ4PEdrqWJ7MpKjo32ttNPRvTr+yBVPyZzvBrZW2kBxsBs9XVurVNZVNsK/dPo
	 ilOkcmKHe6Ey2cIQsC3nBP3D9+XvUPRgeLUkrKxAPBsEZneqrOXcZF63vWlt5Y/XQB
	 kILrkdwpsFQnM7LGkXcDr4w1f2sPGStKv7MVhixXu8sLYnb00aSheN/cAxSMQha3/p
	 lGxcQUz2aSXc3MpWvqfyJOg84rtpRBV7vWWJjwtxYrXwIx+lNqX5NYOJEQ4r6eGkg/
	 DqRJ3iGWnc+n3S0LJn1DG8AP28HQerJqwZl4MViexm0MOUTFCLERViMxGxDTYViKFW
	 /Aiq3EdAwJImA==
Received: by wens.tw (Postfix, from userid 1000)
	id 2C5FC5FE52; Fri, 12 Sep 2025 01:40:33 +0800 (CST)
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
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH net-next v5 3/6] arm64: dts: allwinner: a523: Add GMAC200 ethernet controller
Date: Fri, 12 Sep 2025 01:40:29 +0800
Message-Id: <20250911174032.3147192-4-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911174032.3147192-1-wens@kernel.org>
References: <20250911174032.3147192-1-wens@kernel.org>
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

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v1:
- Fixed typo in tx-queues-config
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 6b6f2296bdff..449bcafbddcd 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -180,6 +180,16 @@ rgmii0_pins: rgmii0-pins {
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
@@ -601,6 +611,51 @@ mdio0: mdio {
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
+			gmac1_mtl_tx_setup: tx-queues-config {
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


