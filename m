Return-Path: <netdev+bounces-257683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AhnFeSShmm6OwQAu9opvQ
	(envelope-from <netdev+bounces-257683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:18:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D886B10470A
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 582DF304FC22
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 01:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF6248F54;
	Sat,  7 Feb 2026 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyqoAn2G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026221771C
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427067; cv=none; b=QEr95gQifeJo4sQRpC93rMwv05U7WPST8qni05hEt9FOyhZIbpEbygABVE5E6BVcRClF2RLUtsQqxwtZWtvgZNWJxARFv2f9Zq4PPd+m5xU25Fj2pueXrd6ApFxoXTjKeECs75pxPw48DVqsDpfF44A/mnKITUFZ1d76AI8RxX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427067; c=relaxed/simple;
	bh=ZdnKo3TDnUE7+e4LT7ZRuWiR+Si+H4SxQG5VDGPl698=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q8jsyKXuBPP4CYj8RroG/+tDAvrFHZjidgRWv4Ufs+mpGZ9UQCZkCh5MvQFIrAiB73Jtui2YG6l19xeYOoD5ADTTRA/7LZtEIj5IjfuvDnqdW3j3dL2pJ7+phiok5vFrQ9JZUA5245w/w24/Yql0EQQAxlQuAwJbGTmWfvXn88o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EyqoAn2G; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a76f2d7744so27859175ad.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 17:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770427067; x=1771031867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSgqvo1idulCNHTrl0X5VRnKePTqlJ79hIF3AfnZQNc=;
        b=EyqoAn2GVJdDYK16659JbZrYeR7GVYv9kBeVx4q3ZXul43TTjX9UL5biXalwcOOu9B
         0ZXEO2V4hgO/6Wk46zvK1v89+FD7iqz0iwz/8ERVNC/8A618Pu2X+8Kf9unDLf5vkIF0
         0nZ3Zqo2/LQqc1vfEiNsxqsZbxKWDZmKqOEqQg1xL204hvFfq472VsXBlgqa1YsvYrON
         Y+3UH8aTtW28SfP6IPq9a9ChT7L8gigIzSAvBouqHn7GLzwTXgY0GTdJMcjElKkOYGT6
         SKZvdYG6DqLqARiKWkh2FplW7vTMzY07ZnStouJpFAxoYhb/Lij0l61oksHlxF+yADs2
         HIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770427067; x=1771031867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSgqvo1idulCNHTrl0X5VRnKePTqlJ79hIF3AfnZQNc=;
        b=dA36p95o0GMPABNvEg4W+z+36qzxStFLOtJqj3EorDuOjY0xAVwCbtklhRif/mAE5r
         iNFH5Ow5KCcucvhOMSWGc2KgPs2590WVGMhYgs0xJDwTvyC1Y07zNOCBYDIdTUHhwYRi
         4WEpEr2FcB4bkGfmqP4GiW/n4JJ2exo+nEx4B8ZWW+kvSN/kFBSTlwb8tUw2gxNUY8QN
         h4l9fzhp594awfJxNV2UASs7if5M+FCXpUwzvrcykxyy7a+PHK37wpIbfULLkO7MuxFe
         ln0G0Vg3neGcqAgZOwZC+aTgZS38yErE0LETZD2YmHT0DRR2F0l2evj8nfTJrVCzTL2T
         pAjw==
X-Gm-Message-State: AOJu0YxV5DklMabhkECXYEnM2LASgzLqb1v7fiDDVVZyrlJ7koYt+USo
	SLXZ2dXqvCBVCCoqcJu2xAh/uP/anUFa355wmfuz6vyikQyruTmfUrk+Bki4/zk8JTbz78isWWo
	+y/WtGQ3pqdkZwzyMQxR5b1kTDrXIMOfNQmnIPR0cBLkyttX1kbvDGoFgOaJDvLz1gMUGfvhN1Z
	5bI7ogLu8ymDBCt92WIypaRp2RpHd1pzS38CcsKla1vYg+cEw=
X-Received: from pgbcz10.prod.google.com ([2002:a05:6a02:230a:b0:c6d:cb9f:2f95])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7353:b0:392:e5eb:f03 with SMTP id adf61e73a8af0-393ad39a7aamr4320448637.69.1770427066443;
 Fri, 06 Feb 2026 17:17:46 -0800 (PST)
Date: Fri,  6 Feb 2026 17:17:32 -0800
In-Reply-To: <20260207011734.437205-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207011734.437205-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207011734.437205-2-joshwash@google.com>
Subject: [PATCH net-next 1/2] gve: Update QPL page registration logic
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, John Fraker <jfraker@google.com>, 
	Matt Olson <maolson@google.com>, Bailey Forrest <bcf@google.com>, Tim Hostetler <thostet@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, linux-kernel@vger.kernel.org, 
	Max Yuan <maxyuan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D886B10470A
X-Rspamd-Action: no action

From: Matt Olson <maolson@google.com>

For DQO, change QPL page registration logic to be more flexible to honor
the "max_registered_pages" parameter from the gVNIC device.

Previously the number of RX pages per QPL was hardcoded to twice the
ring size, and the number of TX pages per QPL was dictated by the device
in the DQO-QPL device option. Now [in DQO-QPL mode], the driver will
ignore the "tx_pages_per_qpl" parameter indicated in the DQO-QPL device
option and instead allocate up to (tx_queue_length / 2) pages per TX QPL
and up to (rx_queue_length * 2) pages per RX QPL while keeping the total
number of pages under the "max_registered_pages".

Merge DQO and GQI QPL page calculation logic into a unified
gve_update_num_qpl_pages function. Add rx_pages_per_qpl to the priv
struct for consumption by both DQO and GQI.

Signed-off-by: Matt Olson <maolson@google.com>
Signed-off-by: Max Yuan <maxyuan@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h                 | 18 ++++++--------
 drivers/net/ethernet/google/gve/gve_adminq.c          |  8 -------
 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c            | 40 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx.c              |  5 +---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c          |  6 ++---
 drivers/net/ethernet/google/gve/gve_tx.c              |  5 +---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c          |  4 +---
 8 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 970d5ca8..adc91d6a 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -79,8 +79,6 @@
 
 #define GVE_DEFAULT_HEADER_BUFFER_SIZE 128
 
-#define DQO_QPL_DEFAULT_TX_PAGES 512
-
 /* Maximum TSO size supported on DQO */
 #define GVE_DQO_TX_MAX	0x3FFFF
 
@@ -711,6 +709,7 @@ struct gve_ptype_lut {
 /* Parameters for allocating resources for tx queues */
 struct gve_tx_alloc_rings_cfg {
 	struct gve_tx_queue_config *qcfg;
+	u16 pages_per_qpl;
 
 	u16 num_xdp_rings;
 
@@ -726,6 +725,7 @@ struct gve_rx_alloc_rings_cfg {
 	/* tx config is also needed to determine QPL ids */
 	struct gve_rx_queue_config *qcfg_rx;
 	struct gve_tx_queue_config *qcfg_tx;
+	u16 pages_per_qpl;
 
 	u16 ring_size;
 	u16 packet_buffer_size;
@@ -816,7 +816,8 @@ struct gve_priv {
 	u16 min_rx_desc_cnt;
 	bool modify_ring_size_enabled;
 	bool default_min_ring_size;
-	u16 tx_pages_per_qpl; /* Suggested number of pages per qpl for TX queues by NIC */
+	u16 tx_pages_per_qpl;
+	u16 rx_pages_per_qpl;
 	u64 max_registered_pages;
 	u64 num_registered_pages; /* num pages registered with NIC */
 	struct bpf_prog *xdp_prog; /* XDP BPF program */
@@ -1150,14 +1151,6 @@ static inline u32 gve_rx_start_qpl_id(const struct gve_tx_queue_config *tx_cfg)
 	return gve_get_rx_qpl_id(tx_cfg, 0);
 }
 
-static inline u32 gve_get_rx_pages_per_qpl_dqo(u32 rx_desc_cnt)
-{
-	/* For DQO, page count should be more than ring size for
-	 * out-of-order completions. Set it to two times of ring size.
-	 */
-	return 2 * rx_desc_cnt;
-}
-
 /* Returns the correct dma direction for tx and rx qpls */
 static inline enum dma_data_direction gve_qpl_dma_dir(struct gve_priv *priv,
 						      int id)
@@ -1303,6 +1296,9 @@ int gve_reset(struct gve_priv *priv, bool attempt_teardown);
 void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
 			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
+void gve_update_num_qpl_pages(struct gve_priv *priv,
+			      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg,
+			      struct gve_tx_alloc_rings_cfg *tx_alloc_cfg);
 int gve_adjust_config(struct gve_priv *priv,
 		      struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 		      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index f27b9501..b1983f97 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -970,14 +970,6 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 		priv->dev->max_mtu = be16_to_cpu(dev_op_jumbo_frames->max_mtu);
 	}
 
-	/* Override pages for qpl for DQO-QPL */
-	if (dev_op_dqo_qpl) {
-		priv->tx_pages_per_qpl =
-			be16_to_cpu(dev_op_dqo_qpl->tx_pages_per_qpl);
-		if (priv->tx_pages_per_qpl == 0)
-			priv->tx_pages_per_qpl = DQO_QPL_DEFAULT_TX_PAGES;
-	}
-
 	if (dev_op_buffer_sizes &&
 	    (supported_features_mask & GVE_SUP_BUFFER_SIZES_MASK)) {
 		priv->max_rx_buffer_size =
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 0e2b703c..6880d153 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -133,7 +133,7 @@ int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
 	u32 idx;
 
 	idx = rx->dqo.next_qpl_page_idx;
-	if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
+	if (idx >= priv->rx_pages_per_qpl) {
 		net_err_ratelimited("%s: Out of QPL pages\n",
 				    priv->dev->name);
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 4feaa481..7a26faeb 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -965,6 +965,7 @@ static void gve_tx_get_curr_alloc_cfg(struct gve_priv *priv,
 	cfg->qcfg = &priv->tx_cfg;
 	cfg->raw_addressing = !gve_is_qpl(priv);
 	cfg->ring_size = priv->tx_desc_cnt;
+	cfg->pages_per_qpl = priv->tx_pages_per_qpl;
 	cfg->num_xdp_rings = cfg->qcfg->num_xdp_queues;
 	cfg->tx = priv->tx;
 }
@@ -996,12 +997,48 @@ static void gve_tx_start_rings(struct gve_priv *priv, int num_rings)
 	}
 }
 
+void gve_update_num_qpl_pages(struct gve_priv *priv,
+			      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg,
+			      struct gve_tx_alloc_rings_cfg *tx_alloc_cfg)
+{
+	u64 ideal_tx_pages, ideal_rx_pages;
+	u16 tx_num_queues, rx_num_queues;
+	u64 max_pages, tx_pages;
+
+	if (priv->queue_format == GVE_GQI_QPL_FORMAT) {
+		rx_alloc_cfg->pages_per_qpl = rx_alloc_cfg->ring_size;
+	} else if (priv->queue_format == GVE_DQO_QPL_FORMAT) {
+		/*
+		 * We want 2 pages per RX descriptor and half a page per TX
+		 * descriptor, which means the fraction ideal_tx_pages /
+		 * (ideal_tx_pages + ideal_rx_pages) of the pages we allocate
+		 * should be for TX. Shrink proportionally as necessary to avoid
+		 * allocating more than max_registered_pages total pages.
+		 */
+		tx_num_queues = tx_alloc_cfg->qcfg->num_queues;
+		rx_num_queues = rx_alloc_cfg->qcfg_rx->num_queues;
+
+		ideal_tx_pages = tx_alloc_cfg->ring_size * tx_num_queues / 2;
+		ideal_rx_pages = rx_alloc_cfg->ring_size * rx_num_queues * 2;
+		max_pages = min(priv->max_registered_pages,
+				ideal_tx_pages + ideal_rx_pages);
+
+		tx_pages = (max_pages * ideal_tx_pages) /
+			   (ideal_tx_pages + ideal_rx_pages);
+		tx_alloc_cfg->pages_per_qpl = tx_pages / tx_num_queues;
+		rx_alloc_cfg->pages_per_qpl = (max_pages - tx_pages) /
+					      rx_num_queues;
+	}
+}
+
 static int gve_queues_mem_alloc(struct gve_priv *priv,
 				struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 				struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
 	int err;
 
+	gve_update_num_qpl_pages(priv, rx_alloc_cfg, tx_alloc_cfg);
+
 	if (gve_is_gqi(priv))
 		err = gve_tx_alloc_rings_gqi(priv, tx_alloc_cfg);
 	else
@@ -1292,6 +1329,7 @@ static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
 	cfg->raw_addressing = !gve_is_qpl(priv);
 	cfg->enable_header_split = priv->header_split_enabled;
 	cfg->ring_size = priv->rx_desc_cnt;
+	cfg->pages_per_qpl = priv->rx_pages_per_qpl;
 	cfg->packet_buffer_size = priv->rx_cfg.packet_buffer_size;
 	cfg->rx = priv->rx;
 	cfg->xdp = !!cfg->qcfg_tx->num_xdp_queues;
@@ -1371,6 +1409,8 @@ static int gve_queues_start(struct gve_priv *priv,
 	priv->rx_cfg = *rx_alloc_cfg->qcfg_rx;
 	priv->tx_desc_cnt = tx_alloc_cfg->ring_size;
 	priv->rx_desc_cnt = rx_alloc_cfg->ring_size;
+	priv->tx_pages_per_qpl = tx_alloc_cfg->pages_per_qpl;
+	priv->rx_pages_per_qpl = rx_alloc_cfg->pages_per_qpl;
 
 	gve_tx_start_rings(priv, gve_num_tx_queues(priv));
 	gve_rx_start_rings(priv, rx_alloc_cfg->qcfg_rx->num_queues);
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 9a37bd99..f466fe82 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -277,7 +277,6 @@ int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 	struct device *hdev = &priv->pdev->dev;
 	u32 slots = cfg->ring_size;
 	int filled_pages;
-	int qpl_page_cnt;
 	u32 qpl_id = 0;
 	size_t bytes;
 	int err;
@@ -313,10 +312,8 @@ int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 
 	if (!rx->data.raw_addressing) {
 		qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx->q_num);
-		qpl_page_cnt = cfg->ring_size;
-
 		rx->data.qpl = gve_alloc_queue_page_list(priv, qpl_id,
-							 qpl_page_cnt);
+							 cfg->pages_per_qpl);
 		if (!rx->data.qpl) {
 			err = -ENOMEM;
 			goto abort_with_copy_pool;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index d2f5c2d7..57c45c54 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -218,7 +218,6 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 {
 	struct device *hdev = &priv->pdev->dev;
 	struct page_pool *pool;
-	int qpl_page_cnt;
 	size_t size;
 	u32 qpl_id;
 
@@ -246,7 +245,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 	XSK_CHECK_PRIV_TYPE(struct gve_xdp_buff);
 
 	rx->dqo.num_buf_states = cfg->raw_addressing ? buffer_queue_slots :
-		gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
+		cfg->pages_per_qpl;
 	rx->dqo.buf_states = kvcalloc_node(rx->dqo.num_buf_states,
 					   sizeof(rx->dqo.buf_states[0]),
 					   GFP_KERNEL, priv->numa_node);
@@ -281,10 +280,9 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 		rx->dqo.page_pool = pool;
 	} else {
 		qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx->q_num);
-		qpl_page_cnt = gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
 
 		rx->dqo.qpl = gve_alloc_queue_page_list(priv, qpl_id,
-							qpl_page_cnt);
+							cfg->pages_per_qpl);
 		if (!rx->dqo.qpl)
 			goto err;
 		rx->dqo.next_qpl_page_idx = 0;
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 97efc8d2..65401a05 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -264,7 +264,6 @@ static int gve_tx_alloc_ring_gqi(struct gve_priv *priv,
 				 int idx)
 {
 	struct device *hdev = &priv->pdev->dev;
-	int qpl_page_cnt;
 	u32 qpl_id = 0;
 	size_t bytes;
 
@@ -291,10 +290,8 @@ static int gve_tx_alloc_ring_gqi(struct gve_priv *priv,
 	tx->dev = hdev;
 	if (!tx->raw_addressing) {
 		qpl_id = gve_tx_qpl_id(priv, tx->q_num);
-		qpl_page_cnt = priv->tx_pages_per_qpl;
-
 		tx->tx_fifo.qpl = gve_alloc_queue_page_list(priv, qpl_id,
-							    qpl_page_cnt);
+							    cfg->pages_per_qpl);
 		if (!tx->tx_fifo.qpl)
 			goto abort_with_desc;
 
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index a2b22004..57361406 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -302,7 +302,6 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 {
 	struct device *hdev = &priv->pdev->dev;
 	int num_pending_packets;
-	int qpl_page_cnt;
 	size_t bytes;
 	u32 qpl_id;
 	int i;
@@ -384,10 +383,9 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 
 	if (!cfg->raw_addressing) {
 		qpl_id = gve_tx_qpl_id(priv, tx->q_num);
-		qpl_page_cnt = priv->tx_pages_per_qpl;
 
 		tx->dqo.qpl = gve_alloc_queue_page_list(priv, qpl_id,
-							qpl_page_cnt);
+							cfg->pages_per_qpl);
 		if (!tx->dqo.qpl)
 			goto err;
 
-- 
2.53.0.239.g8d8fc8a987-goog


