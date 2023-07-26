Return-Path: <netdev+bounces-21640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DD6764143
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14473281E79
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1711CA1D;
	Wed, 26 Jul 2023 21:32:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B61C9E8
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8790AC433BD;
	Wed, 26 Jul 2023 21:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407141;
	bh=C95AFtXvhPYqZIYQdet/hoPNSjj7mMQz3iXHD1v0azM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXiJfPsBcKNDZkbv2E4iz5iHab/uLFxErlfsu2Gt7tu4NSZQYS6CzwmlknncqmRwl
	 3KG9ID0d3xZBysSI8IQpkAFk7TqyD9OnHyy7R2D1pLZGzHN8jaASBWMOmm6nCXbEUf
	 5YxYnqEx+cjVcEJXONgPRIi7XASWoeAQyuTV8royE1QtcCsp9sFKM8P3A/ac6Uoti/
	 7WBY7+jfaeYe0/Abi5reDFIwTfpnUrl1JmBZrrpK45v496mHy7IKJg9mF1nojtzGYD
	 rvNPVjkjqUijrasxMTDrTM2q6HiTj/EIXNvXvi6oAWflCt5Nx4fzpE0pN6JnKrTa6x
	 SysIEyfC2zJYQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Chris Mi <cmi@nvidia.com>,
	Paul Blakey <paulb@nvidia.com>,
	Roi Dayan <roid@nvidia.com>
Subject: [net 13/15] net/mlx5: fs_chains: Fix ft prio if ignore_flow_level is not supported
Date: Wed, 26 Jul 2023 14:32:04 -0700
Message-ID: <20230726213206.47022-14-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726213206.47022-1-saeed@kernel.org>
References: <20230726213206.47022-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mi <cmi@nvidia.com>

The cited commit sets ft prio to fs_base_prio. But if
ignore_flow_level it not supported, ft prio must be set based on
tc filter prio. Otherwise, all the ft prio are the same on the same
chain. It is invalid if ignore_flow_level is not supported.

Fix it by setting ft prio based on tc filter prio and setting
fs_base_prio to 0 for fdb.

Fixes: 8e80e5648092 ("net/mlx5: fs_chains: Refactor to detach chains from tc usage")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Paul Blakey <paulb@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 93b2b94d41cd..bc04abb31f9c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1436,7 +1436,6 @@ esw_chains_create(struct mlx5_eswitch *esw, struct mlx5_flow_table *miss_fdb)
 
 	esw_init_chains_offload_flags(esw, &attr.flags);
 	attr.ns = MLX5_FLOW_NAMESPACE_FDB;
-	attr.fs_base_prio = FDB_TC_OFFLOAD;
 	attr.max_grp_num = esw->params.large_group_num;
 	attr.default_ft = miss_fdb;
 	attr.mapping = esw->offloads.reg_c0_obj_pool;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
index db9df9798ffa..a80ecb672f33 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
@@ -178,7 +178,7 @@ mlx5_chains_create_table(struct mlx5_fs_chains *chains,
 	if (!mlx5_chains_ignore_flow_level_supported(chains) ||
 	    (chain == 0 && prio == 1 && level == 0)) {
 		ft_attr.level = chains->fs_base_level;
-		ft_attr.prio = chains->fs_base_prio;
+		ft_attr.prio = chains->fs_base_prio + prio - 1;
 		ns = (chains->ns == MLX5_FLOW_NAMESPACE_FDB) ?
 			mlx5_get_fdb_sub_ns(chains->dev, chain) :
 			mlx5_get_flow_namespace(chains->dev, chains->ns);
-- 
2.41.0


