Return-Path: <netdev+bounces-79816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D995487B9D5
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 09:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918AF28374F
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CDA6D1B2;
	Thu, 14 Mar 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qWypFDPt"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B46BFDC;
	Thu, 14 Mar 2024 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406516; cv=none; b=MaLxxd2/cdZdSeLne0/ThbVsXG9at6jDQhnL7XHPYZkNys1rRuR4/MZ/nhDrssy4NJFI6MVIUMOLmLiIHNlH66HW3OOGfqCAIHGu6LbX0SxobsV+2zNR4C3/gEL8h6HESAjEJJ6YrWieiYgxQpIPFw7ZA4NfbmRbqQmFk6o/noA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406516; c=relaxed/simple;
	bh=DO52Ju4188zpX06ZisrV189B78C+myiB2XCM8tpADNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmUSF4Pv8DXNemY1KjbMelOv/49LMmpteuGjNhfnSVGVXgGU5iSEADQK7zTDXJQdB6ntkhJc2d2DfrVzlKq4xoOOVm5QHNyHC5q3uyosQQu5gF72v5XCIBO1+A9K1016XZCtwZSSv6hup0hWIOFjalPh32rmqIKLjeaP1oIMqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qWypFDPt; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710406512; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FQkFfqe9owyn4QRszlRMhlAjQzbUKIgXZsFJ9PU7xCQ=;
	b=qWypFDPt8lGz5HiVUScI+vt1mKVM/1W1WAxKRoHhGOmV1TY9Bx0WSAILH+5jeH5v/pN9RmhANlg5wb3h6nR++xys62rUpFcglTehRT0upHrbOAuTga6bsHshnWktYcYgS/u1Svyllkp6cY+SpLwmfc3Y47ib9FcjheVHHn0xj2g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2S1OGK_1710406509;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2S1OGK_1710406509)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 16:55:10 +0800
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
Subject: [PATCH net-next v4 8/8] virtio-net: support queue stat
Date: Thu, 14 Mar 2024 16:54:59 +0800
Message-Id: <20240314085459.115933-9-xuanzhuo@linux.alibaba.com>
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

To enhance functionality, we now support reporting statistics through
the netdev-generic netlink (netdev-genl) queue stats interface. However,
this does not extend to all statistics, so a new field, qstat_offset,
has been introduced. This field determines which statistics should be
reported via netdev-genl queue stats.

Given that queue stats are retrieved individually per queue, it's
necessary for the virtnet_get_hw_stats() function to be capable of
fetching statistics for a specific queue.

python3 ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml
    --dump qstats-get --json '{"scope": "queue"}'
[{'ifindex': 2,
  'queue-id': 0,
  'queue-type': 'rx',
  'rx-bytes': 157844011,
  'rx-csum-bad': 0,
  'rx-csum-none': 0,
  'rx-csum-unnecessary': 2195386,
  'rx-hw-drop-overruns': 0,
  'rx-hw-drop-ratelimits': 0,
  'rx-hw-drops': 12964,
  'rx-packets': 598929},
 {'ifindex': 2,
  'queue-id': 0,
  'queue-type': 'tx',
  'tx-bytes': 1938511,
  'tx-csum-none': 0,
  'tx-hw-drop-errors': 0,
  'tx-hw-drop-ratelimits': 0,
  'tx-hw-drops': 0,
  'tx-needs-csum': 61263,
  'tx-packets': 15515}]

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 191 ++++++++++++++++++++++++++++++---------
 1 file changed, 148 insertions(+), 43 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d48985d61418..3e6ebfa1f4a5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -24,6 +24,7 @@
 #include <net/xdp.h>
 #include <net/net_failover.h>
 #include <net/netdev_rx_queue.h>
+#include <net/netdev_queues.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -78,6 +79,7 @@ static const unsigned long guest_offloads[] = {
 struct virtnet_stat_desc {
 	char desc[ETH_GSTRING_LEN];
 	size_t offset;
+	int qstat_offset;
 };
 
 struct virtnet_sq_stats {
@@ -102,12 +104,27 @@ struct virtnet_rq_stats {
 	u64_stats_t kicks;
 };
 
-#define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m)}
-#define VIRTNET_RQ_STAT(name, m) {name, offsetof(struct virtnet_rq_stats, m)}
+#define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m), -1}
+#define VIRTNET_RQ_STAT(name, m) {name, offsetof(struct virtnet_rq_stats, m), -1}
+
+#define VIRTNET_SQ_STAT_QSTAT(name, m)				\
+	{							\
+		name,						\
+		offsetof(struct virtnet_sq_stats, m),		\
+		offsetof(struct netdev_queue_stats_tx, m),	\
+	}
+
+#define VIRTNET_RQ_STAT_QSTAT(name, m)				\
+	{							\
+		name,						\
+		offsetof(struct virtnet_rq_stats, m),		\
+		offsetof(struct netdev_queue_stats_rx, m),	\
+	}
 
 static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
-	VIRTNET_SQ_STAT("packets",      packets),
-	VIRTNET_SQ_STAT("bytes",        bytes),
+	VIRTNET_SQ_STAT_QSTAT("packets", packets),
+	VIRTNET_SQ_STAT_QSTAT("bytes",   bytes),
+
 	VIRTNET_SQ_STAT("xdp_tx",       xdp_tx),
 	VIRTNET_SQ_STAT("xdp_tx_drops", xdp_tx_drops),
 	VIRTNET_SQ_STAT("kicks",        kicks),
@@ -115,8 +132,9 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
-	VIRTNET_RQ_STAT("packets",       packets),
-	VIRTNET_RQ_STAT("bytes",         bytes),
+	VIRTNET_RQ_STAT_QSTAT("packets", packets),
+	VIRTNET_RQ_STAT_QSTAT("bytes",   bytes),
+
 	VIRTNET_RQ_STAT("drops",         drops),
 	VIRTNET_RQ_STAT("xdp_packets",   xdp_packets),
 	VIRTNET_RQ_STAT("xdp_tx",        xdp_tx),
@@ -129,10 +147,24 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 	{#name, offsetof(struct virtio_net_stats_cvq, name)}
 
 #define VIRTNET_STATS_DESC_RX(class, name) \
-	{#name, offsetof(struct virtio_net_stats_rx_ ## class, rx_ ## name)}
+	{#name, offsetof(struct virtio_net_stats_rx_ ## class, rx_ ## name), -1}
 
 #define VIRTNET_STATS_DESC_TX(class, name) \
-	{#name, offsetof(struct virtio_net_stats_tx_ ## class, tx_ ## name)}
+	{#name, offsetof(struct virtio_net_stats_tx_ ## class, tx_ ## name), -1}
+
+#define VIRTNET_STATS_DESC_RX_QSTAT(class, name, qstat_field)			\
+	{									\
+		#name,								\
+		offsetof(struct virtio_net_stats_rx_ ## class, rx_ ## name),	\
+		offsetof(struct netdev_queue_stats_rx, qstat_field),		\
+	}
+
+#define VIRTNET_STATS_DESC_TX_QSTAT(class, name, qstat_field)			\
+	{									\
+		#name,								\
+		offsetof(struct virtio_net_stats_tx_ ## class, tx_ ## name),	\
+		offsetof(struct netdev_queue_stats_tx, qstat_field),		\
+	}
 
 static const struct virtnet_stat_desc virtnet_stats_cvq_desc[] = {
 	VIRTNET_STATS_DESC_CQ(command_num),
@@ -146,8 +178,8 @@ static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc[] = {
 	VIRTNET_STATS_DESC_RX(basic, notifications),
 	VIRTNET_STATS_DESC_RX(basic, interrupts),
 
-	VIRTNET_STATS_DESC_RX(basic, drops),
-	VIRTNET_STATS_DESC_RX(basic, drop_overruns),
+	VIRTNET_STATS_DESC_RX_QSTAT(basic, drops,         hw_drops),
+	VIRTNET_STATS_DESC_RX_QSTAT(basic, drop_overruns, hw_drop_overruns),
 };
 
 static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc[] = {
@@ -157,46 +189,47 @@ static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc[] = {
 	VIRTNET_STATS_DESC_TX(basic, notifications),
 	VIRTNET_STATS_DESC_TX(basic, interrupts),
 
-	VIRTNET_STATS_DESC_TX(basic, drops),
-	VIRTNET_STATS_DESC_TX(basic, drop_malformed),
+	VIRTNET_STATS_DESC_TX_QSTAT(basic, drops,          hw_drops),
+	VIRTNET_STATS_DESC_TX_QSTAT(basic, drop_malformed, hw_drop_errors),
 };
 
 static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc[] = {
-	VIRTNET_STATS_DESC_RX(csum, csum_valid),
-	VIRTNET_STATS_DESC_RX(csum, needs_csum),
+	VIRTNET_STATS_DESC_RX_QSTAT(csum, csum_valid, csum_unnecessary),
+	VIRTNET_STATS_DESC_RX_QSTAT(csum, csum_none,  csum_none),
+	VIRTNET_STATS_DESC_RX_QSTAT(csum, csum_bad,   csum_bad),
 
-	VIRTNET_STATS_DESC_RX(csum, csum_none),
-	VIRTNET_STATS_DESC_RX(csum, csum_bad),
+	VIRTNET_STATS_DESC_RX(csum, needs_csum),
 };
 
 static const struct virtnet_stat_desc virtnet_stats_tx_csum_desc[] = {
-	VIRTNET_STATS_DESC_TX(csum, needs_csum),
-	VIRTNET_STATS_DESC_TX(csum, csum_none),
+	VIRTNET_STATS_DESC_TX_QSTAT(csum, csum_none,  csum_none),
+	VIRTNET_STATS_DESC_TX_QSTAT(csum, needs_csum, needs_csum),
 };
 
 static const struct virtnet_stat_desc virtnet_stats_rx_gso_desc[] = {
-	VIRTNET_STATS_DESC_RX(gso, gso_packets),
-	VIRTNET_STATS_DESC_RX(gso, gso_bytes),
-	VIRTNET_STATS_DESC_RX(gso, gso_packets_coalesced),
-	VIRTNET_STATS_DESC_RX(gso, gso_bytes_coalesced),
+	VIRTNET_STATS_DESC_RX_QSTAT(gso, gso_packets,           hw_gro_packets),
+	VIRTNET_STATS_DESC_RX_QSTAT(gso, gso_bytes,             hw_gro_bytes),
+	VIRTNET_STATS_DESC_RX_QSTAT(gso, gso_packets_coalesced, hw_gro_wire_packets),
+	VIRTNET_STATS_DESC_RX_QSTAT(gso, gso_bytes_coalesced,   hw_gro_wire_bytes),
 };
 
 static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc[] = {
-	VIRTNET_STATS_DESC_TX(gso, gso_packets),
-	VIRTNET_STATS_DESC_TX(gso, gso_bytes),
-	VIRTNET_STATS_DESC_TX(gso, gso_segments),
-	VIRTNET_STATS_DESC_TX(gso, gso_segments_bytes),
+	VIRTNET_STATS_DESC_TX_QSTAT(gso, gso_packets,        hw_gso_packets),
+	VIRTNET_STATS_DESC_TX_QSTAT(gso, gso_bytes,          hw_gso_bytes),
+	VIRTNET_STATS_DESC_TX_QSTAT(gso, gso_segments,       hw_gso_wire_packets),
+	VIRTNET_STATS_DESC_TX_QSTAT(gso, gso_segments_bytes, hw_gso_wire_bytes),
+
 	VIRTNET_STATS_DESC_TX(gso, gso_packets_noseg),
 	VIRTNET_STATS_DESC_TX(gso, gso_bytes_noseg),
 };
 
 static const struct virtnet_stat_desc virtnet_stats_rx_speed_desc[] = {
-	VIRTNET_STATS_DESC_RX(speed, packets_allowance_exceeded),
+	VIRTNET_STATS_DESC_RX_QSTAT(speed, packets_allowance_exceeded, hw_drop_ratelimits),
 	VIRTNET_STATS_DESC_RX(speed, bytes_allowance_exceeded),
 };
 
 static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
-	VIRTNET_STATS_DESC_TX(speed, packets_allowance_exceeded),
+	VIRTNET_STATS_DESC_TX_QSTAT(speed, packets_allowance_exceeded, hw_drop_ratelimits),
 	VIRTNET_STATS_DESC_TX(speed, packets_allowance_exceeded),
 };
 
@@ -3458,6 +3491,9 @@ static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid,
 }
 
 struct virtnet_stats_ctx {
+	/* the stats are write to qstats or ethtool -S */
+	bool to_qstat;
+
 	u32 desc_num[3];
 
 	u32 bitmap[3];
@@ -3469,12 +3505,13 @@ struct virtnet_stats_ctx {
 
 static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 				   struct virtnet_stats_ctx *ctx,
-				   u64 *data)
+				   u64 *data, bool to_qstat)
 {
 	struct virtnet_stats_map *m;
 	int i;
 
 	ctx->data = data;
+	ctx->to_qstat = to_qstat;
 
 	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
 		m = &virtio_net_stats_map[i];
@@ -3531,7 +3568,7 @@ static void virtnet_fill_total_fields(struct virtnet_info *vi,
 	stats_sum_queue(data, num_tx, first_tx_q, vi->curr_queue_pairs);
 }
 
-/* virtnet_fill_stats - copy the stats to ethtool -S
+/* virtnet_fill_stats - copy the stats to qstats or ethtool -S
  * The stats source is the device or the driver.
  *
  * @vi: virtio net info
@@ -3550,8 +3587,8 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 	const struct virtnet_stat_desc *desc;
 	struct virtnet_stats_map *m;
 	const u64_stats_t *v_stat;
+	u64 offset, value;
 	const __le64 *v;
-	u64 offset;
 	int i, j;
 
 	num_cq = ctx->desc_num[VIRTNET_Q_TYPE_CQ];
@@ -3584,10 +3621,21 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 			desc = &m->desc[j];
 			if (!from_driver) {
 				v = (const __le64 *)(base + desc->offset);
-				ctx->data[offset + j] = le64_to_cpu(*v);
+				value = le64_to_cpu(*v);
 			} else {
 				v_stat = (const u64_stats_t *)(base + desc->offset);
-				ctx->data[offset + j] = u64_stats_read(v_stat);
+				value = u64_stats_read(v_stat);
+			}
+
+			if (ctx->to_qstat) {
+				/* store to the queue stats structure */
+				if (desc->qstat_offset >= 0) {
+					offset = desc->qstat_offset / sizeof(*ctx->data);
+					ctx->data[offset] = value;
+				}
+			} else {
+				/* store to the ethtool -S data area */
+				ctx->data[offset + j] = value;
 			}
 		}
 
@@ -3648,21 +3696,33 @@ static void virtnet_make_stat_req(struct virtnet_info *vi,
 	*idx += 1;
 }
 
+/* qid: -1: get stats of all vq.
+ *     > 0: get the stats for the special vq. This must not be cvq.
+ */
 static int virtnet_get_hw_stats(struct virtnet_info *vi,
-				struct virtnet_stats_ctx *ctx)
+				struct virtnet_stats_ctx *ctx, int qid)
 {
+	int qnum, i, j, res_size, qtype, last_vq, first_vq;
 	struct virtio_net_ctrl_queue_stats *req;
-	int qnum, i, j, res_size, qtype, last_vq;
+	bool enable_cvq;
 	void *reply;
 
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
 		return 0;
 
-	last_vq = vi->curr_queue_pairs * 2 - 1;
+	if (qid == -1) {
+		last_vq = vi->curr_queue_pairs * 2 - 1;
+		first_vq = 0;
+		enable_cvq = true;
+	} else {
+		last_vq = qid;
+		first_vq = qid;
+		enable_cvq = false;
+	}
 
 	qnum = 0;
 	res_size = 0;
-	for (i = 0; i <= last_vq ; ++i) {
+	for (i = first_vq; i <= last_vq ; ++i) {
 		qtype = vq_type(vi, i);
 		if (ctx->bitmap[qtype]) {
 			++qnum;
@@ -3670,7 +3730,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 		}
 	}
 
-	if (ctx->bitmap[VIRTNET_Q_TYPE_CQ]) {
+	if (enable_cvq && ctx->bitmap[VIRTNET_Q_TYPE_CQ]) {
 		res_size += ctx->size[VIRTNET_Q_TYPE_CQ];
 		qnum += 1;
 	}
@@ -3686,10 +3746,11 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	}
 
 	j = 0;
-	for (i = 0; i <= last_vq ; ++i)
+	for (i = first_vq; i <= last_vq ; ++i)
 		virtnet_make_stat_req(vi, ctx, req, i, &j);
 
-	virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
+	if (enable_cvq)
+		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
 
 	return __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
 }
@@ -3742,7 +3803,7 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
 			}
 		}
 
-		virtnet_stats_ctx_init(vi, &ctx, NULL);
+		virtnet_stats_ctx_init(vi, &ctx, NULL, false);
 
 		pair_count = ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.desc_num[VIRTNET_Q_TYPE_TX];
 
@@ -3761,8 +3822,8 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 	unsigned int start, i;
 	const u8 *stats_base;
 
-	virtnet_stats_ctx_init(vi, &ctx, data);
-	if (virtnet_get_hw_stats(vi, &ctx))
+	virtnet_stats_ctx_init(vi, &ctx, data, false);
+	if (virtnet_get_hw_stats(vi, &ctx, -1))
 		dev_warn(&vi->dev->dev, "Failed to get hw stats.\n");
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
@@ -4301,6 +4362,49 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
+static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
+				       struct netdev_queue_stats_rx *stats)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct receive_queue *rq = &vi->rq[i];
+	struct virtnet_stats_ctx ctx = {0};
+
+	virtnet_stats_ctx_init(vi, &ctx, (void *)stats, true);
+
+	virtnet_get_hw_stats(vi, &ctx, i * 2);
+	virtnet_fill_stats(vi, i * 2, &ctx, (void *)&rq->stats, true, 0);
+}
+
+static void virtnet_get_queue_stats_tx(struct net_device *dev, int i,
+				       struct netdev_queue_stats_tx *stats)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct send_queue *sq = &vi->sq[i];
+	struct virtnet_stats_ctx ctx = {0};
+
+	virtnet_stats_ctx_init(vi, &ctx, (void *)stats, true);
+
+	virtnet_get_hw_stats(vi, &ctx, i * 2 + 1);
+	virtnet_fill_stats(vi, i * 2 + 1, &ctx, (void *)&sq->stats, true, 0);
+}
+
+static void virtnet_get_base_stats(struct net_device *dev,
+				   struct netdev_queue_stats_rx *rx,
+				   struct netdev_queue_stats_tx *tx)
+{
+	/* The queue stats of the virtio-net will not be reset. So here we
+	 * return 0.
+	 */
+	memset(rx, 0, sizeof(*rx));
+	memset(tx, 0, sizeof(*tx));
+}
+
+static const struct netdev_stat_ops virtnet_stat_ops = {
+	.get_queue_stats_rx	= virtnet_get_queue_stats_rx,
+	.get_queue_stats_tx	= virtnet_get_queue_stats_tx,
+	.get_base_stats		= virtnet_get_base_stats,
+};
+
 static void virtnet_freeze_down(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
@@ -5060,6 +5164,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE |
 			   IFF_TX_SKB_NO_LINEAR;
 	dev->netdev_ops = &virtnet_netdev;
+	dev->stat_ops = &virtnet_stat_ops;
 	dev->features = NETIF_F_HIGHDMA;
 
 	dev->ethtool_ops = &virtnet_ethtool_ops;
-- 
2.32.0.3.g01195cf9f


