Return-Path: <netdev+bounces-165736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C6FA33446
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CE31660A9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B225A69D2B;
	Thu, 13 Feb 2025 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="payEPhI7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CDA4D8A3
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407903; cv=none; b=g0/PTCalHv7FNmHxav+0aw4s9Ll01pZiIEIYEPkZwpvN/TIhuzYeyBbvOWWHWe70pZ6eVo1C32uPXHInldqb7rzI7hxPfZtPTGXW5ksDajsFZWNbb2XMqoE98FJO2tIBzB6jnCg04Sfav60rncEaYPr7OD0R4lKjPR3VMidmiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407903; c=relaxed/simple;
	bh=SNKZi7zcWDGtJqAEYcLwUaW+VLU7u6S0IU2LBcAycJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClC3DeKmENhI4P4a0CE3ikT2B3ak/A/9zNBLWu249XHGT0mByM+uzsVvyWx9Cv98DH75el+7gvmeKHraXWqeK+rBSughg8hfV/bEQaWhyO8toian3pOh8LW8mulcslxpYZ49xrej50RveK/e6bzV7rSEwAUVUzknGvrmUcOMyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=payEPhI7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f72fac367so26815ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 16:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739407901; x=1740012701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ7+h+nkWzgpHhekbG7PVAPWh0eFUQ+pI8xpVOtRUg0=;
        b=payEPhI78l4icYn+na2DpyRqwdgNIgZvQm1vYt4hN5fGIv+ajTmbn5b6/EOLFN8ZT7
         uHMYf1ggdgc/E0LvdrVmgcSPnTDrOSHFq56BVIgE8oy4o10BbPHDB1Vc/6I3HqUlFGS4
         5VWdO4DqzJwZd+B7lZFBMV2m08lkbkw14rm2N9wpQ2QMb44W8BoL+QyB8jLzDJ8L8p2K
         o04iN4bZO1uon/f5jSgGGPtAzp6dqn9DMX1j/eGWVHNZoM/AX0SNY6kHFtSzM5tQKL0f
         38Tk/O9vpJpjzWryTDTLFpTOsxv06xI12zUdo0uPZr3u120XMJ9LW1i9SlIxNb5x+trb
         yR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407901; x=1740012701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ7+h+nkWzgpHhekbG7PVAPWh0eFUQ+pI8xpVOtRUg0=;
        b=GZmCZrqvql71M+HGz9979JOvtagfRM8I0Eoyu/rJ+DB548BvufGStC8eHZzc5CuAv7
         yDTpwz8YKb/CsQ9ROcJ3j66EsUJtw33OEwbY1AY9vS75DxCLPdWpOWza7MN/PdxIcEOj
         7JqrMwAOZFfW0xkgIwPMRXfjmGeiHxYrACITfWXGuYVlcW8WEyx6OEfportxgsR5Rjcq
         b4Kq/vcG6nPq9+6vUGEb2qy+7dP2If9bZGGFgrJxVfaTJeUpWTthaAKA0C4KbClxLe4n
         K+DrThmVbeE+LAb8KAp/nZTSxXYP+1bd1X0+mAe/7QqbUNAcnGo9fcUQn2zDka+IHCv/
         jzGA==
X-Forwarded-Encrypted: i=1; AJvYcCVUojTJXP5XtHwXMY0Fusm2GNvzlRbhkr1AXoOHiLBEkJVE0rYiLD8GBNSMWK80kNd0fXgAf+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyFKhIf01qAVH9790Ha04u+bKvoT9dG1i4uGSByqJpJZti/mjy
	vAUw1fSlGGStjsnyCy3o+L7uoFvJdOiEb6Rw0XPr27uKZ1N9SGtmk1Wa3G8QxtgYwxdb7Ua+LOr
	iRwyDH37ExqZESqo5v2uuKWUuShbLy69OfL2q
X-Gm-Gg: ASbGncsqB0zDIuF/b0dveMN2sIezEiRj1umKje8vG3Fx3gPz9Tfw9P6GCLiej+KbzQK
	5NU+qWz6rauNTYjduuGicZBH5edezv4dj+OGfWsIN4VbZ1rTMB+V+fQbit5to00J0UQPUsGiEf1
	5POJ+JykILHmUjvcF4Lfb/8/u3GB0=
X-Google-Smtp-Source: AGHT+IFaHXyEuFFQ1ojsAq4oBRSrhwThDfYQFWqdwWW3S9x7KqrpElgxCrRSTvk645cBul/2TG+RH4bj4E96CyUDlC8=
X-Received: by 2002:a17:903:190:b0:215:9ab0:402 with SMTP id
 d9443c01a7336-220d35811femr1119345ad.18.1739407901132; Wed, 12 Feb 2025
 16:51:41 -0800 (PST)
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
 <CAHS8izNyeOThGCt=tO-0xoAEOsoQJLF_DJxF1iV8zJnJoyW-=g@mail.gmail.com> <CAL+tcoBa9uz7i-9_-wtakpQkmeiX55RpQn2zkpDnXFBAXutkYw@mail.gmail.com>
In-Reply-To: <CAL+tcoBa9uz7i-9_-wtakpQkmeiX55RpQn2zkpDnXFBAXutkYw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 12 Feb 2025 16:51:28 -0800
X-Gm-Features: AWEUYZkdktVXQOGNXCxSM72XKZkWZKdN25aZEUaFvhvJVTKu4m8V0_b2untSOVk
Message-ID: <CAHS8izOk6o-CQwJf+3zGkd_2Bfi0du489JqngF8aJVOsfpihqg@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 4:44=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
> >
> > ```
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 2ea8041aba7e..6d62ea45571b 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -1113,13 +1113,12 @@ static void page_pool_release_retry(struct
> > work_struct *wq)
> >         int inflight;
> >
> >         inflight =3D page_pool_release(pool);
> > -       if (!inflight)
> > -               return;
> >
> >         /* Periodic warning for page pools the user can't see */
> >         netdev =3D READ_ONCE(pool->slow.netdev);
> >         if (time_after_eq(jiffies, pool->defer_warn) &&
> > -           (!netdev || netdev =3D=3D NET_PTR_POISON)) {
> > +           (!netdev || netdev =3D=3D NET_PTR_POISON) &&
> > +           inflight !=3D 0) {
> >                 int sec =3D (s32)((u32)jiffies - (u32)pool->defer_start=
) / HZ;
> >
> >                 pr_warn("%s() stalled pool shutdown: id %u, %d
> > inflight %d sec devmem=3D%d\n",
> > @@ -1128,7 +1127,15 @@ static void page_pool_release_retry(struct
> > work_struct *wq)
> >                 pool->defer_warn =3D jiffies + DEFER_WARN_INTERVAL;
> >         }
> >
> > -       /* Still not ready to be disconnected, retry later */
> > +       /* In rare cases, a driver bug may cause inflight to go negativ=
e. Don't
> > +        * reschedule release if inflight is 0 or negative.
> > +        *      - If 0, the page_pool has been destroyed
> > +        *      - if negative, we will never recover
> > +        * in both cases no reschedule necessary.
> > +        */
> > +       if (inflight < 1)
>
> Maybe I would change the above to 'inflight <=3D 0' which looks more
> obvious at the first glance? :)
>

Good catch. Yes.

Also, write "no reschedule is necessary" on the last line in the
comment (add "is")

--=20
Thanks,
Mina

