Return-Path: <netdev+bounces-215781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F660B3045A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9850E1C82912
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE9313552;
	Thu, 21 Aug 2025 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQgtOEQX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89B35206B
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806870; cv=none; b=Pns8oo/lXMx3afABqbLek9GiAA+7h/3WV4Shq7T1xW0eQ7vXM2WzAufOYKzsJXEgbnSfkOvmWkTB3ilE2iLqFoWQpLcEnswomX5BKGVXxyQxiBQ6IEu4JF1jgtwytUDQbz+6O5Cm69YcZNd5UxfTFlNeXx8P0eT5yVJVdlvknFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806870; c=relaxed/simple;
	bh=KQhGj4yMV2JJyYTphSuwtYusktgVAWzYxv4GDdmnyDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csOX6OWgQJFGlMDjlmN7G4uy4xdmgmP6pcQK5kKHBCVGF8OJkRLr3O/iX6q1lWqJcjqHMd3iFx9Ngd6SDkUAMu88dE+oRxmXbfcj0VWTcApaoj3WApiQ2Bfop8KIMfymvBouQhJmOvmf0zUbSsvxM2jm+onhIJaYFtJOp/daG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQgtOEQX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkrXh5PHMEq3NY5i+0892fbAshOERsmwyMLhbVIa0Cc=;
	b=TQgtOEQXAd+ZqMtryRdclu2CWcywwWPcGCzMrZFbaM2gO/NUWiE9zbd6emxjpl4PAaRcmX
	Ja8dVAi+Ww3YWP2K5jdURjRGATicOACA0zIstYunElZfkqNE3+Qa+89Se5oMOlM8Yy0tDq
	RsY7hoM2zfwfOUwYF+6vwfncgXNx/+E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-cUAVmJWSPTuiXaTgKlKLkw-1; Thu, 21 Aug 2025 16:07:44 -0400
X-MC-Unique: cUAVmJWSPTuiXaTgKlKLkw-1
X-Mimecast-MFC-AGG-ID: cUAVmJWSPTuiXaTgKlKLkw_1755806864
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41b88ffso837905f8f.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806863; x=1756411663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkrXh5PHMEq3NY5i+0892fbAshOERsmwyMLhbVIa0Cc=;
        b=vXcRavf68FylwwV6jookT114ULY9CzkgB59W2xUgcLZWq83485K/KnemE1LEgOGp+M
         zw1WnA4dzWtvkRxK96t8eCbzYSRPUGGQ27vIbBQ/v5nnUqhXBiQOch7VlvuDY/uPYd3t
         VAW43kvdDJz91rWhtEbpQdKluo+C4JvyAH9ypa1kZBPYtspGyqGyigUFDsmhSzj/cb4L
         fsyyRH6JfGNU+n43/dT3tbh40irYR92gpVhzvSyvwcD7r88NILZtMpwcO4S8+4nOaNdp
         FteNyOgI37Z9vH1Nk2CMxhtP7IlICzAU2Lnlhrgh6gWhCIyXf94iTlYzuVMzjXdlMHvc
         J+9A==
X-Forwarded-Encrypted: i=1; AJvYcCW1W7DJ6PistD2eDsJPDj6PI+VhuNetVAGrfpc6zE7A9GTY7Szs8BJORD4hbz/iiLMBb7hhCso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmtIj/lQZXR7rvlxJyl92Y2Gf0CmRnqzsU9xe9qG/l/XudHVS
	HkcCXgYhiUD/tWKcvR3fZbxykK5hB1rTRqfY5KFGiYJKWDIr4CwxjXLh/dgiQLa1w187Q7tJYGm
	j55HLjkRDlxthRfvzYsoNO2Mf58xDPpcQoFLJzEcnE4cAO14qfwQuq32y4Q==
X-Gm-Gg: ASbGnctgZgX6mFCmXXTgXhVnCvXtY9lqG52nXPR25gxi/rTVjnlCbjpB2z10jfMlxD0
	ac95shgl0sjPQdn8cdlOq9a+aw31LiPg3MZWQ0/YUARB4waoc2ucMYFDpGbWqQq4eTPhUir4/Ep
	3HNYckeCtI/4xcG4OZsmLSCwADiFhxGGE2EnWZl3x/l4Q09AfAJ4CCYzLsMtGBSM8ftbV6dIKKb
	Za6NlOIM6QPD5xW8OxMzubpt8evPleOhW3wHGWSxcJPsjETVxhefDHqu+stasLndbp6gqe6KGjN
	rqxENry69hOfpSGd5gFMbHIkTv5y+h7BLaifFGv024E7qsrxFBuGtpwAuoT+96WYNHTHk5pDmYP
	aYK7C8DtoAVZqyidnI8/CIg==
X-Received: by 2002:a5d:5d0a:0:b0:3b9:14f2:7eea with SMTP id ffacd0b85a97d-3c5daefc2a3mr192532f8f.18.1755806863466;
        Thu, 21 Aug 2025 13:07:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB28V/U3gI+p1afMr2c1HujEN1g59N1A45YIj+RBO5vrtdOMlsNhrN6BtrkE7YShkW7nBB8Q==
X-Received: by 2002:a5d:5d0a:0:b0:3b9:14f2:7eea with SMTP id ffacd0b85a97d-3c5daefc2a3mr192518f8f.18.1755806862961;
        Thu, 21 Aug 2025 13:07:42 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b51b61256sm1742995e9.3.2025.08.21.13.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:42 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 13/35] mm: simplify folio_page() and folio_page_idx()
Date: Thu, 21 Aug 2025 22:06:39 +0200
Message-ID: <20250821200701.1329277-14-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that a single folio/compound page can no longer span memory sections
in problematic kernel configurations, we can stop using nth_page().

While at it, turn both macros into static inline functions and add
kernel doc for folio_page_idx().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h         | 16 ++++++++++++++--
 include/linux/page-flags.h |  5 ++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 48a985e17ef4e..ef360b72cb05c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -210,10 +210,8 @@ extern unsigned long sysctl_admin_reserve_kbytes;
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
-#define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
 #else
 #define nth_page(page,n) ((page) + (n))
-#define folio_page_idx(folio, p)	((p) - &(folio)->page)
 #endif
 
 /* to align the pointer to the (next) page boundary */
@@ -225,6 +223,20 @@ extern unsigned long sysctl_admin_reserve_kbytes;
 /* test whether an address (unsigned long or pointer) is aligned to PAGE_SIZE */
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
+/**
+ * folio_page_idx - Return the number of a page in a folio.
+ * @folio: The folio.
+ * @page: The folio page.
+ *
+ * This function expects that the page is actually part of the folio.
+ * The returned number is relative to the start of the folio.
+ */
+static inline unsigned long folio_page_idx(const struct folio *folio,
+		const struct page *page)
+{
+	return page - &folio->page;
+}
+
 static inline struct folio *lru_to_folio(struct list_head *head)
 {
 	return list_entry((head)->prev, struct folio, lru);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d53a86e68c89b..080ad10c0defc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -316,7 +316,10 @@ static __always_inline unsigned long _compound_head(const struct page *page)
  * check that the page number lies within @folio; the caller is presumed
  * to have a reference to the page.
  */
-#define folio_page(folio, n)	nth_page(&(folio)->page, n)
+static inline struct page *folio_page(struct folio *folio, unsigned long nr)
+{
+	return &folio->page + nr;
+}
 
 static __always_inline int PageTail(const struct page *page)
 {
-- 
2.50.1


