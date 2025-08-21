Return-Path: <netdev+bounces-215803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D6B30579
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5ADDA03736
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6D38103A;
	Thu, 21 Aug 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5QJHxLd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D9D352FF4
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806931; cv=none; b=ZKCZbibxIYFYZnnC1+S3gyuMgfhEQ3b/HQTlWxWWsx6KKmosEGK8Dx3Tqud/Lcqoj+SLPW03+JHZdo1rpEknaNdgkq+DNkUV4BbBQazSc1xeOGW8vDbYXOFJobRsqtkC6MEvzYg/Gj6n8k5rtqQn5pmEQDdWbDvR37ar1Kx+0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806931; c=relaxed/simple;
	bh=izYuZWtM9expuJ4aw1W3JEFW5k9djBINp3Pti4HydYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIerm5Pe5TVrqIi4dq00gEIou5pkYE1kxa2id0AIUXSEHM1aSirgTDJBMAXtXsJalBoSyMswAG2g7a0pIyKxvcZSAYz4QK4s9cZ4eJVgR1ZFJXU39RqC3kCmgC4VEmlXvkqttaDfV1aB57eGXCkFLV4xJVqMPyTC/mswQy7f/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5QJHxLd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7iPpUiW3LrFM0W3XrB+Z82uodwKTsefoCzXwhLbLUo=;
	b=E5QJHxLdPgsdCb5LzJjnLtQAvvAIbPAekZVKwIOUCnCe8tpd33hvY79DMDI7xT6OajjY+9
	TOsxGDlA46qhG8jRyT6GzFHnikW5+16xDm2KJqXwvFoj5T+Tp/EhZdKZTSItK2mLYBPvPc
	mBjyeNtaESJUXkccpYhhsUStcmvYtGc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-ubw99TQDNXGc0hz-3JYNCg-1; Thu, 21 Aug 2025 16:08:44 -0400
X-MC-Unique: ubw99TQDNXGc0hz-3JYNCg-1
X-Mimecast-MFC-AGG-ID: ubw99TQDNXGc0hz-3JYNCg_1755806923
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3c380aa1ac0so519640f8f.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806923; x=1756411723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7iPpUiW3LrFM0W3XrB+Z82uodwKTsefoCzXwhLbLUo=;
        b=CrPQ2752nlNXfMFQ783AmPU42F7gCESkdMNBa45oMJUG3fVI6qAxv2ovhatgwplf4B
         ezjCoee7NYa2noGA6Ld+zxxpn6k26UC8KATSOqry3fI51qxnudA+KHlIJVc18kkxau+8
         Ift5MkN4JeKX6jVxFxYoOal9NLD+uSnQLq8q5LBDWBeAv8i0eWQtgp1YElM14PI7VA9q
         sV84um2NWWck2QXmLqEBcS0vLlqgrpUuf8Hn4on07+ZGV4kaD92N4R/xEzMDRore8/uR
         obhgzAl4qET5IBjGKlB5KT6RORcIV/FzStJUIP237tWXxlX31ehmbGchUGZIZpFKujKf
         iQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXa55nAcaQFPMoaYfCTD1beOB38ZXaXngMctZVdxF+6Rl03JEK0x1cpG9AHAI/oxA1u2BJiHjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXsqhdYi6i8ASQ1CqyybqMd2VWA/OW250Npx8IfQ412bG7JiEt
	kQoIvHgj8q1j6ET3cOFCGEPGTCqn5ZQIhLTd4haTcrkLBWK3yEvwj/q17YHinMHqv8N3kvgrvKW
	Z66hiHg1I1+OlrDLdOnPGUGFRSZBE6hshC9qqzTdsU86R7v9WgYrjdG+O6Q==
X-Gm-Gg: ASbGncvmHV/rz3PrQmxCxmtauaOdk936kicsH1UNr7XSuEeMJTnKUEdMQbucaVbUin3
	c0fvf/6OgShEm4j22CNNZP4G+lFYxfw/TK7pU8TGYHznp+oTCZaS1csDpyjrdEYuXgdO6Tpr9n/
	O6zy1FlMAy/h8uKpMPW7R93j7UUbFDaXXq5WBISsQW5aHCHZgDl6eRjvgrpgA65Pob3i1twjAC9
	6YF8dgNG7nBHDzJZazn5skqOVqORbhmO5V2noFTvOc1q8DFS6irsXQjNWd61+JI1b0Q3+Y97gWT
	3u1hMozV4jpVOxh5QFB406HNAoSBVQv0eil7O/fEy1YmfBEl7E/t94wZyWbruReMGSdy7EdNaEx
	N2EXu3TrdH5WtlC+yw6qgbg==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3c5dc7313famr204666f8f.33.1755806922942;
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnHzRKC08dohUKQD/XdldMc6IWYVddiLtTh8Yidep5vx+5++gzVG23SiimMwYZ+HldR36Zkg==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3c5dc7313famr204645f8f.33.1755806922505;
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e3a587sm10028205e9.18.2025.08.21.13.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
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
Subject: [PATCH RFC 34/35] block: update comment of "struct bio_vec" regarding nth_page()
Date: Thu, 21 Aug 2025 22:07:00 +0200
Message-ID: <20250821200701.1329277-35-david@redhat.com>
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

Ever since commit 858c708d9efb ("block: move the bi_size update out of
__bio_try_merge_page"), page_is_mergeable() no longer exists, and the
logic in bvec_try_merge_page() is now a simple page pointer
comparison.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/bvec.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 0a80e1f9aa201..3fc0efa0825b1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -22,11 +22,8 @@ struct page;
  * @bv_len:    Number of bytes in the address range.
  * @bv_offset: Start of the address range relative to the start of @bv_page.
  *
- * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
- *
- *   nth_page(@bv_page, n) == @bv_page + n
- *
- * This holds because page_is_mergeable() checks the above property.
+ * All pages within a bio_vec starting from @bv_page are contiguous and
+ * can simply be iterated (see bvec_advance()).
  */
 struct bio_vec {
 	struct page	*bv_page;
-- 
2.50.1


