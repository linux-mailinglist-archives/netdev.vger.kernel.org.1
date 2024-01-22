Return-Path: <netdev+bounces-64775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C871837287
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF31DB26FF0
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8FE4F217;
	Mon, 22 Jan 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLL8wLbW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A94F1E9
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948043; cv=none; b=eX0Ov0cC8ZCYu8IJZ8dMz5UP74jTNisNV/6Uff9kNMYA4xRHsc9iip9xdQqxnJEt16De6F7ZEe7p+B9x42D2mbvCqRm7pCwD3cqJPY4zGa8ffM6gULGqh9Dk4FlKTN8EONOEDqHFT1tmN0YWqMC0i0k1Fzx493OoS0kSA5GKBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948043; c=relaxed/simple;
	bh=7mmgC/+B6cq+Ipqa7gj8UbT1rFFuY2CkQ/djnd69pBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tdxVoUQHFpzBp5ek/7y5U2VMAGxbqzvp8ygo6wzc4lJmjyMO/iNahpQLwIe3qCib2XppJt6n59lZ7zFPt9CChZ9c57HTSTucMYPaShA8NX8k9ONIcmPryV/LTcCXKMJXf3QlXeWhI3DUt69WCvUQwHNQevNyVMyM7n17UPKpXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VLL8wLbW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbdfb8fed1bso4583826276.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 10:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705948041; x=1706552841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IKRVHrdDGc1jnjUD4SM5zaEqPO/NM9QbytVSty7I/c=;
        b=VLL8wLbWegpu/79Vow1AjbR874Rerny+ZVFs3GsyCVHD6EIAdLW1etVSLPL80VnZqI
         EtYCa1QKGw7IFBg0l9tuk/9x02yFfXkPONXqOGLmKwDfKDZr+gYAvfuSEdEs++4xBICO
         FnN0pynykSc/wErctGdxcBh8AbQgn1fAUXIWAPsQ7xXrRAd0Rn5vP0r/AWs2EOHPQ10d
         myqegGx+Gbb0pZWKgBQJ1umg2bDuQ/jUCCGyhjTe2mtzBZ4tw1hkoAYIEop2rdBgzX9v
         ZfhaUGQ34cN9O043YgRHytROBqG3Jav6d6SuxnB1MHdxsRb4KzdrWj3+rHFbKQKY44/D
         eSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948041; x=1706552841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IKRVHrdDGc1jnjUD4SM5zaEqPO/NM9QbytVSty7I/c=;
        b=hJ7GOCGGkFepveT897A6LRcvhx3ptfUMl3EaLxEymdTqkQTp6ASBzw8vcqrE4TG4pP
         jF7jBAjzsVMqj/XtrdS6Dp7NWX3X+iu7XlbGnh1nxVYmAODL4Bu97wTRyYy8AqL1yKgu
         Jv8OHgsQmJyGQAeYMQimG14fqrqsbBJTV9EBDHgTKLZ1C1kXch3goz4p4FiMs3UDtjyk
         juJ/6e2nJ8RYTWRRxzaxD1Csk2x2LonpcynpWOc3b4PzF820DjlbCKdCk79MJ2q8Z6eR
         X8NkF6SVFWJdWLBFonb2uDkqkv/R/G0fE9zR00WFYWcHWJERBOwbfKYtrFByY3z4XiL9
         qAQA==
X-Gm-Message-State: AOJu0YwenXOB3Q13icSXEbsgYNtAw9632NR+CgxipB1qog13z46cfFlk
	fYHPJjCgWtTJiKz/s+Cwo2EbkrxgUqwSK/ORUhn0TxHYKo52IFqDK9I8gsaBo4FbBHBiLD82HAc
	KkAeM7q+8gmiZOX0t+9weg864A+YXEGbKUlOK7NlzFpuJ9LyO4r/Jhn893Z36uB+souRcFuZuEt
	RSKRtI1chbSnl3qnOmUOXI//BBfJWDhJehnMgDUIcxWXw=
X-Google-Smtp-Source: AGHT+IG6bGHD4oJWoZaRZHYkf14t2wL4oy4xFRwatl3Lznzz8b+WUwwCMeHiVVldwKdWoPaIjqfHKwyP7TfqHA==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a25:8b8f:0:b0:dc2:4009:b35e with SMTP id
 j15-20020a258b8f000000b00dc24009b35emr2158977ybl.9.1705948041021; Mon, 22 Jan
 2024 10:27:21 -0800 (PST)
Date: Mon, 22 Jan 2024 18:26:31 +0000
In-Reply-To: <20240122182632.1102721-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122182632.1102721-1-shailend@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122182632.1102721-6-shailend@google.com>
Subject: [PATCH net-next 5/6] gve: Alloc before freeing when adjusting queues
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Shailend Chand <shailend@google.com>, 
	Willem de Bruijn <willemb@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously, existing queues were being freed before the resources for
the new queues were being allocated. This would take down the interface
if someone were to attempt to change queue counts under a resource
crunch.

Signed-off-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 89 ++++++++++++++++------
 1 file changed, 67 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 3515484e4cea..78c9cdf1511f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1869,42 +1869,87 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+static int gve_adjust_config(struct gve_priv *priv,
+			     struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
+			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
+			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+{
+	int err;
+
+	/* Allocate resources for the new confiugration */
+	err = gve_queues_mem_alloc(priv, qpls_alloc_cfg,
+				   tx_alloc_cfg, rx_alloc_cfg);
+	if (err) {
+		netif_err(priv, drv, priv->dev,
+			  "Adjust config failed to alloc new queues");
+		return err;
+	}
+
+	/* Teardown the device and free existing resources */
+	err = gve_close(priv->dev);
+	if (err) {
+		netif_err(priv, drv, priv->dev,
+			  "Adjust config failed to close old queues");
+		gve_queues_mem_free(priv, qpls_alloc_cfg,
+				    tx_alloc_cfg, rx_alloc_cfg);
+		return err;
+	}
+
+	/* Bring the device back up again with the new resources. */
+	err = gve_queues_start(priv, qpls_alloc_cfg,
+			       tx_alloc_cfg, rx_alloc_cfg);
+	if (err) {
+		netif_err(priv, drv, priv->dev,
+			  "Adjust config failed to start new queues, !!! DISABLING ALL QUEUES !!!\n");
+		/* No need to free on error: ownership of resources is lost after
+		 * calling gve_queues_start.
+		 */
+		gve_turndown(priv);
+		return err;
+	}
+
+	return 0;
+}
+
 int gve_adjust_queues(struct gve_priv *priv,
 		      struct gve_queue_config new_rx_config,
 		      struct gve_queue_config new_tx_config)
 {
+	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
+	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
+	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
+	struct gve_qpl_config new_qpl_cfg;
 	int err;
 
-	if (netif_carrier_ok(priv->dev)) {
-		/* To make this process as simple as possible we teardown the
-		 * device, set the new configuration, and then bring the device
-		 * up again.
-		 */
-		err = gve_close(priv->dev);
-		/* we have already tried to reset in close,
-		 * just fail at this point
-		 */
-		if (err)
-			return err;
-		priv->tx_cfg = new_tx_config;
-		priv->rx_cfg = new_rx_config;
+	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
+				&tx_alloc_cfg, &rx_alloc_cfg);
 
-		err = gve_open(priv->dev);
-		if (err)
-			goto err;
+	/* qpl_cfg is not read-only, it contains a map that gets updated as
+	 * rings are allocated, which is why we cannot use the yet unreleased
+	 * one in priv.
+	 */
+	qpls_alloc_cfg.qpl_cfg = &new_qpl_cfg;
+	tx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
+	rx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
+
+	/* Relay the new config from ethtool */
+	qpls_alloc_cfg.tx_cfg = &new_tx_config;
+	tx_alloc_cfg.qcfg = &new_tx_config;
+	rx_alloc_cfg.qcfg_tx = &new_tx_config;
+	qpls_alloc_cfg.rx_cfg = &new_rx_config;
+	rx_alloc_cfg.qcfg = &new_rx_config;
+	tx_alloc_cfg.num_rings = new_tx_config.num_queues;
 
-		return 0;
+	if (netif_carrier_ok(priv->dev)) {
+		err = gve_adjust_config(priv, &qpls_alloc_cfg,
+					&tx_alloc_cfg, &rx_alloc_cfg);
+		return err;
 	}
 	/* Set the config for the next up. */
 	priv->tx_cfg = new_tx_config;
 	priv->rx_cfg = new_rx_config;
 
 	return 0;
-err:
-	netif_err(priv, drv, priv->dev,
-		  "Adjust queues failed! !!! DISABLING ALL QUEUES !!!\n");
-	gve_turndown(priv);
-	return err;
 }
 
 static void gve_turndown(struct gve_priv *priv)
-- 
2.43.0.429.g432eaa2c6b-goog


