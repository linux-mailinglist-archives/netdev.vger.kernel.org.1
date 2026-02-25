Return-Path: <netdev+bounces-261057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE/LJEs+n2lPZgQAu9opvQ
	(envelope-from <netdev+bounces-261057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:24:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962B19C379
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FCA6303D3BF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF12F2F068C;
	Wed, 25 Feb 2026 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+9ujKPU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606C277026
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043834; cv=none; b=Dci8c6QvR905KqWWZisV0r5xx2PPBdKZ5IM282spVuWU2JP+3goCWssdIedSwIR2LOBcuHG0IFSVYGF07RpEVIOqWvDZ8Qdb967I3UMwqNsLPcBsilXWWtza2resNy2hinpkDZXLIyClSQTHniy6syjV1I9WJAGNCh0V9u8Ssng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043834; c=relaxed/simple;
	bh=yt2dMTDrfPSjf2UMxDcPYTQ0yUL1FGj7bmBZGEmpM3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hlvT+VXliC3MFlZKHxQvWgg245q6fS07AC5XW4TE6tapfkcRYM3o5YhySpPFI7gH941HwTm1L6hqVUxzXTYKit1KSxOGQW2BCuVuneq6cVk5zuUtbM33lL05dR5/hDmuCdYhQrtVL6h+iUT4013sL0Er6juVHcPSjGEXSU9MAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R+9ujKPU; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so13978a12.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772043832; x=1772648632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XU/NOnJzLPeKVquJfnxgMP0f7a7HOlu1DW9C4y3zO8k=;
        b=R+9ujKPUGtLXvu454DA6Bs0iOMnCwr2EoDFCSu0vsmah/0Sq/y7TC1/CTat22Z2gQG
         ZG1O8i3YZl4KHbLEtrtuKjPZ1/RirkJKA03/aJ17wBhIlER13BoXbctOF3P769bshwc4
         OiCGtU7UsYjVIK+hK4CTj+uwcapHqSfeZ7gl+9whgamKlQGM4KvkhAEPtMav/kym5AWp
         TxNPa+ZO399LBT3qjegTTvtPxsIyVdM5Z0gKKUnCvykrjf/DaQWHXsQjQLeAcMhGt3qe
         dXmsybc4cp3xu/MUXUDeNV7uWUm7ywk5TpceiaSQ0Zsx47K4vbMk5Dkz0g+7MjfjqBSs
         CroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772043832; x=1772648632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XU/NOnJzLPeKVquJfnxgMP0f7a7HOlu1DW9C4y3zO8k=;
        b=O3zybAvsjRFBQxGX3W6x0Ikcdj8M0l8543jSk5RyNPGKCboDjok76ZJa2DXEP2OknR
         1yyxCIJUbbe6IPqnn/zi2zZb3OPwprNruC99mfrUhKo7cfkuaJkA9e3T24RZ30ytqpkz
         2zMvLs4AYkN7oEpjveZe9aRg0LfNil40hOMonVOs9gf79NwBMVJoRqbaGjKiZBmsxrjZ
         BWnWb3srk3+HPXUZcGAyLY5uUtawRd3+VRaROzriLF/Q48pN0cceIBr7MSMYNkQ4M0+q
         LHmTKFg3ov9hbRgrx0EFBy9CvdBnboXFjXUjoAqZEArWbTf3ZTd+FfeF3lBQ/Gl8mD/9
         u+ZQ==
X-Gm-Message-State: AOJu0YxbJc0Wqc05WHfbFpYcQxIn7VdTM0579KudLbbBco9VlvwDopyH
	uQZqw8zJ/WIp0cK9MP7ECXggsdXg9OwAlkuOnonS61kDAAtZUv9TH/dXpAvKpM6QCLWeZaOEEZR
	Uw4+6TlqIV4SfNLPENHS46kiC2CA8bsNREhhhasE4XJtgfouucqkUUnUmsI3WYQbEFZ5iTAYeCG
	IQ0rSfr8QDZtFx6vnVzn7PMj9/8YPOiNy2X4PhssW4e16uiKo=
X-Received: from pgbdo10.prod.google.com ([2002:a05:6a02:e8a:b0:c6f:be98:d124])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da9:b0:371:8e6d:27f9 with SMTP id adf61e73a8af0-395b1e7fd41mr3081637.33.1772043831831;
 Wed, 25 Feb 2026 10:23:51 -0800 (PST)
Date: Wed, 25 Feb 2026 10:23:41 -0800
In-Reply-To: <20260225182342.1049816-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225182342.1049816-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225182342.1049816-2-joshwash@google.com>
Subject: [PATCH net-next v2 1/2] gve: Update QPL page registration logic
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	John Fraker <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Matt Olson <maolson@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bailey Forrest <bcf@google.com>, Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, 
	Max Yuan <maxyuan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261057-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.985];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2962B19C379
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
Changes in v2:
   - Fixed 32-bit compilation issue by using div64_u64 and div_u64 instead of
     division operators. (Paolo Abeni)

 drivers/net/ethernet/google/gve/gve.h                 | 18 ++++++--------
 drivers/net/ethernet/google/gve/gve_adminq.c          |  8 -------
 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c            | 41 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx.c              |  5 +---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c          |  6 ++---
 drivers/net/ethernet/google/gve/gve_tx.c              |  5 +---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c          |  4 +---
 8 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index cbdf3a84..1d66d383 100644
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
@@ -1308,6 +1301,9 @@ int gve_reset(struct gve_priv *priv, bool attempt_teardown);
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
index ee963c98..0334e0e7 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -11,6 +11,7 @@
 #include <linux/filter.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/sched.h>
@@ -967,6 +968,7 @@ static void gve_tx_get_curr_alloc_cfg(struct gve_priv *priv,
 	cfg->qcfg = &priv->tx_cfg;
 	cfg->raw_addressing = !gve_is_qpl(priv);
 	cfg->ring_size = priv->tx_desc_cnt;
+	cfg->pages_per_qpl = priv->tx_pages_per_qpl;
 	cfg->num_xdp_rings = cfg->qcfg->num_xdp_queues;
 	cfg->tx = priv->tx;
 }
@@ -998,12 +1000,48 @@ static void gve_tx_start_rings(struct gve_priv *priv, int num_rings)
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
+		tx_pages = div64_u64(max_pages * ideal_tx_pages,
+				     ideal_tx_pages + ideal_rx_pages);
+		tx_alloc_cfg->pages_per_qpl = div_u64(tx_pages, tx_num_queues);
+		rx_alloc_cfg->pages_per_qpl = div_u64(max_pages - tx_pages,
+						      rx_num_queues);
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
@@ -1294,6 +1332,7 @@ static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
 	cfg->raw_addressing = !gve_is_qpl(priv);
 	cfg->enable_header_split = priv->header_split_enabled;
 	cfg->ring_size = priv->rx_desc_cnt;
+	cfg->pages_per_qpl = priv->rx_pages_per_qpl;
 	cfg->packet_buffer_size = priv->rx_cfg.packet_buffer_size;
 	cfg->rx = priv->rx;
 	cfg->xdp = !!cfg->qcfg_tx->num_xdp_queues;
@@ -1373,6 +1412,8 @@ static int gve_queues_start(struct gve_priv *priv,
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
index ac44f50d..783bf3d8 100644
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
index 81d27a12..bd7fd330 100644
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
2.53.0.273.g2a3d683680-goog


