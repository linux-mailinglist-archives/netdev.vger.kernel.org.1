Return-Path: <netdev+bounces-84567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B281089756F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 18:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520751F28B4B
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F174514C596;
	Wed,  3 Apr 2024 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PowCscDi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEBC18E20
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162595; cv=none; b=c0NyxUc47KwO2oH7eNA8eGWIzU3qZ9IOFx82O0pipWKw24Gm9tsJbIbWaYvCcH6wfTW5uJE3jD0Wd03JjgDXhhICpAvLOK2t4tvenGCLa9GYWyMjPJOGsSSkCdAz0FiDx1BiG2f+afE9Iu8Xfft6wVZ9H8cuZp2F4SJYxquUSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162595; c=relaxed/simple;
	bh=SxYWihPHi6dlXlVBrFvM6+Prgc4rgyXvKuhM5h1DUWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVEclSGPgiHbGxiimVr787Pf3lGDwxKGKc/+ItcWdDurCz5oyThLFPTMFVMc85aIY2lHTkmrbt5kMtsu1h3nyoeZZbVppWkXksuu/z6eBjmqzq9MIWomjKFIa6U1olhqAxxITrdeK7VSiwrDPEfgYoGRfXTjTz9bVj/ZLFNhtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PowCscDi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56dec96530bso346a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712162592; x=1712767392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxsAArNyvYKtfurrxMnt7Kkz3LlbeXR6c/4Xx4MR9hQ=;
        b=PowCscDiqxADv6rOvILF9/1FW4OY4cyUGWDUJdlRALeJC7Evd6teyxWdDrAvpnr04j
         mer9JzgYR0l2wP4o+6onrXxPPs7D2NVDZbQyO5WQ3fmJddcNZ5RMMBP+hbkGS9EVzmIu
         1x3SkVPt3/S0E/J0DdFqC4MhrXJmuda43iUSVHJePECRrufdHH8LlnXQzo7aexytb1mG
         qRelp/j1KahOLENCl8bhi2GWApQBkJGnh5UXxHKzESUGEY301OfAdn60vZxtgi6X2prm
         xL6X9jDtqAV7K0i5e2jZTm+hqwyegVE6U0Z+8ILSI7mu2I+QxaYqQY0ZKou2ptIg9hU0
         yeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162592; x=1712767392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxsAArNyvYKtfurrxMnt7Kkz3LlbeXR6c/4Xx4MR9hQ=;
        b=OPATDl/M/IdnbLrIEdmfYpbgZqGetunuzvTLcFKaTsl1Yn7P42wH0/i3Duj8Y5M3r7
         D5YfRSAfG6vS+MQz/7Z7dR07iInNVnqEJDg6SsztDvRehJGsqrzpZiLEFolwTjps+08R
         gsgNdui63Cjujr12VzZEDCEFGbG+12g330L2FdFBhZ5NIT2Gl9PoRDVrNL1ydPH2UjTD
         ux7wR6Bzbgux7AoLH+2bOjRRS8HR10oPPB0KF57Na5VzRo4+CfIOmb17RHF4Ic8WDPrP
         pGfkM0GMu5Pqal5aT1IaiUaCEhr6MZ6pbrVWECzTBM4hMTF8Ia4pc2sOWpq6RoG2+p1w
         eg5w==
X-Forwarded-Encrypted: i=1; AJvYcCUvXeCcUsEXRpn/c/PY/c1tpbLJnsS57Zx5NE0EwbTd5XmL82Ts/4dVaHQ/hAISHTdz/VEQcHAmgZZi67r6zLt8JBHQl6Z+
X-Gm-Message-State: AOJu0YztbaoV8xFJ6jr3zpdI/Dw6yHBPZQkQibgkr0z1gK8dyzEMIzxv
	+E0OjnpxMvfEoouim56HjM0anhOJt5ZFEpwvy2OiRWjhPJloVhrASXcqglFWPqBQIYaPcMjzF2O
	k0MIHU0RSvL0BEtc/t59QN6+f3YTyi1FMJUz6
X-Google-Smtp-Source: AGHT+IFqFZ2aTM7meJjCdcEVHJYUZMQKj1JsQn3Bz663Wt+nZJJSRzlXdIBJXq+QPtpqeWv5HtO4CBgLrqiFiPcwl44=
X-Received: by 2002:aa7:c418:0:b0:56e:aa7:a4ae with SMTP id
 j24-20020aa7c418000000b0056e0aa7a4aemr129690edq.5.1712162592350; Wed, 03 Apr
 2024 09:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402215405.432863-1-hli@netflix.com> <CANn89iJOSUa2EvgENS=zc+TKtD6gOgfVn-6me1SNhwFrA2+CXw@mail.gmail.com>
 <CANn89iLyb70E+0NcYUQ7qBJ1N3UH64D4Q8EoigXw287NNQv2sg@mail.gmail.com> <b3kspnkcbj2p3c5q6rbujih72n7vouafpreg5mjsrgvf4fpu52@545rpheaixni>
In-Reply-To: <b3kspnkcbj2p3c5q6rbujih72n7vouafpreg5mjsrgvf4fpu52@545rpheaixni>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Apr 2024 18:43:01 +0200
Message-ID: <CANn89iJ3YrSg-Y+g65vowMtBzvNokT2N7ffk4=uw33k3SsePPA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: update window_clamp together with scaling_ratio
To: Hechao Li <hli@netflix.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	kernel-developers@netflix.com, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 6:30=E2=80=AFPM Hechao Li <hli@netflix.com> wrote:
>
> On 24/04/03 04:49PM, Eric Dumazet wrote:
> > On Wed, Apr 3, 2024 at 4:22=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Tue, Apr 2, 2024 at 11:56=E2=80=AFPM Hechao Li <hli@netflix.com> w=
rote:
> > > >
> > > > After commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scal=
e"),
> > > > we noticed an application-level timeout due to reduced throughput. =
This
> > > > can be reproduced by the following minimal client and server progra=
m.
> > > >
> > > > server:
> > > >
> > > ...
> > > >
> > > > Before the commit, it takes around 22 seconds to transfer 10M data.
> > > > After the commit, it takes 40 seconds. Because our application has =
a
> > > > 30-second timeout, this regression broke the application.
> > > >
> > > > The reason that it takes longer to transfer data is that
> > > > tp->scaling_ratio is initialized to a value that results in ~0.25 o=
f
> > > > rcvbuf. In our case, SO_RCVBUF is set to 65536 by the application, =
which
> > > > translates to 2 * 65536 =3D 131,072 bytes in rcvbuf and hence a ~28=
k
> > > > initial receive window.
> > >
> > > What driver are you using, what MTU is set ?
>
> The driver is AWS ENA driver. This is cross-region/internet traffic, so
> the MTU is 1500.
>
> > >
> > > If you get a 0.25 ratio, that is because a driver is oversizing rx sk=
bs.
> > >
> > > SO_RCVBUF 65536 would map indeed to 32768 bytes of payload.
> > >
>
> The 0.25 ratio is the initial default ratio calculated using
>
> #define TCP_DEFAULT_SCALING_RATIO ((1200 << TCP_RMEM_TO_WIN_SCALE) / \
>                                    SKB_TRUESIZE(4096))
>
> I think this is a constant 0.25, no?

This depends on skb metadata size, which changes over time.

With MAX_SKB_FRAGS =3D=3D 17, this is .25390625

With MAX_SKB_FRAGS =3D=3D 45, this is .234375


>
> Later with skb->len/skb->truesize, we get 0.66. However, the window
> can't grow to this ratio because window_clamp stays at the initial
> value, which is the initial tcp_full_space(sk), which is roughly 0.25 *
> rcvbuf.

Sure. Please address Jakub feedback about tests.

