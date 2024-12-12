Return-Path: <netdev+bounces-151355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D32479EE554
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183AC282AAE
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3DF1F238C;
	Thu, 12 Dec 2024 11:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx315.baidu.com [180.101.52.204])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C628158DB1
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004059; cv=none; b=VET/CM9ZNqf3TkbR8XUFjEviw0WNEYj9c1ia1G/GxrJamOudHrGtsaicZMaH42CfbQ1Rz1zMdtlXJ8tb66E0nO4nJS1TBK7iZJiiXOlGo0ggRrHPnDQ/r4gtBUHKUw23Zo/xt3clrfMYFqtzYW/jV+A2jyNSdqUwMGNZg/OA1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004059; c=relaxed/simple;
	bh=vxemn+dWccA8WDl7TjdH5dLFJOSlbDcfvDOBikqsoJo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JVz8mQ9sRY6aM7Gy6i5/HQ68/ZatIum20d3Xc8pg8qV2K1oGZZAmeWH6TmG8dHTMiEVKvBfeQadoHgw+zNeWqy/RBi7RfI66lQhmsfReuFRtbXKLRVBWokiePeyElSkxBYscLiB88JRVRBHTKfVwlxPpJdQ4ipHYCH4HTlGEQYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 9F04D7F0004B;
	Thu, 12 Dec 2024 19:47:25 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch
Cc: Li RongQing <lirongqing@baidu.com>,
	Shuo Li <lishuo02@baidu.com>
Subject: [PATCH][net-next] net/mlx5e: avoid to call net_dim and dim_update_sample
Date: Thu, 12 Dec 2024 19:47:23 +0800
Message-Id: <20241212114723.38844-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

High cpu usage for net_dim is seen still after commit 61bf0009a765
("dim: pass dim_sample to net_dim() by reference"), the calling
net_dim can be avoid under network low throughput or pingpong mode by
checking the event counter, even under high throughput, it maybe only
rx or tx direction

And don't initialize dim_sample variable, since it will gets
overwritten by dim_update_sample

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Shuo Li <lishuo02@baidu.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 7610829..7c525e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -49,11 +49,19 @@ static inline bool mlx5e_channel_no_affinity_change(struct mlx5e_channel *c)
 static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
 {
 	struct mlx5e_sq_stats *stats = sq->stats;
-	struct dim_sample dim_sample = {};
+	struct dim_sample dim_sample;
+	u16 nevents;
 
 	if (unlikely(!test_bit(MLX5E_SQ_STATE_DIM, &sq->state)))
 		return;
 
+	if (sq->dim->state == DIM_MEASURE_IN_PROGRESS) {
+		nevents = BIT_GAP(BITS_PER_TYPE(u16), sq->cq.event_ctr,
+						  sq->dim->start_sample.event_ctr);
+		if (nevents < DIM_NEVENTS)
+			return;
+	}
+
 	dim_update_sample(sq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
 	net_dim(sq->dim, &dim_sample);
 }
@@ -61,11 +69,19 @@ static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
 static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
 {
 	struct mlx5e_rq_stats *stats = rq->stats;
-	struct dim_sample dim_sample = {};
+	struct dim_sample dim_sample;
+	u16 nevents;
 
 	if (unlikely(!test_bit(MLX5E_RQ_STATE_DIM, &rq->state)))
 		return;
 
+	if (rq->dim->state == DIM_MEASURE_IN_PROGRESS) {
+		nevents = BIT_GAP(BITS_PER_TYPE(u16), rq->cq.event_ctr,
+						  rq->dim->start_sample.event_ctr);
+		if (nevents < DIM_NEVENTS)
+			return;
+	}
+
 	dim_update_sample(rq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
 	net_dim(rq->dim, &dim_sample);
 }
-- 
2.9.4


