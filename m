Return-Path: <netdev+bounces-115667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A82819476DE
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 191C6B22463
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E344914B084;
	Mon,  5 Aug 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5ZSFCbn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0E14A639;
	Mon,  5 Aug 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845089; cv=none; b=inAoUyuXZVdOx8yA6dMkl7wJGZXla5KgbO4b2zOqsrg/D7qORrN2/J3OmMwQ3fdl0X3YsReY2aMI4O90vbzm4sY13UpB9GE6FgxDUjwHRWKBg4bap92kk/YBAjiZ/W/CUChBeHwVbuUbQkjl/jBPhuSBzCzhOeKw/KDN/46LptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845089; c=relaxed/simple;
	bh=OH9eMFxXkTz3nZUDCbKgTQLCvQ/Ah5RpkU7tEaQnWIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bA7/U1w/ILGfs7wrk1kIelZBzm69hsBIWKAvgariwtUKUyaoFqXFzpGztBP8OcKinlQ0Q2Xf0EH37wqoCxJtOr0MgFHZUEA4+jGwHdHv6wpDmCTKfqOoYoIuXjLNoZi3DP907iY7RKvgutmWFlsyf2+tCtBhuxVOmFfA9VFNz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5ZSFCbn; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39b3c36d247so4393635ab.3;
        Mon, 05 Aug 2024 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722845087; x=1723449887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV2EB2MiXTNRu5sSGmUBTQgjztxQtI0naxCItk5VCMw=;
        b=j5ZSFCbn3lQL585lXmG41GYwGQC2tUll+LQds8l7ofcJNnTS4c19s3CwWDtGD+B5cD
         6Telq1HHT+85tk+d0smfKGblwMYorB5stqJPPFooDYrRl98ywHUaN4swXRJ0ieFy0f6o
         Ha+8NZMLIyUhBmozgO2iZw21pLT/BV7UgXF5f166ssC0PFXEYRphTwWH1PQ1OzSjIM/D
         bmZ0eG4PUe+FeJHD1jzWpL3Qj7feOhi+ML6f1l87AQMY5YilhEXH2e5IK0fWKe9g8psT
         VGObsTh/oPKIF5g707MDczMSiO0ylufeskhU3icVcM8bESf7wVTjYQpbMOLLoXrx2xPM
         HXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722845087; x=1723449887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV2EB2MiXTNRu5sSGmUBTQgjztxQtI0naxCItk5VCMw=;
        b=KUxyrOeHIxRUdOiuXk5274lNV7Q1N1fBJyBZN6Hm5leueanHZAfJPuiQlZPdno8mab
         6FWEXBOHoM8bdMq/E9VQk1NU+kv+p2SdnSIu5cRDbZGydzdwlcm7/FOpLqDz7s2g2t+m
         5uZyT9H31Ow1wr18Ft5TYlp94lsc/QWtdkRV+K9zzsU4uCymjlUSvlqSphHCHkDZJolS
         oZp+ypGoWs9yLFEZqzHfEqI4t1Xo0+c1TI7n3voK2FMvUeq/oJ0M6/dqR5uh1/lPIMvQ
         f7LZFZkcdpTaGGz9vIkJs0Tkwn0UtsT+d/hug2n8Jq8RpxQftua1KNZm6t/spAO/cnwl
         uBAw==
X-Forwarded-Encrypted: i=1; AJvYcCUaTWrhpexUKROZX3BVsNzLdL+CPIEUf3c59zhJJEzy78QbXOYogM2wMxBv310hNLWmPIuJWX/HW8jF/rU=@vger.kernel.org, AJvYcCXd1PfO953vK7Vueeqwi68gQ2BUFZUhFUK2HouhfRWcYNwOW/I7x4kYCJcVVMlGilitIX8MnYIM@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPecak1x0PgPh6/pA/5RTXnxaIDIlzNXVPdO+XCtQdKOMeyf+
	t/KyhHiKMlFRB+/DEdBmHALIdTp0fYoERvLndfYUE/VDTpG5jjygejcx2laZ8f0ItZO2m91rIKU
	QK61Ii3LG9PK8m8DcX822fg2TFog=
X-Google-Smtp-Source: AGHT+IFeJY5Nm8n1uDPCqlH+FYmRO8SXNlBC2mlab/7R7Rz2br2uDNHs1mCUAIkxvIr+ha3f5H+37kP4wUNJxSZjqVc=
X-Received: by 2002:a92:d604:0:b0:382:f728:6ce5 with SMTP id
 e9e14a558f8ab-39b1fc3834amr110689185ab.27.1722845087396; Mon, 05 Aug 2024
 01:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me> <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
 <CAL+tcoAHBSDLTNobA1MJ2itLja1xnWwmejDioPBQJh83oma55Q@mail.gmail.com>
 <CAL+tcoDnFCWpFvkjs=7r2C2L_1Fb_8X2J9S0pDNV1KfJKsFo+Q@mail.gmail.com> <CANn89iLNnXEnaAY8xMQR6zeJPTd6ZxnJWo3vHE4d7oe9uXRMUg@mail.gmail.com>
In-Reply-To: <CANn89iLNnXEnaAY8xMQR6zeJPTd6ZxnJWo3vHE4d7oe9uXRMUg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 5 Aug 2024 16:04:10 +0800
Message-ID: <CAL+tcoADT8EnQdFctCHab0B6cf9WyhFoAzNMxOA+JraRuTfUug@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Eric Dumazet <edumazet@google.com>
Cc: Xueming Feng <kuro@kuroa.me>, Lorenzo Colitti <lorenzo@google.com>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 3:23=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Aug 5, 2024 at 6:52=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Sat, Aug 3, 2024 at 11:48=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > Hello Eric,
> > >
> > > On Thu, Aug 1, 2024 at 9:17=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > > >
> > > > On Thu, Aug 1, 2024 at 1:17=E2=80=AFPM Xueming Feng <kuro@kuroa.me>=
 wrote:
> > > > >
> > > > > We have some problem closing zero-window fin-wait-1 tcp sockets i=
n our
> > > > > environment. This patch come from the investigation.
> > > > >
> > > > > Previously tcp_abort only sends out reset and calls tcp_done when=
 the
> > > > > socket is not SOCK_DEAD aka. orphan. For orphan socket, it will o=
nly
> > > > > purging the write queue, but not close the socket and left it to =
the
> > > > > timer.
> > > > >
> > > > > While purging the write queue, tp->packets_out and sk->sk_write_q=
ueue
> > > > > is cleared along the way. However tcp_retransmit_timer have early
> > > > > return based on !tp->packets_out and tcp_probe_timer have early
> > > > > return based on !sk->sk_write_queue.
> > > > >
> > > > > This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resc=
hed
> > > > > and socket not being killed by the timers. Converting a zero-wind=
owed
> > > > > orphan to a forever orphan.
> > > > >
> > > > > This patch removes the SOCK_DEAD check in tcp_abort, making it se=
nd
> > > > > reset to peer and close the socket accordingly. Preventing the
> > > > > timer-less orphan from happening.
> > > > >
> > > > > Fixes: e05836ac07c7 ("tcp: purge write queue upon aborting the co=
nnection")
> > > > > Fixes: bffd168c3fc5 ("tcp: clear tp->packets_out when purging wri=
te queue")
> > > > > Signed-off-by: Xueming Feng <kuro@kuroa.me>
> > > >
> > > > This seems legit, but are you sure these two blamed commits added t=
his bug ?
> > > >
> > > > Even before them, we should have called tcp_done() right away, inst=
ead
> > > > of waiting for a (possibly long) timer to complete the job.
> > > >
> > > > This might be important when killing millions of sockets on a busy =
server.
> > > >
> > > > CC Lorenzo
> > > >
> > > > Lorenzo, do you recall why your patch was testing the SOCK_DEAD fla=
g ?
> > >
> > > I guess that one of possible reasons is to avoid double-free,
> > > something like this, happening in inet_csk_destroy_sock().
> > >
> > > Let me assume: if we call tcp_close() first under the memory pressure
> > > which means tcp_check_oom() returns true and then it will call
> > > inet_csk_destroy_sock() in __tcp_close(), later tcp_abort() will call
> > > tcp_done() to free the sk again in the inet_csk_destroy_sock() when
> > > not testing the SOCK_DEAD flag in tcp_abort.
> > >
> >
> > How about this one which can prevent double calling
> > inet_csk_destroy_sock() when we call destroy and close nearly at the
> > same time under that circumstance:
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index e03a342c9162..d5d3b21cc824 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -4646,7 +4646,7 @@ int tcp_abort(struct sock *sk, int err)
> >         local_bh_disable();
> >         bh_lock_sock(sk);
> >
> > -       if (!sock_flag(sk, SOCK_DEAD)) {
> > +       if (sk->sk_state !=3D TCP_CLOSE) {
> >                 if (tcp_need_reset(sk->sk_state))
> >                         tcp_send_active_reset(sk, GFP_ATOMIC,
> >                                               SK_RST_REASON_NOT_SPECIFI=
ED);
> >
> > Each time we call inet_csk_destroy_sock(), we must make sure we've
> > already set the state to TCP_CLOSE. Based on this, I think we can use
> > this as an indicator to avoid calling twice to destroy the socket.
>
> I do not think this will work.
>
> With this patch, a listener socket will not get an error notification.

Oh, you're right.

I think we can add this particular case in the if or if-else statement
to handle.

Thanks,
Jason

