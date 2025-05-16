Return-Path: <netdev+bounces-191128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CBAABA24B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E36D3B6C7D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94383277020;
	Fri, 16 May 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Lkt49FfP"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1C264A65;
	Fri, 16 May 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418526; cv=none; b=W76HPQk+WpE4iGxlkaJtQBEAL4W0FWgGkEkAvKDwLl/1T2iVaOawevl1SBG4cCJDMXMmA5cPqa+X0OYKIfrBJv0ZVztrJ9+y36A+69dwIyl0eSaIFI4sJO3hdOw1gm5MfMA2RMcdsPsDvTtMcwuRY6OPIFakttQd3EBFEmh3vJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418526; c=relaxed/simple;
	bh=HV5sW6KL3GpUAMX0uPq4oNFgLepZJuCXsf6LjNhuVhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAI5YxdWkojWhZpPzJn8iYUo2sP7RAvhUXTW72oO89vO0o0TNv7bWFlg4S7HN3UmgmgbpBddjCqixm9e/j+a9COwsnjuTS+ZBkPp/Y9Db+4AVO5C3AQ3OUGlk+KR4eqAiWhfVnPLNQIB0QuR8M5Yjdyw+9cRVksXDsSYZspezz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Lkt49FfP; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id BE9F0604DC;
	Fri, 16 May 2025 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1747418516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gntzzHgR7hVfcxIHz+wXqJ/img6vkZtc4/PYkuXugA=;
	b=Lkt49FfPhgvCYAEys78J9qRvMVLYQjXftRz0aqJwwWeo8TNAF1z3aQBCxVA6c2+SEKjlsV
	Io0jANRbvFGSujBGqBfrJGlpJVIIJw2afi9NHfN2u6q7O3o/ue2dql2Y/UPVRiSgbPB+Uu
	yqEuvpe9lt78btCL14A6dLAbVd5BuqA=
Received: from frank-u24.. (fttx-pool-157.180.226.139.bambit.de [157.180.226.139])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 748D41226F2;
	Fri, 16 May 2025 18:01:56 +0000 (UTC)
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
Subject: [PATCH v2 04/14] arm64: dts: mediatek: mt7988: add spi controllers
Date: Fri, 16 May 2025 20:01:35 +0200
Message-ID: <20250516180147.10416-6-linux@fw-web.de>
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

Add SPI controllers for mt7988.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 45 +++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 8f6d1dfae24a..8c31935f4ab0 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -311,6 +311,51 @@ i2c2: i2c@11005000 {
 			status = "disabled";
 		};
 
+		spi0: spi@11007000 {
+			compatible = "mediatek,mt7988-spi-quad", "mediatek,spi-ipm";
+			reg = <0 0x11007000 0 0x100>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_MPLL_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_104M_SPI0>,
+				 <&infracfg CLK_INFRA_66M_SPI0_HCK>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk",
+				      "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi1: spi@11008000 {
+			compatible = "mediatek,mt7988-spi-single", "mediatek,spi-ipm";
+			reg = <0 0x11008000 0 0x100>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_MPLL_D2>,
+				 <&topckgen CLK_TOP_SPIM_MST_SEL>,
+				 <&infracfg CLK_INFRA_104M_SPI1>,
+				 <&infracfg CLK_INFRA_66M_SPI1_HCK>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk",
+				      "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi2: spi@11009000 {
+			compatible = "mediatek,mt7988-spi-quad", "mediatek,spi-ipm";
+			reg = <0 0x11009000 0 0x100>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_MPLL_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_104M_SPI2_BCK>,
+				 <&infracfg CLK_INFRA_66M_SPI2_HCK>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk",
+				      "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		lvts: lvts@1100a000 {
 			compatible = "mediatek,mt7988-lvts-ap";
 			#thermal-sensor-cells = <1>;
-- 
2.43.0


