Return-Path: <netdev+bounces-95273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E88C1CBA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4AA1B21D29
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6031714AD3B;
	Fri, 10 May 2024 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkaQUdDC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF914A4EE
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310293; cv=none; b=BaKJJKwQQUhWPMetTNdyrThzBPvDif33gw/dwamC5pneiC9nBxDrwWHDnkm9CEZP+1fHmNGgr5cFz+0hlOdocOAH5bwujGRsL4bBJMxfOzd3rnqgpz+xRtsP8SCzmC0IHw7mgv1Q3DA31J8HeDkhcbSuFAIp60BBL4SX06+1v8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310293; c=relaxed/simple;
	bh=63DSVTkQGmXCvKdZNlH2ICLDQwES5+pYh9RQl/GBqHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF8cN1IVkaH0PvBtr349j84bu3a8uow9DhhL/SEvhQ//cBGvDuwjCqlr1lgY/HYkI+WjBug0olm3PbK0xPRjcwggv+KZtBXW8pyGX1WtSLaV+X6t7tpG+K8BE4uQgXD/2t6fTWqiq37gDobH+zXuyuXdxNEHcAUucj/9UB/beZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkaQUdDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4490DC32783;
	Fri, 10 May 2024 03:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310292;
	bh=63DSVTkQGmXCvKdZNlH2ICLDQwES5+pYh9RQl/GBqHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkaQUdDCVR/mu6vgtNCKzJZtFZOQOXydF4Xz4iDELtRQTpN9pkDLG5xYIqQZcRV8f
	 SLfX6XHzf3LUiz6J8cyTBG0A9JOnuHNqYHmSy4BtMp0Q+Z+isJEQTD1ZFlzQ8QxzGR
	 EH34VYL7gd4YPZgU1qs65UG07v2DF/A3zeS7GIKKhtecA/Y1xWUUTc4hRz0U4ApCsi
	 8PEZeo/OC12U6NXgagwfGZuCMBoXxuuI272sH5jdC1hgTtigGA7O99ZVH4+t3Lqx83
	 NtavyQ680lnzR4UysTc9oxujyFLuYi8mNNOmyVmC7M29IJchcGrcGuHRhBv4rsbKHt
	 hXws6zeC/KB3A==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com,
	tariqt@nvidia.com,
	Raed Salem <raeds@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 12/15] net/mlx5e: Add PSP steering in local NIC RX
Date: Thu,  9 May 2024 20:04:32 -0700
Message-ID: <20240510030435.120935-13-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510030435.120935-1-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

Introduce decrypt FT, the RX error FT, and the default rules.

The PSP (PSP) RX decrypt flow table is pointed by the TTC
(Traffic Type Classifier) UDP steering rules.
The decrypt flow table has two flow groups. The first flow group
keeps the decrypt steering rule programmed always when PSP packet is
recognized using the dedicated udp destenation port number 1000, if
packet is decrypted then a PSP marker is set in metadata_regB[30].
The second flow group has a default rule to forward all non-offloaded
PSP packet to the TTC UDP default RSS TIR.

The RX error flow table is the destination of the decrypt steering rules in
the PSP RX decrypt flow table. It has two fixed rule one with single copy
action that copies nisp_syndrome to metadata_regB[23:29]. The PSP marker
and syndrome is used to filter out non-nisp packet and to return the PSP
crypto offload status in Rx flow. The marker is used to identify such
packet in driver so the driver could set SKB PSP metadata. The destination
of RX error flow table is the TTC UDP default RSS TIR. The second rule will
drop packets that failed to be decrypted (like in case illegal SPI or
expired SPI is used).

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   2 +-
 .../mellanox/mlx5/core/en_accel/nisp_fs.c     | 481 +++++++++++++++++-
 2 files changed, 476 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index 4d6225e0eec7..23af74e4f8c5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -83,7 +83,7 @@ enum {
 #ifdef CONFIG_MLX5_EN_ARFS
 	MLX5E_ARFS_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 #endif
-#ifdef CONFIG_MLX5_EN_IPSEC
+#if defined(CONFIG_MLX5_EN_IPSEC) || defined(CONFIG_MLX5_EN_PSP)
 	MLX5E_ACCEL_FS_POL_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 	MLX5E_ACCEL_FS_ESP_FT_LEVEL,
 	MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c
index 5d2ce83db7cc..11f583d13bdd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c
@@ -8,6 +8,12 @@
 #include "en_accel/nisp_fs.h"
 #include "en_accel/nisp.h"
 
+enum accel_fs_nisp_type {
+       ACCEL_FS_NISP4,
+       ACCEL_FS_NISP6,
+       ACCEL_FS_NISP_NUM_TYPES,
+};
+
 struct mlx5e_nisp_tx {
 	struct mlx5_flow_namespace *ns;
 	struct mlx5_flow_table *ft;
@@ -17,14 +23,15 @@ struct mlx5e_nisp_tx {
 	u32 refcnt;
 };
 
-struct mlx5e_nisp_fs {
-	struct mlx5_core_dev *mdev;
-	struct mlx5e_nisp_tx *tx_fs;
-	struct mlx5e_flow_steering *fs;
-};
-
 enum accel_nisp_rule_action {
 	ACCEL_NISP_RULE_ACTION_ENCRYPT,
+	ACCEL_NISP_RULE_ACTION_DECRYPT,
+};
+
+enum accel_nisp_syndrome {
+	NISP_OK = 0,
+	NISP_ICV_FAIL,
+	NISP_BAD_TRAILER,
 };
 
 struct mlx5e_accel_nisp_rule {
@@ -32,6 +39,216 @@ struct mlx5e_accel_nisp_rule {
 	u8 action;
 };
 
+struct mlx5e_nisp_rx_err {
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_handle *drop_rule;
+	struct mlx5_modify_hdr *copy_modify_hdr;
+};
+
+struct mlx5e_accel_fs_nisp_prot {
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_group *miss_group;
+	struct mlx5_flow_handle *miss_rule;
+	struct mlx5_flow_destination default_dest;
+	struct mlx5e_nisp_rx_err rx_err;
+	u32 refcnt;
+	struct mutex prot_mutex; /* protect ESP4/ESP6 protocol */
+	struct mlx5_flow_handle *def_rule;
+};
+
+struct mlx5e_accel_fs_nisp {
+	struct mlx5e_accel_fs_nisp_prot fs_prot[ACCEL_FS_NISP_NUM_TYPES];
+};
+
+struct mlx5e_nisp_fs {
+	struct mlx5_core_dev *mdev;
+	struct mlx5e_nisp_tx *tx_fs;
+	/* Rx manage */
+	struct mlx5e_flow_steering *fs;
+	struct mlx5e_accel_fs_nisp *rx_fs;
+};
+
+/* NISP RX flow steering */
+static enum mlx5_traffic_types fs_nisp2tt(enum accel_fs_nisp_type i)
+{
+	if (i == ACCEL_FS_NISP4)
+		return MLX5_TT_IPV4_UDP;
+
+	return MLX5_TT_IPV6_UDP;
+}
+
+static void accel_nisp_fs_rx_err_del_rules(struct mlx5e_nisp_fs *fs,
+					  struct mlx5e_nisp_rx_err *rx_err)
+{
+	if (rx_err->drop_rule) {
+		mlx5_del_flow_rules(rx_err->drop_rule);
+		rx_err->drop_rule = NULL;
+	}
+
+	if (rx_err->rule) {
+		mlx5_del_flow_rules(rx_err->rule);
+		rx_err->rule = NULL;
+	}
+
+	if (rx_err->copy_modify_hdr) {
+		mlx5_modify_header_dealloc(fs->mdev, rx_err->copy_modify_hdr);
+		rx_err->copy_modify_hdr = NULL;
+	}
+}
+
+static void accel_nisp_fs_rx_err_destroy_ft(struct mlx5e_nisp_fs *fs,
+					    struct mlx5e_nisp_rx_err *rx_err)
+{
+	accel_nisp_fs_rx_err_del_rules(fs, rx_err);
+
+	if (rx_err->ft) {
+		mlx5_destroy_flow_table(rx_err->ft);
+		rx_err->ft = NULL;
+	}
+}
+
+static void accel_nisp_setup_syndrome_match(struct mlx5_flow_spec *spec,
+		enum accel_nisp_syndrome syndrome)
+{
+	void *misc_params_2;
+
+	spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
+	misc_params_2 = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, misc_parameters_2);
+	MLX5_SET_TO_ONES(fte_match_set_misc2, misc_params_2, nisp_syndrome);
+	misc_params_2 = MLX5_ADDR_OF(fte_match_param, spec->match_value, misc_parameters_2);
+	MLX5_SET(fte_match_set_misc2, misc_params_2, nisp_syndrome, syndrome);
+}
+
+static int accel_nisp_fs_rx_err_add_rule(struct mlx5e_nisp_fs *fs,
+		struct mlx5e_accel_fs_nisp_prot *fs_prot,
+		struct mlx5e_nisp_rx_err *rx_err)
+{
+	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
+	struct mlx5_core_dev *mdev = fs->mdev;
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_modify_hdr *modify_hdr;
+	struct mlx5_flow_handle *fte;
+	struct mlx5_flow_spec *spec;
+	int err = 0;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	/* Action to copy 7 bit nisp_syndrome to regB[23:29] */
+	MLX5_SET(copy_action_in, action, action_type, MLX5_ACTION_TYPE_COPY);
+	MLX5_SET(copy_action_in, action, src_field, MLX5_ACTION_IN_FIELD_NISP_SYNDROME);
+	MLX5_SET(copy_action_in, action, src_offset, 0);
+	MLX5_SET(copy_action_in, action, length, 7);
+	MLX5_SET(copy_action_in, action, dst_field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
+	MLX5_SET(copy_action_in, action, dst_offset, 23);
+
+	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_KERNEL,
+			1, action);
+	if (IS_ERR(modify_hdr)) {
+		err = PTR_ERR(modify_hdr);
+		mlx5_core_err(mdev,
+			      "fail to alloc nisp copy modify_header_id err=%d\n", err);
+		goto out_spec;
+	}
+
+	accel_nisp_setup_syndrome_match(spec, NISP_OK);
+	/* create fte */
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_MOD_HDR |
+		MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	flow_act.modify_hdr = modify_hdr;
+	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act,
+			&fs_prot->default_dest, 1);
+	if (IS_ERR(fte)) {
+		err = PTR_ERR(fte);
+		mlx5_core_err(mdev, "fail to add nisp rx err copy rule err=%d\n", err);
+		goto out;
+	}
+	rx_err->rule = fte;
+
+	/* add default drop rule */
+	memset(spec, 0, sizeof(*spec));
+	memset(&flow_act, 0, sizeof(flow_act));
+	/* create fte */
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP;
+	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, NULL, 0);
+	if (IS_ERR(fte)) {
+		err = PTR_ERR(fte);
+		mlx5_core_err(mdev, "fail to add nisp rx err drop rule err=%d\n", err);
+		goto out_drop_rule;
+	}
+	rx_err->drop_rule = fte;
+	rx_err->copy_modify_hdr = modify_hdr;
+
+	goto out_spec;
+
+out_drop_rule:
+	mlx5_del_flow_rules(rx_err->rule);
+	rx_err->rule = NULL;
+out:
+	mlx5_modify_header_dealloc(mdev, modify_hdr);
+out_spec:
+	kfree(spec);
+	return err;
+}
+
+static int accel_nisp_fs_rx_err_create_ft(struct mlx5e_nisp_fs *fs,
+					  struct mlx5e_accel_fs_nisp_prot *fs_prot,
+					  struct mlx5e_nisp_rx_err *rx_err)
+{
+	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(fs->fs, false);
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_table *ft;
+	int err;
+
+	ft_attr.max_fte = 2;
+	ft_attr.autogroup.max_num_groups = 2;
+	ft_attr.level = MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL; // MLX5E_ACCEL_FS_TCP_FT_LEVEL
+	ft_attr.prio = MLX5E_NIC_PRIO;
+	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(fs->mdev, "fail to create nisp rx inline ft err=%d\n", err);
+		return err;
+	}
+
+	rx_err->ft = ft;
+	err = accel_nisp_fs_rx_err_add_rule(fs, fs_prot, rx_err);
+	if (err)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	mlx5_destroy_flow_table(ft);
+	rx_err->ft = NULL;
+	return err;
+}
+
+static void accel_nisp_fs_rx_fs_destroy(struct mlx5e_accel_fs_nisp_prot *fs_prot)
+{
+	if (fs_prot->def_rule) {
+		mlx5_del_flow_rules(fs_prot->def_rule);
+		fs_prot->def_rule = NULL;
+	}
+
+	if (fs_prot->miss_rule) {
+		mlx5_del_flow_rules(fs_prot->miss_rule);
+		fs_prot->miss_rule = NULL;
+	}
+
+	if (fs_prot->miss_group) {
+		mlx5_destroy_flow_group(fs_prot->miss_group);
+		fs_prot->miss_group = NULL;
+	}
+
+	if (fs_prot->ft) {
+		mlx5_destroy_flow_table(fs_prot->ft);
+		fs_prot->ft = NULL;
+	}
+}
+
 static void setup_fte_udp_psp(struct mlx5_flow_spec *spec, u16 udp_port)
 {
 	spec->match_criteria_enable |= MLX5_MATCH_OUTER_HEADERS;
@@ -41,6 +258,251 @@ static void setup_fte_udp_psp(struct mlx5_flow_spec *spec, u16 udp_port)
 	MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, ip_protocol, IPPROTO_UDP);
 }
 
+static int accel_nisp_fs_rx_create_ft(struct mlx5e_nisp_fs *fs,
+				      struct mlx5e_accel_fs_nisp_prot *fs_prot)
+{
+	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(fs->fs, false);
+	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_modify_hdr *modify_hdr = NULL;
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_core_dev *mdev = fs->mdev;
+	struct mlx5_flow_group *miss_group;
+	MLX5_DECLARE_FLOW_ACT(flow_act);
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	struct mlx5_flow_table *ft;
+	u32 *flow_group_in;
+	int err = 0;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!flow_group_in || !spec) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Create FT */
+	ft_attr.max_fte = 2;
+	ft_attr.level = MLX5E_ACCEL_FS_ESP_FT_LEVEL;
+	ft_attr.prio = MLX5E_NIC_PRIO;
+	ft_attr.autogroup.num_reserved_entries = 1;
+	ft_attr.autogroup.max_num_groups = 1;
+	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(mdev, "fail to create nisp rx ft err=%d\n", err);
+		goto out_err;
+	}
+	fs_prot->ft = ft;
+
+	/* Create miss_group */
+	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, ft->max_fte - 1);
+	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, ft->max_fte - 1);
+	miss_group = mlx5_create_flow_group(ft, flow_group_in);
+	if (IS_ERR(miss_group)) {
+		err = PTR_ERR(miss_group);
+		mlx5_core_err(mdev, "fail to create nisp rx miss_group err=%d\n", err);
+		goto out_err;
+	}
+	fs_prot->miss_group = miss_group;
+
+	/* Create miss rule */
+	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &fs_prot->default_dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev, "fail to create nisp rx miss_rule err=%d\n", err);
+		goto out_err;
+	}
+	fs_prot->miss_rule = rule;
+
+	/* Add default Rx Nisp rule */
+	setup_fte_udp_psp(spec, PSP_DEFAULT_UDP_PORT);
+	flow_act.crypto.type = MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_NISP;
+	/* Set bit[31, 30] NISP marker */
+	/* Set bit[29-23] nisp_syndrome is set in error FT */
+#define MLX5E_NISP_MARKER_BIT (BIT(30) | BIT(31))
+	MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
+	MLX5_SET(set_action_in, action, field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
+	MLX5_SET(set_action_in, action, data, MLX5E_NISP_MARKER_BIT);
+	MLX5_SET(set_action_in, action, offset, 0);
+	MLX5_SET(set_action_in, action, length, 32);
+
+	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_KERNEL, 1, action);
+	if (IS_ERR(modify_hdr)) {
+		err = PTR_ERR(modify_hdr);
+		mlx5_core_err(mdev, "fail to alloc nisp set modify_header_id err=%d\n", err);
+		modify_hdr = NULL;
+		goto out_err;
+	}
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
+		MLX5_FLOW_CONTEXT_ACTION_CRYPTO_DECRYPT |
+		MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
+	flow_act.modify_hdr = modify_hdr;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest.ft = fs_prot->rx_err.ft;
+	rule = mlx5_add_flow_rules(fs_prot->ft, spec, &flow_act, &dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev,
+			      "fail to add nisp rule Rx dycrption, err=%d, flow_act.action = %#04X\n",
+			      err, flow_act.action);
+		goto out_err;
+	}
+
+	fs_prot->def_rule = rule;
+	goto out;
+
+out_err:
+	accel_nisp_fs_rx_fs_destroy(fs_prot);
+out:
+	kvfree(flow_group_in);
+	kvfree(spec);
+	return err;
+}
+
+static int accel_nisp_fs_rx_destroy(struct mlx5e_nisp_fs *fs, enum accel_fs_nisp_type type)
+{
+	struct mlx5e_accel_fs_nisp_prot *fs_prot;
+	struct mlx5e_accel_fs_nisp *accel_nisp;
+
+	accel_nisp = fs->rx_fs;
+
+	/* The netdev unreg already happened, so all offloaded rule are already removed */
+	fs_prot = &accel_nisp->fs_prot[type];
+
+	accel_nisp_fs_rx_fs_destroy(fs_prot);
+
+	accel_nisp_fs_rx_err_destroy_ft(fs, &fs_prot->rx_err);
+
+	return 0;
+}
+
+static int accel_nisp_fs_rx_create(struct mlx5e_nisp_fs *fs, enum accel_fs_nisp_type type)
+{
+	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
+	struct mlx5e_accel_fs_nisp_prot *fs_prot;
+	struct mlx5e_accel_fs_nisp *accel_nisp;
+	int err;
+
+	accel_nisp = fs->rx_fs;
+	fs_prot = &accel_nisp->fs_prot[type];
+
+	fs_prot->default_dest = mlx5_ttc_get_default_dest(ttc, fs_nisp2tt(type));
+
+	err = accel_nisp_fs_rx_err_create_ft(fs, fs_prot, &fs_prot->rx_err);
+	if (err)
+		return err;
+
+	err = accel_nisp_fs_rx_create_ft(fs, fs_prot);
+	if (err)
+		accel_nisp_fs_rx_err_destroy_ft(fs, &fs_prot->rx_err);
+
+	return err;
+}
+
+static int accel_nisp_fs_rx_ft_get(struct mlx5e_nisp_fs *fs, enum accel_fs_nisp_type type)
+{
+	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
+	struct mlx5e_accel_fs_nisp_prot *fs_prot;
+	struct mlx5_flow_destination dest = {};
+	struct mlx5e_accel_fs_nisp *accel_nisp;
+	int err = 0;
+
+	if (!fs || !fs->rx_fs)
+		return -EINVAL;
+
+	accel_nisp = fs->rx_fs;
+	fs_prot = &accel_nisp->fs_prot[type];
+	mutex_lock(&fs_prot->prot_mutex);
+	if (fs_prot->refcnt++)
+		goto out;
+
+	/* create FT */
+	err = accel_nisp_fs_rx_create(fs, type);
+	if (err) {
+		fs_prot->refcnt--;
+		goto out;
+	}
+
+	/* connect */
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest.ft = fs_prot->ft;
+	mlx5_ttc_fwd_dest(ttc, fs_nisp2tt(type), &dest);
+
+out:
+	mutex_unlock(&fs_prot->prot_mutex);
+	return err;
+}
+
+static void accel_nisp_fs_rx_ft_put(struct mlx5e_nisp_fs *fs, enum accel_fs_nisp_type type)
+{
+	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
+	struct mlx5e_accel_fs_nisp_prot *fs_prot;
+	struct mlx5e_accel_fs_nisp *accel_nisp;
+
+	accel_nisp = fs->rx_fs;
+	fs_prot = &accel_nisp->fs_prot[type];
+	mutex_lock(&fs_prot->prot_mutex);
+	if (--fs_prot->refcnt)
+		goto out;
+
+	/* disconnect */
+	mlx5_ttc_fwd_default_dest(ttc, fs_nisp2tt(type));
+
+	/* remove FT */
+	accel_nisp_fs_rx_destroy(fs, type);
+
+out:
+	mutex_unlock(&fs_prot->prot_mutex);
+}
+
+static void accel_nisp_fs_cleanup_rx(struct mlx5e_nisp_fs *fs)
+{
+	struct mlx5e_accel_fs_nisp_prot *fs_prot;
+	struct mlx5e_accel_fs_nisp *accel_nisp;
+	enum accel_fs_nisp_type i;
+
+	if (!fs->rx_fs)
+		return;
+
+	for (i = 0; i < ACCEL_FS_NISP_NUM_TYPES; i++)
+		accel_nisp_fs_rx_ft_put(fs, i);
+
+	accel_nisp = fs->rx_fs;
+	for (i = 0; i < ACCEL_FS_NISP_NUM_TYPES; i++) {
+		fs_prot = &accel_nisp->fs_prot[i];
+		mutex_destroy(&fs_prot->prot_mutex);
+		WARN_ON(fs_prot->refcnt);
+	}
+	kfree(fs->rx_fs);
+	fs->rx_fs = NULL;
+}
+
+static int accel_nisp_fs_init_rx(struct mlx5e_nisp_fs *fs)
+{
+	struct mlx5e_accel_fs_nisp_prot *fs_prot;
+	struct mlx5e_accel_fs_nisp *accel_nisp;
+	enum accel_fs_nisp_type i;
+
+	accel_nisp = kzalloc(sizeof(*accel_nisp), GFP_KERNEL);
+	if (!accel_nisp)
+		return -ENOMEM;
+
+	for (i = 0; i < ACCEL_FS_NISP_NUM_TYPES; i++) {
+		fs_prot = &accel_nisp->fs_prot[i];
+		mutex_init(&fs_prot->prot_mutex);
+	}
+
+	for (i = 0; i < ACCEL_FS_NISP_NUM_TYPES; i++)
+		accel_nisp_fs_rx_ft_get(fs, ACCEL_FS_NISP4);
+
+	fs->rx_fs = accel_nisp;
+	return 0;
+}
+
 static int accel_nisp_fs_tx_create_ft_table(struct mlx5e_nisp_fs *fs)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
@@ -207,6 +669,7 @@ int mlx5_accel_nisp_fs_init_tx_tables(struct mlx5e_priv *priv)
 
 void mlx5e_accel_nisp_fs_cleanup(struct mlx5e_nisp_fs *fs)
 {
+	accel_nisp_fs_cleanup_rx(fs);
 	accel_nisp_fs_cleanup_tx(fs);
 	kfree(fs);
 }
@@ -226,8 +689,14 @@ struct mlx5e_nisp_fs *mlx5e_accel_nisp_fs_init(struct mlx5e_priv *priv)
 		goto err_tx;
 
 	fs->fs = priv->fs;
+	err = accel_nisp_fs_init_rx(fs);
+	if (err)
+		goto err_rx;
 
 	return fs;
+
+err_rx:
+	accel_nisp_fs_cleanup_tx(fs);
 err_tx:
 	kfree(fs);
 	return ERR_PTR(err);
-- 
2.45.0


