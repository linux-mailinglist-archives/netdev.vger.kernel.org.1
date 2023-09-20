Return-Path: <netdev+bounces-35126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB09F7A72EA
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212C61C20AAB
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637098C1C;
	Wed, 20 Sep 2023 06:36:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5228C19
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3AEC433CD;
	Wed, 20 Sep 2023 06:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191766;
	bh=+xsryfgaPixIgPNogVTJCa8i5jkYie0rwQbaXU9Xexg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZuBdjc3KbeX0jC6mvZwqaTskS3gajwvNDfNX3dh7T8YSBWm93LnLIIBENSkFsw2ka
	 Cl8I7mlOfM20r9SPn7nf2CxODu6XUi/wGu20exhDi3oUcau7xnDSQ0iODQ7kdst05K
	 gR2jRtZSGrS7HW2AfaHR6Jozq4/HIhlroHZXrSUddCFzhNufbYdYIj6+S3xl6X/RN9
	 nMams/eh8ByCfBN3AiGXyzPlWYJLZtvx6kRPkapfT3er8mOvLf5jpU8+mipHtDyCrj
	 S1iuwgYqlPantKgqJwFubwnsXTDhSlEk5jZXesA7pjq+l84Uihnlvi1EiXOJaQb0QO
	 gySPz/Ncv0F8g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 08/15] net/mlx5: Remove redundant max_sfs check and field from struct mlx5_sf_dev_table
Date: Tue, 19 Sep 2023 23:35:45 -0700
Message-ID: <20230920063552.296978-9-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920063552.296978-1-saeed@kernel.org>
References: <20230920063552.296978-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

table->max_sfs is initialized in mlx5_sf_dev_table_create() and only
used to check for 0 in mlx5_sf_dev_add(). mlx5_sf_dev_add() is called
either from mlx5_sf_dev_state_change_handler() or
mlx5_sf_dev_add_active_work(). Both ensure max SF count is not 0,
using mlx5_sf_max_functions() helper before calling mlx5_sf_dev_add().

So remove the redundant check and no longer used max_sfs field.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c  | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
index 05e148db9889..0f9b280514b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
@@ -14,7 +14,6 @@
 
 struct mlx5_sf_dev_table {
 	struct xarray devices;
-	unsigned int max_sfs;
 	phys_addr_t base_address;
 	u64 sf_bar_length;
 	struct notifier_block nb;
@@ -110,12 +109,6 @@ static void mlx5_sf_dev_add(struct mlx5_core_dev *dev, u16 sf_index, u16 fn_id,
 	sf_dev->parent_mdev = dev;
 	sf_dev->fn_id = fn_id;
 
-	if (!table->max_sfs) {
-		mlx5_adev_idx_free(id);
-		kfree(sf_dev);
-		err = -EOPNOTSUPP;
-		goto add_err;
-	}
 	sf_dev->bar_base_addr = table->base_address + (sf_index * table->sf_bar_length);
 
 	trace_mlx5_sf_dev_add(dev, sf_dev, id);
@@ -296,7 +289,6 @@ static void mlx5_sf_dev_destroy_active_work(struct mlx5_sf_dev_table *table)
 void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sf_dev_table *table;
-	unsigned int max_sfs;
 	int err;
 
 	if (!mlx5_sf_dev_supported(dev))
@@ -310,13 +302,8 @@ void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
 
 	table->nb.notifier_call = mlx5_sf_dev_state_change_handler;
 	table->dev = dev;
-	if (MLX5_CAP_GEN(dev, max_num_sf))
-		max_sfs = MLX5_CAP_GEN(dev, max_num_sf);
-	else
-		max_sfs = 1 << MLX5_CAP_GEN(dev, log_max_sf);
 	table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);
 	table->base_address = pci_resource_start(dev->pdev, 2);
-	table->max_sfs = max_sfs;
 	xa_init(&table->devices);
 	mutex_init(&table->table_lock);
 	dev->priv.sf_dev_table = table;
@@ -332,7 +319,6 @@ void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
 	err = mlx5_sf_dev_vhca_arm_all(table);
 	if (err)
 		goto arm_err;
-	mlx5_core_dbg(dev, "SF DEV: max sf devices=%d\n", max_sfs);
 	return;
 
 arm_err:
@@ -340,7 +326,6 @@ void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
 add_active_err:
 	mlx5_vhca_event_notifier_unregister(dev, &table->nb);
 vhca_err:
-	table->max_sfs = 0;
 	kfree(table);
 	dev->priv.sf_dev_table = NULL;
 table_err:
-- 
2.41.0


