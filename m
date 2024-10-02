Return-Path: <netdev+bounces-131393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829A98E6B2
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC72FB22F1F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796B19E960;
	Wed,  2 Oct 2024 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVT1MWJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62508286A
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911193; cv=none; b=mahbh6eu74GgTSdZLABZpMBK/zXkywfLz/FcU57yo4RoksXtGj3U0IsYVN0QdWl72EglMdXuJkAT1R3xd9bP5jLltA9DTUgPMgNtwSPillLkxBHmjOEhswPvh1g7eyzECqanvgwbTc8cF+CUAegF6cWqqsO26U4ueNYsCGs0JcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911193; c=relaxed/simple;
	bh=U997ggCk3eSPCVpFMZnag13MlJ2SrnW2Nei0wlF4+pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnMJID4CPiQWmESYgwW2e6KsKOmxOG/PpIiHWd6pFTxmFpV9jQMn+YJzeVmGb11gt/u3vrhTk6OuYl3Pl7D4sGAOrBeKueVoaVng2U5DBYMXNzUIZ3heagmmQeoh9vZMNYaKKWjNjwW4/+uI8C3RUFAxNUzIghb6YcZibBnW9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVT1MWJ3; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a1a22a7fa6so1396355ab.1
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 16:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727911191; x=1728515991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcLtbcCy1t2XTo/bqePv7BWUAMsmBciJGDlaqqojGLU=;
        b=PVT1MWJ34dpcPHxFkR8vz2FfJ4X22NbSPKOgCDkxulAC7i6AFcG6iAzC/F+sXARqDS
         A2zTtLJrL6uqaXVprorxEz8lGlw8zQDGjBJ2uPt7krVpH93V/mbubVkWPp2S7fm6vmfB
         pJi5iE/TGgMFVimRXB/HqnRKSlHymxyG01oz4AfnR/78+pEIuED4gKjjJ6EKWoYAkttt
         yjQdDMCLELHTV9lab/LJKhRA5mfBPz14ICqewcQT+IrsGBQ0qMb6v03MhghYnek49mS9
         L7Z/+CwaMJjHHXKpq90O09pt5g5AFiwbr7bROhrHCc69i6AcYmha8QWGPhIxAfK9JxyF
         qpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727911191; x=1728515991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcLtbcCy1t2XTo/bqePv7BWUAMsmBciJGDlaqqojGLU=;
        b=qFWCZbHRfEM1UzA4UrIa7gllwqFYHhwZ+iqahmalr3SdD4ydCiiN8in76q1QdOFDdC
         imZviS9Nsk18LvnwUySPI1T/hFDETqb37krIp9jxoLgZza91roNrFoRaFnFCFP+qFYkb
         qkh5vT3ugrKv0ogsXVjeiYqlYkBHyCohjTtAcrD4tJFLx2iHvxUxrlKgUe9aIaXSM4/0
         mCmvB4C3thaCg5YK/RCk94uK+nyCz+fbevleoXlVR+vnjlLfXN8RDu6zE85rM815bQu4
         l+q/UWfihgJxCLA+nHX2un2FuqRHQLKve05BlkymfN0vZiki/5FsE7rYRhTRAGPMUHHI
         PEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjJQTG7LIGA7/dcyAs+zO8EBohUq+j8AR+sZIccOyFBpY59iEHMqShZ34h021AdqdWeT6MZgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT37jcO2EUy8EutGt2MupD0xnDIg98UtkvWMDFuT1d3QdJmcKI
	8ubwLEBzTxPxUxzJN47Q/BlOUkwNtfSwinb3B8yiRWh8OxWg+YwDHAPF8CWXxgmtLU26db6NjEZ
	WexaLouu5WND8gSdQ8ceKwbIpKyI=
X-Google-Smtp-Source: AGHT+IFicXWqwzBlhtQNyaz2dhn4KKHyk+zNqsN/Uu938u5ZZgyRpsMrTIxpyHGDu0VYPmtxPs83QPDYlEx8m34pW1k=
X-Received: by 2002:a05:6e02:13a1:b0:3a1:a2b4:6665 with SMTP id
 e9e14a558f8ab-3a36e2a863cmr11443545ab.12.1727911190881; Wed, 02 Oct 2024
 16:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002173042.917928-1-edumazet@google.com> <20241002173042.917928-4-edumazet@google.com>
In-Reply-To: <20241002173042.917928-4-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 3 Oct 2024 08:19:14 +0900
Message-ID: <CAL+tcoDNTLoOc9yZsCGu-tt7SqgbJf=hdfkaW_isjR7Cntc5AA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: add a fast path in tcp_delack_timer()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Thu, Oct 3, 2024 at 2:31=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> delack timer is not stopped from inet_csk_clear_xmit_timer()
> because we do not define INET_CSK_CLEAR_TIMERS.
>
> This is a conscious choice : inet_csk_clear_xmit_timer()
> is often called from another cpu. Calling del_timer()
> would cause false sharing and lock contention.
>
> This means that very often, tcp_delack_timer() is called
> at the timer expiration, while there is no ACK to transmit.
>
> This can be detected very early, avoiding the socket spinlock.
>
> Notes:
> - test about tp->compressed_ack is racy,
>   but in the unlikely case there is a race, the dedicated
>   compressed_ack_timer hrtimer would close it.
>
> - Even if the fast path is not taken, reading
>   icsk->icsk_ack.pending and tp->compressed_ack
>   before acquiring the socket spinlock reduces
>   acquisition time and chances of contention.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/inet_connection_sock.h | 5 +++--
>  net/ipv4/inet_connection_sock.c    | 4 ++--
>  net/ipv4/tcp_output.c              | 3 ++-
>  net/ipv4/tcp_timer.c               | 9 +++++++++
>  net/mptcp/protocol.c               | 3 ++-
>  5 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index 914d1977270449241f6fc6da2055f3af02a75f99..3c82fad904d4c6c51069e2e70=
3673d667bb36d06 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -202,7 +202,7 @@ static inline void inet_csk_clear_xmit_timer(struct s=
ock *sk, const int what)
>                 sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
>  #endif
>         } else if (what =3D=3D ICSK_TIME_DACK) {
> -               icsk->icsk_ack.pending =3D 0;
> +               smp_store_release(&icsk->icsk_ack.pending, 0);
>                 icsk->icsk_ack.retry =3D 0;
>  #ifdef INET_CSK_CLEAR_TIMERS
>                 sk_stop_timer(sk, &icsk->icsk_delack_timer);
> @@ -233,7 +233,8 @@ static inline void inet_csk_reset_xmit_timer(struct s=
ock *sk, const int what,
>                 icsk->icsk_timeout =3D jiffies + when;
>                 sk_reset_timer(sk, &icsk->icsk_retransmit_timer, icsk->ic=
sk_timeout);
>         } else if (what =3D=3D ICSK_TIME_DACK) {
> -               icsk->icsk_ack.pending |=3D ICSK_ACK_TIMER;
> +               smp_store_release(&icsk->icsk_ack.pending,
> +                                 icsk->icsk_ack.pending | ICSK_ACK_TIMER=
);
>                 icsk->icsk_ack.timeout =3D jiffies + when;
>                 sk_reset_timer(sk, &icsk->icsk_delack_timer, icsk->icsk_a=
ck.timeout);
>         } else {
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 8c53385cc808c61097898514fd91a322e3a08d31..12e975ed4910d8c7cca79b181=
2f365589a5d469a 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -776,7 +776,7 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
>         struct inet_connection_sock *icsk =3D inet_csk(sk);
>
>         smp_store_release(&icsk->icsk_pending, 0);
> -       icsk->icsk_ack.pending =3D 0;
> +       smp_store_release(&icsk->icsk_ack.pending, 0);
>
>         sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
>         sk_stop_timer(sk, &icsk->icsk_delack_timer);
> @@ -792,7 +792,7 @@ void inet_csk_clear_xmit_timers_sync(struct sock *sk)
>         sock_not_owned_by_me(sk);
>
>         smp_store_release(&icsk->icsk_pending, 0);
> -       icsk->icsk_ack.pending =3D 0;
> +       smp_store_release(&icsk->icsk_ack.pending, 0);
>
>         sk_stop_timer_sync(sk, &icsk->icsk_retransmit_timer);
>         sk_stop_timer_sync(sk, &icsk->icsk_delack_timer);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 4d04073016035dcf62ba5e0ad23aac86e54e65c7..08772395690d13a0c3309a273=
543a51aa0dd3fdc 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4224,7 +4224,8 @@ void tcp_send_delayed_ack(struct sock *sk)
>                 if (!time_before(timeout, icsk->icsk_ack.timeout))
>                         timeout =3D icsk->icsk_ack.timeout;
>         }
> -       icsk->icsk_ack.pending |=3D ICSK_ACK_SCHED | ICSK_ACK_TIMER;
> +       smp_store_release(&icsk->icsk_ack.pending,
> +                         icsk->icsk_ack.pending | ICSK_ACK_SCHED | ICSK_=
ACK_TIMER);
>         icsk->icsk_ack.timeout =3D timeout;
>         sk_reset_timer(sk, &icsk->icsk_delack_timer, timeout);
>  }
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index b7266b9101ce5933776bd38d086287667e3a7f18..c3a7442332d4926a6089812f7=
89e89ee23081306 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -361,6 +361,14 @@ static void tcp_delack_timer(struct timer_list *t)
>                         from_timer(icsk, t, icsk_delack_timer);
>         struct sock *sk =3D &icsk->icsk_inet.sk;
>
> +       /* Avoid taking socket spinlock if there is no ACK to send.
> +        * The compressed_ack check is racy, but a separate hrtimer
> +        * will take care of it eventually.
> +        */
> +       if (!(smp_load_acquire(&icsk->icsk_ack.pending) & ICSK_ACK_TIMER)=
 &&
> +           !READ_ONCE(tcp_sk(sk)->compressed_ack))

I wonder what the use of single READ_ONCE() is here without a
WRITE_ONCE() pair? It cannot guarantee that the result of reading
compressed_ack is accurate. What if we use without this READ_ONCE()
here?

Thanks,
Jason

