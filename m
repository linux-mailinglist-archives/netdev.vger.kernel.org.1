Return-Path: <netdev+bounces-72492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0241C85859E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 19:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B1E1F24658
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 18:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB77713AA49;
	Fri, 16 Feb 2024 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zp1l9kHr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621B139573
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109058; cv=none; b=bxdVAQR3CcwOdKPRlh3LS3AyNOikHMgyHMC9GKwzhPBpqyzKpfSv2OJo4OgBC2lgCedw2QGnxkiVzBdyCtANv6Ajiu0ZTPK4L1WKwtov934JOKSpyDE9NvKhdVUlRCT9lnbWQSNW7OG8uhbx2ZWtPAEmxKvM4ssGWee5yRL5aTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109058; c=relaxed/simple;
	bh=is74SxLH2fcG4nxpWW0Ms5pfDS6vmrGLVq+/QoSqAAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p395JTbcqswBS8i0aOSGYWKmOI5xBihKllEoyS03CAUkJR2maJkdh6fhcka0LehOfT7cMVAC762I4HzY4iEJvgSzWo8rF390SpTy1Cl6Bf5CvOHaNKaz6OyBSa+eCTZztgTd+g8f6wMNEVRCeSmlwTtilTdk+SYvbvUAriYeZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zp1l9kHr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso714a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 10:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708109055; x=1708713855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd6bah5kWJs/p0C4VpOMLJEbY6JolrQ4onPS5UWgI9g=;
        b=Zp1l9kHrXqt5boXyQXYi4KPUO8K7MMDLX/2VFa5phAGU9U4rf3k4Tvz/m3g5qXbqD+
         zmat53esWmzRLEgmOwnoAH8ege2uMsA8VJaM03th4fZLUnrMENcefb6jUZNpv5oxRjCh
         5e01X+HgM7T9YC5Tj19WBUj7CQ2GnLS96zHnFIhmNvK7WzfRiFJ80hY62OclnVUs14iX
         YS7waSbL+NcnUN7KwyVd3C0ysFe8NLJuLtJ3RuoQkcez5E/MKZyauqVId4+TEEmLootz
         ZUx1OTfjKU2xvSOkT6P8qBhryrUHWsAnnlQ7eli69ixWw+FFlxy3lZgRsqBzmsTenMhn
         Rmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109055; x=1708713855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vd6bah5kWJs/p0C4VpOMLJEbY6JolrQ4onPS5UWgI9g=;
        b=PbhVkwCCjFmXa+5PkSCGq8Cdkc5y3SeYM3Ao2XyUKQ9zsxFhHzZO7FO2A68KmU1Mmm
         daXXrS3n8L/rS83W8UVJd+aHAaUnSZRAewDdS2CvQcF9Cb50DcOedlm8DEcb2yroJMUK
         4Q2O7wHPxld8in8+zZnkMXFu9O1qtwIP77Hy3yLlg5jBgq0ipn9IOFprgvKis04mpUeh
         uqXtWCtnEGYRPzHIp+qox+n5vnmPyDG+wiN/QavYgrcvLmSNPFi6X50dqf4JPycVoqXw
         /ExvY/L+0qNam8ab5cm5lDJoywACW42XDTyujW92JSr7cPcr7ez3dtJs5bwiq9m3kyJm
         V9TA==
X-Forwarded-Encrypted: i=1; AJvYcCUZYXoFJj07SN/jn2//9aBa0Io2dIpU5f/d4L2QPMc6cgQcUaEOYUaA/+0b44duY1GOhkHsusMoaH98SE1ssWQWKwtLz+EC
X-Gm-Message-State: AOJu0Yzp1fnElYMVtxxjpMofJtBN5yQQMi/4P6u4K7egEM//4cNLIs4Q
	E3XcuqVY/8ddwIRSYcJeLBete2iVKGSuOif8dsaRZEgiZvXoXfhXc4h4I50MuJa7dHrblhXlWWq
	ceYjxwBSGmr4phWClH5Kv0ZUUSsNI7o+1snyIpvv6uOYd0vjxdgBm
X-Google-Smtp-Source: AGHT+IE6SF1IU42agrlb0Z9BmG8VA/Flsiy03gMawoNmEFORdtCKS7bLtlhiD4KF+tuwE8IUnK8Al3LUFj3t2GwCaj4=
X-Received: by 2002:a50:d598:0:b0:560:ea86:4d28 with SMTP id
 v24-20020a50d598000000b00560ea864d28mr9527edi.4.1708108598067; Fri, 16 Feb
 2024 10:36:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrWUtYmSWw9-K1To8UDHe5THqEiwVyeSRNFQBaGuHs4cgg@mail.gmail.com>
 <396f9c38e2e2a14120e629cbc13353ec0aa15a62.camel@redhat.com> <CALCETrVwAT39fM89O0BqW9KAVfOFQo590g-Zs6mt+yAkoCvZZQ@mail.gmail.com>
In-Reply-To: <CALCETrVwAT39fM89O0BqW9KAVfOFQo590g-Zs6mt+yAkoCvZZQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 19:36:24 +0100
Message-ID: <CANn89iKPPt3tozuDaSfsop5YbvgRoKha=dgTR2-ReoYEvA-_DA@mail.gmail.com>
Subject: Re: SO_RESERVE_MEM doesn't quite work, at least on UDP
To: Andy Lutomirski <luto@amacapital.net>
Cc: Paolo Abeni <pabeni@redhat.com>, Wei Wang <weiwan@google.com>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 7:00=E2=80=AFPM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Fri, Feb 16, 2024 at 12:11=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > On Thu, 2024-02-15 at 13:17 -0800, Andy Lutomirski wrote:
> > > With SO_RESERVE_MEM, I can reserve memory, and it gets credited to
> > > sk_forward_alloc.  But, as far as I can tell, nothing keeps it from
> > > getting "reclaimed" (i.e. un-credited from sk_forward_alloc and
> > > uncharged).  So, for UDP at least, it basically doesn't work.
> >
> > SO_RESERVE_MEM is basically not implemented (yet) for UDP. Patches are
> > welcome - even if I would be curious about the use-case.
>
> I've been chasing UDP packet drops under circumstances where they
> really should not be happening.  I *think* something regressed between
> 6.2 and 6.5 (as I was seeing a lot of drops on a 6.5 machine and not
> on a 6.2 machine, and they're both under light load and subscribed to
> the same multicast group).  But regardless of whether there's an
> actual regression, the logic seems rather ancient and complex.  All I
> want is a reasonable size buffer, and I have plenty of memory.  (It's
> not 1995 any more -- I have many GB of RAM and I need a few tens of kB
> of buffer.)
>
> And, on inspection of the code, so far I've learned, in no particular ord=
er:
>
> 1. __sk_raise_mem_allocated() is called very frequently (as the
> sk_forward_alloc mechanism is not particularly effective at reserving
> memory).  And it calls sk_memory_allocated_add(), which looked
> suspiciously like a horrible scalability problem until this patch:
>
> commit 3cd3399dd7a84ada85cb839989cdf7310e302c7d
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Wed Jun 8 23:34:09 2022 -0700
>
>     net: implement per-cpu reserves for memory_allocated
>
> and I suspect that the regression I'm chasing is here:
>
> commit 4890b686f4088c90432149bd6de567e621266fa2
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Wed Jun 8 23:34:11 2022 -0700
>
>     net: keep sk->sk_forward_alloc as small as possible
>
> (My hypothesis is that, before this change, there would frequently be
> enough sk_forward_alloc left to at least drastically reduce the
> frequency of transient failures due to protocol memory limits.)
>
> 2. If a socket wants to use memory in excess of sk_forward_alloc
> (which is now very small) and rcvbuf is sufficient, it goes through
> __sk_mem_raise_allocated, and that has a whole lot of complex rules.
>
> 2a. It checks memcg.  This does page_counter_try_charge, which does an
> unconditional atomic add.  Possibly more than one.  Ouch.
>
> 2b. It checks *global* per-protocol memory limits, and the defaults
> are *small* by modern standards.  One slow program with a UDP socket
> and a big SO_RCVBUF can easily use all the UDP memory, for example.
> Also, why on Earth are we using global limits in a memcg world?
>
> 2c. The per-protocol limits really look buggy.  The code says:
>
>     if (sk_has_memory_pressure(sk)) {
>         u64 alloc;
>
>         if (!sk_under_memory_pressure(sk))
>             return 1;
>         alloc =3D sk_sockets_allocated_read_positive(sk);
>         if (sk_prot_mem_limits(sk, 2) > alloc *
>             sk_mem_pages(sk->sk_wmem_queued +
>                  atomic_read(&sk->sk_rmem_alloc) +
>                  sk->sk_forward_alloc))
>             return 1;
>     }
>
> <-- Surely there should be a return 1 here?!?
>
> suppress_allocation:
>
> That goes all the way back to:
>
> commit 3ab224be6d69de912ee21302745ea4
> 5a99274dbc
> Author: Hideo Aoki <haoki@redhat.com>
> Date:   Mon Dec 31 00:11:19 2007 -0800
>
>     [NET] CORE: Introducing new memory accounting interface.
>
> But it wasn't used for UDP back then, and I don't think the code path
> in question is or was reachable for TCP.
>
> 3. A failure in any of this stuff gives the same drop_reason.  IMO it
> would be really nice if the drop reason were split up into, say,
> RCVBUFF_MEMCG, RCVBUF_PROTO_HARDLIMIT, RCVBUFF_PROTO_PRESSURE or
> similar.
>
>
> And maybe there should be a way (a memcg option?) to just turn the
> protocol limits off entirely within a memcg.  Or to have per-memcg
> protocol limits.  Or something.  A single UDP socket in a different
> memcg should not be able to starve the whole system such that even
> just two (!) queued UDP datagrams don't fit in a receive queue.
>
>
> Anyway, SO_RESERVE_MEM looks like it ought to make enqueueing on that
> socket faster and more scalable.  And exempt from random failures due
> to protocol memory limits.

Yes, this was the goal, but so far only implemented for TCP.

Have you tried to bump SK_MEMORY_PCPU_RESERVE to a higher value ?

SK_MEMORY_PCPU_RESERVE has been set to a very conservative value,
based on TCP workloads.

