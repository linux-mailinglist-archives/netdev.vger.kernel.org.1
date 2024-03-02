Return-Path: <netdev+bounces-76795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7543686EF0C
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E110285F2C
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0FB12B8D;
	Sat,  2 Mar 2024 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWrCkBza"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982A12B81
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363435; cv=none; b=RAdn8eRQLzr6UP013RLpOD7gY5kkpI1gaD6QWIMpuXtjihyjzdpM7Sl5V0t0lBF1K1w+1zZaZzScbxDHguoFg7SyMAGz2Hb1yJ8C/dqkgFvDAw7oOu+keFtvFGSc+uiU04cRKTzJnmluSbpzMU1Ya79u/1Sm3Elra0fqtSDDNHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363435; c=relaxed/simple;
	bh=QILZuWBaR8rQwjMtzDdN+jV8tsTG/BqqLdc5vEV3Ne0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPsub/VJo5asALHbTbAHy2oOUjZ/U/wIYw2k2DHrLgVFzDi6f6+pwywllr19TwsUcW2HCIAbgNjKnDT6XA21Age38lX3IraGi5B4GdJDHRGdX/2ev3p3nyby33isOy6DEh3Y0bht2+3EzrvyqJUQtkfLROovlUsbJtTknu75C5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWrCkBza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EACFC43390;
	Sat,  2 Mar 2024 07:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709363435;
	bh=QILZuWBaR8rQwjMtzDdN+jV8tsTG/BqqLdc5vEV3Ne0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWrCkBza8x1/GEWNWBFKUkcYUu4akpvap1p2DVTBbHNi2S0t131ph78Ubrcp28Qbb
	 a9d6Ntzny3vd6QxcoTVYHVnn9BrdMCJr6Skb/MAeCRaQ5arBXuZJ7XbhbIkYNus/Ru
	 s5GQAgfXLKrQj94iLjIk/UeAjggWVptHKJAGQv6vj22ZglekBhujcnzlBPBQ0X3LKe
	 CVOI1QEDje8BXhwc5V3GUTzvSWZ3UwKG1IDmmtx0FprNwEsp/HbzB1NrVQI8UAqTgn
	 4CLOPG+7ZZfVTr6lOcDF2U/I+BovY1wRhrhoIpQHJ7c/jNRp0JxHZCShmbYVYP3ANA
	 NIBtYlKI2UaoQ==
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
Subject: [net V2 9/9] net/mlx5e: Switch to using _bh variant of of spinlock API in port timestamping NAPI poll context
Date: Fri,  1 Mar 2024 23:10:28 -0800
Message-ID: <20240302071028.63879-4-saeed@kernel.org>
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
2.44.0


