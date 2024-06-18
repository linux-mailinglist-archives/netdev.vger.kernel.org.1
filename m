Return-Path: <netdev+bounces-104341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B2A90C33A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A5D1F227EA
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B368B3B295;
	Tue, 18 Jun 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ZSnd9bc9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06858249EB
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718689934; cv=none; b=j2pdQf7J876i/1xhTQnJ53pIsD/NnYMBtpmZynH1PSnx/qbfzNYdwvduPJh15JX9W9povZC88L7pBKgih79YWyCYjOap+okuj9oOjQ8q8POJ8krq0Dnu9QKHVI28atP9NnmWvz29KDAh/vc3hi4RidLeokaARkbOgg/u0nQUIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718689934; c=relaxed/simple;
	bh=F3lDqlJ7UruJNej8FPihz5f6vW2cFoVTwFbYgUFboBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6eyGzBZxvqsjayBY1y/3Mx0ImRcAWGsaUUkdGq2JAOj4+Km79gPJjeyRwAYYN4rlQttD7finBjxCRfdBKjUPS5eYvNOvCyZxvdAT0ppj6JwVN6HXLyMbRt9Lx1fWbrPBu/EN3yIOjmmu4aa5zZC2tI2li+N+ifBTHZpDTjSGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ZSnd9bc9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f8395a530dso43687335ad.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 22:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718689932; x=1719294732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaUyDmGQKozVhfyPY+cyzhojvOoZVxFyw5exrs8E7D8=;
        b=ZSnd9bc9O1WmaQlOsfdfgmdTEtP1JDaWxS2Mw0b53SZXihUMHwvh5uGOtBlKPS6v58
         pr7W0uNq7pbcOQ1hkBcV5TjE9OAW6tqR/ic80DjnxX/PNjqDkhVczk/pepkz+1h/7wcq
         +k4YrD5rev95KGtLNwLhYQLDndeU61nLtI2VULXz5yfjQUsY1qtuSt7giGD4M6FuZAvC
         1L8yeqjPcfa8FDsQdST6IyLq06IMrs/FiXO9XwNqoOBEod44KNQrECWf5eEGEHFs7S6d
         wOVbarS6/r870V1CrCnkvmXJD8U4TJ/zNNCs//2z5MpuCI3laj8XoHX5bGwyTFAbp1vV
         zXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718689932; x=1719294732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaUyDmGQKozVhfyPY+cyzhojvOoZVxFyw5exrs8E7D8=;
        b=iLxBkv0Ivv5GbsIJctjqiV75pftwF/mV0cZOqmq7FnlW1mkp84jFANM/A02kp64mEn
         C1ceL1uqEYEF/Rk257lsnlq8bzjLFLx7gO46Z920ifKxjq87jXicAgr3xVxJ0i/k331u
         dzWF1PBN2g1oRjqRycNDLSxQop2jgcXkO7R/q5g2+zqUp2TpiC/4RgKfrZRLWZIiqYxU
         DJDII0/LWH6yD+D257w5qtzJMvvGG+No9OExkX08/8Gsm0OviBvCZagZWJJhix5BreXa
         G+RRC1HHgMLpTWTpYnuWHMJTjc2217y2HSlMCKKWviUIT4sjDCIXIPgBdxMMh93wmheL
         xXwA==
X-Forwarded-Encrypted: i=1; AJvYcCUur8xySLVBqqRvq2Rv/tzg6DT4Ihp9wTWldtktEkHH6meB6Z+q5R12NLyhPlK2ZGxD7hH6m3bLtAfVkvimCXFoZYiaFPIp
X-Gm-Message-State: AOJu0Yw3HoZBkR/Zzi2kqd6aSkjEt1TxxSBuh4hkLZPsh1JhrMOrgxNd
	1AQDd8sJ9oO8e9iGALwaRA6h6tlO0pBxuTYv6m1l4hDVp2a2gFGq9+rwNfo56JY=
X-Google-Smtp-Source: AGHT+IE3ahTHqFvA3Vq5G4K8Qdqf5qFEQnoyclUJObhrgxP+RPIbTp+NTxSdf+4E4KqwMO9YN0RgEQ==
X-Received: by 2002:a17:903:244a:b0:1f7:1821:77ad with SMTP id d9443c01a7336-1f8625ce77amr137565135ad.14.1718689932307;
        Mon, 17 Jun 2024 22:52:12 -0700 (PDT)
Received: from localhost (fwdproxy-prn-005.fbsv.net. [2a03:2880:ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f40f38sm88646455ad.277.2024.06.17.22.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 22:52:12 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/3] bnxt_en: implement netdev_queue_mgmt_ops
Date: Mon, 17 Jun 2024 22:52:02 -0700
Message-ID: <20240618055202.2530064-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618055202.2530064-1-dw@davidwei.uk>
References: <20240618055202.2530064-1-dw@davidwei.uk>
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

Rx queues are stopped/started using bnxt_hwrm_vnic_update(), which only
affects queues that are not in the default RSS context. This is
different to the GVE that also implemented the queue API recently where
arbitrary Rx queues can be stopped. Due to this limitation, all ndos
returns EOPNOTSUPP if the queue is in the default RSS context.

Thanks to Somnath for helping me with using bnxt_hwrm_vnic_update() to
stop/start an Rx queue. With their permission I've added them as
Acked-by.

[1]: https://lore.kernel.org/netdev/20240501232549.1327174-2-shailend@google.com/

Acked-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 304 ++++++++++++++++++++++
 1 file changed, 304 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bbe37ea8e1ef..9bed899e0575 100644
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
@@ -14935,6 +14991,253 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
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
+	if (bnxt_get_max_rss_ring(bp) >= idx)
+		return -EOPNOTSUPP;
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
+	struct bnxt_vnic_info *vnic;
+	int rc;
+
+	if (bnxt_get_max_rss_ring(bp) >= idx)
+		return -EOPNOTSUPP;
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
+	vnic = &bp->vnic_info[BNXT_VNIC_NTUPLE];
+	vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
+	rc = bnxt_hwrm_vnic_update(bp, vnic,
+				   VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+	if (rc)
+		goto err_free_hwrm_rx_agg_ring;
+
+	cpr = &rxr->bnapi->cp_ring;
+	cpr->sw_stats->rx.rx_resets++;
+
+	return 0;
+
+err_free_hwrm_rx_agg_ring:
+	napi_disable(&rxr->bnapi->napi);
+	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
+err_free_hwrm_rx_ring:
+	bnxt_hwrm_rx_ring_free(bp, rxr, false);
+	return rc;
+}
+
+static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_rx_ring_info *rxr;
+	struct bnxt_vnic_info *vnic;
+	int rc;
+
+	if (bnxt_get_max_rss_ring(bp) >= idx)
+		return -EOPNOTSUPP;
+
+	vnic = &bp->vnic_info[BNXT_VNIC_NTUPLE];
+	vnic->mru = 0;
+	rc = bnxt_hwrm_vnic_update(bp, vnic,
+				   VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+	if (rc)
+		return rc;
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
@@ -15400,6 +15703,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
+	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	pci_set_drvdata(pdev, dev);
 
 	rc = bnxt_alloc_hwrm_resources(bp);
-- 
2.43.0


