Return-Path: <netdev+bounces-36086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371D27AD25F
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 09:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C9DB72818D2
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AEA10A38;
	Mon, 25 Sep 2023 07:53:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0861118B
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 07:53:11 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E82E3
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 00:53:10 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VsoS-Om_1695628386;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VsoS-Om_1695628386)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:53:07 +0800
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
Subject: [PATCH net v2 3/6] virtio-net: consistently save parameters for per-queue
Date: Mon, 25 Sep 2023 15:52:59 +0800
Message-Id: <2e33885eceecbb6f1565d182a4b45d523cd31d34.1695627660.git.hengqi@linux.alibaba.com>
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

When using .set_coalesce interface to set all queue coalescing
parameters, we need to update both per-queue and global save values.

Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce command")
Cc: Gavin Li <gavinl@nvidia.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 15bac303e3ff..6120dd5343dd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3233,6 +3233,7 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 				       struct ethtool_coalesce *ec)
 {
 	struct scatterlist sgs_tx, sgs_rx;
+	int i;
 
 	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
 	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
@@ -3246,6 +3247,10 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	/* Save parameters */
 	vi->intr_coal_tx.max_usecs = ec->tx_coalesce_usecs;
 	vi->intr_coal_tx.max_packets = ec->tx_max_coalesced_frames;
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		vi->sq[i].intr_coal.max_usecs = ec->tx_coalesce_usecs;
+		vi->sq[i].intr_coal.max_packets = ec->tx_max_coalesced_frames;
+	}
 
 	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
 	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
@@ -3259,6 +3264,10 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	/* Save parameters */
 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
 	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
+		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+	}
 
 	return 0;
 }
-- 
2.19.1.6.gb485710b


