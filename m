Return-Path: <netdev+bounces-47489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929C37EA68C
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CA9281266
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ED03D99F;
	Mon, 13 Nov 2023 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecU7uxso"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3B3D99D
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C753C433CA;
	Mon, 13 Nov 2023 23:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699916483;
	bh=IA1tjeTxdtQ7fgfvF6vDbESOk+gY6fyIr/NCPY9ruCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecU7uxsoe+GaBGBlrMhxF5RkT8/ylX2/L/Md2s5d1vpTH6gIaD36S7zVUMh7fj+8U
	 bFupsZGiCeytDwnZN0x14t4kDvqy1AfUwrGGMWBxHbcnHwHTO5xUqnPNl0aQfXIBjr
	 IvvbyeIGwm2ikFBJ9LSaz9dVHOCbXG0qq8qo5VGq2DtvuXo2mKVI9gOl3YPtqPck+x
	 FjMuP18GpoHFJMDLJn37Z1CpR0vHHNfhPxmT5b0IiTySl8DeTAfG2w/fgGBjBZ/2Eu
	 13UoeOBdGE2PugxuJeBwmiF7kz4mdadlkQidTkWR6lX0p7pOSwKrQwolGUsgOFfnUN
	 9YPfY65JqmJLg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next 08/14] net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port timestamping CQ
Date: Mon, 13 Nov 2023 15:00:45 -0800
Message-ID: <20231113230051.58229-9-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113230051.58229-1-saeed@kernel.org>
References: <20231113230051.58229-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Track the number of times the a CQE was expected to not be delivered on PTP
Tx port timestamping CQ. A CQE is expected to not be delivered of a certain
amount of time passes since the corresponding CQE containing the DMA
timestamp information has arrived. Increment the late_cqe counter when such
a CQE does manage to be delivered to the CQ.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/counters.rst      | 6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c            | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c          | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h          | 1 +
 4 files changed, 9 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index f69ee1ebee01..5464cd9e2694 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -702,6 +702,12 @@ the software port.
        the device typically ensures not posting the CQE.
      - Error
 
+   * - `ptp_cq[i]_lost_cqe`
+     - Number of times a CQE is expected to not be delivered on the PTP
+       timestamping CQE by the device due to a time delta elapsing. If such a
+       CQE is somehow delivered, `ptp_cq[i]_late_cqe` is incremented.
+     - Error
+
 .. [#ring_global] The corresponding ring and global counters do not share the
                   same name (i.e. do not follow the common naming scheme).
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index bb11e644d24f..a81f9c672b69 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -169,6 +169,7 @@ static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 		WARN_ON_ONCE(!pos->inuse);
 		pos->inuse = false;
 		list_del(&pos->entry);
+		ptpsq->cq_stats->lost_cqe++;
 	}
 	spin_unlock(&cqe_list->tracker_list_lock);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 4b96ad657145..7e63d7c88894 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -2158,6 +2158,7 @@ static const struct counter_desc ptp_cq_stats_desc[] = {
 	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, abort) },
 	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, abort_abs_diff_ns) },
 	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, late_cqe) },
+	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, lost_cqe) },
 };
 
 static const struct counter_desc ptp_rq_stats_desc[] = {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 477c547dcc04..2584f049ec53 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -461,6 +461,7 @@ struct mlx5e_ptp_cq_stats {
 	u64 abort;
 	u64 abort_abs_diff_ns;
 	u64 late_cqe;
+	u64 lost_cqe;
 };
 
 struct mlx5e_rep_stats {
-- 
2.41.0


