Return-Path: <netdev+bounces-141288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737829BA5B2
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 14:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D34B20C1E
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04685170A29;
	Sun,  3 Nov 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chWigww3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A793BA42
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730641170; cv=none; b=TaVhVhct7D51QsigggLN3NVyxMEqZKlQ9xW9ZKLZo+Jr3qfe1hkVTaL3qSW9HhgrgPwQdGNHkURR9zx9bMdeK2O/uvn/GY9l71/5rK8t/5rqZg2sVk0u48Mk+03zdYP6G2OT8B50KB2g9827ufV9cEWxAqdyChu31ImoNhz/h9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730641170; c=relaxed/simple;
	bh=SKW3zvj4wZ+wewVM8QK1EhzERGudJGGbIKnwW7ZrwsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcVK9XLtF3I59jDlLgjK+MvqEupSyZRq0cCpo+rjm0bMq13AxWu+qWvAGA7Sp7fhyp7Bv8hNOIDjoZLAv1j/uyxnc39HpBYYQR8u9E2D8CrqFzXPwU6t4lKBZraoMJ2Y/vaQv4ijdfWQch0oAwz0bf02pT6xEj2zHy7yBp9Dzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chWigww3; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83ac817aac3so136918639f.0
        for <netdev@vger.kernel.org>; Sun, 03 Nov 2024 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730641168; x=1731245968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzhJzmm+ZoxSHrUJREvcLJDbyVOYmlAO53xn30EzH5Y=;
        b=chWigww3uBpm117PDrBaI982ANixqmFo0L23GKzokueRtxBbQdT9lVR/4FJupQua8Z
         KCHX8RbyzbnmgI9Vvj35hl6AULiMy/hTiq7WXIqZ7yKaPkCvNalPWV6b7leDArOFft1c
         bGUTuWpesnnqQMBcsmg5HW4d8uUHQFF4YmtAjqZjx9wL/zYXMe1POp8YvBQDZbWcCO1O
         iOt6z9qVjIzdBMwGhmKCpJC47KNtEu/PNRUC95cpGYnjab5bg/GWrUDJt2mVsRlVCI5m
         iM4Iz8UVtLkdfEMzaKL5Z586HvnvwQ3IzHkkxiC+W2dspUIrgnV3LXCbUdzIbL8VtPhW
         AfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730641168; x=1731245968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzhJzmm+ZoxSHrUJREvcLJDbyVOYmlAO53xn30EzH5Y=;
        b=K0t8ciI2uJwXaNuVXT4Iz/ssz4l0xVXNyRfFrYRAXoJjhL+hVYCBUTkkjf8tQxaewa
         yUAx9yGwJ+TSNfmUXrICODLlBhIgzav9hh2/zvagCygLu5pIAtlavz6KOoRab/43nIi1
         wMbG+b75o6U1Wh0K+SY2foa1PmiPCIkQFpHXBaoIN/SS85W2kRMFgO2XQCcsIeogm7Zo
         aZPwQ627pSQk7H7/zk0wQ3hTl4PcH001X1dtU4cKwEz3bzzxf15UoCnxuPQ2HG4pI17e
         NE+Fdg0WmnNZEJPwWF8s1/DnbqiP5C8Qze2vOMSXZ5s3iIqCA2cDjuH9YvXxC5tU81T2
         z5Ug==
X-Gm-Message-State: AOJu0Yyf64FEk5Adc8t+oYWGLDIBeALaOFuEP3gu5bw6dEO2nd44jNCQ
	9KLS2jNtnp4Q+j9d3eXea7PJI5HB7/dIiiQhL0p7zIdGpf+KapnG7Fi5uHVceWFuPyRz/4m+GWe
	GTVygPQnynV8VPqB6cOFYH7lrmWk=
X-Google-Smtp-Source: AGHT+IGhIpOB91GA4A5MXPHuI4xXOIuXx/eFfhKkgCBlWv3aMm1ckphyDfwbMR8BNAZXKdXT4BpxwGBLxGAtP7H3gbk=
X-Received: by 2002:a05:6e02:180f:b0:3a0:8c68:7705 with SMTP id
 e9e14a558f8ab-3a5e262e863mr177294865ab.21.1730641168091; Sun, 03 Nov 2024
 05:39:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102125136.5030-1-annaemesenyiri@gmail.com>
 <20241102125136.5030-3-annaemesenyiri@gmail.com> <6726d1954a48f_2980c729499@willemb.c.googlers.com.notmuch>
In-Reply-To: <6726d1954a48f_2980c729499@willemb.c.googlers.com.notmuch>
From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Sun, 3 Nov 2024 14:39:17 +0100
Message-ID: <CAKm6_RtYXpa5HnTNe+b1xy9p4BsdD8JnG30F+_ktBYcd2QSyfQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] support SO_PRIORITY cmsg
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn <willemdebruijn.kernel@gmail.com> ezt =C3=ADrta (id=C5=91p=
ont:
2024. nov. 3., V, 2:27):
>
> Anna Emese Nyiri wrote:
> > The Linux socket API currently supports setting SO_PRIORITY at the
> > socket level, which applies a uniform priority to all packets sent
> > through that socket. The only exception is IP_TOS; if specified as
> > ancillary data, the packet does not inherit the socket's priority.
> > Instead, the priority value is computed when handling the ancillary
> > data (as implemented in commit <f02db315b8d88>
>
> nit: drop the brackets
>
> > ("ipv4: IP_TOS and IP_TTL can be specified as ancillary data")). If
> > the priority is set via IP_TOS, then skb->priority derives its value
> > from the rt_tos2priority function, which calculates the priority
> > based on the value of ipc->tos obtained from IP_TOS. However, if
> > IP_TOS is not used and the priority has been set through a control
> > message, skb->priority will take the value provided by that control
> > message.
>
> The above describes the new situation? There is no way to set
> priority to a control message prior to this patch.
>
> > Therefore, when both options are available, the primary
> > source for skb->priority is the value set via IP_TOS.
> >
> > Currently, there is no option to set the priority directly from
> > userspace on a per-packet basis. The following changes allow
> > SO_PRIORITY to be set through control messages (CMSG), giving
> > userspace applications more granular control over packet priorities.
> >
> > This patch enables setting skb->priority using CMSG. If SO_PRIORITY
>
> Duplicate statement. Overall, the explanation can perhaps be
> condensed and made more clear.
>
> > is specified as ancillary data, the packet is sent with the priority
> > value set through sockc->priority_cmsg_value, overriding the
>
> No longer matches the code.
>
> > socket-level values set via the traditional setsockopt() method. This
> > is analogous to existing support for SO_MARK (as implemented in commit
> > <c6af0c227a22> ("ip: support SO_MARK cmsg")).
> >
> > Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > ---
> >  include/net/inet_sock.h | 2 +-
> >  include/net/ip.h        | 3 ++-
> >  include/net/sock.h      | 4 +++-
> >  net/can/raw.c           | 2 +-
> >  net/core/sock.c         | 8 ++++++++
> >  net/ipv4/ip_output.c    | 7 +++++--
> >  net/ipv4/raw.c          | 2 +-
> >  net/ipv6/ip6_output.c   | 3 ++-
> >  net/ipv6/raw.c          | 2 +-
> >  net/packet/af_packet.c  | 2 +-
> >  10 files changed, 25 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> > index 56d8bc5593d3..3ccbad881d74 100644
> > --- a/include/net/inet_sock.h
> > +++ b/include/net/inet_sock.h
> > @@ -172,7 +172,7 @@ struct inet_cork {
> >       u8                      tx_flags;
> >       __u8                    ttl;
> >       __s16                   tos;
> > -     char                    priority;
> > +     u32                     priority;
>
> Let's check with pahole how this affects struct size and holes.
> It likely adds a hole, but unavoidably so.
>
> >       __u16                   gso_size;
> >       u32                     ts_opt_id;
> >       u64                     transmit_time;
> > diff --git a/include/net/ip.h b/include/net/ip.h
> > index 0e548c1f2a0e..e8f71a191277 100644
> > --- a/include/net/ip.h
> > +++ b/include/net/ip.h
> > @@ -81,7 +81,7 @@ struct ipcm_cookie {
> >       __u8                    protocol;
> >       __u8                    ttl;
> >       __s16                   tos;
> > -     char                    priority;
> > +     u32                     priority;
>
> No need for a field in ipcm_cookie, when also present in
> sockcm_cookie. As SO_PRIORITY is not limited to IP, sockcm_cookie is
> the right location.

I think there could be a problem if the priority is set by IP_TOS for
some reason, and then also via cmsg. The latter value may overwrite
it. In the ip_setup_cork() function, there is therefore a check for
the value cork->tos !=3D -1 to give priority to the value set by IP_TOS.
And that's why I thought that there should be a priority field in both
ipcm_cookie and sockcm_cookie. The priority field already existed in
ipcm_cookie, I didn't add it. I just changed the type.

>
> If cmsg IP_TOS is present, that can overridde ipc->sockc.priority with
> rt_tos2priority.
>
> Interesting that this override by IP_TOS seems to be IPV4 only. There
> is no equivalent call to rt_tos2priority when setting IPV6_TCLASS.
>
> >       __u16                   gso_size;
> >  };
> >
> > @@ -96,6 +96,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *i=
pcm,
> >       ipcm_init(ipcm);
> >
> >       ipcm->sockc.mark =3D READ_ONCE(inet->sk.sk_mark);
> > +     ipcm->sockc.priority =3D READ_ONCE(inet->sk.sk_priority);
> >       ipcm->sockc.tsflags =3D READ_ONCE(inet->sk.sk_tsflags);
> >       ipcm->oif =3D READ_ONCE(inet->sk.sk_bound_dev_if);
> >       ipcm->addr =3D inet->inet_saddr;
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 7464e9f9f47c..316a34d6c48b 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1814,13 +1814,15 @@ struct sockcm_cookie {
> >       u32 mark;
> >       u32 tsflags;
> >       u32 ts_opt_id;
> > +     u32 priority;
> >  };
> >
> >  static inline void sockcm_init(struct sockcm_cookie *sockc,
> >                              const struct sock *sk)
> >  {
> >       *sockc =3D (struct sockcm_cookie) {
> > -             .tsflags =3D READ_ONCE(sk->sk_tsflags)
> > +             .tsflags =3D READ_ONCE(sk->sk_tsflags),
> > +             .priority =3D READ_ONCE(sk->sk_priority),
> >       };
> >  }
> >
> > diff --git a/net/can/raw.c b/net/can/raw.c
> > index 255c0a8f39d6..46e8ed9d64da 100644
> > --- a/net/can/raw.c
> > +++ b/net/can/raw.c
> > @@ -962,7 +962,7 @@ static int raw_sendmsg(struct socket *sock, struct =
msghdr *msg, size_t size)
> >       }
> >
> >       skb->dev =3D dev;
> > -     skb->priority =3D READ_ONCE(sk->sk_priority);
> > +     skb->priority =3D sockc.priority;
> >       skb->mark =3D READ_ONCE(sk->sk_mark);
> >       skb->tstamp =3D sockc.transmit_time;
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 5ecf6f1a470c..d5586b9212dd 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2941,6 +2941,14 @@ int __sock_cmsg_send(struct sock *sk, struct cms=
ghdr *cmsg,
> >       case SCM_RIGHTS:
> >       case SCM_CREDENTIALS:
> >               break;
> > +     case SO_PRIORITY:
> > +             if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(u32)))
> > +                     return -EINVAL;
> > +             if (sk_set_prio_allowed(sk, *(u32 *)CMSG_DATA(cmsg))) {
> > +                     sockc->priority =3D *(u32 *)CMSG_DATA(cmsg);
> > +                     break;
> > +             }
> > +             return -EPERM;
>
> nit: invert to make the error case the (speculated as unlikely) branch
> and have the common path unindented.
>
> >       default:
> >               return -EINVAL;
> >       }

