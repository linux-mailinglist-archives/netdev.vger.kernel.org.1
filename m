Return-Path: <netdev+bounces-99167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E78D3E74
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B151C21430
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362E5181CE2;
	Wed, 29 May 2024 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnD/l12H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F53426286
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007936; cv=none; b=Co9urEiXzUpawu+NdShjMeufElwxflDFpLHcX6MPvNElOyIcdXcatQ3qGBrlDPOopA7zq356syaE/O8XHAOjVG6aLgbG3BrTpKsAlZZ3/21+ZRw5soZQ7YXASQO2OBIEQkLILTzdr516vI6l9tWLdFSq+ZtrBDW4LIfu1WBiwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007936; c=relaxed/simple;
	bh=J//ItsTHjshoBq1fbsvP0grhv7hdfMhV51+cWUKHTDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvNdyV1Ndj2ViQFfTt3d1xIgyZq+HTyA1sv0WuHWA+5ezZ4Y/rkK3uzUlZBa0TOxgqPAjcZy72AX9MngV1aEBUs11mUlKX3ixSZuzUnw4nhPrfp4I7XVNlb2E5qro6MpdTv9kVUqrsC1oHXqAJ4OKWTxPJxoojzHJ+sOoedSBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnD/l12H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B030C113CC;
	Wed, 29 May 2024 18:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717007935;
	bh=J//ItsTHjshoBq1fbsvP0grhv7hdfMhV51+cWUKHTDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZnD/l12Hftq0O7nYJvGQq3/IS39EnwhtBkYiqJ58dUBdUn7D+rmAWg+6NmWjdlG6j
	 0qQu0SfQKDV4Y4k3d7u6v3hUGDKcsy0US1mHGm8VPPrjfdVm2xRUswiAb/HZUPct5X
	 DaisZEXcWf7lO42Kj7d0hpQV7Qotk0YUuuh7YCXBASTxEQWmF36gY0HhT2/0L3Wqv7
	 SbM3j/LstsP7XkCwTKMqXR3vyQkjo5kFW6n7IjXhvuuF2l5tWKSid2BWP4yWI/gNUv
	 tLJNjnq5i28OR/mL22E+sifwZOmVCkKM0jwypaxj3guUfiKmSrMJxYpq3G1wy1uT57
	 Bw8827GcI19Pg==
Date: Wed, 29 May 2024 11:38:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: cratiu@nvidia.com, rrameshbabu@nvidia.com, Raed Salem <raeds@nvidia.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, pabeni@redhat.com, borisp@nvidia.com,
 gal@nvidia.com, steffen.klassert@secunet.com, tariqt@nvidia.com
Subject: Re: [RFC net-next 14/15] net/mlx5e: Add Rx data path offload
Message-ID: <20240529113854.14fd929e@kernel.org>
In-Reply-To: <664172ded406f_1d6c6729412@willemb.c.googlers.com.notmuch>
References: <20240510030435.120935-1-kuba@kernel.org>
	<20240510030435.120935-15-kuba@kernel.org>
	<664172ded406f_1d6c6729412@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 May 2024 21:54:38 -0400 Willem de Bruijn wrote:
> > +	/* TBD: report errors as SW counters to ethtool, any further handling ? */
> > +	switch (MLX5_NISP_METADATA_SYNDROM(nisp_meta_data)) {
> > +	case MLX5E_NISP_OFFLOAD_RX_SYNDROME_DECRYPTED:
> > +		if (psp_rcv(skb))
> > +			netdev_warn_once(netdev, "PSP handling failed");
> > +		skb->decrypted = 1;  
> 
> Do not set skb->decrypted if psp_rcv failed? But drop the packet and
> account the drop, likely.

nVidia folks does this seem reasonable?

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
index 7ae3e8246d8f..8cf6a8daf721 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
@@ -172,22 +172,24 @@ static int psp_rcv(struct sk_buff *skb)
 	return 0;
 }
 
-void mlx5e_nisp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
+bool mlx5e_nisp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
 				      struct mlx5_cqe64 *cqe)
 {
 	u32 nisp_meta_data = be32_to_cpu(cqe->ft_metadata);
 
 	/* TBD: report errors as SW counters to ethtool, any further handling ? */
-	switch (MLX5_NISP_METADATA_SYNDROM(nisp_meta_data)) {
-	case MLX5E_NISP_OFFLOAD_RX_SYNDROME_DECRYPTED:
-		if (psp_rcv(skb))
-			netdev_warn_once(netdev, "PSP handling failed");
-		skb->decrypted = 1;
-		break;
-	default:
-		WARN_ON_ONCE(true);
-		break;
-	}
+	if (MLX5_NISP_METADATA_SYNDROM(nisp_meta_data) != MLX5E_NISP_OFFLOAD_RX_SYNDROME_DECRYPTED)
+		goto drop;
+
+	if (psp_rcv(skb))
+		goto drop;
+
+	skb->decrypted = 1;
+	return false;
+
+drop:
+	kfree_skb(skb);
+	return true;
 }
 
 void mlx5e_nisp_tx_build_eseg(struct mlx5e_priv *priv, struct sk_buff *skb,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h
index 834481232b21..1e13b09b3522 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h
@@ -86,7 +86,7 @@ static inline bool mlx5e_nisp_is_rx_flow(struct mlx5_cqe64 *cqe)
 	return MLX5_NISP_METADATA_MARKER(be32_to_cpu(cqe->ft_metadata));
 }
 
-void mlx5e_nisp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
+bool mlx5e_nisp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
 				      struct mlx5_cqe64 *cqe);
 
 void mlx5e_nisp_csum_complete(struct net_device *netdev, struct sk_buff *skb);
@@ -113,10 +113,11 @@ static inline bool mlx5e_nisp_is_rx_flow(struct mlx5_cqe64 *cqe)
 	return false;
 }
 
-static inline void mlx5e_nisp_offload_handle_rx_skb(struct net_device *netdev,
+static inline bool mlx5e_nisp_offload_handle_rx_skb(struct net_device *netdev,
 						    struct sk_buff *skb,
 						    struct mlx5_cqe64 *cqe)
 {
+	return false;
 }
 
 static inline void mlx5e_nisp_csum_complete(struct net_device *netdev, struct sk_buff *skb) { }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index ed3c7d8cf99d..22cf1c563844 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1552,7 +1552,7 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 
 #define MLX5E_CE_BIT_MASK 0x80
 
-static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
+static inline bool mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 				      u32 cqe_bcnt,
 				      struct mlx5e_rq *rq,
 				      struct sk_buff *skb)
@@ -1566,8 +1566,10 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 	if (unlikely(get_cqe_tls_offload(cqe)))
 		mlx5e_ktls_handle_rx_skb(rq, skb, cqe, &cqe_bcnt);
 
-	if (unlikely(mlx5e_nisp_is_rx_flow(cqe)))
-		mlx5e_nisp_offload_handle_rx_skb(netdev, skb, cqe);
+	if (unlikely(mlx5e_nisp_is_rx_flow(cqe))) {
+		if (mlx5e_nisp_offload_handle_rx_skb(netdev, skb, cqe))
+			return true;
+	}
 
 	if (unlikely(mlx5_ipsec_is_rx_flow(cqe)))
 		mlx5e_ipsec_offload_handle_rx_skb(netdev, skb,
@@ -1612,9 +1614,11 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
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
@@ -1626,16 +1630,20 @@ static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
 	stats->bytes += cqe_bcnt;
 	stats->gro_bytes += cqe_bcnt;
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
@@ -1644,7 +1652,7 @@ static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 
 	stats->packets++;
 	stats->bytes += cqe_bcnt;
-	mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
+	return mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
 }
 
 static inline
@@ -1858,7 +1866,8 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto wq_cyc_pop;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -1905,7 +1914,8 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto wq_cyc_pop;
 
 	if (rep->vlan && skb_vlan_tag_present(skb))
 		skb_vlan_pop(skb);
@@ -1954,7 +1964,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto mpwrq_cqe_out;
 
 	mlx5e_rep_tc_receive(cqe, rq, skb);
 
@@ -2375,7 +2386,10 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 		mlx5e_fill_skb_data(*skb, rq, frag_page, data_bcnt, data_offset);
 	}
 
-	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
+	if (mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb)) {
+		*skb = NULL;
+		goto free_hd_entry;
+	}
 	if (flush)
 		mlx5e_shampo_flush_skb(rq, cqe, match);
 free_hd_entry:
@@ -2429,7 +2443,8 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto mpwrq_cqe_out;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -2762,7 +2777,8 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 	if (!skb)
 		goto wq_cyc_pop;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb))
+		goto wq_cyc_pop;
 	skb_push(skb, ETH_HLEN);
 
 	mlx5_devlink_trap_report(rq->mdev, trap_id, skb,

