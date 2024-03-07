Return-Path: <netdev+bounces-78285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E38749F3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2416F284789
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8682B83A10;
	Thu,  7 Mar 2024 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7uXpbmk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C183A0D
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800966; cv=none; b=VifIiTy7Fy9lERvzeutFqbTwLjZsfbo3tyNHEFCp7e8OY7W262j/djs2VoYCoKIEA2uVCwVEnMHewRkDuZXqs33+33OcxhMFwmu3ouKF3TaWPR1FoB1lHu8qZ99etKu38ndl975UFH6TfVB6b5GbXzr+bznimUSoJnnY76dSzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800966; c=relaxed/simple;
	bh=wyXddwULvcl3/d051VrkRLBX8+Q+gZouGu+RH1Dns4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5ZeM364IQl5nnM33LGgSgYVP7HQ8EIJfJiiLomHvu7XtUiT8GkwzLeu52f3TyBge41mCevoByi4D3u6TBEho179EPwrKPnxqp2GJPrzq9mp8sx7bdUQq22z6Hn75Y38ZYHNbGrP6ibsTeXDgdFSbnwEDbzVQOHadQyJJNPcOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7uXpbmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C585CC433F1;
	Thu,  7 Mar 2024 08:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709800965;
	bh=wyXddwULvcl3/d051VrkRLBX8+Q+gZouGu+RH1Dns4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7uXpbmkCQg7Xqofr/zf0SdOWWEpefDIOXN3+1MWvIral0UjX1RXIQ/qTInGsGouf
	 nHckuManTSHgVoJN3d+AUj1YWB82fdRUc2cDRavD9ExdF7F/fDU0mScyKWj5bllYB3
	 ABRnyGoGEP4D73ly0P4zx/rUGMLs6oMLsGmsAWpFyg04hshLIVGoVi31vULx8IFOns
	 xw6qrFeaiiB5ibeFn+xejUo73uvS9PLYblSBTlrnIeJNc7kPERYXDiUgu0/PPMuD6Z
	 uh4Xuf97MZA6EyCf573PQbzKYJ/dpVOednV6vd7IE68dso+X7U8HjE2gCAj+j/DSLO
	 8EQlUUWQ+CW2A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V6 09/15] net/mlx5e: Create EN core HW resources for all secondary devices
Date: Thu,  7 Mar 2024 00:42:23 -0800
Message-ID: <20240307084229.500776-10-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307084229.500776-1-saeed@kernel.org>
References: <20240307084229.500776-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Traffic queues will be created on all devices, including the
secondaries. Create the needed core layer resources for them as well.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 32 +++++++++++++------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 55c6ace0acd5..6c143088e247 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -60,6 +60,7 @@
 #include "lib/clock.h"
 #include "en/rx_res.h"
 #include "en/selq.h"
+#include "lib/sd.h"
 
 extern const struct net_device_ops mlx5e_netdev_ops;
 struct page_pool;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ef6a342742a2..c6c406c18b54 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5995,22 +5995,29 @@ static int _mlx5e_resume(struct auxiliary_device *adev)
 	struct mlx5e_priv *priv = mlx5e_dev->priv;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = edev->mdev;
-	int err;
+	struct mlx5_core_dev *pos, *to;
+	int err, i;
 
 	if (netif_device_present(netdev))
 		return 0;
 
-	err = mlx5e_create_mdev_resources(mdev, true);
-	if (err)
-		return err;
+	mlx5_sd_for_each_dev(i, mdev, pos) {
+		err = mlx5e_create_mdev_resources(pos, true);
+		if (err)
+			goto err_destroy_mdev_res;
+	}
 
 	err = mlx5e_attach_netdev(priv);
-	if (err) {
-		mlx5e_destroy_mdev_resources(mdev);
-		return err;
-	}
+	if (err)
+		goto err_destroy_mdev_res;
 
 	return 0;
+
+err_destroy_mdev_res:
+	to = pos;
+	mlx5_sd_for_each_dev_to(i, mdev, to, pos)
+		mlx5e_destroy_mdev_resources(pos);
+	return err;
 }
 
 static int mlx5e_resume(struct auxiliary_device *adev)
@@ -6036,15 +6043,20 @@ static int _mlx5e_suspend(struct auxiliary_device *adev)
 	struct mlx5e_priv *priv = mlx5e_dev->priv;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
+	struct mlx5_core_dev *pos;
+	int i;
 
 	if (!netif_device_present(netdev)) {
 		if (test_bit(MLX5E_STATE_DESTROYING, &priv->state))
-			mlx5e_destroy_mdev_resources(mdev);
+			mlx5_sd_for_each_dev(i, mdev, pos)
+				mlx5e_destroy_mdev_resources(pos);
 		return -ENODEV;
 	}
 
 	mlx5e_detach_netdev(priv);
-	mlx5e_destroy_mdev_resources(mdev);
+	mlx5_sd_for_each_dev(i, mdev, pos)
+		mlx5e_destroy_mdev_resources(pos);
+
 	return 0;
 }
 
-- 
2.44.0


