Return-Path: <netdev+bounces-225904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4264B99037
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 11:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EC319C271C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27F2D5425;
	Wed, 24 Sep 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqeT8gQn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D34F2836BE
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704457; cv=none; b=RdJsfpE6G8RZfgJ4XGq+qjmjk6iU2mAPXbqn40yCoMRtwm/UOLpU4itspXsCWMwXfvkqnh6ojPv9TKTsxATXjdiUAVikxRUhGUFFK2B9oGPxArn5pZ0/A5Y8AeGCJg/Pfu58GCHoyaWT3AKii8plSy1yGti/jrF/NcaTznYD4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704457; c=relaxed/simple;
	bh=Nh4aVWGuaiRZVqPL441CW5oZI1GWK7ZjIAMJm7moJUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNrCIPAEay0vGcP3JEPecAt9+nK5rjg1m7yiHLNpty3sKENwNmRtC/WlgiZ/SPKm0qVf0fmv0tKg7Hhv1UStF9PeQChs18aD5Xns+LQv9ewMWhpLQdD2bKoxcQbpmbu5xTWILX971Qv3qi92/HIylH+aIj9a4xtN1d9ozoy+2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqeT8gQn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758704454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLs02NJP+bbyEGdjFVbfYO8s3w/0jWQxn/snmC8403w=;
	b=CqeT8gQnSAb5mG85c4uRYBHbkc8LpNxNlBY6Cl2m5lsoQckLU5kNkjlLpEf9KPE7tPpsrp
	DIzexfqkSRUZe8yacI1yjiANa1kCjDjeDhp7XaHUr43AokfyVKBwmEiUrefcXbA1x9/Wsb
	9BCutiwo7YbHafhRLwyGVW8UwQVFvSs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-lMC87-_9MtybP7s4QDPcIA-1; Wed, 24 Sep 2025 05:00:52 -0400
X-MC-Unique: lMC87-_9MtybP7s4QDPcIA-1
X-Mimecast-MFC-AGG-ID: lMC87-_9MtybP7s4QDPcIA_1758704452
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b0f435a8e5eso826373266b.0
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 02:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758704451; x=1759309251;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLs02NJP+bbyEGdjFVbfYO8s3w/0jWQxn/snmC8403w=;
        b=rc+neM6TP+D+F/M9GVAlpzlSKpFBr8CEgYKzDA57M6Wwkfb+kU+r5s2rW+IO7vMCOo
         MpRZEd1Woor9IrVuNSuv8AKZ2KiCqFKicIYIdJGKDDFreYxV3vnWez2oyCV0hONPDT+C
         I3pntD61w/xUg1Idr5QGPjrnKnci0Ui6pBky7kH51VNgF/F6ImweHbIOvz2vH8MW1+I8
         NV9AXdwtplZDCjLXsUxY7/D6BNvJDERHkmx7VX8bd1JKhW0EJ6oshFP/Gs9C29Adwh0v
         cVyLvh89HGu+SfxCfiYTNZN4bHPwZes1p2jTVLanWr6WPqnntlkXx3PDCuOJ9b2ROiPv
         A4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWBh+LaSgglLNjB3xD7BlTL4n9MkJ0J/DmUVtxnrrTk8UkdmrDqV5Cl/KT304j/rwP2LoBukQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBLH8RvUmci8pzGL4TxnRj3bqFQPJIKFd5qgnNJ0flBIYqnIC
	2adyzC7NTywK5EuINvrHJhCZz1KdPru982rtJaLk/BzWQ/Ioo8eFChlF7lA7+BNYZe20WV6Bgma
	ctZuIZZdVVAkVdfTIRTHngUCmt98RyOtqfopu05fCVRXyGc176S8aeYfqnA==
X-Gm-Gg: ASbGncv27UMndTGS5Zbve0pSLjpfnOX3Mh4ErTzxAZ4nIDXehdHbs+LKuSoPvmxPiaI
	8cJjZgiNQh29cJnaNuQkTx0RP9iPun9Op1b/BJUChnZ2DP/cXHQEIIYda/oVu+pG+lXfsMo5HDG
	nuYog2XmC2GVK3De9a32iDGDfEZyNOiUjXT+2T+UAyMqSjHkJgU6ZplQmbuaQV9MYZ0slbsVLJn
	6xwCyTuCWZX+C9pmxG9AlYOlfTets6O35nLWfZTV7v6Jrtq/QZZqCVrM6M0FFEBNBMI81dvFsTU
	vWVc81PQ36TGIJQBv3YQmgmHgO/P
X-Received: by 2002:a17:907:9482:b0:b1f:5e1:9f1c with SMTP id a640c23a62f3a-b3027d3f2damr533552766b.29.1758704451400;
        Wed, 24 Sep 2025 02:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9UJN71fNOGfyW/6PFSyW+8a3intaX+vKq3ShzQOP5w4u3pGLhKrKfOxe0gV8M4eHlJvrd0g==
X-Received: by 2002:a17:907:9482:b0:b1f:5e1:9f1c with SMTP id a640c23a62f3a-b3027d3f2damr533538766b.29.1758704449381;
        Wed, 24 Sep 2025 02:00:49 -0700 (PDT)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2928cd31a6sm903885066b.102.2025.09.24.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 02:00:48 -0700 (PDT)
Date: Wed, 24 Sep 2025 05:00:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 4/8] TUN & TAP: Wake netdev queue after
 consuming an entry
Message-ID: <20250924045554-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250922221553.47802-5-simon.schippers@tu-dortmund.de>
 <20250923123101-mutt-send-email-mst@kernel.org>
 <aacb449c-ad20-48b0-aa0f-b3866a3ed7f6@tu-dortmund.de>
 <20250924024416-mutt-send-email-mst@kernel.org>
 <a16b643a-3cfe-4b95-b76a-100f512cdb79@tu-dortmund.de>
 <20250924034534-mutt-send-email-mst@kernel.org>
 <9e7b0931-afde-4b14-8a6e-372bda6cf95e@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e7b0931-afde-4b14-8a6e-372bda6cf95e@tu-dortmund.de>

On Wed, Sep 24, 2025 at 10:40:04AM +0200, Simon Schippers wrote:
> On 24.09.25 09:49, Michael S. Tsirkin wrote:
> > On Wed, Sep 24, 2025 at 09:42:45AM +0200, Simon Schippers wrote:
> >> On 24.09.25 08:55, Michael S. Tsirkin wrote:
> >>> On Wed, Sep 24, 2025 at 07:56:33AM +0200, Simon Schippers wrote:
> >>>> On 23.09.25 18:36, Michael S. Tsirkin wrote:
> >>>>> On Tue, Sep 23, 2025 at 12:15:49AM +0200, Simon Schippers wrote:
> >>>>>> The new wrappers tun_ring_consume/tap_ring_consume deal with consuming an
> >>>>>> entry of the ptr_ring and then waking the netdev queue when entries got
> >>>>>> invalidated to be used again by the producer.
> >>>>>> To avoid waking the netdev queue when the ptr_ring is full, it is checked
> >>>>>> if the netdev queue is stopped before invalidating entries. Like that the
> >>>>>> netdev queue can be safely woken after invalidating entries.
> >>>>>>
> >>>>>> The READ_ONCE in __ptr_ring_peek, paired with the smp_wmb() in
> >>>>>> __ptr_ring_produce within tun_net_xmit guarantees that the information
> >>>>>> about the netdev queue being stopped is visible after __ptr_ring_peek is
> >>>>>> called.
> >>>>>>
> >>>>>> The netdev queue is also woken after resizing the ptr_ring.
> >>>>>>
> >>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>>>> ---
> >>>>>>  drivers/net/tap.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
> >>>>>>  drivers/net/tun.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
> >>>>>>  2 files changed, 88 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>> index 1197f245e873..f8292721a9d6 100644
> >>>>>> --- a/drivers/net/tap.c
> >>>>>> +++ b/drivers/net/tap.c
> >>>>>> @@ -753,6 +753,46 @@ static ssize_t tap_put_user(struct tap_queue *q,
> >>>>>>  	return ret ? ret : total;
> >>>>>>  }
> >>>>>>  
> >>>>>> +static struct sk_buff *tap_ring_consume(struct tap_queue *q)
> >>>>>> +{
> >>>>>> +	struct netdev_queue *txq;
> >>>>>> +	struct net_device *dev;
> >>>>>> +	bool will_invalidate;
> >>>>>> +	bool stopped;
> >>>>>> +	void *ptr;
> >>>>>> +
> >>>>>> +	spin_lock(&q->ring.consumer_lock);
> >>>>>> +	ptr = __ptr_ring_peek(&q->ring);
> >>>>>> +	if (!ptr) {
> >>>>>> +		spin_unlock(&q->ring.consumer_lock);
> >>>>>> +		return ptr;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	/* Check if the queue stopped before zeroing out, so no ptr get
> >>>>>> +	 * produced in the meantime, because this could result in waking
> >>>>>> +	 * even though the ptr_ring is full.
> >>>>>
> >>>>> So what? Maybe it would be a bit suboptimal? But with your design, I do
> >>>>> not get what prevents this:
> >>>>>
> >>>>>
> >>>>> 	stopped? -> No
> >>>>> 		ring is stopped
> >>>>> 	discard
> >>>>>
> >>>>> and queue stays stopped forever
> >>>>>
> >>>>>
> >>>>
> >>>> I totally missed this (but I am not sure why it did not happen in my 
> >>>> testing with different ptr_ring sizes..).
> >>>>
> >>>> I guess you are right, there must be some type of locking.
> >>>> It probably makes sense to lock the netdev txq->_xmit_lock whenever the 
> >>>> consumer invalidates old ptr_ring entries (so when r->consumer_head >= 
> >>>> r->consumer_tail). The producer holds this lock with dev->lltx=false. Then 
> >>>> the consumer is able to wake the queue safely.
> >>>>
> >>>> So I would now just change the implementation to:
> >>>> tun_net_xmit:
> >>>> ...
> >>>> if ptr_ring_produce
> >>>>     // Could happen because of unproduce in vhost_net..
> >>>>     netif_tx_stop_queue
> >>>>     ...
> >>>>     goto drop
> >>>>
> >>>> if ptr_ring_full
> >>>>     netif_tx_stop_queue
> >>>> ...
> >>>>
> >>>> tun_ring_recv/tap_do_read (the implementation for the batched methods 
> >>>> would be done in the similar way):
> >>>> ...
> >>>> ptr_ring_consume
> >>>> if r->consumer_head >= r->consumer_tail
> >>>>     __netif_tx_lock_bh
> >>>>     netif_tx_wake_queue
> >>>>     __netif_tx_unlock_bh
> >>>>
> >>>> This implementation does not need any new ptr_ring helpers and no fancy 
> >>>> ordering tricks.
> >>>> Would this implementation be sufficient in your opinion?
> >>>
> >>>
> >>> Maybe you mean == ? Pls don't poke at ptr ring internals though.
> >>> What are we testing for here?
> >>> I think the point is that a batch of entries was consumed?
> >>> Maybe __ptr_ring_consumed_batch ? and a comment explaining
> >>> this returns true when last successful call to consume
> >>> freed up a batch of space in the ring for producer to make
> >>> progress.
> >>>
> >>
> >> Yes, I mean ==.
> >>
> >> Having a dedicated helper for this purpose makes sense. I just find
> >> the name __ptr_ring_consumed_batch a bit confusing next to
> >> __ptr_ring_consume_batched, since they both refer to different kinds of
> >> batches.
> > 
> > __ptr_ring_consume_created_space ?
> > 
> > /* Previous call to ptr_ring_consume created some space.
> >  *
> >  * NB: only refers to the last call to __ptr_ring_consume,
> >  * if you are calling ptr_ring_consume multiple times, you
> >  * have to check this multiple times.
> >  * Accordingly, do not use this after __ptr_ring_consume_batched.
> >  */
> >
> 
> Sounds good.
> 
> Regarding __ptr_ring_consume_batched:
> Theoretically the consumer_tail before and after calling the method could
> be compared to avoid calling __ptr_ring_consume_created_space at each
> iteration. But I guess it is also fine calling it at each iteration.

Hmm good point, though I worry about wrap-around a bit.


> >>>
> >>> consumer_head == consumer_tail also happens rather a lot,
> >>> though thankfully not on every entry.
> >>> So taking tx lock each time this happens, even if queue
> >>> is not stopped, seems heavyweight.
> >>>
> >>>
> >>
> >> Yes, I agree — but avoiding locking probably requires some fancy
> >> ordering tricks again..
> >>
> >>
> >>>
> >>>
> >>>
> >>>>>> The order of the operations
> >>>>>> +	 * is ensured by barrier().
> >>>>>> +	 */
> >>>>>> +	will_invalidate = __ptr_ring_will_invalidate(&q->ring);
> >>>>>> +	if (unlikely(will_invalidate)) {
> >>>>>> +		rcu_read_lock();
> >>>>>> +		dev = rcu_dereference(q->tap)->dev;
> >>>>>> +		txq = netdev_get_tx_queue(dev, q->queue_index);
> >>>>>> +		stopped = netif_tx_queue_stopped(txq);
> >>>>>> +	}
> >>>>>> +	barrier();
> >>>>>> +	__ptr_ring_discard_one(&q->ring, will_invalidate);
> >>>>>> +
> >>>>>> +	if (unlikely(will_invalidate)) {
> >>>>>> +		if (stopped)
> >>>>>> +			netif_tx_wake_queue(txq);
> >>>>>> +		rcu_read_unlock();
> >>>>>> +	}
> >>>>>
> >>>>>
> >>>>> After an entry is consumed, you can detect this by checking
> >>>>>
> >>>>> 	                r->consumer_head >= r->consumer_tail
> >>>>>
> >>>>>
> >>>>> so it seems you could keep calling regular ptr_ring_consume
> >>>>> and check afterwards?
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>> +	spin_unlock(&q->ring.consumer_lock);
> >>>>>> +
> >>>>>> +	return ptr;
> >>>>>> +}
> >>>>>> +
> >>>>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>>>  			   struct iov_iter *to,
> >>>>>>  			   int noblock, struct sk_buff *skb)
> >>>>>> @@ -774,7 +814,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
> >>>>>>  					TASK_INTERRUPTIBLE);
> >>>>>>  
> >>>>>>  		/* Read frames from the queue */
> >>>>>> -		skb = ptr_ring_consume(&q->ring);
> >>>>>> +		skb = tap_ring_consume(q);
> >>>>>>  		if (skb)
> >>>>>>  			break;
> >>>>>>  		if (noblock) {
> >>>>>> @@ -1207,6 +1247,8 @@ int tap_queue_resize(struct tap_dev *tap)
> >>>>>>  	ret = ptr_ring_resize_multiple_bh(rings, n,
> >>>>>>  					  dev->tx_queue_len, GFP_KERNEL,
> >>>>>>  					  __skb_array_destroy_skb);
> >>>>>> +	if (netif_running(dev))
> >>>>>> +		netif_tx_wake_all_queues(dev);
> >>>>>>  
> >>>>>>  	kfree(rings);
> >>>>>>  	return ret;
> >>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>> index c6b22af9bae8..682df8157b55 100644
> >>>>>> --- a/drivers/net/tun.c
> >>>>>> +++ b/drivers/net/tun.c
> >>>>>> @@ -2114,13 +2114,53 @@ static ssize_t tun_put_user(struct tun_struct *tun,
> >>>>>>  	return total;
> >>>>>>  }
> >>>>>>  
> >>>>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>>>> +{
> >>>>>> +	struct netdev_queue *txq;
> >>>>>> +	struct net_device *dev;
> >>>>>> +	bool will_invalidate;
> >>>>>> +	bool stopped;
> >>>>>> +	void *ptr;
> >>>>>> +
> >>>>>> +	spin_lock(&tfile->tx_ring.consumer_lock);
> >>>>>> +	ptr = __ptr_ring_peek(&tfile->tx_ring);
> >>>>>> +	if (!ptr) {
> >>>>>> +		spin_unlock(&tfile->tx_ring.consumer_lock);
> >>>>>> +		return ptr;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	/* Check if the queue stopped before zeroing out, so no ptr get
> >>>>>> +	 * produced in the meantime, because this could result in waking
> >>>>>> +	 * even though the ptr_ring is full. The order of the operations
> >>>>>> +	 * is ensured by barrier().
> >>>>>> +	 */
> >>>>>> +	will_invalidate = __ptr_ring_will_invalidate(&tfile->tx_ring);
> >>>>>> +	if (unlikely(will_invalidate)) {
> >>>>>> +		rcu_read_lock();
> >>>>>> +		dev = rcu_dereference(tfile->tun)->dev;
> >>>>>> +		txq = netdev_get_tx_queue(dev, tfile->queue_index);
> >>>>>> +		stopped = netif_tx_queue_stopped(txq);
> >>>>>> +	}
> >>>>>> +	barrier();
> >>>>>> +	__ptr_ring_discard_one(&tfile->tx_ring, will_invalidate);
> >>>>>> +
> >>>>>> +	if (unlikely(will_invalidate)) {
> >>>>>> +		if (stopped)
> >>>>>> +			netif_tx_wake_queue(txq);
> >>>>>> +		rcu_read_unlock();
> >>>>>> +	}
> >>>>>> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> >>>>>> +
> >>>>>> +	return ptr;
> >>>>>> +}
> >>>>>> +
> >>>>>>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> >>>>>>  {
> >>>>>>  	DECLARE_WAITQUEUE(wait, current);
> >>>>>>  	void *ptr = NULL;
> >>>>>>  	int error = 0;
> >>>>>>  
> >>>>>> -	ptr = ptr_ring_consume(&tfile->tx_ring);
> >>>>>> +	ptr = tun_ring_consume(tfile);
> >>>>>>  	if (ptr)
> >>>>>>  		goto out;
> >>>>>>  	if (noblock) {
> >>>>>> @@ -2132,7 +2172,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> >>>>>>  
> >>>>>>  	while (1) {
> >>>>>>  		set_current_state(TASK_INTERRUPTIBLE);
> >>>>>> -		ptr = ptr_ring_consume(&tfile->tx_ring);
> >>>>>> +		ptr = tun_ring_consume(tfile);
> >>>>>>  		if (ptr)
> >>>>>>  			break;
> >>>>>>  		if (signal_pending(current)) {
> >>>>>> @@ -3621,6 +3661,9 @@ static int tun_queue_resize(struct tun_struct *tun)
> >>>>>>  					  dev->tx_queue_len, GFP_KERNEL,
> >>>>>>  					  tun_ptr_free);
> >>>>>>  
> >>>>>> +	if (netif_running(dev))
> >>>>>> +		netif_tx_wake_all_queues(dev);
> >>>>>> +
> >>>>>>  	kfree(rings);
> >>>>>>  	return ret;
> >>>>>>  }
> >>>>>> -- 
> >>>>>> 2.43.0
> >>>>>
> >>>
> > 


