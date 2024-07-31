Return-Path: <netdev+bounces-114580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3138942F41
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF401F2AC52
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D84A1BB698;
	Wed, 31 Jul 2024 12:51:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5F1BA899;
	Wed, 31 Jul 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430263; cv=none; b=uofYGt/DqQAltI0HvsEphbTcGkx9RjaCwB9wnHoLJPyMNlO/jN7W9O3td9P5VG6W2LO107ThhBN9ri9cplpgGnAKCxyje54el5EoJs6vRiFNgnM4SExPHWEz3n0gPqp6NFrWFVQPfdT+rtKD9DnTAPxABlIdGOi6n/VspElX0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430263; c=relaxed/simple;
	bh=jDuVyCWta/idaAgYBEfQvZQEjbm4A7Ks7WBdHt98pL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJuspdtdXp6+7F4dKE2ggWIiakqYpbpNcnsJMYJqvDA1bqqswGRzxe/KSzQGrkRpHchhq5rG3+hLey3UtE1bhG1M3Cxf1VWCsjrvgmHkaX/DcnKA4ngPgfffMCUenY8kidWXGXqJHSQjZm5OiBx0MljYLicYFoLJO6Ow31lLELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WYsQc3847zxW1g;
	Wed, 31 Jul 2024 20:50:48 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2933C180AE3;
	Wed, 31 Jul 2024 20:51:00 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 31 Jul 2024 20:50:59 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v12 09/14] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
Date: Wed, 31 Jul 2024 20:44:59 +0800
Message-ID: <20240731124505.2903877-10-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240731124505.2903877-1-linyunsheng@huawei.com>
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
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

Not being able to do the inlining seems to cause some notiable
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
index aa6eef55bb9c..a24d6d5278d1 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -48,11 +48,11 @@ static bool __page_frag_cache_refill(struct page_frag_cache *nc,
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
 			return false;
-- 
2.33.0


