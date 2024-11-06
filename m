Return-Path: <netdev+bounces-142450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1360C9BF39F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC26B242FC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916C20605D;
	Wed,  6 Nov 2024 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZciBo3XH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC0204090
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911930; cv=none; b=TXa/AlPAMIqJbctKLYSVJToZKrP7G2mHaTAvyNnSmOf8K80ZoNYdQJcjUr8M6p1/GZ8PbQJWiux07x9y4X9k0WNDgcWHvOGvSmv/5s3LCQx95FsqLgGT2Z/rmpdVIhJuS5+6bSmki5+mX6c/3njExeohvGNbXQnx0WwIbXBreIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911930; c=relaxed/simple;
	bh=wfvrJkIJkD7cWTPVa799siSRv93sTETpAX8Yan9sDLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVS6Gk8+msDKejI/RCFcfQ1s6ukTZayZNNkObPBlMeg2KcENsqgR7BAK9jekYQJCoIT3ol+olkvAw104wzqhqm9FHdn6psErsuw+P0dIYUXfJrLFcGrj4VjgsJQqDrOs5SQlYrXhTzB1P953JV0iWxXVMkjFSRjog88UuoV4+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZciBo3XH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720be27db74so31975b3a.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 08:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730911927; x=1731516727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpR2iS5Wz9a7Ed3Yf5S3sZhuiwomMm725Dc8wDLmQig=;
        b=ZciBo3XHU8KDEiiMj9vXfpu9GJ5m4ILrDzw/aA0jgQHZJZv5D1uXizKE08WSZpo1N6
         E55ZSQ0q05110C1yvWPacl+86VCz/i6jheAwmsME27TwUrTZzYeC6QRIUXNCUNZW6IsD
         wozl6CU9ch4CKMV4RpQxCgAvNxakeRZYMTDcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730911927; x=1731516727;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpR2iS5Wz9a7Ed3Yf5S3sZhuiwomMm725Dc8wDLmQig=;
        b=WQ/NTzlEvyl/ConmSSRmqjow31Kw8VUKgKYGxHdGEMU8nynq4SGTHnxMmbdUubfWu3
         IF1GfvTumpHl1LYjCkwhra/5r0NkDC7zwItJieLFbL74+GOXPwEtcMq2RyiB0ec6999p
         Bk+RmrvdPQRpLNCkR1qqU+MrejkofSZ5asZEouzYp0t6mb7JtYIjZqWDC/RCdFRnyP8x
         EkpZoi0v+lRT01A8wh6UfDnaVMrrhn9dnBblnjrC6uwCF9YPmxbMCGDAOckGzOebPrH+
         oOg1xeD070k5yeHcscoGJ/2uyo+Hn9Z4p4ZFbEt6Qju5NIXy6zW7FiessjY/kABrAPNG
         HrbA==
X-Gm-Message-State: AOJu0Yz37a96Ie4DL4Rkw9c2LCAywe8xZy+lwjUgRh6FsKDytROmxNMV
	v6nflXImwFZcZH8iBIEjZskJ/j6Rku2UoufZd0Q/ha+upMYWMPlFRbPKqcT6hao=
X-Google-Smtp-Source: AGHT+IEgJZtJt0MJdxpZzlMUWg+AcH31AbtTn853kLwglpscmOgiFFT8TpjbpgMdNu5hs36kUNmLfA==
X-Received: by 2002:a05:6a00:2da1:b0:720:3092:e75f with SMTP id d2e1a72fcca58-723f7aab6a0mr5333855b3a.8.1730911927432;
        Wed, 06 Nov 2024 08:52:07 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e591fsm11900829b3a.51.2024.11.06.08.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 08:52:06 -0800 (PST)
Date: Wed, 6 Nov 2024 08:52:00 -0800
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
Message-ID: <ZyuesOyJLI3U0C5e@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105210338.5364375d@kernel.org>

On Tue, Nov 05, 2024 at 09:03:38PM -0800, Jakub Kicinski wrote:
> On Mon,  4 Nov 2024 21:55:26 +0000 Joe Damato wrote:
> > From: Martin Karsten <mkarsten@uwaterloo.ca>
> > 
> > When NAPI_F_PREFER_BUSY_POLL is set during busy_poll_stop and the
> > irq_suspend_timeout is nonzero, this timeout is used to defer softirq
> > scheduling, potentially longer than gro_flush_timeout. This can be used
> > to effectively suspend softirq processing during the time it takes for
> > an application to process data and return to the next busy-poll.
> > 
> > The call to napi->poll in busy_poll_stop might lead to an invocation of
> 
> The call to napi->poll when we're arming the timer is counter
> productive, right? Maybe we can take this opportunity to add
> the seemingly missing logic to skip over it?

It seems like the call to napi->poll in busy_poll_stop is counter
productive and we're not opposed to making an optimization like that
in the future.

When we tried it, it triggered several bugs/system hangs, so we left
as much of the original code in place as possible.

The existing patch works and streamlining busy_poll_stop to skip the
call to napi->poll is an optimization that can be added as a later
series that focuses solely on when/where/how napi->poll is called.

Our focus was on:
  - Not breaking any of the existing mechanisms
  - Adding a new mechanism

I think we should avoid pulling the optimization you suggest into
this particular series and save that for the future.

> > napi_complete_done, but the prefer-busy flag is still set at that time,
> > so the same logic is used to defer softirq scheduling for
> > irq_suspend_timeout.
> > 
> > Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Co-developed-by: Joe Damato <jdamato@fastly.com>
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > ---
> >  v3:
> >    - Removed reference to non-existent sysfs parameter from commit
> >      message. No functional/code changes.
> > 
> >  net/core/dev.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 4d910872963f..51d88f758e2e 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6239,7 +6239,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
> >  			timeout = napi_get_gro_flush_timeout(n);
> >  		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
> >  	}
> > -	if (n->defer_hard_irqs_count > 0) {
> > +	if (napi_prefer_busy_poll(n)) {
> > +		timeout = napi_get_irq_suspend_timeout(n);
> 
> Why look at the suspend timeout in napi_complete_done()?
> We are unlikely to be exiting busy poll here.

The idea is similar to commit 7fd3253a7de6 ("net: Introduce
preferred busy-polling"); continue to defer IRQs as long as forward
progress is being made. In this case, napi->poll ran, called
napi_complete_done -- the system is moving forward with processing
so prevent IRQs from interrupting us.

epoll_wait will re-enable IRQs (by calling napi_schedule) if
there are no events ready for processing.

> Is it because we need more time than gro_flush_timeout
> for the application to take over the polling?

That's right; we want the application to retain control of packet
processing. That's why we connected this to the "prefer_busy_poll"
flag.

> > +		if (timeout)
> > +			ret = false;
> > +	}
> > +	if (ret && n->defer_hard_irqs_count > 0) {
> >  		n->defer_hard_irqs_count--;
> >  		timeout = napi_get_gro_flush_timeout(n);
> >  		if (timeout)
> > @@ -6375,9 +6380,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
> >  	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
> >  
> >  	if (flags & NAPI_F_PREFER_BUSY_POLL) {
> > -		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
> > -		timeout = napi_get_gro_flush_timeout(napi);
> > -		if (napi->defer_hard_irqs_count && timeout) {
> > +		timeout = napi_get_irq_suspend_timeout(napi);
> 
> Even here I'm not sure if we need to trigger suspend.
> I don't know the eventpoll code well but it seems like you suspend 
> and resume based on events when exiting epoll. Why also here?

There's two questions wrapped up here and an overall point to make:

1. Suspend and resume based on events when exiting epoll - that's
   right and as you'll see in those patches that happens by:
     - arming the suspend timer (via a call to napi_suspend_irqs)
       when a positive number of events are retrieved
     - calling napi_schedule (via napi_resume_irqs) when there are
       no events or the epoll context is being freed.

2. Why defer the suspend timer here in busy_poll_stop? Note that the
   original code would set the timer to gro_flush_timeout, which
   would introduce the trade offs we mention in the cover letter
   (latency for large values, IRQ interruption for small values).

   We don't want the gro_flush_timeout to take over yet because we
   want to avoid these tradeoffs up until the point where epoll_wait
   finds no events for processing.

   Does that make sense? If we skipped the IRQ suspend deferral
   here, we'd be giving packet processing control back to
   gro_flush_timeout and napi_defer_hard_irqs, but the system might
   still have packets that can be processed in the next call to
   epoll_wait.

The overall point to make is that: the suspend timer is used to
prevent misbehaving userland applications from taking too long. It's
essentially a backstop and, as long as the app is making forward
progress, allows the app to continue running its busy poll loop
undisturbed (via napi_complete_done preventing the driver from
enabling IRQs).

Does that make sense?

> > +		if (!timeout) {
> > +			napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
> > +			if (napi->defer_hard_irqs_count)
> > +				timeout = napi_get_gro_flush_timeout(napi);
> > +		}
> > +		if (timeout) {
> >  			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
> >  			skip_schedule = true;
> >  		}
> 

