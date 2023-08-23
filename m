Return-Path: <netdev+bounces-29863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A7784FD3
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69F628129C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327CB1FBE;
	Wed, 23 Aug 2023 05:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFA91842
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE1DC433C8;
	Wed, 23 Aug 2023 05:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767426;
	bh=OuFKcZgOQt4okG86tgsXFpg+ItMbde/B4NUb4hTGVT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9Ml1JOPAL24DZgxJE9N4sbR6+YTBh1xKlWcHaZy7Du0IxGMdDBGtql7eXRf1ywdb
	 j9jWFkQnaFVeUmCKz4BSgjvTUuF4AT2fy8xutmV/EYq0XfweGV6+/GESrwwz7t7sgG
	 zHUMP75QAa2rVFNiTwOjVWaQAmOXwId3x1ulstgY+YyVKGfWJlptW7MPGrX9a7IciH
	 0PKaM4FtS94GZFq5uvDPW6tJHHS0p06eC0Uq3RAEd7XGFnEg75DxEWgqOzpQ9DvJUc
	 qD1mzQYJZBOu4hZTaUSJfHpY7G5v6Xu+OgxqwHnEqWnOSZ6fiCFjSdxkAwazHzY5I0
	 xuRfC0mkl6Lsg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [net-next 02/15] net/mlx5: Push out SF devlink port init and cleanup code to separate helpers
Date: Tue, 22 Aug 2023 22:09:59 -0700
Message-ID: <20230823051012.162483-3-saeed@kernel.org>
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

Similar to what was done for PFs/VFs, introduce devlink port init and
cleanup helpers for SFs and manage the vport->dl_port pointer there.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     | 61 ++++++++++++++++---
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 1864bf83aaa2..dfb1101dfef0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -97,6 +97,48 @@ static const struct devlink_port_ops mlx5_esw_pf_vf_dl_port_ops = {
 	.port_fn_migratable_set = mlx5_devlink_port_fn_migratable_set,
 };
 
+static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswitch *esw,
+							struct devlink_port *dl_port,
+							u32 controller, u32 sfnum)
+{
+	struct mlx5_core_dev *dev = esw->dev;
+	struct netdev_phys_item_id ppid = {};
+	u16 pfnum;
+
+	pfnum = mlx5_get_dev_index(dev);
+	mlx5_esw_get_port_parent_id(dev, &ppid);
+	memcpy(dl_port->attrs.switch_id.id, &ppid.id[0], ppid.id_len);
+	dl_port->attrs.switch_id.id_len = ppid.id_len;
+	devlink_port_attrs_pci_sf_set(dl_port, controller, pfnum, sfnum, !!controller);
+}
+
+static int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num,
+						  struct devlink_port *dl_port,
+						  u32 controller, u32 sfnum)
+{
+	struct mlx5_vport *vport;
+
+	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);
+
+	mlx5_esw_offloads_sf_devlink_port_attrs_set(esw, dl_port, controller, sfnum);
+
+	vport->dl_port = dl_port;
+	return 0;
+}
+
+static void mlx5_esw_offloads_sf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num)
+{
+	struct mlx5_vport *vport;
+
+	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return;
+
+	vport->dl_port = NULL;
+}
+
 int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	struct mlx5_core_dev *dev = esw->dev;
@@ -179,38 +221,37 @@ int mlx5_esw_devlink_sf_port_register(struct mlx5_eswitch *esw, struct devlink_p
 				      u16 vport_num, u32 controller, u32 sfnum)
 {
 	struct mlx5_core_dev *dev = esw->dev;
-	struct netdev_phys_item_id ppid = {};
 	unsigned int dl_port_index;
 	struct mlx5_vport *vport;
 	struct devlink *devlink;
-	u16 pfnum;
 	int err;
 
 	vport = mlx5_eswitch_get_vport(esw, vport_num);
 	if (IS_ERR(vport))
 		return PTR_ERR(vport);
 
-	pfnum = mlx5_get_dev_index(dev);
-	mlx5_esw_get_port_parent_id(dev, &ppid);
-	memcpy(dl_port->attrs.switch_id.id, &ppid.id[0], ppid.id_len);
-	dl_port->attrs.switch_id.id_len = ppid.id_len;
-	devlink_port_attrs_pci_sf_set(dl_port, controller, pfnum, sfnum, !!controller);
+	err = mlx5_esw_offloads_sf_devlink_port_init(esw, vport_num, dl_port, controller, sfnum);
+	if (err)
+		return err;
+
 	devlink = priv_to_devlink(dev);
 	dl_port_index = mlx5_esw_vport_to_devlink_port_index(dev, vport_num);
 	err = devl_port_register_with_ops(devlink, dl_port, dl_port_index,
 					  &mlx5_esw_dl_sf_port_ops);
 	if (err)
-		return err;
+		goto reg_err;
 
 	err = devl_rate_leaf_create(dl_port, vport, NULL);
 	if (err)
 		goto rate_err;
 
-	vport->dl_port = dl_port;
 	return 0;
 
 rate_err:
 	devl_port_unregister(dl_port);
+
+reg_err:
+	mlx5_esw_offloads_sf_devlink_port_cleanup(esw, vport_num);
 	return err;
 }
 
@@ -226,5 +267,5 @@ void mlx5_esw_devlink_sf_port_unregister(struct mlx5_eswitch *esw, u16 vport_num
 	devl_rate_leaf_destroy(vport->dl_port);
 
 	devl_port_unregister(vport->dl_port);
-	vport->dl_port = NULL;
+	mlx5_esw_offloads_sf_devlink_port_cleanup(esw, vport_num);
 }
-- 
2.41.0


