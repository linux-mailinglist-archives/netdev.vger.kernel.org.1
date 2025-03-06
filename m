Return-Path: <netdev+bounces-172637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE86A55979
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95C23AF0AF
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B62B27CB3B;
	Thu,  6 Mar 2025 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="0N6EQO2O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1F627CB10
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299267; cv=none; b=NoZfd/0hCaAHt/K2jdKxw+gvsIWjvxZZLlGGWX3HyjAUw3kfsFQ9Uj2epSpfHe7Phl1XcU7ph+HW0TFVincwwFP+Yvrs6QJVD6eYLlYZYhihUTUISWNfRX53zT+dhI65DcYqfvGhsHu2mKtvVOR9/JX/uEvrY4bbd8A7BzPGEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299267; c=relaxed/simple;
	bh=wCRkM354a8TxW667a3g0fsIH10ONtZ5IxZkFWyNzvLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPpuBglcT3BMeqnUzfydKnpfWHny+RtnwdM5G6nUGh9660O8Cj2EzG0+cJfluzvbsx6Edy9GcfcvTXQuUSpuXk7gNtOtdW72ohurCXYKVU3mjjTK1JGDORBS5xNZ8eXzTJyqfK5QSNofQzaFXsdSo5BR4e8pfEoOZ+xR7z1XgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=0N6EQO2O; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741299264; bh=fshpc8o5qKk/aC1XdolZ+vML6RG3s5omLxYcjsXplmM=;
 b=0N6EQO2O3ChzeDvXmArhM7zB8CCuYBrPu87Vce+Gyep8qpLJWlg/8CBITVIyCerS6UR0D+t9p
 8RIkAjGQwERA7dEFXvfbji2qKNu9i9Ua8L7MeLAY2oisZjeqJOA5JwKauIXx/8aE5Q+TgnGvLG4
 o2yBwDtrk1TDLOp5C8JsB4VufnG8LERTrpRJCGkf0Ce1jhp85RUe63PZ8rnPcQic6UQadVkjtBl
 N/IYDHjM0bsuw73x5PCkMyiRWpwGK81fxy6OY+nYQLw+oXmZai1VTq//NTGK8JGXGqgQOOp2+r5
 cvs2VmyMUIhYOFMjRr+MHTyb1KcbuQyfgdPJ1nROBdQg==
X-Forward-Email-ID: 67ca1e3ec1763851c065c028
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/4] arm64: dts: rockchip: Add GMAC nodes for RK3528
Date: Thu,  6 Mar 2025 22:13:56 +0000
Message-ID: <20250306221402.1704196-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306221402.1704196-1-jonas@kwiboo.se>
References: <20250306221402.1704196-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 has two Ethernet controllers based on Synopsys DWC
Ethernet QoS IP.

Add device tree nodes for the two Ethernet controllers in RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
gmac0 is missing the integrated-phy and has not been tested bacause I do
not have any board that use this Ethernet controller.
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 92 ++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index c1a71ea81e03..5940719cffec 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -286,6 +286,98 @@ saradc: adc@ffae0000 {
 			#io-channel-cells = <1>;
 		};
 
+		gmac0: ethernet@ffbd0000 {
+			compatible = "rockchip,rk3528-gmac", "snps,dwmac-4.20a";
+			reg = <0x0 0xffbd0000 0x0 0x10000>;
+			clocks = <&cru CLK_GMAC0_SRC>, <&cru CLK_GMAC0_RMII_50M>,
+				 <&cru CLK_GMAC0_RX>, <&cru CLK_GMAC0_TX>,
+				 <&cru PCLK_MAC_VO>, <&cru ACLK_MAC_VO>;
+			clock-names = "stmmaceth", "clk_mac_ref",
+				      "mac_clk_rx", "mac_clk_tx",
+				      "pclk_mac", "aclk_mac";
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			resets = <&cru SRST_A_MAC_VO>;
+			reset-names = "stmmaceth";
+			rockchip,grf = <&vo_grf>;
+			snps,axi-config = <&gmac0_stmmac_axi_setup>;
+			snps,mixed-burst;
+			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
+			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
+			snps,tso;
+			status = "disabled";
+
+			mdio0: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+			};
+
+			gmac0_stmmac_axi_setup: stmmac-axi-config {
+				snps,blen = <0 0 0 0 16 8 4>;
+				snps,rd_osr_lmt = <8>;
+				snps,wr_osr_lmt = <4>;
+			};
+
+			gmac0_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <1>;
+				queue0 {};
+			};
+
+			gmac0_mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <1>;
+				queue0 {};
+			};
+		};
+
+		gmac1: ethernet@ffbe0000 {
+			compatible = "rockchip,rk3528-gmac", "snps,dwmac-4.20a";
+			reg = <0x0 0xffbe0000 0x0 0x10000>;
+			clocks = <&cru CLK_GMAC1_SRC_VPU>,
+				 <&cru CLK_GMAC1_RMII_VPU>,
+				 <&cru PCLK_MAC_VPU>,
+				 <&cru ACLK_MAC_VPU>;
+			clock-names = "stmmaceth",
+				      "clk_mac_ref",
+				      "pclk_mac",
+				      "aclk_mac";
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			resets = <&cru SRST_A_MAC>;
+			reset-names = "stmmaceth";
+			rockchip,grf = <&vpu_grf>;
+			snps,axi-config = <&gmac1_stmmac_axi_setup>;
+			snps,mixed-burst;
+			snps,mtl-rx-config = <&gmac1_mtl_rx_setup>;
+			snps,mtl-tx-config = <&gmac1_mtl_tx_setup>;
+			snps,tso;
+			status = "disabled";
+
+			mdio1: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+			};
+
+			gmac1_stmmac_axi_setup: stmmac-axi-config {
+				snps,blen = <0 0 0 0 16 8 4>;
+				snps,rd_osr_lmt = <8>;
+				snps,wr_osr_lmt = <4>;
+			};
+
+			gmac1_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <1>;
+				queue0 {};
+			};
+
+			gmac1_mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <1>;
+				queue0 {};
+			};
+		};
+
 		sdhci: mmc@ffbf0000 {
 			compatible = "rockchip,rk3528-dwcmshc",
 				     "rockchip,rk3588-dwcmshc";
-- 
2.48.1


