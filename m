Return-Path: <netdev+bounces-225803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3277B98710
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93CA19C0746
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 06:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B129D257831;
	Wed, 24 Sep 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtlFQGMB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F123D280
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696938; cv=none; b=CuRBMQOizQyWeT8dJA/GLWZTrw6Zhzn5CaFKF+0EVmkgi4ZuulEOtz9MEK0cYrUpCSzqgE0j8+txJO+++PU+YKUixCht1/HhbxkMWDTLPtU0s4QPdpozvxZU89jvC7exvdKw612qk3u5xJGXDGUudgkRzsVbNpOWyHu/lCAfSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696938; c=relaxed/simple;
	bh=IYyT2OvtNRU8mKssTIxBwKkXN9e3ywY0bC2fvBkYVDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT2I5NPMQzz15ROEp+vM7cwDRyx/OXjUEAQV7dlo4QHQdRAiNMdhjOqpLR5j9qdHI56yDjs0rB7nsDhw7GxdoqzA1d49mYUZfShd9evkbqAxAY5EhLH1Yh0PJ/7HqnnvbsfUzQ/GWS9jB/uWjJ3gqdnxAD46NCoBjP91Em5unU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtlFQGMB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758696935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMFaozSmWaP2nSuZAYoKtFmuv42SSqXkQF+k+CWOpeA=;
	b=PtlFQGMB/rEbDa39+2i0TesKsEseGzfL5IK4st3W3TxlCswHs+imzGc6Wy3lm/3idCfJT9
	20CBduoCwjQrXakAXU/QRQR1kiCbeds76F2cEfZWcurNXBzl9XuhiRuj5iTD4RcUf/7VWP
	5q2N81sFvV8L3QAOHXv7ViX5L+UqfaU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-5SS1_EPJP6OugJXQQ5o7dw-1; Wed, 24 Sep 2025 02:55:33 -0400
X-MC-Unique: 5SS1_EPJP6OugJXQQ5o7dw-1
X-Mimecast-MFC-AGG-ID: 5SS1_EPJP6OugJXQQ5o7dw_1758696933
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso38030725e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 23:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758696932; x=1759301732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMFaozSmWaP2nSuZAYoKtFmuv42SSqXkQF+k+CWOpeA=;
        b=FkdS9e2U/YEscpxLdeMtdrcGQfl5qn/SGStSE/mWRZk5YjtqJxdB9G/E65+BD5E3u8
         fpsEvZu8Z9l//S6qywFk6eRUtdlgUFu2bk5o58IoZKAu8bthpZ/rxn6vX4+Vma1UaE3r
         O6d0PbcCV1UMRueAAi1kIFsKUQn7I6i62LKAaevZy0Tp11zqbc2umZ/DiZJtxBywxbeO
         S8N1o5gN4Ks1+5KdZuFJYObxE8jEEX2VALn94o9GHD0S+W0z56REDggmjCpIG+2SASZQ
         A++jLg2v8E3qgG2un5x3lvn1GI3OqTxBAf74QgTc7EFbR5gh2/6/WeB3DlA9ulc+VAQ9
         mO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWm6wRi7DusXyHZeJv/mRgvBd/GcpkVxyWHT0Z5MmpjhfUuPnE8DmzFVtbiZlf+OG4BRRIGVfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr66+EqjaUvhSD73jMvBFAGteie4xAFUNyxa4fMCGv0EaokkOU
	JR/Z0D5+dtuFmEmVUU5USYdHt9jzlb9/xJRyCo5Nn6/0VmsuteGphvrw99K4DaK5MD11V0FVzXV
	tjcy5yui+zboWcolX8D6PlEtnHJpECW8OFQ1Vm2deh96cua9pkGwzVjllSQ==
X-Gm-Gg: ASbGncu6SCF3LyMYkUwgugd08ZF72oLmDVcjJdVp7DvS4nw4IQ/K3UT/oU40NbqPPtG
	sGFvQADL68QDihsCULL8+Rdpkl+q9jBGYJvemdWUFT/xLDsNbtHRGAK8tQRpVGcfkqtwBRrwMOR
	PnIh0nDU+jagfK4WSf6LRA/SP/iJnZszf/unEZ/JqS2zjhFMNTD6PMjGW2OFGvWtmmMncc7zBB5
	aXwFSnaGpKPebxnjl5c9/HiCHWADWc1TOWWk1g0Gu5J4JWgvFnCh4WOdCEpb3AFysb9Tai5FYZI
	NZ/c45roggLxTHjPCxIIDuLsrBy4953RN0o=
X-Received: by 2002:a05:600c:198f:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-46e1dac6457mr53314995e9.31.1758696932402;
        Tue, 23 Sep 2025 23:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzQnJawr202LYF/GiG0rNphKRkGOKkt//h6RbI08Bh3KFW0jxQ55p1coTiwy7Vic6NwDCxDw==
X-Received: by 2002:a05:600c:198f:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-46e1dac6457mr53314625e9.31.1758696931825;
        Tue, 23 Sep 2025 23:55:31 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f99178390csm13966234f8f.44.2025.09.23.23.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 23:55:31 -0700 (PDT)
Date: Wed, 24 Sep 2025 02:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 4/8] TUN & TAP: Wake netdev queue after
 consuming an entry
Message-ID: <20250924024416-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250922221553.47802-5-simon.schippers@tu-dortmund.de>
 <20250923123101-mutt-send-email-mst@kernel.org>
 <aacb449c-ad20-48b0-aa0f-b3866a3ed7f6@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacb449c-ad20-48b0-aa0f-b3866a3ed7f6@tu-dortmund.de>

On Wed, Sep 24, 2025 at 07:56:33AM +0200, Simon Schippers wrote:
> On 23.09.25 18:36, Michael S. Tsirkin wrote:
> > On Tue, Sep 23, 2025 at 12:15:49AM +0200, Simon Schippers wrote:
> >> The new wrappers tun_ring_consume/tap_ring_consume deal with consuming an
> >> entry of the ptr_ring and then waking the netdev queue when entries got
> >> invalidated to be used again by the producer.
> >> To avoid waking the netdev queue when the ptr_ring is full, it is checked
> >> if the netdev queue is stopped before invalidating entries. Like that the
> >> netdev queue can be safely woken after invalidating entries.
> >>
> >> The READ_ONCE in __ptr_ring_peek, paired with the smp_wmb() in
> >> __ptr_ring_produce within tun_net_xmit guarantees that the information
> >> about the netdev queue being stopped is visible after __ptr_ring_peek is
> >> called.
> >>
> >> The netdev queue is also woken after resizing the ptr_ring.
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/net/tap.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
> >>  drivers/net/tun.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
> >>  2 files changed, 88 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index 1197f245e873..f8292721a9d6 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -753,6 +753,46 @@ static ssize_t tap_put_user(struct tap_queue *q,
> >>  	return ret ? ret : total;
> >>  }
> >>  
> >> +static struct sk_buff *tap_ring_consume(struct tap_queue *q)
> >> +{
> >> +	struct netdev_queue *txq;
> >> +	struct net_device *dev;
> >> +	bool will_invalidate;
> >> +	bool stopped;
> >> +	void *ptr;
> >> +
> >> +	spin_lock(&q->ring.consumer_lock);
> >> +	ptr = __ptr_ring_peek(&q->ring);
> >> +	if (!ptr) {
> >> +		spin_unlock(&q->ring.consumer_lock);
> >> +		return ptr;
> >> +	}
> >> +
> >> +	/* Check if the queue stopped before zeroing out, so no ptr get
> >> +	 * produced in the meantime, because this could result in waking
> >> +	 * even though the ptr_ring is full.
> > 
> > So what? Maybe it would be a bit suboptimal? But with your design, I do
> > not get what prevents this:
> > 
> > 
> > 	stopped? -> No
> > 		ring is stopped
> > 	discard
> > 
> > and queue stays stopped forever
> > 
> > 
> 
> I totally missed this (but I am not sure why it did not happen in my 
> testing with different ptr_ring sizes..).
> 
> I guess you are right, there must be some type of locking.
> It probably makes sense to lock the netdev txq->_xmit_lock whenever the 
> consumer invalidates old ptr_ring entries (so when r->consumer_head >= 
> r->consumer_tail). The producer holds this lock with dev->lltx=false. Then 
> the consumer is able to wake the queue safely.
> 
> So I would now just change the implementation to:
> tun_net_xmit:
> ...
> if ptr_ring_produce
>     // Could happen because of unproduce in vhost_net..
>     netif_tx_stop_queue
>     ...
>     goto drop
> 
> if ptr_ring_full
>     netif_tx_stop_queue
> ...
> 
> tun_ring_recv/tap_do_read (the implementation for the batched methods 
> would be done in the similar way):
> ...
> ptr_ring_consume
> if r->consumer_head >= r->consumer_tail
>     __netif_tx_lock_bh
>     netif_tx_wake_queue
>     __netif_tx_unlock_bh
> 
> This implementation does not need any new ptr_ring helpers and no fancy 
> ordering tricks.
> Would this implementation be sufficient in your opinion?


Maybe you mean == ? Pls don't poke at ptr ring internals though.
What are we testing for here?
I think the point is that a batch of entries was consumed?
Maybe __ptr_ring_consumed_batch ? and a comment explaining
this returns true when last successful call to consume
freed up a batch of space in the ring for producer to make
progress.


consumer_head == consumer_tail also happens rather a lot,
though thankfully not on every entry.
So taking tx lock each time this happens, even if queue
is not stopped, seems heavyweight.





> >> The order of the operations
> >> +	 * is ensured by barrier().
> >> +	 */
> >> +	will_invalidate = __ptr_ring_will_invalidate(&q->ring);
> >> +	if (unlikely(will_invalidate)) {
> >> +		rcu_read_lock();
> >> +		dev = rcu_dereference(q->tap)->dev;
> >> +		txq = netdev_get_tx_queue(dev, q->queue_index);
> >> +		stopped = netif_tx_queue_stopped(txq);
> >> +	}
> >> +	barrier();
> >> +	__ptr_ring_discard_one(&q->ring, will_invalidate);
> >> +
> >> +	if (unlikely(will_invalidate)) {
> >> +		if (stopped)
> >> +			netif_tx_wake_queue(txq);
> >> +		rcu_read_unlock();
> >> +	}
> > 
> > 
> > After an entry is consumed, you can detect this by checking
> > 
> > 	                r->consumer_head >= r->consumer_tail
> > 
> > 
> > so it seems you could keep calling regular ptr_ring_consume
> > and check afterwards?
> > 
> > 
> > 
> > 
> >> +	spin_unlock(&q->ring.consumer_lock);
> >> +
> >> +	return ptr;
> >> +}
> >> +
> >>  static ssize_t tap_do_read(struct tap_queue *q,
> >>  			   struct iov_iter *to,
> >>  			   int noblock, struct sk_buff *skb)
> >> @@ -774,7 +814,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
> >>  					TASK_INTERRUPTIBLE);
> >>  
> >>  		/* Read frames from the queue */
> >> -		skb = ptr_ring_consume(&q->ring);
> >> +		skb = tap_ring_consume(q);
> >>  		if (skb)
> >>  			break;
> >>  		if (noblock) {
> >> @@ -1207,6 +1247,8 @@ int tap_queue_resize(struct tap_dev *tap)
> >>  	ret = ptr_ring_resize_multiple_bh(rings, n,
> >>  					  dev->tx_queue_len, GFP_KERNEL,
> >>  					  __skb_array_destroy_skb);
> >> +	if (netif_running(dev))
> >> +		netif_tx_wake_all_queues(dev);
> >>  
> >>  	kfree(rings);
> >>  	return ret;
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index c6b22af9bae8..682df8157b55 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -2114,13 +2114,53 @@ static ssize_t tun_put_user(struct tun_struct *tun,
> >>  	return total;
> >>  }
> >>  
> >> +static void *tun_ring_consume(struct tun_file *tfile)
> >> +{
> >> +	struct netdev_queue *txq;
> >> +	struct net_device *dev;
> >> +	bool will_invalidate;
> >> +	bool stopped;
> >> +	void *ptr;
> >> +
> >> +	spin_lock(&tfile->tx_ring.consumer_lock);
> >> +	ptr = __ptr_ring_peek(&tfile->tx_ring);
> >> +	if (!ptr) {
> >> +		spin_unlock(&tfile->tx_ring.consumer_lock);
> >> +		return ptr;
> >> +	}
> >> +
> >> +	/* Check if the queue stopped before zeroing out, so no ptr get
> >> +	 * produced in the meantime, because this could result in waking
> >> +	 * even though the ptr_ring is full. The order of the operations
> >> +	 * is ensured by barrier().
> >> +	 */
> >> +	will_invalidate = __ptr_ring_will_invalidate(&tfile->tx_ring);
> >> +	if (unlikely(will_invalidate)) {
> >> +		rcu_read_lock();
> >> +		dev = rcu_dereference(tfile->tun)->dev;
> >> +		txq = netdev_get_tx_queue(dev, tfile->queue_index);
> >> +		stopped = netif_tx_queue_stopped(txq);
> >> +	}
> >> +	barrier();
> >> +	__ptr_ring_discard_one(&tfile->tx_ring, will_invalidate);
> >> +
> >> +	if (unlikely(will_invalidate)) {
> >> +		if (stopped)
> >> +			netif_tx_wake_queue(txq);
> >> +		rcu_read_unlock();
> >> +	}
> >> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> >> +
> >> +	return ptr;
> >> +}
> >> +
> >>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> >>  {
> >>  	DECLARE_WAITQUEUE(wait, current);
> >>  	void *ptr = NULL;
> >>  	int error = 0;
> >>  
> >> -	ptr = ptr_ring_consume(&tfile->tx_ring);
> >> +	ptr = tun_ring_consume(tfile);
> >>  	if (ptr)
> >>  		goto out;
> >>  	if (noblock) {
> >> @@ -2132,7 +2172,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> >>  
> >>  	while (1) {
> >>  		set_current_state(TASK_INTERRUPTIBLE);
> >> -		ptr = ptr_ring_consume(&tfile->tx_ring);
> >> +		ptr = tun_ring_consume(tfile);
> >>  		if (ptr)
> >>  			break;
> >>  		if (signal_pending(current)) {
> >> @@ -3621,6 +3661,9 @@ static int tun_queue_resize(struct tun_struct *tun)
> >>  					  dev->tx_queue_len, GFP_KERNEL,
> >>  					  tun_ptr_free);
> >>  
> >> +	if (netif_running(dev))
> >> +		netif_tx_wake_all_queues(dev);
> >> +
> >>  	kfree(rings);
> >>  	return ret;
> >>  }
> >> -- 
> >> 2.43.0
> > 


