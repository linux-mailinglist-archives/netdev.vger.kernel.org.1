Return-Path: <netdev+bounces-70081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5056E84D932
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546301C23A05
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990372E414;
	Thu,  8 Feb 2024 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF0D0ruk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759EE2E40D
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364452; cv=none; b=kTrhiluq039puPKQEMTVMbQ0YkR3t2KtFOXWnHWf+IaPFfKznv8lPHSI8gGrUW9fyMVGO+jWu/p2T3npULuIuUOKXLpmdUWTHioVaXnVcMTjrqJJs7S4VhcmD6hiVzVAnbbOeqyVSZuUPd1EtIEPmuY+cPn7+K0pXfMqrBc75Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364452; c=relaxed/simple;
	bh=ZaUmORkPX+f7VV97eI063L9v52+UP/R5w3xvd+Yo3Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRcnV1EcDdd6ILsrkqkp7EZ8p7xpimE6fd7PcTgUzwmvMT2zSBx2rVrakwsllkeN1+Qc0VQmcEJ2NLhkTCGlhgCths6nKu147rjyVAQH/Sp59e9oGdBvkC73kY1NPPV5xEww8Qinrg3gBgMAW7Nn7qZFV+ewKwzw8oJG5Wi+yTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF0D0ruk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAF0C43399;
	Thu,  8 Feb 2024 03:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707364452;
	bh=ZaUmORkPX+f7VV97eI063L9v52+UP/R5w3xvd+Yo3Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VF0D0rukDQ7LAcp7xkMlvacqjWsy+ZQLDYAyT55iUgZ2VsywSvmxHFCw3N9RVbTP1
	 p2xYNK93Hzj1nQEkmnb54J0Sae1fdRsXjUaYUd18Eh4yKkETc81LIf4k3SUguPVfPR
	 unn5nnPPxi7BfiJcvwhOm3GC4gw1fs/gGpdYYMkHYq6tbm5LTnUkwUaPww7+uWuiIO
	 m3buuYZiw7DmA8ZiU/t5j608HNMoQdGIrwLmarFV6AwZLPF0McpEIwXsT9kjoA5zxl
	 /jJduGATp2llDYbDT8/8705ro73032GDp1tMzPhuAHsEaGSVzz3X3apw4zS0WkEMvR
	 MQDsZPwJ3elIA==
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
Subject: [net-next V2 04/15] net/mlx5: SD, Implement devcom communication and primary election
Date: Wed,  7 Feb 2024 19:53:41 -0800
Message-ID: <20240208035352.387423-5-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208035352.387423-1-saeed@kernel.org>
References: <20240208035352.387423-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Use devcom to communicate between the different devices. Add a new
devcom component type for this.

Each device registers itself to the devcom component <SD, group ID>.
Once all devices of a component are registered, the component becomes
ready, and a primary device is elected.

In principle, any of the devices can act as a primary, they are all
capable, and a random election would've worked. However, we aim to
achieve predictability and consistency, hence each group always choses
the same device, with the lowest PCI BUS number, as primary.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |   1 +
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 122 +++++++++++++++++-
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index ec32b686f586..d58032dd0df7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -10,6 +10,7 @@ enum mlx5_devcom_component {
 	MLX5_DEVCOM_ESW_OFFLOADS,
 	MLX5_DEVCOM_MPV,
 	MLX5_DEVCOM_HCA_PORTS,
+	MLX5_DEVCOM_SD_GROUP,
 	MLX5_DEVCOM_NUM_COMPONENTS,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index b1f86549af1c..3059a3750f82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -14,6 +14,16 @@
 struct mlx5_sd {
 	u32 group_id;
 	u8 host_buses;
+	struct mlx5_devcom_comp_dev *devcom;
+	bool primary;
+	union {
+		struct { /* primary */
+			struct mlx5_core_dev *secondaries[MLX5_SD_MAX_GROUP_SZ - 1];
+		};
+		struct { /* secondary */
+			struct mlx5_core_dev *primary_dev;
+		};
+	};
 };
 
 static int mlx5_sd_get_host_buses(struct mlx5_core_dev *dev)
@@ -26,13 +36,29 @@ static int mlx5_sd_get_host_buses(struct mlx5_core_dev *dev)
 	return sd->host_buses;
 }
 
+static struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+
+	if (!sd)
+		return dev;
+
+	return sd->primary ? dev : sd->primary_dev;
+}
+
 struct mlx5_core_dev *
 mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx)
 {
+	struct mlx5_sd *sd;
+
 	if (idx == 0)
 		return primary;
 
-	return NULL;
+	if (idx >= mlx5_sd_get_host_buses(primary))
+		return NULL;
+
+	sd = mlx5_get_sd(primary);
+	return sd->secondaries[idx - 1];
 }
 
 int mlx5_sd_ch_ix_get_dev_ix(struct mlx5_core_dev *dev, int ch_ix)
@@ -139,15 +165,93 @@ static void sd_cleanup(struct mlx5_core_dev *dev)
 	kfree(sd);
 }
 
+static int sd_register(struct mlx5_core_dev *dev)
+{
+	struct mlx5_devcom_comp_dev *devcom, *pos;
+	struct mlx5_core_dev *peer, *primary;
+	struct mlx5_sd *sd, *primary_sd;
+	int err, i;
+
+	sd = mlx5_get_sd(dev);
+	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
+						sd->group_id, NULL, dev);
+	if (!devcom)
+		return -ENOMEM;
+
+	sd->devcom = devcom;
+
+	if (mlx5_devcom_comp_get_size(devcom) != sd->host_buses)
+		return 0;
+
+	mlx5_devcom_comp_lock(devcom);
+	mlx5_devcom_comp_set_ready(devcom, true);
+	mlx5_devcom_comp_unlock(devcom);
+
+	if (!mlx5_devcom_for_each_peer_begin(devcom)) {
+		err = -ENODEV;
+		goto err_devcom_unreg;
+	}
+
+	primary = dev;
+	mlx5_devcom_for_each_peer_entry(devcom, peer, pos)
+		if (peer->pdev->bus->number < primary->pdev->bus->number)
+			primary = peer;
+
+	primary_sd = mlx5_get_sd(primary);
+	primary_sd->primary = true;
+	i = 0;
+	/* loop the secondaries */
+	mlx5_devcom_for_each_peer_entry(primary_sd->devcom, peer, pos) {
+		struct mlx5_sd *peer_sd = mlx5_get_sd(peer);
+
+		primary_sd->secondaries[i++] = peer;
+		peer_sd->primary = false;
+		peer_sd->primary_dev = primary;
+	}
+
+	mlx5_devcom_for_each_peer_end(devcom);
+	return 0;
+
+err_devcom_unreg:
+	mlx5_devcom_comp_lock(sd->devcom);
+	mlx5_devcom_comp_set_ready(sd->devcom, false);
+	mlx5_devcom_comp_unlock(sd->devcom);
+	mlx5_devcom_unregister_component(sd->devcom);
+	return err;
+}
+
+static void sd_unregister(struct mlx5_core_dev *dev)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+
+	mlx5_devcom_comp_lock(sd->devcom);
+	mlx5_devcom_comp_set_ready(sd->devcom, false);
+	mlx5_devcom_comp_unlock(sd->devcom);
+	mlx5_devcom_unregister_component(sd->devcom);
+}
+
 int mlx5_sd_init(struct mlx5_core_dev *dev)
 {
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
 	int err;
 
 	err = sd_init(dev);
 	if (err)
 		return err;
 
+	sd = mlx5_get_sd(dev);
+	if (!sd)
+		return 0;
+
+	err = sd_register(dev);
+	if (err)
+		goto err_sd_cleanup;
+
 	return 0;
+
+err_sd_cleanup:
+	sd_cleanup(dev);
+	return err;
 }
 
 void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
@@ -157,6 +261,7 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	if (!sd)
 		return;
 
+	sd_unregister(dev);
 	sd_cleanup(dev);
 }
 
@@ -164,5 +269,18 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 					  struct auxiliary_device *adev,
 					  int idx)
 {
-	return adev;
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+	struct mlx5_core_dev *primary;
+
+	if (!sd)
+		return adev;
+
+	if (!mlx5_devcom_comp_is_ready(sd->devcom))
+		return NULL;
+
+	primary = mlx5_sd_get_primary(dev);
+	if (dev == primary)
+		return adev;
+
+	return &primary->priv.adev[idx]->adev;
 }
-- 
2.43.0


