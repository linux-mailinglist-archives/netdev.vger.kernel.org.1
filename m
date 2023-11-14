Return-Path: <netdev+bounces-47848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45147EB917
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5231F25F4F
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04954177B;
	Tue, 14 Nov 2023 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GATfj12r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3841777
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 21:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FBCC433C9;
	Tue, 14 Nov 2023 21:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699999147;
	bh=flrhQtjisAB4oq7jwgHK6gDW/4qpObavqqwfwxnwVh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GATfj12rUSCV4pkWEoF9QYU9/6/D/dKU+amxqkdocsVOlIGPwEH5BlomomA09xEFf
	 5L12acMGqu3ipwt3Lzoznn2rRIUhPnDFwY5ZIqsh97shEijegNAcxtooaofiNubNhO
	 S4GxuvilwrDeDS07w21LTjEzIUh8dwax/lZgwDnwnnrSkij4EJ1i6z/KFpkUM3AeT3
	 AVA4DJQBYMPbKpRFanijNLNawQIdddiiLSnIkXz08WgWvqcgcCuNQVz0UQWt2AWwSv
	 MGP8J20nf9/1osrTRy7D5bc60E42bcIyfTPWbRcLmhdYbNY2zJN0Xi51TIjvIFiC/S
	 +RfmKwjZ3/d0w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net V2 09/15] net/mlx5e: Avoid referencing skb after free-ing in drop path of mlx5e_sq_xmit_wqe
Date: Tue, 14 Nov 2023 13:58:40 -0800
Message-ID: <20231114215846.5902-10-saeed@kernel.org>
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

When SQ is a port timestamping SQ for PTP, do not access tx flags of skb
after free-ing the skb. Free the skb only after all references that depend
on it have been handled in the dropped WQE path.

Fixes: 3178308ad4ca ("net/mlx5e: Make tx_port_ts logic resilient to out-of-order CQEs")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index d41435c22ce5..19f2c25b05a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -494,10 +494,10 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 
 err_drop:
 	stats->dropped++;
-	dev_kfree_skb_any(skb);
 	if (unlikely(sq->ptpsq && (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)))
 		mlx5e_ptp_metadata_fifo_push(&sq->ptpsq->metadata_freelist,
 					     be32_to_cpu(eseg->flow_table_metadata));
+	dev_kfree_skb_any(skb);
 	mlx5e_tx_flush(sq);
 }
 
-- 
2.41.0


