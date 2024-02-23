Return-Path: <netdev+bounces-74637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 946068620DF
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 01:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82FD1C23ED7
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56D014DFED;
	Sat, 24 Feb 2024 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isXnBIqg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65714DFD6
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732802; cv=none; b=PmwnzPbTEdBwmumw9oGslZp9Hw44NIQw1cYtpm2MCthN+6/RQfkGO/pb3Qzc8woCJemcnfHjPoCnSqUhRn2slwDBGXixLtXk1NkogJXQTMTXGGyVlNbPhwZnQosEA9exWalQTaRXFrbI46zQSGy4fFTIfmIDibhrsd9rCzwpSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732802; c=relaxed/simple;
	bh=BOKBCskQd1duNqsHDhPEOlNRL1+qJ6O87VBljKaKUzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHOZzpQGWVo36zup/dXd1P+3OSHNzT2nofMK3MqF023xlr4YmL0JU/KumBWDzEz5KUktRYCmEE2f6iB+uTbN5s1U+4SB9+LU8RODWD7ErOpp77wxoTCBsLuXKpDUpvWv1HKq4wc2sTxbFs9ebnWaNpBcgf+D+o20cj+n91DKnXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isXnBIqg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3d01a9a9a2so152457766b.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708732799; x=1709337599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Dww4UyYm2PHBVB0cxcCL6Nyz8VPnLySoC9dwQG4AsQ=;
        b=isXnBIqgT3f0ukEwaZCB8u5rYXEmAhDs5ktNvGjhw4mkKAnDtR+gmgV8yAC0XA7fte
         pMFb1/nGTmbkE9iNHpWEuK6s4yTnlqcUvCXK7TlHTgmjMUU7VlYDjKl/D6sZYBgiQEAi
         0a53ArcImQUKM9nvTXHVbQnKXwXJ2y9iMyNZgY2gpafeSYf4bX8FVZKHcEqK4pnqTv3N
         taJklOuQiTY52IhgRTH2ijWSEV7Wjo9WwW2jEoi5GPNJvpuM64ypKVkbTzouJsXKOZPR
         IEjSjnhMuqYaCdun/1Ukbp7fzNHfN1gujz70JSLJ7W3aCHii+Bwd6OgAq16JnsDCqbRs
         WUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732799; x=1709337599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Dww4UyYm2PHBVB0cxcCL6Nyz8VPnLySoC9dwQG4AsQ=;
        b=GvnOMGXX/Zi3jmOlzpDy+udPTdJ1giCkhK9nlCgTVXnoLMN0p2i/2sjZLmzqwaEChF
         wStOm0v+ISkUvvo+qr9J94O6+G8hn9CTVgVq4oqjSaU5rtDpuFpp/6qb1hVNB2hMlN1S
         i4vjdg9iQv6qk6gLj0n+N2gycmFM1V3Jb9t4CzTxt4mXW6wIdf+VoXySqvHCQxwTxBxM
         SJZYxbhhkl1wFPenAINUoLDiiDlFEAZsfyhxxSOQuc83DjJLvC2pqfggkVXuvBr4TIXS
         zkwQ5fL9RSYJ5and9L4541nXE4pJ6IFZ5JpCeIx+u9ugMx3GzYo4NYPNskHODMhwM8jk
         Av6w==
X-Forwarded-Encrypted: i=1; AJvYcCVAKuolLz0JdOzEdii0ynxb3lRl7USYfnfaG1hcTdGX4RXm+cfP44otTeS5Ds+RAsD1ejerS/gvLbVfFLDG6YsEbrGOl0Uz
X-Gm-Message-State: AOJu0YwY4pDra/GsNb9ilbzNS3RFXRlCCpPJMXxNAh/66tsUj7whjG2U
	5bscNzPAd51H2b2gw6aGAGBUfPzERf55a0sKkARkJzVDlusTQ83KwAG20DDhpdLfCt2ct/jWRvU
	AYx22TXN00OuRwmpGu2oAbKKHuwQ=
X-Google-Smtp-Source: AGHT+IEJvUDjqvzD0d+097RL+bKDwxRBSlYydcZrt2dExKmPzaQPCNMfkf2WFU6X2VhJK2clD/zMqkRSM78+HhdcRRs=
X-Received: by 2002:a17:906:57d0:b0:a42:e142:d168 with SMTP id
 u16-20020a17090657d000b00a42e142d168mr260935ejr.64.1708732798684; Fri, 23 Feb
 2024 15:59:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223102851.83749-10-kerneljasonxing@gmail.com> <20240223194445.7537-1-kuniyu@amazon.com>
In-Reply-To: <20240223194445.7537-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 24 Feb 2024 07:59:22 +0800
Message-ID: <CAL+tcoCcppce8LMPsFjFOE=QQPDjm+XXaByF+Fd=ZN13P98Yxw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 09/10] tcp: make the dropreason really work
 when calling tcp_rcv_state_process()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 3:45=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Fri, 23 Feb 2024 18:28:50 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Update three callers including both ipv4 and ipv6 and let the dropreaso=
n
> > mechanism work in reality.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Reviewed-by: David Ahern <dsahern@kernel.org>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> two nits below.
>
>
> > --
> > v9
> > Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fd=
a1@kernel.org/
> > 1. add reviewed-by tag (David)
> >
> > v8
> > Link: https://lore.kernel.org/netdev/CANn89i+Uikp=3DNvB7SVQpYnX-2FqJrH3=
hWw3sV0XpVcC55MiNUg@mail.gmail.com/
> > 1. add reviewed-by tag (Eric)
> > ---
> >  include/net/tcp.h        | 2 +-
> >  net/ipv4/tcp_ipv4.c      | 3 ++-
> >  net/ipv4/tcp_minisocks.c | 9 +++++----
> >  net/ipv6/tcp_ipv6.c      | 3 ++-
> >  4 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index e5af9a5b411b..1d9b2a766b5e 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -396,7 +396,7 @@ enum tcp_tw_status tcp_timewait_state_process(struc=
t inet_timewait_sock *tw,
> >  struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
> >                          struct request_sock *req, bool fastopen,
> >                          bool *lost_race);
> > -int tcp_child_process(struct sock *parent, struct sock *child,
> > +enum skb_drop_reason tcp_child_process(struct sock *parent, struct soc=
k *child,
> >                     struct sk_buff *skb);
>
> Please fix indentation here,

Thanks for the check. I run the checkpatch locally everytime and it
only says it is just 'check' not 'warning' or even 'error'.

Have no idea whether I should 'fix' it.

>
>
> >  void tcp_enter_loss(struct sock *sk);
> >  void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int n=
ewly_lost, int flag);
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 0a944e109088..c79e25549972 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1926,7 +1926,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >       } else
> >               sock_rps_save_rxhash(sk, skb);
> >
> > -     if (tcp_rcv_state_process(sk, skb)) {
> > +     reason =3D tcp_rcv_state_process(sk, skb);
> > +     if (reason) {
> >               rsk =3D sk;
> >               goto reset;
> >       }
> > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > index 9e85f2a0bddd..08d5b48540ea 100644
> > --- a/net/ipv4/tcp_minisocks.c
> > +++ b/net/ipv4/tcp_minisocks.c
> > @@ -911,11 +911,12 @@ EXPORT_SYMBOL(tcp_check_req);
> >   * be created.
> >   */
> >
> > -int tcp_child_process(struct sock *parent, struct sock *child,
> > +enum skb_drop_reason
> > +tcp_child_process(struct sock *parent, struct sock *child,
> >                     struct sk_buff *skb)
>
> and here.
>
>
> >       __releases(&((child)->sk_lock.slock))
> >  {
> > -     int ret =3D 0;
> > +     enum skb_drop_reason reason =3D SKB_NOT_DROPPED_YET;
> >       int state =3D child->sk_state;
> >
> >       /* record sk_napi_id and sk_rx_queue_mapping of child. */
> > @@ -923,7 +924,7 @@ int tcp_child_process(struct sock *parent, struct s=
ock *child,
> >
> >       tcp_segs_in(tcp_sk(child), skb);
> >       if (!sock_owned_by_user(child)) {
> > -             ret =3D tcp_rcv_state_process(child, skb);
> > +             reason =3D tcp_rcv_state_process(child, skb);
> >               /* Wakeup parent, send SIGIO */
> >               if (state =3D=3D TCP_SYN_RECV && child->sk_state !=3D sta=
te)
> >                       parent->sk_data_ready(parent);
> > @@ -937,6 +938,6 @@ int tcp_child_process(struct sock *parent, struct s=
ock *child,
> >
> >       bh_unlock_sock(child);
> >       sock_put(child);
> > -     return ret;
> > +     return reason;
> >  }
> >  EXPORT_SYMBOL(tcp_child_process);
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 0c180bb8187f..4f8464e04b7f 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1663,7 +1663,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >       } else
> >               sock_rps_save_rxhash(sk, skb);
> >
> > -     if (tcp_rcv_state_process(sk, skb))
> > +     reason =3D tcp_rcv_state_process(sk, skb);
> > +     if (reason)
> >               goto reset;
> >       if (opt_skb)
> >               goto ipv6_pktoptions;
> > --
> > 2.37.3
> >

