Return-Path: <netdev+bounces-217144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DCDB37935
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9787B68513F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EEC2D1911;
	Wed, 27 Aug 2025 04:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eThkHOar"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A12D0C9D
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756269929; cv=none; b=pCzzbORCmzeCRIpt8n+XfZTrApj/P3DdM9I4QSM284eO2gMt9df3B4tS3ORjfaZqHcw4dPO1C2f/vgnqpHlZ625qMyW5QqGOvA/PJY1FBN2Lqh/7cAD4pN4xz0j4Vihv6mM9fOYNV+qzYXML/yPtbGzMe3/vTavj7r0UK1UmjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756269929; c=relaxed/simple;
	bh=aWoUcxwoNzCmd3zciO0QtwtI/GhDd4RyV7CkRYIlp60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWLx+0h7YagwoI4m3kAxK265FPtZKK3q2G8WLnJluIlHlNF0z3qAW4+u8nE/ZX9h6wUHcBQD4+Q3wFjPLMhq76W/nBCvpLXlx67e5d+GyZf+HUDfPgFjGdO9JGo50hzKO1aPDtbbp6vOFew7pRJ6OE3ghmJp5PQvuT3PIz7Nz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eThkHOar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD88C113D0;
	Wed, 27 Aug 2025 04:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756269928;
	bh=aWoUcxwoNzCmd3zciO0QtwtI/GhDd4RyV7CkRYIlp60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eThkHOarCEystqWoYwS5Uiu86rtaZlyJreUcJPPNJ5pcyYY8meIGWtbOe04dLp8b1
	 RemiFXuE+yQ/YI7LiRVeyhAZ9c13omoO5L4FLDdxJxy9smVgmQ6A5PPB8ixdMg0Q2O
	 +AULctUgOhT6Zcf3bsV0pF53fIEgg92iUi+XxJSv6NbEtFjHEqK9m1M/CBruBlL4Qu
	 1Yzcx2WcaVBdWlmBnp6k+DRGWabyX/1ZpMHcV3za+dQlBhS4yeLaZZinwM+w5eiquf
	 032F1IuRc9LfsuSBb9BCyRwUdK8XYf4x8RxasAmFPAZVMgX6Vp6xG1j76WnQ7fFNGo
	 8E0Pk1VM4VZwA==
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
	mbloch@nvidia.com
Subject: [PATCH net-next V2 2/7] net/mlx5: E-Switch, Move vport acls root namespaces creation to eswitch
Date: Tue, 26 Aug 2025 21:45:11 -0700
Message-ID: <20250827044516.275267-3-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827044516.275267-1-saeed@kernel.org>
References: <20250827044516.275267-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Move the loop that creates the vports ACLs root name spaces to eswitch,
since it is the eswitch responsibility to decide when and how many
vports ACLs root namespaces to create, in the next patches we will use
the fs_core vport ACL root namespace APIs to create/remove root ns
ACLs dynamically for dynamically created vports.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 73 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 76 ++-----------------
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  7 --
 3 files changed, 72 insertions(+), 84 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 9fe5a45124fd..900650a1a66e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1439,19 +1439,76 @@ static void mlx5_esw_mode_change_notify(struct mlx5_eswitch *esw, u16 mode)
 	blocking_notifier_call_chain(&esw->n_head, 0, &info);
 }
 
+static int mlx5_esw_egress_acls_init(struct mlx5_core_dev *dev)
+{
+	struct mlx5_flow_steering *steering = dev->priv.steering;
+	int total_vports = mlx5_eswitch_get_total_vports(dev);
+	int err;
+	int i;
+
+	for (i = 0; i < total_vports; i++) {
+		err = mlx5_fs_vport_egress_acl_ns_add(steering, i);
+		if (err)
+			goto acl_ns_remove;
+	}
+	return 0;
+
+acl_ns_remove:
+	while (i--)
+		mlx5_fs_vport_egress_acl_ns_remove(steering, i);
+	return err;
+}
+
+static void mlx5_esw_egress_acls_cleanup(struct mlx5_core_dev *dev)
+{
+	struct mlx5_flow_steering *steering = dev->priv.steering;
+	int total_vports = mlx5_eswitch_get_total_vports(dev);
+	int i;
+
+	for (i = total_vports - 1; i >= 0; i--)
+		mlx5_fs_vport_egress_acl_ns_remove(steering, i);
+}
+
+static int mlx5_esw_ingress_acls_init(struct mlx5_core_dev *dev)
+{
+	struct mlx5_flow_steering *steering = dev->priv.steering;
+	int total_vports = mlx5_eswitch_get_total_vports(dev);
+	int err;
+	int i;
+
+	for (i = 0; i < total_vports; i++) {
+		err = mlx5_fs_vport_ingress_acl_ns_add(steering, i);
+		if (err)
+			goto acl_ns_remove;
+	}
+	return 0;
+
+acl_ns_remove:
+	while (i--)
+		mlx5_fs_vport_ingress_acl_ns_remove(steering, i);
+	return err;
+}
+
+static void mlx5_esw_ingress_acls_cleanup(struct mlx5_core_dev *dev)
+{
+	struct mlx5_flow_steering *steering = dev->priv.steering;
+	int total_vports = mlx5_eswitch_get_total_vports(dev);
+	int i;
+
+	for (i = total_vports - 1; i >= 0; i--)
+		mlx5_fs_vport_ingress_acl_ns_remove(steering, i);
+}
+
 static int mlx5_esw_acls_ns_init(struct mlx5_eswitch *esw)
 {
 	struct mlx5_core_dev *dev = esw->dev;
-	int total_vports;
 	int err;
 
 	if (esw->flags & MLX5_ESWITCH_VPORT_ACL_NS_CREATED)
 		return 0;
 
-	total_vports = mlx5_eswitch_get_total_vports(dev);
-
 	if (MLX5_CAP_ESW_EGRESS_ACL(dev, ft_support)) {
-		err = mlx5_fs_egress_acls_init(dev, total_vports);
+		err = mlx5_esw_egress_acls_init(dev);
 		if (err)
 			return err;
 	} else {
@@ -1459,7 +1516,7 @@ static int mlx5_esw_acls_ns_init(struct mlx5_eswitch *esw)
 	}
 
 	if (MLX5_CAP_ESW_INGRESS_ACL(dev, ft_support)) {
-		err = mlx5_fs_ingress_acls_init(dev, total_vports);
+		err = mlx5_esw_ingress_acls_init(dev);
 		if (err)
 			goto err;
 	} else {
@@ -1470,7 +1527,7 @@ static int mlx5_esw_acls_ns_init(struct mlx5_eswitch *esw)
 
 err:
 	if (MLX5_CAP_ESW_EGRESS_ACL(dev, ft_support))
-		mlx5_fs_egress_acls_cleanup(dev);
+		mlx5_esw_egress_acls_cleanup(dev);
 	return err;
 }
 
@@ -1480,9 +1537,9 @@ static void mlx5_esw_acls_ns_cleanup(struct mlx5_eswitch *esw)
 
 	esw->flags &= ~MLX5_ESWITCH_VPORT_ACL_NS_CREATED;
 	if (MLX5_CAP_ESW_INGRESS_ACL(dev, ft_support))
-		mlx5_fs_ingress_acls_cleanup(dev);
+		mlx5_esw_ingress_acls_cleanup(dev);
 	if (MLX5_CAP_ESW_EGRESS_ACL(dev, ft_support))
-		mlx5_fs_egress_acls_cleanup(dev);
+		mlx5_esw_egress_acls_cleanup(dev);
 }
 
 /**
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 7d9de2f65ce6..e4d24e6f3903 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3675,75 +3675,6 @@ void mlx5_fs_vport_ingress_acl_ns_remove(struct mlx5_flow_steering *steering,
 					 vport_idx);
 }
 
-int mlx5_fs_egress_acls_init(struct mlx5_core_dev *dev, int total_vports)
-{
-	struct mlx5_flow_steering *steering = dev->priv.steering;
-	int err;
-	int i;
-
-	xa_init(&steering->esw_egress_root_ns);
-
-	for (i = 0; i < total_vports; i++) {
-		err = mlx5_fs_vport_egress_acl_ns_add(steering, i);
-		if (err)
-			goto cleanup_root_ns;
-	}
-	steering->esw_egress_acl_vports = total_vports;
-	return 0;
-
-cleanup_root_ns:
-	while (i--)
-		mlx5_fs_vport_egress_acl_ns_remove(steering, i);
-	xa_destroy(&steering->esw_egress_root_ns);
-	return err;
-}
-
-void mlx5_fs_egress_acls_cleanup(struct mlx5_core_dev *dev)
-{
-	struct mlx5_flow_steering *steering = dev->priv.steering;
-	int i;
-
-	for (i = 0; i < steering->esw_egress_acl_vports; i++)
-		mlx5_fs_vport_egress_acl_ns_remove(steering, i);
-
-	xa_destroy(&steering->esw_egress_root_ns);
-}
-
-int mlx5_fs_ingress_acls_init(struct mlx5_core_dev *dev, int total_vports)
-{
-	struct mlx5_flow_steering *steering = dev->priv.steering;
-	int err;
-	int i;
-
-	xa_init(&steering->esw_ingress_root_ns);
-
-	for (i = 0; i < total_vports; i++) {
-		err = mlx5_fs_vport_ingress_acl_ns_add(steering, i);
-		if (err)
-			goto cleanup_root_ns;
-	}
-	steering->esw_ingress_acl_vports = total_vports;
-	return 0;
-
-cleanup_root_ns:
-	while (i--)
-		mlx5_fs_vport_ingress_acl_ns_remove(steering, i);
-
-	xa_destroy(&steering->esw_ingress_root_ns);
-	return err;
-}
-
-void mlx5_fs_ingress_acls_cleanup(struct mlx5_core_dev *dev)
-{
-	struct mlx5_flow_steering *steering = dev->priv.steering;
-	int i;
-
-	for (i = 0; i < steering->esw_ingress_acl_vports; i++)
-		mlx5_fs_vport_ingress_acl_ns_remove(steering, i);
-
-	xa_destroy(&steering->esw_ingress_root_ns);
-}
-
 u32 mlx5_fs_get_capabilities(struct mlx5_core_dev *dev, enum mlx5_flow_namespace_type type)
 {
 	struct mlx5_flow_root_namespace *root;
@@ -3874,6 +3805,11 @@ void mlx5_fs_core_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_flow_steering *steering = dev->priv.steering;
 
+	WARN_ON(!xa_empty(&steering->esw_egress_root_ns));
+	WARN_ON(!xa_empty(&steering->esw_ingress_root_ns));
+	xa_destroy(&steering->esw_egress_root_ns);
+	xa_destroy(&steering->esw_ingress_root_ns);
+
 	cleanup_root_ns(steering->root_ns);
 	cleanup_fdb_root_ns(steering);
 	cleanup_root_ns(steering->port_sel_root_ns);
@@ -3964,6 +3900,8 @@ int mlx5_fs_core_init(struct mlx5_core_dev *dev)
 			goto err;
 	}
 
+	xa_init(&steering->esw_egress_root_ns);
+	xa_init(&steering->esw_ingress_root_ns);
 	return 0;
 
 err:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index a7642d9fc118..7877d9a2118d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -159,8 +159,6 @@ struct mlx5_flow_steering {
 	struct mlx5_flow_root_namespace	*rdma_tx_root_ns;
 	struct mlx5_flow_root_namespace	*egress_root_ns;
 	struct mlx5_flow_root_namespace	*port_sel_root_ns;
-	int esw_egress_acl_vports;
-	int esw_ingress_acl_vports;
 	struct mlx5_flow_root_namespace **rdma_transport_rx_root_ns;
 	struct mlx5_flow_root_namespace **rdma_transport_tx_root_ns;
 	int rdma_transport_rx_vports;
@@ -378,11 +376,6 @@ void mlx5_fs_core_free(struct mlx5_core_dev *dev);
 int mlx5_fs_core_init(struct mlx5_core_dev *dev);
 void mlx5_fs_core_cleanup(struct mlx5_core_dev *dev);
 
-int mlx5_fs_egress_acls_init(struct mlx5_core_dev *dev, int total_vports);
-void mlx5_fs_egress_acls_cleanup(struct mlx5_core_dev *dev);
-int mlx5_fs_ingress_acls_init(struct mlx5_core_dev *dev, int total_vports);
-void mlx5_fs_ingress_acls_cleanup(struct mlx5_core_dev *dev);
-
 int mlx5_fs_vport_egress_acl_ns_add(struct mlx5_flow_steering *steering,
 				    u16 vport_idx);
 int mlx5_fs_vport_ingress_acl_ns_add(struct mlx5_flow_steering *steering,
-- 
2.50.1


