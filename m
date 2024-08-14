Return-Path: <netdev+bounces-118338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350979514E1
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E704B26EFE
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7BC13C80E;
	Wed, 14 Aug 2024 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYGx+66Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230713B585
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618773; cv=none; b=hfm18t4q0OjjveyNQqfa9mRSQ5QflNDQ7xq/esEe3AvIscsnxlt6MwyXS6RpTQJONosOa/TXIi7Lj7Vh6V6AHp5DGZrHFk7eEBlLwtuGHrJEoBaw0lKUJtubLTy8tHKbwtQZOX5qkGJR8NZDgdoJ7QViQR/UgnWo1b5vGLaM1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618773; c=relaxed/simple;
	bh=djZGqgZTV4zePC5A4Vl+DC/Cw0xDKzbloMYfCKksJLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKx8g/xdD2YRJAJIfwT3axgx/91LZO9n9lqkMGM9PgJQEBp6E5NEXXjL7+Dx3hDF3Sc/dqaMsNsUvVgwTAXsFyIctphEAVtCN/T1DJw3sRV4ZSJ/LyYnQ/0ZjEAWfwy/aWRXJ3UuQ9ZgWnRN40uBcQjKZScFwQkf+rm7acXFAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYGx+66Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723618770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvHU9FJR5EjTPSL/EsPZcCx8aKRfG52mA0zYfURxj2Y=;
	b=fYGx+66YuRGcoUlO/MMfd8U68ytW9hpD7i2t9ZFDStqwHPJnaKQ5ekd3x5/x5dO27sCcQr
	8CvUKjneybAh0hdRV0/R8yg5SYvoFLJI8me2VW5PmlL9QmGNOc12AW9IYSQ3ATTbBf1Dbn
	0T48XLBWR9os4DGBFMM8/rfqVHg+lPg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-Na5RwlPiNcO7G0JULfEehQ-1; Wed, 14 Aug 2024 02:59:28 -0400
X-MC-Unique: Na5RwlPiNcO7G0JULfEehQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7d6a72ad99so462122966b.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 23:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618767; x=1724223567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvHU9FJR5EjTPSL/EsPZcCx8aKRfG52mA0zYfURxj2Y=;
        b=q4odJrMIjyhduBN4+hmltqkxe+LWJFPHUT9CRCsIB3Ldtu3MIPC/P/sDeGCiMZ1txI
         14x9o53WYsB/xqEVsgn58uOkf+GVCp+4L7ux+AonuL5hT1I6H2O3sdAqGE6xhqQ0no/2
         m/BycEE7Zr53XNZ+AfMvkCoeg0YYfSfp6+cdLBpL+ZlqZmVRPUaVuiFKu6415TfL5OQr
         mwN9QCXfdJozTU01KCfgnEGPmlGrD+8REM8YRe/wVC+NYXNyI+aQ8XCPxJeA9gv8WJAk
         X7eHMJh4aOo2wQ6CHetw+wavu3Sb/DS8mO4Js8wmFIJqk6uH/+bKUwZ+hh0NJUuf3pzn
         /61Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvRJNUvreucPllY4+0AWt48fpbLBHcsUhWfACT2fouJal4W3w7AWO7nowZ9l/3ik6fOxua6spvS5MRBLlYWDI3Sj2psJxe
X-Gm-Message-State: AOJu0Yx2FHooTYk2cUD6FoO4CJQD2++KnI2N143lW/yu+zNVkzNnA05E
	1+csOAj/CZpIucKx7L6+kk4ipwSbDOaTewZ38QcYZcUsy0+HT5OmkPzB7cgeRU1aLhI1WK1RlJC
	PM8K2hXsrA6DO4CJ29qYGUSm0psJt/2uREsjslUgh85VO4gvl9qF1/ImDySoykg==
X-Received: by 2002:a17:907:e285:b0:a7a:a06b:eebe with SMTP id a640c23a62f3a-a8366c1ef88mr132792266b.9.1723618767145;
        Tue, 13 Aug 2024 23:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAu6E40NEOy1d58SSc2IGoJh1Kf2oD9rknMOVITdXpoO3UrJkKz474CZvMIRoSkCHdannKPg==
X-Received: by 2002:a17:907:e285:b0:a7a:a06b:eebe with SMTP id a640c23a62f3a-a8366c1ef88mr132790066b.9.1723618766262;
        Tue, 13 Aug 2024 23:59:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e18csm137789066b.177.2024.08.13.23.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:59:25 -0700 (PDT)
Date: Wed, 14 Aug 2024 02:59:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC 1/3] Revert "virtio_net: rx remove premapped failover
 code"
Message-ID: <7774ac707743ad8ce3afeacbd4bee63ac96dd927.1723617902.git.mst@redhat.com>
References: <cover.1723617902.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723617902.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This reverts commit defd28aa5acb0fd7c15adc6bc40a8ac277d04dea.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-ID: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 89 +++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 37 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fd3d7e926022..4f7e686b8bf9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -348,6 +348,9 @@ struct receive_queue {
 
 	/* Record the last dma info to free after new pages is allocated. */
 	struct virtnet_rq_dma *last_dma;
+
+	/* Do dma by self */
+	bool do_dma;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -848,7 +851,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	void *buf;
 
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf)
+	if (buf && rq->do_dma)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -861,6 +864,11 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	u32 offset;
 	void *head;
 
+	if (!rq->do_dma) {
+		sg_init_one(rq->sg, buf, len);
+		return;
+	}
+
 	head = page_address(rq->alloc_frag.page);
 
 	offset = buf - head;
@@ -886,42 +894,44 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
 	head = page_address(alloc_frag->page);
 
-	dma = head;
+	if (rq->do_dma) {
+		dma = head;
 
-	/* new pages */
-	if (!alloc_frag->offset) {
-		if (rq->last_dma) {
-			/* Now, the new page is allocated, the last dma
-			 * will not be used. So the dma can be unmapped
-			 * if the ref is 0.
+		/* new pages */
+		if (!alloc_frag->offset) {
+			if (rq->last_dma) {
+				/* Now, the new page is allocated, the last dma
+				 * will not be used. So the dma can be unmapped
+				 * if the ref is 0.
+				 */
+				virtnet_rq_unmap(rq, rq->last_dma, 0);
+				rq->last_dma = NULL;
+			}
+
+			dma->len = alloc_frag->size - sizeof(*dma);
+
+			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
+							      dma->len, DMA_FROM_DEVICE, 0);
+			if (virtqueue_dma_mapping_error(rq->vq, addr))
+				return NULL;
+
+			dma->addr = addr;
+			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
+
+			/* Add a reference to dma to prevent the entire dma from
+			 * being released during error handling. This reference
+			 * will be freed after the pages are no longer used.
 			 */
-			virtnet_rq_unmap(rq, rq->last_dma, 0);
-			rq->last_dma = NULL;
+			get_page(alloc_frag->page);
+			dma->ref = 1;
+			alloc_frag->offset = sizeof(*dma);
+
+			rq->last_dma = dma;
 		}
 
-		dma->len = alloc_frag->size - sizeof(*dma);
-
-		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
-						      dma->len, DMA_FROM_DEVICE, 0);
-		if (virtqueue_dma_mapping_error(rq->vq, addr))
-			return NULL;
-
-		dma->addr = addr;
-		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
-
-		/* Add a reference to dma to prevent the entire dma from
-		 * being released during error handling. This reference
-		 * will be freed after the pages are no longer used.
-		 */
-		get_page(alloc_frag->page);
-		dma->ref = 1;
-		alloc_frag->offset = sizeof(*dma);
-
-		rq->last_dma = dma;
+		++dma->ref;
 	}
 
-	++dma->ref;
-
 	buf = head + alloc_frag->offset;
 
 	get_page(alloc_frag->page);
@@ -938,9 +948,12 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	if (!vi->mergeable_rx_bufs && vi->big_packets)
 		return;
 
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		/* error should never happen */
-		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
+			continue;
+
+		vi->rq[i].do_dma = true;
+	}
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
@@ -2036,7 +2049,8 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
+		if (rq->do_dma)
+			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -2150,7 +2164,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
+		if (rq->do_dma)
+			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -5231,7 +5246,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 	int i;
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		if (vi->rq[i].alloc_frag.page) {
-			if (vi->rq[i].last_dma)
+			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
 				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
 			put_page(vi->rq[i].alloc_frag.page);
 		}
-- 
MST


