Return-Path: <netdev+bounces-217143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A92B37936
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443227A9BE5
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27C62D0C69;
	Wed, 27 Aug 2025 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUwqfN6f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0EC2C15B3
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 04:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756269928; cv=none; b=tHx50boHjQ2miUWeY6KFDaHlZn5YKgEEavnNI4u4xp75oM9V9gUJ5rMeBinQBlpgt8YGaBYte3G/m7eRspe+V0a0i/BpiG4pOSqGq9M7FHYONELm3wuukBavLUOEYxSRCkv0hvcA93fny6yRRLHuZ/iSg6AIZJtVl+BwyuGE4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756269928; c=relaxed/simple;
	bh=JkaPTqx+En4ZcjNSh/qmu66B/flyzRLfEGb7EDGCp2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6hhSAhBKSgo8gVohQJ/CqDMrfKaIiJvpFx6rHKEU3tFFP4flpuFAh97IlIry42kYx+a6ahOThYJBQmjSNLkpUagtL5Qu5nFCHewkm8BUHco9J9kh5JdjiDQcZ/5RSTpmTrMiFYTEGCMUid8ag7m0Wp/A3pWwGfKAwuoWn80J88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUwqfN6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5502C4CEEB;
	Wed, 27 Aug 2025 04:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756269927;
	bh=JkaPTqx+En4ZcjNSh/qmu66B/flyzRLfEGb7EDGCp2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUwqfN6frhXbk7V4c1Bejqof7RkRueVykKtoxfD9CWrXXvMOV6CiJZ0U3OTt7mzk6
	 s1j/Xxdvl159RqbR5gdv9757AhhVA9j791J//jdf16tJ9jE4oV1YlQW3i4/TDSychy
	 UDdV4W6BIoVDqaqw2g/qBpMbUJtIWHq2sxC8swrJPtdripZsq8wdKVE852z6y4yxUc
	 +wyRAUTI/3RcRQNgkKWMUNTR64R8ubrEWdTneSmOVMZ7OU0dUbZfDetoAgZ0sdm0C9
	 qcghGkFnfR8P4vQDxBQ9oBmm0985TRsfeHD+IIKM9Y2U+I+CECo1+arU06H1IkDThZ
	 gtXopMH1WmeVQ==
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
Subject: [PATCH net-next V2 1/7] net/mlx5: FS, Convert vport acls root namespaces to xarray
Date: Tue, 26 Aug 2025 21:45:10 -0700
Message-ID: <20250827044516.275267-2-saeed@kernel.org>
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

Before this patch it was a linear array and could only support a certain
number of vports, in the next patches, vport numbers are not bound to a
well known limit, thus convert acl root name space storage to xarray.

In addition create fs_core public API to add/remove vport acl namespaces
as it is the eswitch responsibility to create the vports and their
root name spaces for acls, in the next patch we will move
mlx5_fs_ingress_acls_{init,cleanup} to eswitch and will use
the individual mlx5_fs_vport_{egress,ingresS}_acl_ns_{add,remove}
APIs for dynamically create vports.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 169 ++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  13 +-
 2 files changed, 123 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index d87392360dbd..7d9de2f65ce6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2793,30 +2793,32 @@ struct mlx5_flow_namespace *mlx5_get_flow_namespace(struct mlx5_core_dev *dev,
 }
 EXPORT_SYMBOL(mlx5_get_flow_namespace);
 
+struct mlx5_vport_acl_root_ns {
+	u16 vport_idx;
+	struct mlx5_flow_root_namespace *root_ns;
+};
+
 struct mlx5_flow_namespace *
 mlx5_get_flow_vport_namespace(struct mlx5_core_dev *dev,
 			      enum mlx5_flow_namespace_type type, int vport_idx)
 {
 	struct mlx5_flow_steering *steering = dev->priv.steering;
+	struct mlx5_vport_acl_root_ns *vport_ns;
 
 	if (!steering)
 		return NULL;
 
 	switch (type) {
 	case MLX5_FLOW_NAMESPACE_ESW_EGRESS:
-		if (vport_idx >= steering->esw_egress_acl_vports)
-			return NULL;
-		if (steering->esw_egress_root_ns &&
-		    steering->esw_egress_root_ns[vport_idx])
-			return &steering->esw_egress_root_ns[vport_idx]->ns;
+		vport_ns = xa_load(&steering->esw_egress_root_ns, vport_idx);
+		if (vport_ns)
+			return &vport_ns->root_ns->ns;
 		else
 			return NULL;
 	case MLX5_FLOW_NAMESPACE_ESW_INGRESS:
-		if (vport_idx >= steering->esw_ingress_acl_vports)
-			return NULL;
-		if (steering->esw_ingress_root_ns &&
-		    steering->esw_ingress_root_ns[vport_idx])
-			return &steering->esw_ingress_root_ns[vport_idx]->ns;
+		vport_ns = xa_load(&steering->esw_ingress_root_ns, vport_idx);
+		if (vport_ns)
+			return &vport_ns->root_ns->ns;
 		else
 			return NULL;
 	case MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX:
@@ -3575,30 +3577,102 @@ static int init_fdb_root_ns(struct mlx5_flow_steering *steering)
 	return err;
 }
 
-static int init_egress_acl_root_ns(struct mlx5_flow_steering *steering, int vport)
+static void
+mlx5_fs_remove_vport_acl_root_ns(struct xarray *esw_acl_root_ns, u16 vport_idx)
+{
+	struct mlx5_vport_acl_root_ns *vport_ns;
+
+	vport_ns = xa_erase(esw_acl_root_ns, vport_idx);
+	if (vport_ns) {
+		cleanup_root_ns(vport_ns->root_ns);
+		kfree(vport_ns);
+	}
+}
+
+static int
+mlx5_fs_add_vport_acl_root_ns(struct mlx5_flow_steering *steering,
+			      struct xarray *esw_acl_root_ns,
+			      enum fs_flow_table_type table_type,
+			      u16 vport_idx)
 {
+	struct mlx5_vport_acl_root_ns *vport_ns;
 	struct fs_prio *prio;
+	int err;
+
+	/* sanity check, intended xarrays are used */
+	if (WARN_ON(esw_acl_root_ns != &steering->esw_egress_root_ns &&
+		    esw_acl_root_ns != &steering->esw_ingress_root_ns))
+		return -EINVAL;
 
-	steering->esw_egress_root_ns[vport] = create_root_ns(steering, FS_FT_ESW_EGRESS_ACL);
-	if (!steering->esw_egress_root_ns[vport])
+	if (table_type != FS_FT_ESW_EGRESS_ACL &&
+	    table_type != FS_FT_ESW_INGRESS_ACL) {
+		mlx5_core_err(steering->dev,
+			      "Invalid table type %d for egress/ingress ACLs\n",
+			      table_type);
+		return -EINVAL;
+	}
+
+	if (xa_load(esw_acl_root_ns, vport_idx))
+		return -EEXIST;
+
+	vport_ns = kzalloc(sizeof(*vport_ns), GFP_KERNEL);
+	if (!vport_ns)
 		return -ENOMEM;
 
+	vport_ns->root_ns = create_root_ns(steering, table_type);
+	if (!vport_ns->root_ns) {
+		err = -ENOMEM;
+		goto kfree_vport_ns;
+	}
+
 	/* create 1 prio*/
-	prio = fs_create_prio(&steering->esw_egress_root_ns[vport]->ns, 0, 1);
-	return PTR_ERR_OR_ZERO(prio);
+	prio = fs_create_prio(&vport_ns->root_ns->ns, 0, 1);
+	if (IS_ERR(prio)) {
+		err = PTR_ERR(prio);
+		goto cleanup_root_ns;
+	}
+
+	vport_ns->vport_idx = vport_idx;
+	err = xa_insert(esw_acl_root_ns, vport_idx, vport_ns, GFP_KERNEL);
+	if (err)
+		goto cleanup_root_ns;
+	return 0;
+
+cleanup_root_ns:
+	cleanup_root_ns(vport_ns->root_ns);
+kfree_vport_ns:
+	kfree(vport_ns);
+	return err;
 }
 
-static int init_ingress_acl_root_ns(struct mlx5_flow_steering *steering, int vport)
+int mlx5_fs_vport_egress_acl_ns_add(struct mlx5_flow_steering *steering,
+				    u16 vport_idx)
 {
-	struct fs_prio *prio;
+	return mlx5_fs_add_vport_acl_root_ns(steering,
+					     &steering->esw_egress_root_ns,
+					     FS_FT_ESW_EGRESS_ACL, vport_idx);
+}
 
-	steering->esw_ingress_root_ns[vport] = create_root_ns(steering, FS_FT_ESW_INGRESS_ACL);
-	if (!steering->esw_ingress_root_ns[vport])
-		return -ENOMEM;
+int mlx5_fs_vport_ingress_acl_ns_add(struct mlx5_flow_steering *steering,
+				     u16 vport_idx)
+{
+	return mlx5_fs_add_vport_acl_root_ns(steering,
+					     &steering->esw_ingress_root_ns,
+					     FS_FT_ESW_INGRESS_ACL, vport_idx);
+}
 
-	/* create 1 prio*/
-	prio = fs_create_prio(&steering->esw_ingress_root_ns[vport]->ns, 0, 1);
-	return PTR_ERR_OR_ZERO(prio);
+void mlx5_fs_vport_egress_acl_ns_remove(struct mlx5_flow_steering *steering,
+					int vport_idx)
+{
+	mlx5_fs_remove_vport_acl_root_ns(&steering->esw_egress_root_ns,
+					 vport_idx);
+}
+
+void mlx5_fs_vport_ingress_acl_ns_remove(struct mlx5_flow_steering *steering,
+					 int vport_idx)
+{
+	mlx5_fs_remove_vport_acl_root_ns(&steering->esw_ingress_root_ns,
+					 vport_idx);
 }
 
 int mlx5_fs_egress_acls_init(struct mlx5_core_dev *dev, int total_vports)
@@ -3607,15 +3681,10 @@ int mlx5_fs_egress_acls_init(struct mlx5_core_dev *dev, int total_vports)
 	int err;
 	int i;
 
-	steering->esw_egress_root_ns =
-			kcalloc(total_vports,
-				sizeof(*steering->esw_egress_root_ns),
-				GFP_KERNEL);
-	if (!steering->esw_egress_root_ns)
-		return -ENOMEM;
+	xa_init(&steering->esw_egress_root_ns);
 
 	for (i = 0; i < total_vports; i++) {
-		err = init_egress_acl_root_ns(steering, i);
+		err = mlx5_fs_vport_egress_acl_ns_add(steering, i);
 		if (err)
 			goto cleanup_root_ns;
 	}
@@ -3623,10 +3692,9 @@ int mlx5_fs_egress_acls_init(struct mlx5_core_dev *dev, int total_vports)
 	return 0;
 
 cleanup_root_ns:
-	for (i--; i >= 0; i--)
-		cleanup_root_ns(steering->esw_egress_root_ns[i]);
-	kfree(steering->esw_egress_root_ns);
-	steering->esw_egress_root_ns = NULL;
+	while (i--)
+		mlx5_fs_vport_egress_acl_ns_remove(steering, i);
+	xa_destroy(&steering->esw_egress_root_ns);
 	return err;
 }
 
@@ -3635,14 +3703,10 @@ void mlx5_fs_egress_acls_cleanup(struct mlx5_core_dev *dev)
 	struct mlx5_flow_steering *steering = dev->priv.steering;
 	int i;
 
-	if (!steering->esw_egress_root_ns)
-		return;
-
 	for (i = 0; i < steering->esw_egress_acl_vports; i++)
-		cleanup_root_ns(steering->esw_egress_root_ns[i]);
+		mlx5_fs_vport_egress_acl_ns_remove(steering, i);
 
-	kfree(steering->esw_egress_root_ns);
-	steering->esw_egress_root_ns = NULL;
+	xa_destroy(&steering->esw_egress_root_ns);
 }
 
 int mlx5_fs_ingress_acls_init(struct mlx5_core_dev *dev, int total_vports)
@@ -3651,15 +3715,10 @@ int mlx5_fs_ingress_acls_init(struct mlx5_core_dev *dev, int total_vports)
 	int err;
 	int i;
 
-	steering->esw_ingress_root_ns =
-			kcalloc(total_vports,
-				sizeof(*steering->esw_ingress_root_ns),
-				GFP_KERNEL);
-	if (!steering->esw_ingress_root_ns)
-		return -ENOMEM;
+	xa_init(&steering->esw_ingress_root_ns);
 
 	for (i = 0; i < total_vports; i++) {
-		err = init_ingress_acl_root_ns(steering, i);
+		err = mlx5_fs_vport_ingress_acl_ns_add(steering, i);
 		if (err)
 			goto cleanup_root_ns;
 	}
@@ -3667,10 +3726,10 @@ int mlx5_fs_ingress_acls_init(struct mlx5_core_dev *dev, int total_vports)
 	return 0;
 
 cleanup_root_ns:
-	for (i--; i >= 0; i--)
-		cleanup_root_ns(steering->esw_ingress_root_ns[i]);
-	kfree(steering->esw_ingress_root_ns);
-	steering->esw_ingress_root_ns = NULL;
+	while (i--)
+		mlx5_fs_vport_ingress_acl_ns_remove(steering, i);
+
+	xa_destroy(&steering->esw_ingress_root_ns);
 	return err;
 }
 
@@ -3679,14 +3738,10 @@ void mlx5_fs_ingress_acls_cleanup(struct mlx5_core_dev *dev)
 	struct mlx5_flow_steering *steering = dev->priv.steering;
 	int i;
 
-	if (!steering->esw_ingress_root_ns)
-		return;
-
 	for (i = 0; i < steering->esw_ingress_acl_vports; i++)
-		cleanup_root_ns(steering->esw_ingress_root_ns[i]);
+		mlx5_fs_vport_ingress_acl_ns_remove(steering, i);
 
-	kfree(steering->esw_ingress_root_ns);
-	steering->esw_ingress_root_ns = NULL;
+	xa_destroy(&steering->esw_ingress_root_ns);
 }
 
 u32 mlx5_fs_get_capabilities(struct mlx5_core_dev *dev, enum mlx5_flow_namespace_type type)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 500826229b0b..a7642d9fc118 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -151,8 +151,8 @@ struct mlx5_flow_steering {
 	struct mlx5_flow_root_namespace *root_ns;
 	struct mlx5_flow_root_namespace *fdb_root_ns;
 	struct mlx5_flow_namespace	**fdb_sub_ns;
-	struct mlx5_flow_root_namespace **esw_egress_root_ns;
-	struct mlx5_flow_root_namespace **esw_ingress_root_ns;
+	struct xarray			esw_egress_root_ns;
+	struct xarray			esw_ingress_root_ns;
 	struct mlx5_flow_root_namespace	*sniffer_tx_root_ns;
 	struct mlx5_flow_root_namespace	*sniffer_rx_root_ns;
 	struct mlx5_flow_root_namespace	*rdma_rx_root_ns;
@@ -383,6 +383,15 @@ void mlx5_fs_egress_acls_cleanup(struct mlx5_core_dev *dev);
 int mlx5_fs_ingress_acls_init(struct mlx5_core_dev *dev, int total_vports);
 void mlx5_fs_ingress_acls_cleanup(struct mlx5_core_dev *dev);
 
+int mlx5_fs_vport_egress_acl_ns_add(struct mlx5_flow_steering *steering,
+				    u16 vport_idx);
+int mlx5_fs_vport_ingress_acl_ns_add(struct mlx5_flow_steering *steering,
+				     u16 vport_idx);
+void mlx5_fs_vport_egress_acl_ns_remove(struct mlx5_flow_steering *steering,
+					int vport_idx);
+void mlx5_fs_vport_ingress_acl_ns_remove(struct mlx5_flow_steering *steering,
+					 int vport_idx);
+
 u32 mlx5_fs_get_capabilities(struct mlx5_core_dev *dev, enum mlx5_flow_namespace_type type);
 
 struct mlx5_flow_root_namespace *find_root(struct fs_node *node);
-- 
2.50.1


