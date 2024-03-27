Return-Path: <netdev+bounces-82409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E688DA1C
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 10:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3F2B22C39
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAED36B0D;
	Wed, 27 Mar 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SMoODbgK"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5C381BE
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531159; cv=none; b=ap1StT+L309dNIEKXSRVIn3SREnBtfecdLCvFJlPvtg7viUlgVM3j8hSzFETms+H+qkYjVH400ondfatCXI+v6HXZ7W1mGRWlPwtxtZzD1p7wa1Ts3ly4wPcbc2+htkqNFIK+YR4RhsnM6j4kswmfzbFZsoToh45xwd1M17XBwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531159; c=relaxed/simple;
	bh=Es0Rv3+Gi7kCsJ0fer4oTP4b7GJkF9WNdDRwycD72PQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=DZHh2SEF+DwHjcafGsC036lTRdmJJFVBSjbTYSGJkKmbvKzcYkcv99X+/D+gpATs994Zu3zGXDD9++xxRv3FYGtaLF3ia1KS1L1+uOxnWeWnk/4WwX+d4wASrfHOYhhX1TWX7Wmp69RhccGP6NJN1oELDLYQ6gWYmXx+J4dkA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SMoODbgK; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711531149; h=From:To:Subject:Date:Message-Id;
	bh=uwIrlZ7lTXYiH31yjmSq2vEYnt2L3nFV1QjVTVETDBU=;
	b=SMoODbgK3+hqwGCyHAfTL+AGefMwcSgZRRUmRGalhii8yWYuFNhmltC4Ee3gHNYpZNlEo1yXOCgrbT46pDOAZafymEH3kn/lCet6Z8sQlcUFIWlcPoS3ZYB/YIb/p2KT0/OCiGjQWamUqzWeJkYdQ7lELSfNKjktRMcnP66fLww=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3OEPm._1711531147;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3OEPm._1711531147)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 17:19:08 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v2 1/2] ethtool: provide customized dim profile management
Date: Wed, 27 Mar 2024 17:19:05 +0800
Message-Id: <1711531146-91920-2-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
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
rx-eqe-profs:
{.usec =   1, .pkts = 256, .comps =   0,},
{.usec =   8, .pkts = 256, .comps =   0,},
{.usec =  64, .pkts = 256, .comps =   0,},
{.usec = 128, .pkts = 256, .comps =   0,},
rx-cqe-profs:   n/a
tx-eqe-profs:   n/a
tx-cqe-profs:   n/a

2. Tune
$ ethtool -C ethx rx-eqe-profs 1,1,0_2,2,0_3,3,0_4,4,0_5,5,0
$ ethtool -c ethx
...
rx-eqe-profs:
{.usec =   1, .pkts =   1, .comps =   0,},
{.usec =   2, .pkts =   2, .comps =   0,},
{.usec =   3, .pkts =   3, .comps =   0,},
{.usec =   4, .pkts =   4, .comps =   0,},
{.usec =   5, .pkts =   5, .comps =   0,}
rx-cqe-profs:   n/a
tx-eqe-profs:   n/a
tx-cqe-profs:   n/a

3. Hint
If the device does not support some type of customized dim
profiles, the corresponding "n/a" will display.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 Documentation/networking/ethtool-netlink.rst |  8 +++++
 include/linux/dim.h                          |  7 ++++
 include/linux/ethtool.h                      | 16 ++++++++-
 include/uapi/linux/ethtool_netlink.h         |  4 +++
 lib/dim/net_dim.c                            |  6 ----
 net/ethtool/coalesce.c                       | 51 ++++++++++++++++++++++++++--
 net/ethtool/netlink.h                        | 35 +++++++++++++++++++
 7 files changed, 118 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d583d9a..eb5be7b3 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1033,6 +1033,10 @@ Kernel response contents:
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES``     u32     max aggr size, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES``    u32     max aggr packets, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
+  ``ETHTOOL_A_COALESCE_RX_EQE_PROFILE``        string  profile of DIM EQE, Rx
+  ``ETHTOOL_A_COALESCE_RX_CQE_PROFILE``        string  profile of DIM CQE, Rx
+  ``ETHTOOL_A_COALESCE_TX_EQE_PROFILE``        string  profile of DIM EQE, Tx
+  ``ETHTOOL_A_COALESCE_TX_CQE_PROFILE``        string  profile of DIM CQE, Tx
   ===========================================  ======  =======================
 
 Attributes are only included in reply if their value is not zero or the
@@ -1098,6 +1102,10 @@ Request contents:
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES``     u32     max aggr size, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES``    u32     max aggr packets, Tx
   ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
+  ``ETHTOOL_A_COALESCE_RX_EQE_PROFILE``        string  profile of DIM EQE, Rx
+  ``ETHTOOL_A_COALESCE_RX_CQE_PROFILE``        string  profile of DIM CQE, Rx
+  ``ETHTOOL_A_COALESCE_TX_EQE_PROFILE``        string  profile of DIM EQE, Tx
+  ``ETHTOOL_A_COALESCE_TX_CQE_PROFILE``        string  profile of DIM CQE, Tx
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
index 9901e56..0fd81e8 100644
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
+	struct dim_cq_moder rx_eqe_profs[NET_DIM_PARAMS_NUM_PROFILES];
+	struct dim_cq_moder rx_cqe_profs[NET_DIM_PARAMS_NUM_PROFILES];
+	struct dim_cq_moder tx_eqe_profs[NET_DIM_PARAMS_NUM_PROFILES];
+	struct dim_cq_moder tx_cqe_profs[NET_DIM_PARAMS_NUM_PROFILES];
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
index 3f89074..b7c0b81 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -416,6 +416,10 @@ enum {
 	ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES,		/* u32 */
 	ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,		/* u32 */
 	ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,		/* u32 */
+	ETHTOOL_A_COALESCE_RX_EQE_PROFILE,              /* string */
+	ETHTOOL_A_COALESCE_RX_CQE_PROFILE,              /* string */
+	ETHTOOL_A_COALESCE_TX_EQE_PROFILE,              /* string */
+	ETHTOOL_A_COALESCE_TX_CQE_PROFILE,              /* string */
 
 	/* add new constants above here */
 	__ETHTOOL_A_COALESCE_CNT,
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
index 83112c1..b5d5bc1 100644
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
@@ -108,7 +112,9 @@ static int coalesce_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u8)) +	/* _USE_CQE_MODE_RX */
 	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_BYTES */
 	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_FRAMES */
-	       nla_total_size(sizeof(u32));	/* _TX_AGGR_TIME_USECS */
+	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_TIME_USECS */
+	       nla_total_size(sizeof(struct dim_cq_moder) *
+			      NET_DIM_PARAMS_NUM_PROFILES) * 4; /* _{R,T}X_{E,C}QE_PROFILE */
 }
 
 static bool coalesce_put_u32(struct sk_buff *skb, u16 attr_type, u32 val,
@@ -127,6 +133,27 @@ static bool coalesce_put_bool(struct sk_buff *skb, u16 attr_type, u32 val,
 	return nla_put_u8(skb, attr_type, !!val);
 }
 
+static bool coalesce_put_dim_profs(struct sk_buff *skb, u16 attr_type,
+				   const struct dim_cq_moder *profs,
+				   u32 supported_params)
+{
+	bool valid = false;
+	int i;
+
+	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
+		if (profs[i].usec || profs[i].pkts || profs[i].comps) {
+			valid = true;
+			break;
+		}
+	}
+
+	if (!valid || !(supported_params & attr_to_mask(attr_type)))
+		return false;
+
+	return nla_put(skb, attr_type, sizeof(struct dim_cq_moder) *
+		       NET_DIM_PARAMS_NUM_PROFILES, profs);
+}
+
 static int coalesce_fill_reply(struct sk_buff *skb,
 			       const struct ethnl_req_info *req_base,
 			       const struct ethnl_reply_data *reply_base)
@@ -189,7 +216,15 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,
 			     kcoal->tx_aggr_max_frames, supported) ||
 	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,
-			     kcoal->tx_aggr_time_usecs, supported))
+			     kcoal->tx_aggr_time_usecs, supported) ||
+	    coalesce_put_dim_profs(skb, ETHTOOL_A_COALESCE_RX_EQE_PROFILE,
+				   kcoal->rx_eqe_profs, supported) ||
+	    coalesce_put_dim_profs(skb, ETHTOOL_A_COALESCE_RX_CQE_PROFILE,
+				   kcoal->rx_cqe_profs, supported) ||
+	    coalesce_put_dim_profs(skb, ETHTOOL_A_COALESCE_TX_EQE_PROFILE,
+				   kcoal->tx_eqe_profs, supported) ||
+	    coalesce_put_dim_profs(skb, ETHTOOL_A_COALESCE_TX_CQE_PROFILE,
+				   kcoal->tx_cqe_profs, supported))
 		return -EMSGSIZE;
 
 	return 0;
@@ -227,6 +262,10 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES] = { .type = NLA_U32 },
 	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES] = { .type = NLA_U32 },
 	[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS] = { .type = NLA_U32 },
+	[ETHTOOL_A_COALESCE_RX_EQE_PROFILE]     = { .type = NLA_NUL_STRING },
+	[ETHTOOL_A_COALESCE_RX_CQE_PROFILE]     = { .type = NLA_NUL_STRING },
+	[ETHTOOL_A_COALESCE_TX_EQE_PROFILE]     = { .type = NLA_NUL_STRING },
+	[ETHTOOL_A_COALESCE_TX_CQE_PROFILE]     = { .type = NLA_NUL_STRING },
 };
 
 static int
@@ -316,6 +355,14 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 			 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES], &mod);
 	ethnl_update_u32(&kernel_coalesce.tx_aggr_time_usecs,
 			 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS], &mod);
+	ethnl_update_profs(kernel_coalesce.rx_eqe_profs,
+			   tb[ETHTOOL_A_COALESCE_RX_EQE_PROFILE], &mod);
+	ethnl_update_profs(kernel_coalesce.rx_cqe_profs,
+			   tb[ETHTOOL_A_COALESCE_RX_CQE_PROFILE], &mod);
+	ethnl_update_profs(kernel_coalesce.tx_eqe_profs,
+			   tb[ETHTOOL_A_COALESCE_TX_EQE_PROFILE], &mod);
+	ethnl_update_profs(kernel_coalesce.tx_cqe_profs,
+			   tb[ETHTOOL_A_COALESCE_TX_CQE_PROFILE], &mod);
 
 	/* Update operation modes */
 	ethnl_update_bool32(&coalesce.use_adaptive_rx_coalesce,
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 9a333a8..5a30879 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -85,6 +85,41 @@ static inline void ethnl_update_u32(u32 *dst, const struct nlattr *attr,
 	*mod = true;
 }
 
+static inline void ethnl_update_profs(struct dim_cq_moder *dst,
+				      const struct nlattr *attr,
+				      bool *mod)
+{
+	struct dim_cq_moder profs[NET_DIM_PARAMS_NUM_PROFILES];
+	int ret, i, totlen = 0, retlen;
+	char *buf;
+	u16 len;
+
+	if (!attr)
+		return;
+
+	buf = nla_data(attr);
+	len = nla_len(attr);
+	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
+		ret = sscanf(buf, "%hu,%hu,%hu_%n", &profs[i].usec,
+			     &profs[i].pkts, &profs[i].comps, &retlen);
+		if (ret != 3)
+			return;
+
+		totlen += retlen;
+		if (totlen > len)
+			return;
+
+		if (dst[i].usec  != profs[i].usec ||
+		    dst[i].pkts  != profs[i].pkts ||
+		    dst[i].comps != profs[i].comps)
+			*mod = true;
+
+		buf += retlen;
+	}
+
+	memcpy(dst, profs, sizeof(profs));
+}
+
 /**
  * ethnl_update_u8() - update u8 value from NLA_U8 attribute
  * @dst:  value to update
-- 
1.8.3.1


