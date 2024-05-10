Return-Path: <netdev+bounces-95275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B88C1CBC
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A734280F03
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B317A14BF8F;
	Fri, 10 May 2024 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYcBnEqf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072614BF89
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310294; cv=none; b=MJsIc/R9elNvrsBOWcl583Vd5JG/mi2xMoxgw/WUNASPD1T7Yv8JDVX7ODiC15AVl7kvI7lTbv2sN3w2xa3ZyCI/AoiFIDRFVWh4V8/PZPUZ+15Dsu9DDpjsz0dmEK1916UgFEGTX17NT3cQUSGCU2wf7UgmpgDfzQ0sQc2vs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310294; c=relaxed/simple;
	bh=uqerNasafMvLz+XQH8HDuoRTvTgcSKRMJ5oF0hiHI6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqY5iUGGGgNz82MwANt2BusEUv4BbycfyGVr/oj49uicg/KzdyZlZjm52swpX5wr/lyrSHhEQeMc2hG0dbJO4HC5L9vqo+ZoNerH37iwQCg8PlQy2RuOezULZOkO4lhf7IsZ+aOrxjnVwNNtWhoEgO7ap0CWHgEPaEscPdyk41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYcBnEqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39B6C2BBFC;
	Fri, 10 May 2024 03:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310294;
	bh=uqerNasafMvLz+XQH8HDuoRTvTgcSKRMJ5oF0hiHI6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYcBnEqf30wGPQ17Xg4+Ky+43fl222rBwDvSqb2r+pRdTmi22H7iyggyG9tNgxk/r
	 YxFh3AY1eRwiTOCeiuXBLgbLKKBgFBvDSJ9dpvE/zMajtZ7cRWHdm1Yj5gBDr+B6bq
	 OJw2NTJuqjumdB93t9PJgiSSXHvhQiUT0IVbiCLkqNJr8w/6mKXiEIDUg999KKBu9/
	 8NOY6e0izzUx9+pcxDMmrDst5yJYaS1jfYLLUQEcmzq2RRrpjaDBWhiJOwX7j61c4a
	 hIx7HHUODc9aBqL39NyiX5OMlLf9YwnGsrEjuQQJwLRFDcgnC3UbcV2hjlA5sEN3nc
	 R8qCnApxVvqBA==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com,
	tariqt@nvidia.com,
	Raed Salem <raeds@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 14/15] net/mlx5e: Add Rx data path offload
Date: Thu,  9 May 2024 20:04:34 -0700
Message-ID: <20240510030435.120935-15-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510030435.120935-1-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
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
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |  2 +-
 .../mellanox/mlx5/core/en_accel/nisp_rxtx.c   | 79 +++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nisp_rxtx.h   | 28 +++++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 10 +++
 4 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 82064614846f..9f025c80a6ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -40,7 +40,7 @@
 #include "en/txrx.h"
 
 /* Bit31: IPsec marker, Bit30: reserved, Bit29-24: IPsec syndrome, Bit23-0: IPsec obj id */
-#define MLX5_IPSEC_METADATA_MARKER(metadata)  (((metadata) >> 31) & 0x1)
+#define MLX5_IPSEC_METADATA_MARKER(metadata)  ((((metadata) >> 30) & 0x3) == 0x2)
 #define MLX5_IPSEC_METADATA_SYNDROM(metadata) (((metadata) >> 24) & GENMASK(5, 0))
 #define MLX5_IPSEC_METADATA_HANDLE(metadata)  ((metadata) & GENMASK(23, 0))
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
index c719b2916677..17f42b8d9fd8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
@@ -15,6 +15,12 @@
 #include "en_accel/nisp.h"
 #include "lib/psp_defs.h"
 
+enum {
+	MLX5E_NISP_OFFLOAD_RX_SYNDROME_DECRYPTED,
+	MLX5E_NISP_OFFLOAD_RX_SYNDROME_AUTH_FAILED,
+	MLX5E_NISP_OFFLOAD_RX_SYNDROME_BAD_TRAILER,
+};
+
 static void mlx5e_nisp_set_swp(struct sk_buff *skb,
 			       struct mlx5e_accel_tx_nisp_state *nisp_st,
 			       struct mlx5_wqe_eth_seg *eseg)
@@ -114,6 +120,79 @@ static bool mlx5e_nisp_set_state(struct mlx5e_priv *priv,
 	return ret;
 }
 
+void mlx5e_nisp_csum_complete(struct net_device *netdev, struct sk_buff *skb)
+{
+	pskb_trim(skb, skb->len - PSP_TRL_SIZE);
+}
+
+/* Receive handler for PSP packets.
+ *
+ * Presently it accepts only already-authenticated packets and does not
+ * support optional fields, such as virtualization cookies.
+ */
+static int psp_rcv(struct sk_buff *skb)
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
+void mlx5e_nisp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
+				      struct mlx5_cqe64 *cqe)
+{
+	u32 nisp_meta_data = be32_to_cpu(cqe->ft_metadata);
+
+	/* TBD: report errors as SW counters to ethtool, any further handling ? */
+	switch (MLX5_NISP_METADATA_SYNDROM(nisp_meta_data)) {
+	case MLX5E_NISP_OFFLOAD_RX_SYNDROME_DECRYPTED:
+		if (psp_rcv(skb))
+			netdev_warn_once(netdev, "PSP handling failed");
+		skb->decrypted = 1;
+		break;
+	case MLX5E_NISP_OFFLOAD_RX_SYNDROME_AUTH_FAILED:
+		break;
+	case MLX5E_NISP_OFFLOAD_RX_SYNDROME_BAD_TRAILER:
+		break;
+	default:
+		break;
+	}
+}
+
 void mlx5e_nisp_tx_build_eseg(struct mlx5e_priv *priv, struct sk_buff *skb,
 			      struct mlx5e_accel_tx_nisp_state *nisp_st,
 			      struct mlx5_wqe_eth_seg *eseg)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h
index 1350a73c2019..834481232b21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h
@@ -10,6 +10,11 @@
 #include "en.h"
 #include "en/txrx.h"
 
+/* Bit30: NISP marker, Bit29-23: NISP syndrome, Bit22-0: NISP obj id */
+#define MLX5_NISP_METADATA_MARKER(metadata)  ((((metadata) >> 30) & 0x3) == 0x3)
+#define MLX5_NISP_METADATA_SYNDROM(metadata) (((metadata) >> 23) & GENMASK(6, 0))
+#define MLX5_NISP_METADATA_HANDLE(metadata)  ((metadata) & GENMASK(22, 0))
+
 struct mlx5e_accel_tx_nisp_state {
 	u32 tailen;
 	u32 keyid;
@@ -75,6 +80,16 @@ static inline unsigned int mlx5e_nisp_tx_ids_len(struct mlx5e_accel_tx_nisp_stat
 {
 	return nisp_st->tailen;
 }
+
+static inline bool mlx5e_nisp_is_rx_flow(struct mlx5_cqe64 *cqe)
+{
+	return MLX5_NISP_METADATA_MARKER(be32_to_cpu(cqe->ft_metadata));
+}
+
+void mlx5e_nisp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
+				      struct mlx5_cqe64 *cqe);
+
+void mlx5e_nisp_csum_complete(struct net_device *netdev, struct sk_buff *skb);
 #else
 static inline bool mlx5e_psp_is_offload_state(struct mlx5e_accel_tx_nisp_state *nisp_state)
 {
@@ -92,5 +107,18 @@ static inline bool mlx5e_nisp_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, stru
 {
 	return false;
 }
+
+static inline bool mlx5e_nisp_is_rx_flow(struct mlx5_cqe64 *cqe)
+{
+	return false;
+}
+
+static inline void mlx5e_nisp_offload_handle_rx_skb(struct net_device *netdev,
+						    struct sk_buff *skb,
+						    struct mlx5_cqe64 *cqe)
+{
+}
+
+static inline void mlx5e_nisp_csum_complete(struct net_device *netdev, struct sk_buff *skb) { }
 #endif
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index d601b5faaed5..41a4f8832f2f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -51,6 +51,7 @@
 #include "ipoib/ipoib.h"
 #include "en_accel/ipsec.h"
 #include "en_accel/macsec.h"
+#include "en_accel/nisp_rxtx.h"
 #include "en_accel/ipsec_rxtx.h"
 #include "en_accel/ktls_txrx.h"
 #include "en/xdp.h"
@@ -1517,6 +1518,12 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 		skb->ip_summed = CHECKSUM_COMPLETE;
 		skb->csum = csum_unfold((__force __sum16)cqe->check_sum);
 
+		if (unlikely(mlx5e_nisp_is_rx_flow(cqe))) {
+			/* TBD: PSP csum complete corrections for now chose csum_unnecessary path */
+			mlx5e_nisp_csum_complete(netdev, skb);
+			goto csum_unnecessary;
+		}
+
 		if (test_bit(MLX5E_RQ_STATE_CSUM_FULL, &rq->state))
 			return; /* CQE csum covers all received bytes */
 
@@ -1559,6 +1566,9 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 	if (unlikely(get_cqe_tls_offload(cqe)))
 		mlx5e_ktls_handle_rx_skb(rq, skb, cqe, &cqe_bcnt);
 
+	if (unlikely(mlx5e_nisp_is_rx_flow(cqe)))
+		mlx5e_nisp_offload_handle_rx_skb(netdev, skb, cqe);
+
 	if (unlikely(mlx5_ipsec_is_rx_flow(cqe)))
 		mlx5e_ipsec_offload_handle_rx_skb(netdev, skb,
 						  be32_to_cpu(cqe->ft_metadata));
-- 
2.45.0


