Return-Path: <netdev+bounces-130751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B3D98B657
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27E7282CB3
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1D11BE866;
	Tue,  1 Oct 2024 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOivs9YV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9C1BE226;
	Tue,  1 Oct 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769567; cv=none; b=R+J6MbbaTi/gUrwLAMKuGGvUH+KyTj59c7fl5MCB8WG6BcGruKEK3imJFbpyQ4ak0VvPdIcu0w+B0StH3PguHle/iVHTIQCvDtYWFV9vvyZM4DgdiHQxIRqkRERPGB0ryd3IjEB5GeIf/pSz2DGjqzPChS6LqDlHmnr/7yDwfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769567; c=relaxed/simple;
	bh=UDY2Xjo48piYHKG82PIWe9HXrv7cuPypmF3vaFHwxNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5v0QWaKB1ZhZHw4gWsWggiy+Mp11ggisIFb4a2axd65eDPjpo2FImcYwAb+YRp5Oj8X8duXJceRRFh0u0XpXFEXCPNYwM4gCk4gukiiHTJYkhBuGoxz1ZlaUjlAZlaQIPh1YNVoAb77xWjU4hvrDEdV/jgY4O3qvwAn5VS0n7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOivs9YV; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e0b0142bbfso3267341a91.1;
        Tue, 01 Oct 2024 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727769565; x=1728374365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYCVdOudHYSEPLdfqa+bP8zA1NgdXBDfEGsBksPcr7U=;
        b=SOivs9YVDVhB6YcIdXBJQvXjv575YJVmZO6wFv2lWmqsgqxEWWlmy05DTGay8+nTx7
         SMCjaGXjpROZHJsf5Ct2AwftW1a/3YdGK1TnaCNMhJbBpVQssCdojaXbKiRY8MrLqJTF
         iptGu4tVIWoPOjMOuwjEGAfQvajwNzI4MAHu8C+0O3314fg9ff9YnPvzgAaE86thqYbJ
         vOU7lo+j4hk0kqLnYECea7KuXNZ997PtjxfvxFRMVzJNihXtom8hoLoL/dAtQoCNv07/
         TDYIGH0c3CQOYEcAoBnoJu+x1yyaJguBDkqVS5LriHYDednMgYFyFrTSBOcMMrwJbKm+
         Yk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727769565; x=1728374365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYCVdOudHYSEPLdfqa+bP8zA1NgdXBDfEGsBksPcr7U=;
        b=dFWQnclmPita0q9in29gzIzdfJDrgPg07k6NiiqBNjfSSBRcXjgt2cyeVx3tobbWnf
         aey7g9Id6xMnCxYJNUx7ynAo+XebjKXb4a+Ta+UGKUkXUsyMWW2Zk5I1nLmwIFVrN6g+
         McpPEaH9D7dIhsWeBRjqwGk9wTU47xpJQcqU6gXCQv6aJOU3LbppJ4RZTxpwZWK5oGuA
         IT4Jkl3PUfNncYby/xnaAk0m8Zp7A0haP6kNOmcsAPp/g8ylOBNZ5mrOTs8QUAzcGGWC
         Zht0d+Xd7NepgBTASOr463zzUhH8LMc5ao9a8XIEMgP1n036cGT9qdqBJ42P/atlgDav
         dNXg==
X-Forwarded-Encrypted: i=1; AJvYcCWQYSJd+PaTtmiXM1NNQNb7gfcXtHf5xFNDdJoR3jE59Lf02YEUQD7gVo5zy79M3KqE4nfen53IdDJBk8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKeh7bkyf+49ujTPCPoi39HzGH9Ax1zb5cYlXrGHqfYySJHwWI
	WeXPRi8c9Ahe993kh/F4IqnJoCpZopnd9LODc8dSextuJeaPX25i
X-Google-Smtp-Source: AGHT+IGyubSkW0LS2Q/mlw0qfA+FvSuoj1p26auGSTL84vixBHJ3lx7Y9nlk/IPOdCecjBEq2pxNbw==
X-Received: by 2002:a17:90b:4d04:b0:2e0:a9e8:bb95 with SMTP id 98e67ed59e1d1-2e15a19ec2dmr3403921a91.3.1727769564970;
        Tue, 01 Oct 2024 00:59:24 -0700 (PDT)
Received: from yunshenglin-MS-7549.. ([2409:8a55:301b:e120:88bd:a0fb:c6d6:c4a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16d6d2sm13168168a91.2.2024.10.01.00.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:59:24 -0700 (PDT)
From: Yunsheng Lin <yunshenglin0825@gmail.com>
X-Google-Original-From: Yunsheng Lin <linyunsheng@huawei.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: [PATCH net-next v19 03/14] mm: page_frag: use initial zero offset for page_frag_alloc_align()
Date: Tue,  1 Oct 2024 15:58:46 +0800
Message-Id: <20241001075858.48936-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001075858.48936-1-linyunsheng@huawei.com>
References: <20241001075858.48936-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are about to use page_frag_alloc_*() API to not just
allocate memory for skb->data, but also use them to do
the memory allocation for skb frag too. Currently the
implementation of page_frag in mm subsystem is running
the offset as a countdown rather than count-up value,
there may have several advantages to that as mentioned
in [1], but it may have some disadvantages, for example,
it may disable skb frag coalescing and more correct cache
prefetching

We have a trade-off to make in order to have a unified
implementation and API for page_frag, so use a initial zero
offset in this patch, and the following patch will try to
make some optimization to avoid the disadvantages as much
as possible.

1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com/

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 mm/page_frag_cache.c | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 609a485cd02a..4c8e04379cb3 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -63,9 +63,13 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			      unsigned int fragsz, gfp_t gfp_mask,
 			      unsigned int align_mask)
 {
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	unsigned int size = nc->size;
+#else
 	unsigned int size = PAGE_SIZE;
+#endif
+	unsigned int offset;
 	struct page *page;
-	int offset;
 
 	if (unlikely(!nc->va)) {
 refill:
@@ -85,11 +89,24 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = size;
+		nc->offset = 0;
 	}
 
-	offset = nc->offset - fragsz;
-	if (unlikely(offset < 0)) {
+	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
+	if (unlikely(offset + fragsz > size)) {
+		if (unlikely(fragsz > PAGE_SIZE)) {
+			/*
+			 * The caller is trying to allocate a fragment
+			 * with fragsz > PAGE_SIZE but the cache isn't big
+			 * enough to satisfy the request, this may
+			 * happen in low memory conditions.
+			 * We don't release the cache page because
+			 * it could make memory pressure worse
+			 * so we simply return NULL here.
+			 */
+			return NULL;
+		}
+
 		page = virt_to_page(nc->va);
 
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
@@ -100,33 +117,16 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			goto refill;
 		}
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
 		/* OK, page count is 0, we can safely set it */
 		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		offset = size - fragsz;
-		if (unlikely(offset < 0)) {
-			/*
-			 * The caller is trying to allocate a fragment
-			 * with fragsz > PAGE_SIZE but the cache isn't big
-			 * enough to satisfy the request, this may
-			 * happen in low memory conditions.
-			 * We don't release the cache page because
-			 * it could make memory pressure worse
-			 * so we simply return NULL here.
-			 */
-			return NULL;
-		}
+		offset = 0;
 	}
 
 	nc->pagecnt_bias--;
-	offset &= align_mask;
-	nc->offset = offset;
+	nc->offset = offset + fragsz;
 
 	return nc->va + offset;
 }
-- 
2.34.1


