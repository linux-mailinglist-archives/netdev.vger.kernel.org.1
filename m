Return-Path: <netdev+bounces-156731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4031DA07A19
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005587A23B2
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89521C17E;
	Thu,  9 Jan 2025 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHMYTmi+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4903D126C18
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434932; cv=none; b=H+cG8+HoJXgzyDw4qvWdWkSqNADyanoYsuFZh4shrR5Gqr59FHB9Nssrg0hvzgxVFTImZny9gk7c1WJhebBe5YMBRtEYZaCQINzOYH0F1kPzaopJBHrxn4b3+tMYxnYr7t85mYJHu7SYdI7JwDLZy4/vaPWKVCBiXhC4n5UA8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434932; c=relaxed/simple;
	bh=mhoHNFdfIrer9BqHZ5GkGkfhTEDpjOeJSasdYf8CX+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0YjKN7+atlcCE45tKedfTGYfP/TBZyMJEVTfXDXnlZMQoXKS+5q+NGKo6PJCnjWZ3QAzveikuGnRn/rMZAkmXmTaOISA5MteHHLCY2lJDzbbdtZ3IyrFHa5hMNIDKHhKUCwws0pf820gZJyy7cBxJPLFXG9VcOssPTGnb9wkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHMYTmi+; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a818cd5dcbso35ab.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 07:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736434930; x=1737039730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6X6s5jja2+h2WCquVhSMdKLYDPXcwmQb3KhbzvcQWE=;
        b=wHMYTmi+jJT5CqufBuCKTorAJXHvajapdYItlIp/kSk6IzE1hUFnPE7AyiI+at9dWt
         lVy2MseRq2bNXx9n1WgYbAUeBGAY/n77kBi4WGNviuEpK6EmDoxvcnr7lWgdDHjrb/Xq
         4x6AOMadLEJQgkEumMzJ+WpnaZAysS5Q9CJaOG3b2ZTIhF87GlLFIOpemcxdDNsu/26F
         mNziMpWBFN8NJkjhiHxtE7LwmyN/+Fq515J+w3lsawrOUxkDQ4W60YF3wwT7fQ26QGtI
         0egowQdUks4L672+tvNpGkBI2AIVoehrbIhF2Fls96dGJEBy23LB2uuynIqpNOR98c4M
         ZQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736434930; x=1737039730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6X6s5jja2+h2WCquVhSMdKLYDPXcwmQb3KhbzvcQWE=;
        b=im9kz3CZ1eKWlqykv0CfeHMkOk5VPCL9YccuRh/uTcie87qdlsyQKaIjXYlkkSO2u5
         R/1YOoY+2oipeND+gegtKtXIPy7YR9Vwr4MoY8lZAXK4ARuu+nbQOJXZ8iobkq9wjJpl
         gUOvUqfRl25LtG10BFB3TbZUwLFH/w6qubWN7h3dUUR1+oUV7w/fDWyOw4jU+xXcHRdY
         Z+riaweR/KYam+fVNjcxch6+AR48nAjU8nEtTkJ7H9MTqtk1fs+H2pSwuDtA9PhNUv8A
         4nVC3H/d9dqZO5la7HtKWQe3Nfl9HqO99lkaPX5TAmnUORf4imPGJGnQaGdUhGDhl91P
         cl5g==
X-Forwarded-Encrypted: i=1; AJvYcCXy67JohZxlQRaW6kLghS2XEnkAudMORQfbej9BeoUXiY5mkO/LzAXSeL2ZsoOpI1tjSU5Sdos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTl+orYnI0bKtzAIxPDqA8Ckjdzkclp2Ibp3nyLlTR75C1Wbs8
	ZqENt+iXn1tppSg3sbFLYZ4ndNFXfyx1oKfA69yEmODmP0yo9Na7QaBdCH2VU2cFOVK8oFmRPJM
	vUBB5jtHdBn4RFfYHZ+Zu5SxT8tBp9GCtAnkU
X-Gm-Gg: ASbGncumDrZrJZ344gBTfLCcDSlErR9uyt2mygYCZw9tp8ryY2ijbUyDcpbhGZggqAe
	13LKzHIErSKXtJPVVghG3S48upLzXsrhKMAdsvQ==
X-Google-Smtp-Source: AGHT+IEfiR358Al8m3MfZn9iCkwiuLHNdA22+22rPbK5C0cDBY9IJqRSC7LioeBC1Sv6g5KzzZmX8z6MvvxE3dtgaJc=
X-Received: by 2002:a92:d0c4:0:b0:3ce:51bd:3b05 with SMTP id
 e9e14a558f8ab-3ce53f09bb3mr45285ab.2.1736434929630; Thu, 09 Jan 2025 07:02:09
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109072245.2928832-1-yuyanghuang@google.com>
 <361414dc-3d7b-4616-a15b-3e0cb3219846@redhat.com> <CADXeF1G1G8F4BK2YienEkVHVpGSmF2wQnOFnE+BwzaCBexv3SQ@mail.gmail.com>
In-Reply-To: <CADXeF1G1G8F4BK2YienEkVHVpGSmF2wQnOFnE+BwzaCBexv3SQ@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 10 Jan 2025 00:01:31 +0900
X-Gm-Features: AbW1kvbbAPxZDLW6dhcx2EVNvV2wjBtXsnBcYnl1nrGN3uwWV0bZ3p47wjqSdMs
Message-ID: <CADXeF1FxVt=xt+yk_SvLSYBYw07Vy6pssSfXqv8pOQuP7obPgg@mail.gmail.com>
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

>Also, this will need a paired self-test - even something very simple
>just exercising the new code.

After looking into the existing selftest, I feel writing C program
selftests might be a little bit anti-pattern. The existing test cases
primarily use iproute2. This approach appears to be more common and
easier to implement. I do plan to migrate `ip maddress` to use netlink
instead of parsing procfs, which enables me to write selftests using
iproute2.

I intend to add similar selftests for my other patches
(anycast/multicast notifications), which already have corresponding
iproute2 patches under review or merged.

For this patch, my proposed steps for adding test are:

1. Fix this patch and get it merged.
2. Update iproute2(`ip maddress`) to use netlink.
3. Write selftests using iproute2.

Please let me know if you have any concerns.

Thanks,
Yuyang

On Thu, Jan 9, 2025 at 9:04=E2=80=AFPM Yuyang Huang <yuyanghuang@google.com=
> wrote:
>
> Hi Paolo
>
> Thanks for the review feedback.
>
> >I suspect the above chunk confuses the user-space as inet_fill_ifaddr()
> >still get the 'event' value from fillargs->event
>
> You're right, I missed initializing the event field in the fillargs
> structure. It's a bug introduced in the v4 patch during refactoring. I
> will fix it in the v5 patch.
>
> >Also, this will need a paired self-test - even something very simple
> >just exercising the new code.
>
> Sure, I can send separate patch for adding self-test, but please let
> me know if I should include the self-test in the same patch
>
> Thanks
> Yuyang
>
>
> On Thu, Jan 9, 2025 at 8:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >
> > On 1/9/25 8:22 AM, Yuyang Huang wrote:
> > > @@ -1889,15 +1935,16 @@ static u32 inet_base_seq(const struct net *ne=
t)
> > >       return res;
> > >  }
> > >
> > > -static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_call=
back *cb)
> > > +static int inet_dump_addr(struct sk_buff *skb, struct netlink_callba=
ck *cb,
> > > +                       enum addr_type_t type)
> > >  {
> > >       const struct nlmsghdr *nlh =3D cb->nlh;
> > >       struct inet_fill_args fillargs =3D {
> > >               .portid =3D NETLINK_CB(cb->skb).portid,
> > >               .seq =3D nlh->nlmsg_seq,
> > > -             .event =3D RTM_NEWADDR,
> > >               .flags =3D NLM_F_MULTI,
> > >               .netnsid =3D -1,
> > > +             .type =3D type,
> >
> > This patch is apparently breaking a few tests:
> >
> > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2025-01-09=
--09-00&executor=3Dvmksft-net-dbg&pw-n=3D0&pass=3D0
> > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2025-01-09=
--09-00&executor=3Dvmksft-nf-dbg&pw-n=3D0&pass=3D0
> > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2025-01-09=
--09-00&executor=3Dvmksft-nf&pw-n=3D0&pass=3D0
> >
> > I suspect the above chunk confuses the user-space as inet_fill_ifaddr()
> > still get the 'event' value from fillargs->event
> >
> > Also, this will need a paired self-test - even something very simple
> > just exercising the new code.
> >
> > Thanks,
> >
> > Paolo
> >

