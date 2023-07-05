Return-Path: <netdev+bounces-15607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF48748B29
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881FA281098
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB7515487;
	Wed,  5 Jul 2023 17:58:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA3014AA1
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 17:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF09C433CC;
	Wed,  5 Jul 2023 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688579902;
	bh=3dtLflWcXOJzUJkRAOfeFiPylknrvKBXexBdUvJfqZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HY58Jp7I1v9N4etg78kb2t4nta4ARveY/YpzzZVMso4Th4cKGhvc42ibZBmC/UfJd
	 BarRtJufqgBwGgwTSvJlJUa1AvB25bqz9XkaUQlUmCt49O9nunnHcFfOf68f66bmA2
	 oefyuyhhGNx0VK0dTZdOehVVT1FKOOQjKbsU+hLct1ghojdC/ums3n11lkpl4hjG3X
	 cBpRroKS2J9eK1OKhMTPEsXF5O5yK/67t5WRV3MkAoCIhQSvVOzP7OpK524q7axVJb
	 JpH6Du0ZWZSNyNNP4etCxTHQka1JGGXk0Zu9ktQD0ah9N+g/bWdhXMhrVFzT0LkcVH
	 bkT1Ngnm2qPFg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Paul Blakey <paulb@nvidia.com>
Subject: [net V2 7/9] net/mlx5e: TC, CT: Offload ct clear only once
Date: Wed,  5 Jul 2023 10:57:55 -0700
Message-ID: <20230705175757.284614-8-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705175757.284614-1-saeed@kernel.org>
References: <20230705175757.284614-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Non-clear CT action causes a flow rule split, while CT clear action
doesn't and is just a header-rewrite to the current flow rule.
But ct offload is done in post_parse and is per ct action instance,
so ct clear offload is parsed multiple times, while its deleted once.

Fix this by post_parsing the ct action only once per flow attribute
(which is per flow rule) by using a offloaded ct_attr flag.

Fixes: 08fe94ec5f77 ("net/mlx5e: TC, Remove special handling of CT action")
Signed-off-by: Paul Blakey <paulb@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 14 +++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index a254e728ac95..fadfa8b50beb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -1545,7 +1545,8 @@ mlx5_tc_ct_parse_action(struct mlx5_tc_ct_priv *priv,
 
 	attr->ct_attr.ct_action |= act->ct.action; /* So we can have clear + ct */
 	attr->ct_attr.zone = act->ct.zone;
-	attr->ct_attr.nf_ft = act->ct.flow_table;
+	if (!(act->ct.action & TCA_CT_ACT_CLEAR))
+		attr->ct_attr.nf_ft = act->ct.flow_table;
 	attr->ct_attr.act_miss_cookie = act->miss_cookie;
 
 	return 0;
@@ -1990,6 +1991,9 @@ mlx5_tc_ct_flow_offload(struct mlx5_tc_ct_priv *priv, struct mlx5_flow_attr *att
 	if (!priv)
 		return -EOPNOTSUPP;
 
+	if (attr->ct_attr.offloaded)
+		return 0;
+
 	if (attr->ct_attr.ct_action & TCA_CT_ACT_CLEAR) {
 		err = mlx5_tc_ct_entry_set_registers(priv, &attr->parse_attr->mod_hdr_acts,
 						     0, 0, 0, 0);
@@ -1999,11 +2003,15 @@ mlx5_tc_ct_flow_offload(struct mlx5_tc_ct_priv *priv, struct mlx5_flow_attr *att
 		attr->action |= MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
 	}
 
-	if (!attr->ct_attr.nf_ft) /* means only ct clear action, and not ct_clear,ct() */
+	if (!attr->ct_attr.nf_ft) { /* means only ct clear action, and not ct_clear,ct() */
+		attr->ct_attr.offloaded = true;
 		return 0;
+	}
 
 	mutex_lock(&priv->control_lock);
 	err = __mlx5_tc_ct_flow_offload(priv, attr);
+	if (!err)
+		attr->ct_attr.offloaded = true;
 	mutex_unlock(&priv->control_lock);
 
 	return err;
@@ -2021,7 +2029,7 @@ void
 mlx5_tc_ct_delete_flow(struct mlx5_tc_ct_priv *priv,
 		       struct mlx5_flow_attr *attr)
 {
-	if (!attr->ct_attr.ft) /* no ct action, return */
+	if (!attr->ct_attr.offloaded) /* no ct action, return */
 		return;
 	if (!attr->ct_attr.nf_ft) /* means only ct clear action, and not ct_clear,ct() */
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h
index 8e9316fa46d4..b66c5f98067f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h
@@ -29,6 +29,7 @@ struct mlx5_ct_attr {
 	u32 ct_labels_id;
 	u32 act_miss_mapping;
 	u64 act_miss_cookie;
+	bool offloaded;
 	struct mlx5_ct_ft *ft;
 };
 
-- 
2.41.0


