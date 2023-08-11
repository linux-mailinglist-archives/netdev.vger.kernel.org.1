Return-Path: <netdev+bounces-26643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235BC7787B6
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A03282047
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D91442A;
	Fri, 11 Aug 2023 06:55:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A882B4406
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:55:23 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D991FCF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:55:22 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpWD-9a_1691736915;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VpWD-9a_1691736915)
          by smtp.aliyun-inc.com;
          Fri, 11 Aug 2023 14:55:16 +0800
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
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Gavin Li <gavinl@nvidia.com>
Subject: [PATCH net-next 2/8] virtio-net: fix mismatch of getting txq tx-frames param
Date: Fri, 11 Aug 2023 14:55:06 +0800
Message-Id: <20230811065512.22190-3-hengqi@linux.alibaba.com>
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

Now virtio-net allows switching napi_tx for each txq. Therefore, we
get the corresponding tx-frames for virtnet_get_per_queue_coalesce().

Note: in virtnet_get_coalesce(), since different txqs may have different
napi_tx values, the value of txq[0] is used as a representative.

Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce command")
Cc: Gavin Li <gavinl@nvidia.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3b254f778e7e..b1b4038f06e3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3379,7 +3379,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
-		if (vi->sq[0].napi.weight)
+		if (vi->sq[queue].napi.weight)
 			ec->tx_max_coalesced_frames = 1;
 	}
 
-- 
2.19.1.6.gb485710b


