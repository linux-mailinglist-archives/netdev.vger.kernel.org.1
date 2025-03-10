Return-Path: <netdev+bounces-173566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDC5A597C5
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6AB16D811
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D911422B8C3;
	Mon, 10 Mar 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NUul7KRm"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3E622CBE6
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617357; cv=none; b=tAiXakUKt/ATMTvKm9qe9Pc2CGC9B5wIpyLY23zSue8mfM+KGVcfe3zBkr9gJPgookajtKA3iMT3YMZAH+uELM5Z7FEa8s9cwYgy/7tO8a5Of4t9skvdFVEIWBa3LryRXXx0v5gsvZ6ChqrJEseobVlITudG/ZhwgF/ehXGeAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617357; c=relaxed/simple;
	bh=Akbmx+ag3XVlXpZr7uNwq+KfHyJXW0GfAnFjNJb/4xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtfInWaW8z1eyJ4WCNl5/CgyRpl8says1Kpvyj/LSur+ommJhJ1iXX0pa7DM7Ha0GPA+omVGZZHCCMWoJg4TceoTYZyacMnQXRJ8zhxgRM8Nv2ww8wHhD67vEx4t5NWGUSpuKILdQRqT3g9ISfDLOsYsp+0pJtx/8ksIVzfCWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NUul7KRm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=WslRGGzaaI9HS/JpYja+Tlu6+ck+VQ836pJDNKbYwsM=; b=NUul7KRmOjLdxU5LJLR41epiJQ
	PDvs4LKC8v0gC4rhYhKaF6wmROM+7Vmx2dygOjkJT+qzhqnu/3/QyeQgYKc7AJi2y4mIAemSiuaWc
	PgXtPk0S2B1GAKFZzmyfptA2gVSbP6H73LGQB1b39RxeT6vxFcnNGVfzJU3V4FhYyAB9PZ1Im5gOo
	k+MwGorQqNh5SblaqEIafD9DpuF3RbNDNwK6LVwGHjrALdgFfpIz3N83SQLtBd572oSzOslrYHEcj
	5Wh+wiYECSxbK30n3XsJkRbRRwVGQZdJgDV2kzUGl+SNTB7DA5r+vpu7OHQjiE3GTLkpx8bftCNYn
	f7Q/qotg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1treES-000000056Vg-1EnE;
	Mon, 10 Mar 2025 14:35:52 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	netdev@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] mm: Decline to manipulate the refcount on a slab page
Date: Mon, 10 Mar 2025 14:35:24 +0000
Message-ID: <20250310143544.1216127-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Slab pages now have a refcount of 0, so nobody should be trying to
manipulate the refcount on them.  Doing so has little effect; the object
could be freed and reallocated to a different purpose, although the slab
itself would not be until the refcount was put making it behave rather
like TYPESAFE_BY_RCU.

Unfortunately, __iov_iter_get_pages_alloc() does take a refcount.
Fix that to not change the refcount, and make put_page() silently not
change the refcount.  get_page() warns so that we can fix any other
callers that need to be changed.

Long-term, networking needs to stop taking a refcount on the pages that
it uses and rely on the caller to hold whatever references are necessary
to make the memory stable.  In the medium term, more page types are going
to hav a zero refcount, so we'll want to move get_page() and put_page()
out of line.

Reported-by: Hannes Reinecke <hare@suse.de>
Fixes: 9aec2fb0fd5e (slab: allocate frozen pages)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 7 ++++++-
 lib/iov_iter.c     | 8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 61de65c4e430..4e118cbe0556 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1539,7 +1539,10 @@ static inline void folio_get(struct folio *folio)
 
 static inline void get_page(struct page *page)
 {
-	folio_get(page_folio(page));
+	struct folio *folio = page_folio(page);
+	if (WARN_ON_ONCE(folio_test_slab(folio)))
+		return;
+	folio_get(folio);
 }
 
 static inline __must_check bool try_get_page(struct page *page)
@@ -1633,6 +1636,8 @@ static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
+	if (folio_test_slab(folio))
+		return;
 	folio_put(folio);
 }
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65f550cb5081..8c7fdb7d8c8f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1190,8 +1190,12 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		if (!n)
 			return -ENOMEM;
 		p = *pages;
-		for (int k = 0; k < n; k++)
-			get_page(p[k] = page + k);
+		for (int k = 0; k < n; k++) {
+			struct folio *folio = page_folio(page);
+			p[k] = page + k;
+			if (!folio_test_slab(folio))
+				folio_get(folio);
+		}
 		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
 		i->count -= maxsize;
 		i->iov_offset += maxsize;
-- 
2.47.2


