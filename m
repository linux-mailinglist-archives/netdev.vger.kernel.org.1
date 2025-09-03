Return-Path: <netdev+bounces-219561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC2EB41F5D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E2C3A7D9A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FEA2FF165;
	Wed,  3 Sep 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nTDwRIZa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D32FF163
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903175; cv=none; b=QWOPE5LkHGR8xwd35bcOtCoauXSP1KM0D1gkm1GADYFakojwsjm9vR5O+zC9vZ17mXMls5KALWnWEL7KOTujptNf3PdJ1ZgQx+ibRJyXX9Cs1/3qLXJE501k/rVG7baDrc5GTfXNTww5AHGGjddkXeU4QKSJpjXOKpSyviY6Vvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903175; c=relaxed/simple;
	bh=lQxFivAocfDiJPLQe6EVZ+5odPPU4762fNlqpAu4m24=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GVGze+iHiZhGfzUDOw0M646egCXMniOvugCsbN1A3vvMK6Q7sqXLFQrYlWP+m08e4Y0W2cgSH2mDpPpDGXpCuBrne0cXlR1b8Rju8byADeYeApb+6fdLcARj+pYKCLwvscs1h3WdXhHCWNf3zPx07K1C4O+NMkAJ0bpCBvWzCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nTDwRIZa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7Vcn+jNdSqIoImGQxmQ24Vw/vq1kv4Ixu14H023fa5s=; b=nTDwRIZalp461m2QJWqvq1Aswt
	Thc6rTQhYilK5WEUe4Axzc2UsnuUaFo15gxQwV7nDfo88r6YKPtvPnEigT9YJz8MA3H8L8rbhRNJ1
	hcsIRnl1lSTbEYKeuOr0QRQ3Wj0+5Us/yYZ702z88QTeGetGF8+qg6K4Jc8zwcFOzRqsItNQRF+6V
	wa82J+poVjD9sjSJhuKXUT7NdSrpYXOKIUMKCl7yeVZxYooLhPoTBsHxXoNuDqv3gQAh4NGCIGT5K
	2syOE1pXCDYx1qRMZwfKJcKKPEr/ye7czmrbGdy7f469T8rajeyvCEdOHQqq+ktNxdmceO+fdXRpV
	/B38UmLA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51036 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1utmlo-000000000V7-3Z67;
	Wed, 03 Sep 2025 13:39:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1utmlo-00000001s06-0UTf;
	Wed, 03 Sep 2025 13:39:24 +0100
In-Reply-To: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
References: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 02/11] net: stmmac: mdio: provide stmmac_mdio_wait()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1utmlo-00000001s06-0UTf@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Sep 2025 13:39:24 +0100

All the readl_poll_timeout()s follow the same pattern - test a register
for a bit being clear every 100us, and timeout after 10ms returning
-EBUSY. Wrap this up into a function to avoid duplicating this.

This slightly changes the return value for stmmac_mdio_write() if the
second readl_poll_timeout() fails - rather than returning -ETIMEDOUT
we return -EBUSY matching the stmmac_mdio_read() behaviour.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 70 +++++++++----------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 3106fef6eed8..7887340ae7b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -45,6 +45,16 @@
 #define MII_XGMAC_PA_SHIFT		16
 #define MII_XGMAC_DA_SHIFT		21
 
+static int stmmac_mdio_wait(void __iomem *reg, u32 mask)
+{
+	u32 v;
+
+	if (readl_poll_timeout(reg, v, !(v & mask), 100, 10000))
+		return -EBUSY;
+
+	return 0;
+}
+
 static void stmmac_xgmac2_c45_format(struct stmmac_priv *priv, int phyaddr,
 				     int devad, int phyreg, u32 *hw_addr)
 {
@@ -83,7 +93,6 @@ static int stmmac_xgmac2_mdio_read(struct stmmac_priv *priv, u32 addr,
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
-	u32 tmp;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(priv->device);
@@ -91,33 +100,27 @@ static int stmmac_xgmac2_mdio_read(struct stmmac_priv *priv, u32 addr,
 		return ret;
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-			       !(tmp & MII_XGMAC_BUSY), 100, 10000)) {
-		ret = -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
+	if (ret)
 		goto err_disable_clks;
-	}
 
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
 	value |= MII_XGMAC_READ;
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-			       !(tmp & MII_XGMAC_BUSY), 100, 10000)) {
-		ret = -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
+	if (ret)
 		goto err_disable_clks;
-	}
 
 	/* Set the MII address register to read */
 	writel(addr, priv->ioaddr + mii_address);
 	writel(value, priv->ioaddr + mii_data);
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-			       !(tmp & MII_XGMAC_BUSY), 100, 10000)) {
-		ret = -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
+	if (ret)
 		goto err_disable_clks;
-	}
 
 	/* Read the data from the MII data register */
 	ret = (int)readl(priv->ioaddr + mii_data) & GENMASK(15, 0);
@@ -160,7 +163,6 @@ static int stmmac_xgmac2_mdio_write(struct stmmac_priv *priv, u32 addr,
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
-	u32 tmp;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(priv->device);
@@ -168,11 +170,9 @@ static int stmmac_xgmac2_mdio_write(struct stmmac_priv *priv, u32 addr,
 		return ret;
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-			       !(tmp & MII_XGMAC_BUSY), 100, 10000)) {
-		ret = -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
+	if (ret)
 		goto err_disable_clks;
-	}
 
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
@@ -180,19 +180,16 @@ static int stmmac_xgmac2_mdio_write(struct stmmac_priv *priv, u32 addr,
 	value |= MII_XGMAC_WRITE;
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-			       !(tmp & MII_XGMAC_BUSY), 100, 10000)) {
-		ret = -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
+	if (ret)
 		goto err_disable_clks;
-	}
 
 	/* Set the MII address register to write */
 	writel(addr, priv->ioaddr + mii_address);
 	writel(value, priv->ioaddr + mii_data);
 
 	/* Wait until any existing MII operation is complete */
-	ret = readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-				 !(tmp & MII_XGMAC_BUSY), 100, 10000);
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
 
 err_disable_clks:
 	pm_runtime_put(priv->device);
@@ -251,18 +248,18 @@ static int stmmac_mdio_read(struct stmmac_priv *priv, int data, u32 value)
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
-	u32 v;
+	int ret;
 
-	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
-			       100, 10000))
-		return -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
+	if (ret)
+		return ret;
 
 	writel(data, priv->ioaddr + mii_data);
 	writel(value, priv->ioaddr + mii_address);
 
-	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
-			       100, 10000))
-		return -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
+	if (ret)
+		return ret;
 
 	/* Read the data from the MII data register */
 	return readl(priv->ioaddr + mii_data) & MII_DATA_MASK;
@@ -338,20 +335,19 @@ static int stmmac_mdio_write(struct stmmac_priv *priv, int data, u32 value)
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
-	u32 v;
+	int ret;
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
-			       100, 10000))
-		return -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
+	if (ret)
+		return ret;
 
 	/* Set the MII address register to write */
 	writel(data, priv->ioaddr + mii_data);
 	writel(value, priv->ioaddr + mii_address);
 
 	/* Wait until any existing MII operation is complete */
-	return readl_poll_timeout(priv->ioaddr + mii_address, v,
-				  !(v & MII_BUSY), 100, 10000);
+	return stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
 }
 
 /**
-- 
2.47.2


