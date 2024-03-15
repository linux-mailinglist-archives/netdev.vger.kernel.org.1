Return-Path: <netdev+bounces-80074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FC687CE76
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196ED281F77
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B1C2E634;
	Fri, 15 Mar 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JZOaXdoN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F9376FD
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511432; cv=none; b=Uz/TExWh3oTwwOV31GzeuHhK//mYenCdmMrqvFcFkP08NGl3PnF1WakMFIou7gY3ujMecXdi9HfwxgJ9hE6Z0sqnU4rNbNi73TQzLMj8CKD3MARZqT/ES+Q9l1B8HDLGiVYvJFQnwyXZHhu7iFTiVAaY7mpj4OwB4RLV5ttUpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511432; c=relaxed/simple;
	bh=11sn4pcGeCov9RGyHti5joDCW5zU4TpguLfb4BlQMYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQvObXtCORaJibXXCWQBkEoyTV25fZVDybCEz6yWkDre02eGZ1Y+HFMQ4s3ZDDpRhR0SHTTt1s87ih/Bz+Lk5xi7rY0H08Zqcxs2GdnjDYmjRNyV9I5KZmky8XYymgKvtIkCw+QOHi+OuWNao2BpuZj2b+2ZOVWWMInjnCqyL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JZOaXdoN; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a12661c8a2so797423eaf.2
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710511430; x=1711116230; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lQE0gLheV26fDZRW+ULF2uka/2mtd0etjxYtrrMo3Nc=;
        b=JZOaXdoNFsJl0oPiM4exthxypWMAdjCvToH+E/YaSHhykcAeW+2aPxBFb7QTGexPQY
         i5DZJDH3CglXrdx/B7t3OHZv8G1TECo/uqoMeyls+yZkvgFauM3BLMTM8awFmpFe13/A
         P13EzPXewENbHpoYD7SG5lvwVH1qS7stFcOku8BUgblETAspb39xgJnJGyyIgIBDhu0n
         RcQeu+hdM81vo4ydSw5wergn41oYWTw0G8+eBJ3weC/7ZRlL1tukKG1YcnXRf6DVhXnx
         HbnOHmRn/ahCaXfJbeYpDnA6pQWcs6C9pqXQZPLXdVZn4Kih6/MrWL46tOMhL1W96kaQ
         uRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710511430; x=1711116230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQE0gLheV26fDZRW+ULF2uka/2mtd0etjxYtrrMo3Nc=;
        b=Y8bzrgI6lYDx55BzkK1+WXDua+NW1Y1EUwii/cD/rXfN8sTwVZQSJFURR2d95IGCuu
         L9z5txr7HEFKN6e5gEo8t/d4J2/uAZHb/jDkzKwdkP25SDfoZI/oXt6tEVojkxLCjTbl
         JeOutW2FyVgyueg9MkcvzSqiiQRGUT71Wj9zozdsLu65ZLJftMUD9B9F8Z63L91j7n5y
         21M3eKn2YnUTnq4ZHeRnAIuAvZOYz27nNh08RblUxcH6qiE41AmWgHqhbBdp/Pn/b+nL
         1Z6o+JEUbKoWaofIjxqn8L27rpMXNyxh7W5zYOUW5j8UZlVM4kUy2tfyZsEopNUI98mW
         X8ng==
X-Forwarded-Encrypted: i=1; AJvYcCWwegzz3h8+PQUWwwCM8MyagcnkB3dPZNCwroFQd5fSl1BQeg3DROEjWqSPeevPv3jISpWSsV7CAVhQygbKgxceBS09Dyye
X-Gm-Message-State: AOJu0YyuBQsXftUSZadqiI+/4jhfg/o7iipPCIBMgVXvS7pE5uLt2IL+
	3LoUhEikJkLgl8fn637iG23IlL+dmwhb9Zk5oYwgy6ExmBYx3OYk88lbce6X790=
X-Google-Smtp-Source: AGHT+IH66gHftpBJPsxY492mb5N2jZn3ANtPkGcILSKG9Sao7Vk3Twcq7bQp3tqgSwpxM0Ke7KjL2g==
X-Received: by 2002:a05:6358:2619:b0:17b:80e2:a105 with SMTP id l25-20020a056358261900b0017b80e2a105mr2268392rwc.24.1710511429866;
        Fri, 15 Mar 2024 07:03:49 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u36-20020a81b624000000b0060cca9c7d36sm691188ywh.31.2024.03.15.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 07:03:49 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:03:48 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [BUG] Panic in ipv6 on old NFS sockets from destroyed network
 namespace
Message-ID: <20240315140348.GA2872887@perftesting>
References: <20240314210740.GA2823176@perftesting>
 <CANn89i+Bid4YkwFEmxSvF22Gk0jY+hH7P=mjEKR=LBPc+vG_PA@mail.gmail.com>
 <CANn89iJKfxnzWzoN=KkFERjRUYpyKHO4KLJytMBS69tnRWY9Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJKfxnzWzoN=KkFERjRUYpyKHO4KLJytMBS69tnRWY9Jw@mail.gmail.com>

On Thu, Mar 14, 2024 at 11:10:45PM +0100, Eric Dumazet wrote:
> On Thu, Mar 14, 2024 at 10:47 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Thu, Mar 14, 2024 at 10:07 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > Hello,
> > >
> > > We've been hitting the following panic in production, and I've root caused
> > > what's happening, but I'm at a loss on how to fix it.
> > >
> > > The panic we're seeing is this
> > >
> > >     BUG: kernel NULL pointer dereference, address: 0000000000000000
> > >     RIP: 0010:ip6_pol_route+0x59/0x7a0
> > >     Call Trace:
> > >      <IRQ>
> > >      ? __die+0x78/0xc0
> > >      ? page_fault_oops+0x286/0x380
> > >      ? fib6_table_lookup+0x95/0xf40
> > >      ? exc_page_fault+0x5d/0x110
> > >      ? asm_exc_page_fault+0x22/0x30
> > >      ? ip6_pol_route+0x59/0x7a0
> > >      ? unlink_anon_vmas+0x370/0x370
> > >      fib6_rule_lookup+0x56/0x1b0
> > >      ? update_blocked_averages+0x2c6/0x6a0
> > >      ip6_route_output_flags+0xd2/0x130
> > >      ip6_dst_lookup_tail+0x3b/0x220
> > >      ip6_dst_lookup_flow+0x2c/0x80
> > >      inet6_sk_rebuild_header+0x14c/0x1e0
> > >      ? tcp_release_cb+0x150/0x150
> > >      __tcp_retransmit_skb+0x68/0x6b0
> > >      ? tcp_current_mss+0xca/0x150
> > >      ? tcp_release_cb+0x150/0x150
> > >      tcp_send_loss_probe+0x8e/0x220
> > >      tcp_write_timer+0xbe/0x2d0
> > >      run_timer_softirq+0x272/0x840
> > >      ? hrtimer_interrupt+0x2c9/0x5f0
> > >      ? sched_clock_cpu+0xc/0x170
> > >      irq_exit_rcu+0x171/0x330
> > >      sysvec_apic_timer_interrupt+0x6d/0x80
> > >      </IRQ>
> > >      <TASK>
> > >      asm_sysvec_apic_timer_interrupt+0x16/0x20
> > >     RIP: 0010:cpuidle_enter_state+0xe7/0x243
> > >
> > > Inspecting the vmcore with drgn you can see why this is a NULL pointer deref
> > >
> > >       >>> prog.crashed_thread().stack_trace()[0]
> > >       #0 at 0xffffffff810bfa89 (ip6_pol_route+0x59/0x796) in ip6_pol_route at net/ipv6/route.c:2212:40
> > >
> > >       2212        if (net->ipv6.devconf_all->forwarding == 0)
> > >       2213              strict |= RT6_LOOKUP_F_REACHABLE;
> > >
> > >       >>> prog.crashed_thread().stack_trace()[0]['net'].ipv6.devconf_all
> > >       (struct ipv6_devconf *)0x0
> > >
> > > Looking at the socket you can see that it's been closed
> > >
> > >       >>> decode_enum_type_flags(prog.crashed_thread().stack_trace()[11]['sk'].__sk_common.skc_flags, prog.type('enum sock_flags'))
> > >       'SOCK_DEAD|SOCK_KEEPOPEN|SOCK_ZAPPED|SOCK_USE_WRITE_QUEUE'
> > >       >>> decode_enum_type_flags(1 << prog.crashed_thread().stack_trace()[11]['sk'].__sk_common.skc_state.value_(), prog["TCPF_CLOSE"].type_, bit_numbers=False)
> > >       'TCPF_FIN_WAIT1'
> > >
> > > The way this reproduces is with our NFS setup.  We have an NFS mount inside of a
> > > container, which has it's own network namespace.  We setup the mount inside of
> > > this network namespace.
> > >
> > > On container shutdown sometimes we trigger this panic, it's pretty reliably
> > > reproduced, with a stress tier of 200 machines I can usually trigger it on ~10
> > > machines by stopping the jobs.
> > >
> > > My initial thought was that NFS wasn't properly shutting down the sockets, but
> > > this doesn't appear to be the case.  The sock is always marked with SOCK_DEAD.
> > > My second thought was that we had some pending timers when we call
> > > kernel_sock_shutdown(), so I added tcp_clear_xmit_timers(sk); to tcp_shutdown()
> > > to make sure the timers were cleared.  This didn't fix the issue.
> > >
> > > I added some debugging to the socket and flagged the socket when NFS called
> > > kernel_sock_shutdown() and then had a WARN_ON(sock_flag(sk,
> > > JOSEFS_SPECIAL_FLAG)) where we arm the timer, and that trips constantly.  So
> > > we're definitely arming the sock after NFS has shutdown the socket.
> > >
> > > This is where we leave my ability to figure out what's going on and how to fix
> > > it.  What seems to be happening is this
> > >
> > > 1. NFS calls kernel_sock_shutdown() when we unmount.
> > > 2. We get an ACK on the socket and the timer gets armed.
> > > 3. We shutdown the container and tear down the network namespace.
> > > 4. The timer fires and we try to send the loss probe and we panic because the
> > >    network namespace teardown removes the devconf as part of its teardown.
> > >
> > > It appears to me that sock's will just hang around forever past the end of an
> > > application being done with it, tho I'm not sure if I'm correct in this.  If
> > > that's the case then I don't know the correct way to handle this, other than
> > > adding an extra case for the timer to simply not run when SOCK_DEAD is set.  But
> > > this seems to be done on purpose, so seems like that's a bad fix.
> > >
> > > Let me know if you have debug patches or other information you'd like from a
> > > vmcore, I have plenty.  Like I said I can reproduce reliably, it does take a few
> > > hours to deploy a test kernel, but I can have a turn around of about a day for
> > > debug patches.  Thanks,
> > >
> > > Josef
> >
> >   If NFS is using kernel sockets, it is NFS responsibility to remove
> > all of them when the netns is destroyed.
> >
> > Also look at recent relevant  patches
> >
> > 2a750d6a5b365265dbda33330a6188547ddb5c24 rds: tcp: Fix use-after-free
> > of net in reqsk_timer_handler().
> > 1c4e97dd2d3c9a3e84f7e26346aa39bc426d3249 tcp: Fix NEW_SYN_RECV
> > handling in inet_twsk_purge()
> 
> Another relevant patch was
> 
> commit 3a58f13a881ed351198ffab4cf9953cf19d2ab3a
> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date:   Mon May 2 10:40:18 2022 +0900
> 
>     net: rds: acquire refcount on TCP sockets

Thanks for the quick reply Eric!  I'll get something like this done and tested
for NFS.

Josef

