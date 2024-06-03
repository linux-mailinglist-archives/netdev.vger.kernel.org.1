Return-Path: <netdev+bounces-100286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE2D8D8669
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB3DB2566E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0D136674;
	Mon,  3 Jun 2024 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CMEkEEye"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303ED132110;
	Mon,  3 Jun 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429662; cv=none; b=Z9dOQ5Q6Hoo7YB/uLTlYrqBPwwU2Br5piF/LimzdZgftxAc9pxna7zTpX12ZhBsCX6yR3eBvCMtmoe8otYa3fu8mLc8KY5Esjt5A4BOshCbJ+t2xeRt0MF/x/ZhnLtX8difttvlGkNt3AjLjiLcHFSO7iwuSejdK6weEmBVZAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429662; c=relaxed/simple;
	bh=h2dOgvh0sWfQSKuS7iwTKtX+p6v67FhrSFbT4Tw1MSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nkqoy2Fach3zGsLoDOXHT8W3g1dpcOQsLxJphLZk470+qFIYnaZL3gzEAa9A7nq3LEQcg8CPZ601S0XVwcdc2d3Gqk8fZsOGqpfYV9G1jffes9Rv5f+zt/fdQumNP5RJVmFmZhD8h6qQi57GyC712h6glFzx38gqfVIZAc0mIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CMEkEEye; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717429658; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wBCcUYfTyR8e7GLKfA4FLYpk0PnG+1g1Mf2Ce8XInYw=;
	b=CMEkEEyeJjp6m66mvyf5Xo0k2Ncr3xNfKhInptXaPUh93+Csr9dooUm3TbEEmWrwCN/HEa0rWOG2sArZITvA7mVUatffnNUt9pM+7Tc+KozE2oS+9CJgzmJDf5q5rlzxN/H0y0JynGzwGvoFpxYTzXC76ePuB3TrjZbWThIbnL4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W7oGJ1a_1717429654;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7oGJ1a_1717429654)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 23:47:35 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	justinstitt@google.com,
	donald.hunter@gmail.com,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	awel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH net-next v14 5/5] virtio-net: support dim profile fine-tuning
Date: Mon,  3 Jun 2024 23:47:27 +0800
Message-Id: <20240603154727.31998-6-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240603154727.31998-1-hengqi@linux.alibaba.com>
References: <20240603154727.31998-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio-net has different types of back-end device implementations.
In order to effectively optimize the dim library's gains for different
device implementations, let's use the new interface params to
initialize and query dim results from a customized profile list.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 54 ++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4a802c0ea2cb..f9e15099982d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2421,6 +2421,13 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	return err;
 }
 
+static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
+{
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return;
+	net_dim_work_cancel(dim);
+}
+
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -2447,7 +2454,7 @@ static int virtnet_open(struct net_device *dev)
 
 	for (i--; i >= 0; i--) {
 		virtnet_disable_queue_pair(vi, i);
-		cancel_work_sync(&vi->rq[i].dim.work);
+		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
 
 	return err;
@@ -2619,7 +2626,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 
 	if (running) {
 		napi_disable(&rq->napi);
-		cancel_work_sync(&rq->dim.work);
+		virtnet_cancel_dim(vi, &rq->dim);
 	}
 
 	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
@@ -2878,7 +2885,7 @@ static int virtnet_close(struct net_device *dev)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		virtnet_disable_queue_pair(vi, i);
-		cancel_work_sync(&vi->rq[i].dim.work);
+		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
 
 	return 0;
@@ -4408,7 +4415,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	if (!rq->dim_enabled)
 		goto out;
 
-	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+	update_moder = net_dim_get_rx_irq_moder(dev, dim);
 	if (update_moder.usec != rq->intr_coal.max_usecs ||
 	    update_moder.pkts != rq->intr_coal.max_packets) {
 		err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
@@ -5108,6 +5115,36 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
 }
 
+static int virtnet_init_irq_moder(struct virtnet_info *vi)
+{
+	u8 profile_flags = 0, coal_flags = 0;
+	int ret, i;
+
+	profile_flags |= DIM_PROFILE_RX;
+	coal_flags |= DIM_COALESCE_USEC | DIM_COALESCE_PKTS;
+	ret = net_dim_init_irq_moder(vi->dev, profile_flags, coal_flags,
+				     DIM_CQ_PERIOD_MODE_START_FROM_EQE,
+				     0, virtnet_rx_dim_work, NULL);
+
+	if (ret)
+		return ret;
+
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		net_dim_setting(vi->dev, &vi->rq[i].dim, false);
+
+	return 0;
+}
+
+static void virtnet_free_irq_moder(struct virtnet_info *vi)
+{
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return;
+
+	rtnl_lock();
+	net_dim_free_irq_moder(vi->dev);
+	rtnl_unlock();
+}
+
 static const struct net_device_ops virtnet_netdev = {
 	.ndo_open            = virtnet_open,
 	.ndo_stop   	     = virtnet_close,
@@ -5387,9 +5424,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
 
-		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
-		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
-
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
@@ -5810,6 +5844,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 		for (i = 0; i < vi->max_queue_pairs; i++)
 			if (vi->sq[i].napi.weight)
 				vi->sq[i].intr_coal.max_packets = 1;
+
+		err = virtnet_init_irq_moder(vi);
+		if (err)
+			goto free;
 	}
 
 #ifdef CONFIG_SYSFS
@@ -5961,6 +5999,8 @@ static void virtnet_remove(struct virtio_device *vdev)
 	disable_rx_mode_work(vi);
 	flush_work(&vi->rx_mode_work);
 
+	virtnet_free_irq_moder(vi);
+
 	unregister_netdev(vi->dev);
 
 	net_failover_destroy(vi->failover);
-- 
2.32.0.3.g01195cf9f


