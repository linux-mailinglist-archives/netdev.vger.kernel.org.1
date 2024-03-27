Return-Path: <netdev+bounces-82408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6623888DA1B
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 10:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F4E1C2803C
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A14374E9;
	Wed, 27 Mar 2024 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mCEr2JOT"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA22CCA0
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531154; cv=none; b=b+ji8NmoPGKVbLpER7A7eFVHKeNVzU33uxuRmfs+PTNmRbQGceEzRU9VwZXWrFt0i2AqZs4PXsYSQuMCvVenwB0udJGodTXmOWYrWKMlYqhdZryMra1aNTmZYBeOg2BAy0F9OmAdzzGAw5wVixpK8Ux+iqAahYaMfx4SRYBEmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531154; c=relaxed/simple;
	bh=2ksmy3Q4LK7y9CW0Wzwr36F7dF2L7YZzUIP1+kHFwXc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=X70+m60oT2Knz6cHuGOpMIp3qmuAHr7YjZGMZdMl/7iHyz8jOZDW4DMxXNbBL8GVnFGLmFl+O8fWgNH/U6s4kSEjxHLMv1GiU6MA9ekEdyY/5+Hm5ElaItfc2zhLQnPifpqQ0n29b+gy6wii0+PRE5297h0hyV0dvY7h+c+g3oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mCEr2JOT; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711531150; h=From:To:Subject:Date:Message-Id;
	bh=/BHClCEypdJBG6zdvzl8aHSh+6Sat9WNOP+DNuGwZ7U=;
	b=mCEr2JOTWd9rHxhKBF4leZWbbn/pZfCBGyQkwSKtBI8PYHUFmTaZYsSQHaPHH0wsnrzsXiqOJv2Pco3yWG69dHL0vkFVxawLz+VvelkslXqLZUuFYa+KpybJEUzdJL+xadZNvrhdGKhZvMpt20p0cy92WgqQ4FnnIvLIP/iCF8Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3OGEqF_1711531149;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3OGEqF_1711531149)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 17:19:09 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v2 2/2] virtio-net: support dim profile fine-tuning
Date: Wed, 27 Mar 2024 17:19:06 +0800
Message-Id: <1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
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
 drivers/net/virtio_net.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e709d44..9b6c727 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -57,6 +57,16 @@
 
 #define VIRTNET_DRIVER_VERSION "1.0.0"
 
+/* This is copied from NET_DIM_RX_EQE_PROFILES in DIM library */
+#define VIRTNET_DIM_RX_PKTS 256
+static struct dim_cq_moder rx_eqe_conf[] = {
+	{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
+};
+
 static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
@@ -3584,7 +3594,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		if (!rq->dim_enabled)
 			continue;
 
-		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+		if (dim->profile_ix >= ARRAY_SIZE(rx_eqe_conf))
+			dim->profile_ix = ARRAY_SIZE(rx_eqe_conf) - 1;
+
+		update_moder = rx_eqe_conf[dim->profile_ix];
 		if (update_moder.usec != rq->intr_coal.max_usecs ||
 		    update_moder.pkts != rq->intr_coal.max_packets) {
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
@@ -3627,6 +3640,34 @@ static int virtnet_should_update_vq_weight(int dev_flags, int weight,
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
+		for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
+			if (kc->rx_eqe_profs[i].usec != rx_eqe_conf[i].usec ||
+			    kc->rx_eqe_profs[i].pkts != rx_eqe_conf[i].pkts ||
+			    kc->rx_eqe_profs[i].comps)
+				return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
+		rx_eqe_conf[i].usec = kc->rx_eqe_profs[i].usec;
+		rx_eqe_conf[i].pkts = kc->rx_eqe_profs[i].pkts;
+	}
+
+	return 0;
+}
+
 static int virtnet_set_coalesce(struct net_device *dev,
 				struct ethtool_coalesce *ec,
 				struct kernel_ethtool_coalesce *kernel_coal,
@@ -3653,6 +3694,10 @@ static int virtnet_set_coalesce(struct net_device *dev,
 		}
 	}
 
+	ret = virtnet_update_profile(vi, kernel_coal);
+	if (ret)
+		return ret;
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
 		ret = virtnet_send_notf_coal_cmds(vi, ec);
 	else
@@ -3689,6 +3734,10 @@ static int virtnet_get_coalesce(struct net_device *dev,
 			ec->tx_max_coalesced_frames = 1;
 	}
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		memcpy(kernel_coal->rx_eqe_profs, rx_eqe_conf,
+		       sizeof(rx_eqe_conf));
+
 	return 0;
 }
 
@@ -3868,7 +3917,8 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+		ETHTOOL_COALESCE_RX_EQE_PROFILE,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
-- 
1.8.3.1


