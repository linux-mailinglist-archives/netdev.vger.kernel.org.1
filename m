Return-Path: <netdev+bounces-82433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C5C88DC3E
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6711F2D209
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C799558201;
	Wed, 27 Mar 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FwLt4lnE"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1C55E71
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538083; cv=none; b=JVLlk4L2fIPPeUrKSncrtfIwf41NqqcDlTg33bVg5PfmMVY62igbGh5xzUTY/FxdelrQKPhbFRfZRW46dmeOuyj0q03E0J8OjeKmhHIpsnMAWt8WX/yLMPN7ScY+WXguRvb09gUH8wFUWETeqm3ufwqr6b0I9w5TAGM2VLSSyoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538083; c=relaxed/simple;
	bh=DtdLlhcp5wWl4JYv1rkl2dJW98dpHBX4jJq0BdcnX7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oui14DD5IWpHDUZuOu6E+ybTkwxwKv9/pz3+J/pcus3+yYSe4gnDl7agKRakdlaOxdxCeI99OfDy4n1KerUNkmvl57YPfEwRlcWLtNYYENUHlx2fTS3oadKrqxusEQ3FjbqAmw3BARNecBOPsLR4cIBHAc1Md1O3SbKPr1Iv9cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FwLt4lnE; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711538079; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bgah49XhYIGEFxaCrVyHdvA7HW03bRkAuPZMsTRBhHE=;
	b=FwLt4lnEcICNoJcWNIWeAKYWFjdVc1G3z8h+LNx43eFUMnVsxzz7/OQwn4wi10KrtJLdSI2cWvQdouEeREp2t3IsfO/L+Wb12+UGvfjU19X+rWrWr6C94jVMixK00chkSOFJKxmoVPldETl6zLWDW2Bw7C7fzeZtLuBNFkedcGs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3ObwSU_1711538078;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3ObwSU_1711538078)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 19:14:39 +0800
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
Subject: [PATCH vhost v6 08/10] virtio_ring: export premapped to driver by struct virtqueue
Date: Wed, 27 Mar 2024 19:14:28 +0800
Message-Id: <20240327111430.108787-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e859552de2d6
Content-Transfer-Encoding: 8bit

Export the premapped to drivers, then drivers can check
the vq premapped mode after the find_vqs().
Because the find_vqs() just try to enable the vq premapped mode,
the driver must check that after find_vqs().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 13 +++++--------
 include/linux/virtio.h       |  1 +
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index bbdeab3a9648..543204e26c5a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -177,9 +177,6 @@ struct vring_virtqueue {
 	/* Host publishes avail event idx */
 	bool event;
 
-	/* Do DMA mapping by driver */
-	bool premapped;
-
 	/* Head of free buffer list. */
 	unsigned int free_head;
 	/* Number we've added since last sync. */
@@ -297,7 +294,7 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
 
 static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring)
 {
-	return vring->use_dma_api && !vring->premapped;
+	return vring->use_dma_api && !vring->vq.premapped;
 }
 
 size_t virtio_max_dma_size(const struct virtio_device *vdev)
@@ -369,7 +366,7 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr)
 {
-	if (vq->premapped) {
+	if (vq->vq.premapped) {
 		*addr = sg_dma_address(sg);
 		return 0;
 	}
@@ -2148,7 +2145,7 @@ static struct virtqueue *vring_create_virtqueue_packed(struct virtio_device *vde
 	vq->packed_ring = true;
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, vq, premapped);
+	vq->vq.premapped = vq->use_dma_api && cfg_vq_get(cfg, vq, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, vq, ctx);
@@ -2696,7 +2693,7 @@ static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
 #endif
 	vq->dma_dev = tp_cfg->dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, vq, premapped);
+	vq->vq.premapped = vq->use_dma_api && cfg_vq_get(cfg, vq, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, vq, ctx);
@@ -2832,7 +2829,7 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
-	vq->premapped = true;
+	vq->vq.premapped = true;
 
 	if (vq->packed_ring) {
 		kfree(vq->packed.desc_dma);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b0201747a263..407277d5a16b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -36,6 +36,7 @@ struct virtqueue {
 	unsigned int num_free;
 	unsigned int num_max;
 	bool reset;
+	bool premapped;
 	void *priv;
 };
 
-- 
2.32.0.3.g01195cf9f


