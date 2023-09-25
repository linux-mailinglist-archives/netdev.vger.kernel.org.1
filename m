Return-Path: <netdev+bounces-36083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42A87AD259
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 09:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E803F2813EC
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69410A3B;
	Mon, 25 Sep 2023 07:53:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D56128
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 07:53:09 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDDBD3
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 00:53:07 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsoOBLu_1695628384;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VsoOBLu_1695628384)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:53:05 +0800
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
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net v2 1/6] virtio-net: initially change the value of tx-frames
Date: Mon, 25 Sep 2023 15:52:57 +0800
Message-Id: <b84cfe4015184a54078813c2e951207317c47fce.1695627660.git.hengqi@linux.alibaba.com>
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Background:
1. Commit 0c465be183c7 ("virtio_net: ethtool tx napi configuration") uses
   tx-frames to toggle napi_tx (0 off and 1 on) if notification coalescing
   is not supported.
2. Commit 31c03aef9bc2 ("virtio_net: enable napi_tx by default") enables
   napi_tx for all txqs by default.

Status:
When virtio-net supports notification coalescing, after initialization,
tx-frames is 0 and napi_tx is true.

Problem:
When the user only wants to set rx coalescing params using
           ethtool -C eth0 rx-usecs 10, or
	   ethtool -Q eth0 queue_mask 0x1 -C rx-usecs 10,
these cmds will carry tx-frames as 0, causing the napi_tx switching condition
is satisfied. Then the user gets:
           netlink error: Device or resource busy.

The same happens when trying to set rx-frames, adaptive_rx, adaptive_tx...

How to fix:
When notification coalescing feature is negotiated, initially make the
value of tx-frames to be consistent with napi_tx.

For compatibility with the past, it is still supported to use tx-frames
to toggle napi_tx.

Reported-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fe7f314d65c9..10878c9d430a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4442,13 +4442,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->xdp_features |= NETDEV_XDP_ACT_RX_SG;
 	}
 
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
-		vi->intr_coal_rx.max_usecs = 0;
-		vi->intr_coal_tx.max_usecs = 0;
-		vi->intr_coal_tx.max_packets = 0;
-		vi->intr_coal_rx.max_packets = 0;
-	}
-
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
@@ -4523,6 +4516,27 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (err)
 		goto free;
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
+		vi->intr_coal_rx.max_usecs = 0;
+		vi->intr_coal_tx.max_usecs = 0;
+		vi->intr_coal_rx.max_packets = 0;
+
+		/* Keep the default values of the coalescing parameters
+		 * aligned with the default napi_tx state.
+		 */
+		if (vi->sq[0].napi.weight)
+			vi->intr_coal_tx.max_packets = 1;
+		else
+			vi->intr_coal_tx.max_packets = 0;
+	}
+
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		/* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			if (vi->sq[i].napi.weight)
+				vi->sq[i].intr_coal.max_packets = 1;
+	}
+
 #ifdef CONFIG_SYSFS
 	if (vi->mergeable_rx_bufs)
 		dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
-- 
2.19.1.6.gb485710b


