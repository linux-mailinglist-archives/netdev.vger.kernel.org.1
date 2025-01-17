Return-Path: <netdev+bounces-159173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09054A149E3
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 07:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3833A9CB7
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 06:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C81F78E3;
	Fri, 17 Jan 2025 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEE/q+Lu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9A1F75A6
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737097054; cv=none; b=Lnw2QAKSOoUT3ixp1IIeuGcWKKhWLeLXGKlv2yrxAKvKw2JLq6etJLyhraR5aRi0T3A7og5aceQfYMNfcY1B+q35KIrXb6FIubEgIC3/6L4QbP8zx7vzb4IexJWk9zR400Om4/PniOeNQY9CcYEuZnGAAEp79p1PsIOJaOf3hy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737097054; c=relaxed/simple;
	bh=R2ax26dc068VPcFTLRabCKLrbRsvnHJwy2ajMPD0LLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tnrg40WvXmeo/DaPZ0zEM1Dv0GsWXipn/QAHZLB3b/ZjdNFyieDmqvhXoLHZLH6juh9i5FlYbsCvZ9f7lnmqoOWoJWygzqg+qQQ7ZmRtStxQLA/nvROuEfscir0nqy9GkHN3nd+HZe/jzJLO0VDEqO08MGYdioUCC1kuCxURQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEE/q+Lu; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce7e876317so15ab.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 22:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737097052; x=1737701852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be2q/K9796facHwyGzkyCOH6c+2wk9xgt9HDYl9TLTo=;
        b=KEE/q+LuW5DYOiJhimUVEFZ87XRmt+iXe7HtfGUv6M0vGaAPLVr12GFpWBhSnD0shx
         PWY5M/v1JGdRQXhA5mQ5XqbQNA0zmgzHeOBTMDrMK4X3taUv7htwZT5DWBtHTGZofpCC
         jRcRK6nK1i9QVvVj7O26RAHHEdD5NkLijQoxo+1isEC6A12U4VuMrso8uvyXI31JUThq
         sKA0AP3H8mlP8npcAKqT0aI+G9NL2TfhCKaunfrAKqA3hNkgZsxvvEwLoQhEu4K7Pkzf
         edXdgfyEQ03zXjYocROLSRCUgjrXr+zf5ybhAnDPQZJpAPZueMyRdjhRda4iDIJHcBF4
         pd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737097052; x=1737701852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Be2q/K9796facHwyGzkyCOH6c+2wk9xgt9HDYl9TLTo=;
        b=lI4vH0N/+8OntPSfL+twpMEVFhcc6ozgvZTfj4EdPrX88a4n29CmUrsuBqVYaPhGVR
         8Tx76+0xtAy8H8QxwFxU5d4c3LspZ9+xg+/WhvjBcIUL1nkpPFsm/ATAoECTSziGyGRq
         fZIJRd3colxiWSRjVrj5xvcVuhoU0z4KjqNl3i5MuQVtb4cZf0O9O7VngG4OalR09zDu
         l79osMSCoR2pjLpyypkJiDWaehYoMNHmIHYGL97xF3VPHICSDIjBqQhr/AciDQOuglkl
         0QNfNCtCYfYSY7OwfPmLQ2b8eXKD07GxdnsRpMlx91AYaqDnZoD57FvERCcjWOuKgVdZ
         uwXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnnxKsAwJTOoaAgrPSk8K/RLgYj1jeRnOXkhFO2hWoIHdOEa5egOa+lE4fRi5sFkvlYg3isog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQEUr2NFJRX0Cw6EHdL/Qf20rDxPYuvx2XZ/xj4Ur0Trd+4OB
	RyLUCE0X8znirvdwzdevloJ/L7x8C8zI3sZCbENlD87noQMRBJByFoFjuj4K11AIWazy2q8oPn7
	pSLO/ykS3zVzdubbnKWL9sObR1Yel89M6jW2U
X-Gm-Gg: ASbGncv/YApOMhYb2HTYAIhw8nVKk8LEu1jyzmdt9x5wSNPineHPn/ydkRg03pmr/dO
	4//aHmz8pRDMGTC2NW3UTfyCsfOi5YMgger7TIKBtgM/LOSL5Xw+U8vkjsy6KBBI1+GY=
X-Google-Smtp-Source: AGHT+IFRuoo5Dr5QhvOsVYEqGgKqkoMWzq+rVObcCkRzc3eZSZdnt6FeX24JNTpMztj28BUrWIUvW1/weeoGa6Zir/c=
X-Received: by 2002:a92:daca:0:b0:3ce:4ed9:5249 with SMTP id
 e9e14a558f8ab-3cf78590f1bmr31535ab.1.1737097050753; Thu, 16 Jan 2025 22:57:30
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114023740.3753350-1-yuyanghuang@google.com> <b7305f0a-fe4d-4dd4-aaaf-77a08fd919ac@redhat.com>
In-Reply-To: <b7305f0a-fe4d-4dd4-aaaf-77a08fd919ac@redhat.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 17 Jan 2025 15:56:54 +0900
X-Gm-Features: AbW1kvYoqgBmP-VHM6DmUUhDJ9Jnyw_YcGbKpysft72T0yArfYAel2SlDm77Cn4
Message-ID: <CADXeF1EiMaASLhRiNMEeXmUUT3dXhhbasOeReaNy=nuVwa1agw@mail.gmail.com>
Subject: Re: [PATCH net-next, v5] netlink: support dumping IPv4 multicast addresses
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo

Thanks for the review feedback, I will adjust them in the patch v6.

>Why moving the struct definition here? IMHO addrconf.h is better suited
>and will avoid additional headers dep.

The `struct inet_fill_args` is moved from devinet.c to igmp.h to make
it usable in both devinet.c and igmp.c.
I feel it is incorrect to move `struct inet_fill_args` to addrconf.h
because that file contains IPv6 specific definition and it also
contains `struct inet6_fill_args`. After refactoring, I will remove
the usage of enum addr_type_t type, so we don't need to import
addrconf.h anymore.

Thanks,

Yuyang

On Thu, Jan 16, 2025 at 8:06=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/14/25 3:37 AM, Yuyang Huang wrote:
> > Extended RTM_GETMULTICAST to support dumping joined IPv4 multicast
> > addresses, in addition to the existing IPv6 functionality. This allows
> > userspace applications to retrieve both IPv4 and IPv6 multicast
> > addresses through similar netlink command and then monitor future
> > changes by registering to RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR.
> >
> > This change includes a new ynl based selftest case. To run the test,
> > execute the following command:
> >
> > $ vng -v --user root --cpus 16 -- \
> >     make -C tools/testing/selftests TARGETS=3Dnet \
> >     TEST_PROGS=3Drtnetlink.py TEST_GEN_PROGS=3D"" run_tests
>
> Thanks for including the test!
>
> > diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/n=
etlink/specs/rt_link.yaml
> > index 0d492500c7e5..7dcd5fddac9d 100644
> > --- a/Documentation/netlink/specs/rt_link.yaml
> > +++ b/Documentation/netlink/specs/rt_link.yaml
> > @@ -92,6 +92,41 @@ definitions:
> >        -
> >          name: ifi-change
> >          type: u32
> > +  -
> > +    name: ifaddrmsg
> > +    type: struct
> > +    members:
> > +      -
> > +        name: ifa-family
> > +        type: u8
> > +      -
> > +        name: ifa-prefixlen
> > +        type: u8
> > +      -
> > +        name: ifa-flags
> > +        type: u8
> > +      -
> > +        name: ifa-scope
> > +        type: u8
> > +      -
> > +        name: ifa-index
> > +        type: u32
> > +  -
> > +    name: ifacacheinfo
> > +    type: struct
> > +    members:
> > +      -
> > +        name: ifa-prefered
> > +        type: u32
> > +      -
> > +        name: ifa-valid
> > +        type: u32
> > +      -
> > +        name: cstamp
> > +        type: u32
> > +      -
> > +        name: tstamp
> > +        type: u32
> >    -
> >      name: ifla-bridge-id
> >      type: struct
> > @@ -2253,6 +2288,18 @@ attribute-sets:
> >        -
> >          name: tailroom
> >          type: u16
> > +  -
> > +    name: ifmcaddr-attrs
> > +    attributes:
> > +      -
> > +        name: addr
> > +        type: binary
> > +        value: 7
> > +      -
> > +        name: cacheinfo
> > +        type: binary
> > +        struct: ifacacheinfo
> > +        value: 6
> >
> >  sub-messages:
> >    -
> > @@ -2493,6 +2540,29 @@ operations:
> >          reply:
> >            value: 92
> >            attributes: *link-stats-attrs
> > +    -
> > +      name: getmaddrs
> > +      doc: Get / dump IPv4/IPv6 multicast addresses.
> > +      attribute-set: ifmcaddr-attrs
> > +      fixed-header: ifaddrmsg
> > +      do:
> > +        request:
> > +          value: 58
> > +          attributes:
> > +            - ifa-family
> > +            - ifa-index
> > +        reply:
> > +          value: 58
> > +          attributes: &mcaddr-attrs
> > +            - addr
> > +            - cacheinfo
> > +      dump:
> > +        request:
> > +          value: 58
> > +            - ifa-family
> > +        reply:
> > +          value: 58
> > +          attributes: *mcaddr-attrs
> >
> >  mcast-groups:
> >    list:
>
> IMHO the test case itself should land to a separate patch.
>
> > diff --git a/include/linux/igmp.h b/include/linux/igmp.h
> > index 073b30a9b850..a460e1ef0524 100644
> > --- a/include/linux/igmp.h
> > +++ b/include/linux/igmp.h
> > @@ -16,6 +16,7 @@
> >  #include <linux/ip.h>
> >  #include <linux/refcount.h>
> >  #include <linux/sockptr.h>
> > +#include <net/addrconf.h>
> >  #include <uapi/linux/igmp.h>
> >
> >  static inline struct igmphdr *igmp_hdr(const struct sk_buff *skb)
> > @@ -92,6 +93,16 @@ struct ip_mc_list {
> >       struct rcu_head         rcu;
> >  };
> >
> > +struct inet_fill_args {
> > +     u32 portid;
> > +     u32 seq;
> > +     int event;
> > +     unsigned int flags;
> > +     int netnsid;
> > +     int ifindex;
> > +     enum addr_type_t type;
> > +};
>
> Why moving the struct definition here? IMHO addrconf.h is better suited
> and will avoid additional headers dep.
>
> > @@ -1874,6 +1894,23 @@ static int in_dev_dump_addr(struct in_device *in=
_dev, struct sk_buff *skb,
> >       return err;
> >  }
> >
> > +static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *=
skb,
> > +                         struct netlink_callback *cb, int *s_ip_idx,
> > +                         struct inet_fill_args *fillargs)
> > +{
> > +     switch (fillargs->type) {
> > +     case UNICAST_ADDR:
> > +             fillargs->event =3D RTM_NEWADDR;
>
> I think that adding an additional argument for 'event' to
> inet_dump_addr() would simplify the code a bit.
>
> > +             return in_dev_dump_ifaddr(in_dev, skb, cb, s_ip_idx, fill=
args);
> > +     case MULTICAST_ADDR:
> > +             fillargs->event =3D RTM_GETMULTICAST;
> > +             return in_dev_dump_ifmcaddr(in_dev, skb, cb, s_ip_idx,
> > +                                         fillargs);
> > +     default:
> > +             return 0;
>
> Why not erroring out on unknown types? should never happen, right?
>
> > @@ -1949,6 +1987,20 @@ static int inet_dump_ifaddr(struct sk_buff *skb,=
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
>
> You can avoid the local variable usage.
>
> > +}
> > +
> > +static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_call=
back *cb)
> > +{
> > +     enum addr_type_t type =3D MULTICAST_ADDR;
> > +
> > +     return inet_dump_addr(skb, cb, type);
>
> Same here.
>
> Thanks!
>
> Paolo
>

