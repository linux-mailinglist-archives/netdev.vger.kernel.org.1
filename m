Return-Path: <netdev+bounces-21639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12562764142
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E581C2148D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345571CA14;
	Wed, 26 Jul 2023 21:32:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BBA1CA03
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B47C433A9;
	Wed, 26 Jul 2023 21:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407140;
	bh=7Mf/JvOfy1J/IMduLRib8lgIW10+7HjV496UEwESHLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uuwXLRqMod52cOC7bykyzHSpT5wWcs0qInrI2F+VZuDaMCn4AF/ZSLCnQkuOVp/7Q
	 ZBRijfN9hy6ypGWAn8CREjnlljtrfirHwm/yxclKLDFWvhMut85d9sM7MjoFAfXtOe
	 TTdhuDrNw5UuaUX8q/6W+I/RKdyCMEYCdj5sGTnO8LsOw0mu+Kdmzv9rhxIZnpI8oC
	 us/i+ig3/VHtSaZouVZjv3wJH1aqJmnZn1dmqNcK04SGwKwUu4ZRrbM8NF26sOyQSb
	 oGr80qcq8EE55zvskoEvTa7IT8VkztyaiAoqM6+PIQ6DQtQYXpg2H/JRZXnzZLoapJ
	 r7D5jk9xlWjOw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: [net 12/15] net/mlx5e: kTLS, Fix protection domain in use syndrome when devlink reload
Date: Wed, 26 Jul 2023 14:32:03 -0700
Message-ID: <20230726213206.47022-13-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726213206.47022-1-saeed@kernel.org>
References: <20230726213206.47022-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

There are DEK objects cached in DEK pool after kTLS is used, and they
are freed only in mlx5e_ktls_cleanup().

mlx5e_destroy_mdev_resources() is called in mlx5e_suspend() to
free mdev resources, including protection domain (PD). However, PD is
still referenced by the cached DEK objects in this case, because
profile->cleanup() (and therefore mlx5e_ktls_cleanup()) is called
after mlx5e_suspend() during devlink reload. So the following FW
syndrome is generated:

 mlx5_cmd_out_err:803:(pid 12948): DEALLOC_PD(0x801) op_mod(0x0) failed,
    status bad resource state(0x9), syndrome (0xef0c8a), err(-22)

To avoid this syndrome, move DEK pool destruction to
mlx5e_ktls_cleanup_tx(), which is called by profile->cleanup_tx(). And
move pool creation to mlx5e_ktls_init_tx() for symmetry.

Fixes: f741db1a5171 ("net/mlx5e: kTLS, Improve connection rate by using fast update encryption key")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ktls.c        |  8 -----
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     | 29 +++++++++++++++++--
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index cf704f106b7c..984fa04bd331 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -188,7 +188,6 @@ static void mlx5e_tls_debugfs_init(struct mlx5e_tls *tls,
 
 int mlx5e_ktls_init(struct mlx5e_priv *priv)
 {
-	struct mlx5_crypto_dek_pool *dek_pool;
 	struct mlx5e_tls *tls;
 
 	if (!mlx5e_is_ktls_device(priv->mdev))
@@ -199,12 +198,6 @@ int mlx5e_ktls_init(struct mlx5e_priv *priv)
 		return -ENOMEM;
 	tls->mdev = priv->mdev;
 
-	dek_pool = mlx5_crypto_dek_pool_create(priv->mdev, MLX5_ACCEL_OBJ_TLS_KEY);
-	if (IS_ERR(dek_pool)) {
-		kfree(tls);
-		return PTR_ERR(dek_pool);
-	}
-	tls->dek_pool = dek_pool;
 	priv->tls = tls;
 
 	mlx5e_tls_debugfs_init(tls, priv->dfs_root);
@@ -222,7 +215,6 @@ void mlx5e_ktls_cleanup(struct mlx5e_priv *priv)
 	debugfs_remove_recursive(tls->debugfs.dfs);
 	tls->debugfs.dfs = NULL;
 
-	mlx5_crypto_dek_pool_destroy(tls->dek_pool);
 	kfree(priv->tls);
 	priv->tls = NULL;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index efb2cf74ad6a..d61be26a4df1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -908,28 +908,51 @@ static void mlx5e_tls_tx_debugfs_init(struct mlx5e_tls *tls,
 
 int mlx5e_ktls_init_tx(struct mlx5e_priv *priv)
 {
+	struct mlx5_crypto_dek_pool *dek_pool;
 	struct mlx5e_tls *tls = priv->tls;
+	int err;
+
+	if (!mlx5e_is_ktls_device(priv->mdev))
+		return 0;
+
+	/* DEK pool could be used by either or both of TX and RX. But we have to
+	 * put the creation here to avoid syndrome when doing devlink reload.
+	 */
+	dek_pool = mlx5_crypto_dek_pool_create(priv->mdev, MLX5_ACCEL_OBJ_TLS_KEY);
+	if (IS_ERR(dek_pool))
+		return PTR_ERR(dek_pool);
+	tls->dek_pool = dek_pool;
 
 	if (!mlx5e_is_ktls_tx(priv->mdev))
 		return 0;
 
 	priv->tls->tx_pool = mlx5e_tls_tx_pool_init(priv->mdev, &priv->tls->sw_stats);
-	if (!priv->tls->tx_pool)
-		return -ENOMEM;
+	if (!priv->tls->tx_pool) {
+		err = -ENOMEM;
+		goto err_tx_pool_init;
+	}
 
 	mlx5e_tls_tx_debugfs_init(tls, tls->debugfs.dfs);
 
 	return 0;
+
+err_tx_pool_init:
+	mlx5_crypto_dek_pool_destroy(dek_pool);
+	return err;
 }
 
 void mlx5e_ktls_cleanup_tx(struct mlx5e_priv *priv)
 {
 	if (!mlx5e_is_ktls_tx(priv->mdev))
-		return;
+		goto dek_pool_destroy;
 
 	debugfs_remove_recursive(priv->tls->debugfs.dfs_tx);
 	priv->tls->debugfs.dfs_tx = NULL;
 
 	mlx5e_tls_tx_pool_cleanup(priv->tls->tx_pool);
 	priv->tls->tx_pool = NULL;
+
+dek_pool_destroy:
+	if (mlx5e_is_ktls_device(priv->mdev))
+		mlx5_crypto_dek_pool_destroy(priv->tls->dek_pool);
 }
-- 
2.41.0


