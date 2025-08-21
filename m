Return-Path: <netdev+bounces-215783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED764B3043D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0FD34E3713
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758A135AABD;
	Thu, 21 Aug 2025 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9y1+7vt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C034A338
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806873; cv=none; b=rBf3NJemoJkolJmreQKlyzsFY3TyPYx1O4YpqB58UpCevdOeME5hswSi0hX/86KYrBr9GARyyMUSMRXxjVejt9zDA052KvFiaVcH/EYo7FJTg7c4/cJToKLQ9bUV3vO4CzNkPqBGvvOJ6ghcqh6H9hUaxiubdRast46kP9LG32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806873; c=relaxed/simple;
	bh=I7luCT+CObepmsBOKpah/UXsbrY2375DH2pptgGLgo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/laGV9JSDYf7IY5TYfthzxSUQ5HZu+KQILqJrNZ/9hBuy2XzfHkb7MzXTh4qoJoa3ZVwSneQ2vYup3APtNyQ5mePlzOtCTObQ09n3Gg7Jtde5iliaPU6dWgyHw1FN8wwXKQejIK/GrFwGf8DbRBHnIDV1G9x8kmGQjtns9ee18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9y1+7vt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXj+9vT03G0X8fnCGUCy6hSTWwnZnWm2sdD6cJzGZDI=;
	b=L9y1+7vtvNLNzDvO7vKj1ePSU8z4/HYW2XKOSDErqUG7zCGcLigOFzx3qk2aJSbQEyBxbk
	GFC23PzOdn/LnUwMZzBxKJ/l7W1U+Np966xXjhXhNFuUaaHnep7x2nXK7iBBdeT0UnVHvv
	Z1rD1I81VAPVPI5EVTwPVJvxBoKRR5o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-p3LpVq1QNrO1273TX-CCIg-1; Thu, 21 Aug 2025 16:07:36 -0400
X-MC-Unique: p3LpVq1QNrO1273TX-CCIg-1
X-Mimecast-MFC-AGG-ID: p3LpVq1QNrO1273TX-CCIg_1755806855
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9d41b779aso818596f8f.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806855; x=1756411655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXj+9vT03G0X8fnCGUCy6hSTWwnZnWm2sdD6cJzGZDI=;
        b=Di4jCKnZGBYgsMudi/7zxXfIEhGL5Z8qDEcP0VGi1WQr9PgxZh8YShgSJSXd2aXixN
         dRtIA3RQ23uaUwZjJdMLuvO63IFwbC66+YF6iem4Y8QiUww/kKbAHtUW8ZsJUFjldixD
         DFKRBEwK0nmZkklMM3TDFfw3HTBm2YAs0rP2ibifsjdlUwN1qg/7SEvsajDsrcpxhM5v
         eSlhzlL70H2GNsqrw492NP75OaecF/t6Cg8Ilh7NquVxufbaBfjLSv/J6Im710AoB3/j
         qRmgLTcHoHd55oAa/pZmaCZLIc9tZbl3iBlXg4BmlCgXozp/vIStCImn65d5WnQwf3bG
         r0IA==
X-Forwarded-Encrypted: i=1; AJvYcCVB1PhYTiSIHuJV1iAkDCozytuxBQ+j7H5KfB/BRFZ95GMST+RsdRIVNIOmk0KF9q321G3TZ+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4QxsVX+miy2lbaRw6Vn6iPMSWMQr0nlA7wB0QBvGuKFm7gGu
	L8eweT/DAt+8oI681EtFIQBlFsmb88EKKrwwblu5NBpCuRG3rsEzQNbL2asQPLCYaaHhzEPW+cb
	Ra/8+wf3A9brDEkG9L0rDGdj/8YXYWj+25skf7Amg+vOkUz1w7Rix2fCnzw==
X-Gm-Gg: ASbGncsxadCzU53ggUDaxOfi99OZjwTAHzKCFr4SOhB1EKBWV1BTmnOlPqZTjMLzkm2
	6/xhOAtru3MN7rTbQ2gmGBJNLlj75QcCeGCbrImO7dX2MXEHTQdVS2PTaBcets+EyUv4/abgaiv
	83JYvLj0vc/vucVith7Hfge3pCgrHA82O0iVciM0H+3ApcvzkqrSKLBZmfOXfdFm7yclaiQjvCN
	/+qv/X0kfNsouv4xDEYiMs581eUUb1FAOeJBxKPXXlwTN3td4hxyrqUIrdHOmKp0CDJ79zvuf/e
	zg5YAlNQ7lL9MN5OsU1mrMePG7Jup/vsIgYjrypwXf1uHYex51a+bqjcKXT6+Bqhs3tdEdrI9cT
	CAZns0E5rQ8nZAO/zdGSGmA==
X-Received: by 2002:a05:6000:2303:b0:3b8:d893:5230 with SMTP id ffacd0b85a97d-3c5ddd7f36emr169061f8f.47.1755806855257;
        Thu, 21 Aug 2025 13:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbzCbSL6MUAhNqtGz96KSex+k6XoYEx77XRmSFhqyAAErvnD4a434thNrJcfmyX2YJjFDsxQ==
X-Received: by 2002:a05:6000:2303:b0:3b8:d893:5230 with SMTP id ffacd0b85a97d-3c5ddd7f36emr169035f8f.47.1755806854709;
        Thu, 21 Aug 2025 13:07:34 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077788b39sm12802789f8f.47.2025.08.21.13.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:34 -0700 (PDT)
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
Subject: [PATCH RFC 10/35] mm/hugetlb: cleanup hugetlb_folio_init_tail_vmemmap()
Date: Thu, 21 Aug 2025 22:06:36 +0200
Message-ID: <20250821200701.1329277-11-david@redhat.com>
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

All pages were already initialized and set to PageReserved() with a
refcount of 1 by MM init code.

In fact, by using __init_single_page(), we will be setting the refcount to
1 just to freeze it again immediately afterwards.

So drop the __init_single_page() and use __ClearPageReserved() instead.
Adjust the comments to highlight that we are dealing with an open-coded
prep_compound_page() variant.

Further, as we can now safely iterate over all pages in a folio, let's
avoid the page-pfn dance and just iterate the pages directly.

Note that the current code was likely problematic, but we never ran into
it: prep_compound_tail() would have been called with an offset that might
exceed a memory section, and prep_compound_tail() would have simply
added that offset to the page pointer -- which would not have done the
right thing on sparsemem without vmemmap.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d12a9d5146af4..ae82a845b14ad 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3235,17 +3235,14 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
 					unsigned long start_page_number,
 					unsigned long end_page_number)
 {
-	enum zone_type zone = zone_idx(folio_zone(folio));
-	int nid = folio_nid(folio);
-	unsigned long head_pfn = folio_pfn(folio);
-	unsigned long pfn, end_pfn = head_pfn + end_page_number;
+	struct page *head_page = folio_page(folio, 0);
+	struct page *page = folio_page(folio, start_page_number);
+	unsigned long i;
 	int ret;
 
-	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
-		struct page *page = pfn_to_page(pfn);
-
-		__init_single_page(page, pfn, zone, nid);
-		prep_compound_tail((struct page *)folio, pfn - head_pfn);
+	for (i = start_page_number; i < end_page_number; i++, page++) {
+		__ClearPageReserved(page);
+		prep_compound_tail(head_page, i);
 		ret = page_ref_freeze(page, 1);
 		VM_BUG_ON(!ret);
 	}
@@ -3257,12 +3254,14 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 {
 	int ret;
 
-	/* Prepare folio head */
+	/*
+	 * This is an open-coded prep_compound_page() whereby we avoid
+	 * walking pages twice by preparing+freezing them in the same go.
+	 */
 	__folio_clear_reserved(folio);
 	__folio_set_head(folio);
 	ret = folio_ref_freeze(folio, 1);
 	VM_BUG_ON(!ret);
-	/* Initialize the necessary tail struct pages */
 	hugetlb_folio_init_tail_vmemmap(folio, 1, nr_pages);
 	prep_compound_head((struct page *)folio, huge_page_order(h));
 }
-- 
2.50.1


