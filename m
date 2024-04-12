Return-Path: <netdev+bounces-87252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C0A8A2483
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44792845C6
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 03:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15928179A7;
	Fri, 12 Apr 2024 03:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nU6VTF61"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889818EA1
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712893904; cv=none; b=SdPQKu2qhCkPesKL1PDdSnrwhSEYCS7SsKaLQXUPqKfhLLrUfCaMZl/gZ9SSri4qnxdAqHHjct7TXgOWuSUepw58zIcoU7ZJzSId1nZj/wAdNv8Fp3M/cHT0TdUguNarmlH24/iBuCgLvv1PHuR3yk5LaxOM9BOctUnmVTOk5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712893904; c=relaxed/simple;
	bh=k8NPmLHb7VcvG/I1xAtlykNpAPN7h2//v5aR2565ZXc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=sCeoTYBYCu3jOky1ufz14NwqpI7R9Kt72y2QS0wYwmLvom7gC6c+WrX0EhRA4A2WYkt2kOjzu4XocpCJLf/PO+vzvTea+IuxYqZsmV6cPjSuzLHnrkE8UTKNiCDWv2q20sQ3bzVOjswi8/JwOQU+leInft6JNSz23Kcu0kiREPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nU6VTF61; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712893899; h=Message-ID:Subject:Date:From:To;
	bh=nLQq2C5f+HDUM/3iQjQBwSnuQxU6DtazhwiQIJpzSD0=;
	b=nU6VTF617nycj+3FomFwGM6s95vX+NQClc+o8VdjldCIzPUpNZmjPVsV8ZmO/LomzZgv2I2ZOeUMyIdvxnyibjOB5ojFYfpKDV0A1Pxf2d8t13Yn1ZihgvIwdpu5Hq8qvbW5piETVRZw8VFE9n/hS2Fo4fulLfH1Sb5DyWzz0NI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4MqNih_1712893898;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4MqNih_1712893898)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 11:51:39 +0800
Message-ID: <1712893694.0185902-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 1/6] virtio_ring: introduce dma map api for page
Date: Fri, 12 Apr 2024 11:48:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <virtualization@lists.linux.dev>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo  Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-2-xuanzhuo@linux.alibaba.com>
 <1db181fd-8d08-4f6d-b32f-20d06029360c@intel.com>
In-Reply-To: <1db181fd-8d08-4f6d-b32f-20d06029360c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 11 Apr 2024 13:45:28 +0200, Alexander Lobakin <aleksander.lobakin@intel.com> wrote:
> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Date: Thu, 11 Apr 2024 10:51:22 +0800
>
> > The virtio-net big mode sq will use these APIs to map the pages.
> >
> > dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
> >                                        size_t offset, size_t size,
> >                                        enum dma_data_direction dir,
> >                                        unsigned long attrs);
> > void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
> >                                    size_t size, enum dma_data_direction dir,
> >                                    unsigned long attrs);
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 52 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  7 +++++
> >  2 files changed, 59 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 70de1a9a81a3..1b9fb680cff3 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -3100,6 +3100,58 @@ void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
> >
> > +/**
> > + * virtqueue_dma_map_page_attrs - map DMA for _vq
> > + * @_vq: the struct virtqueue we're talking about.
> > + * @page: the page to do dma
> > + * @offset: the offset inside the page
> > + * @size: the size of the page to do dma
> > + * @dir: DMA direction
> > + * @attrs: DMA Attrs
> > + *
> > + * The caller calls this to do dma mapping in advance. The DMA address can be
> > + * passed to this _vq when it is in pre-mapped mode.
> > + *
> > + * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
> > + */
> > +dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
> > +					size_t offset, size_t size,
> > +					enum dma_data_direction dir,
> > +					unsigned long attrs)
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	if (!vq->use_dma_api)
> > +		return page_to_phys(page) + offset;
>
> page_to_phys() and the actual page DMA address may differ. See
> page_to_dma()/virt_to_dma(). I believe this is not correct.


For the virtio, if use_dma_api is false, we do not try to get the
dma address. We try to get the physical address.


>
> > +
> > +	return dma_map_page_attrs(vring_dma_dev(vq), page, offset, size, dir, attrs);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_dma_map_page_attrs);
>
> Could you try make these functions static inlines and run bloat-o-meter?
> They seem to be small and probably you'd get better performance.

YES.

But struct vring_virtqueue is in the .c file, we must do that with moving
structure to the .h file.

I plan to do that in the future.

Thanks



>
> > +
> > +/**
> > + * virtqueue_dma_unmap_page_attrs - unmap DMA for _vq
> > + * @_vq: the struct virtqueue we're talking about.
> > + * @addr: the dma address to unmap
> > + * @size: the size of the buffer
> > + * @dir: DMA direction
> > + * @attrs: DMA Attrs
> > + *
> > + * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
> > + *
> > + */
> > +void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
> > +				    size_t size, enum dma_data_direction dir,
> > +				    unsigned long attrs)
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	if (!vq->use_dma_api)
> > +		return;
> > +
> > +	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_page_attrs);
> > +
> >  /**
> >   * virtqueue_dma_mapping_error - check dma address
> >   * @_vq: the struct virtqueue we're talking about.
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 26c4325aa373..d6c699553979 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -228,6 +228,13 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size
> >  void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> >  				      size_t size, enum dma_data_direction dir,
> >  				      unsigned long attrs);
> > +dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
> > +					size_t offset, size_t size,
> > +					enum dma_data_direction dir,
> > +					unsigned long attrs);
> > +void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
> > +				    size_t size, enum dma_data_direction dir,
> > +				    unsigned long attrs);
> >  int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
> >
> >  bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
>
> Thanks,
> Olek

