Return-Path: <netdev+bounces-51172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E7B7F964D
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC9D280D9A
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ACE18B10;
	Sun, 26 Nov 2023 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDqGcmZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FCE182B9
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812F4C4163C;
	Sun, 26 Nov 2023 23:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701040104;
	bh=Vbg0fwi9bLNMzv6/rZl8FnMtiYhFfmNKcMcOpmfqz7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDqGcmZDTgej5iaX2q2/ANmnBzYgSPWME5MdyvpZX1siEeZ7eZ9GlflcgloLCqy7a
	 0Ld8ZkotLpZleyAF+nul14n367yh52kex6EVhjBrgGy7oPWGRWZ+EVM3TM682LMSCh
	 wX0SKCDAgZdkw86vjH3I7KjUh9LBzdWZahtYo7q39fiOzT0yDsfZaRQm46rNNS1jfp
	 7hYC0HbzaLZOqU0F8JeeUMKsf2d0LYY91y4qUr3mpdc8t3BMalOKJEsil39cIum1Dt
	 hyc4jq6RKV42n4lKMZFHOCQyS/XLcW/B9oilkcTKVtqFuB2ZJS7OxWJ2aRSoYGTBsw
	 /hgbSZVELGzcg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	willemb@google.com,
	almasrymina@google.com,
	shakeelb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 11/13] net: page_pool: expose page pool stats via netlink
Date: Sun, 26 Nov 2023 15:07:38 -0800
Message-ID: <20231126230740.2148636-12-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126230740.2148636-1-kuba@kernel.org>
References: <20231126230740.2148636-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dump the stats into netlink. More clever approaches
like dumping the stats per-CPU for each CPU individually
to see where the packets get consumed can be implemented
in the future.

A trimmed example from a real (but recently booted system):

$ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
           --dump page-pool-stats-get
[{'info': {'id': 19, 'ifindex': 2},
  'alloc-empty': 48,
  'alloc-fast': 3024,
  'alloc-refill': 0,
  'alloc-slow': 48,
  'alloc-slow-high-order': 0,
  'alloc-waive': 0,
  'recycle-cache-full': 0,
  'recycle-cached': 0,
  'recycle-released-refcnt': 0,
  'recycle-ring': 0,
  'recycle-ring-full': 0},
 {'info': {'id': 18, 'ifindex': 2},
  'alloc-empty': 66,
  'alloc-fast': 11811,
  'alloc-refill': 35,
  'alloc-slow': 66,
  'alloc-slow-high-order': 0,
  'alloc-waive': 0,
  'recycle-cache-full': 1145,
  'recycle-cached': 6541,
  'recycle-released-refcnt': 0,
  'recycle-ring': 1275,
  'recycle-ring-full': 0},
 {'info': {'id': 17, 'ifindex': 2},
  'alloc-empty': 73,
  'alloc-fast': 62099,
  'alloc-refill': 413,
...

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml |  78 ++++++++++++++++++
 Documentation/networking/page_pool.rst  |  10 ++-
 include/net/page_pool/helpers.h         |   8 +-
 include/uapi/linux/netdev.h             |  19 +++++
 net/core/netdev-genl-gen.c              |  32 ++++++++
 net/core/netdev-genl-gen.h              |   7 ++
 net/core/page_pool.c                    |   2 +-
 net/core/page_pool_user.c               | 103 ++++++++++++++++++++++++
 8 files changed, 250 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index b5f715cf9e06..20f75b7d3240 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -139,6 +139,59 @@ name: netdev
           "re-attached", they are just waiting to disappear.
           Attribute is absent if Page Pool has not been detached, and
           can still be used to allocate new memory.
+  -
+    name: page-pool-info
+    subset-of: page-pool
+    attributes:
+      -
+        name: id
+      -
+        name: ifindex
+  -
+    name: page-pool-stats
+    doc: |
+      Page pool statistics, see docs for struct page_pool_stats
+      for information about individual statistics.
+    attributes:
+      -
+        name: info
+        doc: Page pool identifying information.
+        type: nest
+        nested-attributes: page-pool-info
+      -
+        name: alloc-fast
+        type: uint
+        value: 8 # reserve some attr ids in case we need more metadata later
+      -
+        name: alloc-slow
+        type: uint
+      -
+        name: alloc-slow-high-order
+        type: uint
+      -
+        name: alloc-empty
+        type: uint
+      -
+        name: alloc-refill
+        type: uint
+      -
+        name: alloc-waive
+        type: uint
+      -
+        name: recycle-cached
+        type: uint
+      -
+        name: recycle-cache-full
+        type: uint
+      -
+        name: recycle-ring
+        type: uint
+      -
+        name: recycle-ring-full
+        type: uint
+      -
+        name: recycle-released-refcnt
+        type: uint
 
 operations:
   list:
@@ -212,6 +265,31 @@ name: netdev
       notify: page-pool-get
       mcgrp: page-pool
       config-cond: page-pool
+    -
+      name: page-pool-stats-get
+      doc: Get page pool statistics.
+      attribute-set: page-pool-stats
+      do:
+        request:
+          attributes:
+            - info
+        reply: &pp-stats-reply
+          attributes:
+            - info
+            - alloc-fast
+            - alloc-slow
+            - alloc-slow-high-order
+            - alloc-empty
+            - alloc-refill
+            - alloc-waive
+            - recycle-cached
+            - recycle-cache-full
+            - recycle-ring
+            - recycle-ring-full
+            - recycle-released-refcnt
+      dump:
+        reply: *pp-stats-reply
+      config-cond: page-pool-stats
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 60993cb56b32..9d958128a57c 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -41,6 +41,11 @@ Architecture overview
                           |   Fast cache    |     |  ptr-ring cache  |
                           +-----------------+     +------------------+
 
+Monitoring
+==========
+Information about page pools on the system can be accessed via the netdev
+genetlink family (see Documentation/netlink/specs/netdev.yaml).
+
 API interface
 =============
 The number of pools created **must** match the number of hardware queues
@@ -107,8 +112,9 @@ page_pool_get_stats() and structures described below are available.
 It takes a  pointer to a ``struct page_pool`` and a pointer to a struct
 page_pool_stats allocated by the caller.
 
-The API will fill in the provided struct page_pool_stats with
-statistics about the page_pool.
+Older drivers expose page pool statistics via ethtool or debugfs.
+The same statistics are accessible via the netlink netdev family
+in a driver-independent fashion.
 
 .. kernel-doc:: include/net/page_pool/types.h
    :identifiers: struct page_pool_recycle_stats
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 4ebd544ae977..7dc65774cde5 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -55,16 +55,12 @@
 #include <net/page_pool/types.h>
 
 #ifdef CONFIG_PAGE_POOL_STATS
+/* Deprecated driver-facing API, use netlink instead */
 int page_pool_ethtool_stats_get_count(void);
 u8 *page_pool_ethtool_stats_get_strings(u8 *data);
 u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
 
-/*
- * Drivers that wish to harvest page pool stats and report them to users
- * (perhaps via ethtool, debugfs, or another mechanism) can allocate a
- * struct page_pool_stats call page_pool_get_stats to get stats for the specified pool.
- */
-bool page_pool_get_stats(struct page_pool *pool,
+bool page_pool_get_stats(const struct page_pool *pool,
 			 struct page_pool_stats *stats);
 #else
 static inline int page_pool_ethtool_stats_get_count(void)
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 756410274120..2b37233e00c0 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -76,6 +76,24 @@ enum {
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
 };
 
+enum {
+	NETDEV_A_PAGE_POOL_STATS_INFO = 1,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST = 8,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE,
+	NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED,
+	NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL,
+	NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING,
+	NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL,
+	NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_REFCNT,
+
+	__NETDEV_A_PAGE_POOL_STATS_MAX,
+	NETDEV_A_PAGE_POOL_STATS_MAX = (__NETDEV_A_PAGE_POOL_STATS_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
@@ -85,6 +103,7 @@ enum {
 	NETDEV_CMD_PAGE_POOL_ADD_NTF,
 	NETDEV_CMD_PAGE_POOL_DEL_NTF,
 	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
+	NETDEV_CMD_PAGE_POOL_STATS_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 47fb5e1b6369..dccd8c3a141e 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -16,6 +16,17 @@ static const struct netlink_range_validation netdev_a_page_pool_id_range = {
 	.max	= 4294967295ULL,
 };
 
+static const struct netlink_range_validation netdev_a_page_pool_ifindex_range = {
+	.min	= 1ULL,
+	.max	= 2147483647ULL,
+};
+
+/* Common nested types */
+const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1] = {
+	[NETDEV_A_PAGE_POOL_ID] = NLA_POLICY_FULL_RANGE(NLA_UINT, &netdev_a_page_pool_id_range),
+	[NETDEV_A_PAGE_POOL_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_page_pool_ifindex_range),
+};
+
 /* NETDEV_CMD_DEV_GET - do */
 static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
@@ -28,6 +39,13 @@ static const struct nla_policy netdev_page_pool_get_nl_policy[NETDEV_A_PAGE_POOL
 };
 #endif /* CONFIG_PAGE_POOL */
 
+/* NETDEV_CMD_PAGE_POOL_STATS_GET - do */
+#ifdef CONFIG_PAGE_POOL_STATS
+static const struct nla_policy netdev_page_pool_stats_get_nl_policy[NETDEV_A_PAGE_POOL_STATS_INFO + 1] = {
+	[NETDEV_A_PAGE_POOL_STATS_INFO] = NLA_POLICY_NESTED(netdev_page_pool_info_nl_policy),
+};
+#endif /* CONFIG_PAGE_POOL_STATS */
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -56,6 +74,20 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
 #endif /* CONFIG_PAGE_POOL */
+#ifdef CONFIG_PAGE_POOL_STATS
+	{
+		.cmd		= NETDEV_CMD_PAGE_POOL_STATS_GET,
+		.doit		= netdev_nl_page_pool_stats_get_doit,
+		.policy		= netdev_page_pool_stats_get_nl_policy,
+		.maxattr	= NETDEV_A_PAGE_POOL_STATS_INFO,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NETDEV_CMD_PAGE_POOL_STATS_GET,
+		.dumpit	= netdev_nl_page_pool_stats_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+#endif /* CONFIG_PAGE_POOL_STATS */
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 738097847100..649e4b46eccf 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -11,11 +11,18 @@
 
 #include <uapi/linux/netdev.h>
 
+/* Common nested types */
+extern const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1];
+
 int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int netdev_nl_page_pool_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_page_pool_get_dumpit(struct sk_buff *skb,
 				   struct netlink_callback *cb);
+int netdev_nl_page_pool_stats_get_doit(struct sk_buff *skb,
+				       struct genl_info *info);
+int netdev_nl_page_pool_stats_get_dumpit(struct sk_buff *skb,
+					 struct netlink_callback *cb);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a821fb5fe054..3d0938a60646 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -71,7 +71,7 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
  * is passed to this API which is filled in. The caller can then report
  * those stats to the user (perhaps via ethtool, debugfs, etc.).
  */
-bool page_pool_get_stats(struct page_pool *pool,
+bool page_pool_get_stats(const struct page_pool *pool,
 			 struct page_pool_stats *stats)
 {
 	int cpu = 0;
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index bd5ca94f683f..1426434a7e15 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -5,6 +5,7 @@
 #include <linux/xarray.h>
 #include <net/net_debug.h>
 #include <net/page_pool/types.h>
+#include <net/page_pool/helpers.h>
 #include <net/sock.h>
 
 #include "page_pool_priv.h"
@@ -106,6 +107,108 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	return err;
 }
 
+static int
+page_pool_nl_stats_fill(struct sk_buff *rsp, const struct page_pool *pool,
+			const struct genl_info *info)
+{
+#ifdef CONFIG_PAGE_POOL_STATS
+	struct page_pool_stats stats = {};
+	struct nlattr *nest;
+	void *hdr;
+
+	if (!page_pool_get_stats(pool, &stats))
+		return 0;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	nest = nla_nest_start(rsp, NETDEV_A_PAGE_POOL_STATS_INFO);
+
+	if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ID, pool->user.id) ||
+	    (pool->slow.netdev->ifindex != LOOPBACK_IFINDEX &&
+	     nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
+			 pool->slow.netdev->ifindex)))
+		goto err_cancel_nest;
+
+	nla_nest_end(rsp, nest);
+
+	if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST,
+			 stats.alloc_stats.fast) ||
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW,
+			 stats.alloc_stats.slow) ||
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER,
+			 stats.alloc_stats.slow_high_order) ||
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY,
+			 stats.alloc_stats.empty) ||
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL,
+			 stats.alloc_stats.refill) ||
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE,
+			 stats.alloc_stats.waive) ||
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED,
+			 stats.recycle_stats.cached) ||
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL,
+			 stats.recycle_stats.cache_full) ||
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING,
+			 stats.recycle_stats.ring) ||
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL,
+			 stats.recycle_stats.ring_full) ||
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_REFCNT,
+			 stats.recycle_stats.released_refcnt))
+		goto err_cancel_msg;
+
+	genlmsg_end(rsp, hdr);
+
+	return 0;
+err_cancel_nest:
+	nla_nest_cancel(rsp, nest);
+err_cancel_msg:
+	genlmsg_cancel(rsp, hdr);
+	return -EMSGSIZE;
+#else
+	GENL_SET_ERR_MSG(info, "kernel built without CONFIG_PAGE_POOL_STATS");
+	return -EOPNOTSUPP;
+#endif
+}
+
+int netdev_nl_page_pool_stats_get_doit(struct sk_buff *skb,
+				       struct genl_info *info)
+{
+	struct nlattr *tb[ARRAY_SIZE(netdev_page_pool_info_nl_policy)];
+	struct nlattr *nest;
+	int err;
+	u32 id;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_PAGE_POOL_STATS_INFO))
+		return -EINVAL;
+
+	nest = info->attrs[NETDEV_A_PAGE_POOL_STATS_INFO];
+	err = nla_parse_nested(tb, ARRAY_SIZE(tb) - 1, nest,
+			       netdev_page_pool_info_nl_policy,
+			       info->extack);
+	if (err)
+		return err;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, nest, tb, NETDEV_A_PAGE_POOL_ID))
+		return -EINVAL;
+	if (tb[NETDEV_A_PAGE_POOL_IFINDEX]) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NETDEV_A_PAGE_POOL_IFINDEX],
+				    "selecting by ifindex not supported");
+		return -EINVAL;
+	}
+
+	id = nla_get_uint(tb[NETDEV_A_PAGE_POOL_ID]);
+
+	return netdev_nl_page_pool_get_do(info, id, page_pool_nl_stats_fill);
+}
+
+int netdev_nl_page_pool_stats_get_dumpit(struct sk_buff *skb,
+					 struct netlink_callback *cb)
+{
+	return netdev_nl_page_pool_get_dump(skb, cb, page_pool_nl_stats_fill);
+}
+
 static int
 page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		  const struct genl_info *info)
-- 
2.42.0


