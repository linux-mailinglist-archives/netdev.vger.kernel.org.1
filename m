Return-Path: <netdev+bounces-38867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FF37BCCB3
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 08:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C18281F93
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 06:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078E5662;
	Sun,  8 Oct 2023 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172C7497
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 06:27:56 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074BED6
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 23:27:54 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VtdH-lB_1696746471;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VtdH-lB_1696746471)
          by smtp.aliyun-inc.com;
          Sun, 08 Oct 2023 14:27:52 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Gavin Li <gavinl@nvidia.com>
Subject: [PATCH v3 5/6] virtio-net: fix the vq coalescing setting for vq resize
Date: Sun,  8 Oct 2023 14:27:43 +0800
Message-Id: <494591ced310bcb971d691dd3974700bc12fcf59.1696745452.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1696745452.git.hengqi@linux.alibaba.com>
References: <cover.1696745452.git.hengqi@linux.alibaba.com>
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

According to the definition of virtqueue coalescing spec[1]:

  Upon disabling and re-enabling a transmit virtqueue, the device MUST set
  the coalescing parameters of the virtqueue to those configured through the
  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set
  any TX coalescing parameters, to 0.

  Upon disabling and re-enabling a receive virtqueue, the device MUST set
  the coalescing parameters of the virtqueue to those configured through the
  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did not set
  any RX coalescing parameters, to 0.

We need to add this setting for vq resize (ethtool -G) where vq_reset happens.

[1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415.html

Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce command")
Cc: Gavin Li <gavinl@nvidia.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v2->v3:
    1. Remove a useless comment and add the ack tag.

 drivers/net/virtio_net.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 12ec3ae19b60..4c3d16db72f7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2855,6 +2855,9 @@ static void virtnet_get_ringparam(struct net_device *dev,
 	ring->tx_pending = virtqueue_get_vring_size(vi->sq[0].vq);
 }
 
+static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
+					 u16 vqn, u32 max_usecs, u32 max_packets);
+
 static int virtnet_set_ringparam(struct net_device *dev,
 				 struct ethtool_ringparam *ring,
 				 struct kernel_ethtool_ringparam *kernel_ring,
@@ -2890,12 +2893,36 @@ static int virtnet_set_ringparam(struct net_device *dev,
 			err = virtnet_tx_resize(vi, sq, ring->tx_pending);
 			if (err)
 				return err;
+
+			/* Upon disabling and re-enabling a transmit virtqueue, the device must
+			 * set the coalescing parameters of the virtqueue to those configured
+			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver
+			 * did not set any TX coalescing parameters, to 0.
+			 */
+			err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(i),
+							    vi->intr_coal_tx.max_usecs,
+							    vi->intr_coal_tx.max_packets);
+			if (err)
+				return err;
+
+			vi->sq[i].intr_coal.max_usecs = vi->intr_coal_tx.max_usecs;
+			vi->sq[i].intr_coal.max_packets = vi->intr_coal_tx.max_packets;
 		}
 
 		if (ring->rx_pending != rx_pending) {
 			err = virtnet_rx_resize(vi, rq, ring->rx_pending);
 			if (err)
 				return err;
+
+			/* The reason is same as the transmit virtqueue reset */
+			err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(i),
+							    vi->intr_coal_rx.max_usecs,
+							    vi->intr_coal_rx.max_packets);
+			if (err)
+				return err;
+
+			vi->rq[i].intr_coal.max_usecs = vi->intr_coal_rx.max_usecs;
+			vi->rq[i].intr_coal.max_packets = vi->intr_coal_rx.max_packets;
 		}
 	}
 
-- 
2.19.1.6.gb485710b


