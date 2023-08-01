Return-Path: <netdev+bounces-23084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38EF76AACD
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED3D1C20E1B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6DA1ED4B;
	Tue,  1 Aug 2023 08:22:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B51EA9A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:22:43 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00850A0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 01:22:41 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VoopI5K_1690878156;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VoopI5K_1690878156)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 16:22:37 +0800
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
Subject: [RFC PATCH 1/6] virtio-net: returns whether napi is complete
Date: Tue,  1 Aug 2023 16:22:30 +0800
Message-Id: <20230801082235.21634-2-hengqi@linux.alibaba.com>
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

rx netdim needs to count the traffic during a complete napi process,
and start updating and comparing samples to make decisions after
the napi ends. Let virtqueue_napi_complete() return true if napi is done,
otherwise vice versa.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 10eba113b5fa..30dd12e7d28f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -407,7 +407,7 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
 	}
 }
 
-static void virtqueue_napi_complete(struct napi_struct *napi,
+static bool virtqueue_napi_complete(struct napi_struct *napi,
 				    struct virtqueue *vq, int processed)
 {
 	int opaque;
@@ -416,9 +416,13 @@ static void virtqueue_napi_complete(struct napi_struct *napi,
 	if (napi_complete_done(napi, processed)) {
 		if (unlikely(virtqueue_poll(vq, opaque)))
 			virtqueue_napi_schedule(napi, vq);
+		else
+			return true;
 	} else {
 		virtqueue_disable_cb(vq);
 	}
+
+	return false;
 }
 
 static void skb_xmit_done(struct virtqueue *vq)
-- 
2.19.1.6.gb485710b


