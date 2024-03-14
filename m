Return-Path: <netdev+bounces-79817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D13E187B9D6
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 09:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0741C20B31
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE206DCE3;
	Thu, 14 Mar 2024 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LTeVw3kM"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA26BB54;
	Thu, 14 Mar 2024 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406517; cv=none; b=NMyN6GNx2AidZxlWhMYhJTNwtzfFKaJU5Qypm6yBrWyE3tCN4sdfAU2jCeXTceR4LoUqf0t+3NjI3z3osQ7e//FZgn8Wy06EUhShSluRu1ug1HPUI+kkXS2sbX98XY8LDmfT5ixGGimPMdwTCHPsM5POIlt6fj1nBMGpEGhxk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406517; c=relaxed/simple;
	bh=l3rlX4bNovDyGtniopFmjW3WOruHsBpGldfFm+IGyFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+VxK0DxMsaW+wNeHcbyjrhlGidCns6uBkNjoGgVK9Asfhbdt4j/b+GqQKBjovRD/O4wff6V0wuCUPEG220M9AquPSJwYzvD9BvtugrFdMO40iAvtwbt57R188ZVX3AnPO3fsZPT0DLfaQ50jtCUv1+42i+PrcHE8sun2FnDWvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LTeVw3kM; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710406507; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QiFeYd6wUaKsOKMScaG1ih0veDz06hfJGSMp8ER6qzk=;
	b=LTeVw3kMh/aNpdkGTgkW15HpApqMuJdFQa/Cl+LlWLF6+cE8yUZZj8tlLQ+MpYWJUaG99EUUKjXGuLM+OCFEah5eaCCO74a20yrOgb+d7GF9bHL8+FVfwWgOJ3lNT/c9aJkn5mCFRE9SlNQOjKtPrwjcbVpd4lFNWtc+mmiSdeA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2S2VIN_1710406505;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2S2VIN_1710406505)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 16:55:05 +0800
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
Subject: [PATCH net-next v4 4/8] virtio_net: stats map include driver stats
Date: Thu, 14 Mar 2024 16:54:55 +0800
Message-Id: <20240314085459.115933-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 76259b0090f3
Content-Transfer-Encoding: 8bit

In the last commit, we use the stats map to manage the device stats.

Managing driver statistics separately can be inconvenient. To streamline
the process, I propose integrating driver stats into the existing stats
map. This integration will allow us to uniformly handle all statistics
through a single method, simplifying management and reducing complexity
in our codebase.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 200 +++++++++++++++++++--------------------
 1 file changed, 99 insertions(+), 101 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d1f389316e71..e127915a20bd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -102,32 +102,29 @@ struct virtnet_rq_stats {
 	u64_stats_t kicks;
 };
 
-#define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
-#define VIRTNET_RQ_STAT(m)	offsetof(struct virtnet_rq_stats, m)
+#define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m)}
+#define VIRTNET_RQ_STAT(name, m) {name, offsetof(struct virtnet_rq_stats, m)}
 
 static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
-	{ "packets",		VIRTNET_SQ_STAT(packets) },
-	{ "bytes",		VIRTNET_SQ_STAT(bytes) },
-	{ "xdp_tx",		VIRTNET_SQ_STAT(xdp_tx) },
-	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
-	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
-	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
+	VIRTNET_SQ_STAT("packets",      packets),
+	VIRTNET_SQ_STAT("bytes",        bytes),
+	VIRTNET_SQ_STAT("xdp_tx",       xdp_tx),
+	VIRTNET_SQ_STAT("xdp_tx_drops", xdp_tx_drops),
+	VIRTNET_SQ_STAT("kicks",        kicks),
+	VIRTNET_SQ_STAT("tx_timeouts",  tx_timeouts),
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
-	{ "packets",		VIRTNET_RQ_STAT(packets) },
-	{ "bytes",		VIRTNET_RQ_STAT(bytes) },
-	{ "drops",		VIRTNET_RQ_STAT(drops) },
-	{ "xdp_packets",	VIRTNET_RQ_STAT(xdp_packets) },
-	{ "xdp_tx",		VIRTNET_RQ_STAT(xdp_tx) },
-	{ "xdp_redirects",	VIRTNET_RQ_STAT(xdp_redirects) },
-	{ "xdp_drops",		VIRTNET_RQ_STAT(xdp_drops) },
-	{ "kicks",		VIRTNET_RQ_STAT(kicks) },
+	VIRTNET_RQ_STAT("packets",       packets),
+	VIRTNET_RQ_STAT("bytes",         bytes),
+	VIRTNET_RQ_STAT("drops",         drops),
+	VIRTNET_RQ_STAT("xdp_packets",   xdp_packets),
+	VIRTNET_RQ_STAT("xdp_tx",        xdp_tx),
+	VIRTNET_RQ_STAT("xdp_redirects", xdp_redirects),
+	VIRTNET_RQ_STAT("xdp_drops",     xdp_drops),
+	VIRTNET_RQ_STAT("kicks",         kicks),
 };
 
-#define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
-#define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
-
 #define VIRTNET_STATS_DESC_CQ(name) \
 	{#name, offsetof(struct virtio_net_stats_cvq, name)}
 
@@ -208,10 +205,10 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
 #define VIRTNET_Q_TYPE_CQ 2
 
 struct virtnet_stats_map {
-	/* The stat type in bitmap. */
+	/* The stat type in bitmap. Just for device stats. */
 	u64 stat_type;
 
-	/* The bytes of the response for the stat. */
+	/* The bytes of the response for the stat. Just for device stats. */
 	u32 len;
 
 	/* The num of the response fields for the stat. */
@@ -220,9 +217,12 @@ struct virtnet_stats_map {
 	/* The type of queue corresponding to the statistics. (cq, rq, sq) */
 	u32 queue_type;
 
-	/* The reply type of the stat. */
+	/* The reply type of the stat. Just for device stats. */
 	u8 reply_type;
 
+	/* The stats are counted by the driver. */
+	bool from_driver;
+
 	/* Describe the name and the offset in the response. */
 	const struct virtnet_stat_desc *desc;
 };
@@ -234,10 +234,24 @@ struct virtnet_stats_map {
 		ARRAY_SIZE(virtnet_stats_ ## type ##_desc),	\
 		VIRTNET_Q_TYPE_##queue_type,			\
 		VIRTIO_NET_STATS_TYPE_REPLY_##TYPE,		\
+		false,						\
 		&virtnet_stats_##type##_desc[0]			\
 	}
 
+#define VIRTNET_DRIVER_STATS_MAP_ITEM(type, queue_type)		\
+	{							\
+		0, 0,						\
+		ARRAY_SIZE(virtnet_ ## type ## _stats_desc),	\
+		VIRTNET_Q_TYPE_##queue_type,			\
+		0, true,					\
+		&virtnet_##type##_stats_desc[0]			\
+	}
+
 static struct virtnet_stats_map virtio_net_stats_map[] = {
+	/* Driver stats should on the start. */
+	VIRTNET_DRIVER_STATS_MAP_ITEM(rq, RX),
+	VIRTNET_DRIVER_STATS_MAP_ITEM(sq, TX),
+
 	VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
 
 	VIRTNET_DEVICE_STATS_MAP_ITEM(RX_BASIC, rx_basic, RX),
@@ -251,6 +265,11 @@ static struct virtnet_stats_map virtio_net_stats_map[] = {
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
@@ -2266,7 +2285,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 
 	u64_stats_set(&stats.packets, packets);
 	u64_stats_update_begin(&rq->stats.syncp);
-	for (i = 0; i < VIRTNET_RQ_STATS_LEN; i++) {
+	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
 		size_t offset = virtnet_rq_stats_desc[i].offset;
 		u64_stats_t *item, *src;
 
@@ -3400,38 +3419,34 @@ static int virtnet_set_channels(struct net_device *dev,
 	return err;
 }
 
-static void virtnet_get_hw_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
+static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
 {
 	struct virtnet_stats_map *m;
+	const char *tp, *hw, *desc;
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
 
+		hw = m->from_driver ? "" : "_hw";
+		tp = type == VIRTNET_Q_TYPE_RX ? "rx" : "tx";
+
 		for (j = 0; j < m->num; ++j) {
-			switch (type) {
-			case VIRTNET_Q_TYPE_RX:
-				ethtool_sprintf(&p, "rx_queue_hw_%u_%s", qid, m->desc[j].desc);
-				break;
-
-			case VIRTNET_Q_TYPE_TX:
-				ethtool_sprintf(&p, "tx_queue_hw_%u_%s", qid, m->desc[j].desc);
-				break;
-
-			case VIRTNET_Q_TYPE_CQ:
-				ethtool_sprintf(&p, "cq_hw_%s", m->desc[j].desc);
-				break;
+			desc = m->desc[j].desc;
+
+			if (type == VIRTNET_Q_TYPE_CQ) {
+				ethtool_sprintf(&p, "cq%s_%s", hw, desc);
+				continue;
 			}
+
+			ethtool_sprintf(&p, "%s_queue%s_%u_%s", tp, hw, qid, desc);
 		}
 	}
 
@@ -3460,7 +3475,7 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
 		m = &virtio_net_stats_map[i];
 
-		if (!(vi->device_stats_cap & m->stat_type))
+		if (!virtnet_stats_supported(vi, m))
 			continue;
 
 		ctx->bitmap[m->queue_type]   |= m->stat_type;
@@ -3470,54 +3485,67 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 }
 
 /* virtnet_fill_stats - copy the stats to ethtool -S
- * The stats source is the device.
+ * The stats source is the device or the driver.
  *
  * @vi: virtio net info
  * @qid: the vq id
  * @ctx: stats ctx (initiated by virtnet_stats_ctx_init())
- * @base: pointer to the device reply.
- * @type: the type of the device reply
+ * @base: pointer to the device reply or the driver stats structure.
+ * @from_driver: designate the base type (device reply, driver stats)
+ * @type: the type of the device reply (if from_driver is true, this must be
+ *     zero)
  */
 static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 			       struct virtnet_stats_ctx *ctx,
-			       const u8 *base, u8 type)
+			       const u8 *base, bool from_driver, u8 type)
 {
 	u32 queue_type, num_rx, num_tx, num_cq;
+	const struct virtnet_stat_desc *desc;
 	struct virtnet_stats_map *m;
-	u64 offset, bitmap;
+	const u64_stats_t *v_stat;
 	const __le64 *v;
+	u64 offset;
 	int i, j;
 
-	num_rx = VIRTNET_RQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_RX];
-	num_tx = VIRTNET_SQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_TX];
 	num_cq = ctx->desc_num[VIRTNET_Q_TYPE_CQ];
+	num_rx = ctx->desc_num[VIRTNET_Q_TYPE_RX];
+	num_tx = ctx->desc_num[VIRTNET_Q_TYPE_TX];
 
 	queue_type = vq_type(vi, qid);
-	bitmap = ctx->bitmap[queue_type];
 	offset = 0;
 
-	if (queue_type == VIRTNET_Q_TYPE_TX) {
+	if (queue_type == VIRTNET_Q_TYPE_TX)
 		offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
-		offset += VIRTNET_SQ_STATS_LEN;
-	} else if (queue_type == VIRTNET_Q_TYPE_RX) {
-		offset = num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_LEN;
-	}
+	else if (queue_type == VIRTNET_Q_TYPE_RX)
+		offset = num_cq + num_rx * (qid / 2);
 
 	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
 		m = &virtio_net_stats_map[i];
 
-		if (m->stat_type & bitmap)
-			offset += m->num;
+		if (m->queue_type != queue_type)
+			continue;
+
+		if (from_driver != m->from_driver)
+			goto skip;
 
 		if (type != m->reply_type)
-			continue;
+			goto skip;
 
 		for (j = 0; j < m->num; ++j) {
-			v = (const __le64 *)(base + m->desc[j].offset);
-			ctx->data[offset + j] = le64_to_cpu(*v);
+			desc = &m->desc[j];
+			if (!from_driver) {
+				v = (const __le64 *)(base + desc->offset);
+				ctx->data[offset + j] = le64_to_cpu(*v);
+			} else {
+				v_stat = (const u64_stats_t *)(base + desc->offset);
+				ctx->data[offset + j] = u64_stats_read(v_stat);
+			}
 		}
 
 		break;
+skip:
+		if (virtnet_stats_supported(vi, m))
+			offset += m->num;
 	}
 }
 
@@ -3548,7 +3576,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
 		qid = le16_to_cpu(hdr->vq_index);
-		virtnet_fill_stats(vi, qid, ctx, p, hdr->type);
+		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
 	}
 
 	kfree(reply);
@@ -3620,28 +3648,18 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	unsigned int i, j;
+	unsigned int i;
 	u8 *p = data;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_CQ, 0, &p);
+		virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_CQ, 0, &p);
 
-		for (i = 0; i < vi->curr_queue_pairs; i++) {
-			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
-				ethtool_sprintf(&p, "rx_queue_%u_%s", i,
-						virtnet_rq_stats_desc[j].desc);
+		for (i = 0; i < vi->curr_queue_pairs; ++i)
+			virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_RX, i, &p);
 
-			virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_RX, i, &p);
-		}
-
-		for (i = 0; i < vi->curr_queue_pairs; i++) {
-			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
-				ethtool_sprintf(&p, "tx_queue_%u_%s", i,
-						virtnet_sq_stats_desc[j].desc);
-
-			virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_TX, i, &p);
-		}
+		for (i = 0; i < vi->curr_queue_pairs; ++i)
+			virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_TX, i, &p);
 		break;
 	}
 }
@@ -3674,8 +3692,7 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
 
 		virtnet_stats_ctx_init(vi, &ctx, NULL);
 
-		pair_count = VIRTNET_RQ_STATS_LEN + VIRTNET_SQ_STATS_LEN;
-		pair_count += ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.desc_num[VIRTNET_Q_TYPE_TX];
+		pair_count = ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.desc_num[VIRTNET_Q_TYPE_TX];
 
 		return ctx.desc_num[VIRTNET_Q_TYPE_CQ] + vi->curr_queue_pairs * pair_count;
 	default:
@@ -3688,47 +3705,28 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct virtnet_stats_ctx ctx = {0};
-	unsigned int idx, start, i, j;
+	unsigned int start, i;
 	const u8 *stats_base;
-	const u64_stats_t *p;
-	size_t offset;
 
 	virtnet_stats_ctx_init(vi, &ctx, data);
 	if (virtnet_get_hw_stats(vi, &ctx))
 		dev_warn(&vi->dev->dev, "Failed to get hw stats.\n");
 
-	idx = ctx.desc_num[VIRTNET_Q_TYPE_CQ];
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
-		idx += ctx.desc_num[VIRTNET_Q_TYPE_RX];
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
-		idx += ctx.desc_num[VIRTNET_Q_TYPE_TX];
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


