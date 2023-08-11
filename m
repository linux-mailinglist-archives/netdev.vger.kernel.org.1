Return-Path: <netdev+bounces-26641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB787787B1
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A821C210AB
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096DE1872;
	Fri, 11 Aug 2023 06:55:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1371865
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:55:20 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31E92717
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:55:18 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VpWGJDH_1691736914;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VpWGJDH_1691736914)
          by smtp.aliyun-inc.com;
          Fri, 11 Aug 2023 14:55:15 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next 1/8] virtio-net: initially change the value of tx-frames
Date: Fri, 11 Aug 2023 14:55:05 +0800
Message-Id: <20230811065512.22190-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230811065512.22190-1-hengqi@linux.alibaba.com>
References: <20230811065512.22190-1-hengqi@linux.alibaba.com>
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
1. When the user only wants to set rx coalescing params using
           ethtool -C eth0 rx-usecs 10, or
	   ethtool -Q eth0 queue_mask 0x1 -C rx-usecs 10,
   these cmds will carry tx-frames as 0, causing the napi_tx switching condition
   is satisfied. Then the user gets:
           netlink error: Device or resource busy.
   The same happens when trying to set rx-frames, adaptive_{rx, tx}.

2. When notification coalescing is not supported, switching napi_tx is
   a way to achieve coalescing. But now coalescing is supported,
   we don't need tx-frames to toggle napi_tx anymore.

3. The value of supported tx-frames cannot be set arbitrarily.
   When setting 0 and non-zero value, if the device is up, the user will always
   get EBUSY warning. Not intuitive.

Result:
When notification coalescing feature is negotiated, initially change the
value of tx-frames to be consistent with napi_tx.

Reported-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 42 +++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 82f9b899b938..3b254f778e7e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4376,13 +4376,6 @@ static int virtnet_probe(struct virtio_device *vdev)
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
 
@@ -4457,6 +4450,41 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (err)
 		goto free;
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
+		vi->intr_coal_rx.max_usecs = 0;
+		vi->intr_coal_tx.max_usecs = 0;
+		vi->intr_coal_rx.max_packets = 0;
+
+		/* Why is this needed?
+		 * If without this setting, consider that when VIRTIO_NET_F_NOTF_COAL is
+		 * negotiated and napi_tx is initially true: when the user sets non tx-frames
+		 * parameters, such as the following cmd or others,
+		 *		ethtool -C eth0 rx-usecs 10.
+		 * Then
+		 * 1. ethtool_set_coalesce() first calls virtnet_get_coalesce() to get
+		 *    the last parameters except rx-usecs. If tx-frames has never been set before,
+		 *    virtnet_get_coalesce() returns with tx-frames=0 in the parameters.
+		 * 2. virtnet_set_coalesce() is then called, according to 1:
+		 *    ec->tx_max_coalesced_frames=0. Now napi_tx switching condition is met.
+		 * 3. If the device is up, the user setting fails:
+		 *	       "netlink error: Device or resource busy"
+		 * This is not intuitive. Therefore, we keep napi_tx state consistent with
+		 * tx-frames when VIRTIO_NET_F_NOTF_COAL is negotiated. This behavior is
+		 * compatible with before.
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


