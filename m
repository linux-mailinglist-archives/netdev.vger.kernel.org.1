Return-Path: <netdev+bounces-164878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E3A2F877
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2842F16821D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E63625745E;
	Mon, 10 Feb 2025 19:20:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9725744C
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215251; cv=none; b=Mb21sxTlrIRH6FP05Gp8nCuKwK5+iHGy/F9JV44iwPFuXktz++nrsXtsX08FM7SIndEjfAOT4QsSTS/dBmZzBM5Y92pzhoiK7ohi/tycl31oy28f6fngCT0E3x3fBv9Es1vvRIfsNxmrzBp+0V/ZZGRhCa64Y75Ie2g1wUgwIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215251; c=relaxed/simple;
	bh=5H87FUiatla00+qHXnRPAS5Lrou2rVMTndQq+MVXDBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rED8TW4zRYscD2oQV/UAh+4rlL8BWVi/oKWE/UPwklyDR4hAaFqvPRjjZf4jOujX6hUjFxgqn/3LGgjmKeAf0tMUp6iFO6w5tIaGlmLGWgJdTTxfjsA1kzBgeGRtSNjJyfF9hPpOwDjlqzONuohs2R5Fe0dTTFR3qRyPNgOpkQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f6d264221so28168145ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:20:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215248; x=1739820048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2sQ2LzwuJ8vVjKCwohPgmbUFgf3317d8VfMTyZKJP0=;
        b=G268DD2weCN2Q8ixSLGGYQ0mMLEE8gE3fpBcDM0cUoIf0a/hKw5e4TzKY7OLVZJSDd
         Q0K1gdZiiI0QDITkssRUB/nPNEr3fmugSRxnkq+dGfHk/jFDDnXVCTKB6mZOxxLjWzRh
         7qbbVdCaPSDCPtLT0m8PvB+ptSoYlNoE8v22rHpMSDeSr4uqo0Ibx3EZspWselb8SuBD
         TCsMqqIeVB8UjK1yie20EDsSv5Ebv4BRzZFwy9poHeIL28mrKfUdMi/K+BMzaQ+LZpgN
         VvbFwPLk1aJXJqbGS+VILGBRqj0j4pXM8+qqZoC6bHvZ6XBK8WPimV1q2nbOrNM6fbFi
         qVBQ==
X-Gm-Message-State: AOJu0Yz6Z8N6jOCXiqQHzapdjmlaktUWYG9KnOPJb80XNbiTULxg9NSS
	6/8oGkbtUqptMDWMisy6HZpwlapPUBSzBuNrwbTGq1DZ2jMk0bFJNrS8
X-Gm-Gg: ASbGncuJsgjnBBl/ZhaxF8gYXjKW8LgEKE+3wm7afCR7pL6Abnbio3z9LwWjVXnqoPc
	GvIjfiXpd1IooAV2b71fP1AOseblGsXdrmPb9ofSeTi+zz2BsN1UdbvmBYX59gIAtIb307y9Oqy
	nciSKBY9Y9Cd2zM42wTNDXoXojN2usEjuMWIN2GsAY3tSNsFEI8Ttc1KhU5U0c3xF+pQeY/ADvK
	ACkrLgfpV+7ZUc81V34vwnGVJd88wRZIaUm7lhV55ySjrrjVx83/ta+zWtPVVHVECo9wkbNHlMQ
	soegyNerJOIO1ho=
X-Google-Smtp-Source: AGHT+IHK8kLeKCY4JFjhKdkDXSYu4yWk+kQtZZ9Z+RYLxgGC40XXLaoRMg4vpIE9R90J1GeOqY+ZkA==
X-Received: by 2002:a05:6a20:c706:b0:1e1:af74:a235 with SMTP id adf61e73a8af0-1ee03a6b2d6mr28549076637.24.1739215248288;
        Mon, 10 Feb 2025 11:20:48 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7308983e214sm2857843b3a.89.2025.02.10.11.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:20:47 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next 03/11] net: hold netdev instance lock during queue operations
Date: Mon, 10 Feb 2025 11:20:35 -0800
Message-ID: <20250210192043.439074-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210192043.439074-1-sdf@fomichev.me>
References: <20250210192043.439074-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the drivers that use queue management API, switch to the mode where
core stack holds the netdev instance lock. This affects the following
drivers:
- bnxt
- gve
- netdevsim

Originally I locked only start/stop, but switched to holding the
lock over all iterations to make them look atomic to the device
(feels like it should be easier to reason about).

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c   | 22 +++++++++++++--------
 drivers/net/ethernet/google/gve/gve_main.c  |  8 ++++----
 drivers/net/ethernet/google/gve/gve_utils.c |  8 +++++---
 drivers/net/netdevsim/netdev.c              | 22 ++++++++++++---------
 include/linux/netdevice.h                   |  2 +-
 net/core/netdev_rx_queue.c                  |  5 +++++
 6 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b8b5b39c7bb..082a6c2b5cca 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11301,7 +11301,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 		if (rc)
 			break;
 
-		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
+		netif_napi_set_irq_locked(&bp->bnapi[i]->napi, irq->vector);
 		irq->requested = 1;
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
@@ -11337,9 +11337,9 @@ static void bnxt_del_napi(struct bnxt *bp)
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 
-		__netif_napi_del(&bnapi->napi);
+		__netif_napi_del_locked(&bnapi->napi);
 	}
-	/* We called __netif_napi_del(), we need
+	/* We called __netif_napi_del_locked(), we need
 	 * to respect an RCU grace period before freeing napi structures.
 	 */
 	synchronize_net();
@@ -11352,18 +11352,20 @@ static void bnxt_init_napi(struct bnxt *bp)
 	struct bnxt_napi *bnapi;
 	int i;
 
+	netdev_assert_locked(bp->dev);
+
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		poll_fn = bnxt_poll_p5;
 	else if (BNXT_CHIP_TYPE_NITRO_A0(bp))
 		cp_nr_rings--;
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
-		netif_napi_add_config(bp->dev, &bnapi->napi, poll_fn,
-				      bnapi->index);
+		netif_napi_add_config_locked(bp->dev, &bnapi->napi, poll_fn,
+					     bnapi->index);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bnapi = bp->bnapi[cp_nr_rings];
-		netif_napi_add(bp->dev, &bnapi->napi, bnxt_poll_nitroa0);
+		netif_napi_add_locked(bp->dev, &bnapi->napi, bnxt_poll_nitroa0);
 	}
 }
 
@@ -11375,6 +11377,8 @@ static void bnxt_disable_napi(struct bnxt *bp)
 	    test_and_set_bit(BNXT_STATE_NAPI_DISABLED, &bp->state))
 		return;
 
+	netdev_assert_locked(bp->dev);
+
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 		struct bnxt_cp_ring_info *cpr;
@@ -11384,7 +11388,7 @@ static void bnxt_disable_napi(struct bnxt *bp)
 			cpr->sw_stats->tx.tx_resets++;
 		if (bnapi->in_reset)
 			cpr->sw_stats->rx.rx_resets++;
-		napi_disable(&bnapi->napi);
+		napi_disable_locked(&bnapi->napi);
 	}
 }
 
@@ -11392,6 +11396,8 @@ static void bnxt_enable_napi(struct bnxt *bp)
 {
 	int i;
 
+	netdev_assert_locked(bp->dev);
+
 	clear_bit(BNXT_STATE_NAPI_DISABLED, &bp->state);
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
@@ -11406,7 +11412,7 @@ static void bnxt_enable_napi(struct bnxt *bp)
 			INIT_WORK(&cpr->dim.work, bnxt_dim_work);
 			cpr->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 		}
-		napi_enable(&bnapi->napi);
+		napi_enable_locked(&bnapi->napi);
 	}
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 533e659b15b3..cf9bd08d04b2 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1886,7 +1886,7 @@ static void gve_turndown(struct gve_priv *priv)
 			netif_queue_set_napi(priv->dev, idx,
 					     NETDEV_QUEUE_TYPE_TX, NULL);
 
-		napi_disable(&block->napi);
+		napi_disable_locked(&block->napi);
 	}
 	for (idx = 0; idx < priv->rx_cfg.num_queues; idx++) {
 		int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
@@ -1897,7 +1897,7 @@ static void gve_turndown(struct gve_priv *priv)
 
 		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
 				     NULL);
-		napi_disable(&block->napi);
+		napi_disable_locked(&block->napi);
 	}
 
 	/* Stop tx queues */
@@ -1925,7 +1925,7 @@ static void gve_turnup(struct gve_priv *priv)
 		if (!gve_tx_was_added_to_block(priv, idx))
 			continue;
 
-		napi_enable(&block->napi);
+		napi_enable_locked(&block->napi);
 
 		if (idx < priv->tx_cfg.num_queues)
 			netif_queue_set_napi(priv->dev, idx,
@@ -1953,7 +1953,7 @@ static void gve_turnup(struct gve_priv *priv)
 		if (!gve_rx_was_added_to_block(priv, idx))
 			continue;
 
-		napi_enable(&block->napi);
+		napi_enable_locked(&block->napi);
 		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
 				     &block->napi);
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index 30fef100257e..fa21d240806b 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -110,13 +110,15 @@ void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 {
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
-	netif_napi_add(priv->dev, &block->napi, gve_poll);
-	netif_napi_set_irq(&block->napi, block->irq);
+	netdev_assert_locked(priv->dev);
+	netif_napi_add_locked(priv->dev, &block->napi, gve_poll);
+	netif_napi_set_irq_locked(&block->napi, block->irq);
 }
 
 void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 {
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
-	netif_napi_del(&block->napi);
+	netdev_assert_locked(priv->dev);
+	netif_napi_del_locked(&block->napi);
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index d857ae3c8f06..07f4670d69d5 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -664,7 +664,7 @@ nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
 		goto err_free;
 
 	if (!ns->rq_reset_mode)
-		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
+		netif_napi_add_config_locked(dev, &qmem->rq->napi, nsim_poll, idx);
 
 	return 0;
 
@@ -681,7 +681,7 @@ static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
 	page_pool_destroy(qmem->pp);
 	if (qmem->rq) {
 		if (!ns->rq_reset_mode)
-			netif_napi_del(&qmem->rq->napi);
+			netif_napi_del_locked(&qmem->rq->napi);
 		page_pool_destroy(qmem->rq->page_pool);
 		nsim_queue_free(qmem->rq);
 	}
@@ -693,9 +693,11 @@ nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
 
+	netdev_assert_locked(dev);
+
 	if (ns->rq_reset_mode == 1) {
 		ns->rq[idx]->page_pool = qmem->pp;
-		napi_enable(&ns->rq[idx]->napi);
+		napi_enable_locked(&ns->rq[idx]->napi);
 		return 0;
 	}
 
@@ -703,15 +705,15 @@ nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
 	 * here we want to test various call orders.
 	 */
 	if (ns->rq_reset_mode == 2) {
-		netif_napi_del(&ns->rq[idx]->napi);
-		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
+		netif_napi_del_locked(&ns->rq[idx]->napi);
+		netif_napi_add_config_locked(dev, &qmem->rq->napi, nsim_poll, idx);
 	} else if (ns->rq_reset_mode == 3) {
-		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
-		netif_napi_del(&ns->rq[idx]->napi);
+		netif_napi_add_config_locked(dev, &qmem->rq->napi, nsim_poll, idx);
+		netif_napi_del_locked(&ns->rq[idx]->napi);
 	}
 
 	ns->rq[idx] = qmem->rq;
-	napi_enable(&ns->rq[idx]->napi);
+	napi_enable_locked(&ns->rq[idx]->napi);
 
 	return 0;
 }
@@ -721,7 +723,9 @@ static int nsim_queue_stop(struct net_device *dev, void *per_queue_mem, int idx)
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
 
-	napi_disable(&ns->rq[idx]->napi);
+	netdev_assert_locked(dev);
+
+	napi_disable_locked(&ns->rq[idx]->napi);
 
 	if (ns->rq_reset_mode == 1) {
 		qmem->pp = ns->rq[idx]->page_pool;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 06f24dc4f46e..7367e2972026 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2720,7 +2720,7 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 
 static inline bool need_netdev_ops_lock(struct net_device *dev)
 {
-	bool ret = false;
+	bool ret = !!(dev)->queue_mgmt_ops;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	ret |= !!(dev)->netdev_ops->net_shaper_ops;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index ddd54e1e7289..7419c41fd3cb 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -30,6 +30,8 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		goto err_free_new_mem;
 	}
 
+	netdev_lock(dev);
+
 	err = qops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
@@ -52,6 +54,8 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 
 	qops->ndo_queue_mem_free(dev, old_mem);
 
+	netdev_unlock(dev);
+
 	kvfree(old_mem);
 	kvfree(new_mem);
 
@@ -76,6 +80,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	qops->ndo_queue_mem_free(dev, new_mem);
 
 err_free_old_mem:
+	netdev_unlock(dev);
 	kvfree(old_mem);
 
 err_free_new_mem:
-- 
2.48.1


