Return-Path: <netdev+bounces-125863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1650A96F04D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89AF7B2108A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C21CA6AA;
	Fri,  6 Sep 2024 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxysTji2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCF1C8FAB
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616362; cv=none; b=a5PKnLba2vVmR1CXJZcRboU/xQnnRsjzyfeqG2lZnKYBq0z+fZtMgShRc/7v9jL5cHXsT1+gxmzpljUYmhnob/puxNl+rtlCc21iFq2LCE92whD9STqTS2gmPVlZC71Nar/bPbYuFH10HN71wzMUsOtzeshSf3CfSUIdvvwF5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616362; c=relaxed/simple;
	bh=nWO4hB6PBG1t9aSNmguYJznkt6bwH8E+U9bsso6Id7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPpdk4moq1dr0FtI2bNnGZdhFc1E94n9aG/rRwfEBFqkZ7eNCuOIKcd3bfRST3Et5LTj/akIIsKJAbgzGqpfAb4kpcQ+tqKmJjjXTZCNhieI3Ns1Np5iXb6ulkBdjL5lVN9UP6lmDITp2fGWIHufb+rXlNOTtbsioxNyuqOMFCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxysTji2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725616359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mrSfru2lWTmJ7ntOOD4Zd3IGqv+cr43dsZNB2qiF4RM=;
	b=UxysTji2TEw4YbSqsQNn3o20c5ALCacKDjcum+cD7QaIGvtwt0hlBsX5Fbl1vNj08+HsbU
	S9P4CJef3UKjZq4VHB8bDFb05M4A5Ed92OUAGyZnj5/eSCbWIkqjAULCROo9dfTgP2+gO6
	DFXatWASxcJGj3awc0IQCh6TG03mN+0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-6Gr5ubm3MDaRJxzG4TZRgQ-1; Fri, 06 Sep 2024 05:52:37 -0400
X-MC-Unique: 6Gr5ubm3MDaRJxzG4TZRgQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374beb23f35so1211042f8f.0
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 02:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616357; x=1726221157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrSfru2lWTmJ7ntOOD4Zd3IGqv+cr43dsZNB2qiF4RM=;
        b=JcAgjXxQuEli7x7jLBSzxK+u+QrrbZpWfX28u9Fl5z6+zJcMO/KQmpqPiu9kQLKK3b
         XIEcLBE3l4areCk6t5rigUgMgY2ByvE3yvFFjIaI0ukjzaOv3ZiZQ/bUj8Fd8Dvzxxmz
         dmq+xTSHaA8jq3LPoIjq1PvlVGowZva6oZdz59zvsDF08S3s/1Wfe38Ltjtq6KHtiUNQ
         aL3+CqZlAjzwuF0Ck3oFlKFzopzb0NxePHGL9HzZFXCPC7H8MLjwQJrbBjd8JbSilgzn
         fUn2VourvPq/Uj4MljQqbVMeYrVkkZ/AOz+sVrASZa3Td6AqySN8+c+8JwaW7wMiI+Uj
         FnpA==
X-Forwarded-Encrypted: i=1; AJvYcCWrF30TMnBm0EED/BGoNRiRaPC6IExlhTqrni35sOEB7UfXpg1PaalZzM2pU8FiWwaZyRCN0JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM38mQSLRqCQnHm9UXNjPHYA53NgAZ6G5lelMeekLzlt8aE9FE
	1Q6dqXuOr0g6lRBsnbJ7FYlJ3An7Ab5do85/zfdW5I/qfImSvnyPETvfHqQXlceeYJd7/1+xE27
	U7vX4P53A6CYng9XcTDArz0jxWOvBQA7o1MclMm9pD/FAaRCUkrBcnA==
X-Received: by 2002:a5d:5e12:0:b0:374:b685:672 with SMTP id ffacd0b85a97d-374b6850721mr12179537f8f.26.1725616356561;
        Fri, 06 Sep 2024 02:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy9H2fY+IdgasPGdCkAErAN464kou0VTksRkihXRxCSa5S0om1fP+DF92pWZQwo6psBMtuqw==
X-Received: by 2002:a5d:5e12:0:b0:374:b685:672 with SMTP id ffacd0b85a97d-374b6850721mr12179503f8f.26.1725616355994;
        Fri, 06 Sep 2024 02:52:35 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9c48csm21348537f8f.51.2024.09.06.02.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:52:35 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:52:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: [RFC PATCH v2 4/7] Revert "virtio_net: xsk: bind/unbind xsk for rx"
Message-ID: <3f9f2c4be3d84f38ab5878494bfd91be01d18432.1725616135.git.mst@redhat.com>
References: <cover.1725616135.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725616135.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This reverts commit 09d2b3182c8e3a215a9b2a1834f81dd07305989f.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 134 ---------------------------------------
 1 file changed, 134 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3cb0f8adf2e6..0944430dfb1f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -25,7 +25,6 @@
 #include <net/net_failover.h>
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
-#include <net/xdp_sock_drv.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -349,11 +348,6 @@ struct receive_queue {
 
 	/* Record the last dma info to free after new pages is allocated. */
 	struct virtnet_rq_dma *last_dma;
-
-	struct xsk_buff_pool *xsk_pool;
-
-	/* xdp rxq used by xsk */
-	struct xdp_rxq_info xsk_rxq_info;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -5065,132 +5059,6 @@ static int virtnet_restore_guest_offloads(struct virtnet_info *vi)
 	return virtnet_set_guest_offloads(vi, offloads);
 }
 
-static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
-				    struct xsk_buff_pool *pool)
-{
-	int err, qindex;
-
-	qindex = rq - vi->rq;
-
-	if (pool) {
-		err = xdp_rxq_info_reg(&rq->xsk_rxq_info, vi->dev, qindex, rq->napi.napi_id);
-		if (err < 0)
-			return err;
-
-		err = xdp_rxq_info_reg_mem_model(&rq->xsk_rxq_info,
-						 MEM_TYPE_XSK_BUFF_POOL, NULL);
-		if (err < 0)
-			goto unreg;
-
-		xsk_pool_set_rxq_info(pool, &rq->xsk_rxq_info);
-	}
-
-	virtnet_rx_pause(vi, rq);
-
-	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
-	if (err) {
-		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
-
-		pool = NULL;
-	}
-
-	rq->xsk_pool = pool;
-
-	virtnet_rx_resume(vi, rq);
-
-	if (pool)
-		return 0;
-
-unreg:
-	xdp_rxq_info_unreg(&rq->xsk_rxq_info);
-	return err;
-}
-
-static int virtnet_xsk_pool_enable(struct net_device *dev,
-				   struct xsk_buff_pool *pool,
-				   u16 qid)
-{
-	struct virtnet_info *vi = netdev_priv(dev);
-	struct receive_queue *rq;
-	struct device *dma_dev;
-	struct send_queue *sq;
-	int err;
-
-	if (vi->hdr_len > xsk_pool_get_headroom(pool))
-		return -EINVAL;
-
-	/* In big_packets mode, xdp cannot work, so there is no need to
-	 * initialize xsk of rq.
-	 */
-	if (vi->big_packets && !vi->mergeable_rx_bufs)
-		return -ENOENT;
-
-	if (qid >= vi->curr_queue_pairs)
-		return -EINVAL;
-
-	sq = &vi->sq[qid];
-	rq = &vi->rq[qid];
-
-	/* xsk assumes that tx and rx must have the same dma device. The af-xdp
-	 * may use one buffer to receive from the rx and reuse this buffer to
-	 * send by the tx. So the dma dev of sq and rq must be the same one.
-	 *
-	 * But vq->dma_dev allows every vq has the respective dma dev. So I
-	 * check the dma dev of vq and sq is the same dev.
-	 */
-	if (virtqueue_dma_dev(rq->vq) != virtqueue_dma_dev(sq->vq))
-		return -EINVAL;
-
-	dma_dev = virtqueue_dma_dev(rq->vq);
-	if (!dma_dev)
-		return -EINVAL;
-
-	err = xsk_pool_dma_map(pool, dma_dev, 0);
-	if (err)
-		goto err_xsk_map;
-
-	err = virtnet_rq_bind_xsk_pool(vi, rq, pool);
-	if (err)
-		goto err_rq;
-
-	return 0;
-
-err_rq:
-	xsk_pool_dma_unmap(pool, 0);
-err_xsk_map:
-	return err;
-}
-
-static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
-{
-	struct virtnet_info *vi = netdev_priv(dev);
-	struct xsk_buff_pool *pool;
-	struct receive_queue *rq;
-	int err;
-
-	if (qid >= vi->curr_queue_pairs)
-		return -EINVAL;
-
-	rq = &vi->rq[qid];
-
-	pool = rq->xsk_pool;
-
-	err = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
-
-	xsk_pool_dma_unmap(pool, 0);
-
-	return err;
-}
-
-static int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp)
-{
-	if (xdp->xsk.pool)
-		return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
-					       xdp->xsk.queue_id);
-	else
-		return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
-}
-
 static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			   struct netlink_ext_ack *extack)
 {
@@ -5316,8 +5184,6 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
-	case XDP_SETUP_XSK_POOL:
-		return virtnet_xsk_pool_setup(dev, xdp);
 	default:
 		return -EINVAL;
 	}
-- 
MST


