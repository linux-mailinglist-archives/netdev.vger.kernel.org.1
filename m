Return-Path: <netdev+bounces-73790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFD285E6D0
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6F91C208A3
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7085937;
	Wed, 21 Feb 2024 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZsQ4FDH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C14E8563E
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541850; cv=none; b=l3/BsXOJ4WsjTMEg21YqA+0dOqETRKTIoTRvxbY6tnAILovAX4y27+x9eyMTIkgxYySSXqdmBqYMQTkBSaMeAS+IJ4RKA8oKegieFe7UrRyQ6E2pRFIiw6L5JlUXXo1hoggXkoBJe+k7t0tPECJxQvZEaVhsHyYa5vyQ27oXRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541850; c=relaxed/simple;
	bh=PVPLKsrN9b7hVI4Cpbuvg5haCWGInugBqyJ80ir4kN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ui2BzLN6DWFcdCeey6At6I2J9b0bLs7GERgno+KLJuVpMnVhFG7Pvqke62qm6Wm3tSFAaL9RVruUVr4PQumarZofDGVH/ozkZnO5OFzPceAkT3XU7PIFA+lqLptzacw0FX45PPglbWUoBQsQMtzMk2mQn5W7xaodedcw4Od3X58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZsQ4FDH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso8495e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708541847; x=1709146647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvbU3fSwv0gb/SXWD4R1MNvG7LRLazocBG6R6xwNCoQ=;
        b=BZsQ4FDH3TSkBL2KM/JHfH57/vDIGKP7V+9n5RQGw5PKWmT1n9OwRpnz6cvPXNgXVH
         y+6qiXOpxhKiCz3pD0GPHs+Tb9ML0MvqeaTUFSTw3PZMhydNcM8EQzMuqQL1r9C0MWhB
         ugMdpVecusUiU86BvwkCy60yz2UhAo71JhlszLJCJuw69oZFd/C7kmkT/rBUFC44irAJ
         4iezJQcZVWeWQBcbLmUvKP/31r29f9EDGV2EBYpwX79wzinVOwnbcO6NRtu6CqA5c8GG
         HIpVm3wvmcPWGkEscYGwdREBeFDYkJ9YQjQtKemU9648FGkmdRGrdrrVJKcAa5ZH6L0t
         uejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708541847; x=1709146647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvbU3fSwv0gb/SXWD4R1MNvG7LRLazocBG6R6xwNCoQ=;
        b=r0XDSEA8iBQz7AfKiGNattjJrmWxG5GiVDEzgl6YR0/Kv9S2XnLC9OQQHHSDilaes4
         t+lGXxIMyIvBq2ks2VP34K7AUanMJ57DT+qc9QCeZXLV5CWsf/HfH/V1uzlEUxRKH6Vx
         2sKfUEa3jLXYSU0MnYk6KcFadFtX1CXBaDhTIbxAbQEwj9Y4ZokeJm9IslO9ZkqE8YjT
         DErGOdmXbZnOj4tGIr49FfcUEm65lU/dRjuKeUbrdZdnwVhBEpAExe5Lm8eMhu5iHeIE
         I99JNUdsRfJhdlMTuoOiL0dbzHat+3dB3/KAYR+ga3IbDCReEKzdddL2G1XlcxTRq4gX
         bVJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXspSqn8lqZG7R/e6i8/Z6SXqv9SYwBSO/Snx6pnBdjwqGZPZut8IW+S/6gTV7lFc1xjphfEkFeV/7zp4pNKNdGGdmtgk2c
X-Gm-Message-State: AOJu0Yx6lhuTQg9lrPVOm/cH6Zz1W0QPDFl1w/7bznVV6giH0zDKW1AL
	u9mCJ+/3/dVmt1TyEokfn38iPWBj0t4jgFw1qKLm2Cd6ZTg5fE7gYPVQcCk59anpgpACZh5taFl
	CNpysGV6RTHyppPYl0CPUHl5gYCQNKgVfk77m
X-Google-Smtp-Source: AGHT+IGE30Z3jRQG4Tp3vqZwaaoM+dopiRQKUqc6nNJq3dSR43Rcs+e7q+8gBINr+nB+NGaXg7SAbp+6ErtQhN2ZaB4=
X-Received: by 2002:a05:600c:a384:b0:412:7585:b26 with SMTP id
 hn4-20020a05600ca38400b0041275850b26mr204373wmb.1.1708541846475; Wed, 21 Feb
 2024 10:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com> <20240221105915.829140-5-edumazet@google.com>
 <ZdZDWVdjMaQkXBgW@shredder>
In-Reply-To: <ZdZDWVdjMaQkXBgW@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 19:57:12 +0100
Message-ID: <CANn89iJBcDTFUUfc_ZfY3visP26ziRMsdAZCmBNsZQFtJzLy4Q@mail.gmail.com>
Subject: Re: [PATCH net-next 04/13] ipv6: use xarray iterator to implement inet6_dump_ifinfo()
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 7:39=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Wed, Feb 21, 2024 at 10:59:06AM +0000, Eric Dumazet wrote:
> > Prepare inet6_dump_ifinfo() to run with RCU protection
> > instead of RTNL and use for_each_netdev_dump() interface.
> >
> > Also properly return 0 at the end of a dump, avoiding
> > an extra recvmsg() system call and RTNL acquisition.
> >
> > Note that RTNL-less dumps need core changes, yet to come.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Ido Schimmel <idosch@nvidia.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> BTW, not sure if you saw, but there's a failure in the fib_nexthops test
> in Jakub's CI due to a lockdep splat [1]. Reproducer:

I have not seen this yet, thanks !

>
> # ip link add name dummy1 up type dummy
> # ip nexthop add id 1 dev dummy1
> # ip nexthop add id 2 dev dummy1
> # ip nexthop add id 10 group 1/2
> # ip route add 198.51.100.0/24 nhid 10
> # ip -4 r s
>
> Seems like an oversight in nexthop code and fixed by:
>
> diff --git a/include/net/nexthop.h b/include/net/nexthop.h
> index 6647ad509faa..77e99cba60ad 100644
> --- a/include/net/nexthop.h
> +++ b/include/net/nexthop.h
> @@ -317,7 +317,7 @@ static inline
>  int nexthop_mpath_fill_node(struct sk_buff *skb, struct nexthop *nh,
>                             u8 rt_family)
>  {
> -       struct nh_group *nhg =3D rtnl_dereference(nh->nh_grp);
> +       struct nh_group *nhg =3D rcu_dereference_rtnl(nh->nh_grp);
>         int i;
>

Indeed, and this is followed few lines later by

    struct nh_info *nhi =3D rcu_dereference_rtnl(nhe->nh_info); // This
was done nicely

