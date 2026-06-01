Return-Path: <netdev+bounces-293865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B4uAvrHHWrgdwkAu9opvQ
	(envelope-from <netdev+bounces-293865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:57:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD52B623929
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 424F13095449
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA173E5A25;
	Mon,  1 Jun 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2uYNRei"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA543E2AB0
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336487; cv=none; b=ivgWJNYPHGELOrOeTVj8K7/VlyaflVlm2Cw1kOgc2gSZAC+iah/oLnuZzXPe8ScJzFYzDNaQUaCXzOhxUnaiRj5Jua+Q8wL65yC7si/sUbemjgufh7wz8PmeTZ6ajOw4ool45/oVBPqKmV2tFA2ITKtZnP7dBo4+v5/E+ImIXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336487; c=relaxed/simple;
	bh=irnnGq41SRFMUpY7Cbm8xIGBudp5hRleIGnbca8DrP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rurS50otuO33dQTxaUg26oN1CCOy4qy3sWYYbEVC6JNRuVLhtWw8QSxCIllNxsOOowGFl7ao4lTcydos7ac8kPOE5OUIKHzHIlA4Uo2BDVKyE/OAiSgb+9svQgLyUV+F7pJ1a7pHblmkEuA5xsdkgAi860J5XhiMGNYYjg/Wsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2uYNRei; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0532a6588so22182685ad.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336484; x=1780941284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxWPvhflFM9Ed7eSo0Zs6V3/7d1+n3E+IvSQjxR6PRk=;
        b=d2uYNReiChOMLGouXBe2cjnv0BumiuUTVXYk1S+kEYSzEOMBVPs83nQa3KVQ2b51Ft
         dkvvrm3x1CU4qFVDSZXu+mwZRDsMkTNiuJStr1DMsr9wM4JfK2gxyeaCSPdP7e7YDQuL
         7s4iDTiYeae5hWC6LlVSATkDD31Fn2Qugv7ay4R2poRmM7PgLWKdI8bevmoHP0mKEnwI
         FXCTYZ2v2znce0lI4TChmHBTtyXCztGdCG0tPszSn6BVwymIV4khr3a5rDZPV/u4j0o+
         vQoshueEmuOxmfmXFZtRLtRz0jaOcLakgQXvns4ii13DoBw09Z8zGnvypSKNxDWKTDnW
         5ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336484; x=1780941284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxWPvhflFM9Ed7eSo0Zs6V3/7d1+n3E+IvSQjxR6PRk=;
        b=nMvI7Gsj1O9DWqoKt1kSbpNMiZiDARf3U43dEqA0GXMbviUK2lPnAeQ4hNO72SHPB+
         YQdaAGjzESs6U+MhepmfrZ0RPgOCGh6RToVE9om3ONKos6Kn86kIEgLUkL4iCviHQYRs
         QdtadL2NZ8PyRQJyBNR8olLpfeLpk5WB5H0//hdITEfEM6kefxX83YK6lL6OsifDFPZT
         RnEyk0MmSrG57vk4d2RfDYmi4UYuJEP/dI16cfb+3begXi/uZI+maOHC9fD8ar0oEBbv
         LcLeRW/3xek8/EY8u6ROd5hP4IhgGfB61YJlbGL6pT2us7c2p8iFs3OEshV6hBIDSaHt
         /nQg==
X-Gm-Message-State: AOJu0YxhyIvXu3JDKhcNOJ1uJ/prpMm+qPRiE6cMAVME1PvPHfiOW6Ea
	LxoXkXYnx01gd9kIKLK+XnPAg9xqtIABPscyDsw3kXrfNuC/Ag9HSDY1X7FdTDmb0RDj9V4OTMQ
	FOCjqf38c/K57IIlUsfbDQLHLf27RQre2dhNLRksPwertH3hz+rtjywgYJ2xH+4+G0jDyUhsYhq
	GmkB2Vm3leHfTNYsnytXgYiipMyWgh252MSwoXsfKBFVDzZDvmRyoGMJJFue1IWEw=
X-Received: from plxj16.prod.google.com ([2002:a17:902:da90:b0:2bf:2cd5:1d4a])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f60c:b0:2c0:c14c:bf38 with SMTP id d9443c01a7336-2c0c14cc277mr85806675ad.24.1780336484095;
 Mon, 01 Jun 2026 10:54:44 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:28 +0000
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-7-hramamurthy@google.com>
Subject: [PATCH net-next 06/15] gve: introduce control plane operations structure
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293865-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AD52B623929
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To abstract out the difference in implementation of control
plane operations between the existing Adminq ABI and the upcoming
Mailbox ABI, introduce a new gve_ctrl_ops structure which will
contain the basic operations. At probe, these ops will be set based
on the ABI and the corresponding ops will be called in relevant
places.

As of this patch, only Adminq ops are set. In future patches,
corresponding ops will be set for the new mailbox mode.

Implement a ctrl op to map/unmap the doorbell bar. Since this
functionality has moved to a control op, call this op after control
ops are set for AdminQ mode.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 11 ++++++
 drivers/net/ethernet/google/gve/gve_adminq.c | 21 ++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c   | 36 +++++++++++---------
 4 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index e780492edee5..9c1d38467bf9 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -827,6 +827,16 @@ struct gve_device_info {
 	bool cache_rss_config;
 };
 
+/**
+ * struct gve_ctrl_ops - Control plane operations structure
+ * @map_db_bar: Maps the doorbell BAR for the device and store in @priv.
+ * @unmap_db_bar: Unmaps the doorbell BAR previously mapped by @map_db_bar.
+ */
+struct gve_ctrl_ops {
+	int (*map_db_bar)(struct gve_priv *priv);
+	void (*unmap_db_bar)(struct gve_priv *priv);
+};
+
 struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
@@ -966,6 +976,7 @@ struct gve_priv {
 	struct kernel_hwtstamp_config ts_config;
 	u64 last_sync_nic_counter; /* Clock counter from last NIC TS report */
 	struct gve_device_info device_info;
+	const struct gve_ctrl_ops *ctrl_ops;
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 4235ef9f4a04..c9ea1ffd22f8 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1670,3 +1670,24 @@ int gve_adminq_query_rss_config(struct gve_priv *priv, struct ethtool_rxfh_param
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
 	return err;
 }
+
+int gve_adminq_map_db_bar(struct gve_priv *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	void __iomem *db_bar;
+
+	db_bar = pci_iomap(pdev, GVE_DOORBELL_BAR, 0);
+	if (!db_bar) {
+		dev_err(&pdev->dev, "Failed to map doorbell bar!\n");
+		return -ENOMEM;
+	}
+	priv->db_bar2 = db_bar;
+	return 0;
+}
+
+void gve_adminq_unmap_db_bar(struct gve_priv *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+
+	pci_iounmap(pdev, priv->db_bar2);
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 107c21b7b047..85e5dbd1270c 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -655,5 +655,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
+int gve_adminq_map_db_bar(struct gve_priv *priv);
+void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 1aeee916471f..51dd4f9b3022 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2464,6 +2464,11 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
 		priv->header_buf_size = device_info->header_buf_size;
 }
 
+static const struct gve_ctrl_ops gve_adminq_ops = {
+	.map_db_bar	 = gve_adminq_map_db_bar,
+	.unmap_db_bar	 = gve_adminq_unmap_db_bar,
+};
+
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
 	struct gve_device_info *device_info = &priv->device_info;
@@ -2850,7 +2855,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int max_tx_queues, max_rx_queues;
 	struct net_device *dev;
-	__be32 __iomem *db_bar;
 	struct gve_registers __iomem *reg_bar;
 	struct gve_priv *priv;
 	int err;
@@ -2878,13 +2882,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto abort_with_pci_region;
 	}
 
-	db_bar = pci_iomap(pdev, GVE_DOORBELL_BAR, 0);
-	if (!db_bar) {
-		dev_err(&pdev->dev, "Failed to map doorbell bar!\n");
-		err = -ENOMEM;
-		goto abort_with_reg_bar;
-	}
-
 	gve_write_version(&reg_bar->driver_version);
 	/* Get max queues to alloc etherdev */
 	max_tx_queues = ioread32be(&reg_bar->max_tx_queues);
@@ -2894,7 +2891,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!dev) {
 		dev_err(&pdev->dev, "could not allocate netdev\n");
 		err = -ENOMEM;
-		goto abort_with_db_bar;
+		goto abort_with_reg_bar;
 	}
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	pci_set_drvdata(pdev, dev);
@@ -2926,19 +2923,27 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	priv->pdev = pdev;
 	priv->msg_enable = DEFAULT_MSG_LEVEL;
 	priv->reg_bar0 = reg_bar;
-	priv->db_bar2 = db_bar;
 	priv->service_task_flags = 0x0;
 	priv->state_flags = 0x0;
 	priv->ethtool_flags = 0x0;
 	priv->rx_cfg.packet_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 	priv->max_rx_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 
+	/* Set adminq ctrl ops */
+	priv->ctrl_ops = &gve_adminq_ops;
+
+	err = priv->ctrl_ops->map_db_bar(priv);
+	if (err) {
+		err = -ENOMEM;
+		goto abort_with_netdev;
+	}
+
 	gve_set_probe_in_progress(priv);
 	priv->gve_wq = alloc_ordered_workqueue("gve", 0);
 	if (!priv->gve_wq) {
 		dev_err(&pdev->dev, "Could not allocate workqueue");
 		err = -ENOMEM;
-		goto abort_with_netdev;
+		goto abort_with_unmap_db_bar;
 	}
 	INIT_WORK(&priv->service_task, gve_service_task);
 	INIT_WORK(&priv->stats_report_task, gve_stats_report_task);
@@ -2968,12 +2973,12 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 abort_with_wq:
 	destroy_workqueue(priv->gve_wq);
 
+abort_with_unmap_db_bar:
+	priv->ctrl_ops->unmap_db_bar(priv);
+
 abort_with_netdev:
 	free_netdev(dev);
 
-abort_with_db_bar:
-	pci_iounmap(pdev, db_bar);
-
 abort_with_reg_bar:
 	pci_iounmap(pdev, reg_bar);
 
@@ -2989,14 +2994,13 @@ static void gve_remove(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct gve_priv *priv = netdev_priv(netdev);
-	__be32 __iomem *db_bar = priv->db_bar2;
 	void __iomem *reg_bar = priv->reg_bar0;
 
 	unregister_netdev(netdev);
 	gve_teardown_priv_resources(priv);
 	destroy_workqueue(priv->gve_wq);
+	priv->ctrl_ops->unmap_db_bar(priv);
 	free_netdev(netdev);
-	pci_iounmap(pdev, db_bar);
 	pci_iounmap(pdev, reg_bar);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.54.0.669.g59709faab0-goog


