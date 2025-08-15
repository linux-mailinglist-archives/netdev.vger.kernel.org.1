Return-Path: <netdev+bounces-214033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A8CB27EB1
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E165178D73
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17C2FFDF6;
	Fri, 15 Aug 2025 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="W9iw0BPn"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59311DF24F;
	Fri, 15 Aug 2025 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254913; cv=none; b=ReswvTSLFtfRtb2Nkrnu38W4/HnMnW4mh8Ekpb5JsR/XwwQVtDgkof7J0cpexTr0/gcwtMdIW4AFCcw+OiCOnsAbuILUMy/oD2ZQdH+JHoECxkNpBIu4ERhP14A63VnoAuZSSFQCQ1+Fx2G04wjXpzwBUR/LHrhZNwHIgGwrxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254913; c=relaxed/simple;
	bh=G1edQCNuacWPxWwIea/30FqFc+UX9B4+0teA0JgdIRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qc4Pi1tmWMSEUHTiuoC76xcE1ARIXT0NWoZetAxKot9Mmt5fFMJJwWsuOuQhEnyE8l3ge+ajwd+AT1ljskWkCNCcWyse802AvKi40wf3pXk5es3xIRE2PUMPnI+jxYzW39IQCrvpAdRCJyauqDwZCE2acznIKf+jJGNsb9d47Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=W9iw0BPn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 86D5324E0A;
	Fri, 15 Aug 2025 12:48:22 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SyKGABv6NFZd; Fri, 15 Aug 2025 12:48:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755254900; bh=G1edQCNuacWPxWwIea/30FqFc+UX9B4+0teA0JgdIRo=;
	h=From:To:Cc:Subject:Date;
	b=W9iw0BPno5o8NOL0V8LNhfHfl5armoo9r66RuZGE4y1ImOyqLtIWM8qUsuZBEhfe5
	 kixnIHsrNfajaya+gpOmsjxV67sxur+BoRiSVgPAhvGK4Ty0uOFPVeRpAFkQzN2abu
	 3fdiKjMX71Ra+umb9W/m7oP726h2ETceZJ6HRvyT04YA90jHq84enWsb5J1oJlOf8i
	 8dDFPFPiczTUBsVnbBMK2kp+Y+B1BhdwBfhJOwX3sxdUbf5QDzSA89kXgz2p/6O8Bw
	 2IDdB2X5r2DVaXua8wo3EsUEeqmrUYx2arxq6yvPuf+/FcrQ9gu0qqj1WyVnd8Kqf2
	 zGOLsmCDMgotw==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: nux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Han Gao <rabenda.cn@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH net v3] net: stmmac: thead: Enable TX clock before MAC initialization
Date: Fri, 15 Aug 2025 10:48:03 +0000
Message-ID: <20250815104803.55294-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_tx_i clock must be supplied to the MAC for successful
initialization. On TH1520 SoC, the clock is provided by an internal
divider configured through GMAC_PLLCLK_DIV register when using RGMII
interface. However, currently we don't setup the divider before
initialization of the MAC, resulting in DMA reset failures if the
bootloader/firmware doesn't enable the divider,

[    7.839601] thead-dwmac ffe7060000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
[    7.938338] thead-dwmac ffe7060000.ethernet eth0: PHY [stmmac-0:02] driver [RTL8211F Gigabit Ethernet] (irq=POLL)
[    8.160746] thead-dwmac ffe7060000.ethernet eth0: Failed to reset the dma
[    8.170118] thead-dwmac ffe7060000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
[    8.179384] thead-dwmac ffe7060000.ethernet eth0: __stmmac_open: Hw setup failed

Let's simply write GMAC_PLLCLK_DIV_EN to GMAC_PLLCLK_DIV to enable the
divider before MAC initialization. Note that for reconfiguring the
divisor, the divider must be disabled first and re-enabled later to make
sure the new divisor take effect.

The exact clock rate doesn't affect MAC's initialization according to my
test. It's set to the speed required by RGMII when the linkspeed is
1Gbps and could be reclocked later after link is up if necessary.

Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---

Note that the DMA reset failures cannot be reproduced with the vendor
U-Boot, which always enables the divider, regardless whether the port is
used[1].

[1]: https://github.com/revyos/thead-u-boot/blob/93ff49d9f5bbe7942f727ab93311346173506d27/board/thead/light-c910/light.c#L581-L582

Changed from v2
- Explain the special process for changing divider's rate in commit
  message
- Fix the typo where ';' is mistyped as ','
- Link to v2: https://lore.kernel.org/all/20250808103447.63146-2-ziyao@disroot.org/
Changed from v1
- Initialize the divisor to a well-known value (producing the clock rate
  required by RGMII link at 1Gbps)
- Write zero to GMAC_PLLCLK_DIV before writing the configuration, as
  required by the TRM
- Link to v1: https://lore.kernel.org/netdev/20250801094507.54011-1-ziyao@disroot.org/

 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index f2946bea0bc2..6c6c49e4b66f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -152,7 +152,7 @@ static int thead_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
 {
 	struct thead_dwmac *dwmac = plat->bsp_priv;
-	u32 reg;
+	u32 reg, div;
 
 	switch (plat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
@@ -164,6 +164,13 @@ static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* use pll */
+		div = clk_get_rate(plat->stmmac_clk) / rgmii_clock(SPEED_1000);
+		reg = FIELD_PREP(GMAC_PLLCLK_DIV_EN, 1) |
+		      FIELD_PREP(GMAC_PLLCLK_DIV_NUM, div);
+
+		writel(0, dwmac->apb_base + GMAC_PLLCLK_DIV);
+		writel(reg, dwmac->apb_base + GMAC_PLLCLK_DIV);
+
 		writel(GMAC_GTXCLK_SEL_PLL, dwmac->apb_base + GMAC_GTXCLK_SEL);
 		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
 		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
-- 
2.50.1


