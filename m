Return-Path: <netdev+bounces-95593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DCB8C2BE6
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 23:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0542824DD
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8B13B78E;
	Fri, 10 May 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/43edYX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C46613B789
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376479; cv=none; b=ml68TPMtIFQEuiGwpT4egHt4eG2qMIwYamBJOWe23FuMksvHUwGmGibVx9WK34dfMDpDSEXYM1T2tA8ko/SlbT+dIFd3kKTBDZsaVUbIQjIxlLP0wk1yM9WrjRdY6K2Er+b0Bp1ZVicGfG08BJs1tK8Fa7OuN3iMhwNejJnaTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376479; c=relaxed/simple;
	bh=jG1XzQGVqbPJVaV6zbgB4Vv73mJ0VYF0EnY5DNTHpfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPpvRx82hjsmu8/3D1+AwXuZW2rpE1s9V7nFRFI8a0qbnqweW9nxd5IueWytx24RZchfi8izMUCURxlSXjhE78nvayClA7QaL8hA1wA9JrgwApn3J9FVHQwqyQZ9P2hctNyainCUAyg3I1+rr2ceEUCnMhWS1imubDni0q0ca5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k/43edYX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so23073005ad.1
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715376477; x=1715981277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3q3hqpMGXKwiEL9x8u2/jKIHxeOXTBiBSvlvRi/TduI=;
        b=k/43edYX4lRVPreoWrJ1pG65IzPO5HYHH3wkGvwZ6byXewX4ES6DzaK9vLRAfHlKXq
         wmSnuvZeFKzC3d9TLc9nlDzAcpOszpIofkUrA+/3T7KmxNxc6SARxrM2KtCqP4ORO/zR
         Z9zpeGWFd7yr1MOxQ9Xdo4Yuc0645gzIs3q9SzBKs37uctNByDpI1I5BhwRjiOqe5Ayv
         ltxyUTZHmYDrwQ3bxiSUSutALv080hMKvBBXWXQz+owk/7DBaIcXQgIuQ6uoPrpIK695
         WdmyY5zHeGAxCW1NNgxU42gpNtTSxAYIbm3B6JGazfMLYBYO/nUoDk8kebSfnh+udpxJ
         SD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715376477; x=1715981277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3q3hqpMGXKwiEL9x8u2/jKIHxeOXTBiBSvlvRi/TduI=;
        b=oi9Hdw2eviJ5CsA/Ds+4CN9Xci+mZ+FFcfYQigBqdoGXGtCvG9YukYjNe5J2wom3eb
         b8EvLzjhanhU6xSu73YrOmHZFBd5ru/4dqIrgjTqQnLmDURJ/opTKF5qpDGMf5P7Cr59
         xW2nWeR364RIg967BT4SxquxnsUL/gy2Y6Bng+dXf37SFzGDy3GL2+rFus6O0/X8dWH8
         JlngBbAzKpe+XeoBAT9es81cn01pL0dsUA7g6YVK3FMpNMykSH7Gn3E0v6VLj7YTkwgG
         Rz1cjF2VYnWOIYok1cYjWPvbBm0qc5Kfu6TEJeYpT12rqz9tos4TDlf7lk5dVCO1ubPN
         PX2w==
X-Forwarded-Encrypted: i=1; AJvYcCUHksi+fDchjnNvcskDnHwOqwkxuTKys/XJDNvzNoldQs0SNWMqFkl8pJXDEmVhL6w34NoT8X10ocPyXIgO0z7ZTV+SqYOx
X-Gm-Message-State: AOJu0Yx3qR8uvf4VNHFZktjK1EZw946VmM4RHRobjwtfjkXJjaw9YBsA
	AdrFFjd/T95dwHfeH+tvXPeGHNdsXYNaPqVphfYxCxBtXgEkHwMW6xpgxEJK85bK8D6qC39KT+1
	zrAUmT5DB8NJSr5h2PBLxjObAxBp+JxYAwBwt
X-Google-Smtp-Source: AGHT+IHi+uN9YAG1vR1pnN46m2nVsZ9AeJUZEm4EJmPOcrBsoA8vKk4oUGfskunfiAqx8BEU50tYATpFc9YLOtR0IqU=
X-Received: by 2002:a17:90a:fe93:b0:2b2:ce88:c68c with SMTP id
 98e67ed59e1d1-2b6cc44fa08mr3718925a91.19.1715376477090; Fri, 10 May 2024
 14:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502211047.2240237-1-maheshb@google.com> <87fruspxgt.ffs@tglx>
 <CAF2d9jigGhpSAj2hnUG2QSvYeSzTvD1FUf7tT8BW1NU8EouyOA@mail.gmail.com>
In-Reply-To: <CAF2d9jigGhpSAj2hnUG2QSvYeSzTvD1FUf7tT8BW1NU8EouyOA@mail.gmail.com>
From: Yuliang Li <yuliangli@google.com>
Date: Fri, 10 May 2024 14:27:46 -0700
Message-ID: <CADj8K+M9qjLGAKcsV_9YoPQ5SGXe3vmi69Y65m1RUyLOMrJeHg@mail.gmail.com>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
To: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Don Hatchett <hatch@google.com>, 
	Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Sagi Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Mahesh. Please see my answers below.

The mono_raw allows PHC to correlate with a non-adjusted time. This
enables other types of clock sync algorithms to be developed.
For example, if we want to measure the drift rate between CPU
oscillator and PHC. We could run a linear regression over multiple
pairs of <phc, sys>. But if sys time itself is being adjusted (e.g.,
clock_realtime), the linear regression is running over a polyline
hence less effective. With mono_raw, linear regression truly measures
the drift rate of the CPU oscillator.
This capability allows more types of clock sync algorithms to be developed.

Thanks,
Yuliang


On Wed, May 8, 2024 at 7:54=E2=80=AFPM Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=
=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=
=E0=A4=B0)
<maheshb@google.com> wrote:
>
> On Wed, May 8, 2024 at 12:35=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> >
> > On Thu, May 02 2024 at 14:10, Mahesh Bandewar wrote:
> > > The ability to read the PHC (Physical Hardware Clock) alongside
> > > multiple system clocks is currently dependent on the specific
> > > hardware architecture. This limitation restricts the use of
> > > PTP_SYS_OFFSET_PRECISE to certain hardware configurations.
> > >
> > > The generic soultion which would work across all architectures
> > > is to read the PHC along with the latency to perform PHC-read as
> > > offered by PTP_SYS_OFFSET_EXTENDED which provides pre and post
> > > timestamps.  However, these timestamps are currently limited
> > > to the CLOCK_REALTIME timebase. Since CLOCK_REALTIME is affected
> > > by NTP (or similar time synchronization services), it can
> > > experience significant jumps forward or backward. This hinders
> > > the precise latency measurements that PTP_SYS_OFFSET_EXTENDED
> > > is designed to provide.
> >
> > This is really a handwavy argument.
> >
> > Fact is that the time jumps of CLOCK_REALTIME caused by NTP (etc) are
> > rare and significant enough to be easily filtered out. That's why this
> > interface allows you to retrieve more than one sample.
> >
> > Can you please explain which problem you are actually trying to solve?
> >
> > It can't be PTP system time synchronization as that obviously requires
> > CLOCK_REALTIME.
> >
> Let me add a couple of folks from the clock team. @Yuliang Li  @Don Hatch=
ett
> I'm just a nomad-kernel-net guy trying to fill-in gaps :(
>
> > Thanks,
> >
> >         tglx

