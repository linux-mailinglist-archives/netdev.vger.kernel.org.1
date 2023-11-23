Return-Path: <netdev+bounces-50344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D316F7F5667
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C4F280D2E
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309D13D87;
	Thu, 23 Nov 2023 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzp/kCoy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2461A8
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 18:25:40 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf61eed213so3393505ad.2
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 18:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700706339; x=1701311139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=alCRNwrrdh7rHKNUzjSmzrgdnxE0eijK4L857D75ssc=;
        b=Fzp/kCoynNdmKi/Rs4yMPoBlJrXUaLmVQ6MNuwBvynyvTePlXiTWsrVy6gAFyCCp08
         OFwqq9IZFGXRahqzd6F2QUvFvgr0leeerzdUQhAdS8Vpq4emWCZbBVQf2BGbDjnCKgG4
         NrIa4AAJTqcNlQ6/H7/eonQ+icaIanrfcRL1Pp2GRSo46cuQJR/5B8DSKcYo1J/Oy6pm
         XZV0Ld/T1Eq+eGxdB6Sotehg2JqqQ1Me0bzcr6zZEbntwpdvn8k+eHOlVDIwUXcNQHJf
         i7C/1pkrl+rJLhgeI3Fmhi0TzHjEDpshzlkrZXVLSrXoxYEvv650iYjU4nwmGPo87Nk/
         2JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700706339; x=1701311139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alCRNwrrdh7rHKNUzjSmzrgdnxE0eijK4L857D75ssc=;
        b=gF7QnBQb4W4Dnroc7zxk0mQRLs9waUMOSfIalNvaRrymIodN/vJkFoA3nYRdP+zeL4
         Ze9uDWquEutGktsAQzPDrsDs2ZRVqyaul7GzzE48HsSHlR5POiPohvO5+bWRJDysb4td
         1hVmka9SaSHVeY5omaiWNg4tkgHMaBPdO5uxHCBvUDDnboUoOXK8iz3P+5FYRiCU/QlD
         CSdY9HUIfZGcFIEsdVbSKAipGfohsiCiZg3X1d/2cTlnjqE0YAqWoj3H2bn7pVkp2BnR
         Lg0lu9qA/607xHJ4SP0+Ht/bSxwwhgcoBp4OGJvxFMymbsZBrIJhx7i+SDdzXfz6ScK0
         mgUA==
X-Gm-Message-State: AOJu0YyU1i0mMtZzDmmfubAu+aMG/p7ZKi1UiZ3v8hYPnTNdgKr1JBvF
	Odxh0dxLApyfi/yalAEI0Mg=
X-Google-Smtp-Source: AGHT+IEG52qjzrUeruPSojmlN7ETuyzZbhdWyD2gZBEzpIbw7WjFTO6cPT+hHLaRHL7XjIPh8c6egw==
X-Received: by 2002:a17:902:9044:b0:1cc:29ed:96ae with SMTP id w4-20020a170902904400b001cc29ed96aemr4162097plz.41.1700706339368;
        Wed, 22 Nov 2023 18:25:39 -0800 (PST)
Received: from localhost.localdomain ([204.44.110.111])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001ce6452a741sm32880ply.25.2023.11.22.18.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 18:25:38 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Cc: netdev@vger.kernel.org,
	linux-mm@kvack.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v2 1/3] page_pool: Rename pp_frag_count to pp_ref_count
Date: Thu, 23 Nov 2023 10:25:14 +0800
Message-Id: <20231123022516.6757-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support multiple users referencing the same fragment, pp_frag_count is
renamed to pp_ref_count to better reflect its actual meaning based on the
suggestion from [1].

[1]
http://lore.kernel.org/netdev/f71d9448-70c8-8793-dc9a-0eb48a570300@huawei.com

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 include/linux/mm_types.h        |  2 +-
 include/net/page_pool/helpers.h | 31 ++++++++++++++++++-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 957ce38768b2..64e4572ef06d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -125,7 +125,7 @@ struct page {
 			struct page_pool *pp;
 			unsigned long _pp_mapping_pad;
 			unsigned long dma_addr;
-			atomic_long_t pp_frag_count;
+			atomic_long_t pp_ref_count;
 		};
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 4ebd544ae977..a6dc9412c9ae 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -29,7 +29,7 @@
  * page allocated from page pool. Page splitting enables memory saving and thus
  * avoids TLB/cache miss for data access, but there also is some cost to
  * implement page splitting, mainly some cache line dirtying/bouncing for
- * 'struct page' and atomic operation for page->pp_frag_count.
+ * 'struct page' and atomic operation for page->pp_ref_count.
  *
  * The API keeps track of in-flight pages, in order to let API users know when
  * it is safe to free a page_pool object, the API users must call
@@ -214,61 +214,66 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
 	return pool->p.dma_dir;
 }
 
-/* pp_frag_count represents the number of writers who can update the page
+/* pp_ref_count represents the number of writers who can update the page
  * either by updating skb->data or via DMA mappings for the device.
  * We can't rely on the page refcnt for that as we don't know who might be
  * holding page references and we can't reliably destroy or sync DMA mappings
  * of the fragments.
  *
- * When pp_frag_count reaches 0 we can either recycle the page if the page
+ * pp_ref_count initially corresponds to the number of fragments. However,
+ * when multiple users start to reference a single fragment, for example in
+ * skb_try_coalesce, the pp_ref_count will become greater than the number of
+ * fragments.
+ *
+ * When pp_ref_count reaches 0 we can either recycle the page if the page
  * refcnt is 1 or return it back to the memory allocator and destroy any
  * mappings we have.
  */
 static inline void page_pool_fragment_page(struct page *page, long nr)
 {
-	atomic_long_set(&page->pp_frag_count, nr);
+	atomic_long_set(&page->pp_ref_count, nr);
 }
 
 static inline long page_pool_defrag_page(struct page *page, long nr)
 {
 	long ret;
 
-	/* If nr == pp_frag_count then we have cleared all remaining
+	/* If nr == pp_ref_count then we have cleared all remaining
 	 * references to the page:
 	 * 1. 'n == 1': no need to actually overwrite it.
 	 * 2. 'n != 1': overwrite it with one, which is the rare case
-	 *              for pp_frag_count draining.
+	 *              for pp_ref_count draining.
 	 *
 	 * The main advantage to doing this is that not only we avoid a atomic
 	 * update, as an atomic_read is generally a much cheaper operation than
 	 * an atomic update, especially when dealing with a page that may be
-	 * partitioned into only 2 or 3 pieces; but also unify the pp_frag_count
+	 * partitioned into only 2 or 3 pieces; but also unify the pp_ref_count
 	 * handling by ensuring all pages have partitioned into only 1 piece
 	 * initially, and only overwrite it when the page is partitioned into
 	 * more than one piece.
 	 */
-	if (atomic_long_read(&page->pp_frag_count) == nr) {
+	if (atomic_long_read(&page->pp_ref_count) == nr) {
 		/* As we have ensured nr is always one for constant case using
 		 * the BUILD_BUG_ON(), only need to handle the non-constant case
-		 * here for pp_frag_count draining, which is a rare case.
+		 * here for pp_ref_count draining, which is a rare case.
 		 */
 		BUILD_BUG_ON(__builtin_constant_p(nr) && nr != 1);
 		if (!__builtin_constant_p(nr))
-			atomic_long_set(&page->pp_frag_count, 1);
+			atomic_long_set(&page->pp_ref_count, 1);
 
 		return 0;
 	}
 
-	ret = atomic_long_sub_return(nr, &page->pp_frag_count);
+	ret = atomic_long_sub_return(nr, &page->pp_ref_count);
 	WARN_ON(ret < 0);
 
-	/* We are the last user here too, reset pp_frag_count back to 1 to
+	/* We are the last user here too, reset pp_ref_count back to 1 to
 	 * ensure all pages have been partitioned into 1 piece initially,
 	 * this should be the rare case when the last two fragment users call
 	 * page_pool_defrag_page() currently.
 	 */
 	if (unlikely(!ret))
-		atomic_long_set(&page->pp_frag_count, 1);
+		atomic_long_set(&page->pp_ref_count, 1);
 
 	return ret;
 }
-- 
2.31.1


