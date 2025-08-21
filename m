Return-Path: <netdev+bounces-215788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58DDB304AB
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D19B600CC
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88CF3629A0;
	Thu, 21 Aug 2025 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7pxJjw6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DEA369333
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806888; cv=none; b=pYGXJjpPq7EcNmHU6HN36exxv6XYhqemzKMwC9f2YCYkwT8oeh8njsQw9XUvAS/6BXVbxt98ywxqecI8Rny6bhpyNVK2iFxKHVpJ8GTvnPlo4un36fQ5exySBUzWNZC5hxahw3gvew8QPZQr9mQPVrmP/M5H8EcMZM8DYnQhVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806888; c=relaxed/simple;
	bh=3RfOoWzbZTj8EGhrr7OVQfmCtFM6TSZBuGB7jdppkcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGq3BSpn8aNKFabK8e6wpKy0DgwUAsKNmU9PniNxCMv7vbzLnxkuhIUl2gQlpzZUOKPJQtlyKQwR2jTk51jPz6g105wOxxJMpCGZjEbhveoZPl+s9Q3buPFhpsC1H53+OgKK2Il2qDxFcLoTCce7GyjC/fXMuUiWH7xhjE+C0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7pxJjw6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaRFM4K4Pg6WYlxhcM2k1BGbQ/DW6XfjnDsCttbmjXY=;
	b=T7pxJjw6IWMA55qZiM4hqL4R1C6yErAs7PlmpQbO7PYmtCxFEpv9aYQ5RJTkmkW9t7hKOq
	Dnj1t7VQRJLRczFwXgbRmnKCrzolwy3sNDBwrzSrP+VVxWu1VSFiw5Dwvl3XfJ1wLthvBP
	0psEG0s75Rl+3GhdyeOTSqKQWIXG5E8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-nrs4Bs0jMJOTjzIz1nQkwg-1; Thu, 21 Aug 2025 16:08:04 -0400
X-MC-Unique: nrs4Bs0jMJOTjzIz1nQkwg-1
X-Mimecast-MFC-AGG-ID: nrs4Bs0jMJOTjzIz1nQkwg_1755806883
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c584459d02so247362f8f.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806883; x=1756411683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaRFM4K4Pg6WYlxhcM2k1BGbQ/DW6XfjnDsCttbmjXY=;
        b=IXvtcyH/5BTs0/Rp7ulQ3uctXH+LxhGXasot8B9fAmtn0PrAfAQV+tCUkda+I8JZQp
         9siV2C2WTKwLOvxSxzbyFSnTK/ZoYjFFrjEaeFs2hp7/aQROf5/p8vk632vzaWmAunBt
         LAhTjR69T7zkRb/Ebl1iz4NlxNgOFJPd8HHn3+Mqvq42LpsXwdgXsQHPJkAUHELWkvfT
         NCnNTqg262LAyLSuyY6464pzJz4kQWN+p0SS3MRQ3EbDpHoKpx/eaQ0Hj+K8HA2k10HK
         f2BjmmZ9k3xQVKKTsjw25uo15kJSylWurxTVj4yKwh9+72Ki0cAwEjbnTlCGqchPpHBO
         OnJg==
X-Forwarded-Encrypted: i=1; AJvYcCUi0Qw3XdAtls9f2CSbTbQd5gOD/Y3qYNZukutpQxOPAmv0uieO1QKdYbKTQCYP/pSkfx1jKSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNu8djKTPnjKoDSfbn2quWl/6VGojW3Z/DsNuQQvw/JPP3ZrUg
	bQPzSDfdmncMV4/Z9eAmxCdCvrMQYT6gmh2F42cFI2COX1A72IKNb6cxkSDDRMYYLZjeuqbtVyp
	KPpFRYOwOzTr1yV4RMa5D4nLkLtDdjx0ygBElRjYDnHGVMqebnBSuu6kRzw==
X-Gm-Gg: ASbGncthVwtyyhZsfn5y9+gUVA3OMKJa435ivtILbijW7bC7fHW7pSdk908bfF2zrji
	M56JWZ9ogrwLGwV0ZYPkH197x/qCJSKKEHla3uTwmFnZJgyui+t8TFcX2I8Dlq5OXD0eBYQAk3w
	QHcCBCz7jQf8tb5UTn8aafL78viK4beNiK+rxN8JOU6SJPE7bn7DSBTlM1KU3Sxyc8k9dP982dP
	se22v9RaPQ/x0RFk8UHiFZaXmzojT99gPQApSkvLsOdmcK3UVDBh1tDLrm5RAQ75h/oIDbit+FJ
	Qyg7kgrq8FefYuDxP5ADXG9nx3i1DgyvhixGKHh2BM1APhuny4m3W2KAslnWkHjlF/e4sc/dTRj
	J/EOgWD+1cRQQHSO2PMdN7A==
X-Received: by 2002:a05:6000:2012:b0:3b7:dd87:d741 with SMTP id ffacd0b85a97d-3c5dcc095c3mr196174f8f.42.1755806882793;
        Thu, 21 Aug 2025 13:08:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiRO9AsztHDXjXXwtKcCswXKV/HQQvQjujQOlltIgK9F5s1Ca8ikdDYrX2bvCVEtKZoFK6NA==
X-Received: by 2002:a05:6000:2012:b0:3b7:dd87:d741 with SMTP id ffacd0b85a97d-3c5dcc095c3mr196155f8f.42.1755806882316;
        Thu, 21 Aug 2025 13:08:02 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e0b299sm8957945e9.22.2025.08.21.13.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:01 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
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
Subject: [PATCH RFC 20/35] mips: mm: convert __flush_dcache_pages() to __flush_dcache_folio_pages()
Date: Thu, 21 Aug 2025 22:06:46 +0200
Message-ID: <20250821200701.1329277-21-david@redhat.com>
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

Let's make it clearer that we are operating within a single folio by
providing both the folio and the page.

This implies that for flush_dcache_folio() we'll now avoid one more
page->folio lookup, and that we can safely drop the "nth_page" usage.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/mips/include/asm/cacheflush.h | 11 +++++++----
 arch/mips/mm/cache.c               |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 1f14132b3fc98..8a2de28936e07 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -50,13 +50,14 @@ extern void (*flush_cache_mm)(struct mm_struct *mm);
 extern void (*flush_cache_range)(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end);
 extern void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page, unsigned long pfn);
-extern void __flush_dcache_pages(struct page *page, unsigned int nr);
+extern void __flush_dcache_folio_pages(struct folio *folio, struct page *page, unsigned int nr);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 static inline void flush_dcache_folio(struct folio *folio)
 {
 	if (cpu_has_dc_aliases)
-		__flush_dcache_pages(&folio->page, folio_nr_pages(folio));
+		__flush_dcache_folio_pages(folio, folio_page(folio, 0),
+					   folio_nr_pages(folio));
 	else if (!cpu_has_ic_fills_f_dc)
 		folio_set_dcache_dirty(folio);
 }
@@ -64,10 +65,12 @@ static inline void flush_dcache_folio(struct folio *folio)
 
 static inline void flush_dcache_page(struct page *page)
 {
+	struct folio *folio = page_folio(page);
+
 	if (cpu_has_dc_aliases)
-		__flush_dcache_pages(page, 1);
+		__flush_dcache_folio_pages(folio, page, folio_nr_pages(folio));
 	else if (!cpu_has_ic_fills_f_dc)
-		folio_set_dcache_dirty(page_folio(page));
+		folio_set_dcache_dirty(folio);
 }
 
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index bf9a37c60e9f0..e3b4224c9a406 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -99,9 +99,9 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
 	return 0;
 }
 
-void __flush_dcache_pages(struct page *page, unsigned int nr)
+void __flush_dcache_folio_pages(struct folio *folio, struct page *page,
+		unsigned int nr)
 {
-	struct folio *folio = page_folio(page);
 	struct address_space *mapping = folio_flush_mapping(folio);
 	unsigned long addr;
 	unsigned int i;
@@ -117,12 +117,12 @@ void __flush_dcache_pages(struct page *page, unsigned int nr)
 	 * get faulted into the tlb (and thus flushed) anyways.
 	 */
 	for (i = 0; i < nr; i++) {
-		addr = (unsigned long)kmap_local_page(nth_page(page, i));
+		addr = (unsigned long)kmap_local_page(page + i);
 		flush_data_cache_page(addr);
 		kunmap_local((void *)addr);
 	}
 }
-EXPORT_SYMBOL(__flush_dcache_pages);
+EXPORT_SYMBOL(__flush_dcache_folio_pages);
 
 void __flush_anon_page(struct page *page, unsigned long vmaddr)
 {
-- 
2.50.1


