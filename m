Return-Path: <netdev+bounces-170978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F58A4AE88
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 01:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4ABF3B563B
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 00:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7C15A8;
	Sun,  2 Mar 2025 00:09:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12EB667
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874152; cv=none; b=sOzzucu0k8lsM8xyn7IyNB6VCssBc+pakWTc9XVtM6xEtLyJg5NqbO+YQd21dGh0peOMGdoQMAMRrg3iNpJPBX1RF/dUf+A708q1QWkRQWy3betdrtjzcdhkCR5uByQpQ7pdPpDuehklJEJkooDwPK4LNzk+hJNjHTPwcGz7ApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874152; c=relaxed/simple;
	bh=CE/JDG5r9Yj8QUJ3eYoY497Hr4CPXruWZhcNg+HC0M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbXOs/wzNzrckckZKmI8Wbqq7qjDCapf8lAG7cDYlh2QSiJO3di6N9P+cRq870O08nzzQu5Xawk0ivIKKySo4jH4mP0OxESjTSQG912jYVLblG4bGbpygj8u5Pexjt9wyqu2uGjF17fWwq86czKINIsYW3pK+j3N0lMACCTeo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fee4d9c2efso658972a91.3
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 16:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740874150; x=1741478950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKLyGFut6ZSErDec5sG0CPQLD4udTFKU1KH6eNerDRc=;
        b=D4vbhyaZG0D7SBQizzkaHQvp2Ndogut6lT62ttUepDMbNTNXeSZ4qBdtmVamRAUqYN
         DRguuURVCqgc4fMBpmSRo1UOAGWel/JbchSMxMrU/EGVaw3nDe+1ts6mtXKIXzdFOi/q
         jsy3zn52bA9nsSU2/ztI3MkjHQoMsVJnC/PEuhZ85oOLz4InUaBjTZNzNaF30ax6LeYp
         JkDfG6as1RRZrldLpJXJbcX1tKfgq1G/Zcw8o5Yvvzcf+TiDFU9keED/TfZJgJGB9F1Q
         LzlnyKNDCyDO1AoaPAm2xLsLfuFHYzo+32yaaWh56B/uC4DBUt+tJ3EJkvarqI7JC8G0
         yx8g==
X-Gm-Message-State: AOJu0YzHRouWXCND+40QuULyloECc5Uq3fQqfMbzP7d4oJ10ia0YLnf9
	lg/ElFo0rV+2mNyLMAmIcgU0fdowSPd9nxn0yTMLk0l1lsKHZTB3UTXm
X-Gm-Gg: ASbGncuJMIknR/CYdGedYFr3SpFg9QNS/Dm0IRSHMBFsdbIp8NaX6BfrhpUstptYEKC
	Z7av8h1Kiyw5mYd64v14WmuEm4uliJBFZYbeqKvN2NTIVgmSobRSQu9zA+3/vK/1rBpbnc2GpKH
	vcga/3AmmC9pW2YZtmH8rEzG9zm6KzTfCUqupf1NMY6nSlhcFayJphNeBBtf2ecjGTeKHz9UL8t
	yTYQz5IgPaWvJEwXzguc0DtQB7iPOFvx7PdufTqfaEOnrJTJjj9p/r4v1DGgDQI0aerN08V8h1c
	Dg7IuKSuZiBSdrGh1rYQzaz/aT3JfDUPiN21UPIejBu1
X-Google-Smtp-Source: AGHT+IFW+wG3EiGiMQkxJRqBY8tyoRd7CyGZDh7aSmivG7KvaioW0i/FMaRBhfNCdZkTHw969cmerQ==
X-Received: by 2002:a17:90b:3fcb:b0:2fe:9581:fbea with SMTP id 98e67ed59e1d1-2febabf414amr13029759a91.29.1740874149725;
        Sat, 01 Mar 2025 16:09:09 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe8284f134sm8259793a91.48.2025.03.01.16.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 16:09:09 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 05/14] net: hold netdev instance lock during queue operations
Date: Sat,  1 Mar 2025 16:08:52 -0800
Message-ID: <20250302000901.2729164-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302000901.2729164-1-sdf@fomichev.me>
References: <20250302000901.2729164-1-sdf@fomichev.me>
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
index 98c33ba5a460..a8ee0d277fa9 100644
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


