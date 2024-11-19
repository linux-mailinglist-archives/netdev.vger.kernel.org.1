Return-Path: <netdev+bounces-146161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94B39D2266
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509101F228AF
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E2219D8AC;
	Tue, 19 Nov 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQQs/lGG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374B199EAD
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008141; cv=none; b=IgYrq0/4ITgCsE4lD5CZgT0GWAFPhFkbry4Izb2Z6TlWROAP95qDIP2+fYV3zP+RwQsDTXk+p7Jtr0iKMNUxiYB+QAeviDX76MfCUJDVl+yKEFTUryjzHHdugtA4EjOW6TnFZ0iKhBBtgb7IGGFDe80qDWATSMLYiG4eOhIXosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008141; c=relaxed/simple;
	bh=fceHBG+X2UvRjBjCIsgvbxZ9WnEIjCTyT91cqSLZzVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCzt0AfVQaehzqj520JdmUi9rW8d5b+PT72/tF/IafBof0zee/wH13/KcxU3SGIPVm99tYxEKfEqipHdAlBfSHjxblrCt9K93JKTpQGU5+j9FwEOfKikc+CQqLIOzA7dJiOePeGP3f+MTa37LQWTJ9PK3SMiSc7DHYzaKl8HIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VQQs/lGG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e64ed090so3e87.1
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 01:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732008138; x=1732612938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZGge2oSrz74lJ2XqbgtrMjv2pUp4AiCFkma9PNCogA=;
        b=VQQs/lGGxA2N9IOK+b2fSkafXp9IJ8kEmDYiFvuziQJ63p+p2IPQU/ydHZ0D1rDxRu
         gr7M0UDgjnFuK7+PePepJzBJAcraFF7UJx67mu6guSHe4TAb07ykyzml/x0TMDOU9wZh
         C92qQL5dlKCf58zhQgrW+KfCQBi2wnhilLAl91FtCOgqr2nKRcZKMPHweKkv8E82Gy3o
         TkqxpCFVj9vBexIGqVepVfatjdba3FOYnEc7IKVEOYym8wcMqGbqAFMZh9E+AGPVHiHW
         uWJSJMVfZ8BP/c48G6pETppeEeONgQBk8l6Iy4OXseOzTtIusdnyce68ikmKm2CSfe5R
         T6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732008138; x=1732612938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZGge2oSrz74lJ2XqbgtrMjv2pUp4AiCFkma9PNCogA=;
        b=Uqtvu3SZsoWYn34udmmL14ig3W0NjmTeNMgouLENTi4PJoHS6+UIIZ+PmyaKFhJ4W1
         a5UkD8ziL3OT985BwZu9zUT0i7PtKlWlS8tCI1WyMlhbtEvR26UEWdAdBsuQZDu8Dobc
         PTyoKhSH7Qe3Km3gqdtMZe/lUrkXlccG9+/flYeyQnHWkCnlf+8I78X/3NH7AhSX/0mF
         LZRzg3OhYsKJkdAhkEPeYJ6Ip30In5gsRkK/avaJ63AGGa8cXr50Wfht4fQFUmi+EnvZ
         U20ZbJtbHXu3EVPV83oap6iGHJuC98yWJoec0RQ6XqbBsiuV5UwHID8v9gHl1qZCveoO
         JQcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy7Mg6n+oE5Wz+IdYGpoZMG7C9KRirnYcYlNjAge2Ur6bYQiK159ep4rs8ITNQ5x/XDvhlh68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+V9P1xyqTY03v4eA98uGWqGNr9DyLU/Jtt3S7VcRdqWtekaHO
	ECY0x47oDzufl+QS5zefKI4NXvKZwPPIJqiKuenkQ4MIF/E4mhZE9gH/E4MDcqI0aFq/Gh5NyGM
	xfxkEWfLY41jxQGSJBVbiBW2cwVGQpro7C0pt
X-Gm-Gg: ASbGncvMorER/j7NO/9Sc6qKRpAJAZFs6Tte8j8b08gpyeUr9eKN8dl5BdHZbRxRV2o
	Nx5BsVNz3u8LkCo5ALSfN9aIE/RzBk7aBnn/9qJ+rQPSe6O1kyXtXkWtk3kvetg==
X-Google-Smtp-Source: AGHT+IHk1jZ3UBUvPXEVuhDJpKcI8fg2iN9a0VPw8aqiyZDZiC8DZKXfiTozgOoz4bmNpdIlS7WXZ4l6JLgoIfBqtCY=
X-Received: by 2002:a19:ad0d:0:b0:53d:be11:5fca with SMTP id
 2adb3069b0e04-53dbf8985f0mr8e87.1.1732008135454; Tue, 19 Nov 2024 01:22:15
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117141137.2072899-1-yuyanghuang@google.com> <ZzxAqq-TqLts1o4V@fedora>
In-Reply-To: <ZzxAqq-TqLts1o4V@fedora>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 19 Nov 2024 18:21:38 +0900
Message-ID: <CADXeF1GEzTO4BuVnci0Vvorah+vCcrTZR9EE3ohQrN_TKnfL0A@mail.gmail.com>
Subject: Re: [PATCH net-next, v2] netlink: add IGMP/MLD join/leave notifications
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hangbin

Thanks for the review feedback.

>Why the IPv4 scope use RT_SCOPE_LINK,

I'm unsure if I'm setting the IPv4 rt scope correctly.

I read the following document for rtm_scope:

```
/* rtm_scope

   Really it is not scope, but sort of distance to the destination.
   NOWHERE are reserved for not existing destinations, HOST is our
   local addresses, LINK are destinations, located on directly attached
   link and UNIVERSE is everywhere in the Universe.

   Intermediate values are also possible f.e. interior routes
   could be assigned a value between UNIVERSE and LINK.
*/
```

I believe RT_SCOPE_LINK is the closest match to the use case. IGMP
packets have a TTL of 1, so they are not forwarded to other networks.

I saw the RT_SCOPE_LINK was chosen in the original patch so I followed
the same pattern.

Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.att-ma=
il.com

Please kindly advise here if we have more proper logic.

>And IPv6 use RT_SCOPE_UNIVERSE by default?

Since IPv6 provides the `static inline int ipv6_addr_scope(const
struct in6_addr *addr)` helper function, we should utilize it to
correctly determine the address scope. We have the logic like follows
in addrconf.c to determine the rt_scope.

```
static inline int rt_scope(int ifa_scope)
{
    if (ifa_scope & IFA_HOST)
       return RT_SCOPE_HOST;
    else if (ifa_scope & IFA_LINK)
        return RT_SCOPE_LINK;
    else if (ifa_scope & IFA_SITE)
        return RT_SCOPE_SITE;
    else
        return RT_SCOPE_UNIVERSE;
}

```

However, I found the addrconf.c:inet6_fill_ifmcaddr() is using the
following logic so I am trying to make the notification logic
consistent with dump logic.

Maybe we should update `inet6_fill_ifmcaddr()` to use
`ipv6_addr_scope()` to determine the scope properly?

```
static int inet6_fill_ifmcaddr(struct sk_buff *skb,
                  const struct ifmcaddr6 *ifmca,
                  struct inet6_fill_args *args)
{
    int ifindex =3D ifmca->idev->dev->ifindex;
    u8 scope =3D RT_SCOPE_UNIVERSE;
    struct nlmsghdr *nlh;
    if (ipv6_addr_scope(&ifmca->mca_addr) & IFA_SITE)
        scope =3D RT_SCOPE_SITE;
```


In general, I am not sure if the scope information is truly necessary
for IPv4 and IPv6 multicast notifications. In my experience, only the
address itself is needed.  The `ip maddr` command also omits scope.
Perhaps I'm missing some use cases where scope is essential.

>Not sure if we really need this WARN_ON. Wait for others comments.

I try to follow the existing code pattern in addrconf.c; for example:

```
err =3D inet6_fill_ifaddr(skb, ifa, &fillargs);
if (err < 0) {
    /* -EMSGSIZE implies BUG in inet6_ifaddr_msgsize() */
    WARN_ON(err =3D=3D -EMSGSIZE);
    kfree_skb(skb);
    goto errout_ifa;
}
```

Thanks,
Yuyang

On Tue, Nov 19, 2024 at 4:39=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> Hi Yuyang,
> On Sun, Nov 17, 2024 at 11:11:37PM +0900, Yuyang Huang wrote:
> > +static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *=
dev,
> > +                           __be32 addr, int event)
> > +{
> > +     struct ifaddrmsg *ifm;
> > +     struct nlmsghdr *nlh;
> > +
> > +     nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
> > +     if (!nlh)
> > +             return -EMSGSIZE;
> > +
> > +     ifm =3D nlmsg_data(nlh);
> > +     ifm->ifa_family =3D AF_INET;
> > +     ifm->ifa_prefixlen =3D 32;
> > +     ifm->ifa_flags =3D IFA_F_PERMANENT;
> > +     ifm->ifa_scope =3D RT_SCOPE_LINK;
>
> Why the IPv4 scope use RT_SCOPE_LINK,
>
> > +static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct net_device =
*dev,
> > +                            const struct in6_addr *addr, int event)
> > +{
> > +     struct ifaddrmsg *ifm;
> > +     struct nlmsghdr *nlh;
> > +     u8 scope;
> > +
> > +     scope =3D RT_SCOPE_UNIVERSE;
> > +     if (ipv6_addr_scope(addr) & IFA_SITE)
> > +             scope =3D RT_SCOPE_SITE;
>
> And IPv6 use RT_SCOPE_UNIVERSE by default?
>
> > +
> > +     nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
> > +     if (!nlh)
> > +             return -EMSGSIZE;
> > +
> > +     ifm =3D nlmsg_data(nlh);
> > +     ifm->ifa_family =3D AF_INET6;
> > +     ifm->ifa_prefixlen =3D 128;
> > +     ifm->ifa_flags =3D IFA_F_PERMANENT;
> > +     ifm->ifa_scope =3D scope;
> > +     ifm->ifa_index =3D dev->ifindex;
> > +
> > +static void inet6_ifmcaddr_notify(struct net_device *dev,
> > +                               const struct in6_addr *addr, int event)
> > +{
> > +     struct net *net =3D dev_net(dev);
> > +     struct sk_buff *skb;
> > +     int err =3D -ENOBUFS;
> > +
> > +     skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg))
> > +                     + nla_total_size(16), GFP_ATOMIC);
> > +     if (!skb)
> > +             goto error;
> > +
> > +     err =3D inet6_fill_ifmcaddr(skb, dev, addr, event);
> > +     if (err < 0) {
> > +             WARN_ON(err =3D=3D -EMSGSIZE);
>
> Not sure if we really need this WARN_ON. Wait for others comments.
>
> Thanks
> Hangbin

