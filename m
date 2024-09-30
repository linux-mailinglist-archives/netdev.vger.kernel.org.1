Return-Path: <netdev+bounces-130462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4801298A9AA
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951631F21BC2
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15786192D68;
	Mon, 30 Sep 2024 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4LTzxVh+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A721E507
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713460; cv=none; b=s8e7ZJs/4zRVh1QUuRaqlP7IYfgBWe/EwJMknGmOkQe3a9u1zHHbes/gwtTvq51OHOQ+g7/0QK4Z7XwmXajDWtEzFpHEgmjd0hpGI3GusSjD/e8VtUNJZ6SdyPeJbMS+EuycjcblKeg3/2NZ2Kvcc1E6xTfUjONLARh9WdPS9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713460; c=relaxed/simple;
	bh=iUe7/jaZwgdwxVsBjDvqPnuLi95VYIlBWmZd1SJ07h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7c4G2XD1ukzcriAp9i8ysfBBphGSOxCy/uEd1w5LsI+yFu7d0woxnckqqSH/8fsOtZwFL9rRKGbPGWUSvfxkMycCzSKij3iWHhmSrD9+64klNc19G1AdnLvEksCq1ymRXOcuLWiHmEdMT0nYPsGhpnxFwtQ+MlPlgFIvmiHKXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4LTzxVh+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5399675e14cso1292232e87.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727713456; x=1728318256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8Dbennl8xrFosKI6izhfx1K5yuhh00gSFoO+VG3SvA=;
        b=4LTzxVh+jeftPLzQDLy6pkoaifTYhB2Rw3lnOR2q6rxtVEm6YCSM8eWrYXAzaw0Fvf
         Z4V2WdUZDqeFu84fGVc8KMKjMBIZiacDUGpJ4lNtp051xh6NyCU/XWcRqURsOythseUF
         /qH4wy95a9edOQyfmL3I/uYjPvQ9dpAXFw5UIeB0dlAOkdTcyc0xhj7/QQuXWk9XqXkn
         WgbaoF0zag5cGvZM0hlmoq3RQbr+TM0yPJQ6n1lquIwLbRmHaKXUVdYTPVw7+70gNPUV
         9fz+YK90dxWvomQwfTrqKe9Y5gioLtuwMjRPGkKbLvi2IQEByXpQ8UGwEMN5EDzYvnxH
         fkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727713456; x=1728318256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8Dbennl8xrFosKI6izhfx1K5yuhh00gSFoO+VG3SvA=;
        b=mXfG0zFVOlSbhDQo3CTnScrWUNXJvdBV5SOVqGph01oXo5/kT7XMPKLHvOtlySWliZ
         aoQfJnBQgbl5ppxNL8KPvj4L3O4VOfPcmlTwxGfSKAMCd1EvmOtnNWvJV+KAMjhq3qkP
         zisa2mT1i2Zz/bhBDyJOJBqlSuE/B7V2kf5rfiMrFd85FfwvLRkDYh/NiLNJBpCME+Qv
         h4t0nMH52F8aToTcY9erG931N3gmO+GYflMNhW8AGVodxgNRm8hrA/oz0pqgMgKRS3sd
         3bCdeBGGFPM/9PaGH8QeNcTD0VAdC4dVpOixTufDc+4huGE6bOjS6Ns96rQBZ93nVc6k
         vguw==
X-Forwarded-Encrypted: i=1; AJvYcCUNjxLM0N9E7oWYrPhhUJO89Vz5fgJ7Oyaj4Tb2de4NwAjfhZNTTXwZGsdmx9vulOtvdEYhO2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkp8m9u2A8LQAhPjuac0qCJpBH1sphNpWSzhHThNS7i6nsoYXM
	TR4yxSSfjWqxJa9kjGO2kwiuTZRGr/ZIzp5leAb066TtvUCOuhvBjuQgjMiRktuJnIFRuqetlx6
	Z4okjr9NT7w6cCs1K6Je5CR8CFFGV/P6GPQVD
X-Google-Smtp-Source: AGHT+IF4luxmpBlBiTXN19LRsJ4uDDjhtSQ5ZSC04w9FKMg1231Rox1wHoIbRpddW0UDRBunfUM4kDqlgP+8lmx+7BI=
X-Received: by 2002:a05:6512:230e:b0:536:54c2:fb83 with SMTP id
 2adb3069b0e04-5389fc36745mr7021002e87.23.1727713456016; Mon, 30 Sep 2024
 09:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817163400.2616134-1-mrzhang97@gmail.com> <20240817163400.2616134-2-mrzhang97@gmail.com>
 <CANn89iKwN8vCH4Dx0mYvLJexWEmz5TWkfvCFnxmqKGgTTzeraQ@mail.gmail.com>
 <573e24dc-81c7-471f-bdbf-2c6eb2dd488d@gmail.com> <CANn89i+yoe=GJXUO57V84WM3FHqQBOKsvEN3+9cdp_UKKbT4Mw@mail.gmail.com>
 <cf64e6ab-7a2b-4436-8fe2-1f381ead2862@gmail.com> <CANn89iL1g3VQHDfru2yZrHD8EDgKCKGL7-AjYNw+oCdeBQLfow@mail.gmail.com>
 <CADVnQyn2pC5Vjym490ZjjUqak0wRiV5OBhtFU8hqrM6AQQht+g@mail.gmail.com>
In-Reply-To: <CADVnQyn2pC5Vjym490ZjjUqak0wRiV5OBhtFU8hqrM6AQQht+g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Sep 2024 18:24:02 +0200
Message-ID: <CANn89iLYd90nPph6PqxiC5KJt0LYgTtHyU0FmTCPUK_9_iWT4A@mail.gmail.com>
Subject: Re: [PATCH net v4 1/3] tcp_cubic: fix to run bictcp_update() at least
 once per RTT
To: Neal Cardwell <ncardwell@google.com>
Cc: Mingrui Zhang <mrzhang97@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:32=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
>
> On Mon, Aug 26, 2024 at 5:26=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> ...
> > I prefer you rebase your patch after mine is merged.
> >
> > There is a common misconception with jiffies.
> > It can change in less than 20 nsec.
> > Assuming that delta(jiffies) =3D=3D 1 means that 1ms has elapsed is pla=
in wrong.
> > In the old days, linux TCP only could rely on jiffies and we had to
> > accept its limits.
> > We now can switch to high resolution clocks, without extra costs,
> > because we already cache in tcp->tcp_mstamp
> > the usec timestamp for the current time.
> >
> > Some distros are using CONFIG_HZ_250=3Dy or CONFIG_HZ_100=3Dy, this mea=
ns
> > current logic in cubic is more fuzzy for them.
> >
> > Without ca->last_time conversion to jiffies, your patch would still be
> > limited to jiffies resolution:
> > usecs_to_jiffies(ca->delay_min) would round up to much bigger values
> > for DC communications.
>
> Even given Eric's excellent point that is raised above, that an
> increase of jiffies by one can happen even though only O(us) or less
> may have elapsed, AFAICT the patch should be fine in practice.
>
> The patch says:
>
> +       /* Update 32 times per second if RTT > 1/32 second,
> +        * or every RTT if RTT < 1/32 second even when last_cwnd =3D=3D c=
wnd
> +        */
>         if (ca->last_cwnd =3D=3D cwnd &&
> -           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
> +           (s32)(tcp_jiffies32 - ca->last_time) <=3D
> +           min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)))
>                 return;
>
> So, basically, we only run fall through and try to run the core of
> bictcp_update() if cwnd has increased since ca-> last_cwnd, or
> tcp_jiffies32 has increased by more than
> min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)) since ca->last_time.
>
> AFAICT  this works out OK because the logic is looking for "more than"
> and usecs_to_jiffies() rounds up. That means that in the
> interesting/tricky/common case where ca->delay_min is less than a
> jiffy, usecs_to_jiffies(ca->delay_min) will return 1 jiffy. That means
> that in this case we will only fall through and try to run the core of
> bictcp_update() if cwnd has increased since ca-> last_cwnd, or
> tcp_jiffies32 has increased by more than 1 jiffy (i.e., 2 or more
> jiffies).
>
> AFAICT the fact that this check is triggering only if tcp_jiffies32
> has increased by 2 or more means that  at least one full jiffy has
> elapsed between when we set ca->last_time and the time when this check
> triggers running the core of bictcp_update().
>
> So AFAICT this logic is not tricked by the fact that a single
> increment of tcp_jiffies32 can happen over O(us) or less.
>
> At first glance it may sound like if the RTT is much less than a
> jiffy, many RTTs could elapse before we run the core of
> bictcp_update(). However,  AFAIK if the RTT is much less than a jiffy
> then CUBIC is very likely in Reno mode, and so is very likely to
> increase cwnd by roughly 1 packet per round trip (the behavior of
> Reno), so the (ca->last_cwnd =3D=3D cwnd) condition should fail roughly
> once per round trip and allow recomputation of the ca->cnt slope.
>
> So AFAICT this patch should be OK in practice.
>
> Given those considerations, Eric, do you think it would be OK to
> accept the patch as-is?
>

Ok, what about updating net/ipv4/tcp_bic.c at the same time ?

