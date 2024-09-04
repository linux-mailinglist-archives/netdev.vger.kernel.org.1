Return-Path: <netdev+bounces-124811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3D896B0AE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E83D1C204F8
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 05:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FD982C60;
	Wed,  4 Sep 2024 05:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2R9mypVt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804439B
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429154; cv=none; b=KzRCGViUE5bVU1J8HfdEmFy/llEWdBRLyEdSilhBurQu5qKH8qz0Y7on/zWcAu0cMs6LsqtLeZ81BK5rd6DO7mrdDifIyKbmbuB7q7NpnJrsaEgRD8w5ir/guPk43Ca/VQBt9wOMABB0yI2/KA5O0IgyCU010LQakwzzVYu9ey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429154; c=relaxed/simple;
	bh=yNRTOUzKkRJGhqlw5ivru1d9393vB7lDkAch0+shEfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJYI/spVDGA74NCbuowSD8qW2Jv5GeSeQSdYfRIojWA/jSQ8jH5L537luqYMUyPZewC7DYIlLLB8gNVAkEsIz1KUR/WztQDLQ/E8BZLtxqEo8Fj5Ae50BCzKRKojGViQ4vvFMKHAwycmJNfHtg69oqY+HHtu4/qf2cXO+bJ2ZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2R9mypVt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53348589540so2390e87.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 22:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725429151; x=1726033951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfI0/f+BGYzXSB/YInZDUJCx543XTNWba09slmlv2JI=;
        b=2R9mypVtGIJzsTAu0gK4Y5QQ+tYBNDjRARAsLUFWYlMyOkAC6kTvULq388PpE8rDHR
         3AryoaaW+F/eBIdZJlm5wec47N5anNnudXKlZaN9Q6jrptz3EpBDkpwAZ2sgyJPWSum9
         6UTLv63UOIhig3NskBo3J7QQseO8rUyXa7NkKDIM2j0HQEUOKzv7R4fDEt1qTqJPDl/n
         +OWoWbSz5ZUe/EMNbcA1aqxF6rJfpvVuYNLTp6/YA6kJkKEHAGCk7L+w0MB1+VCLSLGh
         O9Qd1c/832q4thQTdzll/AFueHvIT+lCZX5SPY9VOLFbIsRe1Gf1/hbWoeNj00v+ij6o
         qcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725429151; x=1726033951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfI0/f+BGYzXSB/YInZDUJCx543XTNWba09slmlv2JI=;
        b=peJ75pj6McCBhhJpRhLjOyelpWjNYeM4bcjJQOxpusQJYIe9bZpMFwgAlbz1A3LPkv
         HKzMEv1vRTslD6hvABK7zep+EImyGeSnNcm32eMvc58O+Jwgky8nyDr2GrkKf7C2r2LH
         QRGV14iSoHptdVUOLdwEVUPhCuQh2f52MB8c8jDs2bmzONM5tgWqUYahMCpnEyFoD2zU
         ni54eoUHCSyCF1HxOKNawpoLV8SZIJtncfG3aOUqJEYhX9WZcqLBrAvx23zdBDqxsVlt
         adX7nUsvFb5VEQHDGyMCb1lRIy+pJEmSgOmLYyXq7Hje+lC7mNPtFnzduzsDGWTSiJpk
         QA9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCtrCaW86vbzYGu4Yg2r7FWInv5dNyyMH08PNrUC02jkbrE7iEuiTxzAeUk3nBIvBeMt7n9M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvtRFDtjqOMpj5L8vhr11I5GXlud//bi03MxKt94J9WakmfQsi
	UnuCm/atGIYAcwsT0Slu5CbuBYnP0Uo7upClCrF3FnoUq5jgaIi2T57IhZvPFcSGn2l6gr2DrMB
	U1o4gx9t0C/6kagJrg19nyMuGU+vZlncaW30H
X-Google-Smtp-Source: AGHT+IGPJoL2SsMm5N55o3sDX+rl5plbUQ7rMhlvj1/wjC/IbbW3VQg7/xpeR5lFR7gW6Po/n/AhP8LwsU2ZTwIqHC4=
X-Received: by 2002:a05:6512:2389:b0:533:4322:23b7 with SMTP id
 2adb3069b0e04-535655b376dmr88376e87.6.1725429150661; Tue, 03 Sep 2024
 22:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828181011.1591242-1-namangulati@google.com> <939877af-d726-421e-af71-ccf4b2ec33ea@linux.dev>
In-Reply-To: <939877af-d726-421e-af71-ccf4b2ec33ea@linux.dev>
From: Naman Gulati <namangulati@google.com>
Date: Tue, 3 Sep 2024 22:52:18 -0700
Message-ID: <CAMP57yXkxGYXSn+bsCObFNViTYC9LbToJ6C4mJUSSEaHjnnACQ@mail.gmail.com>
Subject: Re: [PATCH] Add provision to busyloop for events in ep_poll.
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, skhawaja@google.com, 
	Joe Damato <jdamato@fastly.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:16=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 28/08/2024 19:10, Naman Gulati wrote:
> > NAPI busypolling in ep_busy_loop loops on napi_poll and checks for new
> > epoll events after every napi poll. Checking just for epoll events in a
> > tight loop in the kernel context delivers latency gains to applications
> > that are not interested in napi busypolling with epoll.
> >
> > This patch adds an option to loop just for new events inside
> > ep_busy_loop, guarded by the EPIOCSPARAMS ioctl that controls epoll nap=
i
> > busypolling.
> >
> > A comparison with neper tcp_rr shows that busylooping for events in
> > epoll_wait boosted throughput by ~3-7% and reduced median latency by
> > ~10%.
> >
> > To demonstrate the latency and throughput improvements, a comparison wa=
s
> > made of neper tcp_rr running with:
> >      1. (baseline) No busylooping
> >      2. (epoll busylooping) enabling the epoll busy looping on all epol=
l
> >      fd's
> >      3. (userspace busylooping) looping on epoll_wait in userspace
> >      with timeout=3D0
> >
> > Stats for two machines with 100Gbps NICs running tcp_rr with 5 threads
> > and varying flows:
> >
> > Type                Flows   Throughput             Latency (=CE=BCs)
> >                               (B/s)      P50   P90    P99   P99.9   P99=
.99
> > baseline            15            272145      57.2  71.9   91.4  100.6 =
  111.6
> > baseline            30            464952      66.8  78.8   98.1  113.4 =
  122.4
> > baseline            60            695920      80.9  118.5  143.4 161.8 =
  174.6
> > epoll busyloop      15            301751      44.7  70.6   84.3  95.4  =
  106.5
> > epoll busyloop      30            508392      58.9  76.9   96.2  109.3 =
  118.5
> > epoll busyloop      60            745731      77.4  106.2  127.5 143.1 =
  155.9
> > userspace busyloop  15            279202      55.4  73.1   85.2  98.3  =
  109.6
> > userspace busyloop  30            472440      63.7  78.2   96.5  112.2 =
  120.1
> > userspace busyloop  60            720779      77.9  113.5  134.9 152.6 =
  165.7
> >
> > Per the above data epoll busyloop outperforms baseline and userspace
> > busylooping in both throughput and latency. As the density of flows per
> > thread increased, the median latency of all three epoll mechanisms
> > converges. However epoll busylooping is better at capturing the tail
> > latencies at high flow counts.
> >
> > Signed-off-by: Naman Gulati <namangulati@google.com>
> > ---
> >   fs/eventpoll.c                 | 53 ++++++++++++++++++++++++++-------=
-
> >   include/uapi/linux/eventpoll.h |  3 +-
> >   2 files changed, 43 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index f53ca4f7fcedd..6cba79261817a 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -232,7 +232,10 @@ struct eventpoll {
> >       u32 busy_poll_usecs;
> >       /* busy poll packet budget */
> >       u16 busy_poll_budget;
> > -     bool prefer_busy_poll;
> > +     /* prefer to busypoll in napi poll */
> > +     bool napi_prefer_busy_poll;
> > +     /* avoid napi poll when busy looping and poll only for events */
> > +     bool event_poll_only;
> >   #endif
> >
> >   #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > @@ -430,6 +433,24 @@ static bool ep_busy_loop_end(void *p, unsigned lon=
g start_time)
> >       return ep_events_available(ep) || busy_loop_ep_timeout(start_time=
, ep);
> >   }
> >
> > +/**
> > + * ep_event_busy_loop - loop until events available or busy poll
> > + * times out.
> > + *
> > + * @ep: Pointer to the eventpoll context.
> > + *
> > + * Return: true if events available, false otherwise.
> > + */
> > +static bool ep_event_busy_loop(struct eventpoll *ep)
> > +{
> > +     unsigned long start_time =3D busy_loop_current_time();
> > +
> > +     while (!ep_busy_loop_end(ep, start_time))
> > +             cond_resched();
> > +
> > +     return ep_events_available(ep);
> > +}
> > +
> >   /*
> >    * Busy poll if globally on and supporting sockets found && no events=
,
> >    * busy loop will return if need_resched or ep_events_available.
> > @@ -440,23 +461,29 @@ static bool ep_busy_loop(struct eventpoll *ep, in=
t nonblock)
> >   {
> >       unsigned int napi_id =3D READ_ONCE(ep->napi_id);
> >       u16 budget =3D READ_ONCE(ep->busy_poll_budget);
> > -     bool prefer_busy_poll =3D READ_ONCE(ep->prefer_busy_poll);
> > +     bool event_poll_only =3D READ_ONCE(ep->event_poll_only);
> >
> >       if (!budget)
> >               budget =3D BUSY_POLL_BUDGET;
> >
> > -     if (napi_id >=3D MIN_NAPI_ID && ep_busy_loop_on(ep)) {
> > +     if (!ep_busy_loop_on(ep))
> > +             return false;
> > +
> > +     if (event_poll_only) {
> > +             return ep_event_busy_loop(ep);
> > +     } else if (napi_id >=3D MIN_NAPI_ID) {
>
> There is no need to use 'else if' in this place, in case of
> event_poll_only =3D=3D true the program flow will not reach this part.
>

Right, I'll change that.

> > +             bool napi_prefer_busy_poll =3D READ_ONCE(ep->napi_prefer_=
busy_poll);
> > +
> >               napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_en=
d,
> > -                            ep, prefer_busy_poll, budget);
> > +                             ep, napi_prefer_busy_poll, budget);
> >               if (ep_events_available(ep))
> >                       return true;
> >               /*
> > -              * Busy poll timed out.  Drop NAPI ID for now, we can add
> > -              * it back in when we have moved a socket with a valid NA=
PI
> > -              * ID onto the ready list.
> > -              */
> > +             * Busy poll timed out.  Drop NAPI ID for now, we can add
> > +             * it back in when we have moved a socket with a valid NAP=
I
> > +             * ID onto the ready list.
> > +             */
>
> I believe this change is accidental, right?
>

Yes, thanks for catching, I'll fix that.

> >               ep->napi_id =3D 0;
> > -             return false;
> >       }
> >       return false;
> >   }
>
> [...]
>

