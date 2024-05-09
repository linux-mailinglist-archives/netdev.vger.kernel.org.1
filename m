Return-Path: <netdev+bounces-94777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B24F8C09EB
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD681F22557
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4AC13BC1D;
	Thu,  9 May 2024 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQ0Hz/ai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2E885950
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715223268; cv=none; b=Ll/2050Ng7UYA0OTyARk9iGfOx4ks3uLK/to/sld/Pynkx3zM6tsx3UmwgIBRcj0oI2RH/1Rmi/SFROdVOPD2aT8/eTbvvvjFURkiDDx/7xkbxy70NI6tP0p9BIK61YERduOo9ri2uwbeuzMqxsRq6xdssOPIysGwTEwSPVTVt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715223268; c=relaxed/simple;
	bh=px95XfgVdNLSqB1NEtbMqouLoL3ZUqGEDf4VJRKlrNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0zmhP5q48dy8hi6mg8lKvryinThK05ziNxx3C98oNM9DRJYWVBfDbuaL0D2MPMpLprMLfVe2JbEYmKW146Pxp7vAp4dQBqbQZJDk0uv2RQP/AvWHZXJjSQQY/t5n9ceYuDEFsITIhMDqtf/2fcbgLeeKpY6Lil3/BARB/b7UMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQ0Hz/ai; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b47833dc5so2012406d6.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 19:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715223266; x=1715828066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n5lXWwCrkNw+mZGyoG+6UZQXx93pGBCtpjOq+keWdY=;
        b=MQ0Hz/aiIh3fGCWR/x2rtu7OJ2Z/DMj2FMHIFrYvJ5Bs4yX2efgDcF/C76eEVc1UAi
         9Gvn8e6sFMX8M1A1GlkEyqzHTiaTKjQ82bpEIhU/BBKHoYgvX9JxJVyJaQCb6qEpvTA6
         kc6+eEjibGwZv9RHGIZXlJI5Bo3ILQWjnjuPfRlctMxnjN8N6R+81B+Q8ZOWO8R3tcYH
         vfEIE3A4eMQxGFzY+Pl1IwQ4+2VC5HLYAdwbQgNbvw2OxkGXEMJnWQVBWcR3z4VWg7gK
         Ds3dR34aK6Z7a8WGKs1BOiO+RxQtLVvi/1IUhVZLKCzp2yby5o12SCa0Q3jC+Y2aKnBD
         4fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715223266; x=1715828066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n5lXWwCrkNw+mZGyoG+6UZQXx93pGBCtpjOq+keWdY=;
        b=Ul6cVdJn8e2fh6tzzXRbQ1TsZNYF5zFVn1PKY5mhctiPwQMooudqODXWGrILunVzz8
         3UcoeayW35pzC+CFarR8FmklrkhdKbddLHuBzTLNhb7gg+AkmjA64i50WhxaNp4V9lPV
         /3SaMySnt0eCpUNLaYMBLiI0gfOm+WGbwkoepLnBrjNk0fRJXsvolOGGgY5OqlWLxOaF
         dpE2RimX1i6muLEa5XjSHLxuE3WfInq+GYLDvywCb6Q92sGWKlKMpkH/kuWxUulmbQDm
         EetVfRz6ulZ1hzCSGFXljOJfDb5d9UxczgKIEM/7v94Lfz6w06/+/md3LrINqyUKThBe
         QLrg==
X-Gm-Message-State: AOJu0YwStjXBm5qBokyedqyd2d7r1HkxFN+vywwFv+3Q6xzU5ycYSyYr
	C/72/SZUNwZXufLzuQB0685XPuimQx2yPWZoUPEzDlVGwiv3gNFMYngZFhc/YJhdl4KbfVKV7iG
	rQLzERqZAJFrMZo3P1eiQOib6wKGxFhUCgpEt
X-Google-Smtp-Source: AGHT+IEDRHFaM7QiNDpvS1RM9lXUOxibfeTGoCbE7y0wlHy7q9FA+3L3PbX3ukTv0VKfULn8aem19wicPLE3Tz00mfQ=
X-Received: by 2002:a05:6214:d66:b0:6a0:c914:2a07 with SMTP id
 6a1803df08f44-6a151436c43mr57067126d6.4.1715223265690; Wed, 08 May 2024
 19:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502211047.2240237-1-maheshb@google.com> <87fruspxgt.ffs@tglx>
In-Reply-To: <87fruspxgt.ffs@tglx>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Wed, 8 May 2024 19:53:58 -0700
Message-ID: <CAF2d9jigGhpSAj2hnUG2QSvYeSzTvD1FUf7tT8BW1NU8EouyOA@mail.gmail.com>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
To: Thomas Gleixner <tglx@linutronix.de>, Yuliang Li <yuliangli@google.com>, 
	Don Hatchett <hatch@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Sagi Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 12:35=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, May 02 2024 at 14:10, Mahesh Bandewar wrote:
> > The ability to read the PHC (Physical Hardware Clock) alongside
> > multiple system clocks is currently dependent on the specific
> > hardware architecture. This limitation restricts the use of
> > PTP_SYS_OFFSET_PRECISE to certain hardware configurations.
> >
> > The generic soultion which would work across all architectures
> > is to read the PHC along with the latency to perform PHC-read as
> > offered by PTP_SYS_OFFSET_EXTENDED which provides pre and post
> > timestamps.  However, these timestamps are currently limited
> > to the CLOCK_REALTIME timebase. Since CLOCK_REALTIME is affected
> > by NTP (or similar time synchronization services), it can
> > experience significant jumps forward or backward. This hinders
> > the precise latency measurements that PTP_SYS_OFFSET_EXTENDED
> > is designed to provide.
>
> This is really a handwavy argument.
>
> Fact is that the time jumps of CLOCK_REALTIME caused by NTP (etc) are
> rare and significant enough to be easily filtered out. That's why this
> interface allows you to retrieve more than one sample.
>
> Can you please explain which problem you are actually trying to solve?
>
> It can't be PTP system time synchronization as that obviously requires
> CLOCK_REALTIME.
>
Let me add a couple of folks from the clock team. @Yuliang Li  @Don Hatchet=
t
I'm just a nomad-kernel-net guy trying to fill-in gaps :(

> Thanks,
>
>         tglx

