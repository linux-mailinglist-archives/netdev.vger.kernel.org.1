Return-Path: <netdev+bounces-92646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3638B82F4
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69901C2173D
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A9E1C233E;
	Tue, 30 Apr 2024 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZH4SRH5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF181C0DD6
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518892; cv=none; b=c1HyZxFo8kqCmadqBNl6m1jMbNtyimSidBMiGxT/YuUb8iQStD8ZKs58KuaydWDV+QIrugBnHrNGWtBUK0hs9q9FWDgTC3Abq8wabuskh3DyEuv0Qz8fx1/rEVAk72vYD58G8pm8J5Pbnskunip5BC8C9RylCBtIl2tuSEpThVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518892; c=relaxed/simple;
	bh=sGt8lpzuoKugog68emobZt7Gm+OFWNmsA5Wl/JisnCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GZi73kW6elc4HH3emFcSUoqWy319jet9wNgAdbzglDGGUJOGfiai76B6TOXpEDq9h4zHIQpj3Dhf5u2pyrtf5visQ9nwrS3X+H5SOKvOdNZ4tRsJzRtxV6boODHSQFG7EkOeM6U6VXV6yQ3+jgNFH3fGdGC5co0xShL9EqjO/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZH4SRH5F; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bbd6578f9so63355297b3.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714518890; x=1715123690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WB3ZS9Ij//X6pRvwFQpFltP77jWP/bicI9Gj5o8Mrik=;
        b=ZH4SRH5FzouYfvU4crh4heBojOlROWRB8TDLQSo3jaXU1iTVhMAGUmNNakdxoqGbkN
         BBdzFILl7JYX8ADBp53DnNsIufYqNWf1P8I+/lmrHVEPnTN4UFFgqbnKN+24m/nAT1UK
         YDSsXbeFnEB0S0hekXj6kipj5NbCH96wyqNpCPOSaylMXu4g9rUcvIpC8yHtGQxpxZmV
         +w0fm6cyAzn+U68UcF7tVKZhFhE8Yr9xWdkEae5/KgODi3RITcvHLValN7BfXjGc2QWY
         doEcS3Y9r3DKLcw3KNGaqd/W3wXmVRx4DSXvnzkbga7171WEJIgFsCxoc2ulu2RDYyuF
         S8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518890; x=1715123690;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WB3ZS9Ij//X6pRvwFQpFltP77jWP/bicI9Gj5o8Mrik=;
        b=aw1252ZRyuuYwigpYDxX3N7ugzskfe7U1hWNUI44Ujb771yWw9oPpSQLghSkoq3G3y
         251RHyYQovCTUwDAs0MRcNHhrYRDP8KHmRmsw+wmHGUgEPa2PBiuOFO/h5lwrIMY4072
         oqSQte4h+kbk8GNKz4+ygiHiagipT4nSqMe2YQnyVxxAv7euiH8PO21H1SO+bhr5vV/p
         hJ822kgbWn+B/bQog+LA66J15xJhJkOIpSxPHBWAhqFiNnWxC0JPSI7C5tzqjirbbiKP
         ZyMRmf5Gb4ba+xW2rs4frbHAn5RHuChq5Eo6MskqtiT6UOOuI72X/6bq94EXblvvPmu3
         //cg==
X-Gm-Message-State: AOJu0Yxcz5I7B8RhdOoH1Z0ScSYKpqjsp9xTXypU7fSu9/qkjsBErPl4
	8puk63hOeC/S6iqBuXVwfTwmoBHVE7Ynzlh2wjawuxuY0SWqKfvTZ4zDILlvgk+IlJCPu6yHDaj
	z39LOn7m3pRRA6voaorlhJad5Dcd6deuGy7VehVxdTBH6xKwmtEeaz9pZDgTiYxvuRwjIORQIo3
	GnSwdEiLWr5K6Fiuq0SX8F3u9I/+sytTTra9bz277G2nI=
X-Google-Smtp-Source: AGHT+IGC4T8B9UV31DPK55kce6jw/XCq6AoIshM3WLo/w5Byttp5TSOFlKCnL3HCwp0BULmMZsOqtv7Ijphkog==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a25:74d7:0:b0:de5:8427:d66e with SMTP id
 p206-20020a2574d7000000b00de58427d66emr301580ybc.11.1714518889993; Tue, 30
 Apr 2024 16:14:49 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:19 +0000
In-Reply-To: <20240430231420.699177-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430231420.699177-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430231420.699177-11-shailend@google.com>
Subject: [PATCH net-next 10/10] gve: Implement queue api
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The new netdev queue api is implemented for gve.

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: =C2=A0Mina=C2=A0Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |   6 +
 drivers/net/ethernet/google/gve/gve_dqo.h    |   6 +
 drivers/net/ethernet/google/gve/gve_main.c   | 177 +++++++++++++++++--
 drivers/net/ethernet/google/gve/gve_rx.c     |  12 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |  12 +-
 5 files changed, 189 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/g=
oogle/gve/gve.h
index 9e0a433c991c..ae1e21c9b0a5 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1096,6 +1096,12 @@ bool gve_tx_clean_pending(struct gve_priv *priv, str=
uct gve_tx_ring *tx);
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
diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethern=
et/google/gve/gve_dqo.h
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
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ether=
net/google/gve/gve_main.c
index 65adab0f5171..2f18910456b2 100644
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
@@ -1238,16 +1239,28 @@ void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
 	gve_rx_get_curr_alloc_cfg(priv, rx_alloc_cfg);
 }
=20
+static void gve_rx_start_ring(struct gve_priv *priv, int i)
+{
+	if (gve_is_gqi(priv))
+		gve_rx_start_ring_gqi(priv, i);
+	else
+		gve_rx_start_ring_dqo(priv, i);
+}
+
 static void gve_rx_start_rings(struct gve_priv *priv, int num_rings)
 {
 	int i;
=20
-	for (i =3D 0; i < num_rings; i++) {
-		if (gve_is_gqi(priv))
-			gve_rx_start_ring_gqi(priv, i);
-		else
-			gve_rx_start_ring_dqo(priv, i);
-	}
+	for (i =3D 0; i < num_rings; i++)
+		gve_rx_start_ring(priv, i);
+}
+
+static void gve_rx_stop_ring(struct gve_priv *priv, int i)
+{
+	if (gve_is_gqi(priv))
+		gve_rx_stop_ring_gqi(priv, i);
+	else
+		gve_rx_stop_ring_dqo(priv, i);
 }
=20
 static void gve_rx_stop_rings(struct gve_priv *priv, int num_rings)
@@ -1257,12 +1270,8 @@ static void gve_rx_stop_rings(struct gve_priv *priv,=
 int num_rings)
 	if (!priv->rx)
 		return;
=20
-	for (i =3D 0; i < num_rings; i++) {
-		if (gve_is_gqi(priv))
-			gve_rx_stop_ring_gqi(priv, i);
-		else
-			gve_rx_stop_ring_dqo(priv, i);
-	}
+	for (i =3D 0; i < num_rings; i++)
+		gve_rx_stop_ring(priv, i);
 }
=20
 static void gve_queues_mem_remove(struct gve_priv *priv)
@@ -1882,6 +1891,15 @@ static void gve_turnup(struct gve_priv *priv)
 	gve_set_napi_enabled(priv);
 }
=20
+static void gve_turnup_and_check_status(struct gve_priv *priv)
+{
+	u32 status;
+
+	gve_turnup(priv);
+	status =3D ioread32be(&priv->reg_bar0->device_status);
+	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status)=
;
+}
+
 static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct gve_notify_block *block;
@@ -2328,6 +2346,140 @@ static void gve_write_version(u8 __iomem *driver_ve=
rsion_register)
 	writeb('\n', driver_version_register);
 }
=20
+static int gve_rx_queue_stop(struct net_device *dev, void *per_q_mem, int =
idx)
+{
+	struct gve_priv *priv =3D netdev_priv(dev);
+	struct gve_rx_ring *gve_per_q_mem;
+	int err;
+
+	if (!priv->rx)
+		return -EAGAIN;
+
+	/* Destroying queue 0 while other queues exist is not supported in DQO */
+	if (!gve_is_gqi(priv) && idx =3D=3D 0)
+		return -ERANGE;
+
+	/* Single-queue destruction requires quiescence on all queues */
+	gve_turndown(priv);
+
+	/* This failure will trigger a reset - no need to clean up */
+	err =3D gve_adminq_destroy_single_rx_queue(priv, idx);
+	if (err)
+		return err;
+
+	if (gve_is_qpl(priv)) {
+		/* This failure will trigger a reset - no need to clean up */
+		err =3D gve_unregister_qpl(priv, gve_rx_get_qpl(priv, idx));
+		if (err)
+			return err;
+	}
+
+	gve_rx_stop_ring(priv, idx);
+
+	/* Turn the unstopped queues back up */
+	gve_turnup_and_check_status(priv);
+
+	gve_per_q_mem =3D (struct gve_rx_ring *)per_q_mem;
+	*gve_per_q_mem =3D priv->rx[idx];
+	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
+	return 0;
+}
+
+static void gve_rx_queue_mem_free(struct net_device *dev, void *per_q_mem)
+{
+	struct gve_priv *priv =3D netdev_priv(dev);
+	struct gve_rx_alloc_rings_cfg cfg =3D {0};
+	struct gve_rx_ring *gve_per_q_mem;
+
+	gve_per_q_mem =3D (struct gve_rx_ring *)per_q_mem;
+	gve_rx_get_curr_alloc_cfg(priv, &cfg);
+
+	if (gve_is_gqi(priv))
+		gve_rx_free_ring_gqi(priv, gve_per_q_mem, &cfg);
+	else
+		gve_rx_free_ring_dqo(priv, gve_per_q_mem, &cfg);
+}
+
+static int gve_rx_queue_mem_alloc(struct net_device *dev, void *per_q_mem,
+				  int idx)
+{
+	struct gve_priv *priv =3D netdev_priv(dev);
+	struct gve_rx_alloc_rings_cfg cfg =3D {0};
+	struct gve_rx_ring *gve_per_q_mem;
+	int err;
+
+	if (!priv->rx)
+		return -EAGAIN;
+
+	gve_per_q_mem =3D (struct gve_rx_ring *)per_q_mem;
+	gve_rx_get_curr_alloc_cfg(priv, &cfg);
+
+	if (gve_is_gqi(priv))
+		err =3D gve_rx_alloc_ring_gqi(priv, &cfg, gve_per_q_mem, idx);
+	else
+		err =3D gve_rx_alloc_ring_dqo(priv, &cfg, gve_per_q_mem, idx);
+
+	return err;
+}
+
+static int gve_rx_queue_start(struct net_device *dev, void *per_q_mem, int=
 idx)
+{
+	struct gve_priv *priv =3D netdev_priv(dev);
+	struct gve_rx_ring *gve_per_q_mem;
+	int err;
+
+	if (!priv->rx)
+		return -EAGAIN;
+
+	gve_per_q_mem =3D (struct gve_rx_ring *)per_q_mem;
+	priv->rx[idx] =3D *gve_per_q_mem;
+
+	/* Single-queue creation requires quiescence on all queues */
+	gve_turndown(priv);
+
+	gve_rx_start_ring(priv, idx);
+
+	if (gve_is_qpl(priv)) {
+		/* This failure will trigger a reset - no need to clean up */
+		err =3D gve_register_qpl(priv, gve_rx_get_qpl(priv, idx));
+		if (err)
+			goto abort;
+	}
+
+	/* This failure will trigger a reset - no need to clean up */
+	err =3D gve_adminq_create_single_rx_queue(priv, idx);
+	if (err)
+		goto abort;
+
+	if (gve_is_gqi(priv))
+		gve_rx_write_doorbell(priv, &priv->rx[idx]);
+	else
+		gve_rx_post_buffers_dqo(&priv->rx[idx]);
+
+	/* Turn the unstopped queues back up */
+	gve_turnup_and_check_status(priv);
+	return 0;
+
+abort:
+	gve_rx_stop_ring(priv, idx);
+
+	/* All failures in this func result in a reset, by clearing the struct
+	 * at idx, we prevent a double free when that reset runs. The reset,
+	 * which needs the rtnl lock, will not run till this func returns and
+	 * its caller gives up the lock.
+	 */
+	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
+	return err;
+}
+
+static const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops =3D {
+	.ndo_queue_mem_size	=3D	sizeof(struct gve_rx_ring),
+	.ndo_queue_mem_alloc	=3D	gve_rx_queue_mem_alloc,
+	.ndo_queue_mem_free	=3D	gve_rx_queue_mem_free,
+	.ndo_queue_start	=3D	gve_rx_queue_start,
+	.ndo_queue_stop		=3D	gve_rx_queue_stop,
+};
+
 static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent=
)
 {
 	int max_tx_queues, max_rx_queues;
@@ -2382,6 +2534,7 @@ static int gve_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *ent)
 	pci_set_drvdata(pdev, dev);
 	dev->ethtool_ops =3D &gve_ethtool_ops;
 	dev->netdev_ops =3D &gve_netdev_ops;
+	dev->queue_mgmt_ops =3D &gve_queue_mgmt_ops;
=20
 	/* Set default and supported features.
 	 *
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/etherne=
t/google/gve/gve_rx.c
index fa45ab184297..68f64ebb0e27 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -99,8 +99,8 @@ void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx)
 	gve_rx_reset_ring_gqi(priv, idx);
 }
=20
-static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring=
 *rx,
-				 struct gve_rx_alloc_rings_cfg *cfg)
+void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
+			  struct gve_rx_alloc_rings_cfg *cfg)
 {
 	struct device *dev =3D &priv->pdev->dev;
 	u32 slots =3D rx->mask + 1;
@@ -264,10 +264,10 @@ void gve_rx_start_ring_gqi(struct gve_priv *priv, int=
 idx)
 	gve_add_napi(priv, ntfy_idx, gve_napi_poll);
 }
=20
-static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
-				 struct gve_rx_alloc_rings_cfg *cfg,
-				 struct gve_rx_ring *rx,
-				 int idx)
+int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
+			  struct gve_rx_alloc_rings_cfg *cfg,
+			  struct gve_rx_ring *rx,
+			  int idx)
 {
 	struct device *hdev =3D &priv->pdev->dev;
 	u32 slots =3D cfg->ring_size;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/eth=
ernet/google/gve/gve_rx_dqo.c
index 4ea8ecc3b2d5..c1c912de59c7 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -299,8 +299,8 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, int id=
x)
 	gve_rx_reset_ring_dqo(priv, idx);
 }
=20
-static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring=
 *rx,
-				 struct gve_rx_alloc_rings_cfg *cfg)
+void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
+			  struct gve_rx_alloc_rings_cfg *cfg)
 {
 	struct device *hdev =3D &priv->pdev->dev;
 	size_t completion_queue_slots;
@@ -376,10 +376,10 @@ void gve_rx_start_ring_dqo(struct gve_priv *priv, int=
 idx)
 	gve_add_napi(priv, ntfy_idx, gve_napi_poll_dqo);
 }
=20
-static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
-				 struct gve_rx_alloc_rings_cfg *cfg,
-				 struct gve_rx_ring *rx,
-				 int idx)
+int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
+			  struct gve_rx_alloc_rings_cfg *cfg,
+			  struct gve_rx_ring *rx,
+			  int idx)
 {
 	struct device *hdev =3D &priv->pdev->dev;
 	int qpl_page_cnt;
--=20
2.45.0.rc0.197.gbae5840b3b-goog


