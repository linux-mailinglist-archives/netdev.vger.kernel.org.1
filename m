Return-Path: <netdev+bounces-89729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3630A8AB588
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 21:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA19B214BC
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 19:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357F213C825;
	Fri, 19 Apr 2024 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIeHq+Th"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F313C679
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554530; cv=none; b=i9aQ7/eqA+KrPX92fjwRQmPOI+thfEZNRKhTb87HqCvDp4fB4Bl0rRDGVinxWtanWukIMeDSYp+O0TwUUCuoe5S1rF6Gqd12YAaRN18ctJcy90G2qIMWGk7sGpPyuCo60bpPA5NebkohfwG7A+d2b7SLVf1Z4btEHZ7/C61Cp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554530; c=relaxed/simple;
	bh=0Yf1np1EiQRR1H+HojMtCteZkzQwyIMTFpovj1tcuSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kun5Tl4SDTzcxYx0iyNJZOM/CR5O3k5D+ljlLbS7X/CdxnFJKYuvzQq7douQR8IN28KLxsO/x4GTDetvFi+VSppgkrIwhRnmg4Em07CaDh3XdE64sn3orcLiQ1qAcMtjmhi/S/vhUmnohvUUnU8VRLawq1/1cJeqkzK184rR4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIeHq+Th; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a554afec54eso245751866b.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713554527; x=1714159327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cgxiaek1OC/UQSjtnluTE8oS+OxORZPByii8n2kRyX4=;
        b=zIeHq+Thn7YTr3RpZM3b+1yEJ5ovU/PQYkZPXZhio6P7bZctZbZiLGj24cRFIg5oFw
         kHsShSdrttqbvrsThk6/whQjz0PlCcUfi9PAf4QKVU5oX7NvZzjZaBMMDyrPYI9GHora
         hI3hMxb4Xu1V3yVOfG25Gh/oSvOu8DBaJD58mNQty4nZZrLQpNnEVabb3PHEhYmbTzGA
         lgOgUcUOb23NYEb7jAsI7wlpy/mr3hoJP9nOjpr1l7996mNf12bdNAiZCMNj5bHB4ACG
         eqCJxOZKZ8nwG30IxCBu7PLmFtG7SkTk/KB2EkG/EC5tdC+3LWFoAcNftt/ysDAJgcOt
         TXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713554527; x=1714159327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cgxiaek1OC/UQSjtnluTE8oS+OxORZPByii8n2kRyX4=;
        b=kYGNzCkiLzccF+1iVaQpt+i08RBJ+1unspgHuDxVCultYaza/+Q3o4Ae55mooXztvP
         g9tz4tQOFc4XAbJE//UtWEVzIQk8WMP9UzGYTDQuxh6eoYFogDXQD2B9cAdHmiAPzgFO
         spHliPKTVNuTdCzL1weylxYGtUeqVW9CICvmBukQ9RxKIa/iAOnw9qw6AZWvO9p2oh6G
         E6XKXYtkvxSccaWIXivcN5SnnZ6Bdc7ip3e/jymsZlBmCKTLV6D91AT13z6j4N1Yjd09
         OD1tsXauT0a0qXnADlw39k/HMeJI52iHee4GaG8q8yz/w06alnB4n9HOM7kEYIjgvKEV
         2+Og==
X-Forwarded-Encrypted: i=1; AJvYcCWCn1y2dQ5lqSjLqyVgn7qdI3QvXyb/FyY60zPDqTEKXcvunCkS6oqpgP2AcDpMHIfskhR/FYzL6EwaUGUpOndZSQ1D4cOJ
X-Gm-Message-State: AOJu0YxSreg8OS1lkHWSxiJ6SYADsaB0xfe0jqG1QLb2c/yzBY34xT0r
	3+mNzPq6mRyYQ/fqRsPji+lotaR4ZKz2zjQ5UPqsFi9ebZxiHhQceB8uIRvcageho1hHu6Fftjm
	qX0XEfQ81KpMRjdB6KaA3qQCxP7u8TxUe1z5z
X-Google-Smtp-Source: AGHT+IEBjBNkvxdmuTE9VnI6C88nKhqq8KjzGCHHIFj/6VLY3xCFjTvSpOxoFw/tjaW8RUkr6IZWX3lHaV1KlXwC0BQ=
X-Received: by 2002:a17:906:f255:b0:a52:2284:d97f with SMTP id
 gy21-20020a170906f25500b00a522284d97fmr2030488ejb.25.1713554526552; Fri, 19
 Apr 2024 12:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328989335.3930751.3091577850420501533.stgit@firesoul> <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
 <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org> <lxzi557wfbrkrj6phdlub4nmtulzbegykbmroextadvssdyfhe@qarxog72lheh>
 <CAJD7tkYJZgWOeFuTMYNoyH=9+uX2qaRdwc4cNuFN9wdhneuHfA@mail.gmail.com>
 <6392f7e8-d14c-40f4-8a19-110dfffb9707@kernel.org> <gckdqiczjtyd5qdod6a7uyaxppbglg3fkgx2pideuscsyhdrmy@by6rlly6crmz>
In-Reply-To: <gckdqiczjtyd5qdod6a7uyaxppbglg3fkgx2pideuscsyhdrmy@by6rlly6crmz>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Apr 2024 12:21:30 -0700
Message-ID: <CAJD7tkbCzx1S9d0oK-wR7AY3O3ToBrEwKTaYTykE1WwczcYLBg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to mutex
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, longman@redhat.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> > > Perhaps we could experiment with always dropping the lock at CPU
> > > boundaries instead?
> > >
> >
> > I don't think this will be enough (always dropping the lock at CPU
> > boundaries).  My measured "lock-hold" times that is blocking IRQ (and
> > softirq) for too long.  When looking at prod with my new cgroup
> > tracepoint script[2]. When contention occurs, I see many Yields
> > happening and with same magnitude as Contended. But still see events
> > with long "lock-hold" times, even-though yields are high.
> >
> >  [2] https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt
> >
> > Example output:
> >
> >  12:46:56 High Lock-contention: wait: 739 usec (0 ms) on CPU:56 comm:kswapd7
> >  12:46:56 Long lock-hold time: 6381 usec (6 ms) on CPU:27 comm:kswapd3
> >  12:46:56 Long lock-hold time: 18905 usec (18 ms) on CPU:100
> > comm:kworker/u261:12
> >
> >  12:46:56  time elapsed: 36 sec (interval = 1 sec)
> >   Flushes(2051) 15/interval (avg 56/sec)
> >   Locks(44464) 1340/interval (avg 1235/sec)
> >   Yields(42413) 1325/interval (avg 1178/sec)
> >   Contended(42112) 1322/interval (avg 1169/sec)
> >
> > There is reported 15 flushes/sec, but locks are yielded quickly.
> >
> > More problematically (for softirq latency) we see a Long lock-hold time
> > reaching 18 ms.  For network RX softirq I need lower than 0.5ms latency,
> > to avoid RX-ring HW queue overflows.

Here we are measuring yields against contention, but the main problem
here is IRQ serving latency, which doesn't have to correlate with
contention, right?

Perhaps contention is causing us to yield the lock every nth cpu
boundary, but apparently this is not enough for IRQ serving latency.
Dropping the lock on each boundary should improve IRQ serving latency,
regardless of the presence of contention.

Let's focus on one problem at a time ;)

> >
> >
> > --Jesper
> > p.s. I'm seeing a pattern with kswapdN contending on this lock.
> >
> > @stack[697, kswapd3]:
> >         __cgroup_rstat_lock+107
> >         __cgroup_rstat_lock+107
> >         cgroup_rstat_flush_locked+851
> >         cgroup_rstat_flush+35
> >         shrink_node+226
> >         balance_pgdat+807
> >         kswapd+521
> >         kthread+228
> >         ret_from_fork+48
> >         ret_from_fork_asm+27
> >
> > @stack[698, kswapd4]:
> >         __cgroup_rstat_lock+107
> >         __cgroup_rstat_lock+107
> >         cgroup_rstat_flush_locked+851
> >         cgroup_rstat_flush+35
> >         shrink_node+226
> >         balance_pgdat+807
> >         kswapd+521
> >         kthread+228
> >         ret_from_fork+48
> >         ret_from_fork_asm+27
> >
> > @stack[699, kswapd5]:
> >         __cgroup_rstat_lock+107
> >         __cgroup_rstat_lock+107
> >         cgroup_rstat_flush_locked+851
> >         cgroup_rstat_flush+35
> >         shrink_node+226
> >         balance_pgdat+807
> >         kswapd+521
> >         kthread+228
> >         ret_from_fork+48
> >         ret_from_fork_asm+27
> >
>
> Can you simply replace mem_cgroup_flush_stats() in
> prepare_scan_control() with the ratelimited version and see if the issue
> still persists for your production traffic?

With thresholding, the fact that we reach cgroup_rstat_flush() means
that there is a high magnitude of pending updates. I think Jesper
mentioned 128 CPUs before, that means 128 * 64 (MEMCG_CHARGE_BATCH)
page-sized updates. That could be over 33 MBs with 4K page size.

I am not sure if it's fine to ignore such updates in shrink_node(),
especially that it is called in a loop sometimes so I imagine we may
want to see what changed after the last iteration.

>
> Also were you able to get which specific stats are getting the most
> updates?

This, on the other hand, would be very interesting. I think it is very
possible that we don't actually have 33 MBs of updates, but rather we
keep adding and subtracting from the same stat until we reach the
threshold. This could especially be true for hot stats like slab
allocations.

