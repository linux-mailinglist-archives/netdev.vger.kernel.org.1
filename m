Return-Path: <netdev+bounces-191132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E79ABA259
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0391BC7EC4
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F85279913;
	Fri, 16 May 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="O7Wmk1H4"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C5272E69;
	Fri, 16 May 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418527; cv=none; b=O+O6T0VVlo4qQsL1LRZBwp00OpuHqI37/d4/b5ECpPfPdDW/wrm3Ka+QQ1rzSTkoCLl3sN0SuzcIszwsBcBdJYB7FiZ9CMAZ09RCVY1l0DdPAzaZetB9nsnixv+oUepqdjef6OW4x8fVYxSgyj9jy5J+Bf1MMLdenFykaFMYo2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418527; c=relaxed/simple;
	bh=ynlCTI58GBOaQCs9YFLcm28DVdN34T3OlrNDt7h9uW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfZ5vhJ++xVKLwjUrk1DzyTZ/IlWUK4oOua6innfHUzehIcZ5g1HYqDPqhIrfpiRQNv9j6iZT2FAXLAB4y4E2HdtyL4yR4MkvUIuvbgCiKajg4Fnx4wCFUHyz6KLiHdhASL3igJ9cPh0XsIRkUuna9tbkreCytWc7xiC90OKvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=O7Wmk1H4; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id 3074F1007A0;
	Fri, 16 May 2025 18:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1747418518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxZ32nniQ48sMzhBF0T/7YO0bN/349dEDPJEtWWeR2Q=;
	b=O7Wmk1H4XZPksOzZUPBAtD0K6QBypwtMKAQiPtQVGEWVts8g+mHl29+Wt7H7lwLLBiYhCC
	oKwj1DTtBqCayXqHsYKy0eXDMINro6WzC9qHe+ha+j66YRzlMnlrasT4jyleH9c9INPRQT
	C0HThhonlDrW8/Zs6UdrDtZBYa/OSwE=
Received: from frank-u24.. (fttx-pool-157.180.226.139.bambit.de [157.180.226.139])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id CB6D41226F2;
	Fri, 16 May 2025 18:01:57 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 08/14] arm64: dts: mediatek: mt7988: add basic ethernet-nodes
Date: Fri, 16 May 2025 20:01:39 +0200
Message-ID: <20250516180147.10416-10-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250516180147.10416-1-linux@fw-web.de>
References: <20250516180147.10416-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add basic ethernet related nodes.

Mac1+2 needs pcs (sgmii+usxgmii) to work correctly which will be linked
later when driver is merged.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 124 +++++++++++++++++++++-
 1 file changed, 121 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 029699e4eb02..aa0947a555aa 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -680,7 +680,28 @@ xphyu3port0: usb-phy@11e13000 {
 			};
 		};
 
-		clock-controller@11f40000 {
+		xfi_tphy0: phy@11f20000 {
+			compatible = "mediatek,mt7988-xfi-tphy";
+			reg = <0 0x11f20000 0 0x10000>;
+			resets = <&watchdog 14>;
+			clocks = <&xfi_pll CLK_XFIPLL_PLL_EN>,
+				 <&topckgen CLK_TOP_XFI_PHY_0_XTAL_SEL>;
+			clock-names = "xfipll", "topxtal";
+			mediatek,usxgmii-performance-errata;
+			#phy-cells = <0>;
+		};
+
+		xfi_tphy1: phy@11f30000 {
+			compatible = "mediatek,mt7988-xfi-tphy";
+			reg = <0 0x11f30000 0 0x10000>;
+			resets = <&watchdog 15>;
+			clocks = <&xfi_pll CLK_XFIPLL_PLL_EN>,
+				 <&topckgen CLK_TOP_XFI_PHY_1_XTAL_SEL>;
+			clock-names = "xfipll", "topxtal";
+			#phy-cells = <0>;
+		};
+
+		xfi_pll: clock-controller@11f40000 {
 			compatible = "mediatek,mt7988-xfi-pll";
 			reg = <0 0x11f40000 0 0x1000>;
 			resets = <&watchdog 16>;
@@ -714,19 +735,116 @@ phy_calibration_p3: calib@97c {
 			};
 		};
 
-		clock-controller@15000000 {
+		ethsys: clock-controller@15000000 {
 			compatible = "mediatek,mt7988-ethsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
 
-		clock-controller@15031000 {
+		ethwarp: clock-controller@15031000 {
 			compatible = "mediatek,mt7988-ethwarp";
 			reg = <0 0x15031000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		eth: ethernet@15100000 {
+			compatible = "mediatek,mt7988-eth";
+			reg = <0 0x15100000 0 0x80000>,
+			      <0 0x15400000 0 0x200000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ethsys CLK_ETHDMA_CRYPT0_EN>,
+				 <&ethsys CLK_ETHDMA_FE_EN>,
+				 <&ethsys CLK_ETHDMA_GP2_EN>,
+				 <&ethsys CLK_ETHDMA_GP1_EN>,
+				 <&ethsys CLK_ETHDMA_GP3_EN>,
+				 <&ethwarp CLK_ETHWARP_WOCPU2_EN>,
+				 <&ethwarp CLK_ETHWARP_WOCPU1_EN>,
+				 <&ethwarp CLK_ETHWARP_WOCPU0_EN>,
+				 <&ethsys CLK_ETHDMA_ESW_EN>,
+				 <&topckgen CLK_TOP_ETH_GMII_SEL>,
+				 <&topckgen CLK_TOP_ETH_REFCK_50M_SEL>,
+				 <&topckgen CLK_TOP_ETH_SYS_200M_SEL>,
+				 <&topckgen CLK_TOP_ETH_SYS_SEL>,
+				 <&topckgen CLK_TOP_ETH_XGMII_SEL>,
+				 <&topckgen CLK_TOP_ETH_MII_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_500M_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_PAO_2X_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_SYNC_250M_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_PPEFB_250M_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_WARP_SEL>,
+				 <&ethsys CLK_ETHDMA_XGP1_EN>,
+				 <&ethsys CLK_ETHDMA_XGP2_EN>,
+				 <&ethsys CLK_ETHDMA_XGP3_EN>;
+			clock-names = "crypto", "fe", "gp2", "gp1",
+				      "gp3",
+				      "ethwarp_wocpu2", "ethwarp_wocpu1",
+				      "ethwarp_wocpu0", "esw", "top_eth_gmii_sel",
+				      "top_eth_refck_50m_sel", "top_eth_sys_200m_sel",
+				      "top_eth_sys_sel", "top_eth_xgmii_sel",
+				      "top_eth_mii_sel", "top_netsys_sel",
+				      "top_netsys_500m_sel", "top_netsys_pao_2x_sel",
+				      "top_netsys_sync_250m_sel",
+				      "top_netsys_ppefb_250m_sel",
+				      "top_netsys_warp_sel","xgp1", "xgp2", "xgp3";
+			assigned-clocks = <&topckgen CLK_TOP_NETSYS_2X_SEL>,
+					  <&topckgen CLK_TOP_NETSYS_GSW_SEL>,
+					  <&topckgen CLK_TOP_USXGMII_SBUS_0_SEL>,
+					  <&topckgen CLK_TOP_USXGMII_SBUS_1_SEL>,
+					  <&topckgen CLK_TOP_SGM_0_SEL>,
+					  <&topckgen CLK_TOP_SGM_1_SEL>;
+			assigned-clock-parents = <&apmixedsys CLK_APMIXED_NET2PLL>,
+						 <&topckgen CLK_TOP_NET1PLL_D4>,
+						 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
+						 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
+						 <&apmixedsys CLK_APMIXED_SGMPLL>,
+						 <&apmixedsys CLK_APMIXED_SGMPLL>;
+			mediatek,ethsys = <&ethsys>;
+			mediatek,infracfg = <&topmisc>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gmac0: mac@0 {
+				compatible = "mediatek,eth-mac";
+				reg = <0>;
+				phy-mode = "internal";
+
+				fixed-link {
+					speed = <10000>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			gmac1: mac@1 {
+				compatible = "mediatek,eth-mac";
+				reg = <1>;
+				status = "disabled";
+			};
+
+			gmac2: mac@2 {
+				compatible = "mediatek,eth-mac";
+				reg = <2>;
+				status = "disabled";
+			};
+
+			mdio_bus: mdio-bus {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* internal 2.5G PHY */
+				int_2p5g_phy: ethernet-phy@f {
+					reg = <15>;
+					compatible = "ethernet-phy-ieee802.3-c45";
+					phy-mode = "internal";
+				};
+			};
+		};
 	};
 
 	thermal-zones {
-- 
2.43.0


