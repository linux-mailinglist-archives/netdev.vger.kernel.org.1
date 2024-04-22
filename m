Return-Path: <netdev+bounces-89962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7EC8AC575
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A81283141
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 07:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D44850271;
	Mon, 22 Apr 2024 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t7KKPKnq"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378B4F613
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770657; cv=none; b=C28B+ZYUg4XOwrOH8CtewfV/v9attsfcdyJxo2SPd6/NKTj4ntzGB32a0rxwLrW7tEQv3z9BZqtINP33Irmdl9E8mkUhIHLd8wfsNt2UyZ+CZTZ6ds5XeVdWlefgPQXp7wJYmpeQFuuFnwyvXrVbeUfGOY+lin7R2FWZkJqtJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770657; c=relaxed/simple;
	bh=tUMAS9KXe4/O949IttMY1KiQyrT5G9XkJhUfio2jbWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qGyHKy3ai5tQqYmWpbJGobFpDD1GS/mEVHg0OOm7x9yR19dk1CTMGpc6BLqlBM/T2kx5FK6pg54wSrPEPtDixUk0gBC1fdRPRI/eEySrZLK2OArmu2sbLPwVUy6bGiV/vF5x6Eog+kVrwx3OIE903kKQkyAObbit/uI0qbDpeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t7KKPKnq; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713770653; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QHpOwg5Ne5hMPAux5XPNVM+NNWi2LMfMQBgNF4Fv8HI=;
	b=t7KKPKnqipEWAIFuI1WC4I8XC5kSUWLP3kPPN2TBmaXXJbUtPiRFJF8rXoWaSayzj43pdPpUrvGd2xm7nop4D5kxV2TSwHOz5Lr2WaQ4ksflDJnGA3yc/fyLYgjU00eaWsJfqBF5S4sKaWIfNBb+0DnFIIEF60rQlsHARgsTCYU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5.Wv0E_1713770651;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5.Wv0E_1713770651)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:24:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost v2 2/7] virtio_ring: enable premapped mode whatever use_dma_api
Date: Mon, 22 Apr 2024 15:24:03 +0800
Message-Id: <20240422072408.126821-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
References: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: aa968d36d784
Content-Transfer-Encoding: 8bit

Now, we have virtio DMA APIs, the driver can be the premapped
mode whatever the virtio core uses dma api or not.

So remove the limit of checking use_dma_api from
virtqueue_set_dma_premapped().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1b9fb680cff3..1924402e0d84 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2730,7 +2730,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  *
  * Returns zero or a negative error.
  * 0: success.
- * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
+ * -EINVAL: the vq is in use.
  */
 int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 {
@@ -2746,11 +2746,6 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
-	if (!vq->use_dma_api) {
-		END_USE(vq);
-		return -EINVAL;
-	}
-
 	vq->premapped = true;
 	vq->do_unmap = false;
 
-- 
2.32.0.3.g01195cf9f


