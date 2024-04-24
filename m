Return-Path: <netdev+bounces-90804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95A8B0404
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0501C23A2A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 08:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F4158874;
	Wed, 24 Apr 2024 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lhPVaMvk"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A083158852
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946604; cv=none; b=VpdjhNi4g/SyPg5ps/elXCvh7hETy5q6STrKwrx2fCHPMgbgw390oY4FZSgdfx5iDKc8mFfdqmlNNuZr10QMBJ4USIv0qSKiPsm6lBBhKNxf6Ws+XNzbP+wF49RlAh9WV+dPtdw9bigIGhDilhp/q8rY/3+10EcLLOi6CbNqf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946604; c=relaxed/simple;
	bh=NJlhVIk+i2CaR+UbHOqH2FF6IWIQ6ho4vVfkYTFyau8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LeqjIMLvZN6QynDtQII+hG5w7s9g3aMJAseFpPqN8kmAceppttjLtX7vqdzg8gon+wnovB91CiR0zjHTvBx2C3d5aMPbU+h9CxLpWSrPFOgNg/k5NhenI9NWswnbgDt2edB0H9lwvPpUteTF6oDsnh4tUmq56uwvPS9G0lmW4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lhPVaMvk; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713946600; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OzEQNPLnA++t/PLJwBTlRHOLmT+PwyNSf7aFkogYhPw=;
	b=lhPVaMvkVqaiS/NnCT4whAhR2b139nQROliUCNjJTXNmbtuYGttjeViRrizKJ0bqKG8bZKjf33ZrM6jovEJi1Yhtuh5TwuW4PaBBJsfC1S+2VPmnywdbSDXj+CLZejN7mEy5PUGjZqQhTzNC634MItQtmWZ4pXkL5f5A+8Mzoc0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5BlATh_1713946598;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5BlATh_1713946598)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 16:16:39 +0800
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
Subject: [PATCH vhost v3 1/4] virtio_ring: enable premapped mode whatever use_dma_api
Date: Wed, 24 Apr 2024 16:16:33 +0800
Message-Id: <20240424081636.124029-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
References: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 55c7001bc45b
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
index 70de1a9a81a3..a939104d551f 100644
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


