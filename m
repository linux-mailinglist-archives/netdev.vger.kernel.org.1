Return-Path: <netdev+bounces-219565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE8B41F65
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D347ABAB2
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6B92FF65B;
	Wed,  3 Sep 2025 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y0XEPdK5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0E62FF654
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903194; cv=none; b=GoxjXxY+9c/b2EaxIklKhTGyAL6T23GYR3kxGzrx1EYFIl4MR++dHxh+0yMS4VBqsguHOjgGuYvDmDvSXRW4U/Y5WthfhofDdNRD1YZKdZLNOlh3iVgF0KlLM7QIHvhIQ0a1kdDov96DO7RgC9EUY5eG76WPqO9uyV2T7T4zt8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903194; c=relaxed/simple;
	bh=QRhi/QdRzRshnMyood0tQtFEZ9iMz9f+xDmav23EfE4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=c7XGF3MXCrtv/PD6MPho9mJ43vaGo2DU2eoNjsAt3YvvuPTFwnsZVtirSyhi4qhvuFT/W41G7N2quxP0IDKmlGunpgRCUXSz4Ut4sPDHfubcZKky1XztVpGdI8ydHKEDdSWnVWsKfHmC4GwQuCKsRTJzz54LiruuBZI9gFLKZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Y0XEPdK5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a1ebKDo9aSBHHibW6Zw6iWwBcU+APekEZ4/kod4pzVE=; b=Y0XEPdK55mZWRPV3+3ZcTQ5tqC
	McyCyAyUCyDWvFS4XKagZ+194cm4ZBaqv8OfvL9s2rfHVaTguPNYjhYuvED4TqCfPlvh5G8u/Bh8J
	l3zCHuBQ5Rmg7sgUhv9YTQG1R0L9fYUTbPIx/2QAfpbFYW10iAOufCUlW4A/rmm6I8ykI1rFQzb2m
	DOlO9Ehe6BjunYA1tmCwjzVWVNcf34EuYMyUJKj1OV1OEtRAn+Oz/VukBNLnbLzBkLGs1ks8VgFn4
	rATLjFQyPG51B5zEe7GppLiZ1HkWboHvkkLk3H2M0b4wSvr41LtG7XyN2/YLY8GZEjcMfFaavpdKJ
	WaoGcx3Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36462 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1utmm9-000000000W8-226m;
	Wed, 03 Sep 2025 13:39:45 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1utmm8-00000001s0U-2VYX;
	Wed, 03 Sep 2025 13:39:44 +0100
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
Subject: [PATCH net-next 06/11] net: stmmac: mdio: move runtime PM into
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
Message-Id: <E1utmm8-00000001s0U-2VYX@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Sep 2025 13:39:44 +0100

Move the runtime PM handling into the common stmmac_mdio_access()
function, rather than having it in the four top-level bus access
functions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 71 ++++++-------------
 1 file changed, 20 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 62e74467de49..2d6a5d40e2c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -246,9 +246,13 @@ static int stmmac_mdio_access(struct stmmac_priv *priv, unsigned int pa,
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
 
@@ -257,10 +261,15 @@ static int stmmac_mdio_access(struct stmmac_priv *priv, unsigned int pa,
 
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
@@ -288,23 +297,14 @@ static int stmmac_mdio_write(struct stmmac_priv *priv, unsigned int pa,
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
@@ -322,22 +322,10 @@ static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
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
@@ -352,23 +340,14 @@ static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
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
@@ -384,22 +363,12 @@ static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
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


