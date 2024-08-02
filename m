Return-Path: <netdev+bounces-115335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCB5945E65
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6CD1F22041
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8951F1E3CD4;
	Fri,  2 Aug 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmGWAdmY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F31DAC5F
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604289; cv=none; b=kDLoA3U0CJU4l5haMGWbMGHci5snRviAu2H8CeMs7bUbiLbWlsOsQDq4Au7i2bTVRPjY2pUrKAWV5dcQ6kotB1le7Rz5hetZMX9HtF2v4QTSrZ6nlCgo9E/tbfa5wMdgIfDfFU4egeFF23tA61BUOSYQ4W79FCW3VkRMSmzuSTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604289; c=relaxed/simple;
	bh=GtqF0j81uMmMkn2DBIGrfJVpy/2P4u2KPrJ2tF75azA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIy9diqi0Q2FzUEcUs6HHvMJBg9YekX2356RVg73zTFhLl63iStyhXKcVg4S8olcE9AKfQgODjK3DBJb5jf2LWIPhbA6VyqCDNfnVEBhaALEIrZyNs0lU40oheik00d8UAZB6wNIDZnC+A60f0SaW2fLHJv/8jet3eSwOPIonG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmGWAdmY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722604286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GA3gHcK7gQa0uIkgdjm6OGs+g7SAjt3707Vb593jBhc=;
	b=fmGWAdmYIv0GkaxPqAiS07bevNN1hUn5B4oum+piyU35cTn+EaSCmrIsANJw4FhkkYUzo6
	wPKX5K7ATX7MM99Ho8t9sbO+BOqD4cNWVntDpaJ1BOjiyVeFsImqyRqcmi2FfdCPhdacaS
	tFLMwT9PP5z9weZxQYDa+frOvqMBDIo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-L7nW1GnlOpKIkutzFr3_Bw-1; Fri, 02 Aug 2024 09:11:25 -0400
X-MC-Unique: L7nW1GnlOpKIkutzFr3_Bw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36835f6ebdcso4975922f8f.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722604282; x=1723209082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GA3gHcK7gQa0uIkgdjm6OGs+g7SAjt3707Vb593jBhc=;
        b=LZbZjfA8dqWAXigfuU3YHtZDItH5/avJ5husI1q/32OHXIZdHk1k8dVLTr26ULU41r
         rXLCaPkAwGv9UmPw+ZdSW8JR+WPSNccQCAbVVhlLPrSRSaS1M0YxppyV1FF9YiXbQaoO
         bO6LdX3tXSjqAIQRSJN9u4MntB1NZimDDJ91XzU4rKAdbQxAiRT+NiQRVFVG6nF4WN6d
         yJ3qlMBdNRJvf0jNl8+OZcIpM+CxGDoGMXMq+C3rEg+KFRU5qdz4ZuwpSaJLcDlO8jUT
         SYWYgBltprd40CHBaYTkNJW5DaEPzADr3tD7w0NCGdy0YZ2ZBEYqkmQ1pjYJO6m3eho5
         WPtA==
X-Forwarded-Encrypted: i=1; AJvYcCWk/pHI60gCzCwjgSLZsfgb382DI5VEDE3AL7bsBzTO6TP1mMruBuvLW1T9unLpIzljRFmRmzJzBmMXQjWUDTjfYk0BL+98
X-Gm-Message-State: AOJu0Yx8xdWCnUQbQ+XvC2Uyhq4x8KeseU1j24NOFf59psNx/iwsa2cR
	md0+fSojizBKjdGEq+UYDCdYLI/1PU01dD4ekq/wJByKzZCp6HH4lrJaobr8diKv0mpSWowwSGp
	tyS4vGrEStkOR7EYdLSYomuPhpCSTJDJowhkB8JzEUirjExfucdG2Kg==
X-Received: by 2002:a05:6000:128b:b0:368:7f4f:9ead with SMTP id ffacd0b85a97d-36bbc0b4f07mr2127275f8f.7.1722604282246;
        Fri, 02 Aug 2024 06:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtON99eWGkJAzYau58ziGITYpzdcXfWosUZg+NokOApiXDyHx++P7yBUYwaqj9NjkxUyi1sQ==
X-Received: by 2002:a05:6000:128b:b0:368:7f4f:9ead with SMTP id ffacd0b85a97d-36bbc0b4f07mr2127239f8f.7.1722604281315;
        Fri, 02 Aug 2024 06:11:21 -0700 (PDT)
Received: from redhat.com ([2.55.39.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06d7cfsm1953780f8f.96.2024.08.02.06.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 06:11:19 -0700 (PDT)
Date: Fri, 2 Aug 2024 09:11:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] virtio_net: Prevent misidentified spurious
 interrupts from killing the irq
Message-ID: <20240802090822-mutt-send-email-mst@kernel.org>
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
 <CACGkMEtBeUnDeD0zYBvpwjhQ4Lv0dz8mBDQ_C-yP1VEaQdv-0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtBeUnDeD0zYBvpwjhQ4Lv0dz8mBDQ_C-yP1VEaQdv-0A@mail.gmail.com>

On Fri, Aug 02, 2024 at 11:41:57AM +0800, Jason Wang wrote:
> On Thu, Aug 1, 2024 at 9:56 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> >
> > Michael has effectively reduced the number of spurious interrupts in
> > commit a7766ef18b33 ("virtio_net: disable cb aggressively") by disabling
> > irq callbacks before cleaning old buffers.
> >
> > But it is still possible that the irq is killed by mistake:
> >
> >   When a delayed tx interrupt arrives, old buffers has been cleaned in
> >   other paths (start_xmit and virtnet_poll_cleantx), then the interrupt is
> >   mistakenly identified as a spurious interrupt in vring_interrupt.
> >
> >   We should refrain from labeling it as a spurious interrupt; otherwise,
> >   note_interrupt may inadvertently kill the legitimate irq.
> 
> I think the evil came from where we do free_old_xmit() in
> start_xmit(). I know it is for performance, but we may need to make
> the code work correctly instead of adding endless hacks. Personally, I
> think the virtio-net TX path is over-complicated. We probably pay too
> much (e.g there's netif_tx_lock in TX NAPI path) to try to "optimize"
> the performance.
> 
> How about just don't do free_old_xmit and do that solely in the TX NAPI?

Not getting interrupts is always better than getting interrupts.
This is not new code, there are no plans to erase it all and start
anew "to make it work correctly" - it's widely deployed,
you will cause performance regressions and they are hard
to debug.


> >
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c     |  9 ++++++
> >  drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  3 ++
> >  3 files changed, 65 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0383a3e136d6..6d8739418203 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2769,6 +2769,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
> >                 do {
> >                         virtqueue_disable_cb(sq->vq);
> >                         free_old_xmit(sq, txq, !!budget);
> > +                       virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
> >                 } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >
> >                 if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> > @@ -3035,6 +3036,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >
> >                 free_old_xmit(sq, txq, false);
> >
> > +               if (use_napi)
> > +                       virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
> > +
> >         } while (use_napi && !xmit_more &&
> >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >
> > @@ -3044,6 +3048,11 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >         /* Try to transmit */
> >         err = xmit_skb(sq, skb, !use_napi);
> >
> > +       if (use_napi) {
> > +               virtqueue_set_tx_newbuf_sent(sq->vq, true);
> > +               virtqueue_set_tx_oldbuf_cleaned(sq->vq, false);
> > +       }
> > +
> >         /* This should not happen! */
> >         if (unlikely(err)) {
> >                 DEV_STATS_INC(dev, tx_fifo_errors);
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index be7309b1e860..fb2afc716371 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -180,6 +180,11 @@ struct vring_virtqueue {
> >          */
> >         bool do_unmap;
> >
> > +       /* Has any new data been sent? */
> > +       bool is_tx_newbuf_sent;
> > +       /* Is the old data recently sent cleaned up? */
> > +       bool is_tx_oldbuf_cleaned;
> > +
> >         /* Head of free buffer list. */
> >         unsigned int free_head;
> >         /* Number we've added since last sync. */
> > @@ -2092,6 +2097,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >         vq->use_dma_api = vring_use_dma_api(vdev);
> >         vq->premapped = false;
> >         vq->do_unmap = vq->use_dma_api;
> > +       vq->is_tx_newbuf_sent = false; /* Initially, no new buffer to send. */
> > +       vq->is_tx_oldbuf_cleaned = true; /* Initially, no old buffer to clean. */
> > +
> >
> >         vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> >                 !context;
> > @@ -2375,6 +2383,38 @@ bool virtqueue_notify(struct virtqueue *_vq)
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_notify);
> >
> > +/**
> > + * virtqueue_set_tx_newbuf_sent - set whether there is new tx buf to send.
> > + * @_vq: the struct virtqueue
> > + *
> > + * If is_tx_newbuf_sent and is_tx_oldbuf_cleaned are both true, the
> > + * spurious interrupt is caused by polling TX vq in other paths outside
> > + * the tx irq callback.
> > + */
> > +void virtqueue_set_tx_newbuf_sent(struct virtqueue *_vq, bool val)
> > +{
> > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +       vq->is_tx_newbuf_sent = val;
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_set_tx_newbuf_sent);
> > +
> > +/**
> > + * virtqueue_set_tx_oldbuf_cleaned - set whether there is old tx buf to clean.
> > + * @_vq: the struct virtqueue
> > + *
> > + * If is_tx_oldbuf_cleaned and is_tx_newbuf_sent are both true, the
> > + * spurious interrupt is caused by polling TX vq in other paths outside
> > + * the tx irq callback.
> > + */
> > +void virtqueue_set_tx_oldbuf_cleaned(struct virtqueue *_vq, bool val)
> > +{
> > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +       vq->is_tx_oldbuf_cleaned = val;
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_set_tx_oldbuf_cleaned);
> > +
> >  /**
> >   * virtqueue_kick - update after add_buf
> >   * @vq: the struct virtqueue
> > @@ -2572,6 +2612,16 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >         struct vring_virtqueue *vq = to_vvq(_vq);
> >
> >         if (!more_used(vq)) {
> > +               /* When the delayed TX interrupt arrives, the old buffers are
> > +                * cleaned in other cases(start_xmit and virtnet_poll_cleantx).
> > +                * We'd better not identify it as a spurious interrupt,
> > +                * otherwise note_interrupt may kill the interrupt.
> > +                */
> > +               if (unlikely(vq->is_tx_newbuf_sent && vq->is_tx_oldbuf_cleaned)) {
> > +                       vq->is_tx_newbuf_sent = false;
> > +                       return IRQ_HANDLED;
> > +               }
> 
> This is the general virtio code, it's better to avoid any device specific logic.
> 
> > +
> >                 pr_debug("virtqueue interrupt with no work for %p\n", vq);
> >                 return IRQ_NONE;
> >         }
> > @@ -2637,6 +2687,9 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >         vq->use_dma_api = vring_use_dma_api(vdev);
> >         vq->premapped = false;
> >         vq->do_unmap = vq->use_dma_api;
> > +       vq->is_tx_newbuf_sent = false; /* Initially, no new buffer to send. */
> > +       vq->is_tx_oldbuf_cleaned = true; /* Initially, no old buffer to clean. */
> > +
> >
> >         vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> >                 !context;
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index ecc5cb7b8c91..ba3be9276c09 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -103,6 +103,9 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
> >  int virtqueue_reset(struct virtqueue *vq,
> >                     void (*recycle)(struct virtqueue *vq, void *buf));
> >
> > +void virtqueue_set_tx_newbuf_sent(struct virtqueue *vq, bool val);
> > +void virtqueue_set_tx_oldbuf_cleaned(struct virtqueue *vq, bool val);
> > +
> >  struct virtio_admin_cmd {
> >         __le16 opcode;
> >         __le16 group_type;
> > --
> > 2.32.0.3.g01195cf9f
> >


