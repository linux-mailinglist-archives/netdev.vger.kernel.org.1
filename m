Return-Path: <netdev+bounces-124216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5F69689ED
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733F728404E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF8719E97C;
	Mon,  2 Sep 2024 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEpfHVCA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420D19E977
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287359; cv=none; b=n+EmpVhq73WFB7AuoTbq2QEmoG2v2eIsj0zC/zZd7KVP9eG7vBKV6Z9V3VbaNxtQImmBthMN9aQrYSdObD0h2oDiiOiFKwZsesjiNoog00xoBYh0vnOuvI8/QcGUJRV2AdEuougDi3f7mMgboB3hl1qg2NQVumVnOoS3zgwMNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287359; c=relaxed/simple;
	bh=pzMzqCoLGkMiXi+0OCi9mtmNqNQkdY6UoJtNdHIbTnQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G6EioHlLhezSJ+9ZmXcF1fhvWGpVk5c7FpN6Toha8Sf+Cu09sqcfyFoKFAkuxuX/EiZQcuV1/Tfkc9YWrry/Y6K70425cEsI9LNwuJdmsBhtZ4XcLj3Ep85jySUBjzA1Ond30ebMNi/BmOp1L2te4RqYrJLN580Bus95qbbuH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEpfHVCA; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a8130906faso174845085a.0
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725287357; x=1725892157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U87uHs0VLguIVZXYPTafPjqrcr4Euti3LQGPm2Q7+cc=;
        b=gEpfHVCAagC6b/HOaE0dQXVdWRGNJLx9Fi720kTrb+he73TaahCPyDMYL1l2Ygn0mx
         VGYzJMdGonF0xjXCi3tH6i4RYecjeWFgYKAtHG8zyAz+nW4bQlr6GQ3tYsbOJVVgbZbs
         suWwaH+fd8r4fKhaHftHqoEGPPF6R6FH6LNWLBXkSJk16IefBd+B3GE4aMyiWI17slTn
         TL0fNt6T/FZL4k+1ve5XYJSXxs4n2S+qlRRJnrH6pWjbZqk9pa2eIzI6kyAM1586tf9p
         JSMaT/GZDN8enVGNEfSJpl3SOM/2bVdsNooCjTxvUo6K2JYZaNoxhIGJJaL6troRdw2t
         3V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287357; x=1725892157;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U87uHs0VLguIVZXYPTafPjqrcr4Euti3LQGPm2Q7+cc=;
        b=FLwyxjao0PwAiO+c35DtNWw1nSpo7/FHR4GfGgNdN0ddgAwQlFcaz187H3y+h2zRPB
         Dinex9uTTCv8N7RttLnkW3Nwni7grqZ8lSVWkao8g0bWt39LquKlIqZBEmIB1rZX1CTc
         4iINU21Bh20wq7v7bZqTTUu9IYj7V8ZDfOij4OMfz+0bLVkz/UKHTicy/Q5bfYTw1YWT
         1vVLybrWH/mhVt/BgQUugmQp13C7Jw36W6VU904uOmFLdJ8KNYx13n/GQ+HpJErF+vhQ
         6VxklUraSzBNPvfxtOMfiNl0OZ210qJWEY5qzkQkslPt+WVcfw+4ki/BUmAQ0NeiKw3y
         fjsg==
X-Forwarded-Encrypted: i=1; AJvYcCWRzB6YeQ5MGbmaP2dplp+dSDOkLrN9QVlk7J0rqEEOqAOej/kkACk/+OLjuw+JffG1Rl5x4pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKedYBBKlKF+fIJgZLq5d66kwC9SaBFaAL+pd7u9wbXETHW16
	C1enYH4h8RwLrABZpRF4XxGru2/kPBXgbPvOkxlu4sd4QV5cMdiU
X-Google-Smtp-Source: AGHT+IEfx+PD5pyN7abi52AFsDVi8PGdh8DILEsJHDFXAHIcpy/VM1/wUo2Iy1Fyk3L24lRyVjSpcQ==
X-Received: by 2002:a05:620a:31a0:b0:7a3:5004:43e3 with SMTP id af79cd13be357-7a8a3dfdea0mr931240585a.4.1725287356510;
        Mon, 02 Sep 2024 07:29:16 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682d95fa2sm40066701cf.87.2024.09.02.07.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:29:16 -0700 (PDT)
Date: Mon, 02 Sep 2024 10:29:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>, 
 netdev@vger.kernel.org
Message-ID: <66d5cbbba9669_6138829497@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240902130937.457115-1-vadfed@meta.com>
References: <20240902130937.457115-1-vadfed@meta.com>
Subject: Re: [PATCH net-next v2 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
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
> timestamps and packets sent via socket. Unfortunately, there is no way
> to reliably predict socket timestamp ID value in case of error returned
> by sendmsg. For UDP sockets it's impossible because of lockless
> nature of UDP transmit, several threads may send packets in parallel. In
> case of RAW sockets MSG_MORE option makes things complicated. More
> details are in the conversation [1].
> This patch adds new control message type to give user-space
> software an opportunity to control the mapping between packets and
> values by providing ID with each sendmsg. This works fine for UDP
> sockets only, and explicit check is added to control message parser.
> 
> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  Documentation/networking/timestamping.rst | 14 ++++++++++++++
>  arch/alpha/include/uapi/asm/socket.h      |  4 +++-
>  arch/mips/include/uapi/asm/socket.h       |  2 ++
>  arch/parisc/include/uapi/asm/socket.h     |  2 ++
>  arch/sparc/include/uapi/asm/socket.h      |  2 ++
>  include/net/inet_sock.h                   |  4 +++-
>  include/net/sock.h                        |  1 +
>  include/uapi/asm-generic/socket.h         |  2 ++
>  include/uapi/linux/net_tstamp.h           |  3 ++-
>  net/core/sock.c                           | 12 ++++++++++++
>  net/ethtool/common.c                      |  1 +
>  net/ipv4/ip_output.c                      | 16 ++++++++++++----
>  net/ipv6/ip6_output.c                     | 16 ++++++++++++----
>  13 files changed, 68 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index 5e93cd71f99f..93b0901e4e8e 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -193,6 +193,20 @@ SOF_TIMESTAMPING_OPT_ID:
>    among all possibly concurrently outstanding timestamp requests for
>    that socket.
>  
> +  With this option enabled user-space application can provide custom
> +  ID for each message sent via UDP socket with control message with
> +  type set to SCM_TS_OPT_ID::
> +
> +    struct msghdr *msg;
> +    ...
> +    cmsg			 = CMSG_FIRSTHDR(msg);
> +    cmsg->cmsg_level		 = SOL_SOCKET;
> +    cmsg->cmsg_type		 = SO_TIMESTAMPING;
> +    cmsg->cmsg_len		 = CMSG_LEN(sizeof(__u32));
> +    *((__u32 *) CMSG_DATA(cmsg)) = opt_id;
> +    err = sendmsg(fd, msg, 0);
> +

Please make it clear that this CMSG is optional.

The process can optionally override the default generated ID, by
passing a specific ID with control message SCM_TS_OPT_ID:

>  SOF_TIMESTAMPING_OPT_ID_TCP:
>    Pass this modifier along with SOF_TIMESTAMPING_OPT_ID for new TCP
>    timestamping applications. SOF_TIMESTAMPING_OPT_ID defines how the
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index e94f621903fe..0698e6662cdf 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -10,7 +10,7 @@
>   * Note: we only bother about making the SOL_SOCKET options
>   * same as OSF/1, as that's all that "normal" programs are
>   * likely to set.  We don't necessarily want to be binary
> - * compatible with _everything_. 
> + * compatible with _everything_.

Is this due to a checkpatch warning? If so, please add a brief comment
to the commit message to show that this change is intentional. If not,
please don't touch unrelated code.

>   */
>  #define SOL_SOCKET	0xffff
>  
> @@ -140,6 +140,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>  
> +#define SCM_TS_OPT_ID		78
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> index 60ebaed28a4c..bb3dc8feb205 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -151,6 +151,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>  
> +#define SCM_TS_OPT_ID		78
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> index be264c2b1a11..c3ab3b3289eb 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -132,6 +132,8 @@
>  #define SO_PASSPIDFD		0x404A
>  #define SO_PEERPIDFD		0x404B
>  
> +#define SCM_TS_OPT_ID		0x404C
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> index 682da3714686..9b40f0a57fbc 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -133,6 +133,8 @@
>  #define SO_PASSPIDFD             0x0055
>  #define SO_PEERPIDFD             0x0056
>  
> +#define SCM_TS_OPT_ID            0x0057
> +
>  #if !defined(__KERNEL__)
>  
>  
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 394c3b66065e..2161d50cf0fd 100644
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
> @@ -241,7 +242,8 @@ struct inet_sock {
>  	struct inet_cork_full	cork;
>  };
>  
> -#define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */
> +#define IPCORK_OPT		1	/* ip-options has been held in ipcork.opt */
> +#define IPCORK_TS_OPT_ID	2	/* timestmap opt id has been provided in cmsg */

typo: timestamp

And maybe more relevant:  /* ts_opt_id field is valid, overriding sk_tskey */
  
>  enum {
>  	INET_FLAGS_PKTINFO	= 0,
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

nit: different indentation

> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
> index a2c66b3d7f0f..e2f145e3f3a1 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -32,8 +32,9 @@ enum {
>  	SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
>  	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
>  	SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
> +	SOF_TIMESTAMPING_OPT_ID_CMSG = (1 << 17),
>  
> -	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_TCP,
> +	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_CMSG,
>  	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
>  				 SOF_TIMESTAMPING_LAST
>  };
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 468b1239606c..560b075765fa 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2859,6 +2859,18 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  			return -EINVAL;
>  		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
>  		break;
> +	case SCM_TS_OPT_ID:
> +		/* allow this option for UDP sockets only */
> +		if (!sk_is_udp(sk))
> +			return -EINVAL;

Let's relax the restriction that this is only for UDP.

At least to also support SOCK_RAW. I don't think that requires any
additional code at all?

Extending to TCP should be straightforward too, just a branch
on sockc in tcp_tx_timestamp.

If so, let's support all. It makes for a simpler API if it is
supported uniformly wherever OPT_ID is.

> +		tsflags = READ_ONCE(sk->sk_tsflags);
> +		if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
> +			return -EINVAL;
> +		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
> +			return -EINVAL;
> +		sockc->ts_opt_id = *(u32 *)CMSG_DATA(cmsg);
> +		sockc->tsflags |= SOF_TIMESTAMPING_OPT_ID_CMSG;
> +		break;
>  	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:

