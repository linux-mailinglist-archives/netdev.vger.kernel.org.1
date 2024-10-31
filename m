Return-Path: <netdev+bounces-140720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6799E9B7B3E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6511C21015
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FBE156236;
	Thu, 31 Oct 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJmGn3VV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727B1BD9E4
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379668; cv=none; b=QwEiime30Zv5poH7omkMGfOdFNKEFo5MHC9jT2YYbzWNQ7OwksvtuN9d+R7o+Rf1Efae3WhAmIbLQh+NwsuLDHTUX+XHpjhLihr0Syz6+BzVY/oOwEFRO9nMc+q8SW5PifCEWTFB3nfqUtIN9zjUPSZUhJMCTCAeCck8iKvXhgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379668; c=relaxed/simple;
	bh=WL0ekRzpEJWB2MlvkZdSWdD1HNMMUD37a8GqtIGSz6U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VOM70ixRSOTpDzcY1lN2DF16eu+D43osEo77jseIRuTqMfcb9jJpLi3/5aOP1gqWG245IUIwmL+p2Bvie65TUheKismo72axafUTs/fmSfANkKT6K1dqqFDnQo3Rg1rbasKEQoV26SMOREFCavecifjyVLirKzvamsUwPLeNnU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJmGn3VV; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71809fe188cso414602a34.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730379664; x=1730984464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dpGwKmpYLtHY2CPvIf6drSwpHGzRpDVIUyo9Mf7N0A=;
        b=gJmGn3VVz4O5ghc+bHhaWk2dL52TLcfpiGXjX4aZx/aMpDqQNnKlAkkicV2iMDRlK9
         xQbXkjFlVTiVQnAmor+a30WXYPKF4ggKbbgzzMYVE/1UCUWg1gPzj6DMJU1VjDO4hJpd
         5zJ58rdKYDRtH+s95Jb2PD3O7Mioo1S2qt4uiG7tH19MBQ2b4Djwc0HpdBkFZqoM6SDx
         bKeqpvNwXasgCw0IbX+Drv5YYu4ktnp8FOumV9iaI2iTLK9ib1UaLnBJvqo9pDVKBe3Q
         YokXJVLdZcurxquzHlCWrD6T55F6Q2jSf+az1LeN78iC0PKFhj4lhTAxLZF3k66hwc0L
         28Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730379664; x=1730984464;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9dpGwKmpYLtHY2CPvIf6drSwpHGzRpDVIUyo9Mf7N0A=;
        b=GFe59xoS1tsGf+QYBqh0GNI0RY+8YxISAK9PBB49UXgWRRSV24QRLQt1/2uqY1VJyp
         eAXs52ZI3sblETuXGlSMSjq6YrV9W7or2Ri8Jkp5TiE6ov8JboB96c1tF1RbVehhk96g
         jGcjmB6TUkxf0EbW8CDzSHdmbsAmFmNcRqG5oHifGf8IxTnY7UDTeFe4WMY8htyAQBUS
         mWVj8yg+YJpHpIN8DvVtAru+1z3ILsnhLmBzMJqPUQvMqPosxGJP+54GEUtA+/HDT0YV
         oWa5VlbtsicuFV5o2t5wn2OuQAhWl14CUNSnCOOxTTibGTPdOSzQGE6gQ2PuqiYNZJYV
         uTuA==
X-Gm-Message-State: AOJu0Yx/k9VETsMOA1QEavTuMPluB+nmkQlcbfBpiMjd6XC6TjHoalx5
	L2p9dPVrkeVJZ4m0lLOZ41DiPaVvi1tm2lAL/4OveZq7AFYos4Qx
X-Google-Smtp-Source: AGHT+IFj5yyG8To4lT6ftA5AtR4SwqTVO9IU7qsBys2ep5hzvhJ/n9aGZtO1qN39NHRSJ+xZLoQEvQ==
X-Received: by 2002:a05:6830:2a9f:b0:718:4063:4c71 with SMTP id 46e09a7af769-7189b4f290fmr3614154a34.15.1730379663802;
        Thu, 31 Oct 2024 06:01:03 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad164066sm7171521cf.73.2024.10.31.06.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 06:01:03 -0700 (PDT)
Date: Thu, 31 Oct 2024 09:01:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Nyiri <annaemesenyiri@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 fejes@inf.elte.hu
Message-ID: <67237f8ec3078_b635c29443@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAKm6_Rv2-0BgpzAKCBPsi9TJbTPq5q0maC1odUAdNEQV7GegiQ@mail.gmail.com>
References: <20241029144142.31382-1-annaemesenyiri@gmail.com>
 <6720fc298dd5a_2bcd7f29492@willemb.c.googlers.com.notmuch>
 <CAKm6_Rv2-0BgpzAKCBPsi9TJbTPq5q0maC1odUAdNEQV7GegiQ@mail.gmail.com>
Subject: Re: [PATCH net-next] support SO_PRIORITY cmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anna Nyiri wrote:
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> ezt =C3=ADrta (id=C5=
=91pont:
> 2024. okt. 29., K, 16:15):
> >
> > Anna Emese Nyiri wrote:
> > > The Linux socket API currently supports setting SO_PRIORITY at the =
socket
> > > level, which applies a uniform priority to all packets sent through=
 that
> > > socket. The only exception is IP_TOS, if that is specified as ancil=
lary
> > > data, the packet does not inherit the socket's priority. Instead, t=
he
> > > priority value is computed when handling the ancillary data (as imp=
lemented
> > > in commit <f02db315b8d888570cb0d4496cfbb7e4acb047cb>: "ipv4: IP_TOS=

> > > and IP_TTL can be specified as ancillary data").
> >
> > Please use commit format <$SHA1:12> ("subject"). Checkpatch might als=
o
> > flag this.
> >
> > > Currently, there is no option to set the priority directly from use=
rspace
> > > on a per-packet basis. The following changes allow SO_PRIORITY to b=
e set
> > > through control messages (CMSG), giving userspace applications more=

> > > granular control over packet priorities.
> > >
> > > This patch enables setting skb->priority using CMSG. If SO_PRIORITY=
 is
> > > specified as ancillary data, the packet is sent with the priority v=
alue
> > > set through sockc->priority_cmsg_value, overriding the socket-level=

> > > values set via the traditional setsockopt() method.
> >
> > Please also describe how this interacts with priority set from IP_TOS=
 or
> > IPV6_TCLASS.
> >
> > > This is analogous to
> > > existing support for SO_MARK (as implemented in commit
> > > <c6af0c227a22bb6bb8ff72f043e0fb6d99fd6515>, =E2=80=9Cip: support SO=
_MARK
> > > cmsg=E2=80=9D).
> > >
> > > Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> > > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > > ---
> > >  include/net/inet_sock.h |  2 ++
> > >  include/net/sock.h      |  5 ++++-
> > >  net/can/raw.c           |  6 +++++-
> > >  net/core/sock.c         | 12 ++++++++++++
> > >  net/ipv4/ip_output.c    | 11 ++++++++++-
> > >  net/ipv4/raw.c          |  5 ++++-
> > >  net/ipv6/ip6_output.c   |  8 +++++++-
> > >  net/ipv6/raw.c          |  6 +++++-
> > >  net/packet/af_packet.c  |  6 +++++-
> > >  9 files changed, 54 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> > > index f9ddd47dc4f8..9d4e4e2a8232 100644
> > > --- a/include/net/inet_sock.h
> > > +++ b/include/net/inet_sock.h
> > > @@ -175,6 +175,8 @@ struct inet_cork {
> > >       __u16                   gso_size;
> > >       u64                     transmit_time;
> > >       u32                     mark;
> > > +     __u8            priority_cmsg_set;
> > > +     u32                     priority_cmsg_value;
> >
> > Just priority, drop the cmsg value.
> >
> > Instead of an explicit "is set" bit, preferred is to initialize the
> > cookie field from the sock. See sockcm_init(), below, and also
> > ipcm_init_sk(). That also avoids the branches later in the datapath.
> >
> > >  };
> > >
> > >  struct inet_cork_full {
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index cce23ac4d514..e02170977165 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -1794,13 +1794,16 @@ struct sockcm_cookie {
> > >       u64 transmit_time;
> > >       u32 mark;
> > >       u32 tsflags;
> > > +     u32 priority_cmsg_value;
> > > +     u8 priority_cmsg_set;
> > >  };
> > >
> > >  static inline void sockcm_init(struct sockcm_cookie *sockc,
> > >                              const struct sock *sk)
> > >  {
> > >       *sockc =3D (struct sockcm_cookie) {
> > > -             .tsflags =3D READ_ONCE(sk->sk_tsflags)
> > > +             .tsflags =3D READ_ONCE(sk->sk_tsflags),
> > > +             .priority_cmsg_set =3D 0
> > >       };
> > >  }
> > >
> > > diff --git a/net/can/raw.c b/net/can/raw.c
> > > index 00533f64d69d..cf7e7ae64cde 100644
> > > --- a/net/can/raw.c
> > > +++ b/net/can/raw.c
> > > @@ -962,7 +962,11 @@ static int raw_sendmsg(struct socket *sock, st=
ruct msghdr *msg, size_t size)
> > >       }
> > >
> > >       skb->dev =3D dev;
> > > -     skb->priority =3D READ_ONCE(sk->sk_priority);
> > > +     if (sockc.priority_cmsg_set)
> > > +             skb->priority =3D sockc.priority_cmsg_value;
> > > +     else
> > > +             skb->priority =3D READ_ONCE(sk->sk_priority);
> > > +
> > >       skb->mark =3D READ_ONCE(sk->sk_mark);
> > >       skb->tstamp =3D sockc.transmit_time;
> > >
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 9abc4fe25953..899bf850b52a 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -2863,6 +2863,18 @@ int __sock_cmsg_send(struct sock *sk, struct=
 cmsghdr *cmsg,
> > >       case SCM_RIGHTS:
> > >       case SCM_CREDENTIALS:
> > >               break;
> > > +     case SO_PRIORITY:
> > > +             if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(u32)))
> > > +                     return -EINVAL;
> > > +
> > > +             if ((*(u32 *)CMSG_DATA(cmsg) >=3D 0 && *(u32 *)CMSG_D=
ATA(cmsg) <=3D 6) ||
> > > +                 sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET=
_RAW) ||
> > > +                 sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET=
_ADMIN)) {
> > > +                     sockc->priority_cmsg_value =3D *(u32 *)CMSG_D=
ATA(cmsg);
> > > +                     sockc->priority_cmsg_set =3D 1;
> > > +                     break;
> > > +             }
> >
> > What is the magic constant 6 here?
> =

> The mechanism for setting the priority value via cmsg mirrors that of
> setting the priority value through setsockopt. The control of the
> priority value is managed by the sk_setsockopt function, which allows
> setting the priority within the range of 0 to 6. However, if the user
> has CAP_NET_ADMIN or CAP_NET_RAW capability, they are permitted to set
> any priority value without restriction. The specified range of 0 to 6
> was selected to align with existing priority value check.

Oh right. This is just copied from setsockopt SO_PRIORITY.
Having an non-annotated constant there is unfortunate too, but goes
back to before the introduction of git.

And that goes back to the priority bands configured with
rt_tos2priority. As setsockopt IP_TOS is not a privileged operation.

Ideally this would say TC_PRIO_BESTEFFORT and TC_PRIO_INTERACTIVE.

Since both the setsockopt and cmsg check are in net/core/sock.c,
can we deduplicate the logic and introduce helper:

    static bool sk_set_prio_allowed(const struct sock *sk, int val)
    {
            return ((val >=3D TC_PRIO_BESTEFFORT && val <=3D TC_PRIO_INTE=
RACTIVE) ||
                    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW=
) ||
                    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADM=
IN))
    }


