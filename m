Return-Path: <netdev+bounces-166286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA47A35598
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 05:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011A53A5290
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 04:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80797155751;
	Fri, 14 Feb 2025 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQAHBNso"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C31547E0
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506202; cv=none; b=fj7Ffxvo5i6tVf4KhKdNRf0u8qsnnMnoTE+AJXc/3GxkdorwZ24Hn1bDt9s9GYsM31ZiX8Kf/NPPN545QTBXFr80qcMvteiWhkII+Xwdx/pEUYAbuW6RuJRRq1ehs5Fgbo+tBkPBvt9GUcMUhcpwADPHI4bHP4L5c61heiY1P34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506202; c=relaxed/simple;
	bh=/+Ke1eOKrHChvO9eXSh8eX8+CTzo3VTqU0B8mb42rYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgXI6f1VyhA7SZWhhFUB+ZWIaGttxVC1fRfelmFfXR/qe3eXBdiswIi7pObpvhWFBPR7KhCqJM/TWW+kGrq27j27KL9wumFCg3NOseaxW5HVdZctQeV4Q+JbpBk6ZigzCikcfk1lT54njRB3TX6sOiAgWloqfTZUvz7TNDwkgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQAHBNso; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f8c280472so60515ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 20:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739506200; x=1740111000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGI+y1htnEUVkeSBP2UinQW8qxrVS8i1NJJtCKduNFM=;
        b=JQAHBNsoIoV191dtfwD8+LSxZLXEKQi9mivI0AtpQ8IhsIANqWOJ/4TcnbLV03O/3d
         16KLLnn7Y3EEokRYWT1odXr29kydHYTVWQfkG1ivaQ9Zys0a5qqMgnKYTRyt+P4MlP1h
         VBg2vw1F4PcvJJ57ByYXrKLXrWowpqWUZzCehYLoLuXC3Lc4k50ovmvklCrjxf1OTaA9
         v2Zt6fcWBbU6my89NyS3lUpVeaEkX3SpsU5SK6j64OdKSW9ZuzrCagYx9dvHWBkj3cBM
         Dqp1ob+HCK5tYQR3G1uIX0yI/sJtTHNgA1YDuO06AoAeKteLReARDTTTQ3z9V85GSeuM
         Malg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739506200; x=1740111000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGI+y1htnEUVkeSBP2UinQW8qxrVS8i1NJJtCKduNFM=;
        b=wYJbk2dT8EH5eL2Dw+hxt176yL9adcbb0qqKRAyMYhRCpJ9TZm9YWoxuJjAb/fYL0R
         KCkKRUOq+iW0rkb9TOKCGIM1i8KYLHAOrXxvxWf32HyLQy4QtSzB2qpzFopj0shVNQLb
         FVIhJEw39mMMCJ1IEuS9Nb2W6FJ/Bhtml+gsNovHLz7BTRXlOFAjtR8PZ5aMkMxAMUDo
         Bh/5vyhnz8fAerHhz9SGAzgFPhTXmPODtr/xHTzmb+AQM4nDFwuHpB8OKS33JCaPSUkG
         Ra5pL3PRhBT0IT+ZWbF5TCFtrKAbA908uZGtqZGr2/AF2GbZCjylVTydp+2xl7mbz2Yw
         nU5w==
X-Forwarded-Encrypted: i=1; AJvYcCVdiJWJHxpwS/6cnle3gv1+cVvoZWkQObobdWgBLuJeAAhvH43cKtXAffsoW24SIJ7h9fkbU+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyax85REqAhj17WoM2pgqlu2Byy8hj3+wPU0bDT+N33Q83w7CWE
	cSj/JMC1cWqEG8txXIXXE5WgA12yCS92ZyYHuyZzs3vL7Geu2xIMAququ5BrMjVv57pSIjeg48M
	fPeqnLmniARAfFWORDmdcvJePKid4upjcWOhz
X-Gm-Gg: ASbGncs8N+HSHteO82sUk4vDPGeqm4np9aHnABXRdlErFRHyliCPc+DZTFRpyoivD9t
	FGmyUqj7ZE6fUUF2PyGumBHXbAHSxa50dKAH8NzOXeicfWMXWnk3eqc9N92VDaUupPtR6q3wk
X-Google-Smtp-Source: AGHT+IEE5rKi9Lu2TmYX/uU6k2swG3MoU2Le9D0ne8goSqyjwkltS0ptETBwTwfj0/Ghy/6B8Z/TxrMpByALfrtI1Xw=
X-Received: by 2002:a17:902:f64f:b0:220:c905:689f with SMTP id
 d9443c01a7336-220eda640acmr957545ad.25.1739506199623; Thu, 13 Feb 2025
 20:09:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213052150.18392-1-kerneljasonxing@gmail.com>
 <94376281-1922-40ee-bfd6-80ff88b9eed7@redhat.com> <CAL+tcoC6r=ow4nfjDvv6tDEKgPVOf-c3aHD56_AXmqUrQMyCMg@mail.gmail.com>
 <CAHS8izO0CdzNti7L3ktg4ynkJSptO96VtrzvtUEkzUiR7h38dg@mail.gmail.com> <CAL+tcoAmYayRmZ=GFpzwczudT4pTwRpH+AMv4TkwSP39q3snDQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAmYayRmZ=GFpzwczudT4pTwRpH+AMv4TkwSP39q3snDQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 13 Feb 2025 20:09:46 -0800
X-Gm-Features: AWEUYZlqBgFb-91NqaMyRM2bzf578smdLr5KLhzM3nhFQrihg7FwV5bhOfx2uuU
Message-ID: <CAHS8izMu+N7S0EDhAMhgPazW=ghVpYjTNa18axqjrk2XTwrhFg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	ilias.apalodimas@linaro.org, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 3:43=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Feb 14, 2025 at 4:14=E2=80=AFAM Mina Almasry <almasrymina@google.=
com> wrote:
> >
> > On Thu, Feb 13, 2025 at 2:49=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Thu, Feb 13, 2025 at 4:32=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > >
> > > > On 2/13/25 6:21 AM, Jason Xing wrote:
> > > > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > > > index 1c6fec08bc43..e1f89a19a6b6 100644
> > > > > --- a/net/core/page_pool.c
> > > > > +++ b/net/core/page_pool.c
> > > > > @@ -1112,13 +1112,12 @@ static void page_pool_release_retry(struc=
t work_struct *wq)
> > > > >       int inflight;
> > > > >
> > > > >       inflight =3D page_pool_release(pool);
> > > > > -     if (!inflight)
> > > > > -             return;
> > > > >
> > > > >       /* Periodic warning for page pools the user can't see */
> > > > >       netdev =3D READ_ONCE(pool->slow.netdev);
> > > >
> > > > This causes UaF, as catched by the CI:
> > > >
> > > > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/990441/34-ud=
pgro-bench-sh/stderr
> > > >
> > > > at this point 'inflight' could be 0 and 'pool' already freed.
> > >
> > > Oh, right, thanks for catching that.
> > >
> > > I'm going to use the previous approach (one-liner with a few comments=
):
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index 1c6fec08bc43..209b5028abd7 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -1112,7 +1112,13 @@ static void page_pool_release_retry(struct
> > > work_struct *wq)
> > >         int inflight;
> > >
> > >         inflight =3D page_pool_release(pool);
> > > -       if (!inflight)
> > > +       /* In rare cases, a driver bug may cause inflight to go negat=
ive.
> > > +        * Don't reschedule release if inflight is 0 or negative.
> > > +        * - If 0, the page_pool has been destroyed
> > > +        * - if negative, we will never recover
> > > +        *   in both cases no reschedule is necessary.
> > > +        */
> > > +       if (inflight <=3D 0)
> > >                 return;
> > >
> >
> > I think it could still be good to have us warn once so that this bug
> > is not silent.
>
> Allow me to double-check what you meant here. Applying the above
> patch, we do at least see the warning once in
> page_pool_release_retry()->page_pool_release()->page_pool_inflight()->WAR=
N()
> before stopping the reschedule.
>

Ah, I see. I had missed indeed that we warn in page_pool_inflight() if
we see anything negative there anyway. Nevermind then. Thanks!

