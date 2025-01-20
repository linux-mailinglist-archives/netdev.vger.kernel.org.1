Return-Path: <netdev+bounces-159760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD1A16C13
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4044D1636CB
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84BD1DF992;
	Mon, 20 Jan 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhV+bCv8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E021B87EE;
	Mon, 20 Jan 2025 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374971; cv=none; b=sco5zGP2LRUq6I+foX04bVovA60h9VfX3Kmv5Z/zm8/34wbljssDkjGpvH1g0a/Z9WM/EzAXNUbXHRckG06IP2GsjnNZE9oCegJc7E+D7P7WWDYbgBPaj+wdAFwcz8qYulsUbSZ5IrIQxBGfHJK88PK5T+FqRrt4aAaNuwpk2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374971; c=relaxed/simple;
	bh=mZsA2nllxdN2Wmc6ZI9w7NmNSuiGYP5/sFpew5DSB4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hce2C4QRsRytMBzbpExGbuSnkMcTIphrY8K6rHV1UHCGo8gn62NACKBQhD2bKW91/n7Dr6GnfV3mbAj+UpARyeHsuhQQaGHsl5E+FJg8NSg45WyVZS2VUsrFT3c1XTtyxTUnTMe6xgXV2YX1EnEFV5QJ1Z56NJPOO4Q5i+yJSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhV+bCv8; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a8160382d4so13729335ab.0;
        Mon, 20 Jan 2025 04:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737374969; x=1737979769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lG4LEJsj+ryNIVrWxDBfdXk2QUfrlY3LsmUHorPDtM=;
        b=YhV+bCv8Ds0P4Z13OcA61npCwmy8Dlh6Zt4/aQk50UUDO3jkJaRbD1LwilGOVwwSil
         FvBiBIGcI701PV1ISOrgpz74aUJBnBTxYqc4/l7fZ5Xs2uBhWp+9WsgCqYRiJpVGGNs4
         G/Yk+X9gHQsqkrQYRTLzEB6aLXWMgN6qEuQ9ootXyrfq23t/ljryQtq3BKdcsOeGtPPG
         Ouica+66XjlBp6KC3Tcc/pBOAyxzd4mVg0NcZrO3g1Lx8QHpT1XDjHlS/X49wVDNeLVr
         LvAFmSwr7ZM3kKYhohGNmR6dvZpPoyDkQqidoEOspF4h1nQaI9ISfcwLxDXXxFVTi6P0
         46Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737374969; x=1737979769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lG4LEJsj+ryNIVrWxDBfdXk2QUfrlY3LsmUHorPDtM=;
        b=Wp3FyNbJDtjBpv1N1hP22INguJgSJ4UD4EiGNQaqT3vbQ5ADjUo/WkciUcYEJnoLLF
         sfivvevZ6fr3F1NTYPoNVJiZ3TdDQMi2K+6R8SwBTRfbMjoRNALvfJdy1PNVVFPZu3rn
         LQYjmJamwdTueQeOyAoglRuxxQYacnJA5iAJmyHzC3dY6PyLN/eSPZcLncD1I+JidewO
         ZRW7vl9ImBd/HgjyTqNWeT5fTNzjQbNb7IamFHoCDHHbtWnYvlAnRiFdyPoR4pSEe+1w
         8gyILeSFuOTHfD1jh/yAV299BPFs2xJeyfuZXQzFkrLOQMOf43hTtTN4KlyC1pZf7ODj
         8Aug==
X-Forwarded-Encrypted: i=1; AJvYcCVNKShuimRJXqoPc+ZV+F7QvKY7u/Eufj/qyGiRvP97FOzcxNlNbqlGvs/UAgsdae/b/uPxbq7D@vger.kernel.org, AJvYcCVjYlQyYv6GYskoruFceW5nLI1S0+IvbaOd3qmR3kzD1QG+QZB6Dpp1HBo3sWHfar2b1jrDAOZeDG571BHIgJH0/LGw@vger.kernel.org, AJvYcCX5f4P4yFUt/2ToZd4SSXap5Exd4kIrce3vSM0VSQhg5ylTnJzGxHdVJ4YNz9Xi4UxhX7U0osNxpJplTFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIx1+DrrTkUBmvWTZaRahAwa8N8oJ6jXHcTZMet403Pb/3aTr4
	BPHtZAB06eI3wYZuHEaN0rTfcVIFiiTr4UjiuiVpvyXArEE1xn6ch99FqlDW1OI7D0J7p+V59Yq
	j6+rFckmkDgkRR95ElQlfZ6Ezgww=
X-Gm-Gg: ASbGnctXyeUVUKO0uMUuIq5TCxDblCaXdMsy460y8zO/5kQLsaY1/49yrOiCJ/8x9+i
	/T8VUjb03tJLBzlEG5Gl3iSFvKqfjSwmcBa9gchzkp5jKNk38lxI=
X-Google-Smtp-Source: AGHT+IGxqlCWgy0Z5BMB5tL40NM1pTL5BrJcMNzCHoTIbc4ItFbN69970HII1njSJ0JEDPU4sfpy3c2SuCRf3p6S8Wo=
X-Received: by 2002:a05:6e02:174b:b0:3ce:7d3d:7fdf with SMTP id
 e9e14a558f8ab-3cf7440376fmr107503945ab.8.1737374968978; Mon, 20 Jan 2025
 04:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
In-Reply-To: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 20 Jan 2025 20:08:52 +0800
X-Gm-Features: AbW1kvam6T4lCjEm_Wb5IsAozI3nNahfe1qzJMZLM-_1F_xBGtdmLUQS9zO7Rkg
Message-ID: <CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] trace: tcp: Add tracepoint for tcp_cwnd_reduction()
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:03=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Add a tracepoint to monitor TCP congestion window adjustments through the
> tcp_cwnd_reduction() function. This tracepoint helps track:
>   - TCP window size fluctuations
>   - Active socket behavior
>   - Congestion window reduction events
>
> Meta has been using BPF programs to monitor this function for years. By
> adding a proper tracepoint, we provide a stable API for all users who
> need to monitor TCP congestion window behavior.
>
> The tracepoint captures:
>   - Socket source and destination IPs
>   - Number of newly acknowledged packets
>   - Number of newly lost packets
>   - Packets in flight
>
> Here is an example of a tracepoint when viewed in the trace buffer:
>
> tcp_cwnd_reduction: src=3D[2401:db00:3021:10e1:face:0:32a:0]:45904 dest=
=3D[2401:db00:3021:1fb:face:0:23:0]:5201 newly_lost=3D0 newly_acked_sacked=
=3D27 in_flight=3D34
>
> CC: Yonghong Song <yonghong.song@linux.dev>
> CC: Song Liu <song@kernel.org>
> CC: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/trace/events/tcp.h | 34 ++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_input.c       |  2 ++
>  2 files changed, 36 insertions(+)
>
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index a27c4b619dffd7dcc72fffa71bf0fd5e34fe6681..b3a636658b39721cca843c000=
0eaa573cf4d09d5 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -259,6 +259,40 @@ TRACE_EVENT(tcp_retransmit_synack,
>                   __entry->saddr_v6, __entry->daddr_v6)
>  );
>
> +TRACE_EVENT(tcp_cwnd_reduction,
> +
> +       TP_PROTO(const struct sock *sk, const int newly_acked_sacked,
> +                const int newly_lost, const int flag),
> +
> +       TP_ARGS(sk, newly_acked_sacked, newly_lost, flag),
> +
> +       TP_STRUCT__entry(
> +               __array(__u8, saddr, sizeof(struct sockaddr_in6))
> +               __array(__u8, daddr, sizeof(struct sockaddr_in6))
> +               __field(int, in_flight)
> +
> +               __field(int, newly_acked_sacked)
> +               __field(int, newly_lost)
> +       ),
> +
> +       TP_fast_assign(
> +               const struct inet_sock *inet =3D inet_sk(sk);
> +               const struct tcp_sock *tp =3D tcp_sk(sk);
> +
> +               memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
> +               memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
> +
> +               TP_STORE_ADDR_PORTS(__entry, inet, sk);
> +               __entry->in_flight =3D tcp_packets_in_flight(tp);
> +               __entry->newly_lost =3D newly_lost;
> +               __entry->newly_acked_sacked =3D newly_acked_sacked;
> +       ),
> +
> +       TP_printk("src=3D%pISpc dest=3D%pISpc newly_lost=3D%d newly_acked=
_sacked=3D%d in_flight=3D%d",
> +                 __entry->saddr, __entry->daddr, __entry->newly_lost,
> +                 __entry->newly_acked_sacked, __entry->in_flight)
> +);
> +
>  #include <trace/events/net_probe_common.h>
>
>  TRACE_EVENT(tcp_probe,
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 4811727b8a02258ec6fa1fd129beecf7cbb0f90e..fc88c511e81bc12ec57e8dc3e=
9185a920d1bd079 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -2710,6 +2710,8 @@ void tcp_cwnd_reduction(struct sock *sk, int newly_=
acked_sacked, int newly_lost,
>         if (newly_acked_sacked <=3D 0 || WARN_ON_ONCE(!tp->prior_cwnd))
>                 return;
>
> +       trace_tcp_cwnd_reduction(sk, newly_acked_sacked, newly_lost, flag=
);
> +

Are there any other reasons why introducing a new tracepoint here?
AFAIK, it can be easily replaced by a bpf related program or script to
monitor in the above position.

Thanks,
Jason

