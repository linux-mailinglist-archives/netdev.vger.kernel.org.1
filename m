Return-Path: <netdev+bounces-79984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A072687C502
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 23:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0587CB20BE1
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 22:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB905768F3;
	Thu, 14 Mar 2024 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qnvze1Y7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830776414
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710454262; cv=none; b=ZE4Nz3gjDOTYOw1jA64DykOBaEIVOzDxuKH4gx8E1qM6H7afkn8plr+nANyfmLqlyJ1eXH2nI+U7mQlnWPcyY92FLN4gshjOn4ShadjOLI2BlV88E7JGFj2PLjwRau+UoPq5XGp/l8dJsKFvkiAaO9EY/T1YtN7bdxl3gI+qWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710454262; c=relaxed/simple;
	bh=9ne34hu1Uu4xRqo+61k7qlNo7lBWoqkWEVOiLb4KbCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h50+OjdrVShG7SU2B6xYnTCrUj1nMcXNdTXc34qCrp3X49OXVWpezRaBj5CY/KuoFkAs2zXoEfoht0baegMHU169zPr5Gva7ycJ+8+G6/w2vpx8z0paAw0hP4TQqeqU3mhPuIZgMsOr/BbQS+lq6z+Np3/TiulJ+itfCSMrLdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qnvze1Y7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso2257a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 15:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710454259; x=1711059059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/iXUZtRmUuGLLpytfk91+YkdDrDFXa6e8mwru/9NwQ=;
        b=qnvze1Y77erMIi4icQiscjvkfdKVHkk1LDdshsvuRJecL6MJo9W1tCucP01PIKUbkl
         0BjCfwAuXbB0KX06iK5YvSdTqnjiVLWGMcItUp6Kdiu38cpeYG2RvzetQeH/X+/RvjmX
         0wGgMG9nyAurji+TX0Aq7dRXUmcRl9UDwmTVLHkCQquIhNU3TQWY/mKE3zxGOTM2hXks
         wNR1o6CpMAagUN8RhET+2ckBO+1TylapHlOpIEEaPr1uC3WIXBpYPIVYIN28izrpXPwG
         mXkPeWCc7us2k9ZuB+y2cZ4qmmaK88ukqHjiWkciomeXV//7/sGaHYgVA1Qfq217FAR9
         gTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710454259; x=1711059059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/iXUZtRmUuGLLpytfk91+YkdDrDFXa6e8mwru/9NwQ=;
        b=WQYeJhwZCiSE6Ko3yPyjB9uNQbB+H7JEYE5y5qlYctTazK4lljSG5LwNCmrCHf+ThQ
         g/hKIx6Bk7rzS+o+uNUqihw5rNaffh55EWEXhQZeAi1ZOqCpt/0LSnPCm7Z3BPmHRYUJ
         ELxDi1w1Zxt5JDwd6qXxQpeCxqPNGRke+L7BQZWZudfkmWM4f2L1Bsy0lgbr9iwIsd0a
         npsEUc3ILqeVS4CxuHliQBRjcBUsvOtjJCLzrV0ER2oPMkQbHVbVaoO89Di1jrOQiXTn
         CKeoufCighRnrwAOj7DcCuaH7Fszdv78y/XApCCP91qUPDR3b9+HZpKl2M/Ai+pxLdd/
         qw9g==
X-Forwarded-Encrypted: i=1; AJvYcCU5UonPTZYtCT7s/vXBNq7AVmS2MVVHrUAtifxM2jqtq0fjOnJP9kx6zCOjzHBeMTfNpoqEK6XF0h5BLxITR+zwcK1bMqyC
X-Gm-Message-State: AOJu0YyJIaDhP5cYqhNHqdWuAVFlm/dicaMfgNUgWB/5gXE6RLPBQ5/f
	hvfnZPfJ6hZX5VN0H44Kt/5XMOPz/zcl2wLeNNmNCjOk2hE84pAjISxFblcvrZzWLzqL3eMQeuo
	aNqQKt1L8HMOtvra87UdpTqNTI5iFwygTzrxK
X-Google-Smtp-Source: AGHT+IFYpuPhcbUnjsVABTe0qGWBimsDDM39+EDJZXwRKdGAylHS5N+jnlJZQMc6TWv59DiSLHe1u3UHCUPnJR8XqQU=
X-Received: by 2002:a05:6402:3d5:b0:568:797f:f529 with SMTP id
 t21-20020a05640203d500b00568797ff529mr46039edw.2.1710454258903; Thu, 14 Mar
 2024 15:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314210740.GA2823176@perftesting> <CANn89i+Bid4YkwFEmxSvF22Gk0jY+hH7P=mjEKR=LBPc+vG_PA@mail.gmail.com>
In-Reply-To: <CANn89i+Bid4YkwFEmxSvF22Gk0jY+hH7P=mjEKR=LBPc+vG_PA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Mar 2024 23:10:45 +0100
Message-ID: <CANn89iJKfxnzWzoN=KkFERjRUYpyKHO4KLJytMBS69tnRWY9Jw@mail.gmail.com>
Subject: Re: [BUG] Panic in ipv6 on old NFS sockets from destroyed network namespace
To: Josef Bacik <josef@toxicpanda.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:47=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Mar 14, 2024 at 10:07=E2=80=AFPM Josef Bacik <josef@toxicpanda.co=
m> wrote:
> >
> > Hello,
> >
> > We've been hitting the following panic in production, and I've root cau=
sed
> > what's happening, but I'm at a loss on how to fix it.
> >
> > The panic we're seeing is this
> >
> >     BUG: kernel NULL pointer dereference, address: 0000000000000000
> >     RIP: 0010:ip6_pol_route+0x59/0x7a0
> >     Call Trace:
> >      <IRQ>
> >      ? __die+0x78/0xc0
> >      ? page_fault_oops+0x286/0x380
> >      ? fib6_table_lookup+0x95/0xf40
> >      ? exc_page_fault+0x5d/0x110
> >      ? asm_exc_page_fault+0x22/0x30
> >      ? ip6_pol_route+0x59/0x7a0
> >      ? unlink_anon_vmas+0x370/0x370
> >      fib6_rule_lookup+0x56/0x1b0
> >      ? update_blocked_averages+0x2c6/0x6a0
> >      ip6_route_output_flags+0xd2/0x130
> >      ip6_dst_lookup_tail+0x3b/0x220
> >      ip6_dst_lookup_flow+0x2c/0x80
> >      inet6_sk_rebuild_header+0x14c/0x1e0
> >      ? tcp_release_cb+0x150/0x150
> >      __tcp_retransmit_skb+0x68/0x6b0
> >      ? tcp_current_mss+0xca/0x150
> >      ? tcp_release_cb+0x150/0x150
> >      tcp_send_loss_probe+0x8e/0x220
> >      tcp_write_timer+0xbe/0x2d0
> >      run_timer_softirq+0x272/0x840
> >      ? hrtimer_interrupt+0x2c9/0x5f0
> >      ? sched_clock_cpu+0xc/0x170
> >      irq_exit_rcu+0x171/0x330
> >      sysvec_apic_timer_interrupt+0x6d/0x80
> >      </IRQ>
> >      <TASK>
> >      asm_sysvec_apic_timer_interrupt+0x16/0x20
> >     RIP: 0010:cpuidle_enter_state+0xe7/0x243
> >
> > Inspecting the vmcore with drgn you can see why this is a NULL pointer =
deref
> >
> >       >>> prog.crashed_thread().stack_trace()[0]
> >       #0 at 0xffffffff810bfa89 (ip6_pol_route+0x59/0x796) in ip6_pol_ro=
ute at net/ipv6/route.c:2212:40
> >
> >       2212        if (net->ipv6.devconf_all->forwarding =3D=3D 0)
> >       2213              strict |=3D RT6_LOOKUP_F_REACHABLE;
> >
> >       >>> prog.crashed_thread().stack_trace()[0]['net'].ipv6.devconf_al=
l
> >       (struct ipv6_devconf *)0x0
> >
> > Looking at the socket you can see that it's been closed
> >
> >       >>> decode_enum_type_flags(prog.crashed_thread().stack_trace()[11=
]['sk'].__sk_common.skc_flags, prog.type('enum sock_flags'))
> >       'SOCK_DEAD|SOCK_KEEPOPEN|SOCK_ZAPPED|SOCK_USE_WRITE_QUEUE'
> >       >>> decode_enum_type_flags(1 << prog.crashed_thread().stack_trace=
()[11]['sk'].__sk_common.skc_state.value_(), prog["TCPF_CLOSE"].type_, bit_=
numbers=3DFalse)
> >       'TCPF_FIN_WAIT1'
> >
> > The way this reproduces is with our NFS setup.  We have an NFS mount in=
side of a
> > container, which has it's own network namespace.  We setup the mount in=
side of
> > this network namespace.
> >
> > On container shutdown sometimes we trigger this panic, it's pretty reli=
ably
> > reproduced, with a stress tier of 200 machines I can usually trigger it=
 on ~10
> > machines by stopping the jobs.
> >
> > My initial thought was that NFS wasn't properly shutting down the socke=
ts, but
> > this doesn't appear to be the case.  The sock is always marked with SOC=
K_DEAD.
> > My second thought was that we had some pending timers when we call
> > kernel_sock_shutdown(), so I added tcp_clear_xmit_timers(sk); to tcp_sh=
utdown()
> > to make sure the timers were cleared.  This didn't fix the issue.
> >
> > I added some debugging to the socket and flagged the socket when NFS ca=
lled
> > kernel_sock_shutdown() and then had a WARN_ON(sock_flag(sk,
> > JOSEFS_SPECIAL_FLAG)) where we arm the timer, and that trips constantly=
.  So
> > we're definitely arming the sock after NFS has shutdown the socket.
> >
> > This is where we leave my ability to figure out what's going on and how=
 to fix
> > it.  What seems to be happening is this
> >
> > 1. NFS calls kernel_sock_shutdown() when we unmount.
> > 2. We get an ACK on the socket and the timer gets armed.
> > 3. We shutdown the container and tear down the network namespace.
> > 4. The timer fires and we try to send the loss probe and we panic becau=
se the
> >    network namespace teardown removes the devconf as part of its teardo=
wn.
> >
> > It appears to me that sock's will just hang around forever past the end=
 of an
> > application being done with it, tho I'm not sure if I'm correct in this=
.  If
> > that's the case then I don't know the correct way to handle this, other=
 than
> > adding an extra case for the timer to simply not run when SOCK_DEAD is =
set.  But
> > this seems to be done on purpose, so seems like that's a bad fix.
> >
> > Let me know if you have debug patches or other information you'd like f=
rom a
> > vmcore, I have plenty.  Like I said I can reproduce reliably, it does t=
ake a few
> > hours to deploy a test kernel, but I can have a turn around of about a =
day for
> > debug patches.  Thanks,
> >
> > Josef
>
>   If NFS is using kernel sockets, it is NFS responsibility to remove
> all of them when the netns is destroyed.
>
> Also look at recent relevant  patches
>
> 2a750d6a5b365265dbda33330a6188547ddb5c24 rds: tcp: Fix use-after-free
> of net in reqsk_timer_handler().
> 1c4e97dd2d3c9a3e84f7e26346aa39bc426d3249 tcp: Fix NEW_SYN_RECV
> handling in inet_twsk_purge()

Another relevant patch was

commit 3a58f13a881ed351198ffab4cf9953cf19d2ab3a
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Mon May 2 10:40:18 2022 +0900

    net: rds: acquire refcount on TCP sockets

