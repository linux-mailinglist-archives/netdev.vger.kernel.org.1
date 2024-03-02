Return-Path: <netdev+bounces-76804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD8286EF1C
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5EF1F225E2
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA75014F86;
	Sat,  2 Mar 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcHvj4lD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D315E80
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709364207; cv=none; b=bZljK6fMqzAiWtLFhVCGq45mQr4HO8kwuzZWDz7jQZyBKJ+jkyaOdkbJq5v7H6Fqyt1ur/odqOm5OeVQupFZ0YoN5yEBz/ta8z08ghO5NbZ/ckkBxz4n8KcgDsFjjnBiKDGwlqScVp2iZlBorfGlDxZ0GEgO7tfQePowWUxvRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709364207; c=relaxed/simple;
	bh=zG/mGoKgoe8c5HJYQp/pFhiEaRmvXZl/dqdfvLLlz8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrKFrCoSZWCPevdBHbyxCyd+r7MCjtwZ98+qsswNqPiSlsOnH5BAP09POAVcLg8dI0ZVr3W7I6M9zBKCqRgk1MGutKJaBiWivkyVj5eXwAO5ohyI3jbbkhNUTVXpUHPgl68+N7qkiqj2L25bRb535rvyIJtOraukWoNQLouK3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcHvj4lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F8BC433C7;
	Sat,  2 Mar 2024 07:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709364207;
	bh=zG/mGoKgoe8c5HJYQp/pFhiEaRmvXZl/dqdfvLLlz8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcHvj4lDVAicQQPHEvaZfm6sJuC3Y0Tf1DeIR9YoG3PpwDUthL1pwyw0L4qVsayqE
	 s29hIqVaHndGjhIMgcmrQcOVx0p9OslH6kt3boEkeZUWY5ndVvcRBFFSnFZyNiy43e
	 iirMmr3+eRpDFrOZBaSYEZTzkiWFyREcSuLSVi4DX4BBOVPIvHgqefunhnzH5vWure
	 hO0rNzW/1whdueMy2RrnILVyyZGpOFkmTUPZUggi2pp+EkO7UgC9Y3sV0OwxkW97fO
	 c8Dx8zH8g3VEB31tkKN8IpO+AkBFcSvk6BM8sV8dkKGUvBgQk51f2X+2VFt65Pctpn
	 w+F4UZK6JZL2g==
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
	sridhar.samudrala@intel.com,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [net-next V4 08/15] net/mlx5e: Create single netdev per SD group
Date: Fri,  1 Mar 2024 23:22:38 -0800
Message-ID: <20240302072246.67920-9-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302072246.67920-1-saeed@kernel.org>
References: <20240302072246.67920-1-saeed@kernel.org>
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
2.44.0


