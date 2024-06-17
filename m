Return-Path: <netdev+bounces-104035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419D090AF04
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0AF28F853
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA75A19A2A2;
	Mon, 17 Jun 2024 13:17:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8ED19A285;
	Mon, 17 Jun 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630268; cv=none; b=JVbthe+R35gpzdqmGxZEESAlvlYqU3q2WrlAker4fcv8Pu2aRH8ho1H1fIpQgybGxq1Y/tnqCIFpMlW4N/Lcngi2rQDpPeINGJt1tyRuAYCw8OwK8PU5LVCeZi+eZtyToSL54koqJhpXjRI7QUwredr/2HToFFMqwZfzB5ij5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630268; c=relaxed/simple;
	bh=vG+NpuVV7lfnxiDGJuSffWNOo2DgSZMYUuJi2QLLHj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TewAUlpf6f4OiFIt8RbH36IRB5gY45txZYuHQljXBrHraIWCwgOJqeV9dB2OfK7/OU8nKPiKFfU4NpgI8Em1rfMtYdVLah/7F1pRw6sSE93b+jm6tkOoXhfjZAIRddpyPwuZKsXfYTKBUjmWZUP3vE7F6L5ZYAeHa+4c4akWLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W2r0J6db9znW17;
	Mon, 17 Jun 2024 21:12:48 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 83FA51402CA;
	Mon, 17 Jun 2024 21:17:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Jun 2024 21:17:40 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v8 08/13] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
Date: Mon, 17 Jun 2024 21:14:07 +0800
Message-ID: <20240617131413.25189-9-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240617131413.25189-1-linyunsheng@huawei.com>
References: <20240617131413.25189-1-linyunsheng@huawei.com>
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

There are more new APIs calling __page_frag_cache_refill() in
this patchset, which may cause compiler not being able to inline
__page_frag_cache_refill() into __page_frag_alloc_va_align().

Not being able to do the inlining seems to casue some notiable
performance degradation in arm64 system with 64K PAGE_SIZE after
adding new API calling __page_frag_cache_refill().

It seems there is about 24Bytes binary size increase for
__page_frag_cache_refill() and __page_frag_cache_refill() in
arm64 system with 64K PAGE_SIZE. By doing the gdb disassembling,
It seems we can have more than 100Bytes decrease for the binary
size by using __alloc_pages() to replace alloc_pages_node(), as
there seems to be some unnecessary checking for nid being
NUMA_NO_NODE, especially when page_frag is still part of the mm
system.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 mm/page_frag_cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 4fd421d4f22c..58facd2b59f7 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -62,11 +62,11 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
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
 		if (unlikely(!page)) {
 			memset(nc, 0, sizeof(*nc));
 			return NULL;
-- 
2.33.0


