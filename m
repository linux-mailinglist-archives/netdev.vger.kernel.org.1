Return-Path: <netdev+bounces-120643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B8295A106
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABECA282704
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBA41494CC;
	Wed, 21 Aug 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hUx0CHUG"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183213A3E8;
	Wed, 21 Aug 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253028; cv=none; b=hKIVq+bAq6k39Wrh7yRqqr4ihiP5HA3DVGeg0/wEiZqI7250bfOedR4XTv8W1qrYg+uM6LnQVYFTlt9sS5jhY3Y9u8sXrrbXqYXGjCpC16Iqzl1yPV1jLqASpQu/OPkWY1katq0//S7INb7pwVHUdKnPr7NLFzEoWndhZOSsELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253028; c=relaxed/simple;
	bh=caplopswex5mmmwoFxztgSLU1wbUPumz9qLByB9Cu6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3VkjBAwvMA+kEXQKB6KqVSjyu1UbwaX4nWQ6si/U61L9FN+0Xk2NXZCaFtCLFxP0E+inCPKfLT/YDV1YMKJBYIVIGRmW+INkybBC8nMvVeR2vs7W46LVTaHqLUI/gUWYO2nRuy5DUVca1DwjLyxMCkya2To38CDCGBY9dqgP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hUx0CHUG; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6055F40009;
	Wed, 21 Aug 2024 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724253017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlbjsk87+B5czs9wCvDXAuk5tc9yKzEFh3ErGk45nwI=;
	b=hUx0CHUGYPBo4tJczonn+eX0gpYW0O9GU1oaHzuMR9R451NOKRIYrBqGTCUTeRN0IGnTBn
	4OOfUwXKBj4K2M7wbEK1W4nkWoCkpagaN55IBKAS+8WmZsUB9ha1n/NF/Z8tcxT34CxBK0
	4viSz/uHb9CX17qVB7Cau/uhJsOVjSlCcDQFp6jh3bADjUM2ha8Z+vJtqBD2JauqmBzvA6
	1uT0xQXMKWESPtjgccKTB2X5qMDIgMQcnCr54Heji/qPudgxHsMj69mrlygFIY3sak8BzH
	WrfnO2ukxGRh0lSx1Nvu6Uax751xSGXR9L/6aNY8Q+mL1UoTJ9EgfwmCwp9V7Q==
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
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v18 01/13] net: phy: Introduce ethernet link topology representation
Date: Wed, 21 Aug 2024 17:09:55 +0200
Message-ID: <20240821151009.1681151-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
References: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
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
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
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
index 5dbf23cf11c8..57f9b83da6f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8339,6 +8339,7 @@ F:	include/linux/mii.h
 F:	include/linux/of_net.h
 F:	include/linux/phy.h
 F:	include/linux/phy_fixed.h
+F:	include/linux/phy_link_topology.h
 F:	include/linux/phylib_stubs.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
 F:	include/linux/platform_data/mdio-gpio.h
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index f086a606a87e..33adb3df5f64 100644
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
index 159e71c1c972..d896c799f7c2 100644
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
@@ -1526,6 +1527,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 		if (phydev->sfp_bus_attached)
 			dev->sfp_bus = phydev->sfp_bus;
+
+		err = phy_link_topo_add_phy(dev, phydev, PHY_UPSTREAM_MAC, dev);
+		if (err)
+			goto error;
 	}
 
 	/* Some Ethernet drivers try to connect to a PHY device before
@@ -1953,6 +1958,7 @@ void phy_detach(struct phy_device *phydev)
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
index 0ef3eaa23f4b..3d1217bc27c7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -40,7 +40,6 @@
 #include <net/dcbnl.h>
 #endif
 #include <net/netprio_cgroup.h>
-
 #include <linux/netdev_features.h>
 #include <linux/neighbour.h>
 #include <linux/netdevice_xmit.h>
@@ -81,6 +80,7 @@ struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
 struct ethtool_netdev_state;
+struct phy_link_topology;
 
 typedef u32 xdp_features_t;
 
@@ -1946,6 +1946,7 @@ enum netdev_reg_state {
  *	@fcoe_ddp_xid:	Max exchange id for FCoE LRO by ddp
  *
  *	@priomap:	XXX: need comments on this one
+ *	@link_topo:	Physical link topology tracking attached PHYs
  *	@phydev:	Physical device may attach itself
  *			for hardware timestamping
  *	@sfp_bus:	attached &struct sfp_bus structure.
@@ -2337,6 +2338,7 @@ struct net_device {
 #if IS_ENABLED(CONFIG_CGROUP_NET_PRIO)
 	struct netprio_map __rcu *priomap;
 #endif
+	struct phy_link_topology	*link_topo;
 	struct phy_device	*phydev;
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 6b7d40d49129..3b0f4bf80650 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -554,6 +554,9 @@ struct macsec_ops;
  * @drv: Pointer to the driver for this PHY instance
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
+ * @phyindex: Unique id across the phy's parent tree of phys to address the PHY
+ *	      from userspace, similar to ifindex. A zero index means the PHY
+ *	      wasn't assigned an id yet.
  * @phy_id: UID for this device found during discovery
  * @c45_ids: 802.3-c45 Device Identifiers if is_c45.
  * @is_c45:  Set to true if this PHY uses clause 45 addressing.
@@ -656,6 +659,7 @@ struct phy_device {
 
 	struct device_link *devlink;
 
+	u32 phyindex;
 	u32 phy_id;
 
 	struct phy_c45_device_ids c45_ids;
diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
new file mode 100644
index 000000000000..68a59e25821c
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
+static inline struct phy_device *
+phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
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
index 4a0a6e703483..c405ed63acfa 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2533,4 +2533,20 @@ struct ethtool_link_settings {
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
index e7260889d4cb..d0e7483abdcd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -158,6 +158,7 @@
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
 #include <net/rps.h>
+#include <linux/phy_link_topology.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -10321,6 +10322,17 @@ static void netdev_do_free_pcpu_stats(struct net_device *dev)
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
@@ -11099,6 +11111,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 #ifdef CONFIG_NET_SCHED
 	hash_init(dev->qdisc_hash);
 #endif
+
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
 
@@ -11191,6 +11204,8 @@ void free_netdev(struct net_device *dev)
 	free_percpu(dev->xdp_bulkq);
 	dev->xdp_bulkq = NULL;
 
+	netdev_free_phy_link_topology(dev);
+
 	/*  Compatibility with error handling in drivers */
 	if (dev->reg_state == NETREG_UNINITIALIZED ||
 	    dev->reg_state == NETREG_DUMMY) {
-- 
2.45.2


