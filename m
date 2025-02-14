Return-Path: <netdev+bounces-166311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C38BFA356DF
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 07:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664F37A58B1
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729451FC7CE;
	Fri, 14 Feb 2025 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fahOXsf0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C51DDC08
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513664; cv=none; b=ZXw3U5YoG7DLj8hgu03UdGZ1DBj98rWh9gJcNtOvMb5vJrotnjITpZDjeTjrVYrdoElNpvJBp5i/VkO+BXuQfNF3PyJ4yaX0iH2krEW4A16jroVqCoovSKW8LnTl1H3ZLQn1IVBqxMAH857KzASs0vI06XXCvyD+HNMhlVY1VxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513664; c=relaxed/simple;
	bh=x/quGArRa+1auH8j9YUMM4ASyFC7q28b7AB6P7DYOUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByaP1jCUfDondQVMCLiJAcyBG1N1L4cAfvHexRCEPXvx5cqZ61H0+wDmdCly+DrkVGXeyiWGjyOTRtsFjPTn1NZY2BOmtiIli9Ken49VoQeYb3XxDNfm2Sk/YcBcRX0NqBGgFYsrS8dEny8oF3NsCXvxZHtjqUAvHJI9hvzeDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fahOXsf0; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d03d2bd7d2so14185595ab.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 22:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739513662; x=1740118462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhfZiixBvgNUg9xyhXaKUMMIbFMmcepQKy7S9fJZTmQ=;
        b=fahOXsf0FMqjFAbggMBrbDvEDJrHK+BbV6Pdsz3im1HTktTOTfd8xWfhlKLS4vnoSs
         IW31XecvTdbT5pa4HUPeLLlqq5qaHrpc/anCs6iv0D6S2AE8Gk4R3OM7tkuIQMyWy58l
         Jfgi+K/djSTvUo+MwWgKqS5l6vCuclLw4sixgtUFN7WRHcYolbNpRmSVXuyM4XYCBywR
         7SF51exMWhp+MM/xLk5MXD671XtIjJ9MClDPCSV+uF1MB6qQXFfU1hCnfitUrm7bsYhT
         MMQVQXMgN/zCzZfkGY2cUekin4zXuo62Rl4RC8zB4l7mIeQembiLc/O9BzSA+xrlWXI5
         verg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739513662; x=1740118462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhfZiixBvgNUg9xyhXaKUMMIbFMmcepQKy7S9fJZTmQ=;
        b=rk6tHjzyEp6Uv1PzIipCnTgjYQrrUBPjKzhmMJpjuD5SshP4x0aZLwQ7Vaxu2WxpEq
         cVUklFl6BuXqQyDlGCvNarQR3CX2P/h1uZyUVrmffLx8Evo/lRbZPfP58Htql4Ra1sp8
         tho6wce5+EM4x+Djpbyr8Idv55TRU5jCYMrXB9LYyzwvW8hGH/TtJLoi8UwbSg4zCZzb
         Odr3Ss0kHOlQfAI9hmFwnzJG0LkNxXTLhgoozL4jWwrtd/lhINZDfmgWk9McIaKiRhlc
         RpnwOz7zl4+3a+XbLgMobdLIxM664eemjw1yts7fFCW5nXpMMRQQjjI6bobMm1dVeikP
         mQzA==
X-Forwarded-Encrypted: i=1; AJvYcCX3u3PnwbnxRrFg4vU2yZM6Jvf5N5GzsJDlyM1qTMJmEJYL4AYrXXkZVbtsZWlsmE0q8bjRPc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJDWY911mCV6Q1CCMThLuOIzdsEEAPelFony0V3a/PZdxTaAz
	9wy+X/HlTfnIWIQwrH59yXWJmpAQLDAMr2rJTPRNfKSI+d2AQyL0Yuoo64M+RdHNeQxq/3o1jfG
	Ry4Q74TZoUcihRuA0/bH9hq7I/Gk=
X-Gm-Gg: ASbGncvcRGtU9Nk4rySzH83P8eRv2/+JR+N5L43ENgf7Xx01zPbJjWFmw+mLJDMrWNJ
	CpQPJd+upMOKasZTSxZL8t8NGooxyrMEQYACrYBu9Ey4RL3TEXeKdZUw0WTBX5A9Ac75/Ry7M
X-Google-Smtp-Source: AGHT+IFc5S2ybjUvvoWghMonGUBspkJTovehVA68D5K73i4JTpaouM6XOlHLh6jZYdwsJRhViRMoi47xkyaPcDWMGjw=
X-Received: by 2002:a05:6e02:1d07:b0:3cf:ceac:37e1 with SMTP id
 e9e14a558f8ab-3d18c239ce6mr47862305ab.11.1739513661849; Thu, 13 Feb 2025
 22:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213052150.18392-1-kerneljasonxing@gmail.com>
 <94376281-1922-40ee-bfd6-80ff88b9eed7@redhat.com> <CAL+tcoC6r=ow4nfjDvv6tDEKgPVOf-c3aHD56_AXmqUrQMyCMg@mail.gmail.com>
 <CAHS8izO0CdzNti7L3ktg4ynkJSptO96VtrzvtUEkzUiR7h38dg@mail.gmail.com>
 <CAL+tcoAmYayRmZ=GFpzwczudT4pTwRpH+AMv4TkwSP39q3snDQ@mail.gmail.com> <CAHS8izMu+N7S0EDhAMhgPazW=ghVpYjTNa18axqjrk2XTwrhFg@mail.gmail.com>
In-Reply-To: <CAHS8izMu+N7S0EDhAMhgPazW=ghVpYjTNa18axqjrk2XTwrhFg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 14 Feb 2025 14:13:45 +0800
X-Gm-Features: AWEUYZkhSso-FlE9fi9Icf9eTsbEQTTFAYjziCADhc_J5KQ2ltUifXyKEQM98TQ
Message-ID: <CAL+tcoDcUKZygnSmVEuCsECrKY=obHH6K3B2ztHrL+K9kMSPPw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] page_pool: avoid infinite loop to schedule
 delayed worker
To: Mina Almasry <almasrymina@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	ilias.apalodimas@linaro.org, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 12:10=E2=80=AFPM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> On Thu, Feb 13, 2025 at 3:43=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Fri, Feb 14, 2025 at 4:14=E2=80=AFAM Mina Almasry <almasrymina@googl=
e.com> wrote:
> > >
> > > On Thu, Feb 13, 2025 at 2:49=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Thu, Feb 13, 2025 at 4:32=E2=80=AFPM Paolo Abeni <pabeni@redhat.=
com> wrote:
> > > > >
> > > > > On 2/13/25 6:21 AM, Jason Xing wrote:
> > > > > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > > > > index 1c6fec08bc43..e1f89a19a6b6 100644
> > > > > > --- a/net/core/page_pool.c
> > > > > > +++ b/net/core/page_pool.c
> > > > > > @@ -1112,13 +1112,12 @@ static void page_pool_release_retry(str=
uct work_struct *wq)
> > > > > >       int inflight;
> > > > > >
> > > > > >       inflight =3D page_pool_release(pool);
> > > > > > -     if (!inflight)
> > > > > > -             return;
> > > > > >
> > > > > >       /* Periodic warning for page pools the user can't see */
> > > > > >       netdev =3D READ_ONCE(pool->slow.netdev);
> > > > >
> > > > > This causes UaF, as catched by the CI:
> > > > >
> > > > > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/990441/34-=
udpgro-bench-sh/stderr
> > > > >
> > > > > at this point 'inflight' could be 0 and 'pool' already freed.
> > > >
> > > > Oh, right, thanks for catching that.
> > > >
> > > > I'm going to use the previous approach (one-liner with a few commen=
ts):
> > > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > > index 1c6fec08bc43..209b5028abd7 100644
> > > > --- a/net/core/page_pool.c
> > > > +++ b/net/core/page_pool.c
> > > > @@ -1112,7 +1112,13 @@ static void page_pool_release_retry(struct
> > > > work_struct *wq)
> > > >         int inflight;
> > > >
> > > >         inflight =3D page_pool_release(pool);
> > > > -       if (!inflight)
> > > > +       /* In rare cases, a driver bug may cause inflight to go neg=
ative.
> > > > +        * Don't reschedule release if inflight is 0 or negative.
> > > > +        * - If 0, the page_pool has been destroyed
> > > > +        * - if negative, we will never recover
> > > > +        *   in both cases no reschedule is necessary.
> > > > +        */
> > > > +       if (inflight <=3D 0)
> > > >                 return;
> > > >
> > >
> > > I think it could still be good to have us warn once so that this bug
> > > is not silent.
> >
> > Allow me to double-check what you meant here. Applying the above
> > patch, we do at least see the warning once in
> > page_pool_release_retry()->page_pool_release()->page_pool_inflight()->W=
ARN()
> > before stopping the reschedule.
> >
>
> Ah, I see. I had missed indeed that we warn in page_pool_inflight() if
> we see anything negative there anyway. Nevermind then. Thanks!

Okay, then a one-liner patch is enough :)

Thanks for the review.

