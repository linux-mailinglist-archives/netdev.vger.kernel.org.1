Return-Path: <netdev+bounces-71933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D2855953
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DEA1C2A00F
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913F1862E;
	Thu, 15 Feb 2024 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owc0wn3R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434218622
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966507; cv=none; b=MFJglTNUbblGSKkYGMybw+9wN4GZXO14x3zfrJDMJreofkam6v3/Sa/IXtQCjQtZarYgOi8hX0SuZuxZABxRex2HpHj8pVO3dCR3crGBN8QaLSdIZRKcYIr7RVHswIyu9PCJi4vjwqUGBaH7KUNrNP2uQ/mMBUDkx8xtjKozZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966507; c=relaxed/simple;
	bh=xuSYO+2FHopnVdPL+zdYNSEjm0gNFhB1oEDfSAcdhdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrfpV511X7Yr64DO++1c0oj5bCN4IhYGrL70uATroV1qDa/fMOYjfjZOnPaIHsDiYZtX5kXZvCmhhEeh4fd61KXBir1nQO/cnVxb87sz2tWkir+aJF0Xp/KrrSCyVy44lYnneu7HPgSWsVAO+oFNfyYW9IBeeeYawUZA7kIkVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owc0wn3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393AAC433F1;
	Thu, 15 Feb 2024 03:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966507;
	bh=xuSYO+2FHopnVdPL+zdYNSEjm0gNFhB1oEDfSAcdhdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owc0wn3RKRVZJbGrhS7hd6qnQw6AerZ6pG2Iyle41dPLea6Ax1dKE7tbub7cwcNQn
	 /12ZojQ0e2au16GOz8eeo8XPRF11QLm4QmdTqxC1YqgEWYQQipB3ZK3Rmr2GK/rLmc
	 7ljnQpzpEgqS4RO/7YRLCkMc2JfPgt1qgl1UsFlw3cnKJ4bo+voM7OiAM3YSS6Np7s
	 u0gtYmXtwqdaHo9jTR20SQTWaIu4DQWuXnXfgeawVm0yzC1DnunFaWnJe52dxetv18
	 NIKDwYmXWT1KfCJMq8QmltPfN1Xj/p6eVz15xRmk40Owu9gfHXbPwlrzQ2kYqnLwRJ
	 63BsWVt17V24w==
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
Subject: [net-next V3 08/15] net/mlx5e: Create single netdev per SD group
Date: Wed, 14 Feb 2024 19:08:07 -0800
Message-ID: <20240215030814.451812-9-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215030814.451812-1-saeed@kernel.org>
References: <20240215030814.451812-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Integrate the SD library calls into the auxiliary_driver ops in
preparation for creating a single netdev for the multiple PFs belonging
to the same SD group.

SD is still disabled at this stage. It is enabled by a downstream patch
when all needed parts are implemented.

The netdev is created whenever the SD group, with all its participants,
are ready. It is later destroyed whenever any of the participating PFs
drops.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 69 +++++++++++++++++--
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index be809556b2e1..ef6a342742a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -70,6 +70,7 @@
 #include "qos.h"
 #include "en/trap.h"
 #include "lib/devcom.h"
+#include "lib/sd.h"
 
 bool mlx5e_check_fragmented_striding_rq_cap(struct mlx5_core_dev *mdev, u8 page_shift,
 					    enum mlx5e_mpwrq_umr_mode umr_mode)
@@ -5987,7 +5988,7 @@ void mlx5e_destroy_netdev(struct mlx5e_priv *priv)
 	free_netdev(netdev);
 }
 
-static int mlx5e_resume(struct auxiliary_device *adev)
+static int _mlx5e_resume(struct auxiliary_device *adev)
 {
 	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
@@ -6012,6 +6013,23 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 	return 0;
 }
 
+static int mlx5e_resume(struct auxiliary_device *adev)
+{
+	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = edev->mdev;
+	struct auxiliary_device *actual_adev;
+	int err;
+
+	err = mlx5_sd_init(mdev);
+	if (err)
+		return err;
+
+	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
+	if (actual_adev)
+		return _mlx5e_resume(actual_adev);
+	return 0;
+}
+
 static int _mlx5e_suspend(struct auxiliary_device *adev)
 {
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
@@ -6032,7 +6050,17 @@ static int _mlx5e_suspend(struct auxiliary_device *adev)
 
 static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
 {
-	return _mlx5e_suspend(adev);
+	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = edev->mdev;
+	struct auxiliary_device *actual_adev;
+	int err = 0;
+
+	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
+	if (actual_adev)
+		err = _mlx5e_suspend(actual_adev);
+
+	mlx5_sd_cleanup(mdev);
+	return err;
 }
 
 static int _mlx5e_probe(struct auxiliary_device *adev)
@@ -6078,9 +6106,9 @@ static int _mlx5e_probe(struct auxiliary_device *adev)
 		goto err_destroy_netdev;
 	}
 
-	err = mlx5e_resume(adev);
+	err = _mlx5e_resume(adev);
 	if (err) {
-		mlx5_core_err(mdev, "mlx5e_resume failed, %d\n", err);
+		mlx5_core_err(mdev, "_mlx5e_resume failed, %d\n", err);
 		goto err_profile_cleanup;
 	}
 
@@ -6111,15 +6139,29 @@ static int _mlx5e_probe(struct auxiliary_device *adev)
 static int mlx5e_probe(struct auxiliary_device *adev,
 		       const struct auxiliary_device_id *id)
 {
-	return _mlx5e_probe(adev);
+	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = edev->mdev;
+	struct auxiliary_device *actual_adev;
+	int err;
+
+	err = mlx5_sd_init(mdev);
+	if (err)
+		return err;
+
+	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
+	if (actual_adev)
+		return _mlx5e_probe(actual_adev);
+	return 0;
 }
 
-static void mlx5e_remove(struct auxiliary_device *adev)
+static void _mlx5e_remove(struct auxiliary_device *adev)
 {
+	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
 	struct mlx5e_priv *priv = mlx5e_dev->priv;
+	struct mlx5_core_dev *mdev = edev->mdev;
 
-	mlx5_core_uplink_netdev_set(priv->mdev, NULL);
+	mlx5_core_uplink_netdev_set(mdev, NULL);
 	mlx5e_dcbnl_delete_app(priv);
 	unregister_netdev(priv->netdev);
 	_mlx5e_suspend(adev);
@@ -6129,6 +6171,19 @@ static void mlx5e_remove(struct auxiliary_device *adev)
 	mlx5e_destroy_devlink(mlx5e_dev);
 }
 
+static void mlx5e_remove(struct auxiliary_device *adev)
+{
+	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = edev->mdev;
+	struct auxiliary_device *actual_adev;
+
+	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
+	if (actual_adev)
+		_mlx5e_remove(actual_adev);
+
+	mlx5_sd_cleanup(mdev);
+}
+
 static const struct auxiliary_device_id mlx5e_id_table[] = {
 	{ .name = MLX5_ADEV_NAME ".eth", },
 	{},
-- 
2.43.0


