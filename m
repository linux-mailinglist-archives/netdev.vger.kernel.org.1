Return-Path: <netdev+bounces-82126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABF588C59A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F803048F9
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0D013C902;
	Tue, 26 Mar 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itW+ttUo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716613C666
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464427; cv=none; b=SNWn4mavLjyWz6JlWQ7xG78bF9bSBR42dcWZPShDxz9KRj9O5DO7+W96WyIMXfk53VWSpXDukMeoNC8pkCfhtUWAh6MElWh+41IkmxAg7E7S3ee+RmNqLjO5VJxzPtSDQnLG91E9ZBpLLg62UJGQyOxsaY40p9UqKzUSFlyF7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464427; c=relaxed/simple;
	bh=FPCDULxX2JZK+MYnvtoUHQRsvHjfLGwPqNFWembX4lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaTzg2v2a6TIwA3eQA1dtMLBokx0Gwa3Y0k/5IjJLeGes31Xd4j5o1HElfQ6yX7BrPsjwutzW8z/JEYf2vafggKoj3B86SPPEYrFZWrxXOfNl59gJBtrBFOWxSS1/MoY3ZKs66oMKgF6qfdX6XK5dCrRhB60D8LjsNIj5MZkwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itW+ttUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB4EC433F1;
	Tue, 26 Mar 2024 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464427;
	bh=FPCDULxX2JZK+MYnvtoUHQRsvHjfLGwPqNFWembX4lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=itW+ttUotex+vgHenyTdCrsT++gGs8Idjx5KuIW8nTAWLhgGSZcqRj2BucOU0AcBe
	 eic5M3BTi0/9ZQuFr3oB17E7s9aAA4CAkWpzyzB3+D43kn2YlF8X8XgxeHRUMppomh
	 djRPNyJt7WWxmjPMRHkwyhw7e9s9QoCCukIXuTGzQZCI5XiVZxMeIIKcn09GuCbIPx
	 VZ5EzVD3x8uXHWAoNNZH3/kKJjUh1YRNr0m+McuIii+rWKxSWFfrLi2GBAXL4Fy8x3
	 Ix7KxfD4/WtNqrpSziaPH9qAE84NJ4I9NW1VAshVikRiCxmcCTCr+3Y1ziTDe32laY
	 V8m8mD67JkrHA==
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
Subject: [net 09/10] net/mlx5e: Do not produce metadata freelist entries in Tx port ts WQE xmit
Date: Tue, 26 Mar 2024 07:46:45 -0700
Message-ID: <20240326144646.2078893-10-saeed@kernel.org>
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

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Free Tx port timestamping metadata entries in the NAPI poll context and
consume metadata enties in the WQE xmit path. Do not free a Tx port
timestamping metadata entry in the WQE xmit path even in the error path to
avoid a race between two metadata entry producers.

Fixes: 3178308ad4ca ("net/mlx5e: Make tx_port_ts logic resilient to out-of-order CQEs")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h | 8 +++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c  | 7 +++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
index 86f1854698b4..883c044852f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
@@ -95,9 +95,15 @@ static inline void mlx5e_ptp_metadata_fifo_push(struct mlx5e_ptp_metadata_fifo *
 }
 
 static inline u8
+mlx5e_ptp_metadata_fifo_peek(struct mlx5e_ptp_metadata_fifo *fifo)
+{
+	return fifo->data[fifo->mask & fifo->cc];
+}
+
+static inline void
 mlx5e_ptp_metadata_fifo_pop(struct mlx5e_ptp_metadata_fifo *fifo)
 {
-	return fifo->data[fifo->mask & fifo->cc++];
+	fifo->cc++;
 }
 
 static inline void
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 2fa076b23fbe..e21a3b4128ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -398,6 +398,8 @@ mlx5e_txwqe_complete(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		     (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))) {
 		u8 metadata_index = be32_to_cpu(eseg->flow_table_metadata);
 
+		mlx5e_ptp_metadata_fifo_pop(&sq->ptpsq->metadata_freelist);
+
 		mlx5e_skb_cb_hwtstamp_init(skb);
 		mlx5e_ptp_metadata_map_put(&sq->ptpsq->metadata_map, skb,
 					   metadata_index);
@@ -496,9 +498,6 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 
 err_drop:
 	stats->dropped++;
-	if (unlikely(sq->ptpsq && (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)))
-		mlx5e_ptp_metadata_fifo_push(&sq->ptpsq->metadata_freelist,
-					     be32_to_cpu(eseg->flow_table_metadata));
 	dev_kfree_skb_any(skb);
 	mlx5e_tx_flush(sq);
 }
@@ -657,7 +656,7 @@ static void mlx5e_cqe_ts_id_eseg(struct mlx5e_ptpsq *ptpsq, struct sk_buff *skb,
 {
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
 		eseg->flow_table_metadata =
-			cpu_to_be32(mlx5e_ptp_metadata_fifo_pop(&ptpsq->metadata_freelist));
+			cpu_to_be32(mlx5e_ptp_metadata_fifo_peek(&ptpsq->metadata_freelist));
 }
 
 static void mlx5e_txwqe_build_eseg(struct mlx5e_priv *priv, struct mlx5e_txqsq *sq,
-- 
2.44.0


