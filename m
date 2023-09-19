Return-Path: <netdev+bounces-34887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFABD7A5B9A
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DFE282238
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 07:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF638DD3;
	Tue, 19 Sep 2023 07:49:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6D38DD5
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:49:26 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8D9123
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:49:24 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VsQbAMz_1695109760;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VsQbAMz_1695109760)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 15:49:21 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
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
Subject: [PATCH net 4/6] virtio-net: fix per queue coalescing parameter setting
Date: Tue, 19 Sep 2023 15:49:13 +0800
Message-Id: <20230919074915.103110-5-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230919074915.103110-1-hengqi@linux.alibaba.com>
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
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

When the user sets a non-zero coalescing parameter to 0 for a specific
virtqueue, it does not work as expected, so let's fix this.

Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce command")
Reported-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
Cc: Gavin Li <gavinl@nvidia.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ce60162d380a..f9a7f6afd099 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3296,27 +3296,23 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 {
 	int err;
 
-	if (ec->rx_coalesce_usecs || ec->rx_max_coalesced_frames) {
-		err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
-						    ec->rx_coalesce_usecs,
-						    ec->rx_max_coalesced_frames);
-		if (err)
-			return err;
-		/* Save parameters */
-		vi->rq[queue].intr_coal.max_usecs = ec->rx_coalesce_usecs;
-		vi->rq[queue].intr_coal.max_packets = ec->rx_max_coalesced_frames;
-	}
+	err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
+					    ec->rx_coalesce_usecs,
+					    ec->rx_max_coalesced_frames);
+	if (err)
+		return err;
+	/* Save parameters */
+	vi->rq[queue].intr_coal.max_usecs = ec->rx_coalesce_usecs;
+	vi->rq[queue].intr_coal.max_packets = ec->rx_max_coalesced_frames;
 
-	if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
-		err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
-						    ec->tx_coalesce_usecs,
-						    ec->tx_max_coalesced_frames);
-		if (err)
-			return err;
-		/* Save parameters */
-		vi->sq[queue].intr_coal.max_usecs = ec->tx_coalesce_usecs;
-		vi->sq[queue].intr_coal.max_packets = ec->tx_max_coalesced_frames;
-	}
+	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
+					    ec->tx_coalesce_usecs,
+					    ec->tx_max_coalesced_frames);
+	if (err)
+		return err;
+	/* Save parameters */
+	vi->sq[queue].intr_coal.max_usecs = ec->tx_coalesce_usecs;
+	vi->sq[queue].intr_coal.max_packets = ec->tx_max_coalesced_frames;
 
 	return 0;
 }
-- 
2.19.1.6.gb485710b


