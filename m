Return-Path: <netdev+bounces-114990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1721944D9C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B23C1F21AE3
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03291A38C1;
	Thu,  1 Aug 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCD+1boJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70761FF2
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521060; cv=none; b=eA1X5o16LVDs7XxrzMyMSBgqxB7BTzpmFBMRCmdPBPiUZVoVFy+UfAgzeWfBTSV4myG6g92Ie9SEijTLnq9cpPhJHLB24RiBkZQcuewLAELbqyV7oLGxxVQmkR8dRIWpWH87OEsVce9yGYPI3Yg+3sLwj1Td8a/9uxiMzRVCrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521060; c=relaxed/simple;
	bh=+opxANMCjVX+SJxuBmQYQgc6VSkJfZss7Zn6HGkq8cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmK6qJu8rW5y8CCMCiGcU/ckBFxcsueB168XvShXI7mYdoVDKaw5OfSmseGqcy7iitmegbTazF6VUk+soJJLuaYhoCUm1SWdfQDuA3MvScT/cKsZFIqZXMhhNXMQLdBKjepjzRrBnRtQUpwfln2T9tbMbTMOYJ55Vn6SGE1BBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCD+1boJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722521058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4wbQoFzGdmG0kZFeNk5jiZjAh3gF2jbjRSKvEg5iqM=;
	b=gCD+1boJ/2Rb8YSgZxSyX8/U0JM3U+9ABnL1P1kF7C6Bd6sCnHP3QWNuf3811w42/AqM3f
	44Jj0whgtppYmiIRf4BvQfXHN3N0fS4doMCkOgGm7nJ8Vfxniuq6cJztZDfBZ5YUEO8lnQ
	9YYbGgiNca58SxBW9z7arCde92FmxTQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-jJUOJnXgNjCoTCnrOMb_jQ-1; Thu, 01 Aug 2024 10:04:15 -0400
X-MC-Unique: jJUOJnXgNjCoTCnrOMb_jQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7a822ee907so681381566b.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722521054; x=1723125854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4wbQoFzGdmG0kZFeNk5jiZjAh3gF2jbjRSKvEg5iqM=;
        b=u8o3wX03zyo/2ddTfAKQSD1GBTMoS/fz+Ud8qVo7DPKoQF8SDmm2SrqzVzBL3TjHbb
         n/c6N+XwLBC99TA9EJDTnw6GLMhwWf7ZUP6Q4YA/EA8RCzeaq0plhjTqYGNnq7o9aNFj
         12LC0eQ5GVcIlJrQ2OvHz6+GXQv7y7bxRBftHMQ+awDhqFc6IsGs21bjAzWxry6gahHa
         MqN7zESz8DctxUdtFIc4axhp7nuPGjK1tq/fLw3s9/yqpjoJ5NQcRDVO5CSnZjLyrbNL
         Tl3C8GmH2tXBtdOooF4JM++DPkEKaZhZFuqKJewEVlMn+ViEfQ7pNvNFfsi5upopOMAr
         6Y3A==
X-Forwarded-Encrypted: i=1; AJvYcCW3jksSmzPlzxOgCm+1DFsBi8BMMt5R+LbFevHc7wqJ/j1tB89tLtyURAtcHuhqUV8qZBkRV43jtyjFereihKKRkTA3NM2e
X-Gm-Message-State: AOJu0Yy/qSLprMB/3b6VrgWUwZvCQYsmtWHEAD8u0bMG+rNypinGtX/t
	4VbcEvYwFF1wiOuoN6NwQdKzM3hAAzRhHBQsQOL8oKLEAVLcXaOX1tP8/qBc9AEzvRTj7qJZAsm
	m2GzymjT+FKkixaqnBpboG5DwNGFitEFGLcVICoMLmnUQouEJl/OcqQ==
X-Received: by 2002:a17:907:98e:b0:a7a:ba59:3172 with SMTP id a640c23a62f3a-a7dc501651dmr20870366b.38.1722521053410;
        Thu, 01 Aug 2024 07:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdu0HJoWBa047FtcEWOPS8XrprCUVAKRVT00sJ5/YqBsC521cs+AlAFaCcBdNIeiIoTbxf2Q==
X-Received: by 2002:a17:907:98e:b0:a7a:ba59:3172 with SMTP id a640c23a62f3a-a7dc501651dmr20861566b.38.1722521052198;
        Thu, 01 Aug 2024 07:04:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236a2sm903567466b.29.2024.08.01.07.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:04:10 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:04:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] virtio_net: Prevent misidentified spurious
 interrupts from killing the irq
Message-ID: <20240801100211-mutt-send-email-mst@kernel.org>
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801135639.11400-1-hengqi@linux.alibaba.com>

On Thu, Aug 01, 2024 at 09:56:39PM +0800, Heng Qi wrote:
> Michael has effectively reduced the number of spurious interrupts in
> commit a7766ef18b33 ("virtio_net: disable cb aggressively") by disabling
> irq callbacks before cleaning old buffers.
> 
> But it is still possible that the irq is killed by mistake:
> 
>   When a delayed tx interrupt arrives, old buffers has been cleaned in
>   other paths (start_xmit and virtnet_poll_cleantx), then the interrupt is
>   mistakenly identified as a spurious interrupt in vring_interrupt.
> 
>   We should refrain from labeling it as a spurious interrupt; otherwise,
>   note_interrupt may inadvertently kill the legitimate irq.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>


Is this a practical or theoretical issue? Do you observe an issue
and see that this patch fixes it? Or is this from code review?
> ---
>  drivers/net/virtio_net.c     |  9 ++++++
>  drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  3 ++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..6d8739418203 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2769,6 +2769,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
>  		do {
>  			virtqueue_disable_cb(sq->vq);
>  			free_old_xmit(sq, txq, !!budget);
> +			virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> @@ -3035,6 +3036,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  		free_old_xmit(sq, txq, false);
>  
> +		if (use_napi)
> +			virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
> +
>  	} while (use_napi && !xmit_more &&
>  	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
> @@ -3044,6 +3048,11 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	/* Try to transmit */
>  	err = xmit_skb(sq, skb, !use_napi);
>  
> +	if (use_napi) {
> +		virtqueue_set_tx_newbuf_sent(sq->vq, true);
> +		virtqueue_set_tx_oldbuf_cleaned(sq->vq, false);
> +	}
> +
>  	/* This should not happen! */
>  	if (unlikely(err)) {
>  		DEV_STATS_INC(dev, tx_fifo_errors);
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..fb2afc716371 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -180,6 +180,11 @@ struct vring_virtqueue {
>  	 */
>  	bool do_unmap;
>  
> +	/* Has any new data been sent? */
> +	bool is_tx_newbuf_sent;
> +	/* Is the old data recently sent cleaned up? */
> +	bool is_tx_oldbuf_cleaned;
> +
>  	/* Head of free buffer list. */
>  	unsigned int free_head;
>  	/* Number we've added since last sync. */
> @@ -2092,6 +2097,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->use_dma_api = vring_use_dma_api(vdev);
>  	vq->premapped = false;
>  	vq->do_unmap = vq->use_dma_api;
> +	vq->is_tx_newbuf_sent = false; /* Initially, no new buffer to send. */
> +	vq->is_tx_oldbuf_cleaned = true; /* Initially, no old buffer to clean. */
> +
>  
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>  		!context;
> @@ -2375,6 +2383,38 @@ bool virtqueue_notify(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_notify);
>  
> +/**
> + * virtqueue_set_tx_newbuf_sent - set whether there is new tx buf to send.
> + * @_vq: the struct virtqueue
> + *
> + * If is_tx_newbuf_sent and is_tx_oldbuf_cleaned are both true, the
> + * spurious interrupt is caused by polling TX vq in other paths outside
> + * the tx irq callback.
> + */
> +void virtqueue_set_tx_newbuf_sent(struct virtqueue *_vq, bool val)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	vq->is_tx_newbuf_sent = val;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_set_tx_newbuf_sent);
> +
> +/**
> + * virtqueue_set_tx_oldbuf_cleaned - set whether there is old tx buf to clean.
> + * @_vq: the struct virtqueue
> + *
> + * If is_tx_oldbuf_cleaned and is_tx_newbuf_sent are both true, the
> + * spurious interrupt is caused by polling TX vq in other paths outside
> + * the tx irq callback.
> + */
> +void virtqueue_set_tx_oldbuf_cleaned(struct virtqueue *_vq, bool val)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	vq->is_tx_oldbuf_cleaned = val;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_set_tx_oldbuf_cleaned);
> +
>  /**
>   * virtqueue_kick - update after add_buf
>   * @vq: the struct virtqueue
> @@ -2572,6 +2612,16 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (!more_used(vq)) {
> +		/* When the delayed TX interrupt arrives, the old buffers are
> +		 * cleaned in other cases(start_xmit and virtnet_poll_cleantx).
> +		 * We'd better not identify it as a spurious interrupt,
> +		 * otherwise note_interrupt may kill the interrupt.
> +		 */
> +		if (unlikely(vq->is_tx_newbuf_sent && vq->is_tx_oldbuf_cleaned)) {
> +			vq->is_tx_newbuf_sent = false;
> +			return IRQ_HANDLED;
> +		}
> +
>  		pr_debug("virtqueue interrupt with no work for %p\n", vq);
>  		return IRQ_NONE;
>  	}
> @@ -2637,6 +2687,9 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->use_dma_api = vring_use_dma_api(vdev);
>  	vq->premapped = false;
>  	vq->do_unmap = vq->use_dma_api;
> +	vq->is_tx_newbuf_sent = false; /* Initially, no new buffer to send. */
> +	vq->is_tx_oldbuf_cleaned = true; /* Initially, no old buffer to clean. */
> +
>  
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>  		!context;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index ecc5cb7b8c91..ba3be9276c09 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -103,6 +103,9 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>  int virtqueue_reset(struct virtqueue *vq,
>  		    void (*recycle)(struct virtqueue *vq, void *buf));
>  
> +void virtqueue_set_tx_newbuf_sent(struct virtqueue *vq, bool val);
> +void virtqueue_set_tx_oldbuf_cleaned(struct virtqueue *vq, bool val);
> +
>  struct virtio_admin_cmd {
>  	__le16 opcode;
>  	__le16 group_type;
> -- 
> 2.32.0.3.g01195cf9f


