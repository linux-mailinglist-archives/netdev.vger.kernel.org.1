Return-Path: <netdev+bounces-59387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6F781ABEB
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F468B227B8
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6646A5B;
	Thu, 21 Dec 2023 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+h3tcK1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB73C3D
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F2AC433CB;
	Thu, 21 Dec 2023 00:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703120251;
	bh=UZ7kMK6YqULZRSQeJ3RnO4x/uLmqBiT0Qc8PDohHlyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+h3tcK1E37DhWkapTqFiF713ptVXoCagpRUBEsLXyOCbW00vkHJjEd9ysBKe6PGL
	 xtJpBPw0gNNHyAw+1CuUZl3UtrhUvrC8Q4cOHzY9/wIo5E0GpgvjTN/mMSN6rf3fEG
	 4K5emfY324Vb1OnphakFYPglLg9nrcK5lmK9wpS5FRuCXuIX53m1jeoH5Rv6RHnmyM
	 dhqITgp/pTvwfs2V9FI0XgxMDD2cxy/YzGAh8SnBzNSHIlIg7GLYQHf473QaXO2qPg
	 tXDANgFYby17sXayGQdFBOxnJYtU8zYilyVXJ329X1JoyZEmMtxdZ/eC1KyhMAfG6H
	 8CbmQhRuRrRgg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [net-next 02/15] net/mlx5: Fix query of sd_group field
Date: Wed, 20 Dec 2023 16:57:08 -0800
Message-ID: <20231221005721.186607-3-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221005721.186607-1-saeed@kernel.org>
References: <20231221005721.186607-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

The sd_group field moved in the HW spec from the MPIR register
to the vport context.
Align the query accordingly.

Fixes: f5e956329960 ("net/mlx5: Expose Management PCIe Index Register (MPIR)")
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/vport.c   | 21 +++++++++++++++++++
 include/linux/mlx5/mlx5_ifc.h                 | 10 ++++++---
 include/linux/mlx5/vport.h                    |  1 +
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 5a31fb47ffa5..c95a84b7db3a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -440,6 +440,27 @@ int mlx5_query_nic_vport_system_image_guid(struct mlx5_core_dev *mdev,
 }
 EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_system_image_guid);
 
+int mlx5_query_nic_vport_sd_group(struct mlx5_core_dev *mdev, u8 *sd_group)
+{
+	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
+	u32 *out;
+	int err;
+
+	out = kvzalloc(outlen, GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	if (err)
+		goto out;
+
+	*sd_group = MLX5_GET(query_nic_vport_context_out, out,
+			     nic_vport_context.sd_group);
+out:
+	kvfree(out);
+	return err;
+}
+
 int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev, u64 *node_guid)
 {
 	u32 *out;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index fee20fc010c2..bf2d51952e48 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -4030,8 +4030,13 @@ struct mlx5_ifc_nic_vport_context_bits {
 	u8	   affiliation_criteria[0x4];
 	u8	   affiliated_vhca_id[0x10];
 
-	u8	   reserved_at_60[0xd0];
+	u8	   reserved_at_60[0xa0];
 
+	u8	   reserved_at_100[0x1];
+	u8         sd_group[0x3];
+	u8	   reserved_at_104[0x1c];
+
+	u8	   reserved_at_120[0x10];
 	u8         mtu[0x10];
 
 	u8         system_image_guid[0x40];
@@ -10116,8 +10121,7 @@ struct mlx5_ifc_mpir_reg_bits {
 	u8         reserved_at_20[0x20];
 
 	u8         local_port[0x8];
-	u8         reserved_at_28[0x15];
-	u8         sd_group[0x3];
+	u8         reserved_at_28[0x18];
 
 	u8         reserved_at_60[0x20];
 };
diff --git a/include/linux/mlx5/vport.h b/include/linux/mlx5/vport.h
index fbb9bf447889..c36cc6d82926 100644
--- a/include/linux/mlx5/vport.h
+++ b/include/linux/mlx5/vport.h
@@ -72,6 +72,7 @@ int mlx5_query_nic_vport_mtu(struct mlx5_core_dev *mdev, u16 *mtu);
 int mlx5_modify_nic_vport_mtu(struct mlx5_core_dev *mdev, u16 mtu);
 int mlx5_query_nic_vport_system_image_guid(struct mlx5_core_dev *mdev,
 					   u64 *system_image_guid);
+int mlx5_query_nic_vport_sd_group(struct mlx5_core_dev *mdev, u8 *sd_group);
 int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev, u64 *node_guid);
 int mlx5_modify_nic_vport_node_guid(struct mlx5_core_dev *mdev,
 				    u16 vport, u64 node_guid);
-- 
2.43.0


