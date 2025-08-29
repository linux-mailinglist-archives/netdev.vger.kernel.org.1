Return-Path: <netdev+bounces-218410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC9B3C510
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD4F5A547C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7912DA751;
	Fri, 29 Aug 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8ivWnw9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184792DA744
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507059; cv=none; b=EkpmVFAnW0dGZDDfYtw5wJQOdwyvOnJsQ74xVMHxRfwVfR6CqDfGH7wd9OzLNjNugQ9a9JOBFekQJoB24FQT63NgKat2hVqa/c0AzQko1REzflJwjeiuofgDe7xqnfv7Bl4dE2hgzt5Uz70mgLfSyb6TlKgYgCOqaB3WgsHT994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507059; c=relaxed/simple;
	bh=uyLa0hqZydOnWervSiusadw2qDHgqHAqVsM0DIEYqQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9jPquD0qTUkb4WBMEheHJvPwlr5xJPUAdUjy7Z20Ttn/VFIPRBu1pINvf4ZtyRr6NzhZh/vd5sLaI0nEscuf5ksqPeG1FrZRRMGBqDRezKJvChggwyGGFelnvlhT4XCj+5Ptxw8ZEYT8WXu0WZktgf7bmvng8JJL4c1Vq4rLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8ivWnw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D734BC4CEF0;
	Fri, 29 Aug 2025 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756507058;
	bh=uyLa0hqZydOnWervSiusadw2qDHgqHAqVsM0DIEYqQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D8ivWnw9n7jGMvgEKgQrNqkAnxLXdXvvZolDbVnmMMxA2WYUXyzCZeAQJnbCow0zK
	 srrCZkJq67xXUQC1hDYIxv86K+Mpu78gszsGdkxsTJ8HrpUC1T7aBh7uxyKrWSsgE6
	 aRYBJXP6AzPwJqAmyaI8Aa1ovlVADoQWZd8PLviiJN5WKMmHr1rTvPsJMiGxWx+f/W
	 xcFyG9gL++o5uLluazYeRo4UTHctD0e2ce/2sar06V0UhaA+KV+V9q5fkTnucBnoM1
	 qERQT4WIji3wiIjdChIk+Bhz8KmXxU/TmTj+fDnsqPAdUkaWG28CjV1XmSDljjgFk0
	 Jwg8jPxPuSyVQ==
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
	mbloch@nvidia.com,
	horms@kernel.org
Subject: [PATCH net-next V3 7/7] net/mlx5: {DR,HWS}, Use the cached vhca_id for this device
Date: Fri, 29 Aug 2025 15:37:22 -0700
Message-ID: <20250829223722.900629-8-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829223722.900629-1-saeed@kernel.org>
References: <20250829223722.900629-1-saeed@kernel.org>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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


