Return-Path: <netdev+bounces-124314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5620D968F00
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 23:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8014DB21EC8
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE32119CC04;
	Mon,  2 Sep 2024 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFZDp0DI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC941865FB
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310791; cv=none; b=ftIMpCGD7dgh65RQQ949pYYRBF90TzQQ7c03QgKKEyo3YS8Wb10P7dpash//MQanwUhgYBxJdv+v/lxGFWhbX5FBGseJ4JnHdWBuBObfN5rg5eTNj4DxvonZ+JScJD+WkXQO8dqUwi1ELsAjcNVMLVVyUapGWxp9HRKwsBRvU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310791; c=relaxed/simple;
	bh=8fiCVEoplvVvIYykkobHIJNPAGoW9IE6L41PVczVFnk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Qn7Vl0ucJa9Gqh7urR9vVDOAaKgeXrxFiwlONNH91tiSEWvC6s2jJ2qbXXA5062GD4CnFGt20G42N0I9LftzFgjstjRQK567ajHpHbuBRxl/e+wTvvF905TVKtW3Tt81ZjGxesSsSXr9bV39rDUcCAP997p138q4XmD8T69psDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFZDp0DI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a802deeb9aso285904985a.0
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725310789; x=1725915589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7Q6GKW6oFjgHddJKHPGX5vJaqKiRgPRDjVH1dd4r+0=;
        b=gFZDp0DIVeM73HoHL7xktT7raxIWLdSHfF6cBFEu0qAh6TL+0glDK1j+ba5oqke4hv
         bLdtRbKcw/+KpsNGeCkN38iLtWkF0AOJTnEnC6I8cd0/8bjhvUp0so4PNc0m7B1rux2z
         jEK8ej0k4aX9888204NEaE9yUyiax/q6IMc2WQeXOWPmbwuFahJ/0iVlkaj/mGXih87I
         uL03blYlZQQD0QXJYz2qojluTTYEuGlnjUi13zb7RBah8FqxyP3rlGro/W6zWRRlIou+
         eJefI3vAj1phaNVM2LqCl3t1x7oFE0nLtqZ6cRcJ/iJ3HPHtgJzLdku91mxYXTfCIq0d
         6W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725310789; x=1725915589;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G7Q6GKW6oFjgHddJKHPGX5vJaqKiRgPRDjVH1dd4r+0=;
        b=s3AOWK1WxNl8Jcq6PKk6Snuet+cng7Mfv4SQfHNrtQjJRGJKTv0qlrHfweEn2wjEEs
         9RQkCX689Ou+FPlw3ms78qEN2fQVN0GvVD8KT3G5n1Ena47v5QnU1V/oB8GyIwnUfemP
         tU48sYZ9dLVyxQKmYcSSD55WydLE/Q9HLem0e/Ii6CootYvqpJ9JNsWnNhLoxChSGkrK
         /CAftha11YIb+xdocrx0y5SER2TMYe483NvP3lOB0HxUP6b/SRzSrJb2uo2/lMzzkAqW
         L53lK/C3fki+35/BfylU8+RvpFJn1MGc3b8EpYXDsvdi6rWGOt18VHv/mGxK0klJj+ys
         N6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXK91vBAwC7SMwmJlHaZ5D3n5/pAnKSu7CA/3vEekPRb3ouG2JjQ24OnScHLkcgrCg/fOk+kCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/6pYp5BMEi3liLk7quHP6VrWdvoz9S0W2HWGqAmBXbS8EYn/o
	byKY4PXA+9pZaJOQrBUxFfdIGtsgJuWCycG6yw8Ydt9/IyueVOWE
X-Google-Smtp-Source: AGHT+IHYmRABt2OOJjsR5iV6eV2vgdGElHQJtdHegr2whPyFL0cNhrQSm7nfcEN3PbQxeVvzdVxNoA==
X-Received: by 2002:a05:620a:31a8:b0:7a7:e4a7:6450 with SMTP id af79cd13be357-7a89aca76fdmr1148454085a.48.1725310788414;
        Mon, 02 Sep 2024 13:59:48 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d3d148sm455054585a.97.2024.09.02.13.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 13:59:47 -0700 (PDT)
Date: Mon, 02 Sep 2024 16:59:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <66d627439edbd_71ed729422@willemb.c.googlers.com.notmuch>
In-Reply-To: <0d79442d-438b-4960-8daf-2f178a210e64@linux.dev>
References: <20240902130937.457115-1-vadfed@meta.com>
 <CAL+tcoDgai2bLqnU0KtspTu1nn=qb_23TQNUf7u=-VOhnitaOA@mail.gmail.com>
 <66d5def0ca56_66cf629420@willemb.c.googlers.com.notmuch>
 <0d79442d-438b-4960-8daf-2f178a210e64@linux.dev>
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

Vadim Fedorenko wrote:
> On 02/09/2024 16:51, Willem de Bruijn wrote:
> > Jason Xing wrote:
> >> On Mon, Sep 2, 2024 at 9:09=E2=80=AFPM Vadim Fedorenko <vadfed@meta.=
com> wrote:
> >>>
> >>> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate=
 TX
> >>> timestamps and packets sent via socket. Unfortunately, there is no =
way
> >>> to reliably predict socket timestamp ID value in case of error retu=
rned
> >>> by sendmsg. For UDP sockets it's impossible because of lockless
> >>> nature of UDP transmit, several threads may send packets in paralle=
l. In
> >>> case of RAW sockets MSG_MORE option makes things complicated. More
> >>> details are in the conversation [1].
> >>> This patch adds new control message type to give user-space
> >>> software an opportunity to control the mapping between packets and
> >>> values by providing ID with each sendmsg. This works fine for UDP
> >>> sockets only, and explicit check is added to control message parser=
.
> >>>
> >>> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr=
1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> >>>
> >>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >>> ---
> >>>   Documentation/networking/timestamping.rst | 14 ++++++++++++++
> >>>   arch/alpha/include/uapi/asm/socket.h      |  4 +++-
> >>>   arch/mips/include/uapi/asm/socket.h       |  2 ++
> >>>   arch/parisc/include/uapi/asm/socket.h     |  2 ++
> >>>   arch/sparc/include/uapi/asm/socket.h      |  2 ++
> >>>   include/net/inet_sock.h                   |  4 +++-
> >>>   include/net/sock.h                        |  1 +
> >>>   include/uapi/asm-generic/socket.h         |  2 ++
> >>>   include/uapi/linux/net_tstamp.h           |  3 ++-
> >>>   net/core/sock.c                           | 12 ++++++++++++
> >>>   net/ethtool/common.c                      |  1 +
> >>>   net/ipv4/ip_output.c                      | 16 ++++++++++++----
> >>>   net/ipv6/ip6_output.c                     | 16 ++++++++++++----
> >>>   13 files changed, 68 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/Documentation/networking/timestamping.rst b/Documentat=
ion/networking/timestamping.rst
> >>> index 5e93cd71f99f..93b0901e4e8e 100644
> >>> --- a/Documentation/networking/timestamping.rst
> >>> +++ b/Documentation/networking/timestamping.rst
> >>> @@ -193,6 +193,20 @@ SOF_TIMESTAMPING_OPT_ID:
> >>>     among all possibly concurrently outstanding timestamp requests =
for
> >>>     that socket.
> >>>
> >>> +  With this option enabled user-space application can provide cust=
om
> >>> +  ID for each message sent via UDP socket with control message wit=
h
> >>> +  type set to SCM_TS_OPT_ID::
> >>> +
> >>> +    struct msghdr *msg;
> >>> +    ...
> >>> +    cmsg                        =3D CMSG_FIRSTHDR(msg);
> >>> +    cmsg->cmsg_level            =3D SOL_SOCKET;
> >>> +    cmsg->cmsg_type             =3D SO_TIMESTAMPING;
> >>> +    cmsg->cmsg_len              =3D CMSG_LEN(sizeof(__u32));
> >>> +    *((__u32 *) CMSG_DATA(cmsg)) =3D opt_id;
> >>> +    err =3D sendmsg(fd, msg, 0);
> >>> +
> >>> +
> >>>   SOF_TIMESTAMPING_OPT_ID_TCP:
> >>>     Pass this modifier along with SOF_TIMESTAMPING_OPT_ID for new T=
CP
> >>>     timestamping applications. SOF_TIMESTAMPING_OPT_ID defines how =
the
> >>> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/incl=
ude/uapi/asm/socket.h
> >>> index e94f621903fe..0698e6662cdf 100644
> >>> --- a/arch/alpha/include/uapi/asm/socket.h
> >>> +++ b/arch/alpha/include/uapi/asm/socket.h
> >>> @@ -10,7 +10,7 @@
> >>>    * Note: we only bother about making the SOL_SOCKET options
> >>>    * same as OSF/1, as that's all that "normal" programs are
> >>>    * likely to set.  We don't necessarily want to be binary
> >>> - * compatible with _everything_.
> >>> + * compatible with _everything_.
> >>>    */
> >>>   #define SOL_SOCKET     0xffff
> >>>
> >>> @@ -140,6 +140,8 @@
> >>>   #define SO_PASSPIDFD           76
> >>>   #define SO_PEERPIDFD           77
> >>>
> >>> +#define SCM_TS_OPT_ID          78
> >>> +
> >>>   #if !defined(__KERNEL__)
> >>>
> >>>   #if __BITS_PER_LONG =3D=3D 64
> >>> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/includ=
e/uapi/asm/socket.h
> >>> index 60ebaed28a4c..bb3dc8feb205 100644
> >>> --- a/arch/mips/include/uapi/asm/socket.h
> >>> +++ b/arch/mips/include/uapi/asm/socket.h
> >>> @@ -151,6 +151,8 @@
> >>>   #define SO_PASSPIDFD           76
> >>>   #define SO_PEERPIDFD           77
> >>>
> >>> +#define SCM_TS_OPT_ID          78
> >>> +
> >>>   #if !defined(__KERNEL__)
> >>>
> >>>   #if __BITS_PER_LONG =3D=3D 64
> >>> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/in=
clude/uapi/asm/socket.h
> >>> index be264c2b1a11..c3ab3b3289eb 100644
> >>> --- a/arch/parisc/include/uapi/asm/socket.h
> >>> +++ b/arch/parisc/include/uapi/asm/socket.h
> >>> @@ -132,6 +132,8 @@
> >>>   #define SO_PASSPIDFD           0x404A
> >>>   #define SO_PEERPIDFD           0x404B
> >>>
> >>> +#define SCM_TS_OPT_ID          0x404C
> >>> +
> >>>   #if !defined(__KERNEL__)
> >>>
> >>>   #if __BITS_PER_LONG =3D=3D 64
> >>> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/incl=
ude/uapi/asm/socket.h
> >>> index 682da3714686..9b40f0a57fbc 100644
> >>> --- a/arch/sparc/include/uapi/asm/socket.h
> >>> +++ b/arch/sparc/include/uapi/asm/socket.h
> >>> @@ -133,6 +133,8 @@
> >>>   #define SO_PASSPIDFD             0x0055
> >>>   #define SO_PEERPIDFD             0x0056
> >>>
> >>> +#define SCM_TS_OPT_ID            0x0057
> >>> +
> >>>   #if !defined(__KERNEL__)
> >>>
> >>>
> >>> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> >>> index 394c3b66065e..2161d50cf0fd 100644
> >>> --- a/include/net/inet_sock.h
> >>> +++ b/include/net/inet_sock.h
> >>> @@ -174,6 +174,7 @@ struct inet_cork {
> >>>          __s16                   tos;
> >>>          char                    priority;
> >>>          __u16                   gso_size;
> >>> +       u32                     ts_opt_id;
> >>>          u64                     transmit_time;
> >>>          u32                     mark;
> >>>   };
> >>> @@ -241,7 +242,8 @@ struct inet_sock {
> >>>          struct inet_cork_full   cork;
> >>>   };
> >>>
> >>> -#define IPCORK_OPT     1       /* ip-options has been held in ipco=
rk.opt */
> >>> +#define IPCORK_OPT             1       /* ip-options has been held=
 in ipcork.opt */
> >>> +#define IPCORK_TS_OPT_ID       2       /* timestmap opt id has bee=
n provided in cmsg */
> >>>
> >>>   enum {
> >>>          INET_FLAGS_PKTINFO      =3D 0,
> >>> diff --git a/include/net/sock.h b/include/net/sock.h
> >>> index f51d61fab059..73e21dad5660 100644
> >>> --- a/include/net/sock.h
> >>> +++ b/include/net/sock.h
> >>> @@ -1794,6 +1794,7 @@ struct sockcm_cookie {
> >>>          u64 transmit_time;
> >>>          u32 mark;
> >>>          u32 tsflags;
> >>> +       u32 ts_opt_id;
> >>>   };
> >>>
> >>>   static inline void sockcm_init(struct sockcm_cookie *sockc,
> >>> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-g=
eneric/socket.h
> >>> index 8ce8a39a1e5f..db3df3e74b01 100644
> >>> --- a/include/uapi/asm-generic/socket.h
> >>> +++ b/include/uapi/asm-generic/socket.h
> >>> @@ -135,6 +135,8 @@
> >>>   #define SO_PASSPIDFD           76
> >>>   #define SO_PEERPIDFD           77
> >>>
> >>> +#define SCM_TS_OPT_ID          78
> >>> +
> >>>   #if !defined(__KERNEL__)
> >>>
> >>>   #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(=
__ILP32__))
> >>> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/n=
et_tstamp.h
> >>> index a2c66b3d7f0f..e2f145e3f3a1 100644
> >>> --- a/include/uapi/linux/net_tstamp.h
> >>> +++ b/include/uapi/linux/net_tstamp.h
> >>> @@ -32,8 +32,9 @@ enum {
> >>>          SOF_TIMESTAMPING_OPT_TX_SWHW =3D (1<<14),
> >>>          SOF_TIMESTAMPING_BIND_PHC =3D (1 << 15),
> >>>          SOF_TIMESTAMPING_OPT_ID_TCP =3D (1 << 16),
> >>> +       SOF_TIMESTAMPING_OPT_ID_CMSG =3D (1 << 17),
> >>
> >> I'm not sure if the new flag needs to be documented as well? After
> >> this patch, people may search the key word in the documentation file=

> >> and then find nothing.
> >>
> >> If we have this flag here, normally it means we can pass it through
> >> setsockopt, so is it expected? If it's an exception, I reckon that w=
e
> >> can forbid passing/setting this option in sock_set_timestamping() an=
d
> >> document this rule?
> > =

> > Good point, thanks.
> > =

> > It must definitely not be part of SOF_TIMESTAMPING_MASK. My bad for
> > suggesting without giving it much thought.
> > =

> > The bit is kernel-internal. No need to even mention it in user-facing=

> > documentation. But anyone reading net_tstamp.h might wonder what it
> > does.
> > =

> > It should not even be in a UAPI header, but in an internal one.
> > Probably include/net/sock.h, near SK_FLAGS_TIMESTAMP.
> > =

> > Maybe we can reserve bit 31 in u32 sk_tsflags. And if we ever have
> > to double that flag size, it can move up to 63, as it is not UAPI in
> > any way. This is a workaround to having a separate flags field in
> > sockcm_cookie.
> > =

> > And have a BUILD_BUG_ON if SOF_TIMESTAMPING_LAST reaches this reserve=
d
> > region.
> =

> Yeah, I was also thinking of it not being UAPI, that's why I tried to
> avoid it in my RFC using 0 as a reserved value. Do you think
> SK_FLAGS_CMSG_TS_OPT_ID is good naming for it?

It's relevant only to sockcm_cookie, so maybe SOCKCM_FLAG_TS_OPT_ID?

One day we'll need another sockcm_cookie flag, we'll grow it to add a
real flags field and can get rid of this hack.

The struct is used embedded in ipcm_cookie and ipcm6_cookie, which
would grow as a result.

It is also simply stack allocated in cases like performance sensitive
tcp_sendmsg_locked. Here, the main cost is a slightly more expensive
zeroing in sockcm_init.

For now, I think we should just stick with using the highest bit in
sockcm.tsflags.



