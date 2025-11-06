Return-Path: <netdev+bounces-236496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BBFC3D3E0
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 20:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494381890571
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 19:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7703A3563C2;
	Thu,  6 Nov 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OirgqZAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250735581B
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457300; cv=none; b=hJ+PVrabMzxcx2b+icY0TqtdICyTOFAA8wiphNmoP8mCubtB6+Kx2IUP1yv+7kc7kcKveHyM7qjDf7D9eiHaLgFYFT4Pd+3G6QzjULhMyocjEJR/0a0cTP7E+ZOppbwYpVenv0oB6z4NYz/yWxkDNSSkwYnTbE3WMFY+4dObCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457300; c=relaxed/simple;
	bh=Xb4EfJdY6bPJY5RRiIfdF/NTZ7iibhgTGr5o3oPF3g4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aeQLfULt5oJo6BO59pyuelCajd9VkxI/Hv9srPyrKvxZiEAXOBgiP+GHxFUH+PLTXJs6213SdETD4CDv5Hu6iNgTXSWcUONC3PaK7JGwxiB9kbe3/fnO8r3B6KQwRESWOUQ6+471tAq+BOD0vhZbcr3vYE33xXwv7RX3trJKdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OirgqZAo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b9d73d57328so1020134a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762457298; x=1763062098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JM9jdZzTWd6aLiHrXhH8eGJ9TVRerOe4nqWwRUMVsg=;
        b=OirgqZAoPeXmTh1UIlGYPgw33Vbymg/df10p5MI2CAdxBLXahqHsJtDrm9waIoPMul
         /M9Nf75JSDe5uBEpeKOtKgsenrZe86Q6xxSEafKH7hmudg3MRBrOEC6fK8bfFItN+ytC
         CDWbRCHo/FXZ4MG8XR2VMNXiFUAn7Qay0IRKj0VGzX4hLLFm7oKyPCHkA8HCGQSKbCUx
         2EWkI1DWOvvKhj1rq9nFJat/MmQCmKU8Lmak5re+b5ZoGWlgvPPZSSR1XZvEBs/iP0Ug
         pZkEzjsus1sO2og9MhKRdogndYbsoPtcSJ07CXhYMYE1oIKXL1aNuXUrr9ptpzse+sNq
         3v6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457298; x=1763062098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JM9jdZzTWd6aLiHrXhH8eGJ9TVRerOe4nqWwRUMVsg=;
        b=lUcq57Ji0HjZuFwCuz4fLZ4BatZ9DtRWoFF5Hq1piKcvAJdET1s2SnMliNFodh+Vy0
         ONeNjc60xP2bnNAQs8Qd9ZD/YrkBkSug2KIPZj4jtd3e+b/WPtUkPFfKh/PKd30gvwM+
         R4Ytu/h3aYW8/HNCfRMcYHr1JDZ3A5Ne4wwThE4rHZ7AWW9vcJpT9fvBWfVmfAAi5IZL
         aAgSl/kixtWsiUdYdq+pbNvTCKXmwaEGDrJVKVzOAe9QpfC/RkONkHkzVC3wkVnB5iWu
         xofxExJ64dUbwcUR7/vKC8IB+ZgUD1R1Enz0zY4CoBgc+fOdQ313AISt2XHWcnRX43To
         ja2A==
X-Gm-Message-State: AOJu0Yz9Zs1UHfd0XDU4qTik4+aweTyO+SrjVPkofqmTr4OAmTqElIW7
	NGCrAY42EhVM4Lpvn4xvU2oGDFUNkCufvdmTrLnD72zIyxwByV05uO8FfFXlUKhKi/6e4poAMvz
	NSjib2efRPV8pBUTkuxIEJ7WzDp5STBzoZloE95jTFODQmnh7nk0o2imRwDrGbPJ5WO2VwADIE+
	ACYKx+jZjhpGkv7+7eEz2/L1KMuZnHOB3IIPwOyXwBrwFJmXY=
X-Google-Smtp-Source: AGHT+IHGM7JVCPtaPwEFgfbgQR8t2tAo11fskdg8fmXe8PTIoLmsll2rbUTNi7cuelWzWi1tOatyEbKa4QTqwQ==
X-Received: from pjty1.prod.google.com ([2002:a17:90a:ca81:b0:33b:51fe:1a89])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3885:b0:340:bb64:c5e with SMTP id 98e67ed59e1d1-3434c4fa855mr370694a91.14.1762457297556;
 Thu, 06 Nov 2025 11:28:17 -0800 (PST)
Date: Thu,  6 Nov 2025 11:27:45 -0800
In-Reply-To: <20251106192746.243525-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106192746.243525-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106192746.243525-4-joshwash@google.com>
Subject: [PATCH net-next v3 3/4] gve: Allow ethtool to configure rx_buf_len
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit Garg <nktgrg@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Add support for getting and setting the RX buffer length via the
ethtool ring parameters (`ethtool -g`/`-G`). The driver restricts the
allowed buffer length to 2048 (SZ_2K) by default and allows 4096 (SZ_4K)
based on device options.

As XDP is only supported when the `rx_buf_len` is 2048, the driver now
enforces this in two places:
1.  In `gve_xdp_set`, rejecting XDP programs if the current buffer
    length is not 2048.
2.  In `gve_set_rx_buf_len_config`, rejecting buffer length changes if XDP
    is loaded and the new length is not 2048.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v3:
* Removed newline from extack messages (Jakub Kicinski)

Changes in v2:
* Refactored RX buffer length validation to clarify that it handles
  scenario when device doesn't advertise 4K support (Jakub Kicinski)
---
 drivers/net/ethernet/google/gve/gve.h         |  9 +++++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 13 ++++++++++++-
 drivers/net/ethernet/google/gve/gve_main.c    | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 872dae6..bebd1ac 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1165,6 +1165,12 @@ static inline bool gve_is_gqi(struct gve_priv *priv)
 		priv->queue_format == GVE_GQI_QPL_FORMAT;
 }
 
+static inline bool gve_is_dqo(struct gve_priv *priv)
+{
+	return priv->queue_format == GVE_DQO_RDA_FORMAT ||
+	       priv->queue_format == GVE_DQO_QPL_FORMAT;
+}
+
 static inline u32 gve_num_tx_queues(struct gve_priv *priv)
 {
 	return priv->tx_cfg.num_queues + priv->tx_cfg.num_xdp_queues;
@@ -1246,6 +1252,9 @@ void gve_rx_free_rings_gqi(struct gve_priv *priv,
 void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx);
 void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx);
 bool gve_header_split_supported(const struct gve_priv *priv);
+int gve_set_rx_buf_len_config(struct gve_priv *priv, u32 rx_buf_len,
+			      struct netlink_ext_ack *extack,
+			      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
 			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 /* rx buffer handling */
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index db6fc85..52500ae 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -529,6 +529,8 @@ static void gve_get_ringparam(struct net_device *netdev,
 	cmd->rx_pending = priv->rx_desc_cnt;
 	cmd->tx_pending = priv->tx_desc_cnt;
 
+	kernel_cmd->rx_buf_len = priv->rx_cfg.packet_buffer_size;
+
 	if (!gve_header_split_supported(priv))
 		kernel_cmd->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
 	else if (priv->header_split_enabled)
@@ -589,6 +591,12 @@ static int gve_set_ringparam(struct net_device *netdev,
 	int err;
 
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+
+	err = gve_set_rx_buf_len_config(priv, kernel_cmd->rx_buf_len, extack,
+					&rx_alloc_cfg);
+	if (err)
+		return err;
+
 	err = gve_set_hsplit_config(priv, kernel_cmd->tcp_data_split,
 				    &rx_alloc_cfg);
 	if (err)
@@ -605,6 +613,8 @@ static int gve_set_ringparam(struct net_device *netdev,
 			return err;
 	} else {
 		/* Set ring params for the next up */
+		priv->rx_cfg.packet_buffer_size =
+			rx_alloc_cfg.packet_buffer_size;
 		priv->header_split_enabled = rx_alloc_cfg.enable_header_split;
 		priv->tx_desc_cnt = tx_alloc_cfg.ring_size;
 		priv->rx_desc_cnt = rx_alloc_cfg.ring_size;
@@ -944,7 +954,8 @@ static int gve_get_ts_info(struct net_device *netdev,
 
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
-	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+				 ETHTOOL_RING_USE_RX_BUF_LEN,
 	.get_drvinfo = gve_get_drvinfo,
 	.get_strings = gve_get_strings,
 	.get_sset_count = gve_get_sset_count,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index c1d9916..2a24b3a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1725,6 +1725,13 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
+	if (priv->rx_cfg.packet_buffer_size != SZ_2K) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "XDP is not supported for Rx buf len %d, only %d supported.",
+				       priv->rx_cfg.packet_buffer_size, SZ_2K);
+		return -EOPNOTSUPP;
+	}
+
 	max_xdp_mtu = priv->rx_cfg.packet_buffer_size - sizeof(struct ethhdr);
 	if (priv->queue_format == GVE_GQI_QPL_FORMAT)
 		max_xdp_mtu -= GVE_RX_PAD;
@@ -2056,6 +2063,38 @@ bool gve_header_split_supported(const struct gve_priv *priv)
 		priv->queue_format == GVE_DQO_RDA_FORMAT && !priv->xdp_prog;
 }
 
+int gve_set_rx_buf_len_config(struct gve_priv *priv, u32 rx_buf_len,
+			      struct netlink_ext_ack *extack,
+			      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+{
+	u32 old_rx_buf_len = rx_alloc_cfg->packet_buffer_size;
+
+	if (rx_buf_len == old_rx_buf_len)
+		return 0;
+
+	/* device options may not always contain support for 4K buffers */
+	if (!gve_is_dqo(priv) || priv->max_rx_buffer_size < SZ_4K) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Modifying Rx buf len is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (priv->xdp_prog && rx_buf_len != SZ_2K) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Rx buf len can only be 2048 when XDP is on");
+		return -EINVAL;
+	}
+
+	if (rx_buf_len != SZ_2K && rx_buf_len != SZ_4K) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Rx buf len can only be 2048 or 4096");
+		return -EINVAL;
+	}
+	rx_alloc_cfg->packet_buffer_size = rx_buf_len;
+
+	return 0;
+}
+
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
 			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
-- 
2.51.2.997.g839fc31de9-goog


