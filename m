Return-Path: <netdev+bounces-236853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E783C40C72
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838425673AB
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E9331D36C;
	Fri,  7 Nov 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ooaASJ15"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB438328B62
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531736; cv=none; b=JiGi0RPqlzTaiSf3knOtigYDruK4EZK2qB4qwAQ+6SMV6rqHnDhHpXH8Bs3YGKU+Dzh+QkBMb4dpD5VuEKTswUISsmjrllMYTEhtK57yuh0Mj+ak/oVwBxzIGp3av/SmZvWAbGBueG9iPh+2/WG49Tu9jUcTHXCqsDvxoGhFj5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531736; c=relaxed/simple;
	bh=sZXGO5xI6o93fTLqIP09KiWgl3xP9CgiOlzXgWwFeOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+KihKDA1N7oHmxM17i77tsUhqt0ELi9pPhG47t1z8NAX/xo7Ih6iQiow8mSHwEjIp02NGckF/zgSfrSACjAyeG/GTQNP1f7v0HBVXZ8xqJKEPQkhENT8iYMfz+Vjw1ZhKNwzjJSPJT7yibRVvgoj2zKmXap2HZ7FfNKHzPY/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ooaASJ15; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed69197d32so12902211cf.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 08:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762531732; x=1763136532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZXGO5xI6o93fTLqIP09KiWgl3xP9CgiOlzXgWwFeOQ=;
        b=ooaASJ15+26g9ww7Mi/euKUblwEbM+ZmhIPXB9O7w8ZZX9wSfMcWjiGdKsNGUXH2OX
         4aWuqoPQSVEFZR2rras2FtbIKSFnSq03/8krB8KM8rBulO3Ojg6w6SmjnUCKKaj+j5Qr
         AHae81Rv9rWqjlb56yoTD+9Hm+x3lFzNZOPvj/ky/DVMzobThcxJlTATNlPNfw+kFSoe
         Cm5MMh478uW0V/Zih/7Gfrda/2ANdl7iudySiGuF7dHghiSwaXFRsR2UGVBjdVweOyz+
         BmXhI1X3axfzm+F8KiC59unvTI+i1LMhqZdwsLkQ2JFcu1o0MuGrOSM8EeNwN62OAn5M
         M9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531732; x=1763136532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZXGO5xI6o93fTLqIP09KiWgl3xP9CgiOlzXgWwFeOQ=;
        b=FfVOntaM4U0QQkuekAXMGpkDvz4jG/WTTn8nWVLNt9p6GUbxLiiqz3Z0YhsDncOPG8
         bqIkW9pP3PuyspSkYPT0z1KbNrcUy3onBzj3PrNaMTn0ubIOjk6rqyx+xtraX0xirCTJ
         4aRSczDIlirgc8f4Vgnm76eoOj0tjmipNUgsDApgKaiqVePs1KQhne0TO5q45kXCT/mV
         KPGIVYT4K823yFCKV73kkufsZczKhkm8YgT+bya1DzeTiXkexPBJ+WEdF2b2L7/IW30/
         FrXVmPuHSO5U4z0WjcTHsvpsXu1i6AirHsyVyiv/eYyThd4XedJ9pZ1l40ApMulOQ5d1
         Dpvg==
X-Forwarded-Encrypted: i=1; AJvYcCUQmuxw9nEiZWKgCJyeULOc1CMY8UbDJ2H369OO1LZxBuASovNDhwU2BA/3kwDhLKRXin9pe+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQSP2zA/O+N5KCB6MXdf+exkPrvyZ1QLTa/OsXsxEFiiNM7Bo
	D92yHx9lCbGx19oqY/VHTx/6H2UZqWryg3u3R6CZ9mxOOHB2d/268dqkx0DXzfbJqPQHYtwi95t
	ek7t6xdrmQ1+ZzqvShhJthr72hEqpo8IgneCzoqfd
X-Gm-Gg: ASbGncsNOlXnf1dH9b757otTqmK68avZp3MdY96/S/oAwvjuV+yPeTDarXvRYNiZaw/
	0LW2k5Zj72leYvhbK5Yw8ftC21VMC0Kfu9EGsRJGwo197d3i48t00UwEw9izmwTSrDPHM8n4oxN
	ZYwEnVjXmIRHOVQskgFH7ArcvYewQErtjLJ1GFKc06BW+5ky/5SxyXqDEYadLlOVr3Sqs7DgJLB
	OniNkA50gi+WIf/bNNDsBZLDwQx8Vm1PFxuLGuZ/skvMNVQ2xLzaBPFNnMBBHRgpBdxdtYigonX
	QryqhA==
X-Google-Smtp-Source: AGHT+IEuSAtw09ysTUFNCsb+6BLqorLTupTyCp8piycvQEriwi2baf+bldT5Ns5NQw0QxXuNSUGgNM4NN28IZKR3EQA=
X-Received: by 2002:a05:622a:4f:b0:4da:155a:76fc with SMTP id
 d75a77b69052e-4ed9493a564mr48549891cf.16.1762531731551; Fri, 07 Nov 2025
 08:08:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-4-edumazet@google.com>
 <CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com>
 <CANn89i+fN=Qda_J52dEZGtXbD-hwtVdTQmQGhNW_m_Ys-JFJSA@mail.gmail.com>
 <CAL+tcoBGSvdoHUO6JD2ggxx3zUY=Mgms+wKSp3GkLN-pLO3=RA@mail.gmail.com>
 <CANn89iJcWc+Qi7xVcsnLOA1q9qjtqZLL5W4YQg=SND3tX=sLgw@mail.gmail.com> <CAL+tcoCmpzJ_z4DCvcoWok2LrR9vL2An8j3zi5XHOjiSity3jg@mail.gmail.com>
In-Reply-To: <CAL+tcoCmpzJ_z4DCvcoWok2LrR9vL2An8j3zi5XHOjiSity3jg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 08:08:40 -0800
X-Gm-Features: AWmQ_bnJcwe_AZmVvJvm1hLi02ObRt_W8pT1UUCydljBibMiLmk7IO_OKoFW7Ts
Message-ID: <CANn89i+4OKrAq6DPZ_=MeDhGmEXDn6k-dRrEyzO8pmy=hN6VwA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 8:04=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Sat, Nov 8, 2025 at 12:00=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Nov 7, 2025 at 7:50=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > On Fri, Nov 7, 2025 at 11:47=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Fri, Nov 7, 2025 at 7:37=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > > >
> > > > > On Fri, Nov 7, 2025 at 4:30=E2=80=AFAM Eric Dumazet <edumazet@goo=
gle.com> wrote:
> > > > > >
> > > > > > skb_defer_max value is very conservative, and can be increased
> > > > > > to avoid too many calls to kick_defer_list_purge().
> > > > > >
> > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > >
> > > > > I was thinking if we ought to enlarge NAPI_SKB_CACHE_SIZE() to 12=
8 as
> > > > > well since the freeing skb happens in the softirq context, which =
I
> > > > > came up with when I was doing the optimization for af_xdp. That i=
s
> > > > > also used to defer freeing skb to obtain some improvement in
> > > > > performance. I'd like to know your opinion on this, thanks in adv=
ance!
> > > >
> > > > Makes sense. I even had a patch like this in my queue ;)
> > >
> > > Great to hear that. Look forward to seeing it soon :)
> >
> > Oh please go ahead !
>
> Okay, thanks for letting me post this minor change. I just thought you
> wanted to do this on your own :P
>
> Will do it soon :)

Note that I was thinking to free only 32 skbs if we fill up the array
completely.

Current code frees half of it, this seems better trying to keep 96
skbs and free 32 of them.

Same for the bulk alloc, we could probably go to 32 (instead of 16)

