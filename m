Return-Path: <netdev+bounces-36088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690C87AD25C
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 09:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 81AB71C20A5F
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 07:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363F11182;
	Mon, 25 Sep 2023 07:53:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B11118B
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 07:53:14 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC3DB3
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 00:53:12 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VsoCOPF_1695628389;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VsoCOPF_1695628389)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:53:10 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Gavin Li <gavinl@nvidia.com>
Subject: [PATCH net v2 5/6] virtio-net: fix the vq coalescing setting for vq resize
Date: Mon, 25 Sep 2023 15:53:01 +0800
Message-Id: <1b4f480bed95951b6f4805d6c4e72dd1a315acab.1695627660.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1695627660.git.hengqi@linux.alibaba.com>
References: <cover.1695627660.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/net/virtio_net.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 12ec3ae19b60..cb19b224419b 100644
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
+			/* Save parameters */
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
+			/* Save parameters */
+			vi->rq[i].intr_coal.max_usecs = vi->intr_coal_rx.max_usecs;
+			vi->rq[i].intr_coal.max_packets = vi->intr_coal_rx.max_packets;
 		}
 	}
 
-- 
2.19.1.6.gb485710b


