Return-Path: <netdev+bounces-72818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65120859B79
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 05:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB962810D5
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F101CD0F;
	Mon, 19 Feb 2024 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq6M71qc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599253FF4
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708318669; cv=none; b=HI69FNrPmzwR7OZBLlzaQtIsfMFxNjNdSM3Kjp1pVJoRh32q1AXP4rH+xbb/qgI6rhTQVRs70BdlijhFd/cLSkrzw9qMXM/PEUKfgw/UcnwetLEw58CRhbTl8OO9Vf3tV6n5ZvcXlbSwsF7tM0UNYY210TpP2kqyqG1WodQo6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708318669; c=relaxed/simple;
	bh=DcHOpBXuIUNKrtKXpU8R3S4teXMraShzu+Dsi3+i6lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaYwQXy9T5phE+qHJ14t+x8Te60c08ccue0jTuHx3zywXJc0MoI+xn6RLpe8XPOMCj/AlqilbQu/AZXpjlwwu7jVyJRMcrpNqcjJPM4YDXuOEJQL2QqwfV3gpbam5QmTNDYdA2ICFrdc1wOnARv1PNkavwJJDc6XTtVGhUsxd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq6M71qc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so6099231a12.2
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 20:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708318665; x=1708923465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgOHl0jBSqqkxNVd2eXNQUXbrvDMJy6l5/eSbhRleCU=;
        b=gq6M71qcZzr3JSwuz2dCm4mVfXQi3eVxwx6PT2IxdkaNKTXxMQts0sXEG65xBBWKxa
         xEHr0+2/fRziWlr0z6JCzTcVcCYqunwEuA2ULoahnnmyZFWfxxFriLEEwBQ8pUY5wTI5
         xWuaWMbTpXJqswkIPP6LjFH/bXbODZudVFkbieN1oGLDNC8T1pPoINmgyNaf3s6v/iMA
         niYxeZB6YDPJD+TrOXx0BR2jS+waUeg8ifHvyhxfR51uhit7K2FPnfiCBkKZOIRaHy9j
         fjjD48DpVphCoP6uadZ6T7voDt/VeUm1THA3xYkTnfYlJbgFBaFhKq2Qn3vUr65PTmbc
         MKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708318665; x=1708923465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgOHl0jBSqqkxNVd2eXNQUXbrvDMJy6l5/eSbhRleCU=;
        b=oZdaTrRMyTQ0GZsatstBqgtC+GS9jBryF6kQZyWkQbKl7gyNzZK/UNtJ6ZHwEVjyrv
         0utBStROVsC/GCc/uTN+o3TseDazZEZS9//2xAOu/sobJl/Eh1Bj2/IDWFTCDV2/vK/n
         8MmB1wMutuhFGNnY1rPsFMTeMc/uJhMAa26Mbj9PL5DvBcKvMUay6QkzoNzCjXch6gLb
         hAsjAel/cAaygNgBoSd4NV4i2Yr53VjqanpY4gH7dNPUsQ017MvRNmHdm09WSFsrX7g8
         RtRZ3w+jz2SCx0vjx+Lgj6XwWEnruvIEql9nFRMR983swxJuyNRTS1woc+bV51OjCvyn
         a1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXbKz1mmcvsOPrv6hke35OqBwzaev9bzeC267mAut/HM3Ev0gIDQUDwDXdOndkepMQOVZBY7BW7WyRouJM5z1Nkn+Zir1xB
X-Gm-Message-State: AOJu0YzlN6VL4VVNycqlq9QUQwpFC1/U7l1OBDjdbSJQXpz/1Fx2G9W/
	1rSJqoHALLZU8Q5btVDilcNQugx2ijTnDrLsfrDSbMevqq0XuDDt8W2oRatNVb1Mw1bh9u9pprB
	0Q87vJZEzrZU3X8hQUKk9lWrqJGI=
X-Google-Smtp-Source: AGHT+IHnMVcHedgTQbMN1FuWwUGE04Es/0ZCk0QpsbnhQsBRuEhpYgGwTdW3Tl4bpQVQq/XIs4jGf66QLXEYSfOpw8w=
X-Received: by 2002:aa7:d4d3:0:b0:564:1c4e:eb5c with SMTP id
 t19-20020aa7d4d3000000b005641c4eeb5cmr3068797edr.24.1708318665428; Sun, 18
 Feb 2024 20:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219032838.91723-5-kerneljasonxing@gmail.com> <20240219043815.98410-1-kuniyu@amazon.com>
In-Reply-To: <20240219043815.98410-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Feb 2024 12:57:08 +0800
Message-ID: <CAL+tcoBQAyEw8AnCAn3hjN8-zXxPO9wW4bQrTqv5OPZKMAHXwg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/11] tcp: directly drop skb in cookie check
 for ipv6
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 12:38=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Mon, 19 Feb 2024 11:28:31 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Like previous patch does, only moving skb drop logical code to
> > cookie_v6_check() for later refinement.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > --
> > v6
> > Link: https://lore.kernel.org/all/c987d2c79e4a4655166eb8eafef473384edb3=
7fb.camel@redhat.com/
> > Link: https://lore.kernel.org/all/CAL+tcoAgSjwsmFnDh_Gs9ZgMi-y5awtVx+4V=
hJPNRADjo7LLSA@mail.gmail.com/
> > 1. take one case into consideration, behave like old days, or else it w=
ill trigger errors.
> >
> > v5
> > Link: https://lore.kernel.org/netdev/CANn89iKz7=3D1q7e8KY57Dn3ED7O=3DRC=
OfLxoHQKO4eNXnZa1OPWg@mail.gmail.com/
> > 1. avoid duplication of these opt_skb tests/actions (Eric)
> > ---
> >  net/ipv6/syncookies.c | 4 ++++
> >  net/ipv6/tcp_ipv6.c   | 7 +++----
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> > index 6b9c69278819..ea0d9954a29f 100644
> > --- a/net/ipv6/syncookies.c
> > +++ b/net/ipv6/syncookies.c
> > @@ -177,6 +177,7 @@ struct sock *cookie_v6_check(struct sock *sk, struc=
t sk_buff *skb)
> >       struct sock *ret =3D sk;
> >       __u8 rcv_wscale;
> >       int full_space;
> > +     SKB_DR(reason);
> >
> >       if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
> >           !th->ack || th->rst)
> > @@ -256,10 +257,13 @@ struct sock *cookie_v6_check(struct sock *sk, str=
uct sk_buff *skb)
> >       ireq->ecn_ok &=3D cookie_ecn_ok(net, dst);
> >
> >       ret =3D tcp_get_cookie_sock(sk, skb, req, dst);
> > +     if (!ret)
> > +             goto out_drop;
> >  out:
> >       return ret;
> >  out_free:
> >       reqsk_free(req);
> >  out_drop:
> > +     kfree_skb_reason(skb, reason);
> >       return NULL;
> >  }
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 57b25b1fc9d9..4cfeedfb871f 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1653,12 +1653,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_bu=
ff *skb)
> >       if (sk->sk_state =3D=3D TCP_LISTEN) {
> >               struct sock *nsk =3D tcp_v6_cookie_check(sk, skb);
> >
> > -             if (!nsk)
> > -                     goto discard;
> > -
> > -             if (nsk !=3D sk) {
> > +             if (nsk && nsk !=3D sk) {
> >                       if (tcp_child_process(sk, nsk, skb))
> >                               goto reset;
> > +             }
> > +             if (!nsk || nsk !=3D sk) {
>
> !nsk is redundant, when nsk is NULL, nsk !=3D sk is true.
>
> We can keep the original nsk !=3D sk check and call tcp_child_process()
> only when nsk is not NULL:
>
> ---8<---
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 57b25b1fc9d9..0c180bb8187f 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1653,11 +1653,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff =
*skb)
>         if (sk->sk_state =3D=3D TCP_LISTEN) {
>                 struct sock *nsk =3D tcp_v6_cookie_check(sk, skb);
>
> -               if (!nsk)
> -                       goto discard;
> -
>                 if (nsk !=3D sk) {
> -                       if (tcp_child_process(sk, nsk, skb))
> +                       if (nsk && tcp_child_process(sk, nsk, skb))
>                                 goto reset;
>                         if (opt_skb)
>                                 __kfree_skb(opt_skb);
> ---8<---

Agreed. It looks much better. I'll take it. Thanks!

