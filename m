Return-Path: <netdev+bounces-79549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D14E879DC9
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788361C219CF
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 21:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A1145FE5;
	Tue, 12 Mar 2024 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="kmhIAGjt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D414534A
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279885; cv=none; b=NeRv3LacKv3SggIK7LVBsGieFSyd/yExU7l3sfJxyIdpwicRod1/SnwulUfehYcPRX44ygl6BuWTTvEOmnEjHtHM2RF8CRo4fqFfjM+QULLwb0F5Ajp+loXFm+V7NKBigE5MUvyCy10zYWyQzxgM8ej2jlksBcV7Owurf7xAt/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279885; c=relaxed/simple;
	bh=eRcCQkeaZ8F0GKFd2KHE5Z+F854s9I1FEkuc3LSzm2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMdw2iziWu7oIy4yV8d3B9MlDfloVBwCmX+TEhS/lEBDooUlqb9MRFXOluyhMm9V65F9U6BZ1npbS7UMEm0E+ILYeoDLHVGv16GC06VhYXUcZaB7yaH2gFpsaLMxnXDXGUMcs41BeluIzYz7eNkp1w1kBSucQNvf1UMgwxQ/rjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=kmhIAGjt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6afd8da93so761496b3a.3
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1710279884; x=1710884684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCy4u9W62ktWc/P2lKJyJOpaYewa777F/POJ5w4gbEU=;
        b=kmhIAGjtTvRveEAIi+6KlRa2BkST490cqz9UQ/5bDtmZG/wxpU5rpCt3aW5WRCcZzc
         0Dk3OWoz4K3IhmCINrIO7tQwi7VY6pTOM83ewJimCkN9CQ1cFFFEtgQyhlTMcXe9/lOC
         oBsZrNW+ij89j9J9+ptsP58FfT+VvE5VlDBIPD8BXaxYdICtTaFCxDIHUEw2h7eiifGO
         L9D0R4G+AEySvl4pJ3rNsaD8IT+SDnGy3U5alkglzloIwgRZdp6Qo4gRrIoIXk1CdLUQ
         Sm0/zivyGJyF/ejru5jEHwZMmg3W8bnVQ8strWs5wLaDpUnaRasEU6bqO5jE2TEnE85O
         0MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279884; x=1710884684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCy4u9W62ktWc/P2lKJyJOpaYewa777F/POJ5w4gbEU=;
        b=VFE9LMze3/34mjJUBsiSeak7trmgTuQn/tV68InWVZo72kurVHX4kiQOJ/Gsuriz8g
         c23iMf2+Z9DyjlwHLs372iF47w+Y8ihHwMOoyxFFQJI3iF3jrV0xXxhz85sd+/dXDp2j
         NkBtJ1cm7QvchUZhEQUtcvoySz3SOaeIMUAyiUApc3FwblnQLehLDraszouWh1DjgVYO
         18d/C8CyBPbHjmGRsfFo3zuIfNq0HzwpWimn8VlHSOPcqKxAQ3gPA1rMHvD2ichgYw96
         xWWyCZizlnL89hPR6RCfyJdHT/gD7f2gCvqPIqRp/KYT8pBpDvrHNbaJO1M21ZcyR49L
         4KiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeGIKe7u5JXtgptAlGAghEmObFyeTyXHv9kO93tcoPx4sztqECWnuE/1s4/fSmaiMTbeQ/bZVV1Su1Kf0pIAh0gqGoA1G3
X-Gm-Message-State: AOJu0YyYSqwSpz22PYHiKyXM9tlrdqMnEYhja8DFMaXm7cLEzwEsbRhJ
	ES+BEUQz2Yi22kjtWQRBeBckSINXqjCxLXISVQyEPXIE8BZVO6WkcsRfSB5GXuU=
X-Google-Smtp-Source: AGHT+IH6qaz8/MgTiX2wWsxztFgdejg3skTArfeuUDbnJDyUll4L7vespliwv23QrCjuFSo8kukySg==
X-Received: by 2002:a05:6a00:9299:b0:6e6:a1ed:aff1 with SMTP id jw25-20020a056a00929900b006e6a1edaff1mr881668pfb.5.1710279883637;
        Tue, 12 Mar 2024 14:44:43 -0700 (PDT)
Received: from localhost (fwdproxy-prn-117.fbsv.net. [2a03:2880:ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id z8-20020aa79e48000000b006e6686effd7sm6555348pfq.76.2024.03.12.14.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:44:43 -0700 (PDT)
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
	Mina Almasry <almasrymina@google.com>
Subject: [RFC PATCH v4 10/16] io_uring: add zero copy buf representation and pool
Date: Tue, 12 Mar 2024 14:44:24 -0700
Message-ID: <20240312214430.2923019-11-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312214430.2923019-1-dw@davidwei.uk>
References: <20240312214430.2923019-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <davidhwei@meta.com>

This patch adds two objects:

* Zero copy buffer representation, holding a page and a net_iov. The
  page is needed as net_iov is designed for opaque device memory,
  whereas we are backed by real pages.
* Zero copy pool, spiritually similar to page pool, that holds ZC bufs
  and hands them out to net devices. This will be used as an
  implementation of page pool memory provider.

Pool regions are registered w/ io_uring using the registered buffer API,
with a 1:1 mapping between region and nr_iovec in
io_uring_register_buffers. This does the heavy lifting of pinning and
chunking into bvecs into a struct io_mapped_ubuf for us.

For now as there is only one pool region per ifq, there is no separate
API for adding/removing regions yet and it is mapped implicitly during
ifq registration.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/linux/io_uring/net.h |   7 +++
 io_uring/zc_rx.c             | 110 +++++++++++++++++++++++++++++++++++
 io_uring/zc_rx.h             |  15 +++++
 3 files changed, 132 insertions(+)

diff --git a/include/linux/io_uring/net.h b/include/linux/io_uring/net.h
index b58f39fed4d5..05d5a6a97264 100644
--- a/include/linux/io_uring/net.h
+++ b/include/linux/io_uring/net.h
@@ -2,8 +2,15 @@
 #ifndef _LINUX_IO_URING_NET_H
 #define _LINUX_IO_URING_NET_H
 
+#include <net/page_pool/types.h>
+
 struct io_uring_cmd;
 
+struct io_zc_rx_buf {
+	struct net_iov		niov;
+	struct page		*page;
+};
+
 #if defined(CONFIG_IO_URING)
 int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags);
 
diff --git a/io_uring/zc_rx.c b/io_uring/zc_rx.c
index 77459c0fc14b..326ae3fcc643 100644
--- a/io_uring/zc_rx.c
+++ b/io_uring/zc_rx.c
@@ -5,6 +5,7 @@
 #include <linux/mm.h>
 #include <linux/io_uring.h>
 #include <linux/netdevice.h>
+#include <linux/nospec.h>
 #include <net/tcp.h>
 #include <net/af_unix.h>
 
@@ -66,6 +67,109 @@ static void io_free_rbuf_ring(struct io_zc_rx_ifq *ifq)
 		folio_put(virt_to_folio(ifq->rq_ring));
 }
 
+static int io_zc_rx_init_buf(struct page *page, struct io_zc_rx_buf *buf)
+{
+	memset(&buf->niov, 0, sizeof(buf->niov));
+	atomic_long_set(&buf->niov.pp_ref_count, 0);
+
+	buf->page = page;
+	get_page(page);
+	return 0;
+}
+
+static void io_zc_rx_free_buf(struct io_zc_rx_buf *buf)
+{
+	struct page *page = buf->page;
+
+	put_page(page);
+}
+
+static int io_zc_rx_init_pool(struct io_zc_rx_pool *pool,
+			     struct io_mapped_ubuf *imu)
+{
+	struct io_zc_rx_buf *buf;
+	struct page *page;
+	int i, ret;
+
+	for (i = 0; i < imu->nr_bvecs; i++) {
+		page = imu->bvec[i].bv_page;
+		buf = &pool->bufs[i];
+		ret = io_zc_rx_init_buf(page, buf);
+		if (ret)
+			goto err;
+
+		pool->freelist[i] = i;
+	}
+
+	pool->free_count = imu->nr_bvecs;
+	return 0;
+err:
+	while (i--) {
+		buf = &pool->bufs[i];
+		io_zc_rx_free_buf(buf);
+	}
+	return ret;
+}
+
+static int io_zc_rx_create_pool(struct io_ring_ctx *ctx,
+				struct io_zc_rx_ifq *ifq,
+				u16 id)
+{
+	struct io_mapped_ubuf *imu;
+	struct io_zc_rx_pool *pool;
+	int nr_pages;
+	int ret;
+
+	if (ifq->pool)
+		return -EFAULT;
+
+	if (unlikely(id >= ctx->nr_user_bufs))
+		return -EFAULT;
+	id = array_index_nospec(id, ctx->nr_user_bufs);
+	imu = ctx->user_bufs[id];
+	if (imu->ubuf & ~PAGE_MASK || imu->ubuf_end & ~PAGE_MASK)
+		return -EFAULT;
+
+	ret = -ENOMEM;
+	nr_pages = imu->nr_bvecs;
+	pool = kvmalloc(struct_size(pool, freelist, nr_pages), GFP_KERNEL);
+	if (!pool)
+		goto err;
+
+	pool->bufs = kvmalloc_array(nr_pages, sizeof(*pool->bufs), GFP_KERNEL);
+	if (!pool->bufs)
+		goto err_buf;
+
+	ret = io_zc_rx_init_pool(pool, imu);
+	if (ret)
+		goto err_map;
+
+	pool->ifq = ifq;
+	pool->pool_id = id;
+	pool->nr_bufs = nr_pages;
+	spin_lock_init(&pool->freelist_lock);
+	ifq->pool = pool;
+	return 0;
+err_map:
+	kvfree(pool->bufs);
+err_buf:
+	kvfree(pool);
+err:
+	return ret;
+}
+
+static void io_zc_rx_free_pool(struct io_zc_rx_pool *pool)
+{
+	struct io_zc_rx_buf *buf;
+
+	for (int i = 0; i < pool->nr_bufs; i++) {
+		buf = &pool->bufs[i];
+		io_zc_rx_free_buf(buf);
+	}
+	kvfree(pool->bufs);
+	kvfree(pool);
+}
+
 static struct io_zc_rx_ifq *io_zc_rx_ifq_alloc(struct io_ring_ctx *ctx)
 {
 	struct io_zc_rx_ifq *ifq;
@@ -104,6 +208,8 @@ static void io_zc_rx_ifq_free(struct io_zc_rx_ifq *ifq)
 {
 	io_shutdown_ifq(ifq);
 
+	if (ifq->pool)
+		io_zc_rx_free_pool(ifq->pool);
 	if (ifq->dev)
 		dev_put(ifq->dev);
 	io_free_rbuf_ring(ifq);
@@ -141,6 +247,10 @@ int io_register_zc_rx_ifq(struct io_ring_ctx *ctx,
 	if (!ifq->dev)
 		goto err;
 
+	ret = io_zc_rx_create_pool(ctx, ifq, reg.region_id);
+	if (ret)
+		goto err;
+
 	ifq->rq_entries = reg.rq_entries;
 	ifq->if_rxq_id = reg.if_rxq_id;
 
diff --git a/io_uring/zc_rx.h b/io_uring/zc_rx.h
index d7b8397d525f..466b2b8f9813 100644
--- a/io_uring/zc_rx.h
+++ b/io_uring/zc_rx.h
@@ -3,15 +3,30 @@
 #define IOU_ZC_RX_H
 
 #include <linux/io_uring_types.h>
+#include <linux/io_uring/net.h>
 #include <linux/skbuff.h>
 
 #define IO_ZC_MAX_IFQ_SOCKETS		16
 #define IO_ZC_IFQ_IDX_OFFSET		16
 #define IO_ZC_IFQ_IDX_MASK		((1U << IO_ZC_IFQ_IDX_OFFSET) - 1)
 
+struct io_zc_rx_pool {
+	struct io_zc_rx_ifq	*ifq;
+	struct io_zc_rx_buf	*bufs;
+	u32			nr_bufs;
+	u16			pool_id;
+
+	/* freelist */
+	spinlock_t		freelist_lock;
+	u32			free_count;
+	u32			freelist[];
+};
+
 struct io_zc_rx_ifq {
 	struct io_ring_ctx		*ctx;
 	struct net_device		*dev;
+	struct io_zc_rx_pool		*pool;
+
 	struct io_uring			*rq_ring;
 	struct io_uring_rbuf_rqe 	*rqes;
 	u32				rq_entries;
-- 
2.43.0


