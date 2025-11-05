Return-Path: <netdev+bounces-235933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22357C374AE
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217AE3B5C9D
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAD4280331;
	Wed,  5 Nov 2025 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjIjxxve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE327B4FA
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367180; cv=none; b=n3cRDtrfI6utzF0fgKB6NG9ppbf+Faj5CWhlzi4Nni6NSH14FFRcBMAFnEhzUEloTyqDGQJKd0/+kiu363nullSsDR028tkv5wu9BUv0vvc5FJY3NheHhLD1lnoPzVh/um03jz6xPjTraUYOXK1YtzVb2GYL4PxETdcZl/uHAPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367180; c=relaxed/simple;
	bh=iDX+Xjk6YPshtFGXJ/bFso821Raymie9r/DGYwcIVUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mj2imdysmKpxLAaZi8rk5q1Wd3c1E8WQCa+q/E4FfBXrXFVm6ObIOy5yRR1chTO4Gbn26T3xOs7+w4rbfzzvS/bQ4yeOUx/vPt+i+vQPV5aoGFvB1VQgXxFyPr9WVVgqrE/YPvCdvHywD+XEUBqwNrylqLpGlBeXfb1a1VgGK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjIjxxve; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3418ad76023so374464a91.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 10:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762367178; x=1762971978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIN6Z9i91+duDdYVW8qK20gY3PDqSGvt0BSLKjqFHuw=;
        b=hjIjxxvePWddAg9XloCLca01gTBjDoVVwrGHhOx1szE38k9Vx1q89LuhJZtlGKZyz2
         dSNr5opjfg/rKJTxJ5xGqM2OMm+EVkfwDbEZ1krfvaQMpmhenbCOKiqoBBfJrh+FreIO
         k48VniFMRrMZFdcjOd4ksFE23iv2DkWKgtDsurHOWQznwAf7NYA/TRow+RSccKesqdqx
         j1Fu1N6WiDtiCohYyBu0Jaxk4abA9ff+PIvdBeVYXZfiFjl/c7IHJgGT7HWBaf87z9uY
         MfqZnMpGzzdaIjlSSRu2BgI6l1nZ5U8kVv2BFyH37ZJqqiCQ6poLeEcYH73tKXcuZI1m
         QI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367178; x=1762971978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIN6Z9i91+duDdYVW8qK20gY3PDqSGvt0BSLKjqFHuw=;
        b=XAP7RD0gT4lNX2fqoW17iS1JQLBqVIrkUEwqHcqH8VLMSETTBkZb/B3mg48dVuBYaT
         uvSjGiE7NrJ2aFTAbIs5ZANaKBeN5hv4WOwWAD8uVaEyT2GPTPITDkK5dwePr9+PCnFb
         lip64tMU9mJqBPgCHTk0lZIE9qW2yc2tiRxcNFY2hpa4vls9q/8+EF6uITe5o8m4zewu
         d/MwjY2x+cQ6lfUeqOlXHSTtSwUvM2ZiPOLpi/LxMew3AwPWuUIMYk5KKTPCpszk6AFj
         wZHLoXda56NaRRaQJv1rNuxOjq4+/btPapYXrirmyNnPHun9jwDlZ1qUY7ugT0tjRHMU
         1j0A==
X-Gm-Message-State: AOJu0YweqqQ3Br9flqSfpbR2jmXAYyCOQJubt2BWUJRRNKVTLQsLpOCv
	SuH6op/tc5dDpIq1j/qKy8tFejtBFtEKomg4iniufapkfQTxmLnkr5LfEh80if5R1nE87fnK/MD
	AUhMaFKOdSI35AxN/NKx6uPyHsMJWhaB6W4xxpMMbQZobmoBTsNf1rznGLgw9GEXlVeCGcIHHod
	Kbp3r/gv4YRtySI7g9lBhOxZCdPJCnPG/HOpm0UhRqXI/Ypwo=
X-Google-Smtp-Source: AGHT+IF8S7FRqRyPimC+uMd0ihT2KBqA3Lw6kdlscKBI6BMgzGjItjrQbv0tFluSpf84LLLZuCAjVCC9OWj5oQ==
X-Received: from plcs13.prod.google.com ([2002:a17:903:30cd:b0:295:1e7a:83a7])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f64b:b0:295:7bbd:52fa with SMTP id d9443c01a7336-2962add9508mr64726255ad.56.1762367178513;
 Wed, 05 Nov 2025 10:26:18 -0800 (PST)
Date: Wed,  5 Nov 2025 10:26:00 -0800
In-Reply-To: <20251105182603.1223474-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251105182603.1223474-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251105182603.1223474-2-joshwash@google.com>
Subject: [PATCH net-next v2 1/4] gve: Decouple header split from RX buffer length
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
	linux-kernel@vger.kernel.org, Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Previously, enabling header split via `gve_set_hsplit_config` also
implicitly changed the RX buffer length to 4K (if supported by the
device). This coupled two settings that should be orthogonal; this patch
removes that side effect.

After this change, `gve_set_hsplit_config` only toggles the header
split configuration. The RX buffer length is no longer affected and
must be configured independently.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  3 ---
 drivers/net/ethernet/google/gve/gve_ethtool.c |  2 --
 drivers/net/ethernet/google/gve/gve_main.c    | 10 ----------
 3 files changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index ac325ab..872dae6 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -59,8 +59,6 @@
 
 #define GVE_DEFAULT_RX_BUFFER_SIZE 2048
 
-#define GVE_MAX_RX_BUFFER_SIZE 4096
-
 #define GVE_XDP_RX_BUFFER_SIZE_DQO 4096
 
 #define GVE_DEFAULT_RX_BUFFER_OFFSET 2048
@@ -1247,7 +1245,6 @@ void gve_rx_free_rings_gqi(struct gve_priv *priv,
 			   struct gve_rx_alloc_rings_cfg *cfg);
 void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx);
 void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx);
-u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hplit);
 bool gve_header_split_supported(const struct gve_priv *priv);
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
 			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index b030a84..db6fc85 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -606,8 +606,6 @@ static int gve_set_ringparam(struct net_device *netdev,
 	} else {
 		/* Set ring params for the next up */
 		priv->header_split_enabled = rx_alloc_cfg.enable_header_split;
-		priv->rx_cfg.packet_buffer_size =
-			rx_alloc_cfg.packet_buffer_size;
 		priv->tx_desc_cnt = tx_alloc_cfg.ring_size;
 		priv->rx_desc_cnt = rx_alloc_cfg.ring_size;
 	}
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 347391a..453e40a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2041,14 +2041,6 @@ static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	priv->tx_timeo_cnt++;
 }
 
-u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hsplit)
-{
-	if (enable_hsplit && priv->max_rx_buffer_size >= GVE_MAX_RX_BUFFER_SIZE)
-		return GVE_MAX_RX_BUFFER_SIZE;
-	else
-		return GVE_DEFAULT_RX_BUFFER_SIZE;
-}
-
 /* Header split is only supported on DQ RDA queue format. If XDP is enabled,
  * header split is not allowed.
  */
@@ -2080,8 +2072,6 @@ int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
 		return 0;
 
 	rx_alloc_cfg->enable_header_split = enable_hdr_split;
-	rx_alloc_cfg->packet_buffer_size =
-		gve_get_pkt_buf_size(priv, enable_hdr_split);
 
 	return 0;
 }
-- 
2.51.2.997.g839fc31de9-goog


