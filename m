Return-Path: <netdev+bounces-215777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDF0B30413
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7DBDB61BE1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A312FC01E;
	Thu, 21 Aug 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2YLdUZG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C8B2F362D
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806855; cv=none; b=SHNGulUod8DQwTdKoP0nlU9dhLUalRwhkWsm9O4lp43fqryBFxELlgq88m1WX10JD1vHWZRnqMt71kNqTEK7qvZmDw38jYvDs35tfnlGUeFD/G+crEhaxvC2BUPrhNCmi0oUV1Z7Mno0IOfzdBknKZrnahEUebOyeJizyyxMlcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806855; c=relaxed/simple;
	bh=ncGz2ZUizfxPtBenqYCMYHXawyPm3K75je3+1YWzFIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFCSCckB8KyoRhc3zG+KOcJE2PMgHd56yMx5sm3I040oMq1hcy7kXggJIMazfACWhTwXoLyGECrLNId9ABpkwujeh+mzceyvo0NqNwurRx8U9YVndoU7o06lJuoF5tAn9+6oeBJUyzXikYaUwGe7I3dH4NS3yo9RpzBJ4FDESQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2YLdUZG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
	b=U2YLdUZGGiEXDAfNBfi4lKqdJfpUYYvX0WK/s62sv0Sg/C+1YpqYmZzMpaMxEBp0nlt8yQ
	rW5NnrkM35qq0uq2lGUhWZqd57XdOPQIlW5eD/vphwDnKvDX9dR/eimni5UcqffnkVqm7B
	o3QbolgHk3WZ1pEfIxQMUC1+brKt9Vc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-wdk4l27GPUy66-a7783cGA-1; Thu, 21 Aug 2025 16:07:31 -0400
X-MC-Unique: wdk4l27GPUy66-a7783cGA-1
X-Mimecast-MFC-AGG-ID: wdk4l27GPUy66-a7783cGA_1755806850
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso9773845e9.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806850; x=1756411650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
        b=LJmraS+ll7rua7Bwp9CXxbDZhrD+oqLk+tITnOyHA16X79Rk+MszlH4nxrVdcgpPEs
         K6oiX3JDZ5L5qEPUt+TOFGy2fswob0aHeJfjDg4RghbzEcuCRcxjtv5+EVVkCTiAghS6
         WfXy8VZ9MYIux8lC8BOe77Qf2rAqKviPT449nW7E4svgK4JibJURYtXkLkJ9Lbp2wDDv
         6l9kiVx0eYjU+JVvPE2eUhvoK69LjlqLWX5VIFBFHyHSKDnpLSh/+Ow2UJDZw+RI/OYE
         0cWUJV1JN/t1GGViPAxDhPkLNGhuy+LcagTi/hBmj931mEORRLy+HUeUTrXATNldF3Lp
         y7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3QfFbHu2MI1oRP3U/7UfoOU9Wm0QJ0/B91Nts+fUmgvZEYEQbwaDhWQ3i18lL1gB8HeFMbU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhEjPtNlGwDYrcTfnmCvZiCHr5jrzFqug8RHH0I7/T4q4YFv95
	jwxbCfqEQixdSDIbNWnMlgz1mf8goZ9hVA/kAkFTmx4GvxsY1lbOUCrKLOmk3fgX6fov0ym1xhQ
	Hzpu/GWdgeHDZ+gxWYo/TvjBpgryc07dmkhqooUqn080NH89LB29v1tVKOg==
X-Gm-Gg: ASbGncu4lZmhiNdgU79bGm6zOazijmChPO56ZLRzMwbhl/ECWvVIowJJ+hhhwRq5rwo
	5FYWtuBR96KGPFm5SwFdfxZHkwEhU8bAP271F0J4VKexmFOlwyYsxDGQC0rDYkERJOInqYClLLd
	0HAOoDFdkaw2WmsG6efzm5NLOtQqG7TfS4sXBcmG8Sfs086jWkrhdUbEZ0lmhH7q/Z1FcoBW2jQ
	Tri1rCnyMpa3dp4feXZzlO1tm1zfr+Mn5/FBKP+XRAklV5SAwuzIWqXy8CoQDtgMMP/SecUGzAt
	3aWZyGQbSdyYMpZ1U8719NHbr6BczmbUJlrqM/bUSbZtpcRfO4zEXWq1e5w/rAh0KzqsS+yj0uN
	XIg0dRAfpu6NqQvOH/d+ECw==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2956035e9.31.1755806850049;
        Thu, 21 Aug 2025 13:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPNoTdvVqQJqQwQf/z0aFpcDb/7HunF1Y6KwbAqmFFF4D3cnAaKEmAnoGbjwE6N5eIepmoyw==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2955545e9.31.1755806849496;
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c3a8980ed5sm7242256f8f.16.2025.08.21.13.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
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
Subject: [PATCH RFC 08/35] mm/hugetlb: check for unreasonable folio sizes when registering hstate
Date: Thu, 21 Aug 2025 22:06:34 +0200
Message-ID: <20250821200701.1329277-9-david@redhat.com>
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

Let's check that no hstate that corresponds to an unreasonable folio size
is registered by an architecture. If we were to succeed registering, we
could later try allocating an unsupported gigantic folio size.

Further, let's add a BUILD_BUG_ON() for checking that HUGETLB_PAGE_ORDER
is sane at build time. As HUGETLB_PAGE_ORDER is dynamic on powerpc, we have
to use a BUILD_BUG_ON_INVALID() to make it compile.

No existing kernel configuration should be able to trigger this check:
either SPARSEMEM without SPARSEMEM_VMEMMAP cannot be configured or
gigantic folios will not exceed a memory section (the case on sparse).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 514fab5a20ef8..d12a9d5146af4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4657,6 +4657,7 @@ static int __init hugetlb_init(void)
 
 	BUILD_BUG_ON(sizeof_field(struct page, private) * BITS_PER_BYTE <
 			__NR_HPAGEFLAGS);
+	BUILD_BUG_ON_INVALID(HUGETLB_PAGE_ORDER > MAX_FOLIO_ORDER);
 
 	if (!hugepages_supported()) {
 		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
@@ -4740,6 +4741,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	}
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
+	WARN_ON(order > MAX_FOLIO_ORDER);
 	h = &hstates[hugetlb_max_hstate++];
 	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
-- 
2.50.1


