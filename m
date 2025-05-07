Return-Path: <netdev+bounces-188510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE19AAD251
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686A97B5F30
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52F28691;
	Wed,  7 May 2025 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uncATNUv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63752224F6;
	Wed,  7 May 2025 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577947; cv=none; b=CQ8gy8gnE8J73SXoDIyWckENfIzczjwv58l8iqgMBCWct7alC/aZxht5iJAHuPeKn4JQrRlpQt3lR5eH8NLCDbORazxFvG9fH7SLP3Hr/665tOqWD4za3Wt6mmsG8rP3VVQITpXy8tMkw0hHEE0pxiv5IOlNjz4X4d3l5dnqTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577947; c=relaxed/simple;
	bh=AU1+ZuEO/e9pesFQQWhqPTvBTxF1f+ZliTd7g3ZrMfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPG0NN1vqzdQE4tgBWjg9dXKUElSsnERJWCWO4ZqVVLA2IzeYKcZrT4/6X46X7iDKMAmzAPx7/M5Puct4DEmI5yJIlcG9+gzL+UrsZPyZFN8HiUl51m1DX/qpOHKw+OUbVcbPmr1tjPY+96cdGNknnf+DPdPx6IeFhKqMLMNkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uncATNUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5524FC4CEEF;
	Wed,  7 May 2025 00:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746577946;
	bh=AU1+ZuEO/e9pesFQQWhqPTvBTxF1f+ZliTd7g3ZrMfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uncATNUvFk7KNCML4WeBLbGolR9OeeHA9BEKoLOz3221OMB5LYsvQPgpV6E1r3cxV
	 Vf6AbRHJ6aHa2z5Aoztvkj8Yv5gZ9/1rcr0wSKk4CAgO2JgX4nrGpvXihPyuvPTZvC
	 Rqd5HbBdrbZyfGcQFpBGmn93bjFljze29z1yhjjXT85LE+vjLfek/nwUkwnLY5QW5J
	 zLy9vv8ig7cDtWqQz1IS3eEd6f9ksB8AJ8CaoXWi1oHFVTM1GNJIwMMOrsOfjHgozx
	 D6Jdh/+/tuTr8UbXRGqA/vfZd/zCFGXhVyCpG6IHE1gBD77+A2iCG7u0Ouuz58S3NO
	 N7eDb5F9z49hw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jdamato@fastly.com,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/2] net: export a helper for adding up queue stats
Date: Tue,  6 May 2025 17:32:20 -0700
Message-ID: <20250507003221.823267-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507003221.823267-1-kuba@kernel.org>
References: <20250507003221.823267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older drivers and drivers with lower queue counts often have a static
array of queues, rather than allocating structs for each queue on demand.
Add a helper for adding up qstats from a queue range. Expectation is
that driver will pass a queue range [netdev->real_num_*x_queues, MAX).
It was tempting to always use num_*x_queues as the end, but virtio
seems to clamp its queue count after allocating the netdev. And this
way we can trivaly reuse the helper for [0, real_..).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_queues.h |  6 ++++
 net/core/netdev-genl.c      | 69 +++++++++++++++++++++++++++----------
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index ea709b59d827..069ff35a72de 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -105,6 +105,12 @@ struct netdev_stat_ops {
 			       struct netdev_queue_stats_tx *tx);
 };
 
+void netdev_stat_queue_sum(struct net_device *netdev,
+			   int rx_start, int rx_end,
+			   struct netdev_queue_stats_rx *rx_sum,
+			   int tx_start, int tx_end,
+			   struct netdev_queue_stats_tx *tx_sum);
+
 /**
  * struct netdev_queue_mgmt_ops - netdev ops for queue management
  *
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 2a1a399fc15d..17aa9e42e8d5 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -702,25 +702,66 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
 	return 0;
 }
 
+/**
+ * netdev_stat_queue_sum() - add up queue stats from range of queues
+ * @netdev:	net_device
+ * @rx_start:	index of the first Rx queue to query
+ * @rx_end:	index after the last Rx queue (first *not* to query)
+ * @rx_sum:	output Rx stats, should be already initialized
+ * @tx_start:	index of the first Tx queue to query
+ * @tx_end:	index after the last Tx queue (first *not* to query)
+ * @tx_sum:	output Tx stats, should be already initialized
+ *
+ * Add stats from [start, end) range of queue IDs to *x_sum structs.
+ * The sum structs must be already initialized. Usually this
+ * helper is invoked from the .get_base_stats callbacks of drivers
+ * to account for stats of disabled queues. In that case the ranges
+ * are usually [netdev->real_num_*x_queues, netdev->num_*x_queues).
+ */
+void netdev_stat_queue_sum(struct net_device *netdev,
+			   int rx_start, int rx_end,
+			   struct netdev_queue_stats_rx *rx_sum,
+			   int tx_start, int tx_end,
+			   struct netdev_queue_stats_tx *tx_sum)
+{
+	const struct netdev_stat_ops *ops;
+	struct netdev_queue_stats_rx rx;
+	struct netdev_queue_stats_tx tx;
+	int i;
+
+	ops = netdev->stat_ops;
+
+	for (i = rx_start; i < rx_end; i++) {
+		memset(&rx, 0xff, sizeof(rx));
+		if (ops->get_queue_stats_rx)
+			ops->get_queue_stats_rx(netdev, i, &rx);
+		netdev_nl_stats_add(rx_sum, &rx, sizeof(rx));
+	}
+	for (i = tx_start; i < tx_end; i++) {
+		memset(&tx, 0xff, sizeof(tx));
+		if (ops->get_queue_stats_tx)
+			ops->get_queue_stats_tx(netdev, i, &tx);
+		netdev_nl_stats_add(tx_sum, &tx, sizeof(tx));
+	}
+}
+EXPORT_SYMBOL(netdev_stat_queue_sum);
+
 static int
 netdev_nl_stats_by_netdev(struct net_device *netdev, struct sk_buff *rsp,
 			  const struct genl_info *info)
 {
-	struct netdev_queue_stats_rx rx_sum, rx;
-	struct netdev_queue_stats_tx tx_sum, tx;
-	const struct netdev_stat_ops *ops;
+	struct netdev_queue_stats_rx rx_sum;
+	struct netdev_queue_stats_tx tx_sum;
 	void *hdr;
-	int i;
 
-	ops = netdev->stat_ops;
 	/* Netdev can't guarantee any complete counters */
-	if (!ops->get_base_stats)
+	if (!netdev->stat_ops->get_base_stats)
 		return 0;
 
 	memset(&rx_sum, 0xff, sizeof(rx_sum));
 	memset(&tx_sum, 0xff, sizeof(tx_sum));
 
-	ops->get_base_stats(netdev, &rx_sum, &tx_sum);
+	netdev->stat_ops->get_base_stats(netdev, &rx_sum, &tx_sum);
 
 	/* The op was there, but nothing reported, don't bother */
 	if (!memchr_inv(&rx_sum, 0xff, sizeof(rx_sum)) &&
@@ -733,18 +774,8 @@ netdev_nl_stats_by_netdev(struct net_device *netdev, struct sk_buff *rsp,
 	if (nla_put_u32(rsp, NETDEV_A_QSTATS_IFINDEX, netdev->ifindex))
 		goto nla_put_failure;
 
-	for (i = 0; i < netdev->real_num_rx_queues; i++) {
-		memset(&rx, 0xff, sizeof(rx));
-		if (ops->get_queue_stats_rx)
-			ops->get_queue_stats_rx(netdev, i, &rx);
-		netdev_nl_stats_add(&rx_sum, &rx, sizeof(rx));
-	}
-	for (i = 0; i < netdev->real_num_tx_queues; i++) {
-		memset(&tx, 0xff, sizeof(tx));
-		if (ops->get_queue_stats_tx)
-			ops->get_queue_stats_tx(netdev, i, &tx);
-		netdev_nl_stats_add(&tx_sum, &tx, sizeof(tx));
-	}
+	netdev_stat_queue_sum(netdev, 0, netdev->real_num_rx_queues, &rx_sum,
+			      0, netdev->real_num_tx_queues, &tx_sum);
 
 	if (netdev_nl_stats_write_rx(rsp, &rx_sum) ||
 	    netdev_nl_stats_write_tx(rsp, &tx_sum))
-- 
2.49.0


