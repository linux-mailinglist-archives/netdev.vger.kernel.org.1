Return-Path: <netdev+bounces-76794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D899C86EF0B
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D5C1F221CB
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65484125BF;
	Sat,  2 Mar 2024 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns/lbYSe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9F125AE
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363434; cv=none; b=Dx8RkMZ2cjXYtsMvAfEyKmwHEzN01NeAkuiNhx3FBaU/pssuivuCtto6kjP/rXqj96Lp0Xv/U0ivYhsziZxEQN09thuIkgrlYsbJo4b0NLUM8yJ0q96JqIDnN8FAMnrsEgTJfvS/CEmgok7Zju/VrLNDSGPJ5HpRLHpYsDdkF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363434; c=relaxed/simple;
	bh=hvEAZRltJofvb1WE/AOfuxeRJ7B5gwycw2IQCCI2Tcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCk/wjPoStr0LaDGuVbdU8Nq4fWwtlmvZlxmbVMW2l4OzMwo5S5SBuNIzc6EUy6IhYClx7I96J1rW7o2fLnr5gybfAxzJAdQdRIK0qnA44utNDFJWgmo9pktX5hwngH5wwHe+CF+u88s9nf8BT/EVdKh1EXB0q8EIG/ZD2szB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns/lbYSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7B2C433C7;
	Sat,  2 Mar 2024 07:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709363433;
	bh=hvEAZRltJofvb1WE/AOfuxeRJ7B5gwycw2IQCCI2Tcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ns/lbYSebk7xG6XruCxKqpV552NpsRlQQNXCzqUucayA5K1WnfFNrFQJhr+Huii93
	 1oz//HX/1M8lH7qVeTrRRVgTDvU3XsqTdeztmugFaDfhi+raM6hfL/oHhEnx3ObET5
	 P/tBk731sf2AhDLf7JCSKdTzkQvk1I1PEMeoBnrmoFHxnLPdlVmeoWChND69ViKU8O
	 gEJAWXxY9WaG1IyEjM7YekceXHmuQfvuyi31X0gkLE5jle8GKWKCycLAsVsNgzcpkM
	 yVKO43jE88aaVMvGGS2kjEEkVOlLcLAEI9zvAzKtcfwLKLacjRK43JDjmIe85qZOPL
	 GoGWJMuBJZBNg==
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
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Vadim Fedorenko <vadfed@meta.com>
Subject: [net V2 8/9] net/mlx5e: Use a memory barrier to enforce PTP WQ xmit submission tracking occurs after populating the metadata_map
Date: Fri,  1 Mar 2024 23:10:27 -0800
Message-ID: <20240302071028.63879-3-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302070318.62997-1-saeed@kernel.org>
References: <20240302070318.62997-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Just simply reordering the functions mlx5e_ptp_metadata_map_put and
mlx5e_ptpsq_track_metadata in the mlx5e_txwqe_complete context is not good
enough since both the compiler and CPU are free to reorder these two
functions. If reordering does occur, the issue that was supposedly fixed by
7e3f3ba97e6c ("net/mlx5e: Track xmit submission to PTP WQ after populating
metadata map") will be seen. This will lead to NULL pointer dereferences in
mlx5e_ptpsq_mark_ts_cqes_undelivered in the NAPI polling context due to the
tracking list being populated before the metadata map.

Fixes: 7e3f3ba97e6c ("net/mlx5e: Track xmit submission to PTP WQ after populating metadata map")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
CC: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 5c166d9d2dca..2fa076b23fbe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -401,6 +401,8 @@ mlx5e_txwqe_complete(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		mlx5e_skb_cb_hwtstamp_init(skb);
 		mlx5e_ptp_metadata_map_put(&sq->ptpsq->metadata_map, skb,
 					   metadata_index);
+		/* ensure skb is put on metadata_map before tracking the index */
+		wmb();
 		mlx5e_ptpsq_track_metadata(sq->ptpsq, metadata_index);
 		if (!netif_tx_queue_stopped(sq->txq) &&
 		    mlx5e_ptpsq_metadata_freelist_empty(sq->ptpsq)) {
-- 
2.44.0


