Return-Path: <netdev+bounces-94412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7198BF65C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598CF282499
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51976199C7;
	Wed,  8 May 2024 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YeYW/jfh"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9EA94D
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150252; cv=none; b=FCWhwl8yakc1MoQJvyeLHqy18mwJZzZVS0L+QJCBPviijDLMD9W+OKDZ/Zpk1oUoOAAKWDFE35KGGUcv7QRCM4QAtZX42rsWExeZn2c4FDimd7O6QZbHY6mAHvoOGnDFLgFlPyNDD4XKF0E7WU2L0XlsjNb3472tWIIqP54GK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150252; c=relaxed/simple;
	bh=n6mg4XesdT1sasQ4rhkqIrST1eSMhlO7ON9mvf+RTao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NbeNazcBv/FXg9NkqA8B0+dhqNouF6uxm1wem96/UR3f4UFrA58Px1v/XPwUl0roQGBqaQctGS3kJ+0wLwjxaaLwY0v3RWbJgHoNSClW075vXI+uQ6/xeeHh0tvsfIrEMa/VfpkJkINrjW4GXFUGuyADr2VwufYWEdcy91r1FKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YeYW/jfh; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715150241; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZCv5CQGZmW/6p3pLhCJK6Ph9CKCR6rO9ZXIFczRA9H4=;
	b=YeYW/jfh/BoAuHeZJcSlp3h2ue8OBPUTxog5QbZZhc/AMy4Bl1+5LYx8CESb4EoEdyLmB3Shv66SKu6NhtdiRDUfG3mMXO7wPCzYg3AzJrOUpkPjf+qrgBzKsNPNwvr3eGI25EzOTjHL8SuVQ+OgQnOcGMJtiQg7r2iHcH8Bjf0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W62X2oK_1715150239;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62X2oK_1715150239)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 14:37:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next v4 1/4] virtio_ring: enable premapped mode whatever use_dma_api
Date: Wed,  8 May 2024 14:37:15 +0800
Message-Id: <20240508063718.69806-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508063718.69806-1-xuanzhuo@linux.alibaba.com>
References: <20240508063718.69806-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: cadd21343bbc
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
index 6f7e5010a673..85d0dc26ae9f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2782,7 +2782,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  *
  * Returns zero or a negative error.
  * 0: success.
- * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
+ * -EINVAL: the vq is in use.
  */
 int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 {
@@ -2798,11 +2798,6 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
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


