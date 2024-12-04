Return-Path: <netdev+bounces-149095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109AA9E4293
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 18:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C059E2835BB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E12144C7;
	Wed,  4 Dec 2024 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="OxZni3Gl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469952144DC
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332971; cv=none; b=NeELzlZcJWpYPyfKEO8+QEjtxzoCq2bL1wHfY96w5OqYdwF3/y5HSDQ/AcmkDz8MXCnALYAuymMCoKQth3pUKgHxpGSs0FPxml8sGcuoKD2aHrWZDdRHnRHqLSrBHlwurn2lVHHG3LhQ/u6ii8H9o2XQZc4Bk3YGsp8lpov3Hmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332971; c=relaxed/simple;
	bh=2Ly0e5Yijxu/LfGPalbYYW0IDXn2bJJLdjQ35I/F9lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/fhlgTEbR1ywtrpALnyJMKWwhU71zTM8avnBKZHWOZtw2IRY+mq22IZGgX+fYK+13PEda6r09ojKpUwmOFui2TuXr/QKmVtbEtWmm5WeP15RLm6ST/768lG6hK4E5fX722J4D0PMV/Rw4evH+QvcH6vxUquypm4XGHwfzvnodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=OxZni3Gl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so50603a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733332970; x=1733937770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVA+/b4qCsGeF/r3+y87HajxoHUhHCxTyMRpyjDTudI=;
        b=OxZni3GluqnhCSfAC2Z1Kc277FqzUyf6VKnVMYqXM5rI+eZLuiG2nwAgKSVosuAVg0
         WbLkVx3S4Suk0nPcbyKvIrKi/N2K8wUtox1nKDXYbwWcBl72lsg2CQoILEUfTpJMmjdF
         2nhR64Cuo3WYDKBiNaJvpH2hUoDq81Y0/3bYyk5Ciqge0q8jFjLOD/VLGRq9j+nFjeaq
         Oo1lSWhNl8zPQyH8WrsgdXN/H0erUEvhyTPc12oRFE7XzRQ7MvWTaBVX09eXEY7+5pai
         naeM+5sorHse8Mjucwp2kvtSBIvhJ5LMGTHEnlpiPcmqm5Q7EJ7N6+qWXbKd/DR7ivZ3
         V+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332970; x=1733937770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVA+/b4qCsGeF/r3+y87HajxoHUhHCxTyMRpyjDTudI=;
        b=ijR4DM5xZ1QXSCtBkfo9JFZ+QeDJQNNhdq6DruHp03I9Pzs/SHAkRj8uDYlToFIPBb
         5lsfFmEEvDcIo+/NtIKu1TdMhVbGSIICJaYntnGWSmaFjI94/KNR63w6tqn6N4asK27H
         DO/j6skZuGCC8TFf/B3YcJOimvRNDxLwknQjhuzF/CHHSsbybQReSemHEah/Rc7sfjja
         +1GIcaBsL9Z6Cw7rABo0uQAuC54gGdRTiPbm9Th2V9MtAODko2ZtLmASZ4UTrIQQ39SK
         ZLQcIwJgSjBkDz652q9xWfQBYVCaZSLSS9ZhxsydHw4YKAqK4yCxIOr3zPYLwx2xMdzq
         PHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmMTZ/aiNSa3iekzx+IVRCuBlejAF19BHuB5hgNoEoZE7LpI1yOXhlLp/Y9K+E5MyG+5v3MbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydyNczUfFd0gspaJmT8caA0/0iXpYPn80D2fJDCEyi+HdCbDsp
	BtBqjSG8l+JBaTZE1DkUBksv5ebq5VTcE+gyQKEaJNvTvT54RaCZLKl9cUuFIno=
X-Gm-Gg: ASbGncs2PQ1yIT3RzU6Gy9Nu6/V3cEXcCwWrRynofvpaemO3rsCOQUEaVSz2WWtJ5tJ
	BcOhlmns8iGQHBriuDg54usyPJSip+z9TpdUQj7isVwNoQRcNHHd4danpAy9WTk/OxHeac0+RKK
	CzxFh/kMLxFqIaDoPvhiMIEV4/4JzyHDXm63r2pCV9tsutXe65+O2NyFinSHLR/F+2VhS5LYv8y
	uNY7biBUGLWjhBycl8SYi/V6W8lxDsitsc=
X-Google-Smtp-Source: AGHT+IEuhl76LZuTMA9l7NFby+dpNqNLOXPZPUIKpzVvQ3cP55eSMyTH71gxdXUKQ8wKcIyAwFFBwA==
X-Received: by 2002:a17:90b:2547:b0:2ee:fa3f:4740 with SMTP id 98e67ed59e1d1-2ef012759b6mr11280221a91.35.1733332969694;
        Wed, 04 Dec 2024 09:22:49 -0800 (PST)
Received: from localhost ([2a03:2880:ff:16::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2701d9a2sm1681179a91.28.2024.12.04.09.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:22:49 -0800 (PST)
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
Subject: [PATCH net-next v8 06/17] net: page pool: add helper creating area from pages
Date: Wed,  4 Dec 2024 09:21:45 -0800
Message-ID: <20241204172204.4180482-7-dw@davidwei.uk>
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

Add a helper that takes an array of pages and initialises passed in
memory provider's area with them, where each net_iov takes one page.
It's also responsible for setting up dma mappings.

We keep it in page_pool.c not to leak netmem details to outside
providers like io_uring, which don't have access to netmem_priv.h
and other private helpers.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h | 10 ++++
 net/core/page_pool.c                    | 63 ++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 include/net/page_pool/memory_provider.h

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
new file mode 100644
index 000000000000..83d7eec0058d
--- /dev/null
+++ b/include/net/page_pool/memory_provider.h
@@ -0,0 +1,10 @@
+#ifndef _NET_PAGE_POOL_MEMORY_PROVIDER_H
+#define _NET_PAGE_POOL_MEMORY_PROVIDER_H
+
+int page_pool_mp_init_paged_area(struct page_pool *pool,
+				struct net_iov_area *area,
+				struct page **pages);
+void page_pool_mp_release_area(struct page_pool *pool,
+				struct net_iov_area *area);
+
+#endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 13f1a4a63760..d17e536ba8b8 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -13,6 +13,7 @@
 
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
+#include <net/page_pool/memory_provider.h>
 #include <net/xdp.h>
 
 #include <linux/dma-direction.h>
@@ -459,7 +460,8 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 
-static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
+static bool page_pool_dma_map_page(struct page_pool *pool, netmem_ref netmem,
+				   struct page *page)
 {
 	dma_addr_t dma;
 
@@ -468,7 +470,7 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	 * into page private data (i.e 32bit cpu with 64bit DMA caps)
 	 * This mapping is kept for lifetime of page, until leaving pool.
 	 */
-	dma = dma_map_page_attrs(pool->p.dev, netmem_to_page(netmem), 0,
+	dma = dma_map_page_attrs(pool->p.dev, page, 0,
 				 (PAGE_SIZE << pool->p.order), pool->p.dma_dir,
 				 DMA_ATTR_SKIP_CPU_SYNC |
 					 DMA_ATTR_WEAK_ORDERING);
@@ -490,6 +492,11 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	return false;
 }
 
+static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
+{
+	return page_pool_dma_map_page(pool, netmem, netmem_to_page(netmem));
+}
+
 static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 						 gfp_t gfp)
 {
@@ -1154,3 +1161,55 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
+
+static void page_pool_release_page_dma(struct page_pool *pool,
+				       netmem_ref netmem)
+{
+	__page_pool_release_page_dma(pool, netmem);
+}
+
+int page_pool_mp_init_paged_area(struct page_pool *pool,
+				 struct net_iov_area *area,
+				 struct page **pages)
+{
+	struct net_iov *niov;
+	netmem_ref netmem;
+	int i, ret = 0;
+
+	if (!pool->dma_map)
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < area->num_niovs; i++) {
+		niov = &area->niovs[i];
+		netmem = net_iov_to_netmem(niov);
+
+		page_pool_set_pp_info(pool, netmem);
+		if (!page_pool_dma_map_page(pool, netmem, pages[i])) {
+			ret = -EINVAL;
+			goto err_unmap_dma;
+		}
+	}
+	return 0;
+
+err_unmap_dma:
+	while (i--) {
+		netmem = net_iov_to_netmem(&area->niovs[i]);
+		page_pool_release_page_dma(pool, netmem);
+	}
+	return ret;
+}
+
+void page_pool_mp_release_area(struct page_pool *pool,
+			       struct net_iov_area *area)
+{
+	int i;
+
+	if (!pool->dma_map)
+		return;
+
+	for (i = 0; i < area->num_niovs; i++) {
+		struct net_iov *niov = &area->niovs[i];
+
+		page_pool_release_page_dma(pool, net_iov_to_netmem(niov));
+	}
+}
-- 
2.43.5


