Return-Path: <netdev+bounces-99895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390158D6E95
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 08:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28AE1F2867A
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56572FC1F;
	Sat,  1 Jun 2024 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="p7eKRsD2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BFF125A9
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224737; cv=none; b=fNtkQL86AjM/mFGPMC1w0yW0hJj+I+j9nNCe7njd1w1H2ocCTTcGNTwWyVZZRFgQmzj6vKII6IkDiQiF5ST+e0ikva1d8N13C0pn4HN6s02/qrjOsTk1LXS39v/KTtuxkXHfOT+PW5dmDjVIxgHSycp7lZsAvCqjthUzLrBg8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224737; c=relaxed/simple;
	bh=VLIt67m644pfgFQB0ZbwSEmFi/vfF+ds8lMDJ07kv98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XatuwD1AxHHN1i6bUMun77q72+mt2DfIiAxMxYIuBN1AVe5O/3yEGob5Nlzk/d0kyjxwYSudpYAmYXfFYinLt/2BXzcHyM9ofCQL9hv65TRfTKELYq7czq3XZSb/YCOjD7wc9QvQjZtxoasHq6FOfHw8UPTQOjYOda+3xjWDZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=p7eKRsD2; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a68c2915d99so6913966b.2
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1717224733; x=1717829533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xzwB/JpZoFpWGmaihy/HRbfL25ktGEM5RjoKiMReVOY=;
        b=p7eKRsD2OLycehOPhDh20q9f7bBdQVNCpP0TDL8izQ0QmwAI9ZPULGZ773ThHYTcGN
         oFwyaKM3J9AQQoX0GkQ2qCaZhOV+YxeWNeXmwbZsQfAn0jP+VfbiJYVCsu/wDCWhu9mu
         v0s0a5dsVd4ri65SdsbxyZGkKbx1SJfQPyqlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717224733; x=1717829533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzwB/JpZoFpWGmaihy/HRbfL25ktGEM5RjoKiMReVOY=;
        b=NrUzFiuEFJB/Lct85U6/vAi9DyjAWAGBBlO1d0HnpYP9Pkua3JElmCqxNdZVZYtDhv
         BmsFRkjyJC7940/P3oICagaG4O+C05UnoesB2+NkEiE+hmmc75CA2NG+FJocSzNbooZa
         SS4iZwxOxn+8VzV4iw1HK6Zewc56QjHC7L6szXX6Kyfo6YXhrvmHO9JY3SB+y2Xll0TJ
         Eb/2EzrJCtK7Zw0P0CmwYv+EIgclgWVsLFoubwmPu6KQU51n/YZwB83Egq/sHBsG+4Fq
         Gg4/7q+MyxuaJzl6LJUSvKSqqWsOYZpz6wKhoQtGlY68PS7qC5Iyur8cXXNnh9HM2+pE
         eHXQ==
X-Gm-Message-State: AOJu0YxXTo8syFkJfiSCXiBJ+JTNlnB9FgRkKDZO885E/sc6LuVzEQVx
	HfHwmmqOuz2RSBy0ipuwLxQegf/EXQSfCbOze6sRVkpXnZlONpV8HpS/Hk7d2lMO8R7ojVlYxsB
	EMkIDwhiGWxxpHQz31S/s/A1EqkwycaAYixsD
X-Google-Smtp-Source: AGHT+IGWP4NynkN/gQDKa8z3JEutyYDqYsdq8ghlS0a7lMQWr8OfRyvtGKBPlaOxLbQ3ClohLfP6f0QCpUy3AfJoYDY=
X-Received: by 2002:a17:906:35c4:b0:a68:ae2f:ea42 with SMTP id
 a640c23a62f3a-a68ae2fee87mr46968166b.65.1717224733342; Fri, 31 May 2024
 23:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com>
 <20240530173324.378acb1f@kernel.org> <CAK8fFZ6nEFcfr8VpBJTo_cRwk6UX0Kr97xuq6NhxyvfYFZ1Awg@mail.gmail.com>
 <20240531142607.5123c3f0@kernel.org>
In-Reply-To: <20240531142607.5123c3f0@kernel.org>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Sat, 1 Jun 2024 08:51:47 +0200
Message-ID: <CAK8fFZ5ED9-m12KDbEeipjN0ZkZZo5Bdb3=+8KWJ=35zUHNCpA@mail.gmail.com>
Subject: Re: [regresion] Dell's OMSA Systems Management Data Engine stuck
 after update from 6.8.y to 6.9.y (with bisecting)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Igor Raits <igor@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"

>
> On Fri, 31 May 2024 08:48:31 +0200 Jaroslav Pulchart wrote:
> > > Could you try this?
> > >
> > > diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> > > index 96accde527da..5fd06473ddd9 100644
> > > --- a/net/ipv4/devinet.c
> > > +++ b/net/ipv4/devinet.c
> > > @@ -1912,6 +1912,8 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
> > >                         goto done;
> > >         }
> > >  done:
> > > +       if (err == -EMSGSIZE && likely(skb->len))
> > > +               err = skb->len;
> > >         if (fillargs.netnsid >= 0)
> > >                 put_net(tgt_net);
> > >         rcu_read_unlock();
> >
> > I tried it and it did not help, the issue is still there.
>
> Hm. Could you strace it ? I wonder if I misread something it doing
> multiple dumps and now its hanging on a different one..

sure, here it is:
...
[pid 24486] socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE) = 12
[pid 24486] sendto(12, [{nlmsg_len=24, nlmsg_type=0x16 /* NLMSG_???
*/, nlmsg_flags=NLM_F_REQUEST|0x300, nlmsg_seq=1, nlmsg_pid=0},
"\x02\x00\x00\x00\x02\x00\x00\x00"], 24, 0, {sa_family=AF_NETLINK,
nl_pid=0, nl_groups=00000000}, 12) = 24
[pid 24486] recvmsg(12, {msg_name={sa_family=AF_NETLINK, nl_pid=0,
nl_groups=00000000}, msg_namelen=12,
msg_iov=[{iov_base=[[{nlmsg_len=76, nlmsg_type=RTM_NEWADDR,
nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1, nlmsg_pid=24486},
{ifa_family=AF_INET, ifa_prefixlen=8, ifa_flags=IFA_F_PERMANENT,
ifa_scope=RT_SCOPE_HOST, ifa_index=if_nametoindex("lo")},
[[{nla_len=8, nla_type=IFA_ADDRESS}, inet_addr("127.0.0.1")],
[{nla_len=8, nla_type=IFA_LOCAL}, inet_addr("127.0.0.1")],
[{nla_len=7, nla_type=IFA_LABEL}, "lo"], [{nla_len=8,
nla_type=IFA_FLAGS}, IFA_F_PERMANENT], [{nla_len=20,
nla_type=IFA_CACHEINFO}, {ifa_prefered=4294967295,
ifa_valid=4294967295, cstamp=766, tstamp=766}]]], [{nlmsg_len=88,
nlmsg_type=RTM_NEWADDR, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1,
nlmsg_pid=24486}, {ifa_family=AF_INET, ifa_prefixlen=24, ifa_flags=0,
ifa_scope=RT_SCOPE_LINK, ifa_index=if_nametoindex("idrac")},
[[{nla_len=8, nla_type=IFA_ADDRESS}, inet_addr("169.254.1.2")],
[{nla_len=8, nla_type=IFA_LOCAL}, inet_addr("169.254.1.2")],
[{nla_len=8, nla_type=IFA_BROADCAST}, inet_addr("169.254.1.255")],
[{nla_len=10, nla_type=IFA_LABEL}, "idrac"], [{nla_len=8,
nla_type=IFA_FLAGS}, IFA_F_NOPREFIXROUTE], [{nla_len=20,
nla_type=IFA_CACHEINFO}, {ifa_prefered=862834, ifa_valid=862834,
cstamp=1717, tstamp=1717}]]], [{nlmsg_len=92, nlmsg_type=RTM_NEWADDR,
nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1, nlmsg_pid=24486},
{ifa_family=AF_INET, ifa_prefixlen=20, ifa_flags=IFA_F_PERMANENT,
ifa_scope=RT_SCOPE_UNIVERSE, ifa_index=if_nametoindex("br_private")},
[[{nla_len=8, nla_type=IFA_ADDRESS}, inet_addr("10.12.48.105")],
[{nla_len=8, nla_type=IFA_LOCAL}, inet_addr("10.12.48.105")],
[{nla_len=8, nla_type=IFA_BROADCAST}, inet_addr("10.12.63.255")],
[{nla_len=15, nla_type=IFA_LABEL}, "br_private"], [{nla_len=8,
nla_type=IFA_FLAGS}, IFA_F_PERMANENT|IFA_F_NOPREFIXROUTE],
[{nla_len=20, nla_type=IFA_CACHEINFO}, {ifa_prefered=4294967295,
ifa_valid=4294967295, cstamp=1706, tstamp=1706}]]], [{nlmsg_len=92,
nlmsg_type=RTM_NEWADDR, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1,
nlmsg_pid=24486}, {ifa_family=AF_INET, ifa_prefixlen=20,
ifa_flags=IFA_F_PERMANENT, ifa_scope=RT_SCOPE_UNIVERSE,
ifa_index=if_nametoindex("br_public")}, [[{nla_len=8,
nla_type=IFA_ADDRESS}, inet_addr("10.12.16.105")], [{nla_len=8,
nla_type=IFA_LOCAL}, inet_addr("10.12.16.105")], [{nla_len=8,
nla_type=IFA_BROADCAST}, inet_addr("10.12.31.255")], [{nla_len=14,
nla_type=IFA_LABEL}, "br_public"], [{nla_len=8, nla_type=IFA_FLAGS},
IFA_F_PERMANENT|IFA_F_NOPREFIXROUTE], [{nla_len=20,
nla_type=IFA_CACHEINFO}, {ifa_prefered=4294967295,
ifa_valid=4294967295, cstamp=1708, tstamp=1708}]]], [{nlmsg_len=20,
nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1,
nlmsg_pid=24486}, 0]], iov_len=13312}], msg_iovlen=1,
msg_controllen=0, msg_flags=0}, 0) = 368

