Return-Path: <netdev+bounces-95274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0554B8C1CBB
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36EF281910
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A7F148858;
	Fri, 10 May 2024 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiSt9SRH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FE14A612
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310293; cv=none; b=C4zKypxR2oGHYhJYIOj36TKfXUZ7rIr0PgMcf61czbt18H+/t0IAIe4qKMpf52Toc+B3lxLMEM4C934liQEt9oeLZ1KNzJMQvCjMSy+KA4MF17hjhDoiDKeymp6bVu+R3vbw1D+vtfz0mleyuoafHvViyku1oH4U1rVIqayyLYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310293; c=relaxed/simple;
	bh=AyNN56ie4UUGTQFe8agp412wqnS+yq5EDX7OkOfs9n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USg8iMDwszN4HSI0P/MTSRwsVjn6YkUNIS1lbmWbFlUIcTCz3UVsn8tJf4wTdztXAuEIWTrwDAgTYlnENx/+goa/vLMmD2pnavEbIw4LYMy+RS+UhzjuAaxRue6/rdV2+z/kFblL0xPPJYQfLnLysP+WjXXh4ExEqDDglYcdb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiSt9SRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08D4C3277B;
	Fri, 10 May 2024 03:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310293;
	bh=AyNN56ie4UUGTQFe8agp412wqnS+yq5EDX7OkOfs9n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oiSt9SRHz9WaMX/07rB7HhYSSBrvOhGWKtFoupvA61E8byLEkCrVPhl6ggzgK7jS+
	 xIIzDURE7NkmRhp+4BO66MWHDqYP/UObNRgwJDqT8WUpOdX5rEJb/YkefZoH247V2Y
	 4CX4bqYXktV7aDMn+pRSqSS+UEzXJ1rr3JxKD2I55bdaE2msBjGABNon6u2BCQ2LIm
	 mVBTQijqCAKYo+udgl10PmxX5bUzdIphwIGcRdxcYRmizT47YLmTcUeC6oumCJv5HQ
	 rLbXUjTuaK7mv7uvaiWF9bihe5U2V8RAnpmB9hAKPyWGdxx7mYLKn6ZICWj4vqSEZ0
	 DG7lLlJIxMOUA==
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
Subject: [RFC net-next 13/15] net/mlx5e: Configure PSP Rx flow steering rules
Date: Thu,  9 May 2024 20:04:33 -0700
Message-ID: <20240510030435.120935-14-kuba@kernel.org>
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

Set the Rx PSP flow steering rule where PSP packet is identified and
decrypted using the dedicated UDP destination port number 1000. If packet
is decrypted then a PSP marker and syndrome are added to metadata so SW can
use it later on in Rx data path.

The rule is set as part of init_rx netdev profile implementation.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../mellanox/mlx5/core/en_accel/en_accel.h    | 14 +++++-
 .../mellanox/mlx5/core/en_accel/nisp_fs.c     | 46 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/nisp_fs.h     |  7 +++
 3 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index cea997847fa4..38d2c73a0f79 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -231,12 +231,24 @@ static inline void mlx5e_accel_tx_finish(struct mlx5e_txqsq *sq,
 
 static inline int mlx5e_accel_init_rx(struct mlx5e_priv *priv)
 {
-	return mlx5e_ktls_init_rx(priv);
+	int err;
+
+	err = mlx5_accel_nisp_fs_init_rx_tables(priv);
+	if (err)
+		goto out;
+
+	err = mlx5e_ktls_init_rx(priv);
+	if (err)
+		mlx5_accel_nisp_fs_cleanup_rx_tables(priv);
+
+out:
+	return err;
 }
 
 static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
 {
 	mlx5e_ktls_cleanup_rx(priv);
+	mlx5_accel_nisp_fs_cleanup_rx_tables(priv);
 }
 
 static inline int mlx5e_accel_init_tx(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c
index 11f583d13bdd..0d80f646e5b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c
@@ -468,9 +468,6 @@ static void accel_nisp_fs_cleanup_rx(struct mlx5e_nisp_fs *fs)
 	if (!fs->rx_fs)
 		return;
 
-	for (i = 0; i < ACCEL_FS_NISP_NUM_TYPES; i++)
-		accel_nisp_fs_rx_ft_put(fs, i);
-
 	accel_nisp = fs->rx_fs;
 	for (i = 0; i < ACCEL_FS_NISP_NUM_TYPES; i++) {
 		fs_prot = &accel_nisp->fs_prot[i];
@@ -496,13 +493,50 @@ static int accel_nisp_fs_init_rx(struct mlx5e_nisp_fs *fs)
 		mutex_init(&fs_prot->prot_mutex);
 	}
 
-	for (i = 0; i < ACCEL_FS_NISP_NUM_TYPES; i++)
-		accel_nisp_fs_rx_ft_get(fs, ACCEL_FS_NISP4);
-
 	fs->rx_fs = accel_nisp;
+
 	return 0;
 }
 
+void  mlx5_accel_nisp_fs_cleanup_rx_tables(struct mlx5e_priv *priv)
+{
+	int i;
+
+	if (!priv->nisp)
+		return;
+
+	for (i = 0; i < ACCEL_FS_NISP_NUM_TYPES; i++)
+		accel_nisp_fs_rx_ft_put(priv->nisp->fs, i);
+}
+
+int  mlx5_accel_nisp_fs_init_rx_tables(struct mlx5e_priv *priv)
+{
+	enum accel_fs_nisp_type i;
+	struct mlx5e_nisp_fs *fs;
+	int err;
+
+	if (!priv->nisp)
+		return 0;
+
+	fs = priv->nisp->fs;
+	for (i = 0; i < ACCEL_FS_NISP_NUM_TYPES; i++) {
+		err = accel_nisp_fs_rx_ft_get(fs, i);
+		if (err)
+			goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	i--;
+	while (i >= 0) {
+		accel_nisp_fs_rx_ft_put(fs, i);
+		--i;
+	}
+
+	return err;
+}
+
 static int accel_nisp_fs_tx_create_ft_table(struct mlx5e_nisp_fs *fs)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.h
index 11cdc447a401..8c44dd51317c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.h
@@ -12,6 +12,8 @@ struct mlx5e_nisp_fs *mlx5e_accel_nisp_fs_init(struct mlx5e_priv *priv);
 void mlx5e_accel_nisp_fs_cleanup(struct mlx5e_nisp_fs *fs);
 int mlx5_accel_nisp_fs_init_tx_tables(struct mlx5e_priv *priv);
 void mlx5_accel_nisp_fs_cleanup_tx_tables(struct mlx5e_priv *priv);
+int mlx5_accel_nisp_fs_init_rx_tables(struct mlx5e_priv *priv);
+void mlx5_accel_nisp_fs_cleanup_rx_tables(struct mlx5e_priv *priv);
 #else
 static inline int mlx5_accel_nisp_fs_init_tx_tables(struct mlx5e_priv *priv)
 {
@@ -19,5 +21,10 @@ static inline int mlx5_accel_nisp_fs_init_tx_tables(struct mlx5e_priv *priv)
 }
 
 static inline void mlx5_accel_nisp_fs_cleanup_tx_tables(struct mlx5e_priv *priv) { }
+static inline int mlx5_accel_nisp_fs_init_rx_tables(struct mlx5e_priv *priv)
+{
+	return 0;
+}
+static inline void mlx5_accel_nisp_fs_cleanup_rx_tables(struct mlx5e_priv *priv) { }
 #endif /* CONFIG_MLX5_EN_PSP */
 #endif /* __MLX5_NISP_FS_H__ */
-- 
2.45.0


