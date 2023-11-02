Return-Path: <netdev+bounces-45724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979447DF343
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 14:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4752E281BA8
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F879EF;
	Thu,  2 Nov 2023 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB515E85
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 13:09:45 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BC7BD
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 06:09:42 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VvWATDe_1698930577;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VvWATDe_1698930577)
          by smtp.aliyun-inc.com;
          Thu, 02 Nov 2023 21:09:38 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Liu, Yujie" <yujie.liu@intel.com>
Subject: [PATCH net-next v2 3/5] virtio-net: extract virtqueue coalescig cmd for reuse
Date: Thu,  2 Nov 2023 21:09:31 +0800
Message-Id: <b114655e675be17e7ebf78dbc48721640a7d4711.1698929590.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1698929590.git.hengqi@linux.alibaba.com>
References: <cover.1698929590.git.hengqi@linux.alibaba.com>
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


