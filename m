Return-Path: <netdev+bounces-166207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9409EA34F1F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319E47A4258
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D1224A07E;
	Thu, 13 Feb 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AF/uQsLP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9E28A2CB
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477660; cv=none; b=m9ogB2ZYhmzFsKyklLP9qu8fXAxLq9DvBmVRu4qu+IxGG17BboMQKxhYcLEga6jXDPiK0kDb9quFW0ok+GsAxAS7FmIRleboTvhTJX22m0AqJuujM3Md9DafeZUM6nICerwh1fO7JyU0U+GFBgX8KLiw/jkcgfKZT10faiXidCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477660; c=relaxed/simple;
	bh=q5BYBj5HZixx6ywC6iODBrmgHLR1RkyERCgct7wK6Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d59uBwBRCivDh/mgfDOsmOkp4X8Us/edYRkcyCfMARc4npawlgvvYRk43ZxmcRFiK4xrCCA98i1WDygFYUUbJ1sg06+vun50eOSd3bvH9RDB2CzorsSeHbucWN2ncRVqzHQQABUp1IoGDdPe64Kwx0u4Ltzfxi8DHVRncU/Ov/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AF/uQsLP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f8c280472so26905ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 12:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739477658; x=1740082458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj2t3514S+fGsSpJdcIv8lVN9kA0Cb6njvavzc1RZ9k=;
        b=AF/uQsLPnqV3lN+2rIUD4xHxVjHI+/MdazORnOFndCC9FZ27fUy+ulcWenp50ZGe5l
         +JhKYZF59Kh+62MnzkDIUBUY7DL/E6oUrD86fddBIkR6zIt90sXsEZBOzQL6bvOdY7sp
         tCXMdYgVERji4BaeytcvsWaYD2NBpOSi/v4V16xxUxmE4d9N2XL6QrV15xUO9Hhj1zGU
         LXj0jEau9Xrm+8gzEk9SiN92d56T2Hm0XeqU9Udu5nqrJhjUnhHucpmSiAMrNRbmTVYg
         uPpmikDSIRGd1d7IgI94TGhQTWVNGDixDHaZz7MIzpPauoPxFr3W1/zPLKtqcGf3cYxC
         t2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477658; x=1740082458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj2t3514S+fGsSpJdcIv8lVN9kA0Cb6njvavzc1RZ9k=;
        b=BjZ7AEJ03GIZF7U5p6wDDlPpZbG7xEfH+dBc0RhuQcMZpdR4YHziUIlFYVwNUFt6D7
         q6c/YWXWAdkGem0dZz6dUI6+GxNuv11/Ma2luJqqpgCQx9dbSxJt9kNEgWFgTQpBRN6D
         iV3vIfTKZrxihC+d7g/EDtCP5F2DBy0lbARPfgtb7okHac5qhfsIBrXH3qHVZQHJNcXQ
         vULkHXVZ8FdP6EtHkbEm7oKqDoSLIz+5GG8n6C9afcir0AWGhQI0jhKZh2EoI4sriX+b
         I+CuKGicQgDtVsj3SPr91KYV1T6UYNDN9coXzkWnIKyUOmIlBY59xnfJw2yqT7Yyc3eq
         eo3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgdTIEWhRBT3PIcKdrJnPaWyfwoOpWpFXXH/TOuTO/YzLQkInMLd7mhz4kvY0Ay4Zntjpiz+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7LmtWXy/VkZ60/MGenl53/x43TdbpRTA0wibYwUxrWGExxgBp
	50RJBbNU+QGdokTkGQK7A4FE95VSc5mw2LpPtb4XAIq/tyOSKfwqHNRPYbhsAXB9iHhNIVDK2tw
	4Io0HMq71kZwE3ZqCmQbrGjqrpBtXRT4h/kSM
X-Gm-Gg: ASbGncsajj2Pb/1ANr1WxzSobwic+EqyUxFfZ6ki2zvA6ebMF/tMxoYDOy6kQIoHKS+
	1qVd84V//G2rd00osycTR3inMkttq7D4d7OdwFxQ4Mew0ziil4qwMuFRG8oa2H7uJhyEJcPtF
X-Google-Smtp-Source: AGHT+IHyBD5p90pqBaTdnXNe9dQV33638MOkRhooolsc65z1YZeaVDTLLC/9p0e/wj1fgHMPZivqYCidB1+k3hYMCj8=
X-Received: by 2002:a17:902:6949:b0:21f:2828:dc82 with SMTP id
 d9443c01a7336-220ecc255bamr389615ad.2.1739477657553; Thu, 13 Feb 2025
 12:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213052150.18392-1-kerneljasonxing@gmail.com>
 <94376281-1922-40ee-bfd6-80ff88b9eed7@redhat.com> <CAL+tcoC6r=ow4nfjDvv6tDEKgPVOf-c3aHD56_AXmqUrQMyCMg@mail.gmail.com>
In-Reply-To: <CAL+tcoC6r=ow4nfjDvv6tDEKgPVOf-c3aHD56_AXmqUrQMyCMg@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 13 Feb 2025 12:14:04 -0800
X-Gm-Features: AWEUYZlM3wqu2n1FKBGn2bv8ljUN7Ghj3NccOKAzpjZBlzFDVsPAIvNZZEKOlbQ
Message-ID: <CAHS8izO0CdzNti7L3ktg4ynkJSptO96VtrzvtUEkzUiR7h38dg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	ilias.apalodimas@linaro.org, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 2:49=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Feb 13, 2025 at 4:32=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 2/13/25 6:21 AM, Jason Xing wrote:
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index 1c6fec08bc43..e1f89a19a6b6 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -1112,13 +1112,12 @@ static void page_pool_release_retry(struct wo=
rk_struct *wq)
> > >       int inflight;
> > >
> > >       inflight =3D page_pool_release(pool);
> > > -     if (!inflight)
> > > -             return;
> > >
> > >       /* Periodic warning for page pools the user can't see */
> > >       netdev =3D READ_ONCE(pool->slow.netdev);
> >
> > This causes UaF, as catched by the CI:
> >
> > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/990441/34-udpgro=
-bench-sh/stderr
> >
> > at this point 'inflight' could be 0 and 'pool' already freed.
>
> Oh, right, thanks for catching that.
>
> I'm going to use the previous approach (one-liner with a few comments):
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1c6fec08bc43..209b5028abd7 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1112,7 +1112,13 @@ static void page_pool_release_retry(struct
> work_struct *wq)
>         int inflight;
>
>         inflight =3D page_pool_release(pool);
> -       if (!inflight)
> +       /* In rare cases, a driver bug may cause inflight to go negative.
> +        * Don't reschedule release if inflight is 0 or negative.
> +        * - If 0, the page_pool has been destroyed
> +        * - if negative, we will never recover
> +        *   in both cases no reschedule is necessary.
> +        */
> +       if (inflight <=3D 0)
>                 return;
>

I think it could still be good to have us warn once so that this bug
is not silent.

We can return early if page_pool_release(pool) =3D=3D 0, and then only
schedule_delayed_work() after the warning if inflight is positive.

--=20
Thanks,
Mina

