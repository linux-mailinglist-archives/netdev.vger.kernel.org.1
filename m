Return-Path: <netdev+bounces-142635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A359D9BFCF3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3446D1F22AE8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A8F78C6D;
	Thu,  7 Nov 2024 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lpe2Uvtw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A718E25
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730949880; cv=none; b=pG5tJD+yJFCfOjQQbYMhXQJlMJx65ahw9HwVy3UkOMr1oq35uN4Tb7MgcrStV3BPVHi8ykt5m3lVqAKZO+Tj+HUnxPb8cykF6mNbGtkCYcrZzLZd1ZGk+qiqvwbmzzxwG7LCDmqCEd9ixV6NjLuKzaWgmjXcx9fqzNjKaSTGwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730949880; c=relaxed/simple;
	bh=5LvJBHy1IjoGH1Q1S9hwUlDnCoNksFoXGeklM7/w/h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAgVAgF8Lc4ul1WpqKzcunzkPavhtACkjivglbXNbSu9iwSyYi9ObeorNAlPoEWtuTOYWJ8DZcI/JrMJftSthwKMUSgoN0xc+qYTKGOh166HaoI0W/xh2IKbyCW5nVduvGOdk9LJ1X1c9w7Eiw+BGGOR2Apc1V3FCI6Y63JXbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lpe2Uvtw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e31af47681so392756a91.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 19:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730949878; x=1731554678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02OLQ9buslZ+/5j/tvhqeNeu0y+vKi9is2pBdh5g8cQ=;
        b=lpe2Uvtwf4QAWlKfOIJfHDVevOmyt+7zBfGtNMwwxmcTVS4uQFmkn9h0P1smo7n6Im
         bIHGx7ZDv1T+Izi4gppV+0dNxHnJymH1rAsMqrS1gF9EFjcCNaLGZAFAAM+qu7P0ai/s
         yGwlTAUf8eMCI3PQEZGaI+zh3v4N/zCbsr1RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730949878; x=1731554678;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02OLQ9buslZ+/5j/tvhqeNeu0y+vKi9is2pBdh5g8cQ=;
        b=GUTIlEJARUijtR7VlDchNMpjy4mJWnnN/M9sEL5IUf7P5ROeUzvGF6/6a6rEhTyc8i
         EKJ8kMFjcBbug1zzFvAyZtRIRU2Fekl3Uizj9PfdgU/hRxZxSbTlD/dbeSZiSc2vKE2a
         RdQ/9077/mqJYgk6Luf+uzaqCitPNyUCngIrJf2y3NBwu5Rr41+7J/lteWB/cvJWe1Cz
         qP6+00sqZFkQ/jKP2EkPQiHMjm5Qwvz8Nw76awsgrEHK2dD9HCA4Ln+GnwVpIPlPKSk3
         i7C6h87y3YE6vzyZLkMdiwzMjqN4o7RY2truXmYbtHmq+idD4OI05J2grWjWdiclTl69
         87QQ==
X-Gm-Message-State: AOJu0YzfHMXftqSg5oYujvREcjV9ae3OJsgaOwRq0SxuOlIxZaq6d9aX
	96LykZtwGxpuptDViKjwF1LFhfBNg4OO+IpW142727FNZg40nU/lLH3GDkRDGSE=
X-Google-Smtp-Source: AGHT+IEf44o2XVLBvLYU0plZyPHGNow5aemrgjErbXpZzq7sSmWHMjHj0H5PvDyJStwFZ/t7LEuB9A==
X-Received: by 2002:a17:90b:1a8c:b0:2e2:e8fc:e0dd with SMTP id 98e67ed59e1d1-2e9a766f188mr387997a91.35.1730949877578;
        Wed, 06 Nov 2024 19:24:37 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm345178a91.5.2024.11.06.19.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 19:24:35 -0800 (PST)
Date: Wed, 6 Nov 2024 19:24:32 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 2/7] net: Suspend softirq when
 prefer_busy_poll is set
Message-ID: <Zywy8PQDljS5r_rX@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	corbet@lwn.net, hdanton@sina.com, bagasdotme@gmail.com,
	pabeni@redhat.com, namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241104215542.215919-1-jdamato@fastly.com>
 <20241104215542.215919-3-jdamato@fastly.com>
 <20241105210338.5364375d@kernel.org>
 <ZyuesOyJLI3U0C5e@LQ3V64L9R2>
 <20241106153100.45fbe646@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106153100.45fbe646@kernel.org>

On Wed, Nov 06, 2024 at 03:31:00PM -0800, Jakub Kicinski wrote:
> On Wed, 6 Nov 2024 08:52:00 -0800 Joe Damato wrote:
> > On Tue, Nov 05, 2024 at 09:03:38PM -0800, Jakub Kicinski wrote:
> > > On Mon,  4 Nov 2024 21:55:26 +0000 Joe Damato wrote:  
> > > > From: Martin Karsten <mkarsten@uwaterloo.ca>
> > > > 
> > > > When NAPI_F_PREFER_BUSY_POLL is set during busy_poll_stop and the
> > > > irq_suspend_timeout is nonzero, this timeout is used to defer softirq
> > > > scheduling, potentially longer than gro_flush_timeout. This can be used
> > > > to effectively suspend softirq processing during the time it takes for
> > > > an application to process data and return to the next busy-poll.
> > > > 
> > > > The call to napi->poll in busy_poll_stop might lead to an invocation of  
> > > 
> > > The call to napi->poll when we're arming the timer is counter
> > > productive, right? Maybe we can take this opportunity to add
> > > the seemingly missing logic to skip over it?  
> > 
> > It seems like the call to napi->poll in busy_poll_stop is counter
> > productive and we're not opposed to making an optimization like that
> > in the future.
> > 
> > When we tried it, it triggered several bugs/system hangs, so we left
> > as much of the original code in place as possible.
> 
> You don't happen to have the patch you used? Many ways to get the
> skipping wrong.

Please see below; I think we've found a solution.
 
> > The existing patch works and streamlining busy_poll_stop to skip the
> > call to napi->poll is an optimization that can be added as a later
> > series that focuses solely on when/where/how napi->poll is called.
> 
> The reason I brought it up is that it rearms the timer, if driver 
> ends up calling napi_complete_done(). So we arm the timer in
> napi_poll_stop(), then call the driver which may rearm again, 
> making the already complex code even harder to reason about.

Agreed that the timer is unnecessarily re-armed twice.

Martin ran some initial tests of this series but with this patch
(patch 2) dropped and the initial results from a small number of
runs seem fine.

In other words: I think we can simply drop this patch entirely,
re-run our tests to regenerate the data, update the documentation,
and send a v7.

But please continue reading below.

> > Our focus was on:
> >   - Not breaking any of the existing mechanisms
> >   - Adding a new mechanism
> > 
> > I think we should avoid pulling the optimization you suggest into
> > this particular series and save that for the future.
> 
> I'm primarily worried about maintainability of this code.

Of course and we're open to figuring out how to help with that.

> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index 4d910872963f..51d88f758e2e 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -6239,7 +6239,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
> > > >  			timeout = napi_get_gro_flush_timeout(n);
> > > >  		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
> > > >  	}
> > > > -	if (n->defer_hard_irqs_count > 0) {
> > > > +	if (napi_prefer_busy_poll(n)) {
> > > > +		timeout = napi_get_irq_suspend_timeout(n);  
> > > 
> > > Why look at the suspend timeout in napi_complete_done()?
> > > We are unlikely to be exiting busy poll here.  
> > 
> > The idea is similar to commit 7fd3253a7de6 ("net: Introduce
> > preferred busy-polling"); continue to defer IRQs as long as forward
> > progress is being made. In this case, napi->poll ran, called
> > napi_complete_done -- the system is moving forward with processing
> > so prevent IRQs from interrupting us.
> 
> We should clarify the mental models. You're describing IRQ deferal,
> but say prefer busy poll.

OK; we're open to using different language if that would be helpful.

> Prefer busy poll has only one function - if we are at 100% busy
> and always see >= budget of packets on the ring, we never call
> napi_complete_done(). Drivers don't call napi_complete_done() if they
> consumed full budget. So we need a way to break that re-polling loop,
> release the NAPI ownership and give busy poll a chance to claim the
> NAPI instance ownership (the SCHED bit). We check for prefer
> busy poll in __napi_poll(), because, again, in the target scenario
> napi_complete_done() is never called.
> 
> The IRQ deferal mechanism is necessary for prefer busy poll to work,
> but it's separate and used by some drivers without good IRQ coalescing,
> no user space polling involved.

Sure, we agree and are on the same page on the above about what
prefer busy poll is and its interaction with IRQ deferral.

> In your case, when machine is not melting under 100% load - prefer busy
> poll will be set once or not at all.

I am not sure what you mean by that last sentence, because the
prefer busy poll flag is set by the application?

Similar to prefer busy poll piggybacking on IRQ deferral, we
piggyback on prefer busy polling by allowing the application to use
an even larger timeout while it is processing incoming data, i.e.,
deferring IRQs for a longer period, but only after a successful busy
poll. This makes prefer busy poll + irq suspend useful when
utilization is below 100%.

> > epoll_wait will re-enable IRQs (by calling napi_schedule) if
> > there are no events ready for processing.
> 
> To be 100% precise calling napi_schedule will not reenable IRQs 
> if IRQ deferal is active. It only guarantees one NAPI run in 
> softirq (or thread if threaded).

Yes, I should have been more precise.

Calling napi_schedule doesn't enable IRQs, but runs NAPI which sets
about the process of *eventually* causing napi_complete_done to
return true which triggers the re-arming of IRQs by the driver.

> > > Is it because we need more time than gro_flush_timeout
> > > for the application to take over the polling?  
> > 
> > That's right; we want the application to retain control of packet
> > processing. That's why we connected this to the "prefer_busy_poll"
> > flag.
> > 
> > > > +		if (timeout)
> > > > +			ret = false;
> > > > +	}
> > > > +	if (ret && n->defer_hard_irqs_count > 0) {
> > > >  		n->defer_hard_irqs_count--;
> > > >  		timeout = napi_get_gro_flush_timeout(n);
> > > >  		if (timeout)
> > > > @@ -6375,9 +6380,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
> > > >  	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
> > > >  
> > > >  	if (flags & NAPI_F_PREFER_BUSY_POLL) {
> > > > -		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
> > > > -		timeout = napi_get_gro_flush_timeout(napi);
> > > > -		if (napi->defer_hard_irqs_count && timeout) {
> > > > +		timeout = napi_get_irq_suspend_timeout(napi);  
> > > 
> > > Even here I'm not sure if we need to trigger suspend.
> > > I don't know the eventpoll code well but it seems like you suspend 
> > > and resume based on events when exiting epoll. Why also here?  
> > 
> > There's two questions wrapped up here and an overall point to make:
> > 
> > 1. Suspend and resume based on events when exiting epoll - that's
> >    right and as you'll see in those patches that happens by:
> >      - arming the suspend timer (via a call to napi_suspend_irqs)
> >        when a positive number of events are retrieved
> >      - calling napi_schedule (via napi_resume_irqs) when there are
> >        no events or the epoll context is being freed.
> > 
> > 2. Why defer the suspend timer here in busy_poll_stop? Note that the
> >    original code would set the timer to gro_flush_timeout, which
> >    would introduce the trade offs we mention in the cover letter
> >    (latency for large values, IRQ interruption for small values).
> > 
> >    We don't want the gro_flush_timeout to take over yet because we
> >    want to avoid these tradeoffs up until the point where epoll_wait
> >    finds no events for processing.
> > 
> >    Does that make sense? If we skipped the IRQ suspend deferral
> >    here, we'd be giving packet processing control back to
> >    gro_flush_timeout and napi_defer_hard_irqs, but the system might
> >    still have packets that can be processed in the next call to
> >    epoll_wait.
> 
> Let me tell you what I think happens and then you can correct me.
> 
> 0 epoll
> 1   # ..does its magic..
> 2   __napi_busy_loop() 
> 3     # finds a waking packet
> 4     busy_poll_stop()
> 5       # arms the timer for long suspend
> 6   # epoll sees events
> 7     ep_suspend_napi_irqs()
> 8       napi_suspend_irqs()
> 9         # arms for long timer again
> 
> The timer we arm here only has to survive from line 5 to line 9,
> because we will override the timeout on line 9.

Yes, you are right. Thanks for highlighting and catching this.

> > The overall point to make is that: the suspend timer is used to
> > prevent misbehaving userland applications from taking too long. It's
> > essentially a backstop and, as long as the app is making forward
> > progress, allows the app to continue running its busy poll loop
> > undisturbed (via napi_complete_done preventing the driver from
> > enabling IRQs).
> > 
> > Does that make sense?
> 
> My mental model put in yet another way is that only epoll knows if it
> has events, and therefore whether the timeout should be short or long.
> So the suspend timer should only be applied by epoll.

Here's what we are thinking, can you let me know if you agree with
this?

  - We can drop patch 2 entirely
  - Update the documentation about IRQ suspension as needed now
    that patch 2 has been dropped
  - Leave the rest of the series as is
  - Re-run our tests to gather sufficient data for the test cases
    outlined in the cover letter to ensure that the performance
    numbers hold over several iterations

Does that seem reasonable for the v7 to you?

I am asking because generating the amount of data over the number of
scenarios we are testing takes a long time and I want to make sure
we are as aligned as we can be before I kick off another run :)

