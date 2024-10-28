Return-Path: <netdev+bounces-139533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7CE9B2F8E
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2552283524
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760441DD0F2;
	Mon, 28 Oct 2024 12:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233E1DC194;
	Mon, 28 Oct 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116824; cv=none; b=Sk9ThmysfmFxEl3IHa60CRcsayX8LTUEuEm0Tn5uBNsFtR6jZuXZDaa29/Mf70XLChN/6Yr4FlK0mbK7hwvY9yIZUS9IHXfN/ygercj1hmIVKWtwtIHzOKLIt/Khr+2Q0+spjVwRRcgCb8qtrKGvlIIZ8UlgfvTbaNq0AIUa0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116824; c=relaxed/simple;
	bh=HXpOkMA5++mVA8E8X2LKjjNPNFx9tyKamSgLeJ7QUIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDpAp/6ZHBDkzLBhz/CvoZ0NUX4r6VoeFRvhsvr3R+fUjcjLSRB3+1Iz1ee2oY+zPZncy7UCrwjTfBUmYiVKEJS5MuB/P0bk9wSwpRaTs6/pH+GqNu7r/zezvrrkcxIbVH4g0aqR0O6QOQJYueJLih+u+ONQgwz6tPTDq465zVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XcX5Q5TTFz1ynk7;
	Mon, 28 Oct 2024 20:00:26 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 785E4140155;
	Mon, 28 Oct 2024 20:00:18 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 20:00:18 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Alexander
 Duyck <alexanderduyck@fb.com>
Subject: [PATCH net-next v23 7/7] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
Date: Mon, 28 Oct 2024 19:53:42 +0800
Message-ID: <20241028115343.3405838-8-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241028115343.3405838-1-linyunsheng@huawei.com>
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

It seems there is about 24Bytes binary size increase for
__page_frag_cache_refill() after refactoring in arm64 system
with 64K PAGE_SIZE. By doing the gdb disassembling, It seems
we can have more than 100Bytes decrease for the binary size
by using __alloc_pages() to replace alloc_pages_node(), as
there seems to be some unnecessary checking for nid being
NUMA_NO_NODE, especially when page_frag is part of the mm
system.

CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linux-MM <linux-mm@kvack.org>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 mm/page_frag_cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index a36fd09bf275..3f7a203d35c6 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -56,11 +56,11 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
-	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
-				PAGE_FRAG_CACHE_MAX_ORDER);
+	page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
+			     numa_mem_id(), NULL);
 #endif
 	if (unlikely(!page)) {
-		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+		page = __alloc_pages(gfp, 0, numa_mem_id(), NULL);
 		order = 0;
 	}
 
-- 
2.33.0


