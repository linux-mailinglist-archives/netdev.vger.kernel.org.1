Return-Path: <netdev+bounces-215774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14EFB3040E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C55B3ABF24
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8058636CE11;
	Thu, 21 Aug 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbucRQ54"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D38369999
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806847; cv=none; b=SH+09R9kM8mNPKjsqamNdw5mpjlt/wViMs4ixho6Do+A4dwPhxNEYwvhCKiZe1/4U3i0tQmoxOXcTDhP69irIXZmbJAknAJvmeCw6JAvhYJc2fAswbD7B8D10iB9gOdZULnHlKs5pv5+gzqOjwjJJdkO2mb9h2pQl5RCRxoBwto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806847; c=relaxed/simple;
	bh=vLP4m8ubY62ddowshnJEYGhNc+fB41I1n0umGIUlXAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9U0zMnsp40ehzkCYGc0ZRssgm4gu21ZZOPJJFptLn1CkCewNCTpRVnERrRE9LeSSbDc0KR/Z4GVaVrayrmt+2h8A4QP/a1e476dskkMdMHKjxDl+mybEPIH9tuORlteXCif7QV5a/ybSEO7qHZsxu0HQ4MvVgDAeuodO1MpgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbucRQ54; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
	b=hbucRQ54sDPTGZ3BfKd563mrpC1xIJBtBESlBPfW0Mz0enbCpRRcd0bD6P8XYBStaUOvrs
	q5og+I2I2OYzZODlRzYY2Zvf0KsB2UDdwySTZfoYKdxzUV+p0HTYLy4CCvRztjDk5g/fbK
	touBRH3plwzJeqDoxYRw6fB6/tpnsqI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641--02QT9GjOGmp7E1h1mofSQ-1; Thu, 21 Aug 2025 16:07:23 -0400
X-MC-Unique: -02QT9GjOGmp7E1h1mofSQ-1
X-Mimecast-MFC-AGG-ID: -02QT9GjOGmp7E1h1mofSQ_1755806842
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0b6466so9581275e9.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806842; x=1756411642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
        b=ZRZ5FMX0scLJEfhrCvESmk1kw8PkxoCHkamlRiBxpR4Hr8GvkLYN0zB5bNPo0vuB5P
         9Qwa1vBr+dWOyRBnZI4JTyY5Jo+Xt6e/XJJA6m7MVGf0vsLHaMj3w3xglXeNBu17RE3d
         N8djCEauvnEPKTUxIPzEwXmKT7NoxLxxpgwZC65FkdZoNAHI3EQjIR1Ll6+TICdJYbLe
         /vr2YsPCyH5ewgfpRgKBNyRf1dO1k+F0G9xINMUcPINDjqgl1JWbJsgRUEmJgR+QlozB
         LkOFi586N25f0i0CzOxBL/Rjw4SFB4/o655Q34PADlSwM7gfLdliSvPX2r6KnzZqBYg5
         BeSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHnXL+1eBwEKCmRFMqzUVoHv2HpFdEsdHBIM0FHZNMGTv6MCj5sKpkARiJIzD8gASYEnadTEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7mHKvLhHiWKMtt8E+/qDXwucdZbg0tsqhhkCYBK3CS7sibdr
	BsX3ee5pMfQdC1qvkn26ioesDkkOtmPRUvXykUpuYT+amSKHtZr9SYVglTlljRqdBFaV/VLShqj
	wcNWdZ+v3s5YGMwGTyOb8+eeTNakuXMGnkOEGT1unecyaSQXUqnQuXlpVLw==
X-Gm-Gg: ASbGncsD0Lh7irtZpDMTHK8z4oHmY1EAi7LfsA5mVx7TlbZveSjEz+MlX8g4cezD7fg
	uBEvRUyaBSEDXoCElfHo7Jp2naBqE9KTl4Ad0BKz5EPdUTxPb0rU6sNzvyhgYXO/1xb+8XmsHLg
	ASKHB3YOZ0uLUPp3JOHJv2CkMpwsADa0vcBfgVInNRHvn4P2sjoYk55hAabfNIL+Uz1pG0l4xO5
	iqzJ4JOmcgbquhxsZE0vtvGdA0rDe1WAKjKkeKri77G5PcbUGFddMdwKlXu5lkgnghA4cnrtHg7
	YVIFYpvABnVYU52ZTgUWksXPLMHlIoB2xmDLri3E8slQNYcimJKnXOgnuuctZ1X3zBsHY7DGZHS
	MzjutIrNOodplmZN7XsRUuQ==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412685e9.14.1755806841716;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtBnzBdejX2oNj8vG9iZBZKJew+pPrkGWxHzVnhFEnb5RkXIsj+cBFTtJrIXnzr/4lYhSU+w==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412295e9.14.1755806841198;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dc00a8sm10960275e9.1.2025.08.21.13.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:20 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
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
Subject: [PATCH RFC 05/35] wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu kernel config
Date: Thu, 21 Aug 2025 22:06:31 +0200
Message-ID: <20250821200701.1329277-6-david@redhat.com>
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

It's no longer user-selectable (and the default was already "y"), so
let's just drop it.

Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/wireguard/qemu/kernel.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 0a5381717e9f4..1149289f4b30f 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -48,7 +48,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_FUTEX=y
 CONFIG_SHMEM=y
 CONFIG_SLUB=y
-CONFIG_SPARSEMEM_VMEMMAP=y
 CONFIG_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_SCHED_MC=y
-- 
2.50.1


