Return-Path: <netdev+bounces-201180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A899FAE8541
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32203189F102
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CE2268C63;
	Wed, 25 Jun 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+fUD2qz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D52690DB
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859552; cv=none; b=GKH52w5h7S2xH+KloYb5pn1hEPNQ7dZsHOsPbQCxePTXzBJMf2jdX2iTxbdV1zbmUJLqH8y5D7S8fKCorG4crPhhOpNVhY9OfImR9D397Y1pyUbsg4qlS+60NAGJAp1lSHJBgdnH0BXxHjXz7caMmGYnmlUqcbqUflhhOZepQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859552; c=relaxed/simple;
	bh=fxejsVV0XT7gfjE1WslApeDNp9qNZKwPsVh4Wq9zsLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxycVUaBj4/R02yxu2nMa6bpep7QOGiuoIEZRLLBA9K9JkQ2rt/1Wr0NY+Ywphxt2YgJWKSRuD5tkTTxJrk+C9nIzG9Pqwd3BHw3nTe16DlL7mU1f5JNiElAdyBcBfgh1xymKcn2HfugeThP/yp5jMZoIKy0crajMdN/BxH7nfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+fUD2qz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7086dcab64bso57226097b3.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859550; x=1751464350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+TkVd8WgwMWE6RJJSqtn8WubSTIEr6fGJLS4evqhg8=;
        b=S+fUD2qzE4fKrmkrnVIDzS4e44C8wsti703IaFW5fV2mFvkRB1DE1EhCH294C8j2ep
         +U+vMMGUVrEGOWJe+I61AZYrlw5leiBCNXgfbqS6llxk1aaqk5BYioiHn4sZx4jOqSBh
         uVIkp8b8MABlp9VrAxRkMi8SYBBnfT68XyioEPB3dwLeyWOhUQqF2OwHeHw/OrDlgV0f
         ra5p2p7wFAWu4XRRQly9ZI53zHc3WJKRGtjQSFldBHrmcON12eqz5iyfD6X8MV+5VyFx
         5vYxpCH64h189J3ZvswtNyiHEGRuTjdTbgfBtp8ydDxtdJwL6KzhHVTKzshaN9btXelJ
         txtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859550; x=1751464350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+TkVd8WgwMWE6RJJSqtn8WubSTIEr6fGJLS4evqhg8=;
        b=e63W2qB0RJscTnM8fqpc/X1fqTi0upc2nnZK7R5a7Nw+rX99/wm5FxaIddEUxqjpo7
         ZpTJqLJf7SGrXWz89SQrhpLUqp2Wv9vNf7o1YzPLpCXLpMPmaoBATiYaum7sO7Rsfyha
         sDEf+qCo+NmhLpjg1DaoMklC86JULZKoSnX2DMDvLc26Y6i5WwlCm/Y2NTF2tA1EJE/Y
         tLhZasldx2YfYyY7b3DSQ1BIuKxVP9KuKdP3cTRgSB1bZv/7fGdKW/gF1wq1jK76JY+t
         +zfkvPypXzDef4VS7kf/PnXlBZ39NlwY0r17bGkIJWp13IVfjUmjGgunNxhCdLW1rlhJ
         ygYw==
X-Forwarded-Encrypted: i=1; AJvYcCWkvfsLM4cGw1yyYXtR0XogWrwboIjowHUNrjP2o7Bn65/Zv3jBlvhqfOyhIMFKgv0v68mK4Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2KogX9Tg2gut+ga2V7kS/4xD7wL4Qlbd5bBZpsxr8L+63T35
	UFqUiW7GmE5jfJxOSj6NnUnPF+ELsLS/u+icDsJ6zPcpE2bKtKitZH99
X-Gm-Gg: ASbGncseW08s1fyzqSiY5JybAHfnOKtOaqqUZ9hSXpPhl0JtrmupmQ9b649/r9T23FQ
	O+6/XO9jbKfygSkiPpFA7qo0NxVmX1MEbTBZijzvHVvjywgT+E+moQl5X6yHoFZXtbKkTt2RalX
	gmzE4PlVc69piRirj+B8G0D44JJpNBFlKJNFwYwBtMr6/P+QaMMmyuuI39oCzTjL8G3lIFYVnyp
	S0jPuvfLxoh8/wx0qJsSgoTQmOzOYC+D1ETcdtPbL8JtlK4wfAq61ptVlcEErxJc5+KqMB8ftr7
	MCLxCPTZr9JCapKaHHEii5M8XxHJBIDaaa6PBl9xL78N8LxqUhIZT5T7u8A7
X-Google-Smtp-Source: AGHT+IFRZdlcvUN05eVWTX29x7lzewvRpKEociLcX+Rw/ItT124ppnAYKV5MzXWTPR5nsEWZludMNg==
X-Received: by 2002:a05:690c:f95:b0:707:dba5:2e44 with SMTP id 00721157ae682-71406ddf6demr44882387b3.30.1750859549726;
        Wed, 25 Jun 2025 06:52:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4a238f6sm24314057b3.48.2025.06.25.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:52:29 -0700 (PDT)
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
Subject: [PATCH v2 16/17] net/mlx5e: Add Rx data path offload
Date: Wed, 25 Jun 2025 06:52:06 -0700
Message-ID: <20250625135210.2975231-17-daniel.zahka@gmail.com>
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

On receive flow inspect received packets for PSP offload indication using
the cqe, for PSP offloaded packets set SKB PSP metadata i.e spi, header
length and key generation number to stack for further processing.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v2:
    - fill out new pse::dev_id field in psp_rcv()
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-15-kuba@kernel.org/

 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |  2 +-
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    | 81 +++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h    | 29 +++++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 50 +++++++++---
 4 files changed, 149 insertions(+), 13 deletions(-)

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
index 7ed59546db4e..86f21ac1ef63 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
@@ -15,6 +15,12 @@
 #include "en_accel/psp.h"
 #include "lib/psp_defs.h"
 
+enum {
+	MLX5E_PSP_OFFLOAD_RX_SYNDROME_DECRYPTED,
+	MLX5E_PSP_OFFLOAD_RX_SYNDROME_AUTH_FAILED,
+	MLX5E_PSP_OFFLOAD_RX_SYNDROME_BAD_TRAILER,
+};
+
 static void mlx5e_psp_set_swp(struct sk_buff *skb,
 			      struct mlx5e_accel_tx_psp_state *psp_st,
 			      struct mlx5_wqe_eth_seg *eseg)
@@ -114,6 +120,81 @@ static bool mlx5e_psp_set_state(struct mlx5e_priv *priv,
 	return ret;
 }
 
+void mlx5e_psp_csum_complete(struct net_device *netdev, struct sk_buff *skb)
+{
+	pskb_trim(skb, skb->len - PSP_TRL_SIZE);
+}
+
+/* Receive handler for PSP packets.
+ *
+ * Presently it accepts only already-authenticated packets and does not
+ * support optional fields, such as virtualization cookies.
+ */
+static int psp_rcv(struct sk_buff *skb, u16 dev_id)
+{
+	const struct psphdr *psph;
+	int depth = 0, end_depth;
+	struct psp_skb_ext *pse;
+	struct ipv6hdr *ipv6h;
+	struct ethhdr *eth;
+	__be16 proto;
+	u32 spi;
+
+	eth = (struct ethhdr *)(skb->data);
+	proto = __vlan_get_protocol(skb, eth->h_proto, &depth);
+	if (proto != htons(ETH_P_IPV6))
+		return -EINVAL;
+
+	ipv6h = (struct ipv6hdr *)(skb->data + depth);
+	depth += sizeof(*ipv6h);
+	end_depth = depth + sizeof(struct udphdr) + sizeof(struct psphdr);
+
+	if (unlikely(end_depth > skb_headlen(skb)))
+		return -EINVAL;
+
+	pse = skb_ext_add(skb, SKB_EXT_PSP);
+	if (!pse)
+		return -EINVAL;
+
+	psph = (const struct psphdr *)(skb->data + depth + sizeof(struct udphdr));
+	pse->spi = psph->spi;
+	pse->dev_id = dev_id;
+	spi = ntohl(psph->spi);
+	pse->generation = 0;
+	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
+
+	ipv6h->nexthdr = psph->nexthdr;
+	ipv6h->payload_len =
+		htons(ntohs(ipv6h->payload_len) - PSP_ENCAP_HLEN - PSP_TRL_SIZE);
+
+	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, depth);
+	skb_pull(skb, PSP_ENCAP_HLEN);
+
+	return 0;
+}
+
+bool mlx5e_psp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
+				     struct mlx5_cqe64 *cqe)
+{
+	u32 psp_meta_data = be32_to_cpu(cqe->ft_metadata);
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	u16 dev_id = priv->psp->psp->id;
+
+	/* TBD: report errors as SW counters to ethtool, any further handling ? */
+	if (MLX5_PSP_METADATA_SYNDROM(psp_meta_data) != MLX5E_PSP_OFFLOAD_RX_SYNDROME_DECRYPTED)
+		goto drop;
+
+	if (psp_rcv(skb, dev_id))
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
index 521b2c3620e6..e3cf34bafc24 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
@@ -10,6 +10,11 @@
 #include "en.h"
 #include "en/txrx.h"
 
+/* Bit30: PSP marker, Bit29-23: PSP syndrome, Bit22-0: PSP obj id */
+#define MLX5_PSP_METADATA_MARKER(metadata)  ((((metadata) >> 30) & 0x3) == 0x3)
+#define MLX5_PSP_METADATA_SYNDROM(metadata) (((metadata) >> 23) & GENMASK(6, 0))
+#define MLX5_PSP_METADATA_HANDLE(metadata)  ((metadata) & GENMASK(22, 0))
+
 struct mlx5e_accel_tx_psp_state {
 	u32 tailen;
 	u32 keyid;
@@ -75,6 +80,16 @@ static inline unsigned int mlx5e_psp_tx_ids_len(struct mlx5e_accel_tx_psp_state
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
+
+void mlx5e_psp_csum_complete(struct net_device *netdev, struct sk_buff *skb);
 #else
 static inline bool mlx5e_psp_is_offload_state(struct mlx5e_accel_tx_psp_state *psp_state)
 {
@@ -92,5 +107,19 @@ static inline bool mlx5e_psp_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struc
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
+
+static inline void mlx5e_psp_csum_complete(struct net_device *netdev, struct sk_buff *skb) { }
 #endif /* CONFIG_MLX5_EN_PSP */
 #endif /* __MLX5E_PSP_RXTX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 2bb32082bfcc..4456971eba8c 100644
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
@@ -1518,6 +1519,12 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 		skb->ip_summed = CHECKSUM_COMPLETE;
 		skb->csum = csum_unfold((__force __sum16)cqe->check_sum);
 
+		if (unlikely(mlx5e_psp_is_rx_flow(cqe))) {
+			/* TBD: PSP csum complete corrections for now chose csum_unnecessary path */
+			mlx5e_psp_csum_complete(netdev, skb);
+			goto csum_unnecessary;
+		}
+
 		if (test_bit(MLX5E_RQ_STATE_CSUM_FULL, &rq->state))
 			return; /* CQE csum covers all received bytes */
 
@@ -1546,7 +1553,7 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 
 #define MLX5E_CE_BIT_MASK 0x80
 
-static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
+static inline bool mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 				      u32 cqe_bcnt,
 				      struct mlx5e_rq *rq,
 				      struct sk_buff *skb)
@@ -1560,6 +1567,11 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
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
@@ -1603,9 +1615,11 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
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
@@ -1615,16 +1629,20 @@ static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
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
@@ -1633,7 +1651,7 @@ static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 
 	stats->packets++;
 	stats->bytes += cqe_bcnt;
-	mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
+	return mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
 }
 
 static inline
@@ -1850,7 +1868,8 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto wq_cyc_pop;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -1897,7 +1916,8 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto wq_cyc_pop;
 
 	if (rep->vlan && skb_vlan_tag_present(skb))
 		skb_vlan_pop(skb);
@@ -1946,7 +1966,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto mpwrq_cqe_out;
 
 	mlx5e_rep_tc_receive(cqe, rq, skb);
 
@@ -2383,7 +2404,10 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
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
@@ -2441,7 +2465,8 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto mpwrq_cqe_out;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -2774,7 +2799,8 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 	if (!skb)
 		goto wq_cyc_pop;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto wq_cyc_pop;
 	skb_push(skb, ETH_HLEN);
 
 	mlx5_devlink_trap_report(rq->mdev, trap_id, skb,
-- 
2.47.1


