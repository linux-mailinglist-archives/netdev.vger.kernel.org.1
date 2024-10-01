Return-Path: <netdev+bounces-130755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3264E98B664
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F301C21FCD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5431BFDE8;
	Tue,  1 Oct 2024 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSqvNqTz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55921BFDE0;
	Tue,  1 Oct 2024 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769591; cv=none; b=FoGO3Kn3nuEs+D17kjtfOpMm93TKBMsIaNFUWNSw6bafEt2K+WOw1tpFGS68qvUrYoUmCXeZtZM3rmuyUQOWLKODBjlskNGiA9QQPEt8WUfg3kZky9cPWBvUGqAtkMrhpYf3WnU/nc3g3JKiq0Zwln3mX8EZGXq4WJkz0Hgfnac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769591; c=relaxed/simple;
	bh=2VC8JX62znmzKZF7TGEoNh8u9WHkFhSDbG66czdPGPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rysS+8vRMwv3ZIGXgDr5WMk4stFmXvGvaFOj1NhVJHqhFSQF9fBT9bCufriQUKvcM2rUGcTwCTMuBDR42FXzCm77WFmpRVxflg9QmRIbES+Fl9jtDHXtKC9VzQlFYxP+O/dWCCRne05b7jojZjWJcICCW3vQx0bEBXF6uPWhohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSqvNqTz; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-718e6299191so2771874b3a.2;
        Tue, 01 Oct 2024 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727769589; x=1728374389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd1RgN1SUA8afyUXxZzVZIDkcTWdN6ZwdQZ6zZRg9I0=;
        b=TSqvNqTzUFm0OjK2zOVtQhSOR+qC+Vpq0J5pmKBuWUNK+BRHgNSFEPhyWckrGnRqp7
         aF6V9D+ecoenqjEsxkC8tDsYuFIJDdvxYm7swe2SPQ4dRTW38fPPYRz/trWcixd7XC3k
         GWVUf+hXXB3XisHbCDNhHaDPkj3lDWNs7t/yT8l4TnOohVGOuK+r1Rt1pbHPBDErbLYL
         XQhnqn3q1YPECxJt+Pnt+FdTaX0KHBf+qQ0IHkkrDTvvKBUI2HEODxvKrGPt7CW2sNqP
         U6kMZy+LvvvH44uoHEWrowyZ5rNX5SpBIpt0HRSy+l8ngVLXOx9sNN1qy0Xpz6BcYwrO
         I/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727769589; x=1728374389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gd1RgN1SUA8afyUXxZzVZIDkcTWdN6ZwdQZ6zZRg9I0=;
        b=LMbWyWYSkUGjtYICQsAOOF4Ij2fVRT4CNEtZ0w2lSf08Sr2nlN7kyDYhb5rXMh3VW/
         Sd/z4EbJYispAEm3+ZK69DOmw+Z8szR/B1ctN9u65LGzQqC/xcxW9s1ny30iO8qfmiOa
         GLk1jwyoYigwKsXJIQxxi/SK6kcXlxiQmgsMfNbeFbNdTqeXoh/BFTK/GVbeQUA450OF
         vKbaZcaBPFPiQi9xtMHVQrELhBiTtpiU/TWtgz5hUboTcdzZzgDtZ6b7hdRUnhAhdqha
         iQGj455B2BxHlor/4u8zrUO5RC4hZKDbKs/kj+zQZo88+E2EpoFqvIZ9voSliVqibsKp
         xTFA==
X-Forwarded-Encrypted: i=1; AJvYcCWXBqrbDaOcOdD3RlrllX1zWuvTPYnCShzkJ+62RSiHlzYSvvnqoJU5YpnLowXkKZXsnOsFthLuP7lJt6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeUdvOF54vOTkULUtfrweyB58GHxc1gRO/GG5thH2vlhBXgBt
	gxCbKmnxRucH9DRPqFj40pgRfMwO3CiZ9GO+Y/UHPVYHLAE0S/IX
X-Google-Smtp-Source: AGHT+IFZp+Gi8vE0ox+pNEB55COsRo/wNQjqM5glSXrin4ALoGI9vxZDRJ2kDHOmSEGDlwKVj4MDzw==
X-Received: by 2002:a05:6a20:6f0a:b0:1cf:2843:f798 with SMTP id adf61e73a8af0-1d4fa7ecda0mr22889063637.47.1727769588834;
        Tue, 01 Oct 2024 00:59:48 -0700 (PDT)
Received: from yunshenglin-MS-7549.. ([2409:8a55:301b:e120:88bd:a0fb:c6d6:c4a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16d6d2sm13168168a91.2.2024.10.01.00.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:59:48 -0700 (PDT)
From: Yunsheng Lin <yunshenglin0825@gmail.com>
X-Google-Original-From: Yunsheng Lin <linyunsheng@huawei.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: [PATCH net-next v19 07/14] mm: page_frag: some minor refactoring before adding new API
Date: Tue,  1 Oct 2024 15:58:50 +0800
Message-Id: <20241001075858.48936-8-linyunsheng@huawei.com>
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

Refactor common codes from __page_frag_alloc_va_align() to
__page_frag_cache_prepare() and __page_frag_cache_commit(),
so that the new API can make use of them.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 36 +++++++++++++++++++++++++++--
 mm/page_frag_cache.c            | 40 ++++++++++++++++++++++++++-------
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 75aaad6eaea2..b634e1338741 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -5,6 +5,7 @@
 
 #include <linux/bits.h>
 #include <linux/log2.h>
+#include <linux/mmdebug.h>
 #include <linux/mm_types_task.h>
 #include <linux/types.h>
 
@@ -41,8 +42,39 @@ static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
-			      gfp_t gfp_mask, unsigned int align_mask);
+void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				struct page_frag *pfrag, gfp_t gfp_mask,
+				unsigned int align_mask);
+unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
+					    struct page_frag *pfrag,
+					    unsigned int used_sz);
+
+static inline unsigned int __page_frag_cache_commit(struct page_frag_cache *nc,
+						    struct page_frag *pfrag,
+						    unsigned int used_sz)
+{
+	VM_BUG_ON(!nc->pagecnt_bias);
+	nc->pagecnt_bias--;
+
+	return __page_frag_cache_commit_noref(nc, pfrag, used_sz);
+}
+
+static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
+					    unsigned int fragsz, gfp_t gfp_mask,
+					    unsigned int align_mask)
+{
+	struct page_frag page_frag;
+	void *va;
+
+	va = __page_frag_cache_prepare(nc, fragsz, &page_frag, gfp_mask,
+				       align_mask);
+	if (unlikely(!va))
+		return NULL;
+
+	__page_frag_cache_commit(nc, &page_frag, fragsz);
+
+	return va;
+}
 
 static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index cf9375a81a64..6f6e47bbdc8d 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -95,9 +95,31 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
-void *__page_frag_alloc_align(struct page_frag_cache *nc,
-			      unsigned int fragsz, gfp_t gfp_mask,
-			      unsigned int align_mask)
+unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
+					    struct page_frag *pfrag,
+					    unsigned int used_sz)
+{
+	unsigned int orig_offset;
+
+	VM_BUG_ON(used_sz > pfrag->size);
+	VM_BUG_ON(pfrag->page != page_frag_encoded_page_ptr(nc->encoded_page));
+	VM_BUG_ON(pfrag->offset + pfrag->size >
+		  page_frag_cache_page_size(nc->encoded_page));
+
+	/* pfrag->offset might be bigger than the nc->offset due to alignment */
+	VM_BUG_ON(nc->offset > pfrag->offset);
+
+	orig_offset = nc->offset;
+	nc->offset = pfrag->offset + used_sz;
+
+	/* Return true size back to caller considering the offset alignment */
+	return nc->offset - orig_offset;
+}
+EXPORT_SYMBOL(__page_frag_cache_commit_noref);
+
+void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				struct page_frag *pfrag, gfp_t gfp_mask,
+				unsigned int align_mask)
 {
 	unsigned long encoded_page = nc->encoded_page;
 	unsigned int size, offset;
@@ -119,6 +141,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		nc->offset = 0;
+	} else {
+		page = page_frag_encoded_page_ptr(encoded_page);
 	}
 
 	size = page_frag_cache_page_size(encoded_page);
@@ -137,8 +161,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			return NULL;
 		}
 
-		page = page_frag_encoded_page_ptr(encoded_page);
-
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
@@ -153,15 +175,17 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+		nc->offset = 0;
 		offset = 0;
 	}
 
-	nc->pagecnt_bias--;
-	nc->offset = offset + fragsz;
+	pfrag->page = page;
+	pfrag->offset = offset;
+	pfrag->size = size - offset;
 
 	return page_frag_encoded_page_address(encoded_page) + offset;
 }
-EXPORT_SYMBOL(__page_frag_alloc_align);
+EXPORT_SYMBOL(__page_frag_cache_prepare);
 
 /*
  * Frees a page fragment allocated out of either a compound or order 0 page.
-- 
2.34.1


