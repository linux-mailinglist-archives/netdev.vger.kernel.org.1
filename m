Return-Path: <netdev+bounces-106447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDED791669A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA961F2419F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4120014D452;
	Tue, 25 Jun 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWfJsXRJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FC14B965;
	Tue, 25 Jun 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316201; cv=none; b=SsRp2p1hKx7u6Jgy56QOD3YFsi/MRXh8JCoA3EYc/XtKY0nUyrNicXhERnM4ejdmU1DYr1EOfZki5YoSSGR/lw3mlqHC5X2sTjWPhGX6NCv7hvAHVNNSlevjhasLNH1Rv1BBSzuxIQG3cvuZqPe9AHYJLRBgFh4D+x5j5XBN6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316201; c=relaxed/simple;
	bh=8toEi3Y9AScBJJg5DYoXctSeYNKSEviLGS6j0leLZOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1BWHAef8cIpDpPLElM9oLidsc7j+V7Gu1c0YKYSiH95uv7ZEx3Uh3CtXH3iwa4X92MwXaVsbKB9JgaHg1o4uvUXec5zEis9chkuwGdTALZkte8hs0HEeROoRHkGTxqZ67LdYNhN3Vs4qtqSR34XxrtfJKEp8+ZMmexUDWDlExY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWfJsXRJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719316200; x=1750852200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8toEi3Y9AScBJJg5DYoXctSeYNKSEviLGS6j0leLZOE=;
  b=RWfJsXRJ5zPWAVnjbbFy1c+AYwxm2jIEagJ2b3xj47JZju2igSh6fSb6
   S2QENbc6Z62hVmHVGCRuqWZ7mqbiSLIXQ+aGVBzcP0B8AQDtE9uZ6Ko0o
   MG9Hc1N2lz767uzdrmc1iwSTk5sPrPT2bVmW3i0PZu8P57p4mIoGwdOzo
   EfAT2tGsbqCUhVpe+UNk3SzAmaVaGuoYjudMUCgW5DAwXu5G0kT92jtmW
   DiJBE240rTloHVGaS7fJ0ZIJz5TgwTSZ9NelVcEXk2eGtLpvyDqXEpnQg
   is5wXQNB/0+52mu/+quj0Z8O0Ax21p/bGUZsTzS+q78Jjrw5lWo3u5Hyw
   g==;
X-CSE-ConnectionGUID: sfbzdX2hSeiz8R2Pq2OldQ==
X-CSE-MsgGUID: Q2WwNMJwQOGAv2YP2J0rkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="20104382"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="20104382"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 04:49:59 -0700
X-CSE-ConnectionGUID: nlufVy0hT7Ghedzo1j5b5A==
X-CSE-MsgGUID: Oz3HSapaRfWYIhAMYKqTng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43724722"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 25 Jun 2024 04:49:56 -0700
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
Subject: [PATCH net-next 1/5] netdevice: convert private flags > BIT(31) to bitfields
Date: Tue, 25 Jun 2024 13:44:28 +0200
Message-ID: <20240625114432.1398320-2-aleksander.lobakin@intel.com>
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

Make dev->priv_flags `u32` back and define bits higher than 31 as
bitfield booleans as per Jakub's suggestion. This simplifies code
which accesses these bits with no optimization loss (testb both
before/after), allows to not extend &netdev_priv_flags each time,
but also scales better as bits > 63 in the future would only add
a new u64 to the structure with no complications, comparing to
that extending ::priv_flags would require converting it to a bitmap.
Note that I picked `unsigned long :1` to not lose any potential
optimizations comparing to `bool :1` etc.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdevice.h                     | 27 ++++++++++++-------
 .../ethernet/microchip/lan966x/lan966x_main.c |  2 +-
 drivers/net/macvlan.c                         |  3 ++-
 drivers/net/vxlan/vxlan_core.c                |  3 ++-
 net/8021q/vlanproc.c                          |  2 +-
 net/core/dev.c                                |  4 +--
 net/core/dev_ioctl.c                          |  9 +++----
 net/core/rtnetlink.c                          |  2 +-
 8 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4e81660b4462..4fddf57f40d9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1607,7 +1607,8 @@ struct net_device_ops {
  * userspace; this means that the order of these flags can change
  * during any kernel release.
  *
- * You should have a pretty good reason to be extending these flags.
+ * You should add bitfield booleans after net_device::priv_flags instead
+ * of extending these flags.
  *
  * @IFF_802_1Q_VLAN: 802.1Q VLAN device
  * @IFF_EBRIDGE: Ethernet bridging device
@@ -1646,10 +1647,6 @@ struct net_device_ops {
  * @IFF_NO_ADDRCONF: prevent ipv6 addrconf
  * @IFF_TX_SKB_NO_LINEAR: device/driver is capable of xmitting frames with
  *	skb_headlen(skb) == 0 (data starts from frag0)
- * @IFF_CHANGE_PROTO_DOWN: device supports setting carrier via IFLA_PROTO_DOWN
- * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
- *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
- *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1684,8 +1681,6 @@ enum netdev_priv_flags {
 	IFF_L3MDEV_RX_HANDLER		= 1<<29,
 	IFF_NO_ADDRCONF			= BIT_ULL(30),
 	IFF_TX_SKB_NO_LINEAR		= BIT_ULL(31),
-	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
-	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -1749,6 +1744,16 @@ enum netdev_reg_state {
  *	data with strictly "high-level" data, and it has to know about
  *	almost every data structure used in the INET module.
  *
+ *	@__priv_flags:	both private flags as bits and as bitfield booleans
+ *			combined, only to assert cacheline placement
+ *	@priv_flags:	flags invisible to userspace defined as bits, see
+ *			enum netdev_priv_flags for the definitions
+ *	@see_all_hwtstamp_requests: device wants to see calls to
+ *			ndo_hwtstamp_set() for all timestamp requests
+ *			regardless of source, even if those aren't
+ *			HWTSTAMP_SOURCE_NETDEV
+ *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
+ *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
  *		of the interface.
@@ -1815,8 +1820,6 @@ enum netdev_reg_state {
  *
  *	@flags:		Interface flags (a la BSD)
  *	@xdp_features:	XDP capability supported by the device
- *	@priv_flags:	Like 'flags' but invisible to userspace,
- *			see if.h for the definitions
  *	@gflags:	Global flags ( kept as legacy )
  *	@padded:	How much padding added by alloc_netdev()
  *	@operstate:	RFC2863 operstate
@@ -2039,7 +2042,11 @@ struct net_device {
 
 	/* TX read-mostly hotpath */
 	__cacheline_group_begin(net_device_read_tx);
-	unsigned long long	priv_flags;
+	struct_group(__priv_flags,
+		unsigned long		priv_flags:32;
+		unsigned long		see_all_hwtstamp_requests:1;
+		unsigned long		change_proto_down:1;
+	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;
 	struct netdev_queue	*_tx;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index ec672af12e25..534d4716d5f7 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -816,7 +816,7 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 			 NETIF_F_HW_VLAN_STAG_TX |
 			 NETIF_F_HW_TC;
 	dev->hw_features |= NETIF_F_HW_TC;
-	dev->priv_flags |= IFF_SEE_ALL_HWTSTAMP_REQUESTS;
+	dev->see_all_hwtstamp_requests = true;
 	dev->needed_headroom = IFH_LEN_BYTES;
 
 	eth_hw_addr_gen(dev, lan966x->base_mac, p + 1);
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 67b7ef2d463f..3aa6d33efdf5 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1213,7 +1213,8 @@ void macvlan_common_setup(struct net_device *dev)
 	dev->max_mtu		= ETH_MAX_MTU;
 	dev->priv_flags	       &= ~IFF_TX_SKB_SHARING;
 	netif_keep_dst(dev);
-	dev->priv_flags	       |= IFF_UNICAST_FLT | IFF_CHANGE_PROTO_DOWN;
+	dev->priv_flags	       |= IFF_UNICAST_FLT;
+	dev->change_proto_down	= true;
 	dev->netdev_ops		= &macvlan_netdev_ops;
 	dev->needs_free_netdev	= true;
 	dev->priv_destructor	= macvlan_dev_free;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 567cb3faab70..2f3a7c58d302 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3325,7 +3325,8 @@ static void vxlan_setup(struct net_device *dev)
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
 	netif_keep_dst(dev);
-	dev->priv_flags |= IFF_NO_QUEUE | IFF_CHANGE_PROTO_DOWN;
+	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->change_proto_down = true;
 
 	/* MTU range: 68 - 65535 */
 	dev->min_mtu = ETH_MIN_MTU;
diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index 87b959da00cd..e8ddf97dad63 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -238,7 +238,7 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
 
 	stats = dev_get_stats(vlandev, &temp);
 	seq_printf(seq,
-		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %llx\n",
+		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %x\n",
 		   vlandev->name, vlan->vlan_id,
 		   (int)(vlan->flags & 1), vlandev->priv_flags);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index b94fb4e63a28..49a88b0ff73b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9266,7 +9266,7 @@ EXPORT_SYMBOL(netdev_port_same_parent_id);
  */
 int dev_change_proto_down(struct net_device *dev, bool proto_down)
 {
-	if (!(dev->priv_flags & IFF_CHANGE_PROTO_DOWN))
+	if (!dev->change_proto_down)
 		return -EOPNOTSUPP;
 	if (!netif_device_present(dev))
 		return -ENODEV;
@@ -11869,7 +11869,7 @@ static struct pernet_operations __net_initdata default_device_ops = {
 static void __init net_dev_struct_check(void)
 {
 	/* TX read-mostly hotpath */
-	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, priv_flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, __priv_flags);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, netdev_ops);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, header_ops);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, _tx);
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index b9719ed3c3fd..3868486fb71f 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -319,8 +319,7 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
  * should take precedence in front of hardware timestamping provided by the
  * netdev. If the netdev driver needs to perform specific actions even for PHY
  * timestamping to work properly (a switch port must trap the timestamped
- * frames and not forward them), it must set IFF_SEE_ALL_HWTSTAMP_REQUESTS in
- * dev->priv_flags.
+ * frames and not forward them), it must set dev->see_all_hwtstamp_requests.
  */
 int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg,
@@ -334,13 +333,13 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 
 	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
 
-	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
+	if (phy_ts && dev->see_all_hwtstamp_requests) {
 		err = ops->ndo_hwtstamp_get(dev, &old_cfg);
 		if (err)
 			return err;
 	}
 
-	if (!phy_ts || (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
+	if (!phy_ts || dev->see_all_hwtstamp_requests) {
 		err = ops->ndo_hwtstamp_set(dev, cfg, extack);
 		if (err) {
 			if (extack->_msg)
@@ -349,7 +348,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 		}
 	}
 
-	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS))
+	if (phy_ts && dev->see_all_hwtstamp_requests)
 		changed = kernel_hwtstamp_config_changed(&old_cfg, cfg);
 
 	if (phy_ts) {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index eabfc8290f5e..cff172f0ff3d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2724,7 +2724,7 @@ static int do_set_proto_down(struct net_device *dev,
 	bool proto_down;
 	int err;
 
-	if (!(dev->priv_flags & IFF_CHANGE_PROTO_DOWN)) {
+	if (!dev->change_proto_down) {
 		NL_SET_ERR_MSG(extack,  "Protodown not supported by device");
 		return -EOPNOTSUPP;
 	}
-- 
2.45.2


