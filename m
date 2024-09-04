Return-Path: <netdev+bounces-125111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D72D96BF4E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF0B1F22E59
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8EA1DC185;
	Wed,  4 Sep 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYyqghD/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF41DC076
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458229; cv=none; b=jjSd7W2sUPLDF8Wa8bv8Js+uHWHFsEVW/5X7Leu69a5sUmRoycftFnH6FuI+7xiUXBKITmGoWe/IcimUBzw1/fg9uQhvCMScubbbvFceSmar/uYte7ATvcQyZSn2q08NDPQ9r11jAe8MiNmeikYuSjcwui+9e10ik5s+rV3Os2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458229; c=relaxed/simple;
	bh=XOK4tY/Tprnn1OncuUgKDdT6c5vsRvcsy2miRnZhHzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OykDI6GWbc5x/W1+nOAAO7eM8tWG+Xv50PT10uLi+HeqviCeRnmAZl63kShtgMcJImWD0PPWMD9nGr/V8W3Bihfl1d5F8/eeAwJPPwtrcVuxvjNX/CEK1GDfuGgecRlPdc152jUzGlJpPLrjrUI4OkCwJ7kMdMxq0p+xgxsV1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYyqghD/; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d47a9ffd5so24804755ab.2
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725458227; x=1726063027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMQRVp+UlvighEOwfFZFs51tNtweMTTz0vlj83ZulJk=;
        b=WYyqghD/y5YL1hixDtJqJ1UE0odTpnLBusYDr29w75bykYh2yAvXcAvv3EXFHBtNxl
         99t9cQLUxxwA3k8QYAEHVWBhJEDx02Cq6UFvbCWv2mr5/GLb993Qci5ntpajZdGOlDDy
         d8FKJ5AVrAeyZZjK0SDRmZ/XmmoLnSw5xjFVMGEPozyLqk0CXLbvnEjUNJYVd7GeeZAe
         HsmSDOMa2xbqVIBjU7wcTxsqNKBxNzisHvVxrQedJ4oCNHWInQ48gRngY6VKAygmMA04
         hQXIS6TKBpMZGpiHOe/Cjyhxuk632reu78jW79Nuna2gcaLwmu85m+cdibssCm2rcl04
         jK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458227; x=1726063027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMQRVp+UlvighEOwfFZFs51tNtweMTTz0vlj83ZulJk=;
        b=I9URWOInDr+Dd4ZiMO+ej80GgumCuHvDAb8O/JEjcciY6Rg2dblyXEz3Us8uKWexRu
         svV2Cj90FLH+NkVj8o4+ivil+OVTITo80Qno9FN93nFsKetQlzme3eoYwZCNw6hI2bEI
         Nzcu/C726J8pK3bJhqcxyDq9A3BfWJkUhtpu6P9WXGPl5T+HtoPVtpr9gZEbuba3TPvT
         srhM8nCkBUgwp2woS7uoppLlFIHfTG6viZEEF/AuEpRhExAuEHeDRtWTy+1fl9++prbL
         6mj+PauU4gYNT0uEFvTyNRxl7Co03mMdnBXZlXooYFqaPCW9t1ZctqOsRWIIBk4YgvNW
         6aVA==
X-Forwarded-Encrypted: i=1; AJvYcCXLk1rD5OBHkbg61GtjVwQ2T3rU90e+Eobju1bNwNtmfAQoTyF7k+bjIBcNeL6nBncHnjHm6F8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzd5+frNiwetvTlGqwylzIJIQ+dxcwdTjELt/7x9VStaUMLUlm
	s2WPLbHOWJecGx6q6/+8vqqFUvOiCTZ3Pv+h/o1Bb8YsEy59rybyqLWnEzNYqdLeaZa/bR7bwKI
	GI49eal94RfvBaXIt2roFhAdZJvQ=
X-Google-Smtp-Source: AGHT+IHAo1qRuWtFyj1ZadEkh8441EEfsa6wy7+ncoBua6YgbyJa+CqkDVP0Wx2i+qHeuUZsgqcQDNfKMx0v3mMSW+E=
X-Received: by 2002:a05:6e02:2141:b0:39d:2a84:86a3 with SMTP id
 e9e14a558f8ab-39f6d71c874mr72619175ab.4.1725458226641; Wed, 04 Sep 2024
 06:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904113153.2196238-1-vadfed@meta.com> <20240904113153.2196238-2-vadfed@meta.com>
In-Reply-To: <20240904113153.2196238-2-vadfed@meta.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 4 Sep 2024 21:56:30 +0800
Message-ID: <CAL+tcoDp5F57cZNsHrTAHE=Uqth89MsTyRC35CabTGJWY+vS_w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/4] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Vadim,

On Wed, Sep 4, 2024 at 7:32=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> wr=
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
> values by providing ID with each sendmsg for UDP sockets.
> The documentation is also added in this patch.
>
> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9=
Eaa9aDPfgHdtA@mail.gmail.com/
>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  Documentation/networking/timestamping.rst | 13 +++++++++++++
>  arch/alpha/include/uapi/asm/socket.h      |  2 ++
>  arch/mips/include/uapi/asm/socket.h       |  2 ++
>  arch/parisc/include/uapi/asm/socket.h     |  2 ++
>  arch/sparc/include/uapi/asm/socket.h      |  2 ++
>  include/net/inet_sock.h                   |  4 +++-
>  include/net/sock.h                        |  2 ++
>  include/uapi/asm-generic/socket.h         |  2 ++
>  include/uapi/linux/net_tstamp.h           |  7 +++++++
>  net/core/sock.c                           |  9 +++++++++
>  net/ipv4/ip_output.c                      | 18 +++++++++++++-----
>  net/ipv6/ip6_output.c                     | 18 +++++++++++++-----
>  12 files changed, 70 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/ne=
tworking/timestamping.rst
> index 5e93cd71f99f..e365526d6bf9 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -193,6 +193,19 @@ SOF_TIMESTAMPING_OPT_ID:
>    among all possibly concurrently outstanding timestamp requests for
>    that socket.
>
> +  The process can optionally override the default generated ID, by
> +  passing a specific ID with control message SCM_TS_OPT_ID::
> +
> +    struct msghdr *msg;
> +    ...
> +    cmsg                        =3D CMSG_FIRSTHDR(msg);
> +    cmsg->cmsg_level            =3D SOL_SOCKET;
> +    cmsg->cmsg_type             =3D SCM_TS_OPT_ID;
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
> index e94f621903fe..99dec81e7c84 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
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
> index 394c3b66065e..f01dd273bea6 100644
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
> +#define IPCORK_TS_OPT_ID       2       /* ts_opt_id field is valid, over=
riding sk_tskey */
>
>  enum {
>         INET_FLAGS_PKTINFO      =3D 0,
> diff --git a/include/net/sock.h b/include/net/sock.h
> index f51d61fab059..c6554ad82961 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -952,6 +952,7 @@ enum sock_flags {
>  };
>
>  #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMES=
TAMPING_RX_SOFTWARE))
> +#define SOCKCM_FLAG_TS_OPT_ID  BIT(31)
>
>  static inline void sock_copy_flags(struct sock *nsk, const struct sock *=
osk)
>  {
> @@ -1794,6 +1795,7 @@ struct sockcm_cookie {
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
> index a2c66b3d7f0f..1c38536350e7 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -38,6 +38,13 @@ enum {
>                                  SOF_TIMESTAMPING_LAST
>  };
>
> +/*
> + * The highest bit of sk_tsflags is reserved for kernel-internal
> + * SOCKCM_FLAG_TS_OPT_ID. This check is to control that SOF_TIMESTAMPING=
*
> + * values do not reach this reserved area
> + */
> +static_assert(SOF_TIMESTAMPING_LAST !=3D (1 << 31));

I saw some error occur in the patchwork:

./usr/include/linux/net_tstamp.h:46:36: error: expected =E2=80=98)=E2=80=99=
 before =E2=80=98!=3D=E2=80=99 token
   46 | static_assert(SOF_TIMESTAMPING_LAST !=3D (1 << 31));
      |                                    ^~~
      |                                    )
make[5]: *** [../usr/include/Makefile:85:
usr/include/linux/net_tstamp.hdrtest] Error 1
make[4]: *** [../scripts/Makefile.build:485: usr/include] Error 2
make[3]: *** [../scripts/Makefile.build:485: usr] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [/home/nipa/net-next/wt-1/Makefile:1925: .] Error 2
make[1]: *** [/home/nipa/net-next/wt-1/Makefile:224: __sub-make] Error 2
make: *** [Makefile:224: __sub-make] Error 2

Please see the link:
https://netdev.bots.linux.dev/static/nipa/886766/13790642/build_32bit/stder=
r
https://netdev.bots.linux.dev/static/nipa/886766/13790640/build_32bit/stder=
r

Thanks,
Jason

