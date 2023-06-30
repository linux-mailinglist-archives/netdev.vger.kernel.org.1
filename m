Return-Path: <netdev+bounces-14864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F2074420C
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 20:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EF81C20BA3
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B417ABC;
	Fri, 30 Jun 2023 18:15:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6671C17AA7
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 18:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2161FC43215;
	Fri, 30 Jun 2023 18:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688148954;
	bh=3dtLflWcXOJzUJkRAOfeFiPylknrvKBXexBdUvJfqZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjW7lOtsWvSZKMvvEoLrbQVhVkoI1+DKBIgA09MPTVGuqQ0cqmW1ZWmYoa+w5X32u
	 20y3VQchAqG8qB0SnRaTg13WZLPsdavhZojUkAKyZkWkG04Xfxn25q7C57ooVyI3cb
	 yaLaMDCAhqGI7IE3AFUi9YRRISHzI45TTg7j/ChdFY1MDaj8ZUuBaKvj4np+MrTDNl
	 5i6BHLwCtzUXM0Dr95vTPnVAquDeQFFMSDtmZKDw8InU45Diy9aPHDUKmjBCbDYoDB
	 J4OWmaLVIcTKpG1orym+4Vjr0CMEIMsSw4pqrSgNyhfqDqlLQn3vRA8sv55bhFGF6q
	 2vkY3HRfVwMDw==
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
Subject: [net 7/9] net/mlx5e: TC, CT: Offload ct clear only once
Date: Fri, 30 Jun 2023 11:15:42 -0700
Message-ID: <20230630181544.82958-8-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630181544.82958-1-saeed@kernel.org>
References: <20230630181544.82958-1-saeed@kernel.org>
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


