Return-Path: <netdev+bounces-23086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E83776AAD1
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F6528177B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F21F951;
	Tue,  1 Aug 2023 08:22:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF31EA9A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:22:45 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D425DF
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 01:22:44 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VoopI6T_1690878159;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VoopI6T_1690878159)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 16:22:40 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC PATCH 3/6] virtio-net: extract virtqueue coalescig cmd for reuse
Date: Tue,  1 Aug 2023 16:22:32 +0800
Message-Id: <20230801082235.21634-4-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230801082235.21634-1-hengqi@linux.alibaba.com>
References: <20230801082235.21634-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extract commands to set virtqueue coalescing parameters for reuse
by ethtool -Q and netdim.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 54 +++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9bf39024d53d..91b284567c96 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3129,6 +3129,42 @@ static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 	return 0;
 }
 
+static int virtnet_send_tx_notf_coal_vq_cmd(struct virtnet_info *vi,
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
+	/* Save parameters */
+	vi->sq[queue].intr_coal.max_usecs = max_usecs;
+	vi->sq[queue].intr_coal.max_packets = max_packets;
+
+	return 0;
+}
+
+static int virtnet_send_rx_notf_coal_vq_cmd(struct virtnet_info *vi,
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
+	/* Save parameters */
+	vi->rq[queue].intr_coal.max_usecs = max_usecs;
+	vi->rq[queue].intr_coal.max_packets = max_packets;
+
+	return 0;
+}
+
 static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec,
 					  u16 queue)
@@ -3136,25 +3172,19 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 	int err;
 
 	if (ec->rx_coalesce_usecs || ec->rx_max_coalesced_frames) {
-		err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
-						    ec->rx_coalesce_usecs,
-						    ec->rx_max_coalesced_frames);
+		err = virtnet_send_rx_notf_coal_vq_cmd(vi, queue,
+						       ec->rx_coalesce_usecs,
+						       ec->rx_max_coalesced_frames);
 		if (err)
 			return err;
-		/* Save parameters */
-		vi->rq[queue].intr_coal.max_usecs = ec->rx_coalesce_usecs;
-		vi->rq[queue].intr_coal.max_packets = ec->rx_max_coalesced_frames;
 	}
 
 	if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
-		err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
-						    ec->tx_coalesce_usecs,
-						    ec->tx_max_coalesced_frames);
+		err = virtnet_send_tx_notf_coal_vq_cmd(vi, queue,
+						       ec->tx_coalesce_usecs,
+						       ec->tx_max_coalesced_frames);
 		if (err)
 			return err;
-		/* Save parameters */
-		vi->sq[queue].intr_coal.max_usecs = ec->tx_coalesce_usecs;
-		vi->sq[queue].intr_coal.max_packets = ec->tx_max_coalesced_frames;
 	}
 
 	return 0;
-- 
2.19.1.6.gb485710b


