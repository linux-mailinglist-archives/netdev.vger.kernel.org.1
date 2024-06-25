Return-Path: <netdev+bounces-106449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5CA91669E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E781F232E2
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C027714B96D;
	Tue, 25 Jun 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJia8akJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC79156879;
	Tue, 25 Jun 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316208; cv=none; b=S1aE42D+t0KCT7lMPbMEemB6a/LVnnWlIgqDqCYD6EUEFZFjH4bpgpqt7l/FeP0ZJMN1DE0zzD2zkpGbEtdVCWTZzHz1OxcwTbiHL5TzJTyIif02rpFx9iMicXqp3f97bBGMFctG5vub6G9MNUrPGbAv6j/E6Vo9azSJe9y6ia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316208; c=relaxed/simple;
	bh=Nfg6/Q4Gt/+n9V0iItNy++z4KKE7+NVFr30BfFrr0pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBAOz6mQr9wHe/2kPbVHl2T3ocD1zVyUKipvI2eJXKzY00vdrflq+8nuTFYIIxDWUbOZCk+88OymFRd5w22gLb0SJF3RwbuUxvC8BC46s/nLwVpIWUAmmoiDSCr55RPIfy4p9gj2nI1wi4nVejYFZ9BBi9vM9r3txFMbYYAn+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJia8akJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719316206; x=1750852206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nfg6/Q4Gt/+n9V0iItNy++z4KKE7+NVFr30BfFrr0pE=;
  b=LJia8akJ4+gReelkV4ktiX89rOiimLt3441/UMf8yWhy6ficn1NXrLOF
   xt0zxtAZgN6BaLzA9k/KjA7rWQfhoY5X4QQGLLiBzP4NwoQFkDHBfAfKo
   +E59ASqhtSbrd/7WvwDV4FOkaURDxNDf/t1qGEJxuqYSx3Q6qEv98jkTk
   vSC+M87OWkqhpExynx9EAxeQB+FJDP6+tyhPMfwfm/q1FKJPQ5xtSjjO0
   Rg0Eg8Ba7lKpnckqPimayEI66ZasbKD16TFTwrfLmN00FOVtE09cCGSqc
   +lGgPTXrHha7EkVLnGvWFmpXaMfAlS6xVakNuzb2QlZMR53XRdmZIej4k
   g==;
X-CSE-ConnectionGUID: VanuqIn3SC6K7c9lRWISZA==
X-CSE-MsgGUID: FwfWaAHwRc+Qdmj2CVXizQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="20104408"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="20104408"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 04:50:06 -0700
X-CSE-ConnectionGUID: jOgdUbIwTU2Qa1+OGBq1BA==
X-CSE-MsgGUID: LdzQDS40QbKiLE6Ihoizag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43724733"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 25 Jun 2024 04:50:02 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] netdev_features: convert NETIF_F_LLTX to dev->lltx
Date: Tue, 25 Jun 2024 13:44:30 +0200
Message-ID: <20240625114432.1398320-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETIF_F_LLTX can't be changed via Ethtool and is not a feature,
rather an attribute, very similar to IFF_NO_QUEUE (and hot).
Free one netdev_features_t bit and make it a private flag.
Now the LLTX bit sits in the first ("Tx read-mostly") cacheline
next to netdev_ops, so that the start_xmit locking code will
potentially read 1 cacheline less, nice.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 Documentation/networking/netdev-features.rst      | 8 --------
 Documentation/networking/netdevices.rst           | 4 ++--
 drivers/net/ethernet/tehuti/tehuti.h              | 2 +-
 include/linux/netdev_features.h                   | 5 +----
 include/linux/netdevice.h                         | 9 ++++++---
 drivers/net/amt.c                                 | 2 +-
 drivers/net/bareudp.c                             | 2 +-
 drivers/net/bonding/bond_main.c                   | 2 +-
 drivers/net/dummy.c                               | 3 ++-
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c         | 3 ++-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c    | 3 ++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 3 ++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c    | 3 ++-
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c | 3 +--
 drivers/net/ethernet/pasemi/pasemi_mac.c          | 5 +++--
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 2 +-
 drivers/net/ethernet/sfc/ef100_rep.c              | 4 ++--
 drivers/net/ethernet/tehuti/tehuti.c              | 4 ++--
 drivers/net/ethernet/toshiba/spider_net.c         | 3 ++-
 drivers/net/geneve.c                              | 2 +-
 drivers/net/gtp.c                                 | 2 +-
 drivers/net/hamradio/bpqether.c                   | 2 +-
 drivers/net/ipvlan/ipvlan_main.c                  | 3 ++-
 drivers/net/loopback.c                            | 2 +-
 drivers/net/macsec.c                              | 4 ++--
 drivers/net/macvlan.c                             | 3 ++-
 drivers/net/net_failover.c                        | 2 +-
 drivers/net/netkit.c                              | 3 ++-
 drivers/net/nlmon.c                               | 4 ++--
 drivers/net/ppp/ppp_generic.c                     | 2 +-
 drivers/net/rionet.c                              | 2 +-
 drivers/net/team/team_core.c                      | 2 +-
 drivers/net/tun.c                                 | 5 +++--
 drivers/net/veth.c                                | 2 +-
 drivers/net/vrf.c                                 | 2 +-
 drivers/net/vsockmon.c                            | 4 ++--
 drivers/net/vxlan/vxlan_core.c                    | 2 +-
 drivers/net/wireguard/device.c                    | 2 +-
 drivers/staging/octeon/ethernet.c                 | 2 +-
 lib/test_bpf.c                                    | 3 +--
 net/8021q/vlan_dev.c                              | 4 ++--
 net/batman-adv/soft-interface.c                   | 2 +-
 net/bridge/br_device.c                            | 3 ++-
 net/core/net-sysfs.c                              | 3 +--
 net/dsa/user.c                                    | 3 ++-
 net/ethtool/common.c                              | 1 -
 net/hsr/hsr_device.c                              | 4 ++--
 net/ipv4/ip_gre.c                                 | 4 +++-
 net/ipv4/ip_vti.c                                 | 2 +-
 net/ipv4/ipip.c                                   | 2 +-
 net/ipv6/ip6_gre.c                                | 4 +++-
 net/ipv6/ip6_tunnel.c                             | 2 +-
 net/ipv6/sit.c                                    | 2 +-
 net/l2tp/l2tp_eth.c                               | 2 +-
 net/openvswitch/vport-internal_dev.c              | 9 +++++----
 net/xfrm/xfrm_interface_core.c                    | 2 +-
 56 files changed, 90 insertions(+), 84 deletions(-)

diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index d7b15bb64deb..f29d982ebf5d 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -139,14 +139,6 @@ chained skbs (skb->next/prev list).
 Features contained in NETIF_F_SOFT_FEATURES are features of networking
 stack. Driver should not change behaviour based on them.
 
- * LLTX driver (deprecated for hardware drivers)
-
-NETIF_F_LLTX is meant to be used by drivers that don't need locking at all,
-e.g. software tunnels.
-
-This is also used in a few legacy drivers that implement their
-own locking, don't use it for new (hardware) drivers.
-
  * netns-local device
 
 NETIF_F_NETNS_LOCAL is set for devices that are not allowed to move between
diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index c2476917a6c3..857c9784f87e 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -258,11 +258,11 @@ ndo_get_stats:
 ndo_start_xmit:
 	Synchronization: __netif_tx_lock spinlock.
 
-	When the driver sets NETIF_F_LLTX in dev->features this will be
+	When the driver sets dev->lltx this will be
 	called without holding netif_tx_lock. In this case the driver
 	has to lock by itself when needed.
 	The locking there should also properly protect against
-	set_rx_mode. WARNING: use of NETIF_F_LLTX is deprecated.
+	set_rx_mode. WARNING: use of dev->lltx is deprecated.
 	Don't use it for new drivers.
 
 	Context: Process with BHs disabled or BH (timer),
diff --git a/drivers/net/ethernet/tehuti/tehuti.h b/drivers/net/ethernet/tehuti/tehuti.h
index 909e7296cecf..47a2d3e5f8ed 100644
--- a/drivers/net/ethernet/tehuti/tehuti.h
+++ b/drivers/net/ethernet/tehuti/tehuti.h
@@ -260,7 +260,7 @@ struct bdx_priv {
 	int tx_update_mark;
 	int tx_noupd;
 #endif
-	spinlock_t tx_lock;	/* NETIF_F_LLTX mode */
+	spinlock_t tx_lock;	/* dev->lltx mode */
 
 	/* rarely used */
 	u8 port;
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 44c428d62db4..54d1578f6642 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -23,8 +23,6 @@ enum {
 	NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAGs */
 	NETIF_F_VLAN_CHALLENGED_BIT,	/* Device cannot handle VLAN packets */
 	NETIF_F_GSO_BIT,		/* Enable software GSO. */
-	NETIF_F_LLTX_BIT,		/* LockLess TX - deprecated. Please */
-					/* do not use LLTX in new drivers */
 	NETIF_F_NETNS_LOCAL_BIT,	/* Does not change network namespaces */
 	NETIF_F_GRO_BIT,		/* Generic receive offload */
 	NETIF_F_LRO_BIT,		/* large receive offload */
@@ -119,7 +117,6 @@ enum {
 #define NETIF_F_HW_VLAN_CTAG_TX	__NETIF_F(HW_VLAN_CTAG_TX)
 #define NETIF_F_IP_CSUM		__NETIF_F(IP_CSUM)
 #define NETIF_F_IPV6_CSUM	__NETIF_F(IPV6_CSUM)
-#define NETIF_F_LLTX		__NETIF_F(LLTX)
 #define NETIF_F_LOOPBACK	__NETIF_F(LOOPBACK)
 #define NETIF_F_LRO		__NETIF_F(LRO)
 #define NETIF_F_NETNS_LOCAL	__NETIF_F(NETNS_LOCAL)
@@ -192,7 +189,7 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 /* Features valid for ethtool to change */
 /* = all defined minus driver/device-class-related */
 #define NETIF_F_NEVER_CHANGE	(NETIF_F_VLAN_CHALLENGED | \
-				 NETIF_F_LLTX | NETIF_F_NETNS_LOCAL)
+				 NETIF_F_NETNS_LOCAL)
 
 /* remember that ((t)1 << t_BITS) is undefined in C99 */
 #define NETIF_F_ETHTOOL_BITS	((__NETIF_F_BIT(NETDEV_FEATURE_COUNT - 1) | \
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4fddf57f40d9..9acbd93188a3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1753,6 +1753,8 @@ enum netdev_reg_state {
  *			regardless of source, even if those aren't
  *			HWTSTAMP_SOURCE_NETDEV
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
+ *	@lltx:		device supports lockless Tx. Mainly used by logical
+ *			interfaces, such as tunnels
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
@@ -2046,6 +2048,7 @@ struct net_device {
 		unsigned long		priv_flags:32;
 		unsigned long		see_all_hwtstamp_requests:1;
 		unsigned long		change_proto_down:1;
+		unsigned long		lltx:1;
 	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;
@@ -4449,7 +4452,7 @@ static inline void netif_tx_unlock_bh(struct net_device *dev)
 }
 
 #define HARD_TX_LOCK(dev, txq, cpu) {			\
-	if ((dev->features & NETIF_F_LLTX) == 0) {	\
+	if (!(dev)->lltx) {				\
 		__netif_tx_lock(txq, cpu);		\
 	} else {					\
 		__netif_tx_acquire(txq);		\
@@ -4457,12 +4460,12 @@ static inline void netif_tx_unlock_bh(struct net_device *dev)
 }
 
 #define HARD_TX_TRYLOCK(dev, txq)			\
-	(((dev->features & NETIF_F_LLTX) == 0) ?	\
+	(!(dev)->lltx ?					\
 		__netif_tx_trylock(txq) :		\
 		__netif_tx_acquire(txq))
 
 #define HARD_TX_UNLOCK(dev, txq) {			\
-	if ((dev->features & NETIF_F_LLTX) == 0) {	\
+	if (!(dev)->lltx) {				\
 		__netif_tx_unlock(txq);			\
 	} else {					\
 		__netif_tx_release(txq);		\
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 6d15ab3bfbbc..921bbfd72a38 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3098,7 +3098,7 @@ static void amt_link_setup(struct net_device *dev)
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
 	dev->priv_flags		|= IFF_NO_QUEUE;
-	dev->features		|= NETIF_F_LLTX;
+	dev->lltx		= true;
 	dev->features		|= NETIF_F_GSO_SOFTWARE;
 	dev->features		|= NETIF_F_NETNS_LOCAL;
 	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index d5c56ca91b77..6f4de883e872 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -553,7 +553,6 @@ static void bareudp_setup(struct net_device *dev)
 	SET_NETDEV_DEVTYPE(dev, &bareudp_type);
 	dev->features    |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->features    |= NETIF_F_RXCSUM;
-	dev->features    |= NETIF_F_LLTX;
 	dev->features    |= NETIF_F_GSO_SOFTWARE;
 	dev->hw_features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->hw_features |= NETIF_F_RXCSUM;
@@ -566,6 +565,7 @@ static void bareudp_setup(struct net_device *dev)
 	dev->type = ARPHRD_NONE;
 	netif_keep_dst(dev);
 	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->lltx = true;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 }
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3c3fcce4acd4..b5d1dd4ebf7a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5886,7 +5886,7 @@ void bond_setup(struct net_device *bond_dev)
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	/* don't acquire bond device's netif_tx_lock when transmitting */
-	bond_dev->features |= NETIF_F_LLTX;
+	bond_dev->lltx = true;
 
 	/* By default, we declare the bond to be fully
 	 * VLAN hardware accelerated capable. Special
diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index d29b5d7af0d7..e9c5e1e11fa0 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -109,9 +109,10 @@ static void dummy_setup(struct net_device *dev)
 	dev->flags |= IFF_NOARP;
 	dev->flags &= ~IFF_MULTICAST;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
+	dev->lltx = true;
 	dev->features	|= NETIF_F_SG | NETIF_F_FRAGLIST;
 	dev->features	|= NETIF_F_GSO_SOFTWARE;
-	dev->features	|= NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_LLTX;
+	dev->features	|= NETIF_F_HW_CSUM | NETIF_F_HIGHDMA;
 	dev->features	|= NETIF_F_GSO_ENCAP_ALL;
 	dev->hw_features |= dev->features;
 	dev->hw_enc_features |= dev->features;
diff --git a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
index 7d7d3e0098df..3b7068832f95 100644
--- a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
+++ b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
@@ -1034,7 +1034,8 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		netdev->hw_features |= NETIF_F_SG | NETIF_F_IP_CSUM |
 			NETIF_F_RXCSUM;
 		netdev->features |= NETIF_F_SG | NETIF_F_IP_CSUM |
-			NETIF_F_RXCSUM | NETIF_F_LLTX | NETIF_F_HIGHDMA;
+			NETIF_F_RXCSUM | NETIF_F_HIGHDMA;
+		netdev->lltx = true;
 
 		if (vlan_tso_capable(adapter)) {
 			netdev->features |=
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index baa0b3c2ce6f..8840ecfd355d 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -229,7 +229,7 @@ static int dpaa_netdev_init(struct net_device *net_dev,
 	net_dev->max_mtu = dpaa_get_max_mtu();
 
 	net_dev->hw_features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-				 NETIF_F_LLTX | NETIF_F_RXHASH);
+				 NETIF_F_RXHASH);
 
 	net_dev->hw_features |= NETIF_F_SG | NETIF_F_HIGHDMA;
 	/* The kernels enables GSO automatically, if we declare NETIF_F_SG.
@@ -239,6 +239,7 @@ static int dpaa_netdev_init(struct net_device *net_dev,
 	net_dev->features |= NETIF_F_RXCSUM;
 
 	net_dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	net_dev->lltx = true;
 	/* we do not want shared skbs on TX */
 	net_dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 6866807973da..29886a8ba73f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4594,12 +4594,13 @@ static int dpaa2_eth_netdev_init(struct net_device *net_dev)
 
 	net_dev->priv_flags |= supported;
 	net_dev->priv_flags &= ~not_supported;
+	net_dev->lltx = true;
 
 	/* Features */
 	net_dev->features = NETIF_F_RXCSUM |
 			    NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			    NETIF_F_SG | NETIF_F_HIGHDMA |
-			    NETIF_F_LLTX | NETIF_F_HW_TC | NETIF_F_TSO;
+			    NETIF_F_HW_TC | NETIF_F_TSO;
 	net_dev->gso_max_segs = DPAA2_ETH_ENQUEUE_MAX_FDS;
 	net_dev->hw_features = net_dev->features;
 	net_dev->xdp_features = NETDEV_XDP_ACT_BASIC |
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index f064789f3240..44d6e125bd6f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1676,9 +1676,10 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 
 	netif_carrier_off(dev);
 
-	dev->features |= NETIF_F_NETNS_LOCAL | NETIF_F_LLTX | NETIF_F_SG |
+	dev->features |= NETIF_F_NETNS_LOCAL | NETIF_F_SG |
 			 NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_TC;
 	dev->hw_features |= NETIF_F_HW_TC | NETIF_F_LOOPBACK;
+	dev->lltx = true;
 
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = MLXSW_PORT_MAX_MTU - MLXSW_PORT_ETH_FRAME_HDR;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index eee0bfc41074..227e7a5d712e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -248,7 +248,6 @@ nfp_repr_fix_features(struct net_device *netdev, netdev_features_t features)
 
 	features = netdev_intersect_features(features, lower_features);
 	features |= old_features & (NETIF_F_SOFT_FEATURES | NETIF_F_HW_TC);
-	features |= NETIF_F_LLTX;
 
 	return features;
 }
@@ -386,7 +385,7 @@ int nfp_repr_init(struct nfp_app *app, struct net_device *netdev,
 	netif_set_tso_max_segs(netdev, NFP_NET_LSO_MAX_SEGS);
 
 	netdev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL;
-	netdev->features |= NETIF_F_LLTX;
+	netdev->lltx = true;
 
 	if (nfp_app_has_tc(app)) {
 		netdev->features |= NETIF_F_HW_TC;
diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index 62ba269da902..cb4e12df7719 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1699,8 +1699,9 @@ pasemi_mac_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netif_napi_add(dev, &mac->napi, pasemi_mac_poll);
 
-	dev->features = NETIF_F_IP_CSUM | NETIF_F_LLTX | NETIF_F_SG |
-			NETIF_F_HIGHDMA | NETIF_F_GSO;
+	dev->features = NETIF_F_IP_CSUM | NETIF_F_SG | NETIF_F_HIGHDMA |
+			NETIF_F_GSO;
+	dev->lltx = true;
 
 	mac->dma_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa007, NULL);
 	if (!mac->dma_pdev) {
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index f1e40aade127..4f0ddcedfa97 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -286,7 +286,7 @@ void rmnet_vnd_setup(struct net_device *rmnet_dev)
 	rmnet_dev->needs_free_netdev = true;
 	rmnet_dev->ethtool_ops = &rmnet_ethtool_ops;
 
-	rmnet_dev->features |= NETIF_F_LLTX;
+	rmnet_dev->lltx = true;
 
 	/* This perm addr will be used as interface identifier by IPv6 */
 	rmnet_dev->addr_assign_type = NET_ADDR_RANDOM;
diff --git a/drivers/net/ethernet/sfc/ef100_rep.c b/drivers/net/ethernet/sfc/ef100_rep.c
index 0b3083ef0ead..e923e1796369 100644
--- a/drivers/net/ethernet/sfc/ef100_rep.c
+++ b/drivers/net/ethernet/sfc/ef100_rep.c
@@ -233,8 +233,8 @@ static struct efx_rep *efx_ef100_rep_create_netdev(struct efx_nic *efx,
 	net_dev->ethtool_ops = &efx_ef100_rep_ethtool_ops;
 	net_dev->min_mtu = EFX_MIN_MTU;
 	net_dev->max_mtu = EFX_MAX_MTU;
-	net_dev->features |= NETIF_F_LLTX;
-	net_dev->hw_features |= NETIF_F_LLTX;
+	net_dev->lltx = true;
+
 	return efv;
 fail1:
 	free_netdev(net_dev);
diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
index ede5f7890fb4..fc77f424f90b 100644
--- a/drivers/net/ethernet/tehuti/tehuti.c
+++ b/drivers/net/ethernet/tehuti/tehuti.c
@@ -1671,7 +1671,7 @@ static netdev_tx_t bdx_tx_transmit(struct sk_buff *skb,
 
 #endif
 #ifdef BDX_LLTX
-	netif_trans_update(ndev); /* NETIF_F_LLTX driver :( */
+	netif_trans_update(ndev); /* dev->lltx driver :( */
 #endif
 	ndev->stats.tx_packets++;
 	ndev->stats.tx_bytes += skb->len;
@@ -2019,7 +2019,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 * set multicast list callback has to use priv->tx_lock.
 		 */
 #ifdef BDX_LLTX
-		ndev->features |= NETIF_F_LLTX;
+		ndev->lltx = true;
 #endif
 		/* MTU range: 60 - 16384 */
 		ndev->min_mtu = ETH_ZLEN;
diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index 87e67121477c..a4937c18d7cb 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -2277,10 +2277,11 @@ spider_net_setup_netdev(struct spider_net_card *card)
 	netdev->hw_features = NETIF_F_RXCSUM | NETIF_F_IP_CSUM;
 	if (SPIDER_NET_RX_CSUM_DEFAULT)
 		netdev->features |= NETIF_F_RXCSUM;
-	netdev->features |= NETIF_F_IP_CSUM | NETIF_F_LLTX;
+	netdev->features |= NETIF_F_IP_CSUM;
 	/* some time: NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 	 *		NETIF_F_HW_VLAN_CTAG_FILTER
 	 */
+	netdev->lltx = true;
 
 	/* MTU range: 64 - 2294 */
 	netdev->min_mtu = SPIDER_NET_MIN_MTU;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 838e85ddec67..7f611c74eb62 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1194,7 +1194,6 @@ static void geneve_setup(struct net_device *dev)
 
 	SET_NETDEV_DEVTYPE(dev, &geneve_type);
 
-	dev->features    |= NETIF_F_LLTX;
 	dev->features    |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->features    |= NETIF_F_RXCSUM;
 	dev->features    |= NETIF_F_GSO_SOFTWARE;
@@ -1215,6 +1214,7 @@ static void geneve_setup(struct net_device *dev)
 	netif_keep_dst(dev);
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
+	dev->lltx = true;
 	eth_hw_addr_random(dev);
 }
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 427b91aca50d..1a4afb216a01 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1353,7 +1353,7 @@ static void gtp_link_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->priv_flags	|= IFF_NO_QUEUE;
-	dev->features	|= NETIF_F_LLTX;
+	dev->lltx = true;
 	netif_keep_dst(dev);
 
 	dev->needed_headroom	= LL_MAX_HEADER + GTP_IPV4_MAXLEN;
diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index 83a16d10eedb..bac1bb69d63a 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -458,7 +458,7 @@ static void bpq_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 
 	dev->flags      = 0;
-	dev->features	= NETIF_F_LLTX;	/* Allow recursion */
+	dev->lltx = true;	/* Allow recursion */
 
 #if IS_ENABLED(CONFIG_AX25)
 	dev->header_ops      = &ax25_header_ops;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 094f44dac5c8..ee2c3cf4df36 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -114,7 +114,7 @@ static void ipvlan_port_destroy(struct net_device *dev)
 	 NETIF_F_GSO_ROBUST | NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL)
 
 #define IPVLAN_ALWAYS_ON \
-	(IPVLAN_ALWAYS_ON_OFLOADS | NETIF_F_LLTX | NETIF_F_VLAN_CHALLENGED)
+	(IPVLAN_ALWAYS_ON_OFLOADS | NETIF_F_VLAN_CHALLENGED)
 
 #define IPVLAN_FEATURES \
 	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
@@ -141,6 +141,7 @@ static int ipvlan_init(struct net_device *dev)
 	dev->vlan_features = phy_dev->vlan_features & IPVLAN_FEATURES;
 	dev->vlan_features |= IPVLAN_ALWAYS_ON_OFLOADS;
 	dev->hw_enc_features |= dev->features;
+	dev->lltx = true;
 	netif_inherit_tso_max(dev, phy_dev);
 	dev->hard_header_len = phy_dev->hard_header_len;
 
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 2b486e7c749c..bf857782be0f 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -171,6 +171,7 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->type		= ARPHRD_LOOPBACK;	/* 0x0001*/
 	dev->flags		= IFF_LOOPBACK;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
+	dev->lltx		= true;
 	netif_keep_dst(dev);
 	dev->hw_features	= NETIF_F_GSO_SOFTWARE;
 	dev->features		= NETIF_F_SG | NETIF_F_FRAGLIST
@@ -179,7 +180,6 @@ static void gen_lo_setup(struct net_device *dev,
 		| NETIF_F_RXCSUM
 		| NETIF_F_SCTP_CRC
 		| NETIF_F_HIGHDMA
-		| NETIF_F_LLTX
 		| NETIF_F_NETNS_LOCAL
 		| NETIF_F_VLAN_CHALLENGED
 		| NETIF_F_LOOPBACK;
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 2da70bc3dd86..12d1b205f6d1 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3550,7 +3550,8 @@ static int macsec_dev_init(struct net_device *dev)
 		return err;
 
 	dev->features = real_dev->features & MACSEC_FEATURES;
-	dev->features |= NETIF_F_LLTX | NETIF_F_GSO_SOFTWARE;
+	dev->features |= NETIF_F_GSO_SOFTWARE;
+	dev->lltx = true;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	macsec_set_head_tail_room(dev);
@@ -3581,7 +3582,6 @@ static netdev_features_t macsec_fix_features(struct net_device *dev,
 
 	features &= (real_dev->features & MACSEC_FEATURES) |
 		    NETIF_F_GSO_SOFTWARE | NETIF_F_SOFT_FEATURES;
-	features |= NETIF_F_LLTX;
 
 	return features;
 }
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 3aa6d33efdf5..7f8bfca7f17d 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -900,7 +900,7 @@ static struct lock_class_key macvlan_netdev_addr_lock_key;
 	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE | \
 	 NETIF_F_GSO_ROBUST | NETIF_F_GSO_ENCAP_ALL)
 
-#define ALWAYS_ON_FEATURES (ALWAYS_ON_OFFLOADS | NETIF_F_LLTX)
+#define ALWAYS_ON_FEATURES ALWAYS_ON_OFFLOADS
 
 #define MACVLAN_FEATURES \
 	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
@@ -932,6 +932,7 @@ static int macvlan_init(struct net_device *dev)
 	dev->vlan_features	= lowerdev->vlan_features & MACVLAN_FEATURES;
 	dev->vlan_features	|= ALWAYS_ON_OFFLOADS;
 	dev->hw_enc_features    |= dev->features;
+	dev->lltx		= true;
 	netif_inherit_tso_max(dev, lowerdev);
 	dev->hard_header_len	= lowerdev->hard_header_len;
 	macvlan_set_lockdep_class(dev);
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 963d8b4af28d..06728385a35f 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -731,7 +731,7 @@ struct failover *net_failover_create(struct net_device *standby_dev)
 				       IFF_TX_SKB_SHARING);
 
 	/* don't acquire failover netdev's netif_tx_lock when transmitting */
-	failover_dev->features |= NETIF_F_LLTX;
+	failover_dev->lltx = true;
 
 	/* Don't allow failover devices to change network namespaces. */
 	failover_dev->features |= NETIF_F_NETNS_LOCAL;
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 16789cd446e9..79232f5cc088 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -255,11 +255,12 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
 	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->lltx = true;
 
 	dev->ethtool_ops = &netkit_ethtool_ops;
 	dev->netdev_ops  = &netkit_netdev_ops;
 
-	dev->features |= netkit_features | NETIF_F_LLTX;
+	dev->features |= netkit_features;
 	dev->hw_features = netkit_features;
 	dev->hw_enc_features = netkit_features;
 	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
diff --git a/drivers/net/nlmon.c b/drivers/net/nlmon.c
index e5a0987a263e..8bfd4ee5a8c4 100644
--- a/drivers/net/nlmon.c
+++ b/drivers/net/nlmon.c
@@ -63,13 +63,13 @@ static void nlmon_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_NETLINK;
 	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->lltx = true;
 
 	dev->netdev_ops	= &nlmon_ops;
 	dev->ethtool_ops = &nlmon_ethtool_ops;
 	dev->needs_free_netdev = true;
 
-	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST |
-			NETIF_F_HIGHDMA | NETIF_F_LLTX;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA;
 	dev->flags = IFF_NOARP;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
 
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 0a65b6d690fe..d0c507ab9c23 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1616,7 +1616,7 @@ static void ppp_setup(struct net_device *dev)
 	dev->netdev_ops = &ppp_netdev_ops;
 	SET_NETDEV_DEVTYPE(dev, &ppp_type);
 
-	dev->features |= NETIF_F_LLTX;
+	dev->lltx = true;
 
 	dev->hard_header_len = PPP_HDRLEN;
 	dev->mtu = PPP_MRU;
diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index 4eececc94513..318a0ef1af50 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -515,7 +515,7 @@ static int rionet_setup_netdev(struct rio_mport *mport, struct net_device *ndev)
 	/* MTU range: 68 - 4082 */
 	ndev->min_mtu = ETH_MIN_MTU;
 	ndev->max_mtu = RIONET_MAX_MTU;
-	ndev->features = NETIF_F_LLTX;
+	ndev->lltx = true;
 	SET_NETDEV_DEV(ndev, &mport->dev);
 	ndev->ethtool_ops = &rionet_ethtool_ops;
 
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..1d1bad3cedc2 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2189,8 +2189,8 @@ static void team_setup(struct net_device *dev)
 	 * Let this up to underlay drivers.
 	 */
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
+	dev->lltx = true;
 
-	dev->features |= NETIF_F_LLTX;
 	dev->features |= NETIF_F_GRO;
 
 	/* Don't allow team devices to change network namespaces. */
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9254bca2813d..1520091cc6b7 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -990,10 +990,11 @@ static int tun_net_init(struct net_device *dev)
 	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST |
 			   TUN_USER_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_STAG_TX;
-	dev->features = dev->hw_features | NETIF_F_LLTX;
+	dev->features = dev->hw_features;
 	dev->vlan_features = dev->features &
 			     ~(NETIF_F_HW_VLAN_CTAG_TX |
 			       NETIF_F_HW_VLAN_STAG_TX);
+	dev->lltx = true;
 
 	tun->flags = (tun->flags & ~TUN_FEATURES) |
 		      (ifr->ifr_flags & TUN_FEATURES);
@@ -1129,7 +1130,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
-	/* NETIF_F_LLTX requires to do our own update of trans_start */
+	/* dev->lltx requires to do our own update of trans_start */
 	queue = netdev_get_tx_queue(dev, txq);
 	txq_trans_cond_update(queue);
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 426e68a95067..925b45d993f1 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1696,11 +1696,11 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
+	dev->lltx = true;
 
 	dev->netdev_ops = &veth_netdev_ops;
 	dev->xdp_metadata_ops = &veth_xdp_metadata_ops;
 	dev->ethtool_ops = &veth_ethtool_ops;
-	dev->features |= NETIF_F_LLTX;
 	dev->features |= VETH_FEATURES;
 	dev->vlan_features = dev->features &
 			     ~(NETIF_F_HW_VLAN_CTAG_TX |
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 9af316cdd8b3..fce065d0b5a0 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1634,7 +1634,7 @@ static void vrf_setup(struct net_device *dev)
 	eth_hw_addr_random(dev);
 
 	/* don't acquire vrf device's netif_tx_lock when transmitting */
-	dev->features |= NETIF_F_LLTX;
+	dev->lltx = true;
 
 	/* don't allow vrf devices to change network namespaces. */
 	dev->features |= NETIF_F_NETNS_LOCAL;
diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
index 4c260074c091..53fb76d574c6 100644
--- a/drivers/net/vsockmon.c
+++ b/drivers/net/vsockmon.c
@@ -83,13 +83,13 @@ static void vsockmon_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_VSOCKMON;
 	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->lltx = true;
 
 	dev->netdev_ops	= &vsockmon_ops;
 	dev->ethtool_ops = &vsockmon_ethtool_ops;
 	dev->needs_free_netdev = true;
 
-	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST |
-			NETIF_F_HIGHDMA | NETIF_F_LLTX;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA;
 
 	dev->flags = IFF_NOARP;
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 2f3a7c58d302..870849267bc9 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3315,7 +3315,6 @@ static void vxlan_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	SET_NETDEV_DEVTYPE(dev, &vxlan_type);
 
-	dev->features	|= NETIF_F_LLTX;
 	dev->features	|= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->features   |= NETIF_F_RXCSUM;
 	dev->features   |= NETIF_F_GSO_SOFTWARE;
@@ -3327,6 +3326,7 @@ static void vxlan_setup(struct net_device *dev)
 	netif_keep_dst(dev);
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->change_proto_down = true;
+	dev->lltx = true;
 
 	/* MTU range: 68 - 65535 */
 	dev->min_mtu = ETH_MIN_MTU;
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 3feb36ee5bfb..45e9b908dbfb 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -289,7 +289,7 @@ static void wg_setup(struct net_device *dev)
 	dev->type = ARPHRD_NONE;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
 	dev->priv_flags |= IFF_NO_QUEUE;
-	dev->features |= NETIF_F_LLTX;
+	dev->lltx = true;
 	dev->features |= WG_NETDEV_FEATURES;
 	dev->hw_features |= WG_NETDEV_FEATURES;
 	dev->hw_enc_features |= WG_NETDEV_FEATURES;
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9eee28f2940c..a5e99cc78a45 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -425,7 +425,7 @@ int cvm_oct_common_init(struct net_device *dev)
 		dev->features |= NETIF_F_SG | NETIF_F_IP_CSUM;
 
 	/* We do our own locking, Linux doesn't need to */
-	dev->features |= NETIF_F_LLTX;
+	dev->lltx = true;
 	dev->ethtool_ops = &cvm_oct_ethtool_ops;
 
 	cvm_oct_set_mac_filter(dev);
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ce5716c3999a..d9b0d4a9074a 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -15077,8 +15077,7 @@ static struct skb_segment_test skb_segment_tests[] __initconst = {
 		.build_skb = build_test_skb_linear_no_head_frag,
 		.features = NETIF_F_SG | NETIF_F_FRAGLIST |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_GSO |
-			    NETIF_F_LLTX | NETIF_F_GRO |
-			    NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM |
+			    NETIF_F_GRO | NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_STAG_TX
 	}
 };
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 3efba4f857ac..eb9e13e8b983 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -569,7 +569,8 @@ static int vlan_dev_init(struct net_device *dev)
 	if (real_dev->vlan_features & NETIF_F_HW_MACSEC)
 		dev->hw_features |= NETIF_F_HW_MACSEC;
 
-	dev->features |= dev->hw_features | NETIF_F_LLTX;
+	dev->features |= dev->hw_features;
+	dev->lltx = true;
 	netif_inherit_tso_max(dev, real_dev);
 	if (dev->features & NETIF_F_VLAN_FEATURES)
 		netdev_warn(real_dev, "VLAN features are set incorrectly.  Q-in-Q configurations may not work correctly.\n");
@@ -655,7 +656,6 @@ static netdev_features_t vlan_dev_fix_features(struct net_device *dev,
 		lower_features |= NETIF_F_HW_CSUM;
 	features = netdev_intersect_features(features, lower_features);
 	features |= old_features & (NETIF_F_SOFT_FEATURES | NETIF_F_GSO_SOFTWARE);
-	features |= NETIF_F_LLTX;
 
 	return features;
 }
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 30ecbc2ef1fd..e791a73ef901 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1021,8 +1021,8 @@ static void batadv_softif_init_early(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = batadv_softif_free;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_NETNS_LOCAL;
-	dev->features |= NETIF_F_LLTX;
 	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->lltx = true;
 
 	/* can't call min_mtu, because the needed variables
 	 * have not been initialized yet
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index fb1115857e49..a6d25113dfb1 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -487,8 +487,9 @@ void br_dev_setup(struct net_device *dev)
 	dev->ethtool_ops = &br_ethtool_ops;
 	SET_NETDEV_DEVTYPE(dev, &br_type);
 	dev->priv_flags = IFF_EBRIDGE | IFF_NO_QUEUE;
+	dev->lltx = true;
 
-	dev->features = COMMON_FEATURES | NETIF_F_LLTX | NETIF_F_NETNS_LOCAL |
+	dev->features = COMMON_FEATURES | NETIF_F_NETNS_LOCAL |
 			NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
 	dev->hw_features = COMMON_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_STAG_TX;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 4c27a360c294..f8179c643d7a 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1764,8 +1764,7 @@ static const struct kobj_type netdev_queue_ktype = {
 
 static bool netdev_uses_bql(const struct net_device *dev)
 {
-	if (dev->features & NETIF_F_LLTX ||
-	    dev->priv_flags & IFF_NO_QUEUE)
+	if (dev->lltx || (dev->priv_flags & IFF_NO_QUEUE))
 		return false;
 
 	return IS_ENABLED(CONFIG_BQL);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index e8f56a40b614..813e7d06e78c 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2642,11 +2642,12 @@ void dsa_user_setup_tagger(struct net_device *user)
 
 	user->features = conduit->vlan_features | NETIF_F_HW_TC;
 	user->hw_features |= NETIF_F_HW_TC;
-	user->features |= NETIF_F_LLTX;
 	if (user->needed_tailroom)
 		user->features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
 	if (ds->needs_standalone_vlan_filtering)
 		user->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	user->lltx = true;
 }
 
 int dsa_user_suspend(struct net_device *user_dev)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..44199d1780d5 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -24,7 +24,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_HW_VLAN_STAG_FILTER_BIT] = "rx-vlan-stag-filter",
 	[NETIF_F_VLAN_CHALLENGED_BIT] =  "vlan-challenged",
 	[NETIF_F_GSO_BIT] =              "tx-generic-segmentation",
-	[NETIF_F_LLTX_BIT] =             "tx-lockless",
 	[NETIF_F_NETNS_LOCAL_BIT] =      "netns-local",
 	[NETIF_F_GRO_BIT] =              "rx-gro",
 	[NETIF_F_GRO_HW_BIT] =           "rx-gro-hw",
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index e4cc6b78dcfc..d4c783076662 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -554,6 +554,8 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->netdev_ops = &hsr_device_ops;
 	SET_NETDEV_DEVTYPE(dev, &hsr_type);
 	dev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL;
+	/* Prevent recursive tx locking */
+	dev->lltx = true;
 
 	dev->needs_free_netdev = true;
 
@@ -563,8 +565,6 @@ void hsr_dev_setup(struct net_device *dev)
 
 	dev->features = dev->hw_features;
 
-	/* Prevent recursive tx locking */
-	dev->features |= NETIF_F_LLTX;
 	/* VLAN on top of HSR needs testing and probably some work on
 	 * hsr_header_create() etc.
 	 */
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index ba205473522e..b54c41f3ae3c 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -996,7 +996,7 @@ static void __gre_tunnel_init(struct net_device *dev)
 	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen;
 	dev->needed_headroom = tunnel->hlen + sizeof(tunnel->parms.iph);
 
-	dev->features		|= GRE_FEATURES | NETIF_F_LLTX;
+	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 
 	/* TCP offload with GRE SEQ is not supported, nor can we support 2
@@ -1010,6 +1010,8 @@ static void __gre_tunnel_init(struct net_device *dev)
 
 	dev->features |= NETIF_F_GSO_SOFTWARE;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+
+	dev->lltx = true;
 }
 
 static int ipgre_tunnel_init(struct net_device *dev)
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 14536da9f5dc..f0b4419cef34 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -443,7 +443,7 @@ static int vti_tunnel_init(struct net_device *dev)
 
 	dev->flags		= IFF_NOARP;
 	dev->addr_len		= 4;
-	dev->features		|= NETIF_F_LLTX;
+	dev->lltx		= true;
 	netif_keep_dst(dev);
 
 	return ip_tunnel_init(dev);
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 923a2ef68c2f..dc0db5895e0e 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -378,7 +378,7 @@ static void ipip_tunnel_setup(struct net_device *dev)
 	dev->type		= ARPHRD_TUNNEL;
 	dev->flags		= IFF_NOARP;
 	dev->addr_len		= 4;
-	dev->features		|= NETIF_F_LLTX;
+	dev->lltx		= true;
 	netif_keep_dst(dev);
 
 	dev->features		|= IPIP_FEATURES;
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 3942bd2ade78..08beab638bda 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1471,7 +1471,7 @@ static void ip6gre_tnl_init_features(struct net_device *dev)
 {
 	struct ip6_tnl *nt = netdev_priv(dev);
 
-	dev->features		|= GRE6_FEATURES | NETIF_F_LLTX;
+	dev->features		|= GRE6_FEATURES;
 	dev->hw_features	|= GRE6_FEATURES;
 
 	/* TCP offload with GRE SEQ is not supported, nor can we support 2
@@ -1485,6 +1485,8 @@ static void ip6gre_tnl_init_features(struct net_device *dev)
 
 	dev->features |= NETIF_F_GSO_SOFTWARE;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+
+	dev->lltx = true;
 }
 
 static int ip6gre_tunnel_init_common(struct net_device *dev)
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9dee0c127955..472fbf524602 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1846,7 +1846,7 @@ static void ip6_tnl_dev_setup(struct net_device *dev)
 	dev->type = ARPHRD_TUNNEL6;
 	dev->flags |= IFF_NOARP;
 	dev->addr_len = sizeof(struct in6_addr);
-	dev->features |= NETIF_F_LLTX;
+	dev->lltx = true;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	netif_keep_dst(dev);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 83b195f09561..008bb84c3b59 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1435,7 +1435,7 @@ static void ipip6_tunnel_setup(struct net_device *dev)
 	dev->flags		= IFF_NOARP;
 	netif_keep_dst(dev);
 	dev->addr_len		= 4;
-	dev->features		|= NETIF_F_LLTX;
+	dev->lltx		= true;
 	dev->features		|= SIT_FEATURES;
 	dev->hw_features	|= SIT_FEATURES;
 	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_TSTATS;
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 8ba00ad433c2..3102976b34b1 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -109,7 +109,7 @@ static void l2tp_eth_dev_setup(struct net_device *dev)
 	SET_NETDEV_DEVTYPE(dev, &l2tpeth_type);
 	ether_setup(dev);
 	dev->priv_flags		&= ~IFF_TX_SKB_SHARING;
-	dev->features		|= NETIF_F_LLTX;
+	dev->lltx		= true;
 	dev->netdev_ops		= &l2tp_eth_netdev_ops;
 	dev->needs_free_netdev	= true;
 }
diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 4b33133cbdff..3a369a31c5cc 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -102,19 +102,20 @@ static void do_setup(struct net_device *netdev)
 	netdev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_OPENVSWITCH |
 			      IFF_NO_QUEUE;
+	netdev->lltx = true;
 	netdev->needs_free_netdev = true;
 	netdev->priv_destructor = NULL;
 	netdev->ethtool_ops = &internal_dev_ethtool_ops;
 	netdev->rtnl_link_ops = &internal_dev_link_ops;
 
-	netdev->features = NETIF_F_LLTX | NETIF_F_SG | NETIF_F_FRAGLIST |
-			   NETIF_F_HIGHDMA | NETIF_F_HW_CSUM |
-			   NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL;
+	netdev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
+			   NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE |
+			   NETIF_F_GSO_ENCAP_ALL;
 
 	netdev->vlan_features = netdev->features;
 	netdev->hw_enc_features = netdev->features;
 	netdev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
-	netdev->hw_features = netdev->features & ~NETIF_F_LLTX;
+	netdev->hw_features = netdev->features;
 
 	eth_hw_addr_random(netdev);
 }
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index e50e4bf993fa..98f1e2b67c76 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -769,7 +769,7 @@ static int xfrmi_dev_init(struct net_device *dev)
 	if (err)
 		return err;
 
-	dev->features |= NETIF_F_LLTX;
+	dev->lltx = true;
 	dev->features |= XFRMI_FEATURES;
 	dev->hw_features |= XFRMI_FEATURES;
 
-- 
2.45.2


