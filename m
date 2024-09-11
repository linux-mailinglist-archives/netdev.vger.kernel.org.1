Return-Path: <netdev+bounces-127559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9EC975B98
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72BB0B21433
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701A51BD007;
	Wed, 11 Sep 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkbDNQya"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A01BD003
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085894; cv=none; b=IKgoi9qpTtzDet9+2GMZjyOzNLwnYZqgLrXutxfW5za+TsjDbriBG6omGWAy4lGS+Rou7f1xoRBGsq077clKfM1cnu5g+ivGXjylDrJXiTPWa7MSxRCY1lAVcQOcjiEB8gB7RsryDmqMMeYp73Zq3I8ljYuMu5HmBmCoNtdpRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085894; c=relaxed/simple;
	bh=iReeQ1MWW8aa8CQ1+EqXzTjHyb4SxjnRkfOkAnmm3x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ2pMpnJ0o5Kjx2+2gCtExbLbvLuIqIZSmzLFqEmW2EGEi4CBREijcX1NrF7PeSymlMLgH/wH1V71SitFgPcuahFKM7iCIhxnXMvEnTnbD6iPfQdMjWuJ/jrKPjFQlC6CDrtpENuHpdNi8lbPiZPSU/dlDLtHqSaklRCDaj3Eiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkbDNQya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A786AC4CECC;
	Wed, 11 Sep 2024 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085893;
	bh=iReeQ1MWW8aa8CQ1+EqXzTjHyb4SxjnRkfOkAnmm3x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZkbDNQyaoLNsJtj6frtva0LnRlgdgu6veLV3QKemqnjWtBuL2i8sprXCVG3x8Z7QW
	 O7caQg/oUuqL8dl2F1KPhopUDZ3lx9yqod71lf9FlemEPCEc7Jh0dB3RjS2bqydAzJ
	 EHDMKcIhqd4MTn5IjYovrzHloDgYVwIDtfCQXy61GC+pMef6Ocd1AjOYHNmF1wnlf5
	 0woll3o/Pspo0Xmpy3vOfXs8oBFTA7QIta4YYBfDdLR2Hp7H9f8B7ah9OggRPlqEST
	 o32sD3BT1XnXI5039JkiAvMV0kgeL2xVsk4wO70Ki36w3Qi6PQZhzRrLS7379KlYc+
	 lDBVRmfMtcsPw==
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
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next 15/15] net/mlx5e: Match cleanup order in mlx5e_free_rq in reverse of mlx5e_alloc_rq
Date: Wed, 11 Sep 2024 13:17:57 -0700
Message-ID: <20240911201757.1505453-16-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

mlx5e_free_rq previously cleaned resources in an order that was not the
reverse of the resource allocation order in mlx5e_alloc_rq.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 47e7a80d221b..a5659c0c4236 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1016,30 +1016,31 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 
 static void mlx5e_free_rq(struct mlx5e_rq *rq)
 {
-	struct bpf_prog *old_prog;
-
-	if (xdp_rxq_info_is_reg(&rq->xdp_rxq)) {
-		old_prog = rcu_dereference_protected(rq->xdp_prog,
-						     lockdep_is_held(&rq->priv->state_lock));
-		if (old_prog)
-			bpf_prog_put(old_prog);
-	}
+	kvfree(rq->dim);
+	page_pool_destroy(rq->page_pool);
 
 	switch (rq->wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
+		mlx5e_rq_free_shampo(rq);
 		kvfree(rq->mpwqe.info);
 		mlx5_core_destroy_mkey(rq->mdev, be32_to_cpu(rq->mpwqe.umr_mkey_be));
 		mlx5e_free_mpwqe_rq_drop_page(rq);
-		mlx5e_rq_free_shampo(rq);
 		break;
 	default: /* MLX5_WQ_TYPE_CYCLIC */
 		mlx5e_free_wqe_alloc_info(rq);
 	}
 
-	kvfree(rq->dim);
-	xdp_rxq_info_unreg(&rq->xdp_rxq);
-	page_pool_destroy(rq->page_pool);
 	mlx5_wq_destroy(&rq->wq_ctrl);
+
+	if (xdp_rxq_info_is_reg(&rq->xdp_rxq)) {
+		struct bpf_prog *old_prog;
+
+		old_prog = rcu_dereference_protected(rq->xdp_prog,
+						     lockdep_is_held(&rq->priv->state_lock));
+		if (old_prog)
+			bpf_prog_put(old_prog);
+	}
+	xdp_rxq_info_unreg(&rq->xdp_rxq);
 }
 
 int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *param, u16 q_counter)
-- 
2.46.0


