Return-Path: <netdev+bounces-92566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891638B7EA8
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 19:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144FA28307E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A217966C;
	Tue, 30 Apr 2024 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K9nugO0q"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B10D1836C1;
	Tue, 30 Apr 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498316; cv=none; b=Vkg5KdmLK1214ooaPh2nvKlzrb1LHRyMXiDF4fx9OaDdsil1ApB869SsbqysGp0TxvBNVwmogaXG0tiC5IwkxisEKH2GdESCFdaFNO4VZOIVz4I4yny7P3Yaqs1v+G49qSRH7cSWcO1mVD44d7J+Tenoddp7xZ8I8fN7TIHitTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498316; c=relaxed/simple;
	bh=MHF4o86DL9pEN8oVs3Sx1G6Ipvv1tXfxSVvGQX7FHqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kL/1NSax+P/rYk/xcLz/Fhu51IEYkEqTsw41sQtrv2OlnNJBMq0WHpsRHVVOEHp92GZqmNl4LnSFdTPPNJZcnB+nYRkd4+3h/BI30Q8HWqmrjyZFyFyUvDeHilHiqHwgUzS8JhLJpKkKRSuh5Rgl0Eq6QbHK+bTtJXYtSHxUbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K9nugO0q; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714498306; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Z3J0rCjHZaiuaiK556RMQJtdoIn3ECoLvSIJUqUCcjg=;
	b=K9nugO0qOqhwHLR0ZRVMyBlCGRvurySl3M/HuI6v0IctMuoc2yj1ugeGA5kMoejTdi3GDQreGtWfrkdplOtPjZLeoqS02hahac03ltxITOFi1PXoYDxHKa1HGpYOnTSwUfKgiq8JqmLnQA9k5yBiJwhsJ3EIzyODecQcLFKqyH8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5ci8h4_1714498303;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5ci8h4_1714498303)
          by smtp.aliyun-inc.com;
          Wed, 01 May 2024 01:31:44 +0800
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
	justinstitt@google.com
Subject: [PATCH net-next v11 4/4] virtio-net: support dim profile fine-tuning
Date: Wed,  1 May 2024 01:31:36 +0800
Message-Id: <20240430173136.15807-5-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240430173136.15807-1-hengqi@linux.alibaba.com>
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
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
 drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1fa84790041b..72924c7b508d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2446,7 +2446,7 @@ static int virtnet_open(struct net_device *dev)
 
 	for (i--; i >= 0; i--) {
 		virtnet_disable_queue_pair(vi, i);
-		cancel_work_sync(&vi->rq[i].dim.work);
+		net_dim_work_cancel(&vi->rq[i].dim);
 	}
 
 	return err;
@@ -2612,7 +2612,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 
 	if (running) {
 		napi_disable(&rq->napi);
-		cancel_work_sync(&rq->dim.work);
+		net_dim_work_cancel(&rq->dim);
 	}
 
 	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
@@ -2874,7 +2874,7 @@ static int virtnet_close(struct net_device *dev)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		virtnet_disable_queue_pair(vi, i);
-		cancel_work_sync(&vi->rq[i].dim.work);
+		net_dim_work_cancel(&vi->rq[i].dim);
 	}
 
 	return 0;
@@ -4363,7 +4363,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		if (!rq->dim_enabled)
 			continue;
 
-		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+		update_moder = net_dim_get_rx_irq_moder(dev, dim);
 		if (update_moder.usec != rq->intr_coal.max_usecs ||
 		    update_moder.pkts != rq->intr_coal.max_packets) {
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
@@ -5054,6 +5054,37 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
 }
 
+static int virtnet_init_irq_moder(struct virtnet_info *vi)
+{
+	u8 profile_flags = 0, coal_flags = 0;
+	struct net_device *dev = vi->dev;
+	int ret, i;
+
+	profile_flags |= DIM_PROFILE_RX;
+	coal_flags |= DIM_COALESCE_USEC | DIM_COALESCE_PKTS;
+	ret = net_dim_init_irq_moder(dev, profile_flags, coal_flags,
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
@@ -5333,9 +5364,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
 
-		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
-		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
-
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
@@ -5753,6 +5781,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 		for (i = 0; i < vi->max_queue_pairs; i++)
 			if (vi->sq[i].napi.weight)
 				vi->sq[i].intr_coal.max_packets = 1;
+
+		err = virtnet_init_irq_moder(vi);
+		if (err)
+			goto free;
 	}
 
 #ifdef CONFIG_SYSFS
@@ -5896,6 +5928,8 @@ static void virtnet_remove(struct virtio_device *vdev)
 	disable_rx_mode_work(vi);
 	flush_work(&vi->rx_mode_work);
 
+	virtnet_free_irq_moder(vi);
+
 	unregister_netdev(vi->dev);
 
 	net_failover_destroy(vi->failover);
-- 
2.32.0.3.g01195cf9f


