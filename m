Return-Path: <netdev+bounces-232754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B68C088D0
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 04:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC9E1C26EE8
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09940231826;
	Sat, 25 Oct 2025 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jpg0JaAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0522CBF1
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761358739; cv=none; b=gr4qbXsqBXomfFNLkYysKcyXAScOb6GKR0tbBktCUsizr7mXzYrbeIvcmwV2yyPdtIu+SwvFNjI52Mux90Q6K1uKjvyE5uKmyMvgtr2jzQ+7l1HcnaFCa4Y6lBn3eDRNbalXbGVSdGYEl1YdvFjzfyzzlDlwvvPWZDAnkUyQbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761358739; c=relaxed/simple;
	bh=bDUYYRciJNzA771LBf/e+NnZDQD2rgyedHYq3kTLh34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEgpKB1X3UdC7HRSjGnmGzWUyc1WX8V1BtZzFVylrLmXh/I5A8sxzPI91UNC9YH+xF3rzgPbUVyS/NCPjv0mGXvkXXcCTZW/eE5B7fMU/qBctjuQ6xYtKnrZZ3hjU547FjcWA6bT4SzugpwyFhVUgvuigk9Aq8oZJ7rC/w99cJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jpg0JaAr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a4176547bfso23516b3a.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 19:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761358738; x=1761963538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pdh//SdW7AOfLkMx7dZ5JsgWsCD402PSQSG+CEzxU10=;
        b=Jpg0JaAriLEG1ygXrWfDuEeSoWG1tGtSt7+5TqFNbtuOQnReAzYR4bHXyeu4tVJgTr
         lOM9pacVMEoUw8KXOrQVbZGiCwEZK0dPtTmV8DFvtrbCLAYnpPFlVuUSH2Bgv/Flq+xu
         ekjH0TSWNQkXzc5ei20FwbFWBFXpz7wM1XWNLPlx+Jz2N3P7roXanOsza9EpYJunDrJ1
         DYl6eW2F4IH/96FVfSnKxRYIHpEfMzqLxmzh2dF9bcZj/tt/OzHSKpD27EnSwU/RcSHo
         J+/nS0H3jfREoLdJf1fbbxqgu3jjMat21EjNUtfn3UowQtro9apLPCvSc++g01RElfIt
         rUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761358738; x=1761963538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pdh//SdW7AOfLkMx7dZ5JsgWsCD402PSQSG+CEzxU10=;
        b=ETffpMNKHih6EPyAZwOfwQfibNODynH6eRaIcYf4aTHxrds7vERM55aOMoqvHilzVe
         JC2rSZ+lqG4q4IRg6MHyJnh8TSjoYEjALxzaGU2tb5Ta4DFOMf+nqzRAY/OYI/rX+0NX
         8J0wp91wOFHJBt0Vl+ZAlBObmGYAVZUXhdlKNpa6aKijJG5cTCPvwgo7X0h11fS2oCN2
         aA9fxJGXG14P2DgQAMqlj/h3xDrZhaFT9YhMYqK6UMA4Rh1obiCI3n294f6s7BDIZXbU
         vaEUxoGEboJlJ9yYsM/vcHqlbM9Z7JulB+33SrY8TBkFeapC+UC8XCS82LD+oYYg9QRX
         sLCw==
X-Forwarded-Encrypted: i=1; AJvYcCWs+Tru4OKWiBZ0jMn+bzykYUqcjyviCFUKBK2uyXbkvAB6udmSWzcXyR6fQ6KwnLsFEpxJlnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfL1vnzK9ZoaH5IJ41gM6fdTVMPGu+JBVq0kBmJ9FxpgVuvd0+
	XXccaDQD0Sg87DCr3Xy2Sdx0iVUmZLHi7VqFSe0NJAYWFk9qjd/2jVuUcWSusOnLbmSpcWID0yt
	TZiCsiN+fvBV1OET5ZFfJ4xnSaikz/KSDATPEZxyD
X-Gm-Gg: ASbGncv+G6vo5Mj9R3Rl2SZTupefzEIWw1/MkuixWy6zJnWCD0jxC1U2KkQZ9XowhXt
	8gJXyuDN6kRkiymMZgHr1dHx/hLsT2/Wbo/LeksKwOxWHTjybBiuGOfG1RDnBpwFShhUS21WNO7
	Y0EObcb07tI9s6tqMdjRrN3vgf1mG3LHSTdNjaUs6tYgfsn2+1mbRxvXXNHFlHLaRmAoBT38LxE
	+5xfp2U1VZKJ7UXZ4m0D4GuQgUp2vo13SunkwthZJrhiJluHhADs6eckfYVpzHV2uPXNJvf3ZEu
	8V3B0Btkg/42Pr1bpQe2cxT5lg==
X-Google-Smtp-Source: AGHT+IFmI7Ixh5dfHqxdYYFwlyBsopPEERAG88gvbSuwZi3OU+ZNgxIr1hG+HXoabCHtqun/qT0ni+tgPV1F6qkmJBQ=
X-Received: by 2002:a17:902:c94b:b0:271:479d:3de2 with SMTP id
 d9443c01a7336-2948b97311fmr48726135ad.13.1761358737408; Fri, 24 Oct 2025
 19:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024093901.1202924-1-lizhi.xu@windriver.com>
In-Reply-To: <20251024093901.1202924-1-lizhi.xu@windriver.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 24 Oct 2025 19:18:46 -0700
X-Gm-Features: AS18NWAyugeNKm7Hp5qAgLdmuPQUETlgM-5DwLDqkUiM2xinU82JuTnZkgQCSOc
Message-ID: <CAAVpQUCx9MOJobomXXBcXsCNgSn__U3mJp8LFxD515o-boyr=w@mail.gmail.com>
Subject: Re: [PATCH V3] net: rose: Prevent the use of freed digipeat
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: edumazet@google.com, davem@davemloft.net, horms@kernel.org, 
	jreuter@yaina.de, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:39=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> There is no synchronization between the two timers, rose_t0timer_expiry
> and rose_timer_expiry.
> rose_timer_expiry() puts the neighbor when the rose state is ROSE_STATE_2=
.
> However, rose_t0timer_expiry() does initiate a restart request on the
> neighbor.
> When rose_t0timer_expiry() accesses the released neighbor member digipeat=
,
> a UAF is triggered.
>
> To avoid this UAF, defer the put operation to rose_t0timer_expiry() and
> stop restarting t0timer after putting the neighbor.
>
> When putting the neighbor, set the neighbor to NULL. Setting neighbor to
> NULL prevents rose_t0timer_expiry() from restarting t0timer.
>
> syzbot reported a slab-use-after-free Read in ax25_find_cb.
> BUG: KASAN: slab-use-after-free in ax25_find_cb+0x3b8/0x3f0 net/ax25/af_a=
x25.c:237
> Read of size 1 at addr ffff888059c704c0 by task syz.6.2733/17200
> Call Trace:
>  ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
>  ax25_send_frame+0x157/0xb60 net/ax25/ax25_out.c:55
>  rose_send_frame+0xcc/0x2c0 net/rose/rose_link.c:106
>  rose_transmit_restart_request+0x1b8/0x240 net/rose/rose_link.c:198
>  rose_t0timer_expiry+0x1d/0x150 net/rose/rose_link.c:83
>
> Freed by task 17183:
>  kfree+0x2b8/0x6d0 mm/slub.c:6826
>  rose_neigh_put include/net/rose.h:165 [inline]
>  rose_timer_expiry+0x537/0x630 net/rose/rose_timer.c:183
>
> Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
> Reported-by: syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V1 -> V2: Putting the neighbor stops t0timer from automatically starting
> V2 -> V3: add rose_neigh_putex for set rose neigh to NULL
>
>  include/net/rose.h   | 12 ++++++++++++
>  net/rose/rose_link.c |  5 +++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/include/net/rose.h b/include/net/rose.h
> index 2b5491bbf39a..33de310ba778 100644
> --- a/include/net/rose.h
> +++ b/include/net/rose.h
> @@ -167,6 +167,18 @@ static inline void rose_neigh_put(struct rose_neigh =
*rose_neigh)
>         }
>  }
>
> +static inline void rose_neigh_putex(struct rose_neigh **roseneigh)
> +{
> +       struct rose_neigh *rose_neigh =3D *roseneigh;
> +       if (refcount_dec_and_test(&rose_neigh->use)) {
> +               if (rose_neigh->ax25)
> +                       ax25_cb_put(rose_neigh->ax25);
> +               kfree(rose_neigh->digipeat);
> +               kfree(rose_neigh);
> +               *roseneigh =3D NULL;
> +       }
> +}
> +
>  /* af_rose.c */
>  extern ax25_address rose_callsign;
>  extern int  sysctl_rose_restart_request_timeout;
> diff --git a/net/rose/rose_link.c b/net/rose/rose_link.c
> index 7746229fdc8c..334c8cc0876d 100644
> --- a/net/rose/rose_link.c
> +++ b/net/rose/rose_link.c
> @@ -43,6 +43,9 @@ void rose_start_ftimer(struct rose_neigh *neigh)
>
>  static void rose_start_t0timer(struct rose_neigh *neigh)
>  {
> +       if (!neigh)
> +               return;
> +
>         timer_delete(&neigh->t0timer);
>
>         neigh->t0timer.function =3D rose_t0timer_expiry;
> @@ -80,10 +83,12 @@ static void rose_t0timer_expiry(struct timer_list *t)
>  {
>         struct rose_neigh *neigh =3D timer_container_of(neigh, t, t0timer=
);
>

What prevents rose_timer_expiry() from releasing the
last refcnt here ?

The t0timer could be triggered even after that happens.


> +       rose_neigh_hold(neigh);
>         rose_transmit_restart_request(neigh);
>
>         neigh->dce_mode =3D 0;
>
> +       rose_neigh_putex(&neigh);
>         rose_start_t0timer(neigh);
>  }
>
> --
> 2.43.0
>

