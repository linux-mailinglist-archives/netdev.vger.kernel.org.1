Return-Path: <netdev+bounces-29870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF4F784FDE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142F42812AE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52D847F;
	Wed, 23 Aug 2023 05:10:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ACE947D
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04363C433A9;
	Wed, 23 Aug 2023 05:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767433;
	bh=AlBO2M7joxTFYPJDxAsUMtxaU3U/92wirBszktlIN5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGY3quDxxyZhIwdDwI81NZSt/fHSgmrKwURde8bD/RYk5zXr1aGSTIigurjyRk37u
	 YqsyQQXUo29bLn35MrLFjv7JnYui8X+53lniIhH9SG42I5LfzmBTw3eiYzp3kJqAkp
	 j2Z2BoU6bW3KbBCvXrJUCVNyQMegRmTQZP2I0Ux87pETglLfwD8sCmIBfhidnsKgh0
	 i/RRBpEd8DB6N+J1kM06qogT0JveZKp6BZOamo1PRs+rOL+/Sjat5vc070+ceDXArD
	 Gf53v4K3k0fNJ4CwZYnQpKeqRuiDNmPypBgUjglBJ6ODpj/kke5qwQvBmC186Cj2xg
	 fKNSO8/z+D1tQ==
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
Subject: [net-next 08/15] net/mlx5: Embed struct devlink_port into driver structure
Date: Tue, 22 Aug 2023 22:10:05 -0700
Message-ID: <20230823051012.162483-9-saeed@kernel.org>
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

Struct devlink_port is usually embedded in a driver-specific struct
which allows to carry driver context to devlink port ops.

Introduce a container struct to include devlink_port struct
in preparation to also include driver context for devlink port ops.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     | 25 +++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 12 ++++++---
 .../mellanox/mlx5/core/eswitch_offloads.c     |  2 +-
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  4 +--
 5 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 69084673e7e6..35cf2739a2aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -56,7 +56,7 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 
 int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num)
 {
-	struct devlink_port *dl_port;
+	struct mlx5_devlink_port *dl_port;
 	struct mlx5_vport *vport;
 
 	if (!mlx5_esw_devlink_port_supported(esw, vport_num))
@@ -70,7 +70,8 @@ int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u16 vpor
 	if (!dl_port)
 		return -ENOMEM;
 
-	mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(esw, vport_num, dl_port);
+	mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(esw, vport_num,
+						       &dl_port->dl_port);
 
 	vport->dl_port = dl_port;
 	return 0;
@@ -113,7 +114,7 @@ static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswitch *esw
 }
 
 int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num,
-					   struct devlink_port *dl_port,
+					   struct mlx5_devlink_port *dl_port,
 					   u32 controller, u32 sfnum)
 {
 	struct mlx5_vport *vport;
@@ -122,7 +123,7 @@ int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_n
 	if (IS_ERR(vport))
 		return PTR_ERR(vport);
 
-	mlx5_esw_offloads_sf_devlink_port_attrs_set(esw, dl_port, controller, sfnum);
+	mlx5_esw_offloads_sf_devlink_port_attrs_set(esw, &dl_port->dl_port, controller, sfnum);
 
 	vport->dl_port = dl_port;
 	return 0;
@@ -157,7 +158,7 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 {
 	struct mlx5_core_dev *dev = esw->dev;
 	const struct devlink_port_ops *ops;
-	struct devlink_port *dl_port;
+	struct mlx5_devlink_port *dl_port;
 	unsigned int dl_port_index;
 	struct mlx5_vport *vport;
 	struct devlink *devlink;
@@ -180,33 +181,35 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 
 	devlink = priv_to_devlink(dev);
 	dl_port_index = mlx5_esw_vport_to_devlink_port_index(dev, vport_num);
-	err = devl_port_register_with_ops(devlink, dl_port, dl_port_index, ops);
+	err = devl_port_register_with_ops(devlink, &dl_port->dl_port, dl_port_index, ops);
 	if (err)
 		return err;
 
-	err = devl_rate_leaf_create(dl_port, vport, NULL);
+	err = devl_rate_leaf_create(&dl_port->dl_port, vport, NULL);
 	if (err)
 		goto rate_err;
 
 	return 0;
 
 rate_err:
-	devl_port_unregister(dl_port);
+	devl_port_unregister(&dl_port->dl_port);
 	return err;
 }
 
 void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, u16 vport_num)
 {
+	struct mlx5_devlink_port *dl_port;
 	struct mlx5_vport *vport;
 
 	vport = mlx5_eswitch_get_vport(esw, vport_num);
 	if (IS_ERR(vport) || !vport->dl_port)
 		return;
+	dl_port = vport->dl_port;
 
 	mlx5_esw_qos_vport_update_group(esw, vport, NULL, NULL);
-	devl_rate_leaf_destroy(vport->dl_port);
+	devl_rate_leaf_destroy(&dl_port->dl_port);
 
-	devl_port_unregister(vport->dl_port);
+	devl_port_unregister(&dl_port->dl_port);
 }
 
 struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u16 vport_num)
@@ -214,5 +217,5 @@ struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u1
 	struct mlx5_vport *vport;
 
 	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	return IS_ERR(vport) ? ERR_CAST(vport) : vport->dl_port;
+	return IS_ERR(vport) ? ERR_CAST(vport) : &vport->dl_port->dl_port;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 5d8d4a4f3e4e..044d0ba9fcf6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1121,7 +1121,7 @@ static void mlx5_eswitch_unload_pf_vf_vport(struct mlx5_eswitch *esw, u16 vport_
 
 int mlx5_eswitch_load_sf_vport(struct mlx5_eswitch *esw, u16 vport_num,
 			       enum mlx5_eswitch_vport_event enabled_events,
-			       struct devlink_port *dl_port, u32 controller, u32 sfnum)
+			       struct mlx5_devlink_port *dl_port, u32 controller, u32 sfnum)
 {
 	int err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index ad2ebd843ed2..b45013465738 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -172,6 +172,10 @@ enum mlx5_eswitch_vport_event {
 	MLX5_VPORT_PROMISC_CHANGE = BIT(3),
 };
 
+struct mlx5_devlink_port {
+	struct devlink_port dl_port;
+};
+
 struct mlx5_vport {
 	struct mlx5_core_dev    *dev;
 	struct hlist_head       uc_list[MLX5_L2_ADDR_HASH_SIZE];
@@ -200,7 +204,7 @@ struct mlx5_vport {
 	bool                    enabled;
 	enum mlx5_eswitch_vport_event enabled_events;
 	int index;
-	struct devlink_port *dl_port;
+	struct mlx5_devlink_port *dl_port;
 };
 
 struct mlx5_esw_indir_table;
@@ -734,7 +738,7 @@ int mlx5_esw_offloads_init_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num);
 void mlx5_esw_offloads_cleanup_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num);
 
 int mlx5_esw_offloads_init_sf_rep(struct mlx5_eswitch *esw, u16 vport_num,
-				  struct devlink_port *dl_port,
+				  struct mlx5_devlink_port *dl_port,
 				  u32 controller, u32 sfnum);
 void mlx5_esw_offloads_cleanup_sf_rep(struct mlx5_eswitch *esw, u16 vport_num);
 
@@ -743,7 +747,7 @@ void mlx5_esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num);
 
 int mlx5_eswitch_load_sf_vport(struct mlx5_eswitch *esw, u16 vport_num,
 			       enum mlx5_eswitch_vport_event enabled_events,
-			       struct devlink_port *dl_port, u32 controller, u32 sfnum);
+			       struct mlx5_devlink_port *dl_port, u32 controller, u32 sfnum);
 void mlx5_eswitch_unload_sf_vport(struct mlx5_eswitch *esw, u16 vport_num);
 
 int mlx5_eswitch_load_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs,
@@ -754,7 +758,7 @@ int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u16 vpor
 void mlx5_esw_offloads_pf_vf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num);
 
 int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num,
-					   struct devlink_port *dl_port,
+					   struct mlx5_devlink_port *dl_port,
 					   u32 controller, u32 sfnum);
 void mlx5_esw_offloads_sf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 1aa404218817..b7ece8767ffe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2552,7 +2552,7 @@ void mlx5_esw_offloads_cleanup_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num
 }
 
 int mlx5_esw_offloads_init_sf_rep(struct mlx5_eswitch *esw, u16 vport_num,
-				  struct devlink_port *dl_port,
+				  struct mlx5_devlink_port *dl_port,
 				  u32 controller, u32 sfnum)
 {
 	return mlx5_esw_offloads_sf_devlink_port_init(esw, vport_num, dl_port, controller, sfnum);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index f7bdbeb92eb3..e34a8f88c518 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -12,7 +12,7 @@
 #include "diag/sf_tracepoint.h"
 
 struct mlx5_sf {
-	struct devlink_port dl_port;
+	struct mlx5_devlink_port dl_port;
 	unsigned int port_index;
 	u32 controller;
 	u16 id;
@@ -296,7 +296,7 @@ static int mlx5_sf_add(struct mlx5_core_dev *dev, struct mlx5_sf_table *table,
 					 &sf->dl_port, new_attr->controller, new_attr->sfnum);
 	if (err)
 		goto esw_err;
-	*dl_port = &sf->dl_port;
+	*dl_port = &sf->dl_port.dl_port;
 	trace_mlx5_sf_add(dev, sf->port_index, sf->controller, sf->hw_fn_id, new_attr->sfnum);
 	return 0;
 
-- 
2.41.0


