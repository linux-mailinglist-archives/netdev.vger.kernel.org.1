Return-Path: <netdev+bounces-165716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E26FA3337A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D4316117A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 23:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC67211712;
	Wed, 12 Feb 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaUwblz+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C5207650
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403577; cv=none; b=eQ+ndp2VHB3zwuUOGoHfsEDu7WgkBKItthaVZpQtSKqUJZ9fD67SpniQlpnpKP/Zy804u6oFwj6DfXi2pk27AOXrv+u4QPkTTRyj8uTHZz1VDL6RWnhdTU+TmiAUbDZxPFtvKzLGNAVeSOOSz5NC1uCEaq8d8zWeydNdRrFdqVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403577; c=relaxed/simple;
	bh=QTRnP5ud8oeAaVo51IK/cbUVHXcCuGMQU1ytEJRAIWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3tmLKq8JtFmXc3GuYQlpmqtvu22CEHIpgXPz/qbuzheem8qDDTlQS8a2Hpprh+DRitbc0bGCenUDz69Y7oFehgoeapahc5t1Hxx/MKwLOT6NnT+9Xhj4Lcv0d/lDoSUYsXgCMG0yMVkKPV+egueQy4SOBLbJfSrwkUrRcDZngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaUwblz+; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d144f1f68bso704645ab.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 15:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739403575; x=1740008375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So00V1ZNE+4GhJnTT7iS7fK9TDTzfkgW0J4oS5JvmJI=;
        b=QaUwblz+P+uiQbYx/uaLh0XFV4KzIV1wwvicXij2uUIwlDpf+5+oxHJk4sh7eM5cQF
         3H+szw5Q4p+995lde57vuQ1wZGIfN+Tv5EJKS07w3Qa/BYsgbTGs2yUL+sRmGGkejI3g
         VWz3/1Iqm9RRWpk0Z0EnintzR1WivQlia9H2mWvkAITKiuSzpKT0YFcU3IG4wFXTZrYL
         C+Kh1/E7nOIeInYeyftK7g0PrIx2BLbkQwBf0c2ki+NpjBb8GAY9k1mHJo7DaDLpuJne
         uhhxOkZFVxMtnBT5ISr1CiBUiKBFb9NkwBZnID5pYjv9yb55aMvHGTOAhwVDTH+rXKyK
         oa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739403575; x=1740008375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=So00V1ZNE+4GhJnTT7iS7fK9TDTzfkgW0J4oS5JvmJI=;
        b=N7v1G/8evOZAOZ4HwmKhBHoOwYhfbKc6Vy+Kv8JKV17rfWnyOsuRl0y/yRuW1ylcES
         b0ZPdNhP0g/tt97t1rFXJrIu+/KXBlOwP5nmYrehqwN3kRagp6gPyFwPipilg1wmOifI
         yv9NMcJEwE6stnnloN/vBamTqi1FNItSJiwKdViUBXx3WD5Z5Z+4thhQyWxoipkOVkGv
         DAPSjLe9k23OXk19bfq//RPqR+S79WDrkWQjsk5BYC4sPmx/cqjO/I10ygR2JUndKBtA
         Q9TX8q80sgMKEwM9Ax+6GmlZmBNTya05J+E7vd8cUBkOi6zGkDLfKxH7FCg7ltNbmSY9
         x+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtzVF1t5eu18xHCq94WwRB6LVyk2MZ+LieU3x6zPuZ1Q1FIyaaXR0H/SQ3AijzUxqfquJNM1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YykYXc93UsGf8ltFWw43cc8pAvv2qiF4pJt76GZ2dP6pjlPMCOm
	wz1pOYUFHorCYC5CNKqnoDNIt2PoHmkk29InXiyuup16KvWqSPS/bs7PkLsUkGdEzCEIaRssDYC
	9fXrpks0mPqZH8GDM2Tik0Vs5dn0=
X-Gm-Gg: ASbGncswt7T/tyFvQfzIm9mLBPuPZGN3Fk/wtKpaW8qOkafPXZtrFfyqYwyLXcZqXRz
	2P65EoF4DVmbEeXQpVZw3aHBFzq9EXRg/LlQFmiluFac4u/OhO7yq3vT8hNzigP36AEFZ8klS
X-Google-Smtp-Source: AGHT+IGNE4pdWiDGn8RrrZDjjmpGpb5f30i/daUEM4I7aNqqL7FyQFNQIdcyI76yPotRpi6631ET9khVCAIS6V0KTbQ=
X-Received: by 2002:a05:6e02:3e06:b0:3d0:443d:a5ad with SMTP id
 e9e14a558f8ab-3d18c21e821mr12776165ab.2.1739403575197; Wed, 12 Feb 2025
 15:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210130953.26831-1-kerneljasonxing@gmail.com>
 <CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
 <CAL+tcoDrxSgGU3G0a=OqpYVD2WAayLKGy=po5p7Tm+eHiodtNw@mail.gmail.com> <CAHS8izNSG_fC7t3cAaN0s3W2Mo-7J2UW8c-OxPSpdeuvK-mxxw@mail.gmail.com>
In-Reply-To: <CAHS8izNSG_fC7t3cAaN0s3W2Mo-7J2UW8c-OxPSpdeuvK-mxxw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 07:38:59 +0800
X-Gm-Features: AWEUYZmDX_uKETejy-sjgT6PhR5iUkZtXX-S0zD8CrTNa9kM0-btmD_4hkN07rc
Message-ID: <CAL+tcoD0CT_JmDcLEY6VGq2_+oU=TgHRfY6LPG70By3gm5CP0A@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 3:24=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Tue, Feb 11, 2025 at 7:14=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Wed, Feb 12, 2025 at 10:37=E2=80=AFAM Mina Almasry <almasrymina@goog=
le.com> wrote:
> > >
> > > On Mon, Feb 10, 2025 at 5:10=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > If the buggy driver causes the inflight less than 0 [1] and warns
> > >
> > > How does a buggy driver trigger this?
> >
> > We're still reproducing and investigating. With a certain version of
> > driver + XDP installed, we have a very slight chance to see this
> > happening.
> >
> > >
> > > > us in page_pool_inflight(), it means we should not expect the
> > > > whole page_pool to get back to work normally.
> > > >
> > > > We noticed the kworker is waken up repeatedly and infinitely[1]
> > > > in production. If the page pool detect the error happening,
> > > > probably letting it go is a better way and do not flood the
> > > > var log messages. This patch mitigates the adverse effect.
> > > >
> > > > [1]
> > > > [Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
> > > > [Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
> > > > ...
> > > > [Mon Feb 10 20:36:11 2025] Call Trace:
> > > > [Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
> > > > [Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
> > > > [Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
> > > > [Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
> > > > [Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
> > > > [Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
> > > > [Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
> > > > [Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
> > > >
> > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > ---
> > > >  net/core/page_pool.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > > index 1c6fec08bc43..8e9f5801aabb 100644
> > > > --- a/net/core/page_pool.c
> > > > +++ b/net/core/page_pool.c
> > > > @@ -1167,7 +1167,7 @@ void page_pool_destroy(struct page_pool *pool=
)
> > > >         page_pool_disable_direct_recycling(pool);
> > > >         page_pool_free_frag(pool);
> > > >
> > > > -       if (!page_pool_release(pool))
> > > > +       if (page_pool_release(pool) <=3D 0)
> > > >                 return;
> > >
> > > Isn't it the condition in page_pool_release_retry() that you want. to
> > > modify? That is the one that handles whether the worker keeps spinnin=
g
> > > no?
> >
> > Right, do you mean this patch?
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 8e9f5801aabb..7dde3bd5f275 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -1112,7 +1112,7 @@ static void page_pool_release_retry(struct
> > work_struct *wq)
> >         int inflight;
> >
> >         inflight =3D page_pool_release(pool);
> > -       if (!inflight)
> > +       if (inflight < 0)
> >                 return;
> >
> > It has the same behaviour as the current patch does. I thought we
> > could stop it earlier.
> >
>
> Yes I mean this.

I'm going to post the above diff patch in V2. Am I understanding right?

>
> > >
> > > I also wonder also whether if the check in page_pool_release() itself
> > > needs to be:
> > >
> > > if (inflight < 0)
> > >   __page_pool_destroy();
> > >
> > > otherwise the pool will never be destroyed no?
> >
> > I'm worried this would have a more severe impact because it's
> > uncertain if in this case the page pool can be released? :(
> >
>
> Makes sense indeed. We can't be sure if the page_pool has already been
> destroyed if inflight < 0. Ignore the earlier suggestion from me,
> thanks.

Thanks for the review.

Thanks,
Jason

>
> --
> Thanks,
> Mina

