Return-Path: <netdev+bounces-86098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E8589D8C4
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDD9282385
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12F512B141;
	Tue,  9 Apr 2024 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yHGCgQru"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38312AAC8
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664212; cv=none; b=mm2zpJVW8OhP0Da9tDU+JT9iQc5Gq0Z7He03BJPFcLnn2GE4vMK5lBTHJW6q2S9EBXdI11dieYcyoADGFIAfxWX+5nPv0tBuWFTPoQoCqnDRDP0whsbUGLZNTe8Z3x1NJTOWZQElaMLxEQK6k+NKuNWiLq0OC5gGag78L0alZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664212; c=relaxed/simple;
	bh=BBKtv7taZr2HQIoDHU0zGLri+vsdVRcOhA/wpmeR93c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BEJ3ig5ZwVtmI7T+IEmtccoZw76d9QDcd9xuFeUn/O9bE+CbUsyotcU1tz2sjIlN7OwSHDi4RjLdL4PuzNJ0ePxRLieCvbNTuuVV8p00hxd37CcmoJInVIz3x5uGiUynDURLZ7jZkY5oZszrfWZogG7gpDQXrdbOCpX6/Fzhl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yHGCgQru; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712664207; h=From:To:Subject:Date:Message-Id;
	bh=OEUwVphtmoc9SILz0940VtZfhevQiKqQx+8zc6AzM1s=;
	b=yHGCgQruM6gh3VUdg4/xY73r+g2ZM2K/5COcFPZCmD4didJRGilYxAIeIO5gfrpvk/tH5KFx6PTrn+MZVt4uSgKA2qyRo/KvlgeW1WXicGndSvnTpezI3MNsBNw5vx2lmDxvUq0/LFZgVBHsL1q6kjwfVJHdtf71NlkaW1let1g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4EUEoR_1712664205;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4EUEoR_1712664205)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 20:03:26 +0800
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
Subject: [PATCH net-next v5 1/4] ethtool: provide customized dim profile management
Date: Tue,  9 Apr 2024 20:03:21 +0800
Message-Id: <1712664204-83147-2-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
References: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
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
 include/linux/dim.h                          |   7 ++
 include/linux/ethtool.h                      |  16 ++-
 include/uapi/linux/ethtool_netlink.h         |  24 ++++
 lib/dim/net_dim.c                            |   6 -
 net/ethtool/coalesce.c                       | 172 ++++++++++++++++++++++++++-
 7 files changed, 257 insertions(+), 9 deletions(-)

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
diff --git a/include/linux/dim.h b/include/linux/dim.h
index f343bc9..43398f5 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -10,6 +10,13 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+/* Number of DIM profiles and period mode. */
+#define NET_DIM_PARAMS_NUM_PROFILES 5
+#define NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE 256
+#define NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE 128
+#define NET_DIM_DEF_PROFILE_CQE 1
+#define NET_DIM_DEF_PROFILE_EQE 1
+
 /*
  * Number of events between DIM iterations.
  * Causes a moderation of the algorithm run.
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6fd9107..2da3ba7 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -18,6 +18,7 @@
 #include <linux/if_ether.h>
 #include <linux/netlink.h>
 #include <uapi/linux/ethtool.h>
+#include <linux/dim.h>
 
 struct compat_ethtool_rx_flow_spec {
 	u32		flow_type;
@@ -238,6 +239,10 @@ struct kernel_ethtool_coalesce {
 	u32 tx_aggr_max_bytes;
 	u32 tx_aggr_max_frames;
 	u32 tx_aggr_time_usecs;
+	struct dim_cq_moder rx_eqe_profile[NET_DIM_PARAMS_NUM_PROFILES];
+	struct dim_cq_moder rx_cqe_profile[NET_DIM_PARAMS_NUM_PROFILES];
+	struct dim_cq_moder tx_eqe_profile[NET_DIM_PARAMS_NUM_PROFILES];
+	struct dim_cq_moder tx_cqe_profile[NET_DIM_PARAMS_NUM_PROFILES];
 };
 
 /**
@@ -284,7 +289,11 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
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
@@ -316,6 +325,11 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
 	(ETHTOOL_COALESCE_TX_AGGR_MAX_BYTES |	\
 	 ETHTOOL_COALESCE_TX_AGGR_MAX_FRAMES |	\
 	 ETHTOOL_COALESCE_TX_AGGR_TIME_USECS)
+#define ETHTOOL_COALESCE_PROFILE		\
+	(ETHTOOL_COALESCE_RX_EQE_PROFILE |	\
+	 ETHTOOL_COALESCE_RX_CQE_PROFILE |	\
+	 ETHTOOL_COALESCE_TX_EQE_PROFILE |	\
+	 ETHTOOL_COALESCE_TX_CQE_PROFILE)
 
 #define ETHTOOL_STAT_NOT_SET	(~0ULL)
 
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
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 4e32f7a..67d5beb 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -11,12 +11,6 @@
  *        There are different set of profiles for RX/TX CQs.
  *        Each profile size must be of NET_DIM_PARAMS_NUM_PROFILES
  */
-#define NET_DIM_PARAMS_NUM_PROFILES 5
-#define NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE 256
-#define NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE 128
-#define NET_DIM_DEF_PROFILE_CQE 1
-#define NET_DIM_DEF_PROFILE_EQE 1
-
 #define NET_DIM_RX_EQE_PROFILES { \
 	{.usec = 1,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
 	{.usec = 8,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 83112c1..e6a399a 100644
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
@@ -127,6 +139,61 @@ static bool coalesce_put_bool(struct sk_buff *skb, u16 attr_type, u32 val,
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
+ */
+static bool coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
+				 const struct dim_cq_moder *profile,
+				 u32 supported_params)
+{
+	struct nlattr *profile_attr, *moder_attr;
+	bool valid = false;
+	int i;
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
+		return -EMSGSIZE;
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
+	return -EMSGSIZE;
+}
+
 static int coalesce_fill_reply(struct sk_buff *skb,
 			       const struct ethnl_req_info *req_base,
 			       const struct ethnl_reply_data *reply_base)
@@ -189,7 +256,15 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,
 			     kcoal->tx_aggr_max_frames, supported) ||
 	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,
-			     kcoal->tx_aggr_time_usecs, supported))
+			     kcoal->tx_aggr_time_usecs, supported) ||
+	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_EQE_PROFILE,
+				 kcoal->rx_eqe_profile, supported) ||
+	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_CQE_PROFILE,
+				 kcoal->rx_cqe_profile, supported) ||
+	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_EQE_PROFILE,
+				 kcoal->tx_eqe_profile, supported) ||
+	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_CQE_PROFILE,
+				 kcoal->tx_cqe_profile, supported))
 		return -EMSGSIZE;
 
 	return 0;
@@ -227,6 +302,16 @@ static int coalesce_fill_reply(struct sk_buff *skb,
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
@@ -253,6 +338,69 @@ static int coalesce_fill_reply(struct sk_buff *skb,
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
+static inline int ethnl_update_profile(struct dim_cq_moder *dst,
+				       const struct nlattr *nests,
+				       bool *mod,
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
+		if (dst[i].usec != profile[i].usec || dst[i].pkts != profile[i].pkts ||
+		    dst[i].comps != profile[i].comps)
+			*mod = true;
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
@@ -316,6 +464,26 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 			 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES], &mod);
 	ethnl_update_u32(&kernel_coalesce.tx_aggr_time_usecs,
 			 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS], &mod);
+	ret = ethnl_update_profile(kernel_coalesce.rx_eqe_profile,
+				   tb[ETHTOOL_A_COALESCE_RX_EQE_PROFILE],
+				   &mod, info->extack);
+	if (ret < 0)
+		return ret;
+	ret = ethnl_update_profile(kernel_coalesce.rx_cqe_profile,
+				   tb[ETHTOOL_A_COALESCE_RX_CQE_PROFILE],
+				   &mod, info->extack);
+	if (ret < 0)
+		return ret;
+	ret = ethnl_update_profile(kernel_coalesce.tx_eqe_profile,
+				   tb[ETHTOOL_A_COALESCE_TX_EQE_PROFILE],
+				   &mod, info->extack);
+	if (ret < 0)
+		return ret;
+	ret = ethnl_update_profile(kernel_coalesce.tx_cqe_profile,
+				   tb[ETHTOOL_A_COALESCE_TX_CQE_PROFILE],
+				   &mod, info->extack);
+	if (ret < 0)
+		return ret;
 
 	/* Update operation modes */
 	ethnl_update_bool32(&coalesce.use_adaptive_rx_coalesce,
-- 
1.8.3.1


