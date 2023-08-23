Return-Path: <netdev+bounces-29873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3886784FE1
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D78B281307
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A4E8BF1;
	Wed, 23 Aug 2023 05:10:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3854A937
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77761C433AB;
	Wed, 23 Aug 2023 05:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767437;
	bh=iXgmkvM3CXuC7SeKi22rUsmIChvtO43hQlWENgxTITo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLroEl9iLJ9VouK4IMmZICI/9zeUXmlPgAzUmUclVdbtJoqRIF3cd2nvKYwH+lcT4
	 lI5NjsxUCkJHt+MYIious9vp2+ozvb26+ceon9Pr4+vUAYSQ3H2+nqzvIV4GS/9Vk9
	 AnkNoiDaLsQjAmJpsJNrUEZS8TvUR9afMscJSlIji7udmoTnJS/GHcuhMgYx9B4nLk
	 PgNMxRKN/XcUgimHTXzl83jFYdWP9mo6yFB9efmviwszLBboFs87fBhIqRa6T8LkOU
	 ewMYGSSzjxO4l20YcgG/uutxxkG0PkxWmQXS+mZu2YxnROq244u+SQLIu6EvrhQr6n
	 cVjlzamw/Mbwg==
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
Subject: [net-next 11/15] net/mlx5: Relax mlx5_devlink_eswitch_get() return value checking
Date: Tue, 22 Aug 2023 22:10:08 -0700
Message-ID: <20230823051012.162483-12-saeed@kernel.org>
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

If called from port ops, it is not needed to perform the checks in
mlx5_devlink_eswitch_get(). The reason is devlink port would not be
registered if the checks are not true. Introduce relaxed version
mlx5_devlink_eswitch_nocheck_get() and use it in port ops.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 21 ++++++++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  6 ++-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 39 ++++---------------
 3 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 5368b33fde63..db1c2a076364 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -77,18 +77,31 @@ static int mlx5_eswitch_check(const struct mlx5_core_dev *dev)
 	return 0;
 }
 
-struct mlx5_eswitch *mlx5_devlink_eswitch_get(struct devlink *devlink)
+static struct mlx5_eswitch *__mlx5_devlink_eswitch_get(struct devlink *devlink, bool check)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	int err;
 
-	err = mlx5_eswitch_check(dev);
-	if (err)
-		return ERR_PTR(err);
+	if (check) {
+		err = mlx5_eswitch_check(dev);
+		if (err)
+			return ERR_PTR(err);
+	}
 
 	return dev->priv.eswitch;
 }
 
+struct mlx5_eswitch *__must_check
+mlx5_devlink_eswitch_get(struct devlink *devlink)
+{
+	return __mlx5_devlink_eswitch_get(devlink, true);
+}
+
+struct mlx5_eswitch *mlx5_devlink_eswitch_nocheck_get(struct devlink *devlink)
+{
+	return __mlx5_devlink_eswitch_get(devlink, false);
+}
+
 struct mlx5_vport *__must_check
 mlx5_eswitch_get_vport(struct mlx5_eswitch *esw, u16 vport_num)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 8d03d4fe6eec..9f94c3d6d6e5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -679,7 +679,11 @@ void mlx5e_tc_clean_fdb_peer_flows(struct mlx5_eswitch *esw);
 			  MLX5_CAP_GEN_2((esw->dev), ec_vf_vport_base) +\
 			  (last) - 1)
 
-struct mlx5_eswitch *mlx5_devlink_eswitch_get(struct devlink *devlink);
+struct mlx5_eswitch *__must_check
+mlx5_devlink_eswitch_get(struct devlink *devlink);
+
+struct mlx5_eswitch *mlx5_devlink_eswitch_nocheck_get(struct devlink *devlink);
+
 struct mlx5_vport *__must_check
 mlx5_eswitch_get_vport(struct mlx5_eswitch *esw, u16 vport_num);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 87cc6ad2e17f..23b562f07c68 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3634,7 +3634,7 @@ static bool esw_offloads_devlink_ns_eq_netdev_ns(struct devlink *devlink)
 	struct net *devl_net, *netdev_net;
 	struct mlx5_eswitch *esw;
 
-	esw = mlx5_devlink_eswitch_get(devlink);
+	esw = mlx5_devlink_eswitch_nocheck_get(devlink);
 	netdev_net = dev_net(esw->dev->mlx5e_res.uplink_netdev);
 	devl_net = devlink_net(devlink);
 
@@ -4222,13 +4222,10 @@ int mlx5_devlink_port_fn_hw_addr_get(struct devlink_port *port,
 				     u8 *hw_addr, int *hw_addr_len,
 				     struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw;
+	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
 	struct mlx5_vport *vport;
 	u16 vport_num;
 
-	esw = mlx5_devlink_eswitch_get(port->devlink);
-	if (IS_ERR(esw))
-		return PTR_ERR(esw);
 
 	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
 
@@ -4249,15 +4246,9 @@ int mlx5_devlink_port_fn_hw_addr_set(struct devlink_port *port,
 				     const u8 *hw_addr, int hw_addr_len,
 				     struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw;
+	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
 	u16 vport_num;
 
-	esw = mlx5_devlink_eswitch_get(port->devlink);
-	if (IS_ERR(esw)) {
-		NL_SET_ERR_MSG_MOD(extack, "Eswitch doesn't support set hw_addr");
-		return PTR_ERR(esw);
-	}
-
 	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
 	return mlx5_eswitch_set_vport_mac(esw, vport_num, hw_addr);
 }
@@ -4277,13 +4268,9 @@ mlx5_devlink_port_fn_get_vport(struct devlink_port *port, struct mlx5_eswitch *e
 int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enabled,
 					struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw;
+	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
 	struct mlx5_vport *vport;
 
-	esw = mlx5_devlink_eswitch_get(port->devlink);
-	if (IS_ERR(esw))
-		return PTR_ERR(esw);
-
 	if (!MLX5_CAP_GEN(esw->dev, migration)) {
 		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support migration");
 		return -EOPNOTSUPP;
@@ -4304,17 +4291,13 @@ int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enab
 int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 					struct netlink_ext_ack *extack)
 {
+	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
 	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	struct mlx5_eswitch *esw;
 	struct mlx5_vport *vport;
 	void *query_ctx;
 	void *hca_caps;
 	int err;
 
-	esw = mlx5_devlink_eswitch_get(port->devlink);
-	if (IS_ERR(esw))
-		return PTR_ERR(esw);
-
 	if (!MLX5_CAP_GEN(esw->dev, migration)) {
 		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support migration");
 		return -EOPNOTSUPP;
@@ -4368,13 +4351,9 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 int mlx5_devlink_port_fn_roce_get(struct devlink_port *port, bool *is_enabled,
 				  struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw;
+	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
 	struct mlx5_vport *vport;
 
-	esw = mlx5_devlink_eswitch_get(port->devlink);
-	if (IS_ERR(esw))
-		return PTR_ERR(esw);
-
 	vport = mlx5_devlink_port_fn_get_vport(port, esw);
 	if (IS_ERR(vport)) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
@@ -4390,18 +4369,14 @@ int mlx5_devlink_port_fn_roce_get(struct devlink_port *port, bool *is_enabled,
 int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 				  struct netlink_ext_ack *extack)
 {
+	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
 	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	struct mlx5_eswitch *esw;
 	struct mlx5_vport *vport;
 	void *query_ctx;
 	void *hca_caps;
 	u16 vport_num;
 	int err;
 
-	esw = mlx5_devlink_eswitch_get(port->devlink);
-	if (IS_ERR(esw))
-		return PTR_ERR(esw);
-
 	vport = mlx5_devlink_port_fn_get_vport(port, esw);
 	if (IS_ERR(vport)) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
-- 
2.41.0


