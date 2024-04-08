Return-Path: <netdev+bounces-85567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E17589B681
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 05:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA981C2148C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 03:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359014C63;
	Mon,  8 Apr 2024 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="osVqlXxk"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7DB1877
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547879; cv=none; b=VdoNuEjahdZJY+rc1m3RxhenhWFABF94aOMYLEFBvvQkVagoy50FhWjeOQ9RlwmrqxfUwSoiUN6PJSDF5cajxDzYMXBINqvTzF5vsP0IXPatGQo1s4DEIDelnIFIm8l8b+UXHMywRW3Gx/LW2N51/q4bM5zOmbSzgs/6NKoDrAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547879; c=relaxed/simple;
	bh=oThzB2CTVde5yyaQ3HzZo2vd5oziz6wBghWVemQ4MW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qgdpbEybmvKIzLu0qSLsqi9SUQaGzjt6j983iZQzmCP84yHFI1Ix7pRn8qKdgrZmMfJZV+FfZX71mE25oSag/i5Qd4Ma9pmkXSA7cEIfp9mhL9kXipILhJecqpJeRL9/drzGL+tEB2HLkXWWxBpiX5d1N2JTah4Ao6J7em0wyV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=osVqlXxk; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712547874; h=From:To:Subject:Date:Message-Id;
	bh=R/hJANnBNUS/FQN5cE9C7fcicpexRUXU01lKJTGYZv4=;
	b=osVqlXxkAk4NSB/un1j8xfMw3TqmIFpsVKaBZNTsfqeqCpdlbwcsPAGumehbMtfKSlNoQIEZ+Dh9q94sXBK5BB7iQJy7Zs773w4KypfhUomUyk3/MYbmqLylWtxVMqUX/FZa4cBxk4KOBf/8uFJ+acnWrh3EvWrVEAwyIYfn/Kk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4249Z2_1712547873;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4249Z2_1712547873)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 11:44:34 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v4 3/4] virtio-net: refactor dim initialization/destruction
Date: Mon,  8 Apr 2024 11:44:29 +0800
Message-Id: <1712547870-112976-4-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712547870-112976-1-git-send-email-hengqi@linux.alibaba.com>
References: <1712547870-112976-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Extract the initialization and destruction actions
of dim for use in the next patch.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e709d44..cc3a281 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2278,6 +2278,13 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	return err;
 }
 
+static void virtnet_dim_clean(struct virtnet_info *vi,
+			      int start_qnum, int end_qnum)
+{
+	for (; start_qnum <= end_qnum; start_qnum++)
+		cancel_work_sync(&vi->rq[start_qnum].dim.work);
+}
+
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -2301,11 +2308,9 @@ static int virtnet_open(struct net_device *dev)
 err_enable_qp:
 	disable_delayed_refill(vi);
 	cancel_delayed_work_sync(&vi->refill);
-
-	for (i--; i >= 0; i--) {
+	virtnet_dim_clean(vi, 0, i - 1);
+	for (i--; i >= 0; i--)
 		virtnet_disable_queue_pair(vi, i);
-		cancel_work_sync(&vi->rq[i].dim.work);
-	}
 
 	return err;
 }
@@ -2470,7 +2475,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 
 	if (running) {
 		napi_disable(&rq->napi);
-		cancel_work_sync(&rq->dim.work);
+		virtnet_dim_clean(vi, qindex, qindex);
 	}
 
 	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
@@ -2720,10 +2725,9 @@ static int virtnet_close(struct net_device *dev)
 	/* Make sure refill_work doesn't re-enable napi! */
 	cancel_delayed_work_sync(&vi->refill);
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
+	virtnet_dim_clean(vi, 0, vi->max_queue_pairs - 1);
+	for (i = 0; i < vi->max_queue_pairs; i++)
 		virtnet_disable_queue_pair(vi, i);
-		cancel_work_sync(&vi->rq[i].dim.work);
-	}
 
 	return 0;
 }
@@ -4422,6 +4426,19 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	return ret;
 }
 
+static void virtnet_dim_init(struct virtnet_info *vi)
+{
+	int i;
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return;
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
+		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+	}
+}
+
 static int virtnet_alloc_queues(struct virtnet_info *vi)
 {
 	int i;
@@ -4441,6 +4458,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 		goto err_rq;
 
 	INIT_DELAYED_WORK(&vi->refill, refill_work);
+	virtnet_dim_init(vi);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
 		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
@@ -4449,9 +4467,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
 
-		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
-		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
-
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
-- 
1.8.3.1


