Return-Path: <netdev+bounces-76793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E56286EF0A
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8977DB22BA5
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039E911C82;
	Sat,  2 Mar 2024 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svgxx8tO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA961173F
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363432; cv=none; b=WlFx3mLEBjHG7lgfkFr+AlgEn6SOH3Q7uPAScHOhpx9KC1SH6PwEwm4Tzv2luwDFkknKAusEWZgJ+4vgnFCgmqR4nsd1tame9xZ9DSEGe3FKWfE9aM5ewjyckvgPe90BkanqgUeQbszIgcH4NvL+9lxHM9rXyiNIrWy3uiq9jOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363432; c=relaxed/simple;
	bh=gpBd/gJ0w5Hrbp4iQBH6YDhLFzNCTib1Q+IVTKvj6QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXqXVtrfrqQcS+zYlgYJZQyUwJ+GsYQ1WIqObcpD8vKMeufQz5NXIUlXHXVEjaclUytm9Wq/a1/IgffNBLnUUAJrPvFv//CnFPb5nMklrFxNFolTn8Rs+YttLAX33hANiQF5LA2MyEZnJvnbiyb1J6k/r+PRK6h8lW6zxUG/VbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svgxx8tO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2842CC433F1;
	Sat,  2 Mar 2024 07:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709363432;
	bh=gpBd/gJ0w5Hrbp4iQBH6YDhLFzNCTib1Q+IVTKvj6QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=svgxx8tOdjvGxBXWoQmCCwaQN/XvmxISJFXXEjflAmxLcK9PClwfvpxluXc/XhKFe
	 kqu4ZT0JgfmscG2wJy1gM+5Nako3MdQ4sFd7qziWvVw2fwgS5nySSYIzw/Gr2O7QFz
	 jUCM3W/fLGMevmzyEPLSxtDkW318TH3IXlgwQDXcR3qSVwJnI7JAQgPs6vePYTQNSj
	 YmYE+1bofl6srhTIfINAhYcTB7BH+ayC2gLnz2HyfkZcLNTJQjhs4rZxK0gxQln4kI
	 XMXCjycPJbepXj1kCej0r6Z/urE3bzKKBZVAU3jtpwLk4o7rNUfP3Z1KQOLHIpLlwW
	 Z4N8xCZW9OeHQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Emeel Hakim <ehakim@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net V2 7/9] net/mlx5e: Fix MACsec state loss upon state update in offload path
Date: Fri,  1 Mar 2024 23:10:26 -0800
Message-ID: <20240302071028.63879-2-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302070318.62997-1-saeed@kernel.org>
References: <20240302070318.62997-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emeel Hakim <ehakim@nvidia.com>

The packet number attribute of the SA is incremented by the device rather
than the software stack when enabling hardware offload. Because the packet
number attribute is managed by the hardware, the software has no insight
into the value of the packet number attribute actually written by the
device.

Previously when MACsec offload was enabled, the hardware object for
handling the offload was destroyed when the SA was disabled. Re-enabling
the SA would lead to a new hardware object being instantiated. This new
hardware object would not have any recollection of the correct packet
number for the SA. Instead, destroy the flow steering rule when
deactivating the SA and recreate it upon reactivation, preserving the
original hardware object.

Fixes: 8ff0ac5be144 ("net/mlx5: Add MACsec offload Tx command support")
Signed-off-by: Emeel Hakim <ehakim@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/macsec.c      | 82 ++++++++++++-------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index d4ebd8743114..b2cabd6ab86c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -310,9 +310,9 @@ static void mlx5e_macsec_destroy_object(struct mlx5_core_dev *mdev, u32 macsec_o
 	mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
 }
 
-static void mlx5e_macsec_cleanup_sa(struct mlx5e_macsec *macsec,
-				    struct mlx5e_macsec_sa *sa,
-				    bool is_tx, struct net_device *netdev, u32 fs_id)
+static void mlx5e_macsec_cleanup_sa_fs(struct mlx5e_macsec *macsec,
+				       struct mlx5e_macsec_sa *sa, bool is_tx,
+				       struct net_device *netdev, u32 fs_id)
 {
 	int action =  (is_tx) ?  MLX5_ACCEL_MACSEC_ACTION_ENCRYPT :
 				 MLX5_ACCEL_MACSEC_ACTION_DECRYPT;
@@ -322,20 +322,49 @@ static void mlx5e_macsec_cleanup_sa(struct mlx5e_macsec *macsec,
 
 	mlx5_macsec_fs_del_rule(macsec->mdev->macsec_fs, sa->macsec_rule, action, netdev,
 				fs_id);
-	mlx5e_macsec_destroy_object(macsec->mdev, sa->macsec_obj_id);
 	sa->macsec_rule = NULL;
 }
 
+static void mlx5e_macsec_cleanup_sa(struct mlx5e_macsec *macsec,
+				    struct mlx5e_macsec_sa *sa, bool is_tx,
+				    struct net_device *netdev, u32 fs_id)
+{
+	mlx5e_macsec_cleanup_sa_fs(macsec, sa, is_tx, netdev, fs_id);
+	mlx5e_macsec_destroy_object(macsec->mdev, sa->macsec_obj_id);
+}
+
+static int mlx5e_macsec_init_sa_fs(struct macsec_context *ctx,
+				   struct mlx5e_macsec_sa *sa, bool encrypt,
+				   bool is_tx, u32 *fs_id)
+{
+	struct mlx5e_priv *priv = macsec_netdev_priv(ctx->netdev);
+	struct mlx5_macsec_fs *macsec_fs = priv->mdev->macsec_fs;
+	struct mlx5_macsec_rule_attrs rule_attrs;
+	union mlx5_macsec_rule *macsec_rule;
+
+	rule_attrs.macsec_obj_id = sa->macsec_obj_id;
+	rule_attrs.sci = sa->sci;
+	rule_attrs.assoc_num = sa->assoc_num;
+	rule_attrs.action = (is_tx) ? MLX5_ACCEL_MACSEC_ACTION_ENCRYPT :
+				      MLX5_ACCEL_MACSEC_ACTION_DECRYPT;
+
+	macsec_rule = mlx5_macsec_fs_add_rule(macsec_fs, ctx, &rule_attrs, fs_id);
+	if (!macsec_rule)
+		return -ENOMEM;
+
+	sa->macsec_rule = macsec_rule;
+
+	return 0;
+}
+
 static int mlx5e_macsec_init_sa(struct macsec_context *ctx,
 				struct mlx5e_macsec_sa *sa,
 				bool encrypt, bool is_tx, u32 *fs_id)
 {
 	struct mlx5e_priv *priv = macsec_netdev_priv(ctx->netdev);
 	struct mlx5e_macsec *macsec = priv->macsec;
-	struct mlx5_macsec_rule_attrs rule_attrs;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5_macsec_obj_attrs obj_attrs;
-	union mlx5_macsec_rule *macsec_rule;
 	int err;
 
 	obj_attrs.next_pn = sa->next_pn;
@@ -357,20 +386,12 @@ static int mlx5e_macsec_init_sa(struct macsec_context *ctx,
 	if (err)
 		return err;
 
-	rule_attrs.macsec_obj_id = sa->macsec_obj_id;
-	rule_attrs.sci = sa->sci;
-	rule_attrs.assoc_num = sa->assoc_num;
-	rule_attrs.action = (is_tx) ? MLX5_ACCEL_MACSEC_ACTION_ENCRYPT :
-				      MLX5_ACCEL_MACSEC_ACTION_DECRYPT;
-
-	macsec_rule = mlx5_macsec_fs_add_rule(mdev->macsec_fs, ctx, &rule_attrs, fs_id);
-	if (!macsec_rule) {
-		err = -ENOMEM;
-		goto destroy_macsec_object;
+	if (sa->active) {
+		err = mlx5e_macsec_init_sa_fs(ctx, sa, encrypt, is_tx, fs_id);
+		if (err)
+			goto destroy_macsec_object;
 	}
 
-	sa->macsec_rule = macsec_rule;
-
 	return 0;
 
 destroy_macsec_object:
@@ -526,9 +547,7 @@ static int mlx5e_macsec_add_txsa(struct macsec_context *ctx)
 		goto destroy_sa;
 
 	macsec_device->tx_sa[assoc_num] = tx_sa;
-	if (!secy->operational ||
-	    assoc_num != tx_sc->encoding_sa ||
-	    !tx_sa->active)
+	if (!secy->operational)
 		goto out;
 
 	err = mlx5e_macsec_init_sa(ctx, tx_sa, tx_sc->encrypt, true, NULL);
@@ -595,7 +614,7 @@ static int mlx5e_macsec_upd_txsa(struct macsec_context *ctx)
 		goto out;
 
 	if (ctx_tx_sa->active) {
-		err = mlx5e_macsec_init_sa(ctx, tx_sa, tx_sc->encrypt, true, NULL);
+		err = mlx5e_macsec_init_sa_fs(ctx, tx_sa, tx_sc->encrypt, true, NULL);
 		if (err)
 			goto out;
 	} else {
@@ -604,7 +623,7 @@ static int mlx5e_macsec_upd_txsa(struct macsec_context *ctx)
 			goto out;
 		}
 
-		mlx5e_macsec_cleanup_sa(macsec, tx_sa, true, ctx->secy->netdev, 0);
+		mlx5e_macsec_cleanup_sa_fs(macsec, tx_sa, true, ctx->secy->netdev, 0);
 	}
 out:
 	mutex_unlock(&macsec->lock);
@@ -1030,8 +1049,9 @@ static int mlx5e_macsec_del_rxsa(struct macsec_context *ctx)
 		goto out;
 	}
 
-	mlx5e_macsec_cleanup_sa(macsec, rx_sa, false, ctx->secy->netdev,
-				rx_sc->sc_xarray_element->fs_id);
+	if (rx_sa->active)
+		mlx5e_macsec_cleanup_sa(macsec, rx_sa, false, ctx->secy->netdev,
+					rx_sc->sc_xarray_element->fs_id);
 	mlx5_destroy_encryption_key(macsec->mdev, rx_sa->enc_key_id);
 	kfree(rx_sa);
 	rx_sc->rx_sa[assoc_num] = NULL;
@@ -1112,8 +1132,8 @@ static int macsec_upd_secy_hw_address(struct macsec_context *ctx,
 			if (!rx_sa || !rx_sa->macsec_rule)
 				continue;
 
-			mlx5e_macsec_cleanup_sa(macsec, rx_sa, false, ctx->secy->netdev,
-						rx_sc->sc_xarray_element->fs_id);
+			mlx5e_macsec_cleanup_sa_fs(macsec, rx_sa, false, ctx->secy->netdev,
+						   rx_sc->sc_xarray_element->fs_id);
 		}
 	}
 
@@ -1124,8 +1144,8 @@ static int macsec_upd_secy_hw_address(struct macsec_context *ctx,
 				continue;
 
 			if (rx_sa->active) {
-				err = mlx5e_macsec_init_sa(ctx, rx_sa, true, false,
-							   &rx_sc->sc_xarray_element->fs_id);
+				err = mlx5e_macsec_init_sa_fs(ctx, rx_sa, true, false,
+							      &rx_sc->sc_xarray_element->fs_id);
 				if (err)
 					goto out;
 			}
@@ -1178,7 +1198,7 @@ static int mlx5e_macsec_upd_secy(struct macsec_context *ctx)
 		if (!tx_sa)
 			continue;
 
-		mlx5e_macsec_cleanup_sa(macsec, tx_sa, true, ctx->secy->netdev, 0);
+		mlx5e_macsec_cleanup_sa_fs(macsec, tx_sa, true, ctx->secy->netdev, 0);
 	}
 
 	for (i = 0; i < MACSEC_NUM_AN; ++i) {
@@ -1187,7 +1207,7 @@ static int mlx5e_macsec_upd_secy(struct macsec_context *ctx)
 			continue;
 
 		if (tx_sa->assoc_num == tx_sc->encoding_sa && tx_sa->active) {
-			err = mlx5e_macsec_init_sa(ctx, tx_sa, tx_sc->encrypt, true, NULL);
+			err = mlx5e_macsec_init_sa_fs(ctx, tx_sa, tx_sc->encrypt, true, NULL);
 			if (err)
 				goto out;
 		}
-- 
2.44.0


