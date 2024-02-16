Return-Path: <netdev+bounces-72478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E58584B7
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 19:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8CE2841EF
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D51A133404;
	Fri, 16 Feb 2024 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="ALVLV8kU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7612FB3F
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106432; cv=none; b=XlTk6ZCYDcE8gCFLUnNEuYPs6vC6RnVxtMXvwh2KwF1j6PgPvlcM4Cw8YcOeuJF/0XSfcf+Leyqw867jcL69OD5cQOzwP1c6S6c/LiRP2Dmueg9f58hAWFZxcChNjLHlEZ76KcICqok92oh8SP3030ZXkr6QytTTuIEnicUuLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106432; c=relaxed/simple;
	bh=15DJW3Vr5PesgonWy6zK6eRGv86QSnj1CkAtnm2Ndp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVD0X2KiPd2KJX2Hgrch6JLSe+Uor69aQehZK3PggmtSk+rQauScd0h0T9fmc/eYJOb3Bw9DfONwwmH+Kep6RZwJQ61BNhKKGrF34SUGNxxWSUR5cB8hiwS54Hicb/4pgZqZ6akIMkUGitTk1ll18OsJE44V//Xhs2WgF0NYTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=ALVLV8kU; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c02af52a21so909927e0c.3
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 10:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1708106429; x=1708711229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueEA8J46wPMLSHTgtE5vFK5FiSgNPoNFDj0S3sr1uM0=;
        b=ALVLV8kUn32GwLzHzQ+GuYQAT4PilVpeSgs1vfncmlTMAOOj+QVN9oJlKdNhoGZ86q
         nk5ijx7tERB1X6Itg6oS4XrfmpbxGBT1V+jCUCKHFkaHUs7BDXOxi0peD1K57ZjHt6Ek
         Ybg5d159aKog+6FsB4aRfj6aR1K/O9FjgYfp39dNEIcvaDZk5etE2IRMBSvCmcjfJWg6
         mamEBhuODRvV0NHmUbH015O+2inirl7kxR6+9tBBbPbOsisLR4e/lz8JG0E7QlXyXj+q
         HoH4R74L4pfAUe6v5qpMARTC+8zzIuHYMsZ+eWf2p9Eh1MWn5ilSG/ivhmGuqUYh2AgW
         li8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106429; x=1708711229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueEA8J46wPMLSHTgtE5vFK5FiSgNPoNFDj0S3sr1uM0=;
        b=KwfLfE60Y2jYjLhHBJPdS8fVQWm1pffBoVTNkVgheKpAa67eJdTyhlPcHH5eIbGp4J
         ZemV/+1xLTo7fNHjJDMcXdsLa2pbH8dd1nOgt/qtS/GXP/tt5XxwyByASf3pPDSsKpky
         xHv0UEnGr7oVgr2CsQExjoLtSU00rh+In1z/lsLGv0VujD0zP+GQ1KUDmBL1s6xTQSqd
         d9qPIDmYTZoYCW9Ou75oNy+vmZfF+XAeLZSjZWsQo4GR3doVQE2ljtc/Q33F3dK8QsE7
         oj52ofvv55W1r0/tj+P/dcjbueTUL92ZNeO914P/yWyfNMDC8+1cySn6XbMTsy3K9pDq
         BVwA==
X-Forwarded-Encrypted: i=1; AJvYcCULu00AGkuSEMEVV2RAwFLVHTbMyfkMJSk8LTBlnGuErqif9U/dcztQqiIaNK96oJHOzf3MIL42oakdDrwFVNP2FoktIAba
X-Gm-Message-State: AOJu0Ywe3FNzYr05+TBGDc3BTq781oOKacw2qe4bFnRgubXxrvTW2QEN
	A7h97nphcmOswso1gNTmm9XvgEWbIjngH7TcY3AjRJcECnTqlnnj7CoguXH2HuLwMzLV2Vg6W2A
	Y3nIggr0WntbwagUnrHUQW7Fle8ibEqUVvWVp
X-Google-Smtp-Source: AGHT+IHGCcc6vqRTtVdvSB4obBROtkaaqjpgiuQtcR3CSpTdrzZo4MTwQ4iFCAZA44KhZXCcPI7yhXn6K1LqE1rxNGA=
X-Received: by 2002:a05:6122:1c2:b0:4c7:344c:4eb1 with SMTP id
 h2-20020a05612201c200b004c7344c4eb1mr863397vko.11.1708106428538; Fri, 16 Feb
 2024 10:00:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrWUtYmSWw9-K1To8UDHe5THqEiwVyeSRNFQBaGuHs4cgg@mail.gmail.com>
 <396f9c38e2e2a14120e629cbc13353ec0aa15a62.camel@redhat.com>
In-Reply-To: <396f9c38e2e2a14120e629cbc13353ec0aa15a62.camel@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 16 Feb 2024 10:00:17 -0800
Message-ID: <CALCETrVwAT39fM89O0BqW9KAVfOFQo590g-Zs6mt+yAkoCvZZQ@mail.gmail.com>
Subject: Re: SO_RESERVE_MEM doesn't quite work, at least on UDP
To: Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weiwan@google.com>, Network Development <netdev@vger.kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 12:11=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Thu, 2024-02-15 at 13:17 -0800, Andy Lutomirski wrote:
> > With SO_RESERVE_MEM, I can reserve memory, and it gets credited to
> > sk_forward_alloc.  But, as far as I can tell, nothing keeps it from
> > getting "reclaimed" (i.e. un-credited from sk_forward_alloc and
> > uncharged).  So, for UDP at least, it basically doesn't work.
>
> SO_RESERVE_MEM is basically not implemented (yet) for UDP. Patches are
> welcome - even if I would be curious about the use-case.

I've been chasing UDP packet drops under circumstances where they
really should not be happening.  I *think* something regressed between
6.2 and 6.5 (as I was seeing a lot of drops on a 6.5 machine and not
on a 6.2 machine, and they're both under light load and subscribed to
the same multicast group).  But regardless of whether there's an
actual regression, the logic seems rather ancient and complex.  All I
want is a reasonable size buffer, and I have plenty of memory.  (It's
not 1995 any more -- I have many GB of RAM and I need a few tens of kB
of buffer.)

And, on inspection of the code, so far I've learned, in no particular order=
:

1. __sk_raise_mem_allocated() is called very frequently (as the
sk_forward_alloc mechanism is not particularly effective at reserving
memory).  And it calls sk_memory_allocated_add(), which looked
suspiciously like a horrible scalability problem until this patch:

commit 3cd3399dd7a84ada85cb839989cdf7310e302c7d
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Jun 8 23:34:09 2022 -0700

    net: implement per-cpu reserves for memory_allocated

and I suspect that the regression I'm chasing is here:

commit 4890b686f4088c90432149bd6de567e621266fa2
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Jun 8 23:34:11 2022 -0700

    net: keep sk->sk_forward_alloc as small as possible

(My hypothesis is that, before this change, there would frequently be
enough sk_forward_alloc left to at least drastically reduce the
frequency of transient failures due to protocol memory limits.)

2. If a socket wants to use memory in excess of sk_forward_alloc
(which is now very small) and rcvbuf is sufficient, it goes through
__sk_mem_raise_allocated, and that has a whole lot of complex rules.

2a. It checks memcg.  This does page_counter_try_charge, which does an
unconditional atomic add.  Possibly more than one.  Ouch.

2b. It checks *global* per-protocol memory limits, and the defaults
are *small* by modern standards.  One slow program with a UDP socket
and a big SO_RCVBUF can easily use all the UDP memory, for example.
Also, why on Earth are we using global limits in a memcg world?

2c. The per-protocol limits really look buggy.  The code says:

    if (sk_has_memory_pressure(sk)) {
        u64 alloc;

        if (!sk_under_memory_pressure(sk))
            return 1;
        alloc =3D sk_sockets_allocated_read_positive(sk);
        if (sk_prot_mem_limits(sk, 2) > alloc *
            sk_mem_pages(sk->sk_wmem_queued +
                 atomic_read(&sk->sk_rmem_alloc) +
                 sk->sk_forward_alloc))
            return 1;
    }

<-- Surely there should be a return 1 here?!?

suppress_allocation:

That goes all the way back to:

commit 3ab224be6d69de912ee21302745ea4
5a99274dbc
Author: Hideo Aoki <haoki@redhat.com>
Date:   Mon Dec 31 00:11:19 2007 -0800

    [NET] CORE: Introducing new memory accounting interface.

But it wasn't used for UDP back then, and I don't think the code path
in question is or was reachable for TCP.

3. A failure in any of this stuff gives the same drop_reason.  IMO it
would be really nice if the drop reason were split up into, say,
RCVBUFF_MEMCG, RCVBUF_PROTO_HARDLIMIT, RCVBUFF_PROTO_PRESSURE or
similar.


And maybe there should be a way (a memcg option?) to just turn the
protocol limits off entirely within a memcg.  Or to have per-memcg
protocol limits.  Or something.  A single UDP socket in a different
memcg should not be able to starve the whole system such that even
just two (!) queued UDP datagrams don't fit in a receive queue.


Anyway, SO_RESERVE_MEM looks like it ought to make enqueueing on that
socket faster and more scalable.  And exempt from random failures due
to protocol memory limits.


--Andy

