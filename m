Return-Path: <netdev+bounces-147497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FE39D9E04
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06FB2B22468
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A211DE4FF;
	Tue, 26 Nov 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVK7aVNs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73359191F8F
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649231; cv=none; b=FmhE4/PCx6CIwFCFV6ikZOpcKdVzZG2VIm/bdBbz+LDzM4xWh6WmEZ0p1fX6NYEXpYaULtM4XcSQofTDC/fpPEoX+tyDOm1oD/RJ+hh5e3CiME+Q8gtd7shU3Gd5JREkrOAEmN44H3opYiNQOxSY/lKSzwqAKRrmh0xiVvcQH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649231; c=relaxed/simple;
	bh=TMydjLwufYqCHd10qFkA6XypG7GfCYJdMS16kUj4sL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kp6lVCGkhELa0zBjNvrberJWUqRaX7oyXJqrlU4Jal2GIbG3nEZ73kt3TOPYR+FLiX3HQwbQxStlT8j0tYwrcg4GRV3p2aiPTlqbfKhR9gdQr0bnpzOgw/oJG5iq2yzGOngcD6BYHTZdEVMm5Cd595onvxopSF2kMhad9Lrjk5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVK7aVNs; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffc80318c9so24051171fa.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 11:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732649227; x=1733254027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMydjLwufYqCHd10qFkA6XypG7GfCYJdMS16kUj4sL0=;
        b=kVK7aVNsPDmvQzzfECNoQcmVQlx3Xista4PbU8X+D4G1rUJP8WAaTqff2aX+KNAN/u
         9YW0DBAOaCF3qCT4V/RZJzhP6lJLdn5y5if739M1nr2J7Rc3YGWMsw5aTtVXDh+vMqDT
         BCJDPxpaKw9IoXUHQd2pHKDK3IVIG1wa9Ewgv2MLuksKRSMq2PngLU7Frqyath/yXW7Q
         OOc5aZoLZZ7f9yZGfJZPN2lrTMOQFylN7/JXaHFMwyaMnfxqRmtA/B70HXx3RYIc2FwK
         g9DaHdtTRu8sl5N0WK4sqYKR1sMiGvcXxhc3MCRObBF+hwvcdbg1mjKD6YZ/g4Ckt4h6
         y0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732649227; x=1733254027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMydjLwufYqCHd10qFkA6XypG7GfCYJdMS16kUj4sL0=;
        b=REEYWQIX9KbVYTUDMn8rddSroKjCPEvHHswtX6Vbz1cWuqyeb1xDbqczKaXMChDna+
         KgJgk8vLdfEyVTIZW09+9GkYaPCm9ovPI0rWF53QPU7pNpEYBa1F8LT5BG29pwQ98517
         64NJ/YrfEgkIFxnG6pqGRU1y1/BR5ot8FJUWU24hXHQSivSWfPzexJEfqFr5+NlvI9+7
         gkLf5tornAdg67Acl9F4H8mxU9yuc24nCgNZK37sNKsrxHH5sRBxF4qNw6EaOebtx5OM
         Zh1Qmb3yt7cw7clrGJWcaG+qyXMFPJ1DnzFewONiyEzdEQoc3l6/Os0KiZbw8SS2rncn
         /lMA==
X-Gm-Message-State: AOJu0YxRlW0pWKKkoQw1VjJ9cDF88dk4+qLDpvHnVUVz1yHbPaEtJIhk
	4f78RWEVtrQI70/tP6dOMuODpr8YhHKz47Bwo/oq22JzLs6elFACb0KM3oG9YGRMM/qcJDMzaGc
	EXGilYn2gnDgj6CI+9N1chjylgjXS1vSEkOva7fj3yec9Wz14OmMD
X-Gm-Gg: ASbGncsmLHyDrCZ2lCP4BQOJ6yTky58HRNvVlBKXPXV7lk/9ajSVvIKYcGuisdcoUi6
	zVIMr+ngKdt88UyJSlLBR1K038t/UteOk
X-Google-Smtp-Source: AGHT+IEecJNoyAyDhaPhdQcmd+ZuUDHRmcmJ7tKPEoxe8bEq+7MCrujxVlZWQKVDO3X9TdzPPIoyuAdeTBPgWTLw+NY=
X-Received: by 2002:a05:651c:547:b0:2fb:34dc:7beb with SMTP id
 38308e7fff4ca-2ffd606ccffmr1280741fa.12.1732649227336; Tue, 26 Nov 2024
 11:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126175402.1506-1-ffmancera@riseup.net> <CANn89iJ7NLR4vSqjSb9gpKxfZ2jPJS+jv_H1Qqs1Qz0DZZC=ug@mail.gmail.com>
 <CANn89i+651SOZDegASE2XQ7BViBdS=gdGPuNs=69SBS7SuKitg@mail.gmail.com> <85bce8fc-6034-43fb-9f4e-45d955568aaa@riseup.net>
In-Reply-To: <85bce8fc-6034-43fb-9f4e-45d955568aaa@riseup.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Nov 2024 20:26:56 +0100
Message-ID: <CANn89iLF_0__Ewy9TXpCs7NP4FB-18iGfnn=cXgXu4qMbxyhwQ@mail.gmail.com>
Subject: Re: [PATCH net] udp: call sock_def_readable() if socket is not SOCK_FASYNC
To: "Fernando F. Mancera" <ffmancera@riseup.net>
Cc: netdev@vger.kernel.org, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 8:18=E2=80=AFPM Fernando F. Mancera
<ffmancera@riseup.net> wrote:
>
> Hi,
>
> On 26/11/2024 19:41, Eric Dumazet wrote:
> > On Tue, Nov 26, 2024 at 7:32=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> >>
> >> On Tue, Nov 26, 2024 at 6:56=E2=80=AFPM Fernando Fernandez Mancera
> >> <ffmancera@riseup.net> wrote:
> >>>
> >>> If a socket is not SOCK_FASYNC, sock_def_readable() needs to be calle=
d
> >>> even if receive queue was not empty. Otherwise, if several threads ar=
e
> >>> listening on the same socket with blocking recvfrom() calls they migh=
t
> >>> hang waiting for data to be received.
> >>>
> >>
> >> SOCK_FASYNC seems completely orthogonal to the issue.
> >>
> >> First sock_def_readable() should wakeup all threads, I wonder what is =
happening.
> >
>
> Well, it might be. But I noticed that if SOCK_FASYNC is set then
> sk_wake_async_rcu() do its work and everything is fine. This is why I
> thought checking on the flag was a good idea.
>

How have you tested SOCK_FASYNC ?

SOCK_FASYNC is sending signals. If SIGIO is blocked, I am pretty sure
the bug is back.


> > Oh well, __skb_wait_for_more_packets() is using
> > prepare_to_wait_exclusive(), so in this case sock_def_readable() is
> > waking only one thread.
> >
>
> Yes, this is what I was expecting. What would be the solution? Should I
> change it to "prepare_to_wait()" instead? Although, I don't know the
> implication that change might have.

Sadly, we will have to revert, this exclusive wake is subtle.

