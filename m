Return-Path: <netdev+bounces-164935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B38FA2FBFD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 22:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF99165AA3
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 21:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4BD1C3038;
	Mon, 10 Feb 2025 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2EVJHtqT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A224126462C
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222824; cv=none; b=R0vetjmtX2tM/ZgXPM46wT2lTWeFYtUjyyRJG+64cVxla+QsBT+Dd0rsojoOCZTLe7so1ng91akJqyTay+qWxYLL1LSG922lLd0iF00T9JA79ha7molcbZSliJ9IIk3YAxg+L+r5D9Dcci4G7n+YTlSqefV3mg0VnPdzfng0km8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222824; c=relaxed/simple;
	bh=xYS4WR4nFFy0864FBxEEBSt5oXW9AdVCUUISYcs+Gws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZXP4t+OyiGKzTJiM9+28RPJ4VpMkCPxWs7GyVnMFaUnFxBwlvF0K/E/rj2S6MmA5HAuZ0DlfQH7aYfChVDqd5Hq2ZaAkIQD9X56YzWEc+qXH2oao8KLNNmzep4SjWKbS8KNejOQ/WDghsCymCYy8bESBXcOauZ0Kle1UwXeiW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2EVJHtqT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab78d9c5542so618938066b.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 13:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739222821; x=1739827621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY0r2BliUauUtrJL9oIz77q8NbwfWZV4vW1VXbqcNwk=;
        b=2EVJHtqTMYrdY19FUvUWMtrmGQYTgillfYJU01Zfoe/V76EKI4ofDgYTjNzGlqSR+a
         G2BXtBidez6XqVIq1cDy2UyDmW4R0qBF/ZO5jKTI7hwMeI5QPPEk1dl9AetfkFWkxtuI
         Bup8h00DHm4GIY0EZijNXwGsaMv6ytois46ULgXAEtmk4KYcVkmzh4NXvoX4CBmb1Jv3
         FrgIw28EML5pkO1DVYQVcGLV5UG3+hjssHKYYHX1WAN3RQlpXaeHLEsyizMqm6QKdS5m
         JDIvVflZgyRMC5aNJp3T3VurUK3w/5qRRqO1o8e0dwYu4XEvw+c+4R2N1ppTB9ZSk3eW
         uQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739222821; x=1739827621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iY0r2BliUauUtrJL9oIz77q8NbwfWZV4vW1VXbqcNwk=;
        b=Gf47FQGe7QHX+sOOeiGQDu4AZwpso79W5IfOBIAqky1Ia+0BSXFZrV7UZ1H1irl8re
         BlRQlF6TaMqO95tyj8mKmUQETZnxcXXdk9/I1pN9U4mXeJJNKAZVddro6EnmLuA5aTKA
         dIGX0tzv1Gg02wgUyL3pWrPsecahnDkFQ/pU74ErlSyhVi6E3j968kiQPuYRbVil3OX8
         hrvslZUp/BtFT2o82aLTgx3GcJ+qFShX8bLcOXPCbA1xkx/JN6qcnKG92nb2RexBSoFu
         43s7QRf9c8BU+k57E7qPRQg14zU6rrwa6Vc00e+kUn/lNvaHMHjvY+cXUKDSMAOSjUua
         2rjA==
X-Forwarded-Encrypted: i=1; AJvYcCXSvOPXinzJaO3csiqFhwLyKwc1eUpxa4P02TnXDjpe/2XU4B7FRyipnDe3rmM27Cz3yejkxvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysvN/jgPajEgPIBW4N+L62yo/W5W3yRifC6UYoCEPFU7kBIzwb
	gomFGjw5wcWTrCq3MvhuS/E7Hjw9oMqqQ2Z3cRP9kOBOrJJpz7M22pCFS1kUUBnsnT/cm0EinqB
	uTrPFFqNN5CTF2omUtrKJPVkTXof3yW2BWTxM
X-Gm-Gg: ASbGncv/qKB4MzQuvW2p4SeLaW/zcMh2CDl1VEepW5YGdfdIVxikkuEHtcqeCF4CCoi
	0crh4KDrh5HwZsAwCFJuqTJwX50sTEmG7pnFoXIWHmGxVYpvxWLSjbIiD1Dz1q6H6h3cNx65a
X-Google-Smtp-Source: AGHT+IEVE9jcaXK+/S53bfGtVvA2Gw/LJDcorZPjaz8Mo6+dycPa/Jaui+Kb89vmR3rySr4F0/ryN3ZjfDZy7UJ/4PM=
X-Received: by 2002:a17:906:4fd6:b0:aa6:79fa:b47d with SMTP id
 a640c23a62f3a-ab789a681a3mr1637739966b.1.1739222820687; Mon, 10 Feb 2025
 13:27:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738940816.git.pabeni@redhat.com> <67a979c156cbe_14761294f6@willemb.c.googlers.com.notmuch>
 <CANn89i+G_Zeqhjp24DMNXj32Z4_vCt8dTRiZ12ChNjFaYKvGDA@mail.gmail.com>
 <1d8801d4-73a9-4822-adf9-20e6c5a6a25c@redhat.com> <0a7773a4-596d-4c14-9fbe-290faa1f8d01@redhat.com>
In-Reply-To: <0a7773a4-596d-4c14-9fbe-290faa1f8d01@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 22:26:48 +0100
X-Gm-Features: AWEUYZltcHcbcXWgyTQleHjBNexI4rlfB-Tnicp4qKXuoCmi6AAKRw4QAlcnf-0
Message-ID: <CANn89iJA1FRWAcwxwDCYxOV-AnCrdT5UEvdAhRnuCKafnwT7ug@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:24=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 2/10/25 5:16 PM, Paolo Abeni wrote:
> > I expect the change you propose would perform alike the RFC patches, bu=
t
> > I'll try to do an explicit test later (and report here the results).
>
> I ran my test on the sock layout change, and it gave the same (good)
> results as the RFC. Note that such test uses a single socket receiver,
> so it's not affected in any way by the eventual increase of touched
> 'struct sock' cachelines.
>
> BTW it just occurred to me that if we could use another bit from
> sk_flags, something alike the following (completely untested!!!) would
> do, without changing the struct sock layout and without adding other
> sock proto ops:
>
> ---
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8036b3b79cd8..a526db7f5c60 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -954,6 +954,7 @@ enum sock_flags {
>         SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
>         SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
>         SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with pack=
et */
> +       SOCK_TIMESTAMPING_ANY, /* sk_tsflags & TSFLAGS_ANY */
>  };
>
>  #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL <<
> SOCK_TIMESTAMPING_RX_SOFTWARE))
> @@ -2665,12 +2666,12 @@ static inline void sock_recv_cmsgs(struct msghdr
> *msg, struct sock *sk,
>  #define FLAGS_RECV_CMSGS ((1UL << SOCK_RXQ_OVFL)                       |=
 \
>                            (1UL << SOCK_RCVTSTAMP)                      |=
 \
>                            (1UL << SOCK_RCVMARK)                        |=
\
> -                          (1UL << SOCK_RCVPRIORITY))
> +                          (1UL << SOCK_RCVPRIORITY)                    |=
\
> +                          (1UL << SOCK_TIMESTAMPING_ANY))
>  #define TSFLAGS_ANY      (SOF_TIMESTAMPING_SOFTWARE                    |=
 \
>                            SOF_TIMESTAMPING_RAW_HARDWARE)
>
> -       if (sk->sk_flags & FLAGS_RECV_CMSGS ||
> -           READ_ONCE(sk->sk_tsflags) & TSFLAGS_ANY)
> +       if (sk->sk_flags & FLAGS_RECV_CMSGS)
>                 __sock_recv_cmsgs(msg, sk, skb);
>         else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
>                 sock_write_timestamp(sk, skb->tstamp);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index eae2ae70a2e0..a197f0a0b878 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -938,6 +938,7 @@ int sock_set_timestamping(struct sock *sk, int optnam=
e,
>
>         WRITE_ONCE(sk->sk_tsflags, val);
>         sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname =3D=3D SO_TIMESTAM=
PING_NEW);
> +       sock_valbool_flag(sk, SOCK_TIMESTAMPING_ANY, !!(val & TSFLAGS_ANY=
));
>
>         if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
>                 sock_enable_timestamp(sk,

This looks nice indeed.

