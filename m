Return-Path: <netdev+bounces-86100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D789D8C8
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7FE1F21BBE
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4E312B16C;
	Tue,  9 Apr 2024 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KMhpYs0m"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D812AAC3
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664215; cv=none; b=NWn2nOahcOraRcnPRCBZjH9YCuKgXttWNj62Q791ssDPJ/bWg9fK8Rbh/DQDeqAao/de7RCRIHkYMfMDwC+FM5nTY1UoUqrWtS63OGpeNEBuh6VZPhCUmnVZrxRQmBC4/4A6RKlQG9ovj2YyybCkpaJHkLygtW2bRZTdUILS6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664215; c=relaxed/simple;
	bh=/pVaVmeOOrFDfZxUDUYeWFc/nJaPWoHwjB+srX5a59M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hZzlXljAFqcdVjKuTj+3C9Piz75HcX036lKB3aXxAh/eJltpyBF6ZpWS9MpEBY5kJeIoOtBhIc+11+JlZdiH53q9lQ/rAOS31krkbw8+oYHGAHTbMkmylxqJG+W9nV7WrzhMON5gNbiP1Hl6RLMRuqQhLzWNJMqJpr6o+6skQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KMhpYs0m; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712664209; h=From:To:Subject:Date:Message-Id;
	bh=EFVW3KbI2EwxDdgwb7ULfgTkyhIbh9ejzJs0vm8vWi4=;
	b=KMhpYs0mZKUa3TftFoPWERY3uY/7he8RhB4W8yRnQZJuBbcIwqVDylw72LEARpU8S76k5e8XVQbSecp+GwOS7OgYbXyfYcIIk5YbMYt5JUWuof5ceHFSLdE0Mk0/Kh0TwQnPmUA6OZvl8BKEHfyGVWO2Fe1/RqYJZ3MoHWrCvY4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4EUEpf_1712664207;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4EUEpf_1712664207)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 20:03:28 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v5 3/4] virtio-net: refactor dim initialization/destruction
Date: Tue,  9 Apr 2024 20:03:23 +0800
Message-Id: <1712664204-83147-4-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
References: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
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
index c22d111..a64656e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2274,6 +2274,13 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
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
@@ -2297,11 +2304,9 @@ static int virtnet_open(struct net_device *dev)
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
@@ -2466,7 +2471,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 
 	if (running) {
 		napi_disable(&rq->napi);
-		cancel_work_sync(&rq->dim.work);
+		virtnet_dim_clean(vi, qindex, qindex);
 	}
 
 	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
@@ -2716,10 +2721,9 @@ static int virtnet_close(struct net_device *dev)
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
@@ -4418,6 +4422,19 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
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
@@ -4437,6 +4454,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 		goto err_rq;
 
 	INIT_DELAYED_WORK(&vi->refill, refill_work);
+	virtnet_dim_init(vi);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
 		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
@@ -4445,9 +4463,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
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


