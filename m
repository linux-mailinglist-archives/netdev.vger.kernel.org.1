Return-Path: <netdev+bounces-65359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C0083A3ED
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F234AB270E6
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6D317573;
	Wed, 24 Jan 2024 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcUu1Lw3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C617571
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084345; cv=none; b=fwsBTjYZwRhCqjv6RkhGBSmZ6axpi7aq0Rjswdb42u98Yz8f4ef1KPAAxkY/h7Jbv5QDugV8vHzBtNFaWX9siHTtvS/KlS8TmZWCsvWiWFMqsz3WQYw2vIlcNai9118nWyxDmN4KV0WYz86IfpRV57uRt2wgk/c4mJUyK+flnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084345; c=relaxed/simple;
	bh=IBT3sitrciWcKYJTKPfcybfu0PfdfAt/JYV3/2U2qUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=io9oKJQcTk2FlS0FMc2NbQyyjhkEJMJjBzBJdc/mFeOyBqE5FDJhgoJ0zXGO+mV5FjPon4HiwJmjhtm1ow/bU1/gYRBfuL41R6UzA72FMrV8oTpDhwV3aB1HazALnbE8rnSBVtz2UIGeqeytDKaYi4HnFctgqZblyjcKqqTqWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcUu1Lw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7446AC433C7;
	Wed, 24 Jan 2024 08:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084344;
	bh=IBT3sitrciWcKYJTKPfcybfu0PfdfAt/JYV3/2U2qUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pcUu1Lw3MNrRra7NUTZuDvm0yjTWeW/XURUReGRTSsJ/EXVEaL3YexIw6TBWoYzFv
	 HNkv3wGQg1tdG4gJM99rGZrPNGR2G2VcIsmBow3P86jJdGiGedN6T42mgbWfPsHkKx
	 GLUMS+5g0O/2xXsSaeNmRe5vGM9gK2GZxWeYdH9PTespA9tnG1XkSisYsyFK91WaPu
	 8AynFyhBT0LVe+yl0SQapSvyjT8DbzxeeRjO6yg/WqVdOKgKIMgSsTlSc7Ud5vGHVP
	 Dp0Tj70Td3utrT76wgNgSdNehvKbRYjubKnCNs/yC1wxOGqUtOvepuj80RUkHSSju0
	 S/Akr1tuUvFMg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [net 02/14] net/mlx5: Fix query of sd_group field
Date: Wed, 24 Jan 2024 00:18:43 -0800
Message-ID: <20240124081855.115410-3-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124081855.115410-1-saeed@kernel.org>
References: <20240124081855.115410-1-saeed@kernel.org>
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
index 21753f327868..1005bb6935b6 100644
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
index bf5320b28b8b..37230253f9f1 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -4036,8 +4036,13 @@ struct mlx5_ifc_nic_vport_context_bits {
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
@@ -10122,8 +10127,7 @@ struct mlx5_ifc_mpir_reg_bits {
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


