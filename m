Return-Path: <netdev+bounces-215786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A318B304B2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12EA163DAE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B29434F491;
	Thu, 21 Aug 2025 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INXnHCKT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5135FC19
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806881; cv=none; b=Maq0xL9o90H/a7dWkHKjuqcfx3bPEFPlxwEQAVDp1G+XJcKAuMJvV6nlG9Ve/+Ra8nlX4V1VQh0AE+RiGl5AJIFwoERGob4UqNLSzZx56Cp1lr5Da/e2tgsWnVDGMRRRKgJxB+qSj4kUhLVROn1ACjppfRgGudbYzMSDhZOB3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806881; c=relaxed/simple;
	bh=jeuBd6AEd//7dLky0U/9/K8CcfgAIF74DmeLEQ7xh6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jH+HoSbacrgPIlYoHcnEroPFFRMMwL8zqEcPmThIjQF+GWi6/8ev/Hvk5alLqfHP247MZKEhgJcXZF6AzBbooniLNzHTV1uqVGm2QmpaqvQR6jmw+5hGkr1/pdPQSCeMabQbuTynOIKHJutXCkueGU3fvnsp/1Ber/LFKm+5cNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INXnHCKT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPs2EdTZ9fd3MpWdb0ATDCa6nUqfGtFMv2uyZP7L+uU=;
	b=INXnHCKTH+h2uu0oN2Z0PLZFrgxk+y1zwtWtFU1603xRSa19AX39/JeNQvGlz0eUXEb69q
	bjHvbghGd/QGAzLP0ziyTYQtduKggYnlnsTIdTfRvYlS2VIhntbKl5eIo1MK+WSAXsGyFo
	GaLWV9xbndCYXKFGMtTabHM8Nj2jGRo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-zm8r23dSMt-ZDECT0h27zw-1; Thu, 21 Aug 2025 16:07:55 -0400
X-MC-Unique: zm8r23dSMt-ZDECT0h27zw-1
X-Mimecast-MFC-AGG-ID: zm8r23dSMt-ZDECT0h27zw_1755806874
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0caae1so7449415e9.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806874; x=1756411674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPs2EdTZ9fd3MpWdb0ATDCa6nUqfGtFMv2uyZP7L+uU=;
        b=C5kVS6uIDD0UcNMJAuSW6rb5p5FV6krSpBYcB69j0psee2JieqemoUa1ginxkCNp38
         2nKM2395q/Le3UnLGyakj+m9moPxqfhp08FQVQa+AikSvwGzCwVjaD1BHCkePYwvYnc2
         sgEGn7r74b+jkZBDJbK6a54ZuGk3RrzO7c/uhcUDlF50K9bP7SmZ4AemWOEqlAjSQ3XP
         bYEtLCrNswUzjYN1bSPLsic+u3MYC1+BFVBtREWx6PQ+UhZVSOYRBP9aGRFRbOkipsCe
         C/tjiDTpK2cSehBqkW0zeqJGcaXJie8BpzQEbXw3qtD9CAp7fn5UUuP/raxOZ9Ea3RpN
         vstA==
X-Forwarded-Encrypted: i=1; AJvYcCV/eSmSSx/6llF87yRyTsmuqN4NTYvxfR2yVKhE5eo9dskY/3Kxg8AjFH6VpShkxkjWFfMQ7bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYuteHw8A80reaxASG6Vme7WLbcwx7krnXGzINlYzsY7Olg90
	0Hl7W/Nz7fYEWIAV2ugaPZzpY6xMGZVgyvhCYOX40fj1rIOeBX7BR6hkH0/y+HgnBr1lb28brcT
	CttcaGso587PCzfQKCtif/8AsOHcEqdMQmiWo5Yg8jfq4jYRVAng+5YBUhQ==
X-Gm-Gg: ASbGncuf7/OucEtXE8lk+173aeYAcHsOhydMKFvCbUIvhEzYH+6wWm3WOqyJIGcU4cu
	XUsil4c1QuWiiQ9PLSCNC186ncGG1BYHcIcW9VGpqBCGXKUp4g8+3cOXVIV8Az0Up1I1akDHIGe
	arox8kGOYeBELjnflRKRXnPdoc3P3B0bJEcut+EHP7AA0jXjBlShFkmDNtABZP+4JbuZh60fHc+
	ATSwYGRTtJNKD67AmkKlKicMvgnusaDUXAYXF5Kr8VHFhgEYWkPpGEWYNSjJRiRgBSD3cDnUIa9
	6X23dX+k/NPHzVzdLFKpWh8ZBOGmpPli/JSU5XpS9GYAZicCQxErbQEIA0CXtI2IHSoXRXxBbbZ
	RsaEq5bmVjzLKrSHMTScong==
X-Received: by 2002:a05:600c:1388:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45b517d40f2mr2554245e9.24.1755806874313;
        Thu, 21 Aug 2025 13:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo8ikhW4DoWVw60oDeAXqMRvn4UERlcVawLCjGel2pacwRc1R1ONhYVQm5EzuW0YIJQT4FDg==
X-Received: by 2002:a05:600c:1388:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45b517d40f2mr2553905e9.24.1755806873856;
        Thu, 21 Aug 2025 13:07:53 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07487a009sm12690403f8f.11.2025.08.21.13.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:53 -0700 (PDT)
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
Subject: [PATCH RFC 17/35] mm/gup: drop nth_page() usage within folio when recording subpages
Date: Thu, 21 Aug 2025 22:06:43 +0200
Message-ID: <20250821200701.1329277-18-david@redhat.com>
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

nth_page() is no longer required when iterating over pages within a
single folio, so let's just drop it when recording subpages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b2a78f0291273..f017ff6d7d61a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -491,9 +491,9 @@ static int record_subpages(struct page *page, unsigned long sz,
 	struct page *start_page;
 	int nr;
 
-	start_page = nth_page(page, (addr & (sz - 1)) >> PAGE_SHIFT);
+	start_page = page + ((addr & (sz - 1)) >> PAGE_SHIFT);
 	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
-		pages[nr] = nth_page(start_page, nr);
+		pages[nr] = start_page + nr;
 
 	return nr;
 }
@@ -1512,7 +1512,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			}
 
 			for (j = 0; j < page_increm; j++) {
-				subpage = nth_page(page, j);
+				subpage = page + j;
 				pages[i + j] = subpage;
 				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
 				flush_dcache_page(subpage);
-- 
2.50.1


