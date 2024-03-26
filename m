Return-Path: <netdev+bounces-82121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739AF88C592
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD5CB255B3
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5513C808;
	Tue, 26 Mar 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqLPRi9+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA6513C3EB
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464419; cv=none; b=LazMzGY0jbMFpWKFvkBjdROGCxBnvM8gW0PO1qJzF8UXajwF3oGKhYACpMVqRwyg+HTOSXSduJ1ZQPuClasK8MDqSshzBQP0VvsS7u4osydr/kopyYWwoS52k8Qc7tPc0w3x5aZiWoCeThj9kOl0UlqZaLeS/BiSs0slaxrwepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464419; c=relaxed/simple;
	bh=lmaJt2nwjSsfM3LN46WStqi6lUZAUyBVUkbOtZppF+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qf6YD4HCFNCYFwjJq57KE6i1v5ikDQFi+yACokfG7vIVImMBWJYSR5vYp3O07T7b6/G4WxgocKTzngdtBlJRV0U4kOZkzwzXu+omPaD6wq9oTTcBkTZ2RDAwTCmhua4uUfMhXZZCACSblrVR05zEizgO4nENZVsc4d3GTkaJZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqLPRi9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D867C43394;
	Tue, 26 Mar 2024 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464419;
	bh=lmaJt2nwjSsfM3LN46WStqi6lUZAUyBVUkbOtZppF+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqLPRi9+/mFhu/E4B1qJwWxn78b6cXsdJkPDfjWLEMlOUo8hpK6hufp2gpkG3Ls1o
	 LhwR+u+8waYzTSRqK9UkyBCiHSd7guNw8Pbr+YtrTrx9c8NJ7DuVNu1vIs8kjMhwY9
	 M2gNnLc/uNJ6JdNYaW/ALMYB8zH0W785u7AASUM9nFY4oqo/eEFfXuInMr4CX3BfDb
	 m9wTmlY0vuREyVdyci8tvTBKnoMdQksmGPSxpJCyfomjTPoq0Iu9TTLSZ2fCBl7vXs
	 X4h07X0Cb1meLvieL31esbkdzwSg/Ph6woiL0kCpGvSE061qHUv+WN1qsIsOs12J/v
	 cArVTQMQsjkKg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [net 04/10] net/mlx5: Properly link new fs rules into the tree
Date: Tue, 26 Mar 2024 07:46:40 -0700
Message-ID: <20240326144646.2078893-5-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326144646.2078893-1-saeed@kernel.org>
References: <20240326144646.2078893-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cosmin Ratiu <cratiu@nvidia.com>

Previously, add_rule_fg would only add newly created rules from the
handle into the tree when they had a refcount of 1. On the other hand,
create_flow_handle tries hard to find and reference already existing
identical rules instead of creating new ones.

These two behaviors can result in a situation where create_flow_handle
1) creates a new rule and references it, then
2) in a subsequent step during the same handle creation references it
   again,
resulting in a rule with a refcount of 2 that is not linked into the
tree, will have a NULL parent and root and will result in a crash when
the flow group is deleted because del_sw_hw_rule, invoked on rule
deletion, assumes node->parent is != NULL.

This happened in the wild, due to another bug related to incorrect
handling of duplicate pkt_reformat ids, which lead to the code in
create_flow_handle incorrectly referencing a just-added rule in the same
flow handle, resulting in the problem described above. Full details are
at [1].

This patch changes add_rule_fg to add new rules without parents into
the tree, properly initializing them and avoiding the crash. This makes
it more consistent with how rules are added to an FTE in
create_flow_handle.

Fixes: 74491de93712 ("net/mlx5: Add multi dest support")
Link: https://lore.kernel.org/netdev/ea5264d6-6b55-4449-a602-214c6f509c1e@163.com/T/#u [1]
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index e6bfa7e4f146..2a9421342a50 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1808,8 +1808,9 @@ static struct mlx5_flow_handle *add_rule_fg(struct mlx5_flow_group *fg,
 	}
 	trace_mlx5_fs_set_fte(fte, false);
 
+	/* Link newly added rules into the tree. */
 	for (i = 0; i < handle->num_rules; i++) {
-		if (refcount_read(&handle->rule[i]->node.refcount) == 1) {
+		if (!handle->rule[i]->node.parent) {
 			tree_add_node(&handle->rule[i]->node, &fte->node);
 			trace_mlx5_fs_add_rule(handle->rule[i]);
 		}
-- 
2.44.0


