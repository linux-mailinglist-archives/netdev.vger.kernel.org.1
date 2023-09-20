Return-Path: <netdev+bounces-35120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5D47A72DA
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0101D1C2092F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE455674;
	Wed, 20 Sep 2023 06:36:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0515671
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F8EC433A9;
	Wed, 20 Sep 2023 06:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191760;
	bh=Xo5uKJbtf58bWVDg5AwhD2u1TTEtQPhbmvUD+Jb157o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2MH9lnpTGezkb1scYZ/+xXPy64wErk++I1aoUMPQ40ZgLcb0VacUm1IrueNeaMsL
	 ijpiQ+xPuRiNGNJFegj9CKwTiZGIQrEZ2JMtrKa+i8aSCJYH4F9y2jfRLOnQEN3bdA
	 TYdRf6NgNYEJLW+XXVQE0w2suIbFsayim7iL2w2JUIq0WPY+V5ALUghbf+koopoylT
	 9CpSldhL5uBrIfpp04VGfFBdWgZwRaHAi5i2/Ef44mr/cX28oZhJ32NwyBh6Z0yB4W
	 5umvTTUw+ChSVgYXMijbfuD5Fggl4W8++l9ystdRgoSEyBBe3VuHG7l7Zy2c+MbfwJ
	 slCcVh5/uQwaA==
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
Subject: [net-next 02/15] net/mlx5: Use devlink port pointer to get the pointer of container SF struct
Date: Tue, 19 Sep 2023 23:35:39 -0700
Message-ID: <20230920063552.296978-3-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920063552.296978-1-saeed@kernel.org>
References: <20230920063552.296978-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Benefit from the fact that struct devlink_port is eventually embedded
in struct mlx5_sf and use container_of() macro to get it instead of the
xarray lookup in every devlink port op.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  | 44 +++++--------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 519033d70e05..b4a373d2ba15 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -20,6 +20,13 @@ struct mlx5_sf {
 	u16 hw_state;
 };
 
+static void *mlx5_sf_by_dl_port(struct devlink_port *dl_port)
+{
+	struct mlx5_devlink_port *mlx5_dl_port = mlx5_devlink_port_get(dl_port);
+
+	return container_of(mlx5_dl_port, struct mlx5_sf, dl_port);
+}
+
 struct mlx5_sf_table {
 	struct mlx5_core_dev *dev; /* To refer from notifier context. */
 	struct xarray port_indices; /* port index based lookup. */
@@ -31,12 +38,6 @@ struct mlx5_sf_table {
 	struct notifier_block mdev_nb;
 };
 
-static struct mlx5_sf *
-mlx5_sf_lookup_by_index(struct mlx5_sf_table *table, unsigned int port_index)
-{
-	return xa_load(&table->port_indices, port_index);
-}
-
 static struct mlx5_sf *
 mlx5_sf_lookup_by_function_id(struct mlx5_sf_table *table, unsigned int fn_id)
 {
@@ -172,26 +173,19 @@ int mlx5_devlink_sf_port_fn_state_get(struct devlink_port *dl_port,
 				      struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(dl_port->devlink);
+	struct mlx5_sf *sf = mlx5_sf_by_dl_port(dl_port);
 	struct mlx5_sf_table *table;
-	struct mlx5_sf *sf;
-	int err = 0;
 
 	table = mlx5_sf_table_try_get(dev);
 	if (!table)
 		return -EOPNOTSUPP;
 
-	sf = mlx5_sf_lookup_by_index(table, dl_port->index);
-	if (!sf) {
-		err = -EOPNOTSUPP;
-		goto sf_err;
-	}
 	mutex_lock(&table->sf_state_lock);
 	*state = mlx5_sf_to_devlink_state(sf->hw_state);
 	*opstate = mlx5_sf_to_devlink_opstate(sf->hw_state);
 	mutex_unlock(&table->sf_state_lock);
-sf_err:
 	mlx5_sf_table_put(table);
-	return err;
+	return 0;
 }
 
 static int mlx5_sf_activate(struct mlx5_core_dev *dev, struct mlx5_sf *sf,
@@ -257,8 +251,8 @@ int mlx5_devlink_sf_port_fn_state_set(struct devlink_port *dl_port,
 				      struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(dl_port->devlink);
+	struct mlx5_sf *sf = mlx5_sf_by_dl_port(dl_port);
 	struct mlx5_sf_table *table;
-	struct mlx5_sf *sf;
 	int err;
 
 	table = mlx5_sf_table_try_get(dev);
@@ -267,14 +261,7 @@ int mlx5_devlink_sf_port_fn_state_set(struct devlink_port *dl_port,
 				   "Port state set is only supported in eswitch switchdev mode or SF ports are disabled.");
 		return -EOPNOTSUPP;
 	}
-	sf = mlx5_sf_lookup_by_index(table, dl_port->index);
-	if (!sf) {
-		err = -ENODEV;
-		goto out;
-	}
-
 	err = mlx5_sf_state_set(dev, table, sf, state, extack);
-out:
 	mlx5_sf_table_put(table);
 	return err;
 }
@@ -385,10 +372,9 @@ int mlx5_devlink_sf_port_del(struct devlink *devlink,
 			     struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	struct mlx5_sf *sf = mlx5_sf_by_dl_port(dl_port);
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
 	struct mlx5_sf_table *table;
-	struct mlx5_sf *sf;
-	int err = 0;
 
 	table = mlx5_sf_table_try_get(dev);
 	if (!table) {
@@ -396,20 +382,14 @@ int mlx5_devlink_sf_port_del(struct devlink *devlink,
 				   "Port del is only supported in eswitch switchdev mode or SF ports are disabled.");
 		return -EOPNOTSUPP;
 	}
-	sf = mlx5_sf_lookup_by_index(table, dl_port->index);
-	if (!sf) {
-		err = -ENODEV;
-		goto sf_err;
-	}
 
 	mlx5_eswitch_unload_sf_vport(esw, sf->hw_fn_id);
 
 	mutex_lock(&table->sf_state_lock);
 	mlx5_sf_dealloc(table, sf);
 	mutex_unlock(&table->sf_state_lock);
-sf_err:
 	mlx5_sf_table_put(table);
-	return err;
+	return 0;
 }
 
 static bool mlx5_sf_state_update_check(const struct mlx5_sf *sf, u8 new_state)
-- 
2.41.0


