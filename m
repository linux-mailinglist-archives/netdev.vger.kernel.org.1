Return-Path: <netdev+bounces-22813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31192769561
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BD91C20929
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8200D182A8;
	Mon, 31 Jul 2023 11:58:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19267182B2
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54955C433C9;
	Mon, 31 Jul 2023 11:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690804731;
	bh=pQ9fFT+LtWPPtGQDk9LYQtmaQMxUU3QWsavkrjHGXIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIiCGMaRqL4mcwwHSBic8yhvuVkSpOILOIlfGF26bFHIlz4hO61Q5o1FgVV75V8Qr
	 XtNqsIjOhRk/Aa6aZ6NXd4Ma6WkjgnFLQ2P/968a1XV/u0GTvXxJnUqdDzVK7UmaB3
	 /2YurIZX/GDliqqGmpvmIa/Ay4mCLCi21jP0eHN6ohkBURf8/aYSuBFZvSiWrxyweI
	 0doFfkyNMgzZ0VP1KpfsKHbst6jcCw5opQW5gUGXna9FC3hNDaiYSVyXb7QvX5idG2
	 2NYFhlEuNniN3zJonZguS6obYvu/W+xC58u1UC4mIfjfG0yy2UvsjXsE+Xs2Ur/nJJ
	 T1Ecu+Nz2Yn6g==
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
Subject: [PATCH net 1/3] net/mlx5: fs_core: Make find_closest_ft more generic
Date: Mon, 31 Jul 2023 14:58:40 +0300
Message-ID: <d3962c2b443ec8dde7a740dc742a1f052d5e256c.1690803944.git.leonro@nvidia.com>
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

As find_closest_ft_recursive is called to find the closest FT, the
first parameter of find_closest_ft can be changed from fs_prio to
fs_node. Thus this function is extended to find the closest FT for the
nodes of any type, not only prios, but also the sub namespaces.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index b4eb27e7f28b..221723694d44 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -905,18 +905,17 @@ static struct mlx5_flow_table *find_closest_ft_recursive(struct fs_node  *root,
 	return ft;
 }
 
-/* If reverse is false then return the first flow table in next priority of
- * prio in the tree, else return the last flow table in the previous priority
- * of prio in the tree.
+/* If reverse is false then return the first flow table next to the passed node
+ * in the tree, else return the last flow table before the node in the tree.
  */
-static struct mlx5_flow_table *find_closest_ft(struct fs_prio *prio, bool reverse)
+static struct mlx5_flow_table *find_closest_ft(struct fs_node *node, bool reverse)
 {
 	struct mlx5_flow_table *ft = NULL;
 	struct fs_node *curr_node;
 	struct fs_node *parent;
 
-	parent = prio->node.parent;
-	curr_node = &prio->node;
+	parent = node->parent;
+	curr_node = node;
 	while (!ft && parent) {
 		ft = find_closest_ft_recursive(parent, &curr_node->list, reverse);
 		curr_node = parent;
@@ -926,15 +925,15 @@ static struct mlx5_flow_table *find_closest_ft(struct fs_prio *prio, bool revers
 }
 
 /* Assuming all the tree is locked by mutex chain lock */
-static struct mlx5_flow_table *find_next_chained_ft(struct fs_prio *prio)
+static struct mlx5_flow_table *find_next_chained_ft(struct fs_node *node)
 {
-	return find_closest_ft(prio, false);
+	return find_closest_ft(node, false);
 }
 
 /* Assuming all the tree is locked by mutex chain lock */
-static struct mlx5_flow_table *find_prev_chained_ft(struct fs_prio *prio)
+static struct mlx5_flow_table *find_prev_chained_ft(struct fs_node *node)
 {
-	return find_closest_ft(prio, true);
+	return find_closest_ft(node, true);
 }
 
 static struct mlx5_flow_table *find_next_fwd_ft(struct mlx5_flow_table *ft,
@@ -946,7 +945,7 @@ static struct mlx5_flow_table *find_next_fwd_ft(struct mlx5_flow_table *ft,
 	next_ns = flow_act->action & MLX5_FLOW_CONTEXT_ACTION_FWD_NEXT_NS;
 	fs_get_obj(prio, next_ns ? ft->ns->node.parent : ft->node.parent);
 
-	return find_next_chained_ft(prio);
+	return find_next_chained_ft(&prio->node);
 }
 
 static int connect_fts_in_prio(struct mlx5_core_dev *dev,
@@ -977,7 +976,7 @@ static int connect_prev_fts(struct mlx5_core_dev *dev,
 {
 	struct mlx5_flow_table *prev_ft;
 
-	prev_ft = find_prev_chained_ft(prio);
+	prev_ft = find_prev_chained_ft(&prio->node);
 	if (prev_ft) {
 		struct fs_prio *prev_prio;
 
@@ -1123,7 +1122,7 @@ static int connect_flow_table(struct mlx5_core_dev *dev, struct mlx5_flow_table
 		if (err)
 			return err;
 
-		next_ft = first_ft ? first_ft : find_next_chained_ft(prio);
+		next_ft = first_ft ? first_ft : find_next_chained_ft(&prio->node);
 		err = connect_fwd_rules(dev, ft, next_ft);
 		if (err)
 			return err;
@@ -1198,7 +1197,7 @@ static struct mlx5_flow_table *__mlx5_create_flow_table(struct mlx5_flow_namespa
 
 	tree_init_node(&ft->node, del_hw_flow_table, del_sw_flow_table);
 	next_ft = unmanaged ? ft_attr->next_ft :
-			      find_next_chained_ft(fs_prio);
+			      find_next_chained_ft(&fs_prio->node);
 	ft->def_miss_action = ns->def_miss_action;
 	ft->ns = ns;
 	err = root->cmds->create_flow_table(root, ft, ft_attr, next_ft);
@@ -2201,7 +2200,7 @@ static struct mlx5_flow_table *find_next_ft(struct mlx5_flow_table *ft)
 
 	if (!list_is_last(&ft->node.list, &prio->node.children))
 		return list_next_entry(ft, node.list);
-	return find_next_chained_ft(prio);
+	return find_next_chained_ft(&prio->node);
 }
 
 static int update_root_ft_destroy(struct mlx5_flow_table *ft)
-- 
2.41.0


