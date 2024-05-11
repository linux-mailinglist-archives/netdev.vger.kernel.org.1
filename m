Return-Path: <netdev+bounces-95667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D81A8C2F3F
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 05:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073A2B22DCD
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86FD24B29;
	Sat, 11 May 2024 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YUFjv5Pw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9B24B4A
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397252; cv=none; b=NxE2Dxab8CNmsaberBmCVhAQQFfjZrlk/QXc7ZsMLBAwe8vPqizvKemDkePD9L0dQZfTNIKeKbdSF0rWXzWiId5rECmON9xAB9HDsSawzvIouV+cqq3mx/Dw1hHzJ5n2I87QaU2bbciE5F8hnUlam9Ck02dhX2tHGZ5o66Lko6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397252; c=relaxed/simple;
	bh=omzQzopQH0JW8bJGtHY/sj2RzVtBsWUvr+TN0eY6PH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piPcFPh0zsRt7sBZTYdzxuzSiAjutDPOgCFGlsukBZufnZFHNKo5YVJZU1TcklF+Pb78ZaW7Y/Imrg+d0qysEJu1Ln2OeNySN34AR0r76qQNpMH1Qz8FncFJmegaLSJhWtAK/GueklZV/wsOxZo6Pyzd3Os/uJcIL2SXHxOXEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YUFjv5Pw; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715397247; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5UihLdeeajwF/OQzQRPOPSmBI7ehRGApnTBKHo7SAk0=;
	b=YUFjv5PwzazkEydC4lQds+XZbm+NpUgxs1MEMregpjWyRCvDyIKrapia/yusJ+WeHk7OZjCcbYTHCrVX+UJX+kckTR0bLSEmWd8YPl59zCrM2ZY1B16jhaWHDmHRFUAbzcMj9OXyPOmPFwdOpNx6F3mVDOgTJGCMO1hVA1jftyo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6BwHin_1715397245;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W6BwHin_1715397245)
          by smtp.aliyun-inc.com;
          Sat, 11 May 2024 11:14:06 +0800
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
Subject: [PATCH net-next v5 1/4] virtio_ring: enable premapped mode whatever use_dma_api
Date: Sat, 11 May 2024 11:14:01 +0800
Message-Id: <20240511031404.30903-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e1ef52e80115
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
index 6f7e5010a673..2a972752ff1b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2782,7 +2782,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  *
  * Returns zero or a negative error.
  * 0: success.
- * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
+ * -EINVAL: too late to enable premapped mode, the vq already contains buffers.
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


