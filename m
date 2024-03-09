Return-Path: <netdev+bounces-78961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED63D8771C1
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 16:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E99DB20EB3
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB340870;
	Sat,  9 Mar 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6ku/Iaj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1711B4085B
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709996573; cv=none; b=p1XsY3KFWUb07Machoepv7j5dykqrT2+VTLct7EqsMHcgBjnpIWFM6pKjct503GdCdhQNLdLm6aqewBdWNb+dKiZplg+m7C1oRNuyzR/wwwgc/VRi5W+RdnxBjisNnSjJzzXTHvUwrQxYHzVVzK5NTCuMHPqukz0NezaXVADxes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709996573; c=relaxed/simple;
	bh=s7rzjC37dET9thJC76xf00+mYAuyHMhhmAND3oFnlew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLFPC5F2OGQ/2irlK43cZyIxq2aZSg5Jq/WbOMBYSIRe/E1NMmfUkZKVGhtIQhkTI+UT7W7j8bzA/hNmR7BlrZCTf5sE5hqbKvvCr12C9qddhyi4vies9j0RPt+dnG8NnFQWbc5XTdRYM2K8/h61LB+7jmprB1vtpVaya58tuHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6ku/Iaj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so3631a12.1
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 07:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709996569; x=1710601369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU/2XAJwgnGDdtXt6U3Lpy48t3jrBi81WFZRTHQzqUs=;
        b=L6ku/Iaj5Ojfv2NZRoKx0sa2CCY6QK6+CAzhPKADD2eZyNAWfJHtUlnEHedM1p7dPQ
         mu9xBPclMl8gJjqNplDE8ntwCGiwGfClTtnxm2fk2qZcKbpwhH4pEnlRLjCWFqEuuwQx
         ep2+1IkgfUbMU0nyF9+a8jepn5Be8ofAMZrXLlaD4sUc2plUJaml8DemACWc4K5SvTbD
         4xssqfLExZzvcSm5Ax7NjvRGcLhanam40Ai3IZhwQQICrrWzLdF14YwpNu+fqAZ11UAC
         KHSESQe8ahInHXQLomlVwx8UxinC/z774P8PeR5cT6RdxduCoXpAHpKDjGxy6yIgXD39
         WlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709996569; x=1710601369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU/2XAJwgnGDdtXt6U3Lpy48t3jrBi81WFZRTHQzqUs=;
        b=fYDxK9W9j/ezK9ECaPS/qwTDcuO3ibw9MJVJ7RmzcsxVbNQOwqqTUiRu0ht7uqSSc/
         yH0ZHwQqlTqUJX+T/2owA16A00O2wSiuWehoA1T1y+0JhSnv9V2x/EEJ//NTKmjnajMH
         fbW3/bokGAejPlr0o39NyjHRWPTnHzKeH/ZICigsuRiRvx7yw93h7xuLL/LN8AWw5mz2
         XROCeKwt4K+KCG405x2X5wOZeQ05TAsVDC1QDfLPjH0FVh/UWYnRZ4NycfjFHP4AHh0f
         OMQkahS9PrXAPsMJiM+lIvW/byCPHNx7xkK40E+B6HsksI5Mx+qDi4Q/j2YEKE9Mp85n
         pteg==
X-Forwarded-Encrypted: i=1; AJvYcCWn0el/15qYv83riOngqAuPV2yVJpZ186cO3Othx/vFoDQEXEw/Z2MoX1o2r+B6IlJ3M/ylFliZKSzTpBGKkFIfMZJsio5R
X-Gm-Message-State: AOJu0YxfUhzXXBp2qLVpStMhNJIQ7gMZIb6XYiB6L6CoAn1waX5PofPb
	1QmEVeSLzqpL0pQjElZ2nUPEcEkdakvC1WQAlA3kYhVYi2+pz9t+sU8ZxgmRIKGef1D7mmsQ+cP
	e1+BRfrEdDsIVaHCSMYk3Oa68b0SVy/rP+HKd
X-Google-Smtp-Source: AGHT+IH2Mz8nw/7aCc+UVHyJCmhCSfrOICs9Gp2ZEsn2zBGfaZTFkK5h6Hcn3kBN8nXP3jjgwMK4iCWLA8OShpvB9bI=
X-Received: by 2002:a05:6402:31ea:b0:568:3775:d9f1 with SMTP id
 dy10-20020a05640231ea00b005683775d9f1mr147972edb.2.1709996569130; Sat, 09 Mar
 2024 07:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709727981.git.petrm@nvidia.com> <a76b651c734d81d1f1c749d16adf105acb9e058c.1709727981.git.petrm@nvidia.com>
In-Reply-To: <a76b651c734d81d1f1c749d16adf105acb9e058c.1709727981.git.petrm@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 9 Mar 2024 16:02:35 +0100
Message-ID: <CANn89i+UNcG0PJMW5X7gOMunF38ryMh=L1aeZUKH3kL4UdUqag@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/7] net: nexthop: Adjust netlink policy
 parsing for a new attribute
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	mlxsw@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 1:50=E2=80=AFPM Petr Machata <petrm@nvidia.com> wrot=
e:
>
> A following patch will introduce a new attribute, op-specific flags to
> adjust the behavior of an operation. Different operations will recognize
> different flags.
>
> - To make the differentiation possible, stop sharing the policies for get
>   and del operations.
>
> - To allow querying for presence of the attribute, have all the attribute
>   arrays sized to NHA_MAX, regardless of what is permitted by policy, and
>   pass the corresponding value to nlmsg_parse() as well.
>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 58 ++++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
>
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 70509da4f080..bcd4df2f1cad 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -43,6 +43,10 @@ static const struct nla_policy rtm_nh_policy_get[] =3D=
 {
>         [NHA_ID]                =3D { .type =3D NLA_U32 },
>  };
>
> +static const struct nla_policy rtm_nh_policy_del[] =3D {
> +       [NHA_ID]                =3D { .type =3D NLA_U32 },
> +};

Bogus repeated pattern in this patch.

rtm_nh_policy_del[] has only NHA_ID entry defined.

So the array size is small.

> +
>  static const struct nla_policy rtm_nh_policy_dump[] =3D {
>         [NHA_OIF]               =3D { .type =3D NLA_U32 },
>         [NHA_GROUPS]            =3D { .type =3D NLA_FLAG },
> @@ -2966,9 +2970,9 @@ static int rtm_new_nexthop(struct sk_buff *skb, str=
uct nlmsghdr *nlh,
>         return err;
>  }
>
>

...

> -
>  /* rtnl */
>  static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
>                            struct netlink_ext_ack *extack)
>  {
>         struct net *net =3D sock_net(skb->sk);
> +       struct nlattr *tb[NHA_MAX + 1];

big tb[] array, but small rtm_nh_policy_del[] policy.

>         struct nl_info nlinfo =3D {
>                 .nlh =3D nlh,
>                 .nl_net =3D net,
> @@ -3020,7 +3010,12 @@ static int rtm_del_nexthop(struct sk_buff *skb, st=
ruct nlmsghdr *nlh,
>         int err;
>         u32 id;
>
> -       err =3D nh_valid_get_del_req(nlh, &id, extack);
> +       err =3D nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,

But here you pass NHA_MAX...

> +                         rtm_nh_policy_del, extack);
> +       if (err < 0)
> +               return err;

So  we hit :

kernel BUG at lib/nlattr.c:411 !
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 14369 Comm: syz-executor.2 Not tainted
6.8.0-rc7-syzkaller-02415-g2f901582f032 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 02/29/2024
RIP: 0010:validate_nla lib/nlattr.c:411 [inline]
RIP: 0010:__nla_validate_parse+0x2f61/0x2f70 lib/nlattr.c:635
Code: 48 8b 4c 24 18 80 e1 07 38 c1 0f 8c e0 f7 ff ff 48 8b 7c 24 18
e8 ff 0e 1d fd e9 d1 f7 ff ff e8 d5 c2 91 06 e8 50 64 ba fc 90 <0f> 0b
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90003c1eec0 EFLAGS: 00010287
RAX: ffffffff84d90ad0 RBX: ffffffff8caa11b0 RCX: 0000000000040000
RDX: ffffc9000499a000 RSI: 000000000000065e RDI: 000000000000065f
RBP: ffffc90003c1f100 R08: ffffffff84d8df5b R09: 0000000000000000
R10: ffffc90003c1f1a0 R11: fffff52000783e46 R12: 0000000000000008
R13: 1ffff1100f9c4183 R14: 000000000000006e R15: 0000000000000005
FS: 00007f5fe2d916c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000440 CR3: 00000000229a2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
__nla_parse+0x40/0x60 lib/nlattr.c:732
__nlmsg_parse include/net/netlink.h:756 [inline]
nlmsg_parse include/net/netlink.h:777 [inline]
rtm_del_nexthop+0x257/0x6d0 net/ipv4/nexthop.c:3256
rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2556
netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
netlink_sendmsg+0x8e0/0xcb0 net/netlink/af_netlink.c:1902
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0x221/0x270 net/socket.c:745
____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
___sys_sendmsg net/socket.c:2638 [inline]
__sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
do_syscall_64+0xf9/0x240
entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f5fe207dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5fe2d910c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5fe21abf80 RCX: 00007f5fe207dda9
RDX: 0000000000000000 RSI: 0000000020000440 RDI: 0000000000000003
RBP: 00007f5fe20ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5fe21abf80 R15: 00007fff7d5a1278

