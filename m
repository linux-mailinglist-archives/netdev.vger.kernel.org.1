Return-Path: <netdev+bounces-215779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC57B30449
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4463163B6C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BDF34A317;
	Thu, 21 Aug 2025 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBm9EXR/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC23B313548
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806864; cv=none; b=N5DQAXXFJqSoOL2oRtbxqaKuUZgT3GBq+iAqWrvWprESoqJKYRNqwo/07STFwqwM6N9T7/7q275vifFvj6iiHiE+wKh7si0wWru4u+GgjK8wuDQ+KYi1SNybif9wJAb8xaiX+LP75+EIbgFM+5/CqrjNXhY1BJ8TXfod3Q2zApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806864; c=relaxed/simple;
	bh=XmsSbVhT3dGsaRmtyroJ024d7WMqPWbEWQJfIPHhOJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctA9+jp9yH+gcSu1Cnmkf4bnRXjWJUoSUyXjzf0Iwss+tkDBRAI5Fm4dqcbGcDDG+Hm0oEiTIbIJuOrYvZiOCLyPPYx+hdDEWULEQ1+fgNDumpRChefGt5SJ2nD4E/hNOb1fF9s8zn9bCj9Xyjn9K6zJ47TX/mAF4cyZhII7DI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBm9EXR/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
	b=YBm9EXR/HmeipwW4WmVjWe76Aap9pkGcP63uHwl13JHG9suLg1dqim3KR7+bY3tx3LEkhm
	dZ6wjHWQ/HFKpCpHwmYFVRsGVUvJZMyxr4YyQxRNmFP3dfuEk/jhnd1rN725RUcDE55n7u
	eem5OiDiPB92SRaHf2cXz/8+Kq42t40=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-L4PDMTXUNaKY4hYE5yBOCQ-1; Thu, 21 Aug 2025 16:07:39 -0400
X-MC-Unique: L4PDMTXUNaKY4hYE5yBOCQ-1
X-Mimecast-MFC-AGG-ID: L4PDMTXUNaKY4hYE5yBOCQ_1755806858
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so8301585e9.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806858; x=1756411658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
        b=ep0SXHvsJpMpJmG0x+R8Z9LZtTC+3J58JCgs7EsxuOAo/O7Z6Lq8/S5oNfC4Wx3YJy
         GPMnPK4PRBCMeF+SMYgN6nm3NPK8VhbrpytYRiX/ZJB3W9PoksH49SsVS8tz9Y7gEzWx
         d3XPPH+/KGGtWOCS9xYXcn/ljYmPjnQlxt/yw/FroXm64sdvmlyBIrl7vWArLlRLCWWh
         BdhVrj1x0FkAF6gkXC0u2SKl4QmTFyns3tDG9K+m0gIQDc9aDDnmLxk/VZHv1HghLvKV
         aDPlFi62RH61JGysK02ocglnKoWJrczBQD0moapL6xm/8YLndUCBWX+ato6Yu5PDDC1Z
         niqw==
X-Forwarded-Encrypted: i=1; AJvYcCVWLUOgHKAkvlFlejb9AcPy2d5YeDFIqRnMiCIONC5IpzJpSql8SLGGjD+YRTnyxOxeV5Mb0Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCq/c4/fSIvkPvOTwmeHSvTCcCSX5eC+SIQSJcFXFUpvQnCVcJ
	eWTirBYEV4ERV2eUG27MfFzPSz2liy4IZAF4mzAQAs6kcGQIb1hdCFxALZbYXoedU42X2dBRGyx
	sPQmfQhZeQY7NWl1TRJnKIPX5EFofSRIlbTUUBcL+9nA0URH85r2oIO/A+g==
X-Gm-Gg: ASbGncsxNsugfNcXM2FTudOXCImXRYfVbp9XakPGJ3QLHdR2ESbpl1F9Xdq4jeGWjh+
	V+PBPaleHIEZ5FLA0GAmrqKksW6GsUxGCyr+Ejun51r/8oYP/exZY+nPAxr/b8z4rua4UsZSRjt
	W+FvlU5qFVdjwadIco3OInCBKPniUpm+mgvW/BogjCQCeZLUSSUpC9ywST7Cd1Yzkiyh4HNkZIN
	uET9mLfzHYsmDv95vw+tpx7SjhYiWTIiqLErYY6mx9A1c7Yg99ZSlfZRyzA+Ttb1oj5xV/t1lAj
	eRgvFEKFiF2SKaTpYsV+ZIvPpRxhbUOoHPlVUX6Z43Oi8xa2CpUI2SVBHnCHux7XFmoTgCpaWrn
	9/OZQkL3kpq00Tj3BJHNAkg==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646855e9.18.1755806857911;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlSU80KqPPviGOLp6CI40u/NjPujjG4FLCG6NoakJIlvY80lRDOTTm20w50mEKFuk0YjVSLQ==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646245e9.18.1755806857378;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e87858asm18672185e9.3.2025.08.21.13.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:36 -0700 (PDT)
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
Subject: [PATCH RFC 11/35] mm: sanity-check maximum folio size in folio_set_order()
Date: Thu, 21 Aug 2025 22:06:37 +0200
Message-ID: <20250821200701.1329277-12-david@redhat.com>
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

Let's sanity-check in folio_set_order() whether we would be trying to
create a folio with an order that would make it exceed MAX_FOLIO_ORDER.

This will enable the check whenever a folio/compound page is initialized
through prepare_compound_head() / prepare_compound_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc030..946ce97036d67 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -755,6 +755,7 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 {
 	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
 		return;
+	VM_WARN_ON_ONCE(order > MAX_FOLIO_ORDER);
 
 	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
 #ifdef NR_PAGES_IN_LARGE_FOLIO
-- 
2.50.1


