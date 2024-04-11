Return-Path: <netdev+bounces-87045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1051D8A16D4
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 16:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A435B244D0
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2868C09;
	Thu, 11 Apr 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ChZjs/8V"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648814D452
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844760; cv=none; b=UMQ2DKAMgpxkO9QunxyiEj8huxF2dfQGn6HI0YsgrmMUZQt6q/wL3H/5Osp82Tiryv+0fVoYO/duy3hJdUAzZyEe2HMza1S46LIwnknr8bDv6o5ZyJp9k/8BjOB+bXlHbpvkqv7Lvgu4cEqY/xEqJrnrtXO/Zdh/Fl88eH2iqtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844760; c=relaxed/simple;
	bh=1YSXkQ2tfXRzIyb3axPAbvkmIXJVB1E8y2JAAt+Lvmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=u/pXP/MqDOvrKJ8Ge3nEBz+cRF1exB0gKP2g7d/Zd5XsexLDj8gtidss3+em/Pt4X6Y7ReI3DFIzoYVNUzx4cL7il5niO/qtVgfp5MXCCiM6iUjmu3GtO71BwCswo9GUtbgvhjVzbY4IMFdkpAjK9Q0GYnsgm+KSO6SKU4kgeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ChZjs/8V; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712844755; h=From:To:Subject:Date:Message-Id;
	bh=ZSEdAEumG/61e6u3Mjlb3DRj13R3KWiftvxbXxtc2pc=;
	b=ChZjs/8VBmQzQdP3uzw7rTXe4HQyys79QBRW157AlgyyT5GKI/gAHiAzSm3BSM6qUESx7hRxEd3o1xrqboIjODsUpKmSKGf8/ObjMJsKYgYVP5LangSkNpGaedK9oxjG1oSP/yJ3Yns4ad5Dt0iXzvFMO0/xEy/W90kQbujerc4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4LVne3_1712844754;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4LVne3_1712844754)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 22:12:34 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v6 2/4] ethtool: provide customized dim profile management
Date: Thu, 11 Apr 2024 22:12:29 +0800
Message-Id: <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
References: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The NetDIM library, currently leveraged by an array of NICs, delivers
excellent acceleration benefits. Nevertheless, NICs vary significantly
in their dim profile list prerequisites.

Specifically, virtio-net backends may present diverse sw or hw device
implementation, making a one-size-fits-all parameter list impractical.
On Alibaba Cloud, the virtio DPU's performance under the default DIM
profile falls short of expectations, partly due to a mismatch in
parameter configuration.

I also noticed that ice/idpf/ena and other NICs have customized
profilelist or placed some restrictions on dim capabilities.

Motivated by this, I tried adding new params for "ethtool -C" that provides
a per-device control to modify and access a device's interrupt parameters.

Usage
========
1. Query the currently customized list of the device

$ ethtool -c ethx
...
rx-eqe-profile:
{.usec =   1, .pkts = 256, .comps =   0,},
{.usec =   8, .pkts = 256, .comps =   0,},
{.usec =  64, .pkts = 256, .comps =   0,},
{.usec = 128, .pkts = 256, .comps =   0,},
{.usec = 256, .pkts = 256, .comps =   0,}
rx-cqe-profile:   n/a
tx-eqe-profile:   n/a
tx-cqe-profile:   n/a

2. Tune
$ ethtool -C ethx rx-eqe-profile 1,1,0_2,2,0_3,3,0_4,4,0_5,5,0
$ ethtool -c ethx
...
rx-eqe-profile:
{.usec =   1, .pkts =   1, .comps =   0,},
{.usec =   2, .pkts =   2, .comps =   0,},
{.usec =   3, .pkts =   3, .comps =   0,},
{.usec =   4, .pkts =   4, .comps =   0,},
{.usec =   5, .pkts =   5, .comps =   0,}
rx-cqe-profile:   n/a
tx-eqe-profile:   n/a
tx-cqe-profile:   n/a

3. Hint
If the device does not support some type of customized dim
profiles, the corresponding "n/a" will display.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 Documentation/netlink/specs/ethtool.yaml     |  33 +++++
 Documentation/networking/ethtool-netlink.rst |   8 ++
 include/linux/ethtool.h                      |  12 +-
 include/linux/netdevice.h                    |  15 +++
 include/uapi/linux/ethtool_netlink.h         |  24 ++++
 net/core/dev.c                               |  63 +++++++++
 net/ethtool/coalesce.c                       | 184 ++++++++++++++++++++++++++-
 7 files changed, 336 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 87ae7b3..1a560ff 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -413,6 +413,18 @@ attribute-sets:
       -
         name: combined-count
         type: u32
+  -
+    name: moderation
+    attributes:
+      -
+        name: usec
+        type: u16
+      -
+        name: pkts
+        type: u16
+      -
+        name: comps
+        type: u16
 
   -
     name: coalesce
@@ -502,6 +514,23 @@ attribute-sets:
       -
         name: tx-aggr-time-usecs
         type: u32
+      -
+        name: rx-eqe-profile
+        type: nest
+        nested-attributes: moderation
+      -
+        name: rx-cqe-profile
+        type: nest
+        nested-attributes: moderation
+      -
+        name: tx-eqe-profile
+        type: nest
+        nested-attributes: moderation
+      -
+        name: tx-cqe-profile
+        type: nest
+        nested-attributes: moderation
+
   -
     name: pause-stat
     attributes:
@@ -1313,6 +1342,10 @@ operations:
             - tx-aggr-max-bytes
             - tx-aggr-max-frames
             - tx-aggr-time-usecs
+            - rx-eqe-profile
+            - rx-cqe-profile
+            - tx-eqe-profile
+            - tx-cqe-profile
       dump: *coalesce-get-op
     -
       name: coalesce-set
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 5dc42f7..4d9eecf 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1040,6 +1040,10 @@ Kernel response contents:
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES``     u32     max aggr size, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES``    u32     max aggr packets, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
+  ``ETHTOOL_A_COALESCE_RX_EQE_PROFILE``        nested  profile of DIM EQE, Rx
+  ``ETHTOOL_A_COALESCE_RX_CQE_PROFILE``        nested  profile of DIM CQE, Rx
+  ``ETHTOOL_A_COALESCE_TX_EQE_PROFILE``        nested  profile of DIM EQE, Tx
+  ``ETHTOOL_A_COALESCE_TX_CQE_PROFILE``        nested  profile of DIM CQE, Tx
   ===========================================  ======  =======================
 
 Attributes are only included in reply if their value is not zero or the
@@ -1105,6 +1109,10 @@ Request contents:
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES``     u32     max aggr size, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES``    u32     max aggr packets, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
+  ``ETHTOOL_A_COALESCE_RX_EQE_PROFILE``        nested  profile of DIM EQE, Rx
+  ``ETHTOOL_A_COALESCE_RX_CQE_PROFILE``        nested  profile of DIM CQE, Rx
+  ``ETHTOOL_A_COALESCE_TX_EQE_PROFILE``        nested  profile of DIM EQE, Tx
+  ``ETHTOOL_A_COALESCE_TX_CQE_PROFILE``        nested  profile of DIM CQE, Tx
   ===========================================  ======  =======================
 
 Request is rejected if it attributes declared as unsupported by driver (i.e.
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6fd9107..1dcfbe5 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -18,6 +18,7 @@
 #include <linux/if_ether.h>
 #include <linux/netlink.h>
 #include <uapi/linux/ethtool.h>
+#include <linux/dim.h>
 
 struct compat_ethtool_rx_flow_spec {
 	u32		flow_type;
@@ -284,7 +285,11 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
 #define ETHTOOL_COALESCE_TX_AGGR_MAX_BYTES	BIT(24)
 #define ETHTOOL_COALESCE_TX_AGGR_MAX_FRAMES	BIT(25)
 #define ETHTOOL_COALESCE_TX_AGGR_TIME_USECS	BIT(26)
-#define ETHTOOL_COALESCE_ALL_PARAMS		GENMASK(26, 0)
+#define ETHTOOL_COALESCE_RX_EQE_PROFILE         BIT(27)
+#define ETHTOOL_COALESCE_RX_CQE_PROFILE         BIT(28)
+#define ETHTOOL_COALESCE_TX_EQE_PROFILE         BIT(29)
+#define ETHTOOL_COALESCE_TX_CQE_PROFILE         BIT(30)
+#define ETHTOOL_COALESCE_ALL_PARAMS		GENMASK(30, 0)
 
 #define ETHTOOL_COALESCE_USECS						\
 	(ETHTOOL_COALESCE_RX_USECS | ETHTOOL_COALESCE_TX_USECS)
@@ -316,6 +321,11 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
 	(ETHTOOL_COALESCE_TX_AGGR_MAX_BYTES |	\
 	 ETHTOOL_COALESCE_TX_AGGR_MAX_FRAMES |	\
 	 ETHTOOL_COALESCE_TX_AGGR_TIME_USECS)
+#define ETHTOOL_COALESCE_PROFILE		\
+	(ETHTOOL_COALESCE_RX_EQE_PROFILE |	\
+	 ETHTOOL_COALESCE_RX_CQE_PROFILE |	\
+	 ETHTOOL_COALESCE_TX_EQE_PROFILE |	\
+	 ETHTOOL_COALESCE_TX_CQE_PROFILE)
 
 #define ETHTOOL_STAT_NOT_SET	(~0ULL)
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d45f330..d2f499a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -48,6 +48,7 @@
 #include <uapi/linux/netdev.h>
 #include <linux/hashtable.h>
 #include <linux/rbtree.h>
+#include <linux/dim.h>
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
@@ -1649,6 +1650,9 @@ struct net_device_ops {
  * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
  *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
  *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
+ * @IFF_PROFILE_USEC: device supports adjusting the DIM profile's usec field
+ * @IFF_PROFILE_PKTS: device supports adjusting the DIM profile's pkts field
+ * @IFF_PROFILE_COMPS: device supports adjusting the DIM profile's comps field
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1685,6 +1689,9 @@ enum netdev_priv_flags {
 	IFF_TX_SKB_NO_LINEAR		= BIT_ULL(31),
 	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
 	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
+	IFF_PROFILE_USEC		= BIT_ULL(34),
+	IFF_PROFILE_PKTS		= BIT_ULL(35),
+	IFF_PROFILE_COMPS		= BIT_ULL(36),
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -2400,6 +2407,14 @@ struct net_device {
 	/** @page_pools: page pools created for this netdevice */
 	struct hlist_head	page_pools;
 #endif
+
+#if IS_ENABLED(CONFIG_DIMLIB)
+	/* DIM profile lists for different dim cq modes */
+	struct dim_cq_moder *rx_eqe_profile;
+	struct dim_cq_moder *rx_cqe_profile;
+	struct dim_cq_moder *tx_eqe_profile;
+	struct dim_cq_moder *tx_cqe_profile;
+#endif
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 23e225f..81c6d9e 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -416,12 +416,36 @@ enum {
 	ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES,		/* u32 */
 	ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,		/* u32 */
 	ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,		/* u32 */
+	ETHTOOL_A_COALESCE_RX_EQE_PROFILE,              /* nest - _A_MODERATIONS_MODERATION */
+	ETHTOOL_A_COALESCE_RX_CQE_PROFILE,              /* nest - _A_MODERATIONS_MODERATION */
+	ETHTOOL_A_COALESCE_TX_EQE_PROFILE,              /* nest - _A_MODERATIONS_MODERATION */
+	ETHTOOL_A_COALESCE_TX_CQE_PROFILE,              /* nest - _A_MODERATIONS_MODERATION */
 
 	/* add new constants above here */
 	__ETHTOOL_A_COALESCE_CNT,
 	ETHTOOL_A_COALESCE_MAX = (__ETHTOOL_A_COALESCE_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_MODERATIONS_UNSPEC,
+	ETHTOOL_A_MODERATIONS_MODERATION,		/* nest, _A_MODERATION_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_MODERATIONS_CNT,
+	ETHTOOL_A_MODERATIONS_MAX = (__ETHTOOL_A_MODERATIONS_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MODERATION_UNSPEC,
+	ETHTOOL_A_MODERATION_USEC,			/* u16 */
+	ETHTOOL_A_MODERATION_PKTS,			/* u16 */
+	ETHTOOL_A_MODERATION_COMPS,			/* u16 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_MODERATION_CNT,
+	ETHTOOL_A_MODERATION_MAX = (__ETHTOOL_A_MODERATION_CNT - 1)
+};
+
 /* PAUSE */
 
 enum {
diff --git a/net/core/dev.c b/net/core/dev.c
index 854a3a2..bc38f33 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -154,6 +154,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
+#include <linux/ethtool.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
@@ -10229,6 +10230,42 @@ static void netdev_do_free_pcpu_stats(struct net_device *dev)
 	}
 }
 
+static int dev_dim_profile_init(struct net_device *dev)
+{
+	int length = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*dev->rx_eqe_profile);
+	u32 supported = dev->ethtool_ops->supported_coalesce_params;
+
+	if (!(dev->priv_flags & (IFF_PROFILE_USEC | IFF_PROFILE_PKTS | IFF_PROFILE_COMPS)))
+		return 0;
+
+	if (supported & ETHTOOL_COALESCE_RX_EQE_PROFILE) {
+		dev->rx_eqe_profile = kzalloc(length, GFP_KERNEL);
+		if (!dev->rx_eqe_profile)
+			return -ENOMEM;
+		memcpy(dev->rx_eqe_profile, rx_profile[0], length);
+	}
+	if (supported & ETHTOOL_COALESCE_RX_CQE_PROFILE) {
+		dev->rx_cqe_profile = kzalloc(length, GFP_KERNEL);
+		if (!dev->rx_cqe_profile)
+			return -ENOMEM;
+		memcpy(dev->rx_cqe_profile, rx_profile[1], length);
+	}
+	if (supported & ETHTOOL_COALESCE_TX_EQE_PROFILE) {
+		dev->tx_eqe_profile = kzalloc(length, GFP_KERNEL);
+		if (!dev->tx_eqe_profile)
+			return -ENOMEM;
+		memcpy(dev->tx_eqe_profile, tx_profile[0], length);
+	}
+	if (supported & ETHTOOL_COALESCE_TX_CQE_PROFILE) {
+		dev->tx_cqe_profile = kzalloc(length, GFP_KERNEL);
+		if (!dev->tx_cqe_profile)
+			return -ENOMEM;
+		memcpy(dev->tx_cqe_profile, tx_profile[1], length);
+	}
+
+	return 0;
+}
+
 /**
  * register_netdevice() - register a network device
  * @dev: device to register
@@ -10258,6 +10295,10 @@ int register_netdevice(struct net_device *dev)
 	if (ret)
 		return ret;
 
+	ret = dev_dim_profile_init(dev);
+	if (ret)
+		return ret;
+
 	spin_lock_init(&dev->addr_list_lock);
 	netdev_set_addr_lockdep_class(dev);
 
@@ -11011,6 +11052,26 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 }
 EXPORT_SYMBOL(alloc_netdev_mqs);
 
+static void netif_free_profile(struct net_device *dev)
+{
+	u32 supported = dev->ethtool_ops->supported_coalesce_params;
+
+	if (!(dev->priv_flags & (IFF_PROFILE_USEC | IFF_PROFILE_PKTS | IFF_PROFILE_COMPS)))
+		return;
+
+	if (supported & ETHTOOL_COALESCE_RX_EQE_PROFILE)
+		kfree(dev->rx_eqe_profile);
+
+	if (supported & ETHTOOL_COALESCE_RX_CQE_PROFILE)
+		kfree(dev->rx_cqe_profile);
+
+	if (supported & ETHTOOL_COALESCE_TX_EQE_PROFILE)
+		kfree(dev->tx_eqe_profile);
+
+	if (supported & ETHTOOL_COALESCE_TX_CQE_PROFILE)
+		kfree(dev->tx_cqe_profile);
+}
+
 /**
  * free_netdev - free network device
  * @dev: device
@@ -11036,6 +11097,8 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
+	netif_free_profile(dev);
+
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
 
diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 83112c1..7b542c3e 100644
--- a/net/ethtool/coalesce.c
+++ b/net/ethtool/coalesce.c
@@ -51,6 +51,10 @@ static u32 attr_to_mask(unsigned int attr_type)
 __CHECK_SUPPORTED_OFFSET(COALESCE_TX_USECS_HIGH);
 __CHECK_SUPPORTED_OFFSET(COALESCE_TX_MAX_FRAMES_HIGH);
 __CHECK_SUPPORTED_OFFSET(COALESCE_RATE_SAMPLE_INTERVAL);
+__CHECK_SUPPORTED_OFFSET(COALESCE_RX_EQE_PROFILE);
+__CHECK_SUPPORTED_OFFSET(COALESCE_RX_CQE_PROFILE);
+__CHECK_SUPPORTED_OFFSET(COALESCE_TX_EQE_PROFILE);
+__CHECK_SUPPORTED_OFFSET(COALESCE_TX_CQE_PROFILE);
 
 const struct nla_policy ethnl_coalesce_get_policy[] = {
 	[ETHTOOL_A_COALESCE_HEADER]		=
@@ -82,6 +86,13 @@ static int coalesce_prepare_data(const struct ethnl_req_info *req_base,
 static int coalesce_reply_size(const struct ethnl_req_info *req_base,
 			       const struct ethnl_reply_data *reply_base)
 {
+	int modersz = nla_total_size(0) + /* _MODERATIONS_MODERATION, nest */
+		      nla_total_size(sizeof(u16)) + /* _MODERATION_USEC */
+		      nla_total_size(sizeof(u16)) + /* _MODERATION_PKTS */
+		      nla_total_size(sizeof(u16));  /* _MODERATION_COMPS */
+	int total_modersz = nla_total_size(0) +  /* _{R,T}X_{E,C}QE_PROFILE, nest */
+			    modersz * NET_DIM_PARAMS_NUM_PROFILES;
+
 	return nla_total_size(sizeof(u32)) +	/* _RX_USECS */
 	       nla_total_size(sizeof(u32)) +	/* _RX_MAX_FRAMES */
 	       nla_total_size(sizeof(u32)) +	/* _RX_USECS_IRQ */
@@ -108,7 +119,8 @@ static int coalesce_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u8)) +	/* _USE_CQE_MODE_RX */
 	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_BYTES */
 	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_FRAMES */
-	       nla_total_size(sizeof(u32));	/* _TX_AGGR_TIME_USECS */
+	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_TIME_USECS */
+	       total_modersz * 4;		/* _{R,T}X_{E,C}QE_PROFILE */
 }
 
 static bool coalesce_put_u32(struct sk_buff *skb, u16 attr_type, u32 val,
@@ -127,6 +139,67 @@ static bool coalesce_put_bool(struct sk_buff *skb, u16 attr_type, u32 val,
 	return nla_put_u8(skb, attr_type, !!val);
 }
 
+/**
+ * coalesce_put_profile - fill reply with a nla nest with four child nla nests.
+ * @skb: socket buffer the message is stored in
+ * @attr_type: nest attr type ETHTOOL_A_COALESCE_*X_*QE_PROFILE
+ * @profile: data passed to userspace
+ * @supported_params: modifiable parameters supported by the driver
+ *
+ * Put a dim profile nest attribute. Refer to ETHTOOL_A_MODERATIONS_MODERATION.
+ *
+ * Returns false to indicate successful placement or no placement, and
+ * returns true to pass the -EMSGSIZE error to the wrapper.
+ */
+static bool coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
+				 const struct dim_cq_moder *profile,
+				 u32 supported_params)
+{
+	struct nlattr *profile_attr, *moder_attr;
+	bool valid = false, emsg = !!-EMSGSIZE;
+	int i;
+
+	if (!profile)
+		return false;
+
+	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
+		if (profile[i].usec || profile[i].pkts || profile[i].comps) {
+			valid = true;
+			break;
+		}
+	}
+
+	if (!valid || !(supported_params & attr_to_mask(attr_type)))
+		return false;
+
+	profile_attr = nla_nest_start(skb, attr_type);
+	if (!profile_attr)
+		return emsg;
+
+	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
+		moder_attr = nla_nest_start(skb, ETHTOOL_A_MODERATIONS_MODERATION);
+		if (!moder_attr)
+			goto nla_cancel_profile;
+
+		if (nla_put_u16(skb, ETHTOOL_A_MODERATION_USEC, profile[i].usec) ||
+		    nla_put_u16(skb, ETHTOOL_A_MODERATION_PKTS, profile[i].pkts) ||
+		    nla_put_u16(skb, ETHTOOL_A_MODERATION_COMPS, profile[i].comps))
+			goto nla_cancel_moder;
+
+		nla_nest_end(skb, moder_attr);
+	}
+
+	nla_nest_end(skb, profile_attr);
+
+	return 0;
+
+nla_cancel_moder:
+	nla_nest_cancel(skb, moder_attr);
+nla_cancel_profile:
+	nla_nest_cancel(skb, profile_attr);
+	return emsg;
+}
+
 static int coalesce_fill_reply(struct sk_buff *skb,
 			       const struct ethnl_req_info *req_base,
 			       const struct ethnl_reply_data *reply_base)
@@ -134,6 +207,7 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 	const struct coalesce_reply_data *data = COALESCE_REPDATA(reply_base);
 	const struct kernel_ethtool_coalesce *kcoal = &data->kernel_coalesce;
 	const struct ethtool_coalesce *coal = &data->coalesce;
+	struct net_device *dev = req_base->dev;
 	u32 supported = data->supported_params;
 
 	if (coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_USECS,
@@ -189,7 +263,15 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,
 			     kcoal->tx_aggr_max_frames, supported) ||
 	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,
-			     kcoal->tx_aggr_time_usecs, supported))
+			     kcoal->tx_aggr_time_usecs, supported) ||
+	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_EQE_PROFILE,
+				 dev->rx_eqe_profile, supported) ||
+	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_CQE_PROFILE,
+				 dev->rx_cqe_profile, supported) ||
+	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_EQE_PROFILE,
+				 dev->tx_eqe_profile, supported) ||
+	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_CQE_PROFILE,
+				 dev->tx_cqe_profile, supported))
 		return -EMSGSIZE;
 
 	return 0;
@@ -227,6 +309,16 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES] = { .type = NLA_U32 },
 	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES] = { .type = NLA_U32 },
 	[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS] = { .type = NLA_U32 },
+	[ETHTOOL_A_COALESCE_RX_EQE_PROFILE]     = { .type = NLA_NESTED },
+	[ETHTOOL_A_COALESCE_RX_CQE_PROFILE]     = { .type = NLA_NESTED },
+	[ETHTOOL_A_COALESCE_TX_EQE_PROFILE]     = { .type = NLA_NESTED },
+	[ETHTOOL_A_COALESCE_TX_CQE_PROFILE]     = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy coalesce_set_profile_policy[] = {
+	[ETHTOOL_A_MODERATION_USEC]	= {.type = NLA_U16},
+	[ETHTOOL_A_MODERATION_PKTS]	= {.type = NLA_U16},
+	[ETHTOOL_A_MODERATION_COMPS]	= {.type = NLA_U16},
 };
 
 static int
@@ -253,6 +345,73 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 	return 1;
 }
 
+/**
+ * ethnl_update_profile - get a nla nest with four child nla nests from userspace.
+ * @dst: data get from the driver and modified by ethnl_update_profile.
+ * @nests: nest attr ETHTOOL_A_COALESCE_*X_*QE_PROFILE to set driver's profile.
+ * @mod: whether the data is modified
+ * @extack: Netlink extended ack
+ *
+ * Layout of nests:
+ *   Nested ETHTOOL_A_COALESCE_*X_*QE_PROFILE attr
+ *     Nested ETHTOOL_A_MODERATIONS_MODERATION attr
+ *       ETHTOOL_A_MODERATION_USEC attr
+ *       ETHTOOL_A_MODERATION_PKTS attr
+ *       ETHTOOL_A_MODERATION_COMPS attr
+ *     ...
+ *     Nested ETHTOOL_A_MODERATIONS_MODERATION attr
+ *       ETHTOOL_A_MODERATION_USEC attr
+ *       ETHTOOL_A_MODERATION_PKTS attr
+ *       ETHTOOL_A_MODERATION_COMPS attr
+ *
+ * Returns 0 on success or a negative error code.
+ */
+static inline int ethnl_update_profile(struct net_device *dev,
+				       struct dim_cq_moder *dst,
+				       const struct nlattr *nests,
+				       struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb_moder[ARRAY_SIZE(coalesce_set_profile_policy)];
+	struct dim_cq_moder profile[NET_DIM_PARAMS_NUM_PROFILES];
+	struct nlattr *nest;
+	int ret, rem, i = 0;
+
+	if (!nests)
+		return 0;
+
+	if (!dst)
+		return -EOPNOTSUPP;
+
+	nla_for_each_nested_type(nest, ETHTOOL_A_MODERATIONS_MODERATION, nests, rem) {
+		ret = nla_parse_nested(tb_moder,
+				       ARRAY_SIZE(coalesce_set_profile_policy) - 1,
+				       nest, coalesce_set_profile_policy,
+				       extack);
+		if (ret)
+			return ret;
+
+		if (NL_REQ_ATTR_CHECK(extack, nest, tb_moder, ETHTOOL_A_MODERATION_USEC) ||
+		    NL_REQ_ATTR_CHECK(extack, nest, tb_moder, ETHTOOL_A_MODERATION_PKTS) ||
+		    NL_REQ_ATTR_CHECK(extack, nest, tb_moder, ETHTOOL_A_MODERATION_COMPS))
+			return -EINVAL;
+
+		profile[i].usec = nla_get_u16(tb_moder[ETHTOOL_A_MODERATION_USEC]);
+		profile[i].pkts = nla_get_u16(tb_moder[ETHTOOL_A_MODERATION_PKTS]);
+		profile[i].comps = nla_get_u16(tb_moder[ETHTOOL_A_MODERATION_COMPS]);
+
+		if ((dst[i].usec != profile[i].usec && !(dev->priv_flags & IFF_PROFILE_USEC)) ||
+		    (dst[i].pkts != profile[i].pkts && !(dev->priv_flags & IFF_PROFILE_PKTS)) ||
+		    (dst[i].comps != profile[i].comps && !(dev->priv_flags & IFF_PROFILE_COMPS)))
+			return -EOPNOTSUPP;
+
+		i++;
+	}
+
+	memcpy(dst, profile, sizeof(profile));
+
+	return 0;
+}
+
 static int
 __ethnl_set_coalesce(struct ethnl_req_info *req_info, struct genl_info *info,
 		     bool *dual_change)
@@ -317,6 +476,27 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 	ethnl_update_u32(&kernel_coalesce.tx_aggr_time_usecs,
 			 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS], &mod);
 
+	ret = ethnl_update_profile(dev, dev->rx_eqe_profile,
+				   tb[ETHTOOL_A_COALESCE_RX_EQE_PROFILE],
+				   info->extack);
+	if (ret < 0)
+		return ret;
+	ret = ethnl_update_profile(dev, dev->rx_cqe_profile,
+				   tb[ETHTOOL_A_COALESCE_RX_CQE_PROFILE],
+				   info->extack);
+	if (ret < 0)
+		return ret;
+	ret = ethnl_update_profile(dev, dev->tx_eqe_profile,
+				   tb[ETHTOOL_A_COALESCE_TX_EQE_PROFILE],
+				   info->extack);
+	if (ret < 0)
+		return ret;
+	ret = ethnl_update_profile(dev, dev->tx_cqe_profile,
+				   tb[ETHTOOL_A_COALESCE_TX_CQE_PROFILE],
+				   info->extack);
+	if (ret < 0)
+		return ret;
+
 	/* Update operation modes */
 	ethnl_update_bool32(&coalesce.use_adaptive_rx_coalesce,
 			    tb[ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX], &mod_mode);
-- 
1.8.3.1


