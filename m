Return-Path: <netdev+bounces-136245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4B29A11F3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007E4283DB3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25D215F62;
	Wed, 16 Oct 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2B7NXSDE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960D2144CF
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104791; cv=none; b=JfHuGjx2am0g/g7Mrvyy1X5xHCR0OVyNnA+F4j5sSL2szOKl1XeWXABwojwfdiaPgSFhoIGHJ8JsUadkUeCwZH3d9EJY7tiVAXPU+Wv5jjGYo4bpsktpAe/uZupDDzzf5boFmkylPFG5zXkUKX/hE0bNCpuQD52PJo/Kp1vEP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104791; c=relaxed/simple;
	bh=stlUgp33BwTRN/0cQTOTCoDhqZGc/HHCVuHNB1SnHKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYAxfJmV9/R/6DPZHbtEHmQV7OyECKPO9IqVGYA7XCX+BuN4bMM7SQLsrx4v4Nm6yqkkEtlTjZuZrZQMFH3TshLMLnPPbvqTPo9i63TJbopBZvbmxi1lYy/eKjM0ScHdewgAKXMHgFKsrWNY85udGWt2YaqbJHH/IbJlOkvogKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=2B7NXSDE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db54269325so107915a12.2
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1729104790; x=1729709590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKhajILgXPnH7N489X2OSTc+5BkU3eYPAK3guNmJgN4=;
        b=2B7NXSDEaEGEpj0Of9wgUDMZmq5zK80gJIUUwrJP0Z8+dIrK28bl76g15cbELZIjQ4
         u8MRJSOiqsyobPKgQEabuawbTn1WZA0BKd0JRqaWc7dNWL5z4kTc0uSQbbPXE3JHB2/5
         cJFaRKD4i64J9j+iAusfazEKHJFOtuc8+oWgWHWQ7nf73kvmopbV2ffkNtRGZn84//Ar
         MO/3Q2k4eJ3qMEKsR1pGpPC865MmW7Gf1/XtoybncZFS8mSj9X0ByPxJLinNlp3OrGxh
         cbIen0mYew27Qjhm6ROvDvfcDGhLujwqa/LpCmB3XufSqI0N9w7TxCtTnQK1DxHaCZ4m
         nbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729104790; x=1729709590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKhajILgXPnH7N489X2OSTc+5BkU3eYPAK3guNmJgN4=;
        b=qwBrhUkZvO2OsZAlqOku85XLkc7hjRHU/7wWwT0Au4sMUeYoXVUHKH6Fnhj0Bku/R1
         EVnZYwd/lK6wjNUkO9RMmOtyNquRb6V+I6Rh1z9W28lNJ3J7afFpM38HIccasaD5fjAV
         mCbXYHsFXHgfdm3jm7mchFkK5AU+ZrPqACJtFcEnFHvsn9tSPqT4OV0NNW0Sv8r2i99/
         COHo4SM710FJiyRMwNbjjXpiGCMv03mx5Daxa8CxxFrVuRCzfBzFdiuwOCp7ZNNa3oUC
         U8BvvJQDu3CAdAlhGup+DhqleblJ3m3cJZ1asFuTK2ZJd+aGOw2eYpxlVdXp+MFvouib
         eSng==
X-Forwarded-Encrypted: i=1; AJvYcCU3PCWqChA2Q4V0jltS5OTrX+DByTDTePnIqEs3sHe5V8c9n7AblaeDu3xs7ZnOUVxJy/JJAOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7H/TxdqgUa+AzHOZwYhy9BrEc+Sb1ZCfB3qjz0acJ7QoQnG3L
	F+qri/zdTnThqHa/ltHUIDJWJA3w2yeJVgyztwD2y87GA/Bw/DNgCzO2eIzVyI0=
X-Google-Smtp-Source: AGHT+IFUKSBYw0TVlOrWwfyB+Hat8M0ZvOzZaPKQW6ZyDBwTh6AcSIrs+UBlG+sTrrHZo3hmqYeeGA==
X-Received: by 2002:a05:6a21:9d83:b0:1cf:6d20:4d6 with SMTP id adf61e73a8af0-1d8c959539amr26460080637.16.1729104790090;
        Wed, 16 Oct 2024 11:53:10 -0700 (PDT)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e7750a74csm3389377b3a.212.2024.10.16.11.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:53:09 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Wei <dw@davidwei.uk>,
	Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH v6 07/15] net: page_pool: introduce page_pool_mp_return_in_cache
Date: Wed, 16 Oct 2024 11:52:44 -0700
Message-ID: <20241016185252.3746190-8-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241016185252.3746190-1-dw@davidwei.uk>
References: <20241016185252.3746190-1-dw@davidwei.uk>
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
index 8bd4a3c80726..9078107c906d 100644
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


