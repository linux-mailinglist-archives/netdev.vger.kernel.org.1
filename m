Return-Path: <netdev+bounces-217228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E956B37E05
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDFA1BA3FDB
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEAA304BA2;
	Wed, 27 Aug 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HnZW6N+j"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770233CE96
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284118; cv=none; b=b99Rn61tjREIvMnRHUcfY0GJOTR/dqxMkTfWk4Ye42hVKAOlXA/y5qI99GHBIcjNA4vbEZfL0nSjAKrxhDCVTyK3lQwjr9xWNUbGDBVpNwVg/COZPunOwvydir4EeNpb2NO6gETt3SzWFEd8Aj2oDwnAxkHxn8F2ZTjNZdUBpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284118; c=relaxed/simple;
	bh=Ri9rru1M9R/pFJJCjN/xTLbaXcxkAnVKXxuPYdQ4cps=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=mdLyUuDgtgqBI4UZ4+lq35ZN7dpLyIrB9xEFtRhbVQ9J69lx/N0KB1dF9Pq4MDykH4ySsM3WqzRDG9QBShMpQEdPs7JJUKuGcd0RbYjXnWtk4ZNB2u1OUwXYtlk49Bz1tEPXl0gH18MJLTkhYMK3rAkyOOxG9/3c4fnVMhO8lPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HnZW6N+j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RPRQY28nN74Kh95BFEt+ohvgl/j08Tf0hPpDTXYE12g=; b=HnZW6N+jpf3sOHGmvI2bA9wWHY
	Umws2c6dlonhdUQTelLzaFqCle4wIFR2/2y1InSx6mPaeVMKWZiuqBY5PM3tspQnWthiN8P5ukdSo
	oq42TC5OGjWwEJTugcBRfdncmOfVtoXctf2ZI9WFZHhWtkyl4WMA3yfJ1OrHQ6ZYsM0G6XJ/pG4/7
	AqZwvNW5TVmq1gJi1M2HWryE0lys2VHLorvU0lgi952fxqImPHxezA3IsllbivU14dOFAZA9UuaOq
	9pGIN75GwkMliRz5raVNb0vfPCMH2uUtO2aQDl0YO7HZDKpkqaisAvVtj3ocN2gEeJlWikgKflA7b
	zo0x9Tog==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49906 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1urBj2-000000000Es-3pdZ;
	Wed, 27 Aug 2025 09:41:48 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1urBj2-000000002as-0pod;
	Wed, 27 Aug 2025 09:41:48 +0100
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
Subject: [PATCH net-next] net: stmmac: mdio: use netdev_priv() directly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1urBj2-000000002as-0pod@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 27 Aug 2025 09:41:48 +0100

netdev_priv() is an inline function, taking a struct net_device
pointer. When passing in the MII bus->priv, which is a void pointer,
there is no need to go via a local ndev variable to type it first.

Thus, instead of:

	struct net_device *ndev = bus->priv;
	struct stmmac_priv *priv;
...
	priv = netdev_priv(ndev);

we can simply do:

	struct stmmac_priv *priv = netdev_priv(bus->priv);

which simplifies the code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 38 +++++--------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 836f2848dfeb..86021e6b67b2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -131,12 +131,9 @@ static int stmmac_xgmac2_mdio_read(struct stmmac_priv *priv, u32 addr,
 static int stmmac_xgmac2_mdio_read_c22(struct mii_bus *bus, int phyaddr,
 				       int phyreg)
 {
-	struct net_device *ndev = bus->priv;
-	struct stmmac_priv *priv;
+	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
-	priv = netdev_priv(ndev);
-
 	/* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
 	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
 	    phyaddr > MII_XGMAC_MAX_C22ADDR)
@@ -150,12 +147,9 @@ static int stmmac_xgmac2_mdio_read_c22(struct mii_bus *bus, int phyaddr,
 static int stmmac_xgmac2_mdio_read_c45(struct mii_bus *bus, int phyaddr,
 				       int devad, int phyreg)
 {
-	struct net_device *ndev = bus->priv;
-	struct stmmac_priv *priv;
+	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
-	priv = netdev_priv(ndev);
-
 	stmmac_xgmac2_c45_format(priv, phyaddr, devad, phyreg, &addr);
 
 	return stmmac_xgmac2_mdio_read(priv, addr, MII_XGMAC_BUSY);
@@ -209,12 +203,9 @@ static int stmmac_xgmac2_mdio_write(struct stmmac_priv *priv, u32 addr,
 static int stmmac_xgmac2_mdio_write_c22(struct mii_bus *bus, int phyaddr,
 					int phyreg, u16 phydata)
 {
-	struct net_device *ndev = bus->priv;
-	struct stmmac_priv *priv;
+	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
-	priv = netdev_priv(ndev);
-
 	/* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
 	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
 	    phyaddr > MII_XGMAC_MAX_C22ADDR)
@@ -229,12 +220,9 @@ static int stmmac_xgmac2_mdio_write_c22(struct mii_bus *bus, int phyaddr,
 static int stmmac_xgmac2_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 					int devad, int phyreg, u16 phydata)
 {
-	struct net_device *ndev = bus->priv;
-	struct stmmac_priv *priv;
+	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
-	priv = netdev_priv(ndev);
-
 	stmmac_xgmac2_c45_format(priv, phyaddr, devad, phyreg, &addr);
 
 	return stmmac_xgmac2_mdio_write(priv, addr, MII_XGMAC_BUSY,
@@ -274,8 +262,7 @@ static int stmmac_mdio_read(struct stmmac_priv *priv, int data, u32 value)
  */
 static int stmmac_mdio_read_c22(struct mii_bus *bus, int phyaddr, int phyreg)
 {
-	struct net_device *ndev = bus->priv;
-	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 value = MII_BUSY;
 	int data = 0;
 
@@ -312,8 +299,7 @@ static int stmmac_mdio_read_c22(struct mii_bus *bus, int phyaddr, int phyreg)
 static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
 				int phyreg)
 {
-	struct net_device *ndev = bus->priv;
-	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 value = MII_BUSY;
 	int data = 0;
 
@@ -373,8 +359,7 @@ static int stmmac_mdio_write(struct stmmac_priv *priv, int data, u32 value)
 static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
 				 u16 phydata)
 {
-	struct net_device *ndev = bus->priv;
-	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int ret, data = phydata;
 	u32 value = MII_BUSY;
 
@@ -412,8 +397,7 @@ static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
 static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 				 int devad, int phyreg, u16 phydata)
 {
-	struct net_device *ndev = bus->priv;
-	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int ret, data = phydata;
 	u32 value = MII_BUSY;
 
@@ -452,8 +436,7 @@ static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 int stmmac_mdio_reset(struct mii_bus *bus)
 {
 #if IS_ENABLED(CONFIG_STMMAC_PLATFORM)
-	struct net_device *ndev = bus->priv;
-	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	unsigned int mii_address = priv->hw->mii.addr;
 
 #ifdef CONFIG_OF
@@ -497,12 +480,11 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 
 int stmmac_pcs_setup(struct net_device *ndev)
 {
+	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct fwnode_handle *devnode, *pcsnode;
 	struct dw_xpcs *xpcs = NULL;
-	struct stmmac_priv *priv;
 	int addr, ret;
 
-	priv = netdev_priv(ndev);
 	devnode = priv->plat->port_node;
 
 	if (priv->plat->pcs_init) {
-- 
2.47.2


