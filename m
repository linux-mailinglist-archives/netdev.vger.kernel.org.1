Return-Path: <netdev+bounces-75218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E55868A5D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA13D2832C7
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CD85647F;
	Tue, 27 Feb 2024 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ooeeiaOP"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66A55E6B
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020998; cv=none; b=PIGI3+Enke7FUZLP6JfMUurF9+SBtMrpr1gwTxUOBq37FxILE1ftcL1iz0SxBDH7GL8NRjXKTtVlBzFic2ep3uV4Fq+ybA/l6nF8BEAoZZUqMgCAxwOZbGN/7anbGAEGnUCZbGhNKcfDZPUT5DxVCqqMiHjqiYw6YF2ruSB7SbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020998; c=relaxed/simple;
	bh=q720S0gwKbxBDOneZo+a5qKiCcMtjWYMmapnKySlWws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G2Zg0LofG2wSbGl/owJqCjXU8cY8s4V9bsz4nSB36CVFAlf/bY7gsSYnbd/Whvh2YMHyJtS67CwZP993nDgsxKJUFBwLBjhoTxdhPlOQN7F7l+o3dZ5gA4Zz9GFawAm7UlXW/VtyCNX3by2RmUcCCoNBGTNXtw9nZEgXYmebASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ooeeiaOP; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709020988; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=A9nh9gbtRNQDiY5CRmp00APsTxxr5/LAII+ZyPtk9oQ=;
	b=ooeeiaOP9C6TERS122ucVvIr+NUsJkPBwblxpTMtYmmxSOC9CnZVKxhZCVFyA0QegpKnsSO28otlL52s51gou7y2q4aufEkbaskOq42pvBNtMW+hMi6yjYmaJab/pf+bcHl3MiAISpGPQgdGcfbTqI4NPkykZ61q2VIMfW8ZeBA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1M4RMv_1709020986;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1M4RMv_1709020986)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 16:03:07 +0800
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
Subject: [PATCH net-next v3 3/6] virtio_net: support device stats
Date: Tue, 27 Feb 2024 16:03:00 +0800
Message-Id: <20240227080303.63894-4-xuanzhuo@linux.alibaba.com>
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

As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

make virtio-net support getting the stats from the device by ethtool -S
<eth0>.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 362 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 358 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index af512d85cd5b..5549fc8508bd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -128,6 +128,121 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 #define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
 #define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
 
+#define VIRTNET_STATS_DESC(qtype, class, name) \
+	{#name, offsetof(struct virtio_net_stats_ ## qtype ## _ ## class, qtype ## _ ## name)}
+
+static const struct virtnet_stat_desc virtnet_stats_cvq_desc[] = {
+	{"command_num", offsetof(struct virtio_net_stats_cvq, command_num)},
+	{"ok_num", offsetof(struct virtio_net_stats_cvq, ok_num)}
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc[] = {
+	VIRTNET_STATS_DESC(rx, basic, packets),
+	VIRTNET_STATS_DESC(rx, basic, bytes),
+
+	VIRTNET_STATS_DESC(rx, basic, notifications),
+	VIRTNET_STATS_DESC(rx, basic, interrupts),
+
+	VIRTNET_STATS_DESC(rx, basic, drops),
+	VIRTNET_STATS_DESC(rx, basic, drop_overruns),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc[] = {
+	VIRTNET_STATS_DESC(tx, basic, packets),
+	VIRTNET_STATS_DESC(tx, basic, bytes),
+
+	VIRTNET_STATS_DESC(tx, basic, notifications),
+	VIRTNET_STATS_DESC(tx, basic, interrupts),
+
+	VIRTNET_STATS_DESC(tx, basic, drops),
+	VIRTNET_STATS_DESC(tx, basic, drop_malformed),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc[] = {
+	VIRTNET_STATS_DESC(rx, csum, csum_valid),
+	VIRTNET_STATS_DESC(rx, csum, needs_csum),
+
+	VIRTNET_STATS_DESC(rx, csum, csum_none),
+	VIRTNET_STATS_DESC(rx, csum, csum_bad),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_csum_desc[] = {
+	VIRTNET_STATS_DESC(tx, csum, needs_csum),
+	VIRTNET_STATS_DESC(tx, csum, csum_none),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_gso_desc[] = {
+	VIRTNET_STATS_DESC(rx, gso, gso_packets),
+	VIRTNET_STATS_DESC(rx, gso, gso_bytes),
+	VIRTNET_STATS_DESC(rx, gso, gso_packets_coalesced),
+	VIRTNET_STATS_DESC(rx, gso, gso_bytes_coalesced),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc[] = {
+	VIRTNET_STATS_DESC(tx, gso, gso_packets),
+	VIRTNET_STATS_DESC(tx, gso, gso_bytes),
+	VIRTNET_STATS_DESC(tx, gso, gso_segments),
+	VIRTNET_STATS_DESC(tx, gso, gso_segments_bytes),
+	VIRTNET_STATS_DESC(tx, gso, gso_packets_noseg),
+	VIRTNET_STATS_DESC(tx, gso, gso_bytes_noseg),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_speed_desc[] = {
+	VIRTNET_STATS_DESC(rx, speed, packets_allowance_exceeded),
+	VIRTNET_STATS_DESC(rx, speed, bytes_allowance_exceeded),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
+	VIRTNET_STATS_DESC(tx, speed, packets_allowance_exceeded),
+	VIRTNET_STATS_DESC(tx, speed, packets_allowance_exceeded),
+};
+
+struct virtnet_stats_map {
+	/* the stat type in bitmap */
+	u64 stat_type;
+
+	/* the bytes of the response for the stat */
+	u32 len;
+
+	/* the num of the response fields for the stat */
+	u32 num;
+
+#define VIRTNET_STATS_Q_TYPE_RX 0
+#define VIRTNET_STATS_Q_TYPE_TX 1
+#define VIRTNET_STATS_Q_TYPE_CQ 2
+	u32 queue_type;
+
+	/* the reply type of the stat */
+	u8 reply_type;
+
+	/* describe the name and the offset in the response */
+	const struct virtnet_stat_desc *desc;
+};
+
+#define VIRTNET_DEVICE_STATS_MAP_ITEM(TYPE, type, queue_type)	\
+	{							\
+		VIRTIO_NET_STATS_TYPE_##TYPE,			\
+		sizeof(struct virtio_net_stats_ ## type),	\
+		ARRAY_SIZE(virtnet_stats_ ## type ##_desc),	\
+		VIRTNET_STATS_Q_TYPE_##queue_type,		\
+		VIRTIO_NET_STATS_TYPE_REPLY_##TYPE,		\
+		&virtnet_stats_##type##_desc[0]			\
+	}
+
+static struct virtnet_stats_map virtio_net_stats_map[] = {
+	VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
+
+	VIRTNET_DEVICE_STATS_MAP_ITEM(RX_BASIC, rx_basic, RX),
+	VIRTNET_DEVICE_STATS_MAP_ITEM(RX_CSUM,  rx_csum,  RX),
+	VIRTNET_DEVICE_STATS_MAP_ITEM(RX_GSO,   rx_gso,   RX),
+	VIRTNET_DEVICE_STATS_MAP_ITEM(RX_SPEED, rx_speed, RX),
+
+	VIRTNET_DEVICE_STATS_MAP_ITEM(TX_BASIC, tx_basic, TX),
+	VIRTNET_DEVICE_STATS_MAP_ITEM(TX_CSUM,  tx_csum,  TX),
+	VIRTNET_DEVICE_STATS_MAP_ITEM(TX_GSO,   tx_gso,   TX),
+	VIRTNET_DEVICE_STATS_MAP_ITEM(TX_SPEED, tx_speed, TX),
+};
+
 struct virtnet_interrupt_coalesce {
 	u32 max_packets;
 	u32 max_usecs;
@@ -244,6 +359,7 @@ struct control_buf {
 	struct virtio_net_ctrl_coal_tx coal_tx;
 	struct virtio_net_ctrl_coal_rx coal_rx;
 	struct virtio_net_ctrl_coal_vq coal_vq;
+	struct virtio_net_stats_capabilities stats_cap;
 };
 
 struct virtnet_info {
@@ -329,6 +445,8 @@ struct virtnet_info {
 
 	/* failover when STANDBY feature enabled */
 	struct failover *failover;
+
+	u64 device_stats_cap;
 };
 
 struct padded_vnet_hdr {
@@ -3263,6 +3381,204 @@ static int virtnet_set_channels(struct net_device *dev,
 	return err;
 }
 
+static void virtnet_get_hw_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
+{
+	struct virtnet_stats_map *m;
+	int i, j;
+	u8 *p = *data;
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
+		m = &virtio_net_stats_map[i];
+
+		if (m->queue_type != type)
+			continue;
+
+		if (!(vi->device_stats_cap & m->stat_type))
+			continue;
+
+		for (j = 0; j < m->num; ++j) {
+			if (type == VIRTNET_STATS_Q_TYPE_RX)
+				ethtool_sprintf(&p, "rx_queue_hw_%u_%s", qid, m->desc[j].desc);
+
+			else if (type == VIRTNET_STATS_Q_TYPE_TX)
+				ethtool_sprintf(&p, "tx_queue_hw_%u_%s", qid, m->desc[j].desc);
+
+			else if (type == VIRTNET_STATS_Q_TYPE_CQ)
+				ethtool_sprintf(&p, "cq_hw_%s", m->desc[j].desc);
+		}
+	}
+
+	*data = p;
+}
+
+struct virtnet_stats_ctx {
+	u32 num_cq;
+	u32 num_rx;
+	u32 num_tx;
+
+	u64 bitmap_cq;
+	u64 bitmap_rx;
+	u64 bitmap_tx;
+
+	u32 size_cq;
+	u32 size_rx;
+	u32 size_tx;
+
+	u64 *data;
+};
+
+static void virtnet_stats_ctx_init(struct virtnet_info *vi,
+				   struct virtnet_stats_ctx *ctx,
+				   u64 *data)
+{
+	struct virtnet_stats_map *m;
+	int i;
+
+	ctx->data = data;
+
+	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
+		m = &virtio_net_stats_map[i];
+
+		if (vi->device_stats_cap & m->stat_type) {
+			if (m->queue_type == VIRTNET_STATS_Q_TYPE_CQ) {
+				ctx->bitmap_cq |= m->stat_type;
+				ctx->num_cq += m->num;
+				ctx->size_cq += m->len;
+			}
+
+			if (m->queue_type == VIRTNET_STATS_Q_TYPE_RX) {
+				ctx->bitmap_rx |= m->stat_type;
+				ctx->num_rx += m->num;
+				ctx->size_rx += m->len;
+			}
+
+			if (m->queue_type == VIRTNET_STATS_Q_TYPE_TX) {
+				ctx->bitmap_tx |= m->stat_type;
+				ctx->num_tx += m->num;
+				ctx->size_tx += m->len;
+			}
+		}
+	}
+}
+
+static int virtnet_get_hw_stats(struct virtnet_info *vi,
+				struct virtnet_stats_ctx *ctx)
+{
+	struct virtio_net_ctrl_queue_stats *req;
+	struct virtio_net_stats_reply_hdr *hdr;
+	struct scatterlist sgs_in, sgs_out;
+	u32 num_rx, num_tx, num_cq, offset;
+	int qnum, i, j,  qid, res_size;
+	struct virtnet_stats_map *m;
+	void *reply, *p;
+	u64 bitmap;
+	int ok;
+	u64 *v;
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
+		return 0;
+
+	qnum = 0;
+	if (ctx->bitmap_cq)
+		qnum += 1;
+
+	if (ctx->bitmap_rx)
+		qnum += vi->curr_queue_pairs;
+
+	if (ctx->bitmap_tx)
+		qnum += vi->curr_queue_pairs;
+
+	req = kcalloc(qnum, sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	res_size = (ctx->size_rx + ctx->size_tx) * vi->curr_queue_pairs + ctx->size_cq;
+	reply = kmalloc(res_size, GFP_KERNEL);
+	if (!reply) {
+		kfree(req);
+		return -ENOMEM;
+	}
+
+	j = 0;
+	for (i = 0; i < vi->curr_queue_pairs; ++i) {
+		if (ctx->bitmap_rx) {
+			req->stats[j].vq_index = cpu_to_le16(i * 2);
+			req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_rx);
+			++j;
+		}
+
+		if (ctx->bitmap_tx) {
+			req->stats[j].vq_index = cpu_to_le16(i * 2 + 1);
+			req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_tx);
+			++j;
+		}
+	}
+
+	if (ctx->size_cq) {
+		req->stats[j].vq_index = cpu_to_le16(vi->max_queue_pairs * 2);
+		req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_cq);
+		++j;
+	}
+
+	sg_init_one(&sgs_out, req, sizeof(*req) * j);
+	sg_init_one(&sgs_in, reply, res_size);
+
+	ok = virtnet_send_command(vi, VIRTIO_NET_CTRL_STATS,
+				  VIRTIO_NET_CTRL_STATS_GET,
+				  &sgs_out, &sgs_in);
+	kfree(req);
+
+	if (!ok) {
+		kfree(reply);
+		return ok;
+	}
+
+	num_rx = VIRTNET_RQ_STATS_LEN + ctx->num_rx;
+	num_tx = VIRTNET_SQ_STATS_LEN + ctx->num_tx;
+	num_cq = ctx->num_tx;
+
+	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
+		hdr = p;
+
+		qid = le16_to_cpu(hdr->vq_index);
+
+		if (qid == vi->max_queue_pairs * 2) {
+			offset = 0;
+			bitmap = ctx->bitmap_cq;
+		} else if (qid % 2) {
+			offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
+			offset += VIRTNET_SQ_STATS_LEN;
+			bitmap = ctx->bitmap_tx;
+		} else {
+			offset = num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_LEN;
+			bitmap = ctx->bitmap_rx;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
+			m = &virtio_net_stats_map[i];
+
+			if (m->stat_type & bitmap)
+				offset += m->num;
+
+			if (hdr->type != m->reply_type)
+				continue;
+
+			for (j = 0; j < m->num; ++j) {
+				v = p + m->desc[j].offset;
+				ctx->data[offset + j] = le64_to_cpu(*v);
+			}
+
+			break;
+		}
+	}
+
+	kfree(reply);
+	return 0;
+}
+
 static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -3271,16 +3587,22 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
+		virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_CQ, 0, &p);
+
 		for (i = 0; i < vi->curr_queue_pairs; i++) {
 			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
 				ethtool_sprintf(&p, "rx_queue_%u_%s", i,
 						virtnet_rq_stats_desc[j].desc);
+
+			virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_RX, i, &p);
 		}
 
 		for (i = 0; i < vi->curr_queue_pairs; i++) {
 			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
 				ethtool_sprintf(&p, "tx_queue_%u_%s", i,
 						virtnet_sq_stats_desc[j].desc);
+
+			virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_TX, i, &p);
 		}
 		break;
 	}
@@ -3289,11 +3611,35 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 static int virtnet_get_sset_count(struct net_device *dev, int sset)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_stats_ctx ctx = {0};
+	u32 pair_count;
 
 	switch (sset) {
 	case ETH_SS_STATS:
-		return vi->curr_queue_pairs * (VIRTNET_RQ_STATS_LEN +
-					       VIRTNET_SQ_STATS_LEN);
+		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS) &&
+		    !vi->device_stats_cap) {
+			struct scatterlist sg;
+
+			sg_init_one(&sg, &vi->ctrl->stats_cap, sizeof(vi->ctrl->stats_cap));
+
+			if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_STATS,
+						  VIRTIO_NET_CTRL_STATS_QUERY,
+						  NULL, &sg)) {
+				dev_warn(&dev->dev, "Fail to get stats capability\n");
+			} else {
+				__le64 v;
+
+				v = vi->ctrl->stats_cap.supported_stats_types[0];
+				vi->device_stats_cap = le64_to_cpu(v);
+			}
+		}
+
+		virtnet_stats_ctx_init(vi, &ctx, NULL);
+
+		pair_count = VIRTNET_RQ_STATS_LEN + VIRTNET_SQ_STATS_LEN;
+		pair_count += ctx.num_rx + ctx.num_tx;
+
+		return ctx.num_cq + vi->curr_queue_pairs * pair_count;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3303,11 +3649,17 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 				      struct ethtool_stats *stats, u64 *data)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	unsigned int idx = 0, start, i, j;
+	struct virtnet_stats_ctx ctx = {0};
+	unsigned int idx, start, i, j;
 	const u8 *stats_base;
 	const u64_stats_t *p;
 	size_t offset;
 
+	virtnet_stats_ctx_init(vi, &ctx, data);
+	virtnet_get_hw_stats(vi, &ctx);
+
+	idx = ctx.num_cq;
+
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
@@ -3321,6 +3673,7 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 			}
 		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
 		idx += VIRTNET_RQ_STATS_LEN;
+		idx += ctx.num_rx;
 	}
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
@@ -3336,6 +3689,7 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 			}
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 		idx += VIRTNET_SQ_STATS_LEN;
+		idx += ctx.num_tx;
 	}
 }
 
@@ -4963,7 +5317,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
 	VIRTIO_NET_F_VQ_NOTF_COAL, \
-	VIRTIO_NET_F_GUEST_HDRLEN
+	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
-- 
2.32.0.3.g01195cf9f


