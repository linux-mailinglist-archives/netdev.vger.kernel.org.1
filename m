Return-Path: <netdev+bounces-212151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60FBB1E685
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD71958760F
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46C626FA4E;
	Fri,  8 Aug 2025 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ktQke4CX"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A321224D7;
	Fri,  8 Aug 2025 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754649349; cv=none; b=PjwmU5r5DDyv+2vLOvKM+YH+5FlPXRjdgjRKaUmSx6HnjPr5ZfNZJ8xobmEO3qTfs8lP3HnchoYz74vQKqw/i2j8Tj2djkZqOmkyhUJ2P0KZ9BXh9C+MvEKNlsYXeU6eqT1m+ox5m2VZ0DzGt3Ed2HfJ5va7XZcfQciIpYCYiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754649349; c=relaxed/simple;
	bh=pWahph/BmK2+BKhzM7PR0tujg3En3xybe2SHthvSIsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmSNtTMe8/4KmNG7dWliLXFkRRcqgQ+kyO2rNLl/mGDUSoMV2hiJm5oHcQMtRcm+BykvoOFn8U5+jWlIcVclu6mW7H/VyfN7RYi886rvQn2c70Ze8qIxHLhdpi19T9j/5fE2NNObUC/i5I+y/UMhTgfgdKIPVbdHaDJo+aPVDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ktQke4CX; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7530525D56;
	Fri,  8 Aug 2025 12:35:46 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ljm0-CrWkI5d; Fri,  8 Aug 2025 12:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754649345; bh=pWahph/BmK2+BKhzM7PR0tujg3En3xybe2SHthvSIsc=;
	h=From:To:Cc:Subject:Date;
	b=ktQke4CXrV26NGfgqQzJgjioG5IzStJmhyz1+rorLbgJEJB6ZhUMLFOtxMZe/YVfq
	 MnJWzzbP2qlqyvi2IyJXR/4SsMpwcHuOWRsADV5yUoAk8v656/ECU0sXrkdposeWug
	 +zGrD7BStkPEPPEY+ncEEbtKSOd4X+a5R6FzWlieJHsLjwTEQhSp84mziylJyRTYDS
	 YpKda4hJdbODKnj6f9fghoO88KLUiqAchPh83++0+5aZ3lzTGxW3A6Nykx6VfkwSXN
	 ipaZApF0lrcZZmNJWaP7rlVsodGjQtnFEfrjg+qSlQEFtHjiBlSU1LpdeSghPvnYWh
	 LaIHhxbI86O/A==
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
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH net v2] net: stmmac: thead: Enable TX clock before MAC initialization
Date: Fri,  8 Aug 2025 10:34:48 +0000
Message-ID: <20250808103447.63146-2-ziyao@disroot.org>
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
divider before MAC initialization. The exact rate doesn't affect MAC's
initialization according to my test. It's set to the speed required by
RGMII when the linkspeed is 1Gbps and could be reclocked later after
link is up if necessary.

Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---

Note that the DMA reset failures cannot be reproduced with the vendor
U-Boot, which always enables the divider, regardless whether the port is
used[1].

As this scheme (enables the divider first and reclock it later) requires
access to the APB glue registers, the patch depends on v3 of series
"Fix broken link with TH1520 GMAC when linkspeed changes"[2] to ensure
the APB bus clock is ungated.

[1]: https://github.com/revyos/thead-u-boot/blob/93ff49d9f5bbe7942f727ab93311346173506d27/board/thead/light-c910/light.c#L581-L582
[2]: https://lore.kernel.org/netdev/20250808093655.48074-2-ziyao@disroot.org/

Changed from v1
- Initialize the divisor to a well-known value (producing the clock rate
  required by RGMII link at 1Gbps)
- Write zero to GMAC_PLLCLK_DIV before writing the configuration, as
  required by the TRM
- Link to v1: https://lore.kernel.org/netdev/20250801094507.54011-1-ziyao@disroot.org/

 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index f2946bea0bc2..50c1920bde6a 100644
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
+		      FIELD_PREP(GMAC_PLLCLK_DIV_NUM, div),
+
+		writel(0, dwmac->apb_base + GMAC_PLLCLK_DIV);
+		writel(reg, dwmac->apb_base + GMAC_PLLCLK_DIV);
+
 		writel(GMAC_GTXCLK_SEL_PLL, dwmac->apb_base + GMAC_GTXCLK_SEL);
 		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
 		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
-- 
2.50.1


