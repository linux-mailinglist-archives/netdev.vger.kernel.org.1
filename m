Return-Path: <netdev+bounces-130948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC6198C23C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BB81F260AA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA841CBEB3;
	Tue,  1 Oct 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SH5pJxuT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110A1CBE9A
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798708; cv=none; b=Gb7JOEwGREiZHQvKfn2KPic6dkOW3wrf/IDWzGBfGCtOO3cabtinuzyWy10RuFIW9EplrEhi182LPiA+LgLB/3g48pzYKjBqkdpcFMOTmvnktNhx4pe5IZ1sj1KfRcFOm06UGSQRJaO4PZ6Xz40NGmgQYcnzSZ9R7g7m1wDBK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798708; c=relaxed/simple;
	bh=0SmsRNqRwTdxeuX7ZfwmaUGHySZ3c14DzcWocv/bk4M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=HTS/RVROZtbew9iVZWNxP6paEXUADp81Ta0qDGqbeYIiUSPCvnV5+ZYqoYrIbP3U+AuljbGx4RA30trlpwlgvZIgc4wPwmxQZYUYBabiP1cstZmOVrzKLBp7vBphmWkmqP67y4DJAT84iQViEs9tRQemBg4aa2ghwLGI7RS07jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SH5pJxuT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=USZAL/oaPLtmmiM9wqLlNaAV3H5YLAqhUh5YPfb65RU=; b=SH5pJxuTFmAdgbfYhQ+QiQGKwx
	JrVBqPSB2IZ+wrewGf6Mii3qvN2wVpxPfXKQDQi7Fqs6ZoYNun21ELJk6u0RytnzjBKD9vKs5pQxe
	2JWR3DHZ60byGHu+UZOfGTn0fkqHEQoa78lG3fVSlViqlvXuUhI0U8m8PTWXRDGtytp3sGg9bvfpB
	YiFJbUeIBavYkvDhdrQg/yyIdIBHBz07nXLKiFKuwBcg83EwNO932khU0iIBzA6nLZcDOOS/U6ypz
	TogELVGXUkw1rp7XVGC1rcctut2sjqvjlPSUpJjn2bvAeWIPCgB3pQQeHsmlJ7vyrhWCg982kFkF7
	8q0WS9+w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49166 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1svfMr-00067O-2I;
	Tue, 01 Oct 2024 17:04:53 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1svfMp-005ZIp-UX; Tue, 01 Oct 2024 17:04:51 +0100
In-Reply-To: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 09/10] net: pcs: xpcs: drop interface argument from
 xpcs_create*()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1svfMp-005ZIp-UX@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 01 Oct 2024 17:04:51 +0100

The XPCS sub-driver no longer uses the "interface" argument to the
xpcs_create_mdiodev() and xpcs_create_fwnode() functions. Remove
this now unnecessary argument, updating the stmmac driver
appropriately.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  7 +++----
 drivers/net/pcs/pcs-xpcs.c                        | 10 +++-------
 include/linux/pcs/pcs-xpcs.h                      |  6 ++----
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 03f90676b3ad..0c7d81ddd440 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -500,23 +500,22 @@ int stmmac_pcs_setup(struct net_device *ndev)
 	struct fwnode_handle *devnode, *pcsnode;
 	struct dw_xpcs *xpcs = NULL;
 	struct stmmac_priv *priv;
-	int addr, mode, ret;
+	int addr, ret;
 
 	priv = netdev_priv(ndev);
-	mode = priv->plat->phy_interface;
 	devnode = priv->plat->port_node;
 
 	if (priv->plat->pcs_init) {
 		ret = priv->plat->pcs_init(priv);
 	} else if (fwnode_property_present(devnode, "pcs-handle")) {
 		pcsnode = fwnode_find_reference(devnode, "pcs-handle", 0);
-		xpcs = xpcs_create_fwnode(pcsnode, mode);
+		xpcs = xpcs_create_fwnode(pcsnode);
 		fwnode_handle_put(pcsnode);
 		ret = PTR_ERR_OR_ZERO(xpcs);
 	} else if (priv->plat->mdio_bus_data &&
 		   priv->plat->mdio_bus_data->pcs_mask) {
 		addr = ffs(priv->plat->mdio_bus_data->pcs_mask) - 1;
-		xpcs = xpcs_create_mdiodev(priv->mii, addr, mode);
+		xpcs = xpcs_create_mdiodev(priv->mii, addr);
 		ret = PTR_ERR_OR_ZERO(xpcs);
 	} else {
 		return 0;
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 9b61f97222b9..f25e7afdfdf5 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1520,14 +1520,12 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
  * xpcs_create_mdiodev() - create a DW xPCS instance with the MDIO @addr
  * @bus: pointer to the MDIO-bus descriptor for the device to be looked at
  * @addr: device MDIO-bus ID
- * @interface: requested PHY interface
  *
  * Return: a pointer to the DW XPCS handle if successful, otherwise -ENODEV if
  * the PCS device couldn't be found on the bus and other negative errno related
  * to the data allocation and MDIO-bus communications.
  */
-struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
-				    phy_interface_t interface)
+struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr)
 {
 	struct mdio_device *mdiodev;
 	struct dw_xpcs *xpcs;
@@ -1554,7 +1552,7 @@ struct phylink_pcs *xpcs_create_pcs_mdiodev(struct mii_bus *bus, int addr)
 {
 	struct dw_xpcs *xpcs;
 
-	xpcs = xpcs_create_mdiodev(bus, addr, PHY_INTERFACE_MODE_NA);
+	xpcs = xpcs_create_mdiodev(bus, addr);
 	if (IS_ERR(xpcs))
 		return ERR_CAST(xpcs);
 
@@ -1565,7 +1563,6 @@ EXPORT_SYMBOL_GPL(xpcs_create_pcs_mdiodev);
 /**
  * xpcs_create_fwnode() - Create a DW xPCS instance from @fwnode
  * @fwnode: fwnode handle poining to the DW XPCS device
- * @interface: requested PHY interface
  *
  * Return: a pointer to the DW XPCS handle if successful, otherwise -ENODEV if
  * the fwnode device is unavailable or the PCS device couldn't be found on the
@@ -1573,8 +1570,7 @@ EXPORT_SYMBOL_GPL(xpcs_create_pcs_mdiodev);
  * other negative errno related to the data allocations and MDIO-bus
  * communications.
  */
-struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode,
-				   phy_interface_t interface)
+struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode)
 {
 	struct mdio_device *mdiodev;
 	struct dw_xpcs *xpcs;
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index a4e2243ce647..758daabb76c7 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -72,10 +72,8 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces);
 int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
 		    int enable);
-struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
-				    phy_interface_t interface);
-struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode,
-				   phy_interface_t interface);
+struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr);
+struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode);
 void xpcs_destroy(struct dw_xpcs *xpcs);
 
 struct phylink_pcs *xpcs_create_pcs_mdiodev(struct mii_bus *bus, int addr);
-- 
2.30.2


