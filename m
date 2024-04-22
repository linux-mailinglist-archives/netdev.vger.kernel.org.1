Return-Path: <netdev+bounces-89903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED248AC298
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 03:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63F41C206AA
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 01:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660B205E33;
	Mon, 22 Apr 2024 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QoyjmIvV"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DE2114
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713750852; cv=none; b=Qe7fGhCNHtGr8LSET35vOqHoxqm/G0FStfd/Rv3xdxrTwiobwIazRjBPu3xAoZVV7Kz1Kg+QxDXaF5VnsOoNHLgBP11Hmd3Z8ZogP6L5a2XECnzc8Nl4HtIIhcpEDs0zVUOKNXfgtSTU1Iw89UvTcmFHlIIsuEXPhhPbtVIsmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713750852; c=relaxed/simple;
	bh=tUMAS9KXe4/O949IttMY1KiQyrT5G9XkJhUfio2jbWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGxOKk4aJA9TO9E7C02s9/Yqzi7c57Wso9lB6wm4h0WPYDOmYM4edC0pZx9jR52ouVXdoHINU/MvMDc0PASF3Xxf3Uq6woL/+WubO4UghH/FmA9q8mt9reEGMfwV8c+fl5J+79khqCl/QgQicdDW7WeUG2OR51J9vn2CK701n3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QoyjmIvV; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713750848; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QHpOwg5Ne5hMPAux5XPNVM+NNWi2LMfMQBgNF4Fv8HI=;
	b=QoyjmIvV+pEbgbviD5iiyAIwqPkMbQRoFD74K1VHDX9xTaPoPAEdouXRxSyjEBPQTH3l2RcAICS14E6m/lpay1YiN4ITXa4ljyqUscpCPhSmu0dI60x8fe/vFWFN9Za9FlBF77Vn6PumRfIPHeRRgp2CoT45NE/mKR78sPP2DYY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4y49bA_1713750846;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4y49bA_1713750846)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 09:54:07 +0800
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
Subject: [PATCH vhost v1 2/7] virtio_ring: enable premapped mode whatever use_dma_api
Date: Mon, 22 Apr 2024 09:53:58 +0800
Message-Id: <20240422015403.72526-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240422015403.72526-1-xuanzhuo@linux.alibaba.com>
References: <20240422015403.72526-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 2c089e81de7e
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


