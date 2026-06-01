Return-Path: <netdev+bounces-293863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGVmFNvHHWrgdwkAu9opvQ
	(envelope-from <netdev+bounces-293863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:56:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2265623913
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CA903083E9F
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58B3E315F;
	Mon,  1 Jun 2026 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgn1iM4o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF583E1D0B
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336485; cv=none; b=qg4eQ+33s6BjmeXC4EjiwEGI1nrj4YlEs9b+klFsVXhBaj2mTMj4eH8nHzGmDHhNS4FBa4Hz5t29QWx5+rdJtjU0UNBEet20KGqe/HhyNiBarg6+PyXOSt1GU7gnM0LPBlKdHaRzOLY9lM1VlLyZvf/8//UHgLQZhuk64QNO8b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336485; c=relaxed/simple;
	bh=NVn9LwPDnlsQON3swgwliR2ZNWfHvu5p5Ixmos9M6tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AuH4UHDbpvnwqGhR6FS2tDXfdyMl8pU/JSVr3HGMgsUgKObwM9LLOU593twrPclweBUuNNYmcQ/WNbSZ8OMEZa2fqYWqSjxWZnPFCvTlXCzJ0vvi+sRzqbGjxJ4lYb/tMP/ESbmFai82uMMRlr27AksKObeSaRT7VU+r1gAzWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tgn1iM4o; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso7020145a91.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336483; x=1780941283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gUNOhawh414/8060FOqpH+YpRhOk1KgnFcLIhcQnxw=;
        b=tgn1iM4oJsKFAvOB3iNYxQhphmfcWEfQC8hxlrkbZzAa3qr3z7tsUATqZbGR+ChrDU
         vqXZO3n6XWvxjG1RjQUC1wM9tEEfrX6dJcU4HbzL2gtA6vGkqtiPomL/8dyFa74j9Nvd
         DXGunYOgJg5UuT2X0IoYzrdOSQbmPbcAWP7S1KWJTLqIPPIcXArU1AeqphUIf085X778
         5bBpy50Y0vSlfcfPsxwSYUpCNx/KPrq9GQubkfNoyLi2rDyrS8ttVMVjPX/mPPCyYANE
         4MiWKgY0e/jPJzwPclM5zPY7YXvF61/8cUVyxE6aQzsNjl8HvRlqeHHW4CVcKBfDgFwO
         ZUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336483; x=1780941283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gUNOhawh414/8060FOqpH+YpRhOk1KgnFcLIhcQnxw=;
        b=nunOIEd2IlI70yWGkSTH8dI0911N5k/MW61BhhVMLTAqrTVKaK+TrTEOT1bY4PUsrp
         JEhUn65cMdRJ/iMzXBsQTp3zXSgO4PrL7ynw2nRU0Ko6f+uWVUH0Ed6iIpOpu7YLk8jd
         xUNABcdmB3ti6NwlQUo4HWlNB6k5rxq3MekfvKNlksdnvWWsq1n2VZisYhWoXsIRm3T1
         Eal1PhcVANphzETRcUdflR8+mTS/J/Z5JF9uH4AI8W7RkJSwDC0vu/h5dU/dA3gFJEFU
         cjQkMOoE20A1kAqd6QBeKvGiq5GJmsgsZhC9p0fqAm3+TKabKIhe/MyFB4eaST1l1gKD
         igsw==
X-Gm-Message-State: AOJu0Yy2VuFQlhlTbWLoFyHNezSmhLi4PqeUO563drljW46e21hPfk/f
	PsU5vFgGUODivvhwCUK2bxWj6+qQUYd5sbaCq2N4A2Ep8Y0LIMjbOjVFJX7dmu+ngu3E22lBHzt
	hBD+B752Qa8xSvgTJ/7CcTBsCzv+EVHBNQXsaLUudv3pmufDcnANYOcMQagzgW4zlEB3ODvkvBJ
	ngU4Vz4swTBUs/7GalY3BmObCDeEZl0OnbgZWQyRMXhZ4prQBWxE6/J87g3zHehSo=
X-Received: from pllh10.prod.google.com ([2002:a17:902:748a:b0:2be:ff74:e5e5])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2389:b0:2b4:656b:aeb0 with SMTP id d9443c01a7336-2bf3685af15mr148148335ad.35.1780336482581;
 Mon, 01 Jun 2026 10:54:42 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:26 +0000
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-5-hramamurthy@google.com>
Subject: [PATCH net-next 04/15] gve: add a few helper functions to set device properties
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
	TAGGED_FROM(0.00)[bounces-293863-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: C2265623913
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For the mailbox ABI, device properties will come from a different
source compared to the AdminQ mode. To accommodate the new source
when the mailbox ABI is added, add a few helper functions to set a
few device properties. Those functions are:

- gve_set_queue_properties() to set no. of pages for QPL mode and
  number of queues in general
- gve_set_mtu()
- gve_set_mac()

This is just code movement, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 38 +++-------------
 drivers/net/ethernet/google/gve/gve_adminq.h |  6 +++
 drivers/net/ethernet/google/gve/gve_main.c   | 46 ++++++++++++++++++++
 3 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index c102f707e284..ac546a245ef3 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -945,19 +945,6 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 	return err;
 }
 
-static void gve_set_default_desc_cnt(struct gve_priv *priv,
-			const struct gve_device_descriptor *descriptor)
-{
-	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
-	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
-
-	/* set default ranges */
-	priv->max_tx_desc_cnt = priv->tx_desc_cnt;
-	priv->max_rx_desc_cnt = priv->rx_desc_cnt;
-	priv->min_tx_desc_cnt = priv->tx_desc_cnt;
-	priv->min_rx_desc_cnt = priv->rx_desc_cnt;
-}
-
 static void gve_set_default_rss_sizes(struct gve_priv *priv)
 {
 	if (!gve_is_gqi(priv)) {
@@ -1074,8 +1061,6 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	union gve_adminq_command cmd;
 	dma_addr_t descriptor_bus;
 	int err = 0;
-	u8 *mac;
-	u16 mtu;
 
 	memset(&cmd, 0, sizeof(cmd));
 	descriptor = dma_pool_alloc(priv->adminq_pool, GFP_KERNEL,
@@ -1137,26 +1122,17 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 			 "Driver is running with GQI QPL queue format.\n");
 	}
 
-	/* set default descriptor counts */
-	gve_set_default_desc_cnt(priv, descriptor);
-
 	gve_set_default_rss_sizes(priv);
 
-	priv->max_registered_pages =
-				be64_to_cpu(descriptor->max_registered_pages);
-	mtu = be16_to_cpu(descriptor->mtu);
-	if (mtu < ETH_MIN_MTU) {
-		dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", mtu);
-		err = -EINVAL;
+	err = gve_set_mtu(priv, descriptor);
+	if (err)
 		goto free_device_descriptor;
-	}
-	priv->dev->max_mtu = mtu;
+
 	priv->num_event_counters = be16_to_cpu(descriptor->counters);
-	eth_hw_addr_set(priv->dev, descriptor->mac);
-	mac = descriptor->mac;
-	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", mac);
-	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
-	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
+
+	gve_set_mac(priv, descriptor);
+
+	gve_set_queue_properties(priv, descriptor);
 
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_jumbo_frames, dev_op_dqo_qpl,
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 107c21b7b047..53ac1a28b26a 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -655,5 +655,11 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
+void gve_set_queue_properties(struct gve_priv *priv,
+			      struct gve_device_descriptor *descriptor);
+int gve_set_mtu(struct gve_priv *priv,
+		struct gve_device_descriptor *descriptor);
+void gve_set_mac(struct gve_priv *priv,
+		 struct gve_device_descriptor *descriptor);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index eb2d768e5881..338dc0b3249a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2400,6 +2400,52 @@ static void gve_set_num_queues(struct gve_priv *priv)
 		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
 }
 
+static void gve_set_default_desc_cnt(struct gve_priv *priv,
+				     const struct gve_device_descriptor *descriptor)
+{
+	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
+	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
+
+	/* set default ranges */
+	priv->max_tx_desc_cnt = priv->tx_desc_cnt;
+	priv->max_rx_desc_cnt = priv->rx_desc_cnt;
+	priv->min_tx_desc_cnt = priv->tx_desc_cnt;
+	priv->min_rx_desc_cnt = priv->rx_desc_cnt;
+}
+
+void gve_set_queue_properties(struct gve_priv *priv,
+			      struct gve_device_descriptor *descriptor)
+{
+	/* set default descriptor counts */
+	gve_set_default_desc_cnt(priv, descriptor);
+
+	priv->max_registered_pages = be64_to_cpu(descriptor->max_registered_pages);
+	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
+	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
+}
+
+int gve_set_mtu(struct gve_priv *priv,
+		struct gve_device_descriptor *descriptor)
+{
+	u16 mtu;
+
+	mtu = be16_to_cpu(descriptor->mtu);
+	if (mtu < ETH_MIN_MTU) {
+		dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", mtu);
+		return -EINVAL;
+	}
+	priv->dev->max_mtu = mtu;
+
+	return 0;
+}
+
+void gve_set_mac(struct gve_priv *priv,
+		 struct gve_device_descriptor *descriptor)
+{
+	eth_hw_addr_set(priv->dev, descriptor->mac);
+	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", descriptor->mac);
+}
+
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
 	int err;
-- 
2.54.0.669.g59709faab0-goog


