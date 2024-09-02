Return-Path: <netdev+bounces-124190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D496873A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579361C2326D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2717D2139CD;
	Mon,  2 Sep 2024 12:09:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763442101B5;
	Mon,  2 Sep 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278964; cv=none; b=k+2hSF/oY6rVCp3UYsA+RgGBWV0do4BJWY7GBLV5F/abN7kbH+ItyQemAEa2ez82uhTa1zCFvdigPlL4Q32Y+BabWftxaYRPlXfIz0Inq61vXP1J+Ez5OyCxGTV+8OYO/RJ9EhXNDksuIcsiGTWCJHFsSeSsB8gG9gR9/kR7VB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278964; c=relaxed/simple;
	bh=wZQRQlgNa1jaOJGDYwKvIVsfrdxfy3TfX6WSG2Qql08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n54+JNmzIeMaf1vtm51REj+yq4cpb/Wl/tHmcFs67x++R/sz9xfd9V0K0tBFBduBmc7VcRjhpNg3ILB9uFxmX+zdBVABliQqJVgNhFMK5vv7voeoJkIhv/KATKtSXB9WaMCPzhAXoE2TNZBSRnT/RAu2hd6OGLtXME3Ncf9ny6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wy6wT4GF1z18Mmp;
	Mon,  2 Sep 2024 20:08:25 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E2131800FE;
	Mon,  2 Sep 2024 20:09:20 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 20:09:20 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v17 08/14] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
Date: Mon, 2 Sep 2024 20:03:07 +0800
Message-ID: <20240902120314.508180-9-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240902120314.508180-1-linyunsheng@huawei.com>
References: <20240902120314.508180-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 mm/page_frag_cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 62d8cf33f27a..994b85e7df67 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -40,11 +40,11 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
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
 			nc->encoded_page = 0;
 			return NULL;
-- 
2.33.0


