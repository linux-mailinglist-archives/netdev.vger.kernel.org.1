Return-Path: <netdev+bounces-149646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00BE9E699F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1C2281F89
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1241E1022;
	Fri,  6 Dec 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ow9PajWw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49021CCB4B
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475888; cv=none; b=K8NWUW6tcAgNMrI5IB1nQfhQ87zkI6B9H0zYnCa/iZcpo0QUFUa3yCnj6rEwQDPWNcQ7TunPDFdRpybue9L+zcxFK5K55tRKij2YTiwbREZeqArdRhjareTBIMjgGOJ5Jjjm0he8jgS4tE54yi0OCwJillWyiwPL0ULEHwPKO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475888; c=relaxed/simple;
	bh=rrQX/O2Ipu+tSsCqX+texkXRgpgQZTDjyjn9A5L0PXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEWmMZZ5zwhtY6f3isXMe5O59JaPself1VmMPoxJr/9DGfZJcniZYlRFHqLeAYjB0vK7Pw9BlgFIonRvoffTsuwtnq8dqMvD3QUidQxQIfEt/+DiXyLSAR23cQEhEm/W47yDmp08Ha4CBgH0E1WBdZxBgX7nyNWGXjgAiArnrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ow9PajWw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0e75dd846so2857450a12.3
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733475885; x=1734080685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dldw98h2j18SwRDYnzalr6BvHpYM5yuyIrT2gkwJtHE=;
        b=ow9PajWwilXtFmS04HUCm7VG4jUyR6raoxRNYdryfxnYNP6npsSx9soJJVFKHB7PWS
         kE557CLrP8fZ3BxTY64OE9XBQmffLY5ioL1Vb3F3b38cZkJlVJBIHcF9AiaaA44myAji
         zGoBC/vlglo83cPzLMitc6kzbDLTetpN3eQ9W0d+w/+nfMgX0kj3lwGLsdYuwfMwA7mx
         qAUnHfgl/emcJGPYDT0DwgyNWbeGNSA37EBimVmLoT8kfqrpGiQ8ZQWWfXYO6RyB1eMr
         REfWcrsBXtQTGgOD2SlbMcfAyFVDxDqHQGQigF97eKqV5VVBjRyPBmxYvjUbIicxCaE1
         54yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733475885; x=1734080685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dldw98h2j18SwRDYnzalr6BvHpYM5yuyIrT2gkwJtHE=;
        b=Tby8CmifKbxdmdX+b2fZg47Txeu1X4nyNZofsCaiqjK+RqXkAzO40hugVDvHpT3h3u
         BBqRig4Z5Hy9QPogATDnjq5ppV1VAba+MJbvFyzypkPDd8UZBUlAXV8XvWeE3tGRBdwo
         QKA+IFGCeaD+sI4BWMME8IktW+CD7vkw+LEtxH11B05A6RQ2oWt7y3l/pZyilRJHqsRs
         ilaxmzdPNlfWSTRTP4bIAxSFoQZCdfDmikORU9lYejBeuB0dKdhAXNKgUocNzFNHAg6r
         WR2nVAptlpnhb5T4WM2OjAHf5XBkLdI2Le4MDbHGD/jxVPLhb2wp+U7RNnlehQKAoBx1
         H2rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSmSvTaWzf3uZPN/Wbv8zWywDECdSL9cbzll0nmMma5ShrpeJXrblI8Afn1xbQKToDKDvv2Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiD+HHYtpXKSYWranLJ4AUhI+q61eG5cbs9X3lnkjEZTNT7jnx
	mamNF/Ccp694BLma/Q6rgWjXYkv25/zypym1JlxGrxak+ZB8lLQvA99w/yJdWoJEnXFg7/xqy8H
	olGVFZ9l9e7o6xI1QVi7AwJKeLlwpJsqElqCR
X-Gm-Gg: ASbGncvPXPrS0ckMonXZKH/1u0tjkHB8wk/5vfNZSJ7zxpXcCPWnjF30rnW/udPVs/f
	yicGD2LbpnKZi/NAnQnj2Fwk0FjuudVo=
X-Google-Smtp-Source: AGHT+IHsX2K6xVWtjaQGnFCaUFIyxSxnueqVZ3RInVi70dICRuZRPYXbqi1gd1cI+ajdnaT7GsVqsRtiM6oOmf0kkgU=
X-Received: by 2002:a05:6402:40d3:b0:5d3:ba42:e9fe with SMTP id
 4fb4d7f45d1cf-5d3be6c4d2cmr2181868a12.12.1733475884924; Fri, 06 Dec 2024
 01:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221254.3537932-1-sbrivio@redhat.com> <20241204221254.3537932-3-sbrivio@redhat.com>
 <CANn89i+iULeqTO2GrTCDZEOKPmU_18zwRxG6-P1XoqhP_j1p3A@mail.gmail.com>
 <Z1Ip9Ij8_JpoFu8c@zatzit> <CANn89i+PCsOHvd02nvM0oRjAXxPTgX6V1Y1-xfRL_43Ew9=H=w@mail.gmail.com>
 <Z1JeePBN5f1YCmYd@zatzit>
In-Reply-To: <Z1JeePBN5f1YCmYd@zatzit>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Dec 2024 10:04:33 +0100
Message-ID: <CANn89iJqLU6RuHgdbz3iGNL_K8XaPBYr3pWqQmgth2TFf14obg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Stefano Brivio <sbrivio@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Mike Manning <mvrmanning@gmail.com>, Paul Holzinger <pholzing@redhat.com>, 
	Philo Lu <lulie@linux.alibaba.com>, Cambda Zhu <cambda@linux.alibaba.com>, 
	Fred Chen <fred.cc@alibaba-inc.com>, Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 3:16=E2=80=AFAM David Gibson <david@gibson.dropbear.=
id.au> wrote:
>
> On Thu, Dec 05, 2024 at 11:52:38PM +0100, Eric Dumazet wrote:
> > On Thu, Dec 5, 2024 at 11:32=E2=80=AFPM David Gibson
> > <david@gibson.dropbear.id.au> wrote:
> > >
> > > On Thu, Dec 05, 2024 at 05:35:52PM +0100, Eric Dumazet wrote:
> > > > On Wed, Dec 4, 2024 at 11:12=E2=80=AFPM Stefano Brivio <sbrivio@red=
hat.com> wrote:
> > > [snip]
> > > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > > index 6a01905d379f..8490408f6009 100644
> > > > > --- a/net/ipv4/udp.c
> > > > > +++ b/net/ipv4/udp.c
> > > > > @@ -639,18 +639,21 @@ struct sock *__udp4_lib_lookup(const struct=
 net *net, __be32 saddr,
> > > > >                 int sdif, struct udp_table *udptable, struct sk_b=
uff *skb)
> > > > >  {
> > > > >         unsigned short hnum =3D ntohs(dport);
> > > > > -       struct udp_hslot *hslot2;
> > > > > +       struct udp_hslot *hslot, *hslot2;
> > > > >         struct sock *result, *sk;
> > > > >         unsigned int hash2;
> > > > >
> > > > > +       hslot =3D udp_hashslot(udptable, net, hnum);
> > > > > +       spin_lock_bh(&hslot->lock);
> > > >
> > > > This is not acceptable.
> > > > UDP is best effort, packets can be dropped.
> > > > Please fix user application expectations.
> > >
> > > The packets aren't merely dropped, they're rejected with an ICMP Port
> > > Unreachable.
> >
> > We made UDP stack scalable with RCU, it took years of work.
> >
> > And this patch is bringing back the UDP stack to horrible performance
> > from more than a decade ago.
> > Everybody will go back to DPDK.
>
> It's reasonable to be concerned about the performance impact.  But
> this seems like preamture hyperbole given no-one has numbers yet, or
> has even suggested a specific benchmark to reveal the impact.
>
> > I am pretty certain this can be solved without using a spinlock in the
> > fast path.
>
> Quite possibly.  But Stefano has tried, and it certainly wasn't
> trivial.
>
> > Think about UDP DNS/QUIC servers, using SO_REUSEPORT and receiving
> > 10,000,000 packets per second....
> >
> > Changing source address on an UDP socket is highly unusual, we are not
> > going to slow down UDP for this case.
>
> Changing in a general way is very rare, one specific case is not.
> Every time you connect() a socket that wasn't previously bound to a
> specific address you get an implicit source address change from
> 0.0.0.0 or :: to something that depends on the routing table.
>
> > Application could instead open another socket, and would probably work
> > on old linux versions.
>
> Possibly there's a procedure that would work here, but it's not at all
> obvious:
>
>  * Clearly, you can't close the non-connected socket before opening
>    the connected one - that just introduces a new much wider race.  It
>    doesn't even get rid of the existing one, because unless you can
>    independently predict what the correct bound address will be
>    for a given peer address, the second socket will still have an
>    address change when you connect().
>

The order is kind of obvious.

Kernel does not have to deal with wrong application design.

>  * So, you must create the connected socket before closing the
>    unconnected one, meaning you have to use SO_REUSEADDR or
>    SO_REUSEPORT whether or not you otherwise wanted to.
>
>  * While both sockets are open, you need to handle the possibility
>    that packets could be delivered to either one.  Doable, but a pain
>    in the arse.

Given UDP does not have a proper listen() + accept() model, I am
afraid this is the only way

You need to keep the generic UDP socket as a catch all, and deal with
packets received on it.

>
>  * How do you know when the transition is completed and you can close
>    the unconnected socket?  The fact that the rehashing has completed
>    and all the necessary memory barriers passed isn't something
>    userspace can directly discern.
>
> > If the regression was recent, this would be considered as a normal regr=
ession,
> > but apparently nobody noticed for 10 years. This should be saying somet=
hing...
>
> It does.  But so does the fact that it can be trivially reproduced.

If a kernel fix is doable without making UDP stack a complete nogo for
most of us,
I will be happy to review it.

