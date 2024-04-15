Return-Path: <netdev+bounces-87822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666198A4B99
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969A21C220DB
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181F04438A;
	Mon, 15 Apr 2024 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xUsnffDB"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0E3FBA5
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173809; cv=none; b=F0eKh/sesMQt9vSx7YfzFXVFdNz8mT6bjlG40E+WgIrB9POFKbu8RoknX23lJ01ds5p72s9sExoIFP4ej0F1+UkzZZ9UDlSSshavjAjaNnTRBQv3MlLXy8ryVSJAfZZZFGrn0vVaursHJ1d5eM7xHLV3zcBFWmzUZcTrp3OiF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173809; c=relaxed/simple;
	bh=DRV6wXNRM1lNrVgDsF8iq2gUUMKQHbCiR9s5YRFKb5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dssxr4k21ks/DbVrqCe139UZsxxkXsG1v9pAwmdH5swdAFBnl9+cS0hJC+PEx32SEtyaRQXdjIhlrBN3tXk6u62d1Eif8tySga80jB4K+muOaKuZHqJQdT7qtWT3zc+fne9HD6FOew3KRR+UidClisW3xEVPpMvnBLmcZdBEAg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xUsnffDB; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713173803; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lUJhBDWdgCHqmNJ+6H8gmi8bjqVhnK1FxycIphyKCaQ=;
	b=xUsnffDBSSSxUqeDVtdvLDtVJMit5r1OVOqK4RdI3XqftcJJRe0DHJAYuzxKcSRk7vv0yoS3KfJpp+hSVVSgI7TF8Guk7cZDQ2GG8Fy/sDU+Ks8o6Wb3tEPfrN41oOHryWloyMAiAC12YvBiYprZKx2ZfPFJxty0D0mmNgObIvc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4aM2wU_1713173802;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4aM2wU_1713173802)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 17:36:43 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v7 3/4] virtio-net: refactor dim initialization/destruction
Date: Mon, 15 Apr 2024 17:36:37 +0800
Message-Id: <20240415093638.123962-4-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240415093638.123962-1-hengqi@linux.alibaba.com>
References: <20240415093638.123962-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the initialization and destruction actions
of dim for use in the next patch.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..e8fbee204bf0 100644
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
@@ -4445,9 +4462,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
 
-		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
-		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
-
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
@@ -4855,6 +4869,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	virtnet_dim_init(vi);
+
 	_virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	/* a random MAC address has been assigned, notify the device.
-- 
2.32.0.3.g01195cf9f


