Return-Path: <netdev+bounces-119413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E0A955817
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 15:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35D0282C16
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6016514F12F;
	Sat, 17 Aug 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j4PgOSny"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31649153808
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723901000; cv=none; b=KMMRh9lQUPRlgdiODgmY9KfwVx/RmFP66jLPtgd9xrJinnpxXzHekj1tYHb0e0QbaRdtX33ICk/Rxo+MKQFV49zQiV7lXtLN64KRMt1yEUDDB+mjVaAUULoZfFX1LA8lMN3xyBxo0l9nblDNhUwUSkgE6/zMwu9C1qJ0Cacn7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723901000; c=relaxed/simple;
	bh=7kA9vYhhEnDOXZ0YyD9eCoHNEsPH8GzDm4g4hUNW+DU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=dZoAzCClXfox1hGC3hj7EezGu4pflrkpujUGbMhj6B8NSJRpDLCnpwcjrRr0caDPMZ+WHrNBP31YBz+O660rL53yW9sAI2Ub67V+PalVt8Pd+KpyIMZ5TXJxyLIqFUkXLJIbg7KLYYbIDduIXusYWwfnrtUQPkiK7ozAVmR6a9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j4PgOSny; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723900989; h=Message-ID:Subject:Date:From:To;
	bh=aa9AZs45HksQVkwdjHJtIw1//A6xPvHBQJDI9oDuUTM=;
	b=j4PgOSnyz6ZSMxtRnqZTMP5Eo7K4Ogk8XCgUCI2rG1mxHH4o+DiIO1ZEraKsaTcFn03ZMLJ9GiOG0ycmzQGcRBbhrMWDVeXY1XCWNQ+TE4O5E5DEWercrjTzv2rAkHCxE5CQMb9v7fjoTyld7Ypq2FVUQ/hN1CvZnq0PlHYwsBM=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WD184Wm_1723900987)
          by smtp.aliyun-inc.com;
          Sat, 17 Aug 2024 21:23:08 +0800
Message-ID: <1723900832.273505-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 1/4] virtio_ring: enable premapped mode whatever use_dma_api
Date: Sat, 17 Aug 2024 21:20:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Si-Wei Liu" <si-wei.liu@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 Darren Kenny <darren.kenny@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <20240511031404.30903-2-xuanzhuo@linux.alibaba.com>
 <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
In-Reply-To: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Hi, guys, I have a fix patch for this.
Could anybody test it?

Thanks.

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index af474cc191d0..426d68c2d01d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2492,13 +2492,15 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
 {
        struct virtnet_info *vi = rq->vq->vdev->priv;
        const size_t hdr_len = vi->hdr_len;
-       unsigned int len;
+       unsigned int len, max_len;
+
+       max_len = PAGE_SIZE - ALIGN(sizeof(struct virtnet_rq_dma), L1_CACHE_BYTES);

        if (room)
-               return PAGE_SIZE - room;
+               return max_len - room;

        len = hdr_len + clamp_t(unsigned int, ewma_pkt_len_read(avg_pkt_len),
-                               rq->min_buf_len, PAGE_SIZE - hdr_len);
+                               rq->min_buf_len, max_len - hdr_len);

        return ALIGN(len, L1_CACHE_BYTES);
 }

