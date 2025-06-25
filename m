Return-Path: <netdev+bounces-201177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE427AE8546
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A5F3B836D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EF6268C55;
	Wed, 25 Jun 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEJzbHZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623C2263F40
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859549; cv=none; b=ALp21h1dyKSJ2p20f9GBu4ozrqccgvLWi07bTC6NThSNbtnmJMlEDRhAPuiR53eqcbTq7MI0ot9/F24q30mq5Y7dduAADU8X+jbN/pKqDp//Iyh+yao9slvMtkz/2kS2VKZrlWSp2CdBZQ8kyQnTpttG7j656Phw7Uo0bdF+KkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859549; c=relaxed/simple;
	bh=qvz+tOdVOUguiVthJ69StMXJcNdqOmDjOSMxDdmg60U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYtYqXZRhpTYUol+B7h2aAZp8kbUkKhdQppnbc1mV5t2GxKFH0SdzMzcXgWOdl2OC08vhO7Y7CbJ32JbU2oevph8pW2UfLfTfqtQqkXKjODMUlMAXGTCuxsc4FaN1FI3yuKBNQC8Sos4wsmvb+QT59fIfB8zkjkhH1s9Pok11aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEJzbHZu; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e812fc35985so1393532276.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859546; x=1751464346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FUazbWvg6xMYWnRWVzx+b7r4Z2t8Td+27Q1Ry8HQUo=;
        b=hEJzbHZuvUxCIInrQ4/lm9sn11c90K55nKT3XJuo8I2Rm7vT+ua3zcsyD6c3Em9zf/
         ocPSkdLGlulow1LVgNXYlPfDG0cld2ZwrZjaWBdWlFEj8rjWwieqOg4nJYqbphGG1yJy
         r6WOr+5BVpr/LaOxM9yWQUCr+/I088Xr5dg3ieFbabIFTgIcDLdHTd4wKVxaj7h9+mHn
         ndGc8iPQoZ+PxKDd0hXD6izx1fUT7rlrXUBdlgiWk+OzUWUKjjRKDNQQZWJhWWZ7VufY
         AX/8pGAKfC3d5WQ7CNDfNIkyWqcTqcXpvQLkJV9ENpTAP0TkrimP0QbxL5GEdY8m0nQN
         43Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859546; x=1751464346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FUazbWvg6xMYWnRWVzx+b7r4Z2t8Td+27Q1Ry8HQUo=;
        b=KClto9D3bVyYqnFBMGBrvxOf11TMsMzUfVOwg2nQe4FxfoqW8a/U8R02hrN3eQg2LC
         6H+Evw6/c17hzAkPJajsLdQcajTJcsuRX5n1v5noKuNL9r+Vme4NiQJjyb6gA+kjX3GB
         soLTkq9euisjOE9lK79MILIZb+PszJeplnRITvsDMWMoZarUWs9LjDTan46pINDPPbxI
         xoagIgbMcFpCookTcv1krBG+Ea43qA2y2lQIEOtn4YvpV7zerlSERQfTIxuj/cYWjnmG
         OX/QgxhLap1CLQiQufThhKzGwg4gyx2RuIeYh4f26bSafK4J3ss6ehH7y3VlLyfI8d4s
         WXwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbObUUtx/HLtATK7uCIaAJXDQoFR0OQkq6dE/xV8IoibNlt814fT7ibEgzcmjRcXHrJhnjp9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOvHpc3sJwBt2rEsyQHjrejuK6BysEAlfkyVC3mWPLASHPcfi
	4Qnjj4XnnKuOSkR9cmWU3mPSNrp/EDQDSN8tLbZdbXa8AC4z0utctZkm
X-Gm-Gg: ASbGncuY4wr0VDdx7LJ/NsHuPuJ7bI3gXrL+F0TcbTX1fH+iJra/hItYcOo/VkeKSfB
	/Wfoy/piUc6Vdi929JljXlhQqF5PXVoXGA2xiKkhfUFKTqiYu22IWhIXdwVfRTB5zhSZWum9Wxv
	1SrJop9p6Ja8mJMem/6qdvday8sM8N3mnYtWAKlydrACurTBGGpl6TGQ6f6fIAEruQoccS0OxPc
	hC3RSSPoGwwpkLGI4zK5MKHIFuRZSuZtOrWS5lP8RaNRZYiv8r+r1zgGXggYJFB8+WHnc+Fk9qD
	E3vpqriyuUSdx61y8xEks56t+WSSzwOJkxVOzJ710vm7M6URowmCkCybwuJC
X-Google-Smtp-Source: AGHT+IEI+KmOV605KbeWB5Y7SUzAVWlLdZsDWkFl5N7gNl5Sc3jA13mhp+zdBqz0Iz4fBjKWSRoRdA==
X-Received: by 2002:a05:690c:9692:b0:710:e81b:f7cf with SMTP id 00721157ae682-71406cafb2dmr42225697b3.13.1750859546266;
        Wed, 25 Jun 2025 06:52:26 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4c1d7a0sm24388057b3.111.2025.06.25.06.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:52:25 -0700 (PDT)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 13/17] net/mlx5e: Implement PSP Tx data path
Date: Wed, 25 Jun 2025 06:52:03 -0700
Message-ID: <20250625135210.2975231-14-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625135210.2975231-1-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
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
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-12-kuba@kernel.org/

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |  28 +++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    | 225 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h    |  96 ++++++++
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  10 +-
 .../mellanox/mlx5/core/lib/psp_defs.h         |  28 +++
 7 files changed, 390 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/psp_defs.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 5d2783f2e82f..3761f5c104d3 100644
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
index 9078becfd710..f3ba317c7cd9 100644
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
@@ -61,6 +62,7 @@
 #include "en/rx_res.h"
 #include "en/selq.h"
 #include "lib/sd.h"
+#include "lib/psp_defs.h"
 
 extern const struct net_device_ops mlx5e_netdev_ops;
 struct page_pool;
@@ -68,7 +70,7 @@ struct page_pool;
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
index 000000000000..7ed59546db4e
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
@@ -0,0 +1,225 @@
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
+#include "lib/psp_defs.h"
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
+	memcpy(&psp_st->keyid, pas->drv_data, sizeof(psp_st->keyid));
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
+static void psp_write_headers(struct net *net, struct sk_buff *skb,
+			      __be32 spi, u8 ver, unsigned int udp_len,
+			      __be16 sport)
+{
+	struct udphdr *uh = udp_hdr(skb);
+	struct psphdr *psph = (struct psphdr *)(uh + 1);
+
+	uh->dest = htons(PSP_DEFAULT_UDP_PORT);
+	uh->source = udp_flow_src_port(net, skb, 0, 0, false);
+	uh->check = 0;
+	uh->len = htons(udp_len);
+
+	psph->nexthdr = IPPROTO_TCP;
+	psph->hdrlen = PSP_HDRLEN_NOOPT;
+	psph->crypt_offset = 0;
+	psph->verfl = FIELD_PREP(PSPHDR_VERFL_VERSION, ver) |
+		      FIELD_PREP(PSPHDR_VERFL_ONE, 1);
+	psph->spi = spi;
+	memset(&psph->iv, 0, sizeof(psph->iv));
+}
+
+/* Encapsulate a TCP packet with PSP by adding the UDP+PSP headers and filling
+ * them in.
+ */
+static bool psp_encapsulate(struct net *net, struct sk_buff *skb,
+			    __be32 spi, u8 ver, __be16 sport)
+{
+	u32 network_len = skb_network_header_len(skb);
+	u32 ethr_len = skb_mac_header_len(skb);
+	u32 bufflen = ethr_len + network_len;
+	struct ipv6hdr *ip6;
+
+	if (skb_cow_head(skb, PSP_ENCAP_HLEN))
+		return false;
+
+	skb_push(skb, PSP_ENCAP_HLEN);
+	skb->mac_header		-= PSP_ENCAP_HLEN;
+	skb->network_header	-= PSP_ENCAP_HLEN;
+	skb->transport_header	-= PSP_ENCAP_HLEN;
+	memmove(skb->data, skb->data + PSP_ENCAP_HLEN, bufflen);
+
+	ip6 = ipv6_hdr(skb);
+	skb_set_inner_ipproto(skb, IPPROTO_TCP);
+	ip6->nexthdr = IPPROTO_UDP;
+	be16_add_cpu(&ip6->payload_len, PSP_ENCAP_HLEN);
+
+	skb_set_inner_transport_header(skb, skb_transport_offset(skb) + PSP_ENCAP_HLEN);
+	skb->encapsulation = 1;
+	psp_write_headers(net, skb, spi, ver,
+			  skb->len - skb_transport_offset(skb), sport);
+
+	return true;
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
+	if (!psp_encapsulate(net, skb, psp_st->spi, psp_st->ver, 0)) {
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
index 55a8629f0792..fd9969ce5e0f 100644
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
 
@@ -298,7 +304,7 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		stats->packets++;
 	}
 
-	attr->insz = mlx5e_accel_tx_ids_len(sq, accel);
+	attr->insz = mlx5e_accel_tx_ids_len(sq, skb, accel);
 	stats->bytes += attr->num_bytes;
 }
 
@@ -668,7 +674,7 @@ static void mlx5e_txwqe_build_eseg(struct mlx5e_priv *priv, struct mlx5e_txqsq *
 				   struct sk_buff *skb, struct mlx5e_accel_tx_state *accel,
 				   struct mlx5_wqe_eth_seg *eseg, u16 ihs)
 {
-	mlx5e_accel_tx_eseg(priv, skb, eseg, ihs);
+	mlx5e_accel_tx_eseg(priv, skb, accel, eseg, ihs);
 	mlx5e_txwqe_build_eseg_csum(sq, skb, accel, eseg);
 	if (unlikely(sq->ptpsq))
 		mlx5e_cqe_ts_id_eseg(sq->ptpsq, skb, eseg);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/psp_defs.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/psp_defs.h
new file mode 100644
index 000000000000..7dd2aa90ed62
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/psp_defs.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef _LIB_PSP_DEFS_H
+#define _LIB_PSP_DEFS_H
+
+/*  PSP Security Payload (PSP) Header
+ *
+ *  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |  Next Header  |  Hdr Ext Len  |  Crypt Offset | R |Version|V|1|
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |                Security Parameters Index (SPI)                |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |                                                               |
+ * +                  Initialization Vector (IV)                   +
+ * |                                                               |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |                Virtualization Key (VK) [Optional]             |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |                  Pad to 8*N bytes [if needed]                 |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ */
+
+/* total length of headers for PSP encapsulation (UDP + PSP) */
+#define PSP_ENCAP_HLEN (sizeof(struct udphdr) + sizeof(struct psphdr))
+
+#endif  /* _LIB_PSP_DEFS_H */
-- 
2.47.1


