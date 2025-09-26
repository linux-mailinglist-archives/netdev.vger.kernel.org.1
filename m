Return-Path: <netdev+bounces-226644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315CFBA37F5
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5759E189207A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F2C2765D2;
	Fri, 26 Sep 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuwhUDJ/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B16158DAC
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758886799; cv=none; b=unfOg4yFlha8tEymAG2WBKR/1JPX0rXxtQi3CkdVLsllfAWC65s6mVEm64eIHgjeP+g8Ms/fKs7XgL8CEwQgmnXvfzXQWAu8dVcyhQgJkezeOVCXn8YV+u9CyI7aJpfqDNhrBLb3fOzCUsFrkXmc9nhYQIaF9edqLjGxllICem0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758886799; c=relaxed/simple;
	bh=C4FA9c9TzoPy/6VPbp8AYsIpxAcjx25Vb0xVGWfCwLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uFGYb7rfCGZ97AQHLlaAkoyJQbZlhyxmpm8jj2SWhO4PAuwsT77bo2QIdsCo54tqkHHGuK6AyjVL39qCfeoZ0kFDc2pd7JHkM6lNy070hl1AuUBRdG6RfRymvZqlECfjGAgWNxJhAcQCORtE8OgSOV34tmRtewWQ4HkNdcXhGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuwhUDJ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758886797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AtJ/1mk75ioxBq+kB3S7YkMI6itFh86Ny1CHtMfezGs=;
	b=PuwhUDJ/RfoqEJMLKfkeYxc+CmTn/EIN5jH4z2LjtxJKYOuYGjCFkXQJKp7e7nBQrjavoE
	Q6BBvsQuKdD9gat1UaJojIF2s04zebyb9P5yK8HWk0NAtc1Vlo7YgZQyYOXwx+C9SOMqCQ
	LwCfsfDv5kAlINVb73G4KxeOW2jDfXI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-5FQkXDSEO2SShcmLBfYsDQ-1; Fri, 26 Sep 2025 07:39:55 -0400
X-MC-Unique: 5FQkXDSEO2SShcmLBfYsDQ-1
X-Mimecast-MFC-AGG-ID: 5FQkXDSEO2SShcmLBfYsDQ_1758886794
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-57a8a75cb30so1339789e87.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 04:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758886794; x=1759491594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtJ/1mk75ioxBq+kB3S7YkMI6itFh86Ny1CHtMfezGs=;
        b=kwjO+5VzaKQ8jYjTr7SVVE2r0rx3Zr28R2Hxl5TvSQkT519Xy1APZFLIrh0Q3ZUwNL
         ++FXJ/dl9dPi8YLsSnkhECcjvRI4cS14XJ+4w2GGsDNdI5JjPU6QNr07NtkeqazOu2oZ
         eZ5zOVrf1S+6sqFHmTXH/1QdDMPS2V1xhWeul8Aagg3YMwFqLrQ3tUv5C36C16DNY9vp
         YDfcAsqcFrQy37728qSDSPvyoJi39c6aWylIvuh4qr60owzeXoQsNrpTYbnXnf6OztDP
         7FOPyPLJI0SsZLbZLVnJW90F6d3py9HoDc11pwBH4P6I21qk46olmhS/SW2r3OZVoY94
         7L5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7+qS3mClBEXfVG+uQCIHYp9b0zwRs1ELSq8WrM6sSBx6ERaRGuoJHrzt3HTurhRCrI/oyuDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznbXKXouyRMfxx5Ss9cfAcUcpM02vxkUK1mMKSywC5GViwOofs
	bUwdCLTmM6An6uYoDARrv/9wf7QMq0XjQVUAwycs/yIbjjPaMaB6fnCPangqCL/SCiEpFCIXF52
	9iyBNKciDmawQx5eclzGQR+C3X+RSNfwEZowQErt/AfzR2BZA2wT/pv68Dw==
X-Gm-Gg: ASbGncvAU8qdOULWZKBbp3Fr4mi7hmCpUMqcHlvs+sfuTn3uYkEmdNEf913mDEpkmKJ
	M3aeYdZ0r4webvIXPptxMS9lly3hoOJO0VkyPQwbQooLQnEzbZUTtzHb+0fVvOyVdQ4+woDdLFL
	CTsIfvmISdGG2/4a24+STpqas1vibMETLoZw4L3V8fbirmiURRsIq7uP9LMI5qPRo6Bf3OuLHdD
	jxiRLO+FHWXOWvDkycZYqsBO3TIb8VARXlTqAbDVQIvANgSFBlKxPH9QdwDW1o2ZQ64R5NEQPnH
	9EiYrX//AdgpDhFfsyVVoR0mAPznkGQnpYvb3V8umhAed6Mx3QCZkoYYhAcDijn+0o0=
X-Received: by 2002:a05:6512:39d1:b0:55b:842d:5828 with SMTP id 2adb3069b0e04-582d2f2796emr2598424e87.36.1758886793729;
        Fri, 26 Sep 2025 04:39:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOkzLCVigWsLXFz4HKYVY99wW4ETi6/xnHL05Mfvqi+0yC4WxRRgQmbTgHpaOV9jp1BFmI0A==
X-Received: by 2002:a05:6512:39d1:b0:55b:842d:5828 with SMTP id 2adb3069b0e04-582d2f2796emr2598408e87.36.1758886793243;
        Fri, 26 Sep 2025 04:39:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430dd5sm1751076e87.24.2025.09.26.04.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 04:39:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F014F2771C6; Fri, 26 Sep 2025 13:39:50 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Helge Deller <deller@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: [PATCH net] page_pool: Fix PP_MAGIC_MASK to avoid crashing on some 32-bit arches
Date: Fri, 26 Sep 2025 13:38:39 +0200
Message-ID: <20250926113841.376461-1-toke@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Helge reported that the introduction of PP_MAGIC_MASK let to crashes on
boot on his 32-bit parisc machine. The cause of this is the mask is set
too wide, so the page_pool_page_is_pp() incurs false positives which
crashes the machine.

Just disabling the check in page_pool_is_pp() will lead to the page_pool
code itself malfunctioning; so instead of doing this, this patch changes
the define for PP_DMA_INDEX_BITS to avoid mistaking arbitrary kernel
pointers for page_pool-tagged pages.

The fix relies on the kernel pointers that alias with the pp_magic field
always being above PAGE_OFFSET. With this assumption, we can use the
lowest bit of the value of PAGE_OFFSET as the upper bound of the
PP_DMA_INDEX_MASK, which should avoid the false positives.

Because we cannot rely on PAGE_OFFSET always being a compile-time
constant, nor on it always being >0, we fall back to disabling the
dma_index storage when there are no bits available. This leaves us in
the situation we were in before the patch in the Fixes tag, but only on
a subset of architecture configurations. This seems to be the best we
can do until the transition to page types in complete for page_pool
pages.

Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Sorry for the delay on getting this out. I have only compile-tested it,
since I don't have any hardware that triggers the original bug. Helge, I'm
hoping you can take it for a spin?

 include/linux/mm.h   | 18 +++++------
 net/core/page_pool.c | 76 ++++++++++++++++++++++++++++++--------------
 2 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..28541cb40f69 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4159,14 +4159,13 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
  * since this value becomes part of PP_SIGNATURE; meaning we can just use the
  * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA), and the
  * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTER_DELTA is
- * 0, we make sure that we leave the two topmost bits empty, as that guarantees
- * we won't mistake a valid kernel pointer for a value we set, regardless of the
- * VMSPLIT setting.
+ * 0, we use the lowest bit of PAGE_OFFSET as the boundary if that value is
+ * known at compile-time.
  *
- * Altogether, this means that the number of bits available is constrained by
- * the size of an unsigned long (at the upper end, subtracting two bits per the
- * above), and the definition of PP_SIGNATURE (with or without
- * POISON_POINTER_DELTA).
+ * If the value of PAGE_OFFSET is not known at compile time, or if it is too
+ * small to leave some bits available above PP_SIGNATURE, we define the number
+ * of bits to be 0, which turns off the DMA index tracking altogether (see
+ * page_pool_register_dma_index()).
  */
 #define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA))
 #if POISON_POINTER_DELTA > 0
@@ -4175,8 +4174,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
  */
 #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_SHIFT)
 #else
-/* Always leave out the topmost two; see above. */
-#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
+/* Constrain to the lowest bit of PAGE_OFFSET if known; see above. */
+#define PP_DMA_INDEX_BITS ((__builtin_constant_p(PAGE_OFFSET) && PAGE_OFFSET > PP_SIGNATURE) ? \
+			      MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_SHIFT) : 0)
 #endif
 
 #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 36a98f2bcac3..e224d2145eed 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -472,11 +472,60 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 	}
 }
 
+static int page_pool_register_dma_index(struct page_pool *pool,
+					netmem_ref netmem, gfp_t gfp)
+{
+	int err = 0;
+	u32 id;
+
+	if (unlikely(!PP_DMA_INDEX_BITS))
+		goto out;
+
+	if (in_softirq())
+		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
+			       PP_DMA_INDEX_LIMIT, gfp);
+	else
+		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
+				  PP_DMA_INDEX_LIMIT, gfp);
+	if (err) {
+		WARN_ONCE(err != -ENOMEM, "couldn't track DMA mapping, please report to netdev@");
+		goto out;
+	}
+
+	netmem_set_dma_index(netmem, id);
+out:
+	return err;
+}
+
+static int page_pool_release_dma_index(struct page_pool *pool,
+				       netmem_ref netmem)
+{
+	struct page *old, *page = netmem_to_page(netmem);
+	unsigned long id;
+
+	if (unlikely(!PP_DMA_INDEX_BITS))
+		return 0;
+
+	id = netmem_get_dma_index(netmem);
+	if (!id)
+		return -1;
+
+	if (in_softirq())
+		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
+	else
+		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
+	if (old != page)
+		return -1;
+
+	netmem_set_dma_index(netmem, 0);
+
+	return 0;
+}
+
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
 {
 	dma_addr_t dma;
 	int err;
-	u32 id;
 
 	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
 	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
@@ -495,18 +544,10 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
 		goto unmap_failed;
 	}
 
-	if (in_softirq())
-		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
-			       PP_DMA_INDEX_LIMIT, gfp);
-	else
-		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
-				  PP_DMA_INDEX_LIMIT, gfp);
-	if (err) {
-		WARN_ONCE(err != -ENOMEM, "couldn't track DMA mapping, please report to netdev@");
+	err = page_pool_register_dma_index(pool, netmem, gfp);
+	if (err)
 		goto unset_failed;
-	}
 
-	netmem_set_dma_index(netmem, id);
 	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
 
 	return true;
@@ -684,8 +725,6 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
 							   netmem_ref netmem)
 {
-	struct page *old, *page = netmem_to_page(netmem);
-	unsigned long id;
 	dma_addr_t dma;
 
 	if (!pool->dma_map)
@@ -694,15 +733,7 @@ static __always_inline void __page_pool_release_netmem_dma(struct page_pool *poo
 		 */
 		return;
 
-	id = netmem_get_dma_index(netmem);
-	if (!id)
-		return;
-
-	if (in_softirq())
-		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
-	else
-		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
-	if (old != page)
+	if (page_pool_release_dma_index(pool, netmem))
 		return;
 
 	dma = page_pool_get_dma_addr_netmem(netmem);
@@ -712,7 +743,6 @@ static __always_inline void __page_pool_release_netmem_dma(struct page_pool *poo
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr_netmem(netmem, 0);
-	netmem_set_dma_index(netmem, 0);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
-- 
2.51.0


