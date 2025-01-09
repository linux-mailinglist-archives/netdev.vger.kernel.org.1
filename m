Return-Path: <netdev+bounces-156752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D72A07C92
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC82C1678A4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD76F21E0A4;
	Thu,  9 Jan 2025 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZqFplc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFC8221DA0
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437993; cv=none; b=c/n28jAesDuF1kutAzhXYJjVW66VWEXud2johQQhqbjOizFNWZ1w1dH0ZdD27HErgS0JrLpqnM3uFWxvRfov3nVDa4AGb3TT1PrO101b86yCZ8jAeMznxKFPmRiaW4Qp9cHh+S3tUiLN3dtE3xopumi3P39H25fYwxqMRVkHYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437993; c=relaxed/simple;
	bh=mxjz5KSPzu3ZUbllGez9dNdWPuH3SNSUKGLDwZP1XbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQvAkUDsjvUBW3fJW4W7cM6vspmAVinfx4h70/ckewQHGGYW1o66pmxEoYuH3xEtYB2AfEhU0CfP9grd9LFvQ86HfgGClB0VdF9X7f9tWZ5Pv53QrQDS3QHSkCjvXCErUJsKS4PpXdpBcRabS2laGRpwwFtmbhLfu6LuaokYXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZqFplc6; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a9d5a7ecc3so165ab.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 07:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736437991; x=1737042791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+KssHQqR2FaveAfqDzOq7iaLeJQWdcrD06d0jyXhfg=;
        b=dZqFplc6xGVnIF7hm56Zi/4o67R5+ObbJjcHj34yLnXpmornadSrD2hEHh6VCLO+3+
         d+Rg79xd0T0IjBsbSZ52x6mlYCNzjv8/CHCQ1JD2QiHtfgCRkemt0c1Vm0mL1A3TosOH
         1+Q39WEs30gFLPDzlu/nhHWnpy1WSH5uAB+af7kdQG8goQIw92J6BQwGUxTK+TNRDmyk
         8ky0tqbo4f8LKnnXhgAOFZYnaXENeZ5aDnls3XvlkRfjdXH4/cI1lgbzBdy04oWnFeST
         bvIqhlWZfca+LSun5XcQwfCTjPXMS/xYlqe/BDRLM0BRIIFLeFDeOOB95xzGRwQ/+kEP
         Re1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736437991; x=1737042791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+KssHQqR2FaveAfqDzOq7iaLeJQWdcrD06d0jyXhfg=;
        b=n0xPuNZliC/42LNqtfwIVCkLWUVr9lUAun59XcHaMLldYJ5AE3EOXAXl8hsHlvQxHB
         hyge8+fPuOKLxpWWGV3sF9i51MoqiVxw6rM/E4E44q0aGYwyRVHB/9zs5w7HRw2mWYaV
         bLeeb/sGdMTMQoha2UIoqHa7WQYF6qsSrua+8pfP9HhQySpg4iE2sqA5/jp1LCisO1QH
         dQki45RGR3103+6uTHCLoarqRHSzM49SWftKf2UEzrOUO/rL6nESIpnSLO0rLHZ5KYsW
         zyf9idZ1njfA4WoIO221+Qi+8D+4HcQhsbP8C4jwgi9Kjxh+6REFxgkKj19+454VXGAr
         hHKw==
X-Forwarded-Encrypted: i=1; AJvYcCUeC3n+RziRpBdJUyiAo700pv72MkxGg1gD4dkfpO31eOs/16WKgCfZMnyBS9Z+tY72e5ato/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDeDVvRRhTKs5pDDOpoNOAJ46c0lZWm02p9PntiRTOZN+PGUNN
	qi+0PItCkQXbS6IiyQk1Q4C7bC2dc++R2BumbH37xc13fvA6qNwCXff+0G+GWnaAnbP/i0KQoRW
	8Oig+zFAla1xLKupZx/LCTEeb4QJC3mAFxkEs
X-Gm-Gg: ASbGnctS1+VXjDfuvqPVz0iuv2KNANeLq98dQpsA+uUvB5QK7A/TzwHGjA32UfezT1h
	2zMQ6RPsurwYroxALvPMPuXtRM4dTADxkRbwKXw==
X-Google-Smtp-Source: AGHT+IGmizlDg74pH/H01Szxctvaw2+2vEFO9c201KH2ay5+pYZ7L489qrKrwFYnRktXGUVI3yVsXgmGIePaWWTc+wE=
X-Received: by 2002:a05:6e02:198d:b0:3a7:d682:36f6 with SMTP id
 e9e14a558f8ab-3ce53da0f5emr104555ab.0.1736437990683; Thu, 09 Jan 2025
 07:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109072245.2928832-1-yuyanghuang@google.com> <d33c8463-e3ae-46a6-a34d-ced78228c2c2@kernel.org>
In-Reply-To: <d33c8463-e3ae-46a6-a34d-ced78228c2c2@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 10 Jan 2025 00:52:33 +0900
X-Gm-Features: AbW1kvZgTsAkAIXi1eYVxjUMm194VEpzxqL9sLLrua9PzYEaSD0WdptEiKvvoSA
Message-ID: <CADXeF1F7eXj5K+rvLmRCVbi7ZoqxE8Y0b_Baqawe5P-dF8eCdw@mail.gmail.com>
Subject: Re: [PATCH net-next, v4] netlink: support dumping IPv4 multicast addresses
To: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>my comment meant that this `type` should be removed and the wrappers
>below just call the intended function. No need for the extra layers.

Sorry, I still do not fully understand the suggestions.

In the current inet_dump_ifaddr() function, there are two places where
in_dev_dump_addr() is called.

For example, we have the following code snippet.

>if (!in_dev)
>goto done;
>err =3D in_dev_dump_addr(in_dev, skb, cb, &ctx->ip_idx,
>       &fillargs);
>goto done;
>}

Do you suggest we do the following way?

> If (type =3D=3D UNICAST_ADDR)
>    err =3D in_dev_dump_ifaddr(in_dev, skb, cb, &ctx->ip_idx,
>                                             &fillargs);
> else if (type =3D=3D MULTICAST_ADDR)
>    in_dev_dump_ifmcaddr(in_dev, skb, cb, s_ip_idx,
>                                         &fillargs);

The current functional call stack is as follows:

inet_dump_ifaddr()/inet_dump_ifmcaddr() -> inet_dump_addr() ->
in_dev_dump_ifaddr()/in_dev_dump_ifmcaddr().

The ifaddr and ifmcaddr dump code paths share common logic inside
inet_dump_addr(). If we don't do the dispatching in
in_dev_dump_addr(), we have to do the dispatching in inet_dump_addr()
instead, and the dispatching logic will be duplicated twice. I don't
think this will simplify the code.

Or do you suggest I should pass a function pointer for
in_dev_dump_ifaddr()/in_dev_dump_ifmcaddr() into inet_dump_addr()?

Thanks,

Yuyang

On Fri, Jan 10, 2025 at 12:33=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 1/9/25 12:22 AM, Yuyang Huang wrote:
> > @@ -1889,15 +1935,16 @@ static u32 inet_base_seq(const struct net *net)
> >       return res;
> >  }
> >
> > -static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callba=
ck *cb)
> > +static int inet_dump_addr(struct sk_buff *skb, struct netlink_callback=
 *cb,
> > +                       enum addr_type_t type)
> >  {
> >       const struct nlmsghdr *nlh =3D cb->nlh;
> >       struct inet_fill_args fillargs =3D {
> >               .portid =3D NETLINK_CB(cb->skb).portid,
> >               .seq =3D nlh->nlmsg_seq,
> > -             .event =3D RTM_NEWADDR,
> >               .flags =3D NLM_F_MULTI,
> >               .netnsid =3D -1,
> > +             .type =3D type,
>
> my comment meant that this `type` should be removed and the wrappers
> below just call the intended function. No need for the extra layers.
>
> >       };
> >       struct net *net =3D sock_net(skb->sk);
> >       struct net *tgt_net =3D net;
> > @@ -1949,6 +1996,20 @@ static int inet_dump_ifaddr(struct sk_buff *skb,=
 struct netlink_callback *cb)
> >       return err;
> >  }
> >
> > +static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callba=
ck *cb)
> > +{
> > +     enum addr_type_t type =3D UNICAST_ADDR;
> > +
> > +     return inet_dump_addr(skb, cb, type);
> > +}
> > +
> > +static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_call=
back *cb)
> > +{
> > +     enum addr_type_t type =3D MULTICAST_ADDR;
> > +
> > +     return inet_dump_addr(skb, cb, type);
> > +}
> > +
> >  static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghd=
r *nlh,
> >                     u32 portid)
> >  {
>

