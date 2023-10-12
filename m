Return-Path: <netdev+bounces-40258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27FE7C669E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C7B282A3E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6105910798;
	Thu, 12 Oct 2023 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C4415E9C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 07:44:20 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDDAB8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:44:17 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VtziJfq_1697096653;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VtziJfq_1697096653)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 15:44:14 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"Liu, Yujie" <yujie.liu@intel.com>
Subject: [PATCH net-next 3/5] virtio-net: extract virtqueue coalescig cmd for reuse
Date: Thu, 12 Oct 2023 15:44:07 +0800
Message-Id: <5b99db97dd4b26636f306f70c8158d9d3297b4a0.1697093455.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1697093455.git.hengqi@linux.alibaba.com>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extract commands to set virtqueue coalescing parameters for reuse
by ethtool -Q, vq resize and netdim.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 106 +++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 42 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 54b3fb8d0384..caef78bb3963 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2846,6 +2846,58 @@ static void virtnet_cpu_notif_remove(struct virtnet_info *vi)
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
@@ -2903,14 +2955,11 @@ static int virtnet_set_ringparam(struct net_device *dev,
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
@@ -2919,14 +2968,11 @@ static int virtnet_set_ringparam(struct net_device *dev,
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
 
@@ -3327,48 +3373,24 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
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


