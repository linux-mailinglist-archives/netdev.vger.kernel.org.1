Return-Path: <netdev+bounces-41211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB457CA3D9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A351C20AA9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41651CA88;
	Mon, 16 Oct 2023 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgp5XtPL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341B1CA86
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D48C433C8;
	Mon, 16 Oct 2023 09:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697447751;
	bh=yO0zpDsVN/aEhN1dro+VBGypkRk8Mr1MXrELk1JJCLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgp5XtPLjd4Lo9xJi5lajj9S3tRoo8ZRbB8eSNKa7M21zqeNHKXfxHgRPJQySxR43
	 aAmh+nz6dRuB51qqNWycktGQpukVgWwwALK8ZOAzaftcY6jyJ2zu/NCyolqcSQquoR
	 Ie/G+PF96wM9Ks/0suOQ1nz0IjjBnbLni3zzG63ImjK7sCCzvyCan7EXTtgaYuvMH0
	 bjtlEKm5hdqxDaiV/5INebuHm/FofR0lbfw3WE8hr6mrccUvvh+QV7VQfiV0zu71Sf
	 r8J37/98Q9Dy9yqTtDIhPh8mwWZrQDmB+Kdj92WClxhTDvfjvZYrtZ556ZZlor+iIs
	 9/A80BVprGfkw==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH xfrm-next 9/9] net/mlx5e: Delete obsolete IPsec code
Date: Mon, 16 Oct 2023 12:15:17 +0300
Message-ID: <7c4b218453db5f46cea5a29bc86636c379db7ee3.1697444728.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697444728.git.leon@kernel.org>
References: <cover.1697444728.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

After addition of HW managed counters and implementation drop
in flow steering logic, the code in driver which checks syndrome
is not reachable anymore.

Let's delete it.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  1 -
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c  | 25 ++-----------------
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |  1 -
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c |  1 -
 4 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index adaea3493193..7d943e93cf6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -137,7 +137,6 @@ struct mlx5e_ipsec_hw_stats {
 struct mlx5e_ipsec_sw_stats {
 	atomic64_t ipsec_rx_drop_sp_alloc;
 	atomic64_t ipsec_rx_drop_sadb_miss;
-	atomic64_t ipsec_rx_drop_syndrome;
 	atomic64_t ipsec_tx_drop_bundle;
 	atomic64_t ipsec_tx_drop_no_state;
 	atomic64_t ipsec_tx_drop_not_ip;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index 51a144246ea6..727fa7c18523 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -304,12 +304,6 @@ bool mlx5e_ipsec_handle_tx_skb(struct net_device *netdev,
 	return false;
 }
 
-enum {
-	MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_DECRYPTED,
-	MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_AUTH_FAILED,
-	MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_BAD_TRAILER,
-};
-
 void mlx5e_ipsec_offload_handle_rx_skb(struct net_device *netdev,
 				       struct sk_buff *skb,
 				       u32 ipsec_meta_data)
@@ -343,20 +337,7 @@ void mlx5e_ipsec_offload_handle_rx_skb(struct net_device *netdev,
 
 	xo = xfrm_offload(skb);
 	xo->flags = CRYPTO_DONE;
-
-	switch (MLX5_IPSEC_METADATA_SYNDROM(ipsec_meta_data)) {
-	case MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_DECRYPTED:
-		xo->status = CRYPTO_SUCCESS;
-		break;
-	case MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_AUTH_FAILED:
-		xo->status = CRYPTO_TUNNEL_ESP_AUTH_FAILED;
-		break;
-	case MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_BAD_TRAILER:
-		xo->status = CRYPTO_INVALID_PACKET_SYNTAX;
-		break;
-	default:
-		atomic64_inc(&ipsec->sw_stats.ipsec_rx_drop_syndrome);
-	}
+	xo->status = CRYPTO_SUCCESS;
 }
 
 int mlx5_esw_ipsec_rx_make_metadata(struct mlx5e_priv *priv, u32 id, u32 *metadata)
@@ -374,8 +355,6 @@ int mlx5_esw_ipsec_rx_make_metadata(struct mlx5e_priv *priv, u32 id, u32 *metada
 		return err;
 	}
 
-	*metadata = MLX5_IPSEC_METADATA_CREATE(ipsec_obj_id,
-					       MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_DECRYPTED);
-
+	*metadata = ipsec_obj_id;
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 9ee014a8ad24..ddd9fad19cc5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -43,7 +43,6 @@
 #define MLX5_IPSEC_METADATA_MARKER(metadata)  (((metadata) >> 31) & 0x1)
 #define MLX5_IPSEC_METADATA_SYNDROM(metadata) (((metadata) >> 24) & GENMASK(5, 0))
 #define MLX5_IPSEC_METADATA_HANDLE(metadata)  ((metadata) & GENMASK(23, 0))
-#define MLX5_IPSEC_METADATA_CREATE(id, syndrome) ((id) | ((syndrome) << 24))
 
 struct mlx5e_accel_tx_ipsec_state {
 	struct xfrm_offload *xo;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
index e0e36a09721c..dd36b04e30a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
@@ -51,7 +51,6 @@ static const struct counter_desc mlx5e_ipsec_hw_stats_desc[] = {
 static const struct counter_desc mlx5e_ipsec_sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_rx_drop_sp_alloc) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_rx_drop_sadb_miss) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_rx_drop_syndrome) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_tx_drop_bundle) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_tx_drop_no_state) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_tx_drop_not_ip) },
-- 
2.41.0


