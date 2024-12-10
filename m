Return-Path: <netdev+bounces-150482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A0D9EA680
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D3F1886C5D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC221D14F8;
	Tue, 10 Dec 2024 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axGsELfz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84C13AC1
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733800791; cv=none; b=lu3ATEWNq5yxQCosjKjx9GAFmT4OoK+fezCoPRuldw6PGMufDaM9DmFShqEttR7dhK4orkArXsWZ6d5tLitxC7MaqNEvh9oOdedz+y/T8mDr2cctaLlt4a8yh57PAonBDUjAYbx/ow2DBPFGNPtQ8Ks+b9qj3EywS5bghQq6sdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733800791; c=relaxed/simple;
	bh=yZSUu3NhQ6TkeyLVdduJYesMCzYR7JNuzaedH9WQ3wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwmIe4Ir2MCCGBuEOR+84KwxipaAuN3AY0bm1et3AfU/Q2QEwubaW/GfB/hg9DYoMhbtD3p7agGYoFQBhTNUkaBKw0KQCcuGukvJj5sHdkFpCrVMnXaeWP8ZHX9LtuC+bzPjAMlEhIhvUX8gWJC+ZSOtxtNCPlBl2GilHjk6QOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axGsELfz; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a818cd5dcbso45ab.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 19:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733800789; x=1734405589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORV3C71NfwwDOP1nJ8oPNj5FGFt76Tos2xi6RUO+x3s=;
        b=axGsELfzTjDctJ4DPNU+H2lKxKlHAUR42E6s8xDLXk6w/sBnSLHSujWMfogbyIhxDS
         9aqiDrkwyzZA4BjqiAzPIoRI0q/m264mGTzGN66aKv7N/XFQ2zrZrFRKcGkkZXNYJiKP
         dCQcHqF8ypFninyQhgWqiIZely3ZFXWeVtK1fzoWYXi2QiYAVBhPPLgxAMZA4gqrxmRN
         fRHsKMSWECfETfZEid4EbpKSX63FmcYh/bKpix/cciP8Xh4yWmbvdFlVx+JwwlkQQQd6
         D/Ku0P6neks4JQZUO6OpothxKHqiF9ui4z0BhtiYR5lc+6ZJiop9lb/08egYzUVY7cI1
         vd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733800789; x=1734405589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORV3C71NfwwDOP1nJ8oPNj5FGFt76Tos2xi6RUO+x3s=;
        b=d+U7mMB+DAVMEjrr2GljRTPRN8PMGAvI3iy+cIHe/xBNeU6r+ocMduugoY3SSd63mF
         z6bhuiumjGSZtyy/Zak8DNIL0zYyvRhnPJ3g6Bm8F2SF4oaOn8LXCX00M57SsfN8I9Hb
         aevH059UcwhsFg85NsaW9lbvnv1npgYzoc4TDHHChaWo40u1R3duULAGMfZLm/mm0LNY
         OiJrBagibaKmZ3doFwu5MWd/OBN2L4Kbo2iRPQiUVYjAqkg+e78qc8BZsrSPeOBeq27Z
         xI/8wAjaO/OJuOgc1Huaec2iRRWG4v50DMlMLQogY8z/q8RIAUYD3gBIQBfQwErZf7ts
         KZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcW0qinpkrKWMaNlbj8fzZ84O/1PSi/VRS9nNt/LI8DJkvpHMZud2dcR0eudcKyVTPQq4fKoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlhWVGQ7peAIv7VQehgL+FTI0rkGnLBBNFHJk7eftABqGeqgy9
	zZc0KY3251vQ0uykBJ9wlY+dkHd96YwsUFq7B27KdyIMjenTpKDFNQWnlxoWhXdZP39UPwJANL4
	FCYy02W0U7QjiwGELt9RUIY0n9ODqS8ckVMyw
X-Gm-Gg: ASbGncv3jCN8ZzLcjzaw+m7nT3ZDD65lAvAI1Yo1n0oVYLxETbFJeBXkb1RDJWzCMTE
	xjKsALMbygQRBUnmw+QhfOZQuZDf4Yv5t1WpM8ID92xi2OcU8lXNJnaL34j4BOlymO78=
X-Google-Smtp-Source: AGHT+IGIjRqDdznbz7vV7Nmyg4tG1Q6u3t22USO6PLu1trSMvx+daaLJ5Mk8glXZ/rT/gp+fCEZNYJ0Ni3Mn4xrzr4o=
X-Received: by 2002:a92:c568:0:b0:3a7:c82d:e64b with SMTP id
 e9e14a558f8ab-3a9e0d39dedmr59005ab.1.1733800788374; Mon, 09 Dec 2024 19:19:48
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206041025.37231-1-yuyanghuang@google.com> <20241209182549.271ede3a@kernel.org>
In-Reply-To: <20241209182549.271ede3a@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 10 Dec 2024 12:19:11 +0900
X-Gm-Features: AbW1kvaC6JzL3NSTKk7lLYQKqVTwvBdPMjpsxgq5vS4ds-4jPhvW5mKgix7BSPI
Message-ID: <CADXeF1FNGMxBHV8_mvU99Xjj-40BcdG44MtbLNywwr1X8CqHkw@mail.gmail.com>
Subject: Re: [PATCH net-next, v5] netlink: add IGMP/MLD join/leave notifications
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review feedback.

>Is there a strong reason you reimplement this instead of trying to reuse
>inet6_fill_ifmcaddr() ? Keeping notifications and get responses in sync
>used to be a thing in rtnetlink, this code already diverged but maybe
>we can bring it back.

In order to reuse the `inet6_fill_ifmcaddr()` logic, we need  move the
function and `struct inet6_fill_args` definition into
`net/core/rtnetlink.c` and `include/net/rtnetlink.h`. Is this approach
acceptable?

In this patch, we will always set `ifa_scope` to `RT_SCOPE_UNIVERSE`
for both IPv4 and IPv6 multicast addresses for consistency. Reusing
`inet6_fill_ifmcaddr()` will revert to the following logic:

>u8 scope =3D RT_SCOPE_UNIVERSE;
>struct nlmsghdr *nlh;
>if (ipv6_addr_scope(&ifmca->mca_addr) & IFA_SITE)
scope =3D RT_SCOPE_SITE;

Is it acceptable, or should I update the old logic to always set
=E2=80=98RT_SCOPE_UNIVERSE=E2=80=99?

>ENOMEM ? I could be wrong but in atomic context the memory pressure
>can well be transient, it's not like the socket queue filled up.

Will update in the next patch version.

>nit: + goes to the end of previous line

Will update in the next patch version.

>nit: nlmsg_free(), since it exists

Will update in the next patch version.

Thanks,
Yuyang


On Tue, Dec 10, 2024 at 11:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri,  6 Dec 2024 13:10:25 +0900 Yuyang Huang wrote:
> > +static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct net_device =
*dev,
> > +                            const struct in6_addr *addr, int event)
> > +{
> > +     struct ifaddrmsg *ifm;
> > +     struct nlmsghdr *nlh;
> > +
> > +     nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
> > +     if (!nlh)
> > +             return -EMSGSIZE;
> > +
> > +     ifm =3D nlmsg_data(nlh);
> > +     ifm->ifa_family =3D AF_INET6;
> > +     ifm->ifa_prefixlen =3D 128;
> > +     ifm->ifa_flags =3D IFA_F_PERMANENT;
> > +     ifm->ifa_scope =3D RT_SCOPE_UNIVERSE;
> > +     ifm->ifa_index =3D dev->ifindex;
> > +
> > +     if (nla_put_in6_addr(skb, IFA_MULTICAST, addr) < 0) {
> > +             nlmsg_cancel(skb, nlh);
> > +             return -EMSGSIZE;
> > +     }
> > +
> > +     nlmsg_end(skb, nlh);
> > +     return 0;
> > +}
>
> Is there a strong reason you reimplement this instead of trying to reuse
> inet6_fill_ifmcaddr() ? Keeping notifications and get responses in sync
> used to be a thing in rtnetlink, this code already diverged but maybe
> we can bring it back.
>
> > +static void inet6_ifmcaddr_notify(struct net_device *dev,
> > +                               const struct in6_addr *addr, int event)
> > +{
> > +     struct net *net =3D dev_net(dev);
> > +     struct sk_buff *skb;
> > +     int err =3D -ENOBUFS;
>
> ENOMEM ? I could be wrong but in atomic context the memory pressure
> can well be transient, it's not like the socket queue filled up.
>
> > +     skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg))
> > +                     + nla_total_size(16), GFP_ATOMIC);
>
> nit: + goes to the end of previous line
>
> > +     if (!skb)
> > +             goto error;
> > +
> > +     err =3D inet6_fill_ifmcaddr(skb, dev, addr, event);
> > +     if (err < 0) {
> > +             WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
> > +             kfree_skb(skb);
>
> nit: nlmsg_free(), since it exists
>
> > +             goto error;
> > +     }
> > +
> > +     rtnl_notify(skb, net, 0, RTNLGRP_IPV6_MCADDR, NULL, GFP_ATOMIC);
> > +     return;
> > +error:
> > +     rtnl_set_sk_err(net, RTNLGRP_IPV6_MCADDR, err);
> > +}
> > +
> --
> pw-bot: cr

