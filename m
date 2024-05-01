Return-Path: <netdev+bounces-92861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191868B925B
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF331C21502
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D51B16C6A1;
	Wed,  1 May 2024 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Heaso9n5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE88168B05
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605976; cv=none; b=Tu31PseeCSjAOFDJXF0neMbwD1MLjf/dBhhUX00nxbHj8NQUQtJTdLuuaoWtPNseg+30KAPth1xIkEnDjoj28cn9rVDjM+miLZkueIVhfY7nv8Yf5EHkqXvo18UG4b5U6qalZ1DGDD+DO6L9ZCS7lC5c4cCfyO6QmiVaOn5bClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605976; c=relaxed/simple;
	bh=W1AK8ygLnTgsvtDOCzZrWNdpLZaLjHjsEmN7cXjb4Zc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZpwB3E+hrc2Fcn0JshMyyODPB6DpkCAitCxFuNJkVCDaqxI3ieRPuQz7tdJP3x8B7rb1ru9xLdC2qcOHXPfQntEx9aXFnD7oqlfamJjUCrQ7r7Tf0Tpemf1fJlLNHPFnthFC66EoDkcSEu9eBHMwO77/I7ZftFmOfHLAtDfYRJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Heaso9n5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de604ccb373so5519756276.2
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605973; x=1715210773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eG2KoU7GnurBrM2dBqBYHFFNoIgr4+ZljfxRfTW2pfU=;
        b=Heaso9n5kV+qkEbBzGmuM6QrFiO/4yxNjD7s5JwTIxpRCRe9C4vzl3n+/cex32KfRH
         DtXdK/ukWQZjk7o6qr0xk6yPflBXOD5dHwqzFQke9soveuy1LR6ymPK965PMV8jyts4S
         oA2TUWSKo8zPVcJWvzAQU9quPoxmmv8vSmJ49iR1FP5Kq2JE4VtCMofXNbzsZygoTMJ6
         AARf8rwbEmAvmVf1dnT6+C4tmDq2FN2AeUNyfX5xRspwAEwSyccVealQGXU2WdLFDhX2
         WwFs0GX4sVttKqjqRT8USmDEMqZvnf2Qkmovk/G/ha+ZTv69lPiTtZ+zvD84BNBzgNwD
         IdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605973; x=1715210773;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eG2KoU7GnurBrM2dBqBYHFFNoIgr4+ZljfxRfTW2pfU=;
        b=SlpQSelIcXIiEmeIEc3bMmSWIh+vdfsjucmyizRyH59AmU5Umtj18AY9PsacvRyRnU
         hGTyS55KLL+R9joLQtOaiaDdM34Zx0dUJxMdOrLby72WS8OrhlEDgKWAcrnHfjLoewF5
         P1sx900lvaVr053wfDywzKWUASlFqmYcvwtaaOaP8vUynuOozaqQHXHPS1ly7HKButdJ
         mCtqaE/pV228ICmD2iy9aAUw9Ade5hsrYlr/QuVCk++3KeQYuLSmH1DLUJUv78oFzOqb
         P+JWH+/iy2IMcAVSD34wjoWbp/0+3U6QaTK2cRL7oFtTCF3c9MWi/waNKLYDPH13l1jD
         PN4g==
X-Gm-Message-State: AOJu0YyTvqyjSc2+ntFOw335WS6CWRxraj9ZXyxZBDyAztpETk9y0qW1
	nToshXGJiSawOz/u68j1qYgJFqbru+C6Rs0k/oTstl2jSSdthraYhX5rnTC5Sp0+Pa+aBUdbEU2
	tD9vPmPJxckdKmb6Ixo3nIRZOIXDV2DjBIZtVkIqLNow0k9Xhwzk4oq1ivmwhAJPF+yxUieU5VN
	c+QHGjr6p/fyLFWaMo5GDMPYzCNqT0gtc5iXnaqQrKzTQ=
X-Google-Smtp-Source: AGHT+IGXdSB3eFf32lSKBDqUZ2PY2G/Kl5aaGe0RuFURZpUvxj6VQcUBHfa7cz3vVOd1SvoHDEiaJlFjz0E4HQ==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:1004:b0:de4:7a4b:903 with SMTP
 id w4-20020a056902100400b00de47a4b0903mr502982ybt.3.1714605973511; Wed, 01
 May 2024 16:26:13 -0700 (PDT)
Date: Wed,  1 May 2024 23:25:49 +0000
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501232549.1327174-11-shailend@google.com>
Subject: [PATCH net-next v2 10/10] gve: Implement queue api
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com, 
	willemb@google.com, ziweixiao@google.com, 
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
index e22ac764ec4f..cabf7d4bcecb 100644
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
@@ -1877,6 +1886,15 @@ static void gve_turnup(struct gve_priv *priv)
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
@@ -2323,6 +2341,140 @@ static void gve_write_version(u8 __iomem *driver_ve=
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
@@ -2377,6 +2529,7 @@ static int gve_probe(struct pci_dev *pdev, const stru=
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
index 70aca2f2c8c3..acb73d4d0de6 100644
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


