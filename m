Return-Path: <netdev+bounces-73132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FFF85B170
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 04:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01EBB231E8
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 03:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2983F55E56;
	Tue, 20 Feb 2024 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTNVfPZS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4D55C16
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399793; cv=none; b=ooFyoTMWdaNGQUK7kwDl815wfdUvYu+Ik0y2BHCfXiPUQu3/6D4JIZtAF6pDWBjMbOQQtI8GwMfscJHYXdkG4mzkae3YAgrJBODL9Rwwg33OOqZphvv8Jt3iDpc3Il7vij8oILoeML35crCvA7QeQVJsxEixtvZGHVltUXC5/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399793; c=relaxed/simple;
	bh=RvD2dqrDB7aGGp2nRl6ceYDYfAesiG2xJqCHgN+uxBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kX3Q8+HHHsdvMbcBp+23k/vfuUIgowUQdhfw7SME+DIE402tLk0Vv9wnJKBMK2ITf1K0GMI8uk27U7SwEeKjDyKbDwI6nJyWbo1W8NO1S6rR603Ge2ASBm2vlQmGrpkd2PfaEoETrsNQQIfs3Oe71o441aWZqdflzsv6h2LEp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTNVfPZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C454FC433B1;
	Tue, 20 Feb 2024 03:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708399792;
	bh=RvD2dqrDB7aGGp2nRl6ceYDYfAesiG2xJqCHgN+uxBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DTNVfPZSWi3wMp6Rs4qHhmHM2htT8iW7dU1Cp8SMOr4Rpw5+nDBF6A7rABGwETlk4
	 Le7MTpTm8jP5fa7Qcbj+DWHywb34IHRr08tUKGmdwL4TwVldsJQ5T+3ffMp+N4XZhv
	 P23knQui5mLG5P8ADtyvv9NlR5q/JL0C15F/X77aTptGTAvqHG6/SG6MYhEZ4WQfZa
	 W2IKL9Sq6FcAcfAdyeTrZQ7QeCPHf0QInJO+Tz9tbSuzpbUH2g4sQWLRGA+NVL2nox
	 gFAtsYt+rY9aQmwHGy7+yzNc5RR50wGQjCIh+ljtmSBfUJD070r+l2o8Moat/pMCcS
	 c/8SeUuMy0kPQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 09/10] net/mlx5e: Use a memory barrier to enforce PTP WQ xmit submission tracking occurs after populating the metadata_map
Date: Mon, 19 Feb 2024 19:29:47 -0800
Message-ID: <20240220032948.35305-4-saeed@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219182320.8914-1-saeed@kernel.org>
References: <20240219182320.8914-1-saeed@kernel.org>
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
2.43.2


