Return-Path: <netdev+bounces-172141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4189A50519
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763013A8E00
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338119D8A3;
	Wed,  5 Mar 2025 16:37:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6B192B95
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192663; cv=none; b=UrmYT8u31/dc/3lGZ9FLB1vX5pYx72EQuSCEXbzJq6/aC/C7kbYW3EZCFoOcGhmMA9B8fm5E8JNW9UrJ8BXUEB/EuVDGNoS8xmPk3teN09hjzFVNi/gjqRMyrF/jUp65i6odo0KSFR/uDHDpYA5WRZRosBOfvBlTiQcN/AFtkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192663; c=relaxed/simple;
	bh=li3Wwhg55SivnUAeThdOqzIJVkOnxj0oZKJ/9oSuuew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lqk2gtwPgQ3fAPLjfiHycy9NojNwcR1fiAXKODdBZ7Q44tBH75/qh6AdqfQXN8NJpDF/1v/70oUYp6imAMbl2FeWuI7AxaP+EOJp2WT1/8Y2Fx722E52kSmyiCuqaK/+5cu4xAR60P4lqtyyGiUoTJIPFIud+uUovy5Vw/rQnt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2235908a30aso130145375ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192660; x=1741797460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsHNQQq2drxqjAJqNRZN+ZyX4jGsveyzK5+6UaTisuw=;
        b=S6hvFz+3sI2rn+iPa0Mh+VcROq9O6igJgxULahUc2LqSBWHT9KfcrHiB7q7ZsN20c8
         v6vNAEeTl5i0oCXylMS3Ok6QYgcsg+ewf6PCloWq+IlQjNsmQgN+htuQrjcMcvmf5fpF
         WGaPB7jxuBQK9TTQPzZYI9AmESEQda1wohZnyE01woifsUHQSu6L3SKZOXCP4htX0QpE
         o5cZgNMY3vsW3lurB8GapMtUOH08+fdZb3oAY6nC7/VG6K5kamPrzyxjtLFGSNCRs8Z9
         ymg8u7n4DNNQVM6uQGb3Y7ip0dRUSiWa1Lg6IyKkcFJKrV9nm13ivN1Fb6wtxCB/uw/c
         zk3A==
X-Gm-Message-State: AOJu0Ywq0SRxL/y221L/H/QM/RGuJT4P4Agykhnoz+wAA1+pFen4bXXm
	Rvd3TJg5FyzUDIyGulinOZtJGVg0iEVRQF+YaA7vDesPrFTAUFzaAzso
X-Gm-Gg: ASbGncvdXpKFhuxfLT9SCFiAiJz1ApGpY2soGlfa1p2HtC1N+fnbVwoxvUTKljSFnPB
	an2ZKKOc+P3iOr9ECs4iSt4xvpWGDkhE0LRpptmTAXvsWZ24zFJbi5ybxoHWEig6wUzNjS7ZpG6
	Pl56jqeYbQ3wLehbbKoawu1+W1/HQPZkxA4KbaMwBGDuZn9ovB0c/aX857EZ+CFwmfvDYXohhvx
	wP3/V9XP99UcqcOmBO1jRlPzXY0XlF8XhchY5m9iOq2AK9dYitGihQS7HuHVnH/iuKup/2K4xc5
	0NpdI180LTzkFIUjgrsPDCgOwNs+wRivaJRTl4BSkEwW
X-Google-Smtp-Source: AGHT+IGNZKnM8wSP8lnzq4J7Bn/4PLvQT2SuxLzkfw6MLXfSYwZ1TXriG7Eu8uBfK6N50uHwBa3+EA==
X-Received: by 2002:a17:902:ea10:b0:21b:b3c9:38ff with SMTP id d9443c01a7336-223f1cf49f5mr57568075ad.37.1741192660109;
        Wed, 05 Mar 2025 08:37:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2235020c2c9sm115546635ad.105.2025.03.05.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:37:39 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 05/14] net: hold netdev instance lock during queue operations
Date: Wed,  5 Mar 2025 08:37:23 -0800
Message-ID: <20250305163732.2766420-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305163732.2766420-1-sdf@fomichev.me>
References: <20250305163732.2766420-1-sdf@fomichev.me>
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

Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c   | 16 ++++++-------
 drivers/net/ethernet/google/gve/gve_main.c  | 12 ++++++----
 drivers/net/ethernet/google/gve/gve_utils.c |  6 ++---
 drivers/net/netdevsim/netdev.c              | 25 +++++++++++++--------
 include/linux/netdevice.h                   |  2 +-
 net/core/netdev_rx_queue.c                  |  5 +++++
 6 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 15c57a06ecaf..ead9fcaad6bd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11508,7 +11508,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 		if (rc)
 			break;
 
-		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
+		netif_napi_set_irq_locked(&bp->bnapi[i]->napi, irq->vector);
 		irq->requested = 1;
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
@@ -11557,9 +11557,9 @@ static void bnxt_del_napi(struct bnxt *bp)
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
@@ -11578,12 +11578,12 @@ static void bnxt_init_napi(struct bnxt *bp)
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
 
@@ -11604,7 +11604,7 @@ static void bnxt_disable_napi(struct bnxt *bp)
 			cpr->sw_stats->tx.tx_resets++;
 		if (bnapi->in_reset)
 			cpr->sw_stats->rx.rx_resets++;
-		napi_disable(&bnapi->napi);
+		napi_disable_locked(&bnapi->napi);
 	}
 }
 
@@ -11626,7 +11626,7 @@ static void bnxt_enable_napi(struct bnxt *bp)
 			INIT_WORK(&cpr->dim.work, bnxt_dim_work);
 			cpr->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 		}
-		napi_enable(&bnapi->napi);
+		napi_enable_locked(&bnapi->napi);
 	}
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 029be8342b7b..6dcdcaf518f4 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1968,7 +1968,7 @@ static void gve_turndown(struct gve_priv *priv)
 			netif_queue_set_napi(priv->dev, idx,
 					     NETDEV_QUEUE_TYPE_TX, NULL);
 
-		napi_disable(&block->napi);
+		napi_disable_locked(&block->napi);
 	}
 	for (idx = 0; idx < priv->rx_cfg.num_queues; idx++) {
 		int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
@@ -1979,7 +1979,7 @@ static void gve_turndown(struct gve_priv *priv)
 
 		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
 				     NULL);
-		napi_disable(&block->napi);
+		napi_disable_locked(&block->napi);
 	}
 
 	/* Stop tx queues */
@@ -2009,7 +2009,7 @@ static void gve_turnup(struct gve_priv *priv)
 		if (!gve_tx_was_added_to_block(priv, idx))
 			continue;
 
-		napi_enable(&block->napi);
+		napi_enable_locked(&block->napi);
 
 		if (idx < priv->tx_cfg.num_queues)
 			netif_queue_set_napi(priv->dev, idx,
@@ -2037,7 +2037,7 @@ static void gve_turnup(struct gve_priv *priv)
 		if (!gve_rx_was_added_to_block(priv, idx))
 			continue;
 
-		napi_enable(&block->napi);
+		napi_enable_locked(&block->napi);
 		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
 				     &block->napi);
 
@@ -2887,6 +2887,7 @@ static int gve_suspend(struct pci_dev *pdev, pm_message_t state)
 
 	priv->suspend_cnt++;
 	rtnl_lock();
+	netdev_lock(netdev);
 	if (was_up && gve_close(priv->dev)) {
 		/* If the dev was up, attempt to close, if close fails, reset */
 		gve_reset_and_teardown(priv, was_up);
@@ -2895,6 +2896,7 @@ static int gve_suspend(struct pci_dev *pdev, pm_message_t state)
 		gve_teardown_priv_resources(priv);
 	}
 	priv->up_before_suspend = was_up;
+	netdev_unlock(netdev);
 	rtnl_unlock();
 	return 0;
 }
@@ -2907,7 +2909,9 @@ static int gve_resume(struct pci_dev *pdev)
 
 	priv->resume_cnt++;
 	rtnl_lock();
+	netdev_lock(netdev);
 	err = gve_reset_recovery(priv, priv->up_before_suspend);
+	netdev_unlock(netdev);
 	rtnl_unlock();
 	return err;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index 30fef100257e..ace9b8698021 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -110,13 +110,13 @@ void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 {
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
-	netif_napi_add(priv->dev, &block->napi, gve_poll);
-	netif_napi_set_irq(&block->napi, block->irq);
+	netif_napi_add_locked(priv->dev, &block->napi, gve_poll);
+	netif_napi_set_irq_locked(&block->napi, block->irq);
 }
 
 void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 {
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
-	netif_napi_del(&block->napi);
+	netif_napi_del_locked(&block->napi);
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index aaa3b58e2e3e..54d03b0628d2 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -683,7 +683,8 @@ nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
 		goto err_free;
 
 	if (!ns->rq_reset_mode)
-		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
+		netif_napi_add_config_locked(dev, &qmem->rq->napi, nsim_poll,
+					     idx);
 
 	return 0;
 
@@ -700,7 +701,7 @@ static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
 	page_pool_destroy(qmem->pp);
 	if (qmem->rq) {
 		if (!ns->rq_reset_mode)
-			netif_napi_del(&qmem->rq->napi);
+			netif_napi_del_locked(&qmem->rq->napi);
 		page_pool_destroy(qmem->rq->page_pool);
 		nsim_queue_free(qmem->rq);
 	}
@@ -712,9 +713,11 @@ nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
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
 
@@ -722,15 +725,17 @@ nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
 	 * here we want to test various call orders.
 	 */
 	if (ns->rq_reset_mode == 2) {
-		netif_napi_del(&ns->rq[idx]->napi);
-		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
+		netif_napi_del_locked(&ns->rq[idx]->napi);
+		netif_napi_add_config_locked(dev, &qmem->rq->napi, nsim_poll,
+					     idx);
 	} else if (ns->rq_reset_mode == 3) {
-		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
-		netif_napi_del(&ns->rq[idx]->napi);
+		netif_napi_add_config_locked(dev, &qmem->rq->napi, nsim_poll,
+					     idx);
+		netif_napi_del_locked(&ns->rq[idx]->napi);
 	}
 
 	ns->rq[idx] = qmem->rq;
-	napi_enable(&ns->rq[idx]->napi);
+	napi_enable_locked(&ns->rq[idx]->napi);
 
 	return 0;
 }
@@ -740,7 +745,9 @@ static int nsim_queue_stop(struct net_device *dev, void *per_queue_mem, int idx)
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
 
-	napi_disable(&ns->rq[idx]->napi);
+	netdev_assert_locked(dev);
+
+	napi_disable_locked(&ns->rq[idx]->napi);
 
 	if (ns->rq_reset_mode == 1) {
 		qmem->pp = ns->rq[idx]->page_pool;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 69951eeb96d2..abda17b15950 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2755,7 +2755,7 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 
 static inline bool netdev_need_ops_lock(struct net_device *dev)
 {
-	bool ret = false;
+	bool ret = !!dev->queue_mgmt_ops;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	ret |= !!dev->netdev_ops->net_shaper_ops;
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


