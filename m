Return-Path: <netdev+bounces-82436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DDD88DC43
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E761F2D1DF
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3E5733F;
	Wed, 27 Mar 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LIyWJ3+V"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2BD58218
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538085; cv=none; b=QODnrWq3T+6Jjfh927mKIEz+XcmtlpST9HIkZx/+T8dvE9I/pgx4t0ihQuHUgAJJdUQ4dBude3DMarc478YiG5Ymf0uKt+RbUOPwJWc+Ww+Sr/l2B/Q0MEFeKiVssNR/c/dhONI51mU9bPJAjm5tpyo9O3kyvX9yvb7cEBL9qb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538085; c=relaxed/simple;
	bh=IBTQxKw6ulQLDR4/WxtUu0l05E6HxLuNQ/VpFkLe0N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twsQFjqbfr8O1aQW6K/R1eh0/8dmmXDOLLuAhXjg+/A+9rO0pE/FOc1xfA9irDMbD38NyDenY5JxTl03VdHqK4OC3+O1AfOuVgx2cZjQ67AbZaZRI6XxLobNskFIFcb2JQAywkZDZnc1HxKPGYhnD9RjWkeP3g+yE2w6PepmYcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LIyWJ3+V; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711538082; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=T3OsMKRTSQ1/QsPE0gmGM4TfmFWE+l9jO6H/0NIiVac=;
	b=LIyWJ3+VraQKW/Jaw7fjukjSA5lqb0stJ2QdNYYmWmWH6N8IC0zCh9g447hrdZhqNRC1JBGYGoFKer3wLxQ5p/yHXQgt3OKKdIbZajo3frIfKxPUGAOL9w/n/5E4yGfKxvnRCSJY1uLNtjd+O7G0El2cvZpO0O7+8ktr40n1EDQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3OcIv6_1711538080;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3OcIv6_1711538080)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 19:14:40 +0800
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
Subject: [PATCH vhost v6 10/10] virtio_ring: virtqueue_set_dma_premapped support disable
Date: Wed, 27 Mar 2024 19:14:30 +0800
Message-Id: <20240327111430.108787-11-xuanzhuo@linux.alibaba.com>
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

Now, the API virtqueue_set_dma_premapped just support to
enable premapped mode.

If we allow enabling the premapped dynamically, we should
make this API to support disable the premapped mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 39 +++++++++++++++++++++++++++---------
 include/linux/virtio.h       |  2 +-
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 543204e26c5a..832fffd93f29 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2792,6 +2792,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
 /**
  * virtqueue_set_dma_premapped - set the vring premapped mode
  * @_vq: the struct virtqueue we're talking about.
+ * @premapped: enable/disable the premapped mode.
  *
  * Enable the premapped mode of the vq.
  *
@@ -2808,11 +2809,15 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  *
  * Returns zero or a negative error.
  * 0: success.
- * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
+ * -EINVAL:
+ *	vring does not use the dma api, so we can not enable premapped mode.
+ *	Or some descs are used, this is not called immediately after creating
+ *	the vq, or after vq reset.
  */
-int virtqueue_set_dma_premapped(struct virtqueue *_vq)
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	int err = 0;
 	u32 num;
 
 	START_USE(vq);
@@ -2824,24 +2829,40 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
+	if (vq->vq.premapped == premapped) {
+		END_USE(vq);
+		return 0;
+	}
+
 	if (!vq->use_dma_api) {
 		END_USE(vq);
 		return -EINVAL;
 	}
 
-	vq->vq.premapped = true;
+	if (premapped) {
+		vq->vq.premapped = true;
+
+		if (vq->packed_ring) {
+			kfree(vq->packed.desc_dma);
+			vq->packed.desc_dma = NULL;
+		} else {
+			kfree(vq->split.desc_dma);
+			vq->split.desc_dma = NULL;
+		}
 
-	if (vq->packed_ring) {
-		kfree(vq->packed.desc_dma);
-		vq->packed.desc_dma = NULL;
 	} else {
-		kfree(vq->split.desc_dma);
-		vq->split.desc_dma = NULL;
+		if (vq->packed_ring)
+			err = vring_alloc_dma_split(&vq->split, false);
+		else
+			err = vring_alloc_dma_packed(&vq->packed, false);
+
+		if (!err)
+			vq->vq.premapped = false;
 	}
 
 	END_USE(vq);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 407277d5a16b..4b338590abf4 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -82,7 +82,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
-int virtqueue_set_dma_premapped(struct virtqueue *_vq);
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped);
 
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
-- 
2.32.0.3.g01195cf9f


