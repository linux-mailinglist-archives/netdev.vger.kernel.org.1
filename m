Return-Path: <netdev+bounces-123867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02694966B24
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271311C21F69
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40291BFE11;
	Fri, 30 Aug 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/1FOBIq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90D13D60E
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052095; cv=none; b=cv93yLuOuPzIgilwKx/7VVb6BgCh9SiLKSYydhMJpAkwdae2Zk+YW1E3pv0O/76sl8uXwMLRuPFBWL4a30dzKcUUJpjXe3LWJPDnZeUH3myg3OKu3RyW855XBzocem45wSL3ke73iWyNTlrGlQY8dikl/FRzfnMbELYq6LqBU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052095; c=relaxed/simple;
	bh=HqRvkYuGFw+oAZ8VMWVhJEcRtfkKXYYlEeHuALX5SWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiTWHuQpY4i3XH7EK47WRrgjrDXZPWyDInPG3GmW9Q9G1FaA5/Bji3X9SsbUdfOdBzDQ8O7Z4avwSMIEOZays2PIU/ZdA0dUnTtroMo+CiuzH0S1KtnkDQ3dm7bg6Lxnern8lDH+Z9rnE3TgtxZsYpitx1ULahGHL2qvc6PLqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/1FOBIq; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-690aabe2600so19638317b3.0
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725052093; x=1725656893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO5DaGIR3/pAn+rcwINbmbxdVh2wd5shdvMsHgCD9+E=;
        b=m/1FOBIq+G2sQmvOzDIyz5kngAk74fl/+D8s4YW8eAieuuHE000oPd33MByVk6tZWC
         VtozQchUzsIxQsuPkz1Zolc7cHQxGywWWfpUwPoZ+T7WHMicN9m0syFqjJRs2Uy59/Im
         R8vZy+1XTEod16YVMbCEtVikio3lKvf31O9FyE+efTZ5WV0Wo0C0zWEFfKA2bhHuZhNw
         9+Vb+ZFjc+gUBN3GgZigQAn7vjxi9iUL8wC7j75l66K+e3huhRF37ebY01JVjYFUcmoa
         fBSrS9NmPl+45Z+ufYg0wW2QqOimbfbXcuB2ovtiLrP5l5QTst7RA9ZDbg1CZ3gA59k2
         p4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725052093; x=1725656893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO5DaGIR3/pAn+rcwINbmbxdVh2wd5shdvMsHgCD9+E=;
        b=LiOj4FfV45LfDQJSEMTegQFrGSmhXuO7ryaAkiog0DAGC+acuDKKhjNEhJWfG/EixS
         14pr6NF/ul0lfeYh4I9pYB92L1VszYbq2ayhkCG8HEKN3J1gOC2iiQ+VHqUYLdB1tvql
         X637CtI+L9AhbtolNH0pc2TO9rmSd0CuX5EHCo3vW5nNIJvYxcfHBkrN+ppKGLmnIQAf
         hLavYLVo12vdVhMVvoStxJW4vuITFfdej5ChZ+xYhvsfFMPFVzhTUFKj+K8w1FIZI1jQ
         NAT2xPjtHaZ5GxFmwyoYmvedQqscX63Dps2OHqL8IRadzu/acJ46e/wVX2+tVizpExPG
         Nzgw==
X-Forwarded-Encrypted: i=1; AJvYcCXgaAQuZBqzLn9YS1/xBma/TK+/oTWoyw6RlZVIZGImPv1mXcxQVbYJGDGb2opV06Y8bBwsKKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WBcHn+qA6BEoYxBPDf1CN9ReB8YEG2VHgm9HdduHnk/R6Lig
	uvQD00j5BQ3p1yujFHIsFSou8hlORtuhO++2CsxVhwHzdF6dYeOmbiwIoEYr2jxbOJaetY8utFW
	0t/NWWP+jnTb8t6KeGQnM1A9F+jg92/u1Llpb
X-Google-Smtp-Source: AGHT+IEI4/XfzliN9jhOOzsMYcJ0nvOBuDa4TGWvbNfzHdvZ1cu0F5FsB4cV+OK/lYX+3kbhvQH1ESA+EmRGOnogI6M=
X-Received: by 2002:a05:690c:fca:b0:6af:8662:ff37 with SMTP id
 00721157ae682-6d40f82a5e9mr42703537b3.21.1725052092533; Fri, 30 Aug 2024
 14:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829204922.1674865-1-vadfed@meta.com> <66d1df11a42fc_3c08a2294a5@willemb.c.googlers.com.notmuch>
 <e3bddd1e-d0a8-40f9-ba95-b19cbbb57560@linux.dev>
In-Reply-To: <e3bddd1e-d0a8-40f9-ba95-b19cbbb57560@linux.dev>
From: Willem de Bruijn <willemb@google.com>
Date: Fri, 30 Aug 2024 17:07:32 -0400
Message-ID: <CA+FuTSe1DXY04rpwaaVvK0qFgq3owUtjTiRrVTTCUuUsR0UKyw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Vadim Fedorenko <vadfed@meta.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:11=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 30/08/2024 16:02, Willem de Bruijn wrote:
> > Vadim Fedorenko wrote:
> >> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> >> timestamps and packets sent via socket. Unfortunately, there is no way
> >> to reliably predict socket timestamp ID value in case of error returne=
d
> >> by sendmsg. For UDP sockets it's impossible because of lockless
> >> nature of UDP transmit, several threads may send packets in parallel. =
In
> >> case of RAW sockets MSG_MORE option makes things complicated. More
> >> details are in the conversation [1].
> >> This patch adds new control message type to give user-space
> >> software an opportunity to control the mapping between packets and
> >> values by providing ID with each sendmsg. This works fine for UDP
> >> sockets only, and explicit check is added to control message parser.
> >>
> >> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD=
_B9Eaa9aDPfgHdtA@mail.gmail.com/
> >>
> >> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >> ---
> >>   include/net/inet_sock.h           |  4 +++-
> >>   include/net/sock.h                |  1 +
> >>   include/uapi/asm-generic/socket.h |  2 ++
> >>   include/uapi/linux/net_tstamp.h   |  1 +
> >>   net/core/sock.c                   | 12 ++++++++++++
> >>   net/ipv4/ip_output.c              | 13 +++++++++++--
> >>   net/ipv6/ip6_output.c             | 13 +++++++++++--
> >>   7 files changed, 41 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> >> index 394c3b66065e..2161d50cf0fd 100644
> >> --- a/include/net/inet_sock.h
> >> +++ b/include/net/inet_sock.h
> >> @@ -174,6 +174,7 @@ struct inet_cork {
> >>      __s16                   tos;
> >>      char                    priority;
> >>      __u16                   gso_size;
> >> +    u32                     ts_opt_id;
> >>      u64                     transmit_time;
> >>      u32                     mark;
> >>   };
> >> @@ -241,7 +242,8 @@ struct inet_sock {
> >>      struct inet_cork_full   cork;
> >>   };
> >>
> >> -#define IPCORK_OPT  1       /* ip-options has been held in ipcork.opt=
 */
> >> +#define IPCORK_OPT          1       /* ip-options has been held in ip=
cork.opt */
> >> +#define IPCORK_TS_OPT_ID    2       /* timestmap opt id has been prov=
ided in cmsg */
> >>
> >>   enum {
> >>      INET_FLAGS_PKTINFO      =3D 0,
> >> diff --git a/include/net/sock.h b/include/net/sock.h
> >> index f51d61fab059..73e21dad5660 100644
> >> --- a/include/net/sock.h
> >> +++ b/include/net/sock.h
> >> @@ -1794,6 +1794,7 @@ struct sockcm_cookie {
> >>      u64 transmit_time;
> >>      u32 mark;
> >>      u32 tsflags;
> >> +    u32 ts_opt_id;
> >>   };
> >>
> >>   static inline void sockcm_init(struct sockcm_cookie *sockc,
> >> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-gene=
ric/socket.h
> >> index 8ce8a39a1e5f..db3df3e74b01 100644
> >> --- a/include/uapi/asm-generic/socket.h
> >> +++ b/include/uapi/asm-generic/socket.h
> >> @@ -135,6 +135,8 @@
> >>   #define SO_PASSPIDFD               76
> >>   #define SO_PEERPIDFD               77
> >>
> >> +#define SCM_TS_OPT_ID               78
> >> +
> >>   #if !defined(__KERNEL__)
> >>
> >>   #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__I=
LP32__))
> >> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_=
tstamp.h
> >> index a2c66b3d7f0f..081b40a55a2e 100644
> >> --- a/include/uapi/linux/net_tstamp.h
> >> +++ b/include/uapi/linux/net_tstamp.h
> >> @@ -32,6 +32,7 @@ enum {
> >>      SOF_TIMESTAMPING_OPT_TX_SWHW =3D (1<<14),
> >>      SOF_TIMESTAMPING_BIND_PHC =3D (1 << 15),
> >>      SOF_TIMESTAMPING_OPT_ID_TCP =3D (1 << 16),
> >> +    SOF_TIMESTAMPING_OPT_ID_CMSG =3D (1 << 17),
> >>
> >>      SOF_TIMESTAMPING_LAST =3D SOF_TIMESTAMPING_OPT_ID_TCP,
> >>      SOF_TIMESTAMPING_MASK =3D (SOF_TIMESTAMPING_LAST - 1) |
> >
> > Update SOF_TIMESTAMPING_LAST
>
> Got it
>
> >> diff --git a/net/core/sock.c b/net/core/sock.c
> >> index 468b1239606c..560b075765fa 100644
> >> --- a/net/core/sock.c
> >> +++ b/net/core/sock.c
> >> @@ -2859,6 +2859,18 @@ int __sock_cmsg_send(struct sock *sk, struct cm=
sghdr *cmsg,
> >>                      return -EINVAL;
> >>              sockc->transmit_time =3D get_unaligned((u64 *)CMSG_DATA(c=
msg));
> >>              break;
> >> +    case SCM_TS_OPT_ID:
> >> +            /* allow this option for UDP sockets only */
> >> +            if (!sk_is_udp(sk))
> >> +                    return -EINVAL;
> >> +            tsflags =3D READ_ONCE(sk->sk_tsflags);
> >> +            if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
> >> +                    return -EINVAL;
> >> +            if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(u32)))
> >> +                    return -EINVAL;
> >> +            sockc->ts_opt_id =3D *(u32 *)CMSG_DATA(cmsg);
> >> +            sockc->tsflags |=3D SOF_TIMESTAMPING_OPT_ID_CMSG;
> >> +            break;
> >>      /* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. *=
/
> >>      case SCM_RIGHTS:
> >>      case SCM_CREDENTIALS:
> >> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> >> index b90d0f78ac80..65b5d9f53102 100644
> >> --- a/net/ipv4/ip_output.c
> >> +++ b/net/ipv4/ip_output.c
> >> @@ -1050,8 +1050,14 @@ static int __ip_append_data(struct sock *sk,
> >>
> >>      hold_tskey =3D cork->tx_flags & SKBTX_ANY_TSTAMP &&
> >>                   READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
> >> -    if (hold_tskey)
> >> -            tskey =3D atomic_inc_return(&sk->sk_tskey) - 1;
> >> +    if (hold_tskey) {
> >> +            if (cork->flags & IPCORK_TS_OPT_ID) {
> >> +                    hold_tskey =3D false;
> >> +                    tskey =3D cork->ts_opt_id;
> >> +            } else {
> >> +                    tskey =3D atomic_inc_return(&sk->sk_tskey) - 1;
> >> +            }
> >> +    }
> >>
> >>      /* So, what's going on in the loop below?
> >>       *
> >> @@ -1324,8 +1330,11 @@ static int ip_setup_cork(struct sock *sk, struc=
t inet_cork *cork,
> >>      cork->mark =3D ipc->sockc.mark;
> >>      cork->priority =3D ipc->priority;
> >>      cork->transmit_time =3D ipc->sockc.transmit_time;
> >> +    cork->ts_opt_id =3D ipc->sockc.ts_opt_id;
> >>      cork->tx_flags =3D 0;
> >>      sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
> >> +    if (ipc->sockc.tsflags & SOF_TIMESTAMPING_OPT_ID_CMSG)
> >> +            cork->flags |=3D IPCORK_TS_OPT_ID;
> >>
> >>      return 0;
> >>   }
> >> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> >> index f26841f1490f..91eafef85c85 100644
> >> --- a/net/ipv6/ip6_output.c
> >> +++ b/net/ipv6/ip6_output.c
> >> @@ -1401,7 +1401,10 @@ static int ip6_setup_cork(struct sock *sk, stru=
ct inet_cork_full *cork,
> >>      cork->base.gso_size =3D ipc6->gso_size;
> >>      cork->base.tx_flags =3D 0;
> >>      cork->base.mark =3D ipc6->sockc.mark;
> >> +    cork->base.ts_opt_id =3D ipc6->sockc.ts_opt_id;
> >>      sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
> >> +    if (ipc6->sockc.tsflags & SOF_TIMESTAMPING_OPT_ID_CMSG)
> >> +            cork->base.flags |=3D IPCORK_TS_OPT_ID;
> >>
> >>      cork->base.length =3D 0;
> >>      cork->base.transmit_time =3D ipc6->sockc.transmit_time;
> >> @@ -1545,8 +1548,14 @@ static int __ip6_append_data(struct sock *sk,
> >>
> >>      hold_tskey =3D cork->tx_flags & SKBTX_ANY_TSTAMP &&
> >>                   READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
> >> -    if (hold_tskey)
> >> -            tskey =3D atomic_inc_return(&sk->sk_tskey) - 1;
> >> +    if (hold_tskey) {
> >> +            if (cork->flags & IPCORK_TS_OPT_ID) {
> >> +                    hold_tskey =3D false;
> >> +                    tskey =3D cork->ts_opt_id;
> >> +            } else {
> >> +                    tskey =3D atomic_inc_return(&sk->sk_tskey) - 1;
> >> +            }
> >> +    }
> >
> > Setting, then clearing hold_tskey is a bit weird. How about
> >
> > if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
> >      READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
> >          if (cork->flags & IPCORK_TS_OPT_ID) {
> >                   tskey =3D cork->ts_opt_id;
> >          } else {
> >                   tskey =3D atomic_inc_return(&sk->sk_tskey) - 1;
> >                   hold_tskey =3D true;
> >          }
> > }
>
> Yeah, looks ok, I'll change it this way, thanks!
>
> Can you please help me with kernel test robot report? I don't really get
> how can SCM_TS_OPT_ID be undefined if I added it the exact same place
> where other option are defined, like SCM_TXTIME or SO_MARK?

Both bot reports mention arch-alpha.

Take a look at the patch that introduced SCM_TXTIME. That is defined
and used in the same locations.

UAPI socket.h definitions need to be defined separate for various
archs. I also missed this.

Btw, for a next version please also document the new feature in
Documentation/networking/timestamping.rst

And let's keep it on the list.

