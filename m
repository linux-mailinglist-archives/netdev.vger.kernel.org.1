Return-Path: <netdev+bounces-122847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75D962C65
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B311C24102
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AB519644C;
	Wed, 28 Aug 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="Ynn39iCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8C13D8B4
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859074; cv=none; b=f1INBKfPqzHGOaoCxPyBD0cQizjtBV9c6KrSD5cJkVFh2sihvpwGQ0z0uKlthBZyoFgH5Qe+eYk08M2nqaQt1qqyHeN2Z/FsxviNDFcjh9EZgdGUEPyEv1qA1s2WV2OAqC9sk6R8PUizNkEVTMhmqICnidoZAk1Sc7aoPecJpeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859074; c=relaxed/simple;
	bh=77NTeXp0kvabyoiijE2GTZgOZkmwI4H1ejGWkUlG0gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Afv9R2i7tAsVHXk2zdEfVU1Z/gyNB03vVamxhKHtHdmkYTWQq1YrlOXp/AF4uvimxgwXW8tPuZq4X8Onr/9zddz8viywfpJg4ugDHNkNxAGOB3t+76/hm4DLag8iofyj/0/foUhDCmOCT3fQ4mpRSjq3lUDlAaWUti7gEeFkj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=Ynn39iCf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-454b3d89a18so37549281cf.2
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1724859072; x=1725463872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE7VQ2DOmh+a+RsQUpS0EECIDl7aHT0iHqx0TVOetY0=;
        b=Ynn39iCfxpgWKFZWHumADDOVsVZDILzyHoHY29X9zCJaJIwcTZA2kRpkIbR95AKPPL
         YMQDrWQpDCutbEkP1Qj/AOalkMMtZgBkccajVoEnM3wxTlts9XdGYK+KxKqKGDRcr3ks
         GMiDa29IhAm3tGcK4GVqr155VQ3seLdnek3tZXbp7hOTQqGgvSd9UTWGGN3WwDqusVRp
         Jmu8ik9HORed8NTJtZubkOpHuBrGWwE71SbgZSsLrUdKsKDlihV7zbzqQTNHvEVonvoK
         XEmVZj+H0kQ7GkJApHvAyiJlkbfFPGfw7bnwh7TQD/EjbKjSsuhD+TEmdL1a6Oatp5do
         /xbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859072; x=1725463872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE7VQ2DOmh+a+RsQUpS0EECIDl7aHT0iHqx0TVOetY0=;
        b=LGqVzUDcwAaa8tRzvAs0Klv3TtoBmJqQ0Ja8dgpOy8ISU7gbIzeoc+4urQc3prJI3e
         AlwAdW9A/RFOiGX1YytMh6kDneamCdEkhOLen97Um31AnAHyoNEClSIKoPGHB+YLqotV
         xXjLlMRn61dUHuuoDFe/pI8/QZY5F1Jvnc9OkRoVf06ZYk1xQmnJCma+uO40b1JTVn1b
         FER62PVQs1RPhkzhjPxh+/2ltnOyXZaindX05L7h15iMGcFvwpoVmvMOJKUHpUnWTNlF
         QOa5d749j32E3Mlol9aN7ZngCHW+smkTLkuyyuV2k3H6ExmyLrE1jECPQL3LBYk3hZsy
         u3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiVNjCtlDeJGtUHIAPBMQc0hy6iGfU1VOXhr5WGgHgRh+hNTMAdN4rYaE3qskuSOPhGIACOP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVxziDMI5M+K7Ne8Ctt4juTOQpgHK1XV749+jIiKjJ1HSkgWo
	ExvnI07Rzk+l3u1zeeQUkTAvaCZzi3EdTPIAV3UE/bau0NGVY/SAHlZMR41LKVp94UiR91JxTVU
	xyz5jQn1lxGWAAy8k4QnF1FFZ7ROI9cbbR2ArrQ==
X-Google-Smtp-Source: AGHT+IG8DqXSyvAN6JjicHbP+NhNifC+CqxO9rdb2O6S7XRkvkx1wBNHdAW4dLEfqGLOUfbBpqfr/Y9Z7FzVYSYdBzQ=
X-Received: by 2002:a05:622a:a19:b0:446:3c7a:3689 with SMTP id
 d75a77b69052e-455097ab604mr260169001cf.43.1724859071747; Wed, 28 Aug 2024
 08:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824215130.2134153-1-max@kutsevol.com> <20240824215130.2134153-2-max@kutsevol.com>
 <Zs3EB+p+Qq1nYObX@gmail.com> <CAO6EAnVXXfQRK1xWoxO+dQwQsftw3bhOz27cQPNX=TzCutkrQQ@mail.gmail.com>
 <Zs8//o3EDLtt+eTY@gmail.com>
In-Reply-To: <Zs8//o3EDLtt+eTY@gmail.com>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Wed, 28 Aug 2024 11:31:01 -0400
Message-ID: <CAO6EAnVO3px9thFJWyV=_UfmMBbSwt-uy=FvM4xxdYxZWknv3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Breno,
thanks for looking at it.


On Wed, Aug 28, 2024 at 11:19=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> Hello Maksym,
>
> On Wed, Aug 28, 2024 at 10:26:20AM -0400, Maksym Kutsevol wrote:
> > > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > > > index 9c09293b5258..45c07ec7842d 100644
> > > > --- a/drivers/net/netconsole.c
> > > > +++ b/drivers/net/netconsole.c
> > > > @@ -82,6 +82,13 @@ static DEFINE_SPINLOCK(target_list_lock);
> > > >   */
> > > >  static struct console netconsole_ext;
> > > >
> > > > +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> > > > +struct netconsole_target_stats  {
> > > > +     size_t xmit_drop_count;
> > > > +     size_t enomem_count;
> > >
> > > I am looking at other drivers, and they use a specific type for these
> > > counters, u64_stats_sync.
> > > if it is possible to use this format, then you can leverage the
> > > `__u64_stats_update` helpers, and not worry about locking/overflow!?
> > >
> > Do you think that these counters really need more than an int?
>
> An int can overflow and become negative, so, you will see negative
> values, right?
It's an unsigned int (maybe not an int on every platform, but still unsigne=
d),
it will become 0, not negative. E.g.
https://www.programiz.com/online-compiler/3qbkayylX5Cmf

> > Switching them to unsigned int instead might be better?
>
> Why not `u64_stats_sync` ?
>
Only because it's smaller and does the job. Unless locking is needed.

> > I'd argue that at the point when an external system collection
> > interval is not short enough
> > to see the unsigned counter going to a lesser value (counters are
> > unsigned, they go to 0 at UINT_MAX+1).
> > I need advice/pointer on locking - I'm looking at it and it looks to
> > me as if there's no locking needed when
> > updating a member of nt there. Tell me if I'm wrong.
>
> well, they are updated while holding `target_list_lock` right? But I
> would not rely on it.
Then I'll update to use them instead.

> If you just convert the values to u64_stats_sync, you get the
> synchronization for free, basically doing the following:
>
>         u64_stats_update_begin()
>         u64_stats_inc()
>         u64_stats_update_end()
>
> Thanks for working on it,
> --breno
Absolutely, my pleasure :)

