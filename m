Return-Path: <netdev+bounces-198269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29861ADBBB5
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593051674AF
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124B214A6A;
	Mon, 16 Jun 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hGhzisxY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD91E89C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108042; cv=none; b=QSTNl4Ar3Pw8ejyEtXPa8Nvkk2k3z72JSRNm677RanY1yt51B4FyVJgJFVPMF9clk35KnQMdS2GHHz4GTPNe+csQIfwLzPqzTcUDjmr49AJgP45Nd5u9w6bAmit3GB0gpSSaQfaFaWE6LN3cDZwbyqf5vsGXB7Wz0ZllgDyqlw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108042; c=relaxed/simple;
	bh=SGWVM+Jwva8ZwV9z3560ln2FMkGpWdsyU0+P1kzonBg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PVA/42JFMQLiwU9CALkiT2vrWVJS1idZVfsp36zTOwRBSeJmqOeFRbbJEVw8jx9R553R0mkamPXhLq+3oAuU2p+FlJV/da6FDAZqwgXCwKUBkYn6TyZspf9rTLfoWTpZgsrB2x/XIu15iWwYsbn+mPQeFxrHKqcRqk9PvUzr+L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hGhzisxY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wIfUnzGMGVGq2OxybQ2u1EyFAhDicZ6TudUKzWins8I=; b=hGhzisxYWTAl91Jqr9NH5Ll0e9
	rEdqL5qB40/F91i37xa6mnpYxu+yHvAg6mdvYIX+VJ7GrH26A878/GNhRAbDCZubx/K2P/7L3l5sT
	mc2s6QxT0TjgM4kkXx2L1urXBWQOICtMgMFicDYqDCT/N37uX7AJ1MnwmlRGYaH2MlxULZ+kbMb8T
	6a1DMrntDv8oat6aBNS4ESZC2gBmCcvaD1mvNbUS09qsV5veAV2xV9MpedvOqc0THbXZApVmnTnWu
	9BgdU/3b8Q5wOqiKDJoPsM0bIOp55yAXNPySP92D9DbD6qTkCckqSD5RShpOuaKsj10pGdEb09Lej
	SMF1V24A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36656 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uRH2u-0004HM-3B;
	Mon, 16 Jun 2025 22:07:13 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uRH2G-004UyY-GD; Mon, 16 Jun 2025 22:06:32 +0100
In-Reply-To: <aFCHJWXSLbUoogi6@shell.armlinux.org.uk>
References: <aFCHJWXSLbUoogi6@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/4] net: stmmac: visconti: make phy_intf_sel local
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uRH2G-004UyY-GD@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 16 Jun 2025 22:06:32 +0100

There is little need to have phy_intf_sel as a member of struct
visconti_eth when we have the PHY interface mode available from
phylink in visconti_eth_set_clk_tx_rate(). Without multiple
interface support, phylink is fixed to supporting only
plat->phy_interface, so we can be sure that "interface" passed
into this function is the same as plat->phy_interface.

Make phy_intf_sel local to visconti_eth_init_hw() and clean up.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-visconti.c  | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index db82b522c248..bd65d4239054 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -48,7 +48,6 @@
 
 struct visconti_eth {
 	void __iomem *reg;
-	u32 phy_intf_sel;
 	struct clk *phy_ref_clk;
 	struct device *dev;
 };
@@ -57,9 +56,9 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 					phy_interface_t interface, int speed)
 {
 	struct visconti_eth *dwmac = bsp_priv;
-	unsigned int val, clk_sel = 0;
+	unsigned long clk_sel, val;
 
-	if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RGMII) {
+	if (phy_interface_mode_is_rgmii(interface)) {
 		switch (speed) {
 		case SPEED_1000:
 			clk_sel = ETHER_CLK_SEL_FREQ_SEL_125M;
@@ -93,7 +92,7 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 
 		val &= ~ETHER_CLK_SEL_TX_O_E_N_IN;
 		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
-	} else if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RMII) {
+	} else if (interface == PHY_INTERFACE_MODE_RMII) {
 		switch (speed) {
 		case SPEED_100:
 			clk_sel = ETHER_CLK_SEL_DIV_SEL_2;
@@ -150,28 +149,28 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 static int visconti_eth_init_hw(struct platform_device *pdev, struct plat_stmmacenet_data *plat_dat)
 {
 	struct visconti_eth *dwmac = plat_dat->bsp_priv;
-	unsigned int reg_val, clk_sel_val;
+	unsigned int clk_sel_val;
+	u32 phy_intf_sel;
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		dwmac->phy_intf_sel = ETHER_CONFIG_INTF_RGMII;
+		phy_intf_sel = ETHER_CONFIG_INTF_RGMII;
 		break;
 	case PHY_INTERFACE_MODE_MII:
-		dwmac->phy_intf_sel = ETHER_CONFIG_INTF_MII;
+		phy_intf_sel = ETHER_CONFIG_INTF_MII;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		dwmac->phy_intf_sel = ETHER_CONFIG_INTF_RMII;
+		phy_intf_sel = ETHER_CONFIG_INTF_RMII;
 		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported phy-mode (%d)\n", plat_dat->phy_interface);
 		return -EOPNOTSUPP;
 	}
 
-	reg_val = dwmac->phy_intf_sel;
-	writel(reg_val, dwmac->reg + REG_ETHER_CONTROL);
+	writel(phy_intf_sel, dwmac->reg + REG_ETHER_CONTROL);
 
 	/* Enable TX/RX clock */
 	clk_sel_val = ETHER_CLK_SEL_FREQ_SEL_125M;
@@ -181,8 +180,8 @@ static int visconti_eth_init_hw(struct platform_device *pdev, struct plat_stmmac
 	       dwmac->reg + REG_ETHER_CLOCK_SEL);
 
 	/* release internal-reset */
-	reg_val |= ETHER_ETH_CONTROL_RESET;
-	writel(reg_val, dwmac->reg + REG_ETHER_CONTROL);
+	phy_intf_sel |= ETHER_ETH_CONTROL_RESET;
+	writel(phy_intf_sel, dwmac->reg + REG_ETHER_CONTROL);
 
 	return 0;
 }
-- 
2.30.2


