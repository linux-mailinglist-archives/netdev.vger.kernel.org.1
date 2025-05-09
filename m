Return-Path: <netdev+bounces-189206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39656AB1291
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F82C4A546E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B1D291171;
	Fri,  9 May 2025 11:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7E828FA9F;
	Fri,  9 May 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791504; cv=none; b=N44R7r83qmiikHrtZWvHbGAtHYgKX4UrJHp8BGI299h2WvObCgFDvNgsC+ckFOXfss+9J5LntYEe7IahQvLRejjK3ejaTr7gZH9XtinTIZXNjWsCZmzGvVyjy6hfZJOHhxlGIV2vIoEcuVgSbmK0+dzmFnKp4IYYpu5wXa+IJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791504; c=relaxed/simple;
	bh=AfghNN/wTX/92J/6suI/Y/6yoO250NFXx+K8SJzJryk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bMhnNN2GmcyPEtMPsdk8abnGhgrQinJhrvvuMI36cjceQwZ0HbXj1wUJxIjfcAQj9ypAEvXZQ4ISEgzrDqwt229HhRyVTdQlo0I7SDxjnNcB4V3iun3W93/VvUheRrprH6qNjKxZbl/CTkykNdKn8BMEUIu00JwB+qeU7bpuvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-38-681dec495411
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
Subject: [RFC 03/19] page_pool: use netmem alloc/put API in __page_pool_alloc_page_order()
Date: Fri,  9 May 2025 20:51:10 +0900
Message-Id: <20250509115126.63190-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoa7nG9kMg+Pz+SzmrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgy5nXLFVwXqOhq7WNtYPzK28XIySEhYCLxtn8BI4y9+GAfC4jNJqAucePGT2YQW0TA
	UOLzo+NAcS4OZoGFzBJXFv9k72Lk4BAWiJLY05AKYrIIqErM/S0BUs4rYCrxaMUHJoiR8hKr
	NxxgBinhFDCT6P+oDhIWAipZNmUBG8hECYHfbBKLn3WxQ9RLShxccYNlAiPvAkaGVYxCmXll
	uYmZOSZ6GZV5mRV6yfm5mxiB4b+s9k/0DsZPF4IPMQpwMCrx8Fo8l80QYk0sK67MPcQowcGs
	JML7vFMmQ4g3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAMj
	/9api2/dbyr88H+mutBp2U7WR5Kdy+If1Ja1ti42PVBcLf/mYu5lf5+lKxpmxqc8XRhkf5Xf
	xflrXMjcd7ZV/W8aJk8Q/RMXsDul6vB8BfXFwft8Pv093cUwWWr3kfe2py6GOv2zCzrArDp3
	rlj1xBWH7Nserwr2XjVbbZ6TH+/hmP7Lmp2eSizFGYmGWsxFxYkA7TKgs3sCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsXC5WfdrOv5RjbD4OMfZos569ewWaz+UWGx
	/MEOVosvP2+zWyxe+A0ofr6FxeLpsUfsFveXPWOx2NO+ndmit+U3s0XTjhVMFofnnmS1uLCt
	j9Xi8q45bBb31vxntTi2QMzi2+k3jBbr991gtfj9Yw6bg7DHlpU3mTx2zrrL7rFgU6nH5hVa
	Hl03LjF7bFrVyeax6dMkdo871/aweZyY8ZvFY+eOz0weH5/eYvF4v+8qm8fiFx+YPD5vkgvg
	i+KySUnNySxLLdK3S+DKmNctV3BdoKKrtY+1gfErbxcjJ4eEgInE4oN9LCA2m4C6xI0bP5lB
	bBEBQ4nPj44Dxbk4mAUWMktcWfyTvYuRg0NYIEpiT0MqiMkioCox97cESDmvgKnEoxUfmCBG
	ykus3nCAGaSEU8BMov+jOkhYCKhk2ZQFbBMYuRYwMqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P
	3cQIDOZltX8m7mD8ctn9EKMAB6MSD6/Fc9kMIdbEsuLK3EOMEhzMSiK8zztlMoR4UxIrq1KL
	8uOLSnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYJzeo6l5kX37GX2bH8+U5
	W6ITO49EqHzesGnGss+vTqnLaYnO357740/Zr10xSzmaX07gXt159pzMymTrODb2h60lUV/d
	1kUfNXwt5Rfz59GWLzq3lb37bxj2TNzYsNTwwcVrceKfnph/YU+IuhLWdaaxItWEqV/z+IMH
	LzbduSfgXszyQVQvRomlOCPRUIu5qDgRAKiZ4UZiAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Use netmem alloc/put API instead of page alloc/put API and make it
return netmem_ref instead of struct page * in
__page_pool_alloc_page_order().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 575fdab337414..9f5e07a15f707 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -498,29 +498,29 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	return false;
 }
 
-static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
+static netmem_ref __page_pool_alloc_page_order(struct page_pool *pool,
 						 gfp_t gfp)
 {
-	struct page *page;
+	netmem_ref netmem;
 
 	gfp |= __GFP_COMP;
-	page = alloc_pages_node(pool->p.nid, gfp, pool->p.order);
-	if (unlikely(!page))
-		return NULL;
+	netmem = alloc_netmems_node(pool->p.nid, gfp, pool->p.order);
+	if (unlikely(!netmem))
+		return 0;
 
-	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page)))) {
-		put_page(page);
-		return NULL;
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
+		put_netmem(netmem);
+		return 0;
 	}
 
 	alloc_stat_inc(pool, slow_high_order);
-	page_pool_set_pp_info(pool, page_to_netmem(page));
+	page_pool_set_pp_info(pool, netmem);
 
 	/* Track how many pages are held 'in-flight' */
 	pool->pages_state_hold_cnt++;
-	trace_page_pool_state_hold(pool, page_to_netmem(page),
+	trace_page_pool_state_hold(pool, netmem,
 				   pool->pages_state_hold_cnt);
-	return page;
+	return netmem;
 }
 
 /* slow path */
@@ -535,7 +535,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
-		return page_to_netmem(__page_pool_alloc_page_order(pool, gfp));
+		return __page_pool_alloc_page_order(pool, gfp);
 
 	/* Unnecessary as alloc cache is empty, but guarantees zero count */
 	if (unlikely(pool->alloc.count > 0))
-- 
2.17.1


