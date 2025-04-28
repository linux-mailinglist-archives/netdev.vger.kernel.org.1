Return-Path: <netdev+bounces-186380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B77A9EDBB
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7DA17442B
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A5825E800;
	Mon, 28 Apr 2025 10:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445721AC44D
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745835613; cv=none; b=m6CN2floNXxRawDQ8ruH9SAN5upwQkeX0lGieV0gGqGulTIyf0i908eFGN7F8LVttQHekmGx6DTbvg8aApGqauEWRheVxq24eZllxAGkYcqHstF7FUTbCfM6EHC2XUkU8jvjQ1SxBjD6VZcit90yZlYFVMeo4l11AWrnMUg5fz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745835613; c=relaxed/simple;
	bh=P3BQ2rKBqacKjYo0ckEbixuugFR39guu029bCsY1Vpk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FV3gbnfmPIGlc2psxRcZrZPpBkqHwC772gjMsTrcmTSN4wiFlhxEbcFCOHi4A/GBa1xW4269vNzunr62Gxgt9agwHUSokEB96082S/1q5HymoWj0eTTvTHOsCnQH0GkWTIDEVPlHekrES39AFTOAJai/kyOJdb5O1qs4LMxm05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso43951725e9.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 03:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745835610; x=1746440410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3BQ2rKBqacKjYo0ckEbixuugFR39guu029bCsY1Vpk=;
        b=NCHSEx4xWsB0RSJBEasy4drHIEaGsjIYVMw7qhuuOt7h+6OtTMp6/prSMCGbvc4r5C
         PImXbavaJhaWgTPmCkVQDk24OhWXzo2VErazhnYMaxQAhnTCrpAGW9iQlsN7GdQlJ04k
         zsoKra37Qw38Iu8ddbakhZ9hWHdYkAp35s2GSHu6vKeOmLi0xUBWjUZNXb1+H478H74T
         EH2gF/2p/5T3bMVdRHftHwf+mAz6ddcxeo3Vd7a0sdx3jp+iVEtRJJ2gj1TEimqBPXbs
         dLTRukJRtrVfsbnixBg7lMxovmsN6XDZOt2njinIVgbTgJpM/jwdqPx/V20UCqkw2Aeb
         JMZg==
X-Gm-Message-State: AOJu0Yx+l9wRMfEv69FavGoDsXibN3xjWf1OzqOrPXiR50/JyXycMiSP
	j8icCTUDqnmMtGpC5gs/2M+er7PlZDex0Aksj0EVEX7ZA5PPhnLw
X-Gm-Gg: ASbGncuoBG0Gpew+bN/yIBzH0juNeQXG9GRVj0fakDCjFSiv1GrXBSbFWtpx4wTiQb7
	DKcVzqcmT5+KyH5gkwObHYtRFz5awQ5e+Y4c+blgfv4SotBXG0Rz6sl7h0mYq5S4g1h2L/ZOBnn
	Qdr1orSq73KDnTTUrfWNVOhboKXGr8xfqi3TBhErSSHswnz3rhR+pCji4k8Uyhw9ljCYgMfmC9D
	QQ1Us3qBqNZuMVYnO/+6BLihFUlL7KhUBFRR2sJCgdzgtdbLFq5nHV8326TSn68VazXypvgX1Yp
	tRLmjXrswWbRfABigYkjrkhSXhW65jUOkpAMqA==
X-Google-Smtp-Source: AGHT+IFLjB4uEhBi1mAr309rkkOZH2TlWjE50Fk0WEXu65u4rvaytDEID1xMh/SLI5i1zO202s8Z2Q==
X-Received: by 2002:a05:600c:1e1c:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-440a64c14bdmr96519805e9.4.1745835609153;
        Mon, 28 Apr 2025 03:20:09 -0700 (PDT)
Received: from [10.148.85.1] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5311403sm118828605e9.23.2025.04.28.03.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 03:20:07 -0700 (PDT)
Message-ID: <2eb4b72dc5578407715e91f87116d2385598fa82.camel@fejes.dev>
Subject: Re: [question] robust netns association with fib4 lookup
From: Ferenc Fejes <ferenc@fejes.dev>
To: Ido Schimmel <idosch@nvidia.com>, dsahern@gmail.com
Cc: netdev <netdev@vger.kernel.org>, kuniyu@amazon.com
Date: Mon, 28 Apr 2025 12:20:06 +0200
In-Reply-To: <aAvRxOGcyaEx0_V2@shredder>
References: <c28ded3224734ca62187ed9a41f7ab39ceecb610.camel@fejes.dev>
	 <aAvRxOGcyaEx0_V2@shredder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 21:17 +0300, Ido Schimmel wrote:
> On Thu, Apr 24, 2025 at 01:33:08PM +0200, Ferenc Fejes wrote:
> > Hi,
> >=20
> > tl;dr: I want to trace fib4 lookups within a network namespace with eBP=
F.=C2=A0=C2=A0
> > This
> > works well with fib6, as the struct net ptr passed as an argument to
> > fib6_table_lookup [0], so I can read the inode from it and pass it to
> > userspace.
> >=20
> >=20
> > Additional context. I'm working on a fib table and fib rule lookup trac=
er
> > application that hooks fib_table_lookup/fib6_table_lookup and
> > fib_rules_lookup
> > with fexit eBPF probes and gathers useful data from the struct flowi4 a=
nd
> > flowi6
> > used for the lookup as well as the resulting nexthop (gw, seg6, mpls tu=
nnel)
> > if
> > the lookup is successful. If this works, my plan is to extend it to
> > neighbour,
> > fdb and mdb lookups.
> >=20
> > Tracepoints exist for fib lookups v4 [1] and v6 [2] but in my tracer I =
would
> > like to have netns filtering. For example: "check unsuccessful fib4 rul=
e and
> > table lookups in netns foo". Unfortunately I can't find a reliable way =
to
> > associate netns info with fib4 lookups. The main problems are as follow=
s.
> >=20
> > Unlike fib6_table_lookup for v6, fib_table_lookup for v4 does not have =
a
> > struct
> > net argument. This makes sense, as struct net is not needed there. But
> > without
> > it, the netns association is not as easy as in the v6 case.
> >=20
> > On the other hand, fib_lookup [3], which in most cases calls
> > fib_table_lookup,
> > has a struct net parameter. Even better, there is the struct fib_result=
 ptr
> > returned by fib_table_lookup. This would be the perfect candidate to ho=
ok
> > into,
> > but unfortunately it is an inline function.
> >=20
> > If there are custom fib rules in the netns, __fib_lookup [4] is called,
> > which is
> > hookable. This has all the necessary info like netns, table and result.=
 To
> > use
> > this I have to add the custom rule to the traced netns and remove it
> > immediately. This will enforce the __fib_lookup codepath. But I feel th=
at at
> > some point this bug(?) will be fixed and the kernel will notice the abs=
ence
> > of
> > custom rules and switch back to the original codepath.
> >=20
> > But this option is useless for tracing unsuccessful lookups. The stack =
looks
> > like this:
> > __fib_lookup=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <-- netns info av=
ailable
> > =C2=A0 fib_rules_lookup=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <-- losing netns info... :-(
> > =C2=A0=C2=A0=C2=A0 fib4_rule_action=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <-- unsuccessful result available
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fib_table_lookup=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <-- source of unsuccessful result
> >=20
> > My current workaround is to restore the netns info using the struct flo=
wi4
> > pointer. When we have the stack above, I use an eBPF hashmap and use th=
e
> > flowi4
> > pointer as the key and netns as the value. Then in the fib_table_lookup=
 I
> > look
> > up the netns id based on the value of the flowi4 pointer. Since this is=
 the
> > common case, it works, but looks like fib_table_lookup is called from o=
ther
> > places as well (even its rare).
> >=20
> > Is there any other way to get the netns info for fib4 lookups? If not, =
would
> > it
> > be worth an RFC to pass the struct net argument to fib_table_lookup as =
well,
> > as
> > is currently done in fib6_table_lookup?
>=20
> I think it makes sense to make both tracepoints similar and pass the net
> argument to trace_fib_table_lookup()

Thank you for looking into it.

>=20
> > Unfortunately this includes some callers to fib_table_lookup. The
> > netns id would also be presented in the existing tracepoints ([1] and
> > [2]). Thanks in advance for any suggestion.
>=20
> By "netns id" you mean the netns cookie? It seems that some TCP trace
> events already expose it (see include/trace/events/tcp.h). It would be
> nice to finally have "perf" filter these FIB events based on netns.

No, by netns id I mean struct net::ns::inum, which is the inode number
associated with the netns. This is convenient since it's easy to look up th=
is
value in userspace with the lsns tool or just stat through the procfs for t=
he
inode.

Looks like struct net::net_cookie is for similar purpose and can be used fr=
om
restricted context (e.g.: xdp/tc/cls eBPF progs) where rich context (struct=
 net
for example) as in a fexit/fentry probe is not available.

>=20
> David, any objections?
>=20
> >=20
> > Best,
> > Ferenc
> >=20
> >=20
> > [0] https://elixir.bootlin.com/linux/v6.15-rc3/source/net/ipv6/route.c#=
L2221
> > [1]
> > https://elixir.bootlin.com/linux/v6.15-rc3/source/include/trace/events/=
fib.h
> > [2]
> > https://elixir.bootlin.com/linux/v6.14/source/include/trace/events/fib6=
.h
> > [3]
> > https://elixir.bootlin.com/linux/v6.15-rc3/source/include/net/ip_fib.h#=
L374

