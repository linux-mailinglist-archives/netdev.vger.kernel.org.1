Return-Path: <netdev+bounces-219917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BF4B43B27
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13FB1654D2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067762C325F;
	Thu,  4 Sep 2025 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vQdDzl2X"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EBD233704
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987869; cv=none; b=qlO7+VBLgP24XzoYGhYaWMCuY+Oz60nGSG7UuD3H1vm0EwzvDkJm/3KLMpe/FJYdiOHsLS8kDAeJq7mqrmr4Cg7jv7MlMtdDQcLHVtQuz8vS7WTWbGyR8zTiCn0FS0NTvobIXK/X6AJrgPcGcFGMPbtfaIXrt52mVBOcv7rEhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987869; c=relaxed/simple;
	bh=LIpUikcrX5/ySo0shgb7Su5KROgZ/u94yzpZjtCvmQI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dgtFE2Tpabf+5plJ445gaiY4MvwbpjChpCAP97xcAng2z/XAjys5F7FG+cuXCnGQqkpAA/Denpwki3YOW7yGlHYDHcRTnI68sXklgJEuzA5q6US5TIZUksbyylKXIGyx8SfVK14VT6dL3TvMcQpVtYgpqtIq1KH8zfnJ/aAGYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vQdDzl2X; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+igjDa/+h9/dAI1xGE7rMdzLe9y5NMxBfbCy+NMhbVY=; b=vQdDzl2XgdNOcAHkagERx00mel
	7ytanqclz8vvy4ifouQhW0CFGlpLuFygOkm45cmxH5DOLuQWLXob4AQz9Dy62RHlMoWccsDFl6kVj
	rBAdCvx/abs4MXUk31UcFzmHXb61HT7ZTt9sQRf/E2tU5ukDwJDKiNZgVOsSTOjTbBRyh1ADhxkj7
	YeQBL0UpQNDBZ2p7sE8tzHJAht9snD0rYuL1eIOWla4tvm17g2PPmnEGz8c3Uv47JCL2d5fJVzXKJ
	hMsjTowIGuLfeSMYeIRoU5GBwQR2Sq9IU6Xc4hq7bjGay0RCJnVYkFqhpAd8Vr3EIcCXh1Ae7k05j
	IWOYDnng==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55606 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uu8ns-000000001x3-3kcd;
	Thu, 04 Sep 2025 13:11:00 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uu8ns-00000001voU-0S7b;
	Thu, 04 Sep 2025 13:11:00 +0100
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
Subject: [PATCH net-next v2 01/11] net: stmmac: mdio: provide address register
 formatter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uu8ns-00000001voU-0S7b@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 04 Sep 2025 13:11:00 +0100

Rather than duplicating the logic for filling the PA (MDIO address),
GR (MDIO register/devad), CR (clock range) and GB (busy) fields of the
address register in four locations, provide a helper to do this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 55 ++++++++++---------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 0a302b711bc2..c305c202055a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -229,6 +229,26 @@ static int stmmac_xgmac2_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 					phydata);
 }
 
+/**
+ * stmmac_mdio_format_addr() - format the address register
+ * @priv: struct stmmac_priv pointer
+ * @pa: 5-bit MDIO package address
+ * @gr: 5-bit MDIO register address (C22) or MDIO device address (C45)
+ *
+ * Return: formatted address register
+ */
+static u32 stmmac_mdio_format_addr(struct stmmac_priv *priv,
+				   unsigned int pa, unsigned int gr)
+{
+	const struct mii_regs *mii_regs = &priv->hw->mii;
+
+	return ((pa << mii_regs->addr_shift) & mii_regs->addr_mask) |
+	       ((gr << mii_regs->reg_shift) & mii_regs->reg_mask) |
+	       ((priv->clk_csr << mii_regs->clk_csr_shift) &
+		mii_regs->clk_csr_mask) |
+	       MII_BUSY;
+}
+
 static int stmmac_mdio_read(struct stmmac_priv *priv, int data, u32 value)
 {
 	unsigned int mii_address = priv->hw->mii.addr;
@@ -263,18 +283,14 @@ static int stmmac_mdio_read(struct stmmac_priv *priv, int data, u32 value)
 static int stmmac_mdio_read_c22(struct mii_bus *bus, int phyaddr, int phyreg)
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
-	u32 value = MII_BUSY;
 	int data = 0;
+	u32 value;
 
 	data = pm_runtime_resume_and_get(priv->device);
 	if (data < 0)
 		return data;
 
-	value |= (phyaddr << priv->hw->mii.addr_shift)
-		& priv->hw->mii.addr_mask;
-	value |= (phyreg << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
-	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
-		& priv->hw->mii.clk_csr_mask;
+	value = stmmac_mdio_format_addr(priv, phyaddr, phyreg);
 	if (priv->plat->has_gmac4)
 		value |= MII_GMAC4_READ;
 
@@ -300,20 +316,16 @@ static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
 				int phyreg)
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
-	u32 value = MII_BUSY;
 	int data = 0;
+	u32 value;
 
 	data = pm_runtime_resume_and_get(priv->device);
 	if (data < 0)
 		return data;
 
-	value |= (phyaddr << priv->hw->mii.addr_shift)
-		& priv->hw->mii.addr_mask;
-	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
-		& priv->hw->mii.clk_csr_mask;
+	value = stmmac_mdio_format_addr(priv, phyaddr, devad);
 	value |= MII_GMAC4_READ;
 	value |= MII_GMAC4_C45E;
-	value |= (devad << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
 
 	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
 
@@ -357,18 +369,13 @@ static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int ret, data = phydata;
-	u32 value = MII_BUSY;
+	u32 value;
 
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
 
-	value |= (phyaddr << priv->hw->mii.addr_shift)
-		& priv->hw->mii.addr_mask;
-	value |= (phyreg << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
-
-	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
-		& priv->hw->mii.clk_csr_mask;
+	value = stmmac_mdio_format_addr(priv, phyaddr, phyreg);
 	if (priv->plat->has_gmac4)
 		value |= MII_GMAC4_WRITE;
 	else
@@ -395,21 +402,15 @@ static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int ret, data = phydata;
-	u32 value = MII_BUSY;
+	u32 value;
 
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
 
-	value |= (phyaddr << priv->hw->mii.addr_shift)
-		& priv->hw->mii.addr_mask;
-
-	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
-		& priv->hw->mii.clk_csr_mask;
-
+	value = stmmac_mdio_format_addr(priv, phyaddr, devad);
 	value |= MII_GMAC4_WRITE;
 	value |= MII_GMAC4_C45E;
-	value |= (devad << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
 
 	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
 
-- 
2.47.2


