Return-Path: <netdev+bounces-35121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE40D7A72DB
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E241C20832
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531157497;
	Wed, 20 Sep 2023 06:36:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DAB747B
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B79C433C7;
	Wed, 20 Sep 2023 06:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191761;
	bh=yNqS0lHPUy3893jAU/ldlUiTtu911ksJ68gIhhPieuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZMwuxF7IzPrVXT6TeAeCm/YEVk7Vf9fdNiTmc2Hd/B8BPErHriUT0IGa7yC5HTaT
	 wdYoOoihwOXgFssbgjbkPUeqUAvHYB/sS8qCKYgu93hX5m1zlgLC3Lb2j5WrR+kwO8
	 TKyrpCtweCVzyftAe0rEvl8WTRlcjDKaV/UuNRpDN59XANk8AQRzwDYTnapNQqXHku
	 w5kevgApRhRey3Gf5wdgkFkhsS3oPhE0VeajBprs5vWRpi47PlALfdo7W1oyH/vw9A
	 UgdM6j9RuA1mLrJW0rpGv1c/falf6rpqA8NGzKFeYtCYekcGxSwU9cBv3VqJmqsGTb
	 pOeCcRxwTr/6g==
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
Subject: [net-next 03/15] net/mlx5: Convert SF port_indices xarray to function_ids xarray
Date: Tue, 19 Sep 2023 23:35:40 -0700
Message-ID: <20230920063552.296978-4-saeed@kernel.org>
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

No need to lookup for sf by a port index. Convert the xarray to have
function id as an index and optimize the remaining function id
based lookup.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  | 29 +++++++------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index b4a373d2ba15..78cdfe595a01 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -29,7 +29,7 @@ static void *mlx5_sf_by_dl_port(struct devlink_port *dl_port)
 
 struct mlx5_sf_table {
 	struct mlx5_core_dev *dev; /* To refer from notifier context. */
-	struct xarray port_indices; /* port index based lookup. */
+	struct xarray function_ids; /* function id based lookup. */
 	refcount_t refcount;
 	struct completion disable_complete;
 	struct mutex sf_state_lock; /* Serializes sf state among user cmds & vhca event handler. */
@@ -41,24 +41,17 @@ struct mlx5_sf_table {
 static struct mlx5_sf *
 mlx5_sf_lookup_by_function_id(struct mlx5_sf_table *table, unsigned int fn_id)
 {
-	unsigned long index;
-	struct mlx5_sf *sf;
-
-	xa_for_each(&table->port_indices, index, sf) {
-		if (sf->hw_fn_id == fn_id)
-			return sf;
-	}
-	return NULL;
+	return xa_load(&table->function_ids, fn_id);
 }
 
-static int mlx5_sf_id_insert(struct mlx5_sf_table *table, struct mlx5_sf *sf)
+static int mlx5_sf_function_id_insert(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 {
-	return xa_insert(&table->port_indices, sf->port_index, sf, GFP_KERNEL);
+	return xa_insert(&table->function_ids, sf->hw_fn_id, sf, GFP_KERNEL);
 }
 
-static void mlx5_sf_id_erase(struct mlx5_sf_table *table, struct mlx5_sf *sf)
+static void mlx5_sf_function_id_erase(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 {
-	xa_erase(&table->port_indices, sf->port_index);
+	xa_erase(&table->function_ids, sf->hw_fn_id);
 }
 
 static struct mlx5_sf *
@@ -95,7 +88,7 @@ mlx5_sf_alloc(struct mlx5_sf_table *table, struct mlx5_eswitch *esw,
 	sf->hw_state = MLX5_VHCA_STATE_ALLOCATED;
 	sf->controller = controller;
 
-	err = mlx5_sf_id_insert(table, sf);
+	err = mlx5_sf_function_id_insert(table, sf);
 	if (err)
 		goto insert_err;
 
@@ -348,7 +341,7 @@ int mlx5_devlink_sf_port_new(struct devlink *devlink,
 
 static void mlx5_sf_dealloc(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 {
-	mlx5_sf_id_erase(table, sf);
+	mlx5_sf_function_id_erase(table, sf);
 
 	if (sf->hw_state == MLX5_VHCA_STATE_ALLOCATED) {
 		mlx5_sf_free(table, sf);
@@ -452,7 +445,7 @@ static void mlx5_sf_deactivate_all(struct mlx5_sf_table *table)
 	/* At this point, no new user commands can start and no vhca event can
 	 * arrive. It is safe to destroy all user created SFs.
 	 */
-	xa_for_each(&table->port_indices, index, sf) {
+	xa_for_each(&table->function_ids, index, sf) {
 		mlx5_eswitch_unload_sf_vport(esw, sf->hw_fn_id);
 		mlx5_sf_dealloc(table, sf);
 	}
@@ -540,7 +533,7 @@ int mlx5_sf_table_init(struct mlx5_core_dev *dev)
 
 	mutex_init(&table->sf_state_lock);
 	table->dev = dev;
-	xa_init(&table->port_indices);
+	xa_init(&table->function_ids);
 	dev->priv.sf_table = table;
 	refcount_set(&table->refcount, 0);
 	table->esw_nb.notifier_call = mlx5_sf_esw_event;
@@ -579,6 +572,6 @@ void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 	mlx5_esw_event_notifier_unregister(dev->priv.eswitch, &table->esw_nb);
 	WARN_ON(refcount_read(&table->refcount));
 	mutex_destroy(&table->sf_state_lock);
-	WARN_ON(!xa_empty(&table->port_indices));
+	WARN_ON(!xa_empty(&table->function_ids));
 	kfree(table);
 }
-- 
2.41.0


