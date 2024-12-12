Return-Path: <netdev+bounces-151458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682E69EF66E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE14517D5DC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2F0226868;
	Thu, 12 Dec 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fc3qBqps"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D72253F1;
	Thu, 12 Dec 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023232; cv=none; b=Rl59wko/Si1bsQfrSXp4AwGtiA21hkhxFTmK2ewQnSfBElQdHN0Gl0Z3gWEFmKprJ/1Ov8CrzBXVAUNW/mKxp/bhz0Frw9O6ZZxATnXrXx8eUekB44tEzS4LtKR+IJB46C5jjYe1IVgerHFOhbUV1XrrxqVt8/pnD+cJlP/5Ux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023232; c=relaxed/simple;
	bh=E+uE2DlNT+Eq6FJ/S24TNGS2baK6Dp71ui9EHV/qmM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPKpDjcrTt9lARjMZigEBNV7KxWF6FpAKigpBzGywR/5FXpXOJ5XlPnrV+vNthaTyDYn3OQt+2iUDMqjXTeqVu5HxuCKINliv6duWhvGuT5M0tAiNqIg9kLLni15pUAqygZzFI+tFcJNTba0GUurXBuTYVKOyI4Q6Zxxnf9TmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fc3qBqps; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B472560005;
	Thu, 12 Dec 2024 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734023228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWnGJ0OJb8yBGMbkiKUMbfrydHq7sBNjtIC5N9B6H2Q=;
	b=Fc3qBqpsZ26tVyjSX+FBUesm0A1HncJgiQqO85niiTZm5/buPBC5Zw7pduc83jK480t9Sv
	G1gtZAHQVaYG0yRgOwoC93nK9moi+1Un8sBLRRvx7+3yYOw6xvudccqFQ5K6o5nHqw1KUp
	eNI22dTBIyVotCzc9DwSI9+itsx2Cnfrif35Gt+SZQytxZ337hieezd0ehT05QngAWj4sj
	RAfY+1laDBoRfBCN/CDZU2KFHdyx9HNv68LNrVZQdjGiSy6OaNwP1iRzp04oFSzVXzbBhl
	93xJp90p+vurRJhBzF0HVnOlpecchpQCJ/kfI5esNQmKcWy1YEId2k6M7rRfaA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 12 Dec 2024 18:06:43 +0100
Subject: [PATCH net-next v21 3/5] net: Add the possibility to support a
 selected hwtstamp in netdevice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-feature_ptp_netnext-v21-3-2c282a941518@bootlin.com>
References: <20241212-feature_ptp_netnext-v21-0-2c282a941518@bootlin.com>
In-Reply-To: <20241212-feature_ptp_netnext-v21-0-2c282a941518@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

Introduce the description of a hwtstamp provider, mainly defined with a
the hwtstamp source and the phydev pointer.

Add a hwtstamp provider description within the netdev structure to
allow saving the hwtstamp we want to use. This prepares for future
support of an ethtool netlink command to select the desired hwtstamp
provider. By default, the old API that does not support hwtstamp
selectability is used, meaning the hwtstamp provider pointer is unset.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch

Change in v10:
- Set hwtstamp in netdevice as a pointer for future use of rcu lock.
- Fix a nit in teh order of setting phydev pointer.
- Add a missing kdoc description.

Change in v13:
- Remove an include from netdevices.h.

Change in v16:
- Import the part of the patch 12 which belong to the hwtstamp provider
  selectability of net core.

Change in v18:
- Fix a doc NIT.

Change in v20:
- Rework the hwtstamp provider design. Use hwtstamp source alongside
  with phydev pointer instead.
---
 drivers/net/phy/phy_device.c    | 10 ++++++++
 include/linux/net_tstamp.h      | 29 +++++++++++++++++++++++
 include/linux/netdevice.h       |  4 ++++
 include/uapi/linux/net_tstamp.h | 11 +++++++++
 net/core/dev_ioctl.c            | 41 ++++++++++++++++++++++++++++++--
 net/core/timestamping.c         | 52 +++++++++++++++++++++++++++++++++++++----
 6 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b26bb33cd1d4..1a908af4175b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -32,6 +32,7 @@
 #include <linux/phy_link_topology.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/property.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/rtnetlink.h>
 #include <linux/sfp.h>
 #include <linux/skbuff.h>
@@ -1998,6 +1999,15 @@ void phy_detach(struct phy_device *phydev)
 
 	phy_suspend(phydev);
 	if (dev) {
+		struct hwtstamp_provider *hwprov;
+
+		hwprov = rtnl_dereference(dev->hwprov);
+		/* Disable timestamp if it is the one selected */
+		if (hwprov && hwprov->phydev == phydev) {
+			rcu_assign_pointer(dev->hwprov, NULL);
+			kfree_rcu(hwprov, rcu_head);
+		}
+
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
 		phy_link_topo_del_phy(dev, phydev);
diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 662074b08c94..ff0758e88ea1 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -19,6 +19,33 @@ enum hwtstamp_source {
 	HWTSTAMP_SOURCE_PHYLIB,
 };
 
+/**
+ * struct hwtstamp_provider_desc - hwtstamp provider description
+ *
+ * @index: index of the hwtstamp provider.
+ * @qualifier: hwtstamp provider qualifier.
+ */
+struct hwtstamp_provider_desc {
+	int index;
+	enum hwtstamp_provider_qualifier qualifier;
+};
+
+/**
+ * struct hwtstamp_provider - hwtstamp provider object
+ *
+ * @rcu_head: RCU callback used to free the struct.
+ * @source: source of the hwtstamp provider.
+ * @phydev: pointer of the phydev source in case a PTP coming from phylib
+ * @desc: hwtstamp provider description.
+ */
+
+struct hwtstamp_provider {
+	struct rcu_head rcu_head;
+	enum hwtstamp_source source;
+	struct phy_device *phydev;
+	struct hwtstamp_provider_desc desc;
+};
+
 /**
  * struct kernel_hwtstamp_config - Kernel copy of struct hwtstamp_config
  *
@@ -31,6 +58,7 @@ enum hwtstamp_source {
  *	copied the ioctl request back to user space
  * @source: indication whether timestamps should come from the netdev or from
  *	an attached phylib PHY
+ * @qualifier: qualifier of the hwtstamp provider
  *
  * Prefer using this structure for in-kernel processing of hardware
  * timestamping configuration, over the inextensible struct hwtstamp_config
@@ -43,6 +71,7 @@ struct kernel_hwtstamp_config {
 	struct ifreq *ifr;
 	bool copied_to_user;
 	enum hwtstamp_source source;
+	enum hwtstamp_provider_qualifier qualifier;
 };
 
 static inline void hwtstamp_config_to_kernel(struct kernel_hwtstamp_config *kernel_cfg,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d917949bba03..2593019ad5b1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -82,6 +82,7 @@ struct xdp_metadata_ops;
 struct xdp_md;
 struct ethtool_netdev_state;
 struct phy_link_topology;
+struct hwtstamp_provider;
 
 typedef u32 xdp_features_t;
 
@@ -2045,6 +2046,7 @@ enum netdev_reg_state {
  *
  *	@neighbours:	List heads pointing to this device's neighbours'
  *			dev_list, one per address-family.
+ *	@hwprov: Tracks which PTP performs hardware packet time stamping.
  *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
@@ -2457,6 +2459,8 @@ struct net_device {
 
 	struct hlist_head neighbours[NEIGH_NR_TABLES];
 
+	struct hwtstamp_provider __rcu	*hwprov;
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index 858339d1c1c4..55b0ab51096c 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -13,6 +13,17 @@
 #include <linux/types.h>
 #include <linux/socket.h>   /* for SO_TIMESTAMPING */
 
+/*
+ * Possible type of hwtstamp provider. Mainly "precise" the default one
+ * is for IEEE 1588 quality and "approx" is for NICs DMA point.
+ */
+enum hwtstamp_provider_qualifier {
+	HWTSTAMP_PROVIDER_QUALIFIER_PRECISE,
+	HWTSTAMP_PROVIDER_QUALIFIER_APPROX,
+
+	HWTSTAMP_PROVIDER_QUALIFIER_CNT,
+};
+
 /* SO_TIMESTAMPING flags */
 enum {
 	SOF_TIMESTAMPING_TX_HARDWARE = (1<<0),
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 1f09930fca26..087a57b7e4fa 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -6,6 +6,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/net_tstamp.h>
 #include <linux/phylib_stubs.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/wireless.h>
 #include <linux/if_bridge.h>
 #include <net/dsa_stubs.h>
@@ -269,6 +270,21 @@ static int dev_eth_ioctl(struct net_device *dev,
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg)
 {
+	struct hwtstamp_provider *hwprov;
+
+	hwprov = rtnl_dereference(dev->hwprov);
+	if (hwprov) {
+		cfg->qualifier = hwprov->desc.qualifier;
+		if (hwprov->source == HWTSTAMP_SOURCE_PHYLIB &&
+		    hwprov->phydev)
+			return phy_hwtstamp_get(hwprov->phydev, cfg);
+
+		if (hwprov->source == HWTSTAMP_SOURCE_NETDEV)
+			return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
+
+		return -EOPNOTSUPP;
+	}
+
 	if (phy_is_default_hwtstamp(dev->phydev))
 		return phy_hwtstamp_get(dev->phydev, cfg);
 
@@ -324,11 +340,32 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-	bool phy_ts = phy_is_default_hwtstamp(dev->phydev);
 	struct kernel_hwtstamp_config old_cfg = {};
+	struct hwtstamp_provider *hwprov;
+	struct phy_device *phydev;
 	bool changed = false;
+	bool phy_ts;
 	int err;
 
+	hwprov = rtnl_dereference(dev->hwprov);
+	if (hwprov) {
+		if (hwprov->source == HWTSTAMP_SOURCE_PHYLIB &&
+		    hwprov->phydev) {
+			phy_ts = true;
+			phydev = hwprov->phydev;
+		} else if (hwprov->source == HWTSTAMP_SOURCE_NETDEV) {
+			phy_ts = false;
+		} else {
+			return -EOPNOTSUPP;
+		}
+
+		cfg->qualifier = hwprov->desc.qualifier;
+	} else {
+		phy_ts = phy_is_default_hwtstamp(dev->phydev);
+		if (phy_ts)
+			phydev = dev->phydev;
+	}
+
 	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
 
 	if (phy_ts && dev->see_all_hwtstamp_requests) {
@@ -350,7 +387,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 		changed = kernel_hwtstamp_config_changed(&old_cfg, cfg);
 
 	if (phy_ts) {
-		err = phy_hwtstamp_set(dev->phydev, cfg, extack);
+		err = phy_hwtstamp_set(phydev, cfg, extack);
 		if (err) {
 			if (changed)
 				ops->ndo_hwtstamp_set(dev, &old_cfg, NULL);
diff --git a/net/core/timestamping.c b/net/core/timestamping.c
index 3717fb152ecc..a50a7ef49ae8 100644
--- a/net/core/timestamping.c
+++ b/net/core/timestamping.c
@@ -9,6 +9,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/skbuff.h>
 #include <linux/export.h>
+#include <linux/ptp_clock_kernel.h>
 
 static unsigned int classify(const struct sk_buff *skb)
 {
@@ -21,19 +22,39 @@ static unsigned int classify(const struct sk_buff *skb)
 
 void skb_clone_tx_timestamp(struct sk_buff *skb)
 {
+	struct hwtstamp_provider *hwprov;
 	struct mii_timestamper *mii_ts;
+	struct phy_device *phydev;
 	struct sk_buff *clone;
 	unsigned int type;
 
-	if (!skb->sk || !skb->dev ||
-	    !phy_is_default_hwtstamp(skb->dev->phydev))
+	if (!skb->sk || !skb->dev)
 		return;
 
+	rcu_read_lock();
+	hwprov = rcu_dereference(skb->dev->hwprov);
+	if (hwprov) {
+		if (hwprov->source != HWTSTAMP_SOURCE_PHYLIB ||
+		    !hwprov->phydev) {
+			rcu_read_unlock();
+			return;
+		}
+
+		phydev = hwprov->phydev;
+	} else {
+		phydev = skb->dev->phydev;
+		if (!phy_is_default_hwtstamp(phydev)) {
+			rcu_read_unlock();
+			return;
+		}
+	}
+	rcu_read_unlock();
+
 	type = classify(skb);
 	if (type == PTP_CLASS_NONE)
 		return;
 
-	mii_ts = skb->dev->phydev->mii_ts;
+	mii_ts = phydev->mii_ts;
 	if (likely(mii_ts->txtstamp)) {
 		clone = skb_clone_sk(skb);
 		if (!clone)
@@ -45,12 +66,33 @@ EXPORT_SYMBOL_GPL(skb_clone_tx_timestamp);
 
 bool skb_defer_rx_timestamp(struct sk_buff *skb)
 {
+	struct hwtstamp_provider *hwprov;
 	struct mii_timestamper *mii_ts;
+	struct phy_device *phydev;
 	unsigned int type;
 
-	if (!skb->dev || !phy_is_default_hwtstamp(skb->dev->phydev))
+	if (!skb->dev)
 		return false;
 
+	rcu_read_lock();
+	hwprov = rcu_dereference(skb->dev->hwprov);
+	if (hwprov) {
+		if (hwprov->source != HWTSTAMP_SOURCE_PHYLIB ||
+		    !hwprov->phydev) {
+			rcu_read_unlock();
+			return false;
+		}
+
+		phydev = hwprov->phydev;
+	} else {
+		phydev = skb->dev->phydev;
+		if (!phy_is_default_hwtstamp(phydev)) {
+			rcu_read_unlock();
+			return false;
+		}
+	}
+	rcu_read_unlock();
+
 	if (skb_headroom(skb) < ETH_HLEN)
 		return false;
 
@@ -63,7 +105,7 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
 	if (type == PTP_CLASS_NONE)
 		return false;
 
-	mii_ts = skb->dev->phydev->mii_ts;
+	mii_ts = phydev->mii_ts;
 	if (likely(mii_ts->rxtstamp))
 		return mii_ts->rxtstamp(mii_ts, skb, type);
 

-- 
2.34.1


