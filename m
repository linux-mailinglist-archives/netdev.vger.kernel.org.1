Return-Path: <netdev+bounces-145836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8C89D11B3
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F935283E46
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECC519994F;
	Mon, 18 Nov 2024 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AeMOGxM8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805638B
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936042; cv=none; b=kN4t1pU6m3htZCwqgUbRr/Ml7p7vEQJjL2irMdsPaF5VgIhYhLhzaeYwyvytLBk0GhQe2cp3p9PonVty379wt7JSII97IO9WG2RAvo1HZ0pOwPgixfVchzZvjETFXt3NEbPbVTk5QmN5u8Pf57gGPkxMSBphQfkAsVLwGWet8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936042; c=relaxed/simple;
	bh=3ysRUl+PVKUYXViDkyvStAguMgORpb59fTxQXyQSLiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwnVk5GauHQeflp52qt5uG+/LmtdF5NzSoMLzVI7ytuj49/RnHjfcyJlZybH5bJDpeyUtJGtQcRRINf9zgJUOPZVMWu6kdIYmSbxtKiC3tPOqWWizG+AOxPSkdSn6r2aUw9YY0CocMX9tAjfh3DCpZ1HSKya/DDor/ty/BgPp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AeMOGxM8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e044d4f7so10e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 05:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731936039; x=1732540839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq7C1iowpqdNPjDCtVSBZi9R0WMWqVOUt4R6+QJevj8=;
        b=AeMOGxM8qt80wiedkaQ1MFzJvSRivoAwaRQKb5u4P+rO9ua8KY1SenSuPWW5Dtx2Cq
         NaYu4bQJ2D4MYcY6egbLZbI2VJlSpA6SsEmege/KxV9F22JkKRSZG6hBOIsk/JFexG6J
         ZzacUQ8WyPkciPxt5vAAewd4FjtUbL47p2PW7gSANcmJ3GoYcPCOMwmqFE7Zgggs3GPN
         GVaSqcbSqbowEICJcINNnMOJBHyhnOHGviEehksg6Ul7yf48mKI1CubGOHBvqDRY3EzZ
         EAuFpjCl96cxyzHXlCiuavnEjBru1bY3/fq7SDqJ6E6KFnWPgwNUVV6S9t64PsF4Ludl
         CJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731936039; x=1732540839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq7C1iowpqdNPjDCtVSBZi9R0WMWqVOUt4R6+QJevj8=;
        b=ZfvaAdcL4lr9IZkSDYtsyiA2reoG5d9RBj/9HpepaqjKxYQta7R84/DJ2TsDqQCyLR
         9piqG2HCqWhFaTn9WJaZhS0mniyAP7wygrNTUMQenPJcq5BepRSpsa+Sypla5r3kxy4I
         M/9zDpGvXbRdFzn4GyPaXb49pwForikcHIWyLOQTy+Q4TlRB4xqeLlSvYmR6lg6cKQz5
         DK7cT9rGtwiwKbM/vsfYgYgbOEY7G+MG/ai02qse2zml8bs+CGPTVh+Q4wyh0GXmTV6u
         jM1dfXGJyCAzh/rKNPsHGFnZrecCSxC9OFJr1mDkLoDoAFOm1sw+gAazI3U78z/rGy/e
         sYtA==
X-Forwarded-Encrypted: i=1; AJvYcCWVy2D64OUzyrKF5B3R0yHT0R+AFPGUXciNgdXw2S50O9p+SHzVjgTNEGkoAdb5kCnVpZ4WNfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxenAJk77dgqkma7zmxJmbaIBuHHKfCpUPGqIdtKgS/lIPyvUNp
	9UMLBMYpzw/Ch9uQ34/XBFUi8HjAgurUpoN65SpQwzJ8Ffc29PY4/em1RlC57i38Vb19LCmGHn1
	wHSeQsNAOHSfBSb7cpqCjVf3ZE2U6dmWcC/jA
X-Gm-Gg: ASbGncv3iUZaQyJlNFMPKwDkHsKNU157IloOSfnnMAacumw7zF1OCPyb4E9Qg/JLiCw
	n7Hhkzq3nreJmoa2wfDBRwDXTCCOm1JM0cgN1JfoZ/pEqpOCah9EH+g234LTexcV9
X-Google-Smtp-Source: AGHT+IECQfdOKRsGi2JqcxQRONDOfhdCeIRY3lpwghNhN8WCCOEWCHPGJeUO+4XPScuMgljcLZBFhWe7l5r4FtGBv78=
X-Received: by 2002:a19:5f47:0:b0:53d:a866:ff6e with SMTP id
 2adb3069b0e04-53dbc3bb642mr3120e87.2.1731936038436; Mon, 18 Nov 2024 05:20:38
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117141655.2078777-1-yuyanghuang@google.com> <Zzs0xDi-3jdQSuk0@fedora>
In-Reply-To: <Zzs0xDi-3jdQSuk0@fedora>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Mon, 18 Nov 2024 22:19:59 +0900
Message-ID: <CADXeF1GqzSWYmSFO3v6x7+KTc=Q+U9hUiTd+x5yvZaViSKSkOQ@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] iproute2: add 'ip monitor mcaddr' support
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the prompt review feedback.

>No need changes for headers. Stephen will sync the headers.

The patch will not compile without the header changes. I guess that
means I should put the patch on hold until the kernel change is merged
and the header changes get synced up to iproute2?

>The rtnl_add_nl_group() should be aligned with the upper bracket. e.g.

> Same with this one.

Acked, will fix the alignment in version 2.

Thanks,
Yuyang

Thanks,
Yuyang


On Mon, Nov 18, 2024 at 9:36=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> On Sun, Nov 17, 2024 at 11:16:55PM +0900, Yuyang Huang wrote:
> > Enhanced the 'ip monitor' command to track changes in IPv4 and IPv6
> > multicast addresses. This update allows the command to listen for
> > events related to multicast address additions and deletions by
> > registering to the newly introduced RTNLGRP_IPV4_MCADDR and
> > RTNLGRP_IPV6_MCADDR netlink groups.
> >
> > This patch depends on the kernel patch that adds RTNLGRP_IPV4_MCADDR
> > and RTNLGRP_IPV6_MCADDR being merged first.
> >
> > Here is an example usage:
> >
> > root@uml-x86-64:/# ip monitor mcaddr
> > 8: nettest123    inet6 mcast ff01::1 scope global
> > 8: nettest123    inet6 mcast ff02::1 scope global
> > 8: nettest123    inet mcast 224.0.0.1 scope link
> > 8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
> > Deleted 8: nettest123    inet mcast 224.0.0.1 scope link
> > Deleted 8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
> > Deleted 8: nettest123    inet6 mcast ff02::1 scope global
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > ---
> >  include/uapi/linux/rtnetlink.h |  8 ++++++++
> >  ip/ipaddress.c                 | 17 +++++++++++++++--
> >  ip/ipmonitor.c                 | 25 ++++++++++++++++++++++++-
> >  3 files changed, 47 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetl=
ink.h
> > index 4e6c8e14..ccf26bf1 100644
> > --- a/include/uapi/linux/rtnetlink.h
> > +++ b/include/uapi/linux/rtnetlink.h
> > @@ -93,6 +93,10 @@ enum {
> >       RTM_NEWPREFIX   =3D 52,
> >  #define RTM_NEWPREFIX        RTM_NEWPREFIX
> >
> > +     RTM_NEWMULTICAST,
> > +#define RTM_NEWMULTICAST RTM_NEWMULTICAST
> > +     RTM_DELMULTICAST,
> > +#define RTM_DELMULTICAST RTM_DELMULTICAST
> >       RTM_GETMULTICAST =3D 58,
> >  #define RTM_GETMULTICAST RTM_GETMULTICAST
> >
> > @@ -772,6 +776,10 @@ enum rtnetlink_groups {
> >  #define RTNLGRP_TUNNEL               RTNLGRP_TUNNEL
> >       RTNLGRP_STATS,
> >  #define RTNLGRP_STATS                RTNLGRP_STATS
> > +     RTNLGRP_IPV4_MCADDR,
> > +#define RTNLGRP_IPV4_MCADDR  RTNLGRP_IPV4_MCADDR
> > +     RTNLGRP_IPV6_MCADDR,
> > +#define RTNLGRP_IPV6_MCADDR    RTNLGRP_IPV6_MCADDR
> >       __RTNLGRP_MAX
> >  };
> >  #define RTNLGRP_MAX  (__RTNLGRP_MAX - 1)
>
> No need changes for headers. Stephen will sync the headers.
>
> > @@ -220,6 +226,8 @@ int do_ipmonitor(int argc, char **argv)
> >                       lmask |=3D IPMON_LNEXTHOP;
> >               } else if (strcmp(*argv, "stats") =3D=3D 0) {
> >                       lmask |=3D IPMON_LSTATS;
> > +             } else if (strcmp(*argv, "mcaddr") =3D=3D 0) {
> > +                     lmask |=3D IPMON_LMCADDR;
> >               } else if (strcmp(*argv, "all") =3D=3D 0) {
> >                       prefix_banner =3D 1;
> >               } else if (matches(*argv, "all-nsid") =3D=3D 0) {
> > @@ -326,6 +334,21 @@ int do_ipmonitor(int argc, char **argv)
> >               exit(1);
> >       }
> >
> > +     if (lmask & IPMON_LMCADDR) {
> > +             if ((!preferred_family || preferred_family =3D=3D AF_INET=
) &&
> > +                     rtnl_add_nl_group(&rth, RTNLGRP_IPV4_MCADDR) < 0)=
 {
>
> The rtnl_add_nl_group() should be aligned with the upper bracket. e.g.
>
>                 if ((!preferred_family || preferred_family =3D=3D AF_INET=
) &&
>                     rtnl_add_nl_group(&rth, RTNLGRP_IPV4_MCADDR) < 0) {
>
> > +                     fprintf(stderr,
> > +                             "Failed to add ipv4 mcaddr group to list\=
n");
> > +                     exit(1);
> > +             }
> > +             if ((!preferred_family || preferred_family =3D=3D AF_INET=
6) &&
> > +                     rtnl_add_nl_group(&rth, RTNLGRP_IPV6_MCADDR) < 0)=
 {
>
> Same with this one.
>
> Thanks
> Hangbin

