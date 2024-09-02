Return-Path: <netdev+bounces-124258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E786968B51
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B231F2324D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233C519F10A;
	Mon,  2 Sep 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF6D/+OF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D61A2627
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292276; cv=none; b=gvc2lkKY22K7sG7QAIBpmDBhQs7E2uNBPSvSzGtw9NjkRU7bA+5MBCSoXaMzR009jR6+o7Fa70fsgNhbdkMmbAGXVEeMam4RJ4ER0jIP2xxuk9WNTs96PF1XCuJBZq3yyhVNMk8reXCo8/JcDgx2/099dZYkgl3I5zah7EQKE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292276; c=relaxed/simple;
	bh=dSsE7zYYJS5dwL+1DcfUnipjqwN4e+A57zc8waq25jA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WAepAKzua0l7MzeP6R4RZBWSddr+bVs43h/KzaMwL3XKuk+VePpoWfg3r7UoihQI5Tn5qhyJrnwjgJsjXYJzk5er7dANPn9DV0cLqZt1Tyaj57hkX3LFStieAsfrIw6inK8Evu47N9Qa544WeA4OkZ5N32tEGJahCPi00HwrYJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF6D/+OF; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a8116a4233so197862185a.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725292273; x=1725897073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oIcIugGxY92Qs00JJSqtEQHuHLWwngmtwKuAdy4DO0=;
        b=eF6D/+OFCtOvJtnAtEBK428RKgGHI7bZyQpT0oQinXNh0u+BqGEdyemMQ7Wdx2iF3+
         hQUHNWFSH8JRFUdhf8q01v+85BDs9ajA5C5o0PhV+1kNuxfa+BeC3c7+qKLC7DdkHAnB
         HR+E6vM7c+nD88dWMZGY6Lj42qrYkSoKQKZv4IEG2uS2VENcj6W3OyzKaX8ps6zNef+8
         WcZjPnoaEsZGLZC6v4nDX6V+F6lYNfsmBk9vgK7nL6LDydeHTW9sFvEnrtKkQmpprprc
         SFg9q1kJSP3GYDfXtGDXoD6MijTmuRCZjoFueWS8dAMKP79L/jFHO7PTHqvDKg3WVtKb
         dh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725292273; x=1725897073;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7oIcIugGxY92Qs00JJSqtEQHuHLWwngmtwKuAdy4DO0=;
        b=fotvo32aAkY+G66ouUvMegxtRYhECdwRSRkojeouBZTkBtOGaqVrOq1dlHPnZ4aApx
         HvNuPEEbu5NMA8kfxR84C0cksenvt3TUDY+BgHM/CwXXNmRg7LgdY4ngidNIdIiRks9W
         sg+q7k2sqeQagoIu8B5bHsLuRQchpZ31nvbVIfOeuKQiAVNEgS/+9xbQluRKRH7jLT1G
         IFXoId9qjDiQFKaLaxztlOQ7E6Og3TQCj640QV59XRR8BbPIHHvy+h7fjwMBP30KroNB
         Z0ZFd61qyIA8zPM5MSAh18B5VzdI1SioZ3DHBO0JRLGdHLVUd/sUimDH41sedxtVvHAO
         TJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBI/9FainebYIcc96q1Gw+OUb2FbeFx6FWoi3joycP5KiS/ibSvov2QHEJBYp6i+ckd+v7Oz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEfUx5LTt8qGdYVNQ+5ge4trGJyZoMnZfPgnX50+hf8DcxSC5
	oAzau9NaslBSIClY48cAzYZ0uIzSoLBdDslBl4Xq9K2AjtkxyMbB
X-Google-Smtp-Source: AGHT+IHJQehPOIv/eHeOoUSbQvHqJFMZkHKb2GJ1KJiPOQRLXt2/AQWcpKe1Yb3ejTUFm4Wu1CBVHg==
X-Received: by 2002:a05:620a:25ce:b0:79f:d0f:2b19 with SMTP id af79cd13be357-7a804292562mr1932141685a.68.1725292272902;
        Mon, 02 Sep 2024 08:51:12 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c2418csm432164285a.29.2024.09.02.08.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:51:12 -0700 (PDT)
Date: Mon, 02 Sep 2024 11:51:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org
Message-ID: <66d5def0ca56_66cf629420@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDgai2bLqnU0KtspTu1nn=qb_23TQNUf7u=-VOhnitaOA@mail.gmail.com>
References: <20240902130937.457115-1-vadfed@meta.com>
 <CAL+tcoDgai2bLqnU0KtspTu1nn=qb_23TQNUf7u=-VOhnitaOA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Mon, Sep 2, 2024 at 9:09=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com=
> wrote:
> >
> > SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate T=
X
> > timestamps and packets sent via socket. Unfortunately, there is no wa=
y
> > to reliably predict socket timestamp ID value in case of error return=
ed
> > by sendmsg. For UDP sockets it's impossible because of lockless
> > nature of UDP transmit, several threads may send packets in parallel.=
 In
> > case of RAW sockets MSG_MORE option makes things complicated. More
> > details are in the conversation [1].
> > This patch adds new control message type to give user-space
> > software an opportunity to control the mapping between packets and
> > values by providing ID with each sendmsg. This works fine for UDP
> > sockets only, and explicit check is added to control message parser.
> >
> > [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1S=
D_B9Eaa9aDPfgHdtA@mail.gmail.com/
> >
> > Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> > ---
> >  Documentation/networking/timestamping.rst | 14 ++++++++++++++
> >  arch/alpha/include/uapi/asm/socket.h      |  4 +++-
> >  arch/mips/include/uapi/asm/socket.h       |  2 ++
> >  arch/parisc/include/uapi/asm/socket.h     |  2 ++
> >  arch/sparc/include/uapi/asm/socket.h      |  2 ++
> >  include/net/inet_sock.h                   |  4 +++-
> >  include/net/sock.h                        |  1 +
> >  include/uapi/asm-generic/socket.h         |  2 ++
> >  include/uapi/linux/net_tstamp.h           |  3 ++-
> >  net/core/sock.c                           | 12 ++++++++++++
> >  net/ethtool/common.c                      |  1 +
> >  net/ipv4/ip_output.c                      | 16 ++++++++++++----
> >  net/ipv6/ip6_output.c                     | 16 ++++++++++++----
> >  13 files changed, 68 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/networking/timestamping.rst b/Documentatio=
n/networking/timestamping.rst
> > index 5e93cd71f99f..93b0901e4e8e 100644
> > --- a/Documentation/networking/timestamping.rst
> > +++ b/Documentation/networking/timestamping.rst
> > @@ -193,6 +193,20 @@ SOF_TIMESTAMPING_OPT_ID:
> >    among all possibly concurrently outstanding timestamp requests for=

> >    that socket.
> >
> > +  With this option enabled user-space application can provide custom=

> > +  ID for each message sent via UDP socket with control message with
> > +  type set to SCM_TS_OPT_ID::
> > +
> > +    struct msghdr *msg;
> > +    ...
> > +    cmsg                        =3D CMSG_FIRSTHDR(msg);
> > +    cmsg->cmsg_level            =3D SOL_SOCKET;
> > +    cmsg->cmsg_type             =3D SO_TIMESTAMPING;
> > +    cmsg->cmsg_len              =3D CMSG_LEN(sizeof(__u32));
> > +    *((__u32 *) CMSG_DATA(cmsg)) =3D opt_id;
> > +    err =3D sendmsg(fd, msg, 0);
> > +
> > +
> >  SOF_TIMESTAMPING_OPT_ID_TCP:
> >    Pass this modifier along with SOF_TIMESTAMPING_OPT_ID for new TCP
> >    timestamping applications. SOF_TIMESTAMPING_OPT_ID defines how the=

> > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/includ=
e/uapi/asm/socket.h
> > index e94f621903fe..0698e6662cdf 100644
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -10,7 +10,7 @@
> >   * Note: we only bother about making the SOL_SOCKET options
> >   * same as OSF/1, as that's all that "normal" programs are
> >   * likely to set.  We don't necessarily want to be binary
> > - * compatible with _everything_.
> > + * compatible with _everything_.
> >   */
> >  #define SOL_SOCKET     0xffff
> >
> > @@ -140,6 +140,8 @@
> >  #define SO_PASSPIDFD           76
> >  #define SO_PEERPIDFD           77
> >
> > +#define SCM_TS_OPT_ID          78
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64
> > diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/=
uapi/asm/socket.h
> > index 60ebaed28a4c..bb3dc8feb205 100644
> > --- a/arch/mips/include/uapi/asm/socket.h
> > +++ b/arch/mips/include/uapi/asm/socket.h
> > @@ -151,6 +151,8 @@
> >  #define SO_PASSPIDFD           76
> >  #define SO_PEERPIDFD           77
> >
> > +#define SCM_TS_OPT_ID          78
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64
> > diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/incl=
ude/uapi/asm/socket.h
> > index be264c2b1a11..c3ab3b3289eb 100644
> > --- a/arch/parisc/include/uapi/asm/socket.h
> > +++ b/arch/parisc/include/uapi/asm/socket.h
> > @@ -132,6 +132,8 @@
> >  #define SO_PASSPIDFD           0x404A
> >  #define SO_PEERPIDFD           0x404B
> >
> > +#define SCM_TS_OPT_ID          0x404C
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64
> > diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/includ=
e/uapi/asm/socket.h
> > index 682da3714686..9b40f0a57fbc 100644
> > --- a/arch/sparc/include/uapi/asm/socket.h
> > +++ b/arch/sparc/include/uapi/asm/socket.h
> > @@ -133,6 +133,8 @@
> >  #define SO_PASSPIDFD             0x0055
> >  #define SO_PEERPIDFD             0x0056
> >
> > +#define SCM_TS_OPT_ID            0x0057
> > +
> >  #if !defined(__KERNEL__)
> >
> >
> > diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> > index 394c3b66065e..2161d50cf0fd 100644
> > --- a/include/net/inet_sock.h
> > +++ b/include/net/inet_sock.h
> > @@ -174,6 +174,7 @@ struct inet_cork {
> >         __s16                   tos;
> >         char                    priority;
> >         __u16                   gso_size;
> > +       u32                     ts_opt_id;
> >         u64                     transmit_time;
> >         u32                     mark;
> >  };
> > @@ -241,7 +242,8 @@ struct inet_sock {
> >         struct inet_cork_full   cork;
> >  };
> >
> > -#define IPCORK_OPT     1       /* ip-options has been held in ipcork=
.opt */
> > +#define IPCORK_OPT             1       /* ip-options has been held i=
n ipcork.opt */
> > +#define IPCORK_TS_OPT_ID       2       /* timestmap opt id has been =
provided in cmsg */
> >
> >  enum {
> >         INET_FLAGS_PKTINFO      =3D 0,
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index f51d61fab059..73e21dad5660 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1794,6 +1794,7 @@ struct sockcm_cookie {
> >         u64 transmit_time;
> >         u32 mark;
> >         u32 tsflags;
> > +       u32 ts_opt_id;
> >  };
> >
> >  static inline void sockcm_init(struct sockcm_cookie *sockc,
> > diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-gen=
eric/socket.h
> > index 8ce8a39a1e5f..db3df3e74b01 100644
> > --- a/include/uapi/asm-generic/socket.h
> > +++ b/include/uapi/asm-generic/socket.h
> > @@ -135,6 +135,8 @@
> >  #define SO_PASSPIDFD           76
> >  #define SO_PEERPIDFD           77
> >
> > +#define SCM_TS_OPT_ID          78
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__I=
LP32__))
> > diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net=
_tstamp.h
> > index a2c66b3d7f0f..e2f145e3f3a1 100644
> > --- a/include/uapi/linux/net_tstamp.h
> > +++ b/include/uapi/linux/net_tstamp.h
> > @@ -32,8 +32,9 @@ enum {
> >         SOF_TIMESTAMPING_OPT_TX_SWHW =3D (1<<14),
> >         SOF_TIMESTAMPING_BIND_PHC =3D (1 << 15),
> >         SOF_TIMESTAMPING_OPT_ID_TCP =3D (1 << 16),
> > +       SOF_TIMESTAMPING_OPT_ID_CMSG =3D (1 << 17),
> =

> I'm not sure if the new flag needs to be documented as well? After
> this patch, people may search the key word in the documentation file
> and then find nothing.
>
> If we have this flag here, normally it means we can pass it through
> setsockopt, so is it expected? If it's an exception, I reckon that we
> can forbid passing/setting this option in sock_set_timestamping() and
> document this rule?

Good point, thanks.

It must definitely not be part of SOF_TIMESTAMPING_MASK. My bad for
suggesting without giving it much thought.

The bit is kernel-internal. No need to even mention it in user-facing
documentation. But anyone reading net_tstamp.h might wonder what it
does.

It should not even be in a UAPI header, but in an internal one.
Probably include/net/sock.h, near SK_FLAGS_TIMESTAMP.

Maybe we can reserve bit 31 in u32 sk_tsflags. And if we ever have
to double that flag size, it can move up to 63, as it is not UAPI in
any way. This is a workaround to having a separate flags field in
sockcm_cookie.

And have a BUILD_BUG_ON if SOF_TIMESTAMPING_LAST reaches this reserved
region.




