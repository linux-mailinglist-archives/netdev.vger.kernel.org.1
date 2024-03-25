Return-Path: <netdev+bounces-81550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E20E88A896
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3B1B25BE6
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4359D15CD62;
	Mon, 25 Mar 2024 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vBaE13DC"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9F15ECED
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356882; cv=none; b=lXxK0cmoApt83jZi1z2Y/L2q8tfiLmbEEqX3KMSb0mIPTj31HMq5vvWJKhSwl3ChF8XrCVGYFo+g3L/NKt8ABs1RE39tDjuZDxMP9VkHWYRRJ406Eud8IM2i1i2G08nVYjMzz4V1NLR4dx+CYWm+xRoTDLW1fV/EuoUS5HnLEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356882; c=relaxed/simple;
	bh=C2wareyrNe4XTdjYFHSW33kyY+EDYFppe02n9prGlrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFLXXSR3nfDJDTz/KpyUXvFCj17ryhxs7jnr9UnB9GzklnCKDK97telfEUiEq5fbtuiG2ZqRUn4eWjYBEvOjEzUU+oDM9XgMPqcZiAV8V+IVkA7wLeAAMVURzKc2EaBp8JTBkCuYel8LEIoNq1wGBqkT6CJCfiS5gFb0EMKLUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vBaE13DC; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711356878; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mjyaJ/lHge8lX78gpF62ArwsRfPZNDUl+yUs9r/5GSQ=;
	b=vBaE13DCV6mvSbYmlEtZGaot0XX+pNFaYJIABkQj565rtumn6I6sM+t7Zp50VwsWXhqZ+NkHEJhGsWKd89gr7CKFDGkZgE1ovttuOFW+Z64JPJeincGGhDG58t5Bwls1PVxzzSqcOATJ1hS0ERNpEd9D8IS/FZnaq3sdZkC9tKY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3DMz-0_1711356876;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DMz-0_1711356876)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 16:54:37 +0800
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
Subject: [PATCH vhost v5 08/10] virtio_ring: export premapped to driver by struct virtqueue
Date: Mon, 25 Mar 2024 16:54:26 +0800
Message-Id: <20240325085428.7275-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
References: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 630d711f51f7
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
index b0a715f23f17..86a60c720a62 100644
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
-	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
+	vq->vq.premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
@@ -2696,7 +2693,7 @@ static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
 #endif
 	vq->dma_dev = tp_cfg->dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
+	vq->vq.premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
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


