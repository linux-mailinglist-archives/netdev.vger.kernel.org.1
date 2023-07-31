Return-Path: <netdev+bounces-22791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE27694CD
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A071C20340
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEBF182A2;
	Mon, 31 Jul 2023 11:28:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18A182A1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E61C4339A;
	Mon, 31 Jul 2023 11:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690802918;
	bh=M1k0ISsjW/TTZHsoj693p+IwNlV79g3kigy4FnPOfyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGPiQIt9fr9Bl9IE8A443yvpP6BiFd3EbkW6NaWI89l8vw7Rtng2vEVxqE7VROZZ2
	 E27tRECMKqgKpqhx+s/Q7ovsI2Wn4SeG5r94di94/E58ZAVmFftFaHnrDQCLk4G7TA
	 WXLgws2fv+HiGHwiyoH/Sq4o78PiUie8YpqgMo3TYAVEogJMzM2eX0R+k7RGcK+5k5
	 dQJ3SfeQfV4CKqzsVDA4LNzii6okI31tXRYm7z4GbIj8E6yhHNgi7aB940Tlm94AQR
	 XrrdoPnCiYU44CEA5URBcG9t3wxTCLYGaQpP4qhAPc7PIqtnPJvc8YIQHi9O9afvWf
	 rL3Be+ICwAn+Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v1 02/13] net/mlx5e: Change the parameter of IPsec RX skb handle function
Date: Mon, 31 Jul 2023 14:28:13 +0300
Message-ID: <3b3c53f64660d464893eaecc41298b1ce49c6baa.1690802064.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690802064.git.leon@kernel.org>
References: <cover.1690802064.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

Refactor the function to pass in reg B value only.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c               | 3 ++-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index eab5bc718771..8d6379ac4574 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -309,9 +309,8 @@ enum {
 
 void mlx5e_ipsec_offload_handle_rx_skb(struct net_device *netdev,
 				       struct sk_buff *skb,
-				       struct mlx5_cqe64 *cqe)
+				       u32 ipsec_meta_data)
 {
-	u32 ipsec_meta_data = be32_to_cpu(cqe->ft_metadata);
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5e_ipsec *ipsec = priv->ipsec;
 	struct mlx5e_ipsec_sa_entry *sa_entry;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 1878a70b9031..436e9a8a32d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -66,7 +66,7 @@ void mlx5e_ipsec_handle_tx_wqe(struct mlx5e_tx_wqe *wqe,
 			       struct mlx5_wqe_inline_seg *inlseg);
 void mlx5e_ipsec_offload_handle_rx_skb(struct net_device *netdev,
 				       struct sk_buff *skb,
-				       struct mlx5_cqe64 *cqe);
+				       u32 ipsec_meta_data);
 static inline unsigned int mlx5e_ipsec_tx_ids_len(struct mlx5e_accel_tx_ipsec_state *ipsec_st)
 {
 	return ipsec_st->tailen;
@@ -145,7 +145,7 @@ mlx5e_ipsec_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 static inline
 void mlx5e_ipsec_offload_handle_rx_skb(struct net_device *netdev,
 				       struct sk_buff *skb,
-				       struct mlx5_cqe64 *cqe)
+				       u32 ipsec_meta_data)
 {}
 
 static inline bool mlx5e_ipsec_eseg_meta(struct mlx5_wqe_eth_seg *eseg)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 41d37159e027..f7bb5f4aaaca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1543,7 +1543,8 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 		mlx5e_ktls_handle_rx_skb(rq, skb, cqe, &cqe_bcnt);
 
 	if (unlikely(mlx5_ipsec_is_rx_flow(cqe)))
-		mlx5e_ipsec_offload_handle_rx_skb(netdev, skb, cqe);
+		mlx5e_ipsec_offload_handle_rx_skb(netdev, skb,
+						  be32_to_cpu(cqe->ft_metadata));
 
 	if (unlikely(mlx5e_macsec_is_rx_flow(cqe)))
 		mlx5e_macsec_offload_handle_rx_skb(netdev, skb, cqe);
-- 
2.41.0


