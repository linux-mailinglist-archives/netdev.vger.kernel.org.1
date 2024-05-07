Return-Path: <netdev+bounces-94025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD338BDFBF
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC951C23295
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F361214F9F0;
	Tue,  7 May 2024 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OlAq8jOo"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54C14EC76;
	Tue,  7 May 2024 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077711; cv=none; b=bRSmJEKcNlMEm/5qSKJ/pNdd1nI6KD7OuZ3Q3smy9wvYooKR4yVm0WV+wzpSYupZABNkqOBrLiSlCcqOFjN+23SqlqW9oggbyXQnJnrBV1dMZYtUQRHOVb+hxLS/RVFCNfEnJQ1sHOluuKW1j5eeZr/wxRCz1ft3MwBNbuyZbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077711; c=relaxed/simple;
	bh=CRCJ3ykaVSd3ZnBKJHBvW/w+eALP52wdcUbDA3bJM9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fG275MuV1ZiHG8ErkQRJ5BVhaK9V3ULTEB18UQvdWbguNBJ9+X1QtOgmec+KCLV3wpWiEjyxFO3kBYgczEbVSaOPPpWMlmgZJ8XbPCoZPV648AUC8FLmw9QEW4uUUAexzvqU7z6DLgBGsvincIulqicRBMhpwLGAmJWyBWTBQCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OlAq8jOo; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29F12E0007;
	Tue,  7 May 2024 10:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715077707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKWwksuY0e8vW4zcYVLDtjcgbFHAfKZqWORMINnwKqM=;
	b=OlAq8jOoJ75+I17s98OlHPmCCr9feqYy00e5yuFdxIyXcwxYITG6RhmUWC7CFkMjy7WnGO
	3MFuz/wCfPl/jRuJMCIb80pdCBKKucqcsCG+FniG/FRtghfUzy5svditQh6x+Q2PrB/f6o
	f/kWJwN/IvAY3rxCRNlLIP7W8PseU5HOB7CVyPXVD7r3dfwrR/ipCTWiE+F9JfCQLNzMrB
	/1Qy6DxphY0YhvLgISzRzEwSQ+m1/vERXBbZzfo1RBl3Ysl/HDwp8J40DCPRvVtvFk/4cV
	A168qZxKZi51Ua6o5WxlltSPMZ4QtKAdOvj9DvH7GIpsLIdgrhleUGJs9fWA5g==
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
Subject: [PATCH net-next 1/2] net: phy: phy_link_topology: Pass netdevice to phy_link_topo helpers
Date: Tue,  7 May 2024 12:28:20 +0200
Message-ID: <20240507102822.2023826-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507102822.2023826-1-maxime.chevallier@bootlin.com>
References: <20240507102822.2023826-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The phy link topology's main goal is to better track which PHYs are
connected to a given netdevice. Make so that the helpers take the
netdevice as a parameter directly.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Fixes: 6916e461e793 ("net: phy: Introduce ethernet link topology representation")
Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
---
 drivers/net/phy/phy_device.c        | 25 ++++++++-----------------
 drivers/net/phy/phy_link_topology.c | 13 ++++++++++---
 include/linux/phy_link_topology.h   | 21 +++++++++++++--------
 net/ethtool/netlink.c               |  2 +-
 4 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 616bd7ba46cb..111434201545 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -277,14 +277,6 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
 
 static struct phy_driver genphy_driver;
 
-static struct phy_link_topology *phy_get_link_topology(struct phy_device *phydev)
-{
-	if (phydev->attached_dev)
-		return phydev->attached_dev->link_topo;
-
-	return NULL;
-}
-
 static LIST_HEAD(phy_fixup_list);
 static DEFINE_MUTEX(phy_fixup_lock);
 
@@ -1389,10 +1381,10 @@ static DEVICE_ATTR_RO(phy_standalone);
 int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
 {
 	struct phy_device *phydev = upstream;
-	struct phy_link_topology *topo = phy_get_link_topology(phydev);
+	struct net_device *dev = phydev->attached_dev;
 
-	if (topo)
-		return phy_link_topo_add_phy(topo, phy, PHY_UPSTREAM_PHY, phydev);
+	if (dev)
+		return phy_link_topo_add_phy(dev, phy, PHY_UPSTREAM_PHY, phydev);
 
 	return 0;
 }
@@ -1411,10 +1403,10 @@ EXPORT_SYMBOL(phy_sfp_connect_phy);
 void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy)
 {
 	struct phy_device *phydev = upstream;
-	struct phy_link_topology *topo = phy_get_link_topology(phydev);
+	struct net_device *dev = phydev->attached_dev;
 
-	if (topo)
-		phy_link_topo_del_phy(topo, phy);
+	if (dev)
+		phy_link_topo_del_phy(dev, phy);
 }
 EXPORT_SYMBOL(phy_sfp_disconnect_phy);
 
@@ -1561,8 +1553,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		if (phydev->sfp_bus_attached)
 			dev->sfp_bus = phydev->sfp_bus;
 
-		err = phy_link_topo_add_phy(dev->link_topo, phydev,
-					    PHY_UPSTREAM_MAC, dev);
+		err = phy_link_topo_add_phy(dev, phydev, PHY_UPSTREAM_MAC, dev);
 		if (err)
 			goto error;
 	}
@@ -1992,7 +1983,7 @@ void phy_detach(struct phy_device *phydev)
 	if (dev) {
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
-		phy_link_topo_del_phy(dev->link_topo, phydev);
+		phy_link_topo_del_phy(dev, phydev);
 	}
 	phydev->phylink = NULL;
 
diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 985941c5c558..0e36bd7c15dc 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -35,10 +35,11 @@ void phy_link_topo_destroy(struct phy_link_topology *topo)
 	kfree(topo);
 }
 
-int phy_link_topo_add_phy(struct phy_link_topology *topo,
+int phy_link_topo_add_phy(struct net_device *dev,
 			  struct phy_device *phy,
 			  enum phy_upstream upt, void *upstream)
 {
+	struct phy_link_topology *topo = dev->link_topo;
 	struct phy_device_node *pdn;
 	int ret;
 
@@ -90,10 +91,16 @@ int phy_link_topo_add_phy(struct phy_link_topology *topo,
 }
 EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
 
-void phy_link_topo_del_phy(struct phy_link_topology *topo,
+void phy_link_topo_del_phy(struct net_device *dev,
 			   struct phy_device *phy)
 {
-	struct phy_device_node *pdn = xa_erase(&topo->phys, phy->phyindex);
+	struct phy_link_topology *topo = dev->link_topo;
+	struct phy_device_node *pdn;
+
+	if (!topo)
+		return;
+
+	pdn = xa_erase(&topo->phys, phy->phyindex);
 
 	/* We delete the PHY from the topology, however we don't re-set the
 	 * phy->phyindex field. If the PHY isn't gone, we can re-assign it the
diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 6b79feb607e7..166a01710aa2 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -12,11 +12,11 @@
 #define __PHY_LINK_TOPOLOGY_H
 
 #include <linux/ethtool.h>
+#include <linux/netdevice.h>
 #include <linux/phy_link_topology_core.h>
 
 struct xarray;
 struct phy_device;
-struct net_device;
 struct sfp_bus;
 
 struct phy_device_node {
@@ -37,11 +37,16 @@ struct phy_link_topology {
 	u32 next_phy_index;
 };
 
-static inline struct phy_device *
-phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
+static inline struct phy_device
+*phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 {
-	struct phy_device_node *pdn = xa_load(&topo->phys, phyindex);
+	struct phy_link_topology *topo = dev->link_topo;
+	struct phy_device_node *pdn;
 
+	if (!topo)
+		return NULL;
+
+	pdn = xa_load(&topo->phys, phyindex);
 	if (pdn)
 		return pdn->phy;
 
@@ -49,21 +54,21 @@ phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
 }
 
 #if IS_REACHABLE(CONFIG_PHYLIB)
-int phy_link_topo_add_phy(struct phy_link_topology *topo,
+int phy_link_topo_add_phy(struct net_device *dev,
 			  struct phy_device *phy,
 			  enum phy_upstream upt, void *upstream);
 
-void phy_link_topo_del_phy(struct phy_link_topology *lt, struct phy_device *phy);
+void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
 
 #else
-static inline int phy_link_topo_add_phy(struct phy_link_topology *topo,
+static inline int phy_link_topo_add_phy(struct net_device *dev,
 					struct phy_device *phy,
 					enum phy_upstream upt, void *upstream)
 {
 	return 0;
 }
 
-static inline void phy_link_topo_del_phy(struct phy_link_topology *topo,
+static inline void phy_link_topo_del_phy(struct net_device *dev,
 					 struct phy_device *phy)
 {
 }
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 563e94e0cbd8..f5b4adf324bc 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -170,7 +170,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 			struct nlattr *phy_id;
 
 			phy_id = tb[ETHTOOL_A_HEADER_PHY_INDEX];
-			phydev = phy_link_topo_get_phy(dev->link_topo,
+			phydev = phy_link_topo_get_phy(dev,
 						       nla_get_u32(phy_id));
 			if (!phydev) {
 				NL_SET_BAD_ATTR(extack, phy_id);
-- 
2.44.0


