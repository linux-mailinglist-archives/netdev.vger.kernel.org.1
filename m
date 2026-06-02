Return-Path: <netdev+bounces-294480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PDwtF8BvH2rLlwAAu9opvQ
	(envelope-from <netdev+bounces-294480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:05:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA163314A
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:05:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Ax4So56q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294480-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294480-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AD8630FE3AB
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 00:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2203DCDB2;
	Tue,  2 Jun 2026 23:59:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957603D1717
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 23:59:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444756; cv=none; b=RwNyOv08SMq1SIzb0RecJn/hd9gSAp/7HuFTKTKSyTEZKR7N5W4e7KRJXeVUrNgvKxqewpO6kPshGSR0W8Q+RCKNI3lgFtiCTy8mQqbXvWBlalkv+U9ecYcx/cKagr8u81D2DmfScYwFnvzpL2CI1O8Ij87asz6+wx/S3YZFaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444756; c=relaxed/simple;
	bh=qdUwWfqH2ScZ7OVPBHIwyGfGzSkBUL7CRJoOZbN0zTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bJRidz7XiAn29E6VesIEu23GlV2S+m4r5I5mnzM/pbxKE5WeCVc5FtqDAAgH0UNs69XPnD9/suhsbns432uxJjV7JDjIOXvPlmC97vSXgd6h+QHY4kK8O4ay+rqdD4lBiIPrEeKYfXjJ2+O8IjkwBH3uKSHTGP9MYhjvJIxMpj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ax4So56q; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c1e112dfso41764225ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444753; x=1781049553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FlKji3hm2NB+QDodIndkPfsEAgD6+iyL7xiAelQYGw=;
        b=Ax4So56q5k61i1vdoLW3n8+og9SmBUt7sisIU3DLWBqMAht0l3yn7usMlfi0IhGrSs
         2sQtiWNah56R57810d99CnQ78qMhbRcVrYHS9hPsA50QtIRMF0i6Ea/pNk03VROYPJwV
         ChnRbT7JpoQL5k74+K36bUlbEP3GGAeuZfZulLNVxLKbFN/+kd1nCFgbHZaENfintGrG
         OQPYBnGCmWLw8H1evA5h7xdaJ/z/b0PA8Vt3QF3/5ek8E1gilUycAYEGjFOJm2nIOhB/
         XxPIpcT/Go9ZJYeA8kNLgG3mZBs7J1zZXHNs2839yc1DO7iNGWvdrbI5dbz2RGHR/UV8
         LY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444753; x=1781049553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FlKji3hm2NB+QDodIndkPfsEAgD6+iyL7xiAelQYGw=;
        b=AEIKyfvIwV3FVgH24EhM5Do7OmVQszJBiDfWCWDkDAULFZ+yZ1l9bkX8urLw5DcxnI
         KwL7KaIsLHbRKSVP2FHyMaxoMBK86myMK+gjsGLkfcA2AXTqihWqtL7l46gqLlGmc+mu
         w0QvMn2GGdBD8XDAs8Vt4/LN0ZC5VNDp63IXJVfOFJ7rJ0rF6qTH81vxF5aVf4yRorjO
         wAbT9f25shc8PMvaYjM4SCylUiXXYhFACALpuaX4AP+q3UbeSlZYvdsiKJppW0Xr0PgX
         KeYXRJbTlJQwZWVTSu469IdGT46iy2DH9s8L7x5VxnTrd75XJ6bxbxT9IQ7LGJ/Um1NJ
         5Yvw==
X-Gm-Message-State: AOJu0YzSEvPiOMwo8VNBAah+ti7JQWb9Aql7YbbDMvmgNkkJZPfItzvW
	CsHWLxHbB8pI8PHre49x2b0cbtdx25ASmHsqxlD/AR5C0Qe2tQxMKNLU+z+UKqqxgcUDsOxAlq6
	P7WglMY39hz0BFTU6q4+vk3g0Tt/0QYRHe+43/AgJ0H+tNR0wLCAUDFtK2zMDzCmpJpVwTfw25J
	U6LivOFl1gMpHYpZhYP18C+E/7YT6i2vFv5O74jtCPTohAeoELaXgaXiSYc3p/qHQ=
X-Received: from plbke7.prod.google.com ([2002:a17:903:3407:b0:2bf:190f:f93e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e985:b0:2c1:5a24:b4ed with SMTP id d9443c01a7336-2c1644d1a9bmr6069555ad.37.1780444752437;
 Tue, 02 Jun 2026 16:59:12 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:56 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-13-hramamurthy@google.com>
Subject: [PATCH net-next v2 12/15] gve: introduce new methods to handle IRQ doorbells
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294480-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:joshwash@google.com,m:hramamurthy@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:willemb@google.com,m:jordanrhee@google.com,m:jfraker@google.com,m:nktgrg@google.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDFA163314A

From: Joshua Washington <joshwash@google.com>

Introduce `request_db_info` and `free_db_resources` to
`struct gve_ctrl_ops`. These encapsulate the configuration of device
resources (counter arrays and IRQ doorbell indices) which vary between
Admin Queue and Mailbox modes. All behaviors related to the IRQ doorbell
indices will be managed by these new methods instead of occurring
directly in notify_block setup/teardown methods. Similarly, GQ ring
counters will be managed in `request_db_info`.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 12 ++++
 drivers/net/ethernet/google/gve/gve_adminq.c | 71 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 70 +++++--------------
 4 files changed, 103 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index e173c14bdc08..6db5fbc0b321 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -833,6 +833,8 @@ struct gve_device_info {
  *                  structures stored in @priv to be used during initialization.
  * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
  *                     initialization.
+ * @request_db_info: Request and store doorbell information into @priv
+ * @free_db_resources: Free DMA memory holding doorbell info (AdminQ only)
  * @get_ptype_map: Learn packet type map from device and store it in @priv
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
@@ -843,6 +845,8 @@ struct gve_ctrl_ops {
 	void (*unmap_db_bar)(struct gve_priv *priv);
 	void (*set_num_queues)(struct gve_priv *priv);
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
+	int (*request_db_info)(struct gve_priv *priv);
+	void (*free_db_resources)(struct gve_priv *priv);
 	int (*get_ptype_map)(struct gve_priv *priv);
 	int (*configure_rss)(struct gve_priv *priv,
 			     struct ethtool_rxfh_param *param);
@@ -1163,6 +1167,11 @@ static inline u32 gve_rx_idx_to_ntfy(struct gve_priv *priv, u32 queue_idx)
 	return (priv->num_ntfy_blks / 2) + queue_idx;
 }
 
+static inline u32 gve_ntfy_to_msix_idx(struct gve_priv *priv, u32 ntfy_blk_idx)
+{
+	return ntfy_blk_idx;
+}
+
 static inline bool gve_is_qpl(struct gve_priv *priv)
 {
 	return priv->queue_format == GVE_GQI_QPL_FORMAT ||
@@ -1375,6 +1384,9 @@ int gve_adjust_queues(struct gve_priv *priv,
 		      struct gve_rx_queue_config new_rx_config,
 		      struct gve_tx_queue_config new_tx_config,
 		      bool reset_rss);
+/* Initialization sequence */
+int gve_alloc_counter_array(struct gve_priv *priv);
+void gve_free_counter_array(struct gve_priv *priv);
 /* flow steering rule */
 int gve_get_flow_rule_entry(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
 int gve_get_flow_rule_ids(struct gve_priv *priv, struct ethtool_rxnfc *cmd, u32 *rule_locs);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index d814108deeef..259dcd617216 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1719,3 +1719,74 @@ void gve_adminq_set_num_queues(struct gve_priv *priv)
 						device_info->default_rx_queues,
 						priv->rx_cfg.num_queues);
 }
+
+int gve_adminq_request_db_info(struct gve_priv *priv)
+{
+	int err;
+	int i;
+
+	/* Alloc dma addrs needed for shm regions */
+	err = gve_alloc_counter_array(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Failed to alloc db counter array.");
+		return err;
+	}
+
+	priv->irq_db_indices =
+		dma_alloc_coherent(&priv->pdev->dev,
+				   priv->num_ntfy_blks *
+				   sizeof(*priv->irq_db_indices),
+				   &priv->irq_db_indices_bus, GFP_KERNEL);
+	if (!priv->irq_db_indices) {
+		err = -ENOMEM;
+		goto abort_with_counter_array;
+	}
+
+	err = gve_adminq_configure_device_resources(priv,
+						    priv->counter_array_bus,
+						    priv->num_event_counters,
+						    priv->irq_db_indices_bus,
+						    priv->num_ntfy_blks);
+	if (unlikely(err)) {
+		dev_err(&priv->pdev->dev,
+			"could not setup device_resources: err=%d\n", err);
+		err = -ENXIO;
+		goto abort_with_irq_db_indices;
+	}
+
+	for (i = 0; i < priv->num_ntfy_blks; i++)
+		priv->ntfy_blocks[i].irq_db_index =
+			&priv->irq_db_indices[i].index;
+	return 0;
+
+abort_with_irq_db_indices:
+	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
+			  sizeof(*priv->irq_db_indices),
+			  priv->irq_db_indices, priv->irq_db_indices_bus);
+	priv->irq_db_indices = NULL;
+abort_with_counter_array:
+	gve_free_counter_array(priv);
+	return err;
+}
+
+void gve_adminq_free_db_resources(struct gve_priv *priv)
+{
+	int err;
+
+	/* Log error in deconfigure device, but don't fail. This is only ever
+	 * called as a reset is about to be triggered, so it would be redundant
+	 * to trigger a reset.
+	 */
+	err = gve_adminq_deconfigure_device_resources(priv);
+	if (err)
+		dev_err(&priv->pdev->dev,
+			"Could not deconfigure device resources: err=%d\n",
+			err);
+
+	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
+			  sizeof(*priv->irq_db_indices),
+			  priv->irq_db_indices, priv->irq_db_indices_bus);
+	priv->irq_db_indices = NULL;
+	gve_free_counter_array(priv);
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index d5f98a80be46..985b1aefea6e 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -657,5 +657,7 @@ int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
 void gve_adminq_set_num_queues(struct gve_priv *priv);
+int gve_adminq_request_db_info(struct gve_priv *priv);
+void gve_adminq_free_db_resources(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 98970508ae54..55f48aee125e 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -179,7 +179,7 @@ static void gve_free_rss_config_cache(struct gve_priv *priv)
 	memset(rss_config, 0, sizeof(*rss_config));
 }
 
-static int gve_alloc_counter_array(struct gve_priv *priv)
+int gve_alloc_counter_array(struct gve_priv *priv)
 {
 	priv->counter_array =
 		dma_alloc_coherent(&priv->pdev->dev,
@@ -192,7 +192,7 @@ static int gve_alloc_counter_array(struct gve_priv *priv)
 	return 0;
 }
 
-static void gve_free_counter_array(struct gve_priv *priv)
+void gve_free_counter_array(struct gve_priv *priv)
 {
 	if (!priv->counter_array)
 		return;
@@ -428,15 +428,6 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 static void gve_free_notify_blocks(struct gve_priv *priv)
 {
 	pci_disable_msix(priv->pdev);
-	if (priv->irq_db_indices) {
-		dma_free_coherent(&priv->pdev->dev,
-				  priv->num_ntfy_blks *
-				  sizeof(*priv->irq_db_indices),
-				  priv->irq_db_indices,
-				  priv->irq_db_indices_bus);
-		priv->irq_db_indices = NULL;
-	}
-
 	kvfree(priv->ntfy_blocks);
 	priv->ntfy_blocks = NULL;
 	kvfree(priv->msix_vectors);
@@ -493,24 +484,14 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 			priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
 	}
 
-	priv->irq_db_indices =
-		dma_alloc_coherent(&priv->pdev->dev,
-				   priv->num_ntfy_blks *
-				   sizeof(*priv->irq_db_indices),
-				   &priv->irq_db_indices_bus, GFP_KERNEL);
-	if (!priv->irq_db_indices) {
-		err = -ENOMEM;
-		goto abort;
-	}
-
 	priv->ntfy_blocks = kvzalloc(priv->num_ntfy_blks *
 				     sizeof(*priv->ntfy_blocks), GFP_KERNEL);
 	if (!priv->ntfy_blocks) {
 		err = -ENOMEM;
 		goto abort;
 	}
-	return 0;
 
+	return 0;
 abort:
 	gve_free_notify_blocks(priv);
 	return err;
@@ -525,13 +506,14 @@ static void gve_teardown_notify_blocks(struct gve_priv *priv)
 
 	for (i = 0; i < priv->num_ntfy_blks; i++) {
 		struct gve_notify_block *block = &priv->ntfy_blocks[i];
+		int msix_idx = gve_ntfy_to_msix_idx(priv, i);
 
 		if (!block->irq_requested)
 			continue;
 
-		irq_set_affinity_hint(priv->msix_vectors[i].vector,
+		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
 				      NULL);
-		free_irq(priv->msix_vectors[i].vector, block);
+		free_irq(priv->msix_vectors[msix_idx].vector, block);
 		block->irq = 0;
 		block->irq_requested = false;
 	}
@@ -560,12 +542,11 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 	}
 	priv->mgmt_irq_requested = true;
 
-	/* Setup the other blocks - the first n-1 vectors */
 	node_mask = gve_get_node_mask(priv);
 	cur_cpu = cpumask_first(node_mask);
 	for (i = 0; i < priv->num_ntfy_blks; i++) {
 		struct gve_notify_block *block = &priv->ntfy_blocks[i];
-		int msix_idx = i;
+		int msix_idx = gve_ntfy_to_msix_idx(priv, i);
 
 		snprintf(block->name, sizeof(block->name), "gve-ntfy-blk%d@pci:%s",
 			 i, pci_name(priv->pdev));
@@ -575,14 +556,13 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 				  IRQF_NO_AUTOEN, block->name, block);
 		if (err) {
 			dev_err(&priv->pdev->dev,
-				"Failed to receive msix vector %d\n", i);
+				"Failed to receive msix vector %d\n", msix_idx);
 			goto abort;
 		}
 		block->irq = priv->msix_vectors[msix_idx].vector;
 		block->irq_requested = true;
 		irq_set_affinity_and_hint(block->irq,
 					  cpumask_of(cur_cpu));
-		block->irq_db_index = &priv->irq_db_indices[i].index;
 
 		cur_cpu = cpumask_next(cur_cpu, node_mask);
 		/* Wrap once CPUs in the node have been exhausted, or when
@@ -599,7 +579,6 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 	return err;
 }
 
-
 static void gve_free_control_plane_resources(struct gve_priv *priv)
 {
 	bitmap_free(priv->xsk_pools);
@@ -608,9 +587,8 @@ static void gve_free_control_plane_resources(struct gve_priv *priv)
 	kvfree(priv->ptype_lut_dqo);
 	priv->ptype_lut_dqo = NULL;
 
-	gve_free_stats_report(priv);
 	gve_free_notify_blocks(priv);
-	gve_free_counter_array(priv);
+	gve_free_stats_report(priv);
 	gve_free_rss_config_cache(priv);
 	gve_free_flow_rule_caches(priv);
 }
@@ -623,9 +601,6 @@ static int gve_alloc_control_plane_resources(struct gve_priv *priv)
 	if (err)
 		return err;
 	err = gve_alloc_rss_config_cache(priv);
-	if (err)
-		goto abort;
-	err = gve_alloc_counter_array(priv);
 	if (err)
 		goto abort;
 	err = gve_alloc_notify_blocks(priv);
@@ -661,15 +636,9 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int err;
 
-	err = gve_adminq_configure_device_resources(priv,
-						    priv->counter_array_bus,
-						    priv->num_event_counters,
-						    priv->irq_db_indices_bus,
-						    priv->num_ntfy_blks);
-	if (unlikely(err)) {
-		dev_err(&priv->pdev->dev,
-			"could not setup device_resources: err=%d\n", err);
-		err = -ENXIO;
+	err = ops->request_db_info(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev, "Failed to get db info");
 		return err;
 	}
 
@@ -678,7 +647,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
-			goto deconfigure_device;
+			goto free_db_resources;
 		}
 	}
 
@@ -708,8 +677,8 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 
 teardown_clock:
 	gve_teardown_clock(priv);
-deconfigure_device:
-	gve_adminq_deconfigure_device_resources(priv);
+free_db_resources:
+	ops->free_db_resources(priv);
 	return err;
 }
 
@@ -739,12 +708,7 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 			dev_err(&priv->pdev->dev,
 				"Failed to detach stats report: err=%d\n", err);
 		gve_teardown_clock(priv);
-
-		err = gve_adminq_deconfigure_device_resources(priv);
-		if (err)
-			dev_err(&priv->pdev->dev,
-				"Could not deconfigure device resources: err=%d\n",
-				err);
+		ops->free_db_resources(priv);
 	}
 
 	gve_clear_device_resources_ok(priv);
@@ -2494,6 +2458,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.reset_flow_rules	= gve_adminq_reset_flow_rules,
 	.setup_stats_report	= gve_adminq_report_stats,
 	.configure_rss		= gve_adminq_configure_rss,
+	.request_db_info	= gve_adminq_request_db_info,
+	.free_db_resources	= gve_adminq_free_db_resources,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.54.0.1013.g208068f2d8-goog


