Return-Path: <netdev+bounces-124246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97775968AC6
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188561F22861
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5E3183CD4;
	Mon,  2 Sep 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOycwbUY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D01CB50B
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290430; cv=none; b=YmgSGGSTvI34WYddPjEUYeImCQvrUGYcURBUpV74BzUt7VwdY3rcdwHMGUuMow8jfEUTQ/kJWjBq68hFxYf9NSGfHW/9T4LJ6OkiruK+QzjF8Gbkvfr/fuA+j+V8SY1HjkKhy7nSNM8cuzrKiioD7H6ERFBoeWIUowICBaSj9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290430; c=relaxed/simple;
	bh=spNaR9YELXPvgd+dDdle2zziHaydW2fKWAsnn+xz3SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luijriIupTymNCDJgoVaZ3j+GHEaWuf+GvNwtM0XGSkPOPFq9bUJRM855SumuEExxm+ehPVI2BzgM5/L9XAkWSOf6eBklYPsDzLRBfcYsIN1bVrH/AOj0d/+B5+czU12qhwhOKZi1yrQHHF4bMfRljSKakZIJuasBptYY+5XACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOycwbUY; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39f50e0caa6so7868125ab.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725290428; x=1725895228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhIkHQW2MwS/jaA6hFOxoLaQ9BupM8fF/koLSZV8Eb8=;
        b=iOycwbUYxpCflkyswq7OX1VcO63egRp7CN9sU9fTU1vFiSCj+P5qAbRdScMsggvz2s
         QeRHUIeFqPfOYOUJdpqrwpZPkiVwB/WJ+Y3WV7U5CTr8bS6L82YvCV+G4F24AjfmvMXK
         wF/3KEJXiKmwdIbD3TgvL/lcmmASjrXi6xGGX5f5KyYQPi3fSNJ2EVC2gpUPKczvxRUj
         pP3ttJskqvsTC1GlP+zQmn1KlWaq902cI1A12los4+WW0qKJXdL0cQwVgDoh4a1qvmV8
         PmM6x5uMy7WZcE9nzPKleM3nthQj8w3BKdmAcGtKK9E3KaJoD/VjHwinsyeiMF/Vjvs5
         ZCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725290428; x=1725895228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhIkHQW2MwS/jaA6hFOxoLaQ9BupM8fF/koLSZV8Eb8=;
        b=MWPneStLCgCbqKqQ4N7u9T3XHl7HxxrYo2Ps8EEl4GB1mUhAxyW9n0jUez9KUMSBJR
         TgAehy1HP64vUv2i6BwYuYr/aKIe3Z7ZKyLYgxL1zzPu2H2rQNGeyoJXCYLCwXGb3+Vi
         L7RX7UU6t8J+W/mzSP/PSfNIZkmxqCdUUuljlKTetaKFDAQGktG8yCUS/MH8Lqrbzxj6
         vxcWEgiEzbP8KQcbsVnaBxZxGOOiK34JGL5eyEMOiS0f1KCCKa9/FZJupFxjTNOy37g4
         UnkOBSFNlus4jlS0ju8iFOSNRzYsXH06TARs4/5nJ/cwAeTVDLAQPAGWftB+LRF9CqON
         EV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMmExlDYBl3bpiTHxsXeGoihz7srFi4MVv5zzV0WyA6GebY5I6qmuPpXGmqkn4/APa0p7Gs9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZFwHkISiXs8Fwcd6/F5SUn5R1qpU9g21NTcsp0dIHaTuspnd
	VLx/rP11zJNxsPhytA39LCGl/JH+5szbuf4Fsd72o0xFEcgTwCpDgTbyP8sMz7fpRkniCduW6va
	QItr7Elqfr5YMew6yBC+CFx9bK7s=
X-Google-Smtp-Source: AGHT+IEsMQj7WzBKr/CZH2NNMgbdXjhh2D/2SqeUGSeSLRkrrwzBDmlSEXWSntzvVOijqeix1+/F/0fVlwSSwYnk2Jw=
X-Received: by 2002:a05:6e02:12cb:b0:39f:5a9e:dec7 with SMTP id
 e9e14a558f8ab-39f5a9ee812mr56165475ab.15.1725290428150; Mon, 02 Sep 2024
 08:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902130937.457115-1-vadfed@meta.com>
In-Reply-To: <20240902130937.457115-1-vadfed@meta.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 2 Sep 2024 23:19:51 +0800
Message-ID: <CAL+tcoDgai2bLqnU0KtspTu1nn=qb_23TQNUf7u=-VOhnitaOA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 9:09=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> wr=
ote:
>
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
> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9=
Eaa9aDPfgHdtA@mail.gmail.com/
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
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/ne=
tworking/timestamping.rst
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
> +    cmsg                        =3D CMSG_FIRSTHDR(msg);
> +    cmsg->cmsg_level            =3D SOL_SOCKET;
> +    cmsg->cmsg_type             =3D SO_TIMESTAMPING;
> +    cmsg->cmsg_len              =3D CMSG_LEN(sizeof(__u32));
> +    *((__u32 *) CMSG_DATA(cmsg)) =3D opt_id;
> +    err =3D sendmsg(fd, msg, 0);
> +
> +
>  SOF_TIMESTAMPING_OPT_ID_TCP:
>    Pass this modifier along with SOF_TIMESTAMPING_OPT_ID for new TCP
>    timestamping applications. SOF_TIMESTAMPING_OPT_ID defines how the
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/ua=
pi/asm/socket.h
> index e94f621903fe..0698e6662cdf 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -10,7 +10,7 @@
>   * Note: we only bother about making the SOL_SOCKET options
>   * same as OSF/1, as that's all that "normal" programs are
>   * likely to set.  We don't necessarily want to be binary
> - * compatible with _everything_.
> + * compatible with _everything_.
>   */
>  #define SOL_SOCKET     0xffff
>
> @@ -140,6 +140,8 @@
>  #define SO_PASSPIDFD           76
>  #define SO_PEERPIDFD           77
>
> +#define SCM_TS_OPT_ID          78
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi=
/asm/socket.h
> index 60ebaed28a4c..bb3dc8feb205 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -151,6 +151,8 @@
>  #define SO_PASSPIDFD           76
>  #define SO_PEERPIDFD           77
>
> +#define SCM_TS_OPT_ID          78
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/=
uapi/asm/socket.h
> index be264c2b1a11..c3ab3b3289eb 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -132,6 +132,8 @@
>  #define SO_PASSPIDFD           0x404A
>  #define SO_PEERPIDFD           0x404B
>
> +#define SCM_TS_OPT_ID          0x404C
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/ua=
pi/asm/socket.h
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
>         __s16                   tos;
>         char                    priority;
>         __u16                   gso_size;
> +       u32                     ts_opt_id;
>         u64                     transmit_time;
>         u32                     mark;
>  };
> @@ -241,7 +242,8 @@ struct inet_sock {
>         struct inet_cork_full   cork;
>  };
>
> -#define IPCORK_OPT     1       /* ip-options has been held in ipcork.opt=
 */
> +#define IPCORK_OPT             1       /* ip-options has been held in ip=
cork.opt */
> +#define IPCORK_TS_OPT_ID       2       /* timestmap opt id has been prov=
ided in cmsg */
>
>  enum {
>         INET_FLAGS_PKTINFO      =3D 0,
> diff --git a/include/net/sock.h b/include/net/sock.h
> index f51d61fab059..73e21dad5660 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1794,6 +1794,7 @@ struct sockcm_cookie {
>         u64 transmit_time;
>         u32 mark;
>         u32 tsflags;
> +       u32 ts_opt_id;
>  };
>
>  static inline void sockcm_init(struct sockcm_cookie *sockc,
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic=
/socket.h
> index 8ce8a39a1e5f..db3df3e74b01 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,8 @@
>  #define SO_PASSPIDFD           76
>  #define SO_PEERPIDFD           77
>
> +#define SCM_TS_OPT_ID          78
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tst=
amp.h
> index a2c66b3d7f0f..e2f145e3f3a1 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -32,8 +32,9 @@ enum {
>         SOF_TIMESTAMPING_OPT_TX_SWHW =3D (1<<14),
>         SOF_TIMESTAMPING_BIND_PHC =3D (1 << 15),
>         SOF_TIMESTAMPING_OPT_ID_TCP =3D (1 << 16),
> +       SOF_TIMESTAMPING_OPT_ID_CMSG =3D (1 << 17),

I'm not sure if the new flag needs to be documented as well? After
this patch, people may search the key word in the documentation file
and then find nothing.

If we have this flag here, normally it means we can pass it through
setsockopt, so is it expected? If it's an exception, I reckon that we
can forbid passing/setting this option in sock_set_timestamping() and
document this rule?

Thanks,
Jason

