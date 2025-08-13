Return-Path: <netdev+bounces-213464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58879B2529B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 19:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B233A951D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE8C1D63C5;
	Wed, 13 Aug 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJ42H29J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C0303C8F
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107575; cv=none; b=MikK0dIVtcEOL3o/+fR0rjDrMeRxZmT4gXgtOVD26bzwDKJ1Y5tNssDifd3icz0tnaJFffql8V1eBCZdljYe11gWTA0j4q6ziCRidoQV+5/rndQRB+0c5J/6J0tLQN8EoQuUSkydJdf8sPA8bTOcr6VGA77mm5mps7vwMqg/UoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107575; c=relaxed/simple;
	bh=Ji78IdZNhw+tyn0C82W+5KGqdcZryFZ+BRRkAmDMhWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eluqZ0EPQ3gI0RTx70zA1lHAl9hkUQ2uzVZUmtCVEeOZ7HYGp5A6evva4Zkxt51+Ip2AVD9NW5DZe8Yx70s1Denr2kYanRQkp8B1VUYklReJjGLt23WMkQsgwoW/kn0r3PwmL7WtyZj6aLNbIOr3be65W7+gERq4XNPV7KI9XhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJ42H29J; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445826fd9dso186255ad.3
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755107573; x=1755712373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji78IdZNhw+tyn0C82W+5KGqdcZryFZ+BRRkAmDMhWs=;
        b=WJ42H29J7moUFJodYK/dy5x00gArdDZS+0kewmviIJMK25slpV2D0UT/7J/rk2oKbc
         Ev/Q/Al67G1pzeD5SFWtQhxcqgFpe8V10EjBIeZ8bfU0HSzpXqGGiMEEHeP0LhW8/3/O
         rVp90GhcbH8VDYr4seCY8QunzCYL+QcJrVEs+TOe0dvIRWZpmAl2LlALNI7YAH5ra699
         61RFuEY9p1/4dfNUPzWvC1/KW+HLHGdilfo4LQMHRgmvpQ4VP597PAy2nh2itWO/wZss
         4Sa2qZKCctfgFXklz4IiM3JzYGPussFNlJpHxSxTyp55wrDECOQeVhyM+TzWhFySfmat
         St6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107573; x=1755712373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji78IdZNhw+tyn0C82W+5KGqdcZryFZ+BRRkAmDMhWs=;
        b=Scc0YXxR9ZkGEHdMPzJkLRQktt+fTYj1V/gibWs68+PiHorp11sQGTYpfNORzxVQD8
         20TsMr+LvI/Sf6zWILGRPUsVEMIo1WwDtoqRiphCfJebCZSX2Wgvj5eGVxXTqLeBXCGu
         ef22jKr/6Zr76GHKTzdD1CQF5CSqDl3MBn1JcDjNNMvB8M7BMJmnN9ms8PsKiitQr9m2
         R88BZoP+m/193FHkyt35GCnfe6FQ3Q2/UHGckU16tarciHKo4qlC4+FqxfJ9S3AGmlnK
         0kgdHTRVUZFJm/K1w+ui7XjvynAr5WNn7Q4ERLzsDKbNmrytF3gOeuFPyBd/ja6Nx9LB
         uVpw==
X-Forwarded-Encrypted: i=1; AJvYcCX8GbxFAL81wRopLB5zBSs8aklGdu/JEril3cXccy7MZWOKKqzxMmXStOUajT0UAwcOkhDimn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ZgApDjqor/uV8bBeYNbPm7V0XXSI88ccePXAQxDo89/i5LFf
	SyjCq3pC0+FoJQZz5DIzbsNq6xUv/syzPlF11C91xzh2iDNaS8II56EeDzrkzL5YJbiKGTrs7N0
	fgI1xbag56R44pgNtSqCh+mLVJioLi1xkI8w/dLJ+
X-Gm-Gg: ASbGncvwVvsNQqK+iecf3rzIzGN/4meR6PNHdt+rfg+jCWfCIcmBsGezskYD7XGuYy2
	NvoofbscwGhj93rINL9oQJP3e1Ht+XKXHw/lO3NC1gVaNndemBFYhFAnv3OFOgraIy9v9V0YDtM
	xy7y7r3o3lsMHoK995njwzO8Rj+xm8A3AF2rZi5EDjL+Zgk2EuM/A1OVm7XFFEHaiDwIlMjPJ/9
	pLXzM8CuS9jmf3+k0wtG+FZR42c1KPGWIxSAAE/
X-Google-Smtp-Source: AGHT+IEjHmDo4KPuA+/sveZn9muwONSBB7vRZtalH5GKSOG3QX576o8Vh9ZDPiB6/QNN0tvmAzFaIqy1EEDsLN+ydVk=
X-Received: by 2002:a17:903:2443:b0:240:4faa:75cd with SMTP id
 d9443c01a7336-2430d1f76f0mr60472055ad.48.1755107573058; Wed, 13 Aug 2025
 10:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802092435.288714-1-dongml2@chinatelecom.cn>
 <20250802092435.288714-2-dongml2@chinatelecom.cn> <CAL+tcoA9Lvc4Cj9zjWVx1FzEQA=d=OnvZRDWA4nE_1GNbEDaRw@mail.gmail.com>
 <CADxym3bD17eL0U0sQkuSZZgNtg7gmvzt0YAA+CiHf9Lw5-+awA@mail.gmail.com>
 <CAL+tcoD80feEhPA_1L7D55UqkRuLSnZ-Kmmdab5J2v9K6uCzTA@mail.gmail.com>
 <CADxym3Zv9+6D0hCEx1KzvW+oAQW5oEDgSHBQPyRjHodezH9O1g@mail.gmail.com>
 <CAL+tcoCCq8Hc3R0_75wZxHUiZrjhfS-q65XFWM69F8pcoJPdyw@mail.gmail.com> <CADxym3bBVEKRNa790CchSyH-WPeXmv9tjTxtmYyJamQv357zKg@mail.gmail.com>
In-Reply-To: <CADxym3bBVEKRNa790CchSyH-WPeXmv9tjTxtmYyJamQv357zKg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 13 Aug 2025 10:52:41 -0700
X-Gm-Features: Ac12FXyx4ErcNKN46eBhzoLzd9zfhqbd1nW9uycrOSGUwjzqL5UmxD07HY05yoA
Message-ID: <CAAVpQUC-bPPar5Q-AoW_sZYrRfLF9Q7Su+163EfmYCBOjqohAA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: tcp: lookup the best matched listen socket
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, edumazet@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, kraig@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:55=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Sun, Aug 3, 2025 at 4:32=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Sun, Aug 3, 2025 at 12:00=E2=80=AFPM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > On Sun, Aug 3, 2025 at 10:54=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Sun, Aug 3, 2025 at 9:59=E2=80=AFAM Menglong Dong <menglong8.don=
g@gmail.com> wrote:
> > > > >
> > > > > On Sat, Aug 2, 2025 at 9:06=E2=80=AFPM Jason Xing <kerneljasonxin=
g@gmail.com> wrote:
> > > > > >
> [......]
> > > >
> > > > I'm trying to picture what the usage can be in the userland as you
> > > > pointed out in the MD5 case. As to the client side, it seems weird
> > > > since it cannot detect and know the priority of the other side wher=
e a
> > > > few sockets listen on the same address and port.
> > >
> > > For the server side, it needs to add all the clients information
> > > with the TCP_MD5SIG option. For socket1 that binded on the
> > > eth0, it will add all the client addresses that come from eth0 to the
> > > socket1 with TCP_MD5SIG. So the server knows the clients.
> >
> > Right, but I meant the _client_ side doesn't know the details of the
> > other side, that is to say, the server side needs to keep sure the
> > client server easily connects to your preferred listener regardless of
> > what the selection algorithm looks like. In terms of what you
> > depicted, I see your point. One question is if the kernel or API
> > provides any rules and instructions to the users that on the server
> > side the sk1 must be selected in your case? Is it possible for other
> > cases where the sk2 is the preferable/ideal one? I'm not sure if it's
> > worth 'fixing' it in the kernel.
>
> What does sk2 represent here? I don't think that the sk2 should
> be preferable. For now, it is selected by the creating order, and
> there should not be a case that relies on the socket creation
> order......would it?
>
> So the socket should be selected by priority, and sk1, which is binded
> on eth0, has higher priority, which is awarded by the users.
>
> I noticed that the net-next is open, so we can use Kuniyuki's
> solution instead, which is better for the performance ;)

I'll post a series next week when Eric is back.

