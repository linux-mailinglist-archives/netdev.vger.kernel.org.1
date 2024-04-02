Return-Path: <netdev+bounces-83979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152348952A0
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E15DB21D2F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBCE762EB;
	Tue,  2 Apr 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="moHXC+Ln"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B965BD1
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059998; cv=none; b=bZuUzCUb0EDvYaLxxPAgcrptlMKjPwqXpt5t1+GEQHoqU/+JJmYl9sEFCl3FOwz3tEd8bir3A++YYoIUZaL5khFREe0NMvz4cPFCOCLfVXqF8MkhxBvMH2Cje+TFxM3nDLv3d0NEZFIF9IqBLJ0ZvyK4rTsmVpOI0l5oUwzCmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059998; c=relaxed/simple;
	bh=KzaA75a97JDAUOkqPD+hLaUrTTpBbFMyYuxVTdoH+iI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RFxJY264CdivcCAYrHiKAE+wZpIx95NbYQ8Xo8U9sJq6AkTmIqTeW8Pk6R/A6u1444LBDkPlMagw3C7c98dmcxa1aMBcm7my/UOYI4mFZxAR6F3RephMWqIpguKnqQfk2RKDZKfWkLc0tVjVGDrdDcPt3J9vbi0cp1DOrpj8+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=moHXC+Ln; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712059993; h=From:To:Subject:Date:Message-Id;
	bh=ZSZO3ZY+29/8eAwC19tnjxV20F7cJUXQbjJvawTvOcM=;
	b=moHXC+LnaOLPZm1UsOtF6eK+KZs7oeGNwhZiPBhBKS/03kOorvAzpeDbJoN36PfoltkeRtyYJW54CEp6UqY4c2GV13tnU6ltykqCv2NtixxIkjzGALY6QCHGUGP3epBznyPWZmQk7Q/2JrLhpOu/sPkjU9VCrOxJ3hKXgLtJSzo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3oSL1B_1712059992;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3oSL1B_1712059992)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 20:13:13 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v3 3/3] virtio-net: support dim profile fine-tuning
Date: Tue,  2 Apr 2024 20:13:08 +0800
Message-Id: <1712059988-7705-4-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712059988-7705-1-git-send-email-hengqi@linux.alibaba.com>
References: <1712059988-7705-1-git-send-email-hengqi@linux.alibaba.com>
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
 drivers/net/virtio_net.c   | 42 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/virtio_net.h | 11 +++++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5c56fdc..732214b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -330,6 +330,12 @@ struct virtnet_info {
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
 
@@ -3588,7 +3594,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		if (!rq->dim_enabled)
 			continue;
 
-		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+		update_moder = vi->rx_eqe_conf[dim->profile_ix];
 		if (update_moder.usec != rq->intr_coal.max_usecs ||
 		    update_moder.pkts != rq->intr_coal.max_packets) {
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
@@ -3631,6 +3637,27 @@ static int virtnet_should_update_vq_weight(int dev_flags, int weight,
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
@@ -3657,6 +3684,10 @@ static int virtnet_set_coalesce(struct net_device *dev,
 		}
 	}
 
+	ret = virtnet_update_profile(vi, kernel_coal);
+	if (ret)
+		return ret;
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
 		ret = virtnet_send_notf_coal_cmds(vi, ec);
 	else
@@ -3693,6 +3724,10 @@ static int virtnet_get_coalesce(struct net_device *dev,
 			ec->tx_max_coalesced_frames = 1;
 	}
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		memcpy(kernel_coal->rx_eqe_profs, vi->rx_eqe_conf,
+		       sizeof(vi->rx_eqe_conf));
+
 	return 0;
 }
 
@@ -3872,7 +3907,8 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+		ETHTOOL_COALESCE_RX_EQE_PROFILE,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
@@ -4437,6 +4473,8 @@ static void virtnet_dim_init(struct virtnet_info *vi)
 		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
 		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	}
+
+	memcpy(vi->rx_eqe_conf, rx_eqe_conf, sizeof(vi->rx_eqe_conf));
 }
 
 static int virtnet_alloc_queues(struct virtnet_info *vi)
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 4dfa9b6..82aa4cc 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -6,9 +6,20 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/udp.h>
+#include <linux/dim.h>
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
 
+/* This is copied from NET_DIM_RX_EQE_PROFILES in DIM library */
+#define VIRTNET_DIM_RX_PKTS 256
+static const struct dim_cq_moder rx_eqe_conf[] = {
+	{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
+};
+
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
 	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
-- 
1.8.3.1


