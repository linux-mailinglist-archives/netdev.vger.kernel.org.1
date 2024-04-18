Return-Path: <netdev+bounces-89050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93A78A9494
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FE61C21A21
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5A575811;
	Thu, 18 Apr 2024 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1TeqA+ki"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB575801
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427453; cv=none; b=cO2DjHKuI8UZme+Bb4fp+4WRVMo78n5NWBk3eyzSBuurfLWdMexR+Snz0apGww+J4qVrq9qBLah9V3WldzzGk2C/dpfTYgMAu1DKyQy2h2ULAZQ2qb8YF8gTi9HZ3/C2uj8TiIAvDibhAX/Og+MFsZRnKpZmoWeZE14TSbHN4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427453; c=relaxed/simple;
	bh=+LEBU/LnF7WoWbazDT5+0VJCm8ZDnK5kDoEdR/eNpR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pG5c0Z+g16AsEFQTiKcmwKmqXDBw8muwTvTPT3S7s3N+UTTAYu3Bomo3OiKTM6JvVJv41WR5afrIj/cHHfAvlDDsl2gk8QwInJOYruJZaxApwkjFF6igoSeAmdRBBm8GY7T2MdWP317bZ9ffiIkxFP0nDo/Chj63asKYsoY1Apw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1TeqA+ki; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-418426e446bso41475e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713427447; x=1714032247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/OOA7zW42lpMZcSMJLnqGE7Gb3i6PSSsuOYqeT8m+Q=;
        b=1TeqA+kiuwKc+MweXFYLBMxrVLJQRx/+MmmP1uCxHMTOxtJMRW/Abc9TWHNaX6T/In
         WuJZC3mUxOwmkStvajWOlO0FIUHo76Xd2THyIVDgmRKAfLBKsKsBZYqpKEbSbBHaEUu0
         escbkgyyhcc+H4S+Qu60zrRV5NAaNdQCrxQcapfiJ/0ePB06pxe0guY05tY4bk5UiCe9
         zwnrM94s8dhvBHo72ef3yStB3fSJE/c2hFtyXYRBZo3FY9TsgMOLSYGmiL04idLCF8VX
         FDRdUmZutnjGeT6bPux8y7py7be9ABw1Cd9xXmTNdWqs/iONMyUUS1Ez856iKwgeRvsy
         x51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713427447; x=1714032247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/OOA7zW42lpMZcSMJLnqGE7Gb3i6PSSsuOYqeT8m+Q=;
        b=DXSfOUxMwybaBCdv0CDp+vi+wEto70/x2ScY9bPUTpsdMwdi5LeFU52MLtmNrGeTer
         E9lxs1gTiNA9TGYDofkp9FWurRVh6Z7sNLsuS/20jpHzUcNEO13/NOSQFBH/FFxVUlL9
         lLJZb7NeaKi8sCJws6vi7Q99Qy1CquiGV82RlaJwOTPbplLJmWVd3ATosaSl7cz/vXIX
         IeSzTdLg/DGFxZzAe8b0SbXYM3CRJDbEeo76eHKMfU5emB8BoITvb/Ia//KUuW50/9EN
         G/OUFR1gks5NPAyraKw7ULYQtPw76D5y3O24fJbLdx+Incu+EEbrno5FvHbtJiBBZW8W
         YQxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9DrDeHroUFmGMCdAxvjxBldooDWe9pR8nmCfO5jFADmJSjmQfxyHWjcrueeNyLrE5i6GvLUWWHL+VD+746ZLuetsxW1TL
X-Gm-Message-State: AOJu0YyMkvdn+4fXqQN+IbeX+4w5GSogxSUyTXWMP9r1PJnvD7DDuzxz
	9q0Yg89Tyk2G4i33YHBGRRFoQNelMckvtLt39VzbwRdUDvbRsjanFIJk5ztae852ooZKVYyi4c5
	uUPM+do9znxzEsWpkSUMKNaNKhw5w/L4tDoUt
X-Google-Smtp-Source: AGHT+IH/zfElyp8pxGrXyj+flpKMNfoO0+lxVOJP9+/dU7C9f9oUxEAqsZ5iNzaEKehAu6D0mbZqzGsh9BKyx4kiuK4=
X-Received: by 2002:a05:600c:3556:b0:418:36c4:4727 with SMTP id
 i22-20020a05600c355600b0041836c44727mr112066wmq.1.1713427446523; Thu, 18 Apr
 2024 01:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-2-edumazet@google.com>
 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
In-Reply-To: <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 10:03:51 +0200
Message-ID: <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 10:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Hi,
>
> On Wed, 2024-04-17 at 16:57 +0000, Eric Dumazet wrote:
> > Blamed commit claimed in its changelog that the new functionality
> > was guarded by IP_RECVERR/IPV6_RECVERR :
> >
> >     Note that applications need to set IP_RECVERR/IPV6_RECVERR option t=
o
> >     enable this feature, and that the error message is only queued
> >     while in SYN_SNT state.
> >
> > This was true only for IPv6, because ipv6_icmp_error() has
> > the following check:
> >
> > if (!inet6_test_bit(RECVERR6, sk))
> >     return;
> >
> > Other callers check IP_RECVERR by themselves, it is unclear
> > if we could factorize these checks in ip_icmp_error()
> >
> > For stable backports, I chose to add the missing check in tcp_v4_err()
> >
> > We think this missing check was the root cause for commit
> > 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving
> > some ICMP") breakage, leading to a revert.
> >
> > Many thanks to Dragos Tatulea for conducting the investigations.
> >
> > As Jakub said :
> >
> >     The suspicion is that SSH sees the ICMP report on the socket error =
queue
> >     and tries to connect() again, but due to the patch the socket isn't
> >     disconnected, so it gets EALREADY, and throws its hands up...
> >
> >     The error bubbles up to Vagrant which also becomes unhappy.
> >
> >     Can we skip the call to ip_icmp_error() for non-fatal ICMP errors?
> >
> > Fixes: 45af29ca761c ("tcp: allow traceroute -Mtcp for unpriv users")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Cc: Dragos Tatulea <dtatulea@nvidia.com>
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Neal Cardwell <ncardwell@google.com>
> > Cc: Shachar Kagan <skagan@nvidia.com>
> > ---
> >  net/ipv4/tcp_ipv4.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 88c83ac4212957f19efad0f967952d2502bdbc7f..a717db99972d977a64178d7=
ed1109325d64a6d51 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -602,7 +602,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
> >               if (fastopen && !fastopen->sk)
> >                       break;
> >
> > -             ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)th);
> > +             if (inet_test_bit(RECVERR, sk))
> > +                     ip_icmp_error(sk, skb, err, th->dest, info, (u8 *=
)th);
> >
> >               if (!sock_owned_by_user(sk)) {
> >                       WRITE_ONCE(sk->sk_err, err);
>
> We have a fcnal-test.sh self-test failure:
>
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2024-04-18--=
06-00&test=3Dfcnal-test-sh
>
> that I suspect are related to this patch (or the following one): the
> test case creates a TCP connection on loopback and this is the only
> patchseries touching the related code, included in the relevant patch
> burst.
>
> Could you please have a look?

Sure, thanks Paolo !

