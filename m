Return-Path: <netdev+bounces-94026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 215A08BDFC1
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1317BB26971
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268911509AF;
	Tue,  7 May 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mAfcNcwr"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EFE14F9C3;
	Tue,  7 May 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077714; cv=none; b=bGuxsIP6ZH5dt8sNeCw5XQTR7RdLoycs0DS7OYkFqthGK6gYCDdaAO710eLRendZamS5NT4/x0oJcMvUnHxI7Z/avF47TDQJL/0EiZguTaYsD3g4Dbj8gUEheScJpyzxir3OKHYlR8Pwi8uWJJVLGN1KVvX7B8mrleBxTrQCwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077714; c=relaxed/simple;
	bh=EirpOcfHbhxzX5mT3leqr6K3yZqEuE5UCC8AzPDkzgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2eB7VvOCuizChOH2rk107+YScpip37asmF4aYkW99ut66Ic9n+0y+qCDpZNxIFYSGP00ucvB/zvjdHuOplhT1sOoodCjqWDohRoB3M6BYLcxiAiXMuwaDoFarW7NiTIWglyhLODu2MOfH6IO77mivRvDwYLqF2AEgMfsBnOGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mAfcNcwr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B99FE0004;
	Tue,  7 May 2024 10:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715077708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUadJuWaqhi+XpEWHDh3AN7U2iQoAUeidf5WQOmYOpA=;
	b=mAfcNcwrAZRpbUmnaGm2ZWNEFMXcdCee0YfFjU6W8xu/Exp+ggJzi20dNqMt7Evgd06mj3
	baEHbfAoNkQK8mxvgTmq0K7eFYGGDz4JWW2n9KYKGrWVhF90is/Iaib04gUAZfFfJIJCwf
	I1KIF7xUou9i3pMTJuSOKtrc6YYXYbh4E3yap5RU8lk0hII/+prnIiebvoG6gTifDrYSzL
	8IntoFByLa0syCQkmkAZZyZ0XIiVtg4xayRWDOkU5YrIDn6gVSVzlyfveD4g70OaPevL31
	+YlxiI9RSDe18/eiLxHkkJM/rGhpBw7Ah1gSapSQHndvUqOhfFiGUl3BuBE+Cw==
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
Subject: [PATCH net-next 2/2] net: phy: phy_link_topology: Lazy-initialize the link topology
Date: Tue,  7 May 2024 12:28:21 +0200
Message-ID: <20240507102822.2023826-3-maxime.chevallier@bootlin.com>
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

Having the net_device's init path for the link_topology depend on
IS_REACHABLE(PHYLIB)-protected helpers triggers errors when modules are being
built with phylib as a module as-well, as they expect netdev->link_topo
to be initialized.

Move the link_topo initialization at the first PHY insertion, which will
both improve the memory usage, and make the behaviour more predicatble
and robust.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Fixes: 6916e461e793 ("net: phy: Introduce ethernet link topology representation")
Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
---
 drivers/net/phy/phy_link_topology.c    | 31 ++++++---------------
 include/linux/netdevice.h              |  2 ++
 include/linux/phy_link_topology.h      | 23 ++++++++--------
 include/linux/phy_link_topology_core.h | 23 +++-------------
 net/core/dev.c                         | 38 ++++++++++++++++++++++----
 5 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 0e36bd7c15dc..b1aba9313e73 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -12,29 +12,6 @@
 #include <linux/rtnetlink.h>
 #include <linux/xarray.h>
 
-struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
-{
-	struct phy_link_topology *topo;
-
-	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
-	if (!topo)
-		return ERR_PTR(-ENOMEM);
-
-	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
-	topo->next_phy_index = 1;
-
-	return topo;
-}
-
-void phy_link_topo_destroy(struct phy_link_topology *topo)
-{
-	if (!topo)
-		return;
-
-	xa_destroy(&topo->phys);
-	kfree(topo);
-}
-
 int phy_link_topo_add_phy(struct net_device *dev,
 			  struct phy_device *phy,
 			  enum phy_upstream upt, void *upstream)
@@ -43,6 +20,14 @@ int phy_link_topo_add_phy(struct net_device *dev,
 	struct phy_device_node *pdn;
 	int ret;
 
+	if (!topo) {
+		ret = netdev_alloc_phy_link_topology(dev);
+		if (ret)
+			return ret;
+
+		topo = dev->link_topo;
+	}
+
 	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 	if (!pdn)
 		return -ENOMEM;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf261fb89d73..25a0a77cfadc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4569,6 +4569,8 @@ void __hw_addr_unsync_dev(struct netdev_hw_addr_list *list,
 					const unsigned char *));
 void __hw_addr_init(struct netdev_hw_addr_list *list);
 
+int netdev_alloc_phy_link_topology(struct net_device *dev);
+
 /* Functions used for device addresses handling */
 void dev_addr_mod(struct net_device *dev, unsigned int offset,
 		  const void *addr, size_t len);
diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 166a01710aa2..3501f9a9e932 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -32,10 +32,12 @@ struct phy_device_node {
 	struct phy_device *phy;
 };
 
-struct phy_link_topology {
-	struct xarray phys;
-	u32 next_phy_index;
-};
+#if IS_ENABLED(CONFIG_PHYLIB)
+int phy_link_topo_add_phy(struct net_device *dev,
+			  struct phy_device *phy,
+			  enum phy_upstream upt, void *upstream);
+
+void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
 
 static inline struct phy_device
 *phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
@@ -53,13 +55,6 @@ static inline struct phy_device
 	return NULL;
 }
 
-#if IS_REACHABLE(CONFIG_PHYLIB)
-int phy_link_topo_add_phy(struct net_device *dev,
-			  struct phy_device *phy,
-			  enum phy_upstream upt, void *upstream);
-
-void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
-
 #else
 static inline int phy_link_topo_add_phy(struct net_device *dev,
 					struct phy_device *phy,
@@ -72,6 +67,12 @@ static inline void phy_link_topo_del_phy(struct net_device *dev,
 					 struct phy_device *phy)
 {
 }
+
+static inline struct phy_device *
+phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __PHY_LINK_TOPOLOGY_H */
diff --git a/include/linux/phy_link_topology_core.h b/include/linux/phy_link_topology_core.h
index 0a6479055745..f9c0520806fb 100644
--- a/include/linux/phy_link_topology_core.h
+++ b/include/linux/phy_link_topology_core.h
@@ -2,24 +2,9 @@
 #ifndef __PHY_LINK_TOPOLOGY_CORE_H
 #define __PHY_LINK_TOPOLOGY_CORE_H
 
-struct phy_link_topology;
-
-#if IS_REACHABLE(CONFIG_PHYLIB)
-
-struct phy_link_topology *phy_link_topo_create(struct net_device *dev);
-void phy_link_topo_destroy(struct phy_link_topology *topo);
-
-#else
-
-static inline struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
-{
-	return NULL;
-}
-
-static inline void phy_link_topo_destroy(struct phy_link_topology *topo)
-{
-}
-
-#endif
+struct phy_link_topology {
+	struct xarray phys;
+	u32 next_phy_index;
+};
 
 #endif /* __PHY_LINK_TOPOLOGY_CORE_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index d2ce91a334c1..1b4ffc273a04 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10256,6 +10256,35 @@ static void netdev_do_free_pcpu_stats(struct net_device *dev)
 	}
 }
 
+int netdev_alloc_phy_link_topology(struct net_device *dev)
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
+EXPORT_SYMBOL_GPL(netdev_alloc_phy_link_topology);
+
+static void netdev_free_phy_link_topology(struct net_device *dev)
+{
+	struct phy_link_topology *topo = dev->link_topo;
+
+	if (!topo)
+		return;
+
+	xa_destroy(&topo->phys);
+	kfree(topo);
+	dev->link_topo = NULL;
+}
+
 /**
  * register_netdevice() - register a network device
  * @dev: device to register
@@ -10998,11 +11027,6 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 #ifdef CONFIG_NET_SCHED
 	hash_init(dev->qdisc_hash);
 #endif
-	dev->link_topo = phy_link_topo_create(dev);
-	if (IS_ERR(dev->link_topo)) {
-		dev->link_topo = NULL;
-		goto free_all;
-	}
 
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
@@ -11092,7 +11116,9 @@ void free_netdev(struct net_device *dev)
 	free_percpu(dev->xdp_bulkq);
 	dev->xdp_bulkq = NULL;
 
-	phy_link_topo_destroy(dev->link_topo);
+#if IS_ENABLED(CONFIG_PHYLIB)
+	netdev_free_phy_link_topology(dev);
+#endif
 
 	/*  Compatibility with error handling in drivers */
 	if (dev->reg_state == NETREG_UNINITIALIZED ||
-- 
2.44.0


