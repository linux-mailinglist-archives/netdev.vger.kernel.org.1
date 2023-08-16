Return-Path: <netdev+bounces-28276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5524777EDF3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDE4281C39
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5091ED5F;
	Wed, 16 Aug 2023 23:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C701ED3E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C32C433A9;
	Wed, 16 Aug 2023 23:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229395;
	bh=sOPZMZWu0C3WyEb46cqz6FINOSIocX/H8sMEpzhZp5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8eG04YlgdAeYM2+B3DldKKKY7nFOgNFuHwrnAOSccJ71sKXmbl4TD5qgDKIx8kZI
	 uP5+2lBIFDbfOoj+X0vXgJFZJ4Vust3UQZ8xrR1YwkQqSXx0vEgBR3I3+WF0+55IZZ
	 PWwK1BKbeCcbpkL2rFfulzgGeJv4gvhnm4FG05hQd9sLS2YBbqMemM3kRSZizTE8My
	 TqFhilbrRWI5qo4jeKj8FEl+vL1JHOQ0qXsMVQzGk3yu770anQ2rt++WOZ08xVo3pO
	 C4gsQFBto/LxFv49JLmHjvHhkGBrsIPPjjxCw59lfsuHUHJnO8Qgz9Ip8zZzwrBsCx
	 vamdDaI6pUQgw==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 11/13] net: page_pool: report when page pool was destroyed
Date: Wed, 16 Aug 2023 16:43:00 -0700
Message-ID: <20230816234303.3786178-12-kuba@kernel.org>
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

Report when page pool was destroyed and number of inflight
references. This allows user to proactively check for dead
page pools without waiting to see if errors messages will
be printed in dmesg.

Only provide inflight for pools which were already "destroyed".
inflight information could also be interesting for "live"
pools but we don't want to have to deal with the potential
negative values due to races.

Example output for a fake leaked page pool using some hacks
in netdevsim (one "live" pool, and one "leaked" on the same dev):

$ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
           --dump page-pool-get
[{'id': 2, 'ifindex': 3},
 {'id': 1, 'ifindex': 3, 'destroyed': 133, 'inflight': 1}]

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 16 ++++++++++++++++
 include/net/page_pool/types.h           |  1 +
 include/uapi/linux/netdev.h             |  2 ++
 net/core/page_pool.c                    |  3 ++-
 net/core/page_pool_priv.h               |  3 +++
 net/core/page_pool_user.c               | 16 ++++++++++++++++
 6 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 47ae2a45daea..1fd3b4235251 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -92,6 +92,20 @@ name: netdev
         name: napi-id
         doc: Id of NAPI using this Page Pool instance.
         type: u32
+      -
+        name: destroyed
+        type: u64
+        doc: |
+          Seconds in CLOCK_BOOTTIME of when Page Pool was destroyed.
+          Page Pools wait for all the memory allocated from them to be freed
+          before truly disappearing.
+          Absent if Page Pool hasn't been destroyed.
+      -
+        name: inflight
+        type: u32
+        doc: |
+          Number of outstanding references to this page pool (allocated
+          but yet to be freed pages).
 
 operations:
   list:
@@ -140,6 +154,8 @@ name: netdev
             - id
             - ifindex
             - napi-id
+            - destroyed
+            - inflight
       dump:
         reply: *pp-reply
     -
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 3017557e0c59..490c7419a474 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -195,6 +195,7 @@ struct page_pool {
 	/* User-facing fields, protected by page_pools_lock */
 	struct {
 		struct hlist_node list;
+		u64 destroyed;
 		u32 napi_id;
 		u32 id;
 	} user;
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 3c9818c1962a..aac840a3849b 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -53,6 +53,8 @@ enum {
 	NETDEV_A_PAGE_POOL_PAD,
 	NETDEV_A_PAGE_POOL_IFINDEX,
 	NETDEV_A_PAGE_POOL_NAPI_ID,
+	NETDEV_A_PAGE_POOL_DESTROYED,
+	NETDEV_A_PAGE_POOL_INFLIGHT,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index de199c356043..733ca2198d94 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -513,7 +513,7 @@ EXPORT_SYMBOL(page_pool_alloc_pages);
  */
 #define _distance(a, b)	(s32)((a) - (b))
 
-static s32 page_pool_inflight(struct page_pool *pool)
+s32 page_pool_inflight(const struct page_pool *pool)
 {
 	u32 release_cnt = atomic_read(&pool->pages_state_release_cnt);
 	u32 hold_cnt = READ_ONCE(pool->pages_state_hold_cnt);
@@ -933,6 +933,7 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_release(pool))
 		return;
 
+	page_pool_destroyed(pool);
 	pool->defer_start = jiffies;
 	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
 
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 6c4e4aeed02a..892e0cddc400 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -3,7 +3,10 @@
 #ifndef __PAGE_POOL_PRIV_H
 #define __PAGE_POOL_PRIV_H
 
+s32 page_pool_inflight(const struct page_pool *pool);
+
 int page_pool_list(struct page_pool *pool);
+void page_pool_destroyed(struct page_pool *pool);
 void page_pool_unlist(struct page_pool *pool);
 
 #endif
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index ba2f27f15495..a74d6f18caac 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -126,6 +126,14 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 	if (pool->user.napi_id &&
 	    nla_put_u32(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, pool->user.napi_id))
 		goto err_cancel;
+	if (pool->user.destroyed) {
+		if (nla_put_u64_64bit(rsp, NETDEV_A_PAGE_POOL_DESTROYED,
+				      pool->user.destroyed,
+				      NETDEV_A_PAGE_POOL_PAD) ||
+		    nla_put_u32(rsp, NETDEV_A_PAGE_POOL_INFLIGHT,
+				page_pool_inflight(pool)))
+			goto err_cancel;
+	}
 
 	genlmsg_end(rsp, hdr);
 
@@ -211,6 +219,14 @@ int page_pool_list(struct page_pool *pool)
 	return err;
 }
 
+void page_pool_destroyed(struct page_pool *pool)
+{
+	mutex_lock(&page_pools_lock);
+	pool->user.destroyed = ktime_get_boottime_seconds();
+	netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_CHANGE_NTF);
+	mutex_unlock(&page_pools_lock);
+}
+
 void page_pool_unlist(struct page_pool *pool)
 {
 	mutex_lock(&page_pools_lock);
-- 
2.41.0


