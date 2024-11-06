Return-Path: <netdev+bounces-142565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398459BFA19
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0A5284026
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43618C03E;
	Wed,  6 Nov 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MltHYz4F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13789168BD;
	Wed,  6 Nov 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935863; cv=none; b=tkHSaYa5K5xFY3Gs0sGat9fuGScy+zuq+LrDsDklAQT1CDOWyJeEtqPG8UVnlt7nWYCZyM3uTNdLhe09amBHsa7gJlmYH8jGZgMrqVgBuShVqjicbRg3YUwn3u8zNgPLB3N5CfHSewNQbjVULKbzpV/M8TTLRQcJJxq9inC5+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935863; c=relaxed/simple;
	bh=YlHn3IaBW1Py7gcTSxAUYqxrtEK4X1eXvgIaOf2+2p8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAf8odR4kSovmJVlcK8kFl8Q3WdPz4J+EI5bNcG7C02GvL9PgyCHDhBZYl4xWSIMGdtUVDpSGJGRx8d+9zZSp6tKPxTVfsd5SWJN6dlGZOi7p5BYXURXyb0Q75oCrQzw4FuDdJichxbH8AsIyECFRyN4xnZnRA85vfONbGq1ru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MltHYz4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CB5C4CEC6;
	Wed,  6 Nov 2024 23:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730935862;
	bh=YlHn3IaBW1Py7gcTSxAUYqxrtEK4X1eXvgIaOf2+2p8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MltHYz4FvxSBSLBpfVo9l9ZNyLJjDoUexxOh/hSvqakooROZEmQxdTlqf/39QHRDQ
	 VGHbZuU7HNr4lhpTRFmXGErj0LZhFNjNNvuNCmibvve5dvkmfdM102NY2LALWoZz0V
	 xw6lS7Su6+WynJreRpbJ8FYsSmY1GH2oC+/RkqNxK53TANl379muNBfj5rNzLworFh
	 pLsiymcLZ7Kp2PuG+M8Awiq594aODIRyyE6no3gxK/ZlOWY89hMn3TzwExdr6lNjkZ
	 i+cPFKA4eSGZ11FPS4uaW/KVuCsZBRrk5HA89C11yxFO1dJWKYaRhMRMwEPS4e08lT
	 hBMzI4mb1oq9Q==
Date: Wed, 6 Nov 2024 15:31:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
 bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
 edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
 m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
 willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com,
 Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 2/7] net: Suspend softirq when
 prefer_busy_poll is set
Message-ID: <20241106153100.45fbe646@kernel.org>
In-Reply-To: <ZyuesOyJLI3U0C5e@LQ3V64L9R2>
References: <20241104215542.215919-1-jdamato@fastly.com>
	<20241104215542.215919-3-jdamato@fastly.com>
	<20241105210338.5364375d@kernel.org>
	<ZyuesOyJLI3U0C5e@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 08:52:00 -0800 Joe Damato wrote:
> On Tue, Nov 05, 2024 at 09:03:38PM -0800, Jakub Kicinski wrote:
> > On Mon,  4 Nov 2024 21:55:26 +0000 Joe Damato wrote:  
> > > From: Martin Karsten <mkarsten@uwaterloo.ca>
> > > 
> > > When NAPI_F_PREFER_BUSY_POLL is set during busy_poll_stop and the
> > > irq_suspend_timeout is nonzero, this timeout is used to defer softirq
> > > scheduling, potentially longer than gro_flush_timeout. This can be used
> > > to effectively suspend softirq processing during the time it takes for
> > > an application to process data and return to the next busy-poll.
> > > 
> > > The call to napi->poll in busy_poll_stop might lead to an invocation of  
> > 
> > The call to napi->poll when we're arming the timer is counter
> > productive, right? Maybe we can take this opportunity to add
> > the seemingly missing logic to skip over it?  
> 
> It seems like the call to napi->poll in busy_poll_stop is counter
> productive and we're not opposed to making an optimization like that
> in the future.
> 
> When we tried it, it triggered several bugs/system hangs, so we left
> as much of the original code in place as possible.

You don't happen to have the patch you used? Many ways to get the
skipping wrong.

> The existing patch works and streamlining busy_poll_stop to skip the
> call to napi->poll is an optimization that can be added as a later
> series that focuses solely on when/where/how napi->poll is called.

The reason I brought it up is that it rearms the timer, if driver 
ends up calling napi_complete_done(). So we arm the timer in
napi_poll_stop(), then call the driver which may rearm again, 
making the already complex code even harder to reason about.

> Our focus was on:
>   - Not breaking any of the existing mechanisms
>   - Adding a new mechanism
> 
> I think we should avoid pulling the optimization you suggest into
> this particular series and save that for the future.

I'm primarily worried about maintainability of this code.

> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 4d910872963f..51d88f758e2e 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6239,7 +6239,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
> > >  			timeout = napi_get_gro_flush_timeout(n);
> > >  		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
> > >  	}
> > > -	if (n->defer_hard_irqs_count > 0) {
> > > +	if (napi_prefer_busy_poll(n)) {
> > > +		timeout = napi_get_irq_suspend_timeout(n);  
> > 
> > Why look at the suspend timeout in napi_complete_done()?
> > We are unlikely to be exiting busy poll here.  
> 
> The idea is similar to commit 7fd3253a7de6 ("net: Introduce
> preferred busy-polling"); continue to defer IRQs as long as forward
> progress is being made. In this case, napi->poll ran, called
> napi_complete_done -- the system is moving forward with processing
> so prevent IRQs from interrupting us.

We should clarify the mental models. You're describing IRQ deferal,
but say prefer busy poll.

Prefer busy poll has only one function - if we are at 100% busy
and always see >= budget of packets on the ring, we never call
napi_complete_done(). Drivers don't call napi_complete_done() if they
consumed full budget. So we need a way to break that re-polling loop,
release the NAPI ownership and give busy poll a chance to claim the
NAPI instance ownership (the SCHED bit). We check for prefer
busy poll in __napi_poll(), because, again, in the target scenario
napi_complete_done() is never called.

The IRQ deferal mechanism is necessary for prefer busy poll to work,
but it's separate and used by some drivers without good IRQ coalescing,
no user space polling involved.

In your case, when machine is not melting under 100% load - prefer busy
poll will be set once or not at all.

> epoll_wait will re-enable IRQs (by calling napi_schedule) if
> there are no events ready for processing.

To be 100% precise calling napi_schedule will not reenable IRQs 
if IRQ deferal is active. It only guarantees one NAPI run in 
softirq (or thread if threaded).

> > Is it because we need more time than gro_flush_timeout
> > for the application to take over the polling?  
> 
> That's right; we want the application to retain control of packet
> processing. That's why we connected this to the "prefer_busy_poll"
> flag.
> 
> > > +		if (timeout)
> > > +			ret = false;
> > > +	}
> > > +	if (ret && n->defer_hard_irqs_count > 0) {
> > >  		n->defer_hard_irqs_count--;
> > >  		timeout = napi_get_gro_flush_timeout(n);
> > >  		if (timeout)
> > > @@ -6375,9 +6380,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
> > >  	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
> > >  
> > >  	if (flags & NAPI_F_PREFER_BUSY_POLL) {
> > > -		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
> > > -		timeout = napi_get_gro_flush_timeout(napi);
> > > -		if (napi->defer_hard_irqs_count && timeout) {
> > > +		timeout = napi_get_irq_suspend_timeout(napi);  
> > 
> > Even here I'm not sure if we need to trigger suspend.
> > I don't know the eventpoll code well but it seems like you suspend 
> > and resume based on events when exiting epoll. Why also here?  
> 
> There's two questions wrapped up here and an overall point to make:
> 
> 1. Suspend and resume based on events when exiting epoll - that's
>    right and as you'll see in those patches that happens by:
>      - arming the suspend timer (via a call to napi_suspend_irqs)
>        when a positive number of events are retrieved
>      - calling napi_schedule (via napi_resume_irqs) when there are
>        no events or the epoll context is being freed.
> 
> 2. Why defer the suspend timer here in busy_poll_stop? Note that the
>    original code would set the timer to gro_flush_timeout, which
>    would introduce the trade offs we mention in the cover letter
>    (latency for large values, IRQ interruption for small values).
> 
>    We don't want the gro_flush_timeout to take over yet because we
>    want to avoid these tradeoffs up until the point where epoll_wait
>    finds no events for processing.
> 
>    Does that make sense? If we skipped the IRQ suspend deferral
>    here, we'd be giving packet processing control back to
>    gro_flush_timeout and napi_defer_hard_irqs, but the system might
>    still have packets that can be processed in the next call to
>    epoll_wait.

Let me tell you what I think happens and then you can correct me.

0 epoll
1   # ..does its magic..
2   __napi_busy_loop() 
3     # finds a waking packet
4     busy_poll_stop()
5       # arms the timer for long suspend
6   # epoll sees events
7     ep_suspend_napi_irqs()
8       napi_suspend_irqs()
9         # arms for long timer again

The timer we arm here only has to survive from line 5 to line 9,
because we will override the timeout on line 9.

> The overall point to make is that: the suspend timer is used to
> prevent misbehaving userland applications from taking too long. It's
> essentially a backstop and, as long as the app is making forward
> progress, allows the app to continue running its busy poll loop
> undisturbed (via napi_complete_done preventing the driver from
> enabling IRQs).
> 
> Does that make sense?

My mental model put in yet another way is that only epoll knows if it
has events, and therefore whether the timeout should be short or long.
So the suspend timer should only be applied by epoll.

