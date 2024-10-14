Return-Path: <netdev+bounces-135025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A999BE0B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 05:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AA71F2262A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 03:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C883CC1;
	Mon, 14 Oct 2024 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z9iuJRot"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D94D599
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875567; cv=none; b=GiKdD6Ou9bttG8fug9jQBrlO2j/67Mqef+TxcMwVcqhlE3XyDH4kNATsvmBunbkgNAc+odT19zxEPXYom+5IHIuREz11DNWq3LuXlIVl8QLiWRQPlAkNf6qZm6MvJ5Pz5hkDG6CQNszAfxOMfuXnH0Y+GOvjNIlPtMvspk1jyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875567; c=relaxed/simple;
	bh=ZimzXTnS+ySDijkHswYbDsKSxEaN9eAvVdl+yrEtNus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m1BMIZ5YHqFVnsJd6/dCClNKXGKC4ZViOZ9ueKibf+oSI23I//GkkLnKZi1M9BgZf8E9v+H7fisZEIUZumigfiUHMDMTTUJWyOGJRA6p6l6tK2JAqWV1qzNaK3t+ATxLk4HCJSQNGuA7mLW8nndhRAtrrCnhgxp5INv292RmI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z9iuJRot; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728875557; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xKnPBWt2rPXTDtTMScZ4Nu217/7LuF0PrrSmloFxuN0=;
	b=Z9iuJRottrdRq5Pj2bRkR0Fai26/LCZHkAj8kayJ1pGr8KjwcRK8Prjzz3Py9qA6ep+J2gOz0d4lTcdFpzwHXzB3hZANUKCeEikqQmiqrDi34m3VjEJ2N0ucB9ra+j2bH6N39Hzkw7dR3LRarHbMnO1krcCMrpdWlj1WyqifWJw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WH.H6A1_1728875556 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 11:12:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 2/5] virtio_net: introduce vi->mode
Date: Mon, 14 Oct 2024 11:12:31 +0800
Message-Id: <20241014031234.7659-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: bba499faae26
Content-Transfer-Encoding: 8bit

Now, if we want to judge the rx work mode, we have to use such codes:

1. merge mode: vi->mergeable_rx_bufs
2. big mode:   vi->big_packets && !vi->mergeable_rx_bufs
3. small:     !vi->big_packets && !vi->mergeable_rx_bufs

This is inconvenient and abstract, and we also have this use case:

if (vi->mergeable_rx_bufs)
    ....
else if (vi->big_packets)
    ....
else

For this case, I think switch-case is the better choice.

So here I introduce vi->mode to record the virtio-net work mode.
That is helpful to judge the work mode and choose the branches.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 61 +++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 59a99bbaf852..14809b614d62 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -385,6 +385,12 @@ struct control_buf {
 	virtio_net_ctrl_ack status;
 };
 
+enum virtnet_mode {
+	VIRTNET_MODE_SMALL,
+	VIRTNET_MODE_MERGE,
+	VIRTNET_MODE_BIG
+};
+
 struct virtnet_info {
 	struct virtio_device *vdev;
 	struct virtqueue *cvq;
@@ -414,6 +420,8 @@ struct virtnet_info {
 	/* Host will merge rx buffers for big packets (shake it! shake it!) */
 	bool mergeable_rx_bufs;
 
+	enum virtnet_mode mode;
+
 	/* Host supports rss and/or hash report */
 	bool has_rss;
 	bool has_rss_hash_report;
@@ -643,12 +651,15 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 static void virtnet_rq_free_buf(struct virtnet_info *vi,
 				struct receive_queue *rq, void *buf)
 {
-	if (vi->mergeable_rx_bufs)
+	switch (vi->mode) {
+	case VIRTNET_MODE_SMALL:
+	case VIRTNET_MODE_MERGE:
 		put_page(virt_to_head_page(buf));
-	else if (vi->big_packets)
+		break;
+	case VIRTNET_MODE_BIG:
 		give_pages(rq, buf);
-	else
-		put_page(virt_to_head_page(buf));
+		break;
+	}
 }
 
 static void enable_delayed_refill(struct virtnet_info *vi)
@@ -1315,7 +1326,8 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 
 	flags = ((struct virtio_net_common_hdr *)(xdp->data - vi->hdr_len))->hdr.flags;
 
-	if (!vi->mergeable_rx_bufs)
+	/* We only support small and merge mode. */
+	if (vi->mode == VIRTNET_MODE_SMALL)
 		skb = virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_xmit, stats);
 	else
 		skb = virtnet_receive_xsk_merge(dev, vi, rq, xdp, xdp_xmit, stats);
@@ -2389,13 +2401,20 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	 */
 	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
 
-	if (vi->mergeable_rx_bufs)
+	switch (vi->mode) {
+	case VIRTNET_MODE_MERGE:
 		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
 					stats);
-	else if (vi->big_packets)
+		break;
+
+	case VIRTNET_MODE_BIG:
 		skb = receive_big(dev, vi, rq, buf, len, stats);
-	else
+		break;
+
+	case VIRTNET_MODE_SMALL:
 		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
+		break;
+	}
 
 	if (unlikely(!skb))
 		return;
@@ -2580,12 +2599,19 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 	}
 
 	do {
-		if (vi->mergeable_rx_bufs)
+		switch (vi->mode) {
+		case VIRTNET_MODE_MERGE:
 			err = add_recvbuf_mergeable(vi, rq, gfp);
-		else if (vi->big_packets)
+			break;
+
+		case VIRTNET_MODE_BIG:
 			err = add_recvbuf_big(vi, rq, gfp);
-		else
+			break;
+
+		case VIRTNET_MODE_SMALL:
 			err = add_recvbuf_small(vi, rq, gfp);
+			break;
+		}
 
 		if (err)
 			break;
@@ -2703,7 +2729,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
 	int packets = 0;
 	void *buf;
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs) {
+	if (vi->mode != VIRTNET_MODE_BIG) {
 		void *ctx;
 		while (packets < budget &&
 		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
@@ -5510,7 +5536,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	/* In big_packets mode, xdp cannot work, so there is no need to
 	 * initialize xsk of rq.
 	 */
-	if (vi->big_packets && !vi->mergeable_rx_bufs)
+	if (vi->mode == VIRTNET_MODE_BIG)
 		return -ENOENT;
 
 	if (qid >= vi->curr_queue_pairs)
@@ -6007,7 +6033,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	vqs_info = kcalloc(total_vqs, sizeof(*vqs_info), GFP_KERNEL);
 	if (!vqs_info)
 		goto err_vqs_info;
-	if (!vi->big_packets || vi->mergeable_rx_bufs) {
+	if (vi->mode != VIRTNET_MODE_BIG) {
 		ctx = kcalloc(total_vqs, sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
 			goto err_ctx;
@@ -6480,6 +6506,13 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtnet_set_big_packets(vi, mtu);
 
+	if (vi->mergeable_rx_bufs)
+		vi->mode = VIRTNET_MODE_MERGE;
+	else if (vi->big_packets)
+		vi->mode = VIRTNET_MODE_BIG;
+	else
+		vi->mode = VIRTNET_MODE_SMALL;
+
 	if (vi->any_header_sg)
 		dev->needed_headroom = vi->hdr_len;
 
-- 
2.32.0.3.g01195cf9f


