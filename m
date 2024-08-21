Return-Path: <netdev+bounces-120638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A42795A0F3
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC70B228E3
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2414EC53;
	Wed, 21 Aug 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiGFsyoh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE8C14E2DE;
	Wed, 21 Aug 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252843; cv=none; b=DrddqdBFmg5gNeU+zFTU10B7AQczyVmpqfdPcrkQlUPMvYiP6XpNepteU0m0xErzZgjMSGA0k1aGqTL+0SFazYrJLkXGG7co+lSKnfUHSQp23bAdSRTXHud5/B6ERvTDmBjmNRtrBZQOlArg4xwZbfjXf4BbIABP06tfwYtzumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252843; c=relaxed/simple;
	bh=kLcDPR3cyDJt9EMbX/RADk9Od5IzI/Qr371OD8mU2G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuSvAgiqmUG6P6bBS9p9dWDicftBltRai0reB5/JgUHJQDoziu3eyvvOWeAdp3iIEOvcpKSsRfKn+dO8uwMYPsLrdqfWUxcLvGrgPMROzdjuo116oZIqsAieta05jFqjNfAD5pEiv4FU9709gL36vG4UY2AcqLAkRHtdMS+CfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiGFsyoh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724252841; x=1755788841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kLcDPR3cyDJt9EMbX/RADk9Od5IzI/Qr371OD8mU2G4=;
  b=NiGFsyoh7gP3PcygO29FYXohweZMtQYttKsqYi8QqU2BvYc/Uhco/Yf8
   6A6zQV/CkGk0vDszk5Ndv0lyrXhYeRgPrPrAgsIqSg95esoY7KJAZ/LvP
   zgQjO5ac69ccKnCKlWlRsAx6yQO35/ckdRKwLWoVI3azHKrmfY2wwZq1l
   JuR9vV/kZ3/O1cVkEWnh1LTjHOdbcVGW0qmJmm6pcVGRV7e3rjhOzL9Ro
   EFViznXVqgZb6HqjSWDYOzZ5lTtB2tSuGUq2PsFyNGzJ+k2+xjfJRZBJD
   OKZnuimZ+z/aA0VdLj8+FSUJo6+UPFagAQQQxdzKsE2pqtUNoaYppUvXB
   g==;
X-CSE-ConnectionGUID: Yf0EBpbMSDmlsjNfpmUabg==
X-CSE-MsgGUID: e4KApfbHRfy2gvavX5QGCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22769271"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22769271"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:07:21 -0700
X-CSE-ConnectionGUID: 8a9lhOlIRWyL6Jv1SzlgbQ==
X-CSE-MsgGUID: 2SqM2lwJRnyWy6sZcSZrFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84291276"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2024 08:07:18 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 5/6] netdev_features: convert NETIF_F_FCOE_MTU to dev->fcoe_mtu
Date: Wed, 21 Aug 2024 17:06:59 +0200
Message-ID: <20240821150700.1760518-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ability to handle maximum FCoE frames of 2158 bytes can never be changed
and thus more of an attribute, not a toggleable feature.
Move it from netdev_features_t to "cold" priv flags (bitfield bool) and
free yet another feature bit.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../networking/net_cachelines/net_device.rst          |  1 +
 include/linux/netdev_features.h                       |  5 +----
 include/linux/netdevice.h                             |  2 ++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c       |  6 ++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c       |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c         |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c          |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c         | 11 ++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c        |  4 ++--
 drivers/scsi/fcoe/fcoe.c                              |  4 ++--
 net/8021q/vlan_dev.c                                  |  1 +
 net/ethtool/common.c                                  |  1 -
 12 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index e65ffdfc9e0a..c3bbf101a887 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -167,6 +167,7 @@ unsigned:1                          threaded                -
 unsigned_long:1                     see_all_hwtstamp_requests                                       
 unsigned_long:1                     change_proto_down                                               
 unsigned_long:1                     netns_local                                                     
+unsigned_long:1                     fcoe_mtu                                                        
 struct_list_head                    net_notifier_list                                               
 struct_macsec_ops*                  macsec_ops                                                      
 struct_udp_tunnel_nic_info*         udp_tunnel_nic_info                                             
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 3bacd4b1adc9..1e9c4da181af 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -55,7 +55,6 @@ enum {
 
 	NETIF_F_FCOE_CRC_BIT,		/* FCoE CRC32 */
 	NETIF_F_SCTP_CRC_BIT,		/* SCTP checksum offload */
-	NETIF_F_FCOE_MTU_BIT,		/* Supports max FCoE MTU, 2158 bytes*/
 	NETIF_F_NTUPLE_BIT,		/* N-tuple filters supported */
 	NETIF_F_RXHASH_BIT,		/* Receive hashing offload */
 	NETIF_F_RXCSUM_BIT,		/* Receive checksumming offload */
@@ -102,7 +101,6 @@ enum {
 #define __NETIF_F(name)		__NETIF_F_BIT(NETIF_F_##name##_BIT)
 
 #define NETIF_F_FCOE_CRC	__NETIF_F(FCOE_CRC)
-#define NETIF_F_FCOE_MTU	__NETIF_F(FCOE_MTU)
 #define NETIF_F_FRAGLIST	__NETIF_F(FRAGLIST)
 #define NETIF_F_FSO		__NETIF_F(FSO)
 #define NETIF_F_GRO		__NETIF_F(GRO)
@@ -207,8 +205,7 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 #define NETIF_F_ALL_TSO 	(NETIF_F_TSO | NETIF_F_TSO6 | \
 				 NETIF_F_TSO_ECN | NETIF_F_TSO_MANGLEID)
 
-#define NETIF_F_ALL_FCOE	(NETIF_F_FCOE_CRC | NETIF_F_FCOE_MTU | \
-				 NETIF_F_FSO)
+#define NETIF_F_ALL_FCOE	(NETIF_F_FCOE_CRC | NETIF_F_FSO)
 
 /* List of features with software fallbacks. */
 #define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |	     \
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1d5359ad87e1..cbfa6b42eabb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1963,6 +1963,7 @@ enum netdev_reg_state {
  *			HWTSTAMP_SOURCE_NETDEV
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@netns_local: interface can't change network namespaces
+ *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
@@ -2356,6 +2357,7 @@ struct net_device {
 	unsigned long		see_all_hwtstamp_requests:1;
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_local:1;
+	unsigned long		fcoe_mtu:1;
 
 	struct list_head	net_notifier_list;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c
index 33b2c0c45509..f6f745f5c022 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c
@@ -81,8 +81,7 @@ int cxgb_fcoe_enable(struct net_device *netdev)
 
 	netdev->features |= NETIF_F_FCOE_CRC;
 	netdev->vlan_features |= NETIF_F_FCOE_CRC;
-	netdev->features |= NETIF_F_FCOE_MTU;
-	netdev->vlan_features |= NETIF_F_FCOE_MTU;
+	netdev->fcoe_mtu = true;
 
 	netdev_features_change(netdev);
 
@@ -112,8 +111,7 @@ int cxgb_fcoe_disable(struct net_device *netdev)
 
 	netdev->features &= ~NETIF_F_FCOE_CRC;
 	netdev->vlan_features &= ~NETIF_F_FCOE_CRC;
-	netdev->features &= ~NETIF_F_FCOE_MTU;
-	netdev->vlan_features &= ~NETIF_F_FCOE_MTU;
+	netdev->fcoe_mtu = false;
 
 	netdev_features_change(netdev);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
index e85f7d2e8810..f2709b10c2e5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
@@ -317,7 +317,7 @@ static u8 ixgbe_dcbnl_set_all(struct net_device *netdev)
 		int max_frame = adapter->netdev->mtu + ETH_HLEN + ETH_FCS_LEN;
 
 #ifdef IXGBE_FCOE
-		if (adapter->netdev->features & NETIF_F_FCOE_MTU)
+		if (adapter->netdev->fcoe_mtu)
 			max_frame = max(max_frame, IXGBE_FCOE_JUMBO_FRAME_SIZE);
 #endif
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 18d63c8c2ff4..955dced844a9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -858,7 +858,7 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
 
 	/* enable FCoE and notify stack */
 	adapter->flags |= IXGBE_FLAG_FCOE_ENABLED;
-	netdev->features |= NETIF_F_FCOE_MTU;
+	netdev->fcoe_mtu = true;
 	netdev_features_change(netdev);
 
 	/* release existing queues and reallocate them */
@@ -898,7 +898,7 @@ int ixgbe_fcoe_disable(struct net_device *netdev)
 
 	/* disable FCoE and notify stack */
 	adapter->flags &= ~IXGBE_FLAG_FCOE_ENABLED;
-	netdev->features &= ~NETIF_F_FCOE_MTU;
+	netdev->fcoe_mtu = false;
 
 	netdev_features_change(netdev);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index 0ee943db3dc9..16fa621ce0ff 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -981,7 +981,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 			set_bit(__IXGBE_RX_CSUM_UDP_ZERO_ERR, &ring->state);
 
 #ifdef IXGBE_FCOE
-		if (adapter->netdev->features & NETIF_F_FCOE_MTU) {
+		if (adapter->netdev->fcoe_mtu) {
 			struct ixgbe_ring_feature *f;
 			f = &adapter->ring_feature[RING_F_FCOE];
 			if ((rxr_idx >= f->offset) &&
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8057cef61f39..8b8404d8c946 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5079,7 +5079,7 @@ static void ixgbe_configure_dcb(struct ixgbe_adapter *adapter)
 		netif_set_tso_max_size(adapter->netdev, 32768);
 
 #ifdef IXGBE_FCOE
-	if (adapter->netdev->features & NETIF_F_FCOE_MTU)
+	if (adapter->netdev->fcoe_mtu)
 		max_frame = max(max_frame, IXGBE_FCOE_JUMBO_FRAME_SIZE);
 #endif
 
@@ -5136,8 +5136,7 @@ static int ixgbe_hpbthresh(struct ixgbe_adapter *adapter, int pb)
 
 #ifdef IXGBE_FCOE
 	/* FCoE traffic class uses FCOE jumbo frames */
-	if ((dev->features & NETIF_F_FCOE_MTU) &&
-	    (tc < IXGBE_FCOE_JUMBO_FRAME_SIZE) &&
+	if (dev->fcoe_mtu && tc < IXGBE_FCOE_JUMBO_FRAME_SIZE &&
 	    (pb == ixgbe_fcoe_get_tc(adapter)))
 		tc = IXGBE_FCOE_JUMBO_FRAME_SIZE;
 #endif
@@ -5197,8 +5196,7 @@ static int ixgbe_lpbthresh(struct ixgbe_adapter *adapter, int pb)
 
 #ifdef IXGBE_FCOE
 	/* FCoE traffic class uses FCOE jumbo frames */
-	if ((dev->features & NETIF_F_FCOE_MTU) &&
-	    (tc < IXGBE_FCOE_JUMBO_FRAME_SIZE) &&
+	if (dev->fcoe_mtu && tc < IXGBE_FCOE_JUMBO_FRAME_SIZE &&
 	    (pb == netdev_get_prio_tc_map(dev, adapter->fcoe.up)))
 		tc = IXGBE_FCOE_JUMBO_FRAME_SIZE;
 #endif
@@ -11096,8 +11094,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				    NETIF_F_FCOE_CRC;
 
 		netdev->vlan_features |= NETIF_F_FSO |
-					 NETIF_F_FCOE_CRC |
-					 NETIF_F_FCOE_MTU;
+					 NETIF_F_FCOE_CRC;
 	}
 #endif /* IXGBE_FCOE */
 	if (adapter->flags2 & IXGBE_FLAG2_RSC_CAPABLE)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index fcfd0a075eee..e71715f5da22 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -495,7 +495,7 @@ static int ixgbe_set_vf_lpe(struct ixgbe_adapter *adapter, u32 max_frame, u32 vf
 		int err = 0;
 
 #ifdef CONFIG_FCOE
-		if (dev->features & NETIF_F_FCOE_MTU)
+		if (dev->fcoe_mtu)
 			pf_max_frame = max_t(int, pf_max_frame,
 					     IXGBE_FCOE_JUMBO_FRAME_SIZE);
 
@@ -857,7 +857,7 @@ static void ixgbe_set_vf_rx_tx(struct ixgbe_adapter *adapter, int vf)
 		int pf_max_frame = dev->mtu + ETH_HLEN;
 
 #if IS_ENABLED(CONFIG_FCOE)
-		if (dev->features & NETIF_F_FCOE_MTU)
+		if (dev->fcoe_mtu)
 			pf_max_frame = max_t(int, pf_max_frame,
 					     IXGBE_FCOE_JUMBO_FRAME_SIZE);
 #endif /* CONFIG_FCOE */
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index f1429f270170..39aec710660c 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -722,7 +722,7 @@ static int fcoe_netdev_config(struct fc_lport *lport, struct net_device *netdev)
 	 * will return 0, so do this first.
 	 */
 	mfs = netdev->mtu;
-	if (netdev->features & NETIF_F_FCOE_MTU) {
+	if (netdev->fcoe_mtu) {
 		mfs = FCOE_MTU;
 		FCOE_NETDEV_DBG(netdev, "Supports FCOE_MTU of %d bytes\n", mfs);
 	}
@@ -1863,7 +1863,7 @@ static int fcoe_device_notification(struct notifier_block *notifier,
 	case NETDEV_CHANGE:
 		break;
 	case NETDEV_CHANGEMTU:
-		if (netdev->features & NETIF_F_FCOE_MTU)
+		if (netdev->fcoe_mtu)
 			break;
 		mfs = netdev->mtu - (sizeof(struct fcoe_hdr) +
 				     sizeof(struct fcoe_crc_eof));
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 3ca485537d77..09b46b057ab2 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -571,6 +571,7 @@ static int vlan_dev_init(struct net_device *dev)
 
 	dev->features |= dev->hw_features;
 	dev->lltx = true;
+	dev->fcoe_mtu = true;
 	netif_inherit_tso_max(dev, real_dev);
 	if (dev->features & NETIF_F_VLAN_FEATURES)
 		netdev_warn(real_dev, "VLAN features are set incorrectly.  Q-in-Q configurations may not work correctly.\n");
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index ca8e64162104..00f93c58b319 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -50,7 +50,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 
 	[NETIF_F_FCOE_CRC_BIT] =         "tx-checksum-fcoe-crc",
 	[NETIF_F_SCTP_CRC_BIT] =        "tx-checksum-sctp",
-	[NETIF_F_FCOE_MTU_BIT] =         "fcoe-mtu",
 	[NETIF_F_NTUPLE_BIT] =           "rx-ntuple-filter",
 	[NETIF_F_RXHASH_BIT] =           "rx-hashing",
 	[NETIF_F_RXCSUM_BIT] =           "rx-checksum",
-- 
2.46.0


