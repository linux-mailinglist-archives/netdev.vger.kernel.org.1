Return-Path: <netdev+bounces-51170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C45057F964B
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A232B1C20904
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED86C1862D;
	Sun, 26 Nov 2023 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky61ftQT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FD182B9
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E13CC433C8;
	Sun, 26 Nov 2023 23:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701040102;
	bh=xc06u5dm7xirs2bRUZpUQWp8Bo5BJajftd60FPl3yek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ky61ftQTj/ZjjxSTX3xLx/GZB+ut6GHVU/337Oab4O+IZZcryfsuGp4lhe+nBn+3n
	 Y5WhUQDxue4Zb314oAbaaZs2qWL9x2asvoxooVtrcReL9Xky9uXusQqHkSlpORe0I+
	 SPZUaJLa4cesiVNOXqf/DTGekoBDRgoSi68+UBPJSJXI0AmNssEl0fRiNTZ6MF+URQ
	 wdlCOS0Ksywl5b7fZzJzEW0M65Gdfe+OD2P2cVjWQUos5dECwmoLrd7PNXtGni1H5R
	 Vu5YSxEVTKPJQomdJFR4149eEKVWs6ZMNHbWGWQ2FL03AViBHWV6NaFa7QJAh2B0pN
	 KGCXRXN8MsFqQ==
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
Subject: [PATCH net-next v4 09/13] net: page_pool: report amount of memory held by page pools
Date: Sun, 26 Nov 2023 15:07:36 -0800
Message-ID: <20231126230740.2148636-10-kuba@kernel.org>
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

Advanced deployments need the ability to check memory use
of various system components. It makes it possible to make informed
decisions about memory allocation and to find regressions and leaks.

Report memory use of page pools. Report both number of references
and bytes held.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v4: extend doc for inflight
---
 Documentation/netlink/specs/netdev.yaml | 15 +++++++++++++++
 include/uapi/linux/netdev.h             |  2 ++
 net/core/page_pool.c                    | 13 +++++++++----
 net/core/page_pool_priv.h               |  2 ++
 net/core/page_pool_user.c               |  8 ++++++++
 5 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 82fbe81f7a49..b76623ff2932 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -114,6 +114,19 @@ name: netdev
         checks:
           min: 1
           max: u32-max
+      -
+        name: inflight
+        type: uint
+        doc: |
+          Number of outstanding references to this page pool (allocated
+          but yet to be freed pages). Allocated pages may be held in
+          socket receive queues, driver receive ring, page pool recycling
+          ring, the page pool cache, etc.
+      -
+        name: inflight-mem
+        type: uint
+        doc: |
+          Amount of memory held by inflight pages.
 
 operations:
   list:
@@ -163,6 +176,8 @@ name: netdev
             - id
             - ifindex
             - napi-id
+            - inflight
+            - inflight-mem
       dump:
         reply: *pp-reply
       config-cond: page-pool
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index beb158872226..26ae5bdd3187 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -68,6 +68,8 @@ enum {
 	NETDEV_A_PAGE_POOL_ID = 1,
 	NETDEV_A_PAGE_POOL_IFINDEX,
 	NETDEV_A_PAGE_POOL_NAPI_ID,
+	NETDEV_A_PAGE_POOL_INFLIGHT,
+	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a8d96ea38d18..566390759294 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -529,7 +529,7 @@ EXPORT_SYMBOL(page_pool_alloc_pages);
  */
 #define _distance(a, b)	(s32)((a) - (b))
 
-static s32 page_pool_inflight(struct page_pool *pool)
+s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 {
 	u32 release_cnt = atomic_read(&pool->pages_state_release_cnt);
 	u32 hold_cnt = READ_ONCE(pool->pages_state_hold_cnt);
@@ -537,8 +537,13 @@ static s32 page_pool_inflight(struct page_pool *pool)
 
 	inflight = _distance(hold_cnt, release_cnt);
 
-	trace_page_pool_release(pool, inflight, hold_cnt, release_cnt);
-	WARN(inflight < 0, "Negative(%d) inflight packet-pages", inflight);
+	if (strict) {
+		trace_page_pool_release(pool, inflight, hold_cnt, release_cnt);
+		WARN(inflight < 0, "Negative(%d) inflight packet-pages",
+		     inflight);
+	} else {
+		inflight = max(0, inflight);
+	}
 
 	return inflight;
 }
@@ -881,7 +886,7 @@ static int page_pool_release(struct page_pool *pool)
 	int inflight;
 
 	page_pool_scrub(pool);
-	inflight = page_pool_inflight(pool);
+	inflight = page_pool_inflight(pool, true);
 	if (!inflight)
 		__page_pool_destroy(pool);
 
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index c17ea092b4ab..72fb21ea1ddc 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -3,6 +3,8 @@
 #ifndef __PAGE_POOL_PRIV_H
 #define __PAGE_POOL_PRIV_H
 
+s32 page_pool_inflight(const struct page_pool *pool, bool strict);
+
 int page_pool_list(struct page_pool *pool);
 void page_pool_unlist(struct page_pool *pool);
 
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 1577fef880c9..2db71e718485 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -110,6 +110,7 @@ static int
 page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		  const struct genl_info *info)
 {
+	size_t inflight, refsz;
 	void *hdr;
 
 	hdr = genlmsg_iput(rsp, info);
@@ -127,6 +128,13 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, pool->user.napi_id))
 		goto err_cancel;
 
+	inflight = page_pool_inflight(pool, false);
+	refsz =	PAGE_SIZE << pool->p.order;
+	if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT, inflight) ||
+	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
+			 inflight * refsz))
+		goto err_cancel;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
-- 
2.42.0


