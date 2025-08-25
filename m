Return-Path: <netdev+bounces-216627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE90B34B5B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEC91B250DA
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D889280318;
	Mon, 25 Aug 2025 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g++PWxWA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC828C5DE
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152101; cv=none; b=mxqYsiVjQkxGoLSrN59uz3DuBQsLVabfjWA0xku/KKinAcjTjzqTTEP1+zkIY2znq6EA/8Nu6K+/+hL4omMML/MXwTM8KEzFIkpN/bkmAJTUpD/6Uk47+jUVHQV0EGvW+Qf8xFlq+cdpj0XcbCCjGiOLQvbREzkQksGGATGN9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152101; c=relaxed/simple;
	bh=AGqCf6o/KkYoVHav7gufKBwA2NtLcaieWKEpkjKctEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzzE13rl5kq08oQ3Pc+LoIqIkp3g68pNsz1tIlxnU9ouwNn5b2hbTKwbMvvwrxrf1i7m6AxvIpkIJwsGEZrkfhifdaGuiJCoYdeO5GKg2DHVibA+FcH0m4TtLD5DBnaxS4J+z5hbWfydTINX6Ackxc7U7kGq1/eZ8A6vWqEtw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g++PWxWA; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e96dd4bd847so83677276.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756152093; x=1756756893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPB/O5rAxKDUJBfK1UdvsPKuz1eP9bQatFl9P6LNr7s=;
        b=g++PWxWA95ZuofYSajaFFjGy2omQ02Qw6UE2VLOF0nzBBL3ZPBQetb0wRMuHzSrLCT
         8S2MhHp+56cabxNhG0GDs6xnD3zCUOjr4cEP7PEvaOTYSoO3Bc2baCecwxzJNtEj2aAy
         cYgS63jcsJXcDLeM+hRyjRQTsInexqnxKxDQ2ZqslysOPEXaObfTKmiS0HWPAOnL8u5F
         ds6hvmi+ICWBHUGDf0Ut3Eh6QhgjBZ6iw5AcrOlDPcMYhcEg2RvW/XS+KTwLbgZgAx5R
         4tnU1dF94seVSoNdvAwYpMdbo0AJcebXhzBPr/Tt+9B4/9WzjI8lx08zHpeVqJpsRiH7
         NNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152093; x=1756756893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPB/O5rAxKDUJBfK1UdvsPKuz1eP9bQatFl9P6LNr7s=;
        b=JPmXUdGyOkS4+z/kRrR85uyUu27VCurwUQvamJkclrcXWk71n78JkSfme+Cz+pHbyd
         hrGf9/D7qdBswrzlvH62+w+XLzZaM8duSKW4qEtXGo3kd17/Ao0mepO0R0LuArR4oG7s
         76FEbiB3yD4zMUMHiWNtECRWUr+OKlIJM5Wfed9m0IUhnaDtTyvEL6l6ad3iHB6RzBG8
         QBhH8nTr68NrEAxpTYqagFKDbeGJtuib6wY0k2K/iQ3qoV+CbvS5BE4CgIuxR3U4exkg
         2p6kkYSYgAI6XEpkxcPSV83VeYt/T9ON4BjVtoO51UIZ57qhnbamP/CxISUGVtx5a37V
         0Sdg==
X-Forwarded-Encrypted: i=1; AJvYcCXHgxY1NHE6N7QZB/YyQeCBVkt5Lpm2rk3lAuLFSJDZ8GfWf/Q88b0XbAKkprIpwp3qYvS/WAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCw66hO5uTMsTkBOMu1skGcSHFLp3Sr6ntNYtrBpJx/lRxDW6
	pD3PTjDpF2pnJLerDYmXUrYGbkD4vp4flqIVqYIchZHhWDiR7mTIByZ7
X-Gm-Gg: ASbGnctDec6GWCnbk3hUT8h7s0dGQyDkYKwYFiyo1vxU2uhMdtv+xqR4JjJnh5TAU4l
	jFBJzYYyCW8wxoGKqeIjGYeXPSOYuWf9t89siwSuMzb8tGG55/u1C7lOStuYQdZjgTHjqhIAUBZ
	YbiT29ne4mcmpFKhr0HTFth8Q9ogjLtZVZYLKjfdpFpG8yed22w17VyvDQIzFjtjJvnOIMFSHfm
	LrjQpH9dW9RN3+cKIlJrRhVUSK7uqMY4AL5tv7MF3r+tBIZiNSgYeHAiM4IKXgQ+lB0xATpC0jc
	ID7LJrR03JjVopqIsB6Hn5BIiSbK0MTu2ZhepIyA0AfzYrhzbC4snwRVtfU0Po0GQ70pShKqcxi
	4CUxLG+T4XyA7f2PQ9rNM2fRfNfWaUVw=
X-Google-Smtp-Source: AGHT+IEpdsqPwySlzrAo/fWcHy1I465tc1ORpzU8LuVToFVUJBjwZuzeg2yhjBfd0DHmrzHbgR32jw==
X-Received: by 2002:a05:6902:4085:b0:e95:3e5:b100 with SMTP id 3f1490d57ef6-e951c2e8843mr15133382276.20.1756152093053;
        Mon, 25 Aug 2025 13:01:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96db453574sm217373276.9.2025.08.25.13.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:01:32 -0700 (PDT)
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
Subject: [PATCH net-next v8 14/19] net/mlx5e: Implement PSP Tx data path
Date: Mon, 25 Aug 2025 13:01:02 -0700
Message-ID: <20250825200112.1750547-15-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825200112.1750547-1-daniel.zahka@gmail.com>
References: <20250825200112.1750547-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

Setup PSP offload on Tx data path based on whether skb indicates that it is
intended for PSP or not. Support driver side encapsulation of the UDP
headers, PSP headers, and PSP trailer for the PSP traffic that will be
encrypted by the NIC.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v4:
    - replace memcpy in mlx5e_psp_set_state()
    v3:
    - move psp_encapsulate() into psp_main.c in a separate commit
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-12-kuba@kernel.org/

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   3 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |  28 +++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    | 170 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h    |  96 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  10 +-
 6 files changed, 306 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index b1f43751e56b..e1711a3a06e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -110,7 +110,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_PSP) += en_accel/psp.o en_accel/psp_offload.o en_accel/psp_fs.o
+mlx5_core-$(CONFIG_MLX5_EN_PSP) += en_accel/psp.o en_accel/psp_offload.o en_accel/psp_fs.o \
+				   en_accel/psp_rxtx.o
 
 #
 # SW Steering
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 32e7b791dd6a..3974a3603ab4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -47,6 +47,7 @@
 #include <linux/rhashtable.h>
 #include <net/udp_tunnel.h>
 #include <net/switchdev.h>
+#include <net/psp/types.h>
 #include <net/xdp.h>
 #include <linux/dim.h>
 #include <linux/bits.h>
@@ -68,7 +69,7 @@ struct page_pool;
 #define MLX5E_METADATA_ETHER_TYPE (0x8CE4)
 #define MLX5E_METADATA_ETHER_LEN 8
 
-#define MLX5E_ETH_HARD_MTU (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
+#define MLX5E_ETH_HARD_MTU (ETH_HLEN + PSP_ENCAP_HLEN + PSP_TRL_SIZE + VLAN_HLEN + ETH_FCS_LEN)
 
 #define MLX5E_HW2SW_MTU(params, hwmtu) ((hwmtu) - ((params)->hard_mtu))
 #define MLX5E_SW2HW_MTU(params, swmtu) ((swmtu) + ((params)->hard_mtu))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index bd990e7a6a79..86496e332b03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -43,6 +43,7 @@
 #include "en.h"
 #include "en/txrx.h"
 #include "en_accel/psp_fs.h"
+#include "en_accel/psp_rxtx.h"
 
 #if IS_ENABLED(CONFIG_GENEVE)
 #include <net/geneve.h>
@@ -120,6 +121,9 @@ struct mlx5e_accel_tx_state {
 #ifdef CONFIG_MLX5_EN_IPSEC
 	struct mlx5e_accel_tx_ipsec_state ipsec;
 #endif
+#ifdef CONFIG_MLX5_EN_PSP
+	struct mlx5e_accel_tx_psp_state psp_st;
+#endif
 };
 
 static inline bool mlx5e_accel_tx_begin(struct net_device *dev,
@@ -138,6 +142,13 @@ static inline bool mlx5e_accel_tx_begin(struct net_device *dev,
 			return false;
 #endif
 
+#ifdef CONFIG_MLX5_EN_PSP
+	if (mlx5e_psp_is_offload(skb, dev)) {
+		if (unlikely(!mlx5e_psp_handle_tx_skb(dev, skb, &state->psp_st)))
+			return false;
+	}
+#endif
+
 #ifdef CONFIG_MLX5_EN_IPSEC
 	if (test_bit(MLX5E_SQ_STATE_IPSEC, &sq->state) && xfrm_offload(skb)) {
 		if (unlikely(!mlx5e_ipsec_handle_tx_skb(dev, skb, &state->ipsec)))
@@ -158,8 +169,14 @@ static inline bool mlx5e_accel_tx_begin(struct net_device *dev,
 }
 
 static inline unsigned int mlx5e_accel_tx_ids_len(struct mlx5e_txqsq *sq,
+						  struct sk_buff *skb,
 						  struct mlx5e_accel_tx_state *state)
 {
+#ifdef CONFIG_MLX5_EN_PSP
+	if (mlx5e_psp_is_offload_state(&state->psp_st))
+		return mlx5e_psp_tx_ids_len(&state->psp_st);
+#endif
+
 #ifdef CONFIG_MLX5_EN_IPSEC
 	if (test_bit(MLX5E_SQ_STATE_IPSEC, &sq->state))
 		return mlx5e_ipsec_tx_ids_len(&state->ipsec);
@@ -173,8 +190,14 @@ static inline unsigned int mlx5e_accel_tx_ids_len(struct mlx5e_txqsq *sq,
 
 static inline void mlx5e_accel_tx_eseg(struct mlx5e_priv *priv,
 				       struct sk_buff *skb,
+				       struct mlx5e_accel_tx_state *accel,
 				       struct mlx5_wqe_eth_seg *eseg, u16 ihs)
 {
+#ifdef CONFIG_MLX5_EN_PSP
+	if (mlx5e_psp_is_offload_state(&accel->psp_st))
+		mlx5e_psp_tx_build_eseg(priv, skb, &accel->psp_st, eseg);
+#endif
+
 #ifdef CONFIG_MLX5_EN_IPSEC
 	if (xfrm_offload(skb))
 		mlx5e_ipsec_tx_build_eseg(priv, skb, eseg);
@@ -200,6 +223,11 @@ static inline void mlx5e_accel_tx_finish(struct mlx5e_txqsq *sq,
 	mlx5e_ktls_handle_tx_wqe(&wqe->ctrl, &state->tls);
 #endif
 
+#ifdef CONFIG_MLX5_EN_PSP
+	if (mlx5e_psp_is_offload_state(&state->psp_st))
+		mlx5e_psp_handle_tx_wqe(wqe, &state->psp_st, inlseg);
+#endif
+
 #ifdef CONFIG_MLX5_EN_IPSEC
 	if (test_bit(MLX5E_SQ_STATE_IPSEC, &sq->state) &&
 	    state->ipsec.xo && state->ipsec.tailen)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
new file mode 100644
index 000000000000..2ae5dafcc43f
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/skbuff.h>
+#include <linux/ip.h>
+#include <linux/udp.h>
+#include <net/protocol.h>
+#include <net/udp.h>
+#include <net/ip6_checksum.h>
+#include <net/psp/types.h>
+
+#include "en.h"
+#include "psp.h"
+#include "en_accel/psp_rxtx.h"
+#include "en_accel/psp.h"
+
+static void mlx5e_psp_set_swp(struct sk_buff *skb,
+			      struct mlx5e_accel_tx_psp_state *psp_st,
+			      struct mlx5_wqe_eth_seg *eseg)
+{
+	/* Tunnel Mode:
+	 * SWP:      OutL3       InL3  InL4
+	 * Pkt: MAC  IP     ESP  IP    L4
+	 *
+	 * Transport Mode:
+	 * SWP:      OutL3       OutL4
+	 * Pkt: MAC  IP     ESP  L4
+	 *
+	 * Tunnel(VXLAN TCP/UDP) over Transport Mode
+	 * SWP:      OutL3                   InL3  InL4
+	 * Pkt: MAC  IP     ESP  UDP  VXLAN  IP    L4
+	 */
+	u8 inner_ipproto = 0;
+	struct ethhdr *eth;
+
+	/* Shared settings */
+	eseg->swp_outer_l3_offset = skb_network_offset(skb) / 2;
+	if (skb->protocol == htons(ETH_P_IPV6))
+		eseg->swp_flags |= MLX5_ETH_WQE_SWP_OUTER_L3_IPV6;
+
+	if (skb->inner_protocol_type == ENCAP_TYPE_IPPROTO) {
+		inner_ipproto = skb->inner_ipproto;
+		/* Set SWP additional flags for packet of type IP|UDP|PSP|[ TCP | UDP ] */
+		switch (inner_ipproto) {
+		case IPPROTO_UDP:
+			eseg->swp_flags |= MLX5_ETH_WQE_SWP_INNER_L4_UDP;
+			fallthrough;
+		case IPPROTO_TCP:
+			eseg->swp_inner_l4_offset = skb_inner_transport_offset(skb) / 2;
+			break;
+		default:
+			break;
+		}
+	} else {
+		/* IP in IP tunneling like vxlan*/
+		if (skb->inner_protocol_type != ENCAP_TYPE_ETHER)
+			return;
+
+		eth = (struct ethhdr *)skb_inner_mac_header(skb);
+		switch (ntohs(eth->h_proto)) {
+		case ETH_P_IP:
+			inner_ipproto = ((struct iphdr *)((char *)skb->data +
+					 skb_inner_network_offset(skb)))->protocol;
+			break;
+		case ETH_P_IPV6:
+			inner_ipproto = ((struct ipv6hdr *)((char *)skb->data +
+					 skb_inner_network_offset(skb)))->nexthdr;
+			break;
+		default:
+			break;
+		}
+
+		/* Tunnel(VXLAN TCP/UDP) over Transport Mode PSP i.e. PSP payload is vxlan tunnel */
+		switch (inner_ipproto) {
+		case IPPROTO_UDP:
+			eseg->swp_flags |= MLX5_ETH_WQE_SWP_INNER_L4_UDP;
+			fallthrough;
+		case IPPROTO_TCP:
+			eseg->swp_inner_l3_offset = skb_inner_network_offset(skb) / 2;
+			eseg->swp_inner_l4_offset =
+				(skb->csum_start + skb->head - skb->data) / 2;
+			if (skb->protocol == htons(ETH_P_IPV6))
+				eseg->swp_flags |= MLX5_ETH_WQE_SWP_INNER_L3_IPV6;
+			break;
+		default:
+			break;
+		}
+
+		psp_st->inner_ipproto = inner_ipproto;
+	}
+}
+
+static bool mlx5e_psp_set_state(struct mlx5e_priv *priv,
+				struct sk_buff *skb,
+				struct mlx5e_accel_tx_psp_state *psp_st)
+{
+	struct psp_assoc *pas;
+	bool ret = false;
+
+	rcu_read_lock();
+	pas = psp_skb_get_assoc_rcu(skb);
+	if (!pas)
+		goto out;
+
+	ret = true;
+	psp_st->tailen = PSP_TRL_SIZE;
+	psp_st->spi = pas->tx.spi;
+	psp_st->ver = pas->version;
+	psp_st->keyid = *(u32 *)pas->drv_data;
+
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+void mlx5e_psp_tx_build_eseg(struct mlx5e_priv *priv, struct sk_buff *skb,
+			     struct mlx5e_accel_tx_psp_state *psp_st,
+			     struct mlx5_wqe_eth_seg *eseg)
+{
+	if (!mlx5_is_psp_device(priv->mdev))
+		return;
+
+	if (unlikely(skb->protocol != htons(ETH_P_IP) &&
+		     skb->protocol != htons(ETH_P_IPV6)))
+		return;
+
+	mlx5e_psp_set_swp(skb, psp_st, eseg);
+	/* Special WA for PSP LSO in ConnectX7 */
+	eseg->swp_outer_l3_offset = 0;
+	eseg->swp_inner_l3_offset = 0;
+
+	eseg->flow_table_metadata |= cpu_to_be32(psp_st->keyid);
+	eseg->trailer |= cpu_to_be32(MLX5_ETH_WQE_INSERT_TRAILER) |
+			 cpu_to_be32(MLX5_ETH_WQE_TRAILER_HDR_OUTER_L4_ASSOC);
+}
+
+void mlx5e_psp_handle_tx_wqe(struct mlx5e_tx_wqe *wqe,
+			     struct mlx5e_accel_tx_psp_state *psp_st,
+			     struct mlx5_wqe_inline_seg *inlseg)
+{
+	inlseg->byte_count = cpu_to_be32(psp_st->tailen | MLX5_INLINE_SEG);
+}
+
+bool mlx5e_psp_handle_tx_skb(struct net_device *netdev,
+			     struct sk_buff *skb,
+			     struct mlx5e_accel_tx_psp_state *psp_st)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct net *net = sock_net(skb->sk);
+	const struct ipv6hdr *ip6;
+	struct tcphdr *th;
+
+	if (!mlx5e_psp_set_state(priv, skb, psp_st))
+		return true;
+
+	/* psp_encap of the packet */
+	if (!psp_dev_encapsulate(net, skb, psp_st->spi, psp_st->ver, 0)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_PSP_OUTPUT);
+		return false;
+	}
+	if (skb_is_gso(skb)) {
+		ip6 = ipv6_hdr(skb);
+		th = inner_tcp_hdr(skb);
+
+		th->check = ~tcp_v6_check(skb_shinfo(skb)->gso_size + inner_tcp_hdrlen(skb), &ip6->saddr,
+					  &ip6->daddr, 0);
+	}
+
+	return true;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
new file mode 100644
index 000000000000..521b2c3620e6
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5E_PSP_RXTX_H__
+#define __MLX5E_PSP_RXTX_H__
+
+#include <linux/skbuff.h>
+#include <net/xfrm.h>
+#include <net/psp.h>
+#include "en.h"
+#include "en/txrx.h"
+
+struct mlx5e_accel_tx_psp_state {
+	u32 tailen;
+	u32 keyid;
+	__be32 spi;
+	u8 inner_ipproto;
+	u8 ver;
+};
+
+#ifdef CONFIG_MLX5_EN_PSP
+static inline bool mlx5e_psp_is_offload_state(struct mlx5e_accel_tx_psp_state *psp_state)
+{
+	return (psp_state->tailen != 0);
+}
+
+static inline bool mlx5e_psp_is_offload(struct sk_buff *skb, struct net_device *netdev)
+{
+	bool ret;
+
+	rcu_read_lock();
+	ret = !!psp_skb_get_assoc_rcu(skb);
+	rcu_read_unlock();
+	return ret;
+}
+
+bool mlx5e_psp_handle_tx_skb(struct net_device *netdev,
+			     struct sk_buff *skb,
+			     struct mlx5e_accel_tx_psp_state *psp_st);
+
+void mlx5e_psp_tx_build_eseg(struct mlx5e_priv *priv, struct sk_buff *skb,
+			     struct mlx5e_accel_tx_psp_state *psp_st,
+			     struct mlx5_wqe_eth_seg *eseg);
+
+void mlx5e_psp_handle_tx_wqe(struct mlx5e_tx_wqe *wqe,
+			     struct mlx5e_accel_tx_psp_state *psp_st,
+			     struct mlx5_wqe_inline_seg *inlseg);
+
+static inline bool mlx5e_psp_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
+						   struct mlx5e_accel_tx_psp_state *psp_st,
+						   struct mlx5_wqe_eth_seg *eseg)
+{
+	u8 inner_ipproto;
+
+	if (!mlx5e_psp_is_offload_state(psp_st))
+		return false;
+
+	inner_ipproto = psp_st->inner_ipproto;
+	eseg->cs_flags = MLX5_ETH_WQE_L3_CSUM;
+	if (inner_ipproto) {
+		eseg->cs_flags |= MLX5_ETH_WQE_L3_INNER_CSUM;
+		if (inner_ipproto == IPPROTO_TCP || inner_ipproto == IPPROTO_UDP)
+			eseg->cs_flags |= MLX5_ETH_WQE_L4_INNER_CSUM;
+		if (likely(skb->ip_summed == CHECKSUM_PARTIAL))
+			sq->stats->csum_partial_inner++;
+	} else if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
+		eseg->cs_flags |= MLX5_ETH_WQE_L4_INNER_CSUM;
+		sq->stats->csum_partial_inner++;
+	}
+
+	return true;
+}
+
+static inline unsigned int mlx5e_psp_tx_ids_len(struct mlx5e_accel_tx_psp_state *psp_st)
+{
+	return psp_st->tailen;
+}
+#else
+static inline bool mlx5e_psp_is_offload_state(struct mlx5e_accel_tx_psp_state *psp_state)
+{
+	return false;
+}
+
+static inline bool mlx5e_psp_is_offload(struct sk_buff *skb, struct net_device *netdev)
+{
+	return false;
+}
+
+static inline bool mlx5e_psp_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
+						   struct mlx5e_accel_tx_psp_state *psp_st,
+						   struct mlx5_wqe_eth_seg *eseg)
+{
+	return false;
+}
+#endif /* CONFIG_MLX5_EN_PSP */
+#endif /* __MLX5E_PSP_RXTX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 319061d31602..10d50ca637f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -39,6 +39,7 @@
 #include "ipoib/ipoib.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ipsec_rxtx.h"
+#include "en_accel/psp_rxtx.h"
 #include "en_accel/macsec.h"
 #include "en/ptp.h"
 #include <net/ipv6.h>
@@ -120,6 +121,11 @@ mlx5e_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 			    struct mlx5e_accel_tx_state *accel,
 			    struct mlx5_wqe_eth_seg *eseg)
 {
+#ifdef CONFIG_MLX5_EN_PSP
+	if (unlikely(mlx5e_psp_txwqe_build_eseg_csum(sq, skb, &accel->psp_st, eseg)))
+		return;
+#endif
+
 	if (unlikely(mlx5e_ipsec_txwqe_build_eseg_csum(sq, skb, eseg)))
 		return;
 
@@ -297,7 +303,7 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		stats->packets++;
 	}
 
-	attr->insz = mlx5e_accel_tx_ids_len(sq, accel);
+	attr->insz = mlx5e_accel_tx_ids_len(sq, skb, accel);
 	stats->bytes += attr->num_bytes;
 }
 
@@ -661,7 +667,7 @@ static void mlx5e_txwqe_build_eseg(struct mlx5e_priv *priv, struct mlx5e_txqsq *
 				   struct sk_buff *skb, struct mlx5e_accel_tx_state *accel,
 				   struct mlx5_wqe_eth_seg *eseg, u16 ihs)
 {
-	mlx5e_accel_tx_eseg(priv, skb, eseg, ihs);
+	mlx5e_accel_tx_eseg(priv, skb, accel, eseg, ihs);
 	mlx5e_txwqe_build_eseg_csum(sq, skb, accel, eseg);
 	if (unlikely(sq->ptpsq))
 		mlx5e_cqe_ts_id_eseg(sq->ptpsq, skb, eseg);
-- 
2.47.3


