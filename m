Return-Path: <netdev+bounces-82125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D2488C596
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249BD304889
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25DD13C80F;
	Tue, 26 Mar 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM36hn3y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4EF13C666
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464425; cv=none; b=nQLnzmbg190TJqcwPw232ACSwTYEeXjXTDB855jXYby/WhY5IdzHJzcg/TLZJuySIUXLnrSmk/dPcbhcG+cABFrpsx7qX3S6UJ8REoKG7rOvoFUBP/P8HLnK2w7ecs4H8WbmNwBCC/z06OL60trs/vX1NCo3lFz5CnVd6DD8Slw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464425; c=relaxed/simple;
	bh=WDSMVBdK4khOmOZqIo19jACc2yX49nOcGyxD1syaniE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QazQTPMyrK9br09Iqs7Fq8iKo1rvePbsrSWtW/7gFa9btW4NzO0+CIbV/5Efpd0K1fAj1ldG/MzGJ/aUhqZpfI/iXGeEX84E0zltgCVo0tdseSkcI29Tn6qKod3mhUgH6Ym/yNxqGev/aOp2sCbWtypBTaoCUiDzL7/T7XcngVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM36hn3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A69C433F1;
	Tue, 26 Mar 2024 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464425;
	bh=WDSMVBdK4khOmOZqIo19jACc2yX49nOcGyxD1syaniE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IM36hn3y1YcE5i/KX+/ITawzmW1Z+vxdwQpNIjou9GJinm7WsZJPuv3OcI3LG8ZP5
	 M9GtnlIqcRq47ogDTP7TDeWFT+xP6nSSqtw6g7UfRz+HHrx18B/5QIdqrYmIP2OIDn
	 mbMTdxyJJ1xZCEMpifrf1fjEPUMeS55jIzbPbTMFsJdG4cdNTzHdQTi0YAz4WvNt6E
	 diEfM1v8QmKzHc3DMtLBLa1VYvEO4FPANbT1wsalzOcQm+Vs/JLFiBKzykhhUC9Kr5
	 5QmsBBt9wUeJ+bb7KfnrIxs8y/UVl8Ca862dHY1mVtI9bjNvOiuHQtDpO9XHputf3F
	 uBnurKvc7VfXA==
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
	Carolina Jubran <cjubran@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net 08/10] net/mlx5e: HTB, Fix inconsistencies with QoS SQs number
Date: Tue, 26 Mar 2024 07:46:44 -0700
Message-ID: <20240326144646.2078893-9-saeed@kernel.org>
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

From: Carolina Jubran <cjubran@nvidia.com>

When creating a new HTB class while the interface is down,
the variable that follows the number of QoS SQs (htb_max_qos_sqs)
may not be consistent with the number of HTB classes.

Previously, we compared these two values to ensure that
the node_qid is lower than the number of QoS SQs, and we
allocated stats for that SQ when they are equal.

Change the check to compare the node_qid with the current
number of leaf nodes and fix the checking conditions to
ensure allocation of stats_list and stats for each node.

Fixes: 214baf22870c ("net/mlx5e: Support HTB offload")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  | 33 ++++++++++---------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index e87e26f2c669..6743806b8480 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -83,24 +83,25 @@ int mlx5e_open_qos_sq(struct mlx5e_priv *priv, struct mlx5e_channels *chs,
 
 	txq_ix = mlx5e_qid_from_qos(chs, node_qid);
 
-	WARN_ON(node_qid > priv->htb_max_qos_sqs);
-	if (node_qid == priv->htb_max_qos_sqs) {
-		struct mlx5e_sq_stats *stats, **stats_list = NULL;
-
-		if (priv->htb_max_qos_sqs == 0) {
-			stats_list = kvcalloc(mlx5e_qos_max_leaf_nodes(priv->mdev),
-					      sizeof(*stats_list),
-					      GFP_KERNEL);
-			if (!stats_list)
-				return -ENOMEM;
-		}
+	WARN_ON(node_qid >= mlx5e_htb_cur_leaf_nodes(priv->htb));
+	if (!priv->htb_qos_sq_stats) {
+		struct mlx5e_sq_stats **stats_list;
+
+		stats_list = kvcalloc(mlx5e_qos_max_leaf_nodes(priv->mdev),
+				      sizeof(*stats_list), GFP_KERNEL);
+		if (!stats_list)
+			return -ENOMEM;
+
+		WRITE_ONCE(priv->htb_qos_sq_stats, stats_list);
+	}
+
+	if (!priv->htb_qos_sq_stats[node_qid]) {
+		struct mlx5e_sq_stats *stats;
+
 		stats = kzalloc(sizeof(*stats), GFP_KERNEL);
-		if (!stats) {
-			kvfree(stats_list);
+		if (!stats)
 			return -ENOMEM;
-		}
-		if (stats_list)
-			WRITE_ONCE(priv->htb_qos_sq_stats, stats_list);
+
 		WRITE_ONCE(priv->htb_qos_sq_stats[node_qid], stats);
 		/* Order htb_max_qos_sqs increment after writing the array pointer.
 		 * Pairs with smp_load_acquire in en_stats.c.
-- 
2.44.0


