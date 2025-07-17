Return-Path: <netdev+bounces-207925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B8B09095
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B6F7B17B0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5FE2F949A;
	Thu, 17 Jul 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3J1gU9t+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377512F9486
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766137; cv=none; b=ZkhVkzfPmBO2NKWY6SYrn08sGsxq2plnXFboxczR+5sKrk6FLSasOCcFysTzZH0EHRjixa2S0hco1bTLmiRUo2DEnc3beGIkPTZQpx4OKgBYFtlnuee2ugI9en8CrKKw28QIHXBMaLSTpEclLKFVXN03xHXBJ9eCyeA16PRaJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766137; c=relaxed/simple;
	bh=NcvoA9F6Y9YVRSSEFIxfbqp4wxDT+5L42zVKQv/hqOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jVuQ3+xE/PCDMvzD6BRNpX0SyqMbegmvxs561BhEHCsE41swiBM9F88sSLpzk44heCIqlZYrGM7XjGN+o9k4WuVwCVFSFXK30lyjaDf7ferPKPD27yHq69ioLl30PhEhbZkRzQyyb+bmOb8FV4n0dAhUpGeJ7cUSq7Sn/dXvQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3J1gU9t+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748f13ef248so1169442b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752766135; x=1753370935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpWL9wdk3L+WXFxV1ZRWsmDqVo9Rw0ijK3vpxGlqD50=;
        b=3J1gU9t+jBxWGjwMd70CcuDIdzpGiLPT3Te3vl+MT7c2TjBYOUFRMPmycGuXFoNZpT
         aByf/9l4bTMHXjHmP5xb43MQxfj68FyknW30nczOrX6Gju6g2oP9jatx3dCZ5oCmlY1l
         lkRt0W9Aez7MZr50hsyiO0Q+hcvxE9kqWw8Rmec0tliJ6NWWoywxCANMy6KGU5CgWg99
         x5xkXY/+zDjSDCa7d7nHWiqqx39U/q4065rBSkqA6rNiRLYdGU3oxXJAtsCdQX0NZhb1
         G07EPnBdfwvKpt3WsfOHOhKMiMej4xY8TZOlByZ84D3cWdwGZEvcsX5wdoenBlwvAJWv
         TsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766135; x=1753370935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpWL9wdk3L+WXFxV1ZRWsmDqVo9Rw0ijK3vpxGlqD50=;
        b=OI0V4s5/nHLUjCeKryCzMvoVXA9ASZP9XzXYWjD3HaNVUC/Qi9LUE+G4n4OIJb0Yy5
         KLlQIhH+M5fVOPGiBj4TDoDl67USdgWX/ttZCd2J3AZfAKfVJjZGMJYkcXiMDxdl3wyr
         QW1QG7TVjX5EV4aAjwwqWm8dF5XSOV6g7OvCNdsORRSwngkHuwrHM0LyhbHqWgomJkRT
         st7nKlKwWa0BYebRvZgH6jMPasvVAYMUTIoIKYoIRnKeTieC4m0lT7ggULQ6Kt3FYf05
         WVEoFWy3alGMkIcDKuX/H/2zvdIY1zZMvA88KcVWPGWvOyDMM2hn4RplTm46nb6wtzxz
         WHeA==
X-Gm-Message-State: AOJu0YyLlueKnydeV+U4BFdL9DolkZ907eM1UBXNyHm55fd6obyEsU9Z
	/GMvnbt/5B+vGiz+lYsMBKof1AQjZZEJnL1Ng7tqfe/9T8XOs+HcGLyOdFbYvIIL72cybu+o7fk
	Bn3+2e+YGxlzBy7/CwdXAM6MloggiB60rqXZ8WFoedNN04pQC4GYf09P98RGtKW8SW+yis//DH0
	2RcdGW6mG/hCtQnkZZSVpkBqjvaTF0n6Kn4qcp6aHEV9V8Qcc=
X-Google-Smtp-Source: AGHT+IFmipscsuc0ScOunV8x6Nv8TidWXWVy8ZGFu/l5Fxg7GafP3c/ULwn2vmD7NFrwDqYAzk7YZX+Zyfvmfg==
X-Received: from pfih1.prod.google.com ([2002:a05:6a00:2181:b0:746:2187:b5c8])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a1c:b0:21d:1fbf:c71a with SMTP id adf61e73a8af0-23811d5b54emr12653192637.4.1752766135235;
 Thu, 17 Jul 2025 08:28:55 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:28:37 -0700
In-Reply-To: <20250717152839.973004-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717152839.973004-1-jeroendb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717152839.973004-4-jeroendb@google.com>
Subject: [PATCH net-next v2 3/5] gve: keep registry of zc xsk pools in netdev_priv
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: hramamurthy@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Joshua Washington <joshwash@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

Relying on xsk_get_pool_from_qid for getting whether zero copy is
enabled on a queue is erroneous, as an XSK pool is registered in
xp_assign_dev whether AF_XDP zero-copy is enabled or not. This becomes
problematic when queues are restarted in copy mode, as all RX queues
with XSKs will register a pool, causing the driver to exercise the
zero-copy codepath.

This patch adds a bitmap to keep track of which queues have zero-copy
enabled.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h      |  1 +
 drivers/net/ethernet/google/gve/gve_main.c | 37 +++++++++++++++++++---
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index b2be3fca4125..9925c08e595e 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -802,6 +802,7 @@ struct gve_priv {
 
 	struct gve_tx_queue_config tx_cfg;
 	struct gve_rx_queue_config rx_cfg;
+	unsigned long *xsk_pools; /* bitmap of RX queues with XSK pools */
 	u32 num_ntfy_blks; /* split between TX and RX so must be even */
 	int numa_node;
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index cf8e1abdfa8e..d5953f5d1895 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2015-2024 Google LLC
  */
 
+#include <linux/bitmap.h>
 #include <linux/bpf.h>
 #include <linux/cpumask.h>
 #include <linux/etherdevice.h>
@@ -1215,6 +1216,14 @@ static void gve_unreg_xdp_info(struct gve_priv *priv)
 	}
 }
 
+static struct xsk_buff_pool *gve_get_xsk_pool(struct gve_priv *priv, int qid)
+{
+	if (!test_bit(qid, priv->xsk_pools))
+		return NULL;
+
+	return xsk_get_pool_from_qid(priv->dev, qid);
+}
+
 static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 {
 	struct napi_struct *napi;
@@ -1236,7 +1245,7 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 		if (err)
 			goto err;
 
-		xsk_pool = xsk_get_pool_from_qid(dev, i);
+		xsk_pool = gve_get_xsk_pool(priv, i);
 		if (xsk_pool)
 			err = gve_reg_xsk_pool(priv, dev, xsk_pool, i);
 		else if (gve_is_qpl(priv))
@@ -1588,15 +1597,19 @@ static int gve_xsk_pool_enable(struct net_device *dev,
 	if (err)
 		return err;
 
+	set_bit(qid, priv->xsk_pools);
+
 	/* If XDP prog is not installed or interface is down, return. */
 	if (!priv->xdp_prog || !netif_running(dev))
 		return 0;
 
 	err = gve_reg_xsk_pool(priv, dev, pool, qid);
-	if (err)
+	if (err) {
+		clear_bit(qid, priv->xsk_pools);
 		xsk_pool_dma_unmap(pool,
 				   DMA_ATTR_SKIP_CPU_SYNC |
 				   DMA_ATTR_WEAK_ORDERING);
+	}
 
 	return err;
 }
@@ -1613,6 +1626,8 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	if (qid >= priv->rx_cfg.num_queues)
 		return -EINVAL;
 
+	clear_bit(qid, priv->xsk_pools);
+
 	pool = xsk_get_pool_from_qid(dev, qid);
 	if (pool)
 		xsk_pool_dma_unmap(pool,
@@ -2360,10 +2375,22 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	priv->ts_config.rx_filter = HWTSTAMP_FILTER_NONE;
 
 setup_device:
+	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
+	if (!priv->xsk_pools) {
+		err = -ENOMEM;
+		goto err;
+	}
+
 	gve_set_netdev_xdp_features(priv);
 	err = gve_setup_device_resources(priv);
-	if (!err)
-		return 0;
+	if (err)
+		goto err_free_xsk_bitmap;
+
+	return 0;
+
+err_free_xsk_bitmap:
+	bitmap_free(priv->xsk_pools);
+	priv->xsk_pools = NULL;
 err:
 	gve_adminq_free(&priv->pdev->dev, priv);
 	return err;
@@ -2373,6 +2400,8 @@ static void gve_teardown_priv_resources(struct gve_priv *priv)
 {
 	gve_teardown_device_resources(priv);
 	gve_adminq_free(&priv->pdev->dev, priv);
+	bitmap_free(priv->xsk_pools);
+	priv->xsk_pools = NULL;
 }
 
 static void gve_trigger_reset(struct gve_priv *priv)
-- 
2.50.0.727.gbf7dc18ff4-goog


