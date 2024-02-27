Return-Path: <netdev+bounces-75214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E18868A58
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8C82835DA
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FCE55E62;
	Tue, 27 Feb 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TXUDSZpQ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583754BC8
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020993; cv=none; b=qUOjPjr6oFFpjn+yYJblmX2cLAYewWF5lEeH+VI7upij5HxNlYCYttvMT+2bE6SBnWto/EYdgtZCEEe7lprdnuTRea5RKazhq6uJHSbH2jUffWo2jL8z11S0CMSK/xPVYYFL67XIb1vSQJ0bKCpn3gpy21Jt5gEK+weKkZeAQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020993; c=relaxed/simple;
	bh=ZtHHlM2tlid+u5KOR1PN5stKbfqq5XB54d92kHNBR/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgmdPyc59QtI5FZhopkDHgSwh7MvLv+ebOJMUxWfdUqSbnWyMohJJ48DfTp97b2slWgbeNtCcLiBkyqraZIwgVuSUkubSRrK41iOgKVigCRrOT9l5txR0l78AXNTJIHV43NmsCCNpKlgukZccXLF7FvaCu6Y8Bxdtz4JI/tcP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TXUDSZpQ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709020989; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=c86DK5PmyOIfGATevZBcS4ksi0VLC5oh1qktT046tAU=;
	b=TXUDSZpQ1fWh+MaMT1+bFA3qwl8g+awPzOiGNA5625CCo/7HRjtVUp0bszdoCKnBu3LOyRVIAyB9LltveuBrMqXScLiidrUTZEeMqCg3obWPkKuwni212n2EX4PnjAVP0jyZGBl02BDhdV5gkKHYGNlC5aAyZb3eUWBojzz5Ffk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1Lw1dq_1709020987;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1Lw1dq_1709020987)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 16:03:08 +0800
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
Subject: [PATCH net-next v3 4/6] virtio_net: stats map include driver stats
Date: Tue, 27 Feb 2024 16:03:01 +0800
Message-Id: <20240227080303.63894-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: cacd048f99e7
Content-Transfer-Encoding: 8bit

In the last commit, we use the stats map to manage the device stats.

For the consistency, we let the stats map includes the driver stats.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 195 ++++++++++++++++++++-------------------
 1 file changed, 100 insertions(+), 95 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5549fc8508bd..95cbfb159a03 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -125,9 +125,6 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 	{ "kicks",		VIRTNET_RQ_STAT(kicks) },
 };
 
-#define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
-#define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
-
 #define VIRTNET_STATS_DESC(qtype, class, name) \
 	{#name, offsetof(struct virtio_net_stats_ ## qtype ## _ ## class, qtype ## _ ## name)}
 
@@ -198,10 +195,10 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
 };
 
 struct virtnet_stats_map {
-	/* the stat type in bitmap */
+	/* the stat type in bitmap. just for device stats */
 	u64 stat_type;
 
-	/* the bytes of the response for the stat */
+	/* the bytes of the response for the stat. just for device stats */
 	u32 len;
 
 	/* the num of the response fields for the stat */
@@ -212,9 +209,11 @@ struct virtnet_stats_map {
 #define VIRTNET_STATS_Q_TYPE_CQ 2
 	u32 queue_type;
 
-	/* the reply type of the stat */
+	/* the reply type of the stat. just for device stats */
 	u8 reply_type;
 
+	u8 from_driver;
+
 	/* describe the name and the offset in the response */
 	const struct virtnet_stat_desc *desc;
 };
@@ -226,10 +225,24 @@ struct virtnet_stats_map {
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
@@ -243,6 +256,11 @@ static struct virtnet_stats_map virtio_net_stats_map[] = {
 	VIRTNET_DEVICE_STATS_MAP_ITEM(TX_SPEED, tx_speed, TX),
 };
 
+#define virtnet_stats_supported(vi, m) ({				\
+	typeof(m) _m = (m);						\
+	(((vi)->device_stats_cap & _m->stat_type) || _m->from_driver);	\
+})
+
 struct virtnet_interrupt_coalesce {
 	u32 max_packets;
 	u32 max_usecs;
@@ -2247,7 +2265,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 
 	u64_stats_set(&stats.packets, packets);
 	u64_stats_update_begin(&rq->stats.syncp);
-	for (i = 0; i < VIRTNET_RQ_STATS_LEN; i++) {
+	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
 		size_t offset = virtnet_rq_stats_desc[i].offset;
 		u64_stats_t *item, *src;
 
@@ -3381,33 +3399,36 @@ static int virtnet_set_channels(struct net_device *dev,
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
 
-		if (!(vi->device_stats_cap & m->stat_type))
+		if (!virtnet_stats_supported(vi, m))
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
 
@@ -3442,7 +3463,7 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
 		m = &virtio_net_stats_map[i];
 
-		if (vi->device_stats_cap & m->stat_type) {
+		if (virtnet_stats_supported(vi, m)) {
 			if (m->queue_type == VIRTNET_STATS_Q_TYPE_CQ) {
 				ctx->bitmap_cq |= m->stat_type;
 				ctx->num_cq += m->num;
@@ -3464,19 +3485,66 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
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
+		if (type != m->reply_type)
+			goto skip;
+
+		for (j = 0; j < m->num; ++j) {
+			if (!from_driver) {
+				v = (const u64 *)(base + m->desc[j].offset);
+				ctx->data[offset + j] = le64_to_cpu(*v);
+			} else {
+				v_stat = (const u64_stats_t *)(base + m->desc[j].offset);
+				ctx->data[offset + j] = u64_stats_read(v_stat);
+			}
+		}
+
+		break;
+skip:
+		if (virtnet_stats_supported(vi, m))
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
@@ -3536,43 +3604,10 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 		return ok;
 	}
 
-	num_rx = VIRTNET_RQ_STATS_LEN + ctx->num_rx;
-	num_tx = VIRTNET_SQ_STATS_LEN + ctx->num_tx;
-	num_cq = ctx->num_tx;
-
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
-
 		qid = le16_to_cpu(hdr->vq_index);
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
-			if (m->stat_type & bitmap)
-				offset += m->num;
-
-			if (hdr->type != m->reply_type)
-				continue;
-
-			for (j = 0; j < m->num; ++j) {
-				v = p + m->desc[j].offset;
-				ctx->data[offset + j] = le64_to_cpu(*v);
-			}
-
-			break;
-		}
+		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
 	}
 
 	kfree(reply);
@@ -3582,28 +3617,18 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
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
@@ -3636,8 +3661,7 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
 
 		virtnet_stats_ctx_init(vi, &ctx, NULL);
 
-		pair_count = VIRTNET_RQ_STATS_LEN + VIRTNET_SQ_STATS_LEN;
-		pair_count += ctx.num_rx + ctx.num_tx;
+		pair_count = ctx.num_rx + ctx.num_tx;
 
 		return ctx.num_cq + vi->curr_queue_pairs * pair_count;
 	default:
@@ -3650,46 +3674,27 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
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


