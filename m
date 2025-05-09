Return-Path: <netdev+bounces-189200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9FCAB1287
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0DB3B9271
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8E928FFDF;
	Fri,  9 May 2025 11:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9935828F95E;
	Fri,  9 May 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791504; cv=none; b=G0LvArfoDnp2xChziuQ214t2ZVxWgMXzYXJNdTAcqZd2w9Ov5/big7m/ucogmuFTQ+K0h+xPyCu1Fh0iBsD7G1x66xfElfeSjKbqCINZqk3PGhufu2hubPvHnADd2PZr+tUqMyCvFF2D7lWhgfJZzU5IRVC+ffrsFMx/qRlrJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791504; c=relaxed/simple;
	bh=gRcToev8ITqpNNNz/rVPb36ZaDdlnPkMef4UC4TXKSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eLKp+kjRTNMEBgnxcI7uWXUvDMnS9Q0S8mh0d4nKiW4ke9WPg0qn14m1QWCeMNabMJhZ2pFSOfnxBgSP62UjIllOnQUcpMuqE8MMOYdPpr3hPxb4mv2+ZnIgQqe+wr0TrQaIWcX+HMMwcvqv1RgtT1hCCebhsYaExnhN2MqKkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-3e-681dec496f14
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
Subject: [RFC 04/19] page_pool: rename __page_pool_alloc_page_order() to __page_pool_alloc_large_netmem()
Date: Fri,  9 May 2025 20:51:11 +0900
Message-Id: <20250509115126.63190-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnka7nG9kMg3sLRCzmrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgyej5KF6zlrDjw7j5zA+Mb9i5GTg4JAROJtZtfsMHY7yf1MYLYbALqEjdu/GQGsUUE
	DCU+PzrO0sXIxcEssJBZ4srin2DNwgKZEktuLQFrZhFQlXi0bT2YzStgKrGi/yYTxFB5idUb
	DgAN4uDgFDCT6P+oDhIWAipZNmUBG8hMCYH/bBJTO5awQNRLShxccYNlAiPvAkaGVYxCmXll
	uYmZOSZ6GZV5mRV6yfm5mxiBMbCs9k/0DsZPF4IPMQpwMCrx8Fo8l80QYk0sK67MPcQowcGs
	JML7vFMmQ4g3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVANj
	yGf9koJz3woLPN5kubRNlP5sKzNH+2ppIoPTpispc0u6ZiQ4rixN4Xky+e5D/x32WZvOT9or
	Lv/oln9o8+6nf15prLAU5tyn/HvLvJzugrSn5ssTZyrMe2d0cIbL5Hm72K/p3ruzJ6Q6N3nC
	fuWJtR9WKe99qR7/4/hn/QmL5c40vNx5o+XPSSWW4oxEQy3mouJEAAE+uah9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXC5WfdrOv5RjbD4ORODos569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK6Pno3TBWs6KA+/uMzcwvmHvYuTkkBAwkXg/qY8RxGYTUJe4ceMn
	M4gtImAo8fnRcZYuRi4OZoGFzBJXFv8EaxAWyJRYcmsJG4jNIqAq8WjbejCbV8BUYkX/TSaI
	ofISqzccABrEwcEpYCbR/1EdJCwEVLJsygK2CYxcCxgZVjGKZOaV5SZm5pjqFWdnVOZlVugl
	5+duYgQG9LLaPxN3MH657H6IUYCDUYmH1+K5bIYQa2JZcWXuIUYJDmYlEd7nnTIZQrwpiZVV
	qUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYyC673nR3iypd/h1Kwz
	2754d8S7ZoaoC7ciDf2/sGWox2x6cu+lU+emm2K/j5zave4Sr0+DfY7EO0mv/Rk6juY3Dlh5
	dqlsWMuoIfTouvq1Oz2GLFkezx+2NX56daP/93vNvwuLFi1wFNiucuRCx9XfDzg4w3Z9Wbou
	Q77RR/Bbq9ekDPujj6YosRRnJBpqMRcVJwIAwB70d2QCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Now that __page_pool_alloc_page_order() uses netmem alloc/put API, not
page alloc/put API, rename it to __page_pool_alloc_large_netmem() to
reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9f5e07a15f707..c03caa11fc606 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -498,7 +498,7 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	return false;
 }
 
-static netmem_ref __page_pool_alloc_page_order(struct page_pool *pool,
+static netmem_ref __page_pool_alloc_large_netmem(struct page_pool *pool,
 						 gfp_t gfp)
 {
 	netmem_ref netmem;
@@ -535,7 +535,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
-		return __page_pool_alloc_page_order(pool, gfp);
+		return __page_pool_alloc_large_netmem(pool, gfp);
 
 	/* Unnecessary as alloc cache is empty, but guarantees zero count */
 	if (unlikely(pool->alloc.count > 0))
-- 
2.17.1


