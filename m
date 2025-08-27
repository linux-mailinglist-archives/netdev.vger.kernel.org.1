Return-Path: <netdev+bounces-217149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623C1B3793A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23C6685166
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D02FD7CE;
	Wed, 27 Aug 2025 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM0/iAhu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72404199230
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 04:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756269934; cv=none; b=Bx2mj4LKCXns2vN+rhNcwtyqTqp9C3rx/3OMVXQ74mc9dpvmpqBVQLnJWu6uHgtbhUuwjh3pRPar7dL2A05Em7+L28zuK+j1/jzNStIea7dLt7d6OEiutd016TwgO8TErAS06KEx3jNwLw5Cp3nmkasO0GKvxx/ubN9/9UyNwQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756269934; c=relaxed/simple;
	bh=jcspID1Khl6+k/aR7j0kSG7qetWww1Vhq7ZDI7sKXzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXSmGalcqQGAp3GCNlOHOlylH74Vxk1ZHuos6dO5I+yu7hm5gb8v7bmyywyuKdsGjWR0yJ1j+nuc/zQvFBjMbILUrD6G9bcQsmo4ZIhfarYPjL3rmeW0VlVN5S0C1479EhZS3erxPMcXr6mytSSV7SVCRtF1sZ6beuKBdjKEWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM0/iAhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED84C116C6;
	Wed, 27 Aug 2025 04:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756269933;
	bh=jcspID1Khl6+k/aR7j0kSG7qetWww1Vhq7ZDI7sKXzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FM0/iAhuesoPx3vU2pO2+uEAJbCf9SVDtg2PdYYENcGrrNlxQ4qSFkoPDGN5cq9br
	 ZXaZAzzo4qUe78WWQmUWw9ob4uTP37VwFXbwpaA8UNy482lRh6h9QdQvWdpTW7oLXi
	 2JTtMzfB9QXX0e4c9eTDFFg5qe+tw8jPx4DUO8c5AVP1oRQqEm8c6xtioA04gteuvW
	 MpRqEDh+cy4bgI6aLQWQSJLc3kVda2sg2+x+ujlU3pyA4+8m/u1AX+S934QXUgGs+6
	 wLX3nxZ8p7hV96iaU0XrxkPvCWKzTaE8cR0SqqB5yPVEoxQhzIvwIHrh/FduJzO9Wo
	 Kd1YAMblMLSsw==
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
Subject: [PATCH net-next V2 7/7] net/mlx5: {DR,HWS}, Use the cached vhca_id for this device
Date: Tue, 26 Aug 2025 21:45:16 -0700
Message-ID: <20250827044516.275267-8-saeed@kernel.org>
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

The mlx5 driver caches many capabilities to be used by mlx5 layers.

In SW and HW steering we can use the cached vhca_id instead of invoking
FW commands.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/cmd.c     | 34 ++++---------------
 .../mellanox/mlx5/core/steering/sws/dr_cmd.c  | 34 ++++---------------
 2 files changed, 14 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
index acb0317f930b..f22eaf506d28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
@@ -1200,40 +1200,20 @@ int mlx5hws_cmd_query_caps(struct mlx5_core_dev *mdev,
 int mlx5hws_cmd_query_gvmi(struct mlx5_core_dev *mdev, bool other_function,
 			   u16 vport_number, u16 *gvmi)
 {
-	u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
-	int out_size;
-	void *out;
 	int err;
 
-	if (other_function) {
-		err = mlx5_vport_get_vhca_id(mdev, vport_number, gvmi);
-		if  (!err)
-			return 0;
-
-		mlx5_core_err(mdev, "Failed to get vport vhca id for vport %d\n",
-			      vport_number);
-		return err;
+	if (!other_function) {
+		/* self vhca_id */
+		*gvmi = MLX5_CAP_GEN(mdev, vhca_id);
+		return 0;
 	}
 
-	/* get vhca_id for `this` function */
-	out_size = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	out = kzalloc(out_size, GFP_KERNEL);
-	if (!out)
-		return -ENOMEM;
-
-	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
-	MLX5_SET(query_hca_cap_in, in, op_mod,
-		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE << 1 | HCA_CAP_OPMOD_GET_CUR);
-
-	err = mlx5_cmd_exec_inout(mdev, query_hca_cap, in, out);
+	err = mlx5_vport_get_vhca_id(mdev, vport_number, gvmi);
 	if (err) {
-		kfree(out);
+		mlx5_core_err(mdev, "Failed to get vport vhca id for vport %d\n",
+			      vport_number);
 		return err;
 	}
 
-	*gvmi = MLX5_GET(query_hca_cap_out, out, capability.cmd_hca_cap.vhca_id);
-
-	kfree(out);
-
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_cmd.c
index bf99b933fd14..1ebb2b15c080 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_cmd.c
@@ -35,41 +35,21 @@ int mlx5dr_cmd_query_esw_vport_context(struct mlx5_core_dev *mdev,
 int mlx5dr_cmd_query_gvmi(struct mlx5_core_dev *mdev, bool other_vport,
 			  u16 vport_number, u16 *gvmi)
 {
-	u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
-	int out_size;
-	void *out;
 	int err;
 
-	if (other_vport) {
-		err = mlx5_vport_get_vhca_id(mdev, vport_number, gvmi);
-		if  (!err)
-			return 0;
-
-		mlx5_core_err(mdev, "Failed to get vport vhca id for vport %d\n",
-			      vport_number);
-		return err;
+	if (!other_vport) {
+		/* self vhca_id */
+		*gvmi = MLX5_CAP_GEN(mdev, vhca_id);
+		return 0;
 	}
 
-	/* get vhca_id for `this` function */
-	out_size = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	out = kzalloc(out_size, GFP_KERNEL);
-	if (!out)
-		return -ENOMEM;
-
-	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
-	MLX5_SET(query_hca_cap_in, in, op_mod,
-		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE << 1 |
-		 HCA_CAP_OPMOD_GET_CUR);
-
-	err = mlx5_cmd_exec_inout(mdev, query_hca_cap, in, out);
+	err = mlx5_vport_get_vhca_id(mdev, vport_number, gvmi);
 	if (err) {
-		kfree(out);
+		mlx5_core_err(mdev, "Failed to get vport vhca id for vport %d\n",
+			      vport_number);
 		return err;
 	}
 
-	*gvmi = MLX5_GET(query_hca_cap_out, out, capability.cmd_hca_cap.vhca_id);
-
-	kfree(out);
 	return 0;
 }
 
-- 
2.50.1


