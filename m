Return-Path: <netdev+bounces-215782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE55B30463
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18025E42C3
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11A35691B;
	Thu, 21 Aug 2025 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIRSUtF7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34764335BAB
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806872; cv=none; b=mQWkmn5rQch6bGGGcJPgrGPbyrE9V+SH6aMVegLIVpO0o68Z0cZljPuVznpZemWxJE7CdTCX6rtn6r6f/2XUYb+3Hj+V2ZQZBNffoci5j9z4u4GYT5UcShwo+SxExK7wACCNLgKGTbjRC/3bn2RZtMwV8oQ/9FUmTwghTmlKKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806872; c=relaxed/simple;
	bh=g5Pqhen6+TGsZaJhVjcxjHrty8uEIOPaJGSbz6Iayeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkwHvtbT+yJA08QqqysSOpmtpaGJgGnp4ryfVKVBC5sOsCNDYyeZlYmpcmPYjFX4QDmPYUpda7VmjRmG9IwsL+iMNZiWD9qnBJd/T9JFYREuS3qqHiOS6y3sKKFIqun8ESSAVsr8zmaP2HmamZwO5WBLRJQJW/jKfFOzklRNoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIRSUtF7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaqjYk7qiFpFT4dP16wKMuC8fiQfbkUwRRgQVKGzHC8=;
	b=jIRSUtF7Qsx0FT7WrG0s6ptvTaWbRuyOa0zj3WIy++xstX+EEKPU/aaEoPK7eplS3fmYF3
	pdniKt+n9l1WIdXbIwXKD+vnOqjE2bydKBQmH/jfjPhj0ucj04ezfkrl5NdHgKlds0kthC
	sX6p/Vv8knDVTkt3t2upH/Uf+X/Tn1I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-ourCzCYENAORx4eE1y40kw-1; Thu, 21 Aug 2025 16:07:47 -0400
X-MC-Unique: ourCzCYENAORx4eE1y40kw-1
X-Mimecast-MFC-AGG-ID: ourCzCYENAORx4eE1y40kw_1755806866
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0d221aso6547775e9.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806866; x=1756411666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaqjYk7qiFpFT4dP16wKMuC8fiQfbkUwRRgQVKGzHC8=;
        b=Kncl2syYyCFxCYBw3K9OLyb97bLAzW1bfSq+zHVAaMgBoRaCtifXNvSLSuoaLiCI4j
         EHPTG7fi/KPjxcjTRTmOSr4L1JKgW3U5QuhcsHdNJvSLR9wwopWnRK+GGZM6N0KcpYrX
         WfGsQVU/yJ4ew98KDGck8Y4O0tITjBycQQrBY/kBKie2afKQNgxhLpdBC7/+yBT4Tenn
         lDFRZvcD8NQt10ymA7/pzOCSb9kAD6AL56MZTlMZZsL2ne7IadeV4o5K5RB9xzx/i7rA
         ddVawaWEEJW1/B5oLS7MEAIfmNi/dz4+shY+8Iw/Lny7d4XU2pFiNGMHg+QstkvIRGII
         j6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnCYKgioChQFdZzQYw1gDcAUgwn9pZAtzG0lOpNHvdhtmJ6tIswPRjAifB0t4cpJ46UTlLbxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6TLGoCXVmLLNwRodBdVl3WZGW0AYAkni3nkslnO8hjtz3Uzd
	JFYIYwTtjMsvmS8zD38EYwC4Nv9XJd/BH/MeWiSG1Cu5xsk46YSfxNE+wZQ6TsvjcLPyjXH4iqy
	cW+i5g20/DpnbWJebsDWPFtyBZ7FRKjRh+m7yrrJzF9vG7k5iM1AYuyByNA==
X-Gm-Gg: ASbGncuBOeK/YXULYZ8Zx/EC7/OC+Tkam6jFi8BtJNbxbgsP2JOZMF/6h2/Y71t/9xF
	5a+MTDbFo1xjkgYEtj6EqdwEv0k2/Dj31RFgBgIcHF0Qty30p3jXERZoqKtR2r10luT+pGi4td1
	h8rCUgh26q96YhHk3iDbnEiWTwpB9GGlDmUOsGdydTsTl/wYaH26yqWi3njG6SE7uSm+ri64VBH
	7Aov2T4WxNW7vdgScVzoFfESC1eS1TreQ3qqncy7BAw/oKGfvePFdrcoksMfO1dIB2I+kMcP2F3
	+lWmbYELuiU3l0Pmx/fo8vav92rMknoks3B2N64iyrXE87p0FxNxks7PglXodZ6J2goC9pz7pc3
	I0v/Bhhd3aGm0Ax9dJ+TGHg==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr2819255e9.26.1755806866175;
        Thu, 21 Aug 2025 13:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUtzGc4rPv18tjnV22wd1xjfGI25AJiVbHUBF3o7jj7YvZLrrv8XzLc39l/Z4dCqHj4yY2QA==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr2819075e9.26.1755806865726;
        Thu, 21 Aug 2025 13:07:45 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dd0380sm8632985e9.10.2025.08.21.13.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:45 -0700 (PDT)
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
Subject: [PATCH RFC 14/35] mm/mm/percpu-km: drop nth_page() usage within single allocation
Date: Thu, 21 Aug 2025 22:06:40 +0200
Message-ID: <20250821200701.1329277-15-david@redhat.com>
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

We're allocating a higher-order page from the buddy. For these pages
(that are guaranteed to not exceed a single memory section) there is no
need to use nth_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/percpu-km.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index fe31aa19db81a..4efa74a495cb6 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -69,7 +69,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 	}
 
 	for (i = 0; i < nr_pages; i++)
-		pcpu_set_page_chunk(nth_page(pages, i), chunk);
+		pcpu_set_page_chunk(pages + i, chunk);
 
 	chunk->data = pages;
 	chunk->base_addr = page_address(pages);
-- 
2.50.1


