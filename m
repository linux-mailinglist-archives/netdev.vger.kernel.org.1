Return-Path: <netdev+bounces-166247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E8A352CA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 01:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3369A188FEEB
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 00:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9732753FD;
	Fri, 14 Feb 2025 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HyhWX91q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6015D1
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492776; cv=none; b=Bf1sKLcXx6gwvOM3dLcdFrmuzeb9vw7Pjppt+uqfJOkWoLO0W4rWzbbZtRX6srO7RcKvAvar4thYk1ygRRSVEwPotzGDibiXWkHzd90d1awLpNl96Zuh/FgE3DS9V8vengNmRSRywiACWWwUOC0waV9/ixi63LahVY4ndMQDaw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492776; c=relaxed/simple;
	bh=Rj+eoPBPUGfFyHGdZiHvXhQMrKmJchvFBcJBbruSTNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YW8n3OxI9RArFPtNX4PQSp15rhs5gI3CtgYkwgf/sD5OdjWrfKMQZ7t85+A81E/JPYiRetnwgvjwYvcxI6Kp/4vf4ZSeaov8kUekrHufidMizImgkpoNfUvxjJRUOvoXM1OF6yhVvcQyetg8JiRWo1qtF5PGHsmd5/huTPDXhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HyhWX91q; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739492774; x=1771028774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BTs3Vj0dcvSqfUVUQyIVMkcqChSIpiwrCWs0zfFKhEg=;
  b=HyhWX91qVWNXUIugGh5LEVlc0lT36XY6EX6tw7OVG4SKOg3Ru42qpMfF
   1w77/8ShJ77Zm/vWECEig/nrAFGYgZfJJq80KlDZsFHuORDRSzuCjaYGX
   bPRMF1WEXqOotAmVIpY+Qi307nx/k/3iVLb2dT39y8Rk6xFix9XFdQkHQ
   M=;
X-IronPort-AV: E=Sophos;i="6.13,284,1732579200"; 
   d="scan'208";a="169539986"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 00:26:12 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:22315]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.115:2525] with esmtp (Farcaster)
 id c08dd6f5-6a66-437c-83e0-3dcfecf1b323; Fri, 14 Feb 2025 00:26:12 +0000 (UTC)
X-Farcaster-Flow-ID: c08dd6f5-6a66-437c-83e0-3dcfecf1b323
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 14 Feb 2025 00:26:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.254.117) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Feb 2025 00:26:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ychemla@nvidia.com>
Subject: Re: [PATCH v4 net 2/3] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
Date: Fri, 14 Feb 2025 09:25:57 +0900
Message-ID: <20250214002557.27185-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213083217.77e18e10@kernel.org>
References: <20250213083217.77e18e10@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 13 Feb 2025 08:32:17 -0800
> On Wed, 12 Feb 2025 15:42:05 +0900 Kuniyuki Iwashima wrote:
> > +static void rtnl_net_dev_lock(struct net_device *dev)
> > +{
> > +	struct net *net;
> > +
> > +#ifdef CONFIG_NET_NS
> > +again:
> > +#endif
> > +	/* netns might be being dismantled. */
> > +	rcu_read_lock();
> > +	net = dev_net_rcu(dev);
> > +	net_passive_inc(net);
> > +	rcu_read_unlock();
> > +
> > +	rtnl_net_lock(net);
> > +
> > +#ifdef CONFIG_NET_NS
> > +	/* dev might have been moved to another netns. */
> > +	if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
> > +		rtnl_net_unlock(net);
> > +		net_passive_dec(net);
> > +		goto again;
> > +	}
> > +#endif
> 
> Is there a plan to clean this up in net-next? Or perhaps after Eric's
> dev_net() work? Otherwise I'm tempted to suggest to use a loop, maybe:

For sure, I will post a followup patch to net-next.

Thanks!


> 
> 	bool again;
> 
> 	do {
> 		again = false;
> 
> 		/* netns might be being dismantled. */
> 		rcu_read_lock();
> 		net = dev_net_rcu(dev);
> 		net_passive_inc(net);
> 		rcu_read_unlock();
> 
> 		rtnl_net_lock(net);
> 
> #ifdef CONFIG_NET_NS
> 		/* dev might have been moved to another netns. */
> 		if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
> 			rtnl_net_unlock(net);
> 			net_passive_dec(net);
> 			again = true;
> 		}
> #endif
> 	} while (again);

