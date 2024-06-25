Return-Path: <netdev+bounces-106450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996089166A0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5139D28BD67
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771C8157485;
	Tue, 25 Jun 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6Uviym5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F58156F32;
	Tue, 25 Jun 2024 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316211; cv=none; b=Rd1yTP6KuWHbpzPyMkSSmT5QWvBwY+ic/eiBrvrt524VejEEccbnETZohfPhM6NFS9h+s2JfnGk6ph75636E7HGVCTvlWTnhBsRhOlRrhU2uL1TOPwxc/fpgOY2bGil1sfB5GeGJvfBZlFD0k7c3aV1JelAqKIZHOYzN5ypFutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316211; c=relaxed/simple;
	bh=p5fPHFpMCiNsdvzhPjXopGJJyIcdD88xKKBz4fRRHWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnzQWJYxxRlsQtil9PuEkfE8f//jwdHCAYSSqs5rPX14fUdtb2atrw1oVELWL8sEMjmmJu+X7d5gFKvlXJo6ivE5jytApmMnSaVmD2BqQxRPCpaC/FxKyC4DBueWysWuQiD37O2KBberocjVTfTYbxK+u1L3zMNgh5T2OwvQwVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6Uviym5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719316210; x=1750852210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p5fPHFpMCiNsdvzhPjXopGJJyIcdD88xKKBz4fRRHWM=;
  b=U6Uviym5lg1ltdhxmSj2n1OoXxU7Vk8/2rvVH9AtzWBMF2+kDHjmLwQu
   GrP2DADrjmOhDLA7tYXpCZBlQHywfajp9VKJOdC17nufF6e5Tt1tI6mC1
   pK4QfvxbEr67p3tKdU7KMja/noVDZbRn7rN66nrG8ZJwHjMLcO6ut7/oZ
   HSD7fozQ8DyQ37ssABucs5Asuu4DrxGZNSXmr9tIhx9uRB7XhoCj8yiWJ
   QtQy0TILnVeOyjLTAyZfp3ABlc0gMKVQSjm+HSVpbAv+2kDzutNMHlFfX
   c3I7YsEpiDttrPlfizjibD+NxvvflvIcisntlQHz6fFzhRU6Bk9SJz3xF
   w==;
X-CSE-ConnectionGUID: TsIHOl6lTwCQzG06+VQnCQ==
X-CSE-MsgGUID: KqzSH4yvR3uE5cL5b0enLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="20104416"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="20104416"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 04:50:09 -0700
X-CSE-ConnectionGUID: RFhND+btTbmZ+N3BEnXWgg==
X-CSE-MsgGUID: PceqgUJhTl+FQSjoHsR4RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43724739"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 25 Jun 2024 04:50:06 -0700
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
Subject: [PATCH net-next 4/5] netdev_features: convert NETIF_F_NETNS_LOCAL to dev->netns_local
Date: Tue, 25 Jun 2024 13:44:31 +0200
Message-ID: <20240625114432.1398320-5-aleksander.lobakin@intel.com>
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

"Interface can't change network namespaces" is rather an attribute,
not a feature, and it can't be changed via Ethtool.
Make it a private flag instead of a netdev_feature and free one
more bit.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 Documentation/networking/netdev-features.rst          |  7 -------
 Documentation/networking/switchdev.rst                |  4 ++--
 include/linux/netdev_features.h                       |  5 +----
 include/linux/netdevice.h                             |  2 ++
 drivers/net/amt.c                                     |  2 +-
 drivers/net/bonding/bond_main.c                       |  6 +++---
 drivers/net/ethernet/adi/adin1110.c                   |  2 +-
 drivers/net/ethernet/marvell/prestera/prestera_main.c |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c     |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c      |  3 ++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c        |  5 +++--
 drivers/net/ethernet/rocker/rocker_main.c             |  3 ++-
 drivers/net/ethernet/ti/cpsw_new.c                    |  3 ++-
 drivers/net/loopback.c                                |  2 +-
 drivers/net/net_failover.c                            |  2 +-
 drivers/net/team/team_core.c                          |  6 +++---
 drivers/net/vrf.c                                     |  2 +-
 net/batman-adv/soft-interface.c                       |  3 ++-
 net/bridge/br_device.c                                |  5 +++--
 net/core/dev.c                                        |  4 ++--
 net/ethtool/common.c                                  |  1 -
 net/hsr/hsr_device.c                                  |  8 ++++----
 net/ieee802154/6lowpan/core.c                         |  2 +-
 net/ieee802154/core.c                                 | 10 +++++-----
 net/ipv4/ip_tunnel.c                                  |  2 +-
 net/ipv4/ipmr.c                                       |  2 +-
 net/ipv6/ip6_gre.c                                    |  3 +--
 net/ipv6/ip6_tunnel.c                                 |  2 +-
 net/ipv6/ip6mr.c                                      |  2 +-
 net/ipv6/sit.c                                        |  2 +-
 net/openvswitch/vport-internal_dev.c                  |  2 +-
 net/wireless/core.c                                   | 10 +++++-----
 tools/testing/selftests/net/forwarding/README         |  2 +-
 33 files changed, 59 insertions(+), 62 deletions(-)

diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index f29d982ebf5d..5014f7cc1398 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -139,13 +139,6 @@ chained skbs (skb->next/prev list).
 Features contained in NETIF_F_SOFT_FEATURES are features of networking
 stack. Driver should not change behaviour based on them.
 
- * netns-local device
-
-NETIF_F_NETNS_LOCAL is set for devices that are not allowed to move between
-network namespaces (e.g. loopback).
-
-Don't use it in drivers.
-
  * VLAN challenged
 
 NETIF_F_VLAN_CHALLENGED should be set for devices which can't cope with VLAN
diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index 758f1dae3fce..f355f0166f1b 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -137,10 +137,10 @@ would be sub-port 0 on port 1 on switch 1.
 Port Features
 ^^^^^^^^^^^^^
 
-NETIF_F_NETNS_LOCAL
+dev->netns_local
 
 If the switchdev driver (and device) only supports offloading of the default
-network namespace (netns), the driver should set this feature flag to prevent
+network namespace (netns), the driver should set this private flag to prevent
 the port netdev from being moved out of the default netns.  A netns-aware
 driver/device would not set this flag and be responsible for partitioning
 hardware to preserve netns containment.  This means hardware cannot forward
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 54d1578f6642..3bacd4b1adc9 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -23,7 +23,6 @@ enum {
 	NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAGs */
 	NETIF_F_VLAN_CHALLENGED_BIT,	/* Device cannot handle VLAN packets */
 	NETIF_F_GSO_BIT,		/* Enable software GSO. */
-	NETIF_F_NETNS_LOCAL_BIT,	/* Does not change network namespaces */
 	NETIF_F_GRO_BIT,		/* Generic receive offload */
 	NETIF_F_LRO_BIT,		/* large receive offload */
 
@@ -119,7 +118,6 @@ enum {
 #define NETIF_F_IPV6_CSUM	__NETIF_F(IPV6_CSUM)
 #define NETIF_F_LOOPBACK	__NETIF_F(LOOPBACK)
 #define NETIF_F_LRO		__NETIF_F(LRO)
-#define NETIF_F_NETNS_LOCAL	__NETIF_F(NETNS_LOCAL)
 #define NETIF_F_NOCACHE_COPY	__NETIF_F(NOCACHE_COPY)
 #define NETIF_F_NTUPLE		__NETIF_F(NTUPLE)
 #define NETIF_F_RXCSUM		__NETIF_F(RXCSUM)
@@ -188,8 +186,7 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 
 /* Features valid for ethtool to change */
 /* = all defined minus driver/device-class-related */
-#define NETIF_F_NEVER_CHANGE	(NETIF_F_VLAN_CHALLENGED | \
-				 NETIF_F_NETNS_LOCAL)
+#define NETIF_F_NEVER_CHANGE	NETIF_F_VLAN_CHALLENGED
 
 /* remember that ((t)1 << t_BITS) is undefined in C99 */
 #define NETIF_F_ETHTOOL_BITS	((__NETIF_F_BIT(NETDEV_FEATURE_COUNT - 1) | \
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9acbd93188a3..f79276453b03 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1755,6 +1755,7 @@ enum netdev_reg_state {
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@lltx:		device supports lockless Tx. Mainly used by logical
  *			interfaces, such as tunnels
+ *	@netns_local: interface can't change network namespaces
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
@@ -2049,6 +2050,7 @@ struct net_device {
 		unsigned long		see_all_hwtstamp_requests:1;
 		unsigned long		change_proto_down:1;
 		unsigned long		lltx:1;
+		unsigned long		netns_local:1;
 	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 921bbfd72a38..0433a0f36d1b 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3099,8 +3099,8 @@ static void amt_link_setup(struct net_device *dev)
 	dev->addr_len		= 0;
 	dev->priv_flags		|= IFF_NO_QUEUE;
 	dev->lltx		= true;
+	dev->netns_local	= true;
 	dev->features		|= NETIF_F_GSO_SOFTWARE;
-	dev->features		|= NETIF_F_NETNS_LOCAL;
 	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
 	dev->hw_features	|= NETIF_F_FRAGLIST | NETIF_F_RXCSUM;
 	dev->hw_features	|= NETIF_F_GSO_SOFTWARE;
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b5d1dd4ebf7a..82e29ff3bd8e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5888,6 +5888,9 @@ void bond_setup(struct net_device *bond_dev)
 	/* don't acquire bond device's netif_tx_lock when transmitting */
 	bond_dev->lltx = true;
 
+	/* Don't allow bond devices to change network namespaces. */
+	bond_dev->netns_local = true;
+
 	/* By default, we declare the bond to be fully
 	 * VLAN hardware accelerated capable. Special
 	 * care is taken in the various xmit functions
@@ -5895,9 +5898,6 @@ void bond_setup(struct net_device *bond_dev)
 	 * capable
 	 */
 
-	/* Don't allow bond devices to change network namespaces. */
-	bond_dev->features |= NETIF_F_NETNS_LOCAL;
-
 	bond_dev->hw_features = BOND_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER |
diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 0713f1e2c7f3..3431a7e62b0d 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -1599,7 +1599,7 @@ static int adin1110_probe_netdevs(struct adin1110_priv *priv)
 		netdev->netdev_ops = &adin1110_netdev_ops;
 		netdev->ethtool_ops = &adin1110_ethtool_ops;
 		netdev->priv_flags |= IFF_UNICAST_FLT;
-		netdev->features |= NETIF_F_NETNS_LOCAL;
+		netdev->netns_local = true;
 
 		port_priv->phydev = get_phy_device(priv->mii_bus, i + 1, false);
 		if (IS_ERR(port_priv->phydev)) {
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 63ae01954dfc..22ca6ee9665e 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -633,7 +633,8 @@ static int prestera_port_create(struct prestera_switch *sw, u32 id)
 	if (err)
 		goto err_dl_port_register;
 
-	dev->features |= NETIF_F_NETNS_LOCAL | NETIF_F_HW_TC;
+	dev->features |= NETIF_F_HW_TC;
+	dev->netns_local = true;
 	dev->netdev_ops = &prestera_netdev_ops;
 	dev->ethtool_ops = &prestera_ethtool_ops;
 	SET_NETDEV_DEV(dev, sw->dev->dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 0eba4c5bb2ec..05dc7dc34386 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4403,9 +4403,9 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 
 	if (mlx5e_is_uplink_rep(priv)) {
 		features = mlx5e_fix_uplink_rep_features(netdev, features);
-		features |= NETIF_F_NETNS_LOCAL;
+		netdev->netns_local = true;
 	} else {
-		features &= ~NETIF_F_NETNS_LOCAL;
+		netdev->netns_local = false;
 	}
 
 	mutex_unlock(&priv->state_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 8790d57dc6db..e2e3b8c33d18 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -898,7 +898,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev,
 	netdev->hw_features    |= NETIF_F_RXCSUM;
 
 	netdev->features |= netdev->hw_features;
-	netdev->features |= NETIF_F_NETNS_LOCAL;
+
+	netdev->netns_local = true;
 }
 
 static int mlx5e_init_rep(struct mlx5_core_dev *mdev,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 44d6e125bd6f..b9ffd7236aff 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1676,10 +1676,11 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 
 	netif_carrier_off(dev);
 
-	dev->features |= NETIF_F_NETNS_LOCAL | NETIF_F_SG |
-			 NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_TC;
+	dev->features |= NETIF_F_SG | NETIF_F_HW_VLAN_CTAG_FILTER |
+			 NETIF_F_HW_TC;
 	dev->hw_features |= NETIF_F_HW_TC | NETIF_F_LOOPBACK;
 	dev->lltx = true;
+	dev->netns_local = true;
 
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = MLXSW_PORT_MAX_MTU - MLXSW_PORT_ETH_FRAME_HDR;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index e097ce3e69ea..84fa911c78db 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2575,7 +2575,8 @@ static int rocker_probe_port(struct rocker *rocker, unsigned int port_number)
 	netif_napi_add(dev, &rocker_port->napi_rx, rocker_port_poll_rx);
 	rocker_carrier_init(rocker_port);
 
-	dev->features |= NETIF_F_NETNS_LOCAL | NETIF_F_SG;
+	dev->features |= NETIF_F_SG;
+	dev->netns_local = true;
 
 	/* MTU range: 68 - 9000 */
 	dev->min_mtu = ROCKER_PORT_MIN_MTU;
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 2baa198ebfa0..557cc71b9dd2 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1407,7 +1407,8 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		cpsw->slaves[i].ndev = ndev;
 
 		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
-				  NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_NETNS_LOCAL | NETIF_F_HW_TC;
+				  NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_TC;
+		ndev->netns_local = true;
 
 		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
 				     NETDEV_XDP_ACT_REDIRECT |
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index bf857782be0f..1993b90b1a5f 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -172,6 +172,7 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->flags		= IFF_LOOPBACK;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
 	dev->lltx		= true;
+	dev->netns_local	= true;
 	netif_keep_dst(dev);
 	dev->hw_features	= NETIF_F_GSO_SOFTWARE;
 	dev->features		= NETIF_F_SG | NETIF_F_FRAGLIST
@@ -180,7 +181,6 @@ static void gen_lo_setup(struct net_device *dev,
 		| NETIF_F_RXCSUM
 		| NETIF_F_SCTP_CRC
 		| NETIF_F_HIGHDMA
-		| NETIF_F_NETNS_LOCAL
 		| NETIF_F_VLAN_CHALLENGED
 		| NETIF_F_LOOPBACK;
 	dev->ethtool_ops	= eth_ops;
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 06728385a35f..54c8b9d5b5fc 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -734,7 +734,7 @@ struct failover *net_failover_create(struct net_device *standby_dev)
 	failover_dev->lltx = true;
 
 	/* Don't allow failover devices to change network namespaces. */
-	failover_dev->features |= NETIF_F_NETNS_LOCAL;
+	failover_dev->netns_local = true;
 
 	failover_dev->hw_features = FAILOVER_VLAN_FEATURES |
 				    NETIF_F_HW_VLAN_CTAG_TX |
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 1d1bad3cedc2..18191d5a8bd4 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2191,10 +2191,10 @@ static void team_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
 	dev->lltx = true;
 
-	dev->features |= NETIF_F_GRO;
-
 	/* Don't allow team devices to change network namespaces. */
-	dev->features |= NETIF_F_NETNS_LOCAL;
+	dev->netns_local = true;
+
+	dev->features |= NETIF_F_GRO;
 
 	dev->hw_features = TEAM_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index fce065d0b5a0..597a041476fa 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1637,7 +1637,7 @@ static void vrf_setup(struct net_device *dev)
 	dev->lltx = true;
 
 	/* don't allow vrf devices to change network namespaces. */
-	dev->features |= NETIF_F_NETNS_LOCAL;
+	dev->netns_local = true;
 
 	/* does not make sense for a VLAN to be added to a vrf device */
 	dev->features   |= NETIF_F_VLAN_CHALLENGED;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index e791a73ef901..2758aba47a2f 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1020,9 +1020,10 @@ static void batadv_softif_init_early(struct net_device *dev)
 	dev->netdev_ops = &batadv_netdev_ops;
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = batadv_softif_free;
-	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_NETNS_LOCAL;
+	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->lltx = true;
+	dev->netns_local = true;
 
 	/* can't call min_mtu, because the needed variables
 	 * have not been initialized yet
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index a6d25113dfb1..26b79feb385d 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -488,9 +488,10 @@ void br_dev_setup(struct net_device *dev)
 	SET_NETDEV_DEVTYPE(dev, &br_type);
 	dev->priv_flags = IFF_EBRIDGE | IFF_NO_QUEUE;
 	dev->lltx = true;
+	dev->netns_local = true;
 
-	dev->features = COMMON_FEATURES | NETIF_F_NETNS_LOCAL |
-			NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
+	dev->features = COMMON_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
+			NETIF_F_HW_VLAN_STAG_TX;
 	dev->hw_features = COMMON_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_STAG_TX;
 	dev->vlan_features = COMMON_FEATURES;
diff --git a/net/core/dev.c b/net/core/dev.c
index 49a88b0ff73b..022da23f5b1e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11426,7 +11426,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 
 	/* Don't allow namespace local devices to be moved. */
 	err = -EINVAL;
-	if (dev->features & NETIF_F_NETNS_LOCAL)
+	if (dev->netns_local)
 		goto out;
 
 	/* Ensure the device has been registrered */
@@ -11808,7 +11808,7 @@ static void __net_exit default_device_exit_net(struct net *net)
 		char fb_name[IFNAMSIZ];
 
 		/* Ignore unmoveable devices (i.e. loopback) */
-		if (dev->features & NETIF_F_NETNS_LOCAL)
+		if (dev->netns_local)
 			continue;
 
 		/* Leave virtual devices for the generic cleanup */
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 44199d1780d5..66c8b6739260 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -24,7 +24,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_HW_VLAN_STAG_FILTER_BIT] = "rx-vlan-stag-filter",
 	[NETIF_F_VLAN_CHALLENGED_BIT] =  "vlan-challenged",
 	[NETIF_F_GSO_BIT] =              "tx-generic-segmentation",
-	[NETIF_F_NETNS_LOCAL_BIT] =      "netns-local",
 	[NETIF_F_GRO_BIT] =              "rx-gro",
 	[NETIF_F_GRO_HW_BIT] =           "rx-gro-hw",
 	[NETIF_F_LRO_BIT] =              "rx-lro",
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index d4c783076662..a06e790042e2 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -556,6 +556,10 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL;
 	/* Prevent recursive tx locking */
 	dev->lltx = true;
+	/* Not sure about this. Taken from bridge code. netdevice.h says
+	 * it means "Does not change network namespaces".
+	 */
+	dev->netns_local = true;
 
 	dev->needs_free_netdev = true;
 
@@ -569,10 +573,6 @@ void hsr_dev_setup(struct net_device *dev)
 	 * hsr_header_create() etc.
 	 */
 	dev->features |= NETIF_F_VLAN_CHALLENGED;
-	/* Not sure about this. Taken from bridge code. netdev_features.h says
-	 * it means "Does not change network namespaces".
-	 */
-	dev->features |= NETIF_F_NETNS_LOCAL;
 }
 
 /* Return true if dev is a HSR master; return false otherwise.
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 77b4e92027c5..175efd860f7b 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -116,7 +116,7 @@ static void lowpan_setup(struct net_device *ldev)
 	ldev->netdev_ops	= &lowpan_netdev_ops;
 	ldev->header_ops	= &lowpan_header_ops;
 	ldev->needs_free_netdev	= true;
-	ldev->features		|= NETIF_F_NETNS_LOCAL;
+	ldev->netns_local	= true;
 }
 
 static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[],
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 60e8fff1347e..88adb04e4072 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -226,11 +226,11 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 	list_for_each_entry(wpan_dev, &rdev->wpan_dev_list, list) {
 		if (!wpan_dev->netdev)
 			continue;
-		wpan_dev->netdev->features &= ~NETIF_F_NETNS_LOCAL;
+		wpan_dev->netdev->netns_local = false;
 		err = dev_change_net_namespace(wpan_dev->netdev, net, "wpan%d");
 		if (err)
 			break;
-		wpan_dev->netdev->features |= NETIF_F_NETNS_LOCAL;
+		wpan_dev->netdev->netns_local = true;
 	}
 
 	if (err) {
@@ -242,11 +242,11 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 						     list) {
 			if (!wpan_dev->netdev)
 				continue;
-			wpan_dev->netdev->features &= ~NETIF_F_NETNS_LOCAL;
+			wpan_dev->netdev->netns_local = false;
 			err = dev_change_net_namespace(wpan_dev->netdev, net,
 						       "wpan%d");
 			WARN_ON(err);
-			wpan_dev->netdev->features |= NETIF_F_NETNS_LOCAL;
+			wpan_dev->netdev->netns_local = true;
 		}
 
 		return err;
@@ -291,7 +291,7 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 	switch (state) {
 		/* TODO NETDEV_DEVTYPE */
 	case NETDEV_REGISTER:
-		dev->features |= NETIF_F_NETNS_LOCAL;
+		dev->netns_local = true;
 		wpan_dev->identifier = ++rdev->wpan_dev_id;
 		list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
 		rdev->devlist_generation++;
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 5cffad42fe8c..023b0ee8bd85 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1161,7 +1161,7 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
 	if (!IS_ERR(itn->fb_tunnel_dev)) {
-		itn->fb_tunnel_dev->features |= NETIF_F_NETNS_LOCAL;
+		itn->fb_tunnel_dev->netns_local = true;
 		itn->fb_tunnel_dev->mtu = ip_tunnel_bind_dev(itn->fb_tunnel_dev);
 		ip_tunnel_add(itn, netdev_priv(itn->fb_tunnel_dev));
 		itn->type = itn->fb_tunnel_dev->type;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 6c750bd13dd8..9b22dad2c9a2 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -536,7 +536,7 @@ static void reg_vif_setup(struct net_device *dev)
 	dev->flags		= IFF_NOARP;
 	dev->netdev_ops		= &reg_vif_netdev_ops;
 	dev->needs_free_netdev	= true;
-	dev->features		|= NETIF_F_NETNS_LOCAL;
+	dev->netns_local	= true;
 }
 
 static struct net_device *ipmr_reg_vif(struct net *net, struct mr_table *mrt)
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 08beab638bda..235808cfec70 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1621,8 +1621,7 @@ static int __net_init ip6gre_init_net(struct net *net)
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
-	ign->fb_tunnel_dev->features |= NETIF_F_NETNS_LOCAL;
-
+	ign->fb_tunnel_dev->netns_local = true;
 
 	ip6gre_fb_tunnel_init(ign->fb_tunnel_dev);
 	ign->fb_tunnel_dev->rtnl_link_ops = &ip6gre_link_ops;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 472fbf524602..f3c966c5a234 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2256,7 +2256,7 @@ static int __net_init ip6_tnl_init_net(struct net *net)
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
-	ip6n->fb_tnl_dev->features |= NETIF_F_NETNS_LOCAL;
+	ip6n->fb_tnl_dev->netns_local = true;
 
 	err = ip6_fb_tnl_dev_init(ip6n->fb_tnl_dev);
 	if (err < 0)
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index dd342e6ecf3f..bfaf3100801f 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -640,7 +640,7 @@ static void reg_vif_setup(struct net_device *dev)
 	dev->flags		= IFF_NOARP;
 	dev->netdev_ops		= &reg_vif_netdev_ops;
 	dev->needs_free_netdev	= true;
-	dev->features		|= NETIF_F_NETNS_LOCAL;
+	dev->netns_local	= true;
 }
 
 static struct net_device *ip6mr_reg_vif(struct net *net, struct mr_table *mrt)
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 008bb84c3b59..a0428612f7d4 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1855,7 +1855,7 @@ static int __net_init sit_init_net(struct net *net)
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
-	sitn->fb_tunnel_dev->features |= NETIF_F_NETNS_LOCAL;
+	sitn->fb_tunnel_dev->netns_local = true;
 
 	err = register_netdev(sitn->fb_tunnel_dev);
 	if (err)
diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 3a369a31c5cc..5858d65ea1a9 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -149,7 +149,7 @@ static struct vport *internal_dev_create(const struct vport_parms *parms)
 
 	/* Restrict bridge port to current netns. */
 	if (vport->port_no == OVSP_LOCAL)
-		vport->dev->features |= NETIF_F_NETNS_LOCAL;
+		vport->dev->netns_local = true;
 
 	rtnl_lock();
 	err = register_netdevice(vport->dev);
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4d5d351bd0b5..661adfc77644 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -165,11 +165,11 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (!wdev->netdev)
 			continue;
-		wdev->netdev->features &= ~NETIF_F_NETNS_LOCAL;
+		wdev->netdev->netns_local = false;
 		err = dev_change_net_namespace(wdev->netdev, net, "wlan%d");
 		if (err)
 			break;
-		wdev->netdev->features |= NETIF_F_NETNS_LOCAL;
+		wdev->netdev->netns_local = true;
 	}
 
 	if (err) {
@@ -181,11 +181,11 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 						     list) {
 			if (!wdev->netdev)
 				continue;
-			wdev->netdev->features &= ~NETIF_F_NETNS_LOCAL;
+			wdev->netdev->netns_local = false;
 			err = dev_change_net_namespace(wdev->netdev, net,
 							"wlan%d");
 			WARN_ON(err);
-			wdev->netdev->features |= NETIF_F_NETNS_LOCAL;
+			wdev->netdev->netns_local = true;
 		}
 
 		return err;
@@ -1473,7 +1473,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		SET_NETDEV_DEVTYPE(dev, &wiphy_type);
 		wdev->netdev = dev;
 		/* can only change netns with wiphy */
-		dev->features |= NETIF_F_NETNS_LOCAL;
+		dev->netns_local = true;
 
 		cfg80211_init_wdev(wdev);
 		break;
diff --git a/tools/testing/selftests/net/forwarding/README b/tools/testing/selftests/net/forwarding/README
index 7fdb6a9ca543..a652429bfd53 100644
--- a/tools/testing/selftests/net/forwarding/README
+++ b/tools/testing/selftests/net/forwarding/README
@@ -6,7 +6,7 @@ to easily create and test complex environments.
 
 Unfortunately, these namespaces can not be used with actual switching
 ASICs, as their ports can not be migrated to other network namespaces
-(NETIF_F_NETNS_LOCAL) and most of them probably do not support the
+(dev->netns_local) and most of them probably do not support the
 L1-separation provided by namespaces.
 
 However, a similar kind of flexibility can be achieved by using VRFs and
-- 
2.45.2


