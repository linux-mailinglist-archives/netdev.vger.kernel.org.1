Return-Path: <netdev+bounces-165400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0BA31E7B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF901888EFA
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37BA1FAC53;
	Wed, 12 Feb 2025 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nR2iRnm0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F711CA9
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340563; cv=none; b=TNAr/vUWOkHvBJhEwPdDHDBPR2dLXlObElqd7Y+ll5BcLQ/6hvFlroR0YulSJPqXIl7O4loJB+DJcc1/rkFGez5eeGo7AcrdzTV7S4/PEStVhh6HL7Pfc6uOVz4B4ksf1pOo9Sonk66Nn+lIvq6gp0K082ylgiVX5Zss1bHHPvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340563; c=relaxed/simple;
	bh=kKYLyn4sckd1BFygUc0gjU9D7sM2jN5X7sReePVZE4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uy0uYKhqr7XyQfrayOhvvhJOnMq4dOg601YRKlqvEI32ZTHn8W1XGUffGi3nt2FcxECqn3GxM4+SDzV+kLEEetzEpM1BA0f6k5XLMAzrxP8klXVD4bMEWq+Cye/FhtH9OCU3Omr4LsFayF75o9plCGX6gvBKJxVkSBghb6CSeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nR2iRnm0; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739340563; x=1770876563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UtGpeD8BFnfOEaSM9Ev20GdCP3fRO4g8eV2YEtxBhY8=;
  b=nR2iRnm0yBac6YD0hQpIfh173EVrG2GzcQjhibG4wE7t9AM65yrzcteU
   jcv5QdDyHYm2vlNZg+DGlh3f8wLHQfjG1nUV0lIbJxreHh1a9E4VnOyeg
   EYIIpkK/43YWaaVA+qyODu8WsWp7UDkrUfcWLNAW/I0huZtcrSqAbkaSQ
   I=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; 
   d="scan'208";a="471439041"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 06:09:19 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:49216]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.59:2525] with esmtp (Farcaster)
 id 3f4b9578-2529-414f-a7ec-0e83c1f2a570; Wed, 12 Feb 2025 06:09:18 +0000 (UTC)
X-Farcaster-Flow-ID: 3f4b9578-2529-414f-a7ec-0e83c1f2a570
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 06:09:17 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.86) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Feb 2025 06:09:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ychemla@nvidia.com>
Subject: Re: [PATCH v3 net 1/2] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
Date: Wed, 12 Feb 2025 15:09:05 +0900
Message-ID: <20250212060905.14400-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89i+oUCt2VGvrbrweniTendZFEh+nwS=uonc004-aPkWy-Q@mail.gmail.com>
References: <CANn89i+oUCt2VGvrbrweniTendZFEh+nwS=uonc004-aPkWy-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Feb 2025 10:43:30 +0100
> On Tue, Feb 11, 2025 at 6:13 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > After the cited commit, dev_net(dev) is fetched before holding RTNL
> > and passed to __unregister_netdevice_notifier_net().
> >
> > However, dev_net(dev) might be different after holding RTNL.
> >
> > In the reported case [0], while removing a VF device, its netns was
> > being dismantled and the VF was moved to init_net.
> >
> > So the following sequence is basically illegal when dev was fetched
> > without lookup:
> >
> >   net = dev_net(dev);
> >   rtnl_net_lock(net);
> >
> > Let's use a new helper rtnl_net_dev_lock() to fix the race.
> >
> > It fetches dev_net_rcu(dev), bumps its net->passive, and checks if
> > dev_net_rcu(dev) is changed after rtnl_net_lock().
> >
> >
> 
> > Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().")
> > Reported-by: Yael Chemla <ychemla@nvidia.com>
> > Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> > v3:
> >   * Bump net->passive instead of maybe_get_net()
> >   * Remove msleep(1) loop
> >   * Use rcu_access_pointer() instead of rcu_read_lock().
> >
> > v2:
> >   * Use dev_net_rcu().
> >   * Use msleep(1) instead of cond_resched() after maybe_get_net()
> >   * Remove cond_resched() after net_eq() check
> >
> > v1: https://lore.kernel.org/netdev/20250130232435.43622-2-kuniyu@amazon.com/
> > ---
> >  net/core/dev.c | 41 +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 37 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 55e356a68db6..1248fb368e78 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -2070,6 +2070,35 @@ static void __move_netdevice_notifier_net(struct net *src_net,
> >         __register_netdevice_notifier_net(dst_net, nb, true);
> >  }
> >
> > +static void rtnl_net_dev_lock(struct net_device *dev)
> > +{
> > +       struct net *net;
> > +
> 
> #ifdef CONFIG_NET_NS
> > +again:
> #endif
> 
> > +       /* netns might be being dismantled. */
> > +       rcu_read_lock();
> > +       net = dev_net_rcu(dev);
> > +       refcount_inc(&net->passive);
> > +       rcu_read_unlock();
> > +
> > +       rtnl_net_lock(net);
> > +
> 
> #ifdef CONFIG_NET_NS
> 
> > +       /* dev might have been moved to another netns. */
> > +       if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
> > +               rtnl_net_unlock(net);
> > +               net_drop_ns(net);
> > +               goto again;
> > +       }
> 
> #endif
> 
> Or perhaps not use net_drop_ns() and rename/export net_free() to
> net_passive_dec() ?

Ah, we need both guard (for dev->nd_net.net) and net_passive_dec().

Or, we can simply rtnl_net_lock(&init_net) for !CONFIG_NET_NS and
keep net_drop_ns().

The former looked cleaner, so I'll do so in v4.

Thanks!

> 
> 
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 7ba1402ca7796663bed3373b1a0c6a0249cd1599..62d1a1c39547bd5cca71082b8172d453b56a96db
> 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -297,7 +297,7 @@ static inline int check_net(const struct net *net)
>  }
> 
>  void net_drop_ns(void *);
> -
> +void net_passive_dec(struct net *net);
>  #else
> 
>  static inline struct net *get_net(struct net *net)
> @@ -326,6 +326,11 @@ static inline int check_net(const struct net *net)
>  }
> 
>  #define net_drop_ns NULL
> +static inline void net_passive_dec(struct net *net)
> +{
> +       refcount_dec(&net->passive);
> +}
> +
>  #endif
> 
>  /* Returns true if the netns initialization is completed successfully */
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index cb39a12b2f8295c605f08b5589932932150a1644..4303f2a4926243e2c0ff0c0387383cd8e0658019
> 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -464,7 +464,7 @@ static void net_complete_free(void)
> 
>  }
> 
> -static void net_free(struct net *net)
> +void net_passive_dec(struct net *net)
>  {
>         if (refcount_dec_and_test(&net->passive)) {
>                 kfree(rcu_access_pointer(net->gen));
> @@ -482,7 +482,7 @@ void net_drop_ns(void *p)
>         struct net *net = (struct net *)p;
> 
>         if (net)
> -               net_free(net);
> +               net_passive_dec(net);
>  }
> 
>  struct net *copy_net_ns(unsigned long flags,
> @@ -523,7 +523,7 @@ struct net *copy_net_ns(unsigned long flags,
>                 key_remove_domain(net->key_domain);
>  #endif
>                 put_user_ns(user_ns);
> -               net_free(net);
> +               net_passive_dec(net);
>  dec_ucounts:
>                 dec_net_namespaces(ucounts);
>                 return ERR_PTR(rv);
> @@ -672,7 +672,7 @@ static void cleanup_net(struct work_struct *work)
>                 key_remove_domain(net->key_domain);
>  #endif
>                 put_user_ns(net->user_ns);
> -               net_free(net);
> +               net_passive_dec(net);
>         }
>         cleanup_net_task = NULL;
>  }

