Return-Path: <netdev+bounces-149096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952E9E4295
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 18:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809F7169016
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E5E214A83;
	Wed,  4 Dec 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="LjebwYQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7D214A75
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332973; cv=none; b=ZhObGGRPrYDS/OiDtKgrZR2a5KDH7fI4Y5OfdFVLLkZE6YjUgJfmHE+C0bfvPKhoBIMwl1OmeCu/x5vROOya65ArVBqf3O+qmLpBw7dAE+lTwMTB22QrkmUwegvsBlSZxWyaZfmDd0WH35PS+GJC7VVT1Kl/iW6xppAp5kJLEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332973; c=relaxed/simple;
	bh=U4Cdy5bsVigQBeIL6KWDF95WYZe8Tqk1pM22YTjXHD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LROKsfiTNzursMQBGMjdvvuVr42AVYNI0W8sVySmuo5jvUnAjHPCs0U+WAQLByC/eZM6JxmkYFSs0kKblUNQSYCDBasXZTQ4Gt9l3qq0dPpX5EYUNSKhY1l9K+RE/1OlBWd/00K87nx0Ezbm0yb5OR2KCjYimzR154Zzyo3v7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=LjebwYQO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7250c199602so62666b3a.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 09:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733332972; x=1733937772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ull/mV+AjRgR++Q1JZdqTKwRQ/UNffKR3r7S+Qmcp54=;
        b=LjebwYQOznhQZqGz3L5QGY0WtGz4sfW/bhxQm9Lc0T2AIiBxedJZfmsdfOmkvgHlcU
         i9jqss4VwofNqphP1xFgxCSTqswIAmJ7h1b1BemvAOfqdNjmkkkSPeUfAJYGkVH9b+Nx
         qp/NXYa+xYKQrzY9jDjMzPJtGASJbLvftURBEF06+hymTsRJlM2tuThVJYGqMQAwof+Y
         K4vNCOKVjUlxsbLq2fdnvDhYQzKY41Wlvd77F15Q+8HJNNnD8uSoulfsMkvh3TRMSVR0
         kEiTH88QX53NPNDOsZ5HQR710T78TmoU72OUxGsQ4EZv9e9Nxx8sRWMf7IeQbTpgmUCK
         tgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332972; x=1733937772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ull/mV+AjRgR++Q1JZdqTKwRQ/UNffKR3r7S+Qmcp54=;
        b=gzO3230QzAEYLugN05wO9QCrecAT5OOZ2tbIQfgzeUFn5Z020Gc9BAnCeUMA8NYgD+
         QKxHJvFU+yXoczbxTVCaEECDxk6TULReqZn+LqCusxbV1XmZneQGr9IFwIiBk2hRk3E4
         TAkfTvDSTeZ7id5iIOhuWKNBZ07Tkw1r0GvOcK9UcH//53g3vTR9yugHfFH07sXBzhbp
         HpkgdU39Lw7/AsT2Vfm7Pb9tqmUZF0gzkQ5JMGxRciCfX3q8P9aJygUQ2pxdzoUO2cOG
         y/9iWV9pcSuRWUt4Y+tDv6NoDrxc9SN3XRXx2EdV89v6dVDQrTZzq1mmpg86TtfMYE1r
         yNzg==
X-Forwarded-Encrypted: i=1; AJvYcCUVPt+2jxwRGRF9YqCwIh9RHIc40wObo6b4PGdQ/fkY7KqTj6Wz8VL8s+XL7L3F4p/y8CABU9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/1iu/EAGtOGSf8kzvtHJICn2m8jPsW0w1w8r0jh9tOguQUGdF
	bbeDH+JoMI8/AlEcN9WlvMghysSyBeS5WgfOKNocb66jQHRe5mXl9U/DBdOXJzc=
X-Gm-Gg: ASbGncvAbZExkPMdvRVktL0+onFGeByEUg7be2LI68pAQmEFugRQqgavyRCpCiDiTnh
	WDtPjFY1LnZN5zimi1OMFTAsfnjQJFN+kqJspBl+WN7K8mrr2cmUCtOvhJALW41KOL8g0cnYLoE
	keiIaNdAeJIhaMUI8T+IOb8Jb7EdqteIlzc0s/hUOD7lDMZoYUZpzxeppijYPmLWcBOrQlzlsBx
	tsWZ2c+//PQQbayI7aXZDuSZr+o1AR9W5w=
X-Google-Smtp-Source: AGHT+IGOTgkLRnA4czWTMkZeEXKvCq1PTMgt5kmHHIjqfFD7w7UmXVYqNmZZa5sXoC8Pmg6yWW7SZw==
X-Received: by 2002:a05:6a00:1487:b0:725:3bd4:9b56 with SMTP id d2e1a72fcca58-7257fa44e93mr10562740b3a.5.1733332970951;
        Wed, 04 Dec 2024 09:22:50 -0800 (PST)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2e1b2fsm11784589a12.20.2024.12.04.09.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:22:50 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v8 07/17] net: page_pool: introduce page_pool_mp_return_in_cache
Date: Wed,  4 Dec 2024 09:21:46 -0800
Message-ID: <20241204172204.4180482-8-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204172204.4180482-1-dw@davidwei.uk>
References: <20241204172204.4180482-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

Add a helper that allows a page pool memory provider to efficiently
return a netmem off the allocation callback.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h |  4 ++++
 net/core/page_pool.c                    | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index 83d7eec0058d..352b3a35d31c 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
 #ifndef _NET_PAGE_POOL_MEMORY_PROVIDER_H
 #define _NET_PAGE_POOL_MEMORY_PROVIDER_H
 
@@ -7,4 +9,6 @@ int page_pool_mp_init_paged_area(struct page_pool *pool,
 void page_pool_mp_release_area(struct page_pool *pool,
 				struct net_iov_area *area);
 
+void page_pool_mp_return_in_cache(struct page_pool *pool, netmem_ref netmem);
+
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d17e536ba8b8..24f29bdd70ab 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1213,3 +1213,22 @@ void page_pool_mp_release_area(struct page_pool *pool,
 		page_pool_release_page_dma(pool, net_iov_to_netmem(niov));
 	}
 }
+
+/*
+ * page_pool_mp_return_in_cache() - return a netmem to the allocation cache.
+ * @pool:	pool from which pages were allocated
+ * @netmem:	netmem to return
+ *
+ * Return already allocated and accounted netmem to the page pool's allocation
+ * cache. The function doesn't provide synchronisation and must only be called
+ * from the napi context.
+ */
+void page_pool_mp_return_in_cache(struct page_pool *pool, netmem_ref netmem)
+{
+	if (WARN_ON_ONCE(pool->alloc.count >= PP_ALLOC_CACHE_REFILL))
+		return;
+
+	page_pool_dma_sync_for_device(pool, netmem, -1);
+	page_pool_fragment_netmem(netmem, 1);
+	pool->alloc.cache[pool->alloc.count++] = netmem;
+}
-- 
2.43.5


