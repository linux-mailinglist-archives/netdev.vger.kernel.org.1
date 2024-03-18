Return-Path: <netdev+bounces-80354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7077587E7FA
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEFA283814
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF67364B4;
	Mon, 18 Mar 2024 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i2IC0wLj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72A20323;
	Mon, 18 Mar 2024 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759976; cv=none; b=kIXVJYzM+MFM2PkPtu+w313rqZmGCSQtcWPWAJEr5Gv+h3qbUM91AuoXMl5mzB53OnURdzbl+V8tYPlrxAnLVaN+CZmtCCbdL5t0MCxHKzHIqNJ3zJCj8ydTMfRuCrY9Ts89QKzmNXaIoHc3RpfXMGuf8Ufy22+YZkw6yVqAduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759976; c=relaxed/simple;
	bh=Gth59JVcSlEOCCQKoCUFrbhldgtHOpdq3AD7m1k6sWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DnFxxmKJx+9vdqb89q093aoQkkQTMRx1P6RHvRQuBdq/9mdLUi/ufrVh0cWN2BAdyb0BelXIL9vfeOkjmfdNhUDe7URpKVzDhSOgxJB16QDJe4XyKZirxXcs0c85vt9PXdXyBofRZwLJFNRJFHAj08f2m8FLAakClMbq+Bupncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i2IC0wLj; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710759969; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yk5zLiy2ZRYomqYIM1eFd+DAXNzLfBwbu7VfTw42Z78=;
	b=i2IC0wLjko6lKb6Otd4ZZ2RXCezRKMX+3mR0D69jkUF/M5MkxMIUMEUuQoHniLUjJI7pRDHSl+bkEfk2fZJcLrseUZ3P295dnLvTjeatab+L72wybiMqRIUbQWABPmnl0rs9q15d6qEcMRoKUENdF2yGlthICSxHSWtT4PQg3rA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2mTiZK_1710759968;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2mTiZK_1710759968)
          by smtp.aliyun-inc.com;
          Mon, 18 Mar 2024 19:06:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 4/9] virtio_net: support device stats
Date: Mon, 18 Mar 2024 19:05:57 +0800
Message-Id: <20240318110602.37166-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 0059ee1bd6b4
Content-Transfer-Encoding: 8bit

As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

make virtio-net support getting the stats from the device by ethtool -S
<eth0>.

Due to the numerous descriptors stats, an organization method is
required. For this purpose, I have introduced the "virtnet_stats_map".
Utilizing this array simplifies coding tasks such as generating field
names, calculating buffer sizes for requests and responses, and parsing
replies from the device. By iterating over the "virtnet_stats_map,"
these operations become more streamlined and efficient.

NIC statistics:
     rx0_packets: 582951
     rx0_bytes: 155307077
     rx0_drops: 0
     rx0_xdp_packets: 0
     rx0_xdp_tx: 0
     rx0_xdp_redirects: 0
     rx0_xdp_drops: 0
     rx0_kicks: 17007
     rx0_hw_packets: 2179409
     rx0_hw_bytes: 510015040
     rx0_hw_notifications: 0
     rx0_hw_interrupts: 0
     rx0_hw_drops: 12964
     rx0_hw_drop_overruns: 0
     rx0_hw_csum_valid: 2179409
     rx0_hw_csum_none: 0
     rx0_hw_csum_bad: 0
     rx0_hw_needs_csum: 2179409
     rx0_hw_ratelimit_packets: 0
     rx0_hw_ratelimit_bytes: 0
     tx0_packets: 15361
     tx0_bytes: 1918970
     tx0_xdp_tx: 0
     tx0_xdp_tx_drops: 0
     tx0_kicks: 15361
     tx0_timeouts: 0
     tx0_hw_packets: 32272
     tx0_hw_bytes: 4311698
     tx0_hw_notifications: 0
     tx0_hw_interrupts: 0
     tx0_hw_drops: 0
     tx0_hw_drop_malformed: 0
     tx0_hw_csum_none: 0
     tx0_hw_needs_csum: 32272
     tx0_hw_ratelimit_packets: 0
     tx0_hw_ratelimit_bytes: 0

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 401 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 397 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8cb5bdd7ad91..70c1d4e850e0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -128,6 +128,129 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 #define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
 #define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
 
+#define VIRTNET_STATS_DESC_CQ(name) \
+	{#name, offsetof(struct virtio_net_stats_cvq, name)}
+
+#define VIRTNET_STATS_DESC_RX(class, name) \
+	{#name, offsetof(struct virtio_net_stats_rx_ ## class, rx_ ## name)}
+
+#define VIRTNET_STATS_DESC_TX(class, name) \
+	{#name, offsetof(struct virtio_net_stats_tx_ ## class, tx_ ## name)}
+
+static const struct virtnet_stat_desc virtnet_stats_cvq_desc[] = {
+	VIRTNET_STATS_DESC_CQ(command_num),
+	VIRTNET_STATS_DESC_CQ(ok_num),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc[] = {
+	VIRTNET_STATS_DESC_RX(basic, packets),
+	VIRTNET_STATS_DESC_RX(basic, bytes),
+
+	VIRTNET_STATS_DESC_RX(basic, notifications),
+	VIRTNET_STATS_DESC_RX(basic, interrupts),
+
+	VIRTNET_STATS_DESC_RX(basic, drops),
+	VIRTNET_STATS_DESC_RX(basic, drop_overruns),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc[] = {
+	VIRTNET_STATS_DESC_TX(basic, packets),
+	VIRTNET_STATS_DESC_TX(basic, bytes),
+
+	VIRTNET_STATS_DESC_TX(basic, notifications),
+	VIRTNET_STATS_DESC_TX(basic, interrupts),
+
+	VIRTNET_STATS_DESC_TX(basic, drops),
+	VIRTNET_STATS_DESC_TX(basic, drop_malformed),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc[] = {
+	VIRTNET_STATS_DESC_RX(csum, csum_valid),
+	VIRTNET_STATS_DESC_RX(csum, needs_csum),
+
+	VIRTNET_STATS_DESC_RX(csum, csum_none),
+	VIRTNET_STATS_DESC_RX(csum, csum_bad),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_csum_desc[] = {
+	VIRTNET_STATS_DESC_TX(csum, needs_csum),
+	VIRTNET_STATS_DESC_TX(csum, csum_none),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_gso_desc[] = {
+	VIRTNET_STATS_DESC_RX(gso, gso_packets),
+	VIRTNET_STATS_DESC_RX(gso, gso_bytes),
+	VIRTNET_STATS_DESC_RX(gso, gso_packets_coalesced),
+	VIRTNET_STATS_DESC_RX(gso, gso_bytes_coalesced),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc[] = {
+	VIRTNET_STATS_DESC_TX(gso, gso_packets),
+	VIRTNET_STATS_DESC_TX(gso, gso_bytes),
+	VIRTNET_STATS_DESC_TX(gso, gso_segments),
+	VIRTNET_STATS_DESC_TX(gso, gso_segments_bytes),
+	VIRTNET_STATS_DESC_TX(gso, gso_packets_noseg),
+	VIRTNET_STATS_DESC_TX(gso, gso_bytes_noseg),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_speed_desc[] = {
+	VIRTNET_STATS_DESC_RX(speed, ratelimit_packets),
+	VIRTNET_STATS_DESC_RX(speed, ratelimit_bytes),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
+	VIRTNET_STATS_DESC_TX(speed, ratelimit_packets),
+	VIRTNET_STATS_DESC_TX(speed, ratelimit_bytes),
+};
+
+#define VIRTNET_Q_TYPE_RX 0
+#define VIRTNET_Q_TYPE_TX 1
+#define VIRTNET_Q_TYPE_CQ 2
+
+struct virtnet_stats_map {
+	/* The stat type in bitmap. */
+	u64 stat_type;
+
+	/* The bytes of the response for the stat. */
+	u32 len;
+
+	/* The num of the response fields for the stat. */
+	u32 num;
+
+	/* The type of queue corresponding to the statistics. (cq, rq, sq) */
+	u32 queue_type;
+
+	/* The reply type of the stat. */
+	u8 reply_type;
+
+	/* Describe the name and the offset in the response. */
+	const struct virtnet_stat_desc *desc;
+};
+
+#define VIRTNET_DEVICE_STATS_MAP_ITEM(TYPE, type, queue_type)	\
+	{							\
+		VIRTIO_NET_STATS_TYPE_##TYPE,			\
+		sizeof(struct virtio_net_stats_ ## type),	\
+		ARRAY_SIZE(virtnet_stats_ ## type ##_desc),	\
+		VIRTNET_Q_TYPE_##queue_type,			\
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
@@ -244,6 +367,7 @@ struct control_buf {
 	struct virtio_net_ctrl_coal_tx coal_tx;
 	struct virtio_net_ctrl_coal_rx coal_rx;
 	struct virtio_net_ctrl_coal_vq coal_vq;
+	struct virtio_net_stats_capabilities stats_cap;
 };
 
 struct virtnet_info {
@@ -329,6 +453,8 @@ struct virtnet_info {
 
 	/* failover when STANDBY feature enabled */
 	struct failover *failover;
+
+	u64 device_stats_cap;
 };
 
 struct padded_vnet_hdr {
@@ -389,6 +515,17 @@ static int rxq2vq(int rxq)
 	return rxq * 2;
 }
 
+static int vq_type(struct virtnet_info *vi, int qid)
+{
+	if (qid == vi->max_queue_pairs * 2)
+		return VIRTNET_Q_TYPE_CQ;
+
+	if (qid % 2)
+		return VIRTNET_Q_TYPE_TX;
+
+	return VIRTNET_Q_TYPE_RX;
+}
+
 static inline struct virtio_net_common_hdr *
 skb_vnet_common_hdr(struct sk_buff *skb)
 {
@@ -3263,6 +3400,223 @@ static int virtnet_set_channels(struct net_device *dev,
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
+			switch (type) {
+			case VIRTNET_Q_TYPE_RX:
+				ethtool_sprintf(&p, "rx_queue_hw_%u_%s", qid, m->desc[j].desc);
+				break;
+
+			case VIRTNET_Q_TYPE_TX:
+				ethtool_sprintf(&p, "tx_queue_hw_%u_%s", qid, m->desc[j].desc);
+				break;
+
+			case VIRTNET_Q_TYPE_CQ:
+				ethtool_sprintf(&p, "cq_hw_%s", m->desc[j].desc);
+				break;
+			}
+		}
+	}
+
+	*data = p;
+}
+
+struct virtnet_stats_ctx {
+	u32 desc_num[3];
+
+	u32 bitmap[3];
+
+	u32 size[3];
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
+		if (!(vi->device_stats_cap & m->stat_type))
+			continue;
+
+		ctx->bitmap[m->queue_type]   |= m->stat_type;
+		ctx->desc_num[m->queue_type] += m->num;
+		ctx->size[m->queue_type]     += m->len;
+	}
+}
+
+/* virtnet_fill_stats - copy the stats to ethtool -S
+ * The stats source is the device.
+ *
+ * @vi: virtio net info
+ * @qid: the vq id
+ * @ctx: stats ctx (initiated by virtnet_stats_ctx_init())
+ * @base: pointer to the device reply.
+ * @type: the type of the device reply
+ */
+static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
+			       struct virtnet_stats_ctx *ctx,
+			       const u8 *base, u8 type)
+{
+	u32 queue_type, num_rx, num_tx, num_cq;
+	struct virtnet_stats_map *m;
+	u64 offset, bitmap;
+	const __le64 *v;
+	int i, j;
+
+	num_rx = VIRTNET_RQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_RX];
+	num_tx = VIRTNET_SQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_TX];
+	num_cq = ctx->desc_num[VIRTNET_Q_TYPE_CQ];
+
+	queue_type = vq_type(vi, qid);
+	bitmap = ctx->bitmap[queue_type];
+	offset = 0;
+
+	if (queue_type == VIRTNET_Q_TYPE_TX) {
+		offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
+		offset += VIRTNET_SQ_STATS_LEN;
+	} else if (queue_type == VIRTNET_Q_TYPE_RX) {
+		offset = num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_LEN;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
+		m = &virtio_net_stats_map[i];
+
+		if (m->stat_type & bitmap)
+			offset += m->num;
+
+		if (type != m->reply_type)
+			continue;
+
+		for (j = 0; j < m->num; ++j) {
+			v = (const __le64 *)(base + m->desc[j].offset);
+			ctx->data[offset + j] = le64_to_cpu(*v);
+		}
+
+		break;
+	}
+}
+
+static int __virtnet_get_hw_stats(struct virtnet_info *vi,
+				  struct virtnet_stats_ctx *ctx,
+				  struct virtio_net_ctrl_queue_stats *req,
+				  int req_size, void *reply, int res_size)
+{
+	struct virtio_net_stats_reply_hdr *hdr;
+	struct scatterlist sgs_in, sgs_out;
+	void *p;
+	u32 qid;
+	int ok;
+
+	sg_init_one(&sgs_out, req, req_size);
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
+	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
+		hdr = p;
+		qid = le16_to_cpu(hdr->vq_index);
+		virtnet_fill_stats(vi, qid, ctx, p, hdr->type);
+	}
+
+	kfree(reply);
+	return 0;
+}
+
+static void virtnet_make_stat_req(struct virtnet_info *vi,
+				  struct virtnet_stats_ctx *ctx,
+				  struct virtio_net_ctrl_queue_stats *req,
+				  int qid, int *idx)
+{
+	int qtype = vq_type(vi, qid);
+	u64 bitmap = ctx->bitmap[qtype];
+
+	if (!bitmap)
+		return;
+
+	req->stats[*idx].vq_index = cpu_to_le16(qid);
+	req->stats[*idx].types_bitmap[0] = cpu_to_le64(bitmap);
+	*idx += 1;
+}
+
+static int virtnet_get_hw_stats(struct virtnet_info *vi,
+				struct virtnet_stats_ctx *ctx)
+{
+	struct virtio_net_ctrl_queue_stats *req;
+	int qnum, i, j, res_size, qtype, last_vq;
+	void *reply;
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
+		return 0;
+
+	last_vq = vi->curr_queue_pairs * 2 - 1;
+
+	qnum = 0;
+	res_size = 0;
+	for (i = 0; i <= last_vq ; ++i) {
+		qtype = vq_type(vi, i);
+		if (ctx->bitmap[qtype]) {
+			++qnum;
+			res_size += ctx->size[qtype];
+		}
+	}
+
+	if (ctx->bitmap[VIRTNET_Q_TYPE_CQ]) {
+		res_size += ctx->size[VIRTNET_Q_TYPE_CQ];
+		qnum += 1;
+	}
+
+	req = kcalloc(qnum, sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	reply = kmalloc(res_size, GFP_KERNEL);
+	if (!reply) {
+		kfree(req);
+		return -ENOMEM;
+	}
+
+	j = 0;
+	for (i = 0; i <= last_vq ; ++i)
+		virtnet_make_stat_req(vi, ctx, req, i, &j);
+
+	virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
+
+	return __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
+}
+
 static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -3271,16 +3625,22 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
+		virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_CQ, 0, &p);
+
 		for (i = 0; i < vi->curr_queue_pairs; i++) {
 			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
 				ethtool_sprintf(&p, "rx%u_%s", i,
 						virtnet_rq_stats_desc[j].desc);
+
+			virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_RX, i, &p);
 		}
 
 		for (i = 0; i < vi->curr_queue_pairs; i++) {
 			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
 				ethtool_sprintf(&p, "tx%u_%s", i,
 						virtnet_sq_stats_desc[j].desc);
+
+			virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_TX, i, &p);
 		}
 		break;
 	}
@@ -3289,11 +3649,35 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
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
+		pair_count += ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.desc_num[VIRTNET_Q_TYPE_TX];
+
+		return ctx.desc_num[VIRTNET_Q_TYPE_CQ] + vi->curr_queue_pairs * pair_count;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3303,11 +3687,18 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
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
+	if (virtnet_get_hw_stats(vi, &ctx))
+		dev_warn(&vi->dev->dev, "Failed to get hw stats.\n");
+
+	idx = ctx.desc_num[VIRTNET_Q_TYPE_CQ];
+
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
@@ -3321,6 +3712,7 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 			}
 		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
 		idx += VIRTNET_RQ_STATS_LEN;
+		idx += ctx.desc_num[VIRTNET_Q_TYPE_RX];
 	}
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
@@ -3336,6 +3728,7 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 			}
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 		idx += VIRTNET_SQ_STATS_LEN;
+		idx += ctx.desc_num[VIRTNET_Q_TYPE_TX];
 	}
 }
 
@@ -4963,7 +5356,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
 	VIRTIO_NET_F_VQ_NOTF_COAL, \
-	VIRTIO_NET_F_GUEST_HDRLEN
+	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
-- 
2.32.0.3.g01195cf9f


