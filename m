Return-Path: <netdev+bounces-87987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184FC8A51DE
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5CEB24E3F
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD267603A;
	Mon, 15 Apr 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rxd8xIi/"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910C75815
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188301; cv=none; b=PZpxZzE24n280l93vEQEDZA8Fkxu1jHxdaqkYR7yays9ASw4wJNatmiZ/t0WR+xf1l9Wk4RWsXFWyom4kknNa/vZBUFsX2y2Osqk1R8NhURO5wx1vA9P/3xp1gkUDTUP2nYRnDDDtknQRTDI/fpZpgMRhbDqKODH9m/JP03PkK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188301; c=relaxed/simple;
	bh=kZK53Rp7KIpAwByil0yRyktDOIYGEO2VhYRieEn3Zao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Up8izpL0HYVgS2IFqsUPvkJwT2O/IQRphebc9Nk2gRi4Qj6VEhPOXTLwuxxHDzapS1ZemSP55+9/r1q3wgUIgbZxI75zaVORrfi/u8SqXNyYcyjWs45rg2tr60eLevzDntOYThtqX/xuIdNEkVKJ8haIWLRJ8FfU2feBs9DMBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rxd8xIi/; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713188292; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tPqiRwVSaLEAe+HcvyM29Do3zQovGanj54XR1XFNne0=;
	b=rxd8xIi/0BDev55qAJiNSkx+IiOsXD6Ds67po+61MPA4FnXC0TKACNouTsNmhZYilmip5/UxOQakLi6GgOvg9W+RbGNgBVjPceo+1MIXBQcc84AnjUObN88dyBfw5ItOgILtVv5sO6qBiDE/r28ylnYDsSD2KCg4nvRNUvDLcyQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4ea7nt_1713188291;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4ea7nt_1713188291)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 21:38:11 +0800
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
Subject: [PATCH RESEND net-next v7 3/4] virtio-net: refactor dim initialization/destruction
Date: Mon, 15 Apr 2024 21:38:06 +0800
Message-Id: <20240415133807.116394-4-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240415133807.116394-1-hengqi@linux.alibaba.com>
References: <20240415133807.116394-1-hengqi@linux.alibaba.com>
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
index 115c3c5414f2..858d7ab89e34 100644
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
@@ -4434,6 +4438,19 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
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
@@ -4461,9 +4478,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
 
-		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
-		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
-
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
@@ -4873,6 +4887,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	virtnet_dim_init(vi);
+
 	_virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	/* a random MAC address has been assigned, notify the device.
-- 
2.32.0.3.g01195cf9f


