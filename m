Return-Path: <netdev+bounces-162761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FD1A27DE4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37463A66A4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D000C21B90B;
	Tue,  4 Feb 2025 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="PL0gV391"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51021ADB4
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706190; cv=none; b=Ts3Y1jFsuDy9uJChFHDVwrHAH1EodLLlTKJ3LyCs+LFR94iNAKxksKP3qix9xlwxQpnOQVZQElZPoK5tjC1gj2TVFX6/eVYnexV2t7FKY3Qyd90oTVFAlXRFjyjogRPQjZjzYMP1A6dBYWWGmCdvwU1JCoWuM7iM8JvCxO2WMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706190; c=relaxed/simple;
	bh=VCfnp3tbSTbnXHNZ32P1p/3YtTKNQGfROVjDj6FO8Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOtza1255pk8CSC+apBoax/sVmcxkmF6Y2OIFVYl0qOxFoCbCNxgXA/L3iduExDsrEY3w5h51MleLu4xMbx2g61X5y8OSDKUhG1QNIHc4LPP9NsotBelPkYIbfGteRaGZ5SCjFC8uKz8aQ0AiCqQmVixuDgeSaKa83sZsqk0p8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=PL0gV391; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f01fe1ce8so18787745ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738706188; x=1739310988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dsKyIS4agUxuloeTXRg37ZYsUhVCI+vxxX48deMrJg=;
        b=PL0gV391THfTxqMK3+Gy50wp3CJpE1iuGXFhsHjbxZfh37RgD27MRsxRXNR8XsjxI4
         LFUUc2N77R4NaPlBt3ltsvLLrYjVpXd9ISgWjJFpy78FpJwIZ69KkDDBSTepbZeujaql
         kOY85Z2cj9FE8priG78X/v/zKWyvONYq+LSOaz97r5qkTlbCu9C5QDkVrVIAf9bqCSh2
         p3odzslL5Uq/gkyiRwGL6TvO/4+w5QBmSRD+gemAdNiDSZ8WmlIO2mvNnbTmUsuNJiFC
         2SENcCbA+o2J2SxYPC3Z8lfAESRtpIQcfJgprurno89Ih1Xi4PUAA3HK09IwvxQBPOLf
         U4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738706188; x=1739310988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dsKyIS4agUxuloeTXRg37ZYsUhVCI+vxxX48deMrJg=;
        b=Cv2/M6nTFQIe0owcxrn4sJq7XFOrBdQBJ8koHY8Ycne3UDtF3U2FKy7NuYv8VonQ2I
         WzUu+Em5gjh1XaopuUHLDjIXB3hNcE2l3yArGyzBLl2OXWqjE+h7XeeIcezKuDVpF7xh
         UWHQ8nGahSpfSYvrhSko7HB9if8yFX9Tl5ASdBJZmNqejJAQisj7G4ILTUD8jrR/LyG8
         X1fA82dai74ooTFFUu4w9tTx1U6u6slI4jrkX21WaSwa92SHlPPNJPNKF7xQlURrEHOp
         78jm5te3LCDi0FihFmjIwCdU2a9rUysh+65BsFgtqQWypSpVmh1uZA/MdjaFNSumcRyO
         p10g==
X-Gm-Message-State: AOJu0YyoqV4rm4rOJnI8l38CbOZnYXh52Gl/l17zAi+JS0yROmJiNNDy
	evxFgDoG5b04dYHqgt5OOSIAv9aWJOvDDm+CsRJMQPqWH2QQzFuq3V3vWdPc+AS9+jpvfEp3oB0
	i
X-Gm-Gg: ASbGnctw8u2Osdrp29fMhxetrdl/00pXFyOVl5Lsgx73Ttln2+icuvUX5IuRJXvz98z
	jKLlQ5ECiaNpQr1kb1eZetX65iXpBM9QDNGR+7SaoD+BCxrfbZP6TgYOd2BTsVanGU7ReCDYDzk
	2xN9A0Cv+spI0hrinNQFZmD2jzW+/07lFj51Jl4KzkuoNCI4E1cgRF0li4AYwOFMYV0bszKz/zI
	xVIK8eRxCMg8VgU/a7krnfyvs87qN/dv006ehZ6dkFA6vHkyxX40dITm6C0nofTNkG7zQdoCe8=
X-Google-Smtp-Source: AGHT+IGX6aH+5CVHV3h1t1THm4THzFZogTV4q38dNuQa3tMmEUGJ+7ZNVPlXcf/IEEI4uNiUIWtQHQ==
X-Received: by 2002:a05:6a21:b98:b0:1e1:af70:a30b with SMTP id adf61e73a8af0-1ede88bc4bdmr883537637.34.1738706188312;
        Tue, 04 Feb 2025 13:56:28 -0800 (PST)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1a78asm11010194b3a.164.2025.02.04.13.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:56:28 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
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
Subject: [PATCH net-next v13 04/10] net: page_pool: create hooks for custom memory providers
Date: Tue,  4 Feb 2025 13:56:15 -0800
Message-ID: <20250204215622.695511-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250204215622.695511-1-dw@davidwei.uk>
References: <20250204215622.695511-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

A spin off from the original page pool memory providers patch by Jakub,
which allows extending page pools with custom allocators. One of such
providers is devmem TCP, and the other is io_uring zerocopy added in
following patches.

Link: https://lore.kernel.org/netdev/20230707183935.997267-7-kuba@kernel.org/
Co-developed-by: Jakub Kicinski <kuba@kernel.org> # initial mp proposal
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h | 15 +++++++++++++++
 include/net/page_pool/types.h           |  4 ++++
 net/core/devmem.c                       | 15 ++++++++++++++-
 net/core/page_pool.c                    | 23 +++++++++++++++--------
 4 files changed, 48 insertions(+), 9 deletions(-)
 create mode 100644 include/net/page_pool/memory_provider.h

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
new file mode 100644
index 000000000000..e49d0a52629d
--- /dev/null
+++ b/include/net/page_pool/memory_provider.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_PAGE_POOL_MEMORY_PROVIDER_H
+#define _NET_PAGE_POOL_MEMORY_PROVIDER_H
+
+#include <net/netmem.h>
+#include <net/page_pool/types.h>
+
+struct memory_provider_ops {
+	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
+	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
+	int (*init)(struct page_pool *pool);
+	void (*destroy)(struct page_pool *pool);
+};
+
+#endif
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 7f405672b089..36eb57d73abc 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -152,8 +152,11 @@ struct page_pool_stats {
  */
 #define PAGE_POOL_FRAG_GROUP_ALIGN	(4 * sizeof(long))
 
+struct memory_provider_ops;
+
 struct pp_memory_provider_params {
 	void *mp_priv;
+	const struct memory_provider_ops *mp_ops;
 };
 
 struct page_pool {
@@ -216,6 +219,7 @@ struct page_pool {
 	struct ptr_ring ring;
 
 	void *mp_priv;
+	const struct memory_provider_ops *mp_ops;
 
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index fb0dddcb4e60..c81625ca57c6 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -16,6 +16,7 @@
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
+#include <net/page_pool/memory_provider.h>
 #include <trace/events/page_pool.h>
 
 #include "devmem.h"
@@ -27,6 +28,8 @@
 /* Protected by rtnl_lock() */
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
+static const struct memory_provider_ops dmabuf_devmem_ops;
+
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 					       struct gen_pool_chunk *chunk,
 					       void *not_used)
@@ -118,6 +121,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		WARN_ON(rxq->mp_params.mp_priv != binding);
 
 		rxq->mp_params.mp_priv = NULL;
+		rxq->mp_params.mp_ops = NULL;
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
@@ -153,7 +157,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	}
 
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
-	if (rxq->mp_params.mp_priv) {
+	if (rxq->mp_params.mp_ops) {
 		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
 		return -EEXIST;
 	}
@@ -171,6 +175,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 		return err;
 
 	rxq->mp_params.mp_priv = binding;
+	rxq->mp_params.mp_ops = &dmabuf_devmem_ops;
 
 	err = netdev_rx_queue_restart(dev, rxq_idx);
 	if (err)
@@ -180,6 +185,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 
 err_xa_erase:
 	rxq->mp_params.mp_priv = NULL;
+	rxq->mp_params.mp_ops = NULL;
 	xa_erase(&binding->bound_rxqs, xa_idx);
 
 	return err;
@@ -399,3 +405,10 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
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
index f5e908c9e7ad..d632cf2c91c3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -13,6 +13,7 @@
 
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
+#include <net/page_pool/memory_provider.h>
 #include <net/xdp.h>
 
 #include <linux/dma-direction.h>
@@ -285,13 +286,19 @@ static int page_pool_init(struct page_pool *pool,
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
@@ -587,8 +594,8 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 		return netmem;
 
 	/* Slow-path: cache empty, do real allocation */
-	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
-		netmem = mp_dmabuf_devmem_alloc_netmems(pool, gfp);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		netmem = pool->mp_ops->alloc_netmems(pool, gfp);
 	else
 		netmem = __page_pool_alloc_pages_slow(pool, gfp);
 	return netmem;
@@ -679,8 +686,8 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	bool put;
 
 	put = true;
-	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
-		put = mp_dmabuf_devmem_release_page(pool, netmem);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		put = pool->mp_ops->release_netmem(pool, netmem);
 	else
 		__page_pool_release_page_dma(pool, netmem);
 
@@ -1048,8 +1055,8 @@ static void __page_pool_destroy(struct page_pool *pool)
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


