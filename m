Return-Path: <netdev+bounces-88774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477E8A883E
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04981F226EF
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1680148308;
	Wed, 17 Apr 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ov4FvCkZ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FC147C8A;
	Wed, 17 Apr 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369362; cv=none; b=Sw1QkXt/kq/T6DGQL5+oVBw4hzsbCLbOwUo88aAn+2cRivfYZHB17tBEZx785mVMuQ4eLs/bZyCkgEIfKJk59GH49378R/FreQk9db40Xxu/WudVHCdaH5XcN6EiBg3Xiqbe82Nocvu7QEOv8cwRAxF3xZC52z7jshyuh9GPFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369362; c=relaxed/simple;
	bh=Dsgmv3Ckl6xv3E3WjqiJsV/DLOsiSBgx4vW+sUCor8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrPxw/w7FZ0tRjrwjMmEj98/W72AkXP0SL/85pc/vjvbMvToyMNEh7bl3Z31DTGDAemOEmGrfBTmw2Z8utMyEjNLfxmmR4JazFpAv9DGyx5PhqauGmuxTZJN61LYInFALr7XTZ0bqzHIDB3z2D2APKnN4O4LCcfJCdwuJJDGTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ov4FvCkZ; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713369352; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1DPOXhfJKraUp/N5WPSsYG+KnFuc+QrGkgg7C+ZG/W0=;
	b=ov4FvCkZtlxqGvR+PZGnOAAbTajZgWGPG5lyf4CNMC2Js+H0C5c9Vj9K6dq7ATyGs3CQRkN8e98J6hFr1g3a/p2ybC+d5qL0Jbcd34qyFqhZSOpihy4f0NKvQvn0MbOuChsvLVPzfLh+rG664QHrMU3yMY5Ujx/01UEilEL7en4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W4m0xGD_1713369349;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4m0xGD_1713369349)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 23:55:49 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"justinstitt@google.com" <justinstitt@google.com>
Subject: [PATCH net-next v9 2/4] ethtool: provide customized dim profile management
Date: Wed, 17 Apr 2024 23:55:44 +0800
Message-Id: <20240417155546.25691-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240417155546.25691-1-hengqi@linux.alibaba.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
The target NIC is named ethx.

Assume that ethx only declares support for ETHTOOL_COALESCE_RX_EQE_PROFILE
in ethtool_ops->supported_coalesce_params.

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
 Documentation/netlink/specs/ethtool.yaml     |  33 +++
 Documentation/networking/ethtool-netlink.rst |   8 +
 include/linux/ethtool.h                      |  11 +-
 include/linux/netdevice.h                    |  24 +++
 include/uapi/linux/ethtool_netlink.h         |  24 +++
 net/core/dev.c                               |  79 ++++++++
 net/ethtool/coalesce.c                       | 201 ++++++++++++++++++-
 7 files changed, 378 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 87ae7b397984..8165b598dab7 100644
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
+        type: u32
+      -
+        name: pkts
+        type: u32
+      -
+        name: comps
+        type: u32
 
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
index 4e63d3708ed9..98a619198465 100644
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
index 6fd9107d3cc0..614a113eda29 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -284,7 +284,11 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
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
@@ -316,6 +320,11 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
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
index d45f330d083d..a1c7e9c2be86 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -80,6 +80,25 @@ struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
 
+#if IS_ENABLED(CONFIG_DIMLIB)
+struct dim_cq_moder;
+
+#define NETDEV_PROFILE_USEC	BIT(0)	/* device supports usec field modification */
+#define NETDEV_PROFILE_PKTS	BIT(1)	/* device supports pkts field modification */
+#define NETDEV_PROFILE_COMPS	BIT(2)	/* device supports comps field modification */
+
+struct netdev_profile_moder {
+	/* See NETDEV_PROFILE_* */
+	unsigned int flags;
+
+	/* DIM profile lists for different dim cq modes */
+	struct dim_cq_moder *rx_eqe_profile;
+	struct dim_cq_moder *rx_cqe_profile;
+	struct dim_cq_moder *tx_eqe_profile;
+	struct dim_cq_moder *tx_cqe_profile;
+};
+#endif
+
 typedef u32 xdp_features_t;
 
 void synchronize_net(void);
@@ -2400,6 +2419,11 @@ struct net_device {
 	/** @page_pools: page pools created for this netdevice */
 	struct hlist_head	page_pools;
 #endif
+
+#if IS_ENABLED(CONFIG_DIMLIB)
+	/** @moderation: dim tunable parameters for this netdevice */
+	struct netdev_profile_moder	*moderation;
+#endif
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index b4f0d233d048..d4c6e30a55cb 100644
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
+	ETHTOOL_A_MODERATION_USEC,			/* u32 */
+	ETHTOOL_A_MODERATION_PKTS,			/* u32 */
+	ETHTOOL_A_MODERATION_COMPS,			/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_MODERATION_CNT,
+	ETHTOOL_A_MODERATION_MAX = (__ETHTOOL_A_MODERATION_CNT - 1)
+};
+
 /* PAUSE */
 
 enum {
diff --git a/net/core/dev.c b/net/core/dev.c
index 854a3a28a8d8..a30287279fcc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -96,6 +96,7 @@
 #include <linux/kthread.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
+#include <linux/dim.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/busy_poll.h>
@@ -10229,6 +10230,57 @@ static void netdev_do_free_pcpu_stats(struct net_device *dev)
 	}
 }
 
+static int dev_dim_profile_init(struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_DIMLIB)
+	u32 supported = dev->ethtool_ops->supported_coalesce_params;
+	struct netdev_profile_moder *moder;
+	int length;
+
+	dev->moderation = kzalloc(sizeof(*dev->moderation), GFP_KERNEL);
+	if (!dev->moderation)
+		goto err_moder;
+
+	moder = dev->moderation;
+	length = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*moder->rx_eqe_profile);
+
+	if (supported & ETHTOOL_COALESCE_RX_EQE_PROFILE) {
+		moder->rx_eqe_profile = kmemdup(dim_rx_profile[0], length, GFP_KERNEL);
+		if (!moder->rx_eqe_profile)
+			goto err_rx_eqe;
+	}
+	if (supported & ETHTOOL_COALESCE_RX_CQE_PROFILE) {
+		moder->rx_cqe_profile = kmemdup(dim_rx_profile[1], length, GFP_KERNEL);
+		if (!moder->rx_cqe_profile)
+			goto err_rx_cqe;
+	}
+	if (supported & ETHTOOL_COALESCE_TX_EQE_PROFILE) {
+		moder->tx_eqe_profile = kmemdup(dim_tx_profile[0], length, GFP_KERNEL);
+		if (!moder->tx_eqe_profile)
+			goto err_tx_eqe;
+	}
+	if (supported & ETHTOOL_COALESCE_TX_CQE_PROFILE) {
+		moder->tx_cqe_profile = kmemdup(dim_tx_profile[1], length, GFP_KERNEL);
+		if (!moder->tx_cqe_profile)
+			goto err_tx_cqe;
+	}
+#endif
+	return 0;
+
+#if IS_ENABLED(CONFIG_DIMLIB)
+err_tx_cqe:
+	kfree(moder->tx_eqe_profile);
+err_tx_eqe:
+	kfree(moder->rx_cqe_profile);
+err_rx_cqe:
+	kfree(moder->rx_eqe_profile);
+err_rx_eqe:
+	kfree(moder);
+err_moder:
+	return -ENOMEM;
+#endif
+}
+
 /**
  * register_netdevice() - register a network device
  * @dev: device to register
@@ -10258,6 +10310,10 @@ int register_netdevice(struct net_device *dev)
 	if (ret)
 		return ret;
 
+	ret = dev_dim_profile_init(dev);
+	if (ret)
+		return ret;
+
 	spin_lock_init(&dev->addr_list_lock);
 	netdev_set_addr_lockdep_class(dev);
 
@@ -11011,6 +11067,27 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 }
 EXPORT_SYMBOL(alloc_netdev_mqs);
 
+static void netif_free_profile(struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_DIMLIB)
+	u32 supported = dev->ethtool_ops->supported_coalesce_params;
+
+	if (supported & ETHTOOL_COALESCE_RX_EQE_PROFILE)
+		kfree(dev->moderation->rx_eqe_profile);
+
+	if (supported & ETHTOOL_COALESCE_RX_CQE_PROFILE)
+		kfree(dev->moderation->rx_cqe_profile);
+
+	if (supported & ETHTOOL_COALESCE_TX_EQE_PROFILE)
+		kfree(dev->moderation->tx_eqe_profile);
+
+	if (supported & ETHTOOL_COALESCE_TX_CQE_PROFILE)
+		kfree(dev->moderation->tx_cqe_profile);
+
+	kfree(dev->moderation);
+#endif
+}
+
 /**
  * free_netdev - free network device
  * @dev: device
@@ -11036,6 +11113,8 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
+	netif_free_profile(dev);
+
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
 
diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 83112c1a71ae..3a41840fbcc7 100644
--- a/net/ethtool/coalesce.c
+++ b/net/ethtool/coalesce.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/dim.h>
 #include "netlink.h"
 #include "common.h"
 
@@ -51,6 +52,10 @@ __CHECK_SUPPORTED_OFFSET(COALESCE_RX_MAX_FRAMES_HIGH);
 __CHECK_SUPPORTED_OFFSET(COALESCE_TX_USECS_HIGH);
 __CHECK_SUPPORTED_OFFSET(COALESCE_TX_MAX_FRAMES_HIGH);
 __CHECK_SUPPORTED_OFFSET(COALESCE_RATE_SAMPLE_INTERVAL);
+__CHECK_SUPPORTED_OFFSET(COALESCE_RX_EQE_PROFILE);
+__CHECK_SUPPORTED_OFFSET(COALESCE_RX_CQE_PROFILE);
+__CHECK_SUPPORTED_OFFSET(COALESCE_TX_EQE_PROFILE);
+__CHECK_SUPPORTED_OFFSET(COALESCE_TX_CQE_PROFILE);
 
 const struct nla_policy ethnl_coalesce_get_policy[] = {
 	[ETHTOOL_A_COALESCE_HEADER]		=
@@ -82,6 +87,14 @@ static int coalesce_prepare_data(const struct ethnl_req_info *req_base,
 static int coalesce_reply_size(const struct ethnl_req_info *req_base,
 			       const struct ethnl_reply_data *reply_base)
 {
+	int modersz = nla_total_size(0) + /* _MODERATIONS_MODERATION, nest */
+		      nla_total_size(sizeof(u32)) + /* _MODERATION_USEC */
+		      nla_total_size(sizeof(u32)) + /* _MODERATION_PKTS */
+		      nla_total_size(sizeof(u32));  /* _MODERATION_COMPS */
+
+	int total_modersz = nla_total_size(0) +  /* _{R,T}X_{E,C}QE_PROFILE, nest */
+			modersz * NET_DIM_PARAMS_NUM_PROFILES;
+
 	return nla_total_size(sizeof(u32)) +	/* _RX_USECS */
 	       nla_total_size(sizeof(u32)) +	/* _RX_MAX_FRAMES */
 	       nla_total_size(sizeof(u32)) +	/* _RX_USECS_IRQ */
@@ -108,7 +121,8 @@ static int coalesce_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u8)) +	/* _USE_CQE_MODE_RX */
 	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_BYTES */
 	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_FRAMES */
-	       nla_total_size(sizeof(u32));	/* _TX_AGGR_TIME_USECS */
+	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_TIME_USECS */
+	       total_modersz * 4;		/* _{R,T}X_{E,C}QE_PROFILE */
 }
 
 static bool coalesce_put_u32(struct sk_buff *skb, u16 attr_type, u32 val,
@@ -127,6 +141,62 @@ static bool coalesce_put_bool(struct sk_buff *skb, u16 attr_type, u32 val,
 	return nla_put_u8(skb, attr_type, !!val);
 }
 
+#if IS_ENABLED(CONFIG_DIMLIB)
+/**
+ * coalesce_put_profile - fill reply with a nla nest with four child nla nests.
+ * @skb: socket buffer the message is stored in
+ * @attr_type: nest attr type ETHTOOL_A_COALESCE_*X_*QE_PROFILE
+ * @profile: data passed to userspace
+ * @supported_params: modifiable parameters supported by the driver
+ *
+ * Put a dim profile nest attribute. Refer to ETHTOOL_A_MODERATIONS_MODERATION.
+ *
+ * Return: false to indicate successful placement or no placement, and
+ * true to pass the -EMSGSIZE error to the wrapper.
+ */
+static bool coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
+				 const struct dim_cq_moder *profile,
+				 u32 supported_params)
+{
+	struct nlattr *profile_attr, *moder_attr;
+	bool emsg = !!-EMSGSIZE;
+	int i;
+
+	if (!profile)
+		return false;
+
+	if (!(supported_params & attr_to_mask(attr_type)))
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
+		if (nla_put_u32(skb, ETHTOOL_A_MODERATION_USEC, profile[i].usec) ||
+		    nla_put_u32(skb, ETHTOOL_A_MODERATION_PKTS, profile[i].pkts) ||
+		    nla_put_u32(skb, ETHTOOL_A_MODERATION_COMPS, profile[i].comps))
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
+#endif
+
 static int coalesce_fill_reply(struct sk_buff *skb,
 			       const struct ethnl_req_info *req_base,
 			       const struct ethnl_reply_data *reply_base)
@@ -134,6 +204,9 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 	const struct coalesce_reply_data *data = COALESCE_REPDATA(reply_base);
 	const struct kernel_ethtool_coalesce *kcoal = &data->kernel_coalesce;
 	const struct ethtool_coalesce *coal = &data->coalesce;
+#if IS_ENABLED(CONFIG_DIMLIB)
+	struct net_device *dev = req_base->dev;
+#endif
 	u32 supported = data->supported_params;
 
 	if (coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_USECS,
@@ -192,6 +265,21 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 			     kcoal->tx_aggr_time_usecs, supported))
 		return -EMSGSIZE;
 
+#if IS_ENABLED(CONFIG_DIMLIB)
+	if (!(dev->moderation->flags & (NETDEV_PROFILE_USEC | NETDEV_PROFILE_PKTS |
+					NETDEV_PROFILE_COMPS)))
+		return 0;
+
+	if (coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_EQE_PROFILE,
+				 dev->moderation->rx_eqe_profile, supported) ||
+	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_CQE_PROFILE,
+				 dev->moderation->rx_cqe_profile, supported) ||
+	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_EQE_PROFILE,
+				 dev->moderation->tx_eqe_profile, supported) ||
+	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_CQE_PROFILE,
+				 dev->moderation->tx_cqe_profile, supported))
+		return -EMSGSIZE;
+#endif
 	return 0;
 }
 
@@ -227,7 +315,19 @@ const struct nla_policy ethnl_coalesce_set_policy[] = {
 	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES] = { .type = NLA_U32 },
 	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES] = { .type = NLA_U32 },
 	[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS] = { .type = NLA_U32 },
+	[ETHTOOL_A_COALESCE_RX_EQE_PROFILE]     = { .type = NLA_NESTED },
+	[ETHTOOL_A_COALESCE_RX_CQE_PROFILE]     = { .type = NLA_NESTED },
+	[ETHTOOL_A_COALESCE_TX_EQE_PROFILE]     = { .type = NLA_NESTED },
+	[ETHTOOL_A_COALESCE_TX_CQE_PROFILE]     = { .type = NLA_NESTED },
+};
+
+#if IS_ENABLED(CONFIG_DIMLIB)
+static const struct nla_policy coalesce_set_profile_policy[] = {
+	[ETHTOOL_A_MODERATION_USEC]	= {.type = NLA_U32},
+	[ETHTOOL_A_MODERATION_PKTS]	= {.type = NLA_U32},
+	[ETHTOOL_A_MODERATION_COMPS]	= {.type = NLA_U32},
 };
+#endif
 
 static int
 ethnl_set_coalesce_validate(struct ethnl_req_info *req_info,
@@ -253,6 +353,76 @@ ethnl_set_coalesce_validate(struct ethnl_req_info *req_info,
 	return 1;
 }
 
+#if IS_ENABLED(CONFIG_DIMLIB)
+/**
+ * ethnl_update_profile - get a nla nest with four child nla nests from userspace.
+ * @dev: netdevice to update the profile
+ * @dst: data get from the driver and modified by ethnl_update_profile.
+ * @nests: nest attr ETHTOOL_A_COALESCE_*X_*QE_PROFILE to set driver's profile.
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
+ * Return: 0 on success or a negative error code.
+ */
+static int ethnl_update_profile(struct net_device *dev,
+				struct dim_cq_moder *dst,
+				const struct nlattr *nests,
+				struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb_moder[ARRAY_SIZE(coalesce_set_profile_policy)];
+	struct dim_cq_moder profile[NET_DIM_PARAMS_NUM_PROFILES];
+	struct netdev_profile_moder *moder = dev->moderation;
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
+		profile[i].usec = nla_get_u32(tb_moder[ETHTOOL_A_MODERATION_USEC]);
+		profile[i].pkts = nla_get_u32(tb_moder[ETHTOOL_A_MODERATION_PKTS]);
+		profile[i].comps = nla_get_u32(tb_moder[ETHTOOL_A_MODERATION_COMPS]);
+
+		if ((dst[i].usec != profile[i].usec && !(moder->flags & NETDEV_PROFILE_USEC)) ||
+		    (dst[i].pkts != profile[i].pkts && !(moder->flags & NETDEV_PROFILE_PKTS)) ||
+		    (dst[i].comps != profile[i].comps && !(moder->flags & NETDEV_PROFILE_COMPS)))
+			return -EOPNOTSUPP;
+
+		i++;
+	}
+
+	memcpy(dst, profile, sizeof(profile));
+
+	return 0;
+}
+#endif
+
 static int
 __ethnl_set_coalesce(struct ethnl_req_info *req_info, struct genl_info *info,
 		     bool *dual_change)
@@ -317,6 +487,35 @@ __ethnl_set_coalesce(struct ethnl_req_info *req_info, struct genl_info *info,
 	ethnl_update_u32(&kernel_coalesce.tx_aggr_time_usecs,
 			 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS], &mod);
 
+#if IS_ENABLED(CONFIG_DIMLIB)
+	ret = ethnl_update_profile(dev, dev->moderation->rx_eqe_profile,
+				   tb[ETHTOOL_A_COALESCE_RX_EQE_PROFILE],
+				   info->extack);
+	if (ret < 0)
+		return ret;
+	ret = ethnl_update_profile(dev, dev->moderation->rx_cqe_profile,
+				   tb[ETHTOOL_A_COALESCE_RX_CQE_PROFILE],
+				   info->extack);
+	if (ret < 0)
+		return ret;
+	ret = ethnl_update_profile(dev, dev->moderation->tx_eqe_profile,
+				   tb[ETHTOOL_A_COALESCE_TX_EQE_PROFILE],
+				   info->extack);
+	if (ret < 0)
+		return ret;
+	ret = ethnl_update_profile(dev, dev->moderation->tx_cqe_profile,
+				   tb[ETHTOOL_A_COALESCE_TX_CQE_PROFILE],
+				   info->extack);
+	if (ret < 0)
+		return ret;
+#else
+	if (tb[ETHTOOL_A_COALESCE_RX_EQE_PROFILE] ||
+	    tb[ETHTOOL_A_COALESCE_RX_CQE_PROFILE] ||
+	    tb[ETHTOOL_A_COALESCE_TX_EQE_PROFILE] ||
+	    tb[ETHTOOL_A_COALESCE_TX_CQE_PROFILE])
+		return -EOPNOTSUPP;
+
+#endif
 	/* Update operation modes */
 	ethnl_update_bool32(&coalesce.use_adaptive_rx_coalesce,
 			    tb[ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX], &mod_mode);
-- 
2.32.0.3.g01195cf9f


