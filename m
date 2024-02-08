Return-Path: <netdev+bounces-70082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A253684D933
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CC21C23B3C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDD12E633;
	Thu,  8 Feb 2024 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU+kADrq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2652E62E
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364453; cv=none; b=gMRPzZHBV54LfV1JmEAtCVl76Zf6jdInBq9ebllodhZW4yBdHMUZU/6KFMYUkAVizcWZlJFgcXghFQHV0eUgo/KcXlzAw3mmNxsDLm+vXePqIVLxMBrD5M1EbT+3LgUAGUX+6zcBED6RArW72ZZa/qaWNJSnfRlTfk3FtnTlz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364453; c=relaxed/simple;
	bh=10QIIsGfbZvhkAA4NHlsNeau7W7UP1Sn4H1aVrUSZeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmDl/k/8kfQ84YLiWEws2nR6U5ZoUfFyxN+HhWz4zdySjJ9JfQpXbE5LkjEQABtyEaM55wXVSp9KK2ng4fgOAGxFaU0KrWQpQiLQcJYECimF2fUsn+k0PWZrxKuiWIwvP3nNo1Aw7Yydvh2ggMMLvREpWmXMNFlDFC+P+Q62gWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU+kADrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBDFC433C7;
	Thu,  8 Feb 2024 03:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707364453;
	bh=10QIIsGfbZvhkAA4NHlsNeau7W7UP1Sn4H1aVrUSZeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YU+kADrq0yBUUa9rZfVz+LHnATxVE3qdtjDzBUyT4maW/4o/j/SE6y8OyG6a3pMWu
	 uoQYoCYMEI3+HmPpLIvmgJFHa2NCDWtUl2xEK13okpdocTp3CmkRCKEgIVsv+WN9MW
	 MNJAnOGMmEitBYg+pH3+jzHkjF6ZNVse0fxpcJtgq9Mh2QKRl/KUunpMptvlRpXvbr
	 6W1wsFq8vGTsvISVQ1ArGL46rZFr68vvXZmBJfl2oFgqwOibMXXSWd8qPm6WVFajYd
	 NJkGc5azN9WDMi9RsDTi7jzth59uVsoa7DykL8vJf3ZeejuzGH9j+PH7tDEKv7FO5l
	 pJp1ec8oXZaKA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V2 05/15] net/mlx5: SD, Implement steering for primary and secondaries
Date: Wed,  7 Feb 2024 19:53:42 -0800
Message-ID: <20240208035352.387423-6-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208035352.387423-1-saeed@kernel.org>
References: <20240208035352.387423-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Implement the needed SD steering adjustments for the primary and
secondaries.

While the SD multiple devices are used to avoid cross-numa memory, when
it comes to chip level all traffic goes only through the primary device.
The secondaries are forced to silent mode, to guarantee they are not
involved in any unexpected ingress/egress traffic.

In RX, secondary devices will not have steering objects. Traffic will be
steered from the primary device to the RQs of a secondary device using
advanced cross-vhca RX steering capabilities.

In TX, the primary creates a new TX flow table, which is aliased by the
secondaries.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 185 +++++++++++++++++-
 1 file changed, 184 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 3059a3750f82..76c2426c2498 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -4,6 +4,7 @@
 #include "lib/sd.h"
 #include "mlx5_core.h"
 #include "lib/mlx5.h"
+#include "fs_cmd.h"
 #include <linux/mlx5/vport.h>
 
 #define sd_info(__dev, format, ...) \
@@ -19,9 +20,11 @@ struct mlx5_sd {
 	union {
 		struct { /* primary */
 			struct mlx5_core_dev *secondaries[MLX5_SD_MAX_GROUP_SZ - 1];
+			struct mlx5_flow_table *tx_ft;
 		};
 		struct { /* secondary */
 			struct mlx5_core_dev *primary_dev;
+			u32 alias_obj_id;
 		};
 	};
 };
@@ -78,6 +81,21 @@ struct mlx5_core_dev *mlx5_sd_ch_ix_get_dev(struct mlx5_core_dev *primary, int c
 	return mlx5_sd_primary_get_peer(primary, mdev_idx);
 }
 
+static bool ft_create_alias_supported(struct mlx5_core_dev *dev)
+{
+	u64 obj_allowed = MLX5_CAP_GEN_2_64(dev, allowed_object_for_other_vhca_access);
+	u32 obj_supp = MLX5_CAP_GEN_2(dev, cross_vhca_object_to_object_supported);
+
+	if (!(obj_supp &
+	    MLX5_CROSS_VHCA_OBJ_TO_OBJ_SUPPORTED_LOCAL_FLOW_TABLE_ROOT_TO_REMOTE_FLOW_TABLE))
+		return false;
+
+	if (!(obj_allowed & MLX5_ALLOWED_OBJ_FOR_OTHER_VHCA_ACCESS_FLOW_TABLE))
+		return false;
+
+	return true;
+}
+
 static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
 {
 	/* Feature is currently implemented for PFs only */
@@ -88,6 +106,24 @@ static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
 	if (host_buses > MLX5_SD_MAX_GROUP_SZ)
 		return false;
 
+	/* Disconnect secondaries from the network */
+	if (!MLX5_CAP_GEN(dev, eswitch_manager))
+		return false;
+	if (!MLX5_CAP_GEN(dev, silent_mode))
+		return false;
+
+	/* RX steering from primary to secondaries */
+	if (!MLX5_CAP_GEN(dev, cross_vhca_rqt))
+		return false;
+	if (host_buses > MLX5_CAP_GEN_2(dev, max_rqt_vhca_id))
+		return false;
+
+	/* TX steering from secondaries to primary */
+	if (!ft_create_alias_supported(dev))
+		return false;
+	if (!MLX5_CAP_FLOWTABLE_NIC_TX(dev, reset_root_to_default))
+		return false;
+
 	return true;
 }
 
@@ -230,10 +266,122 @@ static void sd_unregister(struct mlx5_core_dev *dev)
 	mlx5_devcom_unregister_component(sd->devcom);
 }
 
+static int sd_cmd_set_primary(struct mlx5_core_dev *primary, u8 *alias_key)
+{
+	struct mlx5_cmd_allow_other_vhca_access_attr allow_attr = {};
+	struct mlx5_sd *sd = mlx5_get_sd(primary);
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_namespace *nic_ns;
+	struct mlx5_flow_table *ft;
+	int err;
+
+	nic_ns = mlx5_get_flow_namespace(primary, MLX5_FLOW_NAMESPACE_EGRESS);
+	if (!nic_ns)
+		return -EOPNOTSUPP;
+
+	ft = mlx5_create_flow_table(nic_ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		return err;
+	}
+	sd->tx_ft = ft;
+	memcpy(allow_attr.access_key, alias_key, ACCESS_KEY_LEN);
+	allow_attr.obj_type = MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS;
+	allow_attr.obj_id = (ft->type << FT_ID_FT_TYPE_OFFSET) | ft->id;
+
+	err = mlx5_cmd_allow_other_vhca_access(primary, &allow_attr);
+	if (err) {
+		mlx5_core_err(primary, "Failed to allow other vhca access err=%d\n",
+			      err);
+		mlx5_destroy_flow_table(ft);
+		return err;
+	}
+
+	return 0;
+}
+
+static void sd_cmd_unset_primary(struct mlx5_core_dev *primary)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(primary);
+
+	mlx5_destroy_flow_table(sd->tx_ft);
+}
+
+static int sd_secondary_create_alias_ft(struct mlx5_core_dev *secondary,
+					struct mlx5_core_dev *primary,
+					struct mlx5_flow_table *ft,
+					u32 *obj_id, u8 *alias_key)
+{
+	u32 aliased_object_id = (ft->type << FT_ID_FT_TYPE_OFFSET) | ft->id;
+	u16 vhca_id_to_be_accessed = MLX5_CAP_GEN(primary, vhca_id);
+	struct mlx5_cmd_alias_obj_create_attr alias_attr = {};
+	int ret;
+
+	memcpy(alias_attr.access_key, alias_key, ACCESS_KEY_LEN);
+	alias_attr.obj_id = aliased_object_id;
+	alias_attr.obj_type = MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS;
+	alias_attr.vhca_id = vhca_id_to_be_accessed;
+	ret = mlx5_cmd_alias_obj_create(secondary, &alias_attr, obj_id);
+	if (ret) {
+		mlx5_core_err(secondary, "Failed to create alias object err=%d\n",
+			      ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void sd_secondary_destroy_alias_ft(struct mlx5_core_dev *secondary)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(secondary);
+
+	mlx5_cmd_alias_obj_destroy(secondary, sd->alias_obj_id,
+				   MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS);
+}
+
+static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
+				struct mlx5_core_dev *primary,
+				u8 *alias_key)
+{
+	struct mlx5_sd *primary_sd = mlx5_get_sd(primary);
+	struct mlx5_sd *sd = mlx5_get_sd(secondary);
+	int err;
+
+	err = mlx5_fs_cmd_set_l2table_entry_silent(secondary, 1);
+	if (err)
+		return err;
+
+	err = sd_secondary_create_alias_ft(secondary, primary, primary_sd->tx_ft,
+					   &sd->alias_obj_id, alias_key);
+	if (err)
+		goto err_unset_silent;
+
+	err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, sd->alias_obj_id, false);
+	if (err)
+		goto err_destroy_alias_ft;
+
+	return 0;
+
+err_destroy_alias_ft:
+	sd_secondary_destroy_alias_ft(secondary);
+err_unset_silent:
+	mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
+	return err;
+}
+
+static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
+{
+	mlx5_fs_cmd_set_tx_flow_table_root(secondary, 0, true);
+	sd_secondary_destroy_alias_ft(secondary);
+	mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
+}
+
 int mlx5_sd_init(struct mlx5_core_dev *dev)
 {
+	struct mlx5_core_dev *primary, *pos, *to;
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
-	int err;
+	u8 alias_key[ACCESS_KEY_LEN];
+	int err, i;
 
 	err = sd_init(dev);
 	if (err)
@@ -247,8 +395,33 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_sd_cleanup;
 
+	if (!mlx5_devcom_comp_is_ready(sd->devcom))
+		return 0;
+
+	primary = mlx5_sd_get_primary(dev);
+
+	for (i = 0; i < ACCESS_KEY_LEN; i++)
+		alias_key[i] = get_random_u8();
+
+	err = sd_cmd_set_primary(primary, alias_key);
+	if (err)
+		goto err_sd_unregister;
+
+	mlx5_sd_for_each_secondary(i, primary, pos) {
+		err = sd_cmd_set_secondary(pos, primary, alias_key);
+		if (err)
+			goto err_unset_secondaries;
+	}
+
 	return 0;
 
+err_unset_secondaries:
+	to = pos;
+	mlx5_sd_for_each_secondary_to(i, primary, to, pos)
+		sd_cmd_unset_secondary(pos);
+	sd_cmd_unset_primary(primary);
+err_sd_unregister:
+	sd_unregister(dev);
 err_sd_cleanup:
 	sd_cleanup(dev);
 	return err;
@@ -257,10 +430,20 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
+	struct mlx5_core_dev *primary, *pos;
+	int i;
 
 	if (!sd)
 		return;
 
+	if (!mlx5_devcom_comp_is_ready(sd->devcom))
+		goto out;
+
+	primary = mlx5_sd_get_primary(dev);
+	mlx5_sd_for_each_secondary(i, primary, pos)
+		sd_cmd_unset_secondary(pos);
+	sd_cmd_unset_primary(primary);
+out:
 	sd_unregister(dev);
 	sd_cleanup(dev);
 }
-- 
2.43.0


