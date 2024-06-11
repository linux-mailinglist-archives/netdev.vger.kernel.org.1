Return-Path: <netdev+bounces-102426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BAC902E6F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD82A1F237C0
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EDC16F911;
	Tue, 11 Jun 2024 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="m9Uyg8k6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284816F905
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073211; cv=none; b=TzLbqsFWsH3yIxYGIeTX0iHUeG8oI9pYf98ycqJzRdwTiYS+CkV6UWNrdX59eedrHAoqKgknAy4XK/hUOrJtTLM0rqgnNgN4h/R4/CGiba27WBl9qRBHHhPlz70VMl1U8hjyTiIcZ4RWtHOOSKhyGGI3D/blRP5FY2l9GKn3Yts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073211; c=relaxed/simple;
	bh=LZTv85ATis+ddyvck+KEPEwK1lZTIaLO02kfrntF5Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5FzGEG0xFhaZqhyiVn3oabU7p4uMvBg0Y3FowtQ/2tQ4m1iNF7XV9ARf+6kimf8fiosRCmoY0iV0sW3wWpR9TASf+hQbWzJ+0aL5KuWrTMlFzwNXgkCMtRfgYIZcPVQ+dS51oODMFoYk6jFDvJ8EhGJr8M0CMupJD708rwMh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=m9Uyg8k6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so4164869a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718073209; x=1718678009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO3xY7Kpb0crdqtPY8szjxwk8IF11cJAPMgOZQX7g+w=;
        b=m9Uyg8k6bHZOugTNScJu6LYFIX6+Y+QsCAG2ROuXh2UPV57C+fngmT8EAuzNrNgU2l
         4KvqJkBJdGUAAcfqAAWJQoAlGfgWyAafXksVBEY+4OnTd67VCYBAgG3w0/idw+EgoEyM
         ZhRrLcEiBNDvYUIw0aiMPKvsjF/C8EVEWQ5NOtgdu906K8pnauWNpGWCJ1SZiSOtzUUN
         6yZn05syqVK9HExp1nGvRtTqjpCBjDbF6fNfZQe43QJxcLido/TtloNaQRIctb7oXv8h
         UKYoEIgsbNrXQRiDSEc+GoN8UQyicMhmeOty5uBke9Hhh9isRuS1ZFzRb02KRF3EV1J7
         p0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718073209; x=1718678009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rO3xY7Kpb0crdqtPY8szjxwk8IF11cJAPMgOZQX7g+w=;
        b=saVA/Ovl5n/CUbL7YNpJtgD/6tJd5nCeViaGae2u5gdFyZXQC7P5GFJWje5HLsGnHA
         BocTZfXDi6njhqz13zXUws57VVN/iC6s0DuwRPCWJL1To8WXOoZqEYgIV/ERLYSYwpkS
         TQxsxiH3sNiCmoq5T0HJjobgv7A+gxQyWWvCJd6bv+NOZ3FsIMb+w+4v+RHysanTKlUO
         kuhJTpS5YcqQ1quUySK7PZGcafhkB2i2YAaQ1NShbPGxSDE9YR0jhwUaPkloBSiq+iCg
         jc1VtKY/t1iA3AhgMlIWDgFxN5DDiCXstf/3VP6OrqUCPJSKM0GIM0Tlvo2H87HYXZvm
         SiTg==
X-Forwarded-Encrypted: i=1; AJvYcCXgWmUSoAiIgc013i3SnHC25LILSxb2eLq5kggYznTjAOOUU2W7v0ncqXZs2Run46/HoeEz0fvGn5OkUQZbJmWvCPouHoTN
X-Gm-Message-State: AOJu0YxS3eMZcs5f8LOQulqo6ePvobP2m/P26hwBEbJi7h0gJEX/pt4f
	W7rxezBWZH/NAdkY/oNAmaHzEe2GmAS3a7cqEjLWSLjpokSSULu+lRLhmSsHU04=
X-Google-Smtp-Source: AGHT+IHOhji1trcJvU0ckhSn+2V2n3eFnAPLQmiVphZ6slmJPqr6tA/ZeqvRh9YFR+8UPd94Czr0Vg==
X-Received: by 2002:a17:903:32c5:b0:1f7:126:5ba7 with SMTP id d9443c01a7336-1f72892f9c8mr22273585ad.21.1718073209478;
        Mon, 10 Jun 2024 19:33:29 -0700 (PDT)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8080c2f55sm4196163a12.83.2024.06.10.19.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 19:33:29 -0700 (PDT)
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
Subject: [PATCH net-next v1 3/3] bnxt_en: implement netdev_queue_mgmt_ops
Date: Mon, 10 Jun 2024 19:33:24 -0700
Message-ID: <20240611023324.1485426-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611023324.1485426-1-dw@davidwei.uk>
References: <20240611023324.1485426-1-dw@davidwei.uk>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 307 ++++++++++++++++++++++
 1 file changed, 307 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b5895e0854d1..aa857b109378 100644
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
@@ -14937,6 +14993,256 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
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
+	if (bnxt_get_max_rss_ring(bp) >= idx)
+		return -EOPNOTSUPP;
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
@@ -15402,6 +15708,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
+	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	pci_set_drvdata(pdev, dev);
 
 	rc = bnxt_alloc_hwrm_resources(bp);
-- 
2.43.0


