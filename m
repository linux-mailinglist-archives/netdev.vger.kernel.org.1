Return-Path: <netdev+bounces-215771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B71B303F6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B58AA1F35
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94686350832;
	Thu, 21 Aug 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUBaY8aG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49BD34F474
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806838; cv=none; b=HUGvWlkiy47JuZyIxv5XVujFvHQclZkiOGgi1fT8xgmRG/KLLkzjRzXmCEh2BOCHuZuC5bx4pYNPrANIFl0UfdeL+pldQwDCOtDwZxhVHJkEGkiuiTWrlzOuGnl9yrVMB29m/UdaRQJkm2TrZwvohw4dOZ0pQbFNQWASYQzUtZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806838; c=relaxed/simple;
	bh=3FOM28sJXvbUF2Tn/5jLCVekviR1dLu1+OtM4m//AQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFANAA+rvWDvJ9ve9O8VjWz0GFHVAmf4EEGqy44WJl6pPkHZCri5wXeLltywBaEUHij088kQnLYHtlo8XcGyWTKqB04Jy59e+nbcjV5+ZTHSfeAPJCUVTQzgJQdZMDlSHDhDzcsuCKbvjgNVZx+009Wh2T/M9/L/ZMFXsWtolNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUBaY8aG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
	b=ZUBaY8aGc6h8AaVVkeyTLZ3J+O1D+D/c8cVUbV19LJv6ZIKVbXabLCyTrOad47hDCgnktr
	RRuDrA7m34WEiR6fwoRZHoEFArIqXrONt6ywnM+0+d5IkIZjr5pYP70a/XseYFqWNgLQc+
	SAAkVUJHYT7W/shHWSZuLf7wwSq0iVE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-e4S0yunLOkGtcohhJQjz6Q-1; Thu, 21 Aug 2025 16:07:14 -0400
X-MC-Unique: e4S0yunLOkGtcohhJQjz6Q-1
X-Mimecast-MFC-AGG-ID: e4S0yunLOkGtcohhJQjz6Q_1755806833
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so7730705e9.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806833; x=1756411633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
        b=p88RZR0UqqSZ51cWf0xdGgAtDGd7gXet597kirOK1kY6su9swjJcRUwKPvqQIjk/Aw
         FH8BDvchjwJ/L2TXMbH9e68PEUjzMbwFp8u+XY2NhdubJX7qv4doToNnDW6fPHMOo/e+
         9dFozAX+qYHSOpp0O+Zv6u8VaPJojDilbKnTZlvaUtkOLqzXUQiDrV5liun/RtCSLTH7
         HvBLwK+pKiHOWmhkucErNmvV/59IwHjQMmJu3gr4gbwYHD0E81IKYzHkf/pLUrvxKqNY
         WXuytaflD7FLgvVLaeGks9oziu0gD7uFNeHFKgA8Ju48Wiq2ODR2n0wjHArjvZbGRHbI
         q1sw==
X-Forwarded-Encrypted: i=1; AJvYcCWCHz/huPpNfl3U0bvoGb3Ae8tNwTT5ekGdWFvxc5Q9fnkRzINq0rGT8jzPAMSySNofQ33y48k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS36amSHI50vwi1fQ/CFj993g1v1/AuhJEcNRbjWGktE1Qkt4f
	l2Jut1+8GPsu3NT7QUatVJGHjFF4YEsflRXbjCS0L0l2zmenDGiF26rj71e8Us9INHmTuJBXNa7
	p8WsxJjyMF/0O8FdJw/ya2z7jIETvqW1FdM5IudmsiImdv/o6P3q9+paXWQ==
X-Gm-Gg: ASbGncvkf0NN6xW5RzNm/Cj5T/ixJuP2CRyzqywrW60umlriLBkPLirOytR/DNIju1+
	+WafHKhB+pnRXoipA/6uqAeXdxVe79YV26NYVTjCV+X2GoHQbmZW34IcWGZXfjbJMxEEYEtDcb3
	LJ92C8g+MloxCrBGPG4khpbch5ajwCT+x95CTldKJNedatHU/B9Oy3sK7OoQpvp9kuHloEP1xT/
	dwXUvXJwqLRZ7BXpNGpgTskXu/IDnPPbcz0fOO1cWMHeeu8hHL2nQ13BFGOUoZVyyJqLWI5CWcx
	PSitsknOlJVWCLsNu+qpWP6MjewvPdktigT5k88FXjsn+XWFA+y7xYpTSANtlqVlDhIM2SiD/H0
	kphsZZnN6z8rzx/A8HdRUBQ==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2598525e9.14.1755806833367;
        Thu, 21 Aug 2025 13:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSutx6qbatKffMJ28UfT2ZDXFlSv+vNq81oYks3KAGI73zxxTWKo8ClwQ/mmPq6W0wDfVQow==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2597955e9.14.1755806832889;
        Thu, 21 Aug 2025 13:07:12 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c166bsm12916801f8f.33.2025.08.21.13.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:11 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
Subject: [PATCH RFC 02/35] arm64: Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:28 +0200
Message-ID: <20250821200701.1329277-3-david@redhat.com>
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

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a64..b1d1f2ff2493b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1570,7 +1570,6 @@ source "kernel/Kconfig.hz"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config HW_PERF_EVENTS
 	def_bool y
-- 
2.50.1


