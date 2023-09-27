Return-Path: <netdev+bounces-36417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757687AFA62
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 07:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0302A28147C
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 05:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD9414A92;
	Wed, 27 Sep 2023 05:52:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC6911CBC
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:52:52 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C2D1713
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 22:52:50 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VszCD.b_1695793966;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VszCD.b_1695793966)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 13:52:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH vhost] virtio_net: fix the missing of the dma cpu sync
Date: Wed, 27 Sep 2023 13:52:46 +0800
Message-Id: <20230927055246.121544-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: c5d9aae29ad9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 295525e29a5b ("virtio_net: merge dma operations when filling
mergeable buffers") unmaps the buffer with DMA_ATTR_SKIP_CPU_SYNC when
the dma->ref is zero. We do that with DMA_ATTR_SKIP_CPU_SYNC, because we
do not want to do the sync for the entire page_frag. But that misses the
sync for the current area.

This patch does cpu sync regardless of whether the ref is zero or not.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Reported-by: Michael Roth <michael.roth@amd.com>
Closes: http://lore.kernel.org/all/20230926130451.axgodaa6tvwqs3ut@amd.com
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 98dc9b49d56b..9ece27dc5144 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -589,16 +589,16 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
 
 	--dma->ref;
 
-	if (dma->ref) {
-		if (dma->need_sync && len) {
-			offset = buf - (head + sizeof(*dma));
+	if (dma->need_sync && len) {
+		offset = buf - (head + sizeof(*dma));
 
-			virtqueue_dma_sync_single_range_for_cpu(rq->vq, dma->addr, offset,
-								len, DMA_FROM_DEVICE);
-		}
+		virtqueue_dma_sync_single_range_for_cpu(rq->vq, dma->addr,
+							offset, len,
+							DMA_FROM_DEVICE);
+	}
 
+	if (dma->ref)
 		return;
-	}
 
 	virtqueue_dma_unmap_single_attrs(rq->vq, dma->addr, dma->len,
 					 DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
-- 
2.32.0.3.g01195cf9f


