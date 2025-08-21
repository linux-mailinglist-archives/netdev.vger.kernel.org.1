Return-Path: <netdev+bounces-215835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4119CB308BF
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 23:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397371C28598
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 21:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB962EB870;
	Thu, 21 Aug 2025 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttgRYIFh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB32EB86B
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813538; cv=none; b=KpkOISRrXIoJ7y9aWYht1wAO5rBYgv8PGxugXlhrfsHY6bLPhRNMdMVkCKdUtJN9ZSthr1iUpC6grB8gmPaJ0H+nGWOGPDrMytuX51e+DOH39wIFoA0ezK4ohHy5pwiFEadqnhWc24c5kVkZjp/cyluTGZLoVSqkxert5brwIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813538; c=relaxed/simple;
	bh=jcspID1Khl6+k/aR7j0kSG7qetWww1Vhq7ZDI7sKXzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9HzgKessrqceE3fWeAQwZPevI6A1mIPSHByFd21XBX0zZUiWfs+rIXZdgn4+lnsAPd4J+mb6Szhw7zqXUF1wbnKH443LW5aedqcdzJE2fV5a/QmeKHjKc9yH0TdqBf/r9h0i7n8zesw31dhWp2te/Imjavrw+UdeqaffPaLNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttgRYIFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E8DC4CEEB;
	Thu, 21 Aug 2025 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755813538;
	bh=jcspID1Khl6+k/aR7j0kSG7qetWww1Vhq7ZDI7sKXzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ttgRYIFh5lOANZABI09O+26mBvngVKJp8icko3HS/z45HYp0QemmY0SGYjj888Ly4
	 nueh3Rz3dWVGBPBGi/VinMhtiWYSMGAUyVZkTuRCBcvpKgoX1AH3pF8pb4uqiTJ4ZL
	 /pBlAP04lRGvRMs72xaAn/sDwHa5svgui5KAZNsAmsgo3lXEAzltKmdPeaeOmZPuQg
	 LYbnR7mLC6cQ8JZ+pixvjv1aajkP33FhRacguzz8YSSPslQnEPv5QXX9cXArpWtvyS
	 kNxT5kUE6t4idQERw9vZf0YpUY+6CLDT0O30LJS/xll07+NJoJ9Ifu3BHPnEuoBEAm
	 CzYaf2htWDJwg==
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
Subject: [PATCH net-next 7/7] net/mlx5: {DR,HWS}, Use the cached vhca_id for this device
Date: Thu, 21 Aug 2025 14:58:39 -0700
Message-ID: <20250821215839.280364-8-saeed@kernel.org>
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


