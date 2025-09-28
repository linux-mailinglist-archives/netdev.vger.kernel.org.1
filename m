Return-Path: <netdev+bounces-227062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F181BA790D
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 00:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83A73B4CFE
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 22:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D2298CC4;
	Sun, 28 Sep 2025 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foatBzkp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD5239591
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759098811; cv=none; b=NXCmWAeN8Sz+1ZIufxgRUrmntD+8axKUXxFajrwUtJT3hFYKvhhD22PtYpdZGoTc8I5PvTzVIfGTN5slD5rNUx5mCniEyHJODqH4yOQiu0ey9gnAYInAcP+uUu+J5Ar5ruBAc7ejrMDhLOhj2EhK6gEfnhgdIHxY7euv+FrbKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759098811; c=relaxed/simple;
	bh=kToVhAnyQxbOxNzGx185oA5CzF2OowSupwsidyoXwQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F57QCvbyUgyxo4Itw9AiDWrbeUaQuQgTH0igBBo3SfkD4nM5yRArh/1EdNa2q8a/ML3F7J4g0npyQgIrIfhGfrM3VJLU4qEcT2XML0sQm21C4R5MKH7nAQFPEI0UErS4C7U5siM/WzECj8j1v5KrKZGrkkZEimd6YW2Ub31pziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=foatBzkp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759098807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=63XHNOJUe+fnX5f1rSK96+lybuhkf+gQNTiVJFb80yo=;
	b=foatBzkpUNjrmtpWTKOWQCEs+Da97aV7/s5YT16Y6Vkcw345pQ8p79qFLuNRxt1iIgISSD
	HOSIQiI8RV8xyFQeqm6XgjjWnK8EBhlKmfHGiMdl1+QnW2UOpVj5BnXdkFkoyI3Zjo/l8+
	5KoGg8pnsP1+r3wUapF2mHGhWbkPN7c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-edNfdcD8M5yS2xYmIgD4_A-1; Sun, 28 Sep 2025 18:33:24 -0400
X-MC-Unique: edNfdcD8M5yS2xYmIgD4_A-1
X-Mimecast-MFC-AGG-ID: edNfdcD8M5yS2xYmIgD4_A_1759098802
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee13e43dd9so1909728f8f.1
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 15:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759098802; x=1759703602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63XHNOJUe+fnX5f1rSK96+lybuhkf+gQNTiVJFb80yo=;
        b=C1Wi1dS8H4X2HMehLBikVtIH6lqyblJ5NQBfPL580wdi6D6QAnLIm86kFhxABfdYsw
         QRPTdp6ACIhCROPthcsirLo5+kWd+J+/oQ2KD2jzSHqiJHyIQpqbAXdSlj1iT2p58Eu+
         2HRyFwla5ta883ZAUm2DuFpxG8yfRfnP0NWdUZ8DfN5a3DjC82zHSqovYn2KzARoKUvW
         /3wnzNgvGX2S6vF2dQKxKh+xjn3OAoJeUVs0cBrIc7CCJCOqBpp5pe9h4NLFPRJCJ7VO
         52Z+R6ldt8qrRxqtN+CYFqTcq9El0YUkbqZqsqF4hBlecJDVANZXdig2qBk92jbtbC9Y
         cm7w==
X-Forwarded-Encrypted: i=1; AJvYcCURb764pqy+o+dMC84Mj3nevZusIYggPuVM8Y9Z+laDC6B3pxPCNhuFK/N2pCdDI4FfyR6dYfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvVbJbrQmGB6+EJ1WcMhBIUOvNhXgJOUqgHj7YtT8lHHTCh6G
	POQZoEOAuwBWcjMWZ1gT3etA4uEUvFUzdlC8gQ3XBPsY+520qrA5axdEpf1lxf9J+NaOYdW0kel
	k0DRSYA2BQ8c9OtEeTtEFnQL08EP5UcgNkOAHUzEeId4lsIsUKKQolJuMEA==
X-Gm-Gg: ASbGncstS/uojEPNP0zdm/ERgcaap3qftMiy9s76wICPhvXpXZtX84NYi2GerEUQPns
	gA9f1Yu5dleBZhThYJVJ+lxkmrbjYK2i1a0Tn435pSIWI3zsHDZLIndiYBL896kRJ9VDaWYoTqm
	uNrISn/Hn5+WqtEAshSa3ylC5DwZZlHbtSft1gRel9g7lA7fd8ShV1qIzCobE1AcjiQmOBGCLk9
	DJ1trnKVLFihV/SkFaFfcl8rnleWalHxBYu6GwdWp+FY+IYGuGv9Vd27OLsHb1oMlLHM5p+f2aq
	8skghKMAx3uV57PmwM4jeuWR9Ot+TB6O3w==
X-Received: by 2002:a05:6000:1866:b0:3eb:734d:e2f2 with SMTP id ffacd0b85a97d-40e4c2d2463mr13842509f8f.56.1759098802359;
        Sun, 28 Sep 2025 15:33:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVyCIzpyN1mOCjVw8gGVf1INyZAm9Mv+ttxeBjXqNl1bSeoRkXBuU8fJnJUAzbRoGKbJDaCw==
X-Received: by 2002:a05:6000:1866:b0:3eb:734d:e2f2 with SMTP id ffacd0b85a97d-40e4c2d2463mr13842498f8f.56.1759098801750;
        Sun, 28 Sep 2025 15:33:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1516:4a00:1db4:bba4:9d0f:d39a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc88b0779sm15521075f8f.58.2025.09.28.15.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:33:21 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:33:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 4/8] TUN & TAP: Wake netdev queue after
 consuming an entry
Message-ID: <20250928182445-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250922221553.47802-5-simon.schippers@tu-dortmund.de>
 <20250923123101-mutt-send-email-mst@kernel.org>
 <4dde6d41-2a26-47b8-aef1-4967f7fc94ab@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dde6d41-2a26-47b8-aef1-4967f7fc94ab@tu-dortmund.de>

On Sun, Sep 28, 2025 at 11:27:25PM +0200, Simon Schippers wrote:
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
> 
> I think I found a solution to this problem, see below:
> 
> > 
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
> 
> Here I just check for
> 
> 	if (will_invalidate || __ptr_ring_empty(&q->ring)) {
> 
> instead because, if the ptr_ring is empty and the netdev queue stopped,
> the race must have occurred. Then it is safe to wake the netdev queue,
> because it is known that space in the ptr_ring was freed when the race
> occurred. Also, it is guaranteed that tap_ring_consume is called at least
> once after the race, because a new entry is generated by the producer at
> the race.
> In my adjusted implementation, it tests fine with pktgen without any lost
> packets.


what if it is not empty and ring is stopped?

> 
> Generally now I think that the whole implementation can be fine without
> using spinlocks at all. I am currently adjusting the implementation
> regarding SMP memory barrier pairings, and I have a question:
> In the v4 you mentioned "the stop -> wake bounce involves enough barriers
> already". Does it, for instance, mean that netif_tx_wake_queue already
> ensures memory ordering, and I do not have to use an smp_wmb() in front of
> netif_tx_wake_queue() and smp_rmb() in front of the ptr_ring operations
> in tun_net_xmit?
> I dug through net/core/netdevice.h and dev.c but could not really
> answer this question by myself...
> Thanks :)

Only if it wakes up something, I think.

Read:

SLEEP AND WAKE-UP FUNCTIONS


in Documentation/memory-barriers.txt


IIUC this is the same.


> 
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


