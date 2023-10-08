Return-Path: <netdev+bounces-38866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE467BCCB2
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 08:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795BC2821C9
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 06:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6F568F;
	Sun,  8 Oct 2023 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53AE6129
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 06:27:55 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E2CF
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 23:27:54 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VtdH-ks_1696746470;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VtdH-ks_1696746470)
          by smtp.aliyun-inc.com;
          Sun, 08 Oct 2023 14:27:50 +0800
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
Subject: [PATCH v3 4/6] virtio-net: fix per queue coalescing parameter setting
Date: Sun,  8 Oct 2023 14:27:42 +0800
Message-Id: <c2188831f03c4096910847c134aeff256204d1ea.1696745452.git.hengqi@linux.alibaba.com>
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

When the user sets a non-zero coalescing parameter to 0 for a specific
virtqueue, it does not work as expected, so let's fix this.

Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce command")
Reported-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
Cc: Gavin Li <gavinl@nvidia.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v2->v3:
    1. Add the ack tag.

v1->v2:
    1. Remove useless comments.

 drivers/net/virtio_net.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6120dd5343dd..12ec3ae19b60 100644
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
+	vi->rq[queue].intr_coal.max_usecs = ec->rx_coalesce_usecs;
+	vi->rq[queue].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+
+	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
+					    ec->tx_coalesce_usecs,
+					    ec->tx_max_coalesced_frames);
+	if (err)
+		return err;
+
+	vi->sq[queue].intr_coal.max_usecs = ec->tx_coalesce_usecs;
+	vi->sq[queue].intr_coal.max_packets = ec->tx_max_coalesced_frames;
 
 	return 0;
 }
-- 
2.19.1.6.gb485710b


