Return-Path: <netdev+bounces-60241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2389281E5A8
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 08:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4372C1C21C87
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403D4CB2C;
	Tue, 26 Dec 2023 07:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35354C61E
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VzH-NXo_1703575868;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzH-NXo_1703575868)
          by smtp.aliyun-inc.com;
          Tue, 26 Dec 2023 15:31:09 +0800
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
Subject: [PATCH net-next v1 4/6] virtio_net: stats map include driver stats
Date: Tue, 26 Dec 2023 15:31:01 +0800
Message-Id: <20231226073103.116153-5-xuanzhuo@linux.alibaba.com>
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

In the last commit, we use the stats map to manage the device stats.

For the consistency, we let the stats map includes the driver stats.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 194 ++++++++++++++++++++-------------------
 1 file changed, 102 insertions(+), 92 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1f4d9605552f..75d68795f2bc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -124,9 +124,6 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 	{ "kicks",		VIRTNET_RQ_STAT(kicks) },
 };
 
-#define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
-#define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
-
 #define VIRTNET_STATS_DESC(qtype, class, name) \
 	{#name, offsetof(struct virtio_net_stats_ ## qtype ## _ ## class, qtype ## _ ## name)}
 
@@ -197,8 +194,12 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
 };
 
 struct virtnet_stats_map {
+	/* just for device stats */
 	u64 flag;
+
+	/* just for device stats */
 	u32 len;
+
 	u32 num;
 
 #define VIRTNET_STATS_Q_TYPE_RX 0
@@ -206,7 +207,10 @@ struct virtnet_stats_map {
 #define VIRTNET_STATS_Q_TYPE_CQ 2
 	u32 queue_type;
 
+	/* just for device stats */
 	u8 type;
+
+	u8 from_driver;
 	const struct virtnet_stat_desc *desc;
 };
 
@@ -217,10 +221,24 @@ struct virtnet_stats_map {
 		ARRAY_SIZE(virtnet_stats_ ## type ##_desc),	\
 		VIRTNET_STATS_Q_TYPE_##queue_type,		\
 		VIRTIO_NET_STATS_TYPE_REPLY_##TYPE,		\
+		false, \
 		&virtnet_stats_##type##_desc[0]			\
 	}
 
+#define VIRTNET_DRIVER_STATS_MAP_ITEM(type, queue_type)	\
+	{							\
+		0, 0,	\
+		ARRAY_SIZE(virtnet_ ## type ## _stats_desc),	\
+		VIRTNET_STATS_Q_TYPE_##queue_type,		\
+		0, true, \
+		&virtnet_##type##_stats_desc[0]			\
+	}
+
 static struct virtnet_stats_map virtio_net_stats_map[] = {
+	/* driver stats should on the start. */
+	VIRTNET_DRIVER_STATS_MAP_ITEM(rq, RX),
+	VIRTNET_DRIVER_STATS_MAP_ITEM(sq, TX),
+
 	VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
 
 	VIRTNET_DEVICE_STATS_MAP_ITEM(RX_BASIC, rx_basic, RX),
@@ -234,6 +252,11 @@ static struct virtnet_stats_map virtio_net_stats_map[] = {
 	VIRTNET_DEVICE_STATS_MAP_ITEM(TX_SPEED, tx_speed, TX),
 };
 
+#define virtnet_stats_valid(vi, m) ({				\
+	typeof(m) _m = (m);					\
+	(((vi)->device_stats_cap & _m->flag) || _m->from_driver);	\
+})
+
 struct virtnet_interrupt_coalesce {
 	u32 max_packets;
 	u32 max_usecs;
@@ -2206,7 +2229,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 
 	u64_stats_set(&stats.packets, packets);
 	u64_stats_update_begin(&rq->stats.syncp);
-	for (i = 0; i < VIRTNET_RQ_STATS_LEN; i++) {
+	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
 		size_t offset = virtnet_rq_stats_desc[i].offset;
 		u64_stats_t *item, *src;
 
@@ -3267,33 +3290,36 @@ static int virtnet_set_channels(struct net_device *dev,
 	return err;
 }
 
-static void virtnet_get_hw_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
+static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
 {
 	struct virtnet_stats_map *m;
+	const char *tp;
 	int i, j;
 	u8 *p = *data;
 
-	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
-		return;
-
 	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
 		m = &virtio_net_stats_map[i];
 
 		if (m->queue_type != type)
 			continue;
 
-		if (!(vi->device_stats_cap & m->flag))
+		if (!virtnet_stats_valid(vi, m))
 			continue;
 
 		for (j = 0; j < m->num; ++j) {
+			if (m->from_driver)
+				tp = "";
+			else
+				tp = "_hw";
+
 			if (type == VIRTNET_STATS_Q_TYPE_RX)
-				ethtool_sprintf(&p, "rx_queue_hw_%u_%s", qid, m->desc[j].desc);
+				ethtool_sprintf(&p, "rx_queue%s_%u_%s", tp, qid, m->desc[j].desc);
 
 			else if (type == VIRTNET_STATS_Q_TYPE_TX)
-				ethtool_sprintf(&p, "tx_queue_hw_%u_%s", qid, m->desc[j].desc);
+				ethtool_sprintf(&p, "tx_queue%s_%u_%s", tp, qid, m->desc[j].desc);
 
 			else if (type == VIRTNET_STATS_Q_TYPE_CQ)
-				ethtool_sprintf(&p, "cq_hw_%s", m->desc[j].desc);
+				ethtool_sprintf(&p, "cq%s_%s", tp, m->desc[j].desc);
 		}
 	}
 
@@ -3328,7 +3354,7 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
 		m = &virtio_net_stats_map[i];
 
-		if (vi->device_stats_cap & m->flag) {
+		if (virtnet_stats_valid(vi, m)) {
 			if (m->queue_type == VIRTNET_STATS_Q_TYPE_CQ) {
 				ctx->bitmap_cq |= m->flag;
 				ctx->num_cq += m->num;
@@ -3350,19 +3376,66 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 	}
 }
 
+static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
+			       struct virtnet_stats_ctx *ctx,
+			       const u8 *base, bool from_driver, u8 type)
+{
+	struct virtnet_stats_map *m;
+	const u64_stats_t *v_stat;
+	u32 queue_type;
+	const u64 *v;
+	u64 offset;
+	int i, j;
+
+	if (qid == vi->max_queue_pairs * 2) {
+		offset = 0;
+		queue_type = VIRTNET_STATS_Q_TYPE_CQ;
+	} else if (qid % 2) {
+		offset = ctx->num_cq + ctx->num_rx * vi->curr_queue_pairs + ctx->num_tx * (qid / 2);
+		queue_type = VIRTNET_STATS_Q_TYPE_TX;
+	} else {
+		offset = ctx->num_cq + ctx->num_rx * (qid / 2);
+		queue_type = VIRTNET_STATS_Q_TYPE_RX;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
+		m = &virtio_net_stats_map[i];
+
+		if (m->queue_type != queue_type)
+			continue;
+
+		if (from_driver != m->from_driver)
+			goto skip;
+
+		if (type != m->type)
+			goto skip;
+
+		for (j = 0; j < m->num; ++j) {
+			if (!from_driver) {
+				v = (const u64 *)(base + m->desc[j].offset);
+				ctx->data[offset + j] = virtio64_to_cpu(vi->vdev, *v);
+			} else {
+				v_stat = (const u64_stats_t *)(base + m->desc[j].offset);
+				ctx->data[offset + j] = u64_stats_read(v_stat);
+			}
+		}
+
+		break;
+skip:
+		if (virtnet_stats_valid(vi, m))
+			offset += m->num;
+	}
+}
+
 static int virtnet_get_hw_stats(struct virtnet_info *vi,
 				struct virtnet_stats_ctx *ctx)
 {
 	struct virtio_net_ctrl_queue_stats *req;
 	struct virtio_net_stats_reply_hdr *hdr;
 	struct scatterlist sgs_in, sgs_out;
-	u32 num_rx, num_tx, num_cq, offset;
 	int qnum, i, j,  qid, res_size;
-	struct virtnet_stats_map *m;
 	void *reply, *p;
-	u64 bitmap;
 	int ok;
-	u64 *v;
 
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
 		return 0;
@@ -3422,43 +3495,10 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 		return ok;
 	}
 
-	num_rx = VIRTNET_RQ_STATS_LEN + ctx->num_rx;
-	num_tx = VIRTNET_SQ_STATS_LEN + ctx->num_tx;
-	num_cq = ctx->num_tx;
-
 	for (p = reply; p - reply < res_size; p += virtio16_to_cpu(vi->vdev, hdr->size)) {
 		hdr = p;
-
 		qid = virtio16_to_cpu(vi->vdev, hdr->vq_index);
-
-		if (qid == vi->max_queue_pairs * 2) {
-			offset = 0;
-			bitmap = ctx->bitmap_cq;
-		} else if (qid % 2) {
-			offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
-			offset += VIRTNET_SQ_STATS_LEN;
-			bitmap = ctx->bitmap_tx;
-		} else {
-			offset = num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_LEN;
-			bitmap = ctx->bitmap_rx;
-		}
-
-		for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
-			m = &virtio_net_stats_map[i];
-
-			if (m->flag & bitmap)
-				offset += m->num;
-
-			if (hdr->type != m->type)
-				continue;
-
-			for (j = 0; j < m->num; ++j) {
-				v = p + m->desc[j].offset;
-				ctx->data[offset + j] = virtio64_to_cpu(vi->vdev, *v);
-			}
-
-			break;
-		}
+		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
 	}
 
 	kfree(reply);
@@ -3468,28 +3508,18 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	unsigned int i, j;
+	unsigned int i;
 	u8 *p = data;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_CQ, 0, &p);
+		virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_CQ, 0, &p);
 
-		for (i = 0; i < vi->curr_queue_pairs; i++) {
-			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
-				ethtool_sprintf(&p, "rx_queue_%u_%s", i,
-						virtnet_rq_stats_desc[j].desc);
+		for (i = 0; i < vi->curr_queue_pairs; ++i)
+			virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_RX, i, &p);
 
-			virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_RX, i, &p);
-		}
-
-		for (i = 0; i < vi->curr_queue_pairs; i++) {
-			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
-				ethtool_sprintf(&p, "tx_queue_%u_%s", i,
-						virtnet_sq_stats_desc[j].desc);
-
-			virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_TX, i, &p);
-		}
+		for (i = 0; i < vi->curr_queue_pairs; ++i)
+			virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_TX, i, &p);
 		break;
 	}
 }
@@ -3522,8 +3552,7 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
 
 		virtnet_stats_ctx_init(vi, &ctx, NULL);
 
-		pair_count = VIRTNET_RQ_STATS_LEN + VIRTNET_SQ_STATS_LEN;
-		pair_count += ctx.num_rx + ctx.num_tx;
+		pair_count = ctx.num_rx + ctx.num_tx;
 
 		return ctx.num_cq + vi->curr_queue_pairs * pair_count;
 	default:
@@ -3536,46 +3565,27 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct virtnet_stats_ctx ctx = {0};
-	unsigned int idx, start, i, j;
+	unsigned int start, i;
 	const u8 *stats_base;
-	const u64_stats_t *p;
-	size_t offset;
 
 	virtnet_stats_ctx_init(vi, &ctx, data);
 	virtnet_get_hw_stats(vi, &ctx);
 
-	idx = ctx.num_cq;
-
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
+		struct send_queue *sq = &vi->sq[i];
 
 		stats_base = (const u8 *)&rq->stats;
 		do {
 			start = u64_stats_fetch_begin(&rq->stats.syncp);
-			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++) {
-				offset = virtnet_rq_stats_desc[j].offset;
-				p = (const u64_stats_t *)(stats_base + offset);
-				data[idx + j] = u64_stats_read(p);
-			}
+			virtnet_fill_stats(vi, i * 2, &ctx, stats_base, true, 0);
 		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
-		idx += VIRTNET_RQ_STATS_LEN;
-		idx += ctx.num_rx;
-	}
-
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		struct send_queue *sq = &vi->sq[i];
 
 		stats_base = (const u8 *)&sq->stats;
 		do {
 			start = u64_stats_fetch_begin(&sq->stats.syncp);
-			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++) {
-				offset = virtnet_sq_stats_desc[j].offset;
-				p = (const u64_stats_t *)(stats_base + offset);
-				data[idx + j] = u64_stats_read(p);
-			}
+			virtnet_fill_stats(vi, i * 2 + 1, &ctx, stats_base, true, 0);
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
-		idx += VIRTNET_SQ_STATS_LEN;
-		idx += ctx.num_tx;
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


