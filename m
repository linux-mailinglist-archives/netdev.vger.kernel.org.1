Return-Path: <netdev+bounces-189209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108C5AB129A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C499AA04DBE
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC922918C8;
	Fri,  9 May 2025 11:51:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8370828FAA8;
	Fri,  9 May 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791507; cv=none; b=Hsj+jpDwJnCEwSd+vk7cdtQ4xo4d25xS/N6x7ntmDUP8KpaXD/eHnyKVRVV3wdwckV+hriuOgHX8BujeMPWoQoWDooZWu02N/9TwHrisklG5VBcR3V4F0G3npb4h7+K0bCTcv/YS+mZjwAY2AMqFnLJ0wIGZX3ixkFc5wXUwJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791507; c=relaxed/simple;
	bh=cVoQg6VLoUphUFismE0rH5IYGlskFI/Je6TNOOVwkqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CmQRVjLtKisQDzlRrC3rXP8aCpmbNDnf3qIyXBnek7R/Eoq0RyU7hQUiZNqo+QFWvzQcKbqyjUZutoWExr1jlp9PSEB5cCoxvb/GJk1JSZTXGOqsEfKykA1RVAIyJVxa8GbRmoutTrqjokjHPWeZXjGXioxfiLsbEtnoZzEfVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-5c-681dec495ced
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
Subject: [RFC 09/19] page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
Date: Fri,  9 May 2025 20:51:16 +0900
Message-Id: <20250509115126.63190-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnka7nG9kMgxNbVS3mrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgyHi1ewFjQJVAxd8d61gbGGbxdjJwcEgImEn+eLGLtYuQAs/unK4GE2QTUJW7c+MkM
	YosIGEp8fnScpYuRi4NZYCGzxJXFP9lBEsICkRK73p0Hs1kEVCXmLbrCCmLzCphJvNkymwVi
	vrzE6g0HmEHmcwLF+z+qg4SFBEwllk1ZwAYyU0KgmV3i5JQFjBD1khIHV9xgmcDIu4CRYRWj
	UGZeWW5iZo6JXkZlXmaFXnJ+7iZGYAwsq/0TvYPx04XgQ4wCHIxKPLwWz2UzhFgTy4orcw8x
	SnAwK4nwPu+UyRDiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TB
	KdXAWLtd3F1OJtP9pxjvD+0PZu3b+868TJslsDLHusr8n3MO08K2i3LqIVeCqqfoe6yfonOg
	K/CtyY0/7TI8bT/84j5/l3I5lNGWaen8XlDl2/euNB6lrNJXvy05TVtvPL/yv/em+d2aE0zL
	Pna7Tt/TfMdI4OmJgyUm8pfm/hB9qXucKyDR+dEJJZbijERDLeai4kQAy4ET9n0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXC5WfdrOv5RjbD4MQ/cYs569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK+PR4gWMBV0CFXN3rGdtYJzB28XIwSEhYCLRP12pi5GTg01AXeLG
	jZ/MILaIgKHE50fHWboYuTiYBRYyS1xZ/JMdJCEsECmx6915MJtFQFVi3qIrrCA2r4CZxJst
	s1lAbAkBeYnVGw4wg8znBIr3f1QHCQsJmEosm7KAbQIj1wJGhlWMIpl5ZbmJmTmmesXZGZV5
	mRV6yfm5mxiBAb2s9s/EHYxfLrsfYhTgYFTi4bV4LpshxJpYVlyZe4hRgoNZSYT3eadMhhBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVAOj6vr0/LK0BRe/
	iOUuqO84M11OZ529OM8E/R+/Vh1jZm2+EyAUI9HD+eG/w7kv67Qthd2LbBl+bnTpyztS2Mt4
	NbhKr7g4M5XtfVFMY7L7O6nfO6Unx21Ycvh99MOkudHmqZwP166bfEVEUj1xNkPVm4idvasX
	KOQkxnSG+7kfr9+s87nwSZ4SS3FGoqEWc1FxIgCHxaVyZAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Now that __page_pool_put_page() puts netmem, not struct page, rename it
to __page_pool_put_netmem() to reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 47164d561d1aa..f858a5518b7a4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -755,7 +755,7 @@ static bool __page_pool_page_can_be_recycled(netmem_ref netmem)
  * subsystem.
  */
 static __always_inline netmem_ref
-__page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
+__page_pool_put_netmem(struct page_pool *pool, netmem_ref netmem,
 		     unsigned int dma_sync_size, bool allow_direct)
 {
 	lockdep_assert_no_hardirq();
@@ -811,7 +811,7 @@ static bool page_pool_napi_local(const struct page_pool *pool)
 	/* Allow direct recycle if we have reasons to believe that we are
 	 * in the same context as the consumer would run, so there's
 	 * no possible race.
-	 * __page_pool_put_page() makes sure we're not in hardirq context
+	 * __page_pool_put_netmem() makes sure we're not in hardirq context
 	 * and interrupts are enabled prior to accessing the cache.
 	 */
 	cpuid = smp_processor_id();
@@ -830,7 +830,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 		allow_direct = page_pool_napi_local(pool);
 
 	netmem =
-		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
+		__page_pool_put_netmem(pool, netmem, dma_sync_size, allow_direct);
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
@@ -931,7 +931,7 @@ void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
 				continue;
 			}
 
-			netmem = __page_pool_put_page(pool, netmem, -1,
+			netmem = __page_pool_put_netmem(pool, netmem, -1,
 						      allow_direct);
 			/* Approved for bulk recycling in ptr_ring cache */
 			if (netmem)
-- 
2.17.1


