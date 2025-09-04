Return-Path: <netdev+bounces-219919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D78B43B31
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F66954449E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913952DFA39;
	Thu,  4 Sep 2025 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vcQihDfN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5A2C21C0
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987880; cv=none; b=YPcUelBA++vOZcu7DxJTRgUlXC3O4MmjwarApuD4u9oEayAqasZEupZyrdRr1R89NmTmlOdhtKxNSkTH0n7M4T1xl/hbjRbDFbUM9xjewl05uMym0pqN1qjSFLZCYHqKhlsTlr+DYU876vD32tuZo74s/krK3QR/9Bp/SgTLMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987880; c=relaxed/simple;
	bh=ht3WwgjNKjbKSZDQ+KHUaxNhVkkrb9Hiin507OO8Ta8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=cA0RCz2xy84J18xH1qQR/sGeCyPetUSfcTEt0zvZrjPU4atAqTj0/uzWZ1c7/eQnmq7XB2FidmZC9q5OnHEPYFg8PZB6qcR0Q5oUb36QkWNz3kXB1SOlyT0WMIRQVVgR3DLNbJMS64xM9T8T3yOa8NOqqrUVie/PcL11EffKc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vcQihDfN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ULNdmNCRIkxTZoG3Dhg+00hD3xZk802sCVX/OceuCXk=; b=vcQihDfN3gMaQiuBf8ew4pox7j
	7jNiz2DnlR2GdLbke/hlIY+/eDcKVQbEMNYzgP7Tjiotnks50pHa8HpLEe0LrubZNTrYPcWedwdQa
	N5Ab0BJ+Oe+RJATmx0fFgK9HboPcqMkWlYodGiunL1PtgOOSx+rn/Ivieud8C+D3fxXWZ4tzkEE5G
	gr2vFRW2jhW+YAn3HZoY7tTxULKuVshPK23EKZYQHQ1i5uvsQ9XQaKNnBDCxyiqfAyjiDru++3yR8
	1JHhU/HX1AK8KRovfviR65FBbf3mZEhyvFvUYnxilA9vvgEXOVqFhONT4lrq+pfVC08YfmjY4E0kO
	5/Bo094g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36092 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uu8o3-000000001xZ-0ySZ;
	Thu, 04 Sep 2025 13:11:11 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uu8o2-00000001vog-1LyK;
	Thu, 04 Sep 2025 13:11:10 +0100
In-Reply-To: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 03/11] net: stmmac: mdio: provide
 priv->gmii_address_bus_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uu8o2-00000001vog-1LyK@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 04 Sep 2025 13:11:10 +0100

Provide a pre-formatted value for the MDIO address register fields
which remain constant across the various different transactions
rather than recreating the register value from scratch every time.
Currently, we only do this for the CR (clock range) field.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 26 ++++++++++++-------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 78d6b3737a26..4d5577935b13 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -290,6 +290,7 @@ struct stmmac_priv {
 	int wolopts;
 	int wol_irq;
 	int clk_csr;
+	u32 gmii_address_bus_config;
 	struct timer_list eee_ctrl_timer;
 	int lpi_irq;
 	u32 tx_lpi_timer;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 6acce54b5d55..4294262c208d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -104,9 +104,7 @@ static int stmmac_xgmac2_mdio_read(struct stmmac_priv *priv, u32 addr,
 	if (ret)
 		goto err_disable_clks;
 
-	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
-		& priv->hw->mii.clk_csr_mask;
-	value |= MII_XGMAC_READ;
+	value |= priv->gmii_address_bus_config | MII_XGMAC_READ;
 
 	/* Wait until any existing MII operation is complete */
 	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
@@ -174,10 +172,7 @@ static int stmmac_xgmac2_mdio_write(struct stmmac_priv *priv, u32 addr,
 	if (ret)
 		goto err_disable_clks;
 
-	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
-		& priv->hw->mii.clk_csr_mask;
-	value |= phydata;
-	value |= MII_XGMAC_WRITE;
+	value |= priv->gmii_address_bus_config | phydata | MII_XGMAC_WRITE;
 
 	/* Wait until any existing MII operation is complete */
 	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
@@ -241,8 +236,7 @@ static u32 stmmac_mdio_format_addr(struct stmmac_priv *priv,
 
 	return ((pa << mii_regs->addr_shift) & mii_regs->addr_mask) |
 	       ((gr << mii_regs->reg_shift) & mii_regs->reg_mask) |
-	       ((priv->clk_csr << mii_regs->clk_csr_shift) &
-		mii_regs->clk_csr_mask) |
+	       priv->gmii_address_bus_config |
 	       MII_BUSY;
 }
 
@@ -517,6 +511,18 @@ void stmmac_pcs_clean(struct net_device *ndev)
 	priv->hw->xpcs = NULL;
 }
 
+static void stmmac_mdio_bus_config(struct stmmac_priv *priv, u32 value)
+{
+	value <<= priv->hw->mii.clk_csr_shift;
+
+	if (value & ~priv->hw->mii.clk_csr_mask)
+		dev_warn(priv->device,
+			 "clk_csr value out of range (0x%08x exceeds mask 0x%08x), truncating\n",
+			 value, priv->hw->mii.clk_csr_mask);
+
+	priv->gmii_address_bus_config = value & priv->hw->mii.clk_csr_mask;
+}
+
 /**
  * stmmac_mdio_register
  * @ndev: net device structure
@@ -537,6 +543,8 @@ int stmmac_mdio_register(struct net_device *ndev)
 	if (!mdio_bus_data)
 		return 0;
 
+	stmmac_mdio_bus_config(priv, priv->clk_csr);
+
 	new_bus = mdiobus_alloc();
 	if (!new_bus)
 		return -ENOMEM;
-- 
2.47.2


