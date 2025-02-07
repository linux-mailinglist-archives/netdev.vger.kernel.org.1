Return-Path: <netdev+bounces-163829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD33A2BBE4
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4426F3A7AF4
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 06:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C0519A297;
	Fri,  7 Feb 2025 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WuHgdbDg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C6199E80
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738911553; cv=none; b=H2xInaIWwkbnKAhFHeEZlsqrd6TccurG1LaH+2n87IUhXCjPO5tfwNt3uD0ODyQ+e5LZQ0vwo3gODvIxkojE17b8D8YqKCPLOtfxpiA+OZ3Vy6qa/98kULrADCx2E2TfmctrkcwaX0Bj8uzc8mPpPLfDAUFY9PHvlhR1SIzS8uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738911553; c=relaxed/simple;
	bh=aSuRtiA2oZXfR+Royha2KG5F+ISDoMH08pNMcN28hbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKxLWUBWcQBNs1O/chDr9pM8oteg8ak8af4MgxJlcguUD0nfpDrLS6cc+CKtwTEUu7DKQBQ92mX/HUolyqBXysi+Z7X6RgA8QbwQYNyUrie5eNM/xRymS1s5Ubc4MqNrSzVYcb2Vui3YILu3Lb+X7XGfWxDjKjqs74H3d4giz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WuHgdbDg; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738911552; x=1770447552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h5hdA0m+2L27rEx47Km6UYv42pjZ1XpmvIcJQQkGdYI=;
  b=WuHgdbDg7jZMk/iVPSUlfuZ04KJV/GdDOpyKisyrkgi3zKvNnuMvQYRm
   Nt6x+mzbIgL0cpCFOut5H4JLdKNt8WoIQG1cjzbR1EZUpx2Rd/Pmju+q8
   py0o6MVOVGEEvwTIijJAF9NTb3MRNqdWeWxLVvWBp0Q/uYMDGlZKsOj32
   w=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="269138269"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 06:59:08 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:64969]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.242:2525] with esmtp (Farcaster)
 id cd64d3d0-37b5-4473-ac97-bbc336724fef; Fri, 7 Feb 2025 06:59:07 +0000 (UTC)
X-Farcaster-Flow-ID: cd64d3d0-37b5-4473-ac97-bbc336724fef
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 06:58:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 06:58:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ychemla@nvidia.com>
Subject: Re: [PATCH v2 net 1/2] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
Date: Fri, 7 Feb 2025 15:58:47 +0900
Message-ID: <20250207065847.83672-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iKdg=_uf-gis1knki-XSTbp-oHSXM0=kP-HFm2H39AWcg@mail.gmail.com>
References: <CANn89iKdg=_uf-gis1knki-XSTbp-oHSXM0=kP-HFm2H39AWcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 07:42:13 +0100
> On Fri, Feb 7, 2025 at 5:43 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
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
> > It calls maybe_get_net() for dev_net_rcu(dev) and checks dev_net_rcu(dev)
> > before/after rtnl_net_lock().
> >
> > The dev_net_rcu(dev) pointer itself is valid, thanks to RCU API, but the
> > netns might be being dismantled.  maybe_get_net() is to avoid the race.
> > This can be done by holding pernet_ops_rwsem, but it will be overkill.
> >
> >
> > Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().")
> > Reported-by: Yael Chemla <ychemla@nvidia.com>
> > Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Tested-by: Yael Chemla <ychemla@nvidia.com>
> > ---
> > v2:
> >   * Use dev_net_rcu().
> >   * Use msleep(1) instead of cond_resched() after maybe_get_net()
> >   * Remove cond_resched() after net_eq() check
> >
> > v1: https://lore.kernel.org/netdev/20250130232435.43622-2-kuniyu@amazon.com/
> > ---
> >  net/core/dev.c | 63 +++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 50 insertions(+), 13 deletions(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index b91658e8aedb..f7430c9d9bc3 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -2070,6 +2070,51 @@ static void __move_netdevice_notifier_net(struct net *src_net,
> >         __register_netdevice_notifier_net(dst_net, nb, true);
> >  }
> >
> > +static bool from_cleanup_net(void)
> > +{
> > +#ifdef CONFIG_NET_NS
> > +       return current == cleanup_net_task;
> > +#else
> > +       return false;
> > +#endif
> > +}
> > +
> > +static void rtnl_net_dev_lock(struct net_device *dev)
> > +{
> > +       struct net *net;
> > +
> > +       DEBUG_NET_WARN_ON_ONCE(from_cleanup_net());
> 
> I would rather make sure rtnl_net_dev_lock() _can_ be called from cleanup_net()
> 
> 
> > +again:
> > +       /* netns might be being dismantled. */
> > +       rcu_read_lock();
> > +       net = maybe_get_net(dev_net_rcu(dev));
> 
> I do not think maybe_get_net() is what we want here.
> 
> If the netns is already in dismantle phase, the count will be zero.

Yes, so I placed the warning above.

Will use net->passive instead, thanks for suggestion!


> 
> Instead:
> 
> net = dev_net_rcu(dev);
> refcount_inc(&net->passive);
> 
> 
> > +       rcu_read_unlock();
> 
> > +       if (!net) {
> > +               msleep(1);
> > +               goto again;
> > +       }
> 
> > +
> > +       rtnl_net_lock(net);
> > +
> > +       /* dev might have been moved to another netns. */
> > +       rcu_read_lock();
> 
> As we do not dereference the net pointer, I would not acquire
> rcu_read_lock() and instead use
> 
> if (!net_eq(net, rcu_access_pointer(dev->nd_net.net)) {

Exactly, will use rcu_access_pointer().


> 
> 
> 
> > +       if (!net_eq(net, dev_net_rcu(dev))) {
> > +               rcu_read_unlock();
> > +               rtnl_net_unlock(net);
> 
> > +               put_net(net);
> instead :
>          net_drop_ns(net);
> 
> > +               goto again;
> > +       }
> > +       rcu_read_unlock();
> > +}
> > +
> > +static void rtnl_net_dev_unlock(struct net_device *dev)
> > +{
> > +       struct net *net = dev_net(dev);
> > +
> > +       rtnl_net_unlock(net);
> 
> And replace the put_net() here and above with:
> 
> net_drop_ns(net);
> 
> > +       put_net(net);
> > +}
> > +
> >  int register_netdevice_notifier_dev_net(struct net_device *dev,
> >                                         struct notifier_block *nb,
> >                                         struct netdev_net_notifier *nn)
> > @@ -2077,6 +2122,8 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
> >         struct net *net = dev_net(dev);
> >         int err;
> >
> 
> > +       DEBUG_NET_WARN_ON_ONCE(!list_empty(&dev->dev_list));
> /* Why is this needed ? */

The following rtnl_net_lock() assumes the dev is not yet published
by register_netdevice(), and I think there's no such users calling
register_netdevice_notifier_dev_net() after that, so just a paranoid..


> 
> > +
> >         rtnl_net_lock(net);
> >         err = __register_netdevice_notifier_net(net, nb, false);
> >         if (!err) {

