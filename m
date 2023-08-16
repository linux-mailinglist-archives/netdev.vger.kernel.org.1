Return-Path: <netdev+bounces-28277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F67077EDF4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695971C211B3
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865981ED3E;
	Wed, 16 Aug 2023 23:43:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EE1ED50
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29992C433BD;
	Wed, 16 Aug 2023 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229396;
	bh=f/Q6sLF6/AqmTANIaSFsUvH+5XSnII5ySheMXhBMcnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyqxIvY8vcwgpnA7+uQeSSsqgQaZwsGzjRx3e58EfMYz0WVjBeDxFiRH9K3o1aikw
	 boCUP0ByjoQ8qp8CCghgpdNg5xvDMYTIQDK2weFNPen/yu/RjUMnz2wW3Ujej0zEya
	 x9d+kMNMBVAyG0YVeqkh1+1pCUHPp5nZr0aFIo6/fbHZ4YPIs1Te8Lnmwd8675okqp
	 rrqA3ks0S2oQZ5un/t0cGyf/5HYE+vrSELq1OnlfuXgZpfuW7WTVBfbDdbKGWV+7Np
	 FpZCPrZtfhpZgGsBwHKEg5zTRG/ubJOH0KtSn25pM96pduYjeoDR26l1lVldlE4JEI
	 chPPKFshc2JMA==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 12/13] net: page_pool: expose page pool stats via netlink
Date: Wed, 16 Aug 2023 16:43:01 -0700
Message-ID: <20230816234303.3786178-13-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816234303.3786178-1-kuba@kernel.org>
References: <20230816234303.3786178-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml |  84 +++++++++++++++++++
 Documentation/networking/page_pool.rst  |   5 +-
 include/net/page_pool/helpers.h         |   8 +-
 include/uapi/linux/netdev.h             |  20 +++++
 net/core/netdev-genl-gen.c              |  23 +++++
 net/core/netdev-genl-gen.h              |   7 ++
 net/core/page_pool.c                    |   2 +-
 net/core/page_pool_user.c               | 106 ++++++++++++++++++++++++
 8 files changed, 246 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 1fd3b4235251..412e500d5eaa 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -106,6 +106,66 @@ name: netdev
         doc: |
           Number of outstanding references to this page pool (allocated
           but yet to be freed pages).
+  -
+    name: page-pool-info
+    subset-of: page-pool
+    attributes:
+      -
+        name: id
+        type: u32
+        checks:
+          min: 1
+      -
+        name: ifindex
+        type: u32
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
+        name: pad
+        type: pad
+      -
+        name: alloc-fast
+        type: u64
+        value: 8 # reserve some attr ids in case we need more metadata later
+      -
+        name: alloc-slow
+        type: u64
+      -
+        name: alloc-slow-high-order
+        type: u64
+      -
+        name: alloc-empty
+        type: u64
+      -
+        name: alloc-refill
+        type: u64
+      -
+        name: alloc-waive
+        type: u64
+      -
+        name: recycle-cached
+        type: u64
+      -
+        name: recycle-cache-full
+        type: u64
+      -
+        name: recycle-ring
+        type: u64
+      -
+        name: recycle-ring-full
+        type: u64
+      -
+        name: recycle-released-refcnt
+        type: u64
 
 operations:
   list:
@@ -173,6 +233,30 @@ name: netdev
       doc: Notification about page pool configuration being changed.
       notify: page-pool-get
       mcgrp: page-pool
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
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 215ebc92752c..d5566b7c5e7c 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -105,8 +105,9 @@ page_pool_get_stats() and structures described below are available.
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
index 94231533a369..b004eef7071a 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -32,16 +32,12 @@
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
index aac840a3849b..25754237eb2f 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -60,6 +60,25 @@ enum {
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
 };
 
+enum {
+	NETDEV_A_PAGE_POOL_STATS_INFO = 1,
+	NETDEV_A_PAGE_POOL_STATS_PAD,
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
@@ -69,6 +88,7 @@ enum {
 	NETDEV_CMD_PAGE_POOL_ADD_NTF,
 	NETDEV_CMD_PAGE_POOL_DEL_NTF,
 	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
+	NETDEV_CMD_PAGE_POOL_STATS_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 23d5bd111ddd..5dab064988c1 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -10,6 +10,12 @@
 
 #include <uapi/linux/netdev.h>
 
+/* Common nested types */
+const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1] = {
+	[NETDEV_A_PAGE_POOL_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_PAGE_POOL_IFINDEX] = { .type = NLA_U32, },
+};
+
 /* NETDEV_CMD_DEV_GET - do */
 static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
@@ -20,6 +26,11 @@ static const struct nla_policy netdev_page_pool_get_nl_policy[NETDEV_A_PAGE_POOL
 	[NETDEV_A_PAGE_POOL_ID] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_PAGE_POOL_STATS_GET - do */
+static const struct nla_policy netdev_page_pool_stats_get_nl_policy[NETDEV_A_PAGE_POOL_STATS_INFO + 1] = {
+	[NETDEV_A_PAGE_POOL_STATS_INFO] = NLA_POLICY_NESTED(netdev_page_pool_info_nl_policy),
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -46,6 +57,18 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.dumpit	= netdev_nl_page_pool_get_dumpit,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
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
index 733ca2198d94..b7dac08709ea 100644
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
index a74d6f18caac..f31e81b340d4 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -5,6 +5,7 @@
 #include <linux/xarray.h>
 #include <net/net_debug.h>
 #include <net/page_pool/types.h>
+#include <net/page_pool/helpers.h>
 #include <net/sock.h>
 
 #include "page_pool_priv.h"
@@ -106,6 +107,111 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	return err;
 }
 
+static int
+page_pool_nl_stats_fill(struct sk_buff *rsp, const struct page_pool *pool,
+			const struct genl_info *info)
+{
+#ifdef CONFIG_PAGE_POOL_STATS
+	const u32 pad =	NETDEV_A_PAGE_POOL_STATS_PAD;
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
+	if (nla_put_u32(rsp, NETDEV_A_PAGE_POOL_ID, pool->user.id) ||
+	    (pool->slow.netdev->ifindex != 1 &&
+	     nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
+			 pool->slow.netdev->ifindex)))
+		goto err_cancel_nest;
+
+	nla_nest_end(rsp, nest);
+
+	if (nla_put_u64_64bit(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST,
+			      stats.alloc_stats.fast, pad) ||
+	    nla_put_u64_64bit(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW,
+			      stats.alloc_stats.slow, pad) ||
+	    nla_put_u64_64bit(rsp,
+			      NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER,
+			      stats.alloc_stats.slow_high_order, pad) ||
+	    nla_put_u64_64bit(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY,
+			      stats.alloc_stats.empty, pad) ||
+	    nla_put_u64_64bit(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL,
+			      stats.alloc_stats.refill, pad) ||
+	    nla_put_u64_64bit(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE,
+			      stats.alloc_stats.waive, pad) ||
+	    nla_put_u64_64bit(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED,
+			      stats.recycle_stats.cached, pad) ||
+	    nla_put_u64_64bit(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL,
+			      stats.recycle_stats.cache_full, pad) ||
+	    nla_put_u64_64bit(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING,
+			      stats.recycle_stats.ring, pad) ||
+	    nla_put_u64_64bit(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL,
+			      stats.recycle_stats.ring_full, pad) ||
+	    nla_put_u64_64bit(rsp,
+			      NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_REFCNT,
+			      stats.recycle_stats.released_refcnt, pad))
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
+	id = nla_get_u32(tb[NETDEV_A_PAGE_POOL_ID]);
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
2.41.0


