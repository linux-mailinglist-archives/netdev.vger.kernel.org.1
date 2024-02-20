Return-Path: <netdev+bounces-73133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD8D85B173
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 04:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFC5281E45
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 03:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7445256B8A;
	Tue, 20 Feb 2024 03:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpd0a0yn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD756B85
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 03:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399794; cv=none; b=R9P/bfgPi7b2m3L/DUPeM8gZjfLkDzzVCItAnEcPkEnzpJ2mH3GLm+Zjzj+esolxJrGpBrSRcU5/1nfhcl/iQebNapNTCf2QZiulLJsd0M+Bkyk2T30WaAkTPZfW34I/smMMZbfkP5Os8fR15IN0gLMFy7KMGPMnu80BQNq1HSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399794; c=relaxed/simple;
	bh=Asbp0e0UT3h4Yq0AtejhBzjhgbz71HzZ/BSbV/Zutn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXQ78PDSgPPME8+lyAJ3UMkeNaczaVr03CZaXCl7P/pczGdxQjQOCbYodf4lTK7MOpjbVY1TSH7u6qpJL7ktkhRLU/tkHH2cMTtdIwTNtFzj0JTsMZuJLZ7UIf8aB/LNa573r7GDHRtKeucFNvYI+Vi60obBXs+LBLBzQLkUXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpd0a0yn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6214C433F1;
	Tue, 20 Feb 2024 03:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708399793;
	bh=Asbp0e0UT3h4Yq0AtejhBzjhgbz71HzZ/BSbV/Zutn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpd0a0ynFncAbblajTYdCTWozMgy0Bye93tJ60mhKmUPI3lFvRWKRlE5OM5cd3Ema
	 uOldeDnDPUp0uN2K4XbEoaMC1u7IerUtr3ySoY4QGxV2gmzM+wfW6TTwwXXhy1XyGR
	 KvMW3C5VIwDIWnWfawRMo16EQC1HBSIYP1csnHfCDR2MxFCw7I1Q5QGKsu77gOA9SQ
	 jv7Cq1vQh24jzyVvA9q8YgjY0qJByTznq5YvMOslcHe2gkkF0kck/DJ+sfsDTQIh6Q
	 qi5rea6++5fWgGKahX8k33UiDS/isHIuku+27HryZFTsDtfrsuKRf/yUo667LD0hTQ
	 BSQBNkJDMzEtA==
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
Subject: [net 10/10] net/mlx5e: Switch to using _bh variant of of spinlock API in port timestamping NAPI poll context
Date: Mon, 19 Feb 2024 19:29:48 -0800
Message-ID: <20240220032948.35305-5-saeed@kernel.org>
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

The NAPI poll context is a softirq context. Do not use normal spinlock API
in this context to prevent concurrency issues.

Fixes: 3178308ad4ca ("net/mlx5e: Make tx_port_ts logic resilient to out-of-order CQEs")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
CC: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 078f56a3cbb2..ca05b3252a1b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -42,9 +42,9 @@ mlx5e_ptp_port_ts_cqe_list_add(struct mlx5e_ptp_port_ts_cqe_list *list, u8 metad
 
 	WARN_ON_ONCE(tracker->inuse);
 	tracker->inuse = true;
-	spin_lock(&list->tracker_list_lock);
+	spin_lock_bh(&list->tracker_list_lock);
 	list_add_tail(&tracker->entry, &list->tracker_list_head);
-	spin_unlock(&list->tracker_list_lock);
+	spin_unlock_bh(&list->tracker_list_lock);
 }
 
 static void
@@ -54,9 +54,9 @@ mlx5e_ptp_port_ts_cqe_list_remove(struct mlx5e_ptp_port_ts_cqe_list *list, u8 me
 
 	WARN_ON_ONCE(!tracker->inuse);
 	tracker->inuse = false;
-	spin_lock(&list->tracker_list_lock);
+	spin_lock_bh(&list->tracker_list_lock);
 	list_del(&tracker->entry);
-	spin_unlock(&list->tracker_list_lock);
+	spin_unlock_bh(&list->tracker_list_lock);
 }
 
 void mlx5e_ptpsq_track_metadata(struct mlx5e_ptpsq *ptpsq, u8 metadata)
@@ -155,7 +155,7 @@ static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 	struct mlx5e_ptp_metadata_map *metadata_map = &ptpsq->metadata_map;
 	struct mlx5e_ptp_port_ts_cqe_tracker *pos, *n;
 
-	spin_lock(&cqe_list->tracker_list_lock);
+	spin_lock_bh(&cqe_list->tracker_list_lock);
 	list_for_each_entry_safe(pos, n, &cqe_list->tracker_list_head, entry) {
 		struct sk_buff *skb =
 			mlx5e_ptp_metadata_map_lookup(metadata_map, pos->metadata_id);
@@ -170,7 +170,7 @@ static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 		pos->inuse = false;
 		list_del(&pos->entry);
 	}
-	spin_unlock(&cqe_list->tracker_list_lock);
+	spin_unlock_bh(&cqe_list->tracker_list_lock);
 }
 
 #define PTP_WQE_CTR2IDX(val) ((val) & ptpsq->ts_cqe_ctr_mask)
-- 
2.43.2


