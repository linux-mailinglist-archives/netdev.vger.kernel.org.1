Return-Path: <netdev+bounces-95272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD58C1CB9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FED1F228F9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401514A61B;
	Fri, 10 May 2024 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwVdUNTB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135A14A612
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310292; cv=none; b=fPSSo2gY/ivZc1/rFvjVHRlYzIxMna3g+DjB7rl9cZ0dNxwkDoLEUY3lJo1oOXWLHJNatMyC6XnT5ZRq2jSAtzgHeeDnU3m3LfdmIagEnKpv5guw437a/2xWFTAc8acOW3tr4hpY3vBburxqQiC2sjWyT9XNebX4FgFeazeYj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310292; c=relaxed/simple;
	bh=Ko7QWpB5UW2oDWL/PPysLgB3odYnHMO/QHDwLoXXCes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPIWXWc53n2b6MJV7UaOsxVjGEHTr7Kca9+PAYO+oMm6z8a/0E/e2K6FRvvUme+CIDhtXEyf/k6p8rP3J8IGejhmUAn/vCRM6iLECiOPyEp0U+WlS4c+mmXPpiWy5QsWDJPLNUV2+ULV0a1npvNxLf6Z9obwSMd2pkTjqWh0XDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwVdUNTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC36C2BBFC;
	Fri, 10 May 2024 03:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310292;
	bh=Ko7QWpB5UW2oDWL/PPysLgB3odYnHMO/QHDwLoXXCes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nwVdUNTBqCicDcN9D7B1WIkBXUQfsHjA4RFJ+SRo4AIFb6jFEwmgLgp8rBfbq5aZ9
	 9FD4qZpOHh00lAurSGShSmu4XG9yIzwMtOtvnnTXD+w7FuvZRn8tjT+2/t9Mm8AlKo
	 6zchNVdMNe6Q/TE8oluJmtt7SKPOhK4mAtD5As25Vbws+5e5t4Xeyo1+fxV50PhyzV
	 I5F8ieRzsYzyEJKQeRhGh+v12awaJPbXmwE+ReVB+Zbkjydr8DGC313vVvmdVDjEVy
	 ayPnN8DKwPFkphFCh66m8m5MsECqmD+bE4Ixz8AxyskyRdMqf3REfSHMMriJcqwjVW
	 Ac3Vsm6roudmA==
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
Subject: [RFC net-next 11/15] net/mlx5e: Implement PSP Tx data path
Date: Thu,  9 May 2024 20:04:31 -0700
Message-ID: <20240510030435.120935-12-kuba@kernel.org>
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

Setup PSP offload on Tx data path based on whether skb indicates that it is
intended for PSP or not. Support driver side encapsulation of the UDP
headers, PSP headers, and PSP trailer for the PSP traffic that will be
encrypted by the NIC.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |  28 +++
 .../mellanox/mlx5/core/en_accel/nisp_rxtx.c   | 225 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nisp_rxtx.h   |  96 ++++++++
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  10 +-
 .../mellanox/mlx5/core/lib/psp_defs.h         |  28 +++
 7 files changed, 390 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/psp_defs.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 5ce78b84c763..858ab2e7cb1f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -109,7 +109,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_PSP) += en_accel/nisp.o en_accel/nisp_offload.o en_accel/nisp_fs.o
+mlx5_core-$(CONFIG_MLX5_EN_PSP) += en_accel/nisp.o en_accel/nisp_offload.o en_accel/nisp_fs.o \
+				   en_accel/nisp_rxtx.o
 
 mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/dr_domain.o steering/dr_table.o \
 					steering/dr_matcher.o steering/dr_rule.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index b7ceb8011a92..92e2554d6271 100644
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
index c15e48b0724c..cea997847fa4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -43,6 +43,7 @@
 #include "en.h"
 #include "en/txrx.h"
 #include "en_accel/nisp_fs.h"
+#include "en_accel/nisp_rxtx.h"
 
 #if IS_ENABLED(CONFIG_GENEVE)
 #include <net/geneve.h>
@@ -114,6 +115,9 @@ struct mlx5e_accel_tx_state {
 #ifdef CONFIG_MLX5_EN_IPSEC
 	struct mlx5e_accel_tx_ipsec_state ipsec;
 #endif
+#ifdef CONFIG_MLX5_EN_PSP
+	struct mlx5e_accel_tx_nisp_state nisp_st;
+#endif
 };
 
 static inline bool mlx5e_accel_tx_begin(struct net_device *dev,
@@ -132,6 +136,13 @@ static inline bool mlx5e_accel_tx_begin(struct net_device *dev,
 			return false;
 #endif
 
+#ifdef CONFIG_MLX5_EN_PSP
+	if (mlx5e_psp_is_offload(skb, dev)) {
+		if (unlikely(!mlx5e_nisp_handle_tx_skb(dev, skb, &state->nisp_st)))
+			return false;
+	}
+#endif
+
 #ifdef CONFIG_MLX5_EN_IPSEC
 	if (test_bit(MLX5E_SQ_STATE_IPSEC, &sq->state) && xfrm_offload(skb)) {
 		if (unlikely(!mlx5e_ipsec_handle_tx_skb(dev, skb, &state->ipsec)))
@@ -152,8 +163,14 @@ static inline bool mlx5e_accel_tx_begin(struct net_device *dev,
 }
 
 static inline unsigned int mlx5e_accel_tx_ids_len(struct mlx5e_txqsq *sq,
+						  struct sk_buff *skb,
 						  struct mlx5e_accel_tx_state *state)
 {
+#ifdef CONFIG_MLX5_EN_PSP
+	if (mlx5e_psp_is_offload_state(&state->nisp_st))
+		return mlx5e_nisp_tx_ids_len(&state->nisp_st);
+#endif
+
 #ifdef CONFIG_MLX5_EN_IPSEC
 	if (test_bit(MLX5E_SQ_STATE_IPSEC, &sq->state))
 		return mlx5e_ipsec_tx_ids_len(&state->ipsec);
@@ -167,8 +184,14 @@ static inline unsigned int mlx5e_accel_tx_ids_len(struct mlx5e_txqsq *sq,
 
 static inline void mlx5e_accel_tx_eseg(struct mlx5e_priv *priv,
 				       struct sk_buff *skb,
+				       struct mlx5e_accel_tx_state *accel,
 				       struct mlx5_wqe_eth_seg *eseg, u16 ihs)
 {
+#ifdef CONFIG_MLX5_EN_PSP
+	if (mlx5e_psp_is_offload_state(&accel->nisp_st))
+		mlx5e_nisp_tx_build_eseg(priv, skb, &accel->nisp_st, eseg);
+#endif
+
 #ifdef CONFIG_MLX5_EN_IPSEC
 	if (xfrm_offload(skb))
 		mlx5e_ipsec_tx_build_eseg(priv, skb, eseg);
@@ -194,6 +217,11 @@ static inline void mlx5e_accel_tx_finish(struct mlx5e_txqsq *sq,
 	mlx5e_ktls_handle_tx_wqe(&wqe->ctrl, &state->tls);
 #endif
 
+#ifdef CONFIG_MLX5_EN_PSP
+	if (mlx5e_psp_is_offload_state(&state->nisp_st))
+		mlx5e_nisp_handle_tx_wqe(wqe, &state->nisp_st, inlseg);
+#endif
+
 #ifdef CONFIG_MLX5_EN_IPSEC
 	if (test_bit(MLX5E_SQ_STATE_IPSEC, &sq->state) &&
 	    state->ipsec.xo && state->ipsec.tailen)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
new file mode 100644
index 000000000000..c719b2916677
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
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
+#include "../nisp.h"
+#include "en_accel/nisp_rxtx.h"
+#include "en_accel/nisp.h"
+#include "lib/psp_defs.h"
+
+static void mlx5e_nisp_set_swp(struct sk_buff *skb,
+			       struct mlx5e_accel_tx_nisp_state *nisp_st,
+			       struct mlx5_wqe_eth_seg *eseg)
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
+		nisp_st->inner_ipproto = inner_ipproto;
+	}
+}
+
+static bool mlx5e_nisp_set_state(struct mlx5e_priv *priv,
+				 struct sk_buff *skb,
+				 struct mlx5e_accel_tx_nisp_state *nisp_st)
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
+	nisp_st->tailen = PSP_TRL_SIZE;
+	nisp_st->spi = pas->tx.spi;
+	nisp_st->ver = pas->version;
+	memcpy(&nisp_st->keyid, pas->drv_data, sizeof(nisp_st->keyid));
+
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+void mlx5e_nisp_tx_build_eseg(struct mlx5e_priv *priv, struct sk_buff *skb,
+			      struct mlx5e_accel_tx_nisp_state *nisp_st,
+			      struct mlx5_wqe_eth_seg *eseg)
+{
+	if (!mlx5_is_nisp_device(priv->mdev))
+		return;
+
+	if (unlikely(skb->protocol != htons(ETH_P_IP) &&
+		     skb->protocol != htons(ETH_P_IPV6)))
+		return;
+
+	mlx5e_nisp_set_swp(skb, nisp_st, eseg);
+	/* Special WA for PSP LSO in ConnectX7 */
+	eseg->swp_outer_l3_offset = 0;
+	eseg->swp_inner_l3_offset = 0;
+
+	eseg->flow_table_metadata |= cpu_to_be32(nisp_st->keyid);
+	eseg->trailer |= cpu_to_be32(MLX5_ETH_WQE_INSERT_TRAILER) |
+			 cpu_to_be32(MLX5_ETH_WQE_TRAILER_HDR_OUTER_L4_ASSOC);
+}
+
+void mlx5e_nisp_handle_tx_wqe(struct mlx5e_tx_wqe *wqe,
+			      struct mlx5e_accel_tx_nisp_state *nisp_st,
+			      struct mlx5_wqe_inline_seg *inlseg)
+{
+	inlseg->byte_count = cpu_to_be32(nisp_st->tailen | MLX5_INLINE_SEG);
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
+bool mlx5e_nisp_handle_tx_skb(struct net_device *netdev,
+			      struct sk_buff *skb,
+			      struct mlx5e_accel_tx_nisp_state *nisp_st)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct net *net = sock_net(skb->sk);
+	const struct ipv6hdr *ip6;
+	struct tcphdr *th;
+
+	if (!mlx5e_nisp_set_state(priv, skb, nisp_st))
+		return true;
+
+	/* psp_encap of the packet */
+	if (!psp_encapsulate(net, skb, nisp_st->spi, nisp_st->ver, 0)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_PSP_OUTPUT);
+		return false;
+	}
+	if (skb_is_gso(skb)) {
+		ip6 = ipv6_hdr(skb);
+		th = inner_tcp_hdr(skb);
+
+		th->check = ~tcp_v6_check(skb_shinfo(skb)->gso_size + inner_tcp_hdrlen(skb), &ip6->saddr,
+				&ip6->daddr, 0);
+	}
+
+	return true;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h
new file mode 100644
index 000000000000..1350a73c2019
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5E_NISP_RXTX_H__
+#define __MLX5E_NISP_RXTX_H__
+
+#include <linux/skbuff.h>
+#include <net/xfrm.h>
+#include <net/psp.h>
+#include "en.h"
+#include "en/txrx.h"
+
+struct mlx5e_accel_tx_nisp_state {
+	u32 tailen;
+	u32 keyid;
+	__be32 spi;
+	u8 inner_ipproto;
+	u8 ver;
+};
+
+#ifdef CONFIG_MLX5_EN_PSP
+static inline bool mlx5e_psp_is_offload_state(struct mlx5e_accel_tx_nisp_state *nisp_state)
+{
+	return (nisp_state->tailen != 0);
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
+bool mlx5e_nisp_handle_tx_skb(struct net_device *netdev,
+			      struct sk_buff *skb,
+			      struct mlx5e_accel_tx_nisp_state *nisp_st);
+
+void mlx5e_nisp_tx_build_eseg(struct mlx5e_priv *priv, struct sk_buff *skb,
+			      struct mlx5e_accel_tx_nisp_state *nisp_st,
+			      struct mlx5_wqe_eth_seg *eseg);
+
+void mlx5e_nisp_handle_tx_wqe(struct mlx5e_tx_wqe *wqe,
+			      struct mlx5e_accel_tx_nisp_state *nisp_st,
+			      struct mlx5_wqe_inline_seg *inlseg);
+
+static inline bool mlx5e_nisp_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
+						    struct mlx5e_accel_tx_nisp_state *nisp_st,
+						    struct mlx5_wqe_eth_seg *eseg)
+{
+	u8 inner_ipproto;
+
+	if (!mlx5e_psp_is_offload_state(nisp_st))
+		return false;
+
+	inner_ipproto = nisp_st->inner_ipproto;
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
+static inline unsigned int mlx5e_nisp_tx_ids_len(struct mlx5e_accel_tx_nisp_state *nisp_st)
+{
+	return nisp_st->tailen;
+}
+#else
+static inline bool mlx5e_psp_is_offload_state(struct mlx5e_accel_tx_nisp_state *nisp_state)
+{
+	return false;
+}
+
+static inline bool mlx5e_psp_is_offload(struct sk_buff *skb, struct net_device *netdev)
+{
+	return false;
+}
+
+static inline bool mlx5e_nisp_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
+						    struct mlx5e_accel_tx_nisp_state *nisp_st,
+						    struct mlx5_wqe_eth_seg *eseg)
+{
+	return false;
+}
+#endif
+#endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 099bf1078889..cc4d236a976f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -39,6 +39,7 @@
 #include "ipoib/ipoib.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ipsec_rxtx.h"
+#include "en_accel/nisp_rxtx.h"
 #include "en_accel/macsec.h"
 #include "en/ptp.h"
 #include <net/ipv6.h>
@@ -120,6 +121,11 @@ mlx5e_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 			    struct mlx5e_accel_tx_state *accel,
 			    struct mlx5_wqe_eth_seg *eseg)
 {
+#ifdef CONFIG_MLX5_EN_PSP
+	if (unlikely(mlx5e_nisp_txwqe_build_eseg_csum(sq, skb, &accel->nisp_st, eseg)))
+		return;
+#endif
+
 	if (unlikely(mlx5e_ipsec_txwqe_build_eseg_csum(sq, skb, eseg)))
 		return;
 
@@ -294,7 +300,7 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		stats->packets++;
 	}
 
-	attr->insz = mlx5e_accel_tx_ids_len(sq, accel);
+	attr->insz = mlx5e_accel_tx_ids_len(sq, skb, accel);
 	stats->bytes += attr->num_bytes;
 }
 
@@ -663,7 +669,7 @@ static void mlx5e_txwqe_build_eseg(struct mlx5e_priv *priv, struct mlx5e_txqsq *
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
2.45.0


