Return-Path: <netdev+bounces-192540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F54CAC04B6
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF801BC1031
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 06:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5DA2236E0;
	Thu, 22 May 2025 06:38:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11504221DBC;
	Thu, 22 May 2025 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895887; cv=none; b=SnrTBsXGR4CvGvBz4XaJ0H0XIJDPcW1j+x6tdVgnJ45yBjJVEhlQZLqqIXF1OFJZguWaNU141rWnwk+rfiHhCrWYFwNTBfvkF/m3sNPL5bPYKuQnybCwH9BjBJNVh42bF60y4ZYFz21/SMWM9z0G3SCrd0ylZd2hGvelgHgScTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895887; c=relaxed/simple;
	bh=OvgUR6M8mrEzNRJnUalt7yVdkbKC4auzhxypn5qvETY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K898G7612Ai5FIYxa2zitRyr9UWd2qIQhDwL72zLQYPMZpxtRW3+6BR3FrtNA3YAyPoJLKYwxGj+z5PslWjtns7QRIFVmWUZ2muFAgmYM1TeZedPpj5DoLI232o5gOoH1tBpXsztmpYb8kh7/j+19DlBzFHqFG2y0Yg8E9ruPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2z6f2xc7z6DJ8M;
	Thu, 22 May 2025 14:34:50 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 0897D140605;
	Thu, 22 May 2025 14:38:04 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 08:37:59 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Fan Gong <gongfan1@huawei.com>
Subject: [PATCH net-next v2 3/3] hinic3: remove tx_q name collision hack
Date: Thu, 22 May 2025 09:54:43 +0300
Message-ID: <cad71b91a8a484a9dc799ef416c0bd7881c42f95.1747896423.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1747896423.git.gur.stavi@huawei.com>
References: <cover.1747896423.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500005.china.huawei.com (7.182.85.13)

A local variable of tx_q worked around name collision with internal
txq variable in netif_subqueue macros.
This workaround is no longer needed.

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 7b6f101da313..3f7f73430be4 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -482,7 +482,6 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 {
 	struct hinic3_sq_wqe_combo wqe_combo = {};
 	struct hinic3_tx_info *tx_info;
-	struct hinic3_txq *tx_q = txq;
 	u32 offload, queue_info = 0;
 	struct hinic3_sq_task task;
 	u16 wqebb_cnt, num_sge;
@@ -506,9 +505,9 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 		if (likely(wqebb_cnt > txq->tx_stop_thrs))
 			txq->tx_stop_thrs = min(wqebb_cnt, txq->tx_start_thrs);
 
-		netif_subqueue_try_stop(netdev, tx_q->sq->q_id,
-					hinic3_wq_free_wqebbs(&tx_q->sq->wq),
-					tx_q->tx_start_thrs);
+		netif_subqueue_try_stop(netdev, txq->sq->q_id,
+					hinic3_wq_free_wqebbs(&txq->sq->wq),
+					txq->tx_start_thrs);
 
 		return NETDEV_TX_BUSY;
 	}
@@ -543,10 +542,10 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 	}
 
 	netif_subqueue_sent(netdev, txq->sq->q_id, skb->len);
-	netif_subqueue_maybe_stop(netdev, tx_q->sq->q_id,
-				  hinic3_wq_free_wqebbs(&tx_q->sq->wq),
-				  tx_q->tx_stop_thrs,
-				  tx_q->tx_start_thrs);
+	netif_subqueue_maybe_stop(netdev, txq->sq->q_id,
+				  hinic3_wq_free_wqebbs(&txq->sq->wq),
+				  txq->tx_stop_thrs,
+				  txq->tx_start_thrs);
 
 	hinic3_prepare_sq_ctrl(&wqe_combo, queue_info, num_sge, owner);
 	hinic3_write_db(txq->sq, 0, DB_CFLAG_DP_SQ,
@@ -630,7 +629,6 @@ bool hinic3_tx_poll(struct hinic3_txq *txq, int budget)
 	struct net_device *netdev = txq->netdev;
 	u16 hw_ci, sw_ci, q_id = txq->sq->q_id;
 	struct hinic3_tx_info *tx_info;
-	struct hinic3_txq *tx_q = txq;
 	unsigned int bytes_compl = 0;
 	unsigned int pkts = 0;
 	u16 wqebb_cnt = 0;
@@ -662,8 +660,8 @@ bool hinic3_tx_poll(struct hinic3_txq *txq, int budget)
 	hinic3_wq_put_wqebbs(&txq->sq->wq, wqebb_cnt);
 
 	netif_subqueue_completed_wake(netdev, q_id, pkts, bytes_compl,
-				      hinic3_wq_free_wqebbs(&tx_q->sq->wq),
-				      tx_q->tx_start_thrs);
+				      hinic3_wq_free_wqebbs(&txq->sq->wq),
+				      txq->tx_start_thrs);
 
 	return pkts == HINIC3_TX_POLL_WEIGHT;
 }
-- 
2.45.2


