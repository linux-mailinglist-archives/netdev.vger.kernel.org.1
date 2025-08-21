Return-Path: <netdev+bounces-215833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D35B308BE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 23:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36034A28788
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 21:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52712EB5C1;
	Thu, 21 Aug 2025 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+VUnnNg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DACE2EB5AB
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813536; cv=none; b=JefoUcZDEKuMw6sM3bPPChwi4SgwrYiPmrIf5wAzvhQHT+i4shdZnfxMw+n17CGzjBgA++EcILYFBZLBiX0n7b8K9JDrECTFtan5hek4prolIb45RBOu6MsunOjdQ41f7QxeNRwjTM0Kyh5bdgpbgFu64TUy0j0Q4coTM9cw0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813536; c=relaxed/simple;
	bh=rHT6baWng5Doep7tNskldJeg8sAI3DKafQW5NJRgTU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQcxa6ZaQqVT8JXdLl+2bqS3FY+P9FcHpZd0v7ZeZuKkRZ9SWET2f/k0riqelqDsWOlsgIsL+VaoZQuSUm2yZC4vbKMCESnkb3UfDJaPVabf+4k6ftwcKqSJFHM+3QEEEuWXdgZnlCPlxwROJWwdashjLG++RPJleqJ3xKRVyIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+VUnnNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC3BC4CEF4;
	Thu, 21 Aug 2025 21:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755813536;
	bh=rHT6baWng5Doep7tNskldJeg8sAI3DKafQW5NJRgTU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G+VUnnNguBwkbA6G3ComBtYVOmd0jH/kiIYYocTHvJCnaocYr/pXYKFVHv00l26KF
	 DVkyh2idwNu9Bj9RgKhvZfKIVoKLsAC41QFIKlimCwY6zcUOUXV8ajl6I20hhW22kJ
	 Bk6x+LVoI6tdY2ZFscFvBsxMojLLFHPbAyt0BDIjFtpSyLzX2s+bNCKzS6v8lSeEky
	 3P0c8/sUFLBff45NKYar0tRjeztaq7xMn+sGBMAk9sF3wm545cq9LEVJ0LkrMxieS4
	 ZhvjuPXzv2a6BDhQY5uuzawg5u20ukw+rm3X+NK/yGk+lgsoT2UPqP/pv7Puspa6zf
	 vvB6IoGDosUeg==
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
	Parav Pandit <parav@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: [PATCH net-next 5/7] net/mlx5: E-Switch, Register representors for adjacent vports
Date: Thu, 21 Aug 2025 14:58:37 -0700
Message-ID: <20250821215839.280364-6-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821215839.280364-1-saeed@kernel.org>
References: <20250821215839.280364-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Register representors for adjacent vports dynamically when they are
discovered. Dynamically added representors state will now be set to
'REGISTERED' when the representor type was already registered,
otherwise they won't be loaded.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/esw/adj_vport.c        | 10 ++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  5 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 33 ++++++++++++++++---
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
index 8e6edd4b6386..26f2ba6f665d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
@@ -85,10 +85,19 @@ static int mlx5_esw_adj_vport_create(struct mlx5_eswitch *esw, u16 vhca_id)
 
 	mlx5_fs_vport_egress_acl_ns_add(esw->dev->priv.steering, vport->index);
 	mlx5_fs_vport_ingress_acl_ns_add(esw->dev->priv.steering, vport->index);
+	err = mlx5_esw_offloads_rep_add(esw, vport);
+	if (err)
+		goto err_free;
 
 	mlx5_esw_adj_vport_modify(esw->dev, vport_num, MLX5_ADJ_VPORT_CONNECT);
 	return 0;
 
+err_free:
+	mlx5_fs_vport_ingress_acl_ns_remove(esw->dev->priv.steering,
+					    vport->index);
+	mlx5_fs_vport_egress_acl_ns_remove(esw->dev->priv.steering,
+					   vport->index);
+	mlx5_esw_vport_free(esw, vport);
 err_destroy:
 	mlx5_esw_destroy_esw_vport(esw->dev, vport_num);
 	return err;
@@ -103,6 +112,7 @@ static void mlx5_esw_adj_vport_destroy(struct mlx5_eswitch *esw,
 		  vport_num, vport->vhca_id);
 	mlx5_esw_adj_vport_modify(esw->dev, vport_num,
 				  MLX5_ADJ_VPORT_DISCONNECT);
+	mlx5_esw_offloads_rep_remove(esw, vport);
 	mlx5_fs_vport_egress_acl_ns_remove(esw->dev->priv.steering,
 					   vport->index);
 	mlx5_fs_vport_ingress_acl_ns_remove(esw->dev->priv.steering,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 9f8bb397eae5..9fc020bc40cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -838,6 +838,11 @@ void mlx5_esw_vport_vhca_id_unmap(struct mlx5_eswitch *esw,
 int mlx5_eswitch_vhca_id_to_vport(struct mlx5_eswitch *esw, u16 vhca_id, u16 *vport_num);
 bool mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id);
 
+void mlx5_esw_offloads_rep_remove(struct mlx5_eswitch *esw,
+				  const struct mlx5_vport *vport);
+int mlx5_esw_offloads_rep_add(struct mlx5_eswitch *esw,
+			      const struct mlx5_vport *vport);
+
 /**
  * struct mlx5_esw_event_info - Indicates eswitch mode changed/changing.
  *
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index fb03981d5036..d57f86d297ab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2378,7 +2378,20 @@ static int esw_offloads_start(struct mlx5_eswitch *esw,
 	return 0;
 }
 
-static int mlx5_esw_offloads_rep_init(struct mlx5_eswitch *esw, const struct mlx5_vport *vport)
+void mlx5_esw_offloads_rep_remove(struct mlx5_eswitch *esw,
+				  const struct mlx5_vport *vport)
+{
+	struct mlx5_eswitch_rep *rep = xa_load(&esw->offloads.vport_reps,
+					       vport->vport);
+
+	if (!rep)
+		return;
+	xa_erase(&esw->offloads.vport_reps, vport->vport);
+	kfree(rep);
+}
+
+int mlx5_esw_offloads_rep_add(struct mlx5_eswitch *esw,
+			      const struct mlx5_vport *vport)
 {
 	struct mlx5_eswitch_rep *rep;
 	int rep_type;
@@ -2390,9 +2403,19 @@ static int mlx5_esw_offloads_rep_init(struct mlx5_eswitch *esw, const struct mlx
 
 	rep->vport = vport->vport;
 	rep->vport_index = vport->index;
-	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++)
-		atomic_set(&rep->rep_data[rep_type].state, REP_UNREGISTERED);
-
+	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++) {
+		if (!esw->offloads.rep_ops[rep_type]) {
+			atomic_set(&rep->rep_data[rep_type].state,
+				   REP_UNREGISTERED);
+			continue;
+		}
+		/* Dynamic/delegated vports add their representors after
+		 * mlx5_eswitch_register_vport_reps, so mark them as registered
+		 * for them to be loaded later with the others.
+		 */
+		rep->esw = esw;
+		atomic_set(&rep->rep_data[rep_type].state, REP_REGISTERED);
+	}
 	err = xa_insert(&esw->offloads.vport_reps, rep->vport, rep, GFP_KERNEL);
 	if (err)
 		goto insert_err;
@@ -2430,7 +2453,7 @@ static int esw_offloads_init_reps(struct mlx5_eswitch *esw)
 	xa_init(&esw->offloads.vport_reps);
 
 	mlx5_esw_for_each_vport(esw, i, vport) {
-		err = mlx5_esw_offloads_rep_init(esw, vport);
+		err = mlx5_esw_offloads_rep_add(esw, vport);
 		if (err)
 			goto err;
 	}
-- 
2.50.1


