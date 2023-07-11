Return-Path: <netdev+bounces-16748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B23674EA89
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F3E2815FB
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C68B17FE9;
	Tue, 11 Jul 2023 09:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DC5182A0
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAF6C43395;
	Tue, 11 Jul 2023 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689067771;
	bh=8aySs3ZeSvljek9AAXretug94/Z1TaNr6HOG9L+bY0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYrpkPP7s9VJqnM9y4lNHE/JreAHlNStf8mxY3XAm98YrhUUU6F+hAOodEy3c0S3v
	 MSj2INsgxPBqap9w6xwwTObm7F3bJdw7mKEkwKRBHChQ5C7TgeQ+7NzKJr0UqYSNnZ
	 EEsElD49E09zXNOmi/C3CHm0ykn0ACipBO/pi/C/aVXDUhdgEJMmbW8G5KK7iL83NO
	 Q/UgFOKRG+c33MCWJFeGxI2/VvyW1VfcEP3z6oSi6U8xGfUl9eyyVLKLrmbeayO+Yc
	 rpRZhYQ0Y7mSoy5pWycVXayEZSEl0pSF2rXXDqcFWkD72MWEV/MaiLFTso7w6xM9Oe
	 uIP1zdi/xKs+g==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next 02/12] net/mlx5e: Change the parameter of IPsec RX skb handle function
Date: Tue, 11 Jul 2023 12:29:00 +0300
Message-ID: <df1c2f9e00e49a9a06e98effce5569bf17a1e05c.1689064922.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689064922.git.leonro@nvidia.com>
References: <cover.1689064922.git.leonro@nvidia.com>
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
index 704b022cd1f0..b9e92456ec4d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1535,7 +1535,8 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 		mlx5e_ktls_handle_rx_skb(rq, skb, cqe, &cqe_bcnt);
 
 	if (unlikely(mlx5_ipsec_is_rx_flow(cqe)))
-		mlx5e_ipsec_offload_handle_rx_skb(netdev, skb, cqe);
+		mlx5e_ipsec_offload_handle_rx_skb(netdev, skb,
+						  be32_to_cpu(cqe->ft_metadata));
 
 	if (unlikely(mlx5e_macsec_is_rx_flow(cqe)))
 		mlx5e_macsec_offload_handle_rx_skb(netdev, skb, cqe);
-- 
2.41.0


