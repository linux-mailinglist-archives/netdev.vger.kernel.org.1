Return-Path: <netdev+bounces-20585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEED7602A8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACC4281661
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4147156C1;
	Mon, 24 Jul 2023 22:44:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A323154A0
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A8EC433BA;
	Mon, 24 Jul 2023 22:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690238682;
	bh=KU2PkTqCvH2iTuJ72764GBNfl2BCk1EalHuuKsQh44s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVoH6fPatc9sv8N7xN5aa3Go8CTyUnPvS7ORU9cXW3iKyz5wgY/tzfpoA7odrjrrQ
	 8JF6ZVcTHc7TWLUydeObnnEo/13fJufyJ2Nt2pESxUwJvaZnokfDn+FVKbk27hT0Aw
	 l3bTAmbsD7IzAndQzFguRwnp4lQWNoN21uKWHjZNpGmJ7vWDk78V7zR/pt3/CcZ4ox
	 qKKnB+moLnore3Pas9bJ6Hq7UfYUW/9bqyu8AzqJJvsP9Am2eJrE+NX7crc1ikMX5V
	 Jr/RmTdW16TT8Ewbnc5+QlWTr55Oign9ytzxUl3l7JbcyUit2MIlhxKKrP5BWZCM2+
	 PHaevy/x8fd6g==
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
Subject: [net-next 13/14] net/mlx5: Don't check vport->enabled in port ops
Date: Mon, 24 Jul 2023 15:44:25 -0700
Message-ID: <20230724224426.231024-14-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724224426.231024-1-saeed@kernel.org>
References: <20230724224426.231024-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

vport->enabled is always set for a vport for which a devlink port is
registered, therefore the checks in the ops are pointless.
Remove those.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 28 ++++---------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b4b8cb788573..c192000e3614 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4125,7 +4125,6 @@ int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enab
 {
 	struct mlx5_eswitch *esw;
 	struct mlx5_vport *vport;
-	int err = -EOPNOTSUPP;
 
 	esw = mlx5_devlink_eswitch_get(port->devlink);
 	if (IS_ERR(esw))
@@ -4133,7 +4132,7 @@ int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enab
 
 	if (!MLX5_CAP_GEN(esw->dev, migration)) {
 		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support migration");
-		return err;
+		return -EOPNOTSUPP;
 	}
 
 	vport = mlx5_devlink_port_fn_get_vport(port, esw);
@@ -4143,12 +4142,9 @@ int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enab
 	}
 
 	mutex_lock(&esw->state_lock);
-	if (vport->enabled) {
-		*is_enabled = vport->info.mig_enabled;
-		err = 0;
-	}
+	*is_enabled = vport->info.mig_enabled;
 	mutex_unlock(&esw->state_lock);
-	return err;
+	return 0;
 }
 
 int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
@@ -4177,10 +4173,6 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 	}
 
 	mutex_lock(&esw->state_lock);
-	if (!vport->enabled) {
-		NL_SET_ERR_MSG_MOD(extack, "Eswitch vport is disabled");
-		goto out;
-	}
 
 	if (vport->info.mig_enabled == enable) {
 		err = 0;
@@ -4224,7 +4216,6 @@ int mlx5_devlink_port_fn_roce_get(struct devlink_port *port, bool *is_enabled,
 {
 	struct mlx5_eswitch *esw;
 	struct mlx5_vport *vport;
-	int err = -EOPNOTSUPP;
 
 	esw = mlx5_devlink_eswitch_get(port->devlink);
 	if (IS_ERR(esw))
@@ -4237,12 +4228,9 @@ int mlx5_devlink_port_fn_roce_get(struct devlink_port *port, bool *is_enabled,
 	}
 
 	mutex_lock(&esw->state_lock);
-	if (vport->enabled) {
-		*is_enabled = vport->info.roce_enabled;
-		err = 0;
-	}
+	*is_enabled = vport->info.roce_enabled;
 	mutex_unlock(&esw->state_lock);
-	return err;
+	return 0;
 }
 
 int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
@@ -4251,10 +4239,10 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
 	struct mlx5_eswitch *esw;
 	struct mlx5_vport *vport;
-	int err = -EOPNOTSUPP;
 	void *query_ctx;
 	void *hca_caps;
 	u16 vport_num;
+	int err;
 
 	esw = mlx5_devlink_eswitch_get(port->devlink);
 	if (IS_ERR(esw))
@@ -4268,10 +4256,6 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 	vport_num = vport->vport;
 
 	mutex_lock(&esw->state_lock);
-	if (!vport->enabled) {
-		NL_SET_ERR_MSG_MOD(extack, "Eswitch vport is disabled");
-		goto out;
-	}
 
 	if (vport->info.roce_enabled == enable) {
 		err = 0;
-- 
2.41.0


