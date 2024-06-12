Return-Path: <netdev+bounces-103013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808BD905F57
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9E2B21925
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389F612C526;
	Wed, 12 Jun 2024 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxMdKS/9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD186136
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718235724; cv=none; b=i/dv11ERVhvUbyPqwUT6IQIkWXnFJiodDOqdmZXOGvSwItWC2GI3ddE+QKxUOAoUF/AqxrRVOnJTTLuaOUkN6fAicZ5AC7JLoZ7ckhGE9SzVrVHN3W3GRkR0CTwUA9AJsn3tAdhFMN7P0W2MSU/S2fR8hEQURilZFaAwAY+hfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718235724; c=relaxed/simple;
	bh=2LMCnFagc3/S/uTR6COrLsXNubgLTq1UhtjQxfpTjNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zvw401fS0ouWGw4UUiosuY1+2VaPHVqS0y4yi+MH6z+JRpQ0nSVVzQwir0rXAkWtrhv0Gk3uR0r0L3s4iL3cKDQWgyWM5gUeRUmgx8fxHlNUQiDUb6jb1Zb6svIHqI4afGT2MpjzkljaGZC3VhOAMwzvqfjK9YOvg9soyHfD3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxMdKS/9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718235720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9pH2zPG8Vr2PNZCVlKQqJC3r20KYd9dC3U6iqsOmIU=;
	b=gxMdKS/9P96k9Hf1KhCN8SBHN+cO4gGAOm0s12ESRuAforEEJ1mUtqtK3OWCL4t0sGvSmA
	XGVGqiX6+cnpFYCpfqE+YM7Cg5EpsS6SdBdrZyts9WcorH61SOs/TWtnB0RNtkRezpvOF0
	jXOWdtX3wDRnB4DpQUIIQsa55JMl4SA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-skFnThPmO4u8Sy7uIasvGg-1; Wed, 12 Jun 2024 19:41:58 -0400
X-MC-Unique: skFnThPmO4u8Sy7uIasvGg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f0f8b6badso150561f8f.1
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 16:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718235717; x=1718840517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9pH2zPG8Vr2PNZCVlKQqJC3r20KYd9dC3U6iqsOmIU=;
        b=mZuXRHNe1MmKJUNybH1q3LhXPx0uHu3XL6DESfxIcn/nCQE4UMXa9BnlXklVlxJ40A
         YcOZ+3LXt+XssjFoputvf6L2CSJMWz+dqjV6BhYpUwbxUS5rL3CFenEA8DMMWlP1bjXk
         q3jV8LGeR0KkEmslzuQuM66q/NgSPwzBAL7z/JOaVk9QxDhdmkuvBbEZ0ysS7ggsofmK
         9UXgNm5eNv0Xb1qsKC2LP7Lb596fcgm5Z2LpSRNP90Yw58CRiKJS/HE1JPhRyC37lxkj
         YWCcFv71cHDF2X3yXauFeiRGV6LunIfKtaHa2saTwGfeHG+JKIXZwYtfBMQOoxUC2Web
         0CzQ==
X-Gm-Message-State: AOJu0YzoEiNkLy0gq/fUhCe0oUhVpjuH3PhnJvy4DztS059pdJnIrmr/
	DkmRx0ExsDh+1Y0mjR0191ReLZd1Aq1MTVntl+hx3iJ1dLxvJCkpQqdqABe/ozzSyHh6N9T07RB
	LAJ7ZpbFN+/9YjJbWHwHtBsfsieyE07WDsXirPsJUgPHf5om0xx5+2Q==
X-Received: by 2002:adf:f647:0:b0:35f:fd7:6102 with SMTP id ffacd0b85a97d-360718f19b7mr686313f8f.35.1718235717162;
        Wed, 12 Jun 2024 16:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdpH9p4R25Q9HiTif7qjUXuqjJgSmu8vlRLbpWpYil17LYYYHX6iHquScBCA9dx7p6kB7+uA==
X-Received: by 2002:adf:f647:0:b0:35f:fd7:6102 with SMTP id ffacd0b85a97d-360718f19b7mr686303f8f.35.1718235716625;
        Wed, 12 Jun 2024 16:41:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:94c5:b48b:41a4:81c0:f1c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093d58sm118181f8f.4.2024.06.12.16.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 16:41:55 -0700 (PDT)
Date: Wed, 12 Jun 2024 19:41:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 08/15] virtio_net: sq support premapped mode
Message-ID: <20240612193142-mutt-send-email-mst@kernel.org>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
 <20240611114147.31320-9-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611114147.31320-9-xuanzhuo@linux.alibaba.com>

On Tue, Jun 11, 2024 at 07:41:40PM +0800, Xuan Zhuo wrote:
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode when it is bound to
> af-xdp.
> 
> * virtnet_sq_set_premapped(sq, true) is used to enable premapped mode.
> 
>     In this mode, the driver will record the dma info when skb or xdp
>     frame is sent.
> 
>     Currently, the SQ premapped mode is operational only with af-xdp. In
>     this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
>     the same SQ. Af-xdp independently manages its DMA. The kernel stack
>     and xdp tx/redirect utilize this DMA metadata to manage the DMA
>     info.
> 
>     If the indirect descriptor feature be supported, the volume of DMA
>     details we need to maintain becomes quite substantial. Here, we have
>     a cap on the amount of DMA info we manage.
> 
>     If the kernel stack and xdp tx/redirect attempt to use more
>     descriptors, virtnet_add_outbuf() will return an -ENOMEM error. But
>     the af-xdp can work continually.
> 
> * virtnet_sq_set_premapped(sq, false) is used to disable premapped mode.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 219 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 215 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e84a4624549b..4968ab7eb5a4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -25,6 +25,7 @@
>  #include <net/net_failover.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
> +#include <uapi/linux/virtio_ring.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -276,6 +277,25 @@ struct virtnet_rq_dma {
>  	u16 need_sync;
>  };
>  
> +struct virtnet_sq_dma {
> +	union {
> +		struct virtnet_sq_dma *next;

Maybe:

struct llist_node node;   

I'd like to avoid growing our own single linked list
implementation if at all possible.



> +		void *data;
> +	};
> +	dma_addr_t addr;
> +	u32 len;
> +	u8 num;
> +};
> +
> +struct virtnet_sq_dma_info {
> +	/* record for kfree */
> +	void *p;
> +
> +	u32 free_num;
> +
> +	struct virtnet_sq_dma *free;
> +};
> +
>  /* Internal representation of a send virtqueue */
>  struct send_queue {
>  	/* Virtqueue associated with this send _queue */
> @@ -295,6 +315,11 @@ struct send_queue {
>  
>  	/* Record whether sq is in reset state. */
>  	bool reset;
> +
> +	/* SQ is premapped mode or not. */
> +	bool premapped;
> +
> +	struct virtnet_sq_dma_info dmainfo;
>  };
>  
>  /* Internal representation of a receive virtqueue */
> @@ -492,9 +517,11 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>  enum virtnet_xmit_type {
>  	VIRTNET_XMIT_TYPE_SKB,
>  	VIRTNET_XMIT_TYPE_XDP,
> +	VIRTNET_XMIT_TYPE_DMA,
>  };
>  
> -#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP)
> +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP \
> +				| VIRTNET_XMIT_TYPE_DMA)
>  
>  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
>  {
> @@ -510,12 +537,178 @@ static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type type)
>  	return (void *)((unsigned long)ptr | type);
>  }
>  
> +static void virtnet_sq_unmap(struct send_queue *sq, void **data)
> +{
> +	struct virtnet_sq_dma *head, *tail, *p;
> +	int i;
> +
> +	head = *data;
> +
> +	p = head;
> +
> +	for (i = 0; i < head->num; ++i) {
> +		virtqueue_dma_unmap_page_attrs(sq->vq, p->addr, p->len,
> +					       DMA_TO_DEVICE, 0);
> +		tail = p;
> +		p = p->next;
> +	}
> +
> +	*data = tail->data;
> +
> +	tail->next = sq->dmainfo.free;
> +	sq->dmainfo.free = head;
> +	sq->dmainfo.free_num += head->num;
> +}
> +
> +static void *virtnet_dma_chain_update(struct send_queue *sq,
> +				      struct virtnet_sq_dma *head,
> +				      struct virtnet_sq_dma *tail,
> +				      u8 num, void *data)
> +{
> +	sq->dmainfo.free = tail->next;
> +	sq->dmainfo.free_num -= num;
> +	head->num = num;
> +
> +	tail->data = data;
> +
> +	return virtnet_xmit_ptr_mix(head, VIRTNET_XMIT_TYPE_DMA);
> +}
> +
> +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq, int num, void *data)
> +{
> +	struct virtnet_sq_dma *head, *tail, *p;
> +	struct scatterlist *sg;
> +	dma_addr_t addr;
> +	int i, err;
> +
> +	if (num > sq->dmainfo.free_num)
> +		return NULL;
> +
> +	head = sq->dmainfo.free;
> +	p = head;
> +
> +	tail = NULL;
> +
> +	for (i = 0; i < num; ++i) {
> +		sg = &sq->sg[i];
> +
> +		addr = virtqueue_dma_map_page_attrs(sq->vq, sg_page(sg),
> +						    sg->offset,
> +						    sg->length, DMA_TO_DEVICE,
> +						    0);
> +		err = virtqueue_dma_mapping_error(sq->vq, addr);
> +		if (err)
> +			goto err;
> +
> +		sg->dma_address = addr;
> +
> +		tail = p;
> +		tail->addr = sg->dma_address;
> +		tail->len = sg->length;
> +
> +		p = p->next;
> +	}
> +
> +	return virtnet_dma_chain_update(sq, head, tail, num, data);
> +
> +err:
> +	if (tail) {
> +		virtnet_dma_chain_update(sq, head, tail, i, data);
> +		virtnet_sq_unmap(sq, (void **)&head);
> +	}
> +
> +	return NULL;
> +}
> +
>  static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data,
>  			      enum virtnet_xmit_type type)
>  {
> -	return virtqueue_add_outbuf(sq->vq, sq->sg, num,
> -				    virtnet_xmit_ptr_mix(data, type),
> -				    GFP_ATOMIC);
> +	int ret;
> +
> +	data = virtnet_xmit_ptr_mix(data, type);
> +
> +	if (sq->premapped) {
> +		data = virtnet_sq_map_sg(sq, num, data);
> +		if (!data)
> +			return -ENOMEM;
> +	}
> +
> +	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
> +	if (ret && sq->premapped) {
> +		virtnet_xmit_ptr_strip(&data);
> +		virtnet_sq_unmap(sq, &data);
> +	}
> +
> +	return ret;
> +}
> +
> +static int virtnet_sq_alloc_dma_meta(struct send_queue *sq)
> +{
> +	struct virtnet_sq_dma *d;
> +	int num, i;
> +
> +	num = virtqueue_get_vring_size(sq->vq);
> +
> +	/* Currently, the SQ premapped mode is operational only with af-xdp. In
> +	 * this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
> +	 * the same SQ. Af-xdp independently manages its DMA. The kernel stack
> +	 * and xdp tx/redirect utilize this DMA metadata to manage the DMA info.
> +	 *
> +	 * If the indirect descriptor feature be supported, the volume of DMA
> +	 * details we need to maintain becomes quite substantial. Here, we have
> +	 * a cap on the amount of DMA info we manage, effectively limiting it to
> +	 * twice the size of the ring buffer.
> +	 *
> +	 * If the kernel stack and xdp tx/redirect attempt to use more
> +	 * descriptors than allowed by this double ring buffer size,
> +	 * virtnet_add_outbuf() will return an -ENOMEM error. But the af-xdp can
> +	 * work continually.
> +	 */
> +	if (virtio_has_feature(sq->vq->vdev, VIRTIO_RING_F_INDIRECT_DESC))
> +		num = num * 2;
> +
> +	sq->dmainfo.free = kcalloc(num, sizeof(*sq->dmainfo.free), GFP_KERNEL);

Can be large. kvmalloc seems more appropriate.


> +	if (!sq->dmainfo.free)
> +		return -ENOMEM;
> +
> +	sq->dmainfo.p = sq->dmainfo.free;
> +	sq->dmainfo.free_num = num;
> +
> +	for (i = 0; i < num; ++i) {
> +		d = &sq->dmainfo.free[i];
> +		d->next = d + 1;
> +	}
> +
> +	d->next = NULL;
> +
> +	return 0;
> +}
> +
> +static void virtnet_sq_free_dma_meta(struct send_queue *sq)
> +{
> +	kfree(sq->dmainfo.p);
> +
> +	sq->dmainfo.p = NULL;
> +	sq->dmainfo.free = NULL;
> +	sq->dmainfo.free_num = 0;
> +}
> +
> +/* This function must be called immediately after creating the vq, or after vq
> + * reset, and before adding any buffers to it.
> + */
> +static int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)
> +{
> +	if (premapped) {
> +		if (virtnet_sq_alloc_dma_meta(sq))
> +			return -ENOMEM;

I would just return what virtnet_sq_alloc_dma_meta returns.
	int r = virtnet_sq_alloc_dma_meta();

	if (r)
		return r;

> +	} else {
> +		virtnet_sq_free_dma_meta(sq);
> +	}
> +
> +	BUG_ON(virtqueue_set_dma_premapped(sq->vq, premapped));
> +
> +	sq->premapped = premapped;
> +	return 0;
>  }
>  
>  static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> @@ -529,6 +722,7 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>  		++stats->packets;
>  
> +retry:
>  		switch (virtnet_xmit_ptr_strip(&ptr)) {
>  		case VIRTNET_XMIT_TYPE_SKB:
>  			skb = ptr;
> @@ -545,6 +739,10 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>  			stats->bytes += xdp_get_frame_len(frame);
>  			xdp_return_frame(frame);
>  			break;
> +
> +		case VIRTNET_XMIT_TYPE_DMA:
> +			virtnet_sq_unmap(sq, &ptr);
> +			goto retry;
>  		}
>  	}
>  }
> @@ -5232,6 +5430,8 @@ static void virtnet_free_queues(struct virtnet_info *vi)
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		__netif_napi_del(&vi->rq[i].napi);
>  		__netif_napi_del(&vi->sq[i].napi);
> +
> +		virtnet_sq_free_dma_meta(&vi->sq[i]);
>  	}
>  
>  	/* We called __netif_napi_del(),
> @@ -5280,6 +5480,13 @@ static void free_receive_page_frags(struct virtnet_info *vi)
>  
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
> +	struct virtnet_info *vi = vq->vdev->priv;
> +	struct send_queue *sq;
> +	int i = vq2rxq(vq);
> +
> +	sq = &vi->sq[i];
> +
> +retry:
>  	switch (virtnet_xmit_ptr_strip(&buf)) {
>  	case VIRTNET_XMIT_TYPE_SKB:
>  		dev_kfree_skb(buf);
> @@ -5288,6 +5495,10 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  	case VIRTNET_XMIT_TYPE_XDP:
>  		xdp_return_frame(buf);
>  		break;
> +
> +	case VIRTNET_XMIT_TYPE_DMA:
> +		virtnet_sq_unmap(sq, &buf);
> +		goto retry;

document what's going on here? why are we retrying?


>  	}
>  }
>  
> -- 
> 2.32.0.3.g01195cf9f


