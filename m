Return-Path: <netdev+bounces-115653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F369475EF
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B101C2096D
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 07:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B7149000;
	Mon,  5 Aug 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3qFdGWw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD4146A6F
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842591; cv=none; b=J6qTpJiUsiV2ipbU+x8SSkLLUkFS3nDkXFVt58pV0aDTVIeymzr5zUZX9oGhRC1SsieABcjEJY5olWBranr2zMOgnCSb2jkNgziJXX2n8miyWn82m4gv3q4EZFG3nezSRXqy3SE1qxxvBGSxZVnoT+LfYQej97NwggXg7ZjiWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842591; c=relaxed/simple;
	bh=whviROFOksxKo0ATxUEhZYm+jGP5OEw5Ou1nGR5Chrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2rPR2WUbEndeUHY8A4tKNltk14FSm9nD+MuLYwWnv+kqosmywvy25bfAI8ddQO3NrTR8TRiYofiFlmBA+YivQAPq/5MpRnSdYvWRu7K8Yka6ZvaC8FKquHYS1L32czyiexjES8XYTw88URILyku669IypuGNkvyMEszT8/Cn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3qFdGWw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so7845a12.0
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 00:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722842588; x=1723447388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwtAi2JDzAVWKNytVgaFiG1iE0Nc4sSYXPYsvIjBKDU=;
        b=F3qFdGWw+Y/IQTWYj4qv3v+EPp08fZT5hXyEHYd6qyG4rqWggSkTQmlXFR7YwCtyM7
         GtYwIa8i1KaWvHpewTEs3rVeEosOGFHVM+Itn32KuscxPEop7oX9j/8a/x5lThqiP7KX
         7yML8uzfe5BzC0x9fhMmONwuejwJEQeFSaekRITBQ+SwsTkP7/4ixQI6/4W1N6rIbisC
         DxFXepKV/9fwjTsbA8vzPf3AOBAUSXu9774PnDgtY00yX4wEt4zeYf8IqgwJDK5hL4/1
         WpVnGjkXLKN9mOmzNv98aROQ4jYG3xlBIUgxun4OwyOe8XScDghT0xf3IKrPKSiXI/A0
         Qo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842588; x=1723447388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwtAi2JDzAVWKNytVgaFiG1iE0Nc4sSYXPYsvIjBKDU=;
        b=QA/VqKIqIf2dGRxWo1IkMoCwyqzktHYuPc+ZuQotbLQiuv1hFogOeAvnx1sDNFCnx5
         3QpHSHQYOKjYs+tLIq1IvBsiixXyqaVhFIcvz8kxo0hkTEQwsK2XWPqb8KeHAVGO5m9f
         bAsFLea/Hyz3BmOnkwaMYtA+AB4SGlA+yTJYodFm08+LlDTljY3zgbyq7aKZIsvE70Ya
         r5OkFWe76J0z8d6AdD3JVXZT7k8pKauj7zP+j1z2K5zXuicFVI3ccM4wNukjbdZmjSrS
         OjarB3GMi6FF1EGF9e9ZmLu257UXpE7+6iNHAGprNiXfPQF0eeVELgzK3xd1dUELsi8V
         o97A==
X-Forwarded-Encrypted: i=1; AJvYcCWniG3oH5x8A3Y+yloJcOVJpewyfoswG27D5uTOGRscc2gNSr1Qb09say7dy9Zmg2v09OHoj2FRLAe0yOHBeYWaeFfOCt3/
X-Gm-Message-State: AOJu0YxzvfnErfeZ7lnlSxCSehtos+SVcJJJ5bz1o0Z1uI9HPG7dNJym
	mAd15f634hJoIu/aBTWXDbrJtQXBxlzU1wlyvGt4QRCzWeD6sINbudKCtuxqv9xvN/BVm1cSFAC
	oO5PLZhYJdYT8Q7U4qQl+04Puo3Ru7bBMICMa
X-Google-Smtp-Source: AGHT+IEGUJM4hq/vsukiju3tD4QDurT9hpBRP4QGdwM3aICEZAEMueWtC90QZzuZKjFWZ9zdyjzgA/Cu+NVPKGJBXNc=
X-Received: by 2002:a05:6402:270e:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5b9c68cf7f9mr209673a12.6.1722842587613; Mon, 05 Aug 2024
 00:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me> <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
 <CAL+tcoAHBSDLTNobA1MJ2itLja1xnWwmejDioPBQJh83oma55Q@mail.gmail.com> <CAL+tcoDnFCWpFvkjs=7r2C2L_1Fb_8X2J9S0pDNV1KfJKsFo+Q@mail.gmail.com>
In-Reply-To: <CAL+tcoDnFCWpFvkjs=7r2C2L_1Fb_8X2J9S0pDNV1KfJKsFo+Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 Aug 2024 09:22:53 +0200
Message-ID: <CANn89iLNnXEnaAY8xMQR6zeJPTd6ZxnJWo3vHE4d7oe9uXRMUg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Xueming Feng <kuro@kuroa.me>, Lorenzo Colitti <lorenzo@google.com>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 6:52=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Sat, Aug 3, 2024 at 11:48=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Thu, Aug 1, 2024 at 9:17=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Thu, Aug 1, 2024 at 1:17=E2=80=AFPM Xueming Feng <kuro@kuroa.me> w=
rote:
> > > >
> > > > We have some problem closing zero-window fin-wait-1 tcp sockets in =
our
> > > > environment. This patch come from the investigation.
> > > >
> > > > Previously tcp_abort only sends out reset and calls tcp_done when t=
he
> > > > socket is not SOCK_DEAD aka. orphan. For orphan socket, it will onl=
y
> > > > purging the write queue, but not close the socket and left it to th=
e
> > > > timer.
> > > >
> > > > While purging the write queue, tp->packets_out and sk->sk_write_que=
ue
> > > > is cleared along the way. However tcp_retransmit_timer have early
> > > > return based on !tp->packets_out and tcp_probe_timer have early
> > > > return based on !sk->sk_write_queue.
> > > >
> > > > This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resche=
d
> > > > and socket not being killed by the timers. Converting a zero-window=
ed
> > > > orphan to a forever orphan.
> > > >
> > > > This patch removes the SOCK_DEAD check in tcp_abort, making it send
> > > > reset to peer and close the socket accordingly. Preventing the
> > > > timer-less orphan from happening.
> > > >
> > > > Fixes: e05836ac07c7 ("tcp: purge write queue upon aborting the conn=
ection")
> > > > Fixes: bffd168c3fc5 ("tcp: clear tp->packets_out when purging write=
 queue")
> > > > Signed-off-by: Xueming Feng <kuro@kuroa.me>
> > >
> > > This seems legit, but are you sure these two blamed commits added thi=
s bug ?
> > >
> > > Even before them, we should have called tcp_done() right away, instea=
d
> > > of waiting for a (possibly long) timer to complete the job.
> > >
> > > This might be important when killing millions of sockets on a busy se=
rver.
> > >
> > > CC Lorenzo
> > >
> > > Lorenzo, do you recall why your patch was testing the SOCK_DEAD flag =
?
> >
> > I guess that one of possible reasons is to avoid double-free,
> > something like this, happening in inet_csk_destroy_sock().
> >
> > Let me assume: if we call tcp_close() first under the memory pressure
> > which means tcp_check_oom() returns true and then it will call
> > inet_csk_destroy_sock() in __tcp_close(), later tcp_abort() will call
> > tcp_done() to free the sk again in the inet_csk_destroy_sock() when
> > not testing the SOCK_DEAD flag in tcp_abort.
> >
>
> How about this one which can prevent double calling
> inet_csk_destroy_sock() when we call destroy and close nearly at the
> same time under that circumstance:
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03a342c9162..d5d3b21cc824 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4646,7 +4646,7 @@ int tcp_abort(struct sock *sk, int err)
>         local_bh_disable();
>         bh_lock_sock(sk);
>
> -       if (!sock_flag(sk, SOCK_DEAD)) {
> +       if (sk->sk_state !=3D TCP_CLOSE) {
>                 if (tcp_need_reset(sk->sk_state))
>                         tcp_send_active_reset(sk, GFP_ATOMIC,
>                                               SK_RST_REASON_NOT_SPECIFIED=
);
>
> Each time we call inet_csk_destroy_sock(), we must make sure we've
> already set the state to TCP_CLOSE. Based on this, I think we can use
> this as an indicator to avoid calling twice to destroy the socket.

I do not think this will work.

With this patch, a listener socket will not get an error notification.

Ideally we need tests for this seldom used feature.

