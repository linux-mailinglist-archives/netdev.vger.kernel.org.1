Return-Path: <netdev+bounces-191812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D5AABD5E0
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6923BCF16
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98027C16A;
	Tue, 20 May 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VK4Fw1bl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A061267B74
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739139; cv=none; b=U7Np1GD/oZ/8o043f2ikKDS11Tr9FgbVpyDWzgxC/J73XDHsHKUtJdqy4BEMGdBcE9jrAP0yUGD30HnKizr+ZOp8yVCOnv+M5PCcOFlNRu4pcEpCWNsVVXdW5lgCnpvaDVsCPu1XA77l6fJEqqN9jMhFvXsPKAyMLFa4o7ZT3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739139; c=relaxed/simple;
	bh=yk/3MKALOEYeKqVKhUIAAn8SXbS+jf00AOomxrFgLpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5UTWUJucZ5iq+LyBeLAm8auYaMxLDfr4yjKtH5PzXjoBYKP5ozXN6fT0aD7fTQBXNcGA8qX06jtn9YODuBOh3iI4S1MP4s/eZG9/vHoah8p/2aeOaLjiqOcAkNAUKu2sDBuhFFWGzt72FuLN3CUd1+p5B1/9LuuhVfx6Vc1Ym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VK4Fw1bl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747739135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88rZqcHfyQL70LO9q5pA/dk/SVH44MpHD6BYGbaF9Sw=;
	b=VK4Fw1blobGewTcumKaRnYnPWmHPjNkHArT95jU4v2zZCt44gzniO3B4TnWXxMN//pxZa6
	fMaANKRwIKdyDbkAblNcWT+exz3zplXON029eisTJciTqGNEPvLKrutyv6F3Jiojjm0Qh3
	SMigpWA4wBrgqIKqfQ2bSu63D7raYn0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-ig1S1rx8NaSU80oz2zuwZA-1; Tue,
 20 May 2025 07:05:34 -0400
X-MC-Unique: ig1S1rx8NaSU80oz2zuwZA-1
X-Mimecast-MFC-AGG-ID: ig1S1rx8NaSU80oz2zuwZA_1747739133
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33795180087B;
	Tue, 20 May 2025 11:05:33 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.64])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E7EF19560A3;
	Tue, 20 May 2025 11:05:30 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 1/2] virtio_ring: Fix error reporting in virtqueue_resize
Date: Tue, 20 May 2025 13:05:25 +0200
Message-ID: <20250520110526.635507-2-lvivier@redhat.com>
In-Reply-To: <20250520110526.635507-1-lvivier@redhat.com>
References: <20250520110526.635507-1-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The virtqueue_resize() function was not correctly propagating error codes
from its internal resize helper functions, specifically
virtqueue_resize_packet() and virtqueue_resize_split(). If these helpers
returned an error, but the subsequent call to virtqueue_enable_after_reset()
succeeded, the original error from the resize operation would be masked.
Consequently, virtqueue_resize() could incorrectly report success to its
caller despite an underlying resize failure.

This change restores the original code behavior:

       if (vdev->config->enable_vq_after_reset(_vq))
               return -EBUSY;

       return err;

Fix: commit ad48d53b5b3f ("virtio_ring: separate the logic of reset/enable from virtqueue_resize")
Cc: xuanzhuo@linux.alibaba.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/virtio/virtio_ring.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b784aab66867..4397392bfef0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2797,7 +2797,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 		     void (*recycle_done)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	int err;
+	int err, err_reset;
 
 	if (num > vq->vq.num_max)
 		return -E2BIG;
@@ -2819,7 +2819,11 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	else
 		err = virtqueue_resize_split(_vq, num);
 
-	return virtqueue_enable_after_reset(_vq);
+	err_reset = virtqueue_enable_after_reset(_vq);
+	if (err_reset)
+		return err_reset;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(virtqueue_resize);
 
-- 
2.49.0


