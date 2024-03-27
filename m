Return-Path: <netdev+bounces-82434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4C88DC40
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674F91F2D199
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1032F58231;
	Wed, 27 Mar 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qspysmI3"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213C856B90
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538084; cv=none; b=Teo3RvOyluXax/D5qLPSAvb9NxWYFj/CDscrMUc8lxM++Q6X7pIalUxUVXZGjO0Psr2CQuJMiSFh8hZ4ABAPAFobHPr6AXRkjoButKeD7u9xCLLqmZFZNJUiyzSsWPBJlJaNPsCVzwQVbNJTGmSV9MxpMdbW88kaHVUpF9L1vsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538084; c=relaxed/simple;
	bh=jPgIC//oqX15uhnDw/hVVWgd7B6AAhWNZ9H0WbHTB9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEAUic/lZVEiZPYhdOMxKsaCz8sGO17equEt0fVS30RGbsg3+G/8TodH39D4aUkH4nq4D+LAf93nHcDzBIkh9o47Q6I8XRoFkhqlqoulUL+sSK45bumBF2I5/roAyO0Vp+EKjW9ZbcFLELyQZccJB3jFXxBsIOaZNpm8cKRmyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qspysmI3; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711538078; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ob0vYtVfzLTCs+gj7f1lmy1s+CIzODRQX0mHkXLMrls=;
	b=qspysmI3KWNI6k9zWkslaOAFSR0TrTTh33JT+5SPsli1XSCwBce43jmHM++HZaBqU1aGRtJ+Vdr1gLZrFNUEkvvpXAUFEjPWrCKjaiVNFEVw+3PGZbAdDa7TiD37K6fYPmUqorza2FLX9r5T/km05yWnDSc8GYYXvUSkhcMzzvA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3OcIu5_1711538077;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3OcIu5_1711538077)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 19:14:38 +0800
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
Subject: [PATCH vhost v6 07/10] virtio: find_vqs: add new parameter premapped
Date: Wed, 27 Mar 2024 19:14:27 +0800
Message-Id: <20240327111430.108787-8-xuanzhuo@linux.alibaba.com>
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

If the premapped mode is enabled, the dma array(struct vring_desc_dma) of
virtio core will not be allocated. That is judged when find_vqs() is
called. To avoid allocating dma array in find_vqs() and releasing it
immediately by virtqueue_set_dma_premapped(). This patch introduces a
new parameter to find_vqs(). Then we can judge should we allocate the
dma array(struct vring_desc_dma) or not inside find_vqs().

The driver must check the premapped mode of every vq after find_vqs().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c  | 4 ++--
 include/linux/virtio_config.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 08e4f6e1d722..bbdeab3a9648 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2148,7 +2148,7 @@ static struct virtqueue *vring_create_virtqueue_packed(struct virtio_device *vde
 	vq->packed_ring = true;
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
+	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, vq, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, vq, ctx);
@@ -2696,7 +2696,7 @@ static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
 #endif
 	vq->dma_dev = tp_cfg->dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
+	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, vq, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, vq, ctx);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 370e79df50c4..80b7974ca9ff 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -29,6 +29,8 @@ typedef void vq_callback_t(struct virtqueue *);
  * @ctx: (optional) array of context. If the value of the vq in the array
  *	is true, the driver can pass ctx to virtio core when adding bufs to
  *	virtqueue.
+ * @premapped: (optional) array of premapped. If the value of the vq in the
+ *      array is true, the vq will try to enable premapped mode.
  * @desc: desc for interrupts
  */
 struct virtio_vq_config {
@@ -38,6 +40,7 @@ struct virtio_vq_config {
 	vq_callback_t      **callbacks;
 	const char         **names;
 	const bool          *ctx;
+	const bool          *premapped;
 	struct irq_affinity *desc;
 };
 
-- 
2.32.0.3.g01195cf9f


