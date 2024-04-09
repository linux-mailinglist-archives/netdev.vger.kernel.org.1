Return-Path: <netdev+bounces-86101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8750089D8CB
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88D31C215C7
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7479412DDA7;
	Tue,  9 Apr 2024 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Lkl9HGep"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAAE12D761
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664216; cv=none; b=nyfGIjZnkL4GKim5oUZx1TmcsCJ1n9hm0Up347H2/r9amrqQ7H1tMPeOBE8f/6178huAdYV8WftgwGozGoSFmzxl2guE/sea+PCQ5KMqLc5VWDq4ZRSrdJuUFCh7ZZRTNuTn0M3ErdyGovKcr3gIW6Za8+mPP0+bqgII/gYNfDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664216; c=relaxed/simple;
	bh=KfkAXKqjvx2YaC+R1odSmg3fW5a9snW6FdAk7oR71gA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=feAJ7w6n4FMo4ItE064daVNyNAT4jUdAtW5ZmLvMjVB2Bmt8aJdvIzQlKmMIrblceogj+78lWXLN5e3g6u/wAexX2ecjmYsFSEHR4y0dm8ATQ99A1AuAVVY59cBedAPcPgQ6ET+osvV7zj5WBABrQ4LzGOo8m4609Hjw8YIEQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Lkl9HGep; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712664210; h=From:To:Subject:Date:Message-Id;
	bh=R8UegQmlnT940x6x6bs23Fw0fmgGlqJ4Ul8YbofQMkk=;
	b=Lkl9HGepsCfyO869ELeQUvWI3fS+3k3eRDkxxlc5bBssNWIYJ9LL/8/kVv9FRUsX5ZUh7cDdgSe3pJ+oFh/pMS0T+WYcKLaWbDXvCFiAwnSMR2XtH79P81hw/aoOt/vepReg+0Tj32D18vCnVN5vPzVhmhKZY0yLjP0huOkDrYA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4EReBT_1712664208;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4EReBT_1712664208)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 20:03:29 +0800
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
Subject: [PATCH net-next v5 4/4] virtio-net: support dim profile fine-tuning
Date: Tue,  9 Apr 2024 20:03:24 +0800
Message-Id: <1712664204-83147-5-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
References: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
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
 drivers/net/virtio_net.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a64656e..03840e9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -57,6 +57,8 @@
 
 #define VIRTNET_DRIVER_VERSION "1.0.0"
 
+static const struct dim_cq_moder rx_eqe_conf[] = NET_DIM_RX_EQE_PROFILES;
+
 static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
@@ -335,6 +337,9 @@ struct virtnet_info {
 	struct virtnet_interrupt_coalesce intr_coal_tx;
 	struct virtnet_interrupt_coalesce intr_coal_rx;
 
+	/* DIM profile list */
+	struct dim_cq_moder rx_eqe_conf[NET_DIM_PARAMS_NUM_PROFILES];
+
 	unsigned long guest_offloads;
 	unsigned long guest_offloads_capable;
 
@@ -3584,7 +3589,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		if (!rq->dim_enabled)
 			continue;
 
-		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+		update_moder = vi->rx_eqe_conf[dim->profile_ix];
 		if (update_moder.usec != rq->intr_coal.max_usecs ||
 		    update_moder.pkts != rq->intr_coal.max_packets) {
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
@@ -3627,6 +3632,27 @@ static int virtnet_should_update_vq_weight(int dev_flags, int weight,
 	return 0;
 }
 
+static int virtnet_update_profile(struct virtnet_info *vi,
+				  struct kernel_ethtool_coalesce *kc)
+{
+	int i;
+
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++)
+			if (kc->rx_eqe_profile[i].comps)
+				return -EINVAL;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
+		vi->rx_eqe_conf[i].usec = kc->rx_eqe_profile[i].usec;
+		vi->rx_eqe_conf[i].pkts = kc->rx_eqe_profile[i].pkts;
+	}
+
+	return 0;
+}
+
 static int virtnet_set_coalesce(struct net_device *dev,
 				struct ethtool_coalesce *ec,
 				struct kernel_ethtool_coalesce *kernel_coal,
@@ -3653,6 +3679,10 @@ static int virtnet_set_coalesce(struct net_device *dev,
 		}
 	}
 
+	ret = virtnet_update_profile(vi, kernel_coal);
+	if (ret)
+		return ret;
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
 		ret = virtnet_send_notf_coal_cmds(vi, ec);
 	else
@@ -3689,6 +3719,10 @@ static int virtnet_get_coalesce(struct net_device *dev,
 			ec->tx_max_coalesced_frames = 1;
 	}
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		memcpy(kernel_coal->rx_eqe_profile, vi->rx_eqe_conf,
+		       sizeof(vi->rx_eqe_conf));
+
 	return 0;
 }
 
@@ -3868,7 +3902,8 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+		ETHTOOL_COALESCE_RX_EQE_PROFILE,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
@@ -4433,6 +4468,8 @@ static void virtnet_dim_init(struct virtnet_info *vi)
 		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
 		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	}
+
+	memcpy(vi->rx_eqe_conf, rx_eqe_conf, sizeof(vi->rx_eqe_conf));
 }
 
 static int virtnet_alloc_queues(struct virtnet_info *vi)
-- 
1.8.3.1


