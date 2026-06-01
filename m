Return-Path: <netdev+bounces-293866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLcTBBPIHWrgdwkAu9opvQ
	(envelope-from <netdev+bounces-293866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:57:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95362393E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13D1F309F751
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5F3E5EEC;
	Mon,  1 Jun 2026 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbO6nx/s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE13E3C7A
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336488; cv=none; b=nyUptpnk4xZnYHaM5gBjN0SlXTuD0BAc69BckcdufIbnWaS4GdCfvK+k3Ead7IaoWLGT1s2xP7EwpObvKkgPFnz+tyRwV5nYRdzB7mgZeNHlWpK3AFj/1zSbzE/mFrjS/7022LLUHVCKRIJqHZbCkw10ZGpDouKPBdg4sR88nzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336488; c=relaxed/simple;
	bh=WPIHFJgcVtGgXlghGogtvbRgfVoxegmW2H7v7PaydW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lcTusMwAC7MYXolqcsvPkvWDqcGQ1xJ+4lxoYpN3YapsQdFXpT4oWDuZeT7M56RfJUTeAeLw2cDMRrqCQhU0xRvigRDW8W52HVOiiOcHtmN6QDYJC3NAhHYvEL7pLc8z85mxTOFri0ET/PQY7oEge4g3wh3Gv1OWnJjK7L+nFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbO6nx/s; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d97955899so1522060a91.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336485; x=1780941285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIViWg1T1aGVF2yYVGpgkPmWFa/trDD0tyf+jZFvz8A=;
        b=cbO6nx/sBqbP9+fACARkBq/yb2XtUo0AI5GalGjDzxulXb9BL0MVmFt8LPtYTBu0hE
         Oi99IAKXD1RRu+3DQF0s8T7OCM2DYHNoLE4rtELsWPdSpiFxWKsdhvaskzAW9Sy3fFFR
         ts2Qa3D5Q5Ksin+Eq17cGXUT5ItwP2kmMyDZVKcEwRUQCwdPsoJM9fAXfyqa6How9CYm
         jtJ5CnlkcUiMHJpDykVAZ9dRt6XNlFnRtuZp/OmjAnvfsizfL6Dq1KnX6yljL9jCSlsH
         5uRlXJUYRq9yHy1tdWEqy1ql+AmFHkzMECRpgW6HHX4n7UnhEf9a/p5mkFABAB6/Sa5A
         3sVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336485; x=1780941285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIViWg1T1aGVF2yYVGpgkPmWFa/trDD0tyf+jZFvz8A=;
        b=NDEs/sT9TFLyy/9T4/Ajg22pyH+b81Mj6nkBmF9TxyYfT1nZ2LKLDQimtztlkFiOrv
         tc1DWcx6fqBTe9AIoAGNXY1Q2nDnYaMky1G4eLEuxqUV0vFEjJGawvNfDO3H1H9UHZ93
         SnGHviB/0fKa1g1GSvWdCC0xVOIdJHSYJbMmrxJvKOiMHkdvYMtfQFYQfV7z9Sfu+Fx+
         WsCNJbX1bVrWqF47YGRlq1iIDBGvX8vee+9p62IrbSvek/GxB7DbhmHlm4wAucsyy1ss
         O5xTxfnEXb9d6Dlx3+CfrvkIZnep57WH1W9ALnlEHPs17JBq+tpe+3gMKc9Cw41NTtO7
         Zb6Q==
X-Gm-Message-State: AOJu0YyUeXuSOXmVmKwFfK89ZAhywDqx+9h5T7LSB6RvOnRbCMT1XjyG
	oyItVqMZLuss1zdBn1SUT5MGvQAYPR2Kh3lNIIq5Tdm+z7UZkwzKgTfJj5Kk/gEm78tspxuvRQA
	9aTgKlpJG9/6A3TDEXlHdmDcwhjMOYSECHC2gqPjbqJcDq04o9DgwHSVt3pMtvmzuIq3qb0Fkci
	jAjIbL0kqUSt8drSvIpwdc0h2mPmKLXEDVjXCY3mVInIrWyPcAFCMLt35GB7Gzl+k=
X-Received: from pgbda11.prod.google.com ([2002:a05:6a02:238b:b0:c85:b574:566b])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3dc8:b0:36d:cf58:b79 with SMTP id 98e67ed59e1d1-36dcf580f7fmr1928828a91.19.1780336484943;
 Mon, 01 Jun 2026 10:54:44 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:29 +0000
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-8-hramamurthy@google.com>
Subject: [PATCH net-next 07/15] gve: introduce ctrl ops to set vectors and Qs
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293866-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7B95362393E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce following ctrl ops for Adminq mode. This change does
not introduce any functional change, just movement of code into
ops.

- set_num_queues to set maximum and default TX/RX queues in the
  alloc structures used in the initialization flow.
- set_num_ntfy_blks op to set number of vectors(ntfy_blks) in the
  initialization flow.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  6 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 45 ++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 64 +++-----------------
 4 files changed, 63 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 9c1d38467bf9..a4a558df2019 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -831,10 +831,16 @@ struct gve_device_info {
  * struct gve_ctrl_ops - Control plane operations structure
  * @map_db_bar: Maps the doorbell BAR for the device and store in @priv.
  * @unmap_db_bar: Unmaps the doorbell BAR previously mapped by @map_db_bar.
+ * @set_num_queues: Sets default and max TX/RX queues into allocation
+ *                  structures stored in @priv to be used during initialization.
+ * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
+ *                     initialization.
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
 	void (*unmap_db_bar)(struct gve_priv *priv);
+	void (*set_num_queues)(struct gve_priv *priv);
+	int (*set_num_ntfy_blks)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index c9ea1ffd22f8..c6680b6ede8a 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1691,3 +1691,48 @@ void gve_adminq_unmap_db_bar(struct gve_priv *priv)
 
 	pci_iounmap(pdev, priv->db_bar2);
 }
+
+int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv)
+{
+	int num_ntfy;
+
+	num_ntfy = pci_msix_vec_count(priv->pdev);
+	if (num_ntfy <= 0) {
+		dev_err(&priv->pdev->dev,
+			"could not count MSI-x vectors: err=%d\n", num_ntfy);
+		return num_ntfy;
+	} else if (num_ntfy < GVE_MIN_MSIX) {
+		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
+			GVE_MIN_MSIX, num_ntfy);
+		return -EINVAL;
+	}
+
+	/* gvnic has one Notification Block per MSI-x vector, except for the
+	 * management vector
+	 */
+	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
+	priv->mgmt_msix_idx = priv->num_ntfy_blks;
+
+	return 0;
+}
+
+void gve_adminq_set_num_queues(struct gve_priv *priv)
+{
+	struct gve_device_info *device_info = &priv->device_info;
+
+	priv->tx_cfg.max_queues =
+		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
+	priv->rx_cfg.max_queues =
+		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
+
+	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
+	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
+	if (device_info->default_tx_queues > 0)
+		priv->tx_cfg.num_queues = min_t(int,
+						device_info->default_tx_queues,
+						priv->tx_cfg.num_queues);
+	if (device_info->default_rx_queues > 0)
+		priv->rx_cfg.num_queues = min_t(int,
+						device_info->default_rx_queues,
+						priv->rx_cfg.num_queues);
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 85e5dbd1270c..8b6f81d03bc6 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -657,5 +657,7 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
 int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
+int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
+void gve_adminq_set_num_queues(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 51dd4f9b3022..d693caed7e3d 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2354,56 +2354,6 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
 	.xmo_rx_timestamp	= gve_xdp_rx_timestamp,
 };
 
-static int gve_set_num_ntfy_blks(struct gve_priv *priv)
-{
-	int num_ntfy;
-
-	num_ntfy = pci_msix_vec_count(priv->pdev);
-	if (num_ntfy <= 0) {
-		dev_err(&priv->pdev->dev,
-			"could not count MSI-x vectors: err=%d\n", num_ntfy);
-		return num_ntfy;
-	} else if (num_ntfy < GVE_MIN_MSIX) {
-		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
-			GVE_MIN_MSIX, num_ntfy);
-		return -EINVAL;
-	}
-
-	/* gvnic has one Notification Block per MSI-x vector, except for the
-	 * management vector
-	 */
-	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
-	priv->mgmt_msix_idx = priv->num_ntfy_blks;
-
-	return 0;
-}
-
-static void gve_set_num_queues(struct gve_priv *priv)
-{
-	struct gve_device_info *device_info = &priv->device_info;
-
-	priv->tx_cfg.max_queues =
-		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
-	priv->rx_cfg.max_queues =
-		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
-
-	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
-	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
-	if (device_info->default_tx_queues > 0)
-		priv->tx_cfg.num_queues = min_t(int,
-						device_info->default_tx_queues,
-						priv->tx_cfg.num_queues);
-	if (device_info->default_rx_queues > 0)
-		priv->rx_cfg.num_queues = min_t(int,
-						device_info->default_rx_queues,
-						priv->rx_cfg.num_queues);
-
-	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
-		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
-	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
-		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
-}
-
 static void gve_set_desc_cnt(struct gve_priv *priv)
 {
 	struct gve_device_info *device_info = &priv->device_info;
@@ -2465,8 +2415,10 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
 }
 
 static const struct gve_ctrl_ops gve_adminq_ops = {
-	.map_db_bar	 = gve_adminq_map_db_bar,
-	.unmap_db_bar	 = gve_adminq_unmap_db_bar,
+	.map_db_bar		= gve_adminq_map_db_bar,
+	.unmap_db_bar		= gve_adminq_unmap_db_bar,
+	.set_num_queues		= gve_adminq_set_num_queues,
+	.set_num_ntfy_blks	= gve_adminq_set_num_ntfy_blks,
 };
 
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
@@ -2494,14 +2446,18 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 
 	priv->queue_format = priv->device_info.queue_format;
 
-	err = gve_set_num_ntfy_blks(priv);
+	err = priv->ctrl_ops->set_num_ntfy_blks(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not setup notify blocks: err=%d\n", err);
 		goto err;
 	}
 
-	gve_set_num_queues(priv);
+	priv->ctrl_ops->set_num_queues(priv);
+	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
+		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
+	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
+		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
 
 	if (gve_is_dqo(priv)) {
 		/* DQO supports HW-GRO and UDP_GSO */
-- 
2.54.0.669.g59709faab0-goog


