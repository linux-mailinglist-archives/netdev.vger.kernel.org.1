Return-Path: <netdev+bounces-207927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 183EBB09098
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547631C456E6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8A92F949F;
	Thu, 17 Jul 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vs+yIVc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEEC2F94B3
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766141; cv=none; b=Oa2Gxi1+pk+tpUqEx+eKWfjktnI6r499U8/pVK2nd0qNfxi0XizYKPsBN8BIO9ATfLU/akRqqiPaX0oFtwCSABcNbGqFFwdRU/+jvF3WkRfw/qLk3uCB5XgPGwSNXo1jFwMYZzWtJE8hQHhne1m2AG7rybLiQD55flaJnhVZUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766141; c=relaxed/simple;
	bh=9S4Q8Qv5RJMh6VRveYgcZUc6W75sz27CghyI170ywMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cC2U+3itx3Brq0hFZA9T1y3Cu1JCe50uI6FkMZCS6IoQ5eId4BW6LYvHUsVHkTf2Xcwb6GuVeEm7Nqi8Jp+ozDwAi80PPVEt06+/1KqzWz0DtuB38axeDVFBa7LWrMOAJ8qsQUabsS0SrLb/EFp/mJ5REXfLU9yu8qoMi8UwRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vs+yIVc0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso1660376b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752766139; x=1753370939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B3QeYl8Fq3/VWlv4CYcN87ilLKbrjsXrp26vrHIciUQ=;
        b=vs+yIVc0Hub1YrOkbFdDd+Nn5HOz1/kpCUgUQfPACBJf3zngX6UBD6KAtXJckf7I4u
         7YMuoFr3mva0yfW/KKnJO+PoHH2jyVIWaj8wmePHbog2bmNvalCzryozBgHdKwunyGSo
         VzCi6mbIkNl755KrUbD9FDC9UXw6pixni6f7umJtbbs6X36fXheqqMauD2wC/9XvLaHE
         6z1/xRq0cqInrHk3IA/8LCUoLNuiwWGCmq/WYsUM/BVjyFBiN5V525dhOpuSgl23QTgq
         GxXh8FWL0QGZQl6Wo7oMq9dp2KHqj3JebuiVobfWtBdgmklyqLFDlbNkZCj4nU+tcjO6
         u6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766139; x=1753370939;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3QeYl8Fq3/VWlv4CYcN87ilLKbrjsXrp26vrHIciUQ=;
        b=j4PmDuV3L73ABnLxpcSABxmqsAcxKggtW90mrw+a0Tdz7gIYfxLPzceBxz3CQnKfBN
         PheF2ida06MIq18glMoj6x8nDzQM2Z6WBO8sO1aCsxgY7lrcwBJH2xQs4OnbLIGQRVP/
         VbW50GllPX4wtto7aqGgIZ17z3Hp7h2loLMQJpt1tWEMdrWIwttDQ5CX6Fg3qJu2fYQk
         Z5uoOhkpzalDfIvfIZEDfkSdhYf2WJlG23loQEjmnUA83p7e8ouIU4xVIdb/yjr4tbCy
         ZUv6WWAIy+jCeLBB7NpFBvpbRYtaStbxg7S5qtt+LOfqwAN50JdWLJ2GpkNwCoMmxOCP
         TjOw==
X-Gm-Message-State: AOJu0YyvGfT6IBm4VdtkjtDYsdHMJ/b7cW7eb1MVLrAuuhYQojEM7gOo
	BxGaoanElGK9bRMYL0xpFXF3Pp/t5oIfvR9cK6Ej8VeJfuZhnxsXUIuvQ+VIXZSRFGi0l6PaUX6
	ES50ed8kMiXiFjKjN8qjhsB4H9I4JqXHYtYcCDp+QVdNMGWznGjKfRj9GEsrstkGTGzYIgb1kNy
	ukNKs95nZLR85uxGqffDijD3cIe0K0cN8BbYkNRRk8yKQDRI0=
X-Google-Smtp-Source: AGHT+IHNoLT8PfI8nlcqJY/MeaM+7NCvYpxq67GR0nLpuk8m7b8cszoMz4/KCLCB3fSXxTrSsWdsSVHb5FJQtQ==
X-Received: from pfbbd35.prod.google.com ([2002:a05:6a00:27a3:b0:746:1eb5:7f3e])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:cd5:b0:748:f365:bedd with SMTP id d2e1a72fcca58-7572568099fmr8283895b3a.17.1752766138775;
 Thu, 17 Jul 2025 08:28:58 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:28:39 -0700
In-Reply-To: <20250717152839.973004-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717152839.973004-1-jeroendb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717152839.973004-6-jeroendb@google.com>
Subject: [PATCH net-next v2 5/5] gve: implement DQO RX datapath and control
 path for AF_XDP zero-copy
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: hramamurthy@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

Add the RX datapath for AF_XDP zero-copy for DQ RDA. The RX path is
quite similar to that of the normal XDP case. Parallel methods are
introduced to properly handle XSKs instead of normal driver buffers.

To properly support posting from XSKs, queues are destroyed and
recreated, as the driver was initially making use of page pool buffers
instead of the XSK pool memory.

Expose support for AF_XDP zero-copy, as the TX and RX datapaths both
exist.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  3 +
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 24 ++++-
 drivers/net/ethernet/google/gve/gve_main.c    | 42 +++++++--
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 94 ++++++++++++++++++-
 4 files changed, 149 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index ff7dc06e7fa4..bceaf9b05cb4 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -190,6 +190,9 @@ struct gve_rx_buf_state_dqo {
 	/* The page posted to HW. */
 	struct gve_rx_slot_page_info page_info;
 
+	/* XSK buffer */
+	struct xdp_buff *xsk_buff;
+
 	/* The DMA address corresponding to `page_info`. */
 	dma_addr_t addr;
 
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 6c3c459a1b5e..8f5021e59e0a 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2015-2024 Google, Inc.
  */
 
+#include <net/xdp_sock_drv.h>
 #include "gve.h"
 #include "gve_utils.h"
 
@@ -29,6 +30,10 @@ struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx)
 	/* Point buf_state to itself to mark it as allocated */
 	buf_state->next = buffer_id;
 
+	/* Clear the buffer pointers */
+	buf_state->page_info.page = NULL;
+	buf_state->xsk_buff = NULL;
+
 	return buf_state;
 }
 
@@ -286,7 +291,24 @@ int gve_alloc_buffer(struct gve_rx_ring *rx, struct gve_rx_desc_dqo *desc)
 {
 	struct gve_rx_buf_state_dqo *buf_state;
 
-	if (rx->dqo.page_pool) {
+	if (rx->xsk_pool) {
+		buf_state = gve_alloc_buf_state(rx);
+		if (unlikely(!buf_state))
+			return -ENOMEM;
+
+		buf_state->xsk_buff = xsk_buff_alloc(rx->xsk_pool);
+		if (unlikely(!buf_state->xsk_buff)) {
+			xsk_set_rx_need_wakeup(rx->xsk_pool);
+			gve_free_buf_state(rx, buf_state);
+			return -ENOMEM;
+		}
+		/* Allocated xsk buffer. Clear wakeup in case it was set. */
+		xsk_clear_rx_need_wakeup(rx->xsk_pool);
+		desc->buf_id = cpu_to_le16(buf_state - rx->dqo.buf_states);
+		desc->buf_addr =
+			cpu_to_le64(xsk_buff_xdp_get_dma(buf_state->xsk_buff));
+		return 0;
+	} else if (rx->dqo.page_pool) {
 		buf_state = gve_alloc_buf_state(rx);
 		if (WARN_ON_ONCE(!buf_state))
 			return -ENOMEM;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index c6ccc0bb40c9..6ea306947417 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1610,13 +1610,24 @@ static int gve_xsk_pool_enable(struct net_device *dev,
 		return 0;
 
 	err = gve_reg_xsk_pool(priv, dev, pool, qid);
-	if (err) {
-		clear_bit(qid, priv->xsk_pools);
-		xsk_pool_dma_unmap(pool,
-				   DMA_ATTR_SKIP_CPU_SYNC |
-				   DMA_ATTR_WEAK_ORDERING);
+	if (err)
+		goto err_xsk_pool_dma_mapped;
+
+	/* Stop and start RDA queues to repost buffers. */
+	if (!gve_is_qpl(priv)) {
+		err = gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
+		if (err)
+			goto err_xsk_pool_registered;
 	}
+	return 0;
 
+err_xsk_pool_registered:
+	gve_unreg_xsk_pool(priv, qid);
+err_xsk_pool_dma_mapped:
+	clear_bit(qid, priv->xsk_pools);
+	xsk_pool_dma_unmap(pool,
+			   DMA_ATTR_SKIP_CPU_SYNC |
+			   DMA_ATTR_WEAK_ORDERING);
 	return err;
 }
 
@@ -1628,6 +1639,7 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	struct napi_struct *napi_tx;
 	struct xsk_buff_pool *pool;
 	int tx_qid;
+	int err;
 
 	if (qid >= priv->rx_cfg.num_queues)
 		return -EINVAL;
@@ -1643,6 +1655,13 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	if (!netif_running(dev) || !priv->tx_cfg.num_xdp_queues)
 		return 0;
 
+	/* Stop and start RDA queues to repost buffers. */
+	if (!gve_is_qpl(priv) && priv->xdp_prog) {
+		err = gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
+		if (err)
+			return err;
+	}
+
 	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
 	napi_disable(napi_rx); /* make sure current rx poll is done */
 
@@ -1654,12 +1673,14 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	smp_mb(); /* Make sure it is visible to the workers on datapath */
 
 	napi_enable(napi_rx);
-	if (gve_rx_work_pending(&priv->rx[qid]))
-		napi_schedule(napi_rx);
-
 	napi_enable(napi_tx);
-	if (gve_tx_clean_pending(priv, &priv->tx[tx_qid]))
-		napi_schedule(napi_tx);
+	if (gve_is_gqi(priv)) {
+		if (gve_rx_work_pending(&priv->rx[qid]))
+			napi_schedule(napi_rx);
+
+		if (gve_tx_clean_pending(priv, &priv->tx[tx_qid]))
+			napi_schedule(napi_tx);
+	}
 
 	return 0;
 }
@@ -2286,6 +2307,7 @@ static void gve_set_netdev_xdp_features(struct gve_priv *priv)
 	} else if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
 		xdp_features = NETDEV_XDP_ACT_BASIC;
 		xdp_features |= NETDEV_XDP_ACT_REDIRECT;
+		xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
 	} else {
 		xdp_features = 0;
 	}
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index afaa822b1227..7380c2b7a2d8 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -16,6 +16,7 @@
 #include <net/ip6_checksum.h>
 #include <net/ipv6.h>
 #include <net/tcp.h>
+#include <net/xdp_sock_drv.h>
 
 static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
 {
@@ -149,6 +150,10 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 			gve_free_to_page_pool(rx, bs, false);
 		else
 			gve_free_qpl_page_dqo(bs);
+		if (gve_buf_state_is_allocated(rx, bs) && bs->xsk_buff) {
+			xsk_buff_free(bs->xsk_buff);
+			bs->xsk_buff = NULL;
+		}
 	}
 
 	if (rx->dqo.qpl) {
@@ -580,8 +585,11 @@ static int gve_xdp_tx_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 	int err;
 
 	xdpf = xdp_convert_buff_to_frame(xdp);
-	if (unlikely(!xdpf))
+	if (unlikely(!xdpf)) {
+		if (rx->xsk_pool)
+			xsk_buff_free(xdp);
 		return -ENOSPC;
+	}
 
 	tx_qid = gve_xdp_tx_queue_id(priv, rx->q_num);
 	tx = &priv->tx[tx_qid];
@@ -592,6 +600,41 @@ static int gve_xdp_tx_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 	return err;
 }
 
+static void gve_xsk_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
+			     struct xdp_buff *xdp, struct bpf_prog *xprog,
+			     int xdp_act)
+{
+	switch (xdp_act) {
+	case XDP_ABORTED:
+	case XDP_DROP:
+	default:
+		xsk_buff_free(xdp);
+		break;
+	case XDP_TX:
+		if (unlikely(gve_xdp_tx_dqo(priv, rx, xdp)))
+			goto err;
+		break;
+	case XDP_REDIRECT:
+		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog)))
+			goto err;
+		break;
+	}
+
+	u64_stats_update_begin(&rx->statss);
+	if ((u32)xdp_act < GVE_XDP_ACTIONS)
+		rx->xdp_actions[xdp_act]++;
+	u64_stats_update_end(&rx->statss);
+	return;
+
+err:
+	u64_stats_update_begin(&rx->statss);
+	if (xdp_act == XDP_TX)
+		rx->xdp_tx_errors++;
+	if (xdp_act == XDP_REDIRECT)
+		rx->xdp_redirect_errors++;
+	u64_stats_update_end(&rx->statss);
+}
+
 static void gve_xdp_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 			     struct xdp_buff *xdp, struct bpf_prog *xprog,
 			     int xdp_act,
@@ -633,6 +676,48 @@ static void gve_xdp_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 	return;
 }
 
+static int gve_rx_xsk_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
+			  struct gve_rx_buf_state_dqo *buf_state, int buf_len,
+			  struct bpf_prog *xprog)
+{
+	struct xdp_buff *xdp = buf_state->xsk_buff;
+	struct gve_priv *priv = rx->gve;
+	int xdp_act;
+
+	xdp->data_end = xdp->data + buf_len;
+	xsk_buff_dma_sync_for_cpu(xdp);
+
+	if (xprog) {
+		xdp_act = bpf_prog_run_xdp(xprog, xdp);
+		buf_len = xdp->data_end - xdp->data;
+		if (xdp_act != XDP_PASS) {
+			gve_xsk_done_dqo(priv, rx, xdp, xprog, xdp_act);
+			gve_free_buf_state(rx, buf_state);
+			return 0;
+		}
+	}
+
+	/* Copy the data to skb */
+	rx->ctx.skb_head = gve_rx_copy_data(priv->dev, napi,
+					    xdp->data, buf_len);
+	if (unlikely(!rx->ctx.skb_head)) {
+		xsk_buff_free(xdp);
+		gve_free_buf_state(rx, buf_state);
+		return -ENOMEM;
+	}
+	rx->ctx.skb_tail = rx->ctx.skb_head;
+
+	/* Free XSK buffer and Buffer state */
+	xsk_buff_free(xdp);
+	gve_free_buf_state(rx, buf_state);
+
+	/* Update Stats */
+	u64_stats_update_begin(&rx->statss);
+	rx->xdp_actions[XDP_PASS]++;
+	u64_stats_update_end(&rx->statss);
+	return 0;
+}
+
 /* Returns 0 if descriptor is completed successfully.
  * Returns -EINVAL if descriptor is invalid.
  * Returns -ENOMEM if data cannot be copied to skb.
@@ -671,7 +756,11 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	buf_len = compl_desc->packet_len;
 	hdr_len = compl_desc->header_len;
 
-	/* Page might have not been used for a while and was likely last written
+	xprog = READ_ONCE(priv->xdp_prog);
+	if (buf_state->xsk_buff)
+		return gve_rx_xsk_dqo(napi, rx, buf_state, buf_len, xprog);
+
+	/* Page might have not been used for awhile and was likely last written
 	 * by a different thread.
 	 */
 	if (rx->dqo.page_pool) {
@@ -721,7 +810,6 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		return 0;
 	}
 
-	xprog = READ_ONCE(priv->xdp_prog);
 	if (xprog) {
 		struct xdp_buff xdp;
 		void *old_data;
-- 
2.50.0.727.gbf7dc18ff4-goog


