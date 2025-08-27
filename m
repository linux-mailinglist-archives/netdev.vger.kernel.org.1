Return-Path: <netdev+bounces-217365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF18B38724
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5831E18824A8
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E51835691C;
	Wed, 27 Aug 2025 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2NJNDCV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A133CEB3
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310045; cv=none; b=r/d0vpxb2n0khQJUBCEaEllfitSlCYjRM7yTVwI2dGgxwr4j3nh/lY6y1sZmsEqDF1WFYQZVkD+ocLdy6YY6oBtcwNm2KBFIt4dEqu9vtRSj31/ttT2/FMYfdUVkK9EI4pH6ihK2m2+53I/Xv3rakTbzyxsZJLLi3CaNUAzjaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310045; c=relaxed/simple;
	bh=IdxgJZCrGw6r3AbOSvergTiRAFtwh1SAGbMKM/tjFDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gT7RLb1e1kA5CzqGQWecsF9UXQEPq6TuZW7IOFONCVio1QCWQnOGk8omZ6UM/kFe5+aoTVVrHS3V8gR5q8O+2Ss4xQCOHiXNsbnDCm/7y5glsg7DTFuWw8UMPBW2C+lSv8aHgUOMMvZHVE3hXso+FMrV7bQWFO9XVlWy9NiHM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2NJNDCV; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71e6f84b77eso55924957b3.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310042; x=1756914842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXzeSxEhO+TL4hVEiijBY1pcbn8eYrbaSU1+DUXJzdU=;
        b=F2NJNDCVVWtH3AClXLsp3ZxVOFOr01abgDuMF65VpEnWBLWy2z9PDVTT9g3jW66BcZ
         yl2J52Le7Q0hL+DsSJAFRG+CegrAA8oOyOXu9hB6NUndt6TAez0ucPt8nx339Mxk5N0y
         Y70w38m8486+TDFBhvjYc78F7dpT/pEflHWZ0Xm/q0K5a/qQ+/Sou7CJTKKfyJCCHGI6
         M+H2aNJ1xPQ9XmGL46gk5s0nrqxZhrIhAiNBWH49ZGw5NtPYoRXkjP/h72cVpQav93XW
         SOFc33sYQxm/50vmB4ZuTZLqWgcjM1Zyrf+jHK4ADAKLqkFQ1WvEEgYW+Q+5z6FDIkIV
         KQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310042; x=1756914842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXzeSxEhO+TL4hVEiijBY1pcbn8eYrbaSU1+DUXJzdU=;
        b=o7j0Bwts9If4PO9w+mfUI5TnzOq2YDQvi7Szgi0zZB4VxwphxzIuW2LsRgxal66vuk
         EPXBIILE5hELKpO1zS2fV9HdnKflIy2Dq+zVbCe52TPa7SFGGtJUrg+M3uKHOlYhIImr
         tFh/gWyUo6Tx6MiTvM4fA3AsDoLiFLHBxfIlFIBYxBmDkpMvoAdBXgJbEdAjXB7flR1Q
         rP/MRH3MJiicU7h46EnRdIj6Iq9/zqadM8nwTyLm1pBPwWtvVbXhqhLgacYuFH1ptSis
         u/6TIBKAOZUf3VmuB2Y6Mq4WXgnp8w0dkoorp7twRMMlJf54DM9DyiWGGD95Pl3xpk33
         2cHw==
X-Forwarded-Encrypted: i=1; AJvYcCVoF26G3L76w9NHSHVoy7X+mAQjfbVA0q3GdEdPLGDKTZtlThKY3OoshRIUlXAsO4hXq3ulwgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32DOu56meV6soSvjIq7/FTFvQK5LQKnv9+Bfyubf2MA5QWkkS
	QkSJEHP8KpnwkTTY4e/2BaXB1MsgVyTwpU7EwO9AofhiLHivyDUAzEiQ
X-Gm-Gg: ASbGnctaP4ykC/yTAgzzG/3N6Lc7mcFGn3tsOrVZk3+y4d+oGi8slkWU0Jx+Dm0VaAc
	I35jr1UC1eZeuUQf8fhOYr2s9LZAQirh/mpyxCSjX1rYa3RD4CiyiiVbNhm5KRTerEcSpZf2XJh
	YmkP3SLo/OiWglvetlSUsN24SjSPajXBS5I36zUmxuO+S9Y8gwKBws+UCsvPvZASrGsBYAKLQ+u
	gHj0ZB4OAKVa7r0vknqtsx1Vch01hfUd4VTUZ7Euasu3lMWTZ1ek7CcQbEbrh1BDqhMG2YhnWOI
	8gK3quTI4s5Ef2MfBgKKU9tmjLlPnOy5VuqpSVlMA0ZKKJ/K+43/gVxM16uDn6P/gOIvPslUjof
	edlMUdiz9InVUAxrpP2Wag/moLrIsZCp/RW0Pgxqy
X-Google-Smtp-Source: AGHT+IHXG6NFWRAl/ibEuuDacE7QiB7Hbzu2xK3Ui55oSaZlRr6S5zSQbi8QCJEw01JB4LfEgp6k+w==
X-Received: by 2002:a05:690c:4c02:b0:71e:7a28:c13b with SMTP id 00721157ae682-71fdc3db116mr213535837b3.28.1756310042049;
        Wed, 27 Aug 2025 08:54:02 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17339f2sm32077027b3.25.2025.08.27.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:54:01 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v9 18/19] net/mlx5e: Add Rx data path offload
Date: Wed, 27 Aug 2025 08:53:35 -0700
Message-ID: <20250827155340.2738246-19-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827155340.2738246-1-daniel.zahka@gmail.com>
References: <20250827155340.2738246-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

On receive flow inspect received packets for PSP offload indication using
the cqe, for PSP offloaded packets set SKB PSP metadata i.e spi, header
length and key generation number to stack for further processing.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v4:
    - remove mlx5e_psp_csum_complete() because stripping psp_icv can be
      done in psp_dev_rcv() now
    - fix MLX5_PSP_METADATA_SYNDROME typo
    v3:
    - move psp_rcv() into psp_main.c in a separate commit
    v2:
    - fill out new pse::dev_id field in psp_rcv()
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-15-kuba@kernel.org/

 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |  2 +-
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    | 30 ++++++++++++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h    | 25 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 49 ++++++++++++++-----
 4 files changed, 93 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 3cc640669247..45b0d19e735c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -40,7 +40,7 @@
 #include "en/txrx.h"
 
 /* Bit31: IPsec marker, Bit30: reserved, Bit29-24: IPsec syndrome, Bit23-0: IPsec obj id */
-#define MLX5_IPSEC_METADATA_MARKER(metadata)  (((metadata) >> 31) & 0x1)
+#define MLX5_IPSEC_METADATA_MARKER(metadata)  ((((metadata) >> 30) & 0x3) == 0x2)
 #define MLX5_IPSEC_METADATA_SYNDROM(metadata) (((metadata) >> 24) & GENMASK(5, 0))
 #define MLX5_IPSEC_METADATA_HANDLE(metadata)  ((metadata) & GENMASK(23, 0))
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
index 2ae5dafcc43f..828bff1137af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
@@ -14,6 +14,12 @@
 #include "en_accel/psp_rxtx.h"
 #include "en_accel/psp.h"
 
+enum {
+	MLX5E_PSP_OFFLOAD_RX_SYNDROME_DECRYPTED,
+	MLX5E_PSP_OFFLOAD_RX_SYNDROME_AUTH_FAILED,
+	MLX5E_PSP_OFFLOAD_RX_SYNDROME_BAD_TRAILER,
+};
+
 static void mlx5e_psp_set_swp(struct sk_buff *skb,
 			      struct mlx5e_accel_tx_psp_state *psp_st,
 			      struct mlx5_wqe_eth_seg *eseg)
@@ -113,6 +119,30 @@ static bool mlx5e_psp_set_state(struct mlx5e_priv *priv,
 	return ret;
 }
 
+bool mlx5e_psp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
+				     struct mlx5_cqe64 *cqe)
+{
+	u32 psp_meta_data = be32_to_cpu(cqe->ft_metadata);
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	u16 dev_id = priv->psp->psp->id;
+	bool strip_icv = true;
+	u8 generation = 0;
+
+	/* TBD: report errors as SW counters to ethtool, any further handling ? */
+	if (MLX5_PSP_METADATA_SYNDROME(psp_meta_data) != MLX5E_PSP_OFFLOAD_RX_SYNDROME_DECRYPTED)
+		goto drop;
+
+	if (psp_dev_rcv(skb, dev_id, generation, strip_icv))
+		goto drop;
+
+	skb->decrypted = 1;
+	return false;
+
+drop:
+	kfree_skb(skb);
+	return true;
+}
+
 void mlx5e_psp_tx_build_eseg(struct mlx5e_priv *priv, struct sk_buff *skb,
 			     struct mlx5e_accel_tx_psp_state *psp_st,
 			     struct mlx5_wqe_eth_seg *eseg)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
index 521b2c3620e6..70289c921bd6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
@@ -10,6 +10,11 @@
 #include "en.h"
 #include "en/txrx.h"
 
+/* Bit30: PSP marker, Bit29-23: PSP syndrome, Bit22-0: PSP obj id */
+#define MLX5_PSP_METADATA_MARKER(metadata)  ((((metadata) >> 30) & 0x3) == 0x3)
+#define MLX5_PSP_METADATA_SYNDROME(metadata) (((metadata) >> 23) & GENMASK(6, 0))
+#define MLX5_PSP_METADATA_HANDLE(metadata)  ((metadata) & GENMASK(22, 0))
+
 struct mlx5e_accel_tx_psp_state {
 	u32 tailen;
 	u32 keyid;
@@ -75,6 +80,14 @@ static inline unsigned int mlx5e_psp_tx_ids_len(struct mlx5e_accel_tx_psp_state
 {
 	return psp_st->tailen;
 }
+
+static inline bool mlx5e_psp_is_rx_flow(struct mlx5_cqe64 *cqe)
+{
+	return MLX5_PSP_METADATA_MARKER(be32_to_cpu(cqe->ft_metadata));
+}
+
+bool mlx5e_psp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
+				     struct mlx5_cqe64 *cqe);
 #else
 static inline bool mlx5e_psp_is_offload_state(struct mlx5e_accel_tx_psp_state *psp_state)
 {
@@ -92,5 +105,17 @@ static inline bool mlx5e_psp_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struc
 {
 	return false;
 }
+
+static inline bool mlx5e_psp_is_rx_flow(struct mlx5_cqe64 *cqe)
+{
+	return false;
+}
+
+static inline bool mlx5e_psp_offload_handle_rx_skb(struct net_device *netdev,
+						   struct sk_buff *skb,
+						   struct mlx5_cqe64 *cqe)
+{
+	return false;
+}
 #endif /* CONFIG_MLX5_EN_PSP */
 #endif /* __MLX5E_PSP_RXTX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..f4dbdeb27821 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -51,6 +51,7 @@
 #include "ipoib/ipoib.h"
 #include "en_accel/ipsec.h"
 #include "en_accel/macsec.h"
+#include "en_accel/psp_rxtx.h"
 #include "en_accel/ipsec_rxtx.h"
 #include "en_accel/ktls_txrx.h"
 #include "en/xdp.h"
@@ -1521,6 +1522,11 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 		skb->ip_summed = CHECKSUM_COMPLETE;
 		skb->csum = csum_unfold((__force __sum16)cqe->check_sum);
 
+		if (unlikely(mlx5e_psp_is_rx_flow(cqe))) {
+			/* TBD: PSP csum complete corrections for now chose csum_unnecessary path */
+			goto csum_unnecessary;
+		}
+
 		if (test_bit(MLX5E_RQ_STATE_CSUM_FULL, &rq->state))
 			return; /* CQE csum covers all received bytes */
 
@@ -1549,7 +1555,7 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 
 #define MLX5E_CE_BIT_MASK 0x80
 
-static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
+static inline bool mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 				      u32 cqe_bcnt,
 				      struct mlx5e_rq *rq,
 				      struct sk_buff *skb)
@@ -1563,6 +1569,11 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 	if (unlikely(get_cqe_tls_offload(cqe)))
 		mlx5e_ktls_handle_rx_skb(rq, skb, cqe, &cqe_bcnt);
 
+	if (unlikely(mlx5e_psp_is_rx_flow(cqe))) {
+		if (mlx5e_psp_offload_handle_rx_skb(netdev, skb, cqe))
+			return true;
+	}
+
 	if (unlikely(mlx5_ipsec_is_rx_flow(cqe)))
 		mlx5e_ipsec_offload_handle_rx_skb(netdev, skb,
 						  be32_to_cpu(cqe->ft_metadata));
@@ -1608,9 +1619,11 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
 	if (unlikely(mlx5e_skb_is_multicast(skb)))
 		stats->mcast_packets++;
+
+	return false;
 }
 
-static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
+static bool mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
 					 struct mlx5_cqe64 *cqe,
 					 u32 cqe_bcnt,
 					 struct sk_buff *skb)
@@ -1620,16 +1633,20 @@ static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
 	stats->packets++;
 	stats->bytes += cqe_bcnt;
 	if (NAPI_GRO_CB(skb)->count != 1)
-		return;
-	mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
+		return false;
+
+	if (mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb))
+		return true;
+
 	skb_reset_network_header(skb);
 	if (!skb_flow_dissect_flow_keys(skb, &rq->hw_gro_data->fk, 0)) {
 		napi_gro_receive(rq->cq.napi, skb);
 		rq->hw_gro_data->skb = NULL;
 	}
+	return false;
 }
 
-static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
+static inline bool mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 					 struct mlx5_cqe64 *cqe,
 					 u32 cqe_bcnt,
 					 struct sk_buff *skb)
@@ -1638,7 +1655,7 @@ static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 
 	stats->packets++;
 	stats->bytes += cqe_bcnt;
-	mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
+	return mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
 }
 
 static inline
@@ -1855,7 +1872,8 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto wq_cyc_pop;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -1902,7 +1920,8 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto wq_cyc_pop;
 
 	if (rep->vlan && skb_vlan_tag_present(skb))
 		skb_vlan_pop(skb);
@@ -1951,7 +1970,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto mpwrq_cqe_out;
 
 	mlx5e_rep_tc_receive(cqe, rq, skb);
 
@@ -2388,7 +2408,10 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 		stats->hds_nosplit_bytes += data_bcnt;
 	}
 
-	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
+	if (mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb)) {
+		*skb = NULL;
+		goto free_hd_entry;
+	}
 	if (flush && rq->hw_gro_data->skb)
 		mlx5e_shampo_flush_skb(rq, cqe, match);
 free_hd_entry:
@@ -2446,7 +2469,8 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto mpwrq_cqe_out;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -2779,7 +2803,8 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 	if (!skb)
 		goto wq_cyc_pop;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto wq_cyc_pop;
 	skb_push(skb, ETH_HLEN);
 
 	mlx5_devlink_trap_report(rq->mdev, trap_id, skb,
-- 
2.47.3


