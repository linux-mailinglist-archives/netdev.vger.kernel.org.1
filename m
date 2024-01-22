Return-Path: <netdev+bounces-64773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C8083715F
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACBE285CE4
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C94F1EF;
	Mon, 22 Jan 2024 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SH0nyJP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5D4EB3F
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948042; cv=none; b=si7pg5SlErpQfUzEKvx7kwXDv6d/sXE0tCcGGMvWniRqF7OVQIoTCI0YHYySfkDQsr8Kvnp7fAF/yYIKBCYS9xajjm7b+YLaIikaTcc2SptgL6KiUEDcypmtpXjDq+g8npCgroII7frUgoMblFzabUdk9hr30O8aI3gvVw0zM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948042; c=relaxed/simple;
	bh=JQtrOJwcOYER/NPvqtTcHz+T6P+35i6x0S4VO1eN4kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O7cPq3KscrhADrxpkNj0MIaeW8dH08Fp4firfP8W1vrzYytJ0iBsGtrXKbjONxw9hA6XeNzd8DhYJZo5IlGoy7/zx6EPAZXYIo3CXW3953KMi1cPb024rJASiftYSwdAfPUEe+JdUSJY2vrOiYxB+QDqGIUni7gHWSncY2CmIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SH0nyJP4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffa9b3659cso36790777b3.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 10:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705948039; x=1706552839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9YHpQmPN0D7ujtn/xUcQd/74Nin1ta+g/9SKfN+rq9U=;
        b=SH0nyJP4lyVKklK5qMVJWxNaQYdj9LLYfMo+WcJAO1BvyuXbUqBH9togLTvpHfVA4J
         I3lsVCnnHDAGR7P+NQeLQLhbbdU1XqXfHBciD45//DsfbiOjvaxx/AbjuKftY/Di9flt
         fn+DQQrjn9FaT6MrOpTix+bOp/Hs3VVwjTtm0EH+H7Ue4ThF+CytilZ8mNeAK0GQbj5b
         VAb8BRBZDnUebvRIcYJ3zFYacGBiaRRDnObqBFi+IzQg+yR15USI0rRhmTj5/GhtHC5w
         WxNOjy/XL7rtEtqonLL1NffasiWtsxBmKgP2y9WeFSIQYxUxPa3aIgOjiK78H7YEfY26
         VfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948039; x=1706552839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YHpQmPN0D7ujtn/xUcQd/74Nin1ta+g/9SKfN+rq9U=;
        b=R6bXnk7SWJyCqDNbrnYzWEgnJeO0yu48IY9WSADGJXBI6SgqFMqR2CJcn5wLmudRn2
         IhHRc73Kueh3vwxB9IKi7Tff+R8W3GqFL4iU1cLGNFRm3V45zQVOJa8xW9+EZFeXWSNy
         Yz6Y7vTzbrya5welRbCribzmK3PscrCHIWWBlE6xRUDcHZ5FDOGGRQkTT44z+P4EbP/b
         q5FlLt4JFNKvHfsGE5G4+YUmLNZELf8BNxqn+7qs8tF1E49RyF1ZkGoen1Bx2QWgV67n
         minMSqsUDs1yVBZvma0RESfPPIAzdU7ImIsW5GFsyVxCmx9wfeAoV2kb+46+VmpUKFNZ
         Pnww==
X-Gm-Message-State: AOJu0Ywy9MXONN78ZYv32meLepAuVpcoFhsENgoj6HEfdAK47zTiQgQ1
	7REg9Kjk/ZAcN9OSXZ75uVwDmX7eOK/uplQO4iJnI62ePJXjI1dWxnIOGWx0NScra4Fs6TxW6lL
	XH+JdO7gtEURBGZm4zy3Z5WPnv1u6wVIRNVOc8/9zEsg45EFG7Y/haGWUe5Sj4MMbIPWnLdbRMo
	SylkFjcPbUcTXDLSDZm27BRFfdW7LEQO8MqPjOW4ookOg=
X-Google-Smtp-Source: AGHT+IEwWQeVz10rV54WnVJ4ONOHkWStZQKhnJELZVKnzZLJv1sEsyCqAogYrp6imk8tLjtUshiLncXuIQvTqQ==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a5b:a4a:0:b0:dc2:2ab7:5f09 with SMTP id
 z10-20020a5b0a4a000000b00dc22ab75f09mr2171455ybq.2.1705948039468; Mon, 22 Jan
 2024 10:27:19 -0800 (PST)
Date: Mon, 22 Jan 2024 18:26:30 +0000
In-Reply-To: <20240122182632.1102721-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122182632.1102721-1-shailend@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122182632.1102721-5-shailend@google.com>
Subject: [PATCH net-next 4/6] gve: Refactor gve_open and gve_close
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Shailend Chand <shailend@google.com>, 
	Willem de Bruijn <willemb@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

gve_open is rewritten to be composed of two funcs: gve_queues_mem_alloc
and gve_queues_start. The former only allocates queue resources without
doing anything to install the queues, which is taken up by the latter.
Similarly gve_close is split into gve_queues_stop and
gve_queues_mem_free.

Separating the acts of queue resource allocation and making the queue
become live help with subsequent changes that aim to not take down the
datapath when applying new configurations.

Signed-off-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 159 +++++++++++++++------
 1 file changed, 119 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8049a47c38fc..3515484e4cea 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1350,45 +1350,99 @@ static void gve_rx_stop_rings(struct gve_priv *priv, int num_rings)
 	}
 }
 
-static int gve_open(struct net_device *dev)
+static void gve_queues_mem_free(struct gve_priv *priv,
+				struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
+				struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
+				struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+{
+	gve_free_rings(priv, tx_alloc_cfg, rx_alloc_cfg);
+	gve_free_qpls(priv, qpls_alloc_cfg);
+}
+
+static int gve_queues_mem_alloc(struct gve_priv *priv,
+				struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
+				struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
+				struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+{
+	int err;
+
+	err = gve_alloc_qpls(priv, qpls_alloc_cfg);
+	if (err) {
+		netif_err(priv, drv, priv->dev, "Failed to alloc QPLs\n");
+		return err;
+	}
+	tx_alloc_cfg->qpls = qpls_alloc_cfg->qpls;
+	rx_alloc_cfg->qpls = qpls_alloc_cfg->qpls;
+	err = gve_alloc_rings(priv, tx_alloc_cfg, rx_alloc_cfg);
+	if (err) {
+		netif_err(priv, drv, priv->dev, "Failed to alloc rings\n");
+		goto free_qpls;
+	}
+
+	return 0;
+
+free_qpls:
+	gve_free_qpls(priv, qpls_alloc_cfg);
+	return err;
+}
+
+static void gve_queues_mem_remove(struct gve_priv *priv)
 {
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
 	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
-	struct gve_priv *priv = netdev_priv(dev);
+
+	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
+				&tx_alloc_cfg, &rx_alloc_cfg);
+	gve_queues_mem_free(priv, &qpls_alloc_cfg,
+			    &tx_alloc_cfg, &rx_alloc_cfg);
+	priv->qpls = NULL;
+	priv->tx = NULL;
+	priv->rx = NULL;
+}
+
+/* The passed-in queue memory is stored into priv and the queues are made live.
+ * No memory is allocated. Passed-in memory is freed on errors.
+ */
+static int gve_queues_start(struct gve_priv *priv,
+			    struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
+			    struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
+			    struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+{
+	struct net_device *dev = priv->dev;
 	int err;
 
+	/* Record new resources into priv */
+	priv->qpls = qpls_alloc_cfg->qpls;
+	priv->tx = tx_alloc_cfg->tx;
+	priv->rx = rx_alloc_cfg->rx;
+
+	/* Record new configs into priv */
+	priv->qpl_cfg = *qpls_alloc_cfg->qpl_cfg;
+	priv->tx_cfg = *tx_alloc_cfg->qcfg;
+	priv->rx_cfg = *rx_alloc_cfg->qcfg;
+	priv->tx_desc_cnt = tx_alloc_cfg->ring_size;
+	priv->rx_desc_cnt = rx_alloc_cfg->ring_size;
+
 	if (priv->xdp_prog)
 		priv->num_xdp_queues = priv->rx_cfg.num_queues;
 	else
 		priv->num_xdp_queues = 0;
 
-	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
-				&tx_alloc_cfg, &rx_alloc_cfg);
-	err = gve_alloc_qpls(priv, &qpls_alloc_cfg);
-	if (err)
-		return err;
-	priv->qpls = qpls_alloc_cfg.qpls;
-	tx_alloc_cfg.qpls = priv->qpls;
-	rx_alloc_cfg.qpls = priv->qpls;
-	err = gve_alloc_rings(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-	if (err)
-		goto free_qpls;
-
-	gve_tx_start_rings(priv, 0, tx_alloc_cfg.num_rings);
-	gve_rx_start_rings(priv, rx_alloc_cfg.qcfg->num_queues);
+	gve_tx_start_rings(priv, 0, tx_alloc_cfg->num_rings);
+	gve_rx_start_rings(priv, rx_alloc_cfg->qcfg->num_queues);
 	gve_init_sync_stats(priv);
 
 	err = netif_set_real_num_tx_queues(dev, priv->tx_cfg.num_queues);
 	if (err)
-		goto free_rings;
+		goto stop_and_free_rings;
 	err = netif_set_real_num_rx_queues(dev, priv->rx_cfg.num_queues);
 	if (err)
-		goto free_rings;
+		goto stop_and_free_rings;
 
 	err = gve_reg_xdp_info(priv, dev);
 	if (err)
-		goto free_rings;
+		goto stop_and_free_rings;
 
 	err = gve_register_qpls(priv);
 	if (err)
@@ -1416,29 +1470,22 @@ static int gve_open(struct net_device *dev)
 	priv->interface_up_cnt++;
 	return 0;
 
-free_rings:
-	gve_tx_stop_rings(priv, 0, tx_alloc_cfg.num_rings);
-	gve_rx_stop_rings(priv, rx_alloc_cfg.qcfg->num_queues);
-	gve_free_rings(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-free_qpls:
-	gve_free_qpls(priv, &qpls_alloc_cfg);
-	return err;
-
 reset:
-	/* This must have been called from a reset due to the rtnl lock
-	 * so just return at this point.
-	 */
 	if (gve_get_reset_in_progress(priv))
-		return err;
-	/* Otherwise reset before returning */
+		goto stop_and_free_rings;
 	gve_reset_and_teardown(priv, true);
 	/* if this fails there is nothing we can do so just ignore the return */
 	gve_reset_recovery(priv, false);
 	/* return the original error */
 	return err;
+stop_and_free_rings:
+	gve_tx_stop_rings(priv, 0, gve_num_tx_queues(priv));
+	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
+	gve_queues_mem_remove(priv);
+	return err;
 }
 
-static int gve_close(struct net_device *dev)
+static int gve_open(struct net_device *dev)
 {
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
@@ -1446,7 +1493,30 @@ static int gve_close(struct net_device *dev)
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
-	netif_carrier_off(dev);
+	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
+				&tx_alloc_cfg, &rx_alloc_cfg);
+
+	err = gve_queues_mem_alloc(priv, &qpls_alloc_cfg,
+				   &tx_alloc_cfg, &rx_alloc_cfg);
+	if (err)
+		return err;
+
+	/* No need to free on error: ownership of resources is lost after
+	 * calling gve_queues_start.
+	 */
+	err = gve_queues_start(priv, &qpls_alloc_cfg,
+			       &tx_alloc_cfg, &rx_alloc_cfg);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int gve_queues_stop(struct gve_priv *priv)
+{
+	int err;
+
+	netif_carrier_off(priv->dev);
 	if (gve_get_device_rings_ok(priv)) {
 		gve_turndown(priv);
 		gve_drain_page_cache(priv);
@@ -1462,12 +1532,8 @@ static int gve_close(struct net_device *dev)
 
 	gve_unreg_xdp_info(priv);
 
-	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
-				&tx_alloc_cfg, &rx_alloc_cfg);
-	gve_tx_stop_rings(priv, 0, tx_alloc_cfg.num_rings);
-	gve_rx_stop_rings(priv, rx_alloc_cfg.qcfg->num_queues);
-	gve_free_rings(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-	gve_free_qpls(priv, &qpls_alloc_cfg);
+	gve_tx_stop_rings(priv, 0, gve_num_tx_queues(priv));
+	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
 
 	priv->interface_down_cnt++;
 	return 0;
@@ -1483,6 +1549,19 @@ static int gve_close(struct net_device *dev)
 	return gve_reset_recovery(priv, false);
 }
 
+static int gve_close(struct net_device *dev)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+	int err;
+
+	err = gve_queues_stop(priv);
+	if (err)
+		return err;
+
+	gve_queues_mem_remove(priv);
+	return 0;
+}
+
 static int gve_remove_xdp_queues(struct gve_priv *priv)
 {
 	int qpl_start_id;
-- 
2.43.0.429.g432eaa2c6b-goog


