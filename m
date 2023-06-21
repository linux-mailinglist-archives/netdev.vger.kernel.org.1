Return-Path: <netdev+bounces-12740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB5A738C39
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42477281360
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF8419E79;
	Wed, 21 Jun 2023 16:46:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4919E50
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 16:46:23 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EFD1BD6;
	Wed, 21 Jun 2023 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=H7xjtBA+jzTamJkZvSrBReaOKW0qDsx5kc7RVJ9s550=; b=t7EgP9l+MssKQftiMAo7VAdBCc
	Nv98h8aNtVO16LGaXGeEq2m9ltD2DVLbWxZHMVIHdnansE52q8B0dmRkBjGAlUiCMoIMy/OreImcr
	5cqHvjHzMp6Nq3yxahSKcv8h0zZPtEmJc2nmPl3Y7HZoHQEaS6cdgbsAZkrux0e53j9vMSEKgXdOK
	EKZ68SjKoRwct8bGiDcah4w9QZ3tVXt3ANsdqnDF3UeEkp2GKmn12AODcUbhsUcILgUOYmiiBAZWV
	9DXjTmPrk3hO4ePJxd9hC8YahWikG3UdRtJUwE1RGLdoobQf/AQ8MdhsOblwR8sJo3t78oQYQslj4
	WpEPi5ag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qC0y2-00EjEd-D4; Wed, 21 Jun 2023 16:46:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 11/13] mm: Rename invalidate_mapping_pagevec to mapping_try_invalidate
Date: Wed, 21 Jun 2023 17:45:55 +0100
Message-Id: <20230621164557.3510324-12-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230621164557.3510324-1-willy@infradead.org>
References: <20230621164557.3510324-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We don't use pagevecs for the LRU cache any more, and we don't know
that the failed invalidations were due to the folio being in an
LRU cache.  So rename it to be more accurate.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/fadvise.c  | 16 +++++++---------
 mm/internal.h |  4 ++--
 mm/truncate.c | 25 ++++++++++++-------------
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index fb7c5f43fd2a..f684ffd7f9c9 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -143,7 +143,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		}
 
 		if (end_index >= start_index) {
-			unsigned long nr_pagevec = 0;
+			unsigned long nr_failed = 0;
 
 			/*
 			 * It's common to FADV_DONTNEED right after
@@ -156,17 +156,15 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 			 */
 			lru_add_drain();
 
-			invalidate_mapping_pagevec(mapping,
-						start_index, end_index,
-						&nr_pagevec);
+			mapping_try_invalidate(mapping, start_index, end_index,
+					&nr_failed);
 
 			/*
-			 * If fewer pages were invalidated than expected then
-			 * it is possible that some of the pages were on
-			 * a per-cpu pagevec for a remote CPU. Drain all
-			 * pagevecs and try again.
+			 * The failures may be due to the folio being
+			 * in the LRU cache of a remote CPU. Drain all
+			 * caches and try again.
 			 */
-			if (nr_pagevec) {
+			if (nr_failed) {
 				lru_add_drain_all();
 				invalidate_mapping_pages(mapping, start_index,
 						end_index);
diff --git a/mm/internal.h b/mm/internal.h
index 119a8241f9d9..2ff7587b4045 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -133,8 +133,8 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
 		loff_t end);
 long invalidate_inode_page(struct page *page);
-unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
-		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec);
+unsigned long mapping_try_invalidate(struct address_space *mapping,
+		pgoff_t start, pgoff_t end, unsigned long *nr_failed);
 
 /**
  * folio_evictable - Test whether a folio is evictable.
diff --git a/mm/truncate.c b/mm/truncate.c
index 86de31ed4d32..4a917570887f 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -486,18 +486,17 @@ void truncate_inode_pages_final(struct address_space *mapping)
 EXPORT_SYMBOL(truncate_inode_pages_final);
 
 /**
- * invalidate_mapping_pagevec - Invalidate all the unlocked pages of one inode
- * @mapping: the address_space which holds the pages to invalidate
+ * mapping_try_invalidate - Invalidate all the evictable folios of one inode
+ * @mapping: the address_space which holds the folios to invalidate
  * @start: the offset 'from' which to invalidate
  * @end: the offset 'to' which to invalidate (inclusive)
- * @nr_pagevec: invalidate failed page number for caller
+ * @nr_failed: How many folio invalidations failed
  *
- * This helper is similar to invalidate_mapping_pages(), except that it accounts
- * for pages that are likely on a pagevec and counts them in @nr_pagevec, which
- * will be used by the caller.
+ * This function is similar to invalidate_mapping_pages(), except that it
+ * returns the number of folios which could not be evicted in @nr_failed.
  */
-unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
-		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec)
+unsigned long mapping_try_invalidate(struct address_space *mapping,
+		pgoff_t start, pgoff_t end, unsigned long *nr_failed)
 {
 	pgoff_t indices[PAGEVEC_SIZE];
 	struct folio_batch fbatch;
@@ -527,9 +526,9 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
 			 */
 			if (!ret) {
 				deactivate_file_folio(folio);
-				/* It is likely on the pagevec of a remote CPU */
-				if (nr_pagevec)
-					(*nr_pagevec)++;
+				/* Likely in the lru cache of a remote CPU */
+				if (nr_failed)
+					(*nr_failed)++;
 			}
 			count += ret;
 		}
@@ -552,12 +551,12 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
  * If you want to remove all the pages of one inode, regardless of
  * their use and writeback state, use truncate_inode_pages().
  *
- * Return: the number of the cache entries that were invalidated
+ * Return: The number of indices that had their contents invalidated
  */
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t end)
 {
-	return invalidate_mapping_pagevec(mapping, start, end, NULL);
+	return mapping_try_invalidate(mapping, start, end, NULL);
 }
 EXPORT_SYMBOL(invalidate_mapping_pages);
 
-- 
2.39.2


