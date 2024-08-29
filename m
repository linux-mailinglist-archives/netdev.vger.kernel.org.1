Return-Path: <netdev+bounces-123185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6034B963FAC
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F251C22F13
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F2918CC18;
	Thu, 29 Aug 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s5+59voF"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15AB14B075
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922992; cv=none; b=qawnQ9ds7PcMjNq9HchPqVdZIMVzTR+vzmYZPpJE8qAjHXz1P1WljO3O9S6NVlZHTskCkAGOS5QNxIQKSOruFMZPeFceNivXYwD88MZouHBZ4BWFB4CCYtUeV27SwS8wJWl2mBzudz6RuvlK4s5PQsDfXXipBjHQKiZ7rOUZUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922992; c=relaxed/simple;
	bh=WPrVwuty4BPa6p9mEHIR0PaWDPFbGQKLmCggXhFxPkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXA61wT6J93Nzx5jIoFibRj/+bvCNHCVIkiL+Ar8NM5h5v5xOoM7UNFidTsLWwsn8KNQGrnyubh9Jwt+D2OeCrlqWTQXbFNMMK7NNj0bZj9AQ2xIHsPBOSXRB6hH+vPR2WH2mT1RjeMh66bO1VrDV90ZgnYdQFh3MJbB5P6mcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s5+59voF; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <939877af-d726-421e-af71-ccf4b2ec33ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724922986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfAceVyfYMvpGPfpOzZ0gGILHs9xQf3lHbqa/aSXEZE=;
	b=s5+59voFYFpQOfSg9X9HSvlLYrOcBULonyLEBVsb9u90kspJRMAs5pv29Vx8v+OkypfrS2
	mN6+0Mczctc7yxTqV66y3lA/4Y8KKgrUtTsxciKspYvqI6jiOpOLvJEHvNTLPPRoJe6xnB
	0++cCrfVBKg3ehmtn24wBFs088cnOgs=
Date: Thu, 29 Aug 2024 10:16:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Add provision to busyloop for events in ep_poll.
To: Naman Gulati <namangulati@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org
Cc: Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 skhawaja@google.com, Joe Damato <jdamato@fastly.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240828181011.1591242-1-namangulati@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240828181011.1591242-1-namangulati@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2024 19:10, Naman Gulati wrote:
> NAPI busypolling in ep_busy_loop loops on napi_poll and checks for new
> epoll events after every napi poll. Checking just for epoll events in a
> tight loop in the kernel context delivers latency gains to applications
> that are not interested in napi busypolling with epoll.
> 
> This patch adds an option to loop just for new events inside
> ep_busy_loop, guarded by the EPIOCSPARAMS ioctl that controls epoll napi
> busypolling.
> 
> A comparison with neper tcp_rr shows that busylooping for events in
> epoll_wait boosted throughput by ~3-7% and reduced median latency by
> ~10%.
> 
> To demonstrate the latency and throughput improvements, a comparison was
> made of neper tcp_rr running with:
>      1. (baseline) No busylooping
>      2. (epoll busylooping) enabling the epoll busy looping on all epoll
>      fd's
>      3. (userspace busylooping) looping on epoll_wait in userspace
>      with timeout=0
> 
> Stats for two machines with 100Gbps NICs running tcp_rr with 5 threads
> and varying flows:
> 
> Type                Flows   Throughput             Latency (μs)
>                               (B/s)      P50   P90    P99   P99.9   P99.99
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
>   fs/eventpoll.c                 | 53 ++++++++++++++++++++++++++--------
>   include/uapi/linux/eventpoll.h |  3 +-
>   2 files changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index f53ca4f7fcedd..6cba79261817a 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -232,7 +232,10 @@ struct eventpoll {
>   	u32 busy_poll_usecs;
>   	/* busy poll packet budget */
>   	u16 busy_poll_budget;
> -	bool prefer_busy_poll;
> +	/* prefer to busypoll in napi poll */
> +	bool napi_prefer_busy_poll;
> +	/* avoid napi poll when busy looping and poll only for events */
> +	bool event_poll_only;
>   #endif
>   
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
> @@ -430,6 +433,24 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
>   	return ep_events_available(ep) || busy_loop_ep_timeout(start_time, ep);
>   }
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
>   /*
>    * Busy poll if globally on and supporting sockets found && no events,
>    * busy loop will return if need_resched or ep_events_available.
> @@ -440,23 +461,29 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
>   {
>   	unsigned int napi_id = READ_ONCE(ep->napi_id);
>   	u16 budget = READ_ONCE(ep->busy_poll_budget);
> -	bool prefer_busy_poll = READ_ONCE(ep->prefer_busy_poll);
> +	bool event_poll_only = READ_ONCE(ep->event_poll_only);
>   
>   	if (!budget)
>   		budget = BUSY_POLL_BUDGET;
>   
> -	if (napi_id >= MIN_NAPI_ID && ep_busy_loop_on(ep)) {
> +	if (!ep_busy_loop_on(ep))
> +		return false;
> +
> +	if (event_poll_only) {
> +		return ep_event_busy_loop(ep);
> +	} else if (napi_id >= MIN_NAPI_ID) {

There is no need to use 'else if' in this place, in case of
event_poll_only == true the program flow will not reach this part.

> +		bool napi_prefer_busy_poll = READ_ONCE(ep->napi_prefer_busy_poll);
> +
>   		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end,
> -			       ep, prefer_busy_poll, budget);
> +				ep, napi_prefer_busy_poll, budget);
>   		if (ep_events_available(ep))
>   			return true;
>   		/*
> -		 * Busy poll timed out.  Drop NAPI ID for now, we can add
> -		 * it back in when we have moved a socket with a valid NAPI
> -		 * ID onto the ready list.
> -		 */
> +		* Busy poll timed out.  Drop NAPI ID for now, we can add
> +		* it back in when we have moved a socket with a valid NAPI
> +		* ID onto the ready list.
> +		*/

I believe this change is accidental, right?

>   		ep->napi_id = 0;
> -		return false;
>   	}
>   	return false;
>   }

[...]


