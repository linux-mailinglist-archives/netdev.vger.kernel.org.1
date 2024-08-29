Return-Path: <netdev+bounces-123211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D617396421E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BD1B261AA
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911B418E358;
	Thu, 29 Aug 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CBVuGKso"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7018E02F
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928053; cv=none; b=JtBp8mDbRG/N3ANOqTWvjRqow1DYUFPuaEu4EPo388ti7TPOW266HXxsq48kqWdA8ZZfCP4i9xK1Z8/faQRDu7P6f4wdK7ZvhC7y2gHPRkEONPlABejDrR+kHgc1AC3Qz/VrdZASE6mT+A2shocv3iAiPasHXX4Fe3rmCH6oTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928053; c=relaxed/simple;
	bh=oBs6rTef3t7+2UM7m73Q75zjl+OdHm7lJRZDomtLuvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0X4nhVE9JvgOyrMKVHrwJKCPiKTs26p5XXEzgaNyqtLdSeFZ7zWAT2uCe4IrSdSf7ff/Hw0+xnRdpqCM3Hn5l1QgWnTiHkTUtoSQwEakmQKeaHWVEWZvlFqnAnIHtUJBLaJOhYNyCPVvx/p+jnKcgScKveg2k2BLXvOWwXfEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CBVuGKso; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a86acbaddb4so53396666b.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724928050; x=1725532850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tsq//j+H5ixsuT8m1m+oQU7qTGwUCuKP2F/HTF+wnpE=;
        b=CBVuGKsoN8+2kvK5YElh1Ichtg+I23XHF61yhmyccnh8gctR0VlmkXH9XcfggYeB8o
         qSnCzVg4FKMXyKz5MHbBcgl/osObqqUl2FQ0i7/YJxUd6uE0uxBqmELbPHNJpA9QXAGQ
         J3RxHlhpTrAiXCuhx3Dd1b8vKdO7qF3x/zkDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724928050; x=1725532850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tsq//j+H5ixsuT8m1m+oQU7qTGwUCuKP2F/HTF+wnpE=;
        b=L9xgrZEeMGT/GNuDdpxRFDxOw2V1K1Zq8elzXiDFwAtbsdz93sfcg/yxL6zAUuPzIh
         oM6kQduFw1kuDUjRzIG/lds+kW5YM5FaCoRnCke/hP9Bd6F06LG+EWF/0i2OfZfA8SZo
         uSl8D6GeYgb6P4LY9MXI8hAILzoPoJnLoVoJ3eoD9kLXQvDLd9UhzCsAx2lGyiGwRNhk
         LCdhZfumH3MN2POQoVFzYIURhNhI49/Pl+KMeItsOqAIjZO3/ZK8bjqQ9se5DFzTHheo
         wj8k0Xo+k0rFmakHrch2WqutnnWuCQgu2W4cHTungaXYMAqunowjgCCeSpXABNxEDgRq
         1o/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVt51S+9T8Pa9GwcQ7z3rJCMeSozqY/2pNpCmql8yklpMXV2f7ZgAzKEq3L4Ge9ACojesRJFgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUTIT3uKlWROyPPWsEcDSB2qwAd8ozf8r53vs//VRMxrYd1vR+
	P0kjwz9ksGMKQvSy3zCCC7BvOmIBr8fGX4V6Gl8qboLiL5gMdg8BCJqzcAtuAf8=
X-Google-Smtp-Source: AGHT+IHUfySnDTuQo2u25koIToxsry3YgUb2xQDsoBD8wjywfCio/HCqYP4RML57+Q8ru2bOH5YcvA==
X-Received: by 2002:a17:907:7da4:b0:a86:9793:350d with SMTP id a640c23a62f3a-a897fad5099mr165221266b.62.1724928049067;
        Thu, 29 Aug 2024 03:40:49 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feae58sm63790066b.18.2024.08.29.03.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:40:48 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:40:46 +0100
From: Joe Damato <jdamato@fastly.com>
To: Naman Gulati <namangulati@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
	skhawaja@google.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	mkarsten@uwaterloo.ca
Subject: Re: [PATCH] Add provision to busyloop for events in ep_poll.
Message-ID: <ZtBQLqqMrpCLBMw1@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Naman Gulati <namangulati@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
	skhawaja@google.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	mkarsten@uwaterloo.ca
References: <20240828181011.1591242-1-namangulati@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828181011.1591242-1-namangulati@google.com>

On Wed, Aug 28, 2024 at 06:10:11PM +0000, Naman Gulati wrote:
> NAPI busypolling in ep_busy_loop loops on napi_poll and checks for new
> epoll events after every napi poll. Checking just for epoll events in a
> tight loop in the kernel context delivers latency gains to applications
> that are not interested in napi busypolling with epoll.
> 
> This patch adds an option to loop just for new events inside
> ep_busy_loop, guarded by the EPIOCSPARAMS ioctl that controls epoll napi
> busypolling.

This makes an API change, so I think that linux-api@vger.kernel.org
needs to be CC'd ?
 
> A comparison with neper tcp_rr shows that busylooping for events in
> epoll_wait boosted throughput by ~3-7% and reduced median latency by
> ~10%.
> 
> To demonstrate the latency and throughput improvements, a comparison was
> made of neper tcp_rr running with:
>     1. (baseline) No busylooping

Is there NAPI-based steering to threads via SO_INCOMING_NAPI_ID in
this case? More details, please, on locality. If there is no
NAPI-based flow steering in this case, perhaps the improvements you
are seeing are a result of both syscall overhead avoidance and data
locality?

>     2. (epoll busylooping) enabling the epoll busy looping on all epoll
>     fd's

This is the case you've added, event_poll_only ? It seems like in
this case you aren't busy looping exactly, you are essentially
allowing IRQ/softIRQ to drive processing and checking on wakeup that
events are available.

IMHO, I'm not sure if "epoll busylooping" is an appropriate
description.

>     3. (userspace busylooping) looping on epoll_wait in userspace
>     with timeout=0

Same question as Stanislav; timeout=0 should get ep_loop to transfer
events immediately (if there are any) and return without actually
invoking busy poll. So, it would seem that your ioctl change
shouldn't be necessary since the equivalent behavior is already
possible with timeout=0.

I'd probably investigate both syscall overhead and data locality
before approving this patch because it seems a bit suspicious to me.

> 
> Stats for two machines with 100Gbps NICs running tcp_rr with 5 threads
> and varying flows:
> 
> Type                Flows   Throughput             Latency (μs)
>                              (B/s)      P50   P90    P99   P99.9   P99.99
> baseline            15	    272145      57.2  71.9   91.4  100.6   111.6
> baseline            30	    464952	66.8  78.8   98.1  113.4   122.4
> baseline            60	    695920	80.9  118.5  143.4 161.8   174.6
> epoll busyloop      15	    301751	44.7  70.6   84.3  95.4    106.5
> epoll busyloop      30	    508392	58.9  76.9   96.2  109.3   118.5
> epoll busyloop      60	    745731	77.4  106.2  127.5 143.1   155.9
> userspace busyloop  15	    279202	55.4  73.1   85.2  98.3    109.6
> userspace busyloop  30	    472440	63.7  78.2   96.5  112.2   120.1
> userspace busyloop  60	    720779	77.9  113.5  134.9 152.6   165.7
> 
> Per the above data epoll busyloop outperforms baseline and userspace
> busylooping in both throughput and latency. As the density of flows per
> thread increased, the median latency of all three epoll mechanisms
> converges. However epoll busylooping is better at capturing the tail
> latencies at high flow counts.
> 
> Signed-off-by: Naman Gulati <namangulati@google.com>
> ---
>  fs/eventpoll.c                 | 53 ++++++++++++++++++++++++++--------
>  include/uapi/linux/eventpoll.h |  3 +-
>  2 files changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index f53ca4f7fcedd..6cba79261817a 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -232,7 +232,10 @@ struct eventpoll {
>  	u32 busy_poll_usecs;
>  	/* busy poll packet budget */
>  	u16 busy_poll_budget;
> -	bool prefer_busy_poll;
> +	/* prefer to busypoll in napi poll */
> +	bool napi_prefer_busy_poll;

Adding napi seems slightly redundant to me but I could be convinced either
way, I suppose.

> +	/* avoid napi poll when busy looping and poll only for events */
> +	bool event_poll_only;

I'm not sure about this overall; this isn't exactly what I think of
when I think about the word "polling" but maybe I'm being too
nit-picky.

>  #endif
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> @@ -430,6 +433,24 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
>  	return ep_events_available(ep) || busy_loop_ep_timeout(start_time, ep);
>  }
>  
> +/**
> + * ep_event_busy_loop - loop until events available or busy poll
> + * times out.
> + *
> + * @ep: Pointer to the eventpoll context.
> + *
> + * Return: true if events available, false otherwise.
> + */
> +static bool ep_event_busy_loop(struct eventpoll *ep)
> +{
> +	unsigned long start_time = busy_loop_current_time();
> +
> +	while (!ep_busy_loop_end(ep, start_time))
> +		cond_resched();
> +
> +	return ep_events_available(ep);
> +}
> +
>  /*
>   * Busy poll if globally on and supporting sockets found && no events,
>   * busy loop will return if need_resched or ep_events_available.
> @@ -440,23 +461,29 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
>  {
>  	unsigned int napi_id = READ_ONCE(ep->napi_id);
>  	u16 budget = READ_ONCE(ep->busy_poll_budget);
> -	bool prefer_busy_poll = READ_ONCE(ep->prefer_busy_poll);
> +	bool event_poll_only = READ_ONCE(ep->event_poll_only);
>  
>  	if (!budget)
>  		budget = BUSY_POLL_BUDGET;
>  
> -	if (napi_id >= MIN_NAPI_ID && ep_busy_loop_on(ep)) {
> +	if (!ep_busy_loop_on(ep))
> +		return false;
> +
> +	if (event_poll_only) {
> +		return ep_event_busy_loop(ep);
> +	} else if (napi_id >= MIN_NAPI_ID) {
> +		bool napi_prefer_busy_poll = READ_ONCE(ep->napi_prefer_busy_poll);
> +
>  		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end,
> -			       ep, prefer_busy_poll, budget);
> +				ep, napi_prefer_busy_poll, budget);
>  		if (ep_events_available(ep))
>  			return true;
>  		/*
> -		 * Busy poll timed out.  Drop NAPI ID for now, we can add
> -		 * it back in when we have moved a socket with a valid NAPI
> -		 * ID onto the ready list.
> -		 */
> +		* Busy poll timed out.  Drop NAPI ID for now, we can add
> +		* it back in when we have moved a socket with a valid NAPI
> +		* ID onto the ready list.
> +		*/
>  		ep->napi_id = 0;
> -		return false;
>  	}
>  	return false;
>  }
> @@ -523,13 +550,15 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
>  
>  		WRITE_ONCE(ep->busy_poll_usecs, epoll_params.busy_poll_usecs);
>  		WRITE_ONCE(ep->busy_poll_budget, epoll_params.busy_poll_budget);
> -		WRITE_ONCE(ep->prefer_busy_poll, epoll_params.prefer_busy_poll);
> +		WRITE_ONCE(ep->napi_prefer_busy_poll, epoll_params.prefer_busy_poll);
> +		WRITE_ONCE(ep->event_poll_only, epoll_params.event_poll_only);
>  		return 0;
>  	case EPIOCGPARAMS:
>  		memset(&epoll_params, 0, sizeof(epoll_params));
>  		epoll_params.busy_poll_usecs = READ_ONCE(ep->busy_poll_usecs);
>  		epoll_params.busy_poll_budget = READ_ONCE(ep->busy_poll_budget);
> -		epoll_params.prefer_busy_poll = READ_ONCE(ep->prefer_busy_poll);
> +		epoll_params.prefer_busy_poll = READ_ONCE(ep->napi_prefer_busy_poll);
> +		epoll_params.event_poll_only = READ_ONCE(ep->event_poll_only);
>  		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
>  			return -EFAULT;
>  		return 0;
> @@ -2203,7 +2232,7 @@ static int do_epoll_create(int flags)
>  #ifdef CONFIG_NET_RX_BUSY_POLL
>  	ep->busy_poll_usecs = 0;
>  	ep->busy_poll_budget = 0;
> -	ep->prefer_busy_poll = false;
> +	ep->napi_prefer_busy_poll = false;
>  #endif

Just FYI: This is going to conflict with a patch I've sent to VFS
that hasn't quite made its way back to net-next just yet.

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.misc&id=4eb76c5d9a8851735fd3ec5833ecf412e8921655

>  	ep->file = file;
>  	fd_install(fd, file);
> diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> index 4f4b948ef3811..3bc0f4eed976c 100644
> --- a/include/uapi/linux/eventpoll.h
> +++ b/include/uapi/linux/eventpoll.h
> @@ -89,9 +89,10 @@ struct epoll_params {
>  	__u32 busy_poll_usecs;
>  	__u16 busy_poll_budget;
>  	__u8 prefer_busy_poll;
> +	__u8 event_poll_only:1;
>  
>  	/* pad the struct to a multiple of 64bits */
> -	__u8 __pad;
> +	__u8 __pad:7;
>  };

If the above is accepted then a similar change should make its way
into glibc, uclibc-ng, and musl. It might be easier to add an
entirely new ioctl.

All the above said: I'm not sure I'm convinced yet and having more
clear data, descriptions, and answers on locality/syscall overhead
would be very helpful.

In the future, add 'net-next' to the subject line so that this
targets the right tree:
   [PATCH net-next] subject-line

- Joe

