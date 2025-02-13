Return-Path: <netdev+bounces-165730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B10A33430
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936493A7BDA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AEC4DA04;
	Thu, 13 Feb 2025 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXQpQ0lO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62035961
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407445; cv=none; b=s+ho6X/srYSsd/SKY+CztUjc5O2gh9WfxiKYCTbCoenovvvpIYo3mPsHwzZ/3BZw64m77lZhyfq89kz/qiA/LBFhKLTXd0k32aVwppUZH75gLm7e2qcR6tuv58svkGKpyzFU5HulBcIF3JvjPFx4ACVgaUvgCpPR0IxjA1C04YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407445; c=relaxed/simple;
	bh=bcEsJfytYxSBnF+w/UN1f293qxafCgx/oocj7TLk/x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFt6bWEmgewPOmDKJXpIcuh+t3P/854R4Xq/hfJpyvKdJaloQKN3PSqtDGOV2NJRHXQGT/XRVnc82TulYANlTEm5JjSiRuZsfN/oKxQuIRXOfU7BCuLARYLzZatdgdu6HbQZWvh4OEmKWLn/vAepjQK5LtKUXasqUtnbBhdaD5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXQpQ0lO; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85527b814abso6057839f.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 16:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739407442; x=1740012242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL76b5Jy1KHSZfdP3r8df8oZlxIdnj3ZFR57VonsQF8=;
        b=aXQpQ0lO2X1l69c8ypPfBUpkoJQwlzTOf07f/QEmAkUgMSuqqG51VJN3TIL7pVrIeA
         ZrNgey8bH1cDkzBiQHqkqeZk5ToBLOm4QITVEV0W7/0yuLLqWarZMNbjyF6QnvsXI42Y
         uc+cLkNxaQXDYJkd96alzOosZRCnCshWRdtK7rp6c7c+Ec5494YwADmCHiyfY+5Udck4
         N1AfxNVLbepAqNklkY+T3pI7zYgyL0FxLyRRayfGNYHUnKNcWH2jDCmmDPAR/mq+EfvZ
         jsszSi+0XenT7kEgmlU67H2ZkbgwVoGfRP284dZt5Rp3cuOkm03oq5qfV9gF0mpvY3fy
         mq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407442; x=1740012242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iL76b5Jy1KHSZfdP3r8df8oZlxIdnj3ZFR57VonsQF8=;
        b=cSpoVyXCRyySaO0fO8Mh2/2g+AaeeIAV+F/93HiBpTGBWU7uAD+wVvCqK+Q46aBe4V
         sy7lEGUfHPpRVsrKxtdQIKDhW+vf2xCAudG7PXRrc4k9EYY1KRyvZkrowNWMwFFe70oW
         Fa2FEkBW+L+fDWysWOrhzT3LHtoHBoi2aQe7Q6ExlUD3TBwCO0CEY0MciPIlDkryjn0P
         oRAPc5P+jztjWfVqWi2xRJ7nEBXtFCU1elBIfMy6CfVgFgvM4UNkikqtb3LBhQv2uFip
         ezyH3k/Q9+HVsT/mu88L8ogk96CbcOtOLu/xQjXOoUk2xmt42HqBlqj0MTJZYwShKaR8
         /rAg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Q27Y3oCVeSGAfux6Q/BMfWVhcUk4txT6xJ1w1WBQ0t3WzSyV7AkBJ9l/AGCqSjhNTmSbjRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl3/sgKrVXEAT5m5CRvrEd3Lhp9PFGHtOltLgsQoAPRkluoiac
	az84WtGdm3HET8iC23oBiPbpDJV/EChbcBhuMznd+VuG24LW3cxXCYqlcSITPYwMlm7llna0j9x
	XnmegfUcGLdNE8GBnqXTZb+bJgZI=
X-Gm-Gg: ASbGncv4ro0xNtBMD2vGV84iyRumBydXWPOASRh8o3XpDb6za8t8iu2L2tCZ6/uIWkT
	ed0/B3OYJU7ooYlPNTHd+odvDUn2t0DeF0jY/iag7h6e2IelZyksNnHXRJso87RxWSo4QKk8=
X-Google-Smtp-Source: AGHT+IF/uvJ6kG03YzhhKwZ8UVzbaT6aZmnrAKW7d+1lchmIBXjL7A2/qojMRzMbyOLfU/HezmVhv0LP/fEpXLajd8I=
X-Received: by 2002:a05:6e02:13aa:b0:3cf:fa94:cad with SMTP id
 e9e14a558f8ab-3d17be17d7emr53506735ab.8.1739407442307; Wed, 12 Feb 2025
 16:44:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210130953.26831-1-kerneljasonxing@gmail.com>
 <CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
 <CAL+tcoDrxSgGU3G0a=OqpYVD2WAayLKGy=po5p7Tm+eHiodtNw@mail.gmail.com>
 <CAHS8izNSG_fC7t3cAaN0s3W2Mo-7J2UW8c-OxPSpdeuvK-mxxw@mail.gmail.com>
 <CAL+tcoD0CT_JmDcLEY6VGq2_+oU=TgHRfY6LPG70By3gm5CP0A@mail.gmail.com> <CAHS8izNyeOThGCt=tO-0xoAEOsoQJLF_DJxF1iV8zJnJoyW-=g@mail.gmail.com>
In-Reply-To: <CAHS8izNyeOThGCt=tO-0xoAEOsoQJLF_DJxF1iV8zJnJoyW-=g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 08:43:26 +0800
X-Gm-Features: AWEUYZmYE0Yumi63gLYiK-HDSZ2oIDnZPG_YGX7y2MllQdjxPQs-uIb5XKWzBTE
Message-ID: <CAL+tcoBa9uz7i-9_-wtakpQkmeiX55RpQn2zkpDnXFBAXutkYw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:38=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Wed, Feb 12, 2025 at 3:39=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 3:24=E2=80=AFAM Mina Almasry <almasrymina@googl=
e.com> wrote:
> > >
> > > On Tue, Feb 11, 2025 at 7:14=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Wed, Feb 12, 2025 at 10:37=E2=80=AFAM Mina Almasry <almasrymina@=
google.com> wrote:
> > > > >
> > > > > On Mon, Feb 10, 2025 at 5:10=E2=80=AFAM Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > >
> > > > > > If the buggy driver causes the inflight less than 0 [1] and war=
ns
> > > > >
> > > > > How does a buggy driver trigger this?
> > > >
> > > > We're still reproducing and investigating. With a certain version o=
f
> > > > driver + XDP installed, we have a very slight chance to see this
> > > > happening.
> > > >
> > > > >
> > > > > > us in page_pool_inflight(), it means we should not expect the
> > > > > > whole page_pool to get back to work normally.
> > > > > >
> > > > > > We noticed the kworker is waken up repeatedly and infinitely[1]
> > > > > > in production. If the page pool detect the error happening,
> > > > > > probably letting it go is a better way and do not flood the
> > > > > > var log messages. This patch mitigates the adverse effect.
> > > > > >
> > > > > > [1]
> > > > > > [Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
> > > > > > [Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pag=
es
> > > > > > ...
> > > > > > [Mon Feb 10 20:36:11 2025] Call Trace:
> > > > > > [Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
> > > > > > [Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
> > > > > > [Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
> > > > > > [Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
> > > > > > [Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
> > > > > > [Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
> > > > > > [Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
> > > > > > [Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
> > > > > >
> > > > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > > ---
> > > > > >  net/core/page_pool.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > > > > index 1c6fec08bc43..8e9f5801aabb 100644
> > > > > > --- a/net/core/page_pool.c
> > > > > > +++ b/net/core/page_pool.c
> > > > > > @@ -1167,7 +1167,7 @@ void page_pool_destroy(struct page_pool *=
pool)
> > > > > >         page_pool_disable_direct_recycling(pool);
> > > > > >         page_pool_free_frag(pool);
> > > > > >
> > > > > > -       if (!page_pool_release(pool))
> > > > > > +       if (page_pool_release(pool) <=3D 0)
> > > > > >                 return;
> > > > >
> > > > > Isn't it the condition in page_pool_release_retry() that you want=
. to
> > > > > modify? That is the one that handles whether the worker keeps spi=
nning
> > > > > no?
> > > >
> > > > Right, do you mean this patch?
> > > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > > index 8e9f5801aabb..7dde3bd5f275 100644
> > > > --- a/net/core/page_pool.c
> > > > +++ b/net/core/page_pool.c
> > > > @@ -1112,7 +1112,7 @@ static void page_pool_release_retry(struct
> > > > work_struct *wq)
> > > >         int inflight;
> > > >
> > > >         inflight =3D page_pool_release(pool);
> > > > -       if (!inflight)
> > > > +       if (inflight < 0)
> > > >                 return;
> > > >
> > > > It has the same behaviour as the current patch does. I thought we
> > > > could stop it earlier.
> > > >
> > >
> > > Yes I mean this.
> >
> > I'm going to post the above diff patch in V2. Am I understanding right?
> >
>
> Please also add Jakub's request, i.e. a code comment indicating why we
> return early.

Got it.

>
> Also, now that I look more closely, we want to make sure we get at
> least one warning when inflight goes negative, so, maybe something
> like (untested, may need some iteration):

Good suggestion.

>
> ```
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 2ea8041aba7e..6d62ea45571b 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1113,13 +1113,12 @@ static void page_pool_release_retry(struct
> work_struct *wq)
>         int inflight;
>
>         inflight =3D page_pool_release(pool);
> -       if (!inflight)
> -               return;
>
>         /* Periodic warning for page pools the user can't see */
>         netdev =3D READ_ONCE(pool->slow.netdev);
>         if (time_after_eq(jiffies, pool->defer_warn) &&
> -           (!netdev || netdev =3D=3D NET_PTR_POISON)) {
> +           (!netdev || netdev =3D=3D NET_PTR_POISON) &&
> +           inflight !=3D 0) {
>                 int sec =3D (s32)((u32)jiffies - (u32)pool->defer_start) =
/ HZ;
>
>                 pr_warn("%s() stalled pool shutdown: id %u, %d
> inflight %d sec devmem=3D%d\n",
> @@ -1128,7 +1127,15 @@ static void page_pool_release_retry(struct
> work_struct *wq)
>                 pool->defer_warn =3D jiffies + DEFER_WARN_INTERVAL;
>         }
>
> -       /* Still not ready to be disconnected, retry later */
> +       /* In rare cases, a driver bug may cause inflight to go negative.=
 Don't
> +        * reschedule release if inflight is 0 or negative.
> +        *      - If 0, the page_pool has been destroyed
> +        *      - if negative, we will never recover
> +        * in both cases no reschedule necessary.
> +        */
> +       if (inflight < 1)

Maybe I would change the above to 'inflight <=3D 0' which looks more
obvious at the first glance? :)

> +               return;
> +
>         schedule_delayed_work(&pool->release_dw, DEFER_TIME);
>  }
> ```

I will test it. Thanks, Mina.

Thanks,
Jason

>
> --
> Thanks,
> Mina

