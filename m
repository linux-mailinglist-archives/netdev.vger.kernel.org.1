Return-Path: <netdev+bounces-21637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B6776413F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7A71C204F0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA771AA8F;
	Wed, 26 Jul 2023 21:32:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85F1C9EE
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F052C433A9;
	Wed, 26 Jul 2023 21:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407138;
	bh=YRemj34FSkaxe2QVyVR49Vdqjv9fgW8F18AD/q9gL7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LEpsLF5fxMsbWExfD7UL31Q/yWjPFpe35fXtVy3A5QsuyagefQ3aFNC2v0LLJOsmV
	 HcMBie+v5g/+VkFq6WbIKtkHOSAUO1PNoUsK1x59yWeK3ItEoZWLc+v0G2q1fi6M6N
	 h3xwuAbC4OSH6c/unfYECNwIHADdWfQGhFUr71GKL7Of/IKuE06nByW5XWDgQ0CHKw
	 /LlUMnMwtn7OZrHNILeyz3LaaSpz0//I02ETZcMkE/Gv1nPMILb7XSuNPraICJQfee
	 ZcHM3Xd990gTGMowuMyWz4aJkIY8aGczO0T3twIs2vLquuMipwDYOVZsSX3B1jkW/w
	 MPS2iSF1GY0Hg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Kal Cutter Conley <kal.conley@dectris.com>
Subject: [net 10/15] net/mlx5e: xsk: Fix crash on regular rq reactivation
Date: Wed, 26 Jul 2023 14:32:01 -0700
Message-ID: <20230726213206.47022-11-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726213206.47022-1-saeed@kernel.org>
References: <20230726213206.47022-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

When the regular rq is reactivated after the XSK socket is closed
it could be reading stale cqes which eventually corrupts the rq.
This leads to no more traffic being received on the regular rq and a
crash on the next close or deactivation of the rq.

Kal Cuttler Conely reported this issue as a crash on the release
path when the xdpsock sample program is stopped (killed) and restarted
in sequence while traffic is running.

This patch flushes all cqes when during the rq flush. The cqe flushing
is done in the reset state of the rq. mlx5e_rq_to_ready code is moved
into the flush function to allow for this.

Fixes: 082a9edf12fe ("net/mlx5e: xsk: Flush RQ on XSK activation to save memory")
Reported-by: Kal Cutter Conley <kal.conley@dectris.com>
Closes: https://lore.kernel.org/xdp-newbies/CAHApi-nUAs4TeFWUDV915CZJo07XVg2Vp63-no7UDfj6wur9nQ@mail.gmail.com
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 29 ++++++++++++++-----
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index defb1efccb78..1c820119e438 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1036,7 +1036,23 @@ static int mlx5e_modify_rq_state(struct mlx5e_rq *rq, int curr_state, int next_s
 	return err;
 }
 
-static int mlx5e_rq_to_ready(struct mlx5e_rq *rq, int curr_state)
+static void mlx5e_flush_rq_cq(struct mlx5e_rq *rq)
+{
+	struct mlx5_cqwq *cqwq = &rq->cq.wq;
+	struct mlx5_cqe64 *cqe;
+
+	if (test_bit(MLX5E_RQ_STATE_MINI_CQE_ENHANCED, &rq->state)) {
+		while ((cqe = mlx5_cqwq_get_cqe_enahnced_comp(cqwq)))
+			mlx5_cqwq_pop(cqwq);
+	} else {
+		while ((cqe = mlx5_cqwq_get_cqe(cqwq)))
+			mlx5_cqwq_pop(cqwq);
+	}
+
+	mlx5_cqwq_update_db_record(cqwq);
+}
+
+int mlx5e_flush_rq(struct mlx5e_rq *rq, int curr_state)
 {
 	struct net_device *dev = rq->netdev;
 	int err;
@@ -1046,6 +1062,10 @@ static int mlx5e_rq_to_ready(struct mlx5e_rq *rq, int curr_state)
 		netdev_err(dev, "Failed to move rq 0x%x to reset\n", rq->rqn);
 		return err;
 	}
+
+	mlx5e_free_rx_descs(rq);
+	mlx5e_flush_rq_cq(rq);
+
 	err = mlx5e_modify_rq_state(rq, MLX5_RQC_STATE_RST, MLX5_RQC_STATE_RDY);
 	if (err) {
 		netdev_err(dev, "Failed to move rq 0x%x to ready\n", rq->rqn);
@@ -1055,13 +1075,6 @@ static int mlx5e_rq_to_ready(struct mlx5e_rq *rq, int curr_state)
 	return 0;
 }
 
-int mlx5e_flush_rq(struct mlx5e_rq *rq, int curr_state)
-{
-	mlx5e_free_rx_descs(rq);
-
-	return mlx5e_rq_to_ready(rq, curr_state);
-}
-
 static int mlx5e_modify_rq_vsd(struct mlx5e_rq *rq, bool vsd)
 {
 	struct mlx5_core_dev *mdev = rq->mdev;
-- 
2.41.0


