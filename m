Return-Path: <netdev+bounces-173564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD79A5978D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A50188DFFA
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E222B8C7;
	Mon, 10 Mar 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BBN9H589"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454E11CBA
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616878; cv=none; b=MKgPorWKb0JeQSMQIfnr8u02/DkDQAuVABZoXMYKwfsqfpK/LwtSnvz47aPrtn7JwMMk4GPwgmA3S+KDYO2kTaTGi6I24XTabOMAKa/DUadL+Gnfj2ARekcqxKvu9xuOsHarLXq1daMvU8j67teVT4tMXTmPRGGIv8aLKLu7gnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616878; c=relaxed/simple;
	bh=Akbmx+ag3XVlXpZr7uNwq+KfHyJXW0GfAnFjNJb/4xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PlfGZYe/ksBzc+aYLscNsJXayt0lwqbzOVD/hi2w9CaTOIaaRewvzUT1HvgMJRAEi7/4pj4OaXIRhv4SN8L4vYNjkaOhzxIgqhSgiwSNucVOcXJ/ca4FwKk5eVIYF8tWNTmyfRxX+uHJckvEZ/0E9UcpWCq5TfMMZBFVZyYKGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BBN9H589; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=WslRGGzaaI9HS/JpYja+Tlu6+ck+VQ836pJDNKbYwsM=; b=BBN9H589L6ZrfJc6YYCShGFGDg
	Jtxtv547cgschZ2c5G+PZd/lZJ1sfOLdaQ5YsD+jFA/BhJZRWP40yUC1kWdh7VAzbXksImpy3j76W
	OcvUCAcg6p0cu2m/KLIttRstzYh+eOQVPEcC5o9gHYK0Bm6GYeKrS7gFivDZEzKYfVpex0WZXIRJZ
	MpNjaVvaNvsMPXDWPylCKRGX22OMEMcHaop5kol3vAZiKg11uznP+2ngbboYy7hjIHWK9/zyoozhU
	dZcoiL5zT81/9Wl7/+uUsQVIwy9CSvBrUClf7e+nlUStfHM8PoJmdqz/V705TVN7kP+kFDPuYTKtG
	4xPn63oA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tre6i-000000054aQ-2d04;
	Mon, 10 Mar 2025 14:27:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: 
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	netdev@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] mm: Decline to manipulate the refcount on a slab page
Date: Mon, 10 Mar 2025 14:27:48 +0000
Message-ID: <20250310142750.1209192-1-willy@infradead.org>
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


