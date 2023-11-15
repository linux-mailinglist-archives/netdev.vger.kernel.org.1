Return-Path: <netdev+bounces-47446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316607EA536
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0658280F5E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4B425115;
	Mon, 13 Nov 2023 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD97MtRB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F0250FB
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9186C433C9;
	Mon, 13 Nov 2023 21:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699909712;
	bh=AfViKGJrf6BUOsO8wIS7W406oI+prBnS0cPfJQF5weM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SD97MtRBWFZi3Lcm3r8jzO0aC6tTH6RJwZfpQ9WY6yyzqMnH3nbNEKeFROmsQ1JCQ
	 5nO6CTLbLAm0JVLeCUUuOaMWCsoLP6/ZuwNp7eL/TXY6LZmFHmsX4EBEMvsHIBpb4C
	 Yiz0d9sdaz5EvP3mvnR4Uxszfd/zf5EeVithJyu6RSVyQ+Qunx8bLcfc32PIePgP5G
	 fjgo7czlScSI6I/m3pbsgLqiPwVoCkCiC7mUJqbcbPx1JJAAju9+s/U7iUn0o0oyqz
	 tdRRFeM+9UcOZ74548uVGFbEKmh03JwYfrvEyLKTnKOjlK8tBjkXBxaMo2akFy9rqO
	 II1yF80hQiPYg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>
Subject: [net 01/17] Revert "net/mlx5: DR, Supporting inline WQE when possible"
Date: Mon, 13 Nov 2023 13:08:10 -0800
Message-ID: <20231113210826.47593-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113210826.47593-1-saeed@kernel.org>
References: <20231113210826.47593-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Itamar Gozlan <igozlan@nvidia.com>

This reverts commit 95c337cce0e11d06a715da73e6796ade9216637f.
The revert is required due to the suspicion it cause some tests
fail and will be moved to further investigation.

Fixes: 95c337cce0e1 ("net/mlx5: DR, Supporting inline WQE when possible")
Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/steering/dr_send.c     | 115 ++----------------
 1 file changed, 13 insertions(+), 102 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
index 4e8527a724f5..6fa06ba2d346 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
@@ -52,7 +52,6 @@ struct dr_qp_init_attr {
 	u32 cqn;
 	u32 pdn;
 	u32 max_send_wr;
-	u32 max_send_sge;
 	struct mlx5_uars_page *uar;
 	u8 isolate_vl_tc:1;
 };
@@ -247,37 +246,6 @@ static int dr_poll_cq(struct mlx5dr_cq *dr_cq, int ne)
 	return err == CQ_POLL_ERR ? err : npolled;
 }
 
-static int dr_qp_get_args_update_send_wqe_size(struct dr_qp_init_attr *attr)
-{
-	return roundup_pow_of_two(sizeof(struct mlx5_wqe_ctrl_seg) +
-				  sizeof(struct mlx5_wqe_flow_update_ctrl_seg) +
-				  sizeof(struct mlx5_wqe_header_modify_argument_update_seg));
-}
-
-/* We calculate for specific RC QP with the required functionality */
-static int dr_qp_calc_rc_send_wqe(struct dr_qp_init_attr *attr)
-{
-	int update_arg_size;
-	int inl_size = 0;
-	int tot_size;
-	int size;
-
-	update_arg_size = dr_qp_get_args_update_send_wqe_size(attr);
-
-	size = sizeof(struct mlx5_wqe_ctrl_seg) +
-	       sizeof(struct mlx5_wqe_raddr_seg);
-	inl_size = size + ALIGN(sizeof(struct mlx5_wqe_inline_seg) +
-				DR_STE_SIZE, 16);
-
-	size += attr->max_send_sge * sizeof(struct mlx5_wqe_data_seg);
-
-	size = max(size, update_arg_size);
-
-	tot_size = max(size, inl_size);
-
-	return ALIGN(tot_size, MLX5_SEND_WQE_BB);
-}
-
 static struct mlx5dr_qp *dr_create_rc_qp(struct mlx5_core_dev *mdev,
 					 struct dr_qp_init_attr *attr)
 {
@@ -285,7 +253,6 @@ static struct mlx5dr_qp *dr_create_rc_qp(struct mlx5_core_dev *mdev,
 	u32 temp_qpc[MLX5_ST_SZ_DW(qpc)] = {};
 	struct mlx5_wq_param wqp;
 	struct mlx5dr_qp *dr_qp;
-	int wqe_size;
 	int inlen;
 	void *qpc;
 	void *in;
@@ -365,15 +332,6 @@ static struct mlx5dr_qp *dr_create_rc_qp(struct mlx5_core_dev *mdev,
 	if (err)
 		goto err_in;
 	dr_qp->uar = attr->uar;
-	wqe_size = dr_qp_calc_rc_send_wqe(attr);
-	dr_qp->max_inline_data = min(wqe_size -
-				     (sizeof(struct mlx5_wqe_ctrl_seg) +
-				      sizeof(struct mlx5_wqe_raddr_seg) +
-				      sizeof(struct mlx5_wqe_inline_seg)),
-				     (2 * MLX5_SEND_WQE_BB -
-				      (sizeof(struct mlx5_wqe_ctrl_seg) +
-				       sizeof(struct mlx5_wqe_raddr_seg) +
-				       sizeof(struct mlx5_wqe_inline_seg))));
 
 	return dr_qp;
 
@@ -437,48 +395,8 @@ dr_rdma_handle_flow_access_arg_segments(struct mlx5_wqe_ctrl_seg *wq_ctrl,
 		MLX5_SEND_WQE_DS;
 }
 
-static int dr_set_data_inl_seg(struct mlx5dr_qp *dr_qp,
-			       struct dr_data_seg *data_seg, void *wqe)
-{
-	int inline_header_size = sizeof(struct mlx5_wqe_ctrl_seg) +
-				sizeof(struct mlx5_wqe_raddr_seg) +
-				sizeof(struct mlx5_wqe_inline_seg);
-	struct mlx5_wqe_inline_seg *seg;
-	int left_space;
-	int inl = 0;
-	void *addr;
-	int len;
-	int idx;
-
-	seg = wqe;
-	wqe += sizeof(*seg);
-	addr = (void *)(unsigned long)(data_seg->addr);
-	len  = data_seg->length;
-	inl += len;
-	left_space = MLX5_SEND_WQE_BB - inline_header_size;
-
-	if (likely(len > left_space)) {
-		memcpy(wqe, addr, left_space);
-		len -= left_space;
-		addr += left_space;
-		idx = (dr_qp->sq.pc + 1) & (dr_qp->sq.wqe_cnt - 1);
-		wqe = mlx5_wq_cyc_get_wqe(&dr_qp->wq.sq, idx);
-	}
-
-	memcpy(wqe, addr, len);
-
-	if (likely(inl)) {
-		seg->byte_count = cpu_to_be32(inl | MLX5_INLINE_SEG);
-		return DIV_ROUND_UP(inl + sizeof(seg->byte_count),
-				    MLX5_SEND_WQE_DS);
-	} else {
-		return 0;
-	}
-}
-
 static void
-dr_rdma_handle_icm_write_segments(struct mlx5dr_qp *dr_qp,
-				  struct mlx5_wqe_ctrl_seg *wq_ctrl,
+dr_rdma_handle_icm_write_segments(struct mlx5_wqe_ctrl_seg *wq_ctrl,
 				  u64 remote_addr,
 				  u32 rkey,
 				  struct dr_data_seg *data_seg,
@@ -494,17 +412,15 @@ dr_rdma_handle_icm_write_segments(struct mlx5dr_qp *dr_qp,
 	wq_raddr->reserved = 0;
 
 	wq_dseg = (void *)(wq_raddr + 1);
-	/* WQE ctrl segment + WQE remote addr segment */
-	*size = (sizeof(*wq_ctrl) + sizeof(*wq_raddr)) / MLX5_SEND_WQE_DS;
 
-	if (data_seg->send_flags & IB_SEND_INLINE) {
-		*size += dr_set_data_inl_seg(dr_qp, data_seg, wq_dseg);
-	} else {
-		wq_dseg->byte_count = cpu_to_be32(data_seg->length);
-		wq_dseg->lkey = cpu_to_be32(data_seg->lkey);
-		wq_dseg->addr = cpu_to_be64(data_seg->addr);
-		*size += sizeof(*wq_dseg) / MLX5_SEND_WQE_DS;  /* WQE data segment */
-	}
+	wq_dseg->byte_count = cpu_to_be32(data_seg->length);
+	wq_dseg->lkey = cpu_to_be32(data_seg->lkey);
+	wq_dseg->addr = cpu_to_be64(data_seg->addr);
+
+	*size = (sizeof(*wq_ctrl) +    /* WQE ctrl segment */
+		 sizeof(*wq_dseg) +    /* WQE data segment */
+		 sizeof(*wq_raddr)) /  /* WQE remote addr segment */
+		MLX5_SEND_WQE_DS;
 }
 
 static void dr_set_ctrl_seg(struct mlx5_wqe_ctrl_seg *wq_ctrl,
@@ -535,7 +451,7 @@ static void dr_rdma_segments(struct mlx5dr_qp *dr_qp, u64 remote_addr,
 	switch (opcode) {
 	case MLX5_OPCODE_RDMA_READ:
 	case MLX5_OPCODE_RDMA_WRITE:
-		dr_rdma_handle_icm_write_segments(dr_qp, wq_ctrl, remote_addr,
+		dr_rdma_handle_icm_write_segments(wq_ctrl, remote_addr,
 						  rkey, data_seg, &size);
 		break;
 	case MLX5_OPCODE_FLOW_TBL_ACCESS:
@@ -656,7 +572,7 @@ static void dr_fill_write_args_segs(struct mlx5dr_send_ring *send_ring,
 	if (send_ring->pending_wqe % send_ring->signal_th == 0)
 		send_info->write.send_flags |= IB_SEND_SIGNALED;
 	else
-		send_info->write.send_flags &= ~IB_SEND_SIGNALED;
+		send_info->write.send_flags = 0;
 }
 
 static void dr_fill_write_icm_segs(struct mlx5dr_domain *dmn,
@@ -680,13 +596,9 @@ static void dr_fill_write_icm_segs(struct mlx5dr_domain *dmn,
 	}
 
 	send_ring->pending_wqe++;
-	if (!send_info->write.lkey)
-		send_info->write.send_flags |= IB_SEND_INLINE;
 
 	if (send_ring->pending_wqe % send_ring->signal_th == 0)
 		send_info->write.send_flags |= IB_SEND_SIGNALED;
-	else
-		send_info->write.send_flags &= ~IB_SEND_SIGNALED;
 
 	send_ring->pending_wqe++;
 	send_info->read.length = send_info->write.length;
@@ -696,9 +608,9 @@ static void dr_fill_write_icm_segs(struct mlx5dr_domain *dmn,
 	send_info->read.lkey = send_ring->sync_mr->mkey;
 
 	if (send_ring->pending_wqe % send_ring->signal_th == 0)
-		send_info->read.send_flags |= IB_SEND_SIGNALED;
+		send_info->read.send_flags = IB_SEND_SIGNALED;
 	else
-		send_info->read.send_flags &= ~IB_SEND_SIGNALED;
+		send_info->read.send_flags = 0;
 }
 
 static void dr_fill_data_segs(struct mlx5dr_domain *dmn,
@@ -1345,7 +1257,6 @@ int mlx5dr_send_ring_alloc(struct mlx5dr_domain *dmn)
 	dmn->send_ring->cq->qp = dmn->send_ring->qp;
 
 	dmn->info.max_send_wr = QUEUE_SIZE;
-	init_attr.max_send_sge = 1;
 	dmn->info.max_inline_size = min(dmn->send_ring->qp->max_inline_data,
 					DR_STE_SIZE);
 
-- 
2.41.0


