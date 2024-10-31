Return-Path: <netdev+bounces-140702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C87C9B7ADD
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE201F24901
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A001ABEA3;
	Thu, 31 Oct 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpdT1kyy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186719E833
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378357; cv=none; b=BLeScpGe4bfCAeEowg+nJ2igVclHIYNVCPJaDuueVISzscVsXgwAd8HKcTHnV6yJNmUtGCeecDezWMktO22lpJgWJuYgtnXtOIV007KMAvTlLCv36PyZSwkJejQ1cpEYy5MvLu70ns1W/zAcVZdpJfAX1GY1SeRbHGsCbnqidIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378357; c=relaxed/simple;
	bh=tXHcEa4AzYspL9JGtWNdzzADF+XxVdDA9yt/WCCJjXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8zom1DoSKTLMn47jnOkt7aUPY89/hYUSoYcR5ZSO2dieXatqfT79+JYXXlVlf4YyaYYm8iSoYmLwnRFkFGhGHNvRTdmt0N43asSW5/Vh+BBSlVPGZCzLvvga48PK4MqESJf+MEvXgwsUfKtAXCurHTX5MntVMuwsWPNf1qdSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpdT1kyy; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83aac75fcceso29132439f.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730378354; x=1730983154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCG0ZWYScfSiTN4UbzIn6tsNqSO0qb2ol/K203hQt1U=;
        b=WpdT1kyyExPe1nBlVbUbzCJoclPDU9Uwj1OeiR/ET9irVW09MAqTUjJLpEyq+G7zHw
         YLXlhujYwU7Bnttuijg7lKCWnPG5Dh/uFHl1i4rTrTWOsRUXj2yXiHi61ZbbyKR5e837
         /3bQ+4tyuXDnpjPr/QRx0ChxuuSV3BymMQrY3zuS8Kb+e9kGfTRiWS5tGdWrBAAXPCaU
         nGNqdlMQiU20PNrrCVN8FgcHZg7SfbaJhD/eyBnOKuUlrtjJMne61FQGOEYedMRqZi6A
         qrk5Io58WksGPJpyLMPoO8t/KFBEIce7XXOGcAlnHB/rVJj+0enkR6mZTDBPlCoPHKmn
         mzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378354; x=1730983154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCG0ZWYScfSiTN4UbzIn6tsNqSO0qb2ol/K203hQt1U=;
        b=qPMe0qC7Uo0TQtQsnHdJRmq21NufSqX3FaFQlU2hN0yDU0gW31Av62hbXPRBiZexZE
         7bFElz2NndAiIfiF2z7e9oJEjdMHQD2p9BfCG/KXfy8SCYsICDZPg4/sS78JXUUyQFW1
         LCUkrSf7AKvELAYVG9is9CkVD91RuXtjtp1BR1ja77ZhUv+B5+4JaK85wPxxdlE8pVBn
         HvIw9AOazFDoXghF0tnw2ts5qvqj6kAz8NDSWfcNMpRgZBu8p6GgX5LGtMFIjQdjyGkV
         kY5MHkEE0b0I4pMFLMcOs2AlfWlXZpMNxpvXeeGj0uiI1XSCVGsw7f7go/tp2+jYsj8T
         BmRg==
X-Gm-Message-State: AOJu0YzGgFZXiQywAQdt14KRUmDVk2e2ktJJjDRO1tl6iZbBGTtMGiH6
	DwZtPY6X7dzI7np23OGT+5QxqC/CduvTfFL0w/rSI6s4afuvnQu2+D2UqzEJa7/BnirwZY9s7UR
	RZ3S8ReNAQAp+fYD9h7cpTheT4E3LE7Af
X-Google-Smtp-Source: AGHT+IGThhM819ixlg7TjCnBlbDDDINLCFZ+Tc7tZ6uukfN8FQAYpKOB4JhYDkf4P/IGo8v0R+jZEjeX4hWL99xu1Ro=
X-Received: by 2002:a05:6602:6b10:b0:82d:18d:bab with SMTP id
 ca18e2360f4ac-83b1c5d4ecamr1864859339f.15.1730378354348; Thu, 31 Oct 2024
 05:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029144142.31382-1-annaemesenyiri@gmail.com> <6720fc298dd5a_2bcd7f29492@willemb.c.googlers.com.notmuch>
In-Reply-To: <6720fc298dd5a_2bcd7f29492@willemb.c.googlers.com.notmuch>
From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Thu, 31 Oct 2024 13:39:03 +0100
Message-ID: <CAKm6_Rv2-0BgpzAKCBPsi9TJbTPq5q0maC1odUAdNEQV7GegiQ@mail.gmail.com>
Subject: Re: [PATCH net-next] support SO_PRIORITY cmsg
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn <willemdebruijn.kernel@gmail.com> ezt =C3=ADrta (id=C5=91p=
ont:
2024. okt. 29., K, 16:15):
>
> Anna Emese Nyiri wrote:
> > The Linux socket API currently supports setting SO_PRIORITY at the sock=
et
> > level, which applies a uniform priority to all packets sent through tha=
t
> > socket. The only exception is IP_TOS, if that is specified as ancillary
> > data, the packet does not inherit the socket's priority. Instead, the
> > priority value is computed when handling the ancillary data (as impleme=
nted
> > in commit <f02db315b8d888570cb0d4496cfbb7e4acb047cb>: "ipv4: IP_TOS
> > and IP_TTL can be specified as ancillary data").
>
> Please use commit format <$SHA1:12> ("subject"). Checkpatch might also
> flag this.
>
> > Currently, there is no option to set the priority directly from userspa=
ce
> > on a per-packet basis. The following changes allow SO_PRIORITY to be se=
t
> > through control messages (CMSG), giving userspace applications more
> > granular control over packet priorities.
> >
> > This patch enables setting skb->priority using CMSG. If SO_PRIORITY is
> > specified as ancillary data, the packet is sent with the priority value
> > set through sockc->priority_cmsg_value, overriding the socket-level
> > values set via the traditional setsockopt() method.
>
> Please also describe how this interacts with priority set from IP_TOS or
> IPV6_TCLASS.
>
> > This is analogous to
> > existing support for SO_MARK (as implemented in commit
> > <c6af0c227a22bb6bb8ff72f043e0fb6d99fd6515>, =E2=80=9Cip: support SO_MAR=
K
> > cmsg=E2=80=9D).
> >
> > Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > ---
> >  include/net/inet_sock.h |  2 ++
> >  include/net/sock.h      |  5 ++++-
> >  net/can/raw.c           |  6 +++++-
> >  net/core/sock.c         | 12 ++++++++++++
> >  net/ipv4/ip_output.c    | 11 ++++++++++-
> >  net/ipv4/raw.c          |  5 ++++-
> >  net/ipv6/ip6_output.c   |  8 +++++++-
> >  net/ipv6/raw.c          |  6 +++++-
> >  net/packet/af_packet.c  |  6 +++++-
> >  9 files changed, 54 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> > index f9ddd47dc4f8..9d4e4e2a8232 100644
> > --- a/include/net/inet_sock.h
> > +++ b/include/net/inet_sock.h
> > @@ -175,6 +175,8 @@ struct inet_cork {
> >       __u16                   gso_size;
> >       u64                     transmit_time;
> >       u32                     mark;
> > +     __u8            priority_cmsg_set;
> > +     u32                     priority_cmsg_value;
>
> Just priority, drop the cmsg value.
>
> Instead of an explicit "is set" bit, preferred is to initialize the
> cookie field from the sock. See sockcm_init(), below, and also
> ipcm_init_sk(). That also avoids the branches later in the datapath.
>
> >  };
> >
> >  struct inet_cork_full {
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index cce23ac4d514..e02170977165 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1794,13 +1794,16 @@ struct sockcm_cookie {
> >       u64 transmit_time;
> >       u32 mark;
> >       u32 tsflags;
> > +     u32 priority_cmsg_value;
> > +     u8 priority_cmsg_set;
> >  };
> >
> >  static inline void sockcm_init(struct sockcm_cookie *sockc,
> >                              const struct sock *sk)
> >  {
> >       *sockc =3D (struct sockcm_cookie) {
> > -             .tsflags =3D READ_ONCE(sk->sk_tsflags)
> > +             .tsflags =3D READ_ONCE(sk->sk_tsflags),
> > +             .priority_cmsg_set =3D 0
> >       };
> >  }
> >
> > diff --git a/net/can/raw.c b/net/can/raw.c
> > index 00533f64d69d..cf7e7ae64cde 100644
> > --- a/net/can/raw.c
> > +++ b/net/can/raw.c
> > @@ -962,7 +962,11 @@ static int raw_sendmsg(struct socket *sock, struct=
 msghdr *msg, size_t size)
> >       }
> >
> >       skb->dev =3D dev;
> > -     skb->priority =3D READ_ONCE(sk->sk_priority);
> > +     if (sockc.priority_cmsg_set)
> > +             skb->priority =3D sockc.priority_cmsg_value;
> > +     else
> > +             skb->priority =3D READ_ONCE(sk->sk_priority);
> > +
> >       skb->mark =3D READ_ONCE(sk->sk_mark);
> >       skb->tstamp =3D sockc.transmit_time;
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 9abc4fe25953..899bf850b52a 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2863,6 +2863,18 @@ int __sock_cmsg_send(struct sock *sk, struct cms=
ghdr *cmsg,
> >       case SCM_RIGHTS:
> >       case SCM_CREDENTIALS:
> >               break;
> > +     case SO_PRIORITY:
> > +             if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(u32)))
> > +                     return -EINVAL;
> > +
> > +             if ((*(u32 *)CMSG_DATA(cmsg) >=3D 0 && *(u32 *)CMSG_DATA(=
cmsg) <=3D 6) ||
> > +                 sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW=
) ||
> > +                 sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADM=
IN)) {
> > +                     sockc->priority_cmsg_value =3D *(u32 *)CMSG_DATA(=
cmsg);
> > +                     sockc->priority_cmsg_set =3D 1;
> > +                     break;
> > +             }
>
> What is the magic constant 6 here?

The mechanism for setting the priority value via cmsg mirrors that of
setting the priority value through setsockopt. The control of the
priority value is managed by the sk_setsockopt function, which allows
setting the priority within the range of 0 to 6. However, if the user
has CAP_NET_ADMIN or CAP_NET_RAW capability, they are permitted to set
any priority value without restriction. The specified range of 0 to 6
was selected to align with existing priority value check.

