Return-Path: <netdev+bounces-165739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DC1A3345A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F431642B9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E4422098;
	Thu, 13 Feb 2025 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBRQ/PsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CED6FC3
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739408502; cv=none; b=c2J/ZPVqE9y5xFIt3g/UIDzB8wVwGCfPyZM8k0n37Ip23o+QpVaJgJ+u/Fej81ilHLrLhKwNNP5q8FTE+UtLE83R14JOuZGg/FLYqyLu6wgZoqzG8nt6KbXyo6XOxZ20t96CwBxPmm3kloKv3iIYcvrk3uSnQeQIqY9nqw0l+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739408502; c=relaxed/simple;
	bh=swN01M7f5wqK0GQrDqHnU/MaClmDUJ2TakcP69V4Ncw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ptca5qDPRj90r9y4EiXDiRuF3EUN4rFJa80VH4dYlR8Ex8uVCzUNvSioOpTiDkHevdRtUPbdCQmBD3y9v1lblFMc6Q6PKuiA9ehTvQgCc0sVZg3m5QYSc3dtE1ZXWzMenrFg0fYvosqWwKaBy/YcN5Wnv5HbV4WYGxYSujEMdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBRQ/PsK; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3cfcf8b7455so2303495ab.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739408500; x=1740013300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl8JJHcNH+3+3Q75U4zc6obkA4164oDMpCFa4xStX/s=;
        b=iBRQ/PsKQ5XcwkK6cdOsxlKL/T6o5N1PBp7gHz7O3OMSj6RaJziZzfDIEPSN54vHcc
         rRXAyt6u5TXabmJx/ynK+S4TqGunuwCmZSG2FklwI8H6FldSoMQECIM60Vh9mnK/MsM4
         RuzG/VN3YNP3uTfXPdEMgV184UldSm2Bpf7NUfsZBL8JN0+gljwfRVdo6p1yXLnm9OkT
         n77Nkht+q5Y8qL8Uc/xu4ZdJAZ43CFF4OgmflB56gLi9Nf/6wFuv6jZQzaRMBde1O8RN
         KSSpBuPGG7l9Ye/8mXGakaOMrjfm6B+O7O/7aF2i6/kO9d+9KXcH+QGpY2IGNY73CxBG
         Il0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739408500; x=1740013300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jl8JJHcNH+3+3Q75U4zc6obkA4164oDMpCFa4xStX/s=;
        b=sQzrJQpw+21NPWv7psg/YTdtOGnxAzLmzxQQPmbJyeGF58SSOrDcj6OVN+PLm0y6y7
         KsDDIULg3qYKMUHRX+D0WiGM4XkbxdpfDr2PUd3BjOdRf7KRzM5aKe1m1LkgkbZk4sDh
         f9R2c6elUSLyg4OMRBL/uj+HOPweV3lcZ5wn8xmS6MiuyLWxN3IPPHFtxBsJWTHl/8AX
         gf4hlrS4jvX3ZWIYViF7HKfU6Ua7kk59lyWJfelX6n2fR56OPWLVQlYxRWth1U0eSqZV
         1KakMphNrSOhTISuYMWtRp2ztlmXD+fJrljvd6X/bR2/CIxwrhkN724+Fpc6sfHUC+FU
         5EUg==
X-Forwarded-Encrypted: i=1; AJvYcCVQif8eD2CR2+oygynpNQvkkrrmEXbF2V4jJMqzAy2itlGLHFcYJI1hnzbiLxjjcwxDEHJY4mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvQ2IaJ2tfIkAEbZknYPNHwHpXHtKi+EFezuJ5efChE6agI+P
	oDyjG1CLSfncSOgW2VrUpZIU6nAYDOdEHfVpWru5wQzD0XK9LscQUrafKaPeIMCxFxrBL2s/9wt
	/u3hqjl5PoAJNzF6H4PT86hm9D8c=
X-Gm-Gg: ASbGncvok0bQM90QymiHeFjcS8W2wcYXFyCwy68mWzFDItE+Gcqc/UVxJQ4vndTQx/k
	7D7ZAy2uqrdKEgGZFdbgiiqxAEtdaQVCTV7PExlTUMXucsKvnrwsvxeTVy2LbImCxkO3Rwq8=
X-Google-Smtp-Source: AGHT+IFuUuw6Yu3vW8S+HaZzL8sXITEUuP+sXAh4vEarE5fz2m4H1foXUniNFhIzDd1IiABkY26dk0JinI6Mwzh8SdU=
X-Received: by 2002:a05:6e02:1a4d:b0:3d0:2477:83ec with SMTP id
 e9e14a558f8ab-3d17bfde009mr47376625ab.14.1739408500045; Wed, 12 Feb 2025
 17:01:40 -0800 (PST)
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
 <CAL+tcoD0CT_JmDcLEY6VGq2_+oU=TgHRfY6LPG70By3gm5CP0A@mail.gmail.com>
 <CAHS8izNyeOThGCt=tO-0xoAEOsoQJLF_DJxF1iV8zJnJoyW-=g@mail.gmail.com>
 <CAL+tcoBa9uz7i-9_-wtakpQkmeiX55RpQn2zkpDnXFBAXutkYw@mail.gmail.com> <CAHS8izOk6o-CQwJf+3zGkd_2Bfi0du489JqngF8aJVOsfpihqg@mail.gmail.com>
In-Reply-To: <CAHS8izOk6o-CQwJf+3zGkd_2Bfi0du489JqngF8aJVOsfpihqg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 09:01:04 +0800
X-Gm-Features: AWEUYZmkGyNpNbclF1l3rZKujd3ys-GhVGjblntzg8HiuGImj_tuqh0KHUfcnbk
Message-ID: <CAL+tcoAQdSzO+WkWadrA_wijEOUKuua-244jGewG_VrRC-2jLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:51=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Wed, Feb 12, 2025 at 4:44=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> > >
> > > ```
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index 2ea8041aba7e..6d62ea45571b 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -1113,13 +1113,12 @@ static void page_pool_release_retry(struct
> > > work_struct *wq)
> > >         int inflight;
> > >
> > >         inflight =3D page_pool_release(pool);
> > > -       if (!inflight)
> > > -               return;
> > >
> > >         /* Periodic warning for page pools the user can't see */
> > >         netdev =3D READ_ONCE(pool->slow.netdev);
> > >         if (time_after_eq(jiffies, pool->defer_warn) &&
> > > -           (!netdev || netdev =3D=3D NET_PTR_POISON)) {
> > > +           (!netdev || netdev =3D=3D NET_PTR_POISON) &&
> > > +           inflight !=3D 0) {
> > >                 int sec =3D (s32)((u32)jiffies - (u32)pool->defer_sta=
rt) / HZ;
> > >
> > >                 pr_warn("%s() stalled pool shutdown: id %u, %d
> > > inflight %d sec devmem=3D%d\n",
> > > @@ -1128,7 +1127,15 @@ static void page_pool_release_retry(struct
> > > work_struct *wq)
> > >                 pool->defer_warn =3D jiffies + DEFER_WARN_INTERVAL;
> > >         }
> > >
> > > -       /* Still not ready to be disconnected, retry later */
> > > +       /* In rare cases, a driver bug may cause inflight to go negat=
ive. Don't
> > > +        * reschedule release if inflight is 0 or negative.
> > > +        *      - If 0, the page_pool has been destroyed
> > > +        *      - if negative, we will never recover
> > > +        * in both cases no reschedule necessary.
> > > +        */
> > > +       if (inflight < 1)
> >
> > Maybe I would change the above to 'inflight <=3D 0' which looks more
> > obvious at the first glance? :)
> >
>
> Good catch. Yes.
>
> Also, write "no reschedule is necessary" on the last line in the
> comment (add "is")

Will adjust it. Thanks!

>
> --
> Thanks,
> Mina

