Return-Path: <netdev+bounces-125222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B972696C53C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1621C25308
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7DC1E4933;
	Wed,  4 Sep 2024 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aEqUixAz"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAFD1E2021;
	Wed,  4 Sep 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470316; cv=none; b=CqtVDV1ghEhuLvNKHcCYwMqFgv6YhWnyyvp7qxhZ93zItba1i6bfq7kzSHifgt8DK6jncmVbC9ayOEb0SolHe/TNREbmlfNm0FZgHqowjZKG8OWdgTX2il8Vb3tidzQ/jWITzhokaU/FEu08iJnm/Rvgf3I4dOjNp8EFOo+j0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470316; c=relaxed/simple;
	bh=8+6qX6qK6w83uAj2rGp3ok/VtBoA8vlkVBAX48imnTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtBnRS0P6DF8sWYHDL7OkG2MBRrXyJkzyqvUIGvDAP+C50+xZ9tyxA1oeLrM1FMnCjpojXjX58Ttce6edsfYeUbQxIUSsBwsl8QvsTg6tzz58sHGwZG0YGs6rAB4jYcCDZwsGnV90Pdjp09fyEubJXcDOWnQxnTpBKrzKeJDT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aEqUixAz; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 486241BF20A;
	Wed,  4 Sep 2024 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725470312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/EiYosKGb5+eECLJXEKS5woXUtS93FVCAzSRCIBrQI=;
	b=aEqUixAzvNeO8VMJTbKYnJg4dlfVGT3bVXJ+F5DEcAHXyQo0t3T5qDFVe2Uqxwmw8hztxb
	aOXYDhz46JLqgeMeFnHFu2bv1uhEm3tBrG0IJKt07rj5cpZZnJHKNCc9qep8zFV1cVjvgi
	LbFjjk3VFeRsB8CveLhVYiFBlwLxzj3Lm0HAlo7BHafezcl5uNxFbHYAgUN2QG797Zwwoz
	5Bqg913hP0zmFaBp5rH7ut/G8TAPXAT+xKMHkP2HEx6mnArEjsV57ZAziOlc/B1a5D2/bM
	NsXD2HQ2f3InUEMXt5Myo3qj+NFMkbnGCRDg45yFfsDq32iUFONueSN1CiO87Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 8/8] net: ethernet: fs_enet: phylink conversion
Date: Wed,  4 Sep 2024 19:18:21 +0200
Message-ID: <20240904171822.64652-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
References: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

fs_enet is a quite old but still used Ethernet driver found on some NXP
devices. It has support for 10/100 Mbps ethernet, with half and full
duplex. Some variants of it can use RMII, while other integrations are
MII-only.

Add phylink support, thus removing custom fixed-link hanldling.

This also allows removing some internal flags such as the use_rmii flag.

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/freescale/fs_enet/Kconfig    |   2 +-
 .../ethernet/freescale/fs_enet/fs_enet-main.c | 215 +++++++++---------
 .../net/ethernet/freescale/fs_enet/fs_enet.h  |  12 +-
 .../net/ethernet/freescale/fs_enet/mac-fcc.c  |  11 +-
 .../net/ethernet/freescale/fs_enet/mac-fec.c  |   9 +-
 .../net/ethernet/freescale/fs_enet/mac-scc.c  |   5 +-
 6 files changed, 132 insertions(+), 122 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/Kconfig b/drivers/net/ethernet/freescale/fs_enet/Kconfig
index 7f20840fde07..57013bf14d7c 100644
--- a/drivers/net/ethernet/freescale/fs_enet/Kconfig
+++ b/drivers/net/ethernet/freescale/fs_enet/Kconfig
@@ -3,7 +3,7 @@ config FS_ENET
 	tristate "Freescale Ethernet Driver"
 	depends on NET_VENDOR_FREESCALE && (CPM1 || CPM2 || PPC_MPC512x)
 	select MII
-	select PHYLIB
+	select PHYLINK
 
 config FS_ENET_MPC5121_FEC
 	def_bool y if (FS_ENET && PPC_MPC512x)
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index ec43b71c0eba..d300b01859a1 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -31,11 +31,13 @@
 #include <linux/fs.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
+#include <linux/phylink.h>
 #include <linux/property.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/pgtable.h>
+#include <linux/rtnetlink.h>
 
 #include <linux/vmalloc.h>
 #include <asm/irq.h>
@@ -68,6 +70,13 @@ static void fs_set_multicast_list(struct net_device *dev)
 	(*fep->ops->set_multicast_list)(dev);
 }
 
+static int fs_eth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	return phylink_mii_ioctl(fep->phylink, ifr, cmd);
+}
+
 static void skb_align(struct sk_buff *skb, int align)
 {
 	int off = ((unsigned long)skb->data) & (align - 1);
@@ -581,15 +590,21 @@ static void fs_timeout_work(struct work_struct *work)
 
 	dev->stats.tx_errors++;
 
-	spin_lock_irqsave(&fep->lock, flags);
+	/* In the event a timeout was detected, but the netdev is brought down
+	 * shortly after, it no longer makes sense to try to recover from the
+	 * timeout. netif_running() will return false when called from the
+	 * .ndo_close() callback. Calling the following recovery code while
+	 * called from .ndo_close() could deadlock on rtnl.
+	 */
+	if (!netif_running(dev))
+		return;
 
-	if (dev->flags & IFF_UP) {
-		phy_stop(dev->phydev);
-		(*fep->ops->stop)(dev);
-		(*fep->ops->restart)(dev);
-	}
+	rtnl_lock();
+	phylink_stop(fep->phylink);
+	phylink_start(fep->phylink);
+	rtnl_unlock();
 
-	phy_start(dev->phydev);
+	spin_lock_irqsave(&fep->lock, flags);
 	wake = fep->tx_free >= MAX_SKB_FRAGS &&
 	       !(CBDR_SC(fep->cur_tx) & BD_ENET_TX_READY);
 	spin_unlock_irqrestore(&fep->lock, flags);
@@ -605,68 +620,37 @@ static void fs_timeout(struct net_device *dev, unsigned int txqueue)
 	schedule_work(&fep->timeout_work);
 }
 
-/* generic link-change handler - should be sufficient for most cases */
-static void fs_adjust_link(struct  net_device *dev)
+static void fs_mac_link_up(struct phylink_config *config,
+			   struct phy_device *phy,
+			   unsigned int mode, phy_interface_t interface,
+			   int speed, int duplex,
+			   bool tx_pause, bool rx_pause)
 {
-	struct fs_enet_private *fep = netdev_priv(dev);
-	struct phy_device *phydev = dev->phydev;
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct fs_enet_private *fep = netdev_priv(ndev);
 	unsigned long flags;
-	int new_state = 0;
-
-	if (phydev->link) {
-		/* adjust to duplex mode */
-		if (phydev->duplex != fep->oldduplex) {
-			new_state = 1;
-			fep->oldduplex = phydev->duplex;
-		}
-
-		if (phydev->speed != fep->oldspeed) {
-			new_state = 1;
-			fep->oldspeed = phydev->speed;
-		}
-
-		if (!fep->oldlink) {
-			new_state = 1;
-			fep->oldlink = 1;
-		}
-
-		if (new_state) {
-			spin_lock_irqsave(&fep->lock, flags);
-			fep->ops->restart(dev);
-			spin_unlock_irqrestore(&fep->lock, flags);
-		}
-	} else if (fep->oldlink) {
-		new_state = 1;
-		fep->oldlink = 0;
-		fep->oldspeed = 0;
-		fep->oldduplex = -1;
-	}
 
-	if (new_state && netif_msg_link(fep))
-		phy_print_status(phydev);
+	spin_lock_irqsave(&fep->lock, flags);
+	fep->ops->restart(ndev, interface, speed, duplex);
+	spin_unlock_irqrestore(&fep->lock, flags);
 }
 
-static int fs_init_phy(struct net_device *dev)
+static void fs_mac_link_down(struct phylink_config *config,
+			     unsigned int mode, phy_interface_t interface)
 {
-	struct fs_enet_private *fep = netdev_priv(dev);
-	struct phy_device *phydev;
-	phy_interface_t iface;
-
-	fep->oldlink = 0;
-	fep->oldspeed = 0;
-	fep->oldduplex = -1;
-
-	iface = fep->fpi->use_rmii ?
-		PHY_INTERFACE_MODE_RMII : PHY_INTERFACE_MODE_MII;
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct fs_enet_private *fep = netdev_priv(ndev);
+	unsigned long flags;
 
-	phydev = of_phy_connect(dev, fep->fpi->phy_node, &fs_adjust_link, 0,
-				iface);
-	if (!phydev) {
-		dev_err(&dev->dev, "Could not attach to PHY\n");
-		return -ENODEV;
-	}
+	spin_lock_irqsave(&fep->lock, flags);
+	fep->ops->stop(ndev);
+	spin_unlock_irqrestore(&fep->lock, flags);
+}
 
-	return 0;
+static void fs_mac_config(struct phylink_config *config, unsigned int mode,
+			  const struct phylink_link_state *state)
+{
+	/* Nothing to do */
 }
 
 static int fs_enet_open(struct net_device *dev)
@@ -691,13 +675,13 @@ static int fs_enet_open(struct net_device *dev)
 		return -EINVAL;
 	}
 
-	err = fs_init_phy(dev);
+	err = phylink_of_phy_connect(fep->phylink, fep->dev->of_node, 0);
 	if (err) {
 		free_irq(fep->interrupt, dev);
 		napi_disable(&fep->napi);
 		return err;
 	}
-	phy_start(dev->phydev);
+	phylink_start(fep->phylink);
 
 	netif_start_queue(dev);
 
@@ -710,19 +694,18 @@ static int fs_enet_close(struct net_device *dev)
 	unsigned long flags;
 
 	netif_stop_queue(dev);
-	netif_carrier_off(dev);
 	napi_disable(&fep->napi);
-	cancel_work_sync(&fep->timeout_work);
-	phy_stop(dev->phydev);
+	cancel_work(&fep->timeout_work);
+	phylink_stop(fep->phylink);
 
 	spin_lock_irqsave(&fep->lock, flags);
 	spin_lock(&fep->tx_lock);
 	(*fep->ops->stop)(dev);
 	spin_unlock(&fep->tx_lock);
 	spin_unlock_irqrestore(&fep->lock, flags);
+	phylink_disconnect_phy(fep->phylink);
 
 	/* release any irqs */
-	phy_disconnect(dev->phydev);
 	free_irq(fep->interrupt, dev);
 
 	return 0;
@@ -810,6 +793,22 @@ static int fs_set_tunable(struct net_device *dev,
 	return ret;
 }
 
+static int fs_ethtool_set_link_ksettings(struct net_device *dev,
+					 const struct ethtool_link_ksettings *cmd)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	return phylink_ethtool_ksettings_set(fep->phylink, cmd);
+}
+
+static int fs_ethtool_get_link_ksettings(struct net_device *dev,
+					 struct ethtool_link_ksettings *cmd)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	return phylink_ethtool_ksettings_get(fep->phylink, cmd);
+}
+
 static const struct ethtool_ops fs_ethtool_ops = {
 	.get_drvinfo = fs_get_drvinfo,
 	.get_regs_len = fs_get_regs_len,
@@ -819,8 +818,8 @@ static const struct ethtool_ops fs_ethtool_ops = {
 	.set_msglevel = fs_set_msglevel,
 	.get_regs = fs_get_regs,
 	.get_ts_info = ethtool_op_get_ts_info,
-	.get_link_ksettings = phy_ethtool_get_link_ksettings,
-	.set_link_ksettings = phy_ethtool_set_link_ksettings,
+	.get_link_ksettings = fs_ethtool_get_link_ksettings,
+	.set_link_ksettings = fs_ethtool_set_link_ksettings,
 	.get_tunable = fs_get_tunable,
 	.set_tunable = fs_set_tunable,
 };
@@ -837,7 +836,7 @@ static const struct net_device_ops fs_enet_netdev_ops = {
 	.ndo_start_xmit		= fs_enet_start_xmit,
 	.ndo_tx_timeout		= fs_timeout,
 	.ndo_set_rx_mode	= fs_set_multicast_list,
-	.ndo_eth_ioctl		= phy_do_ioctl_running,
+	.ndo_eth_ioctl		= fs_eth_ioctl,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= eth_mac_addr,
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -845,14 +844,21 @@ static const struct net_device_ops fs_enet_netdev_ops = {
 #endif
 };
 
+static const struct phylink_mac_ops fs_enet_phylink_mac_ops = {
+	.mac_config = fs_mac_config,
+	.mac_link_down = fs_mac_link_down,
+	.mac_link_up = fs_mac_link_up,
+};
+
 static int fs_enet_probe(struct platform_device *ofdev)
 {
-	int err, privsize, len, ret = -ENODEV;
-	const char *phy_connection_type;
+	int privsize, len, ret = -ENODEV;
 	struct fs_platform_info *fpi;
 	struct fs_enet_private *fep;
+	phy_interface_t phy_mode;
 	const struct fs_ops *ops;
 	struct net_device *ndev;
+	struct phylink *phylink;
 	const u32 *data;
 	struct clk *clk;
 
@@ -872,29 +878,18 @@ static int fs_enet_probe(struct platform_device *ofdev)
 		fpi->cp_command = *data;
 	}
 
+	ret = of_get_phy_mode(ofdev->dev.of_node, &phy_mode);
+	if (ret) {
+		/* For compatibility, if the mode isn't specified in DT,
+		 * assume MII
+		 */
+		phy_mode = PHY_INTERFACE_MODE_MII;
+	}
+
 	fpi->rx_ring = RX_RING_SIZE;
 	fpi->tx_ring = TX_RING_SIZE;
 	fpi->rx_copybreak = 240;
 	fpi->napi_weight = 17;
-	fpi->phy_node = of_parse_phandle(ofdev->dev.of_node, "phy-handle", 0);
-	if (!fpi->phy_node && of_phy_is_fixed_link(ofdev->dev.of_node)) {
-		err = of_phy_register_fixed_link(ofdev->dev.of_node);
-		if (err)
-			goto out_free_fpi;
-
-		/* In the case of a fixed PHY, the DT node associated
-		 * to the PHY is the Ethernet MAC DT node.
-		 */
-		fpi->phy_node = of_node_get(ofdev->dev.of_node);
-	}
-
-	if (of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc5125-fec")) {
-		phy_connection_type = of_get_property(ofdev->dev.of_node,
-						      "phy-connection-type",
-						      NULL);
-		if (phy_connection_type && !strcmp("rmii", phy_connection_type))
-			fpi->use_rmii = 1;
-	}
 
 	/* make clock lookup non-fatal (the driver is shared among platforms),
 	 * but require enable to succeed when a clock was specified/found,
@@ -902,7 +897,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	 */
 	clk = devm_clk_get_enabled(&ofdev->dev, "per");
 	if (IS_ERR(clk))
-		goto out_deregister_fixed_link;
+		goto out_free_fpi;
 
 	privsize = sizeof(*fep) +
 		   sizeof(struct sk_buff **) *
@@ -912,7 +907,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	ndev = alloc_etherdev(privsize);
 	if (!ndev) {
 		ret = -ENOMEM;
-		goto out_deregister_fixed_link;
+		goto out_free_fpi;
 	}
 
 	SET_NETDEV_DEV(ndev, &ofdev->dev);
@@ -924,9 +919,29 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	fep->fpi = fpi;
 	fep->ops = ops;
 
+	fep->phylink_config.dev = &ndev->dev;
+	fep->phylink_config.type = PHYLINK_NETDEV;
+	fep->phylink_config.mac_capabilities = MAC_10 | MAC_100;
+
+	__set_bit(PHY_INTERFACE_MODE_MII,
+		  fep->phylink_config.supported_interfaces);
+
+	if (of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc5125-fec"))
+		__set_bit(PHY_INTERFACE_MODE_RMII,
+			  fep->phylink_config.supported_interfaces);
+
+	phylink = phylink_create(&fep->phylink_config, dev_fwnode(fep->dev),
+				 phy_mode, &fs_enet_phylink_mac_ops);
+	if (IS_ERR(phylink)) {
+		ret = PTR_ERR(phylink);
+		goto out_free_dev;
+	}
+
+	fep->phylink = phylink;
+
 	ret = fep->ops->setup_data(ndev);
 	if (ret)
-		goto out_free_dev;
+		goto out_phylink;
 
 	fep->rx_skbuff = (struct sk_buff **)&fep[1];
 	fep->tx_skbuff = fep->rx_skbuff + fpi->rx_ring;
@@ -956,8 +971,6 @@ static int fs_enet_probe(struct platform_device *ofdev)
 
 	ndev->ethtool_ops = &fs_ethtool_ops;
 
-	netif_carrier_off(ndev);
-
 	ndev->features |= NETIF_F_SG;
 
 	ret = register_netdev(ndev);
@@ -972,12 +985,10 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	fep->ops->free_bd(ndev);
 out_cleanup_data:
 	fep->ops->cleanup_data(ndev);
+out_phylink:
+	phylink_destroy(fep->phylink);
 out_free_dev:
 	free_netdev(ndev);
-out_deregister_fixed_link:
-	of_node_put(fpi->phy_node);
-	if (of_phy_is_fixed_link(ofdev->dev.of_node))
-		of_phy_deregister_fixed_link(ofdev->dev.of_node);
 out_free_fpi:
 	kfree(fpi);
 	return ret;
@@ -993,9 +1004,7 @@ static void fs_enet_remove(struct platform_device *ofdev)
 	fep->ops->free_bd(ndev);
 	fep->ops->cleanup_data(ndev);
 	dev_set_drvdata(fep->dev, NULL);
-	of_node_put(fep->fpi->phy_node);
-	if (of_phy_is_fixed_link(ofdev->dev.of_node))
-		of_phy_deregister_fixed_link(ofdev->dev.of_node);
+	phylink_destroy(fep->phylink);
 	free_netdev(ndev);
 }
 
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
index 6ebb1b4404c7..36e4fcc29e36 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/phy.h>
+#include <linux/phylink.h>
 #include <linux/dma-mapping.h>
 
 #ifdef CONFIG_CPM1
@@ -76,7 +77,8 @@ struct fs_ops {
 	void (*free_bd)(struct net_device *dev);
 	void (*cleanup_data)(struct net_device *dev);
 	void (*set_multicast_list)(struct net_device *dev);
-	void (*restart)(struct net_device *dev);
+	void (*restart)(struct net_device *dev, phy_interface_t interface,
+			int speed, int duplex);
 	void (*stop)(struct net_device *dev);
 	void (*napi_clear_event)(struct net_device *dev);
 	void (*napi_enable)(struct net_device *dev);
@@ -112,13 +114,9 @@ struct fs_platform_info {
 
 	u32 dpram_offset;
 
-	struct device_node *phy_node;
-
 	int rx_ring, tx_ring;	/* number of buffers on rx	*/
 	int rx_copybreak;	/* limit we copy small frames	*/
 	int napi_weight;	/* NAPI weight			*/
-
-	int use_rmii;		/* use RMII mode		*/
 };
 
 struct fs_enet_private {
@@ -143,10 +141,10 @@ struct fs_enet_private {
 	cbd_t __iomem *cur_tx;
 	int tx_free;
 	u32 msg_enable;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 	int interrupt;
 
-	int oldduplex, oldspeed, oldlink;	/* current settings */
-
 	/* event masks */
 	u32 ev_napi;		/* mask of NAPI events */
 	u32 ev;			/* event mask          */
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
index 666a54d6e667..be63293511d9 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
@@ -235,7 +235,8 @@ static void set_multicast_list(struct net_device *dev)
 		set_promiscuous_mode(dev);
 }
 
-static void restart(struct net_device *dev)
+static void restart(struct net_device *dev, phy_interface_t interface,
+		    int speed, int duplex)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
 	const struct fs_platform_info *fpi = fep->fpi;
@@ -359,8 +360,8 @@ static void restart(struct net_device *dev)
 	fs_init_bds(dev);
 
 	/* adjust to speed (for RMII mode) */
-	if (fpi->use_rmii) {
-		if (dev->phydev->speed == SPEED_100)
+	if (interface == PHY_INTERFACE_MODE_RMII) {
+		if (speed == SPEED_100)
 			C8(fcccp, fcc_gfemr, 0x20);
 		else
 			S8(fcccp, fcc_gfemr, 0x20);
@@ -382,11 +383,11 @@ static void restart(struct net_device *dev)
 
 	W32(fccp, fcc_fpsmr, FCC_PSMR_ENCRC);
 
-	if (fpi->use_rmii)
+	if (interface == PHY_INTERFACE_MODE_RMII)
 		S32(fccp, fcc_fpsmr, FCC_PSMR_RMII);
 
 	/* adjust to duplex mode */
-	if (dev->phydev->duplex == DUPLEX_FULL)
+	if (duplex == DUPLEX_FULL)
 		S32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
 	else
 		C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index c1b7877178b9..f2ecd20027cf 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -220,7 +220,8 @@ static void set_multicast_list(struct net_device *dev)
 		set_promiscuous_mode(dev);
 }
 
-static void restart(struct net_device *dev)
+static void restart(struct net_device *dev, phy_interface_t interface,
+		    int speed, int duplex)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
 	struct fec __iomem *fecp = fep->fec.fecp;
@@ -302,13 +303,13 @@ static void restart(struct net_device *dev)
 	 * Only set MII/RMII mode - do not touch maximum frame length
 	 * configured before.
 	 */
-	FS(fecp, r_cntrl, fpi->use_rmii ?
-			FEC_RCNTRL_RMII_MODE : FEC_RCNTRL_MII_MODE);
+	FS(fecp, r_cntrl, interface == PHY_INTERFACE_MODE_RMII ?
+			  FEC_RCNTRL_RMII_MODE : FEC_RCNTRL_MII_MODE);
 #endif
 	/*
 	 * adjust to duplex mode
 	 */
-	if (dev->phydev->duplex == DUPLEX_FULL) {
+	if (duplex == DUPLEX_FULL) {
 		FC(fecp, r_cntrl, FEC_RCNTRL_DRT);
 		FS(fecp, x_cntrl, FEC_TCNTRL_FDEN);	/* FD enable */
 	} else {
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
index d061092ced6c..6c97191649de 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
@@ -226,7 +226,8 @@ static void set_multicast_list(struct net_device *dev)
  * change.  This only happens when switching between half and full
  * duplex.
  */
-static void restart(struct net_device *dev)
+static void restart(struct net_device *dev, phy_interface_t interface,
+		    int speed, int duplex)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
 	scc_t __iomem *sccp = fep->scc.sccp;
@@ -337,7 +338,7 @@ static void restart(struct net_device *dev)
 	W16(sccp, scc_psmr, SCC_PSMR_ENCRC | SCC_PSMR_NIB22);
 
 	/* Set full duplex mode if needed */
-	if (dev->phydev->duplex == DUPLEX_FULL)
+	if (duplex == DUPLEX_FULL)
 		S16(sccp, scc_psmr, SCC_PSMR_LPB | SCC_PSMR_FDE);
 
 	/* Restore multicast and promiscuous settings */
-- 
2.46.0


