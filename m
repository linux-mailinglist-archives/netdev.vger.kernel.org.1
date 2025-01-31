Return-Path: <netdev+bounces-161811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAFFA2425E
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F7B168C17
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD26A1DED74;
	Fri, 31 Jan 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jzERPVC0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB4C4315A
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738347073; cv=none; b=I+PkPjMWEHyRIftqNE+rB+Z/B+RZXbUNE9Ovd8c+8pXrCbc97/F/O9VYbUDIhchciGR9rXC4yqJiB5OzWg+KYyBGxnfbVXhKDvv6x08JyiABV1Tgp66jBVIyZ1Eam3G1ODIEisRDYF7zLCjmQ51mmQbC9ut7LrYW8w9JHRJojuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738347073; c=relaxed/simple;
	bh=J3y06eoMKVASo/R/YCpZaexX2rgCdZaW4srGOZPAJpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4TI0ArbIfD1zyz+9pBrxZNfyGTGEjMztmF4H+8/IEP1L7A9Ra3sMb+Y0wSulH0jzVtFuGp26lvCevNhB1mjkpznmTHtqxAEIbIcQwvKH7a5vk7Y+q2Eymv5yb6VSQyau/aMKtcek2Scv6uuzNtdRggzt83lfsAHatg6bgbiljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jzERPVC0; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738347072; x=1769883072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=63rFvi+O1aMltd7UavBny7fFkMulxBxmGP6H5CdPe3U=;
  b=jzERPVC0+dp1nCO6ZRSJnLMZp0nkc8rS3UBS6Tpuqv7+QOtapm0vnYaF
   JlsxKvYierAoysPKcJ2OcHm5JP3KGqOp9IdJtF8JyV2CfLhyl38vTptzw
   GHzx/f27sFVyAIthu9C8mbGrV9ggamn5ouCvEygv2WYXdBu6QdyTguD5v
   0=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="18755063"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 18:11:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:26666]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.117:2525] with esmtp (Farcaster)
 id 6c697415-e8c7-4692-9ae0-c4ed9275d104; Fri, 31 Jan 2025 18:11:09 +0000 (UTC)
X-Farcaster-Flow-ID: 6c697415-e8c7-4692-9ae0-c4ed9275d104
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 18:11:00 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 18:10:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ychemla@nvidia.com>
Subject: Re: [PATCH v1 net 1/2] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
Date: Fri, 31 Jan 2025 10:10:49 -0800
Message-ID: <20250131181049.88262-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iJzav0za=tJq7MvXpEXYNFY_+1D6==w2jbKd0-0mhKO4g@mail.gmail.com>
References: <CANn89iJzav0za=tJq7MvXpEXYNFY_+1D6==w2jbKd0-0mhKO4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 05:33:49 +0100
> On Fri, Jan 31, 2025 at 12:25 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
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
> > It calls maybe_get_net() for dev_net(dev) and checks dev_net(dev)
> > before/after rtnl_net_lock().
> >
> > The dev_net(dev) pointer itself is valid, thanks to RCU API, but the
> 
> I am pretty sure dev_net(net) is not always called under rcu_read_lock().

Ah, exactly !
Why I didn't notice that while writing changelog :S


> 
> And RTNL would not help in the future either.
> 
> > netns might be being dismantled.  maybe_get_net() is to avoid the race.
> > This can be done by holding pernet_ops_rwsem, but it will be overkill.
> >
> > [0]:
> 
> > Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().")
> > Reported-by: Yael Chemla <ychemla@nvidia.com>
> > Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Tested-by: Yael Chemla <ychemla@nvidia.com>
> > ---
> >  net/core/dev.c | 59 +++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 46 insertions(+), 13 deletions(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index c0021cbd28fc..f91ddb7f8bdf 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -2070,6 +2070,47 @@ static void __move_netdevice_notifier_net(struct net *src_net,
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
> > +again:
> > +       /* netns might be being dismantled. */
> 
> rcu_read_lock();
> 
> > +       net = maybe_get_net(dev_net(dev));
> 
> rcu_read_unlock();

I'll wait for your first dev_net_rcu() series to be applied and
then repost v2 with rcu_read_lock() and dev_net_rcu() next week.


> 
> 
> 
> > +       if (!net) {
> > +               cond_resched();
> 
> cond_resched() can be a NOP on some kernel builds.
> 
> This loop might burn a lot of cpu cycles.
> 
> Perhaps msleep(1) instead.

I didn't know that, will use msleep(1).


> 
> > +               goto again;
> > +       }
> > +
> 
> 
> > +       rtnl_net_lock(net);
> > +
> > +       /* dev might have been moved to another netns. */
> > +       if (!net_eq(net, dev_net(dev))) {
> > +               rtnl_net_unlock(net);
> > +               put_net(net);
> > +               cond_resched();
> 
>       This cond_resched() seems unnecessary, the net change can not
> occur more than once per rcu grace period (an eternity)

Will remove cond_resched() here.

Thank you!

