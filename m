Return-Path: <netdev+bounces-22814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF92769562
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762BB281481
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E24182B2;
	Mon, 31 Jul 2023 11:58:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DC182A9
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C884C433C8;
	Mon, 31 Jul 2023 11:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690804735;
	bh=jr3ZhzRljgnDotQCq5tm34v0vvEFvbPYFxSReizMdOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aiQHR0Mmho9vETv1qUeOywFsijNFXuD7MoE5p6KWUBSRsAfpGCmhdRYkTdcj+vsBE
	 8V6yd3p7DiKuJkyFau5X7QrtbapblrxBh8GrYRvxHtyBtO22Yt1Izscc+Mgkron5xU
	 xpbe2t32NOW2yuOVXvAPXU4SuqA2eyQLsUDLqJA/3piZGBV45QhryN9jZ38vedm0vP
	 9sBmd77bypml2kvORJoatsNDxw5Lu74kVwYTXTisLGO7oibFB8IlPYpsgza1lZ2YHg
	 u4FJ+rl4X28wJdk+7Ec8xDgF4ZS68b3f48tk6X/fuH0uEOwvQ3pUjcRsx5yemUhxcG
	 a4ydT9X/aPqTg==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Paul Blakey <paulb@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net 2/3] net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_prio
Date: Mon, 31 Jul 2023 14:58:41 +0300
Message-ID: <7a95754df479e722038996c97c97b062b372591f.1690803944.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690803944.git.leonro@nvidia.com>
References: <cover.1690803944.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

In the cited commit, new type of FS_TYPE_PRIO_CHAINS fs_prio was added
to support multiple parallel namespaces for multi-chains. And we skip
all the flow tables under the fs_node of this type unconditionally,
when searching for the next or previous flow table to connect for a
new table.

As this search function is also used for find new root table when the
old one is being deleted, it will skip the entire FS_TYPE_PRIO_CHAINS
fs_node next to the old root. However, new root table should be chosen
from it if there is any table in it. Fix it by skipping only the flow
tables in the same FS_TYPE_PRIO_CHAINS fs_node when finding the
closest FT for a fs_node.

Besides, complete the connecting from FTs of previous priority of prio
because there should be multiple prevs after this fs_prio type is
introduced. And also the next FT should be chosen from the first flow
table next to the prio in the same FS_TYPE_PRIO_CHAINS fs_prio, if
this prio is the first child.

Fixes: 328edb499f99 ("net/mlx5: Split FDB fast path prio to multiple namespaces")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Paul Blakey <paulb@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 80 +++++++++++++++++--
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 221723694d44..6b069fa411c5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -889,7 +889,7 @@ static struct mlx5_flow_table *find_closest_ft_recursive(struct fs_node  *root,
 	struct fs_node *iter = list_entry(start, struct fs_node, list);
 	struct mlx5_flow_table *ft = NULL;
 
-	if (!root || root->type == FS_TYPE_PRIO_CHAINS)
+	if (!root)
 		return NULL;
 
 	list_for_each_advance_continue(iter, &root->children, reverse) {
@@ -905,19 +905,42 @@ static struct mlx5_flow_table *find_closest_ft_recursive(struct fs_node  *root,
 	return ft;
 }
 
+static struct fs_node *find_prio_chains_parent(struct fs_node *parent,
+					       struct fs_node **child)
+{
+	struct fs_node *node = NULL;
+
+	while (parent && parent->type != FS_TYPE_PRIO_CHAINS) {
+		node = parent;
+		parent = parent->parent;
+	}
+
+	if (child)
+		*child = node;
+
+	return parent;
+}
+
 /* If reverse is false then return the first flow table next to the passed node
  * in the tree, else return the last flow table before the node in the tree.
+ * If skip is true, skip the flow tables in the same prio_chains prio.
  */
-static struct mlx5_flow_table *find_closest_ft(struct fs_node *node, bool reverse)
+static struct mlx5_flow_table *find_closest_ft(struct fs_node *node, bool reverse,
+					       bool skip)
 {
+	struct fs_node *prio_chains_parent = NULL;
 	struct mlx5_flow_table *ft = NULL;
 	struct fs_node *curr_node;
 	struct fs_node *parent;
 
+	if (skip)
+		prio_chains_parent = find_prio_chains_parent(node, NULL);
 	parent = node->parent;
 	curr_node = node;
 	while (!ft && parent) {
-		ft = find_closest_ft_recursive(parent, &curr_node->list, reverse);
+		if (parent != prio_chains_parent)
+			ft = find_closest_ft_recursive(parent, &curr_node->list,
+						       reverse);
 		curr_node = parent;
 		parent = curr_node->parent;
 	}
@@ -927,13 +950,13 @@ static struct mlx5_flow_table *find_closest_ft(struct fs_node *node, bool revers
 /* Assuming all the tree is locked by mutex chain lock */
 static struct mlx5_flow_table *find_next_chained_ft(struct fs_node *node)
 {
-	return find_closest_ft(node, false);
+	return find_closest_ft(node, false, true);
 }
 
 /* Assuming all the tree is locked by mutex chain lock */
 static struct mlx5_flow_table *find_prev_chained_ft(struct fs_node *node)
 {
-	return find_closest_ft(node, true);
+	return find_closest_ft(node, true, true);
 }
 
 static struct mlx5_flow_table *find_next_fwd_ft(struct mlx5_flow_table *ft,
@@ -969,21 +992,55 @@ static int connect_fts_in_prio(struct mlx5_core_dev *dev,
 	return 0;
 }
 
+static struct mlx5_flow_table *find_closet_ft_prio_chains(struct fs_node *node,
+							  struct fs_node *parent,
+							  struct fs_node **child,
+							  bool reverse)
+{
+	struct mlx5_flow_table *ft;
+
+	ft = find_closest_ft(node, reverse, false);
+
+	if (ft && parent == find_prio_chains_parent(&ft->node, child))
+		return ft;
+
+	return NULL;
+}
+
 /* Connect flow tables from previous priority of prio to ft */
 static int connect_prev_fts(struct mlx5_core_dev *dev,
 			    struct mlx5_flow_table *ft,
 			    struct fs_prio *prio)
 {
+	struct fs_node *prio_parent, *parent = NULL, *child, *node;
 	struct mlx5_flow_table *prev_ft;
+	int err = 0;
+
+	prio_parent = find_prio_chains_parent(&prio->node, &child);
+
+	/* return directly if not under the first sub ns of prio_chains prio */
+	if (prio_parent && !list_is_first(&child->list, &prio_parent->children))
+		return 0;
 
 	prev_ft = find_prev_chained_ft(&prio->node);
-	if (prev_ft) {
+	while (prev_ft) {
 		struct fs_prio *prev_prio;
 
 		fs_get_obj(prev_prio, prev_ft->node.parent);
-		return connect_fts_in_prio(dev, prev_prio, ft);
+		err = connect_fts_in_prio(dev, prev_prio, ft);
+		if (err)
+			break;
+
+		if (!parent) {
+			parent = find_prio_chains_parent(&prev_prio->node, &child);
+			if (!parent)
+				break;
+		}
+
+		node = child;
+		prev_ft = find_closet_ft_prio_chains(node, parent, &child, true);
 	}
-	return 0;
+	return err;
 }
 
 static int update_root_ft_create(struct mlx5_flow_table *ft, struct fs_prio
@@ -2194,12 +2251,19 @@ EXPORT_SYMBOL(mlx5_del_flow_rules);
 /* Assuming prio->node.children(flow tables) is sorted by level */
 static struct mlx5_flow_table *find_next_ft(struct mlx5_flow_table *ft)
 {
+	struct fs_node *prio_parent, *child;
 	struct fs_prio *prio;
 
 	fs_get_obj(prio, ft->node.parent);
 
 	if (!list_is_last(&ft->node.list, &prio->node.children))
 		return list_next_entry(ft, node.list);
+
+	prio_parent = find_prio_chains_parent(&prio->node, &child);
+
+	if (prio_parent && list_is_first(&child->list, &prio_parent->children))
+		return find_closest_ft(&prio->node, false, false);
+
 	return find_next_chained_ft(&prio->node);
 }
 
-- 
2.41.0


