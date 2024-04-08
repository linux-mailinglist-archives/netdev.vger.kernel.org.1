Return-Path: <netdev+bounces-85570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EB989B689
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 05:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262E7B21C6A
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 03:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663C44A2F;
	Mon,  8 Apr 2024 03:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EvWJmE51"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325717494
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 03:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547886; cv=none; b=CVOpZtrqw0wDELbvtZEJ8pdqnPeLbCs/hIWVuIQ+cF67UerpwXn9NiwcSYeIbfJwJWBtA12JAODRTIZ0IJqezYzhhxzD8m/cKmqeEfs7XWmWkfTAIWAY9v7bwTWsAEXGVE0hCr+501Sd8LVd1JPFba78GtRkGETciFvQiK264LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547886; c=relaxed/simple;
	bh=FlKKvak3gW/xamFIUx6JWJHzjqlZgfllx0jrRr18NnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ir/Vc53ZnkAA1dPLHurKD6jLdBkoGkj9SKWBPaCx/2bxTy1CDGr4xf6IAhe8isPAK1GNY+oGcxBsjBi32Q3xHXFEzmWMUrNZJcdW4MWlH6BP3vl62cffI3eZ9A5GRy+j6Rhq4K+FIR6UN0gSHPkglTXWWBIv9BSkorCs0RxhwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EvWJmE51; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712547875; h=From:To:Subject:Date:Message-Id;
	bh=kpoOngaByRvectsngOJghtr0xxXXevY+L8PpYW6ecPU=;
	b=EvWJmE51sln+23gE+ZUsNK3bpkAiHHRkOSNP3KykQpU68UqHyKEQe/LC/LKsDAMZBlMAdowVZ8wcVwZ5tcQMhakNLtzY1y29xuh1NEhB5PYAwM+l+GuzQ/Ga9hfcXQoC2yD/PZeZiKy9IacZpYxf1e2O9gHvufhd5XHrmpGb/xA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W41xIq2_1712547874;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W41xIq2_1712547874)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 11:44:35 +0800
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
Subject: [PATCH net-next v4 4/4] virtio-net: support dim profile fine-tuning
Date: Mon,  8 Apr 2024 11:44:30 +0800
Message-Id: <1712547870-112976-5-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712547870-112976-1-git-send-email-hengqi@linux.alibaba.com>
References: <1712547870-112976-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Virtio-net has different types of back-end device
implementations. In order to effectively optimize
the dim library's gains for different device
implementations, let's use the new interface params
to fine-tune the profile list.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cc3a281..24e8a59 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -57,6 +57,8 @@
 
 #define VIRTNET_DRIVER_VERSION "1.0.0"
 
+static const struct dim_cq_moder rx_eqe_conf[] = NET_DIM_RX_EQE_PROFILES;
+
 static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
@@ -330,6 +332,12 @@ struct virtnet_info {
 	struct virtnet_interrupt_coalesce intr_coal_tx;
 	struct virtnet_interrupt_coalesce intr_coal_rx;
 
+	/* DIM profile list for different queue mode */
+	struct dim_cq_moder rx_eqe_conf[NET_DIM_PARAMS_NUM_PROFILES];
+	struct dim_cq_moder rx_cqe_conf[NET_DIM_PARAMS_NUM_PROFILES];
+	struct dim_cq_moder tx_eqe_conf[NET_DIM_PARAMS_NUM_PROFILES];
+	struct dim_cq_moder tx_cqe_conf[NET_DIM_PARAMS_NUM_PROFILES];
+
 	unsigned long guest_offloads;
 	unsigned long guest_offloads_capable;
 
@@ -3588,7 +3596,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		if (!rq->dim_enabled)
 			continue;
 
-		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+		update_moder = vi->rx_eqe_conf[dim->profile_ix];
 		if (update_moder.usec != rq->intr_coal.max_usecs ||
 		    update_moder.pkts != rq->intr_coal.max_packets) {
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
@@ -3631,6 +3639,27 @@ static int virtnet_should_update_vq_weight(int dev_flags, int weight,
 	return 0;
 }
 
+static int virtnet_update_profile(struct virtnet_info *vi,
+				  struct kernel_ethtool_coalesce *kc)
+{
+	int i;
+
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++)
+			if (kc->rx_eqe_profs[i].comps)
+				return -EINVAL;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
+		vi->rx_eqe_conf[i].usec = kc->rx_eqe_profs[i].usec;
+		vi->rx_eqe_conf[i].pkts = kc->rx_eqe_profs[i].pkts;
+	}
+
+	return 0;
+}
+
 static int virtnet_set_coalesce(struct net_device *dev,
 				struct ethtool_coalesce *ec,
 				struct kernel_ethtool_coalesce *kernel_coal,
@@ -3657,6 +3686,10 @@ static int virtnet_set_coalesce(struct net_device *dev,
 		}
 	}
 
+	ret = virtnet_update_profile(vi, kernel_coal);
+	if (ret)
+		return ret;
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
 		ret = virtnet_send_notf_coal_cmds(vi, ec);
 	else
@@ -3693,6 +3726,10 @@ static int virtnet_get_coalesce(struct net_device *dev,
 			ec->tx_max_coalesced_frames = 1;
 	}
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		memcpy(kernel_coal->rx_eqe_profs, vi->rx_eqe_conf,
+		       sizeof(vi->rx_eqe_conf));
+
 	return 0;
 }
 
@@ -3872,7 +3909,8 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+		ETHTOOL_COALESCE_RX_EQE_PROFILE,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
@@ -4437,6 +4475,8 @@ static void virtnet_dim_init(struct virtnet_info *vi)
 		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
 		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	}
+
+	memcpy(vi->rx_eqe_conf, rx_eqe_conf, sizeof(vi->rx_eqe_conf));
 }
 
 static int virtnet_alloc_queues(struct virtnet_info *vi)
-- 
1.8.3.1


