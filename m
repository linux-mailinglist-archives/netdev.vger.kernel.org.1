Return-Path: <netdev+bounces-155602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF337A03256
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F060C7A0489
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB191DF984;
	Mon,  6 Jan 2025 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="fDiE1Npa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EDF1DE4EB
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200471; cv=none; b=lTDLSenBnndvlZwdgSyRr8V66QAVmeP7k5iCPkwQHqrhnyiQslwg5MP8p8YRQlR1MXrNcAS2bccgoyTtNUSByY2esZbpYnxIis5HHcsHQnzNRnNg40Dwoxi1f8KhyNngPxC3IXbH64Cayx+Pk/kRiAuz0N1IuBdnhSJby6PmPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200471; c=relaxed/simple;
	bh=nM6HMfZO9oOrnxHruHfEgJ5NCsG3NGWp9hE0HFPtInw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwm1oDCWGbCXfKNLf2jRrEY/upPFGgJvhA6HPZ5TimbP9YvaMViX4aJO3aPeRjFKvRABA/cPyf77LI8YjAuSENjsdMdouNyaGQ+tVRSPS4xMfqO+jmg1e3/rW/FmvpnLyOdGeob+3RnFsGCg3+MBk2wrgxJ6WOhqw5hNcDqrEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=fDiE1Npa; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+6qLutr/S3PlqjyN0MSRfd0GMUbW88wayTw34CHLCTM=; t=1736200470; x=1737064470; 
	b=fDiE1Npa8MGWWPfyANjajplVHn1iM8XyjcYwCCvlohCqHs0RR14ZebjSO1uygVwEhcQsg/OSA+S
	q9CUDwaczqmC6i74ZHT3VW5yJT3al92Z9NdiGgJHgOaXl1YchzkDv6TQ61Cu0dzBJj903/Tuzh94i
	UX8VbN+LHU44PusIcWhDpBJ2pUfZMBTHC1R+q/S0GHG2OfJA2GlEJuxmsHEgarUmLWo2mx7Qwmu/g
	SY0IuJFyz9KRcxme/ikhscU4MhhaXjhhWL+zkssrFgEaG4QhgN9SOrDIcwfwDY+HVE9LXovcTkfON
	XxOrG/ETAPLff1jy+6tlS441Vqap/2gAMPug==;
Received: from mail-oa1-f51.google.com ([209.85.160.51]:44431)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tUv3N-0005XE-4E
	for netdev@vger.kernel.org; Mon, 06 Jan 2025 13:54:29 -0800
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29645a83b1bso7464246fac.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 13:54:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeTyqFgqafEB00W5fYS4Crx0NPmDYF6ANmfPXsiR+geJNcWQNnJ2u+N0em3GvE/O8cdcWTgR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGTuTPv5dF7sLxo19zXj4F9jWLrdZ9yAO5rsYg358ebsbgucR
	HnLhznGSET76cAubo6VPrpiUAPTcEgliaIoDD9Ni4RXWWTGkYWjnJWVERRjPCWiSR+Z2rwUrtjx
	jrL8wCeGQXlEo5WUXxHG/lQ4aLDQ=
X-Google-Smtp-Source: AGHT+IGh6bvpBPsLWhTGv8i7jK5ROcZoYQqEc7qiX09aYWnIpyp2LneZjVzqx3huz2z2HbRsfZHDFCaDi1WjTID5FD4=
X-Received: by 2002:a05:6870:b607:b0:29e:5ffa:b769 with SMTP id
 586e51a60fabf-2a7fb4bd121mr33137901fac.29.1736200468590; Mon, 06 Jan 2025
 13:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217000626.2958-13-ouster@cs.stanford.edu>
 <202412251044.574ee2c0-lkp@intel.com> <CAGXJAmzUZLKZj_7M63r2NXHV41_zf7aUH-b9LtAQOMgcheVUrQ@mail.gmail.com>
 <de0a7ef1-c2d0-4db4-8267-9d5ac96f0e23@lunn.ch>
In-Reply-To: <de0a7ef1-c2d0-4db4-8267-9d5ac96f0e23@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 6 Jan 2025 13:53:51 -0800
X-Gmail-Original-Message-ID: <CAGXJAmyufo2j2zbooDM5uqrFSkkH-SDoJicq=K=SYDJAoZzeDw@mail.gmail.com>
Message-ID: <CAGXJAmyufo2j2zbooDM5uqrFSkkH-SDoJicq=K=SYDJAoZzeDw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 12/12] net: homa: create Makefile and Kconfig
To: Andrew Lunn <andrew@lunn.ch>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: f824399eb00b5943f8bdbe5dd24fccda

On Mon, Jan 6, 2025 at 11:09=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Jan 06, 2025 at 09:27:24AM -0800, John Ousterhout wrote:
> > I have pored over this message for a while and can't figure out how
> > Homa code could participate in this deadlock, other than by calling
> > hrtimer_init (which is done without holding any locks). If anyone else
> > can figure out exactly what this message means and how it relates to
> > Homa, I'd love to hear it. Otherwise I'm going to assume it's either a
> > false positive or a problem elsewhere in the Linux kernel.
>
> The problem with ignoring these splats is that after the first splat,
> you don't get any more. So if Homa does have a real deadlock, you
> might never get it reported, you just deadlock.
>
> Have you reproduced this?

If there is actually a problem, I'd definitely like to fix it.
However, I have not been able to reproduce this.

> > > [   11.585197][  T133] -> #0 ((console_sem).lock){-...}-{2:2}:
> > > [ 11.585197][ T133] check_prev_add (kernel/locking/lockdep.c:3162)
> > > [ 11.585197][ T133] validate_chain (kernel/locking/lockdep.c:3281 ker=
nel/locking/lockdep.c:3904)
> > > [ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
> > > [ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel=
/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
> > > [ 11.585197][ T133] _raw_spin_lock_irqsave (include/linux/spinlock_ap=
i_smp.h:111 kernel/locking/spinlock.c:162)
> > > [ 11.585197][ T133] down_trylock (kernel/locking/semaphore.c:140)
> > > [ 11.585197][ T133] __down_trylock_console_sem (kernel/printk/printk.=
c:326)
> > > [ 11.585197][ T133] console_trylock_spinning (kernel/printk/printk.c:=
2852 kernel/printk/printk.c:2009)
> > > [ 11.585197][ T133] vprintk_emit (kernel/printk/printk.c:2431 kernel/=
printk/printk.c:2378)
> > > [ 11.585197][ T133] vprintk (kernel/printk/printk_safe.c:86)
> > > [ 11.585197][ T133] _printk (kernel/printk/printk.c:2452)
> > > [ 11.585197][ T133] lookup_object_or_alloc+0x3d4/0x590
> > > [ 11.585197][ T133] __debug_object_init (lib/debugobjects.c:744)
> > > [ 11.585197][ T133] hrtimer_init (kernel/time/hrtimer.c:456 kernel/ti=
me/hrtimer.c:1606)
> > > [ 11.585197][ T133] homa_timer_main (net/homa/homa_plumbing.c:971)
> > > [ 11.585197][ T133] kthread (kernel/kthread.c:389)
> > > [ 11.585197][ T133] ret_from_fork (arch/x86/kernel/process.c:153)
> > > [ 11.585197][ T133] ret_from_fork_asm (arch/x86/entry/entry_64.S:254)
>
> Do you see something in the console log at this point?

No: when I "sudo insmod homa.ko" I see nothing in the log other than a
"Homa module loading" message, which occurs well before
homa_timer_main starts up in its own thread.

> I find it odd that hrtimer_init() results in a console message. Maybe
> the console message itself is a clue, there is something wrong with
> the timer setup. If you can avoid the console message, you might then
> avoid the later lock inversion.

Yep, this seems odd to me as well.  I think Jakub's message below may
explain the problem.


-John-

