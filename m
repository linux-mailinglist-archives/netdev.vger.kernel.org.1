Return-Path: <netdev+bounces-57184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7722D812508
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172871F21B0F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A096546A2;
	Thu, 14 Dec 2023 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5eHGBRB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E434437
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4B8C433C8;
	Thu, 14 Dec 2023 02:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519727;
	bh=IWANXQlKp4SDbvu4rGn4Rl1LnxYA2ZQMLuhFjoEqVXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5eHGBRB45LLYVbvLvdv86dPSnBCgUgtGFsQc/VmucI7SsiX0VnA+cVU46g9rpjJA
	 OefP3F92lqQVEdjvtsYYhk/TzVXZxh8lhLfTjot4gI09efbe82M8OmBnTixxzu/i+R
	 4LE28Sdcn0q7+RuNZmlNR48JTyC8jvDlgZAlwHmiIUPBbvx8B5MIbobd3hi1Lys6C4
	 wMHQQCdRze1VoEOlxxKfiOIbNU6svU7TCUtbyfpVMAdPIWXBuWl7R51WasRhQolqw2
	 PC2dyKrgBelmVWT9H7JuZgZCM5BYgPmCm8sTInMnkkg5ki3DcW+h73WJ5gMq9tDNrs
	 ppd/cj91m6Htw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 08/11] net/mlx5e: Add wrapping for auxiliary_driver ops and remove unused args
Date: Wed, 13 Dec 2023 18:08:29 -0800
Message-ID: <20231214020832.50703-9-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214020832.50703-1-saeed@kernel.org>
References: <20231214020832.50703-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Turn some of the struct auxiliary_driver ops into wrappers to stop
having dummy local vars passed as unused arguments.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ecb40950ec8d..78794268abe7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5984,7 +5984,7 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 	return 0;
 }
 
-static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
+static int _mlx5e_suspend(struct auxiliary_device *adev)
 {
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
 	struct mlx5e_priv *priv = mlx5e_dev->priv;
@@ -6002,15 +6002,18 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
 	return 0;
 }
 
-static int mlx5e_probe(struct auxiliary_device *adev,
-		       const struct auxiliary_device_id *id)
+static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
+{
+	return _mlx5e_suspend(adev);
+}
+
+static int _mlx5e_probe(struct auxiliary_device *adev)
 {
 	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
 	const struct mlx5e_profile *profile = &mlx5e_nic_profile;
 	struct mlx5_core_dev *mdev = edev->mdev;
 	struct mlx5e_dev *mlx5e_dev;
 	struct net_device *netdev;
-	pm_message_t state = {};
 	struct mlx5e_priv *priv;
 	int err;
 
@@ -6065,7 +6068,7 @@ static int mlx5e_probe(struct auxiliary_device *adev,
 	return 0;
 
 err_resume:
-	mlx5e_suspend(adev, state);
+	_mlx5e_suspend(adev);
 err_profile_cleanup:
 	profile->cleanup(priv);
 err_destroy_netdev:
@@ -6077,16 +6080,21 @@ static int mlx5e_probe(struct auxiliary_device *adev,
 	return err;
 }
 
+static int mlx5e_probe(struct auxiliary_device *adev,
+		       const struct auxiliary_device_id *id)
+{
+	return _mlx5e_probe(adev);
+}
+
 static void mlx5e_remove(struct auxiliary_device *adev)
 {
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
 	struct mlx5e_priv *priv = mlx5e_dev->priv;
-	pm_message_t state = {};
 
 	mlx5_core_uplink_netdev_set(priv->mdev, NULL);
 	mlx5e_dcbnl_delete_app(priv);
 	unregister_netdev(priv->netdev);
-	mlx5e_suspend(adev, state);
+	_mlx5e_suspend(adev);
 	priv->profile->cleanup(priv);
 	mlx5e_destroy_netdev(priv);
 	mlx5e_devlink_port_unregister(mlx5e_dev);
-- 
2.43.0


