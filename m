Return-Path: <netdev+bounces-227340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B099CBACB9C
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B581516B502
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8FA260565;
	Tue, 30 Sep 2025 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAldI52l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F92561B6
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232637; cv=none; b=dVA3Z0yZ4vYP3TMoMSRIoYG+Mxb6M7xk8jaKzyXhmR6ZQlyiUPQcpfpV3zAcsj0g4KlWf57GkqaWva9ZfOaU/vh+ULHT/2giDdFk7sTUPY0TX2swyIU/54JsMTSlG6r5vqiFoR8/lkpfGNZvxEpunQGix4nri87r9/5diAL9Fi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232637; c=relaxed/simple;
	bh=mf9UWvi+yEasN6qeo9Sru+j4hpkPsRoIMzHxRONQBOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B+IsfrqiUT+48pSU7Vb+zGiyFZvq4iS8CHr0g+FYfGNIDbj0WInGyQvGjOTJS4L/ltSIz6iz8iNcT7Jm0Zj64YxymBePTqrE1JYksycCurCRn4LlA6tLmd2AQQZfB23ByMyoP1xYT/NzmcD9SypFgQ6iB1CTJP2i6uO+DwE95Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAldI52l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759232633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DCufy65uAGFvGM422HmSOUaLbZSyia38lvC3FYRKqcI=;
	b=CAldI52lN+RuwE9uW3bqEs7XEvgKICrOIijfRUHyiIFUyD2ybWykzQmte7Wdf799LZaZ5c
	tuJM4fu/fKfMTyaaPAdu0SPGU6AJghOdlnE3bD9G+SvHa/1/UHLtHD7hJRgmFfmxxoGmj4
	mVIvIkkirmeIIewwUIOWz5Xb3UhAihY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-1WF1Rf4BODiPpLgTYdR8aQ-1; Tue, 30 Sep 2025 07:43:52 -0400
X-MC-Unique: 1WF1Rf4BODiPpLgTYdR8aQ-1
X-Mimecast-MFC-AGG-ID: 1WF1Rf4BODiPpLgTYdR8aQ_1759232631
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b07c2924d53so515452966b.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 04:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759232631; x=1759837431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCufy65uAGFvGM422HmSOUaLbZSyia38lvC3FYRKqcI=;
        b=wqbqu3B2NDdHw7GOqk0Bu/BRSqqySbwIkCdVKMo0L+ki+zrh1Zaiia/v90ABalPXrz
         iJ7LJOD31TUF1Oq9mZwoIhXQeK71DgbJu5+637hXTiy+3j+sVU8p2mFpvkYy/PX/cUNi
         0uinHIefPhVp0Vg8PkyuZb/1TidWxZGPvKFOE8XkFFl9k+4t3v7JL9zVeF6p2dFaXweY
         8l9w+Zuw/xQDljZ87YppUfG2MVciqX2R1L1s0dVpHRZAPsMTLp2/YSmmo0k9Lw4Vr0Im
         /3zDWIITJ5aabcISWgtahudQqol1sJ4ZBfYVqNxfyLNP5E4E+/umHplGAnl3hP2f0n6L
         H7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXz6Un+xps82Q/MRvKk0Euas0sO5DVl3YH3QN0ok5jLsWP8yfdPuKeRPt8oXJzvabe1H5IgJs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrz3096TIu+GAj3TEaVujNEyEe+f6BC12xyA6V972WT190VrHT
	aHM6FRihLt14g8ZJP/j9p5ae9fT8frbclVbwxIL25q9Q7fLEdWavZkQwWdLQUSWO+YJryfCCljm
	w+qA232V0fBEG6oeTgllG7QykGuGsT083xJtkme4Lc5qFVg/pIUa0maO96A==
X-Gm-Gg: ASbGncv4sQNpJYIg5UuLmGjb7cWnkF9zJFABaiPq8kzF+o59TJwfvMQOMVLyu26tiDK
	twNaPF3cg/oN27BmBAKzMoTp4FeHNijYqIsMEaFxUQdQXgqTKpH90tQv9JYiDU/SNWdnAi5BNDk
	/Dh7ITHEu27QqST2Xrq7mK11z+2IkprTXqEYJkMHrO9W0KobM5cHyXviRtJbstSkVVVJHDnIFV1
	uZZLapcEHlgm+3emkCLNBBjQHIwEM/JzvXzaqV1qpWNGIslAozVqfYCYW5O494CDHAhWHyYbPL+
	9Pf/euvO9uR+d/FvwY2FaTqOd6gMyoLUjzR1qo4ydakm1RkBru/OWPwGfyIzGO8KQ8wdcoA0
X-Received: by 2002:a17:907:e895:b0:b3f:f6d:1d90 with SMTP id a640c23a62f3a-b3f0f7cbd87mr600070266b.11.1759232630868;
        Tue, 30 Sep 2025 04:43:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHhdlfo70y+N4yKgHnnC+e82yqT8ByRohQadZ6Z8uJEwP7JjzeerbeTRrtvCy1hIRO79Au/w==
X-Received: by 2002:a17:907:e895:b0:b3f:f6d:1d90 with SMTP id a640c23a62f3a-b3f0f7cbd87mr600065666b.11.1759232630334;
        Tue, 30 Sep 2025 04:43:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3544fd0a9esm1148965566b.84.2025.09.30.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 04:43:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9A6012777FF; Tue, 30 Sep 2025 13:43:48 +0200 (CEST)
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
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Mina Almasry <almasrymina@google.com>
Cc: stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: [PATCH net v2] page_pool: Fix PP_MAGIC_MASK to avoid crashing on some 32-bit arches
Date: Tue, 30 Sep 2025 13:43:29 +0200
Message-ID: <20250930114331.675412-1-toke@redhat.com>
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
dma_index storage when there are not enough bits available. This leaves
us in the situation we were in before the patch in the Fixes tag, but
only on a subset of architecture configurations. This seems to be the
best we can do until the transition to page types in complete for
page_pool pages.

v2:
- Make sure there's at least 8 bits available and that the PAGE_OFFSET
  bit calculation doesn't wrap

Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
Cc: stable@vger.kernel.org # 6.15+
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/mm.h   | 22 +++++++------
 net/core/page_pool.c | 76 ++++++++++++++++++++++++++++++--------------
 2 files changed, 66 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..0905eb6b55ec 100644
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
+ * small to leave at least 8 bits available above PP_SIGNATURE, we define the
+ * number of bits to be 0, which turns off the DMA index tracking altogether
+ * (see page_pool_register_dma_index()).
  */
 #define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA))
 #if POISON_POINTER_DELTA > 0
@@ -4175,8 +4174,13 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
  */
 #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_SHIFT)
 #else
-/* Always leave out the topmost two; see above. */
-#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
+/* Use the lowest bit of PAGE_OFFSET if there's at least 8 bits available; see above */
+#define PP_DMA_INDEX_MIN_OFFSET (1 << (PP_DMA_INDEX_SHIFT + 8))
+#define PP_DMA_INDEX_BITS ((__builtin_constant_p(PAGE_OFFSET) && \
+			    PAGE_OFFSET >= PP_DMA_INDEX_MIN_OFFSET && \
+			    !(PAGE_OFFSET & (PP_DMA_INDEX_MIN_OFFSET - 1))) ? \
+			      MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_SHIFT) : 0)
+
 #endif
 
 #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 492728f9e021..1a5edec485f1 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -468,11 +468,60 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
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
@@ -491,18 +540,10 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
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
@@ -680,8 +721,6 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
 							   netmem_ref netmem)
 {
-	struct page *old, *page = netmem_to_page(netmem);
-	unsigned long id;
 	dma_addr_t dma;
 
 	if (!pool->dma_map)
@@ -690,15 +729,7 @@ static __always_inline void __page_pool_release_netmem_dma(struct page_pool *poo
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
@@ -708,7 +739,6 @@ static __always_inline void __page_pool_release_netmem_dma(struct page_pool *poo
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr_netmem(netmem, 0);
-	netmem_set_dma_index(netmem, 0);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
-- 
2.51.0


