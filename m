Return-Path: <netdev+bounces-29862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC29784FD1
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4D028127E
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F420F13;
	Wed, 23 Aug 2023 05:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4B17C6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCFFC433CA;
	Wed, 23 Aug 2023 05:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767425;
	bh=QqBHEYyhTjnuBoYxOn6yVeiT8mZ9xP+ZYn21IeBXZRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tvTDf8VEJVdA7nOV2ZJeDmwuMGYqK3U71mz+ucrmzPgd1MMA0sIw2SbfRAsUrn7/Q
	 eASRPHqil2ilhGL3q1wek/OUqrv2ie4UIITlVWqeYtGPTcii2qGDRnO98tmy/6Kzup
	 6PC7sXu7i1dYjXOIrpaR8QO3vDUzFcMHpE0TATCbD7oF5nynrmzgixdtX73ZiXxi2y
	 r/pGaHMVxjUI2ZGKBRWEaboYuKPkkF2XXMNg/DvsL15HhA1eUFIoFmlIeM+9zuEBts
	 eINRGjcYkq7SBESeDxvcNwpfHlhXMTnrygbvz4faPoYyvKlLkro6YhQY/m8JTvfRYS
	 npj6wE/rXtktA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 01/15] net/mlx5: Rework devlink port alloc/free into init/cleanup
Date: Tue, 22 Aug 2023 22:09:58 -0700
Message-ID: <20230823051012.162483-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823051012.162483-1-saeed@kernel.org>
References: <20230823051012.162483-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In order to prepare the devlink port registration function to be common
for PFs/VFs and SFs, change the existing devlink port allocation and
free functions into PF/VF init and cleanup, so similar helpers could be
later on introduced for SFs. Make the init/cleanup helpers responsible
for setting/clearing the vport->dl_port pointer.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     | 65 ++++++++++++-------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 234fd4c28e79..1864bf83aaa2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -21,19 +21,16 @@ static bool mlx5_esw_devlink_port_supported(struct mlx5_eswitch *esw, u16 vport_
 	       mlx5_core_is_ec_vf_vport(esw->dev, vport_num);
 }
 
-static struct devlink_port *mlx5_esw_dl_port_alloc(struct mlx5_eswitch *esw, u16 vport_num)
+static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *esw,
+							   u16 vport_num,
+							   struct devlink_port *dl_port)
 {
 	struct mlx5_core_dev *dev = esw->dev;
 	struct netdev_phys_item_id ppid = {};
-	struct devlink_port *dl_port;
 	u32 controller_num = 0;
 	bool external;
 	u16 pfnum;
 
-	dl_port = kzalloc(sizeof(*dl_port), GFP_KERNEL);
-	if (!dl_port)
-		return NULL;
-
 	mlx5_esw_get_port_parent_id(dev, &ppid);
 	pfnum = mlx5_get_dev_index(dev);
 	external = mlx5_core_is_ecpf_esw_manager(dev);
@@ -55,12 +52,40 @@ static struct devlink_port *mlx5_esw_dl_port_alloc(struct mlx5_eswitch *esw, u16
 		devlink_port_attrs_pci_vf_set(dl_port, 0, pfnum,
 					      vport_num - 1, false);
 	}
-	return dl_port;
 }
 
-static void mlx5_esw_dl_port_free(struct devlink_port *dl_port)
+static int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num)
+{
+	struct devlink_port *dl_port;
+	struct mlx5_vport *vport;
+
+	if (!mlx5_esw_devlink_port_supported(esw, vport_num))
+		return 0;
+
+	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);
+
+	dl_port = kzalloc(sizeof(*dl_port), GFP_KERNEL);
+	if (!dl_port)
+		return -ENOMEM;
+
+	mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(esw, vport_num, dl_port);
+
+	vport->dl_port = dl_port;
+	return 0;
+}
+
+static void mlx5_esw_offloads_pf_vf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num)
 {
-	kfree(dl_port);
+	struct mlx5_vport *vport;
+
+	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport) || !vport->dl_port)
+		return;
+
+	kfree(vport->dl_port);
+	vport->dl_port = NULL;
 }
 
 static const struct devlink_port_ops mlx5_esw_pf_vf_dl_port_ops = {
@@ -81,16 +106,17 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 	struct devlink *devlink;
 	int err;
 
-	if (!mlx5_esw_devlink_port_supported(esw, vport_num))
-		return 0;
-
 	vport = mlx5_eswitch_get_vport(esw, vport_num);
 	if (IS_ERR(vport))
 		return PTR_ERR(vport);
 
-	dl_port = mlx5_esw_dl_port_alloc(esw, vport_num);
+	err = mlx5_esw_offloads_pf_vf_devlink_port_init(esw, vport_num);
+	if (err)
+		return err;
+
+	dl_port = vport->dl_port;
 	if (!dl_port)
-		return -ENOMEM;
+		return 0;
 
 	devlink = priv_to_devlink(dev);
 	dl_port_index = mlx5_esw_vport_to_devlink_port_index(dev, vport_num);
@@ -103,13 +129,12 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 	if (err)
 		goto rate_err;
 
-	vport->dl_port = dl_port;
 	return 0;
 
 rate_err:
 	devl_port_unregister(dl_port);
 reg_err:
-	mlx5_esw_dl_port_free(dl_port);
+	mlx5_esw_offloads_pf_vf_devlink_port_cleanup(esw, vport_num);
 	return err;
 }
 
@@ -117,19 +142,15 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, u16 vpo
 {
 	struct mlx5_vport *vport;
 
-	if (!mlx5_esw_devlink_port_supported(esw, vport_num))
-		return;
-
 	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport))
+	if (IS_ERR(vport) || !vport->dl_port)
 		return;
 
 	mlx5_esw_qos_vport_update_group(esw, vport, NULL, NULL);
 	devl_rate_leaf_destroy(vport->dl_port);
 
 	devl_port_unregister(vport->dl_port);
-	mlx5_esw_dl_port_free(vport->dl_port);
-	vport->dl_port = NULL;
+	mlx5_esw_offloads_pf_vf_devlink_port_cleanup(esw, vport_num);
 }
 
 struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u16 vport_num)
-- 
2.41.0


