Return-Path: <netdev+bounces-219922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 984EFB43B34
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C39685F7F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156B52D8777;
	Thu,  4 Sep 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kpy0H3PW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C02C21F9
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987896; cv=none; b=PqxtjRAgC8TFuGRQp2pJ9yVTPnfRVAceYmxqMxYwPCO57N3WvzbU0OvEWZoLyzJWD/gDu/YkoUwOhQ3uDkBQka6rH6HihdFK6Cj9ia5s9rHz2QJbNbTG4YIACAwSq/Wo+r4ZUclFH4In0IQt9/O+T9JUEDKtqvsPnm0xGKjdas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987896; c=relaxed/simple;
	bh=EoX4tyfTix0OyIsPNYKmy5ccXxOojl/3WQE83niRqBc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=nrVHtX/NWjYkbj2uU/Ejw4Il++hqP9nksi8M35fpq/82o4cTMQcMeBB4U7GMJPoK5mKwS5XqiMz7L7Qis1mQNLhHeC9u4dRkFYNKP28X6KdBdvrDe1lBGnbwUSdhEMGBEOa5lGQnpJrFF52AFLdsZ7oZd04s1qFF2IQRwoZxdGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Kpy0H3PW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fSVSPrih3MzHiW4irYSyioG1xeCu7b4RyBIot2dvKWc=; b=Kpy0H3PWnemy4ECY3h8c5nQEHO
	fEyyptf7BpHvGJiBMULTwlaSY3tsqxwe0zzvmWVSNYuxK5m/7P4guIJsEIbMpvPxMDJ6mfJ+jQco7
	oZVLuz8VeSDsdcPfJlKzT6HMVRNzHRvTDNDVae2CPKfRjwg1iQOVI1d2Ipvi1vRyMowLdHPoPR3B+
	VPQZdmx0tXvQDKoJtQ3QTF22oKNNek8GOGZHKkUeNJgYleE55ampeUEqHSn661COj10AMbSFnFIIw
	VOOwjFv3KIlYao5kp2/G/bL5Zn8O16e/aqFIxPV7VDYVpvv9S1wSFBq9XIVRwddrRrJ9yW+PFqIBF
	xaujJRuA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36328 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uu8oI-000000001yN-1nSG;
	Thu, 04 Sep 2025 13:11:26 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uu8oH-00000001voy-2jfU;
	Thu, 04 Sep 2025 13:11:25 +0100
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
Subject: [PATCH net-next v2 06/11] net: stmmac: mdio: move runtime PM into
 stmmac_mdio_access()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uu8oH-00000001voy-2jfU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 04 Sep 2025 13:11:25 +0100

Move the runtime PM handling into the common stmmac_mdio_access()
function, rather than having it in the four top-level bus access
functions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 71 ++++++-------------
 1 file changed, 20 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 4e2eb206a234..c95e9799273f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -248,9 +248,13 @@ static int stmmac_mdio_access(struct stmmac_priv *priv, unsigned int pa,
 	u32 addr;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(priv->device);
+	if (ret < 0)
+		return ret;
+
 	ret = stmmac_mdio_wait(mii_address, MII_BUSY);
 	if (ret)
-		return ret;
+		goto out;
 
 	addr = stmmac_mdio_format_addr(priv, pa, gr) | cmd;
 
@@ -259,10 +263,15 @@ static int stmmac_mdio_access(struct stmmac_priv *priv, unsigned int pa,
 
 	ret = stmmac_mdio_wait(mii_address, MII_BUSY);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* Read the data from the MII data register if in read mode */
-	return read ? readl(mii_data) & MII_DATA_MASK : 0;
+	ret = read ? readl(mii_data) & MII_DATA_MASK : 0;
+
+out:
+	pm_runtime_put(priv->device);
+
+	return ret;
 }
 
 static int stmmac_mdio_read(struct stmmac_priv *priv, unsigned int pa,
@@ -290,23 +299,14 @@ static int stmmac_mdio_write(struct stmmac_priv *priv, unsigned int pa,
 static int stmmac_mdio_read_c22(struct mii_bus *bus, int phyaddr, int phyreg)
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
-	int data = 0;
 	u32 cmd;
 
-	data = pm_runtime_resume_and_get(priv->device);
-	if (data < 0)
-		return data;
-
 	if (priv->plat->has_gmac4)
 		cmd = MII_GMAC4_READ;
 	else
 		cmd = 0;
 
-	data = stmmac_mdio_read(priv, phyaddr, phyreg, cmd, data);
-
-	pm_runtime_put(priv->device);
-
-	return data;
+	return stmmac_mdio_read(priv, phyaddr, phyreg, cmd, 0);
 }
 
 /**
@@ -324,22 +324,10 @@ static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
 				int phyreg)
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
-	int data = 0;
-	u32 cmd;
-
-	data = pm_runtime_resume_and_get(priv->device);
-	if (data < 0)
-		return data;
-
-	cmd = MII_GMAC4_READ | MII_GMAC4_C45E;
-
-	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
-
-	data = stmmac_mdio_read(priv, phyaddr, devad, cmd, data);
+	int data = phyreg << MII_GMAC4_REG_ADDR_SHIFT;
+	u32 cmd = MII_GMAC4_READ | MII_GMAC4_C45E;
 
-	pm_runtime_put(priv->device);
-
-	return data;
+	return stmmac_mdio_read(priv, phyaddr, devad, cmd, data);
 }
 
 /**
@@ -354,23 +342,14 @@ static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
 				 u16 phydata)
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
-	int ret, data = phydata;
 	u32 cmd;
 
-	ret = pm_runtime_resume_and_get(priv->device);
-	if (ret < 0)
-		return ret;
-
 	if (priv->plat->has_gmac4)
 		cmd = MII_GMAC4_WRITE;
 	else
 		cmd = MII_WRITE;
 
-	ret = stmmac_mdio_write(priv, phyaddr, phyreg, cmd, data);
-
-	pm_runtime_put(priv->device);
-
-	return ret;
+	return stmmac_mdio_write(priv, phyaddr, phyreg, cmd, phydata);
 }
 
 /**
@@ -386,22 +365,12 @@ static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 				 int devad, int phyreg, u16 phydata)
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
-	int ret, data = phydata;
-	u32 cmd;
-
-	ret = pm_runtime_resume_and_get(priv->device);
-	if (ret < 0)
-		return ret;
-
-	cmd = MII_GMAC4_WRITE | MII_GMAC4_C45E;
+	u32 cmd = MII_GMAC4_WRITE | MII_GMAC4_C45E;
+	int data = phydata;
 
 	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
 
-	ret = stmmac_mdio_write(priv, phyaddr, devad, cmd, data);
-
-	pm_runtime_put(priv->device);
-
-	return ret;
+	return stmmac_mdio_write(priv, phyaddr, devad, cmd, data);
 }
 
 /**
-- 
2.47.2


