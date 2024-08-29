Return-Path: <netdev+bounces-123292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0E9646C2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90751C23C55
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD482194094;
	Thu, 29 Aug 2024 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT8eSIQ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E0E15AD9E
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938304; cv=none; b=uuwb+Ay5lYQH9fXCMsZCLlUPkSshrTnWK6D2ZGTD6+d4BqrU9FU4SngIGsQ78EAw0RlnsinaohgiY8Yt+OPZX8/m0pBIaGakceVdgFKkF7tDFI9k1fJ2xHKdkP2PKK88Q2c2O6KIXXBrCZroHk1OVs4vvrjJO3VGBVjqykdxOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938304; c=relaxed/simple;
	bh=KKqRbhPvEc9jc7HXD8ar98KMmmYp2MKvIxhq1Vv4YTg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RRRnAv7gLVjRHAecbm7W3qz+Gl7c9KLoNcVwveZsDxVkWrJz5NPBtEAQzuKDnr0KxyqThEN3h92Hlr0OvgmkGMx2jaiOrFHkZRm2YbsEpSeyOY//UzXRJKKkFYBvf5Lj93H6vZO32xgvqgQ3YNQTMkQh7LnsfnDVhFzrAUF/6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT8eSIQ3; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c32e1c263aso3784536d6.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724938302; x=1725543102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/2hD3tic8LUBfD7pGLxlY/6Qzw7GztjtJfR4Sg9LfA=;
        b=bT8eSIQ3hwuqpoBLSZ9ILJ/2QG2xoNFlOvP+tQkZEvJ9h5LESbbsOVT8+hDxNuRq5N
         EnlxbSsuXtPL9ul/k+lS0f9mGpRPGuQYoC50iD2US12+oEParv2sP0JgACo4oLDgbEP5
         BLUzy5onT/Z+pTUxTJP10AF4CuOdGevCyPwkztHexKcFytlDEOtfewki5garSa4zKBDF
         Za/5piyFOCXSzjXMKbSyjNk2ERn/ATtTIDDVnkdriYUfOmIL+gQtAFR0TtOGgZvDxQ3P
         N1No7eCDmzMEvgmKFChykG+ecGvZVU2dv0U/JdtPxMmTpAsBuNLfaPMOMMrN0UZgfULM
         ZzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724938302; x=1725543102;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I/2hD3tic8LUBfD7pGLxlY/6Qzw7GztjtJfR4Sg9LfA=;
        b=wqNdUOSIp/HL/ak9Ntn5NVOMn10fXdDptuqDfPiOfQF/VsmkuVPZ4ALKwtp4RWGFK3
         EoSWUoRnVHPh9IlS6wUM9N0x4R58s1lQ6X+344LpyV3elef0gBIcBKEah9f2tKrBGFW8
         HS0nxgTUS5wW+Ovs1+0qpAgCovvlv617F1KOevQDC9axYu+kHLSX9J2H/vtNMN8S6SsA
         IgDbTGJMp3dIkqq+qoF+cfhgksVRONRNwIqwSnmfhQ8cZJWbFgwBOfm2iIfc5LUfx6jx
         G9xiF1dGmUGeBx33ADaBzOeoSY+PLqTGrXzvacFG+A/P2xZva14/kooQAVVESzRipLfB
         ry/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHEKK6XtclHPG0RM9Uc/TR3eWPEG4qc/ItEqfRw0TihjkMGLykiAhB8J1ePmWc1RHi82M8m8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBUt0VAk5jEKaZqdtwvsweh3X5BMqoNKs3XCbzAeTM7giJIQJ
	d9A/s8TT7IBtQ3QRu3cNxEu/4WSaNfjWGlnOQcOywW4SvxEFS8Fj
X-Google-Smtp-Source: AGHT+IFHt8C2UdEVi3zDDxFvgIMYXrwQwzdjwQ3GDeBG0gIHyZcmAzvZhtMGabAC2+oXW5zvWlX4tA==
X-Received: by 2002:a05:6214:5f0b:b0:6b7:b441:8fdf with SMTP id 6a1803df08f44-6c33e7d8a0cmr20708046d6.56.1724938301631;
        Thu, 29 Aug 2024 06:31:41 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340ca66f8sm5084576d6.117.2024.08.29.06.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:31:41 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:31:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, 
 netdev@vger.kernel.org
Message-ID: <66d0783ca3dc4_3895fa2946a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240829000355.1172094-1-vadfed@meta.com>
References: <20240829000355.1172094-1-vadfed@meta.com>
Subject: Re: [RFC PATCH] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in
 control message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> timestamps

+1 on the feature. Few minor points only.

Not a hard requirement, but would be nice if there was a test,
e.g., as a tools/testing/../txtimestamp.c extension.

> and packets sent via socket. Unfortunately, there is no way
> to reliably predict socket timestamp ID value in case of error returned
> by sendmsg [1].

Might be good to copy more context from the discussion to explain why
reliable OPT_ID is infeasible. For UDP, it is as simple as lockless
transmit. For RAW, things like MSG_MORE come into play.

> This patch adds new control message type to give user-space
> software an opportunity to control the mapping between packets and
> values by providing ID with each sendmsg. This works fine for UDP
> sockets only, and explicit check is added to control message parser.
> Also, there is no easy way to use 0 as provided ID, so this is value
> treated as invalid.

This is because the code branches on non-zero value in the cookie,
else uses ts_key. Please make this explicit. Or perhaps better, add a
bit in the cookie so that the full 32-bit space can be used.

> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  include/net/inet_sock.h           |  1 +
>  include/net/sock.h                |  1 +
>  include/uapi/asm-generic/socket.h |  2 ++
>  net/core/sock.c                   | 14 ++++++++++++++
>  net/ipv4/ip_output.c              | 11 +++++++++--
>  net/ipv6/ip6_output.c             | 11 +++++++++--
>  6 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 394c3b66065e..7e8545311557 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -174,6 +174,7 @@ struct inet_cork {
>  	__s16			tos;
>  	char			priority;
>  	__u16			gso_size;
> +	u32			ts_opt_id;
>  	u64			transmit_time;
>  	u32			mark;
>  };

Ah there's a hole here. Nice!

> diff --git a/include/net/sock.h b/include/net/sock.h
> index f51d61fab059..73e21dad5660 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1794,6 +1794,7 @@ struct sockcm_cookie {
>  	u64 transmit_time;
>  	u32 mark;
>  	u32 tsflags;
> +	u32 ts_opt_id;
>  };
>  
>  static inline void sockcm_init(struct sockcm_cookie *sockc,
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 8ce8a39a1e5f..db3df3e74b01 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>  
> +#define SCM_TS_OPT_ID		78
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 468b1239606c..918cb6a0dcba 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2859,6 +2859,20 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  			return -EINVAL;
>  		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
>  		break;
> +	case SCM_TS_OPT_ID:
> +		/* allow this option for UDP sockets only */
> +		if (!sk_is_udp(sk))
> +			return -EINVAL;
> +		tsflags = READ_ONCE(sk->sk_tsflags);
> +		if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
> +			return -EINVAL;
> +		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
> +			return -EINVAL;
> +		sockc->ts_opt_id = get_unaligned((u32 *)CMSG_DATA(cmsg));

Is the get_unaligned here needed? I don't usually see that on
CMSG_DATA accesses. Even though they are indeed likely to be
unaligned.

> +		/* do not allow 0 as packet id for timestamp */
> +		if (!sockc->ts_opt_id)
> +			return -EINVAL;
> +		break;
>  	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index b90d0f78ac80..f1e6695cafd2 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1050,8 +1050,14 @@ static int __ip_append_data(struct sock *sk,
>  
>  	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
>  		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
> -	if (hold_tskey)
> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +	if (hold_tskey) {
> +                if (cork->ts_opt_id) {
> +                        hold_tskey = false;
> +                        tskey = cork->ts_opt_id;
> +                } else {
> +                        tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +                }
> +	}
>  
>  	/* So, what's going on in the loop below?
>  	 *
> @@ -1324,6 +1330,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
>  	cork->mark = ipc->sockc.mark;
>  	cork->priority = ipc->priority;
>  	cork->transmit_time = ipc->sockc.transmit_time;
> +	cork->ts_opt_id = ipc->sockc.ts_opt_id;
>  	cork->tx_flags = 0;
>  	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
>  
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index f26841f1490f..602064250546 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1401,6 +1401,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
>  	cork->base.gso_size = ipc6->gso_size;
>  	cork->base.tx_flags = 0;
>  	cork->base.mark = ipc6->sockc.mark;
> +	cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
>  	sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
>  
>  	cork->base.length = 0;
> @@ -1545,8 +1546,14 @@ static int __ip6_append_data(struct sock *sk,
>  
>  	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
>  		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
> -	if (hold_tskey)
> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +	if (hold_tskey) {
> +		if (cork->ts_opt_id) {
> +			hold_tskey = false;
> +			tskey = cork->ts_opt_id;
> +		} else {
> +			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +		}
> +	}
>  
>  	/*
>  	 * Let's try using as much space as possible.
> -- 
> 2.43.5
> 



