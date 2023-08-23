Return-Path: <netdev+bounces-29874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A86784FE2
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8CC2812D0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC15A937;
	Wed, 23 Aug 2023 05:10:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3FBA959
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF50C433D9;
	Wed, 23 Aug 2023 05:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767438;
	bh=QuCTlNuNJCYKzNjJbvinYdVhCQtsxNGSPPsZPGIYqh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhYctr1UaYqjMMwhrvkkTlcW6Zx1qeXFdxBpBD17VRkfnHI5koS/9ZXa6pw+uSGZ+
	 HAD93kERx+7jmBCDwO+O5HIxO+pufj4GKY5D6+jErPPrWEVDZ1aGkuFvMzeQdypmMJ
	 J985I8r5fIcGKEvgjyYgJoc2l32is6lk4j4VXSCpoejNfWEIfrDd5Gh828Ogt0sInB
	 9zWhzOrlY8flM2+IUQqvrriESD4rWOJFY2e91Ty9R6oGZ2hXEq3rcyyjmtSXD5oBlm
	 ERYg7S9Ga4lT0CPtJVGfj/u3mKn9pEKHHSEpqoyx8IU8iNqyVNoyrwOMxu+5kooUTx
	 oMl2u/XRO+eug==
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
Subject: [net-next 12/15] net/mlx5: Check vhca_resource_manager capability in each op and add extack msg
Date: Tue, 22 Aug 2023 22:10:09 -0700
Message-ID: <20230823051012.162483-13-saeed@kernel.org>
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

Since the follow-up patch is going to remove
mlx5_devlink_port_fn_get_vport() entirely, move the vhca_resource_manager
capability checking to individual ops. Add proper extack message
on the way.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 23b562f07c68..e4d1744516f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4258,9 +4258,6 @@ mlx5_devlink_port_fn_get_vport(struct devlink_port *port, struct mlx5_eswitch *e
 {
 	u16 vport_num;
 
-	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
-		return ERR_PTR(-EOPNOTSUPP);
-
 	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
 	return mlx5_eswitch_get_vport(esw, vport_num);
 }
@@ -4276,6 +4273,11 @@ int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enab
 		return -EOPNOTSUPP;
 	}
 
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+		return -EOPNOTSUPP;
+	}
+
 	vport = mlx5_devlink_port_fn_get_vport(port, esw);
 	if (IS_ERR(vport)) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
@@ -4303,6 +4305,11 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 		return -EOPNOTSUPP;
 	}
 
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+		return -EOPNOTSUPP;
+	}
+
 	vport = mlx5_devlink_port_fn_get_vport(port, esw);
 	if (IS_ERR(vport)) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
@@ -4354,6 +4361,11 @@ int mlx5_devlink_port_fn_roce_get(struct devlink_port *port, bool *is_enabled,
 	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
 	struct mlx5_vport *vport;
 
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+		return -EOPNOTSUPP;
+	}
+
 	vport = mlx5_devlink_port_fn_get_vport(port, esw);
 	if (IS_ERR(vport)) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
@@ -4377,6 +4389,11 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 	u16 vport_num;
 	int err;
 
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+		return -EOPNOTSUPP;
+	}
+
 	vport = mlx5_devlink_port_fn_get_vport(port, esw);
 	if (IS_ERR(vport)) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
-- 
2.41.0


