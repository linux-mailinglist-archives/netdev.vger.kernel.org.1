Return-Path: <netdev+bounces-215832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E10B308BD
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 23:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C6B5C856C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 21:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236FF2EACFF;
	Thu, 21 Aug 2025 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLUV1xM9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D052EACF3
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813536; cv=none; b=DxFTu7aMo5gPvF0DA7Lfd47oF7Y155bnffjMhu1TezdBNCEXXI85Erv824AnDUeKxSBKM9Fj/Dn7Bryv0wOx6rnvqMvujV+1udi8PrNgAzla6kyH96XZ54aAZh1wwhqCYbVUoy8h6bpWkTRL9qPmy+EnEdONffOBzJq5Rfvl3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813536; c=relaxed/simple;
	bh=OLCW8HhikcCVBxtlZi4jGQmqzO79Z+OmHE83kbqrhAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdexAm4i9G09sVk5XwbUgySxvI6o17fDVCcPaOcVNZIzt3yD+HCxfvld9fsRggs4cMmDMo89z8xu40+PLaNrAbNh6AmksyV/KDxNwiKbBy66uMhqpD8nJrz6mA+fOsjwHD7Q9R4BGCCEp5C/yuib94gzxOFD1OkhWCBhuEq+LWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLUV1xM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CC9C4CEEB;
	Thu, 21 Aug 2025 21:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755813535;
	bh=OLCW8HhikcCVBxtlZi4jGQmqzO79Z+OmHE83kbqrhAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLUV1xM9eAvPPR2Nu5pYy08HhP/9cIp7blqYa3FqdFCbhY6s0KH8tTbXGydQIdF6L
	 yUoU0Ik7dZYpFk/6f/o4vJuG10eUvxa6cN9CQMpr8JNjVOG40vbINe3sNXRRhB3BeN
	 WSiZYCdcsoHfGKy/ZFKz9/YorCggEub2q/e37hCi63dLLIx5Qo2lIso1AlrJSNh5IJ
	 XBt5IWYKtBjKvQ2iOSmeYQJFFH+I6kNTKzYBxJOfS1FkufjO9vb1VCcsiEq3GbT9Qp
	 JzYHN1I3Bw57opkAKThtumTGLDWMAut/B6/uZY38QDfrqxd+N5Yx7QO7/rU/jCu4Xs
	 t0MDdDyIg3sTA==
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
Subject: [PATCH net-next 4/7] net/mlx5: E-Switch, Create acls root namespace for adjacent vports
Date: Thu, 21 Aug 2025 14:58:36 -0700
Message-ID: <20250821215839.280364-5-saeed@kernel.org>
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

Use the new vport acl root namespace add/remove API to create the
missing acl root name spaces per each new adjacent function vport.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
index 0bb7f77cce1f..8e6edd4b6386 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 // Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
+#include "fs_core.h"
 #include "eswitch.h"
 
 enum {
@@ -82,6 +83,9 @@ static int mlx5_esw_adj_vport_create(struct mlx5_eswitch *esw, u16 vhca_id)
 	vport->adjacent = true;
 	vport->vhca_id = vhca_id;
 
+	mlx5_fs_vport_egress_acl_ns_add(esw->dev->priv.steering, vport->index);
+	mlx5_fs_vport_ingress_acl_ns_add(esw->dev->priv.steering, vport->index);
+
 	mlx5_esw_adj_vport_modify(esw->dev, vport_num, MLX5_ADJ_VPORT_CONNECT);
 	return 0;
 
@@ -99,6 +103,10 @@ static void mlx5_esw_adj_vport_destroy(struct mlx5_eswitch *esw,
 		  vport_num, vport->vhca_id);
 	mlx5_esw_adj_vport_modify(esw->dev, vport_num,
 				  MLX5_ADJ_VPORT_DISCONNECT);
+	mlx5_fs_vport_egress_acl_ns_remove(esw->dev->priv.steering,
+					   vport->index);
+	mlx5_fs_vport_ingress_acl_ns_remove(esw->dev->priv.steering,
+					    vport->index);
 	mlx5_esw_vport_free(esw, vport);
 	/* Reset the vport index back so new adj vports can use this index.
 	 * When vport count can incrementally change, this needs to be modified.
-- 
2.50.1


