Return-Path: <netdev+bounces-108932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA5192643E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E0D1C21943
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42186180A86;
	Wed,  3 Jul 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1dNY+xY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0517DA2E;
	Wed,  3 Jul 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019098; cv=none; b=YPzSY8UXLnQ6Dk1H1xwGg3jNI4PfRL7karRLTgGf1dhOugs6mAFcd2s0ijw0XS/rqVPcoo5dj6IqYy0vMNqC7vo1K7YQpc206XxCfG1cyL9cMaiTUzMBv6vyySMk3pa9iHuLr00eURzmsKBTWYqjClAq40BXnEERCxvDBOnDLgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019098; c=relaxed/simple;
	bh=kQJutCFAOhvpXwswEj4gDMuKGuTGXjMnMb2+2QP0giY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnaVXmG/IJZHmbfUlmmBMJoOmMHNDsHIhNLbo21rPeX0M09bx0tqiAZkqw0weBmMRTl7M3dtNC5hkLeimz9nOeIqKMpuWWdNHodHA3NhZZhlTgVCBK9lpSQUfr9ZKSaAX0zFvfbo+dzIMHBez+Z4CPr/O6FslMsSATzc4f74FCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1dNY+xY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720019096; x=1751555096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kQJutCFAOhvpXwswEj4gDMuKGuTGXjMnMb2+2QP0giY=;
  b=Q1dNY+xYyI2eR9fz4GC401CrgTZT3u8eTqZzjSSeYwd2kiE2rx5Cz5I8
   EG3UKKohiVsrr5M+m1bgM5I2ZTpRcB1WPT8QSDp2wd8zXjKJcD6ebcF8C
   56xdEG0b50N1fK3DseMQQx1iDjUCfZ93o/y3QutreQJPVciMOhuC3rvdj
   cbRi1ZHBl2m69b9njNlPhABJfuc6IiUSZpwfj721t7hvO9MfIPxKLTWrf
   1WNEuwOEGlCPVoN5Iakb6JwT8muReNmvrSDTi4LEFF2lkYfczrNxhuf51
   vm1IqW/oTW8VcNTOvwIo8tTD8wiJuvFdJZqnDkA4mRerZT5+DdgKTwHID
   w==;
X-CSE-ConnectionGUID: xBBi83XGT76sfo+hggfhpw==
X-CSE-MsgGUID: LCnqQ9sWQaSTdQGr7FiNxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17079131"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17079131"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 08:04:52 -0700
X-CSE-ConnectionGUID: eFAOprA2SASx/uPx1P8Y6w==
X-CSE-MsgGUID: /xc9lY/wQBi4+KFWjtoSbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="77016636"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 03 Jul 2024 08:04:49 -0700
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
Subject: [PATCH net-next v2 1/5] netdevice: convert private flags > BIT(31) to bitfields
Date: Wed,  3 Jul 2024 17:03:38 +0200
Message-ID: <20240703150342.1435976-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
References: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
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
 .../networking/net_cachelines/net_device.rst  |  4 ++-
 include/linux/netdevice.h                     | 30 ++++++++++++-------
 .../ethernet/microchip/lan966x/lan966x_main.c |  2 +-
 drivers/net/macvlan.c                         |  3 +-
 drivers/net/vxlan/vxlan_core.c                |  3 +-
 net/8021q/vlanproc.c                          |  4 +--
 net/core/dev.c                                |  4 +--
 net/core/dev_ioctl.c                          |  9 +++---
 net/core/rtnetlink.c                          |  2 +-
 9 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 70c4fb9d4e5c..d7ba48ff5559 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -7,6 +7,7 @@ net_device struct fast path usage breakdown
 
 Type                                Name                    fastpath_tx_access  fastpath_rx_access  Comments
 ..struct                            ..net_device                                                    
+unsigned_long:32                    priv_flags              read_mostly         -                   __dev_queue_xmit(tx)
 char                                name[16]                -                   -                   
 struct_netdev_name_node*            name_node                                                       
 struct_dev_ifalias*                 ifalias                                                         
@@ -23,7 +24,6 @@ struct_list_head                    ptype_specific
 struct                              adj_list                                                        
 unsigned_int                        flags                   read_mostly         read_mostly         __dev_queue_xmit,__dev_xmit_skb,ip6_output,__ip6_finish_output(tx);ip6_rcv_core(rx)
 xdp_features_t                      xdp_features                                                    
-unsigned_long_long                  priv_flags              read_mostly         -                   __dev_queue_xmit(tx)
 struct_net_device_ops*              netdev_ops              read_mostly         -                   netdev_core_pick_tx,netdev_start_xmit(tx)
 struct_xdp_metadata_ops*            xdp_metadata_ops                                                
 int                                 ifindex                 -                   read_mostly         ip6_rcv_core
@@ -163,6 +163,8 @@ struct_lock_class_key*              qdisc_tx_busylock
 bool                                proto_down                                                      
 unsigned:1                          wol_enabled                                                     
 unsigned:1                          threaded                -                   -                   napi_poll(napi_enable,dev_set_threaded)
+unsigned_long:1                     see_all_hwtstamp_requests                                       
+unsigned_long:1                     change_proto_down                                               
 struct_list_head                    net_notifier_list                                               
 struct_macsec_ops*                  macsec_ops                                                      
 struct_udp_tunnel_nic_info*         udp_tunnel_nic_info                                             
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3c719f0d5f5a..20ffc7a112da 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1608,7 +1608,8 @@ struct net_device_ops {
  * userspace; this means that the order of these flags can change
  * during any kernel release.
  *
- * You should have a pretty good reason to be extending these flags.
+ * You should add bitfield booleans after either net_device::priv_flags
+ * (hotpath) or ::threaded (slowpath) instead of extending these flags.
  *
  * @IFF_802_1Q_VLAN: 802.1Q VLAN device
  * @IFF_EBRIDGE: Ethernet bridging device
@@ -1647,10 +1648,6 @@ struct net_device_ops {
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
@@ -1685,8 +1682,6 @@ enum netdev_priv_flags {
 	IFF_L3MDEV_RX_HANDLER		= 1<<29,
 	IFF_NO_ADDRCONF			= BIT_ULL(30),
 	IFF_TX_SKB_NO_LINEAR		= BIT_ULL(31),
-	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
-	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -1750,6 +1745,11 @@ enum netdev_reg_state {
  *	data with strictly "high-level" data, and it has to know about
  *	almost every data structure used in the INET module.
  *
+ *	@priv_flags_fast: both hotpath private flags as bits and as bitfield
+ *			booleans combined, only to assert cacheline placement
+ *	@priv_flags:	flags invisible to userspace defined as bits, see
+ *			enum netdev_priv_flags for the definitions
+ *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
  *		of the interface.
@@ -1816,8 +1816,6 @@ enum netdev_reg_state {
  *
  *	@flags:		Interface flags (a la BSD)
  *	@xdp_features:	XDP capability supported by the device
- *	@priv_flags:	Like 'flags' but invisible to userspace,
- *			see if.h for the definitions
  *	@gflags:	Global flags ( kept as legacy )
  *	@padded:	How much padding added by alloc_netdev()
  *	@operstate:	RFC2863 operstate
@@ -1989,6 +1987,12 @@ enum netdev_reg_state {
  *
  *	@threaded:	napi threaded mode is enabled
  *
+ *	@see_all_hwtstamp_requests: device wants to see calls to
+ *			ndo_hwtstamp_set() for all timestamp requests
+ *			regardless of source, even if those aren't
+ *			HWTSTAMP_SOURCE_NETDEV
+ *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
+ *
  *	@module_fw_flash_in_progress:	Module firmware flashing is in progress.
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
@@ -2041,7 +2045,9 @@ struct net_device {
 
 	/* TX read-mostly hotpath */
 	__cacheline_group_begin(net_device_read_tx);
-	unsigned long long	priv_flags;
+	struct_group(priv_flags_fast,
+		unsigned long		priv_flags:32;
+	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;
 	struct netdev_queue	*_tx;
@@ -2376,6 +2382,10 @@ struct net_device {
 	bool			proto_down;
 	bool			threaded;
 
+	/* priv_flags_slow, ungrouped to save space */
+	unsigned long		see_all_hwtstamp_requests:1;
+	unsigned long		change_proto_down:1;
+
 	unsigned		module_fw_flash_in_progress:1;
 	struct list_head	net_notifier_list;
 
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
index ba59e92ab941..c1dedda4e6ba 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3332,7 +3332,8 @@ static void vxlan_setup(struct net_device *dev)
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
 	netif_keep_dst(dev);
-	dev->priv_flags |= IFF_NO_QUEUE | IFF_CHANGE_PROTO_DOWN;
+	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->change_proto_down = true;
 
 	/* MTU range: 68 - 65535 */
 	dev->min_mtu = ETH_MIN_MTU;
diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index 87b959da00cd..fa67374bda49 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -238,9 +238,9 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
 
 	stats = dev_get_stats(vlandev, &temp);
 	seq_printf(seq,
-		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %llx\n",
+		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %x\n",
 		   vlandev->name, vlan->vlan_id,
-		   (int)(vlan->flags & 1), vlandev->priv_flags);
+		   (int)(vlan->flags & 1), (u32)vlandev->priv_flags);
 
 	seq_printf(seq, fmt64, "total frames received", stats->rx_packets);
 	seq_printf(seq, fmt64, "total bytes received", stats->rx_bytes);
diff --git a/net/core/dev.c b/net/core/dev.c
index 385c4091aa77..a2ced6cd5138 100644
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
@@ -11909,7 +11909,7 @@ static struct pernet_operations __net_initdata default_device_ops = {
 static void __init net_dev_struct_check(void)
 {
 	/* TX read-mostly hotpath */
-	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, priv_flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, priv_flags_fast);
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


