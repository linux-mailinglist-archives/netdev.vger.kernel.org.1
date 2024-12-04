Return-Path: <netdev+bounces-148906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA479E3601
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B0C165AED
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273691990D3;
	Wed,  4 Dec 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvfoC279"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E519309C
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302542; cv=none; b=Gqd5WMdXuxhdv+omcGJJZNMWLxst7SbNnIjUGFTRGoC/v2G0aCpQcHez5BowfsqE/Kn1olF8zLD4+HafacpopHc08TX7GOEC3PyLRa23blpKQdStvbJoYEZNmU7bPt2Xj+oHREYYQa4FKnihaGKCnBVO2Rkj5A1BVq3nLohZJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302542; c=relaxed/simple;
	bh=6Izke65AXpS0VmYoo22e0g0QsGHtrZ06IK9M6bCw2cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iavJXC27h7CoKI8/rAfNc0zUWKHY1HbOtPLZG/ulYzwebd7c5HiMxsqzi1Ol7JhsPimWHClA7CLPD87csSNyH53iuvva8wcDYTi4ni1CbjZYIcKsIxdNy5n+rslnNViaHoOWVUOZk3j5SbJAVKGdPl/1nPbguUIDAvissyYIWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvfoC279; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so7985071a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733302538; x=1733907338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJbrEWxBCkHbyaq9EdVtGXFN+ax//3d1lQb0Nm+ee6g=;
        b=FvfoC2792yz+VKuy5rfvlLSlyRXHiMatjOE7NYK1rZaZBbO0NgOvapb5YdI6DHBMz4
         ENLyvkpqNje0Svn2CkyXJ87PimIu5D12JP+a+K78lv77VtPn+C1wLE1DS0JdsczQvEGV
         Z2ixUDQW5sAG8Zu7AhUenCwN2LoMhm1WwI22HU9DpRRi5+wyssuQB7hj4lETQBH4UgFr
         VenfEE5TbPCWUrhbQSSTSX8kuokHSsZa2U0TuwH+BTtw2svl5R+OC4KXOUNzrWWc7cZE
         TFHVvJMGT10Z0oHxYkKeya/DiyJdfsl5NHISL6zMnxFdUoSaiBOAq7Ys/r1ngn2oRCC4
         tV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733302538; x=1733907338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJbrEWxBCkHbyaq9EdVtGXFN+ax//3d1lQb0Nm+ee6g=;
        b=tpjbatN2qjHP5I6PfUdDtz5pIe+YuLeMVNfH/miG4D+Kqxt0H1EiAXnbW5LpW/rXGD
         Hzyof8b41FtqumYsqPnVpQYOcxO/L8wULELqJP96x1OcLpPfPFnqasBm6RGVOsJca9qJ
         JMlX/hLRfbPMCAx69WbaU4ZoLYyoPrezwWYNeMyTHfx1u3gho5+kN3NDcdznQHohFLpI
         NNJt1uDKgrxipWjrhaSb6Hbd/gsa5G6mgmzHymm8Bv5NEdK7NMNv98C8cwGNwoeaUxpJ
         f/T81ckOWH2dOaSk4Xl5h4QAO/QKje2kUCIhnXsZyEt8Cqcf+Repdn1y4f9MI8Rdv+lm
         tPzg==
X-Forwarded-Encrypted: i=1; AJvYcCXk6rcFjAS7VnbFoCetUGjKZO0WC00fBj8KpmsM2XKyQX8eSQgqnJtqx/9dIEKCms2i2Z6zqao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIArglBZyPjDj6+YHZ7uNM/rQKR/R7HGYJZZbWaYQCBrBbF0p
	UbgUXxRYnm/HqUcbHsfX1Dmo1/sQNQVYFAv8/i3oWNELHd3iG9o9dHkzUm+d9gBJaX/2mo9zAxc
	ZduZStxbCC2hwG7ClM4SM2Oy37y6rn4ujeay7
X-Gm-Gg: ASbGnctiUMQr8VNtLtP/0zcXa5H3sfYmHXfqWsTVRx3Jf7g+6yJOuWaAYj6kW5e6YBx
	guhxWab8l9jXwE89q/3HFWGPJI4oZrWmD
X-Google-Smtp-Source: AGHT+IFLv8Go2ESiUlixE1oPJUrkZ+SZMuqPqhRi/X2v6c4Cj8NkE5kV/d4b0u8vBcSwZLQ7b46y6DZnCQ2lgETqDSI=
X-Received: by 2002:a05:6402:3903:b0:5d0:b74f:6422 with SMTP id
 4fb4d7f45d1cf-5d10cba2bd8mr5494843a12.32.1733302537392; Wed, 04 Dec 2024
 00:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com> <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
 <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com> <Z0/L2gDjvXVfj1ho@perf>
In-Reply-To: <Z0/L2gDjvXVfj1ho@perf>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 09:55:26 +0100
Message-ID: <CANn89i+LzKpwfCRX2YGqi-0fmekT53fDpGtvav2u3E0EMB95qw@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: Neal Cardwell <ncardwell@google.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dujeong.lee@samsung.com, 
	guo88.liu@samsung.com, yiwang.cai@samsung.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joonki.min@samsung.com, hajun.sung@samsung.com, 
	d7271.choe@samsung.com, sw.ju@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:22=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung.c=
om> wrote:
>
> On Tue, Dec 03, 2024 at 10:34:46AM -0500, Neal Cardwell wrote:
> > On Tue, Dec 3, 2024 at 6:07=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Tue, Dec 3, 2024 at 9:10=E2=80=AFAM Youngmin Nam <youngmin.nam@sam=
sung.com> wrote:
> > > >
> > > > We encountered the following WARNINGs
> > > > in tcp_sacktag_write_queue()/tcp_fastretrans_alert()
> > > > which triggered a kernel panic due to panic_on_warn.
> > > >
> > > > case 1.
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 4 PID: 453 at net/ipv4/tcp_input.c:2026
> > > > Call trace:
> > > >  tcp_sacktag_write_queue+0xae8/0xb60
> > > >  tcp_ack+0x4ec/0x12b8
> > > >  tcp_rcv_state_process+0x22c/0xd38
> > > >  tcp_v4_do_rcv+0x220/0x300
> > > >  tcp_v4_rcv+0xa5c/0xbb4
> > > >  ip_protocol_deliver_rcu+0x198/0x34c
> > > >  ip_local_deliver_finish+0x94/0xc4
> > > >  ip_local_deliver+0x74/0x10c
> > > >  ip_rcv+0xa0/0x13c
> > > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > > >
> > > > case 2.
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 0 PID: 648 at net/ipv4/tcp_input.c:3004
> > > > Call trace:
> > > >  tcp_fastretrans_alert+0x8ac/0xa74
> > > >  tcp_ack+0x904/0x12b8
> > > >  tcp_rcv_state_process+0x22c/0xd38
> > > >  tcp_v4_do_rcv+0x220/0x300
> > > >  tcp_v4_rcv+0xa5c/0xbb4
> > > >  ip_protocol_deliver_rcu+0x198/0x34c
> > > >  ip_local_deliver_finish+0x94/0xc4
> > > >  ip_local_deliver+0x74/0x10c
> > > >  ip_rcv+0xa0/0x13c
> > > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > > >
> > >
> > > I have not seen these warnings firing. Neal, have you seen this in th=
e past ?
> >
> > I can't recall seeing these warnings over the past 5 years or so, and
> > (from checking our monitoring) they don't seem to be firing in our
> > fleet recently.
> >
> > > In any case this test on sk_state is too specific.
> >
> > I agree with Eric. IMHO TCP_FIN_WAIT1 deserves all the same warnings
> > as ESTABLISHED, since in this state the connection may still have a
> > big queue of data it is trying to reliably send to the other side,
> > with full loss recovery and congestion control logic.
> Yes I agree with Eric as well.
>
> >
> > I would suggest that instead of running with panic_on_warn it would
> > make more sense to not panic on warning, and instead add more detail
> > to these warning messages in your kernels during your testing, to help
> > debug what is going wrong. I would suggest adding to the warning
> > message:
> >
> > tp->packets_out
> > tp->sacked_out
> > tp->lost_out
> > tp->retrans_out
> > tcp_is_sack(tp)
> > tp->mss_cache
> > inet_csk(sk)->icsk_ca_state
> > inet_csk(sk)->icsk_pmtu_cookie
>
> Hi Neal.
> Thanks for your opinion.
>
> By the way, we enable panic_on_warn by default for stability.
> As you know, panic_on_warn is not applied to a specific subsystem but to =
the entire kernel.
> We just want to avoid the kernel panic.
>
> So when I see below lwn article, I think we might use pr_warn() instaed o=
f WARN_ON().
> https://lwn.net/Articles/969923/
>
> How do you think of it ?

You want to silence a WARN_ON() because you chose  to make all WARN_ON() fa=
tal.

We want something to be able to fix real bugs, because we really care
of TCP being correct.

We have these discussions all the time.
https://lwn.net/Articles/969923/ is a good summary.

It makes sense for debug kernels (for instance used by syzkaller or
other fuzzers) to panic,
but for production this is a high risk, there is a reason
panic_on_warn is not set by default.

If we use a soft  print there like pr_warn(), no future bug will be caught.

What next : add a new sysctl to panic whenever a pr_warn() is hit by syzkal=
ler ?

Then Android will set this sysctl "because of stability concerns"

> >
> > A hunch would be that this is either firing for (a) non-SACK
> > connections, or (b) after an MTU reduction.
> >
> > In particular, you might try `echo 0 >
> > /proc/sys/net/ipv4/tcp_mtu_probing` and see if that makes the warnings
> > go away.
> >
> > cheers,
> > neal
> >

