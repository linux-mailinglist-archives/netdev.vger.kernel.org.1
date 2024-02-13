Return-Path: <netdev+bounces-71466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF188536DB
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED15D1F24CA4
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B005FBA1;
	Tue, 13 Feb 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsUmUAUH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FAC5FDAB
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844186; cv=none; b=SEca3ufsrilC9zYoHQHwQr6X3e+gNAZIiAD3MaLm72Y7Oz4JeSeBX18E3QvpjuMSQj6276iUdfc2iqsP/RdgN1l++8n1fRvrTypFa9VsxTpGlVQpChLaIy/VFGIVI9dafF+B9gKF4F9g9EhBUjZ32ECsH6gxseT1XwJjVwpsQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844186; c=relaxed/simple;
	bh=wdRyjHyHNQCMJiMIeDpi77j7EwjGwF/1QWz2/hQZIe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnW2ea2SGvQsHr38Ugswfcz24XrUH9oMCrPbVL+/n62shDe7x3Jv+k5MIxtZbq1nG0npwIRWDeQrYEa+YiybJHCUZn/RRPBOX1/XWKazCNS+knpqAlRDr3IrFzGFG0exSQUEn8SUp7L0CsaGFvjdLqmqEbLYjOWeHKH3KDpOzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsUmUAUH; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0e521de4eso39901991fa.2
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707844183; x=1708448983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpgfkiUk5ZPQZJCoSnuFRddxEWV9dZ627UGC1x8ctxc=;
        b=AsUmUAUH7RfNBEWIfgHCkiotv5incnZbHFnizYOj3hrTDhMsxNaudD369gojPSc6GW
         fn+JDZNNjQeFZYR4bA1A4yrPMEdNis7ZVCZNoikhwLR9hH5qwhsoGSuHmUilZCwgtfW8
         fYxolDH0CygEpj3QUOmDipOYdy+AesypuxWAMx5UE4CAExa3M7/K52BouKBQo96AkbIZ
         1qWAQFR3MzrJ/eGErjFZh091EZupvqX9yIvsMVI3vtnXJlu9qMigFmnjU6WqZD5lJ7wV
         LKhtguR1FJ2riM2Fm0V6hO1oiPso8YmotoE2bBWQk7dqr8tbZufDvnfQrJGRRJOys7jc
         CkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844183; x=1708448983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpgfkiUk5ZPQZJCoSnuFRddxEWV9dZ627UGC1x8ctxc=;
        b=oNTunwKfP27uMSCE2lN6pMj5hMnBXk+932bUYgbMBz2XIorTNU/nABJWAGzEPzAMQq
         vQxmFH1Ku6RucOu82qJ5d0kk8Nqg2NgUVOaLScz9PxgCFYBDnwE1pNU/GxC0SdHMEtsj
         gRCzQP5BdCnOz+bAPQQg7pimJSrE9lVJ0CMBpbnDfraasQp6JDS/A5lpiT3VZNnt35lO
         xN2nBlvDzaMq1deHZaT2VY5NLj+YIn6/FYLlns3B6SjAhEUfTB684K5oWmzGX/3EaXMX
         enC8vikCO2SJWSN7dsetVLb7KlyRBN/a1We+OkhsxWvNOu1jogtyKyRqIk5GF4oowF5N
         0shA==
X-Forwarded-Encrypted: i=1; AJvYcCWVtfMI+5cjbOCrdKjz8JK0mtsWKmUTdJcL8sGSkukMoaOD0RmEjL0D3+AY0u1VTX8e34aRRZQNE8khHJjsxusv3DRMHc7J
X-Gm-Message-State: AOJu0Yxrts4mIONiZcLggdmJITXgpAkWgZ6QOfXmNddnlrr1V2eL30aC
	yh+WpZFf4Ht/Jsl+vCHgCwk0r9pNJoGK1yp0G9A9l6Nl7p8PZr2YUjbyclnvzO5LmGZl+X8AEXZ
	9nSMHNeSzd9fbSWnMbOGHQc4UMUA=
X-Google-Smtp-Source: AGHT+IGOMvnEJ1Ac4DiS202SMd9L3kjQbHyxi/aK+TgRKfrQaoB+AM0G2MzHXltCRD641h7bBoY6ogxDk+Ds4dDozSo=
X-Received: by 2002:a19:5216:0:b0:511:9776:8a23 with SMTP id
 m22-20020a195216000000b0051197768a23mr97356lfb.65.1707844182731; Tue, 13 Feb
 2024 09:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213134205.8705-1-kerneljasonxing@gmail.com>
 <20240213134205.8705-5-kerneljasonxing@gmail.com> <CANn89iKz7=1q7e8KY57Dn3ED7O=RCOfLxoHQKO4eNXnZa1OPWg@mail.gmail.com>
In-Reply-To: <CANn89iKz7=1q7e8KY57Dn3ED7O=RCOfLxoHQKO4eNXnZa1OPWg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Feb 2024 01:09:06 +0800
Message-ID: <CAL+tcoBgjNjLCXD716G-yc2gTiPF+-tyKF3Tz6CQBXBSDe3Tfg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/5] tcp: directly drop skb in cookie check
 for ipv6
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:30=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Feb 13, 2024 at 2:42=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Like previous patch does, only moving skb drop logical code to
> > cookie_v6_check() for later refinement.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv6/syncookies.c | 4 ++++
> >  net/ipv6/tcp_ipv6.c   | 7 +++++--
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> > index 6b9c69278819..ea0d9954a29f 100644
> > --- a/net/ipv6/syncookies.c
> > +++ b/net/ipv6/syncookies.c
> > @@ -177,6 +177,7 @@ struct sock *cookie_v6_check(struct sock *sk, struc=
t sk_buff *skb)
> >         struct sock *ret =3D sk;
> >         __u8 rcv_wscale;
> >         int full_space;
> > +       SKB_DR(reason);
> >
> >         if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
> >             !th->ack || th->rst)
> > @@ -256,10 +257,13 @@ struct sock *cookie_v6_check(struct sock *sk, str=
uct sk_buff *skb)
> >         ireq->ecn_ok &=3D cookie_ecn_ok(net, dst);
> >
> >         ret =3D tcp_get_cookie_sock(sk, skb, req, dst);
> > +       if (!ret)
> > +               goto out_drop;
> >  out:
> >         return ret;
> >  out_free:
> >         reqsk_free(req);
> >  out_drop:
> > +       kfree_skb_reason(skb, reason);
> >         return NULL;
> >  }
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 57b25b1fc9d9..27639ffcae2f 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1653,8 +1653,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buf=
f *skb)
> >         if (sk->sk_state =3D=3D TCP_LISTEN) {
> >                 struct sock *nsk =3D tcp_v6_cookie_check(sk, skb);
> >
> > -               if (!nsk)
> > -                       goto discard;
> > +               if (!nsk) {
> > +                       if (opt_skb)
> > +                               __kfree_skb(opt_skb);
> > +                       return 0;
> > +               }
> >
> >                 if (nsk !=3D sk) {
> >                         if (tcp_child_process(sk, nsk, skb))
> > --
>
> or perhaps try to avoid duplication of these opt_skb tests/actions.
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 57b25b1fc9d9d529e3c53778ef09b65b1ac4c9d5..1ca4f11c3d6f3af2a0148f0e5=
0dfea96b8ba3a53
> 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1653,16 +1653,13 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
>         if (sk->sk_state =3D=3D TCP_LISTEN) {
>                 struct sock *nsk =3D tcp_v6_cookie_check(sk, skb);
>
> -               if (!nsk)
> -                       goto discard;
> -
> -               if (nsk !=3D sk) {
> +               if (nsk && nsk !=3D sk) {
>                         if (tcp_child_process(sk, nsk, skb))
>                                 goto reset;
> -                       if (opt_skb)
> -                               __kfree_skb(opt_skb);
> -                       return 0;
>                 }
> +               if (opt_skb)
> +                       __kfree_skb(opt_skb);
> +               return 0;
>         } else
>                 sock_rps_save_rxhash(sk, skb);

Thanks for your advice. Will update it:)

Thanks,
Jason

