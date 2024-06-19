Return-Path: <netdev+bounces-104736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF38590E365
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E8B1C21F81
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 06:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FAA6F2F9;
	Wed, 19 Jun 2024 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="g6Wenazv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C36F06D
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778579; cv=none; b=HZsk6evPeAD3w/opWyQ+u6DOFQ1JTSWTOnAtxnMhEbzYTbEqVZXl/nG+AaN5WvXwsOvCyaXzMMl10geKEGVddHuX0UbV06oxEzcDBSDNJ6qVOQuJ+clkj6KyQ9w/QTslKAL/C4uUmib9l4pMOHO4XbJuNMEoLixZqOfpa9YdB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778579; c=relaxed/simple;
	bh=p3WfwHopJDPv9BMsXKCzu/0yWbk/IcdVEDEhuBpVKpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQn/E+wnKA3eiQS+9m5X9Ky6twoABqOzvnawzE9LEHRKZfjpB36G5QAmqBK1yEz7Ot+aXbgkyve2chhzazl5YSe3oWI/CbZ015fdd4/BTy2W/5wd5rMYI8Z2Nr7DxGxYFBg94/nAAb0i3gLlu2lI7nExCvyyH/qK+sSmGRKPwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=g6Wenazv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70436048c25so4875232b3a.0
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718778577; x=1719383377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYCNpZJlos2u8B+J7soHvzd9OZgog9HhyfRHnjgq7rk=;
        b=g6Wenazv/6rKPjpNx5nWP1mWQeAu9UbHr8nmRG7AOzSCTxwJHFIzJpBB1DDZ1eRngy
         qaVSePjJ5TiACvCWjiaJTaSK2BoD4eAoPXgB6A9zE+pRc7SJEPS0kNqBs07KjvYRCGVJ
         20nDqtKHZsLHyU0P6K2+rtE9sDinYA+uB7lqxrCZ2sjKMoW1l2Z7gERKGGHh6EpYYUqD
         NzLjk8y1IXH0Ubf3Tsri8UitzpWdxalxJTM/FNH+X4qI68jlnKS45JDqBX+kPNW7IYkG
         xN4FSNCvgWlMlGD2W6mkU/O10i4B60M13fcDvEZ/sgZbY8SbAYncwyxW05Rq2t0J1DSP
         ypWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718778577; x=1719383377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYCNpZJlos2u8B+J7soHvzd9OZgog9HhyfRHnjgq7rk=;
        b=qQgwalz05eYFhUR2sdO4ekbhxd9sJLFFKklkjH2bNRbFLxZN5cLZMLoXljEVkgMpOt
         tU367AvQ+TxmQo99HZWZy3BH3Ad1GTv1j/RfDk7BR2pV+OPKKNuMtm0zkdWUTq+1Dm0u
         d/shpYEto10Hp6eoNjjjZfTOcxKL22El3NVlH6D+xepwPg0fsjFdED4PT9pfBRIZcROw
         KPgdntUDNAN5YSxSzQcPDre1TxTCzBq60Mk6llsBF7dj4C2SXkpFMsbPj4cyNdZVXmBO
         eQw6Xwr0PazRmoQmzlePUSuMCcmwEITP1z6h/rjkKWkuheV2LNz2dKrfrkzU4RKoCLZW
         3Weg==
X-Forwarded-Encrypted: i=1; AJvYcCWgYAx4gcMHLeM//wCB1dTlSzzZK1gB+1wiCuuVaHVwh4JfhSDCwHJ1PKAtMSvSnpz/Ti7p7+ir1fpQ/q/D0zxR2ClRD+Px
X-Gm-Message-State: AOJu0YytpHXG0e14+a5jNkqZUimLAJZ40WiKbBfJ2+jBffwomOGyhE+n
	6FMok4TNXgoza5YUHtK4b9PMS5SIUWvlz6wFDq9faHGCmuvRIxsytLH5J9ZwFk4=
X-Google-Smtp-Source: AGHT+IH5CkYdOKYK9BGhrPry9K8lLtrSuWb7TyncaYOviyz0hmNE4ok10mneoes2PJCj7swb3qW1qg==
X-Received: by 2002:a05:6a00:c8f:b0:705:c0a1:61c9 with SMTP id d2e1a72fcca58-7062c0d198bmr1571269b3a.9.1718778577467;
        Tue, 18 Jun 2024 23:29:37 -0700 (PDT)
Received: from localhost (fwdproxy-prn-011.fbsv.net. [2a03:2880:ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4a927sm9963426b3a.103.2024.06.18.23.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:29:37 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 2/2] bnxt_en: implement netdev_queue_mgmt_ops
Date: Tue, 18 Jun 2024 23:29:31 -0700
Message-ID: <20240619062931.19435-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619062931.19435-1-dw@davidwei.uk>
References: <20240619062931.19435-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement netdev_queue_mgmt_ops for bnxt added in [1].

Two bnxt_rx_ring_info structs are allocated to hold the new/old queue
memory. Queue memory is copied from/to the main bp->rx_ring[idx]
bnxt_rx_ring_info.

Queue memory is pre-allocated in bnxt_queue_mem_alloc() into a clone,
and then copied into bp->rx_ring[idx] in bnxt_queue_mem_start().

Similarly, when bp->rx_ring[idx] is stopped its queue memory is copied
into a clone, and then freed later in bnxt_queue_mem_free().

I tested this patchset with netdev_rx_queue_restart(), including
inducing errors in all places that returns an error code. In all cases,
the queue is left in a good working state.

Rx queues are created/destroyed using bnxt_hwrm_rx_ring_alloc() and
bnxt_hwrm_rx_ring_free(), which issue HWRM_RING_ALLOC and HWRM_RING_FREE
commands respectively to the firmware. By the time a HWRM_RING_FREE
response is received, there won't be any more completions from that
queue.

Thanks to Somnath for helping me with this patch. With their permission
I've added them as Acked-by.

[1]: https://lore.kernel.org/netdev/20240501232549.1327174-2-shailend@google.com/

Acked-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 275 ++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9e8d5cc32f16..259fbe709a8b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3997,6 +3997,62 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 	return 0;
 }
 
+static void bnxt_init_rx_ring_struct(struct bnxt *bp,
+				     struct bnxt_rx_ring_info *rxr)
+{
+	struct bnxt_ring_mem_info *rmem;
+	struct bnxt_ring_struct *ring;
+
+	ring = &rxr->rx_ring_struct;
+	rmem = &ring->ring_mem;
+	rmem->nr_pages = bp->rx_nr_pages;
+	rmem->page_size = HW_RXBD_RING_SIZE;
+	rmem->pg_arr = (void **)rxr->rx_desc_ring;
+	rmem->dma_arr = rxr->rx_desc_mapping;
+	rmem->vmem_size = SW_RXBD_RING_SIZE * bp->rx_nr_pages;
+	rmem->vmem = (void **)&rxr->rx_buf_ring;
+
+	ring = &rxr->rx_agg_ring_struct;
+	rmem = &ring->ring_mem;
+	rmem->nr_pages = bp->rx_agg_nr_pages;
+	rmem->page_size = HW_RXBD_RING_SIZE;
+	rmem->pg_arr = (void **)rxr->rx_agg_desc_ring;
+	rmem->dma_arr = rxr->rx_agg_desc_mapping;
+	rmem->vmem_size = SW_RXBD_AGG_RING_SIZE * bp->rx_agg_nr_pages;
+	rmem->vmem = (void **)&rxr->rx_agg_ring;
+}
+
+static void bnxt_reset_rx_ring_struct(struct bnxt *bp,
+				      struct bnxt_rx_ring_info *rxr)
+{
+	struct bnxt_ring_mem_info *rmem;
+	struct bnxt_ring_struct *ring;
+	int i;
+
+	rxr->page_pool->p.napi = NULL;
+	rxr->page_pool = NULL;
+
+	ring = &rxr->rx_ring_struct;
+	rmem = &ring->ring_mem;
+	rmem->pg_tbl = NULL;
+	rmem->pg_tbl_map = 0;
+	for (i = 0; i < rmem->nr_pages; i++) {
+		rmem->pg_arr[i] = NULL;
+		rmem->dma_arr[i] = 0;
+	}
+	*rmem->vmem = NULL;
+
+	ring = &rxr->rx_agg_ring_struct;
+	rmem = &ring->ring_mem;
+	rmem->pg_tbl = NULL;
+	rmem->pg_tbl_map = 0;
+	for (i = 0; i < rmem->nr_pages; i++) {
+		rmem->pg_arr[i] = NULL;
+		rmem->dma_arr[i] = 0;
+	}
+	*rmem->vmem = NULL;
+}
+
 static void bnxt_init_ring_struct(struct bnxt *bp)
 {
 	int i, j;
@@ -14914,6 +14970,224 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
+static int bnxt_alloc_rx_agg_bmap(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
+{
+	u16 mem_size;
+
+	rxr->rx_agg_bmap_size = bp->rx_agg_ring_mask + 1;
+	mem_size = rxr->rx_agg_bmap_size / 8;
+	rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
+	if (!rxr->rx_agg_bmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
+{
+	struct bnxt_rx_ring_info *rxr, *clone;
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_ring_struct *ring;
+	int rc;
+
+	rxr = &bp->rx_ring[idx];
+	clone = qmem;
+	memcpy(clone, rxr, sizeof(*rxr));
+	bnxt_init_rx_ring_struct(bp, clone);
+	bnxt_reset_rx_ring_struct(bp, clone);
+
+	clone->rx_prod = 0;
+	clone->rx_agg_prod = 0;
+	clone->rx_sw_agg_prod = 0;
+	clone->rx_next_cons = 0;
+
+	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
+	if (rc)
+		return rc;
+
+	ring = &clone->rx_ring_struct;
+	rc = bnxt_alloc_ring(bp, &ring->ring_mem);
+	if (rc)
+		goto err_free_rx_ring;
+
+	if (bp->flags & BNXT_FLAG_AGG_RINGS) {
+		ring = &clone->rx_agg_ring_struct;
+		rc = bnxt_alloc_ring(bp, &ring->ring_mem);
+		if (rc)
+			goto err_free_rx_agg_ring;
+
+		rc = bnxt_alloc_rx_agg_bmap(bp, clone);
+		if (rc)
+			goto err_free_rx_agg_ring;
+	}
+
+	bnxt_init_one_rx_ring_rxbd(bp, clone);
+	bnxt_init_one_rx_agg_ring_rxbd(bp, clone);
+
+	bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
+	if (bp->flags & BNXT_FLAG_AGG_RINGS)
+		bnxt_alloc_one_rx_ring_page(bp, clone, idx);
+
+	return 0;
+
+err_free_rx_agg_ring:
+	bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
+err_free_rx_ring:
+	bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
+	clone->page_pool->p.napi = NULL;
+	page_pool_destroy(clone->page_pool);
+	clone->page_pool = NULL;
+	return rc;
+}
+
+static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
+{
+	struct bnxt_rx_ring_info *rxr = qmem;
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_ring_struct *ring;
+
+	bnxt_free_one_rx_ring(bp, rxr);
+	bnxt_free_one_rx_agg_ring(bp, rxr);
+
+	/* At this point, this NAPI instance has another page pool associated
+	 * with it. Disconnect here before freeing the old page pool to avoid
+	 * warnings.
+	 */
+	rxr->page_pool->p.napi = NULL;
+	page_pool_destroy(rxr->page_pool);
+	rxr->page_pool = NULL;
+
+	ring = &rxr->rx_ring_struct;
+	bnxt_free_ring(bp, &ring->ring_mem);
+
+	ring = &rxr->rx_agg_ring_struct;
+	bnxt_free_ring(bp, &ring->ring_mem);
+
+	kfree(rxr->rx_agg_bmap);
+	rxr->rx_agg_bmap = NULL;
+}
+
+static void bnxt_copy_rx_ring(struct bnxt *bp,
+			      struct bnxt_rx_ring_info *dst,
+			      struct bnxt_rx_ring_info *src)
+{
+	struct bnxt_ring_mem_info *dst_rmem, *src_rmem;
+	struct bnxt_ring_struct *dst_ring, *src_ring;
+	int i;
+
+	dst_ring = &dst->rx_ring_struct;
+	dst_rmem = &dst_ring->ring_mem;
+	src_ring = &src->rx_ring_struct;
+	src_rmem = &src_ring->ring_mem;
+
+	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
+	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
+	WARN_ON(dst_rmem->flags != src_rmem->flags);
+	WARN_ON(dst_rmem->depth != src_rmem->depth);
+	WARN_ON(dst_rmem->vmem_size != src_rmem->vmem_size);
+	WARN_ON(dst_rmem->ctx_mem != src_rmem->ctx_mem);
+
+	dst_rmem->pg_tbl = src_rmem->pg_tbl;
+	dst_rmem->pg_tbl_map = src_rmem->pg_tbl_map;
+	*dst_rmem->vmem = *src_rmem->vmem;
+	for (i = 0; i < dst_rmem->nr_pages; i++) {
+		dst_rmem->pg_arr[i] = src_rmem->pg_arr[i];
+		dst_rmem->dma_arr[i] = src_rmem->dma_arr[i];
+	}
+
+	if (!(bp->flags & BNXT_FLAG_AGG_RINGS))
+		return;
+
+	dst_ring = &dst->rx_agg_ring_struct;
+	dst_rmem = &dst_ring->ring_mem;
+	src_ring = &src->rx_agg_ring_struct;
+	src_rmem = &src_ring->ring_mem;
+
+	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
+	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
+	WARN_ON(dst_rmem->flags != src_rmem->flags);
+	WARN_ON(dst_rmem->depth != src_rmem->depth);
+	WARN_ON(dst_rmem->vmem_size != src_rmem->vmem_size);
+	WARN_ON(dst_rmem->ctx_mem != src_rmem->ctx_mem);
+	WARN_ON(dst->rx_agg_bmap_size != src->rx_agg_bmap_size);
+
+	dst_rmem->pg_tbl = src_rmem->pg_tbl;
+	dst_rmem->pg_tbl_map = src_rmem->pg_tbl_map;
+	*dst_rmem->vmem = *src_rmem->vmem;
+	for (i = 0; i < dst_rmem->nr_pages; i++) {
+		dst_rmem->pg_arr[i] = src_rmem->pg_arr[i];
+		dst_rmem->dma_arr[i] = src_rmem->dma_arr[i];
+	}
+
+	dst->rx_agg_bmap = src->rx_agg_bmap;
+}
+
+static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_rx_ring_info *rxr, *clone;
+	struct bnxt_cp_ring_info *cpr;
+	int rc;
+
+	rxr = &bp->rx_ring[idx];
+	clone = qmem;
+
+	rxr->rx_prod = clone->rx_prod;
+	rxr->rx_agg_prod = clone->rx_agg_prod;
+	rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
+	rxr->rx_next_cons = clone->rx_next_cons;
+	rxr->page_pool = clone->page_pool;
+
+	bnxt_copy_rx_ring(bp, rxr, clone);
+
+	rc = bnxt_hwrm_rx_ring_alloc(bp, rxr);
+	if (rc)
+		return rc;
+	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
+	if (rc)
+		goto err_free_hwrm_rx_ring;
+
+	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
+	if (bp->flags & BNXT_FLAG_AGG_RINGS)
+		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
+
+	napi_enable(&rxr->bnapi->napi);
+
+	cpr = &rxr->bnapi->cp_ring;
+	cpr->sw_stats->rx.rx_resets++;
+
+	return 0;
+
+err_free_hwrm_rx_ring:
+	bnxt_hwrm_rx_ring_free(bp, rxr, false);
+	return rc;
+}
+
+static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_rx_ring_info *rxr;
+
+	rxr = &bp->rx_ring[idx];
+	napi_disable(&rxr->bnapi->napi);
+	bnxt_hwrm_rx_ring_free(bp, rxr, false);
+	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
+	rxr->rx_next_cons = 0;
+
+	memcpy(qmem, rxr, sizeof(*rxr));
+	bnxt_init_rx_ring_struct(bp, qmem);
+
+	return 0;
+}
+
+static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
+	.ndo_queue_mem_size	= sizeof(struct bnxt_rx_ring_info),
+	.ndo_queue_mem_alloc	= bnxt_queue_mem_alloc,
+	.ndo_queue_mem_free	= bnxt_queue_mem_free,
+	.ndo_queue_start	= bnxt_queue_start,
+	.ndo_queue_stop		= bnxt_queue_stop,
+};
+
 static void bnxt_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -15379,6 +15653,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
+	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	pci_set_drvdata(pdev, dev);
 
 	rc = bnxt_alloc_hwrm_resources(bp);
-- 
2.43.0


