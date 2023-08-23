Return-Path: <netdev+bounces-29866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4D4784FD7
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EA6281279
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8513E8484;
	Wed, 23 Aug 2023 05:10:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A9D1FB8
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CABC433CB;
	Wed, 23 Aug 2023 05:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767428;
	bh=kgtduLTDfD9dxADPlGJSJztuFvwrUyQi05Fv6qMPdQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6F64I1nCFPN915Mk70GSEZPmxBjj7B+nEVdLg3VLEn64hl9Ew6wQqDuVEIz9u+DJ
	 W7dvCzfNrZNSjg6UJK+8pdmrYd0at9S7SKGJObxlVywQhE2XP9rIO1S8v9QIqNz6dB
	 INwbb4vWGiCv14Sw23FysgkiQAM4g3IlFeHqd7bZNNYy9PDCnOeNNHGr83HujVXvU0
	 xSh8cm7ILCHXDZQP4xuAbgzbOf/0d5I9b0afIqa3tH0FRM9EmXPJTJrOm2g9FVHUS+
	 KlN71UBe3+rq0DoFmbaZMIqdfjiZSVMKR7p0ZG/8SzgkbG+9VPyf16STNXhQu0z/qW
	 j1xq9u5aX6VPg==
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
Subject: [net-next 04/15] net/mlx5: Allow mlx5_esw_offloads_devlink_port_register() to register SFs
Date: Tue, 22 Aug 2023 22:10:01 -0700
Message-ID: <20230823051012.162483-5-saeed@kernel.org>
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

Currently there is a separate set of functions used to
register/unregister the SF. The only difference is currently the ops
struct. Move the struct up and use it for SFs in
mlx5_esw_offloads_devlink_port_register().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     | 37 +++++++++++--------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 5e8557f7564c..60e25fbaef5f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -139,9 +139,24 @@ static void mlx5_esw_offloads_sf_devlink_port_cleanup(struct mlx5_eswitch *esw,
 	vport->dl_port = NULL;
 }
 
+static const struct devlink_port_ops mlx5_esw_dl_sf_port_ops = {
+#ifdef CONFIG_MLX5_SF_MANAGER
+	.port_del = mlx5_devlink_sf_port_del,
+#endif
+	.port_fn_hw_addr_get = mlx5_devlink_port_fn_hw_addr_get,
+	.port_fn_hw_addr_set = mlx5_devlink_port_fn_hw_addr_set,
+	.port_fn_roce_get = mlx5_devlink_port_fn_roce_get,
+	.port_fn_roce_set = mlx5_devlink_port_fn_roce_set,
+#ifdef CONFIG_MLX5_SF_MANAGER
+	.port_fn_state_get = mlx5_devlink_sf_port_fn_state_get,
+	.port_fn_state_set = mlx5_devlink_sf_port_fn_state_set,
+#endif
+};
+
 int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	struct mlx5_core_dev *dev = esw->dev;
+	const struct devlink_port_ops *ops;
 	struct devlink_port *dl_port;
 	unsigned int dl_port_index;
 	struct mlx5_vport *vport;
@@ -156,10 +171,14 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 	if (!dl_port)
 		return 0;
 
+	if (mlx5_esw_is_sf_vport(esw, vport_num))
+		ops = &mlx5_esw_dl_sf_port_ops;
+	else
+		ops = &mlx5_esw_pf_vf_dl_port_ops;
+
 	devlink = priv_to_devlink(dev);
 	dl_port_index = mlx5_esw_vport_to_devlink_port_index(dev, vport_num);
-	err = devl_port_register_with_ops(devlink, dl_port, dl_port_index,
-					  &mlx5_esw_pf_vf_dl_port_ops);
+	err = devl_port_register_with_ops(devlink, dl_port, dl_port_index, ops);
 	if (err)
 		return err;
 
@@ -196,20 +215,6 @@ struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u1
 	return IS_ERR(vport) ? ERR_CAST(vport) : vport->dl_port;
 }
 
-static const struct devlink_port_ops mlx5_esw_dl_sf_port_ops = {
-#ifdef CONFIG_MLX5_SF_MANAGER
-	.port_del = mlx5_devlink_sf_port_del,
-#endif
-	.port_fn_hw_addr_get = mlx5_devlink_port_fn_hw_addr_get,
-	.port_fn_hw_addr_set = mlx5_devlink_port_fn_hw_addr_set,
-	.port_fn_roce_get = mlx5_devlink_port_fn_roce_get,
-	.port_fn_roce_set = mlx5_devlink_port_fn_roce_set,
-#ifdef CONFIG_MLX5_SF_MANAGER
-	.port_fn_state_get = mlx5_devlink_sf_port_fn_state_get,
-	.port_fn_state_set = mlx5_devlink_sf_port_fn_state_set,
-#endif
-};
-
 int mlx5_esw_devlink_sf_port_register(struct mlx5_eswitch *esw, struct devlink_port *dl_port,
 				      u16 vport_num, u32 controller, u32 sfnum)
 {
-- 
2.41.0


