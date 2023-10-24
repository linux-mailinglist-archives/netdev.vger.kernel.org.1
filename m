Return-Path: <netdev+bounces-43926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE41D7D5747
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B901C20D21
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F763AC3F;
	Tue, 24 Oct 2023 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOs3IGtd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98CC3AC32
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A7DC43391;
	Tue, 24 Oct 2023 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163365;
	bh=uzQHC4rtr5dY32AG4LBKUs1d39g0b0TvSv46i6HRxK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOs3IGtdF6SOoUhEbbjJ8/cRlrmFz4VE+2Zkb2m+4Q6lzBnoXo7FZIbNpZPkzPbQQ
	 Dzzy3rVIxiwcdKaIYbLQIpz1D669msJNCDo6RPxZM8Cep3PMWwmbfYZnbm6LjZU/VV
	 Om/boFGwdgEsA4oRlcWowA5Vw9E/uPns5wwMM/h29dzMIGhRwZ5j89hrjiFoKn3iBl
	 usAyFZNoQhNDbCXMYol4YSgv+YLgpDXNLuqYMjoqTomnTB3yCI2DhHm2rG8shFcoyH
	 XGnkPHvZGN6bJRnxQzTrUaqO2+2H8DqxcUUkSPIzg/kZrIM/KcJfypcggZrYk7K074
	 Lx43vC+2dvuFw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 11/15] net: page_pool: report amount of memory held by page pools
Date: Tue, 24 Oct 2023 09:02:16 -0700
Message-ID: <20231024160220.3973311-12-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024160220.3973311-1-kuba@kernel.org>
References: <20231024160220.3973311-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 13 +++++++++++++
 include/uapi/linux/netdev.h             |  2 ++
 net/core/page_pool.c                    | 13 +++++++++----
 net/core/page_pool_priv.h               |  2 ++
 net/core/page_pool_user.c               |  8 ++++++++
 5 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 2963ff853dd6..8d995760a14a 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -114,6 +114,17 @@ name: netdev
         checks:
           min: 1
           max: u32-max
+      -
+        name: inflight
+        type: uint
+        doc: |
+          Number of outstanding references to this page pool (allocated
+          but yet to be freed pages).
+      -
+        name: inflight-mem
+        type: uint
+        doc: |
+          Amount of memory held by inflight pages.
 
 operations:
   list:
@@ -163,6 +174,8 @@ name: netdev
             - id
             - ifindex
             - napi-id
+            - inflight
+            - inflight-mem
       dump:
         reply: *pp-reply
     -
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
index b3b484fbacae..30c8fc91fa66 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -525,7 +525,7 @@ EXPORT_SYMBOL(page_pool_alloc_pages);
  */
 #define _distance(a, b)	(s32)((a) - (b))
 
-static s32 page_pool_inflight(struct page_pool *pool)
+s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 {
 	u32 release_cnt = atomic_read(&pool->pages_state_release_cnt);
 	u32 hold_cnt = READ_ONCE(pool->pages_state_hold_cnt);
@@ -533,8 +533,13 @@ static s32 page_pool_inflight(struct page_pool *pool)
 
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
@@ -877,7 +882,7 @@ static int page_pool_release(struct page_pool *pool)
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
index 0c7f065907d9..c971fe9eeb01 100644
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
2.41.0


