Return-Path: <netdev+bounces-225829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F45BB98B21
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 09:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE6C18874A7
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6A287260;
	Wed, 24 Sep 2025 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFiAjPdf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5C28725A
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700206; cv=none; b=bOm5HBHC1573iZoEARca+/X/s8gFHoYELbGeg7zSs6wcfZVYUCcL5zYHsQxLFOXhixQnsZ1xtG+1s/iQs55cZlun6H6WYYPSluK9gBymClQeYsh09f9Uny3fZpHtyaD907midyy3LYLmizwV5LegniCU33WOEYgj2dcyb4Clakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700206; c=relaxed/simple;
	bh=uc6ISieAaXFT4aav6NNM2tVosCA7b7yxzr213CmqjSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpfUaXRWuXJOx/fbPWbTZyohYzmQFByn7pIHZsQTIBKAoUjAA7abAsZigOXXvZ8eTIPXHAwmivHGP9XbkXpb7nb730m2xhPoHgSA/qRnUpiU7KQSW3McX8Nm7eWmYI/dvdQHdSd9ItvivRcEI1cUBWZGmMXIPVCM9CsXbBjT3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFiAjPdf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758700203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdMx3QVWSZ6LKmjhlJB1nzhhz5UUzIgjxX638ayHrZQ=;
	b=fFiAjPdfYg9H8HUKiVwpsfxvCP3pCkb+CoTSAIf9dHqVkit+tQWQreXuTX9IoKUbq+hCXL
	H9nz+FCqIMtvxX5nRCsolUeaCPBAqaHWAW3Qy6ItFiTuHjbUyvIHxCf9dmT/mKPD2BVN5k
	UVyKLZijfTvci25yOafXkFWUG41mUDM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-MN6Wv87tMJOSh1O9xUDlBQ-1; Wed, 24 Sep 2025 03:49:56 -0400
X-MC-Unique: MN6Wv87tMJOSh1O9xUDlBQ-1
X-Mimecast-MFC-AGG-ID: MN6Wv87tMJOSh1O9xUDlBQ_1758700195
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee1365964cso4473039f8f.2
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700194; x=1759304994;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdMx3QVWSZ6LKmjhlJB1nzhhz5UUzIgjxX638ayHrZQ=;
        b=gqZxb2lxMYznAcQOslB/56kHzfW7uhReU5NQ10ddxOycWRMK8c6HnupeqAXh3eUjkI
         qhBEg+YSohRfxznnTwmtCVPiKUW2MDFU+LdV/huW5ZYdyZcs9MhSs3GVXEPjeHz6Yuun
         1Lgp5YvH54HfkStYYxm2fUFpfF5hCLQj7jNTiPG0AhH22nu3eUtLcAWJ3SobvNG9gseZ
         2RZ1+ecRXJC21M9TGuUxoXs1IYEFCozRTyCkecvCr3yul0FpoyUi4jNB9qHhI4TjSI0s
         GHzH1qgdAud1Tse+acd5s4FFDJnfBPZ+X/21eKflBnP/ZGU3ynx38NVDBLKTgSReJ6Fj
         X4ew==
X-Forwarded-Encrypted: i=1; AJvYcCVyfFMoGs0zh6A2fXh3cd+kUknbEASqqBlIcXFqzmrEOWEwrx6uvDpVlakqLmPDqJzztWa5s5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhsArn4ExO6QrDftmVW63hGmXaJeSvE6BpMaZDyBHV82HOuX3O
	KpDWFwbdViVu4zISbsmi6sKYU4kvjP2/t1JXYXpsM2vmGZ0+QdfJFFUbXJ0ZFcnu5ewdqcKVmbq
	qIGzGhUA0VHypyCsrYiCM8tsB91ZzjB8i9oLJkGc4cfaLCvk7tA7l8ixUyw==
X-Gm-Gg: ASbGncsysHjZ/mm8CS0sSfDhum/YOB8tpKK1cF7poNRWoERhYVW3RVqCnfvqqTEAosW
	xWzTd85AgWmUXmWYbUg7rGc40kjrD/lIYvAFUo1f1nO3D9MAiSq/lLG+j4gQ+LJFpSc0BMFJucD
	yGVqJ1GG9Hvef7yxFg9epsyjOvKZkhS7b8Ud8AhJWp0x3X+7mXbNG55MEtGhw1jFVOYFkiRj1HR
	M9r3RBMFYR+M/ufOXjF5EJX0KHosdf7ltJlgiS+tmF5qdFZpUpVtvWxsnXjj98LaYnsdA0hLsgd
	WJdcAca48aq7COFqZX11oNHip2/eSf8GHaw=
X-Received: by 2002:a05:6000:2204:b0:3e7:65a6:dbf with SMTP id ffacd0b85a97d-405c5ccc9d5mr4161810f8f.6.1758700194526;
        Wed, 24 Sep 2025 00:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAd953qSH8hZIgDHBwYLoc8FquXuXRMDSqiFyKFFPq3vdIpLOnAbvFV8zHb6qxjx8ZavCtZw==
X-Received: by 2002:a05:6000:2204:b0:3e7:65a6:dbf with SMTP id ffacd0b85a97d-405c5ccc9d5mr4161779f8f.6.1758700194045;
        Wed, 24 Sep 2025 00:49:54 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f9c62d083esm15058456f8f.32.2025.09.24.00.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:49:53 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:49:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 4/8] TUN & TAP: Wake netdev queue after
 consuming an entry
Message-ID: <20250924034534-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250922221553.47802-5-simon.schippers@tu-dortmund.de>
 <20250923123101-mutt-send-email-mst@kernel.org>
 <aacb449c-ad20-48b0-aa0f-b3866a3ed7f6@tu-dortmund.de>
 <20250924024416-mutt-send-email-mst@kernel.org>
 <a16b643a-3cfe-4b95-b76a-100f512cdb79@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a16b643a-3cfe-4b95-b76a-100f512cdb79@tu-dortmund.de>

On Wed, Sep 24, 2025 at 09:42:45AM +0200, Simon Schippers wrote:
> On 24.09.25 08:55, Michael S. Tsirkin wrote:
> > On Wed, Sep 24, 2025 at 07:56:33AM +0200, Simon Schippers wrote:
> >> On 23.09.25 18:36, Michael S. Tsirkin wrote:
> >>> On Tue, Sep 23, 2025 at 12:15:49AM +0200, Simon Schippers wrote:
> >>>> The new wrappers tun_ring_consume/tap_ring_consume deal with consuming an
> >>>> entry of the ptr_ring and then waking the netdev queue when entries got
> >>>> invalidated to be used again by the producer.
> >>>> To avoid waking the netdev queue when the ptr_ring is full, it is checked
> >>>> if the netdev queue is stopped before invalidating entries. Like that the
> >>>> netdev queue can be safely woken after invalidating entries.
> >>>>
> >>>> The READ_ONCE in __ptr_ring_peek, paired with the smp_wmb() in
> >>>> __ptr_ring_produce within tun_net_xmit guarantees that the information
> >>>> about the netdev queue being stopped is visible after __ptr_ring_peek is
> >>>> called.
> >>>>
> >>>> The netdev queue is also woken after resizing the ptr_ring.
> >>>>
> >>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>> ---
> >>>>  drivers/net/tap.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
> >>>>  drivers/net/tun.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
> >>>>  2 files changed, 88 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>> index 1197f245e873..f8292721a9d6 100644
> >>>> --- a/drivers/net/tap.c
> >>>> +++ b/drivers/net/tap.c
> >>>> @@ -753,6 +753,46 @@ static ssize_t tap_put_user(struct tap_queue *q,
> >>>>  	return ret ? ret : total;
> >>>>  }
> >>>>  
> >>>> +static struct sk_buff *tap_ring_consume(struct tap_queue *q)
> >>>> +{
> >>>> +	struct netdev_queue *txq;
> >>>> +	struct net_device *dev;
> >>>> +	bool will_invalidate;
> >>>> +	bool stopped;
> >>>> +	void *ptr;
> >>>> +
> >>>> +	spin_lock(&q->ring.consumer_lock);
> >>>> +	ptr = __ptr_ring_peek(&q->ring);
> >>>> +	if (!ptr) {
> >>>> +		spin_unlock(&q->ring.consumer_lock);
> >>>> +		return ptr;
> >>>> +	}
> >>>> +
> >>>> +	/* Check if the queue stopped before zeroing out, so no ptr get
> >>>> +	 * produced in the meantime, because this could result in waking
> >>>> +	 * even though the ptr_ring is full.
> >>>
> >>> So what? Maybe it would be a bit suboptimal? But with your design, I do
> >>> not get what prevents this:
> >>>
> >>>
> >>> 	stopped? -> No
> >>> 		ring is stopped
> >>> 	discard
> >>>
> >>> and queue stays stopped forever
> >>>
> >>>
> >>
> >> I totally missed this (but I am not sure why it did not happen in my 
> >> testing with different ptr_ring sizes..).
> >>
> >> I guess you are right, there must be some type of locking.
> >> It probably makes sense to lock the netdev txq->_xmit_lock whenever the 
> >> consumer invalidates old ptr_ring entries (so when r->consumer_head >= 
> >> r->consumer_tail). The producer holds this lock with dev->lltx=false. Then 
> >> the consumer is able to wake the queue safely.
> >>
> >> So I would now just change the implementation to:
> >> tun_net_xmit:
> >> ...
> >> if ptr_ring_produce
> >>     // Could happen because of unproduce in vhost_net..
> >>     netif_tx_stop_queue
> >>     ...
> >>     goto drop
> >>
> >> if ptr_ring_full
> >>     netif_tx_stop_queue
> >> ...
> >>
> >> tun_ring_recv/tap_do_read (the implementation for the batched methods 
> >> would be done in the similar way):
> >> ...
> >> ptr_ring_consume
> >> if r->consumer_head >= r->consumer_tail
> >>     __netif_tx_lock_bh
> >>     netif_tx_wake_queue
> >>     __netif_tx_unlock_bh
> >>
> >> This implementation does not need any new ptr_ring helpers and no fancy 
> >> ordering tricks.
> >> Would this implementation be sufficient in your opinion?
> > 
> > 
> > Maybe you mean == ? Pls don't poke at ptr ring internals though.
> > What are we testing for here?
> > I think the point is that a batch of entries was consumed?
> > Maybe __ptr_ring_consumed_batch ? and a comment explaining
> > this returns true when last successful call to consume
> > freed up a batch of space in the ring for producer to make
> > progress.
> >
> 
> Yes, I mean ==.
> 
> Having a dedicated helper for this purpose makes sense. I just find
> the name __ptr_ring_consumed_batch a bit confusing next to
> __ptr_ring_consume_batched, since they both refer to different kinds of
> batches.

__ptr_ring_consume_created_space ?

/* Previous call to ptr_ring_consume created some space.
 *
 * NB: only refers to the last call to __ptr_ring_consume,
 * if you are calling ptr_ring_consume multiple times, you
 * have to check this multiple times.
 * Accordingly, do not use this after __ptr_ring_consume_batched.
 */

> > 
> > consumer_head == consumer_tail also happens rather a lot,
> > though thankfully not on every entry.
> > So taking tx lock each time this happens, even if queue
> > is not stopped, seems heavyweight.
> > 
> > 
> 
> Yes, I agree — but avoiding locking probably requires some fancy
> ordering tricks again..
> 
> 
> > 
> > 
> > 
> >>>> The order of the operations
> >>>> +	 * is ensured by barrier().
> >>>> +	 */
> >>>> +	will_invalidate = __ptr_ring_will_invalidate(&q->ring);
> >>>> +	if (unlikely(will_invalidate)) {
> >>>> +		rcu_read_lock();
> >>>> +		dev = rcu_dereference(q->tap)->dev;
> >>>> +		txq = netdev_get_tx_queue(dev, q->queue_index);
> >>>> +		stopped = netif_tx_queue_stopped(txq);
> >>>> +	}
> >>>> +	barrier();
> >>>> +	__ptr_ring_discard_one(&q->ring, will_invalidate);
> >>>> +
> >>>> +	if (unlikely(will_invalidate)) {
> >>>> +		if (stopped)
> >>>> +			netif_tx_wake_queue(txq);
> >>>> +		rcu_read_unlock();
> >>>> +	}
> >>>
> >>>
> >>> After an entry is consumed, you can detect this by checking
> >>>
> >>> 	                r->consumer_head >= r->consumer_tail
> >>>
> >>>
> >>> so it seems you could keep calling regular ptr_ring_consume
> >>> and check afterwards?
> >>>
> >>>
> >>>
> >>>
> >>>> +	spin_unlock(&q->ring.consumer_lock);
> >>>> +
> >>>> +	return ptr;
> >>>> +}
> >>>> +
> >>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>  			   struct iov_iter *to,
> >>>>  			   int noblock, struct sk_buff *skb)
> >>>> @@ -774,7 +814,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
> >>>>  					TASK_INTERRUPTIBLE);
> >>>>  
> >>>>  		/* Read frames from the queue */
> >>>> -		skb = ptr_ring_consume(&q->ring);
> >>>> +		skb = tap_ring_consume(q);
> >>>>  		if (skb)
> >>>>  			break;
> >>>>  		if (noblock) {
> >>>> @@ -1207,6 +1247,8 @@ int tap_queue_resize(struct tap_dev *tap)
> >>>>  	ret = ptr_ring_resize_multiple_bh(rings, n,
> >>>>  					  dev->tx_queue_len, GFP_KERNEL,
> >>>>  					  __skb_array_destroy_skb);
> >>>> +	if (netif_running(dev))
> >>>> +		netif_tx_wake_all_queues(dev);
> >>>>  
> >>>>  	kfree(rings);
> >>>>  	return ret;
> >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>> index c6b22af9bae8..682df8157b55 100644
> >>>> --- a/drivers/net/tun.c
> >>>> +++ b/drivers/net/tun.c
> >>>> @@ -2114,13 +2114,53 @@ static ssize_t tun_put_user(struct tun_struct *tun,
> >>>>  	return total;
> >>>>  }
> >>>>  
> >>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>> +{
> >>>> +	struct netdev_queue *txq;
> >>>> +	struct net_device *dev;
> >>>> +	bool will_invalidate;
> >>>> +	bool stopped;
> >>>> +	void *ptr;
> >>>> +
> >>>> +	spin_lock(&tfile->tx_ring.consumer_lock);
> >>>> +	ptr = __ptr_ring_peek(&tfile->tx_ring);
> >>>> +	if (!ptr) {
> >>>> +		spin_unlock(&tfile->tx_ring.consumer_lock);
> >>>> +		return ptr;
> >>>> +	}
> >>>> +
> >>>> +	/* Check if the queue stopped before zeroing out, so no ptr get
> >>>> +	 * produced in the meantime, because this could result in waking
> >>>> +	 * even though the ptr_ring is full. The order of the operations
> >>>> +	 * is ensured by barrier().
> >>>> +	 */
> >>>> +	will_invalidate = __ptr_ring_will_invalidate(&tfile->tx_ring);
> >>>> +	if (unlikely(will_invalidate)) {
> >>>> +		rcu_read_lock();
> >>>> +		dev = rcu_dereference(tfile->tun)->dev;
> >>>> +		txq = netdev_get_tx_queue(dev, tfile->queue_index);
> >>>> +		stopped = netif_tx_queue_stopped(txq);
> >>>> +	}
> >>>> +	barrier();
> >>>> +	__ptr_ring_discard_one(&tfile->tx_ring, will_invalidate);
> >>>> +
> >>>> +	if (unlikely(will_invalidate)) {
> >>>> +		if (stopped)
> >>>> +			netif_tx_wake_queue(txq);
> >>>> +		rcu_read_unlock();
> >>>> +	}
> >>>> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> >>>> +
> >>>> +	return ptr;
> >>>> +}
> >>>> +
> >>>>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> >>>>  {
> >>>>  	DECLARE_WAITQUEUE(wait, current);
> >>>>  	void *ptr = NULL;
> >>>>  	int error = 0;
> >>>>  
> >>>> -	ptr = ptr_ring_consume(&tfile->tx_ring);
> >>>> +	ptr = tun_ring_consume(tfile);
> >>>>  	if (ptr)
> >>>>  		goto out;
> >>>>  	if (noblock) {
> >>>> @@ -2132,7 +2172,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> >>>>  
> >>>>  	while (1) {
> >>>>  		set_current_state(TASK_INTERRUPTIBLE);
> >>>> -		ptr = ptr_ring_consume(&tfile->tx_ring);
> >>>> +		ptr = tun_ring_consume(tfile);
> >>>>  		if (ptr)
> >>>>  			break;
> >>>>  		if (signal_pending(current)) {
> >>>> @@ -3621,6 +3661,9 @@ static int tun_queue_resize(struct tun_struct *tun)
> >>>>  					  dev->tx_queue_len, GFP_KERNEL,
> >>>>  					  tun_ptr_free);
> >>>>  
> >>>> +	if (netif_running(dev))
> >>>> +		netif_tx_wake_all_queues(dev);
> >>>> +
> >>>>  	kfree(rings);
> >>>>  	return ret;
> >>>>  }
> >>>> -- 
> >>>> 2.43.0
> >>>
> > 


