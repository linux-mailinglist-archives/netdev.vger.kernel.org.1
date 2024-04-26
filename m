Return-Path: <netdev+bounces-91553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5598B30E1
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 08:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3247A281713
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B327D13A88F;
	Fri, 26 Apr 2024 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TaW8ZJaU"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3913B5B3
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114514; cv=none; b=Goeh5amp1neBOw3L8ZUaDF4BWbbaDApFpMdAP6ASgIriTJ3YDdR4CDQI+tX257O8sd2BaVacmbzzXpA4dLwCmYBoUODxhJJUxHvBH0K3I55FbUfEeufBEdkLK2dG1wrMi3ZyHUa1yEURNzgEyyZo0/pgh3GaFIUlVmLhq29dB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114514; c=relaxed/simple;
	bh=TGYFaIai2Z0dam9L8nAVwO8TpywOklb2AgAye2mg+Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KlkIfByZZFWOFOjmRQvpHbsgvNBuI6vNGPIsUdkeg2NIHf3DPZpE0Wbn5QQCe4zxwIjgG1UY2FL9ZBIwv2Qu416HRcnpr15xdrlLSDR6WgAPIFTG7HG1YHK4/3hk+3RJCaARZyA9tRYhaS3C/qrhwlpmPmhKzAzcBd1S62otzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TaW8ZJaU; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714114486; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CZkfS1T+3iklRYyYG/M6nVAjZnl0ZNjEuysnrUnFU68=;
	b=TaW8ZJaUd7bGWs5+xXZt4K1bd37kvLgpiRtGEOle7mQY5XRtX5E96P4NKa6DPaCOEsDYuPhzOuWDM0cPNCKvJgUQ/kZyiZdAqcyHiOjGWA0sdMe7KxMCuj5n+ZcawCaxU/3CZIQeOhMRLcM0bEXuf5vVD9JfrbYPIWbSjgs++LE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5INMe2_1714114484;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5INMe2_1714114484)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 14:54:46 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 2/2] virtio_net: get init coalesce value when probe
Date: Fri, 26 Apr 2024 14:54:41 +0800
Message-Id: <20240426065441.120710-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240426065441.120710-1-hengqi@linux.alibaba.com>
References: <20240426065441.120710-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, virtio-net lacks a way to obtain the default coalesce
values of the device during the probe phase. That is, the device
may have default experience values, but the user uses "ethtool -c"
to query that the values are still 0.

Therefore, we reuse VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET to complete the goal.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 68 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3bc9b1e621db..fe0c15819dd3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4623,6 +4623,46 @@ static int virtnet_validate(struct virtio_device *vdev)
 	return 0;
 }
 
+static int virtnet_get_coal_init_value(struct virtnet_info *vi,
+				       u16 _vqn, bool is_tx)
+{
+	struct virtio_net_ctrl_coal *coal = &vi->ctrl->coal_vq.coal;
+	__le16 *vqn = &vi->ctrl->coal_vq.vqn;
+	struct scatterlist sgs_in, sgs_out;
+	u32 usecs, pkts, i;
+	bool ret;
+
+	*vqn = cpu_to_le16(_vqn);
+
+	sg_init_one(&sgs_out, vqn, sizeof(*vqn));
+	sg_init_one(&sgs_in, coal, sizeof(*coal));
+	ret = virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_NOTF_COAL,
+					 VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET,
+					 &sgs_out, &sgs_in);
+	if (!ret)
+		return ret;
+
+	usecs = le32_to_cpu(coal->max_usecs);
+	pkts = le32_to_cpu(coal->max_packets);
+	if (is_tx) {
+		vi->intr_coal_tx.max_usecs = usecs;
+		vi->intr_coal_tx.max_packets = pkts;
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			vi->sq[i].intr_coal.max_usecs = usecs;
+			vi->sq[i].intr_coal.max_packets = pkts;
+		}
+	} else {
+		vi->intr_coal_rx.max_usecs = usecs;
+		vi->intr_coal_rx.max_packets = pkts;
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			vi->rq[i].intr_coal.max_usecs = usecs;
+			vi->rq[i].intr_coal.max_packets = pkts;
+		}
+	}
+
+	return 0;
+}
+
 static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
 {
 	return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
@@ -4885,13 +4925,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 			vi->intr_coal_tx.max_packets = 0;
 	}
 
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
-		/* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
-		for (i = 0; i < vi->max_queue_pairs; i++)
-			if (vi->sq[i].napi.weight)
-				vi->sq[i].intr_coal.max_packets = 1;
-	}
-
 #ifdef CONFIG_SYSFS
 	if (vi->mergeable_rx_bufs)
 		dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
@@ -4926,6 +4959,27 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		/* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			if (vi->sq[i].napi.weight)
+				vi->sq[i].intr_coal.max_packets = 1;
+
+		/* The loop exits if the default value from any
+		 * queue is successfully read.
+		 */
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			err = virtnet_get_coal_init_value(vi, rxq2vq(i), false);
+			if (!err)
+				break;
+		}
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			err = virtnet_get_coal_init_value(vi, txq2vq(i), true);
+			if (!err)
+				break;
+		}
+	}
+
 	_virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	/* a random MAC address has been assigned, notify the device.
-- 
2.32.0.3.g01195cf9f


