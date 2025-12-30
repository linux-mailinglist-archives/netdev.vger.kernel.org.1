Return-Path: <netdev+bounces-246334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC7CCE9737
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A53903016F9D
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787FE2EBB8D;
	Tue, 30 Dec 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZoNDrbe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2y2cdSA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F02EACF9
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089789; cv=none; b=hLXuihiUO0vjrU7/ISEgwio0AJsNzfZrxTjSjMghsPzB0dBv//v1eOvRvstkYoDah+gqQnem0i8g8PNZz3eoh3y1OF0hwxmFxGvUPwkhBQGBWAglwYtXWIfIuFPKMZPOltQ4BKn5ZhFtwLUDPV4kV+2exEZDsrAAt1P3y/Dowog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089789; c=relaxed/simple;
	bh=GajfymOgkcPkdkaB0RAuWogZvPX10QSebBxhGC7QBSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaOmGTkEKVHLreso4g/nPInfCXWUZJbNCXUlJDtgD0kR3R51i4oPtWCnTxMfzDnHTZdkI/QkI9LqQtODuiF9RbhUD0un+V8VDQN97/3Du+LDcDCLm47XTHaJhLtF3fvQg+rmiRKk0zJm43KkOUQgHvC2OJ9/cASILO7VvlSs9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZoNDrbe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2y2cdSA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGgwtCzFbkcOM+PDCBbTUD1kyCibNYOBRdnG12nNQ/w=;
	b=RZoNDrbeCTztQIcpIAmpbTkbYQI4beFMhtIVNZZffAFWGZmm/sc5+ZObLj+8423uiiur35
	qwIy2QEvlwsbcmuOP7miW9uHvS/MQaOFvtWz9XDtY7mLDi6V0ceFlrtX/N6X0rkEXNTyIS
	6KOJVPUJagrQAGcTKWMBaA1z/BLRFmY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-VDFQdOQZPgCIK-XYNwACMg-1; Tue, 30 Dec 2025 05:16:23 -0500
X-MC-Unique: VDFQdOQZPgCIK-XYNwACMg-1
X-Mimecast-MFC-AGG-ID: VDFQdOQZPgCIK-XYNwACMg_1767089782
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325b81081aso5255722f8f.3
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 02:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767089782; x=1767694582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGgwtCzFbkcOM+PDCBbTUD1kyCibNYOBRdnG12nNQ/w=;
        b=A2y2cdSAR39FCx/iw/+1ov9QmY5nnpDSF12sGmOmeivdLCVvkEyI2LwIA7RYqBWgZg
         Q+BZrZbnaXTCn5FIZab5H9g6e823x3F6J0X1jKqqArC8DJhgX3GcGqTCbUnqOIrL53Qn
         0TSzyaXuDi73OdzfqBC7/1s2W+eHbpK4MsDhuhjfa6diu3CmIvWXPvLuG49jnspIiyGY
         Q4YKcaUuMzk2znQfINVQn047hSMCRmNHKEPq7LO13y8OAgzwtFdJTjOQxTb9keMueGHH
         1oHgG6okXHS84f75pjEVaVlboTahWjim3Rmya9YOEEIDwNyJclZB0FKXgMlP5viKPk8P
         Cm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089782; x=1767694582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGgwtCzFbkcOM+PDCBbTUD1kyCibNYOBRdnG12nNQ/w=;
        b=xDyp4Xz0zoOnR4jHC1H5uQmyZ6VKRZnfolWqCgARh+bCyRynk4W8A5b36rfpy6pazB
         9vt5FXAdGQz5Ow0BtRZIFR96fRWphGpIeQ1Hi2pKsD6qUodJmAg8/4xSMkQvMFvJwP94
         opSndE/MwKGyEoFplWxyX0H5pyxGjs2F3yFebT1fbbCheZi039WCTURTZxNXRgAvEbIU
         +vFlVXsKv8lLl/cKGHVGWTNr6E0sinIw/jdGQ8Bm7Wl6DymeY6W723c+Dpgi6+AWohih
         j1+hm1uL7Qm+p+k1RZNo+6H9RFPXdpXeyASFNRC9HgcnWfGylJeL2f8Poll7w793koCT
         6qzw==
X-Forwarded-Encrypted: i=1; AJvYcCUN+gyysJ5JaHk+Vb39mnjzVO3a9hbGQWI11eecTzP+Y2f4yQkmkyGfVlrE6Bq7YecS0gBuAIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOge3KPptYDwIUoxIBRxupanpt06ExKJ1eNlVqyOcl11U447dI
	va22j1lolg61cXN6/OuW+/kxT9CfdGt5pNu1b7P2LpqSWDR5oeTdRNOlRLT34BiaHjinN2YUjqr
	o46/cSdNDrILAe4hM+bOK7C3zHg/sYRZLOfANPWtxKPH0Rar6uYSOJRqBlg==
X-Gm-Gg: AY/fxX6VXUeAMoRk2i9b4kXQvdXxE5WJ0AD1Mji97M/DS6dZrf2tB2aZ9hYgOa3EA6M
	c0aBr6LpQQYYiigWq6KFAzBmDT8ntSPHDAgBYBafcFBEzQSLpK0Q4OhuMJIndaTZ5pv8q6no58u
	eF6e0401C2emalO8pVXPsZvs+bZc0j99eBQyzF1F1nZvX+QtWz/LNJMkYN3Z9uLzQJG8cRDQWZW
	t+dcTk7F5YRv1wuc6WhtLhaoxHbHuF0izIYX86FkaepO2OTDl9ojdIfoyXWV1ss47+gu4YWHUL7
	9EdTXWy84Ou5I02STJjOKd0x9ZYDJZ+KqeZlX3CMzp3sfPnSjp1+fR8IHG7bPBmneaNKb/U7YDd
	4lPAbJuwhSvNMitdLAtJ5lWJ0mhUy0iM0xQ==
X-Received: by 2002:a05:6000:40db:b0:42c:b8fd:21b3 with SMTP id ffacd0b85a97d-4324e70b2c0mr42681803f8f.57.1767089782066;
        Tue, 30 Dec 2025 02:16:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4XayC4ymFC/bWs00E9fRypXNJ9u10o1pYrVldfljsEtp9WZrRKo/7Fbn9vwkm8J3pD7bCzw==
X-Received: by 2002:a05:6000:40db:b0:42c:b8fd:21b3 with SMTP id ffacd0b85a97d-4324e70b2c0mr42681761f8f.57.1767089781587;
        Tue, 30 Dec 2025 02:16:21 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432613f7e6esm57256214f8f.21.2025.12.30.02.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:21 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RFC 10/13] virtio_scsi: fix DMA cacheline issues for events
Message-ID: <c238ea28521dc0433350f848361b46e7d451b96c.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Current struct virtio_scsi_event_node layout has two problems:

The event (DMA_FROM_DEVICE) and work (CPU-written via
INIT_WORK/queue_work) fields share a cacheline.
On non-cache-coherent platforms, CPU writes to work can
corrupt device-written event data.

If DMA_MIN_ALIGN is large enough, the 8 events in event_list share
cachelines, triggering CONFIG_DMA_API_DEBUG warnings.

Fix the corruption by moving event buffers to a separate array and
aligning using __dma_from_device_aligned_begin/end.

Suppress the (now spurious) DMA debug warnings using
virtqueue_add_inbuf_cache_clean().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/scsi/virtio_scsi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 96a69edddbe5..b0ce3884e22a 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -29,6 +29,7 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_devinfo.h>
 #include <linux/seqlock.h>
+#include <linux/dma-mapping.h>
 
 #include "sd.h"
 
@@ -61,7 +62,7 @@ struct virtio_scsi_cmd {
 
 struct virtio_scsi_event_node {
 	struct virtio_scsi *vscsi;
-	struct virtio_scsi_event event;
+	struct virtio_scsi_event *event;
 	struct work_struct work;
 };
 
@@ -89,6 +90,12 @@ struct virtio_scsi {
 
 	struct virtio_scsi_vq ctrl_vq;
 	struct virtio_scsi_vq event_vq;
+
+	/* DMA buffers for events - aligned, kept separate from CPU-written fields */
+	__dma_from_device_aligned_begin
+	struct virtio_scsi_event events[VIRTIO_SCSI_EVENT_LEN];
+	__dma_from_device_aligned_end
+
 	struct virtio_scsi_vq req_vqs[];
 };
 
@@ -237,12 +244,12 @@ static int virtscsi_kick_event(struct virtio_scsi *vscsi,
 	unsigned long flags;
 
 	INIT_WORK(&event_node->work, virtscsi_handle_event);
-	sg_init_one(&sg, &event_node->event, sizeof(struct virtio_scsi_event));
+	sg_init_one(&sg, event_node->event, sizeof(struct virtio_scsi_event));
 
 	spin_lock_irqsave(&vscsi->event_vq.vq_lock, flags);
 
-	err = virtqueue_add_inbuf(vscsi->event_vq.vq, &sg, 1, event_node,
-				  GFP_ATOMIC);
+	err = virtqueue_add_inbuf_cache_clean(vscsi->event_vq.vq, &sg, 1, event_node,
+					      GFP_ATOMIC);
 	if (!err)
 		virtqueue_kick(vscsi->event_vq.vq);
 
@@ -257,6 +264,7 @@ static int virtscsi_kick_event_all(struct virtio_scsi *vscsi)
 
 	for (i = 0; i < VIRTIO_SCSI_EVENT_LEN; i++) {
 		vscsi->event_list[i].vscsi = vscsi;
+		vscsi->event_list[i].event = &vscsi->events[i];
 		virtscsi_kick_event(vscsi, &vscsi->event_list[i]);
 	}
 
@@ -380,7 +388,7 @@ static void virtscsi_handle_event(struct work_struct *work)
 	struct virtio_scsi_event_node *event_node =
 		container_of(work, struct virtio_scsi_event_node, work);
 	struct virtio_scsi *vscsi = event_node->vscsi;
-	struct virtio_scsi_event *event = &event_node->event;
+	struct virtio_scsi_event *event = event_node->event;
 
 	if (event->event &
 	    cpu_to_virtio32(vscsi->vdev, VIRTIO_SCSI_T_EVENTS_MISSED)) {
-- 
MST


