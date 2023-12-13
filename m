Return-Path: <netdev+bounces-55839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF14D80C6BD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0EE2816DD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5C2556F;
	Mon, 11 Dec 2023 10:36:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE88DD2
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 02:36:12 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyG86RU_1702290968;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VyG86RU_1702290968)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 18:36:09 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	yinjun.zhang@corigine.com,
	edumazet@google.com,
	davem@davemloft.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	ast@kernel.org,
	horms@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v8 1/4] virtio-net: returns whether napi is complete
Date: Mon, 11 Dec 2023 18:36:04 +0800
Message-Id: <4497004c8ba06fdb621689e40c2f801c493c83ea.1702275514.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1702275514.git.hengqi@linux.alibaba.com>
References: <cover.1702275514.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rx netdim needs to count the traffic during a complete napi process,
and start updating and comparing samples to make decisions after
the napi ends. Let virtqueue_napi_complete() return true if napi is done,
otherwise vice versa.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d16f592c2061..0ad2894e6a5e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -431,7 +431,7 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
 	}
 }
 
-static void virtqueue_napi_complete(struct napi_struct *napi,
+static bool virtqueue_napi_complete(struct napi_struct *napi,
 				    struct virtqueue *vq, int processed)
 {
 	int opaque;
@@ -440,9 +440,13 @@ static void virtqueue_napi_complete(struct napi_struct *napi,
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


