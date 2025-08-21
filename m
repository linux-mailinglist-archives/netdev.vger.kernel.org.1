Return-Path: <netdev+bounces-215834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A0B308C0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 23:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB136A2857F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 21:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75902EB853;
	Thu, 21 Aug 2025 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vK1tNfJZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6C2EB850
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813537; cv=none; b=CnINo5QONc2HiTco3uXnT/34+NmLGjsN5lEadzY4H8fJ5Czso27MfNfsQgJZzafNaGzoy4Q/POb/fjy+fjE+Q3+vRPNWeBb2nDbIKbRkFRWt0wmn6oBv4Uf+AfG2bMRwxpVEbg1X2DDL0kGr3ugCkdx9ycJj6+c+5FSJcTB75Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813537; c=relaxed/simple;
	bh=6q/4aTiZh3Pk4ewtQLjjhBuQ/QGx/JdDEqWcDWBwIKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RosAVt9KzQNrFQDPrBn1Z86IS9GDFw+BLYseV+aTHZB0vFZRY7GcarKpwvg0FeDe7U2TqTI4xBNZoVhgIjZcLG/k0rfEph1EbX/VtEhEHNNAtruBBM5KiBo1lJBy2xfsheKYp7yjhLjEZeYvmbI+Lvc38MZAXBS5UoFLgPPyMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vK1tNfJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D172C4CEEB;
	Thu, 21 Aug 2025 21:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755813537;
	bh=6q/4aTiZh3Pk4ewtQLjjhBuQ/QGx/JdDEqWcDWBwIKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vK1tNfJZ5pBaOkejYHsXWe9ieQEnNf3B0ypJK/63mJaCAnJundB93O1LVSGFvMgkY
	 rQqcLUuuMeQ6qFBgv+nCL0n4X7y+aZ2Z/rl1tKkTe9Rl4aVfhmvcJbGWyp4pJhnqDE
	 60dHOvRCoXbA9rnQMwZWmeNlVXYr8c4WNN0GR3sg9yathgIgTOH1reQdJjKjAGEOQD
	 Nlih0Y22ENtjT7x9T7QysHSqy0Os8HtNVEO+2Q6Gl7PeplUOuS5TWepsHzsaxXsJZD
	 ZkYjYjBqzL6cVArgWR4NZvgbzkgj7hfTk4gAr+8K9KmUf38nu+nBYARGr8XWWFHLF4
	 kXu940epFCF2w==
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
Subject: [PATCH net-next 6/7] net/mlx5: E-switch, Set representor attributes for adjacent VFs
Date: Thu, 21 Aug 2025 14:58:38 -0700
Message-ID: <20250821215839.280364-7-saeed@kernel.org>
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

From: Adithya Jayachandran <ajayachandra@nvidia.com>

Adjacent vfs get their devlink port information from firmware,
use the information (pfnum, function id) from FW when populating the
devlink port attributes.

Before:
$ devlink port show
pci/0000:00:03.0/180225: type eth netdev eth0 flavour pcivf controller 0 pfnum 0 vfnum 49152 external false splittable false
  function:
    hw_addr 00:00:00:00:00:00

After:
$ devlink port show
pci/0000:00:03.0/180225: type eth netdev enp0s3npf0vf2 flavour pcivf controller 0 pfnum 0 vfnum 2 external false splittable false
  function:
    hw_addr 00:00:00:00:00:00

Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/adj_vport.c  | 16 +++++++++++-----
 .../mellanox/mlx5/core/esw/devlink_port.c        | 11 ++++++++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h    |  5 +++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
index 26f2ba6f665d..6e1a6057e6b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
@@ -57,7 +57,8 @@ static int mlx5_esw_create_esw_vport(struct mlx5_core_dev *dev, u16 vhca_id,
 	return err;
 }
 
-static int mlx5_esw_adj_vport_create(struct mlx5_eswitch *esw, u16 vhca_id)
+static int mlx5_esw_adj_vport_create(struct mlx5_eswitch *esw, u16 vhca_id,
+				     const void *rid_info_reg)
 {
 	struct mlx5_vport *vport;
 	u16 vport_num;
@@ -83,6 +84,12 @@ static int mlx5_esw_adj_vport_create(struct mlx5_eswitch *esw, u16 vhca_id)
 	vport->adjacent = true;
 	vport->vhca_id = vhca_id;
 
+	vport->adj_info.parent_pci_devfn =
+		MLX5_GET(function_vhca_rid_info_reg, rid_info_reg,
+			 parent_pci_device_function);
+	vport->adj_info.function_id =
+		MLX5_GET(function_vhca_rid_info_reg, rid_info_reg, function_id);
+
 	mlx5_fs_vport_egress_acl_ns_add(esw->dev->priv.steering, vport->index);
 	mlx5_fs_vport_ingress_acl_ns_add(esw->dev->priv.steering, vport->index);
 	err = mlx5_esw_offloads_rep_add(esw, vport);
@@ -176,7 +183,7 @@ void mlx5_esw_adjacent_vhcas_setup(struct mlx5_eswitch *esw)
 	esw_debug(esw->dev, "Delegated vhca functions count %d\n", count);
 
 	for (i = 0; i < count; i++) {
-		void *rid_info, *rid_info_reg;
+		const void *rid_info, *rid_info_reg;
 		u16 vhca_id;
 
 		rid_info = MLX5_ADDR_OF(query_delegated_vhca_out, out,
@@ -187,10 +194,9 @@ void mlx5_esw_adjacent_vhcas_setup(struct mlx5_eswitch *esw)
 
 		vhca_id = MLX5_GET(function_vhca_rid_info_reg, rid_info_reg,
 				   vhca_id);
-		esw_debug(esw->dev, "Delegating vhca_id 0x%x rid info:\n",
-			  vhca_id);
+		esw_debug(esw->dev, "Delegating vhca_id 0x%x\n", vhca_id);
 
-		err = mlx5_esw_adj_vport_create(esw, vhca_id);
+		err = mlx5_esw_adj_vport_create(esw, vhca_id, rid_info_reg);
 		if (err) {
 			esw_warn(esw->dev,
 				 "Failed to init adjacent vhca 0x%x, err %d\n",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index c33accadae0f..cf88a106d80d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -27,6 +27,7 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 {
 	struct mlx5_core_dev *dev = esw->dev;
 	struct netdev_phys_item_id ppid = {};
+	struct mlx5_vport *vport;
 	u32 controller_num = 0;
 	bool external;
 	u16 pfnum;
@@ -42,10 +43,18 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
 		devlink_port_attrs_pci_pf_set(dl_port, controller_num, pfnum, external);
 	} else if (mlx5_eswitch_is_vf_vport(esw, vport_num)) {
+		u16 func_id = vport_num - 1;
+
+		vport = mlx5_eswitch_get_vport(esw, vport_num);
 		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
+		if (vport->adjacent) {
+			func_id = vport->adj_info.function_id;
+			pfnum = vport->adj_info.parent_pci_devfn;
+		}
+
 		devlink_port_attrs_pci_vf_set(dl_port, controller_num, pfnum,
-					      vport_num - 1, external);
+					      func_id, external);
 	}  else if (mlx5_core_is_ec_vf_vport(esw->dev, vport_num)) {
 		u16 base_vport = mlx5_core_ec_vf_vport_base(dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 9fc020bc40cf..6fb925949ed1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -217,6 +217,11 @@ struct mlx5_vport {
 	int                     vhca_id;
 
 	bool adjacent; /* delegated vhca from adjacent function */
+	struct {
+		u16 parent_pci_devfn; /* Adjacent parent PCI device function */
+		u16 function_id; /* Function ID of the delegated VPort */
+	} adj_info;
+
 	struct mlx5_vport_info  info;
 
 	/* Protected with the E-Switch qos domain lock. The Vport QoS can
-- 
2.50.1


