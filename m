Return-Path: <netdev+bounces-115237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5294591D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223AC1C218B9
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82B21BF309;
	Fri,  2 Aug 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WxJ8MqsA"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF191BF306
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584617; cv=none; b=GdldBwYru8MSBM35xR1lyj0jOeGtYbQatmAwxABeoM1nZLfbZRvaGJiLSlgv2JGWajsgGOP9AaCofeB8ZZZRzFpaHdr6p4qDHWMNqEwkiBu5/8VpIyt3IqHAVUCc3WWJejt4K2XjioyNj8Nnm6kDwq86qFOhVMiOKQtAx1ndnI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584617; c=relaxed/simple;
	bh=Dea6mS4xgDcdRXc6+K7XVwF+h8EmeIZulyu4yFNyIEI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=rzoHNvruC6bXpcgBjqcPd7vcL9TN8iWANgNvCxZQsrQedsyIEQNdI7ikCuSfGprYPdftkSCDQbYNzOs29jXZ1RK4x4s0GKOqiAjmbLSdFfSLMT23fEvkpAtee0wXj5UVUQuQQB3ydvAb9OmYHw3K4NTRQjXVxL+w7m/2fekl5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WxJ8MqsA; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722584607; h=Message-ID:Subject:Date:From:To;
	bh=IykKpDRPyiMC3Gkl1dAI1D1GBRUvFpCGFcVPB0WoL2o=;
	b=WxJ8MqsAbo5DR+Yg058+z45fJpD5lW2kRQvS7HQd0bkixGN2WBwe7h9wLEEcPWPrw9GU2qqdsCnqbEADKvqky94mN+ZaK/Eci8cxzVIBnWH1dPYJIqjP1NA0eux6XoDXVUDnO6i2LEmdHDmgO3YZEGgNTyybIlNTMNGexLuRu14=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WBwhTvv_1722584606;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBwhTvv_1722584606)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 15:43:26 +0800
Message-ID: <1722584526.9355304-3-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next] virtio_net: Prevent misidentified spurious interrupts from killing the irq
Date: Fri, 2 Aug 2024 15:42:06 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 netdev@vger.kernel.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
 <20240801100211-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240801100211-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 1 Aug 2024 10:04:05 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Aug 01, 2024 at 09:56:39PM +0800, Heng Qi wrote:
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
> > 
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> 
> 
> Is this a practical or theoretical issue? Do you observe an issue
> and see that this patch fixes it? Or is this from code review?


This issue was previously documented in our bugzilla, but that was in 2020.

I can't easily reproduce the issue after a7766ef18b33, but interrupt suppression
under virtio is unreliable and out of sync, which is still a potential risk for
DPUs where the VM and the device are not on the same host.

Thanks.

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
> >  		do {
> >  			virtqueue_disable_cb(sq->vq);
> >  			free_old_xmit(sq, txq, !!budget);
> > +			virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
> >  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >  
> >  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> > @@ -3035,6 +3036,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  
> >  		free_old_xmit(sq, txq, false);
> >  
> > +		if (use_napi)
> > +			virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
> > +
> >  	} while (use_napi && !xmit_more &&
> >  	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >  
> > @@ -3044,6 +3048,11 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	/* Try to transmit */
> >  	err = xmit_skb(sq, skb, !use_napi);
> >  
> > +	if (use_napi) {
> > +		virtqueue_set_tx_newbuf_sent(sq->vq, true);
> > +		virtqueue_set_tx_oldbuf_cleaned(sq->vq, false);
> > +	}
> > +
> >  	/* This should not happen! */
> >  	if (unlikely(err)) {
> >  		DEV_STATS_INC(dev, tx_fifo_errors);
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index be7309b1e860..fb2afc716371 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -180,6 +180,11 @@ struct vring_virtqueue {
> >  	 */
> >  	bool do_unmap;
> >  
> > +	/* Has any new data been sent? */
> > +	bool is_tx_newbuf_sent;
> > +	/* Is the old data recently sent cleaned up? */
> > +	bool is_tx_oldbuf_cleaned;
> > +
> >  	/* Head of free buffer list. */
> >  	unsigned int free_head;
> >  	/* Number we've added since last sync. */
> > @@ -2092,6 +2097,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >  	vq->use_dma_api = vring_use_dma_api(vdev);
> >  	vq->premapped = false;
> >  	vq->do_unmap = vq->use_dma_api;
> > +	vq->is_tx_newbuf_sent = false; /* Initially, no new buffer to send. */
> > +	vq->is_tx_oldbuf_cleaned = true; /* Initially, no old buffer to clean. */
> > +
> >  
> >  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> >  		!context;
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
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	vq->is_tx_newbuf_sent = val;
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
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	vq->is_tx_oldbuf_cleaned = val;
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_set_tx_oldbuf_cleaned);
> > +
> >  /**
> >   * virtqueue_kick - update after add_buf
> >   * @vq: the struct virtqueue
> > @@ -2572,6 +2612,16 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> >  	if (!more_used(vq)) {
> > +		/* When the delayed TX interrupt arrives, the old buffers are
> > +		 * cleaned in other cases(start_xmit and virtnet_poll_cleantx).
> > +		 * We'd better not identify it as a spurious interrupt,
> > +		 * otherwise note_interrupt may kill the interrupt.
> > +		 */
> > +		if (unlikely(vq->is_tx_newbuf_sent && vq->is_tx_oldbuf_cleaned)) {
> > +			vq->is_tx_newbuf_sent = false;
> > +			return IRQ_HANDLED;
> > +		}
> > +
> >  		pr_debug("virtqueue interrupt with no work for %p\n", vq);
> >  		return IRQ_NONE;
> >  	}
> > @@ -2637,6 +2687,9 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >  	vq->use_dma_api = vring_use_dma_api(vdev);
> >  	vq->premapped = false;
> >  	vq->do_unmap = vq->use_dma_api;
> > +	vq->is_tx_newbuf_sent = false; /* Initially, no new buffer to send. */
> > +	vq->is_tx_oldbuf_cleaned = true; /* Initially, no old buffer to clean. */
> > +
> >  
> >  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> >  		!context;
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index ecc5cb7b8c91..ba3be9276c09 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -103,6 +103,9 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
> >  int virtqueue_reset(struct virtqueue *vq,
> >  		    void (*recycle)(struct virtqueue *vq, void *buf));
> >  
> > +void virtqueue_set_tx_newbuf_sent(struct virtqueue *vq, bool val);
> > +void virtqueue_set_tx_oldbuf_cleaned(struct virtqueue *vq, bool val);
> > +
> >  struct virtio_admin_cmd {
> >  	__le16 opcode;
> >  	__le16 group_type;
> > -- 
> > 2.32.0.3.g01195cf9f
> 

