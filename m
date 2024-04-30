Return-Path: <netdev+bounces-92564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE398B7EA3
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 19:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822F8282BEF
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1934181B93;
	Tue, 30 Apr 2024 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LBq92Idu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC14180A93;
	Tue, 30 Apr 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498310; cv=none; b=HCpcCnVUUgDa30yKVhygSQCKB4VGjsEpNhCSPHVplVrYvniiycXvsJN6vgGZSM60KLBoA5V2U9fFyEhqug0lwguUMP7nf6Vxmpi1a8kkWq+pm1SMOLmM9olgMWkcsMMqP9SLBrtsQpfeYKddE8nFjOhiD1lo7w37tL0QVPhSQs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498310; c=relaxed/simple;
	bh=Ca0SzY8iTztSKZ4vZHaHs5F1kOd/2MVDuN2+YU7xU3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sFY20EZcveowtuojN8vWzxPXf5XNS2xOB26TlIGBc2sU2j4dEIip5eXA3v1NxrY6NhsSOgq2O4fcKE+Mk9EotrzgFa7jcNu0U5idj7v1lmnIg+ebZaLAaMNdSG8BBZOdeeyH/2Pz3KREKt92qhfOjP2LErXay77E4yBtKNBAVIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LBq92Idu; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714498305; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LF5/c/mRulCi+n2oEjxu3HIGz8avUcrkCz99lvcflP4=;
	b=LBq92IduqCvO4dyAf6KQLCNmp91ppbsyRqdFMz5Qj5Hkizl3OtgKinMtJsP4LPsP7Hr//anxLgaswzenb6RuhFMwk962Uj8vUj78X2wbt3OwBNtRpX1ZHaBkIc4N+pp29O+Dre7+/4rGadxzmXx8DWQ5h/5jTf1t9LBBJJySL10=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5ci8g7_1714498299;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5ci8g7_1714498299)
          by smtp.aliyun-inc.com;
          Wed, 01 May 2024 01:31:40 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
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
	justinstitt@google.com
Subject: [PATCH net-next v11 2/4] ethtool: provide customized dim profile management
Date: Wed,  1 May 2024 01:31:34 +0800
Message-Id: <20240430173136.15807-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240430173136.15807-1-hengqi@linux.alibaba.com>
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
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

Assume that ethx only declares support for rx profile setting
(with DIM_PROFILE_RX flag set in profile_flags) and supports modification
of usec and pkt fields.

1. Query the currently customized list of the device

$ ethtool -c ethx
...
rx-profile:
{.usec =   1, .pkts = 256, .comps = n/a,},
{.usec =   8, .pkts = 256, .comps = n/a,},
{.usec =  64, .pkts = 256, .comps = n/a,},
{.usec = 128, .pkts = 256, .comps = n/a,},
{.usec = 256, .pkts = 256, .comps = n/a,}
tx-profile:   n/a

2. Tune
$ ethtool -C ethx rx-profile 1,1,n_2,n,n_3,3,n_4,4,n_n,5,n
"n" means do not modify this field.
$ ethtool -c ethx
...
rx-profile:
{.usec =   1, .pkts =   1, .comps = n/a,},
{.usec =   2, .pkts = 256, .comps = n/a,},
{.usec =   3, .pkts =   3, .comps = n/a,},
{.usec =   4, .pkts =   4, .comps = n/a,},
{.usec = 256, .pkts =   5, .comps = n/a,}
tx-profile:   n/a

3. Hint
If the device does not support some type of customized dim profiles,
the corresponding "n/a" will display.

If the "n/a" field is being modified, -EOPNOTSUPP will be reported.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 Documentation/netlink/specs/ethtool.yaml     |  31 +++
 Documentation/networking/ethtool-netlink.rst |   4 +
 include/linux/dim.h                          |  62 +++++
 include/linux/ethtool.h                      |   7 +-
 include/linux/netdevice.h                    |   5 +
 include/uapi/linux/ethtool_netlink.h         |  22 ++
 lib/dim/net_dim.c                            |  71 +++++
 net/ethtool/coalesce.c                       | 278 ++++++++++++++++++-
 8 files changed, 478 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 00dc61358be8..6c2ab3d1c22f 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -414,6 +414,26 @@ attribute-sets:
         name: combined-count
         type: u32
 
+  -
+    name: irq-moderation
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
+  -
+    name: profile
+    attributes:
+      -
+        name: irq-moderation
+        type: nest
+        multi-attr: true
+        nested-attributes: irq-moderation
   -
     name: coalesce
     attributes:
@@ -502,6 +522,15 @@ attribute-sets:
       -
         name: tx-aggr-time-usecs
         type: u32
+      -
+        name: rx-profile
+        type: nest
+        nested-attributes: profile
+      -
+        name: tx-profile
+        type: nest
+        nested-attributes: profile
+
   -
     name: pause-stat
     attributes:
@@ -1325,6 +1354,8 @@ operations:
             - tx-aggr-max-bytes
             - tx-aggr-max-frames
             - tx-aggr-time-usecs
+            - rx-profile
+            - tx-profile
       dump: *coalesce-get-op
     -
       name: coalesce-set
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 8bc71f249448..11e15d2fa731 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1040,6 +1040,8 @@ Kernel response contents:
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES``     u32     max aggr size, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES``    u32     max aggr packets, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
+  ``ETHTOOL_A_COALESCE_RX_PROFILE``            nested  profile of DIM, Rx
+  ``ETHTOOL_A_COALESCE_TX_PROFILE``            nested  profile of DIM, Tx
   ===========================================  ======  =======================
 
 Attributes are only included in reply if their value is not zero or the
@@ -1105,6 +1107,8 @@ Request contents:
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES``     u32     max aggr size, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES``    u32     max aggr packets, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
+  ``ETHTOOL_A_COALESCE_RX_PROFILE``            nested  profile of DIM, Rx
+  ``ETHTOOL_A_COALESCE_TX_PROFILE``            nested  profile of DIM, Tx
   ===========================================  ======  =======================
 
 Request is rejected if it attributes declared as unsupported by driver (i.e.
diff --git a/include/linux/dim.h b/include/linux/dim.h
index 43398f5eade2..4b1630f4672b 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <linux/netdevice.h>
 
 /* Number of DIM profiles and period mode. */
 #define NET_DIM_PARAMS_NUM_PROFILES 5
@@ -45,12 +46,47 @@
  * @pkts: CQ packet counter suggestion (by DIM)
  * @comps: Completion counter
  * @cq_period_mode: CQ period count mode (from CQE/EQE)
+ * @rcu: for asynchronous kfree_rcu
  */
 struct dim_cq_moder {
 	u16 usec;
 	u16 pkts;
 	u16 comps;
 	u8 cq_period_mode;
+	struct rcu_head rcu;
+};
+
+#define DIM_PROFILE_RX		BIT(0)	/* support rx profile modification */
+#define DIM_PROFILE_TX		BIT(1)	/* support tx profile modification */
+
+#define DIM_COALESCE_USEC	BIT(0)	/* support usec field modification */
+#define DIM_COALESCE_PKTS	BIT(1)	/* support pkts field modification */
+#define DIM_COALESCE_COMPS	BIT(2)	/* support comps field modification */
+
+struct dim_irq_moder {
+	/* See DIM_PROFILE_* */
+	u8 profile_flags;
+
+	/* See DIM_COALESCE_* for Rx and Tx */
+	u8 coal_flags;
+
+	/* Rx DIM period count mode: CQE or EQE */
+	u8 dim_rx_mode;
+
+	/* Tx DIM period count mode: CQE or EQE */
+	u8 dim_tx_mode;
+
+	/* DIM profile list for Rx */
+	struct dim_cq_moder __rcu *rx_profile;
+
+	/* DIM profile list for Tx */
+	struct dim_cq_moder __rcu *tx_profile;
+
+	/* Rx DIM worker function scheduled by net_dim() */
+	void (*rx_dim_work)(struct work_struct *work);
+
+	/* Tx DIM worker function scheduled by net_dim() */
+	void (*tx_dim_work)(struct work_struct *work);
 };
 
 /**
@@ -198,6 +234,32 @@ enum dim_step_result {
 	DIM_ON_EDGE,
 };
 
+/**
+ * net_dim_init_irq_moder - collect information to initialize irq moderation
+ * @dev: target network device
+ * @profile_flags: Rx or Tx profile modification capability
+ * @coal_flags: irq moderation params flags
+ * @rx_mode: CQ period mode for Rx
+ * @tx_mode: CQ period mode for Tx
+ * @rx_dim_work: Rx worker called after dim decision
+ *    void (*rx_dim_work)(struct work_struct *work);
+ *
+ * @tx_dim_work: Tx worker called after dim decision
+ *    void (*tx_dim_work)(struct work_struct *work);
+ *
+ * Return: 0 on success or a negative error code.
+ */
+int net_dim_init_irq_moder(struct net_device *dev, u8 profile_flags,
+			   u8 coal_flags, u8 rx_mode, u8 tx_mode,
+			   void (*rx_dim_work)(struct work_struct *work),
+			   void (*tx_dim_work)(struct work_struct *work));
+
+/**
+ * net_dim_free_irq_moder - free fields for irq moderation
+ * @dev: target network device
+ */
+void net_dim_free_irq_moder(struct net_device *dev);
+
 /**
  *	dim_on_top - check if current state is a good place to stop (top location)
  *	@dim: DIM context
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6fd9107d3cc0..902815b517dc 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -284,7 +284,9 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
 #define ETHTOOL_COALESCE_TX_AGGR_MAX_BYTES	BIT(24)
 #define ETHTOOL_COALESCE_TX_AGGR_MAX_FRAMES	BIT(25)
 #define ETHTOOL_COALESCE_TX_AGGR_TIME_USECS	BIT(26)
-#define ETHTOOL_COALESCE_ALL_PARAMS		GENMASK(26, 0)
+#define ETHTOOL_COALESCE_RX_PROFILE		BIT(27)
+#define ETHTOOL_COALESCE_TX_PROFILE		BIT(28)
+#define ETHTOOL_COALESCE_ALL_PARAMS		GENMASK(28, 0)
 
 #define ETHTOOL_COALESCE_USECS						\
 	(ETHTOOL_COALESCE_RX_USECS | ETHTOOL_COALESCE_TX_USECS)
@@ -316,6 +318,9 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
 	(ETHTOOL_COALESCE_TX_AGGR_MAX_BYTES |	\
 	 ETHTOOL_COALESCE_TX_AGGR_MAX_FRAMES |	\
 	 ETHTOOL_COALESCE_TX_AGGR_TIME_USECS)
+#define ETHTOOL_COALESCE_PROFILE	\
+	(ETHTOOL_COALESCE_RX_PROFILE |	\
+	 ETHTOOL_COALESCE_TX_PROFILE)
 
 #define ETHTOOL_STAT_NOT_SET	(~0ULL)
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f849e7d110ed..4bf6ea2074aa 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2400,6 +2400,11 @@ struct net_device {
 	/** @page_pools: page pools created for this netdevice */
 	struct hlist_head	page_pools;
 #endif
+
+#if IS_ENABLED(CONFIG_DIMLIB)
+	/** @irq_moder: dim related parameters for this netdevice */
+	struct dim_irq_moder	*irq_moder;
+#endif
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index f17dbe54bf5e..e1b57edb0342 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -416,12 +416,34 @@ enum {
 	ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES,		/* u32 */
 	ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,		/* u32 */
 	ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,		/* u32 */
+	/* nest - _A_PROFILE_IRQ_MODERATION */
+	ETHTOOL_A_COALESCE_RX_PROFILE,
+	/* nest - _A_PROFILE_IRQ_MODERATION */
+	ETHTOOL_A_COALESCE_TX_PROFILE,
 
 	/* add new constants above here */
 	__ETHTOOL_A_COALESCE_CNT,
 	ETHTOOL_A_COALESCE_MAX = (__ETHTOOL_A_COALESCE_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PROFILE_UNSPEC,
+	/* nest, _A_IRQ_MODERATION_* */
+	ETHTOOL_A_PROFILE_IRQ_MODERATION,
+	__ETHTOOL_A_PROFILE_CNT,
+	ETHTOOL_A_PROFILE_MAX = (__ETHTOOL_A_PROFILE_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_IRQ_MODERATION_UNSPEC,
+	ETHTOOL_A_IRQ_MODERATION_USEC,			/* u32 */
+	ETHTOOL_A_IRQ_MODERATION_PKTS,			/* u32 */
+	ETHTOOL_A_IRQ_MODERATION_COMPS,			/* u32 */
+
+	__ETHTOOL_A_IRQ_MODERATION_CNT,
+	ETHTOOL_A_IRQ_MODERATION_MAX = (__ETHTOOL_A_IRQ_MODERATION_CNT - 1)
+};
+
 /* PAUSE */
 
 enum {
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 67d5beb34dc3..b3e01619f929 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/dim.h>
+#include <linux/rtnetlink.h>
 
 /*
  * Net DIM profiles:
@@ -95,6 +96,76 @@ net_dim_get_def_tx_moderation(u8 cq_period_mode)
 }
 EXPORT_SYMBOL(net_dim_get_def_tx_moderation);
 
+int net_dim_init_irq_moder(struct net_device *dev, u8 profile_flags,
+			   u8 coal_flags, u8 rx_mode, u8 tx_mode,
+			   void (*rx_dim_work)(struct work_struct *work),
+			   void (*tx_dim_work)(struct work_struct *work))
+{
+	struct dim_cq_moder *rxp = NULL, *txp;
+	struct dim_irq_moder *moder;
+	int len;
+
+	dev->irq_moder = kzalloc(sizeof(*dev->irq_moder), GFP_KERNEL);
+	if (!dev->irq_moder)
+		goto err_moder;
+
+	moder = dev->irq_moder;
+	len = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*moder->rx_profile);
+
+	moder->coal_flags = coal_flags;
+	moder->profile_flags = profile_flags;
+
+	if (profile_flags & DIM_PROFILE_RX) {
+		moder->rx_dim_work = rx_dim_work;
+		WRITE_ONCE(moder->dim_rx_mode, rx_mode);
+		rxp = kmemdup(rx_profile[rx_mode], len, GFP_KERNEL);
+		if (!rxp)
+			goto err_rx_profile;
+
+		rcu_assign_pointer(moder->rx_profile, rxp);
+	}
+
+	if (profile_flags & DIM_PROFILE_TX) {
+		moder->tx_dim_work = tx_dim_work;
+		WRITE_ONCE(moder->dim_tx_mode, tx_mode);
+		txp = kmemdup(tx_profile[tx_mode], len, GFP_KERNEL);
+		if (!txp)
+			goto err_tx_profile;
+
+		rcu_assign_pointer(moder->tx_profile, txp);
+	}
+
+	return 0;
+
+err_tx_profile:
+	kfree(rxp);
+err_rx_profile:
+	kfree(moder);
+err_moder:
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(net_dim_init_irq_moder);
+
+/* RTNL lock is held. */
+void net_dim_free_irq_moder(struct net_device *dev)
+{
+	struct dim_cq_moder *rxp, *txp;
+
+	if (!dev->irq_moder)
+		return;
+
+	rxp = rtnl_dereference(dev->irq_moder->rx_profile);
+	txp = rtnl_dereference(dev->irq_moder->tx_profile);
+
+	rcu_assign_pointer(dev->irq_moder->rx_profile, NULL);
+	rcu_assign_pointer(dev->irq_moder->tx_profile, NULL);
+
+	kfree_rcu(rxp, rcu);
+	kfree_rcu(txp, rcu);
+	kfree(dev->irq_moder);
+}
+EXPORT_SYMBOL(net_dim_free_irq_moder);
+
 static int net_dim_step(struct dim *dim)
 {
 	if (dim->tired == (NET_DIM_PARAMS_NUM_PROFILES * 2))
diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 83112c1a71ae..2978e58c74ee 100644
--- a/net/ethtool/coalesce.c
+++ b/net/ethtool/coalesce.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/dim.h>
 #include "netlink.h"
 #include "common.h"
 
@@ -82,6 +83,14 @@ static int coalesce_prepare_data(const struct ethnl_req_info *req_base,
 static int coalesce_reply_size(const struct ethnl_req_info *req_base,
 			       const struct ethnl_reply_data *reply_base)
 {
+	int modersz = nla_total_size(0) + /* _PROFILE_IRQ_MODERATION, nest */
+		      nla_total_size(sizeof(u32)) + /* _IRQ_MODERATION_USEC */
+		      nla_total_size(sizeof(u32)) + /* _IRQ_MODERATION_PKTS */
+		      nla_total_size(sizeof(u32));  /* _IRQ_MODERATION_COMPS */
+
+	int total_modersz = nla_total_size(0) +  /* _{R,T}X_PROFILE, nest */
+			modersz * NET_DIM_PARAMS_NUM_PROFILES;
+
 	return nla_total_size(sizeof(u32)) +	/* _RX_USECS */
 	       nla_total_size(sizeof(u32)) +	/* _RX_MAX_FRAMES */
 	       nla_total_size(sizeof(u32)) +	/* _RX_USECS_IRQ */
@@ -108,7 +117,8 @@ static int coalesce_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u8)) +	/* _USE_CQE_MODE_RX */
 	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_BYTES */
 	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_FRAMES */
-	       nla_total_size(sizeof(u32));	/* _TX_AGGR_TIME_USECS */
+	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_TIME_USECS */
+	       total_modersz * 2;		/* _{R,T}X_PROFILE */
 }
 
 static bool coalesce_put_u32(struct sk_buff *skb, u16 attr_type, u32 val,
@@ -127,6 +137,74 @@ static bool coalesce_put_bool(struct sk_buff *skb, u16 attr_type, u32 val,
 	return nla_put_u8(skb, attr_type, !!val);
 }
 
+/**
+ * coalesce_put_profile - fill reply with a nla nest with four child nla nests.
+ * @skb: socket buffer the message is stored in
+ * @attr_type: nest attr type ETHTOOL_A_COALESCE_*X_PROFILE
+ * @profile: data passed to userspace
+ * @coal_flags: modifiable parameters supported by the driver
+ *
+ * Put a dim profile nest attribute. Refer to ETHTOOL_A_PROFILE_IRQ_MODERATION.
+ *
+ * Return: 0 on success or a negative error code.
+ */
+static int coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
+				const struct dim_cq_moder *profile,
+				u8 coal_flags)
+{
+	struct nlattr *profile_attr, *moder_attr;
+	int i, ret;
+
+	if (!profile || !coal_flags)
+		return 0;
+
+	profile_attr = nla_nest_start(skb, attr_type);
+	if (!profile_attr)
+		return -EMSGSIZE;
+
+	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
+		moder_attr = nla_nest_start(skb,
+					    ETHTOOL_A_PROFILE_IRQ_MODERATION);
+		if (!moder_attr) {
+			ret = -EMSGSIZE;
+			goto cancel_profile;
+		}
+
+		if (coal_flags & DIM_COALESCE_USEC) {
+			ret = nla_put_u32(skb, ETHTOOL_A_IRQ_MODERATION_USEC,
+					  profile[i].usec);
+			if (ret)
+				goto cancel_moder;
+		}
+
+		if (coal_flags & DIM_COALESCE_PKTS) {
+			ret = nla_put_u32(skb, ETHTOOL_A_IRQ_MODERATION_PKTS,
+					  profile[i].pkts);
+			if (ret)
+				goto cancel_moder;
+		}
+
+		if (coal_flags & DIM_COALESCE_COMPS) {
+			ret = nla_put_u32(skb, ETHTOOL_A_IRQ_MODERATION_COMPS,
+					  profile[i].comps);
+			if (ret)
+				goto cancel_moder;
+		}
+
+		nla_nest_end(skb, moder_attr);
+	}
+
+	nla_nest_end(skb, profile_attr);
+
+	return 0;
+
+cancel_moder:
+	nla_nest_cancel(skb, moder_attr);
+cancel_profile:
+	nla_nest_cancel(skb, profile_attr);
+	return ret;
+}
+
 static int coalesce_fill_reply(struct sk_buff *skb,
 			       const struct ethnl_req_info *req_base,
 			       const struct ethnl_reply_data *reply_base)
@@ -134,6 +212,12 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 	const struct coalesce_reply_data *data = COALESCE_REPDATA(reply_base);
 	const struct kernel_ethtool_coalesce *kcoal = &data->kernel_coalesce;
 	const struct ethtool_coalesce *coal = &data->coalesce;
+#if IS_ENABLED(CONFIG_DIMLIB)
+	struct net_device *dev = req_base->dev;
+	struct dim_irq_moder *moder = dev->irq_moder;
+	u8 coal_flags;
+	int ret;
+#endif
 	u32 supported = data->supported_params;
 
 	if (coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_USECS,
@@ -192,11 +276,49 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 			     kcoal->tx_aggr_time_usecs, supported))
 		return -EMSGSIZE;
 
+#if IS_ENABLED(CONFIG_DIMLIB)
+	if (!moder)
+		return 0;
+
+	coal_flags = moder->coal_flags;
+	rcu_read_lock();
+	if (moder->profile_flags & DIM_PROFILE_RX) {
+		ret = coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_PROFILE,
+					   rcu_dereference(moder->rx_profile),
+					   coal_flags);
+		if (ret) {
+			rcu_read_unlock();
+			return ret;
+		}
+	}
+
+	if (moder->profile_flags & DIM_PROFILE_TX) {
+		ret = coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_PROFILE,
+					   rcu_dereference(moder->tx_profile),
+					   coal_flags);
+		if (ret) {
+			rcu_read_unlock();
+			return ret;
+		}
+	}
+	rcu_read_unlock();
+#endif
 	return 0;
 }
 
 /* COALESCE_SET */
 
+static const struct nla_policy coalesce_irq_moderation_policy[] = {
+	[ETHTOOL_A_IRQ_MODERATION_USEC]	= { .type = NLA_U32 },
+	[ETHTOOL_A_IRQ_MODERATION_PKTS]	= { .type = NLA_U32 },
+	[ETHTOOL_A_IRQ_MODERATION_COMPS] = { .type = NLA_U32 },
+};
+
+static const struct nla_policy coalesce_profile_policy[] = {
+	[ETHTOOL_A_PROFILE_IRQ_MODERATION] =
+		NLA_POLICY_NESTED(coalesce_irq_moderation_policy),
+};
+
 const struct nla_policy ethnl_coalesce_set_policy[] = {
 	[ETHTOOL_A_COALESCE_HEADER]		=
 		NLA_POLICY_NESTED(ethnl_header_policy),
@@ -227,6 +349,10 @@ const struct nla_policy ethnl_coalesce_set_policy[] = {
 	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES] = { .type = NLA_U32 },
 	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES] = { .type = NLA_U32 },
 	[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS] = { .type = NLA_U32 },
+	[ETHTOOL_A_COALESCE_RX_PROFILE] =
+		NLA_POLICY_NESTED(coalesce_profile_policy),
+	[ETHTOOL_A_COALESCE_TX_PROFILE] =
+		NLA_POLICY_NESTED(coalesce_profile_policy),
 };
 
 static int
@@ -234,6 +360,9 @@ ethnl_set_coalesce_validate(struct ethnl_req_info *req_info,
 			    struct genl_info *info)
 {
 	const struct ethtool_ops *ops = req_info->dev->ethtool_ops;
+#if IS_ENABLED(CONFIG_DIMLIB)
+	struct net_device *dev = req_info->dev;
+#endif
 	struct nlattr **tb = info->attrs;
 	u32 supported_params;
 	u16 a;
@@ -243,6 +372,15 @@ ethnl_set_coalesce_validate(struct ethnl_req_info *req_info,
 
 	/* make sure that only supported parameters are present */
 	supported_params = ops->supported_coalesce_params;
+#if IS_ENABLED(CONFIG_DIMLIB)
+	if (dev->irq_moder) {
+		if (dev->irq_moder->profile_flags & DIM_PROFILE_RX)
+			supported_params |= ETHTOOL_COALESCE_RX_PROFILE;
+
+		if (dev->irq_moder->profile_flags & DIM_PROFILE_TX)
+			supported_params |= ETHTOOL_COALESCE_TX_PROFILE;
+	}
+#endif
 	for (a = ETHTOOL_A_COALESCE_RX_USECS; a < __ETHTOOL_A_COALESCE_CNT; a++)
 		if (tb[a] && !(supported_params & attr_to_mask(a))) {
 			NL_SET_ERR_MSG_ATTR(info->extack, tb[a],
@@ -253,12 +391,133 @@ ethnl_set_coalesce_validate(struct ethnl_req_info *req_info,
 	return 1;
 }
 
+/**
+ * ethnl_update_irq_moder - update a specific field in the given profile
+ * @irq_moder: place that collects dim related information
+ * @irq_field: field in profile to modify
+ * @attr_type: attr type ETHTOOL_A_IRQ_MODERATION_*
+ * @tb: netlink attribute with new values or null
+ * @coal_bit: DIM_COALESCE_* bit from coal_flags
+ * @extack: netlink extended ack
+ *
+ * Return: 0 on success or a negative error code.
+ */
+static int ethnl_update_irq_moder(struct dim_irq_moder *irq_moder,
+				  u16 *irq_field, u16 attr_type,
+				  struct nlattr **tb, u8 coal_bit,
+				  struct netlink_ext_ack *extack)
+{
+	int ret = 0;
+
+	if (!tb[attr_type])
+		return 0;
+
+	if (irq_moder->coal_flags & coal_bit) {
+		*irq_field = nla_get_u32(tb[attr_type]);
+	} else {
+		NL_SET_BAD_ATTR(extack, tb[attr_type]);
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+/**
+ * ethnl_update_profile - get a profile nest with child nests from userspace.
+ * @dev: netdevice to update the profile
+ * @dst: profile get from the driver and modified by ethnl_update_profile.
+ * @nests: nest attr ETHTOOL_A_COALESCE_*X_PROFILE to set profile.
+ * @extack: Netlink extended ack
+ *
+ * Layout of nests:
+ *   Nested ETHTOOL_A_COALESCE_*X_PROFILE attr
+ *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
+ *       ETHTOOL_A_IRQ_MODERATION_USEC attr
+ *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
+ *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
+ *     ...
+ *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
+ *       ETHTOOL_A_IRQ_MODERATION_USEC attr
+ *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
+ *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
+ *
+ * Return: 0 on success or a negative error code.
+ */
+static int ethnl_update_profile(struct net_device *dev,
+				struct dim_cq_moder __rcu **dst,
+				const struct nlattr *nests,
+				struct netlink_ext_ack *extack)
+{
+	int len_irq_moder = ARRAY_SIZE(coalesce_irq_moderation_policy);
+	struct nlattr *tb[ARRAY_SIZE(coalesce_irq_moderation_policy)];
+	struct dim_irq_moder *irq_moder = dev->irq_moder;
+	struct dim_cq_moder *new_profile, *old_profile;
+	int ret, rem, i = 0, len;
+	struct nlattr *nest;
+
+	if (!nests)
+		return 0;
+
+	if (!*dst)
+		return -EOPNOTSUPP;
+
+	old_profile = rtnl_dereference(*dst);
+	len = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*old_profile);
+	new_profile = kmemdup(old_profile, len, GFP_KERNEL);
+	if (!new_profile)
+		return -ENOMEM;
+
+	nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION,
+				 nests, rem) {
+		ret = nla_parse_nested(tb, len_irq_moder - 1, nest,
+				       coalesce_irq_moderation_policy,
+				       extack);
+		if (ret)
+			goto err_out;
+
+		ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].usec,
+					     ETHTOOL_A_IRQ_MODERATION_USEC,
+					     tb, DIM_COALESCE_USEC,
+					     extack);
+		if (ret)
+			goto err_out;
+
+		ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].pkts,
+					     ETHTOOL_A_IRQ_MODERATION_PKTS,
+					     tb, DIM_COALESCE_PKTS,
+					     extack);
+		if (ret)
+			goto err_out;
+
+		ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].comps,
+					     ETHTOOL_A_IRQ_MODERATION_COMPS,
+					     tb, DIM_COALESCE_COMPS,
+					     extack);
+		if (ret)
+			goto err_out;
+
+		i++;
+	}
+
+	rcu_assign_pointer(*dst, new_profile);
+	kfree_rcu(old_profile, rcu);
+
+	return 0;
+
+err_out:
+	kfree(new_profile);
+	return ret;
+}
+
 static int
 __ethnl_set_coalesce(struct ethnl_req_info *req_info, struct genl_info *info,
 		     bool *dual_change)
 {
 	struct kernel_ethtool_coalesce kernel_coalesce = {};
 	struct net_device *dev = req_info->dev;
+#if IS_ENABLED(CONFIG_DIMLIB)
+	struct dim_irq_moder *irq_moder = dev->irq_moder;
+#endif
 	struct ethtool_coalesce coalesce = {};
 	bool mod_mode = false, mod = false;
 	struct nlattr **tb = info->attrs;
@@ -317,6 +576,23 @@ __ethnl_set_coalesce(struct ethnl_req_info *req_info, struct genl_info *info,
 	ethnl_update_u32(&kernel_coalesce.tx_aggr_time_usecs,
 			 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS], &mod);
 
+#if IS_ENABLED(CONFIG_DIMLIB)
+	if (irq_moder && irq_moder->profile_flags & DIM_PROFILE_RX) {
+		ret = ethnl_update_profile(dev, &irq_moder->rx_profile,
+					   tb[ETHTOOL_A_COALESCE_RX_PROFILE],
+					   info->extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (irq_moder && irq_moder->profile_flags & DIM_PROFILE_TX) {
+		ret = ethnl_update_profile(dev, &irq_moder->tx_profile,
+					   tb[ETHTOOL_A_COALESCE_TX_PROFILE],
+					   info->extack);
+		if (ret < 0)
+			return ret;
+	}
+#endif
 	/* Update operation modes */
 	ethnl_update_bool32(&coalesce.use_adaptive_rx_coalesce,
 			    tb[ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX], &mod_mode);
-- 
2.32.0.3.g01195cf9f


