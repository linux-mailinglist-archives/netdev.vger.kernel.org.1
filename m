Return-Path: <netdev+bounces-51171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3723C7F964C
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66A0280D8D
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE418028;
	Sun, 26 Nov 2023 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5gn6yDA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6F18AF8
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF305C433CA;
	Sun, 26 Nov 2023 23:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701040103;
	bh=+spaqklg5sxeuQpW2m0NHELuHNX9ly8ClKaeNFNJtWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5gn6yDAUpWZtFDLW9O/6JUfHrFKVbLrvkoW8nk/XZ47liCV7JD7K+pnomL6yaQ4s
	 68+f2w45lKua/hxGdjRVuBA9J4u4019gkOX6lvSmnJIyDvi33iN0OOBh38GF3U64p6
	 rSPIw1Tf7hczkpbzbTqXUH6NbVKYtfZUzsoL+t1P/09QdbKRdQIBdGHa1k7Cx8phR0
	 kyti4nSdHJD35P3FIoK3jaQa2x4FuVvTrRLDzux7dOdlM4/ozfNqJJ/UcvnbhFBBel
	 7qg3Iw53mwps191dE0mBWGMEvXsvB5kaHstP5A1y416IUWT/FRhyyW4wH6U0OK8iK3
	 poVV4fmpQo/lg==
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
Subject: [PATCH net-next v4 10/13] net: page_pool: report when page pool was destroyed
Date: Sun, 26 Nov 2023 15:07:37 -0800
Message-ID: <20231126230740.2148636-11-kuba@kernel.org>
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

Report when page pool was destroyed. Together with the inflight
/ memory use reporting this can serve as a replacement for the
warning about leaked page pools we currently print to dmesg.

Example output for a fake leaked page pool using some hacks
in netdevsim (one "live" pool, and one "leaked" on the same dev):

$ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
           --dump page-pool-get
[{'id': 2, 'ifindex': 3},
 {'id': 1, 'ifindex': 3, 'destroyed': 133, 'inflight': 1}]

Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 13 +++++++++++++
 include/net/page_pool/types.h           |  1 +
 include/uapi/linux/netdev.h             |  1 +
 net/core/page_pool.c                    |  1 +
 net/core/page_pool_priv.h               |  1 +
 net/core/page_pool_user.c               | 12 ++++++++++++
 6 files changed, 29 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index b76623ff2932..b5f715cf9e06 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -127,6 +127,18 @@ name: netdev
         type: uint
         doc: |
           Amount of memory held by inflight pages.
+      -
+        name: detach-time
+        type: uint
+        doc: |
+          Seconds in CLOCK_BOOTTIME of when Page Pool was detached by
+          the driver. Once detached Page Pool can no longer be used to
+          allocate memory.
+          Page Pools wait for all the memory allocated from them to be freed
+          before truly disappearing. "Detached" Page Pools cannot be
+          "re-attached", they are just waiting to disappear.
+          Attribute is absent if Page Pool has not been detached, and
+          can still be used to allocate new memory.
 
 operations:
   list:
@@ -178,6 +190,7 @@ name: netdev
             - napi-id
             - inflight
             - inflight-mem
+            - detach-time
       dump:
         reply: *pp-reply
       config-cond: page-pool
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 7e47d7bb2c1e..ac286ea8ce2d 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -193,6 +193,7 @@ struct page_pool {
 	/* User-facing fields, protected by page_pools_lock */
 	struct {
 		struct hlist_node list;
+		u64 detach_time;
 		u32 napi_id;
 		u32 id;
 	} user;
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 26ae5bdd3187..756410274120 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -70,6 +70,7 @@ enum {
 	NETDEV_A_PAGE_POOL_NAPI_ID,
 	NETDEV_A_PAGE_POOL_INFLIGHT,
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
+	NETDEV_A_PAGE_POOL_DETACH_TIME,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 566390759294..a821fb5fe054 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -953,6 +953,7 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_release(pool))
 		return;
 
+	page_pool_detached(pool);
 	pool->defer_start = jiffies;
 	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
 
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 72fb21ea1ddc..90665d40f1eb 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -6,6 +6,7 @@
 s32 page_pool_inflight(const struct page_pool *pool, bool strict);
 
 int page_pool_list(struct page_pool *pool);
+void page_pool_detached(struct page_pool *pool);
 void page_pool_unlist(struct page_pool *pool);
 
 #endif
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 2db71e718485..bd5ca94f683f 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -134,6 +134,10 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 			 inflight * refsz))
 		goto err_cancel;
+	if (pool->user.detach_time &&
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DETACH_TIME,
+			 pool->user.detach_time))
+		goto err_cancel;
 
 	genlmsg_end(rsp, hdr);
 
@@ -219,6 +223,14 @@ int page_pool_list(struct page_pool *pool)
 	return err;
 }
 
+void page_pool_detached(struct page_pool *pool)
+{
+	mutex_lock(&page_pools_lock);
+	pool->user.detach_time = ktime_get_boottime_seconds();
+	netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_CHANGE_NTF);
+	mutex_unlock(&page_pools_lock);
+}
+
 void page_pool_unlist(struct page_pool *pool)
 {
 	mutex_lock(&page_pools_lock);
-- 
2.42.0


