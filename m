Return-Path: <netdev+bounces-59390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1562B81ABEE
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F89287281
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F22EDE;
	Thu, 21 Dec 2023 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvTUqrGs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC6D5239
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC95CC433C8;
	Thu, 21 Dec 2023 00:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703120256;
	bh=HvUhiYdCxO4zgemMCChvycgueJsXno3/+HhLDg33qVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvTUqrGsmjR1MftzO+5s9woNK7Kks3NspzRSHbOPaAbqN2BAszclJ9jr2PVaFcwRg
	 tJ9eVpVTlJu3S1yJATi1VrLoDLv5ufJmaHyzNeKPWK362tjYCcNhDhaL/s9ZAvoXVO
	 t/xtqnYYWsy9hb4XICyVG6wtWpFcnWLp1FRa0Wzt+gWWJHFtXDxlPjpIOeAZhGzFA2
	 hMwldllMNr3t44Z6LDuZRx6hguemMT9uWBhATES8hqhMzc6wS4/R042vuN6m4MiQw2
	 0/sVm+hp2ICM57Uoct4jliIetfAf2ba6nE1PWeFy8XqORQcvVC+vxOFtWFjTw28pSh
	 RH37HMZm4cJWw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [net-next 05/15] net/mlx5: SD, Implement devcom communication and primary election
Date: Wed, 20 Dec 2023 16:57:11 -0800
Message-ID: <20231221005721.186607-6-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221005721.186607-1-saeed@kernel.org>
References: <20231221005721.186607-1-saeed@kernel.org>
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
index 9d8b1bb0c0a6..19e674dd1af7 100644
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
@@ -136,15 +162,93 @@ static void sd_cleanup(struct mlx5_core_dev *dev)
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
@@ -154,6 +258,7 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	if (!sd)
 		return;
 
+	sd_unregister(dev);
 	sd_cleanup(dev);
 }
 
@@ -161,5 +266,18 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
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


