Return-Path: <netdev+bounces-83827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F508947EA
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 01:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A7EB2201F
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 23:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB335FB8A;
	Mon,  1 Apr 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgmK2iv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354C5DF0D
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015144; cv=none; b=OS9b9REPCbqmF9QJTwgzQaUHq0dJJ9grBu+Ag8SDF2/WlNtkQv+9LZKJ99kOXWqzneNtxhswphMaASfU+7+zSZsUpheJCyy/7zWxZZV7r/HMMI0IoQgZr7jxQlNgDLyBWwlZ+zKya/7o0Vapi+bsXs6EOwYK30ZqZdh970VKPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015144; c=relaxed/simple;
	bh=zmdb2RykTKxgOnYxe1piDwaiGtsm1mvy4+l4CT85SUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F0UTIDsKxzaRwz1glHOBrsDZM43XReKQABNCBvHeju3oDzhIpwzeteMjtyzlKUM7aoa6kZOw00zNallpoJykqdeGZKZayB1ZZNUaLGbbHE0Dn0N8alalC9Ng8GkAlk4olOFC3UCr/iUNRFmhWsTfpcLvgY21VlYON9n6iLagTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JgmK2iv1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dc4ffda13fso4200261a12.0
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 16:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015142; x=1712619942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SL4gSpw35iFPDr0r8I57ZBW33p2oC8+GNJ3croWhHJo=;
        b=JgmK2iv1BsWi1+J6CF0+sjsAkb9ri5i57gPWb6KU58cW8RRW9xeAuIVmMxVRB2rCPT
         x/M19NJMdLmEHF7XW59j3VOxmHFLvv4nsZdAn3XEYxfZ9XFtSHJh7za+7+yi0LI1aeEP
         t4o6Z5dJJkh8ShLmwM+zYROAfeJATIgvgMwqp9//O9xWIdK/8PK1DcIJHf2tiIr9xdjH
         ZNXl7bsQKkKGuFOh++RmOMmCe9l9d38bstWZ000DYKagpbhBmFyjuGAfakw7MRzcRnF8
         iE7PPBG9WkGYUB9DziqzgU+rbOxbHcCa6DZOHhT2bQ8K9zCif6aaMrA0ID8NKRy8my7k
         zUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015142; x=1712619942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SL4gSpw35iFPDr0r8I57ZBW33p2oC8+GNJ3croWhHJo=;
        b=wJbyhB3QGICtRSY1bLHLY/gDuIcfYn92Qpx76MR499G+9he4yG3UJTzv86Of++Q2sT
         O89FzeTyJNQbxwTs9Aei1G6qCysePdvzbLwOXa3JfArgPhaY+3/DBshKjXk/RI3G9p3C
         SWqByaX/bxKjclRgAlx5OuwzFu/EuxR4BU8GhDMwAYwsGKjOk1LHoj+/Z4sJiICokuN/
         hcMghj8HSZn4EzBBqDB+vD5IVzEf49ceX/aKU5n8U7cuDFJLehXHjtrYnb9qNoDymSOJ
         D/TGdJfkSB6i2X0P0WkIU6YSVyHgihZNiiAtiKdKN4JBBNtUpx1OcHsoasNLm4NdYI6l
         d9Ew==
X-Gm-Message-State: AOJu0YxFrSmzj6rN/3S8Qxs15y+oBGAKGGhYAaDrK7l2N4Eo0kccuBvI
	ZDV1PSWnGDYYGp7pisKrWtFBI203LBTxoeAW4jk4J1HQjZIQpQHkLEFdvqdZm0VjhlqRTbxaGRa
	0wEYwNG160BODNYxpsGMBp7MhOqgeGtt3Nwvu6ADFi7XpOpLGa40dLDxjP9K1VCUjuBupP4iffK
	QsRsNRQMehUVtuaPt7Mx+jaMPMdjKpQN5WmCy4/G1ug82V2JeXKbEVjrdo8XM=
X-Google-Smtp-Source: AGHT+IEVImByN++D88oacBX+RxQuh83VMx/H5Xh8Wa6G1kf6Ysz7vUklVGBi0ciEnIoEuO4k9iWTvBB2xKDji1NemA==
X-Received: from hramamurthy-gve.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:141e])
 (user=hramamurthy job=sendgmr) by 2002:a17:903:2305:b0:1e2:57b:9d8c with SMTP
 id d5-20020a170903230500b001e2057b9d8cmr649790plh.4.1712015140212; Mon, 01
 Apr 2024 16:45:40 -0700 (PDT)
Date: Mon,  1 Apr 2024 23:45:28 +0000
In-Reply-To: <20240401234530.3101900-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401234530.3101900-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234530.3101900-4-hramamurthy@google.com>
Subject: [PATCH net-next 3/5] gve: set page count for RX QPL for GQI and DQO
 queue formats
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

Fulfill the requirement that for GQI, the number of pages per
RX QPL is equal to the ring size. Set this value to be equal to
ring size. Because of this change, the rx_data_slot_cnt and
rx_pages_per_qpl fields stored in the priv structure are not
needed, so remove their usage. And for DQO, the number of pages
per RX QPL is more than ring size to account for out-of-order
completions. So set it to two times of rx ring size.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 11 ++++++++---
 drivers/net/ethernet/google/gve/gve_adminq.c | 11 -----------
 drivers/net/ethernet/google/gve/gve_main.c   | 14 +++++++++-----
 drivers/net/ethernet/google/gve/gve_rx.c     |  2 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |  4 ++--
 5 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index f009f7b3e68b..693d4b7d818b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -63,7 +63,6 @@
 #define GVE_DEFAULT_HEADER_BUFFER_SIZE 128
 
 #define DQO_QPL_DEFAULT_TX_PAGES 512
-#define DQO_QPL_DEFAULT_RX_PAGES 2048
 
 /* Maximum TSO size supported on DQO */
 #define GVE_DQO_TX_MAX	0x3FFFF
@@ -714,8 +713,6 @@ struct gve_priv {
 	u16 tx_desc_cnt; /* num desc per ring */
 	u16 rx_desc_cnt; /* num desc per ring */
 	u16 tx_pages_per_qpl; /* Suggested number of pages per qpl for TX queues by NIC */
-	u16 rx_pages_per_qpl; /* Suggested number of pages per qpl for RX queues by NIC */
-	u16 rx_data_slot_cnt; /* rx buffer length */
 	u64 max_registered_pages;
 	u64 num_registered_pages; /* num pages registered with NIC */
 	struct bpf_prog *xdp_prog; /* XDP BPF program */
@@ -1038,6 +1035,14 @@ static inline u32 gve_rx_start_qpl_id(const struct gve_queue_config *tx_cfg)
 	return gve_get_rx_qpl_id(tx_cfg, 0);
 }
 
+static inline u32 gve_get_rx_pages_per_qpl_dqo(u32 rx_desc_cnt)
+{
+	/* For DQO, page count should be more than ring size for
+	 * out-of-order completions. Set it to two times of ring size.
+	 */
+	return 2 * rx_desc_cnt;
+}
+
 /* Returns a pointer to the next available tx qpl in the list of qpls */
 static inline
 struct gve_queue_page_list *gve_assign_tx_qpl(struct gve_tx_alloc_rings_cfg *cfg,
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 2ff9327ec056..faeff20cd370 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -764,12 +764,8 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 	if (dev_op_dqo_qpl) {
 		priv->tx_pages_per_qpl =
 			be16_to_cpu(dev_op_dqo_qpl->tx_pages_per_qpl);
-		priv->rx_pages_per_qpl =
-			be16_to_cpu(dev_op_dqo_qpl->rx_pages_per_qpl);
 		if (priv->tx_pages_per_qpl == 0)
 			priv->tx_pages_per_qpl = DQO_QPL_DEFAULT_TX_PAGES;
-		if (priv->rx_pages_per_qpl == 0)
-			priv->rx_pages_per_qpl = DQO_QPL_DEFAULT_RX_PAGES;
 	}
 
 	if (dev_op_buffer_sizes &&
@@ -878,13 +874,6 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	mac = descriptor->mac;
 	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", mac);
 	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
-	priv->rx_data_slot_cnt = be16_to_cpu(descriptor->rx_pages_per_qpl);
-
-	if (gve_is_gqi(priv) && priv->rx_data_slot_cnt < priv->rx_desc_cnt) {
-		dev_err(&priv->pdev->dev, "rx_data_slot_cnt cannot be smaller than rx_desc_cnt, setting rx_desc_cnt down to %d.\n",
-			priv->rx_data_slot_cnt);
-		priv->rx_desc_cnt = priv->rx_data_slot_cnt;
-	}
 	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
 
 	gve_enable_supported_features(priv, supported_features_mask,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 166bd827a6d7..470447c0490f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1103,13 +1103,13 @@ static int gve_alloc_n_qpls(struct gve_priv *priv,
 	return err;
 }
 
-static int gve_alloc_qpls(struct gve_priv *priv,
-			  struct gve_qpls_alloc_cfg *cfg)
+static int gve_alloc_qpls(struct gve_priv *priv, struct gve_qpls_alloc_cfg *cfg,
+			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
 	int max_queues = cfg->tx_cfg->max_queues + cfg->rx_cfg->max_queues;
 	int rx_start_id, tx_num_qpls, rx_num_qpls;
 	struct gve_queue_page_list *qpls;
-	int page_count;
+	u32 page_count;
 	int err;
 
 	if (cfg->raw_addressing)
@@ -1141,8 +1141,12 @@ static int gve_alloc_qpls(struct gve_priv *priv,
 	/* For GQI_QPL number of pages allocated have 1:1 relationship with
 	 * number of descriptors. For DQO, number of pages required are
 	 * more than descriptors (because of out of order completions).
+	 * Set it to twice the number of descriptors.
 	 */
-	page_count = cfg->is_gqi ? priv->rx_data_slot_cnt : priv->rx_pages_per_qpl;
+	if (cfg->is_gqi)
+		page_count = rx_alloc_cfg->ring_size;
+	else
+		page_count = gve_get_rx_pages_per_qpl_dqo(rx_alloc_cfg->ring_size);
 	rx_num_qpls = gve_num_rx_qpls(cfg->rx_cfg, gve_is_qpl(priv));
 	err = gve_alloc_n_qpls(priv, qpls, page_count, rx_start_id, rx_num_qpls);
 	if (err)
@@ -1363,7 +1367,7 @@ static int gve_queues_mem_alloc(struct gve_priv *priv,
 {
 	int err;
 
-	err = gve_alloc_qpls(priv, qpls_alloc_cfg);
+	err = gve_alloc_qpls(priv, qpls_alloc_cfg, rx_alloc_cfg);
 	if (err) {
 		netif_err(priv, drv, priv->dev, "Failed to alloc QPLs\n");
 		return err;
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 20f5a9e7fae9..cd727e55ae0f 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -240,7 +240,7 @@ static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 				 int idx)
 {
 	struct device *hdev = &priv->pdev->dev;
-	u32 slots = priv->rx_data_slot_cnt;
+	u32 slots = cfg->ring_size;
 	int filled_pages;
 	size_t bytes;
 	int err;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7c2ab1edfcb2..15108407b54f 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -178,7 +178,7 @@ static int gve_alloc_page_dqo(struct gve_rx_ring *rx,
 			return err;
 	} else {
 		idx = rx->dqo.next_qpl_page_idx;
-		if (idx >= priv->rx_pages_per_qpl) {
+		if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
 			net_err_ratelimited("%s: Out of QPL pages\n",
 					    priv->dev->name);
 			return -ENOMEM;
@@ -321,7 +321,7 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 
 	rx->dqo.num_buf_states = cfg->raw_addressing ?
 		min_t(s16, S16_MAX, buffer_queue_slots * 4) :
-		priv->rx_pages_per_qpl;
+		gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
 	rx->dqo.buf_states = kvcalloc(rx->dqo.num_buf_states,
 				      sizeof(rx->dqo.buf_states[0]),
 				      GFP_KERNEL);
-- 
2.44.0.478.gd926399ef9-goog


