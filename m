Return-Path: <netdev+bounces-231820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644AABFDCDD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171CF3A43E9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5996344042;
	Wed, 22 Oct 2025 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZR8HU3s5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7B337B99
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157405; cv=none; b=lpsMF33/BKxD024RfyXoGLn3vnndzBDy5Iwm5ut+jDBS/HkoSv8bVZ0p9t+Onv64uMrrqtGKoc/j0ZfyA41TsP7yN7QhhJ8KX5AvtGYAsCBeRzzPX5iJLjf3KzBf85PC//wWvnn8v+KG11BossdNaxBp0Z1IiIyDF7NUVKq2bSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157405; c=relaxed/simple;
	bh=Mtn2S0bnI8t9f5MzmCAQjaNwa/k1YvIYY2gLwi4xrFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZO7bBSzSFvNmR8KEc2szWU1tL/0K8FsCxQPdY8VjazrCgCA+cNLllZ0viY12VUCcT5xrpUFDlFy8GwyCyvcpf3ztJsYr1t5ykPxNCp+9Yo/ox1cy0P+32NdXeCd8sSTnWnvCBjnTvpIPd7wj4u2N3piec9YYgi1B4E9XuD8sTlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZR8HU3s5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso8553366a91.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761157403; x=1761762203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BSjvwoj3QY8YDFwz6g2xMO+Jxrb6UQbJ+DExnyviC1c=;
        b=ZR8HU3s5HSykCA8r1kKXxukBUG5NEIuQWaHSUbOqhBRO8GtrSppkAKAK6fIVJKj24v
         SguBa+QP4fus1J4yAzBjk7ggJBCbDPqMNIUK8i4QwP2+hJautN0gaBXIRuqed7I1CqW8
         EdyAthZkOiQidk92mVGlUusT+l5D1iBZf6IoI3I+GBEFlOE2FLyzr5Fy3vLvserZqQbl
         xuGPdPasoF3kHd14XYNVRT+dwgHUzc6EswyOQ7jONZs3c7dynthRlnsEuZ1JZJfSQcT1
         Dpe5Zkyd9Z6/WvcIRf/l7cb0TuPpwM6oqI9H8bgPACsdFFU4hrnOpQoChOZyPIabg5XW
         g+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761157403; x=1761762203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSjvwoj3QY8YDFwz6g2xMO+Jxrb6UQbJ+DExnyviC1c=;
        b=Xry/DjxM0Q5voEFpWmCu4ulYgQDni699MRyjdYJpy/P4nxKs3xF7JAjFJ4vkdirY+j
         eNyhqlT3PrtqZDJPJbD4SI/hbHBZo3jDUwvLaQjMrSJdYZnTR+95ALpvt02U/0g36VGQ
         owXV4kJ+nPL9FfcOFwcl6YptoqfhxTWiEt1SofKas8Ji8pSfhCrC5A294aedGkoz27QQ
         CfQS5Aw6cMsBEvCQ1t4arHUeYbT3PIghh3nLn+AtluyObP3+WtCmpiaL3ctVCuTL931g
         xEuRhTyT9MkrmLZ+k+IoL+xEFIftTO9cRqKnyq9a16Yeogd3TVmNRpFNQ9iUMe7CoLqV
         FeOw==
X-Gm-Message-State: AOJu0YzvVSP3c7JLi8GrWeXpApIy3ibGNy/cyDCLLC1NlhowUKjfKANK
	CPRNalfXGr0vNxOKZsT+23RhrDm99HGUIzN+DNNH3PuJJwAPzF6mjp/Z8kxLXn/jzwyB6WrYBf1
	4PUL+EYJNsh5wJwGs48sgfC7QDyuVKYCo8defi3ED2etKdSlwUfFvZPjUChONHf0Vp9QPOVq/Sj
	Uycdo5WbLofHTDVKiGdiHnQ4PlRDlqvkxZzu0ebYjyV4+L2u4=
X-Google-Smtp-Source: AGHT+IFSGiEBHzmUJ9Zm6BjG0EdjwrD2yFch0TYJtxCLqhBdri6M5unSRtixX3MkKfUYqoMBDsSlJFJSIffG9g==
X-Received: from pjbkr5.prod.google.com ([2002:a17:90b:4905:b0:33e:384c:7327])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:ec8b:b0:32e:9a24:2df9 with SMTP id 98e67ed59e1d1-33bcf86c09emr25106830a91.14.1761157403088;
 Wed, 22 Oct 2025 11:23:23 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:22:23 -0700
In-Reply-To: <20251022182301.1005777-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022182301.1005777-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022182301.1005777-2-joshwash@google.com>
Subject: [PATCH net-next 1/3] gve: Decouple header split from RX buffer length
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
index cf95ec25b11a..c237d00c5ab3 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -59,8 +59,6 @@
 
 #define GVE_DEFAULT_RX_BUFFER_SIZE 2048
 
-#define GVE_MAX_RX_BUFFER_SIZE 4096
-
 #define GVE_XDP_RX_BUFFER_SIZE_DQO 4096
 
 #define GVE_DEFAULT_RX_BUFFER_OFFSET 2048
@@ -1249,7 +1247,6 @@ void gve_rx_free_rings_gqi(struct gve_priv *priv,
 			   struct gve_rx_alloc_rings_cfg *cfg);
 void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx);
 void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx);
-u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hplit);
 bool gve_header_split_supported(const struct gve_priv *priv);
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
 			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index b030a84b678c..db6fc855a511 100644
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
index 29845e8f3c0d..8d825218965a 100644
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
2.51.1.814.gb8fa24458f-goog


