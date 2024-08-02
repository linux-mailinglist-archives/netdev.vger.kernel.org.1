Return-Path: <netdev+bounces-115334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E6C945E5A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4D328495E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC641E3CC3;
	Fri,  2 Aug 2024 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S52pFM7X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E751E3CB1
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604107; cv=none; b=A9Wg/IgZD+MOofdd4Gu9QtL9Q2I0sTDLRx5aYkiMphP0VSdXnWtFCpF3jWtSZCa5NF5GtFTVVqshPIm+eTESphYGd9oUEZ3UjK0nB5MirLtk5nmnkjf5LgKhlx3tQfFhdfRVVdplozfchAxzFZCEOjkoZ/aJOggI8IokKH1kIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604107; c=relaxed/simple;
	bh=trlTcUZuDcGY57erNYAzm5gbHqMW//W23eHekc7FYWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmpITpJwTjXEZGC2cEgs617zW0DfE9gBVKvgdXMmdEUrj4xQ1GGQy/5L5AdCkUSiGzZq0FBqk0vLokD+NP4QNKmDa033JkMSijBgWK/izHY+k6o3gfQ0698clNPC4Qg0CZ1sfDgMYh1AlMQZlJ9VNp0n/GplV6NIbd5o8YAtN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S52pFM7X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722604104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmPkNWzP9lkTnsLSoahFD3773maCWt+g0H5GQPEuYLc=;
	b=S52pFM7XeAHdEvH9Tar2C4GS9Y3EG2ieB1Sk9hDjoXHFhb+T+39b97D/hOxqRT6xkKQtYQ
	cNRpySdlDrJXw5G5n6tKMSNHcpc8xKgq3bEv7qpxmkNXOyxljKcbgdpPRY3plKTrCPUIQ2
	JkEDFYAhUwf19omciHSDW2U2CDjGAQY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-Z2KNT4YPNLyQ0wPQQ5tNmA-1; Fri, 02 Aug 2024 09:08:23 -0400
X-MC-Unique: Z2KNT4YPNLyQ0wPQQ5tNmA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280ec5200cso50730285e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722604099; x=1723208899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmPkNWzP9lkTnsLSoahFD3773maCWt+g0H5GQPEuYLc=;
        b=NmJ9AYbb//WWidZA9xkbJ/YIelDZhLN3FY9ZgM5SGK1RJH1GaTdDhcFtpOKl2t1nXs
         dSM1jxNeKx64b64UOMkN87UgWI520+JgrE6hPPg2me7neHiJ/GGA9l7Xezff7805Bopo
         wSlxDphHKrKcxPBSEY+D6WbXLp81BaQsn/t6Np/Nf+1RT9ekBOUbapqCClz7U/5FvNT+
         SIwwFIniUDK9eJ2Ba3KwCLDr5grPVtBBPehUeL3A925rvjPpQb59k0xkTZ3+JHBLM8DX
         j5ufS0JGsmgC68ydRfnEDCzq7zhVIh/CjOKLNpId9A3na1ROK4JaV0ZsC8ZJ+hrfyeiz
         LLSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/j23HJ+7LR7YNTXCVeFZho2RL3QPdn1C6LD+R2ohpehaEWJ6tNMEpvxZNhRl/Zkhk9G+qGD1josuGwo8r7chpYDUGoaNU
X-Gm-Message-State: AOJu0YwzzmwS1i3PIPoRDNGgJAYC8GevOEdeL7qRXH00Yg+07iNaI3QV
	6Lj6TtP0NlhZBABG7DmUhutRkWaAu5OpMAXz4t0GQzqRhhtBZbM3ltmomCa3CI9B8SZw0DZLtNA
	3/84V8cTbVkTPRvARJulGTkR3VSPlfiQWb9fxoNXDDruTnFwX2BzpFg==
X-Received: by 2002:adf:fc42:0:b0:367:97e9:1121 with SMTP id ffacd0b85a97d-36bbc14aab1mr2145612f8f.39.1722604099399;
        Fri, 02 Aug 2024 06:08:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1IqcHutuwrt/6TQlyyk8nv2/xHrPC5Ia5T6dr9TCbaJhikAuTqU7o05ZIxHIWL23lF3BhJA==
X-Received: by 2002:adf:fc42:0:b0:367:97e9:1121 with SMTP id ffacd0b85a97d-36bbc14aab1mr2145556f8f.39.1722604098328;
        Fri, 02 Aug 2024 06:08:18 -0700 (PDT)
Received: from redhat.com ([2.55.39.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc63sm1950135f8f.5.2024.08.02.06.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 06:08:16 -0700 (PDT)
Date: Fri, 2 Aug 2024 09:08:09 -0400
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
Message-ID: <20240802085902-mutt-send-email-mst@kernel.org>
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
 <20240801100211-mutt-send-email-mst@kernel.org>
 <1722584526.9355304-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722584526.9355304-3-hengqi@linux.alibaba.com>

On Fri, Aug 02, 2024 at 03:42:06PM +0800, Heng Qi wrote:
> On Thu, 1 Aug 2024 10:04:05 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Aug 01, 2024 at 09:56:39PM +0800, Heng Qi wrote:
> > > Michael has effectively reduced the number of spurious interrupts in
> > > commit a7766ef18b33 ("virtio_net: disable cb aggressively") by disabling
> > > irq callbacks before cleaning old buffers.
> > > 
> > > But it is still possible that the irq is killed by mistake:
> > > 
> > >   When a delayed tx interrupt arrives, old buffers has been cleaned in
> > >   other paths (start_xmit and virtnet_poll_cleantx), then the interrupt is
> > >   mistakenly identified as a spurious interrupt in vring_interrupt.
> > > 
> > >   We should refrain from labeling it as a spurious interrupt; otherwise,
> > >   note_interrupt may inadvertently kill the legitimate irq.
> > > 
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > 
> > 
> > Is this a practical or theoretical issue? Do you observe an issue
> > and see that this patch fixes it? Or is this from code review?
> 
> 
> This issue was previously documented in our bugzilla, but that was in 2020.
> 
> I can't easily reproduce the issue after a7766ef18b33, but interrupt suppression
> under virtio is unreliable and out of sync, which is still a potential risk for
> DPUs where the VM and the device are not on the same host.
> 
> Thanks.

I find it hard to believe there's a real problem after a7766ef18b33.



> > > ---
> > >  drivers/net/virtio_net.c     |  9 ++++++
> > >  drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/virtio.h       |  3 ++
> > >  3 files changed, 65 insertions(+)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 0383a3e136d6..6d8739418203 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2769,6 +2769,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
> > >  		do {
> > >  			virtqueue_disable_cb(sq->vq);
> > >  			free_old_xmit(sq, txq, !!budget);
> > > +			virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
> > >  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >  
> > >  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> > > @@ -3035,6 +3036,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > >  
> > >  		free_old_xmit(sq, txq, false);
> > >  
> > > +		if (use_napi)
> > > +			virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
> > > +
> > >  	} while (use_napi && !xmit_more &&
> > >  	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >  
> > > @@ -3044,6 +3048,11 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > >  	/* Try to transmit */
> > >  	err = xmit_skb(sq, skb, !use_napi);
> > >  
> > > +	if (use_napi) {
> > > +		virtqueue_set_tx_newbuf_sent(sq->vq, true);
> > > +		virtqueue_set_tx_oldbuf_cleaned(sq->vq, false);
> > > +	}
> > > +
> > >  	/* This should not happen! */
> > >  	if (unlikely(err)) {
> > >  		DEV_STATS_INC(dev, tx_fifo_errors);
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index be7309b1e860..fb2afc716371 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -180,6 +180,11 @@ struct vring_virtqueue {
> > >  	 */
> > >  	bool do_unmap;
> > >  
> > > +	/* Has any new data been sent? */
> > > +	bool is_tx_newbuf_sent;
> > > +	/* Is the old data recently sent cleaned up? */
> > > +	bool is_tx_oldbuf_cleaned;
> > > +
> > >  	/* Head of free buffer list. */
> > >  	unsigned int free_head;
> > >  	/* Number we've added since last sync. */
> > > @@ -2092,6 +2097,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > >  	vq->use_dma_api = vring_use_dma_api(vdev);
> > >  	vq->premapped = false;
> > >  	vq->do_unmap = vq->use_dma_api;
> > > +	vq->is_tx_newbuf_sent = false; /* Initially, no new buffer to send. */
> > > +	vq->is_tx_oldbuf_cleaned = true; /* Initially, no old buffer to clean. */
> > > +
> > >  
> > >  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> > >  		!context;
> > > @@ -2375,6 +2383,38 @@ bool virtqueue_notify(struct virtqueue *_vq)
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_notify);
> > >  
> > > +/**
> > > + * virtqueue_set_tx_newbuf_sent - set whether there is new tx buf to send.
> > > + * @_vq: the struct virtqueue
> > > + *
> > > + * If is_tx_newbuf_sent and is_tx_oldbuf_cleaned are both true, the
> > > + * spurious interrupt is caused by polling TX vq in other paths outside
> > > + * the tx irq callback.
> > > + */
> > > +void virtqueue_set_tx_newbuf_sent(struct virtqueue *_vq, bool val)
> > > +{
> > > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > > +
> > > +	vq->is_tx_newbuf_sent = val;
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_set_tx_newbuf_sent);
> > > +
> > > +/**
> > > + * virtqueue_set_tx_oldbuf_cleaned - set whether there is old tx buf to clean.
> > > + * @_vq: the struct virtqueue
> > > + *
> > > + * If is_tx_oldbuf_cleaned and is_tx_newbuf_sent are both true, the
> > > + * spurious interrupt is caused by polling TX vq in other paths outside
> > > + * the tx irq callback.
> > > + */
> > > +void virtqueue_set_tx_oldbuf_cleaned(struct virtqueue *_vq, bool val)
> > > +{
> > > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > > +
> > > +	vq->is_tx_oldbuf_cleaned = val;
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_set_tx_oldbuf_cleaned);
> > > +
> > >  /**
> > >   * virtqueue_kick - update after add_buf
> > >   * @vq: the struct virtqueue
> > > @@ -2572,6 +2612,16 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > >  
> > >  	if (!more_used(vq)) {
> > > +		/* When the delayed TX interrupt arrives, the old buffers are
> > > +		 * cleaned in other cases(start_xmit and virtnet_poll_cleantx).
> > > +		 * We'd better not identify it as a spurious interrupt,
> > > +		 * otherwise note_interrupt may kill the interrupt.
> > > +		 */
> > > +		if (unlikely(vq->is_tx_newbuf_sent && vq->is_tx_oldbuf_cleaned)) {
> > > +			vq->is_tx_newbuf_sent = false;
> > > +			return IRQ_HANDLED;
> > > +		}
> > > +

I am not merging anything this ugly.


> > >  		pr_debug("virtqueue interrupt with no work for %p\n", vq);
> > >  		return IRQ_NONE;
> > >  	}
> > > @@ -2637,6 +2687,9 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > >  	vq->use_dma_api = vring_use_dma_api(vdev);
> > >  	vq->premapped = false;
> > >  	vq->do_unmap = vq->use_dma_api;
> > > +	vq->is_tx_newbuf_sent = false; /* Initially, no new buffer to send. */
> > > +	vq->is_tx_oldbuf_cleaned = true; /* Initially, no old buffer to clean. */
> > > +
> > >  
> > >  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> > >  		!context;
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index ecc5cb7b8c91..ba3be9276c09 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -103,6 +103,9 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
> > >  int virtqueue_reset(struct virtqueue *vq,
> > >  		    void (*recycle)(struct virtqueue *vq, void *buf));
> > >  
> > > +void virtqueue_set_tx_newbuf_sent(struct virtqueue *vq, bool val);
> > > +void virtqueue_set_tx_oldbuf_cleaned(struct virtqueue *vq, bool val);
> > > +
> > >  struct virtio_admin_cmd {
> > >  	__le16 opcode;
> > >  	__le16 group_type;
> > > -- 
> > > 2.32.0.3.g01195cf9f
> > 


