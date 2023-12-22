Return-Path: <netdev+bounces-59844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE37681C37E
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 04:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C59286236
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 03:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425844699;
	Fri, 22 Dec 2023 03:30:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E2186E
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VyzU0Pn_1703215827;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VyzU0Pn_1703215827)
          by smtp.aliyun-inc.com;
          Fri, 22 Dec 2023 11:30:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next 5/6] virtio_net: add the total stats field
Date: Fri, 22 Dec 2023 11:30:20 +0800
Message-Id: <20231222033021.20649-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231222033021.20649-1-xuanzhuo@linux.alibaba.com>
References: <20231222033021.20649-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 4f1c8f2a0c5b
Content-Transfer-Encoding: 8bit

Now, we just show the stats of every queue.

But for the user, the total values of every stat may are valuable.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 72 ++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 75d68795f2bc..e97a9474d91a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3290,6 +3290,7 @@ static int virtnet_set_channels(struct net_device *dev,
 	return err;
 }
 
+/* qid == -1: for rx/tx queue total field */
 static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
 {
 	struct virtnet_stats_map *m;
@@ -3312,14 +3313,23 @@ static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid,
 			else
 				tp = "_hw";
 
-			if (type == VIRTNET_STATS_Q_TYPE_RX)
-				ethtool_sprintf(&p, "rx_queue%s_%u_%s", tp, qid, m->desc[j].desc);
-
-			else if (type == VIRTNET_STATS_Q_TYPE_TX)
-				ethtool_sprintf(&p, "tx_queue%s_%u_%s", tp, qid, m->desc[j].desc);
-
-			else if (type == VIRTNET_STATS_Q_TYPE_CQ)
+			if (type == VIRTNET_STATS_Q_TYPE_RX) {
+				if (qid < 0)
+					ethtool_sprintf(&p, "rx%s_%s", tp, m->desc[j].desc);
+				else
+					ethtool_sprintf(&p, "rx_queue%s_%u_%s", tp, qid,
+							m->desc[j].desc);
+
+			} else if (type == VIRTNET_STATS_Q_TYPE_TX) {
+				if (qid < 0)
+					ethtool_sprintf(&p, "tx%s_%s", tp, m->desc[j].desc);
+				else
+					ethtool_sprintf(&p, "tx_queue%s_%u_%s", tp, qid,
+							m->desc[j].desc);
+
+			} else if (type == VIRTNET_STATS_Q_TYPE_CQ) {
 				ethtool_sprintf(&p, "cq%s_%s", tp, m->desc[j].desc);
+			}
 		}
 	}
 
@@ -3376,6 +3386,38 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 	}
 }
 
+static void stats_sum_queue(u64 *sum, u32 num, u64 *q_value, u32 q_num)
+{
+	u32 step = num;
+	int i, j;
+	u64 *p;
+
+	for (i = 0; i < num; ++i) {
+		p = sum + i;
+		*p = 0;
+
+		for (j = 0; j < q_num; ++j)
+			*p += *(q_value + i + j * step);
+	}
+}
+
+static void virtnet_fill_total_fields(struct virtnet_info *vi,
+				      struct virtnet_stats_ctx *ctx)
+{
+	u64 *data, *first_rx_q, *first_tx_q;
+
+	first_rx_q = ctx->data + ctx->num_rx + ctx->num_tx + ctx->num_cq;
+	first_tx_q = first_rx_q + vi->curr_queue_pairs * ctx->num_rx;
+
+	data = ctx->data;
+
+	stats_sum_queue(data, ctx->num_rx, first_rx_q, vi->curr_queue_pairs);
+
+	data = ctx->data + ctx->num_rx;
+
+	stats_sum_queue(data, ctx->num_tx, first_tx_q, vi->curr_queue_pairs);
+}
+
 static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 			       struct virtnet_stats_ctx *ctx,
 			       const u8 *base, bool from_driver, u8 type)
@@ -3387,14 +3429,17 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 	u64 offset;
 	int i, j;
 
+	/* skip the total fields of pairs */
+	offset = ctx->num_rx + ctx->num_tx;
+
 	if (qid == vi->max_queue_pairs * 2) {
-		offset = 0;
 		queue_type = VIRTNET_STATS_Q_TYPE_CQ;
 	} else if (qid % 2) {
-		offset = ctx->num_cq + ctx->num_rx * vi->curr_queue_pairs + ctx->num_tx * (qid / 2);
+		offset += ctx->num_cq + ctx->num_rx * vi->curr_queue_pairs +
+			ctx->num_tx * (qid / 2);
 		queue_type = VIRTNET_STATS_Q_TYPE_TX;
 	} else {
-		offset = ctx->num_cq + ctx->num_rx * (qid / 2);
+		offset += ctx->num_cq + ctx->num_rx * (qid / 2);
 		queue_type = VIRTNET_STATS_Q_TYPE_RX;
 	}
 
@@ -3513,6 +3558,9 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
+		virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_RX, -1, &p);
+		virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_TX, -1, &p);
+
 		virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_CQ, 0, &p);
 
 		for (i = 0; i < vi->curr_queue_pairs; ++i)
@@ -3554,7 +3602,7 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
 
 		pair_count = ctx.num_rx + ctx.num_tx;
 
-		return ctx.num_cq + vi->curr_queue_pairs * pair_count;
+		return pair_count + ctx.num_cq + vi->curr_queue_pairs * pair_count;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3587,6 +3635,8 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 			virtnet_fill_stats(vi, i * 2 + 1, &ctx, stats_base, true, 0);
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 	}
+
+	virtnet_fill_total_fields(vi, &ctx);
 }
 
 static void virtnet_get_channels(struct net_device *dev,
-- 
2.32.0.3.g01195cf9f


