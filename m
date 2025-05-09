Return-Path: <netdev+bounces-189204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8401AB1288
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014CB4A4EA6
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9128FABC;
	Fri,  9 May 2025 11:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E6B28FAA7;
	Fri,  9 May 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791504; cv=none; b=UBO3CYaGplxFSVyxRnBwKQEHoo77xt2SgeZyLDixUBaq8W95tj+g/2I+89/bO4Xkvwpeya4F2K+tCAOzmuIi5eLvUl/vALud1QPKhleEdfay5BGe/SDqN6V4v7ZsdD6wdDDWs6tyl3/JjPQNBA1hjDj0M9QJ7FYUEkyRwFVj/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791504; c=relaxed/simple;
	bh=NvxFm06XQPMr5ZW9JmyqSkOq3f4umYXIgqYFpOzJOOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NRyBH/S83pz33fv4KkGqkURrkzZWnshAolElJadW1/mhGwqufc7T7kCnp4pcKhTQEdGfysmDmW/rmGjFQmB7mFv1t8NF4SyHmkZuVvQ8ioxN51fGhoCWUbYdMy+hZbmcL1MHLe41sWUDaCmG9U3Q0wAeAXqvqjOjM7AdoRHaZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-44-681dec49fa7f
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: [RFC 05/19] page_pool: use netmem alloc/put API in __page_pool_alloc_pages_slow()
Date: Fri,  9 May 2025 20:51:12 +0900
Message-Id: <20250509115126.63190-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnoa7nG9kMgwlvRC3mrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgy/q1ZxVKwT6Ti8s3FbA2MZwS6GDk5JARMJG7dbmKCsR++38QKYrMJqEvcuPGTGcQW
	ETCU+PzoOEsXIxcHs8BCZokri3+ygySEBaIkvh/7D9bMIqAqsehSA1icV8BUYvOBy6wQQ+Ul
	Vm84ADSIg4NTwEyi/6M6SFgIqGTZlAVsIDMlBP6zSUzaeJYRol5S4uCKGywTGHkXMDKsYhTK
	zCvLTczMMdHLqMzLrNBLzs/dxAiMgmW1f6J3MH66EHyIUYCDUYmH1+K5bIYQa2JZcWXuIUYJ
	DmYlEd7nnTIZQrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODil
	GhibZdZLsfFFMNzx9K/5KN2244/KEi9vsSlTfP/wzFpgL8TeVflMJeJt1t4TV6sd2o4G8/e/
	vCiUrWyZOVHo2WmZfuXAtycaz94/fCkiNKtJu85l1ovYh++a2Dl5M938M5tZ2bV/Vp4ScQ9L
	9L69aq3vmgnqyyN2rDbi/PxV92i4irvhxugVa5RYijMSDbWYi4oTAWaa+r5+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC5WfdrOv5RjbD4NYzHos569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK+PfmlUsBftEKi7fXMzWwHhGoIuRk0NCwETi4ftNrCA2m4C6xI0b
	P5lBbBEBQ4nPj46zdDFycTALLGSWuLL4JztIQlggSuL7sf9MIDaLgKrEoksNYHFeAVOJzQcu
	s0IMlZdYveEA0CAODk4BM4n+j+ogYSGgkmVTFrBNYORawMiwilEkM68sNzEzx1SvODujMi+z
	Qi85P3cTIzCkl9X+mbiD8ctl90OMAhyMSjy8Fs9lM4RYE8uKK3MPMUpwMCuJ8D7vlMkQ4k1J
	rKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYJwUEpsmcfZm1Jq7
	R2ZMNvyRWqAmpC11cdvBAmexqvWivfY+R5x6AyOaktoLN1QlPmzqMIsUPLPickr39BN8W8/t
	UTjO93s9z46CP7axeYYLGsR5pOxD1SpS1C/VPtab80Pp/sFU/U1MzgYXhH862+05uc5959J9
	5x6pH9GUXf542g5Ovssp25RYijMSDbWYi4oTARRwE2xlAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Use netmem alloc/put API instead of page alloc/put API in
__page_pool_alloc_pages_slow().

While at it, improved some comments.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index c03caa11fc606..57ad133e6dc8c 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -531,7 +531,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	unsigned int pp_order = pool->p.order;
 	bool dma_map = pool->dma_map;
 	netmem_ref netmem;
-	int i, nr_pages;
+	int i, nr_netmems;
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
@@ -541,21 +541,21 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	if (unlikely(pool->alloc.count > 0))
 		return pool->alloc.cache[--pool->alloc.count];
 
-	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk */
+	/* Mark empty alloc.cache slots "empty" for alloc_netmems_bulk_node() */
 	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
 
-	nr_pages = alloc_pages_bulk_node(gfp, pool->p.nid, bulk,
-					 (struct page **)pool->alloc.cache);
-	if (unlikely(!nr_pages))
+	nr_netmems = alloc_netmems_bulk_node(gfp, pool->p.nid, bulk,
+					   pool->alloc.cache);
+	if (unlikely(!nr_netmems))
 		return 0;
 
-	/* Pages have been filled into alloc.cache array, but count is zero and
-	 * page element have not been (possibly) DMA mapped.
+	/* Netmems have been filled into alloc.cache array, but count is
+	 * zero and elements have not been (possibly) DMA mapped.
 	 */
-	for (i = 0; i < nr_pages; i++) {
+	for (i = 0; i < nr_netmems; i++) {
 		netmem = pool->alloc.cache[i];
 		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
-			put_page(netmem_to_page(netmem));
+			put_netmem(netmem);
 			continue;
 		}
 
@@ -567,7 +567,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 					   pool->pages_state_hold_cnt);
 	}
 
-	/* Return last page */
+	/* Return the last netmem */
 	if (likely(pool->alloc.count > 0)) {
 		netmem = pool->alloc.cache[--pool->alloc.count];
 		alloc_stat_inc(pool, slow);
@@ -575,7 +575,8 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 		netmem = 0;
 	}
 
-	/* When page just alloc'ed is should/must have refcnt 1. */
+	/* When a netmem has been just allocated, it should/must have
+	 * refcnt 1. */
 	return netmem;
 }
 
-- 
2.17.1


