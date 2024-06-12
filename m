Return-Path: <netdev+bounces-102955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F383A9059A0
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EE31C22753
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDE51836ED;
	Wed, 12 Jun 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yDzs+14r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EBA1836E9
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212137; cv=none; b=lhf3oGA7WUkguQSq1m0SBEtXXdhIxO5usilGBdsqUhANngvZLY10Oj5RNlRqmJtbQRy6pj7iSMY5pSYaz2Ij7WhtZUzgF0BY8qg9DiQqdy5F9yOlyDxqoI4J9Hg1w37lZgQwdBPiiypYoh1n6xD0Z4uIpEtErcVkHGoXsDS1+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212137; c=relaxed/simple;
	bh=ehhpo/SsPl+jO5Cm/RZD7FkvtzJ8YrUg+VPu+Ir8zOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDmw0zIWfikWIhEF/x+7N6JpgxoHROug8uhOuOki/Xsaer/J/XAiYFXedX4AaEuwSISLbJ5vGv2IanSxUj/JfNCSa7XBIAJOARAgXjwMRZKUsGZ5CheysXyrP+x6lvwNg1nblJjtde2uI+RCG6nHnxYdnCdO8SbV8xLHJFRBQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yDzs+14r; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42138eadf64so894725e9.3
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718212133; x=1718816933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hs80+4gULAKFtbcZATRfAFutwZtvYFCLdFppd1JyzNg=;
        b=yDzs+14rpAH3ZtRhFP42MNdUI1Mr8chi+S5ZagJWq9xRSwtFT3jSHRxy8Z14S4d9qv
         tvBqZIhREByrRuf4GzMcQv/hW6iBKWwbMocVzzXv9HDdC2aLYBZegwACtipMvBNj0tWD
         Q+SfDEmMchyyDFb6sovTNsTvHGRuAQ4a5lwE/nefx7/V76R4efH7/Yg/ZrLxX42/+JWJ
         DaZstT7GTvaPGGLoFqT0X0E02RdHhZnqc10h3JXffrhllGm94swhzdOBnhuLYh7me12u
         E6OR75tZyRqgcauIpzv8tw6WpfFTgY+ZP5M2xjzUviA4Mlhvl82byJ4uIOIfalVCMM7J
         VRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718212133; x=1718816933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hs80+4gULAKFtbcZATRfAFutwZtvYFCLdFppd1JyzNg=;
        b=GNkAaL14cbx0bOL3uOGgUwC0VMn4Q37qpF0TDGQzLDIbzGMkeUewbVtAcQOm/dHdNP
         MsVy6EfvKdBppJ9xouXKboc97WePZMp6fEGPpBLW9tYjGh8JUx/E69+dqn8C7pYWdujw
         pdH5jBhfQwHIeRLePpxxCQ2bTTbJXSIfFWFiWsLZ3eMpGCUi5RBpcCxV8ZXRNWWfczL5
         snt8LXoo23RtWL/KndvbYnnY5SNJf8dbGwulh0JeTha0o88/Jh9tIgfzYh0V02MWvVBO
         owHgGkG5DJ+CF01DUiI4Zj2YyA0syJ0+DrizXPFKRzLZGs3RwReeNi7VMB7paGiMbhOF
         OYdg==
X-Gm-Message-State: AOJu0YwTnPNeUDBLtP79lE2BGIXqeUiQibUQuAeu1gg2dyvzY5b6efoT
	qQA/VL9vIbvVWkqu8x9wL1kprRkDFpCUuSgx+Jz4i0OvNs1vCDNJHEtWz0Es9IadAtdAoLe1WjM
	I01s=
X-Google-Smtp-Source: AGHT+IETaybsGXPKig6yyoOYHXuEFIM4ZppEUklkjbaecVf1wThk5HX0fOyzM26uVRTUqVB6Tz+Quw==
X-Received: by 2002:a05:600c:4ec9:b0:421:7ee4:bbf0 with SMTP id 5b1f17b1804b1-42285c6d02bmr25298525e9.0.1718212132883;
        Wed, 12 Jun 2024 10:08:52 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1846574esm12175819f8f.117.2024.06.12.10.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 10:08:52 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	dave.taht@gmail.com,
	kerneljasonxing@gmail.com,
	hengqi@linux.alibaba.com
Subject: [PATCH net-next v2] virtio_net: add support for Byte Queue Limits
Date: Wed, 12 Jun 2024 19:08:51 +0200
Message-ID: <20240612170851.1004604-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add support for Byte Queue Limits (BQL).

Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
running in background. Netperf TCP_RR results:

NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
  BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
  BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
  BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
  BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
  BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
  BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- moved netdev_tx_completed_queue() call into __free_old_xmit(),
  propagate use_napi flag to __free_old_xmit() and only call
  netdev_tx_completed_queue() in case it is true
- added forgotten call to netdev_tx_reset_queue()
- fixed stats for xdp packets
- fixed bql accounting when __free_old_xmit() is called from xdp path
- handle the !use_napi case in start_xmit() kick section
---
 drivers/net/virtio_net.c | 50 +++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d134544..5863c663ccab 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -84,7 +84,9 @@ struct virtnet_stat_desc {
 
 struct virtnet_sq_free_stats {
 	u64 packets;
+	u64 xdp_packets;
 	u64 bytes;
+	u64 xdp_bytes;
 };
 
 struct virtnet_sq_stats {
@@ -506,29 +508,33 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
-static void __free_old_xmit(struct send_queue *sq, bool in_napi,
+static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
+			    bool in_napi, bool use_napi,
 			    struct virtnet_sq_free_stats *stats)
 {
 	unsigned int len;
 	void *ptr;
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		++stats->packets;
-
 		if (!is_xdp_frame(ptr)) {
 			struct sk_buff *skb = ptr;
 
 			pr_debug("Sent skb %p\n", skb);
 
+			stats->packets++;
 			stats->bytes += skb->len;
 			napi_consume_skb(skb, in_napi);
 		} else {
 			struct xdp_frame *frame = ptr_to_xdp(ptr);
 
-			stats->bytes += xdp_get_frame_len(frame);
+			stats->xdp_packets++;
+			stats->xdp_bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
 		}
 	}
+	if (use_napi)
+		netdev_tx_completed_queue(txq, stats->packets, stats->bytes);
+
 }
 
 /* Converting between virtqueue no. and kernel tx/rx queue no.
@@ -955,21 +961,22 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 	virtnet_rq_free_buf(vi, rq, buf);
 }
 
-static void free_old_xmit(struct send_queue *sq, bool in_napi)
+static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
+			  bool in_napi, bool use_napi)
 {
 	struct virtnet_sq_free_stats stats = {0};
 
-	__free_old_xmit(sq, in_napi, &stats);
+	__free_old_xmit(sq, txq, in_napi, use_napi, &stats);
 
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
 	 */
-	if (!stats.packets)
+	if (!stats.packets && !stats.xdp_packets)
 		return;
 
 	u64_stats_update_begin(&sq->stats.syncp);
-	u64_stats_add(&sq->stats.bytes, stats.bytes);
-	u64_stats_add(&sq->stats.packets, stats.packets);
+	u64_stats_add(&sq->stats.bytes, stats.bytes + stats.xdp_bytes);
+	u64_stats_add(&sq->stats.packets, stats.packets + stats.xdp_packets);
 	u64_stats_update_end(&sq->stats.syncp);
 }
 
@@ -1003,7 +1010,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	 * early means 16 slots are typically wasted.
 	 */
 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
-		netif_stop_subqueue(dev, qnum);
+		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
+
+		netif_tx_stop_queue(txq);
 		u64_stats_update_begin(&sq->stats.syncp);
 		u64_stats_inc(&sq->stats.stop);
 		u64_stats_update_end(&sq->stats.syncp);
@@ -1012,7 +1021,7 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 				virtqueue_napi_schedule(&sq->napi, sq->vq);
 		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
-			free_old_xmit(sq, false);
+			free_old_xmit(sq, txq, false, use_napi);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
 				u64_stats_update_begin(&sq->stats.syncp);
@@ -1138,7 +1147,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	__free_old_xmit(sq, false, &stats);
+	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
+			false, sq->napi.weight, &stats);
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
@@ -2313,7 +2323,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit(sq, true);
+			free_old_xmit(sq, txq, true, true);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
@@ -2412,6 +2422,7 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 		goto err_xdp_reg_mem_model;
 
 	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
+	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
 
 	return 0;
@@ -2471,7 +2482,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit(sq, true);
+	free_old_xmit(sq, txq, true, true);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
 		if (netif_tx_queue_stopped(txq)) {
@@ -2559,17 +2570,18 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct send_queue *sq = &vi->sq[qnum];
 	int err;
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
-	bool kick = !netdev_xmit_more();
+	bool xmit_more = netdev_xmit_more();
 	bool use_napi = sq->napi.weight;
+	bool kick;
 
 	/* Free up any pending old buffers before queueing new ones. */
 	do {
 		if (use_napi)
 			virtqueue_disable_cb(sq->vq);
 
-		free_old_xmit(sq, false);
+		free_old_xmit(sq, txq, false, use_napi);
 
-	} while (use_napi && kick &&
+	} while (use_napi && !xmit_more &&
 	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 	/* timestamp packet in software */
@@ -2598,7 +2610,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	check_sq_full_and_disable(vi, dev, sq);
 
-	if (kick || netif_xmit_stopped(txq)) {
+	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
+			  !xmit_more && netif_xmit_stopped(txq);
+	if (kick) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
 			u64_stats_inc(&sq->stats.kicks);
-- 
2.45.1


