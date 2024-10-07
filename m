Return-Path: <netdev+bounces-132735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2950992EC9
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9B61C2350C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DA21D7E58;
	Mon,  7 Oct 2024 14:17:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8F1D414C
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310653; cv=none; b=PNgrV1z/syJkn44ZBbxCAQtL3+lZ+l6q38PAhXEP60EIpLark8jbiTZ7TCzuF425PHJg9O/+GMIN2Rj0DW1T8GDrypt5k2hcXVhFDzelxhBErUBaKN7PTR7D6nPNqCvzy9OW9WwVGb5l6i/ZTrubSvilirg6+4eyduWXivGec9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310653; c=relaxed/simple;
	bh=sZkmrTYr8EVyASnS0JbfcOEzrJeJOvpqLS/GrMmDYJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzsCWYR3SycpGS9Y0r6gRavPBCV3ElBJFTxbjEp4w26RuQon6iIRmB+zxLb7BNBn9QsYaZKGGztS5CJenPId+z9JzPIG9rXkpH1RqzwK23hubkc7rEq3zEj2hhAs8fs8ZP4QbUxhDki54xk+34QT9kOSdlLig2ry9KbG6Obz034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1sxoY4-0008LN-Uu; Mon, 07 Oct 2024 16:17:20 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 07 Oct 2024 16:17:12 +0200
Subject: [PATCH 2/2] net: dpaa: use __dev_mc_sync in dpaa_set_rx_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-igmp-speedup-v1-2-6c0a387890a5@pengutronix.de>
References: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
In-Reply-To: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Madalin Bucur <madalin.bucur@nxp.com>, 
 Sean Anderson <sean.anderson@seco.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The original driver first unregisters then re-registers all multicast
addresses in the struct net_device_ops::ndo_set_rx_mode() callback.

As the networking stack calls ndo_set_rx_mode() if a single multicast
address change occurs, a significant amount of time may be used to first
unregister and then re-register unchanged multicast addresses. This
leads to performance issues when tracking large numbers of multicast
addresses.

Replace the unregister and register loop and the hand crafted
mc_addr_list list handling with __dev_mc_sync(), to only update entries
which have changed.

On profiling with an fsl_dpa NIC, this patch presented a speedup of
around 40 when successively setting up 2000 multicast groups using
setsockopt(), without drawbacks on smaller numbers of multicast groups.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   | 20 +++++++++--
 drivers/net/ethernet/freescale/fman/fman_dtsec.c |  1 -
 drivers/net/ethernet/freescale/fman/fman_memac.c |  1 -
 drivers/net/ethernet/freescale/fman/fman_tgec.c  |  1 -
 drivers/net/ethernet/freescale/fman/mac.c        | 42 ------------------------
 drivers/net/ethernet/freescale/fman/mac.h        |  2 --
 6 files changed, 18 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 6b9b6d72db98c22b9c104833b3c8c675931fd1aa..ac06b01fe93401b0416cd6a654bac2cb40ce12aa 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -463,6 +463,22 @@ static int dpaa_set_mac_address(struct net_device *net_dev, void *addr)
 	return 0;
 }
 
+static int dpaa_addr_sync(struct net_device *net_dev, const u8 *addr)
+{
+	const struct dpaa_priv *priv = netdev_priv(net_dev);
+
+	return priv->mac_dev->add_hash_mac_addr(priv->mac_dev->fman_mac,
+						(enet_addr_t *)addr);
+}
+
+static int dpaa_addr_unsync(struct net_device *net_dev, const u8 *addr)
+{
+	const struct dpaa_priv *priv = netdev_priv(net_dev);
+
+	return priv->mac_dev->remove_hash_mac_addr(priv->mac_dev->fman_mac,
+						   (enet_addr_t *)addr);
+}
+
 static void dpaa_set_rx_mode(struct net_device *net_dev)
 {
 	const struct dpaa_priv	*priv;
@@ -490,9 +506,9 @@ static void dpaa_set_rx_mode(struct net_device *net_dev)
 				  err);
 	}
 
-	err = priv->mac_dev->set_multi(net_dev, priv->mac_dev);
+	err = __dev_mc_sync(net_dev, dpaa_addr_sync, dpaa_addr_unsync);
 	if (err < 0)
-		netif_err(priv, drv, net_dev, "mac_dev->set_multi() = %d\n",
+		netif_err(priv, drv, net_dev, "dpaa_addr_sync() = %d\n",
 			  err);
 }
 
diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
index 3088da7adf0f846744079107f7f72fea74114f4a..85617bb94959f3789d75766bce8f3e11a7b321d5 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -1415,7 +1415,6 @@ int dtsec_initialization(struct mac_device *mac_dev,
 	mac_dev->set_exception		= dtsec_set_exception;
 	mac_dev->set_allmulti		= dtsec_set_allmulti;
 	mac_dev->set_tstamp		= dtsec_set_tstamp;
-	mac_dev->set_multi		= fman_set_multi;
 	mac_dev->enable			= dtsec_enable;
 	mac_dev->disable		= dtsec_disable;
 
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 796e6f4e583d18be6069f78af15fbedf9557378e..3925441143fac9eecc40ea45d05f36be63b16a78 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -1087,7 +1087,6 @@ int memac_initialization(struct mac_device *mac_dev,
 	mac_dev->set_exception		= memac_set_exception;
 	mac_dev->set_allmulti		= memac_set_allmulti;
 	mac_dev->set_tstamp		= memac_set_tstamp;
-	mac_dev->set_multi		= fman_set_multi;
 	mac_dev->enable			= memac_enable;
 	mac_dev->disable		= memac_disable;
 
diff --git a/drivers/net/ethernet/freescale/fman/fman_tgec.c b/drivers/net/ethernet/freescale/fman/fman_tgec.c
index c2261d26db5b9374a5e52bac41c25ed8831f4822..fecfca6eba03e571cfb569b8aad20dc3fa8dc1c7 100644
--- a/drivers/net/ethernet/freescale/fman/fman_tgec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_tgec.c
@@ -771,7 +771,6 @@ int tgec_initialization(struct mac_device *mac_dev,
 	mac_dev->set_exception		= tgec_set_exception;
 	mac_dev->set_allmulti		= tgec_set_allmulti;
 	mac_dev->set_tstamp		= tgec_set_tstamp;
-	mac_dev->set_multi		= fman_set_multi;
 	mac_dev->enable			= tgec_enable;
 	mac_dev->disable		= tgec_disable;
 
diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 43f4ad29eadd495ce7f4861b3e635e22379ddc72..974d2e7e131c087ddbb41dcb906f6144a150db46 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -32,8 +32,6 @@ MODULE_DESCRIPTION("FSL FMan MAC API based driver");
 struct mac_priv_s {
 	u8				cell_index;
 	struct fman			*fman;
-	/* List of multicast addresses */
-	struct list_head		mc_addr_list;
 	struct platform_device		*eth_dev;
 	u16				speed;
 };
@@ -57,44 +55,6 @@ static void mac_exception(struct mac_device *mac_dev,
 		__func__, ex);
 }
 
-int fman_set_multi(struct net_device *net_dev, struct mac_device *mac_dev)
-{
-	struct mac_priv_s	*priv;
-	struct mac_address	*old_addr, *tmp;
-	struct netdev_hw_addr	*ha;
-	int			err;
-	enet_addr_t		*addr;
-
-	priv = mac_dev->priv;
-
-	/* Clear previous address list */
-	list_for_each_entry_safe(old_addr, tmp, &priv->mc_addr_list, list) {
-		addr = (enet_addr_t *)old_addr->addr;
-		err = mac_dev->remove_hash_mac_addr(mac_dev->fman_mac, addr);
-		if (err < 0)
-			return err;
-
-		list_del(&old_addr->list);
-		kfree(old_addr);
-	}
-
-	/* Add all the addresses from the new list */
-	netdev_for_each_mc_addr(ha, net_dev) {
-		addr = (enet_addr_t *)ha->addr;
-		err = mac_dev->add_hash_mac_addr(mac_dev->fman_mac, addr);
-		if (err < 0)
-			return err;
-
-		tmp = kmalloc(sizeof(*tmp), GFP_ATOMIC);
-		if (!tmp)
-			return -ENOMEM;
-
-		ether_addr_copy(tmp->addr, ha->addr);
-		list_add(&tmp->list, &priv->mc_addr_list);
-	}
-	return 0;
-}
-
 static DEFINE_MUTEX(eth_lock);
 
 static struct platform_device *dpaa_eth_add_device(int fman_id,
@@ -181,8 +141,6 @@ static int mac_probe(struct platform_device *_of_dev)
 	mac_dev->priv = priv;
 	mac_dev->dev = dev;
 
-	INIT_LIST_HEAD(&priv->mc_addr_list);
-
 	/* Get the FM node */
 	dev_node = of_get_parent(mac_node);
 	if (!dev_node) {
diff --git a/drivers/net/ethernet/freescale/fman/mac.h b/drivers/net/ethernet/freescale/fman/mac.h
index fe747915cc73792b66d8bfe4339894476fc841af..be9d48aad5ef16d6826e0dc3c93b8c456cdfa925 100644
--- a/drivers/net/ethernet/freescale/fman/mac.h
+++ b/drivers/net/ethernet/freescale/fman/mac.h
@@ -39,8 +39,6 @@ struct mac_device {
 	int (*change_addr)(struct fman_mac *mac_dev, const enet_addr_t *enet_addr);
 	int (*set_allmulti)(struct fman_mac *mac_dev, bool enable);
 	int (*set_tstamp)(struct fman_mac *mac_dev, bool enable);
-	int (*set_multi)(struct net_device *net_dev,
-			 struct mac_device *mac_dev);
 	int (*set_exception)(struct fman_mac *mac_dev,
 			     enum fman_mac_exceptions exception, bool enable);
 	int (*add_hash_mac_addr)(struct fman_mac *mac_dev,

-- 
2.39.5


