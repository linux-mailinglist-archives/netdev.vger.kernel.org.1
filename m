Return-Path: <netdev+bounces-29868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B707784FDC
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BD6281249
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDA61842;
	Wed, 23 Aug 2023 05:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E638838
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6F7C433C7;
	Wed, 23 Aug 2023 05:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767430;
	bh=YRlbDGsa2t5PadirWj4Y3jla1TvKx+FfqAs0+EUTx0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XalbOx847GjbXz1tbt2GQulNW68JQ46Buq6b+L/X611/AC5ZKRegizwz7myQ/sDJy
	 7RrQNcTIXSieAx7/AVzhctZlDg+mmKAsK/1H+29wrnT97vz2AGkAsCSJQTKqzt92C5
	 uIx/69ST6jIEXoImqsuzWVNIepgr2I0gL0Mqs7z6aE6jim/epNr2MEEuzB0a+5TY93
	 Ix80gPo9mDkV7UZ6rh4kfOqI5PGO+Bi2/5iMItZWEb8P5cfp2pUPSCc2sPMwRJC+yb
	 YjBNFmsdVF6qdHRVGFTNL6apuEVyOhUDS9w1BkX+guqftQHJpCTgoBgz8pNsyE9dAf
	 sDdePod4DBx3Q==
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
Subject: [net-next 06/15] net/mlx5: Remove no longer used mlx5_esw_offloads_sf_vport_enable/disable()
Date: Tue, 22 Aug 2023 22:10:03 -0700
Message-ID: <20230823051012.162483-7-saeed@kernel.org>
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

Since the previous patch removed the only users of these functions,
remove them.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     | 53 -------------------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 32 -----------
 3 files changed, 92 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 540bebd93ea5..b77893507476 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -214,56 +214,3 @@ struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u1
 	vport = mlx5_eswitch_get_vport(esw, vport_num);
 	return IS_ERR(vport) ? ERR_CAST(vport) : vport->dl_port;
 }
-
-int mlx5_esw_devlink_sf_port_register(struct mlx5_eswitch *esw, struct devlink_port *dl_port,
-				      u16 vport_num, u32 controller, u32 sfnum)
-{
-	struct mlx5_core_dev *dev = esw->dev;
-	unsigned int dl_port_index;
-	struct mlx5_vport *vport;
-	struct devlink *devlink;
-	int err;
-
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport))
-		return PTR_ERR(vport);
-
-	err = mlx5_esw_offloads_sf_devlink_port_init(esw, vport_num, dl_port, controller, sfnum);
-	if (err)
-		return err;
-
-	devlink = priv_to_devlink(dev);
-	dl_port_index = mlx5_esw_vport_to_devlink_port_index(dev, vport_num);
-	err = devl_port_register_with_ops(devlink, dl_port, dl_port_index,
-					  &mlx5_esw_dl_sf_port_ops);
-	if (err)
-		goto reg_err;
-
-	err = devl_rate_leaf_create(dl_port, vport, NULL);
-	if (err)
-		goto rate_err;
-
-	return 0;
-
-rate_err:
-	devl_port_unregister(dl_port);
-
-reg_err:
-	mlx5_esw_offloads_sf_devlink_port_cleanup(esw, vport_num);
-	return err;
-}
-
-void mlx5_esw_devlink_sf_port_unregister(struct mlx5_eswitch *esw, u16 vport_num)
-{
-	struct mlx5_vport *vport;
-
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport))
-		return;
-
-	mlx5_esw_qos_vport_update_group(esw, vport, NULL, NULL);
-	devl_rate_leaf_destroy(vport->dl_port);
-
-	devl_port_unregister(vport->dl_port);
-	mlx5_esw_offloads_sf_devlink_port_cleanup(esw, vport_num);
-}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 89efeffa075d..e1e808105e98 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -761,13 +761,6 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, u16 vport_num);
 struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u16 vport_num);
 
-int mlx5_esw_devlink_sf_port_register(struct mlx5_eswitch *esw, struct devlink_port *dl_port,
-				      u16 vport_num, u32 controller, u32 sfnum);
-void mlx5_esw_devlink_sf_port_unregister(struct mlx5_eswitch *esw, u16 vport_num);
-
-int mlx5_esw_offloads_sf_vport_enable(struct mlx5_eswitch *esw, struct devlink_port *dl_port,
-				      u16 vport_num, u32 controller, u32 sfnum);
-void mlx5_esw_offloads_sf_vport_disable(struct mlx5_eswitch *esw, u16 vport_num);
 int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs, u16 *sf_base_id);
 
 int mlx5_esw_vport_vhca_id_set(struct mlx5_eswitch *esw, u16 vport_num);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 998e56cf43db..4b03f2bf605d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4130,38 +4130,6 @@ u32 mlx5_eswitch_get_vport_metadata_for_match(struct mlx5_eswitch *esw,
 }
 EXPORT_SYMBOL(mlx5_eswitch_get_vport_metadata_for_match);
 
-int mlx5_esw_offloads_sf_vport_enable(struct mlx5_eswitch *esw, struct devlink_port *dl_port,
-				      u16 vport_num, u32 controller, u32 sfnum)
-{
-	int err;
-
-	err = mlx5_esw_vport_enable(esw, vport_num, MLX5_VPORT_UC_ADDR_CHANGE);
-	if (err)
-		return err;
-
-	err = mlx5_esw_devlink_sf_port_register(esw, dl_port, vport_num, controller, sfnum);
-	if (err)
-		goto devlink_err;
-
-	err = mlx5_esw_offloads_rep_load(esw, vport_num);
-	if (err)
-		goto rep_err;
-	return 0;
-
-rep_err:
-	mlx5_esw_devlink_sf_port_unregister(esw, vport_num);
-devlink_err:
-	mlx5_esw_vport_disable(esw, vport_num);
-	return err;
-}
-
-void mlx5_esw_offloads_sf_vport_disable(struct mlx5_eswitch *esw, u16 vport_num)
-{
-	mlx5_esw_offloads_rep_unload(esw, vport_num);
-	mlx5_esw_devlink_sf_port_unregister(esw, vport_num);
-	mlx5_esw_vport_disable(esw, vport_num);
-}
-
 static int mlx5_esw_query_vport_vhca_id(struct mlx5_eswitch *esw, u16 vport_num, u16 *vhca_id)
 {
 	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-- 
2.41.0


