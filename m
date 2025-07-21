Return-Path: <netdev+bounces-208509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA32DB0BE61
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AB53B6606
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713AA286D64;
	Mon, 21 Jul 2025 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFZgBxWZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4952286D4B
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085067; cv=none; b=ZtT/czZYGrb37nB6eYDKM64Tg9F3CeN3OmOA2aAxQCFMr/twq5+B2VJB/7WZ6UO22brcTY+lIXkJ1MfRNSihjYA1przh5UQ38yBNsglvMKer1m9gyFaSuESqkp4tXdumXT7e8HpcMNiJu9KidGIUpju5A0lR1e2Qc1WTTxgq73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085067; c=relaxed/simple;
	bh=7WMyJM3+34WxpvkqleN2rhyi2Cs6Gp3Ha81J+Ak53Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I41sZR8ZBvrCY22tbYE7RNxk/JxMRy3N6yTpGPyK6ptjqJy315Featr5NYT6LJOPggLuLZfSBaqtmycv7c4Qh2q/biuFc7cNjwRDSAIcu7TcwAuyEgCs6h7vgjAtQ140FEbsyf8o4OcDDwC8cLb0BhDcEStZwkVjedeLbP5YEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFZgBxWZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab6646476aso25047881cf.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753085064; x=1753689864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/oRstTtFBhYOfoX7g+9oPvcpnCdgj2b3eytU4zkyC0=;
        b=lFZgBxWZK9DGKJyfmItx3qc522FQufGFti4QJluhxcIhqptitbJqniXF6J2BZHjye9
         C+HEmsh38WRb0daUrd3mIg4zliCsCIgoKqTJMOiB/pnAx7ESPKPDx115ABP4no5uLnpZ
         Wn35EDyluz87WajG1b2wFniRbUsIBVH47RDfOhhmK5uYfY1yPk6D5/rmA+G9qiQ0Nsjx
         ENFItway2K8Q8vGxgD/P8iaa8z0xGDyih2vjU47Lbkd4dM64KO0pfuHivi+9Dfjy9icz
         3P9R7hq8dg0S8TsXWATVNKb8PgNwLOWlS/ns9qMqO5Rg1X6hFuNZ2bwOfGrttqYeELoU
         TKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753085064; x=1753689864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/oRstTtFBhYOfoX7g+9oPvcpnCdgj2b3eytU4zkyC0=;
        b=dbp1LUlta2TvP+hYs7NM3FS26GbFt4oil2kEBAZtMHRH08wrvgzJge4neY7mwPkYln
         ECRYdNjCJq+MX1QHsPFdVwgW1wi8BV6vYmF136BfCgQAbd6kQAhygUm2hM6DQDsLXDcp
         pNX61UNGaH+jaraTHg86/XCvD1L9fCVB6EpywAzg+xZkfWnifaKNE61FjPfn7r/qAi4K
         AgX6yvcfqU8MTbe4aev6X17LAoCd6MU4JwanjjY2tLxMVeM4Br9oZ14/MKH6pi8ExUuN
         j79LqpgxFKoB/gIe984HyI7tdmvDDmOb0XwyeA0s50TqrN+f7lDqvBEc/hRweCtFCDK8
         j7TA==
X-Gm-Message-State: AOJu0YwhcR5yyclzDH5aX8Y2Vmzp6iJE3gMsl1c3ZDhBpgeoQmb8YnuJ
	AhpqoqlS6DhSe4695nZoP1JHo5C8HzUmI2dgxQAX/jycBj5wnrDE1iIKBDLx7hopZ32nxpN3XZr
	4g5pBxY7gFVbc0f3Gqz7KKt915/y23dfiNmmpJATT
X-Gm-Gg: ASbGncsnSjMCm9O9Jl0j7pWVm5s+R5EC851WN6Mo3K1jBlD7gF5Hm9j8S4O9ZzvbsdO
	TkXt2r1PSyL+wdcWqGzZb3vU5yRPPTQKBwW8R1lwdXT0IXimZnDLhmVlss+Zo09QzYp0GFyLSyr
	UfJQtL1eKR2vm5mVTG4vgQR0AiRvIVDxQ+uqOJ7Sq2MR3YpKQG8H5EGSP4TN3VP/iWxfK4LTI1+
	boDUEU=
X-Google-Smtp-Source: AGHT+IFiLMc4C5Toe8MF5TFAm+uyqcPJbpgbf/jXjOBqWGjhJ9vlGFMfX8c0UVmkOQwFOO1ZH5ouT3bUP6YpzL7rVaM=
X-Received: by 2002:a05:6214:acf:b0:702:d3ab:c67d with SMTP id
 6a1803df08f44-705073a3dfdmr242863606d6.23.1753085064144; Mon, 21 Jul 2025
 01:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752859383.git.pabeni@redhat.com> <3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
In-Reply-To: <3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 01:04:12 -0700
X-Gm-Features: Ac12FXzPoPTjrHpSqSHDcjZWCpHZIAZEzqAIlFf9U-FAPOOO9d_BD0auk6sG_ak
Message-ID: <CANn89i+KCsw+LH1X1yzmgr1wg5Vxm47AbAEOeOnY5gqq4ngH4w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: do not set a zero size receive buffer
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> The nipa CI is reporting frequent failures in the mptcp_connect
> self-tests.
>
> In the failing scenarios (TCP -> MPTCP) the involved sockets are
> actually plain TCP ones, as fallback for passive socket at 2whs
> time cause the MPTCP listener to actually create a TCP socket.
>
> The transfer is stuck due to the receiver buffer being zero.
> With the stronger check in place, tcp_clamp_window() can be invoked
> while the TCP socket has sk_rmem_alloc =3D=3D 0, and the receive buffer
> will be zeroed, too.
>
> Pass to tcp_clamp_window() even the current skb truesize, so that
> such helper could compute and use the actual limit enforced by
> the stack.
>
> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/ipv4/tcp_input.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 672cbfbdcec1..c98de02a3c57 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -610,24 +610,24 @@ static void tcp_init_buffer_space(struct sock *sk)
>  }
>
>  /* 4. Recalculate window clamp after socket hit its memory bounds. */
> -static void tcp_clamp_window(struct sock *sk)
> +static void tcp_clamp_window(struct sock *sk, int truesize)


I am unsure about this one. truesize can be 1MB here, do we want that
in general ?

I am unsure why MPTCP ends up with this path.

 LINUX_MIB_PRUNECALLED being called in normal MPTCP operations seems
strange to me.


>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         struct inet_connection_sock *icsk =3D inet_csk(sk);
>         struct net *net =3D sock_net(sk);
> -       int rmem2;
> +       int rmem2, needed;
>
>         icsk->icsk_ack.quick =3D 0;
>         rmem2 =3D READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
> +       needed =3D atomic_read(&sk->sk_rmem_alloc) + truesize;
>
>         if (sk->sk_rcvbuf < rmem2 &&
>             !(sk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
>             !tcp_under_memory_pressure(sk) &&
>             sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)) {
> -               WRITE_ONCE(sk->sk_rcvbuf,
> -                          min(atomic_read(&sk->sk_rmem_alloc), rmem2));
> +               WRITE_ONCE(sk->sk_rcvbuf, min(needed, rmem2));
>         }
> -       if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> +       if (needed > sk->sk_rcvbuf)
>                 tp->rcv_ssthresh =3D min(tp->window_clamp, 2U * tp->advms=
s);
>  }
>
> @@ -5552,7 +5552,7 @@ static int tcp_prune_queue(struct sock *sk, const s=
truct sk_buff *in_skb)
>         NET_INC_STATS(sock_net(sk), LINUX_MIB_PRUNECALLED);
>
>         if (!tcp_can_ingest(sk, in_skb))
> -               tcp_clamp_window(sk);
> +               tcp_clamp_window(sk, in_skb->truesize);
>         else if (tcp_under_memory_pressure(sk))
>                 tcp_adjust_rcv_ssthresh(sk);
>
> --
> 2.50.0
>

