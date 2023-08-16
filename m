Return-Path: <netdev+bounces-28239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF477EB54
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261961C20321
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BDE18052;
	Wed, 16 Aug 2023 21:01:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E81BEEB
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AF9C433AD;
	Wed, 16 Aug 2023 21:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219669;
	bh=3x4JFNrpo0iZakPqLAcs4OvXNQ2iKfdgnBZdgyDDih4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oClPTA3abfpZ9NJaE+w8pGroSShUFw068XOCjjO4t/IwlC4hnCRWMFafArELuezWl
	 nPLh6RaQUXtzOD6eN0IeQIlDQfkzkw59caXOGbJkgrO/5KNa2qTX3VCf+RfBNMqHGz
	 u7R5vvlw2Ki4nPaYlz4+stAA3b5Ni8taBJNXYhCva62HVffHLKYY9fq1T4uwgveNnY
	 VT226S8LvRpkJk1IAnC2RF4t6+JRjjxEdwzhep4DtkzvK2ogIlnOY/z0qSXrDWEkkt
	 ED5rS6mVzPyRT46sVqNpveP97W4xMSGqzPcP2aYkYZV7r7agpya0VGuL1MKcsPAbM4
	 48G6n5C8UzlCA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net-next 13/15] net/mlx5: DR, Supporting inline WQE when possible
Date: Wed, 16 Aug 2023 14:00:47 -0700
Message-ID: <20230816210049.54733-14-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816210049.54733-1-saeed@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Itamar Gozlan <igozlan@nvidia.com>

In WQE (Work Queue Entry), the two types of data segments memories are
pointers and inline data, where inline data is passed directly as
part of the WQE.
For software steering, the maximal inline size should be less than
2*MLX5_SEND_WQE_BB, i.e., the potential data must fit with the required
inline WQE headers.

Two consecutive blocks (MLX5_SEND_WQE_BB) are not guaranteed to reside
on the same memory page. Hence, writes to MLX5_SEND_WQE_BB should be
done separately, i.e., each MLX5_SEND_WQE_BB  should be obtained using
the mlx5_wq_cyc_get_wqe macro.

Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/steering/dr_send.c     | 115 ++++++++++++++++--
 1 file changed, 102 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
index 6fa06ba2d346..4e8527a724f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
@@ -52,6 +52,7 @@ struct dr_qp_init_attr {
 	u32 cqn;
 	u32 pdn;
 	u32 max_send_wr;
+	u32 max_send_sge;
 	struct mlx5_uars_page *uar;
 	u8 isolate_vl_tc:1;
 };
@@ -246,6 +247,37 @@ static int dr_poll_cq(struct mlx5dr_cq *dr_cq, int ne)
 	return err == CQ_POLL_ERR ? err : npolled;
 }
 
+static int dr_qp_get_args_update_send_wqe_size(struct dr_qp_init_attr *attr)
+{
+	return roundup_pow_of_two(sizeof(struct mlx5_wqe_ctrl_seg) +
+				  sizeof(struct mlx5_wqe_flow_update_ctrl_seg) +
+				  sizeof(struct mlx5_wqe_header_modify_argument_update_seg));
+}
+
+/* We calculate for specific RC QP with the required functionality */
+static int dr_qp_calc_rc_send_wqe(struct dr_qp_init_attr *attr)
+{
+	int update_arg_size;
+	int inl_size = 0;
+	int tot_size;
+	int size;
+
+	update_arg_size = dr_qp_get_args_update_send_wqe_size(attr);
+
+	size = sizeof(struct mlx5_wqe_ctrl_seg) +
+	       sizeof(struct mlx5_wqe_raddr_seg);
+	inl_size = size + ALIGN(sizeof(struct mlx5_wqe_inline_seg) +
+				DR_STE_SIZE, 16);
+
+	size += attr->max_send_sge * sizeof(struct mlx5_wqe_data_seg);
+
+	size = max(size, update_arg_size);
+
+	tot_size = max(size, inl_size);
+
+	return ALIGN(tot_size, MLX5_SEND_WQE_BB);
+}
+
 static struct mlx5dr_qp *dr_create_rc_qp(struct mlx5_core_dev *mdev,
 					 struct dr_qp_init_attr *attr)
 {
@@ -253,6 +285,7 @@ static struct mlx5dr_qp *dr_create_rc_qp(struct mlx5_core_dev *mdev,
 	u32 temp_qpc[MLX5_ST_SZ_DW(qpc)] = {};
 	struct mlx5_wq_param wqp;
 	struct mlx5dr_qp *dr_qp;
+	int wqe_size;
 	int inlen;
 	void *qpc;
 	void *in;
@@ -332,6 +365,15 @@ static struct mlx5dr_qp *dr_create_rc_qp(struct mlx5_core_dev *mdev,
 	if (err)
 		goto err_in;
 	dr_qp->uar = attr->uar;
+	wqe_size = dr_qp_calc_rc_send_wqe(attr);
+	dr_qp->max_inline_data = min(wqe_size -
+				     (sizeof(struct mlx5_wqe_ctrl_seg) +
+				      sizeof(struct mlx5_wqe_raddr_seg) +
+				      sizeof(struct mlx5_wqe_inline_seg)),
+				     (2 * MLX5_SEND_WQE_BB -
+				      (sizeof(struct mlx5_wqe_ctrl_seg) +
+				       sizeof(struct mlx5_wqe_raddr_seg) +
+				       sizeof(struct mlx5_wqe_inline_seg))));
 
 	return dr_qp;
 
@@ -395,8 +437,48 @@ dr_rdma_handle_flow_access_arg_segments(struct mlx5_wqe_ctrl_seg *wq_ctrl,
 		MLX5_SEND_WQE_DS;
 }
 
+static int dr_set_data_inl_seg(struct mlx5dr_qp *dr_qp,
+			       struct dr_data_seg *data_seg, void *wqe)
+{
+	int inline_header_size = sizeof(struct mlx5_wqe_ctrl_seg) +
+				sizeof(struct mlx5_wqe_raddr_seg) +
+				sizeof(struct mlx5_wqe_inline_seg);
+	struct mlx5_wqe_inline_seg *seg;
+	int left_space;
+	int inl = 0;
+	void *addr;
+	int len;
+	int idx;
+
+	seg = wqe;
+	wqe += sizeof(*seg);
+	addr = (void *)(unsigned long)(data_seg->addr);
+	len  = data_seg->length;
+	inl += len;
+	left_space = MLX5_SEND_WQE_BB - inline_header_size;
+
+	if (likely(len > left_space)) {
+		memcpy(wqe, addr, left_space);
+		len -= left_space;
+		addr += left_space;
+		idx = (dr_qp->sq.pc + 1) & (dr_qp->sq.wqe_cnt - 1);
+		wqe = mlx5_wq_cyc_get_wqe(&dr_qp->wq.sq, idx);
+	}
+
+	memcpy(wqe, addr, len);
+
+	if (likely(inl)) {
+		seg->byte_count = cpu_to_be32(inl | MLX5_INLINE_SEG);
+		return DIV_ROUND_UP(inl + sizeof(seg->byte_count),
+				    MLX5_SEND_WQE_DS);
+	} else {
+		return 0;
+	}
+}
+
 static void
-dr_rdma_handle_icm_write_segments(struct mlx5_wqe_ctrl_seg *wq_ctrl,
+dr_rdma_handle_icm_write_segments(struct mlx5dr_qp *dr_qp,
+				  struct mlx5_wqe_ctrl_seg *wq_ctrl,
 				  u64 remote_addr,
 				  u32 rkey,
 				  struct dr_data_seg *data_seg,
@@ -412,15 +494,17 @@ dr_rdma_handle_icm_write_segments(struct mlx5_wqe_ctrl_seg *wq_ctrl,
 	wq_raddr->reserved = 0;
 
 	wq_dseg = (void *)(wq_raddr + 1);
+	/* WQE ctrl segment + WQE remote addr segment */
+	*size = (sizeof(*wq_ctrl) + sizeof(*wq_raddr)) / MLX5_SEND_WQE_DS;
 
-	wq_dseg->byte_count = cpu_to_be32(data_seg->length);
-	wq_dseg->lkey = cpu_to_be32(data_seg->lkey);
-	wq_dseg->addr = cpu_to_be64(data_seg->addr);
-
-	*size = (sizeof(*wq_ctrl) +    /* WQE ctrl segment */
-		 sizeof(*wq_dseg) +    /* WQE data segment */
-		 sizeof(*wq_raddr)) /  /* WQE remote addr segment */
-		MLX5_SEND_WQE_DS;
+	if (data_seg->send_flags & IB_SEND_INLINE) {
+		*size += dr_set_data_inl_seg(dr_qp, data_seg, wq_dseg);
+	} else {
+		wq_dseg->byte_count = cpu_to_be32(data_seg->length);
+		wq_dseg->lkey = cpu_to_be32(data_seg->lkey);
+		wq_dseg->addr = cpu_to_be64(data_seg->addr);
+		*size += sizeof(*wq_dseg) / MLX5_SEND_WQE_DS;  /* WQE data segment */
+	}
 }
 
 static void dr_set_ctrl_seg(struct mlx5_wqe_ctrl_seg *wq_ctrl,
@@ -451,7 +535,7 @@ static void dr_rdma_segments(struct mlx5dr_qp *dr_qp, u64 remote_addr,
 	switch (opcode) {
 	case MLX5_OPCODE_RDMA_READ:
 	case MLX5_OPCODE_RDMA_WRITE:
-		dr_rdma_handle_icm_write_segments(wq_ctrl, remote_addr,
+		dr_rdma_handle_icm_write_segments(dr_qp, wq_ctrl, remote_addr,
 						  rkey, data_seg, &size);
 		break;
 	case MLX5_OPCODE_FLOW_TBL_ACCESS:
@@ -572,7 +656,7 @@ static void dr_fill_write_args_segs(struct mlx5dr_send_ring *send_ring,
 	if (send_ring->pending_wqe % send_ring->signal_th == 0)
 		send_info->write.send_flags |= IB_SEND_SIGNALED;
 	else
-		send_info->write.send_flags = 0;
+		send_info->write.send_flags &= ~IB_SEND_SIGNALED;
 }
 
 static void dr_fill_write_icm_segs(struct mlx5dr_domain *dmn,
@@ -596,9 +680,13 @@ static void dr_fill_write_icm_segs(struct mlx5dr_domain *dmn,
 	}
 
 	send_ring->pending_wqe++;
+	if (!send_info->write.lkey)
+		send_info->write.send_flags |= IB_SEND_INLINE;
 
 	if (send_ring->pending_wqe % send_ring->signal_th == 0)
 		send_info->write.send_flags |= IB_SEND_SIGNALED;
+	else
+		send_info->write.send_flags &= ~IB_SEND_SIGNALED;
 
 	send_ring->pending_wqe++;
 	send_info->read.length = send_info->write.length;
@@ -608,9 +696,9 @@ static void dr_fill_write_icm_segs(struct mlx5dr_domain *dmn,
 	send_info->read.lkey = send_ring->sync_mr->mkey;
 
 	if (send_ring->pending_wqe % send_ring->signal_th == 0)
-		send_info->read.send_flags = IB_SEND_SIGNALED;
+		send_info->read.send_flags |= IB_SEND_SIGNALED;
 	else
-		send_info->read.send_flags = 0;
+		send_info->read.send_flags &= ~IB_SEND_SIGNALED;
 }
 
 static void dr_fill_data_segs(struct mlx5dr_domain *dmn,
@@ -1257,6 +1345,7 @@ int mlx5dr_send_ring_alloc(struct mlx5dr_domain *dmn)
 	dmn->send_ring->cq->qp = dmn->send_ring->qp;
 
 	dmn->info.max_send_wr = QUEUE_SIZE;
+	init_attr.max_send_sge = 1;
 	dmn->info.max_inline_size = min(dmn->send_ring->qp->max_inline_data,
 					DR_STE_SIZE);
 
-- 
2.41.0


