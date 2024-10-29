Return-Path: <netdev+bounces-139972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A29B4D5B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C78283D7F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B997219342D;
	Tue, 29 Oct 2024 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edt9LOi0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF4747F
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214957; cv=none; b=bRa8LgQUzBUw2tc2w+S12EC8+LnrHAoO0zBXCSeiLFLgIZMN6l3x2ugB7ecNs5g8gbkZtd56CV9wIueA9EUEGFeoWqGblW5uFym/yGB1YBJ/WQ3469jSLu0gHvg8GbA81MUP5hDgf7KF/TbNe/nwv1dYeiJlx9oA/7B6mg4Jl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214957; c=relaxed/simple;
	bh=jaboQPYiXX7ozLbQGara9KvpZS+Ky23CqaWSccyoD2k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GW1NOPGnGiyqe1iLW9UDAiJuFtt+CT6prpHMPlwN+O6S/oqGZHFa7vsfABd307608bzH9k8UshwlTpMHPy+njJ1T+m7cy8JT00IfvZX0qkBVW5ccOOBceGfDwxAaajdv6DMnljeMu9JnyFMwLDxOmSXrs2Y+hzMe9YfjRg9gIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edt9LOi0; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso34726036d6.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730214954; x=1730819754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L//fnK5nh+H8L177JyDmkwJFJmpPhjaY5SHG56IWmVQ=;
        b=edt9LOi08YRBQz+ZMM0wueOF8IbzbuDOV0YmJDsomIYLpYGLR6rIBkh9vcveE5BirB
         +bV5oBgcDsGXA67gt51Gq1RX6lTOUSnktqHnh9XVM7oe8Cul/jutcgAOJqjJDiNm7CnS
         ie+YyJDRifXpOUjgQG8SgqvC8OKXXl01moXH+XO5pB8EoZVP8bYPrgX356pU1T5cHB2y
         HFRlrLugGMTvLtSggR4tzHqh0S08JZFJlpH7g6forbL3vVpxWpYJb2LkzvqrXyP2EdPE
         R8wlUqiQLrs/QPH0PYuFYXGa2TgpF9yllWOqcyxXCqP1RqTuRMQef5j3P9v//uWM0ZVx
         pVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214954; x=1730819754;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L//fnK5nh+H8L177JyDmkwJFJmpPhjaY5SHG56IWmVQ=;
        b=MPjjFUL1Sgy7/0oZ8+g6rmg8MzKxuu5Ypo7E+STAxQOygreMBi/AtHSqz4201zS9Qc
         JrmCdiXVSGYgtzoq8M0Eq0ZmT13DO8sz6LmBHfzds5CcruvZj4C8SbQKfyCrNE29UjDs
         RXmk8NSnu9y+Xrq9tdAcpExQkmeUGrv4fFoo2mngGFQ7oqI0gI54wVKFNi9ZqiymYYdL
         TixtwECb+gMu+XOBdVEDPWarB6c0c8hksQQ38Ss4xZuiFMsJZwi3AHWuT5PJwRZdtFbb
         6SYWS2g6P2kPt0uJcWK6r4q+Bn+oLCjr5VxRV8+/A9VDxb8T+21re7cCNm5mB/6Jtqua
         ROzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr5huksegZqJMt8R4WfVkixwu+bxA/EEYB45uCpx/q9kTP6ZVK6ig0oI+q5D7YlqJpsAbD5nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdG0q0jWG092Ub0MS+DkHFEMRr+q54xtVAsHeY6BDJ7IWJ0yD
	qnbzEmCLHJf4F6zzkC9VlUQsoYeZbpKgMmqSBLNIVrNa7UiRsPMZvpqkXA==
X-Google-Smtp-Source: AGHT+IFrR5WJx61G6p8FrzRiObU1VfbRhtTXaU4OhcVwJBah84M1WqzTStfqU6TjN0X8E/36UsiDMw==
X-Received: by 2002:a05:6214:5343:b0:6cd:e38a:a91e with SMTP id 6a1803df08f44-6d1856e6a44mr149696716d6.18.1730214954309;
        Tue, 29 Oct 2024 08:15:54 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2e6e1sm42475366d6.107.2024.10.29.08.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:15:53 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:15:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 annaemesenyiri@gmail.com
Message-ID: <6720fc298dd5a_2bcd7f29492@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241029144142.31382-1-annaemesenyiri@gmail.com>
References: <20241029144142.31382-1-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next] support SO_PRIORITY cmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anna Emese Nyiri wrote:
> The Linux socket API currently supports setting SO_PRIORITY at the sock=
et
> level, which applies a uniform priority to all packets sent through tha=
t
> socket. The only exception is IP_TOS, if that is specified as ancillary=

> data, the packet does not inherit the socket's priority. Instead, the
> priority value is computed when handling the ancillary data (as impleme=
nted
> in commit <f02db315b8d888570cb0d4496cfbb7e4acb047cb>: "ipv4: IP_TOS
> and IP_TTL can be specified as ancillary data").

Please use commit format <$SHA1:12> ("subject"). Checkpatch might also
flag this.
 =

> Currently, there is no option to set the priority directly from userspa=
ce
> on a per-packet basis. The following changes allow SO_PRIORITY to be se=
t
> through control messages (CMSG), giving userspace applications more
> granular control over packet priorities.
> =

> This patch enables setting skb->priority using CMSG. If SO_PRIORITY is
> specified as ancillary data, the packet is sent with the priority value=

> set through sockc->priority_cmsg_value, overriding the socket-level
> values set via the traditional setsockopt() method.

Please also describe how this interacts with priority set from IP_TOS or
IPV6_TCLASS.

> This is analogous to
> existing support for SO_MARK (as implemented in commit
> <c6af0c227a22bb6bb8ff72f043e0fb6d99fd6515>, =E2=80=9Cip: support SO_MAR=
K
> cmsg=E2=80=9D).
> =

> Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> ---
>  include/net/inet_sock.h |  2 ++
>  include/net/sock.h      |  5 ++++-
>  net/can/raw.c           |  6 +++++-
>  net/core/sock.c         | 12 ++++++++++++
>  net/ipv4/ip_output.c    | 11 ++++++++++-
>  net/ipv4/raw.c          |  5 ++++-
>  net/ipv6/ip6_output.c   |  8 +++++++-
>  net/ipv6/raw.c          |  6 +++++-
>  net/packet/af_packet.c  |  6 +++++-
>  9 files changed, 54 insertions(+), 7 deletions(-)
> =

> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index f9ddd47dc4f8..9d4e4e2a8232 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -175,6 +175,8 @@ struct inet_cork {
>  	__u16			gso_size;
>  	u64			transmit_time;
>  	u32			mark;
> +	__u8		priority_cmsg_set;
> +	u32			priority_cmsg_value;

Just priority, drop the cmsg value.

Instead of an explicit "is set" bit, preferred is to initialize the
cookie field from the sock. See sockcm_init(), below, and also
ipcm_init_sk(). That also avoids the branches later in the datapath.

>  };
>  =

>  struct inet_cork_full {
> diff --git a/include/net/sock.h b/include/net/sock.h
> index cce23ac4d514..e02170977165 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1794,13 +1794,16 @@ struct sockcm_cookie {
>  	u64 transmit_time;
>  	u32 mark;
>  	u32 tsflags;
> +	u32 priority_cmsg_value;
> +	u8 priority_cmsg_set;
>  };
>  =

>  static inline void sockcm_init(struct sockcm_cookie *sockc,
>  			       const struct sock *sk)
>  {
>  	*sockc =3D (struct sockcm_cookie) {
> -		.tsflags =3D READ_ONCE(sk->sk_tsflags)
> +		.tsflags =3D READ_ONCE(sk->sk_tsflags),
> +		.priority_cmsg_set =3D 0
>  	};
>  }
>  =

> diff --git a/net/can/raw.c b/net/can/raw.c
> index 00533f64d69d..cf7e7ae64cde 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -962,7 +962,11 @@ static int raw_sendmsg(struct socket *sock, struct=
 msghdr *msg, size_t size)
>  	}
>  =

>  	skb->dev =3D dev;
> -	skb->priority =3D READ_ONCE(sk->sk_priority);
> +	if (sockc.priority_cmsg_set)
> +		skb->priority =3D sockc.priority_cmsg_value;
> +	else
> +		skb->priority =3D READ_ONCE(sk->sk_priority);
> +
>  	skb->mark =3D READ_ONCE(sk->sk_mark);
>  	skb->tstamp =3D sockc.transmit_time;
>  =

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9abc4fe25953..899bf850b52a 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2863,6 +2863,18 @@ int __sock_cmsg_send(struct sock *sk, struct cms=
ghdr *cmsg,
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:
>  		break;
> +	case SO_PRIORITY:
> +		if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(u32)))
> +			return -EINVAL;
> +
> +		if ((*(u32 *)CMSG_DATA(cmsg) >=3D 0 && *(u32 *)CMSG_DATA(cmsg) <=3D =
6) ||
> +		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
> +		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
> +			sockc->priority_cmsg_value =3D *(u32 *)CMSG_DATA(cmsg);
> +			sockc->priority_cmsg_set =3D 1;
> +			break;
> +		}

What is the magic constant 6 here?


