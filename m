Return-Path: <netdev+bounces-215787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA5B3049E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D89FB648FE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D16368084;
	Thu, 21 Aug 2025 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g80CNirM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC736206D
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806884; cv=none; b=qoKNTLtIGtIIUCcoIyD4taNe3hyMZYuPSEL2vf4USEmt9IwJ8ptjOpJO7D02ZAhCu69KEmeZxfGyJi+Om8Z7BUeCNpqHwt7lGkI/i+mR+tqOhjDF4vKz4xSZRm0CczZJi9Ojm0xTMpTvDwyrGRuSeiT/GrcVJnC+lu5Q0hQEzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806884; c=relaxed/simple;
	bh=zuH5Mfr3MXrb3Q6KuIuEbIGzhyvXbwh1EOpbXVleP4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGEffWwNA3voEehniykFkmrqajVeJLEjK/IwbCyxHWtZsTl/Hn6u8N4A5tDN8GPA8QlzvuMV9r8xGZQ9x8HWDL1BJJGfcyYQJlNEYtWuArOIiJ5GrqZJ2x3fWPYtVlvkth+1kbGJe4Hvsc+Od3BZR6TPQzhIhRpsIDC7GCyXr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g80CNirM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hICKs+PYshPEfoclHwqOXtWPheskj6p8LyRcJkrFnX4=;
	b=g80CNirM+XKtd5lCB8seBW95EVoOYwWRh+oRieBSB+hTQ/OAFnTZ2QRD+MpCwkJonxsPha
	kHGbgxKNI1xHQKQq5qxt9CVy68m43ZgBoAcGd8m+ySiDKu3fZ1ccqafrKvwqNgIYuqt05Z
	r8dkKgBNIu324SVLDqQAgUCFZsRSEHI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-18W5_EhgPdSZsQmYGsByTA-1; Thu, 21 Aug 2025 16:07:58 -0400
X-MC-Unique: 18W5_EhgPdSZsQmYGsByTA-1
X-Mimecast-MFC-AGG-ID: 18W5_EhgPdSZsQmYGsByTA_1755806877
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41bda7bso1053981f8f.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806877; x=1756411677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hICKs+PYshPEfoclHwqOXtWPheskj6p8LyRcJkrFnX4=;
        b=Os0leD+9QpAimAz0celkkS9+RwR4meCxc/rTyQQUapdpotKC73XssZ4MEFFZiCPfG2
         BX/20aclwOmuC32vJ1kOmAqwO/F7F1qCx+yHyzX3qAhU3EnatsOKfBK1NbCgIKKF0qJa
         ZCChJ7XytLnpSi1bDCT90Q8aYq49m2DQwOmvGR5pqfKjFQCaB2X5D/gqapwkvzkebtKM
         28zYqr4b6dlIICwKmgLAsb/55JYgjkXfnpJbTHhhpeIeRsrApCU4Kxm2nojz9CsKtIPy
         sOOj1/1fXg+3ZlWETHA/JxI0DOIAwXOn309lLlgWuH5Wwhy3GJmA5UEIifCotD6C3m04
         mmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0eCk3wqkmZ7XTuuUMLVlg9e/f3rxzbKjoJYX5EPUGVP3VJ6ynMFL/aMID4k2/Jxjy1p6F6KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVnNke3/hdUWkIaAKXdRL3MuTBSMaS8/IOwgoLtO2pQWtDHJm
	S3s1LNpYf22iZalwz03vUVigQYcvvJ3XQE6a8GUSQAV8hp73tkfJYwZZu1xyQEZfWPO2LpDJdAk
	RR4TCaUfDRRZ+0pHeZYjGMprvnsNMYa7EbddfZ0Co0N+PT6IhlcHjAquY2A==
X-Gm-Gg: ASbGncscWAyZT1k3Ua6Skv51rURvdydNIUv0uUJoKenJtrjm+ujZTUWeEXjVqBDfZ5Z
	BGOjsj6RcLoY+SpEVsVzcwGehUrQ/t6Ck2DWxaC9+PmAJ2DBr7ro1wx1fRjkqiDDi2v7APE8KyX
	5X0ahH8YxeGy9LcDGyHw0/InhYb9z3V9SYI6ks6zgEmUNBRTyZiXKhSODSwSMxpeR3WBYdHT8zz
	3Iv1TxWbz5IHmn/CtcvaZQ3uhFcSmuqp2lYu4U/Q+6mzLbJMPQ6rxmY2nvDorr6q85ss/0IQHyF
	tzJRDCc+rheNSvsWU63g/6VuIidVEZaJcJZXB7uJ1gcS2WyhXT1srGzu6kIu7rP+RJYDMzpt9YY
	c8LOmet11EIVMsv/iVSytcg==
X-Received: by 2002:a05:6000:1789:b0:3b4:9721:2b2b with SMTP id ffacd0b85a97d-3c5dac17062mr195821f8f.12.1755806877251;
        Thu, 21 Aug 2025 13:07:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgVLjhFaRrDh3LOBLGV7UmH7wFAxvy1IR++ErfO8cOP/XFU/ikMyZpM3bVU7Jjqctj1mhmFQ==
X-Received: by 2002:a05:6000:1789:b0:3b4:9721:2b2b with SMTP id ffacd0b85a97d-3c5dac17062mr195797f8f.12.1755806876810;
        Thu, 21 Aug 2025 13:07:56 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c4f77e968esm2903478f8f.21.2025.08.21.13.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:56 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH RFC 18/35] io_uring/zcrx: remove "struct io_copy_cache" and one nth_page() usage
Date: Thu, 21 Aug 2025 22:06:44 +0200
Message-ID: <20250821200701.1329277-19-david@redhat.com>
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

We always provide a single dst page, it's unclear why the io_copy_cache
complexity is required.

So let's simplify and get rid of "struct io_copy_cache", simply working on
the single page.

... which immediately allows us for dropping one "nth_page" usage,
because it's really just a single page.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 io_uring/zcrx.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index e5ff49f3425e0..f29b2a4867516 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -954,29 +954,18 @@ static struct net_iov *io_zcrx_alloc_fallback(struct io_zcrx_area *area)
 	return niov;
 }
 
-struct io_copy_cache {
-	struct page		*page;
-	unsigned long		offset;
-	size_t			size;
-};
-
-static ssize_t io_copy_page(struct io_copy_cache *cc, struct page *src_page,
+static ssize_t io_copy_page(struct page *dst_page, struct page *src_page,
 			    unsigned int src_offset, size_t len)
 {
-	size_t copied = 0;
+	size_t dst_offset = 0;
 
-	len = min(len, cc->size);
+	len = min(len, PAGE_SIZE);
 
 	while (len) {
 		void *src_addr, *dst_addr;
-		struct page *dst_page = cc->page;
-		unsigned dst_offset = cc->offset;
 		size_t n = len;
 
-		if (folio_test_partial_kmap(page_folio(dst_page)) ||
-		    folio_test_partial_kmap(page_folio(src_page))) {
-			dst_page = nth_page(dst_page, dst_offset / PAGE_SIZE);
-			dst_offset = offset_in_page(dst_offset);
+		if (folio_test_partial_kmap(page_folio(src_page))) {
 			src_page = nth_page(src_page, src_offset / PAGE_SIZE);
 			src_offset = offset_in_page(src_offset);
 			n = min(PAGE_SIZE - src_offset, PAGE_SIZE - dst_offset);
@@ -991,12 +980,10 @@ static ssize_t io_copy_page(struct io_copy_cache *cc, struct page *src_page,
 		kunmap_local(src_addr);
 		kunmap_local(dst_addr);
 
-		cc->size -= n;
-		cc->offset += n;
+		dst_offset += n;
 		len -= n;
-		copied += n;
 	}
-	return copied;
+	return dst_offset;
 }
 
 static ssize_t io_zcrx_copy_chunk(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
@@ -1011,7 +998,6 @@ static ssize_t io_zcrx_copy_chunk(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 		return -EFAULT;
 
 	while (len) {
-		struct io_copy_cache cc;
 		struct net_iov *niov;
 		size_t n;
 
@@ -1021,11 +1007,7 @@ static ssize_t io_zcrx_copy_chunk(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			break;
 		}
 
-		cc.page = io_zcrx_iov_page(niov);
-		cc.offset = 0;
-		cc.size = PAGE_SIZE;
-
-		n = io_copy_page(&cc, src_page, src_offset, len);
+		n = io_copy_page(io_zcrx_iov_page(niov), src_page, src_offset, len);
 
 		if (!io_zcrx_queue_cqe(req, niov, ifq, 0, n)) {
 			io_zcrx_return_niov(niov);
-- 
2.50.1


