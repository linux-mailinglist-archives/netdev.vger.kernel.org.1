Return-Path: <netdev+bounces-27498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE077C297
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00BC1C20AA4
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631FC1078F;
	Mon, 14 Aug 2023 21:41:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A881100CB
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16FCC433B8;
	Mon, 14 Aug 2023 21:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049318;
	bh=XEZc7c3nGYaImUIDJVMvY639ZRyhHoOVWeGO+V9tei0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2A3+fHwtjjIIqNNevDqD9R7Fz2agr9vHtqUC6Xu4iOOc+E4hM7BUoR9AyVbQoJYG
	 OTNR9DnAguJej4E3Yv+a91l2bMx08mPF0EcdbnlHQjHvLJ1lqlcgeyt+uJQgl3cCZE
	 5hhqbH+dVZHqgd48t+mCjtRnlGZvJz4BlvZrBaQfmP8Si+Rr1xO2Sfl37g1PrIuhih
	 lD91ln6r77O7rnbBHU4fatAQgzenPKaXHG5Nw7AMfr6+MocKiuZb0UZvLutn6qHfOG
	 szj+RK+BaXBoHVkwkABvhZM0N8vZupMKmENWz0rD3DNnL5xWcOC94bQZ5jREMNxfRH
	 o0VnYcowOLbGA==
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
Subject: [net-next 09/14] net/mlx5: Use mlx5_sf_start_function_id() helper instead of directly calling MLX5_CAP_GEN()
Date: Mon, 14 Aug 2023 14:41:39 -0700
Message-ID: <20230814214144.159464-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214144.159464-1-saeed@kernel.org>
References: <20230814214144.159464-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

There is a helper called mlx5_sf_start_function_id() that
wraps up a query to get base SF function id. Use that instead of
calling MLX5_CAP_GEN() directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
index b2c849b8c0c9..39132a6cc68b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
@@ -167,7 +167,7 @@ mlx5_sf_dev_state_change_handler(struct notifier_block *nb, unsigned long event_
 	if (!max_functions)
 		return 0;
 
-	base_id = MLX5_CAP_GEN(table->dev, sf_base_id);
+	base_id = mlx5_sf_start_function_id(table->dev);
 	if (event->function_id < base_id || event->function_id >= (base_id + max_functions))
 		return 0;
 
@@ -209,7 +209,7 @@ static int mlx5_sf_dev_vhca_arm_all(struct mlx5_sf_dev_table *table)
 	int i;
 
 	max_functions = mlx5_sf_max_functions(dev);
-	function_id = MLX5_CAP_GEN(dev, sf_base_id);
+	function_id = mlx5_sf_start_function_id(dev);
 	/* Arm the vhca context as the vhca event notifier */
 	for (i = 0; i < max_functions; i++) {
 		err = mlx5_vhca_event_arm(dev, function_id);
@@ -234,7 +234,7 @@ static void mlx5_sf_dev_add_active_work(struct work_struct *work)
 	int i;
 
 	max_functions = mlx5_sf_max_functions(dev);
-	function_id = MLX5_CAP_GEN(dev, sf_base_id);
+	function_id = mlx5_sf_start_function_id(dev);
 	for (i = 0; i < max_functions; i++, function_id++) {
 		if (table->stop_active_wq)
 			return;
-- 
2.41.0


