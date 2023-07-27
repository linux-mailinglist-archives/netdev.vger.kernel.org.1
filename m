Return-Path: <netdev+bounces-22029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA62765B83
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0671C216EF
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A881CA1D;
	Thu, 27 Jul 2023 18:39:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00DF1C9FA
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7290DC433B7;
	Thu, 27 Jul 2023 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690483173;
	bh=KU2PkTqCvH2iTuJ72764GBNfl2BCk1EalHuuKsQh44s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KflT9P1ExQFVJbc9veCKSNeTM30Pqt+YhIh2w+WlqFWvfmIQdOGe4X4ZqiimWPeh2
	 QR4SYc75cT4X7nfXuUgRJQ+Kz6TaWD000+IDpeM71q+L8lA0pO42Bxv+/jQ8pKejrN
	 r0IKiotDVCQ+gyZV979Et6ODIXbTSUSjyTRIS/LN/yLAUZl/Chlp70uFIaMJKme+tc
	 NCRVN8MEcplQtTPGunx58MR1bBdsP/2j5ImLJ+dqPUD3pFn+DbkOCkFpl3a/rECWVU
	 wvBDRHbkAbJ7fprMrLOlpalhVufBZeGfgrrfISVFPq6VoRdpclflACsm3pIaPmOEkJ
	 td7gWjJZI+YDw==
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
Subject: [net-next V2 11/15] net/mlx5: Don't check vport->enabled in port ops
Date: Thu, 27 Jul 2023 11:39:10 -0700
Message-ID: <20230727183914.69229-12-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727183914.69229-1-saeed@kernel.org>
References: <20230727183914.69229-1-saeed@kernel.org>
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


