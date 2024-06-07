Return-Path: <netdev+bounces-101689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA28FFCE4
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 056D7B2238C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEFC154454;
	Fri,  7 Jun 2024 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h7hfgOfb"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B67B64E;
	Fri,  7 Jun 2024 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744732; cv=none; b=pIhRqv92mmT4u5CQ2IwJtKvy750V/KOCjXP0ODBGN+va8BiHvIynC9a66xx2Uf145KEc3U2wnJbWpFEPE82docq3ZFpAx8m4MS1ltruVerGnFiof+BMsH8ThTK+7IkyeMp/luURfDjh8eYKcQdi6Drv3l1Vnv2WnQAuOEx8lE48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744732; c=relaxed/simple;
	bh=53W8I37MqSPsojym1RII6ZsVhFeM63mdXrewZkkg2NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZsFj2Mvlj+oDXFn/8oG5bBcTGGbfdMDAdfQmEcXo7NGnD1w8nhxlpFgjies39UXduTf9UvrA6Xrak2OPjSXXwNLHAyYDuRkw4+hHOQwnimZQ757dH8H9qqiMpzohBJIXU8so2iPa57fzpQ4SmIYXFr9w8Y4+dw+6ycMDhMnhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h7hfgOfb; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27DD11BF20A;
	Fri,  7 Jun 2024 07:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717744727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iK3KTmq33UQgg8RO4g6MAVMBhMen9T9M5rtSgCWSdBY=;
	b=h7hfgOfbe1JTmVe+9fHog0BhABE0geGeIADd6dcG9tSUnRVOoqOpP4cu5bdavpjzfpl5Qr
	Qs37zFd5azEyM2KyDGD4dLbUDU4Ncv/VnbqN+h0YgtD9z2BWLuV/wedDglR/LYxbeiyGsc
	tEvXLtisFLw73qARUXFSirFQlb38eB6PZzDR5rrIM2RXAlYXRpSTK1gF7LFECGCHpRC0tP
	ehro4jOrVVQAg+tcral1tYE5hUd0tqzQS7hwrmpQqo+WhjR2vjv0ZQNMW/YCIDfCYKKnub
	jGOnFtgBnCocOan0dhlRdw8WPPHEn3jRKsrExVYOBKXifrcGxvVIv/wya1dv1w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next v13 01/13] net: phy: Introduce ethernet link topology representation
Date: Fri,  7 Jun 2024 09:18:14 +0200
Message-ID: <20240607071836.911403-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Link topologies containing multiple network PHYs attached to the same
net_device can be found when using a PHY as a media converter for use
with an SFP connector, on which an SFP transceiver containing a PHY can
be used.

With the current model, the transceiver's PHY can't be used for
operations such as cable testing, timestamping, macsec offload, etc.

The reason being that most of the logic for these configuration, coming
from either ethtool netlink or ioctls tend to use netdev->phydev, which
in multi-phy systems will reference the PHY closest to the MAC.

Introduce a numbering scheme allowing to enumerate PHY devices that
belong to any netdev, which can in turn allow userspace to take more
precise decisions with regard to each PHY's configuration.

The numbering is maintained per-netdev, in a phy_device_list.
The numbering works similarly to a netdevice's ifindex, with
identifiers that are only recycled once INT_MAX has been reached.

This prevents races that could occur between PHY listing and SFP
transceiver removal/insertion.

The identifiers are assigned at phy_attach time, as the numbering
depends on the netdevice the phy is attached to. The PHY index can be
re-used for PHYs that are persistent.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 MAINTAINERS                         |   1 +
 drivers/net/phy/Makefile            |   2 +-
 drivers/net/phy/phy_device.c        |   6 ++
 drivers/net/phy/phy_link_topology.c | 105 ++++++++++++++++++++++++++++
 include/linux/netdevice.h           |   4 +-
 include/linux/phy.h                 |   4 ++
 include/linux/phy_link_topology.h   |  82 ++++++++++++++++++++++
 include/uapi/linux/ethtool.h        |  16 +++++
 net/core/dev.c                      |  15 ++++
 9 files changed, 233 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/phy/phy_link_topology.c
 create mode 100644 include/linux/phy_link_topology.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cd3277a98cfe..3cad63bb49be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8193,6 +8193,7 @@ F:	include/linux/mii.h
 F:	include/linux/of_net.h
 F:	include/linux/phy.h
 F:	include/linux/phy_fixed.h
+F:	include/linux/phy_link_topology.h
 F:	include/linux/phylib_stubs.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
 F:	include/linux/platform_data/mdio-gpio.h
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 202ed7f450da..1d8be374915f 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Linux PHY drivers
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
-				   linkmode.o
+				   linkmode.o phy_link_topology.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_MDIO_DEVICE
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6c6ec9475709..439d03f5774a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -29,6 +29,7 @@
 #include <linux/phy.h>
 #include <linux/phylib_stubs.h>
 #include <linux/phy_led_triggers.h>
+#include <linux/phy_link_topology.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/property.h>
 #include <linux/rtnetlink.h>
@@ -1511,6 +1512,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 		if (phydev->sfp_bus_attached)
 			dev->sfp_bus = phydev->sfp_bus;
+
+		err = phy_link_topo_add_phy(dev, phydev, PHY_UPSTREAM_MAC, dev);
+		if (err)
+			goto error;
 	}
 
 	/* Some Ethernet drivers try to connect to a PHY device before
@@ -1938,6 +1943,7 @@ void phy_detach(struct phy_device *phydev)
 	if (dev) {
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
+		phy_link_topo_del_phy(dev, phydev);
 	}
 	phydev->phylink = NULL;
 
diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
new file mode 100644
index 000000000000..4a5d73002a1a
--- /dev/null
+++ b/drivers/net/phy/phy_link_topology.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Infrastructure to handle all PHY devices connected to a given netdev,
+ * either directly or indirectly attached.
+ *
+ * Copyright (c) 2023 Maxime Chevallier<maxime.chevallier@bootlin.com>
+ */
+
+#include <linux/phy_link_topology.h>
+#include <linux/phy.h>
+#include <linux/rtnetlink.h>
+#include <linux/xarray.h>
+
+static int netdev_alloc_phy_link_topology(struct net_device *dev)
+{
+	struct phy_link_topology *topo;
+
+	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
+	if (!topo)
+		return -ENOMEM;
+
+	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
+	topo->next_phy_index = 1;
+
+	dev->link_topo = topo;
+
+	return 0;
+}
+
+int phy_link_topo_add_phy(struct net_device *dev,
+			  struct phy_device *phy,
+			  enum phy_upstream upt, void *upstream)
+{
+	struct phy_link_topology *topo = dev->link_topo;
+	struct phy_device_node *pdn;
+	int ret;
+
+	if (!topo) {
+		ret = netdev_alloc_phy_link_topology(dev);
+		if (ret)
+			return ret;
+
+		topo = dev->link_topo;
+	}
+
+	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
+	if (!pdn)
+		return -ENOMEM;
+
+	pdn->phy = phy;
+	switch (upt) {
+	case PHY_UPSTREAM_MAC:
+		pdn->upstream.netdev = (struct net_device *)upstream;
+		if (phy_on_sfp(phy))
+			pdn->parent_sfp_bus = pdn->upstream.netdev->sfp_bus;
+		break;
+	case PHY_UPSTREAM_PHY:
+		pdn->upstream.phydev = (struct phy_device *)upstream;
+		if (phy_on_sfp(phy))
+			pdn->parent_sfp_bus = pdn->upstream.phydev->sfp_bus;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err;
+	}
+	pdn->upstream_type = upt;
+
+	/* Attempt to re-use a previously allocated phy_index */
+	if (phy->phyindex)
+		ret = xa_insert(&topo->phys, phy->phyindex, pdn, GFP_KERNEL);
+	else
+		ret = xa_alloc_cyclic(&topo->phys, &phy->phyindex, pdn,
+				      xa_limit_32b, &topo->next_phy_index,
+				      GFP_KERNEL);
+
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	kfree(pdn);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
+
+void phy_link_topo_del_phy(struct net_device *dev,
+			   struct phy_device *phy)
+{
+	struct phy_link_topology *topo = dev->link_topo;
+	struct phy_device_node *pdn;
+
+	if (!topo)
+		return;
+
+	pdn = xa_erase(&topo->phys, phy->phyindex);
+
+	/* We delete the PHY from the topology, however we don't re-set the
+	 * phy->phyindex field. If the PHY isn't gone, we can re-assign it the
+	 * same index next time it's added back to the topology
+	 */
+
+	kfree(pdn);
+}
+EXPORT_SYMBOL_GPL(phy_link_topo_del_phy);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d20c6c99eb88..6c2077f45b9f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -40,7 +40,6 @@
 #include <net/dcbnl.h>
 #endif
 #include <net/netprio_cgroup.h>
-
 #include <linux/netdev_features.h>
 #include <linux/neighbour.h>
 #include <uapi/linux/netdevice.h>
@@ -79,6 +78,7 @@ struct xdp_buff;
 struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
+struct phy_link_topology;
 
 typedef u32 xdp_features_t;
 
@@ -1975,6 +1975,7 @@ enum netdev_reg_state {
  *	@fcoe_ddp_xid:	Max exchange id for FCoE LRO by ddp
  *
  *	@priomap:	XXX: need comments on this one
+ *	@link_topo:	Physical link topology tracking attached PHYs
  *	@phydev:	Physical device may attach itself
  *			for hardware timestamping
  *	@sfp_bus:	attached &struct sfp_bus structure.
@@ -2367,6 +2368,7 @@ struct net_device {
 #if IS_ENABLED(CONFIG_CGROUP_NET_PRIO)
 	struct netprio_map __rcu *priomap;
 #endif
+	struct phy_link_topology	*link_topo;
 	struct phy_device	*phydev;
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e6e83304558e..8c848c79b1fd 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -550,6 +550,9 @@ struct macsec_ops;
  * @drv: Pointer to the driver for this PHY instance
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
+ * @phyindex: Unique id across the phy's parent tree of phys to address the PHY
+ *	      from userspace, similar to ifindex. A zero index means the PHY
+ *	      wasn't assigned an id yet.
  * @phy_id: UID for this device found during discovery
  * @c45_ids: 802.3-c45 Device Identifiers if is_c45.
  * @is_c45:  Set to true if this PHY uses clause 45 addressing.
@@ -650,6 +653,7 @@ struct phy_device {
 
 	struct device_link *devlink;
 
+	u32 phyindex;
 	u32 phy_id;
 
 	struct phy_c45_device_ids c45_ids;
diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
new file mode 100644
index 000000000000..6f1569db6643
--- /dev/null
+++ b/include/linux/phy_link_topology.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PHY device list allow maintaining a list of PHY devices that are
+ * part of a netdevice's link topology. PHYs can for example be chained,
+ * as is the case when using a PHY that exposes an SFP module, on which an
+ * SFP transceiver that embeds a PHY is connected.
+ *
+ * This list can then be used by userspace to leverage individual PHY
+ * capabilities.
+ */
+#ifndef __PHY_LINK_TOPOLOGY_H
+#define __PHY_LINK_TOPOLOGY_H
+
+#include <linux/ethtool.h>
+#include <linux/netdevice.h>
+
+struct xarray;
+struct phy_device;
+struct sfp_bus;
+
+struct phy_link_topology {
+	struct xarray phys;
+	u32 next_phy_index;
+};
+
+struct phy_device_node {
+	enum phy_upstream upstream_type;
+
+	union {
+		struct net_device	*netdev;
+		struct phy_device	*phydev;
+	} upstream;
+
+	struct sfp_bus *parent_sfp_bus;
+
+	struct phy_device *phy;
+};
+
+#if IS_ENABLED(CONFIG_PHYLIB)
+int phy_link_topo_add_phy(struct net_device *dev,
+			  struct phy_device *phy,
+			  enum phy_upstream upt, void *upstream);
+
+void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
+
+static inline struct phy_device
+*phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
+{
+	struct phy_link_topology *topo = dev->link_topo;
+	struct phy_device_node *pdn;
+
+	if (!topo)
+		return NULL;
+
+	pdn = xa_load(&topo->phys, phyindex);
+	if (pdn)
+		return pdn->phy;
+
+	return NULL;
+}
+
+#else
+static inline int phy_link_topo_add_phy(struct net_device *dev,
+					struct phy_device *phy,
+					enum phy_upstream upt, void *upstream)
+{
+	return 0;
+}
+
+static inline void phy_link_topo_del_phy(struct net_device *dev,
+					 struct phy_device *phy)
+{
+}
+
+static inline struct phy_device *
+phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __PHY_LINK_TOPOLOGY_H */
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 8733a3117902..041e09c3515d 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2323,4 +2323,20 @@ struct ethtool_link_settings {
 	 * __u32 map_lp_advertising[link_mode_masks_nwords];
 	 */
 };
+
+/**
+ * enum phy_upstream - Represents the upstream component a given PHY device
+ * is connected to, as in what is on the other end of the MII bus. Most PHYs
+ * will be attached to an Ethernet MAC controller, but in some cases, there's
+ * an intermediate PHY used as a media-converter, which will driver another
+ * MII interface as its output.
+ * @PHY_UPSTREAM_MAC: Upstream component is a MAC (a switch port,
+ *		      or ethernet controller)
+ * @PHY_UPSTREAM_PHY: Upstream component is a PHY (likely a media converter)
+ */
+enum phy_upstream {
+	PHY_UPSTREAM_MAC,
+	PHY_UPSTREAM_PHY,
+};
+
 #endif /* _UAPI_LINUX_ETHTOOL_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index e62698c7a0e6..36d4d6662af6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -158,6 +158,7 @@
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
 #include <net/rps.h>
+#include <linux/phy_link_topology.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -10256,6 +10257,17 @@ static void netdev_do_free_pcpu_stats(struct net_device *dev)
 	}
 }
 
+static void netdev_free_phy_link_topology(struct net_device *dev)
+{
+	struct phy_link_topology *topo = dev->link_topo;
+
+	if (IS_ENABLED(CONFIG_PHYLIB) && topo) {
+		xa_destroy(&topo->phys);
+		kfree(topo);
+		dev->link_topo = NULL;
+	}
+}
+
 /**
  * register_netdevice() - register a network device
  * @dev: device to register
@@ -10998,6 +11010,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 #ifdef CONFIG_NET_SCHED
 	hash_init(dev->qdisc_hash);
 #endif
+
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
 
@@ -11086,6 +11099,8 @@ void free_netdev(struct net_device *dev)
 	free_percpu(dev->xdp_bulkq);
 	dev->xdp_bulkq = NULL;
 
+	netdev_free_phy_link_topology(dev);
+
 	/*  Compatibility with error handling in drivers */
 	if (dev->reg_state == NETREG_UNINITIALIZED ||
 	    dev->reg_state == NETREG_DUMMY) {
-- 
2.45.1


