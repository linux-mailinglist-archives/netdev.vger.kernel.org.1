Return-Path: <netdev+bounces-47850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3957EB919
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98548B20B19
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49CA2E82F;
	Tue, 14 Nov 2023 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVlZHNF5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77542E82C
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 21:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E2EC433CA;
	Tue, 14 Nov 2023 21:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699999149;
	bh=5jvyaK8QPzsSqcnxW3vS9yR1Svr+QZt4wE8NgIROQCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVlZHNF5/9tuAPiyDOuTlERB95VppSHVTekjfhDFtBUvwB3NV6nuFKnDyoqGwIKdQ
	 vK++gxNo1vlhskLotcZMe+S914CWhqxmOUihxqQMYa//tUf2vS2+rcOudwaIB5B4iI
	 ZXzGanNv2RqIW5vYrljwwWk20JEoHx7fw1Tabs2ofbIsig5zW4SzMa+H0mZKyLEPJ2
	 2CFfkmg5x8UsRZJjWk2Fe6pmO0OF3ie6OXxY7313rMOmdQ1J36PcJGzKsYrsmcFL0H
	 4Mr4zNCktH9hTdxZfiLe/nTkFAVmMzgVap1ZwcphpOH7Uy/maSQdhGRfwt1oQVIzf5
	 IFit9zHZxCGEw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net V2 11/15] net/mlx5e: Update doorbell for port timestamping CQ before the software counter
Date: Tue, 14 Nov 2023 13:58:42 -0800
Message-ID: <20231114215846.5902-12-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114215846.5902-1-saeed@kernel.org>
References: <20231114215846.5902-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Previously, mlx5e_ptp_poll_ts_cq would update the device doorbell with the
incremented consumer index after the relevant software counters in the
kernel were updated. In the mlx5e_sq_xmit_wqe context, this would lead to
either overrunning the device CQ or exceeding the expected software buffer
size in the device CQ if the device CQ size was greater than the software
buffer size. Update the relevant software counter only after updating the
device CQ consumer index in the port timestamping napi_poll context.

Log:
    mlx5_core 0000:08:00.0: cq_err_event_notifier:517:(pid 0): CQ error on CQN 0x487, syndrome 0x1
    mlx5_core 0000:08:00.0 eth2: mlx5e_cq_error_event: cqn=0x000487 event=0x04

Fixes: 1880bc4e4a96 ("net/mlx5e: Add TX port timestamp support")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index bb11e644d24f..af3928eddafd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -177,6 +177,8 @@ static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 
 static void mlx5e_ptp_handle_ts_cqe(struct mlx5e_ptpsq *ptpsq,
 				    struct mlx5_cqe64 *cqe,
+				    u8 *md_buff,
+				    u8 *md_buff_sz,
 				    int budget)
 {
 	struct mlx5e_ptp_port_ts_cqe_list *pending_cqe_list = ptpsq->ts_cqe_pending_list;
@@ -211,19 +213,24 @@ static void mlx5e_ptp_handle_ts_cqe(struct mlx5e_ptpsq *ptpsq,
 	mlx5e_ptpsq_mark_ts_cqes_undelivered(ptpsq, hwtstamp);
 out:
 	napi_consume_skb(skb, budget);
-	mlx5e_ptp_metadata_fifo_push(&ptpsq->metadata_freelist, metadata_id);
+	md_buff[*md_buff_sz++] = metadata_id;
 	if (unlikely(mlx5e_ptp_metadata_map_unhealthy(&ptpsq->metadata_map)) &&
 	    !test_and_set_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state))
 		queue_work(ptpsq->txqsq.priv->wq, &ptpsq->report_unhealthy_work);
 }
 
-static bool mlx5e_ptp_poll_ts_cq(struct mlx5e_cq *cq, int budget)
+static bool mlx5e_ptp_poll_ts_cq(struct mlx5e_cq *cq, int napi_budget)
 {
 	struct mlx5e_ptpsq *ptpsq = container_of(cq, struct mlx5e_ptpsq, ts_cq);
-	struct mlx5_cqwq *cqwq = &cq->wq;
+	int budget = min(napi_budget, MLX5E_TX_CQ_POLL_BUDGET);
+	u8 metadata_buff[MLX5E_TX_CQ_POLL_BUDGET];
+	u8 metadata_buff_sz = 0;
+	struct mlx5_cqwq *cqwq;
 	struct mlx5_cqe64 *cqe;
 	int work_done = 0;
 
+	cqwq = &cq->wq;
+
 	if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED, &ptpsq->txqsq.state)))
 		return false;
 
@@ -234,7 +241,8 @@ static bool mlx5e_ptp_poll_ts_cq(struct mlx5e_cq *cq, int budget)
 	do {
 		mlx5_cqwq_pop(cqwq);
 
-		mlx5e_ptp_handle_ts_cqe(ptpsq, cqe, budget);
+		mlx5e_ptp_handle_ts_cqe(ptpsq, cqe,
+					metadata_buff, &metadata_buff_sz, napi_budget);
 	} while ((++work_done < budget) && (cqe = mlx5_cqwq_get_cqe(cqwq)));
 
 	mlx5_cqwq_update_db_record(cqwq);
@@ -242,6 +250,10 @@ static bool mlx5e_ptp_poll_ts_cq(struct mlx5e_cq *cq, int budget)
 	/* ensure cq space is freed before enabling more cqes */
 	wmb();
 
+	while (metadata_buff_sz > 0)
+		mlx5e_ptp_metadata_fifo_push(&ptpsq->metadata_freelist,
+					     metadata_buff[--metadata_buff_sz]);
+
 	mlx5e_txqsq_wake(&ptpsq->txqsq);
 
 	return work_done == budget;
-- 
2.41.0


