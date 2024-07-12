Return-Path: <netdev+bounces-110985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5273B92F314
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076121F2282C
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94BE523A;
	Fri, 12 Jul 2024 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHV010fN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B44C97
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744408; cv=none; b=XwLBm83NkoEOHUZkXP27+AzMISYNHSGLgwmDXPWS4WyeEdGRpAcOjtrXpnTOx+RP6wfc3lfcuxoKaFwD6TTzGi+Bol/Pi9fw+jHMdLVbD+ZixdK3a8rBKzNKYaQKZQ+pkN7tF/Gpo5IyOtxz/6Lm9+npOTxf8trSoLq/7ECoJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744408; c=relaxed/simple;
	bh=RD4UbqPP1RnaSCibgSxfet9vt1wWq1U0hDug3RgiRP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5Q6F6MLUsGd8L+pGoThtHgujRAqNqRhikWHX15leJMI9v6lkGAjFCryrgyfwrHYQT9UItIm2Izhy9lV+tSYVgbIQaRMGj7TNb5tPnNn0QXmxjHWg7k1pOHafz+ufGARpdZqhYcRL/mICpkrbpBBh9V5zev2Gb0k8gRLcHHd9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHV010fN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C94C116B1;
	Fri, 12 Jul 2024 00:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720744408;
	bh=RD4UbqPP1RnaSCibgSxfet9vt1wWq1U0hDug3RgiRP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHV010fNBLyMuw6O2EQefdXBnODDCOlUCoJvPwE8jSgrcqrJeDovDVKQGFa1ytSe6
	 Ec29vRCfowFaeL0ZzqNKCT5MGdbYmp6ih1I7GIoG7W7au2I9zuva5CmsIINKq7WSXs
	 Yah971zf4c9CnHSQd+qjcaaV/DgFmCBo4sm/Qd2GUUrJXlkAve5DRVv2Dc2mXUOXcu
	 +gdnwYIWmD0elsf9J+4xenTW9KaOAIEKfaznqxVHiLPli0OKAhvrAy33lnWHCHqb7T
	 ageN1N2J3D/ai0+xFsK/Zyg0rmumwyau9q7/nqyuG5Q0cbzrWrTBpCSBLF03L2srW4
	 XoalMJBbBFXbQ==
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
	Daniel Jurgens <danielj@nvidia.com>,
	William Tu <witu@nvidia.com>
Subject: [PATCH net-next V3 3/4] net/mlx5: Set default max eqs for SFs
Date: Thu, 11 Jul 2024 17:33:09 -0700
Message-ID: <20240712003310.355106-4-saeed@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712003310.355106-1-saeed@kernel.org>
References: <20240712003310.355106-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Jurgens <danielj@nvidia.com>

If the user hasn't configured max_io_eqs set a low default. The SF
driver shouldn't try to create more than this, but FW will enforce this
limit.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h    |  3 +++
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 12 +++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c | 12 ++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 88745dc6aed5..578466d69f21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -223,6 +223,7 @@ struct mlx5_vport {
 
 	u16 vport;
 	bool                    enabled;
+	bool max_eqs_set;
 	enum mlx5_eswitch_vport_event enabled_events;
 	int index;
 	struct mlx5_devlink_port *dl_port;
@@ -579,6 +580,8 @@ int mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port,
 int mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port,
 					u32 max_io_eqs,
 					struct netlink_ext_ack *extack);
+int mlx5_devlink_port_fn_max_io_eqs_set_sf_default(struct devlink_port *port,
+						   struct netlink_ext_ack *extack);
 
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 099a716f1784..768199d2255a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -68,6 +68,7 @@
 #define MLX5_ESW_FT_OFFLOADS_DROP_RULE (1)
 
 #define MLX5_ESW_MAX_CTRL_EQS 4
+#define MLX5_ESW_DEFAULT_SF_COMP_EQS 8
 
 static struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_mirror_ns = {
 	.max_fte = MLX5_ESW_VPORT_TBL_SIZE,
@@ -4683,9 +4684,18 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
-
+	vport->max_eqs_set = true;
 out:
 	mutex_unlock(&esw->state_lock);
 	kfree(query_ctx);
 	return err;
 }
+
+int
+mlx5_devlink_port_fn_max_io_eqs_set_sf_default(struct devlink_port *port,
+					       struct netlink_ext_ack *extack)
+{
+	return mlx5_devlink_port_fn_max_io_eqs_set(port,
+						   MLX5_ESW_DEFAULT_SF_COMP_EQS,
+						   extack);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 6c11e075cab0..a96be98be032 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -161,6 +161,7 @@ int mlx5_devlink_sf_port_fn_state_get(struct devlink_port *dl_port,
 static int mlx5_sf_activate(struct mlx5_core_dev *dev, struct mlx5_sf *sf,
 			    struct netlink_ext_ack *extack)
 {
+	struct mlx5_vport *vport;
 	int err;
 
 	if (mlx5_sf_is_active(sf))
@@ -170,6 +171,13 @@ static int mlx5_sf_activate(struct mlx5_core_dev *dev, struct mlx5_sf *sf,
 		return -EBUSY;
 	}
 
+	vport = mlx5_devlink_port_vport_get(&sf->dl_port.dl_port);
+	if (!vport->max_eqs_set && MLX5_CAP_GEN_2(dev, max_num_eqs_24b)) {
+		err = mlx5_devlink_port_fn_max_io_eqs_set_sf_default(&sf->dl_port.dl_port,
+								     extack);
+		if (err)
+			return err;
+	}
 	err = mlx5_cmd_sf_enable_hca(dev, sf->hw_fn_id);
 	if (err)
 		return err;
@@ -318,7 +326,11 @@ int mlx5_devlink_sf_port_new(struct devlink *devlink,
 
 static void mlx5_sf_dealloc(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 {
+	struct mlx5_vport *vport;
+
 	mutex_lock(&table->sf_state_lock);
+	vport = mlx5_devlink_port_vport_get(&sf->dl_port.dl_port);
+	vport->max_eqs_set = false;
 
 	mlx5_sf_function_id_erase(table, sf);
 
-- 
2.45.2


