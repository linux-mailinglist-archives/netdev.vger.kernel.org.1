Return-Path: <netdev+bounces-52264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE2C7FE116
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 21:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA748B20F3D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 20:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3DB39869;
	Wed, 29 Nov 2023 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="He8RRbwi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C934991
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 12:33:24 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bc7706520so345110e87.3
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 12:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701290003; x=1701894803; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=46xP1QCom/WAaNZ9fuKB6h13iTyemZVYBjsuExY6WTc=;
        b=He8RRbwiwhToZQNUBecgP9tsr5QLtzZ8jQy3gcks07nYKLkJA2uu4eUrTYbW/GxLGo
         pO16MkIs31n5RWY4cZ6QDk089MeN/py0Ayc2ST6PG/kepvrcQ0rxiokuGZXPWhE3n7FC
         9jBmIHVg1r/8+lVNIZMQTNIuLMPXai1QzZYwCDm5jzm4zppoCGXXb4mqFkM33JMqaB3H
         3NqnacaK9mlS/a/uQiAr0V2giFwjczNrqqbcIw8XqjgHWDm8eYPAzUVtbYO2m2bTvuRB
         DYOhdgVf9VivU5yB1q5gUWBui4VaMmff7CsDcEUA1noiea2WaNhDgVGruVhe6UeoJmFQ
         z8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290003; x=1701894803;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46xP1QCom/WAaNZ9fuKB6h13iTyemZVYBjsuExY6WTc=;
        b=NqMV3hCJ98rUsqhUr9gYI9/P2O3gi5dr+N8oKaFtTjPQLQahZ8t6sDJYQb8wNf4ueN
         WcOfoQgvo3TLlopfWq1cTvQaOjAMGrCf0zvTfDB08k/rGkOndhU+wDsTmmU7dreMg4SS
         ZxzIIhEYDKZm9C3nrn/ErwdxO4mds0eg03J+8/KwhsMwlEOvmv/PG6dEHDU4ceyzAjxF
         TEBdQKpLD6EQAb8WeF7Pu91k5vnPX0/ftBzzILoWfCD9WEM368wfwk7jNpIXk8rg1/KK
         r2f300pBVg1DwBZF0MVMyMoLYiWIVKY0ySLjz5qT4tJYch2Ym7pyjKhGhzKkOoqQ+MT9
         FQFw==
X-Gm-Message-State: AOJu0YxEB1vmnYF7L2wRV9dDOe6WEmiHbh/cvmyBiS0q75xcSrg+brW5
	WV1/sq4YMA6S3Npbpai8JO1b9FIrwBQv3OsnJCWk3g==
X-Google-Smtp-Source: AGHT+IEpIfaZayxeuIAJ2jm0MZ78Fojwk6nvNQ8nXSd58Wm3XwB+5iFh5Trma5MfQ63AwAjOt71OFw==
X-Received: by 2002:a19:f50a:0:b0:50b:c89f:65d1 with SMTP id j10-20020a19f50a000000b0050bc89f65d1mr1244490lfb.40.1701290002981;
        Wed, 29 Nov 2023 12:33:22 -0800 (PST)
Received: from cloudflare.com (79.184.129.107.ipv4.supernova.orange.pl. [79.184.129.107])
        by smtp.gmail.com with ESMTPSA id dm22-20020a05640222d600b0054be3528e40sm699580edb.80.2023.11.29.12.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:33:22 -0800 (PST)
References: <a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 'Jakub Kicinski'
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Stephen
 Hemminger <stephen@networkplumber.org>, Eric Dumazet
 <edumazet@google.com>, 'David Ahern' <dsahern@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ipv4: Use READ/WRITE_ONCE() for IP
 local_port_range
Date: Wed, 29 Nov 2023 21:17:25 +0100
In-reply-to: <a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com>
Message-ID: <87r0k82tbi.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hey David,

On Wed, Nov 29, 2023 at 07:26 PM GMT, David Laight wrote:
> Commit 227b60f5102cd added a seqlock to ensure that the low and high
> port numbers were always updated together.
> This is overkill because the two 16bit port numbers can be held in
> a u32 and read/written in a single instruction.
>
> More recently 91d0b78c5177f added support for finer per-socket limits.
> The user-supplied value is 'high << 16 | low' but they are held
> separately and the socket options protected by the socket lock.
>
> Use a u32 containing 'high << 16 | low' for both the 'net' and 'sk'
> fields and use READ_ONCE()/WRITE_ONCE() to ensure both values are
> always updated together.
>
> Change (the now trival) inet_get_local_port_range() to a static inline
> to optimise the calling code.
> (In particular avoiding returning integers by reference.)
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---

Regarding the per-socket changes - we don't expect contention on sock
lock between inet_stream_connect / __inet_bind, where we grab it and
eventually call inet_sk_get_local_port_range, and sockopt handlers, do
we?

The motivation is not super clear for me for that of the changes.

>  include/net/inet_sock.h         |  5 +----
>  include/net/ip.h                |  7 ++++++-
>  include/net/netns/ipv4.h        |  3 +--
>  net/ipv4/af_inet.c              |  4 +---
>  net/ipv4/inet_connection_sock.c | 29 ++++++++++------------------
>  net/ipv4/ip_sockglue.c          | 34 ++++++++++++++++-----------------
>  net/ipv4/sysctl_net_ipv4.c      | 12 ++++--------
>  7 files changed, 40 insertions(+), 54 deletions(-)
>
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 74db6d97cae1..ebf71410aa2b 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -234,10 +234,7 @@ struct inet_sock {
>  	int			uc_index;
>  	int			mc_index;
>  	__be32			mc_addr;
> -	struct {
> -		__u16 lo;
> -		__u16 hi;
> -	}			local_port_range;
> +	u32			local_port_range;

Nit: This field would benefit from a similar comment as you have added to
local_ports.range ("/* high << 16 | low */"), now that it is no longer
obvious how to interpret the contents.

>  
>  	struct ip_mc_socklist __rcu	*mc_list;
>  	struct inet_cork_full	cork;

[...]

> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 394a498c2823..1a45d41f8b39 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -117,34 +117,25 @@ bool inet_rcv_saddr_any(const struct sock *sk)

[...]

>  void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high)
>  {
>  	const struct inet_sock *inet = inet_sk(sk);
>  	const struct net *net = sock_net(sk);
>  	int lo, hi, sk_lo, sk_hi;
> +	u32 sk_range;
>  
>  	inet_get_local_port_range(net, &lo, &hi);
>  
> -	sk_lo = inet->local_port_range.lo;
> -	sk_hi = inet->local_port_range.hi;
> +	sk_range = READ_ONCE(inet->local_port_range);
> +	if (unlikely(sk_range)) {
> +		sk_lo = sk_range & 0xffff;
> +		sk_hi = sk_range >> 16;
>  
> -	if (unlikely(lo <= sk_lo && sk_lo <= hi))
> -		lo = sk_lo;
> -	if (unlikely(lo <= sk_hi && sk_hi <= hi))
> -		hi = sk_hi;
> +		if (unlikely(lo <= sk_lo && sk_lo <= hi))
> +			lo = sk_lo;
> +		if (unlikely(lo <= sk_hi && sk_hi <= hi))
> +			hi = sk_hi;
> +	}

Actually when we know that sk_range is set, the above two branches
become likely. It will be usually so that the set per-socket port range
narrows down the per-netns port range.

These checks exist only in case the per-netns port range has been
reconfigured after per-socket port range has been set. The per-netns one
always takes precedence.

>  
>  	*low = lo;
>  	*high = hi;

[...]

