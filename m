Return-Path: <netdev+bounces-89406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09028AA38C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48B11C203BC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765931C65E2;
	Thu, 18 Apr 2024 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtebK5ec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E61BED97
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469954; cv=none; b=qXggfSXpS/vqiRJgTxoxp5mF/rOG5OqqliLAIlG7xzI6ndgTo0ctWgOsfPMbZFjdpJToklnNvso/o/YZuFwIQRSjup9G9fodT+NidR3nZKQJ15hV1kBbNrkV9M6kJGQC5PuwKPr47XYovLHI09zMMhu/1FE+gIjaBY7Bh+GyJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469954; c=relaxed/simple;
	bh=WDJ5j8PJj/UBtgdIBrsmMBPpR6pgGYQj8OHYaP/oy/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JiFIfUUVyhmoybUdtfe1827tJ38eFvNSaYCwIyGY7w+Q+4e1wREIKUbJoE2Yl2Z+laiw8CUxPCeixnuXd50+PDekEcwpaP5VBEelZ4QRoUqQ+g2IDFLjPHj41jqsB+37Hx2ZdH/Yv7DB95Yp78NyWbRTUQAaGq6MH7i06vJI+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtebK5ec; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61afb46bad8so17037387b3.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713469951; x=1714074751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHKeTrkXK3fIfwzUH8OvkiHPe+4pqEtlSdkT5mNWt1o=;
        b=rtebK5ecprY8gvnvHqIyc4PlFDGaZp3EtcrqwSICLpmlXT9HfEzCzV89l1UJrLMS/b
         bpNaDzsb2rfiVrW7DzWAhPb6SMUebJ1P6UDqzzUM10inBdB84g0ILBr4iOxrtBDVYhTh
         8lx4psX/nujdB1WpqB5grQCbT3adazVO8HbwNxS+5OfrMYzduZsLzeCCItZNPphvV6E2
         Nl3752UMbD+znETqLLP4UrQX+QhLf/v5rHSXek9VIGwn3f/u4kT2mGzW6co3e04S2ulr
         YketbTkDh3PUMzjzzwcDl9701dAEaVwhwP/NKeF2GdwEoCO8OLlJrxMJrrjCewQkAj26
         le7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469951; x=1714074751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHKeTrkXK3fIfwzUH8OvkiHPe+4pqEtlSdkT5mNWt1o=;
        b=v0SVVsoBLDz3U+jlDJcU0YsXSlw76mRsU3bWZluBeg2O33ERNzyDVy29pkZAXgKhiU
         TkjSIwhahBdGmwO9SN131RboSIdEXvQvfeUws1T7swSWcy5sGX4oJ25+1e70UwvDl9lZ
         T4AXWx3E8/r4mWhLIni6oOxlDaDR31W9F6Y3GgDYhbhESO1CVi/iGDsZ3fpcHLz3aqyv
         cA7unpTRwV8+GpMkSvbU0V1pEpEkNk1lm+qomcVNtEqeUq1oCeul9gIE2/GzPwF5JDtO
         R4U/BeRf0ATlD0GKuYtioYowsVV/valJdG1WtrMmdGVKtu4qNzl+FmQ1bcfeaj7aimDn
         rV1g==
X-Gm-Message-State: AOJu0YwfrKu+XAaZgCHxBusTGFdD1kUOjULFysci5hMN/OugxoxFlTxk
	rJXgdP28p3c7+ICsRDMJx0nbPPG4zb0ChC5V/sOo6JSndX8pcb4ByOSiX58pK2BeesfJUYaNbYl
	huWqZRknc6zh1YNRXrG12nRReG3QO6WXgkd3LqMe+nZfeOOQM0LQN9Zs8QgsVmrRl5LK2+Jjzsr
	i6ZtiY6ikNHMo76ZWF+83hq/tRG2DNiXDbTNildLgUt10=
X-Google-Smtp-Source: AGHT+IFOm/vkNIltjVtWSDKWUWKxm7l7OJK1Q1Tg/OCy9uLIdUCyIM2PQpJspnMKOjSKsZofFd6Atb/oe2rJvw==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a81:4911:0:b0:618:9348:6b92 with SMTP id
 w17-20020a814911000000b0061893486b92mr688971ywa.1.1713469951585; Thu, 18 Apr
 2024 12:52:31 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:51:59 +0000
In-Reply-To: <20240418195159.3461151-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418195159.3461151-10-shailend@google.com>
Subject: [RFC PATCH net-next 9/9] gve: Implement queue api
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

An api enabling the net stack to reset driver queues is implemented for
gve.

Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |   6 +
 drivers/net/ethernet/google/gve/gve_dqo.h    |   6 +
 drivers/net/ethernet/google/gve/gve_main.c   | 143 +++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx.c     |  12 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |  12 +-
 5 files changed, 167 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 9f6a897c87cb..d752e525bde7 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1147,6 +1147,12 @@ bool gve_tx_clean_pending(struct gve_priv *priv, struct gve_tx_ring *tx);
 void gve_rx_write_doorbell(struct gve_priv *priv, struct gve_rx_ring *rx);
 int gve_rx_poll(struct gve_notify_block *block, int budget);
 bool gve_rx_work_pending(struct gve_rx_ring *rx);
+int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
+			  struct gve_rx_alloc_rings_cfg *cfg,
+			  struct gve_rx_ring *rx,
+			  int idx);
+void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
+			  struct gve_rx_alloc_rings_cfg *cfg);
 int gve_rx_alloc_rings(struct gve_priv *priv);
 int gve_rx_alloc_rings_gqi(struct gve_priv *priv,
 			   struct gve_rx_alloc_rings_cfg *cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
index b81584829c40..e83773fb891f 100644
--- a/drivers/net/ethernet/google/gve/gve_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_dqo.h
@@ -44,6 +44,12 @@ void gve_tx_free_rings_dqo(struct gve_priv *priv,
 			   struct gve_tx_alloc_rings_cfg *cfg);
 void gve_tx_start_ring_dqo(struct gve_priv *priv, int idx);
 void gve_tx_stop_ring_dqo(struct gve_priv *priv, int idx);
+int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
+			  struct gve_rx_alloc_rings_cfg *cfg,
+			  struct gve_rx_ring *rx,
+			  int idx);
+void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
+			  struct gve_rx_alloc_rings_cfg *cfg);
 int gve_rx_alloc_rings_dqo(struct gve_priv *priv,
 			   struct gve_rx_alloc_rings_cfg *cfg);
 void gve_rx_free_rings_dqo(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index c348dff7cca6..5e652958f10f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -17,6 +17,7 @@
 #include <linux/workqueue.h>
 #include <linux/utsname.h>
 #include <linux/version.h>
+#include <net/netdev_queues.h>
 #include <net/sch_generic.h>
 #include <net/xdp_sock_drv.h>
 #include "gve.h"
@@ -2070,6 +2071,15 @@ static void gve_turnup(struct gve_priv *priv)
 	gve_set_napi_enabled(priv);
 }
 
+static void gve_turnup_and_check_status(struct gve_priv *priv)
+{
+	u32 status;
+
+	gve_turnup(priv);
+	status = ioread32be(&priv->reg_bar0->device_status);
+	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+}
+
 static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct gve_notify_block *block;
@@ -2530,6 +2540,138 @@ static void gve_write_version(u8 __iomem *driver_version_register)
 	writeb('\n', driver_version_register);
 }
 
+static int gve_rx_queue_stop(struct net_device *dev, int idx,
+			     void **out_per_q_mem)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+	struct gve_rx_ring *rx;
+	int err;
+
+	if (!priv->rx)
+		return -EAGAIN;
+	if (idx < 0 || idx >= priv->rx_cfg.max_queues)
+		return -ERANGE;
+
+	/* Destroying queue 0 while other queues exist is not supported in DQO */
+	if (!gve_is_gqi(priv) && idx == 0)
+		return -ERANGE;
+
+	rx = kvzalloc(sizeof(*rx), GFP_KERNEL);
+	if (!rx)
+		return -ENOMEM;
+	*rx = priv->rx[idx];
+
+	/* Single-queue destruction requires quiescence on all queues */
+	gve_turndown(priv);
+
+	/* This failure will trigger a reset - no need to clean up */
+	err = gve_adminq_destroy_single_rx_queue(priv, idx);
+	if (err) {
+		kvfree(rx);
+		return err;
+	}
+
+	if (gve_is_gqi(priv))
+		gve_rx_stop_ring_gqi(priv, idx);
+	else
+		gve_rx_stop_ring_dqo(priv, idx);
+
+	/* Turn the unstopped queues back up */
+	gve_turnup_and_check_status(priv);
+
+	*out_per_q_mem = rx;
+	return 0;
+}
+
+static void gve_rx_queue_mem_free(struct net_device *dev, void *per_q_mem)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+	struct gve_rx_alloc_rings_cfg cfg = {0};
+	struct gve_rx_ring *rx;
+
+	gve_rx_get_curr_alloc_cfg(priv, &cfg);
+	rx = (struct gve_rx_ring *)per_q_mem;
+	if (!rx)
+		return;
+
+	if (gve_is_gqi(priv))
+		gve_rx_free_ring_gqi(priv, rx, &cfg);
+	else
+		gve_rx_free_ring_dqo(priv, rx, &cfg);
+
+	kvfree(per_q_mem);
+}
+
+static void *gve_rx_queue_mem_alloc(struct net_device *dev, int idx)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+	struct gve_rx_alloc_rings_cfg cfg = {0};
+	struct gve_rx_ring *rx;
+	int err;
+
+	gve_rx_get_curr_alloc_cfg(priv, &cfg);
+	if (idx < 0 || idx >= cfg.qcfg->max_queues)
+		return NULL;
+
+	rx = kvzalloc(sizeof(*rx), GFP_KERNEL);
+	if (!rx)
+		return NULL;
+
+	if (gve_is_gqi(priv))
+		err = gve_rx_alloc_ring_gqi(priv, &cfg, rx, idx);
+	else
+		err = gve_rx_alloc_ring_dqo(priv, &cfg, rx, idx);
+
+	if (err) {
+		kvfree(rx);
+		return NULL;
+	}
+	return rx;
+}
+
+static int gve_rx_queue_start(struct net_device *dev, int idx, void *per_q_mem)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+	struct gve_rx_ring *rx;
+	int err;
+
+	if (!priv->rx)
+		return -EAGAIN;
+	if (idx < 0 || idx >= priv->rx_cfg.max_queues)
+		return -ERANGE;
+	rx = (struct gve_rx_ring *)per_q_mem;
+	priv->rx[idx] = *rx;
+
+	/* Single-queue creation requires quiescence on all queues */
+	gve_turndown(priv);
+
+	if (gve_is_gqi(priv))
+		gve_rx_start_ring_gqi(priv, idx);
+	else
+		gve_rx_start_ring_dqo(priv, idx);
+
+	/* This failure will trigger a reset - no need to clean up */
+	err = gve_adminq_create_single_rx_queue(priv, idx);
+	if (err)
+		return err;
+
+	if (gve_is_gqi(priv))
+		gve_rx_write_doorbell(priv, &priv->rx[idx]);
+	else
+		gve_rx_post_buffers_dqo(&priv->rx[idx]);
+
+	/* Turn the unstopped queues back up */
+	gve_turnup_and_check_status(priv);
+	return 0;
+}
+
+static const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops = {
+	.ndo_queue_mem_alloc	=	gve_rx_queue_mem_alloc,
+	.ndo_queue_mem_free	=	gve_rx_queue_mem_free,
+	.ndo_queue_start	=	gve_rx_queue_start,
+	.ndo_queue_stop		=	gve_rx_queue_stop,
+};
+
 static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int max_tx_queues, max_rx_queues;
@@ -2584,6 +2726,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_drvdata(pdev, dev);
 	dev->ethtool_ops = &gve_ethtool_ops;
 	dev->netdev_ops = &gve_netdev_ops;
+	dev->queue_mgmt_ops = &gve_queue_mgmt_ops;
 
 	/* Set default and supported features.
 	 *
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 1d235caab4c5..307bf97d4778 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -101,8 +101,8 @@ void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx)
 	gve_rx_reset_ring_gqi(priv, idx);
 }
 
-static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
-				 struct gve_rx_alloc_rings_cfg *cfg)
+void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
+			  struct gve_rx_alloc_rings_cfg *cfg)
 {
 	struct device *dev = &priv->pdev->dev;
 	u32 slots = rx->mask + 1;
@@ -270,10 +270,10 @@ void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx)
 	gve_add_napi(priv, ntfy_idx, gve_napi_poll);
 }
 
-static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
-				 struct gve_rx_alloc_rings_cfg *cfg,
-				 struct gve_rx_ring *rx,
-				 int idx)
+int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
+			  struct gve_rx_alloc_rings_cfg *cfg,
+			  struct gve_rx_ring *rx,
+			  int idx)
 {
 	struct device *hdev = &priv->pdev->dev;
 	u32 slots = cfg->ring_size;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index dc2c6bd92e82..dcbc37118870 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -299,8 +299,8 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
 	gve_rx_reset_ring_dqo(priv, idx);
 }
 
-static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
-				 struct gve_rx_alloc_rings_cfg *cfg)
+void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
+			  struct gve_rx_alloc_rings_cfg *cfg)
 {
 	struct device *hdev = &priv->pdev->dev;
 	size_t completion_queue_slots;
@@ -373,10 +373,10 @@ void gve_rx_start_ring_dqo(struct gve_priv *priv, int idx)
 	gve_add_napi(priv, ntfy_idx, gve_napi_poll_dqo);
 }
 
-static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
-				 struct gve_rx_alloc_rings_cfg *cfg,
-				 struct gve_rx_ring *rx,
-				 int idx)
+int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
+			  struct gve_rx_alloc_rings_cfg *cfg,
+			  struct gve_rx_ring *rx,
+			  int idx)
 {
 	struct device *hdev = &priv->pdev->dev;
 	size_t size;
-- 
2.44.0.769.g3c40516874-goog


