Return-Path: <netdev+bounces-219920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EA7B43B2D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56A55E7C1E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244052D46CB;
	Thu,  4 Sep 2025 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cI4WnIjd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EFF2C325F
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987885; cv=none; b=gHvA9lHLv0MlV4/hr3Dx2ZWOp9Qoi/AtJ6YjuFJE9PZ93VZuxs/lsWMdpzNs6mw0KFPE5FGy+GdOfvmCrHoll/hgQktgeyLDdqETJbkqWpaDOSQ4UaIyR8ndNDU5qrtdjttdltSItpMSWwE4DSvVmiicD1d01QHgElfwTJ0flIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987885; c=relaxed/simple;
	bh=Y4B+jk/oyyhVNTmecIe4aSJ1TKUqWoHREU5a6AB1hos=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=fFP5SGpONpSX8OKSoOwZ1hD+KfoWVHJ8x7hL82AG5ubAzRaMMea9Q0ToBuO/vgrOvMCePn9BvL7fhuhRIavJP9yQYji0mzumnuTs6f3VlwFLdoI1EM5su2U8faSFtItbaJMVP17C2ktIpRR4UJki6F0IDoK9hMRFKhX3xsZJsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cI4WnIjd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EeFJMgclvS4xrirX5nKqAdmYYnelMX93rWhM5Ad0/oQ=; b=cI4WnIjdBevGI4RvPmF3Nwk9DB
	+s1iZvD22zU/96xmrZ/hwhu6oRLp6K5NCorwuOSeSukufeBNENEGscu2ovltjFUb49v7DCgYKxlWL
	iV4o8AWEGXePGxB7NQlhpSm0U3CRjmR1fT8T2NCsLBp5vJXkVeZ41a8Ty543ACmqikg7LU+DWGQxB
	m4NsEgLSz3of47aiHBRuMpsB5vuNVmQD+mx0ZkSQYqTd6vU8pZPjJUficOsjA+GlQyW6tY2K3J/4Q
	3jYSP9Z0ji3tyU9mLlp5Tri4iZl0eJEPUETY5xdnPwbhH8kVCyBckNDPu7o6OyPI2gO1hr4Ec2/xY
	N34ZA4ZQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36098 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uu8o8-000000001xp-1KwK;
	Thu, 04 Sep 2025 13:11:16 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uu8o7-00000001vom-1pN8;
	Thu, 04 Sep 2025 13:11:15 +0100
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
Subject: [PATCH net-next v2 04/11] net: stmmac: mdio: move
 stmmac_mdio_format_addr() into read/write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uu8o7-00000001vom-1pN8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 04 Sep 2025 13:11:15 +0100

Move stmmac_mdio_format_addr() into stmmac_mdio_read() and
stmmac_mdio_write().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 46 ++++++++++---------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 4294262c208d..d588475b4279 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -240,16 +240,20 @@ static u32 stmmac_mdio_format_addr(struct stmmac_priv *priv,
 	       MII_BUSY;
 }
 
-static int stmmac_mdio_read(struct stmmac_priv *priv, int data, u32 value)
+static int stmmac_mdio_read(struct stmmac_priv *priv, unsigned int pa,
+			    unsigned int gr, u32 cmd, int data)
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
+	u32 value;
 	int ret;
 
 	ret = stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
 	if (ret)
 		return ret;
 
+	value = stmmac_mdio_format_addr(priv, pa, gr) | cmd;
+
 	writel(data, priv->ioaddr + mii_data);
 	writel(value, priv->ioaddr + mii_address);
 
@@ -275,17 +279,18 @@ static int stmmac_mdio_read_c22(struct mii_bus *bus, int phyaddr, int phyreg)
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int data = 0;
-	u32 value;
+	u32 cmd;
 
 	data = pm_runtime_resume_and_get(priv->device);
 	if (data < 0)
 		return data;
 
-	value = stmmac_mdio_format_addr(priv, phyaddr, phyreg);
 	if (priv->plat->has_gmac4)
-		value |= MII_GMAC4_READ;
+		cmd = MII_GMAC4_READ;
+	else
+		cmd = 0;
 
-	data = stmmac_mdio_read(priv, data, value);
+	data = stmmac_mdio_read(priv, phyaddr, phyreg, cmd, data);
 
 	pm_runtime_put(priv->device);
 
@@ -308,29 +313,29 @@ static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int data = 0;
-	u32 value;
+	u32 cmd;
 
 	data = pm_runtime_resume_and_get(priv->device);
 	if (data < 0)
 		return data;
 
-	value = stmmac_mdio_format_addr(priv, phyaddr, devad);
-	value |= MII_GMAC4_READ;
-	value |= MII_GMAC4_C45E;
+	cmd = MII_GMAC4_READ | MII_GMAC4_C45E;
 
 	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
 
-	data = stmmac_mdio_read(priv, data, value);
+	data = stmmac_mdio_read(priv, phyaddr, devad, cmd, data);
 
 	pm_runtime_put(priv->device);
 
 	return data;
 }
 
-static int stmmac_mdio_write(struct stmmac_priv *priv, int data, u32 value)
+static int stmmac_mdio_write(struct stmmac_priv *priv, unsigned int pa,
+			     unsigned int gr, u32 cmd, int data)
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
+	u32 value;
 	int ret;
 
 	/* Wait until any existing MII operation is complete */
@@ -338,6 +343,8 @@ static int stmmac_mdio_write(struct stmmac_priv *priv, int data, u32 value)
 	if (ret)
 		return ret;
 
+	value = stmmac_mdio_format_addr(priv, pa, gr) | cmd;
+
 	/* Set the MII address register to write */
 	writel(data, priv->ioaddr + mii_data);
 	writel(value, priv->ioaddr + mii_address);
@@ -359,19 +366,18 @@ static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int ret, data = phydata;
-	u32 value;
+	u32 cmd;
 
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
 
-	value = stmmac_mdio_format_addr(priv, phyaddr, phyreg);
 	if (priv->plat->has_gmac4)
-		value |= MII_GMAC4_WRITE;
+		cmd = MII_GMAC4_WRITE;
 	else
-		value |= MII_WRITE;
+		cmd = MII_WRITE;
 
-	ret = stmmac_mdio_write(priv, data, value);
+	ret = stmmac_mdio_write(priv, phyaddr, phyreg, cmd, data);
 
 	pm_runtime_put(priv->device);
 
@@ -392,19 +398,17 @@ static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int ret, data = phydata;
-	u32 value;
+	u32 cmd;
 
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
 
-	value = stmmac_mdio_format_addr(priv, phyaddr, devad);
-	value |= MII_GMAC4_WRITE;
-	value |= MII_GMAC4_C45E;
+	cmd = MII_GMAC4_WRITE | MII_GMAC4_C45E;
 
 	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
 
-	ret = stmmac_mdio_write(priv, data, value);
+	ret = stmmac_mdio_write(priv, phyaddr, devad, cmd, data);
 
 	pm_runtime_put(priv->device);
 
-- 
2.47.2


