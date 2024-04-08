Return-Path: <netdev+bounces-85660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C90789BC95
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886AC1F21AB6
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18109524D1;
	Mon,  8 Apr 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KY75uFhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F4524D7
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570631; cv=none; b=FJLmARQRL0/lVm4AOV/rn5llI5XKQxLs51GUXzVj4KRqPEySb7tiDc81jqDP1hsAwHOiFthOJ64a9FU8m5HakAKYeGuQo5Q6FilANCJcHtjuqmjg/eOhtGUElUEhXRB3j2X7ggoRd6bqD42P0sSPzY9zJ4TkXdDW6pGxB7ZVYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570631; c=relaxed/simple;
	bh=TglUxC2B5T8fWiuGvHoMXF6o1k9bTTzHTKXSEJ9+4Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYFQ50b6MIEutDY/XNE/jpwcJsnXZ4iP+qZr7tBu3oZK2Id1UySbOxsaXgqpIsrT/ONejZOW0ifMLvhWag+UXz8xdsoXncGVCzV5kZtfbi5PaABpUerSPk6Lu9x9E6RI/YILeIOUdzn/8SIKwujLhqvW92OcSxeFMpi/mwGqFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KY75uFhf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so14669a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712570627; x=1713175427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUeK8tUltCiiNIWWzwpRkvxOb1EySFIlgtsCvzHp/MA=;
        b=KY75uFhfcAa9zRw6t9yYL17xytjmOXm+MOT8cEYPsl0yJcQBynExaR2hQ2yTHnfktG
         txiwLUr93IZGIrfRXFtiVyg7ZcfgI/Dy2NoUYH3l3cmUbx8tAarajMRrR/vG8IMNy0SJ
         2fT0GUZNNMyKpoTqhToeg49dqXUKF6OBXSIb8q2LDy3jkpoYX06yCXoYIE0LTwBuuoWq
         eCZJ7R26Pkng9vrxIjI8Seu2hpVo5iCN4oxzyqbBdy/SmYuOXPFvY18KMagCtI2sKUYz
         t6ddRkElKBwKT5HC5QEH8Tew5S66LciMvv8Ig/ScYf9SmeyyVuUulrrUPwic9m/6Ipx5
         nmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570627; x=1713175427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUeK8tUltCiiNIWWzwpRkvxOb1EySFIlgtsCvzHp/MA=;
        b=DqnsYV5phuUTlIjLlGgcfG/5PD/C0LuMi/WwUbkfZuqyMRIFqurslEKixt/v+Jcdtn
         doLHTG55ZJQ05OhaBstHzWNyo6f2avhT8qL6tDnPCHw89bDjbSGV4NUajMkAWmazFkW3
         5lZgQtokw6gVn36yS2ICpNuygeHiQW2A5SAXx763GvDHXREuH7n08fMFW8pfXAxPpycH
         Ip7psZV4JOoKwZwqQTMGqqt9CGYtSBgEXpyJls39qMdgIx9nPEluplUm4BbqcuF7EA1Y
         AbLz7pbHYbBi9SfUFsWlBTl3D40nyntjA7aIkveIMGLPDZ4J4ofG03mNyKHzSqw3VSjy
         cS/g==
X-Gm-Message-State: AOJu0YwWK9BExEpq7a3dBKoHQzx75y7vyaZY9Vul8jeJZ+eDc1vg3bsk
	DFCORsZ4nH+Wr1LutFoDmpGJMIdgnlE2tZhKHbi6UhJcTb/aFfEHdBMuA4Edv6h2Fr2SxNEy3kS
	2Qpqj+jPCbMCQM0xK3tD1FJ5gpPwyYXc3hLYt
X-Google-Smtp-Source: AGHT+IHo4xqDV2ksYOcRZu/IBTlWIBBQ4JZAobA8bJwE8WOGynuS/UjeVbuj/3gPonZ9dTtC8OkJ9NXvnh5DfV9DROQ=
X-Received: by 2002:a05:6402:2554:b0:56e:68ac:3d50 with SMTP id
 l20-20020a056402255400b0056e68ac3d50mr58769edb.4.1712570627209; Mon, 08 Apr
 2024 03:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406182107.261472-1-jmaloy@redhat.com> <20240406182107.261472-3-jmaloy@redhat.com>
 <CANn89iJgXBXaZyX5gBwr4WiAz5DRn8sH_v0LLtNOSB84yDP3yg@mail.gmail.com>
In-Reply-To: <CANn89iJgXBXaZyX5gBwr4WiAz5DRn8sH_v0LLtNOSB84yDP3yg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Apr 2024 12:03:35 +0200
Message-ID: <CANn89i+UjuasDbqH2tUu0wv=m+roHocBHwzcV4VS+Wotz-8hng@mail.gmail.com>
Subject: Re: [net-next 2/2] tcp: correct handling of extreme menory squeeze
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 8:37=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Sat, Apr 6, 2024 at 8:21=E2=80=AFPM <jmaloy@redhat.com> wrote:
> >
> > From: Jon Maloy <jmaloy@redhat.com>
> >
> > Testing of the previous commit ("tcp: add support for SO_PEEK_OFF")
> > in this series along with the pasta protocol splicer revealed a bug in
> > the way tcp handles window advertising during extreme memory squeeze
> > situations.
> >
> > The excerpt of the below logging session shows what is happeing:
> >
> > [5201<->54494]:     =3D=3D=3D=3D Activating log @ tcp_select_window()/2=
68 =3D=3D=3D=3D
> > [5201<->54494]:     (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM) -=
-> TRUE
> > [5201<->54494]:   tcp_select_window(<-) tp->rcv_wup: 2812454294, tp->rc=
v_wnd: 5812224, tp->rcv_nxt 2818016354, returning 0
> > [5201<->54494]:   ADVERTISING WINDOW SIZE 0
> > [5201<->54494]: __tcp_transmit_skb(<-) tp->rcv_wup: 2812454294, tp->rcv=
_wnd: 5812224, tp->rcv_nxt 2818016354
> >
> > [5201<->54494]: tcp_recvmsg_locked(->)
> > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_now=
): 500328))? --> time_to_ack: 0
> > [5201<->54494]:     NOT calling tcp_send_ack()
> > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]: tcp_recvmsg_locked(<-) returning 131072 bytes, window n=
ow: 250164, qlen: 83
> >
> > [...]
>
> I would prefer a packetdrill test, it is not clear what is happening...
>
> In particular, have you used SO_RCVBUF ?
>
> >
> > [5201<->54494]: tcp_recvmsg_locked(->)
> > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_now=
): 500328))? --> time_to_ack: 0
> > [5201<->54494]:     NOT calling tcp_send_ack()
> > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]: tcp_recvmsg_locked(<-) returning 131072 bytes, window n=
ow: 250164, qlen: 1
> >
> > [5201<->54494]: tcp_recvmsg_locked(->)
> > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_now=
): 500328))? --> time_to_ack: 0
> > [5201<->54494]:     NOT calling tcp_send_ack()
> > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]: tcp_recvmsg_locked(<-) returning 57036 bytes, window no=
w: 250164, qlen: 0
> >
> > [5201<->54494]: tcp_recvmsg_locked(->)
> > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]:     NOT calling tcp_send_ack()
> > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]: tcp_recvmsg_locked(<-) returning -11 bytes, window now:=
 250164, qlen: 0
> >
> > We can see that although we are adverising a window size of zero,
> > tp->rcv_wnd is not updated accordingly. This leads to a discrepancy
> > between this side's and the peer's view of the current window size.
> > - The peer thinks the window is zero, and stops sending.
> > - This side ends up in a cycle where it repeatedly caclulates a new
> >   window size it finds too small to advertise.
> >
> > Hence no messages are received, and no acknowledges are sent, and
> > the situation remains locked even after the last queued receive buffer
> > has been consumed.
> >
> > We fix this by setting tp->rcv_wnd to 0 before we return from the
> > function tcp_select_window() in this particular case.
> > Further testing shows that the connection recovers neatly from the
> > squeeze situation, and traffic can continue indefinitely.
> >
> > Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> > Signed-off-by: Jon Maloy <jmaloy@redhat.com>

I do not think this patch is good. If we reach zero window, it is a
sign something is wrong.

TCP has heuristics to slow down the sender if the receiver does not
drain the receive queue fast enough.

MSG_PEEK is an obvious reason, and SO_RCVLOWAT too.

I suggest you take a look at tcp_set_rcvlowat(), see what is needed
for SO_PEEK_OFF (ab)use ?

In short, when SO_PEEK_OFF is in action :
- TCP needs to not delay ACK when receive queue starts to fill
- TCP needs to make sure sk_rcvbuf and tp->window_clamp grow (if
autotuning is enabled)

