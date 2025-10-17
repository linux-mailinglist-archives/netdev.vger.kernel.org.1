Return-Path: <netdev+bounces-230267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 973C5BE6085
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBFBF4E957D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F021D59C;
	Fri, 17 Oct 2025 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUFAXwOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45A21CFEF
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760664398; cv=none; b=CYSDenYQd+asuJnmWUtezfLt9qdCjVfIohkQT5CoDGoY3APs7XeP8oJvCGlzl9qEp5STyhzkC2JWGdcOdmakq4phOtXZFWG5NyQuT1WbaxWaUYmo8e0WrniZ7Zu4LxUBkFl1vr/GcjHVpyeVw0fbqGBKEAbH4dNj5Efr9Z1dOew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760664398; c=relaxed/simple;
	bh=L8goSy0mCfbNYD9NH8iLoywsSWGUd85reHgk72ACCb0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O2hPcZJNHyclz8BjdEqLiLqd8K3x1zRVRgmku7q8c4ZUCtcHoftZYKpzopTVKGLkf1yl9cibVfmqwT+Weh0WAT7IPO69ny4fT5IPAFYNQLAV2YH2kkQJYFJOs0CqQ/RPFki7pYmJ2lhd9efHc00jGB1cWbcBRi2xr8KgIoDWZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUFAXwOb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so1683390b3a.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760664395; x=1761269195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+j1Q9uHuP/v3a0srhPD8Cb5JpHL5lf27N6y4qanBqGY=;
        b=zUFAXwOb+m6LeeR8XHIZ0wXkqRwEW8953AtrQbWsvy5S8JXal04KDxCtj12PuvVGAN
         20vwdzGr7NCBOOqXkNVy1WjgY7DrMwVJjROHSSTY3+08mtMUVqcX1OfTjeSYKPdqPRTN
         nQfGVAfA/XqVvrl7BYF1GrRuMYFxxJjrkjk2RhaP+sQa6n9MH30u995fBnxVaOcRzECr
         Kun7hFDG63B3YuYgMZ8sAL/5m4vm7Qe+M/MqX7utS4kv+rPILh6IUoklIcmr7jE4TLcp
         w48PQVcbF5e71MFd875JngbvI74ux9NnsSqfaPPYKN8yOPWRj3owOfwRhekwqXN+XJV1
         r0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760664395; x=1761269195;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+j1Q9uHuP/v3a0srhPD8Cb5JpHL5lf27N6y4qanBqGY=;
        b=V7qDsfGRLK/nfMF0zEFxhaoUZEcE6NIF61QJXm/l0FN6LJeZMHxYZ7tQZSVcem90ng
         TR2H1cH2tO/AP3jy8o81I8nMANAVEwKZ5B60KLADMZdljokR8gzz48SJP21JGsHPzg+U
         9yZl4pA5NDlmJsxf/Zxg12YVbnadD/xz5TjRPB6R6x80Uwf3Hsay6jquHb8YKwcQfw7I
         VPjEnhuExFO4G4Hc5BHkUyuNX6XiJJkI1jDXoGf6xWBZBTr/vufytAJwlDktK1cGGsMS
         I4mAQmkydXeCk+PtyRW67WDKMGYV3lIrDdpZmuJjjeApeKVo/E9GnWwc1FBYdp8N7inl
         bndg==
X-Gm-Message-State: AOJu0YxL8SkoI4fSRo7KfxqS9gYMyB2LffGvOwEQC+HhCBaqePyrjUa4
	iIQ32W664LqPy6Fja5QGqFnjQHXWGqubmv042ML1aq5zZcjidMb1eHpVT5BYHnrHFDJg1SW1wbj
	TRxR0p24KBtANKLFjQQbOqAkiRktCuksJ8TLuWVFj1pxcz27hhpRH2VmYobcS24JRNqO2MtuTwO
	Y7713kh6n6OXATIlDh7w18n6OkMRxBvQYuA56WeylBuEOY8dU=
X-Google-Smtp-Source: AGHT+IF9WKhakeHmEI55UHHxr4qLhlFzl6C0HLU83cEAqNCYxeOqqWtaEkS+pQ4DOXaLCFMH7w0wH1iIPJjZIA==
X-Received: from pfgt20.prod.google.com ([2002:a05:6a00:1394:b0:792:f698:fda2])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1410:b0:77f:2b7d:edf1 with SMTP id d2e1a72fcca58-7a220a98d14mr2299469b3a.16.1760664395281;
 Thu, 16 Oct 2025 18:26:35 -0700 (PDT)
Date: Thu, 16 Oct 2025 18:25:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017012614.3631351-1-joshwash@google.com>
Subject: [PATCH net-next] gve: Consolidate and persist ethtool ring changes
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Ankit Garg <nktgrg@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Refactor the ethtool ring parameter configuration logic to address two
issues: unnecessary queue resets and lost configuration changes when
the interface is down.

Previously, `gve_set_ringparam` could trigger multiple queue
destructions and recreations for a single command, as different settings
(e.g., header split, ring sizes) were applied one by one. Furthermore,
if the interface was down, any changes made via ethtool were discarded
instead of being saved for the next time the interface was brought up.

This patch centralizes the configuration logic. Individual functions
like `gve_set_hsplit_config` are modified to only validate and stage
changes in a temporary config struct.

The main `gve_set_ringparam` function now gathers all staged changes
and applies them as a single, combined configuration:
1.  If the interface is up, it calls `gve_adjust_config` once.
2.  If the interface is down, it saves the settings directly to the
    driver's private struct, ensuring they persist and are used when
    the interface is brought back up.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  3 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c | 86 +++++++++----------
 drivers/net/ethernet/google/gve/gve_main.c    | 17 ++--
 3 files changed, 51 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index bceaf9b05cb4..ac325ab0f5c0 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1249,7 +1249,8 @@ void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx);
 void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx);
 u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hplit);
 bool gve_header_split_supported(const struct gve_priv *priv);
-int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split);
+int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
+			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 /* rx buffer handling */
 int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs);
 void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index d0a223250845..b030a84b678c 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -537,34 +537,6 @@ static void gve_get_ringparam(struct net_device *netdev,
 		kernel_cmd->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
 }
 
-static int gve_adjust_ring_sizes(struct gve_priv *priv,
-				 u16 new_tx_desc_cnt,
-				 u16 new_rx_desc_cnt)
-{
-	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
-	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
-	int err;
-
-	/* get current queue configuration */
-	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-
-	/* copy over the new ring_size from ethtool */
-	tx_alloc_cfg.ring_size = new_tx_desc_cnt;
-	rx_alloc_cfg.ring_size = new_rx_desc_cnt;
-
-	if (netif_running(priv->dev)) {
-		err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-		if (err)
-			return err;
-	}
-
-	/* Set new ring_size for the next up */
-	priv->tx_desc_cnt = new_tx_desc_cnt;
-	priv->rx_desc_cnt = new_rx_desc_cnt;
-
-	return 0;
-}
-
 static int gve_validate_req_ring_size(struct gve_priv *priv, u16 new_tx_desc_cnt,
 				      u16 new_rx_desc_cnt)
 {
@@ -584,34 +556,62 @@ static int gve_validate_req_ring_size(struct gve_priv *priv, u16 new_tx_desc_cnt
 	return 0;
 }
 
+static int gve_set_ring_sizes_config(struct gve_priv *priv, u16 new_tx_desc_cnt,
+				     u16 new_rx_desc_cnt,
+				     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
+				     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+{
+	if (new_tx_desc_cnt == priv->tx_desc_cnt &&
+	    new_rx_desc_cnt == priv->rx_desc_cnt)
+		return 0;
+
+	if (!priv->modify_ring_size_enabled) {
+		dev_err(&priv->pdev->dev, "Modify ring size is not supported.\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (gve_validate_req_ring_size(priv, new_tx_desc_cnt, new_rx_desc_cnt))
+		return -EINVAL;
+
+	tx_alloc_cfg->ring_size = new_tx_desc_cnt;
+	rx_alloc_cfg->ring_size = new_rx_desc_cnt;
+	return 0;
+}
+
 static int gve_set_ringparam(struct net_device *netdev,
 			     struct ethtool_ringparam *cmd,
 			     struct kernel_ethtool_ringparam *kernel_cmd,
 			     struct netlink_ext_ack *extack)
 {
+	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
+	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
 	struct gve_priv *priv = netdev_priv(netdev);
-	u16 new_tx_cnt, new_rx_cnt;
 	int err;
 
-	err = gve_set_hsplit_config(priv, kernel_cmd->tcp_data_split);
+	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+	err = gve_set_hsplit_config(priv, kernel_cmd->tcp_data_split,
+				    &rx_alloc_cfg);
 	if (err)
 		return err;
 
-	if (cmd->tx_pending == priv->tx_desc_cnt && cmd->rx_pending == priv->rx_desc_cnt)
-		return 0;
+	err = gve_set_ring_sizes_config(priv, cmd->tx_pending, cmd->rx_pending,
+					&tx_alloc_cfg, &rx_alloc_cfg);
+	if (err)
+		return err;
 
-	if (!priv->modify_ring_size_enabled) {
-		dev_err(&priv->pdev->dev, "Modify ring size is not supported.\n");
-		return -EOPNOTSUPP;
+	if (netif_running(priv->dev)) {
+		err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+		if (err)
+			return err;
+	} else {
+		/* Set ring params for the next up */
+		priv->header_split_enabled = rx_alloc_cfg.enable_header_split;
+		priv->rx_cfg.packet_buffer_size =
+			rx_alloc_cfg.packet_buffer_size;
+		priv->tx_desc_cnt = tx_alloc_cfg.ring_size;
+		priv->rx_desc_cnt = rx_alloc_cfg.ring_size;
 	}
-
-	new_tx_cnt = cmd->tx_pending;
-	new_rx_cnt = cmd->rx_pending;
-
-	if (gve_validate_req_ring_size(priv, new_tx_cnt, new_rx_cnt))
-		return -EINVAL;
-
-	return gve_adjust_ring_sizes(priv, new_tx_cnt, new_rx_cnt);
+	return 0;
 }
 
 static int gve_user_reset(struct net_device *netdev, u32 *flags)
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 1be1b1ef31ee..29845e8f3c0d 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2058,12 +2058,10 @@ bool gve_header_split_supported(const struct gve_priv *priv)
 		priv->queue_format == GVE_DQO_RDA_FORMAT && !priv->xdp_prog;
 }
 
-int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split)
+int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
+			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
-	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
-	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
 	bool enable_hdr_split;
-	int err = 0;
 
 	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
 		return 0;
@@ -2081,14 +2079,11 @@ int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split)
 	if (enable_hdr_split == priv->header_split_enabled)
 		return 0;
 
-	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-
-	rx_alloc_cfg.enable_header_split = enable_hdr_split;
-	rx_alloc_cfg.packet_buffer_size = gve_get_pkt_buf_size(priv, enable_hdr_split);
+	rx_alloc_cfg->enable_header_split = enable_hdr_split;
+	rx_alloc_cfg->packet_buffer_size =
+		gve_get_pkt_buf_size(priv, enable_hdr_split);
 
-	if (netif_running(priv->dev))
-		err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-	return err;
+	return 0;
 }
 
 static int gve_set_features(struct net_device *netdev,
-- 
2.51.0.858.gf9c4a03a3a-goog


