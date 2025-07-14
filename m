Return-Path: <netdev+bounces-206766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA39B04507
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF0F4A00EF
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA6A25DB1C;
	Mon, 14 Jul 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wA6tmhsX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0725DAFF
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509117; cv=none; b=eyjdyvwEDdWmKgr1QDrEsyfBE8ttCv/cEEeOlimE/4HVe9k7aaRi8ZW8gKw/BbTRJ7HvVE6PWzcviHDQRvDDMg5me3yAPERQe1xEjUe+xS/wgoWChB5DfMQ2ww/3j/bpDvaXctjDrtq2hRZ3uH0MpUQRIxUE9t814vfn6g1MBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509117; c=relaxed/simple;
	bh=xNSEpNPh57JKSH/VEZdMFsV6mAzBiOk8QuQCburcvzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pt/ttnLbNc3SJ9PhGFiKH9ph9NASEu+eridcCD2KDFOOl231NjtQ92boYH1DmvYfzaV8gkK/BbT+EsjRWTwk1cXEIGdccjMMFyeMQ3AV8YyqLxNFqeRe3QQKyr1hs4XzKNKFjyvm1TtJFf3uz8Q9ANSKf+qnAaH1ZzMtGGE3tTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wA6tmhsX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c37558eccso3998670a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752509115; x=1753113915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmqtE1n6qYM7o20IeQfw03Q0kcLrhjY5U6X+n8Fe9mk=;
        b=wA6tmhsXhSYPBUpCspRiZdZL8luSZ/6iCqJX0OEWVncBWO+/0j8YMK9jzwTFginubo
         id9uWJbXDi2FqJwqFRPyalv892FiMpoZH1KCzGxgP9755TpIwEnfrA+R0D1MS2lMtLfb
         /nJToccDx08svAJSAe4EYolj3dPOOkGLDe/lC3sNKr/wy9yJKkDd584Tr0FoCgE22SlP
         fWRQ90g4KtgRG1thm5h9CyVn8OKAjQlpZOkIiYTTJ4X/cgdn+cPF11aKlhjWwscIGb3d
         zJ9J8uM1ljI2FvkeM8TPekTU8cZJzQ/fFDNKox0gQFLGRyRmSFav4Y1yzr0q9qlq97Ku
         GocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509115; x=1753113915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmqtE1n6qYM7o20IeQfw03Q0kcLrhjY5U6X+n8Fe9mk=;
        b=hN3sQ/MqXMTS2MR0vAjHQKAGAfdj1R9GcMLdU9n8Tghk+W8feUUqFiUXJs06YF7isK
         8i0QfBxE+F2O11fpY/DHiKHRca8nCwFgCamTt5OQFhabdHil1g7x9M/1jQrx3OiLuo8w
         z58lFt6drBOKixkyPbToDx3IW2KAPztztX06BVOmWfoMILPuNXSGHiXA7234NJygrRU1
         BL6VDl2FRnRCogjXdvv6/TMbQtWL8uZWqLznOQgD+2wVNk8e7PeSQfqsXVo1cQ7BuKD+
         yUKJ1AikQKq6bzINb810CJsQ2OAT5hgVRm6j2InSaU3Ykod8cmQVJwYUOzrhCBCHyT8e
         ECBg==
X-Gm-Message-State: AOJu0YzpRvqlo/FMiajgaekZT6lSAXfBELM6CqqgvkXfEd1fzuTzJN/X
	fa5jlM4MpKlzJHeIxTMfpWkMrG1Hy2ig6O9kmrwbh5ViQkX6aV1dyNdkSXQDSCKvhVEakwrHDaW
	pgvIUaGl/UE2p9imSW85Rizi5AMrG8YZdeggYCrp5vrKlNcBWMILfd8mNCSXjlG4MuEMgDd5vIf
	dNkwJr0Jk1zazh43Ma6ThpH8yNgd+vqGUJLKT4HAtZqfr/Xfo=
X-Google-Smtp-Source: AGHT+IHpJH6EWIz9PkCQgzCUyNiww3P5Tm1E4RUPt7w91JEyHVD4s6Pdho3jKPsVQT3sO1HX5m+hAXlepJkCRw==
X-Received: from pfbcw23.prod.google.com ([2002:a05:6a00:4517:b0:748:f030:4e6a])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2d23:b0:21f:50d9:dde with SMTP id adf61e73a8af0-2311dc63416mr19676386637.5.1752509115037;
 Mon, 14 Jul 2025 09:05:15 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:04:51 -0700
In-Reply-To: <20250714160451.124671-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714160451.124671-1-jeroendb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714160451.124671-6-jeroendb@google.com>
Subject: [PATCH net-next 5/5] gve: implement DQO RX datapath and control path
 for AF_XDP zero-copy
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
index b1aba3242435..9e96d1d111b1 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1612,13 +1612,24 @@ static int gve_xsk_pool_enable(struct net_device *dev,
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
 
@@ -1630,6 +1641,7 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	struct napi_struct *napi_tx;
 	struct xsk_buff_pool *pool;
 	int tx_qid;
+	int err;
 
 	if (qid >= priv->rx_cfg.num_queues)
 		return -EINVAL;
@@ -1645,6 +1657,13 @@ static int gve_xsk_pool_disable(struct net_device *dev,
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
 
@@ -1656,12 +1675,14 @@ static int gve_xsk_pool_disable(struct net_device *dev,
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
@@ -2288,6 +2309,7 @@ static void gve_set_netdev_xdp_features(struct gve_priv *priv)
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


