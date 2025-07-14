Return-Path: <netdev+bounces-206764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92759B0450E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9B44A1219
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3B2561D1;
	Mon, 14 Jul 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U06sn9D7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858925DAFF
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509114; cv=none; b=UBmq2Jl1H1yWNrDR5KiH6OkSiVDWsGd1tQTwUOQ5hcxnEhFSA+KjmXfemzADGkGbaR0hkZxwAcsNQ+1Z7yP4lyaCxJclEeBzX91juYocMsFUQzmKXP0KFZhI49TkKIwtlfhBYhG2zaRunH3a/F34EcPiTCYMtBPOaKj4xARQNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509114; c=relaxed/simple;
	bh=cbhr9Rhk3GklQKWIlLjHypeIPSw/X/jCpAE4OuH0vFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r8SMt6pyoVzyPeL5Qlbqte9jz8SIC0ff7hlmXX27GP7mjl5DVgEuXfU7NT34eTlAF8GuSvzlhQiO4LopzbY+muq0ydjORLwr5TIRBjclsgkvdaqTdw+07xoLFrywgDN6IPjm3bp91zZyIMjj3XxPfShwgokNyPFvrS6CEkKjmsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U06sn9D7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so3619482a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752509112; x=1753113912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGHtvylOkisNi9cjVOb143LgpCp+xMUQzZGIKXcs9uQ=;
        b=U06sn9D7pmTp2HSLmXFF4wJGRTuFW4yTMnv/k3xGr3cfFHhc3XPDLiGY/PuHbIeIMa
         mMR9YmpoY/2jsX6ply39x4yqQYVMLODSI8cnnht5hLqjJqPO/XW2Jcy3OSeUzB2Lgdag
         AfXQoh4g8MWK+58Lv8txQmwdyEa4o44tHEoqnEcsXtJCSLxcLB6Ds4xikiMQ61HDpLF6
         AzNURJW35vr5Am6Njuiqweftm6xlO1KO5jTRW1gq1Pz5we5lela3x7jqmwk5Q+Z3GlN2
         e3QR5Zm00xCmglAU2FfdMGd5kWHGOqEF8PslX7dTbybvy+xQqmz6tJ0H4lEX6SG1vM3v
         AP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509112; x=1753113912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGHtvylOkisNi9cjVOb143LgpCp+xMUQzZGIKXcs9uQ=;
        b=ikRfy90X3cqZ6ULMXsqhe6/ePKby5hXgT7zFeH4EPLfgosWncjNV2sj/jNyI5tIDis
         7dXPdFT/aOyyKLpleC2tpfV05yCUXR+4FDzii+ZuM5ncyF8z9drCOpB3rPxxdqQte9Hw
         NLt5Eu8bd2vYgm4e1WpAMVaHEx3s4E9aGZOL9VXVPinvajgRlVsUbCehVAvYyNR5qIcN
         VSDuGXDP291AUtJISSd6UhWM8ELOx/7/o0JUwB9MLrBR9Hb7eRsCBJFGqHJMZkrQtcK1
         ubiQENjPjiRTOq8C0KeniYoNmTUXd08a9avdNUVGppU+pEFujlDTvV3yXP3Oy2UvuPnN
         +MvA==
X-Gm-Message-State: AOJu0Ywb6iYfYatvz1lUNkBpRupmiS4bs1ETvZCEEnS23cNKtvS1GfXu
	DlU3VOX6Sm2TUC4RGR/HM0q8+/ejk3zluWWePofNhjtkuVxnuPLwoh0zn6PFEjkq1mDKxK8R5yI
	9OXFwjXGJhVovHR1xX2QQCStQFh0kvEUh5mB2qqh0pf/A1JEAAGDbHP5RXOEnjKGuSqElJP7dRu
	qbVuIBFpZegGeCuNbQWjYcxm75EFU90lYHoEFizOXlJsirmpQ=
X-Google-Smtp-Source: AGHT+IH9E+uB008EnOi8zKVI0mngPSd3nr5ojLeWg5Ufh3Z2xshkOwroDmEhsKPnR9g5yYE3MFB9kzr2CioPYw==
X-Received: from pfbmb2.prod.google.com ([2002:a05:6a00:7602:b0:74c:efaa:794a])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3393:b0:234:4b39:1829 with SMTP id adf61e73a8af0-2344b3918f7mr9784402637.29.1752509111753;
 Mon, 14 Jul 2025 09:05:11 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:04:49 -0700
In-Reply-To: <20250714160451.124671-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714160451.124671-1-jeroendb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714160451.124671-4-jeroendb@google.com>
Subject: [PATCH net-next 3/5] gve: keep registry of zc xsk pools in netdev_priv
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
index d2797f55ae7c..02020d5d2f92 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2015-2024 Google LLC
  */
 
+#include <linux/bitmap.h>
 #include <linux/bpf.h>
 #include <linux/cpumask.h>
 #include <linux/etherdevice.h>
@@ -1217,6 +1218,14 @@ static void gve_unreg_xdp_info(struct gve_priv *priv)
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
@@ -1238,7 +1247,7 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 		if (err)
 			goto err;
 
-		xsk_pool = xsk_get_pool_from_qid(dev, i);
+		xsk_pool = gve_get_xsk_pool(priv, i);
 		if (xsk_pool)
 			err = gve_reg_xsk_pool(priv, dev, xsk_pool, i);
 		else if (gve_is_qpl(priv))
@@ -1590,15 +1599,19 @@ static int gve_xsk_pool_enable(struct net_device *dev,
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
@@ -1615,6 +1628,8 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	if (qid >= priv->rx_cfg.num_queues)
 		return -EINVAL;
 
+	clear_bit(qid, priv->xsk_pools);
+
 	pool = xsk_get_pool_from_qid(dev, qid);
 	if (pool)
 		xsk_pool_dma_unmap(pool,
@@ -2362,10 +2377,22 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
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
@@ -2375,6 +2402,8 @@ static void gve_teardown_priv_resources(struct gve_priv *priv)
 {
 	gve_teardown_device_resources(priv);
 	gve_adminq_free(&priv->pdev->dev, priv);
+	bitmap_free(priv->xsk_pools);
+	priv->xsk_pools = NULL;
 }
 
 static void gve_trigger_reset(struct gve_priv *priv)
-- 
2.50.0.727.gbf7dc18ff4-goog


