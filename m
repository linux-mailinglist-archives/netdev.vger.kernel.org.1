Return-Path: <netdev+bounces-152756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E7B9F5BB9
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325341883558
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167F03C47B;
	Wed, 18 Dec 2024 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bxVd30/T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807613596D
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482281; cv=none; b=bApIJ/klPzV2LKQ1zBUrR57ju8TOAqOzqTsrEnQRLw+KlgCcAF5JEkyVPy6TXZVEowhHplNmV+ZKcaTQFntcP7RIYwTjcQH7TCBqWsj+w4K248e/h5fimVDzIqaw/U2fls+1eJu1VIKgr/wbVee1wC3L+lRqo6f18AhXCsGSRBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482281; c=relaxed/simple;
	bh=EBvFIsawVGxLxMU3p1j1YX1UqSiCQdW1wkhcOZFyBMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6j4m3sje4iQOXAueqqKQDZJvpww06ydzoh8MS1Oz7Y7pRvUEzi2d056C95VkUwyoiele8Fnq+EzYgkcVAvtOJuRbcDHNYC/C4KRTDRklSrESUVnGXpsr0GNlawSz46KTBW0i8aC2LUh2Y+Qbe5AW+ovOcIGbVUQTXyOWoCY178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=bxVd30/T; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725ed193c9eso5080589b3a.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734482280; x=1735087080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+YHcXEAtBvssxU5fzHig35lu0TSHQacf/OaCK3OLTg=;
        b=bxVd30/TDcvR+Esh7VtUU7P1YMAG2Cqx/q8o6i0lnUUJc6YjRdYjvLl9FnFnH78/t6
         HB5h6FD7lHKbBpHoEd+a/xa6W9Q2Lg9exbo/T0CVoCNHgyOxP8XLbePi8MlH6eEqFGFj
         +ncR4mBvxRZD6gvXjmp0EZMqGdlA6l4UpxonD4lireq/6x72udBrw6EXK39XzNY47zqP
         M62dTaplEjPPDpX/Z5rBkB5IzT1gB08IQ9mZdJ0blsMXx484whunMktywSBS43H5t4y1
         YfXzTVCeXDQieggMhUsW3GFAbDXuAlXBJtY8GqLte51F9QvaokZVFA4rQDgQHw8dj8VH
         EjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482280; x=1735087080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+YHcXEAtBvssxU5fzHig35lu0TSHQacf/OaCK3OLTg=;
        b=nfhCwW8SQOVY8pLB4ZLycCf8ECAx7v6sHygfzwTJdPpxM7Ir5uHYlYK9gd1l527iqX
         zJfVCbXjR0h7H38asCzqsetj7H0OfQTSXH9z6adMk4Xnl2PVzjvGg/HUeq0mQ1PqzIaV
         xi6OYFGu+0APVVmAAu1d1+BrCXfbhvkH3+rfg1ExB4UTlYQxNTU9k3o2z/+tPFBMgttp
         3eey+pbuclSkotj1qGLozDOK7B93S026b6JYBqHk+MtlEkVPXUyDybj7I9tQla8BnTiq
         bgHkGjIHpm0dBkoDJhE0Fe0PIJLXGZnsz1a4yuoB68jX3tBkynvQdNqoluFPfiaU8xgz
         ua+A==
X-Forwarded-Encrypted: i=1; AJvYcCV20KmvFNIy/di86X2KWIs6B8wwwgU2Yrkwq+yoCdkgt7tUgMjJkP0XM/btC7t+C11zz+OsBPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKVVI5FGTHitxl/apPKn9KqHiWmZzYWe/KWkxJGIs0rgRXcB/f
	BSs5eM4VekIlBQOWKy09UTyzDgnZQuG65tMS+b51eQF5QMo4iEMVvbqO7SC+lLA=
X-Gm-Gg: ASbGncsg4p7V1L8Yobj6Xz0NeR9Np3MxMJW4I6FsKH3YAHv/9jafl1qBoX1YiUgE6KM
	tqDY4sD5D4nseEnRBLXNgtfBlgH8gEWjt6f6xFL15sItxbblAALw1EB/LqAQWK8REPrxJfnFjXf
	sSODLytYuVPdRw1D2PI/wFO2SsRxisQ00WgWc/mX1d4n/S7opY+c53wq1/GD2o6U2XsosdoMwvV
	bRpbE7mqQKFO8lL/fslWNevlG+GN09Uj3DzF8sq
X-Google-Smtp-Source: AGHT+IHNaclYzql/KiG+f8dQp/Qdpzpc2xkSKZ9c3EdFR/saiYZ/O/25OFfs9MN3+2HMMxYSmkpHVA==
X-Received: by 2002:a05:6a00:3693:b0:725:9f02:489f with SMTP id d2e1a72fcca58-72a8d2dfd73mr1599294b3a.26.1734482279804;
        Tue, 17 Dec 2024 16:37:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90693sm6473914a12.9.2024.12.17.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:37:59 -0800 (PST)
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
Subject: [PATCH net-next v9 04/20] net: page_pool: create hooks for custom page providers
Date: Tue, 17 Dec 2024 16:37:30 -0800
Message-ID: <20241218003748.796939-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218003748.796939-1-dw@davidwei.uk>
References: <20241218003748.796939-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

The page providers which try to reuse the same pages will
need to hold onto the ref, even if page gets released from
the pool - as in releasing the page from the pp just transfers
the "ownership" reference from pp to the provider, and provider
will wait for other references to be gone before feeding this
page back into the pool.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/types.h |  9 +++++++++
 net/core/devmem.c             | 14 +++++++++++++-
 net/core/page_pool.c          | 22 ++++++++++++++--------
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ed4cd114180a..d6241e8a5106 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -152,8 +152,16 @@ struct page_pool_stats {
  */
 #define PAGE_POOL_FRAG_GROUP_ALIGN	(4 * sizeof(long))
 
+struct memory_provider_ops {
+	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
+	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
+	int (*init)(struct page_pool *pool);
+	void (*destroy)(struct page_pool *pool);
+};
+
 struct pp_memory_provider_params {
 	void *mp_priv;
+	const struct memory_provider_ops *mp_ops;
 };
 
 struct page_pool {
@@ -216,6 +224,7 @@ struct page_pool {
 	struct ptr_ring ring;
 
 	void *mp_priv;
+	const struct memory_provider_ops *mp_ops;
 
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index c250db6993d3..48903b7ab215 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -26,6 +26,8 @@
 /* Protected by rtnl_lock() */
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
+static const struct memory_provider_ops dmabuf_devmem_ops;
+
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 					       struct gen_pool_chunk *chunk,
 					       void *not_used)
@@ -117,6 +119,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		WARN_ON(rxq->mp_params.mp_priv != binding);
 
 		rxq->mp_params.mp_priv = NULL;
+		rxq->mp_params.mp_ops = NULL;
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
@@ -142,7 +145,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	}
 
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
-	if (rxq->mp_params.mp_priv) {
+	if (rxq->mp_params.mp_ops) {
 		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
 		return -EEXIST;
 	}
@@ -160,6 +163,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 		return err;
 
 	rxq->mp_params.mp_priv = binding;
+	rxq->mp_params.mp_ops = &dmabuf_devmem_ops;
 
 	err = netdev_rx_queue_restart(dev, rxq_idx);
 	if (err)
@@ -169,6 +173,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 
 err_xa_erase:
 	rxq->mp_params.mp_priv = NULL;
+	rxq->mp_params.mp_ops = NULL;
 	xa_erase(&binding->bound_rxqs, xa_idx);
 
 	return err;
@@ -388,3 +393,10 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
 	/* We don't want the page pool put_page()ing our net_iovs. */
 	return false;
 }
+
+static const struct memory_provider_ops dmabuf_devmem_ops = {
+	.init			= mp_dmabuf_devmem_init,
+	.destroy		= mp_dmabuf_devmem_destroy,
+	.alloc_netmems		= mp_dmabuf_devmem_alloc_netmems,
+	.release_netmem		= mp_dmabuf_devmem_release_page,
+};
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e07ad7315955..784a547b2ca4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -285,13 +285,19 @@ static int page_pool_init(struct page_pool *pool,
 		rxq = __netif_get_rx_queue(pool->slow.netdev,
 					   pool->slow.queue_idx);
 		pool->mp_priv = rxq->mp_params.mp_priv;
+		pool->mp_ops = rxq->mp_params.mp_ops;
 	}
 
-	if (pool->mp_priv) {
+	if (pool->mp_ops) {
 		if (!pool->dma_map || !pool->dma_sync)
 			return -EOPNOTSUPP;
 
-		err = mp_dmabuf_devmem_init(pool);
+		if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops))) {
+			err = -EFAULT;
+			goto free_ptr_ring;
+		}
+
+		err = pool->mp_ops->init(pool);
 		if (err) {
 			pr_warn("%s() mem-provider init failed %d\n", __func__,
 				err);
@@ -588,8 +594,8 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 		return netmem;
 
 	/* Slow-path: cache empty, do real allocation */
-	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
-		netmem = mp_dmabuf_devmem_alloc_netmems(pool, gfp);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		netmem = pool->mp_ops->alloc_netmems(pool, gfp);
 	else
 		netmem = __page_pool_alloc_pages_slow(pool, gfp);
 	return netmem;
@@ -680,8 +686,8 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	bool put;
 
 	put = true;
-	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
-		put = mp_dmabuf_devmem_release_page(pool, netmem);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		put = pool->mp_ops->release_netmem(pool, netmem);
 	else
 		__page_pool_release_page_dma(pool, netmem);
 
@@ -1049,8 +1055,8 @@ static void __page_pool_destroy(struct page_pool *pool)
 	page_pool_unlist(pool);
 	page_pool_uninit(pool);
 
-	if (pool->mp_priv) {
-		mp_dmabuf_devmem_destroy(pool);
+	if (pool->mp_ops) {
+		pool->mp_ops->destroy(pool);
 		static_branch_dec(&page_pool_mem_providers);
 	}
 
-- 
2.43.5


