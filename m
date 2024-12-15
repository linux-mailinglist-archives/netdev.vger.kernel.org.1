Return-Path: <netdev+bounces-152004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A24B9F251C
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DF916487F
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831FD1B4128;
	Sun, 15 Dec 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ty3ShekP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFC314A4D4
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734284550; cv=none; b=n3h2fkQ+foIcjzstvQc+pUYWujqVRUgg+pBMZNQUZ7SySt67Go7C7YR1zgHGZJNsQiK2wHVXrBwfuf4nwhIh83DqBEpaDkIr5acEcp6suAxaedSbJw/eHFO3xdYbwlI8pWgj5q4viw4GHGnCUq1gI2iQxru5W9aB53UZDcpibb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734284550; c=relaxed/simple;
	bh=0g00IIcvIzy/z06zGWUmiw/Bf3bPzghsBoVa9ZAJmOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEJtdnzWEG9sFw5f+ZAVOQTFZaQHs0qNYfvBql/CTT75ZjvK2kE3h++yXN7AlI5EGSjDpcc3NLM4wj0MRHA5GSxUkr0pIqZDoqyC56BmvletafCJfL/P5Mdw+V5gUT/pC32xmfhMifJgJ6YEfORIyoPfIGvqDBaOAH5vf9VwIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ty3ShekP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so5389624a12.3
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 09:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734284546; x=1734889346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DP5rqwEmW+kZD+0hzW4hsA7W9pfg87g1+ByVuwIj+U=;
        b=Ty3ShekPT4AP2cZ8MgDVRkFK07iZVXy5fwjt7ZdK5m60pXubVQs+X0dUlMDYm7MVoJ
         FVBc2rp5tVY5IRXAtaPpWzEnlfsr6rqS83JCissOwMeCLnC3j7QEPqUgVpWgLNiDz/5t
         LuA6fyBHxT2ku06Qyyuiwiggejidm/DHyqlKsgkhgbARFDntbk2wqz3Y7omPa/nCobgW
         VyRuFTDP+ymeO/BGenCzag7cLaq/FHTLJm4j2H0MCt3cEessRKZ4pl2uHf+maEnnkgPG
         TDvdVop+NmO5o7QqcALUpNKlmvIgJdJQtKshG0ofgqc6QlDPdrQimz8GYiXel994gEfv
         DVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734284546; x=1734889346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DP5rqwEmW+kZD+0hzW4hsA7W9pfg87g1+ByVuwIj+U=;
        b=eJim/2ubV/PvrE20B1wRBj2h3atPo2Av8mcyZLECm3urIkAojzh3MBCqPmcHdta6mf
         kh48gk5RMse/icXSQ7iensz3R8Tvdm4CGJE7XGoKK40bxD1sKQnpwREgthhSTdhevu5c
         icO0dE43CTeQ6azRG64Ceca1OqxlnHRU5npHiZx/ljc1ZyfITvbVkj4QvZbD92rJGxyG
         KpvfA7NmXOYQ+FLxTdssVbSXGOs13jmTZGUxk3Z4V/12t1wyuA6ebFuYZP8syrw1xNWO
         1+V6/noEGLqjcH1+H0fNp7qgqgohHI8LBpd8TdiHZrKKu7SdQ5krbOmwMjmL77Oz0xRJ
         gWbA==
X-Forwarded-Encrypted: i=1; AJvYcCUXKlbiKPdIRk9sE0nJFdLSZ5L7jqf2rTg5y7PVNTyTdW39Pzf50QHlL6IYWu4jL5Z0qbKBS34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3GBxmWcALZ+On4/qjUABDss4UYr8megycifdlFKDaYZIF0THW
	C0PfZTJPQMSiO9zdBNIt9/FHuEzwkA830mYXbRPw6a5TMdo+4DsZQ2Yawc8TDbs9X6ez7rznheG
	Wehu3SUgJL65x3gtRrwZeiieMyGHRtccYj5Fb
X-Gm-Gg: ASbGnctahXSsMBpdp7aWzvk4CnGIX8pf3KGcYtu4hwjY41CTfnbFRiWFx6hRjKguSyr
	Kurswt+/zfEFDssQRrNHIZbd9ek63QZa4LQJzqA==
X-Google-Smtp-Source: AGHT+IE+OOrZWNtocAL7BSNv3YyKLxM7sFRGQoWNY3OQzqDuYCxO6d4mbOE8ptnuG0IlNFW/WFf3KYDFHxG2blfOa+0=
X-Received: by 2002:a05:6402:3890:b0:5cf:bcaf:98ec with SMTP id
 4fb4d7f45d1cf-5d63c3a96a7mr9237797a12.26.1734284546234; Sun, 15 Dec 2024
 09:42:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213130212.1783302-1-edumazet@google.com> <20241213130212.1783302-5-edumazet@google.com>
 <Z176ZdYvXpwm6bpa@shredder>
In-Reply-To: <Z176ZdYvXpwm6bpa@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 15 Dec 2024 18:42:15 +0100
Message-ID: <CANn89iJgOA3SUfT_vEujxSpHjbGkr1yAmHYKw6dbnjfZ0ZuJow@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] inetpeer: do not get a refcount in inet_getpeer()
To: Ido Schimmel <idosch@idosch.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 4:48=E2=80=AFPM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Fri, Dec 13, 2024 at 01:02:12PM +0000, Eric Dumazet wrote:
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index 5eeb9f569a706cf2766d74bcf1a667c8930804f2..7a1b1af2edcae0b0648ef3c=
3411b4ef36e6d9b14 100644
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -322,11 +322,11 @@ static bool icmpv4_xrlim_allow(struct net *net, s=
truct rtable *rt,
> >               goto out;
> >
> >       vif =3D l3mdev_master_ifindex(dst->dev);
> > +     rcu_read_lock();
> >       peer =3D inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif);
> >       rc =3D inet_peer_xrlim_allow(peer,
> >                                  READ_ONCE(net->ipv4.sysctl_icmp_rateli=
mit));
> > -     if (peer)
> > -             inet_putpeer(peer);
> > +     rcu_read_unlock();
> >  out:
> >       if (!rc)
> >               __ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
>
> Maybe convert l3mdev_master_ifindex() to l3mdev_master_ifindex_rcu() and
> move it into the RCU critical section?
>
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 7a1b1af2edca..094084b61bff 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -312,7 +312,6 @@ static bool icmpv4_xrlim_allow(struct net *net, struc=
t rtable *rt,
>         struct dst_entry *dst =3D &rt->dst;
>         struct inet_peer *peer;
>         bool rc =3D true;
> -       int vif;
>
>         if (!apply_ratelimit)
>                 return true;
> @@ -321,9 +320,9 @@ static bool icmpv4_xrlim_allow(struct net *net, struc=
t rtable *rt,
>         if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
>                 goto out;
>
> -       vif =3D l3mdev_master_ifindex(dst->dev);
>         rcu_read_lock();
> -       peer =3D inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif);
> +       peer =3D inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
> +                              l3mdev_master_ifindex_rcu(dst->dev));
>         rc =3D inet_peer_xrlim_allow(peer,
>                                    READ_ONCE(net->ipv4.sysctl_icmp_rateli=
mit));
>         rcu_read_unlock();
>
> [...]
>
> > @@ -975,9 +975,9 @@ static int ip_error(struct sk_buff *skb)
> >               break;
> >       }
> >
> > +     rcu_read_lock();
> >       peer =3D inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr,
> >                              l3mdev_master_ifindex(skb->dev));
> > -
> >       send =3D true;
> >       if (peer) {
> >               now =3D jiffies;
>
> And here?
>
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index d2086648dcf1..9f9d4e6ea1b9 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -977,7 +977,7 @@ static int ip_error(struct sk_buff *skb)
>
>         rcu_read_lock();
>         peer =3D inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr,
> -                              l3mdev_master_ifindex(skb->dev));
> +                              l3mdev_master_ifindex_rcu(skb->dev));
>         send =3D true;
>         if (peer) {
>                 now =3D jiffies;

Good ideas, I will add this to V2, thanks !

