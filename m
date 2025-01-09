Return-Path: <netdev+bounces-156669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6A6A0753F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93CC17A29D7
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8EF2165FE;
	Thu,  9 Jan 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2T2mIVa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835FE195
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424315; cv=none; b=J9n+WyhE4N2m6nw2kmnQ849h4sZ2mUDbDoXGjzTIDYDVAjC0oMSb+/oqFEWWfEePD/ix+ogBL8EqBpgSuLs2au5exkn7kX65cCJMNNkCVRuXohej7JXqrH1tilN3yrGz6+cZg614L4pu4kfiF3gPRaMc10W1uZdnFi1+oYsgnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424315; c=relaxed/simple;
	bh=8/3nK54h+vJSql5Sau2XJwg+l4vNvuA9l/bK3h2JcQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoFrjUaX3b50ITvBYHU21UhWFf7doo4kKhGYrxnkONbU+g2qLeLP3gUzl6ZiGh9FEdM+klNiD0+PFtYRPjSlsLpmK5NBOSwWcKlOHHDwUIgw5nVecw7XyRd9dNNHiyBZLfts+4rdo5Q/rAPiTJjD0I6+FTIHWEiz5zvgePWd2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2T2mIVa; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a818cd5dcbso85ab.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 04:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736424312; x=1737029112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHFu0yDdbWe0xRPSdwVKl3w4pSHpkYcdxPt7u4bcYfE=;
        b=B2T2mIVaQfW4+L02EmKHJnMGwRskbnLRo2YGI9Zvl6fkfRz9dzoY0cZ+rejdKV8kMU
         h/fup0BEtwYEEHrt81sq7Dq5hLLDPimq3IuH6NIJFNqPc9PIPK423fEoV64iXht6i3Tq
         dmR5s5G4jxsOVIMRQQRCOnuSYmRadQ3/QGkq4iICcwMaRCyX8GWEaNm0iKT3dqQkYKA7
         2eOoMRXkL9QrdP6G8xfBpTYb0jUfMTSJ9mGpSdEMM3tO9LoRbiqPDxmI2pJL5zQzWbuS
         nfASVFSHpLv75W9OSXfB0kraDga4nOpstNWVyOTcoP2vrs1NHV+/4M6gW6cxz7Ek8g8H
         LiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736424312; x=1737029112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHFu0yDdbWe0xRPSdwVKl3w4pSHpkYcdxPt7u4bcYfE=;
        b=khqDzeiy3ri7q2RsZjH4vQ2clU0dJlGejYA55FU8Fmr++GhlZ+kwlWsghOXgeUIjmE
         DYV2ESGG4E+wq574CV0pq0rGD6R7Lk/q70PN3OHOy4mBcPpDI8xWopBPQYJVfLNZoXjR
         M4od3R6jUUtsy1CJv9Rh2j0a9XwhPuhcdcZFKZfRcNmRg1EMcaikSrJfcAsI4Et/w9qc
         omxtCvpb4NQoPLYFNJq5guKEH541zmZHrJLH3ZU8TAbrYtDfVgBwvcymOsUoc0SaqjMM
         RHdekvFOa7ClidzgnsAXoaMjXmWRMP8o/yWzBBZkGgBmnaN83gOarSUTxn5EUWN3UrzG
         fG0g==
X-Forwarded-Encrypted: i=1; AJvYcCXHxQ1l6vcA3tqZK0+oSQq0akeG2nJbEGiSqBp2bpTfj+QXnSxbaC4mLyr5R39hVdjf8ygkHeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvhLPQru1hKoJhxQG6JhViPmQ0xfq/PtPxDoXxzSSyhuELJ64C
	4ch35PtKrcE7PL7pPnhFloliC3rgSAP4DPmCNJEuScP4YYNx1tGXTmaC4Hsw4ZtLUMndKi8gKCH
	yv0f02X4PjX79RNDSPqv606hIEFv7LW6LGm+w
X-Gm-Gg: ASbGncsaQvpymtVJgDdlfjFaMHGPe9EkBZ8RVnlwfgJ+RYaQf9Yx++oZ4gnLjPCr8M7
	iqebXsX9LHZWQ9klv0PahExPhQ7+Nct1Na9FoGSkmCNFhGQJBglXxafmIzzDgcPJbBBGOHtE=
X-Google-Smtp-Source: AGHT+IGb7mX5ZuoDX6xEGGYV43TnLLVN5OgT+xSrrsBsOKDnjyNOYQg5nQ+A45pGNj4u1J4AMUvia4+0oR9k13qr/0E=
X-Received: by 2002:a92:d3c9:0:b0:3ce:4ed9:5249 with SMTP id
 e9e14a558f8ab-3ce50e97631mr43895ab.1.1736424311432; Thu, 09 Jan 2025 04:05:11
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109072245.2928832-1-yuyanghuang@google.com> <361414dc-3d7b-4616-a15b-3e0cb3219846@redhat.com>
In-Reply-To: <361414dc-3d7b-4616-a15b-3e0cb3219846@redhat.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 9 Jan 2025 21:04:33 +0900
X-Gm-Features: AbW1kvaCzwzj4Wfi6xmKz_pX_-PYAYzGghlBQTWTbgmemGqFtmPuj5oUVpcitGM
Message-ID: <CADXeF1G1G8F4BK2YienEkVHVpGSmF2wQnOFnE+BwzaCBexv3SQ@mail.gmail.com>
Subject: Re: [PATCH net-next, v4] netlink: support dumping IPv4 multicast addresses
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo

Thanks for the review feedback.

>I suspect the above chunk confuses the user-space as inet_fill_ifaddr()
>still get the 'event' value from fillargs->event

You're right, I missed initializing the event field in the fillargs
structure. It's a bug introduced in the v4 patch during refactoring. I
will fix it in the v5 patch.

>Also, this will need a paired self-test - even something very simple
>just exercising the new code.

Sure, I can send separate patch for adding self-test, but please let
me know if I should include the self-test in the same patch

Thanks
Yuyang


On Thu, Jan 9, 2025 at 8:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 1/9/25 8:22 AM, Yuyang Huang wrote:
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
> This patch is apparently breaking a few tests:
>
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2025-01-09--=
09-00&executor=3Dvmksft-net-dbg&pw-n=3D0&pass=3D0
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2025-01-09--=
09-00&executor=3Dvmksft-nf-dbg&pw-n=3D0&pass=3D0
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2025-01-09--=
09-00&executor=3Dvmksft-nf&pw-n=3D0&pass=3D0
>
> I suspect the above chunk confuses the user-space as inet_fill_ifaddr()
> still get the 'event' value from fillargs->event
>
> Also, this will need a paired self-test - even something very simple
> just exercising the new code.
>
> Thanks,
>
> Paolo
>

