Return-Path: <netdev+bounces-60244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC4F81E5AF
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 08:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDE7282CE3
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8734C626;
	Tue, 26 Dec 2023 07:31:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08434C614
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VzGpBzl_1703575870;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzGpBzl_1703575870)
          by smtp.aliyun-inc.com;
          Tue, 26 Dec 2023 15:31:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH net-next v1 6/6] virtio_net: rename stat tx_timeout to timeout
Date: Tue, 26 Dec 2023 15:31:03 +0800
Message-Id: <20231226073103.116153-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com>
References: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: a7c967e04d1e
Content-Transfer-Encoding: 8bit

Now, we have this:

    tx_queue_0_tx_timeouts

This is used to record the tx schedule timeout.
But this has two "tx". I think the below is enough.

    tx_queue_0_timeouts

So I rename this field.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e97a9474d91a..49625638ad43 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -86,7 +86,7 @@ struct virtnet_sq_stats {
 	u64_stats_t xdp_tx;
 	u64_stats_t xdp_tx_drops;
 	u64_stats_t kicks;
-	u64_stats_t tx_timeouts;
+	u64_stats_t timeouts;
 };
 
 struct virtnet_rq_stats {
@@ -110,7 +110,7 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
 	{ "xdp_tx",		VIRTNET_SQ_STAT(xdp_tx) },
 	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
 	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
-	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
+	{ "timeouts",		VIRTNET_SQ_STAT(timeouts) },
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
@@ -2696,7 +2696,7 @@ static void virtnet_stats(struct net_device *dev,
 			start = u64_stats_fetch_begin(&sq->stats.syncp);
 			tpackets = u64_stats_read(&sq->stats.packets);
 			tbytes   = u64_stats_read(&sq->stats.bytes);
-			terrors  = u64_stats_read(&sq->stats.tx_timeouts);
+			terrors  = u64_stats_read(&sq->stats.timeouts);
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 
 		do {
@@ -4316,7 +4316,7 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
 
 	u64_stats_update_begin(&sq->stats.syncp);
-	u64_stats_inc(&sq->stats.tx_timeouts);
+	u64_stats_inc(&sq->stats.timeouts);
 	u64_stats_update_end(&sq->stats.syncp);
 
 	netdev_err(dev, "TX timeout on queue: %u, sq: %s, vq: 0x%x, name: %s, %u usecs ago\n",
-- 
2.32.0.3.g01195cf9f


