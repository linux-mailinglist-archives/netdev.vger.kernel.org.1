Return-Path: <netdev+bounces-49224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F17F137C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 13:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865431F2416A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2C412E48;
	Mon, 20 Nov 2023 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2BE92
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 04:37:42 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vwnzw74_1700483859;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vwnzw74_1700483859)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 20:37:40 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	ast@kernel.org,
	horms@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v4 3/4] virtio-net: extract virtqueue coalescig cmd for reuse
Date: Mon, 20 Nov 2023 20:37:33 +0800
Message-Id: <2eeceac3fca52bbd72dc596ccea9ec92f1307cd5.1700478183.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1700478183.git.hengqi@linux.alibaba.com>
References: <cover.1700478183.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract commands to set virtqueue coalescing parameters for reuse
by ethtool -Q, vq resize and netdim.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 106 +++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 42 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0285301caf78..69fe09e99b3c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2849,6 +2849,58 @@ static void virtnet_cpu_notif_remove(struct virtnet_info *vi)
 					    &vi->node_dead);
 }
 
+static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
+					 u16 vqn, u32 max_usecs, u32 max_packets)
+{
+	struct scatterlist sgs;
+
+	vi->ctrl->coal_vq.vqn = cpu_to_le16(vqn);
+	vi->ctrl->coal_vq.coal.max_usecs = cpu_to_le32(max_usecs);
+	vi->ctrl->coal_vq.coal.max_packets = cpu_to_le32(max_packets);
+	sg_init_one(&sgs, &vi->ctrl->coal_vq, sizeof(vi->ctrl->coal_vq));
+
+	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
+				  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
+				  &sgs))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int virtnet_send_rx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
+					    u16 queue, u32 max_usecs,
+					    u32 max_packets)
+{
+	int err;
+
+	err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
+					    max_usecs, max_packets);
+	if (err)
+		return err;
+
+	vi->rq[queue].intr_coal.max_usecs = max_usecs;
+	vi->rq[queue].intr_coal.max_packets = max_packets;
+
+	return 0;
+}
+
+static int virtnet_send_tx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
+					    u16 queue, u32 max_usecs,
+					    u32 max_packets)
+{
+	int err;
+
+	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
+					    max_usecs, max_packets);
+	if (err)
+		return err;
+
+	vi->sq[queue].intr_coal.max_usecs = max_usecs;
+	vi->sq[queue].intr_coal.max_packets = max_packets;
+
+	return 0;
+}
+
 static void virtnet_get_ringparam(struct net_device *dev,
 				  struct ethtool_ringparam *ring,
 				  struct kernel_ethtool_ringparam *kernel_ring,
@@ -2906,14 +2958,11 @@ static int virtnet_set_ringparam(struct net_device *dev,
 			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver
 			 * did not set any TX coalescing parameters, to 0.
 			 */
-			err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(i),
-							    vi->intr_coal_tx.max_usecs,
-							    vi->intr_coal_tx.max_packets);
+			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
+							       vi->intr_coal_tx.max_usecs,
+							       vi->intr_coal_tx.max_packets);
 			if (err)
 				return err;
-
-			vi->sq[i].intr_coal.max_usecs = vi->intr_coal_tx.max_usecs;
-			vi->sq[i].intr_coal.max_packets = vi->intr_coal_tx.max_packets;
 		}
 
 		if (ring->rx_pending != rx_pending) {
@@ -2922,14 +2971,11 @@ static int virtnet_set_ringparam(struct net_device *dev,
 				return err;
 
 			/* The reason is same as the transmit virtqueue reset */
-			err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(i),
-							    vi->intr_coal_rx.max_usecs,
-							    vi->intr_coal_rx.max_packets);
+			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
+							       vi->intr_coal_rx.max_usecs,
+							       vi->intr_coal_rx.max_packets);
 			if (err)
 				return err;
-
-			vi->rq[i].intr_coal.max_usecs = vi->intr_coal_rx.max_usecs;
-			vi->rq[i].intr_coal.max_packets = vi->intr_coal_rx.max_packets;
 		}
 	}
 
@@ -3334,48 +3380,24 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	return 0;
 }
 
-static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
-					 u16 vqn, u32 max_usecs, u32 max_packets)
-{
-	struct scatterlist sgs;
-
-	vi->ctrl->coal_vq.vqn = cpu_to_le16(vqn);
-	vi->ctrl->coal_vq.coal.max_usecs = cpu_to_le32(max_usecs);
-	vi->ctrl->coal_vq.coal.max_packets = cpu_to_le32(max_packets);
-	sg_init_one(&sgs, &vi->ctrl->coal_vq, sizeof(vi->ctrl->coal_vq));
-
-	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
-				  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
-				  &sgs))
-		return -EINVAL;
-
-	return 0;
-}
-
 static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec,
 					  u16 queue)
 {
 	int err;
 
-	err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
-					    ec->rx_coalesce_usecs,
-					    ec->rx_max_coalesced_frames);
+	err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
+					       ec->rx_coalesce_usecs,
+					       ec->rx_max_coalesced_frames);
 	if (err)
 		return err;
 
-	vi->rq[queue].intr_coal.max_usecs = ec->rx_coalesce_usecs;
-	vi->rq[queue].intr_coal.max_packets = ec->rx_max_coalesced_frames;
-
-	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
-					    ec->tx_coalesce_usecs,
-					    ec->tx_max_coalesced_frames);
+	err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
+					       ec->tx_coalesce_usecs,
+					       ec->tx_max_coalesced_frames);
 	if (err)
 		return err;
 
-	vi->sq[queue].intr_coal.max_usecs = ec->tx_coalesce_usecs;
-	vi->sq[queue].intr_coal.max_packets = ec->tx_max_coalesced_frames;
-
 	return 0;
 }
 
-- 
2.19.1.6.gb485710b


