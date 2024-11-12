Return-Path: <netdev+bounces-144116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A8B9C59EA
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED45A1F247D4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D1B1FBF4A;
	Tue, 12 Nov 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KhGwc7+g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439D1C9DD8
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420430; cv=none; b=RovQESU0i8Lvie1ROnHlUBLP4qqpfQEW/spgK22avHM+KEO8Acae3lBN6N20ztI+GC2Fljh8nBMg5fSVA1ICHnD2WKaNZSUNCYR+w/1G1qw4TU3SN3+gDPbL8Je8rzwxRqx3EtpBLGK8CTr78RhS5+ZyS4CJomyy1OGsw1PJaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420430; c=relaxed/simple;
	bh=qTsla8LPOl1ORhhmeCSUDNcsXytpPGCWMoGv0QO842A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrSweHh6+4RsM84NFlV5i+K2o2fhNYAMK1CuqgMQrU/NBnpmaMPu1YblyyRvGVzWPsfpk8SHw//6+uu2pvbv135zjAOdALQd1VYf2t0z5IaUygoimQYWeZCgsKj8dXtBc/5mVs5MrvWQjRcZdtdIP4mKLFyApkXZWC0ul/kH7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KhGwc7+g; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e64ed090so2e87.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 06:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731420427; x=1732025227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFcu87aTk7oxCRyGC6lP4oXiqxSRfvuQlxxADDN6tpk=;
        b=KhGwc7+ggFdxRWkRTzDm5qbpdBoBvQPBc6ur9TS8hcMUQciwxfgQkQsT7/XKfNvJd9
         WDneFRCF9DCxJjhPgbKb2VmRTbCNoncThR7vr2Zoc8RThHK5mbj468u99kb/7QxVLLd6
         xcOS22ff49mMfWBFmFkzr6RB10rIrn1DVfiNCjep/+jm05l45dG6kDGQ8sS+DSF8QW+j
         0IZmoQNvM/tVlaXAGECXV8b/Zk1VSvNSXrpdRfSsPPA7JdqC2amRzu0+xt5NLCff217f
         /FMvjF3SmN1n0yB3gC7WPwN+7beobl9MIkfmtKtxATmIzmrl2BR+BuxZu3f8VNgYATF/
         nYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731420427; x=1732025227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFcu87aTk7oxCRyGC6lP4oXiqxSRfvuQlxxADDN6tpk=;
        b=WhRXfPUmhkM8BRQGYKSIycujtr3McHHO3W9yek0YgmOpAV77TWVUlhtYH7/+znzG04
         agt6KNAK8R3ml75jy05VolsA9ry/x1SEbmILAZf8SU26liy4WbevNdaz7K0yeJMTR087
         eY0HZUZI3CZMQ5y+TwV7+3VRkidGlHS193oIKbeqeocXCXafpbxi7dyKt8s2u6FWBMP6
         Xpr6DCiY1p1S1KiwOzGBJGgc1naigIrgVSF62Pnv8Y1WM87SzPC2aw7ekERVjHcr6bal
         x2XFfRyZWRDHBOHFY0sz4lMJyhI3gkffcJJbFGL5XdtRVlPAYRWFpYHXnQ3YDZuck189
         bHHw==
X-Forwarded-Encrypted: i=1; AJvYcCXASH5c7y62lieEn+XCEOYWdz2eOYVN/LopEIl/ubDWEE/BCYs/XfU1BIXEtCqu+mIXUm+BFx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKI8btyN3/SproESzhu7VedSiK8TvytAe5NQR7hMTT3ru6iYPj
	zThCWz/d50om6FyI0p9FEDa5MLIAb3emQW3pB/snB9f+eq0BgRSlBybeyK5hT/aPTdhAFzxY4Ni
	6MjuQkwUl39ueQYDcXwKB90RWbnfPJjTm4TDWIF2ITsdPMM8Ptr2KWj4=
X-Gm-Gg: ASbGncs8yfzJotaXM7S6/8pjZIhik/LTQbdNUWlYIiBhaBnpP9BDoFyvCCyE+S9+Kdz
	m2yw58733pQAMxgEm1sxW5ewY9ZyNIb8=
X-Google-Smtp-Source: AGHT+IFQJN8HG4FLV3m3BjcJTPGcJS7bxbu2MQdU1Pfc3qBtElPHOR+Gi0VbWAeUVdE77EGRdjf+G/95bsB+VUuWZLE=
X-Received: by 2002:ac2:5e21:0:b0:539:dd63:72e8 with SMTP id
 2adb3069b0e04-53d9f0cab4cmr61e87.2.1731420425282; Tue, 12 Nov 2024 06:07:05
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110081953.121682-1-yuyanghuang@google.com> <ef98012b-559c-42fc-831f-d8f54ca65b1b@6wind.com>
In-Reply-To: <ef98012b-559c-42fc-831f-d8f54ca65b1b@6wind.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 12 Nov 2024 23:06:27 +0900
Message-ID: <CADXeF1HSL5pSHdvPgf7YmONdtZUe0Uv1nMiutmoNzKYu2Zh=jQ@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: add igmp join/leave notifications
To: nicolas.dichtel@6wind.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> These names are misleading, they are very generic, but in fact, specializ=
ed to igmp.
> Are there plans to add more notifications later?
> What about ipv6?

I plan to add MLD support as well. The
RTM_NEWMULTICAST/RTM_DELMULTICAST can be used for monitoring both IPv4
and IPv6 multicast addresses. As it was brought up now, I will send a
v2 patch later to include the MLD change.

>The RTM_GETMULTICAST works only for with IPv6 and the NEW/DEL will work fo=
r IPv4

I plan to make igmp.c support RTM_GETMULTICAST as well, maybe in a
different patch series. In this case, it can be used to dump both IPv4
and IPv6 multicast addresses. After adding RTM_GETMULTICAST support
for IPv4, I'll migrate 'ip maddr' to use netlink instead of parsing
procfs to dump IPv4/v6 multicast addresses.

Thanks,
Yuyang

On Tue, Nov 12, 2024 at 10:45=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 10/11/2024 =C3=A0 09:19, Yuyang Huang a =C3=A9crit :
> > This change introduces netlink notifications for multicast address
> > changes, enabling components like the Android Packet Filter to implemen=
t
> > IGMP offload solutions.
> >
> > The following features are included:
> > * Addition and deletion of multicast addresses are reported using
> >   RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET.
> > * A new notification group, RTNLGRP_IPV4_MCADDR, is introduced for
> >   receiving these events.
> >
> > This enhancement allows user-space components to efficiently track
> > multicast group memberships and program hardware offload filters
> > accordingly.
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> > Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> > Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.at=
t-mail.com
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > ---
> >  include/uapi/linux/rtnetlink.h |  6 ++++
> >  net/ipv4/igmp.c                | 58 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetl=
ink.h
> > index 3b687d20c9ed..354a923f129d 100644
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
> These names are misleading, they are very generic, but in fact, specializ=
ed to igmp.
>
> Are there plans to add more notifications later?
> What about ipv6?
>
> >       RTM_GETMULTICAST =3D 58,>  #define RTM_GETMULTICAST RTM_GETMULTIC=
AST
> The RTM_GETMULTICAST works only for with IPv6 and the NEW/DEL will work f=
or IPv4
> only.
>
> Regards,
> Nicolas
>
> >
> > @@ -774,6 +778,8 @@ enum rtnetlink_groups {
> >  #define RTNLGRP_TUNNEL               RTNLGRP_TUNNEL
> >       RTNLGRP_STATS,
> >  #define RTNLGRP_STATS                RTNLGRP_STATS
> > +     RTNLGRP_IPV4_MCADDR,
> > +#define RTNLGRP_IPV4_MCADDR  RTNLGRP_IPV4_MCADDR
> >       __RTNLGRP_MAX
> >  };
> >  #define RTNLGRP_MAX  (__RTNLGRP_MAX - 1)

