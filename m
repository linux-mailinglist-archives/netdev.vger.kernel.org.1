Return-Path: <netdev+bounces-29869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9999784FDD
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FE92812D5
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37A38838;
	Wed, 23 Aug 2023 05:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A099469
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAFDC433C8;
	Wed, 23 Aug 2023 05:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767431;
	bh=n1fIsFcKJGmrfbYZoOcrBZZ80ehDZ+t8xHaq+L7Xbqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMVsNXP4ahtNn73aUvEuuvbdVwcnibQtiwISozfEGmqgTGdZoquCqa+qGToEoyROQ
	 I1rmV2uOqp5NgJB6aVKXqS/dG4Q6tK36yutxE8hT8lqIzKFIZ82oBkn33KiOgyiSkG
	 IaQUTb8lQaEsCxk/PcFFHRAzIahTx5a75Z3UijdQSi0RNlR7dmbXuRz1raSGSrNNpL
	 WXhP3hRRRpzoXmK3itR7e5X7GPT0+eycZOBlgGzsEn2fClUJ6GQGlFu1kXRJ0Jqjwp
	 OuOJEiR3yqBtJ2euTR0G35hAwFXHRSyqfnJQ7FsEroFy/WICWGsey5G8wg6gzvvVYy
	 618EfpYw0nEMg==
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
Subject: [net-next 07/15] net/mlx5: Don't register ops for non-PF/VF/SF port and avoid checks in ops
Date: Tue, 22 Aug 2023 22:10:04 -0700
Message-ID: <20230823051012.162483-8-saeed@kernel.org>
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

Currently each PF/VF/SF devlink port op called into mlx5 code calls
is_port_function_supported() to check if the port is either
PF, VF or SF. So make sure that the ops are registered with devlink
port only for those and avoid the is_port_function_supported() checks
in ops.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c      |  4 +++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c  |  6 ++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h  |  1 +
 .../mellanox/mlx5/core/eswitch_offloads.c      | 18 ------------------
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index b77893507476..69084673e7e6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -173,8 +173,10 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 
 	if (mlx5_esw_is_sf_vport(esw, vport_num))
 		ops = &mlx5_esw_dl_sf_port_ops;
-	else
+	else if (mlx5_eswitch_is_pf_vf_vport(esw, vport_num))
 		ops = &mlx5_esw_pf_vf_dl_port_ops;
+	else
+		ops = NULL;
 
 	devlink = priv_to_devlink(dev);
 	dl_port_index = mlx5_esw_vport_to_devlink_port_index(dev, vport_num);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index f77237401ee9..5d8d4a4f3e4e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1970,6 +1970,12 @@ bool mlx5_eswitch_is_vf_vport(struct mlx5_eswitch *esw, u16 vport_num)
 	return mlx5_esw_check_port_type(esw, vport_num, MLX5_ESW_VPT_VF);
 }
 
+bool mlx5_eswitch_is_pf_vf_vport(struct mlx5_eswitch *esw, u16 vport_num)
+{
+	return vport_num == MLX5_VPORT_PF ||
+		mlx5_eswitch_is_vf_vport(esw, vport_num);
+}
+
 bool mlx5_esw_is_sf_vport(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	return mlx5_esw_check_port_type(esw, vport_num, MLX5_ESW_VPT_SF);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index e1e808105e98..ad2ebd843ed2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -680,6 +680,7 @@ struct mlx5_vport *__must_check
 mlx5_eswitch_get_vport(struct mlx5_eswitch *esw, u16 vport_num);
 
 bool mlx5_eswitch_is_vf_vport(struct mlx5_eswitch *esw, u16 vport_num);
+bool mlx5_eswitch_is_pf_vf_vport(struct mlx5_eswitch *esw, u16 vport_num);
 bool mlx5_esw_is_sf_vport(struct mlx5_eswitch *esw, u16 vport_num);
 
 int mlx5_esw_funcs_changed_handler(struct notifier_block *nb, unsigned long type, void *data);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 4b03f2bf605d..1aa404218817 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4218,14 +4218,6 @@ u32 mlx5_eswitch_get_vport_metadata_for_set(struct mlx5_eswitch *esw,
 }
 EXPORT_SYMBOL(mlx5_eswitch_get_vport_metadata_for_set);
 
-static bool
-is_port_function_supported(struct mlx5_eswitch *esw, u16 vport_num)
-{
-	return vport_num == MLX5_VPORT_PF ||
-	       mlx5_eswitch_is_vf_vport(esw, vport_num) ||
-	       mlx5_esw_is_sf_vport(esw, vport_num);
-}
-
 int mlx5_devlink_port_fn_hw_addr_get(struct devlink_port *port,
 				     u8 *hw_addr, int *hw_addr_len,
 				     struct netlink_ext_ack *extack)
@@ -4239,8 +4231,6 @@ int mlx5_devlink_port_fn_hw_addr_get(struct devlink_port *port,
 		return PTR_ERR(esw);
 
 	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
-	if (!is_port_function_supported(esw, vport_num))
-		return -EOPNOTSUPP;
 
 	vport = mlx5_eswitch_get_vport(esw, vport_num);
 	if (IS_ERR(vport)) {
@@ -4269,11 +4259,6 @@ int mlx5_devlink_port_fn_hw_addr_set(struct devlink_port *port,
 	}
 
 	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
-	if (!is_port_function_supported(esw, vport_num)) {
-		NL_SET_ERR_MSG_MOD(extack, "Port doesn't support set hw_addr");
-		return -EINVAL;
-	}
-
 	return mlx5_eswitch_set_vport_mac(esw, vport_num, hw_addr);
 }
 
@@ -4286,9 +4271,6 @@ mlx5_devlink_port_fn_get_vport(struct devlink_port *port, struct mlx5_eswitch *e
 		return ERR_PTR(-EOPNOTSUPP);
 
 	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
-	if (!is_port_function_supported(esw, vport_num))
-		return ERR_PTR(-EOPNOTSUPP);
-
 	return mlx5_eswitch_get_vport(esw, vport_num);
 }
 
-- 
2.41.0


