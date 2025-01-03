Return-Path: <netdev+bounces-155005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B5A009F6
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 14:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C975418845C4
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 13:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11171EE7C5;
	Fri,  3 Jan 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WXmpR9TI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED978158553
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735911489; cv=none; b=mHL5t8DBdCoOSJBbva6M9IWD7hKcRJ9Mrm9VAoOo0RlbyH5zUzqLC/rEap9DzQ2Ze2tTuhJwbVXGuUkGC9Yyvg8p5fR446v6SPgdxA996nzjgD0976cIKbbJcNtx3BWiFC1fXs5vAcmSf1bnOd4SSAiBIlnuE3kU3Z9aZQDpPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735911489; c=relaxed/simple;
	bh=TUy/v2Lp8c08e+iOiygORE2hr6sS4hrPyjpbAv5RL3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWZehtnwhtif42zf1KXGV6k6h7iDZNXamXdj0ygX9cYQzs7S7YWTOIPSIZYjo/t6awoROzmJ5hFmi6+ZUhfaXcabfD9LnTSotoLBHuEyQPeCVdAh/Hav1ToLvU0mbsdJvR9l69V3b8bnK/egGJ40B2eduIbgJpB+SMHDAN2Ytc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WXmpR9TI; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735911487; x=1767447487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cFOhUp6fdFM2tBRc5o39pXNPmAOP9HIA75ACqW2pBQs=;
  b=WXmpR9TISdrvxIDdn4QV7uAjzGLA2igoYF5iQ/YC7f7EdSidDEYJyIK+
   Vx5dm62cVIVSncNIXPCkg4X765LlEjLbgL3V3lqmMeBdxBtgvvXapTjzj
   q8UQ7K9Z89wEFYrybzZ5VJaaNLJuMYvig83k0yUs9l6iKvZgEfuX2rlcx
   s=;
X-IronPort-AV: E=Sophos;i="6.12,286,1728950400"; 
   d="scan'208";a="708237824"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 13:38:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:41844]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.144:2525] with esmtp (Farcaster)
 id 3725e560-2227-44a3-8a37-3a5f90488cf2; Fri, 3 Jan 2025 13:38:04 +0000 (UTC)
X-Farcaster-Flow-ID: 3725e560-2227-44a3-8a37-3a5f90488cf2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 3 Jan 2025 13:38:02 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 3 Jan 2025 13:37:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<maheshb@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net] ipvlan: Fix use-after-free in ipvlan_get_iflink().
Date: Fri, 3 Jan 2025 22:37:49 +0900
Message-ID: <20250103133749.76202-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250102174400.085fd8ac@kernel.org>
References: <20250102174400.085fd8ac@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 2 Jan 2025 17:44:00 -0800
> On Wed, 1 Jan 2025 18:10:08 +0900 Kuniyuki Iwashima wrote:
> > syzbot presented a use-after-free report [0] regarding ipvlan and
> > linkwatch.
> > 
> > ipvlan does not hold a refcnt of the lower device.
> > 
> > When the linkwatch work is triggered for the ipvlan dev, the lower
> > dev might have already been freed.
> > 
> > Let's hold the lower dev's refcnt in dev->netdev_ops->ndo_init()
> > and release it in dev->priv_destructor() as done for vlan and macvlan.
> 
> Hmmm, random ndo calls after unregister_netdevice() has returned 
> are very error prone, if we can address this in the core - I think
> that's better.
> 
> Perhaps we could take Eric's commit 750e51603395 ("net: avoid potential
> UAF in default_operstate()") even further?
> 
> If the device is unregistering we can just assume DOWN. And we can use
> RCU protection to make sure the unregistration doesn't race with us?

Sounds good to me.

Will post v2, thanks!


> Just to give the idea (not even compile tested):
> 
> diff --git a/net/core/link_watch.c b/net/core/link_watch.c
> index 1b4d39e38084..985273bc7c0d 100644
> --- a/net/core/link_watch.c
> +++ b/net/core/link_watch.c
> @@ -42,14 +42,20 @@ static unsigned int default_operstate(const struct net_device *dev)
>  	 * first check whether lower is indeed the source of its down state.
>  	 */
>  	if (!netif_carrier_ok(dev)) {
> -		int iflink = dev_get_iflink(dev);
>  		struct net_device *peer;
> +		int iflink;
>  
>  		/* If called from netdev_run_todo()/linkwatch_sync_dev(),
>  		 * dev_net(dev) can be already freed, and RTNL is not held.
>  		 */
> -		if (dev->reg_state == NETREG_UNREGISTERED ||
> -		    iflink == dev->ifindex)
> +		rcu_read_lock();
> +		if (dev->reg_state <= NETREG_REGISTERED)
> +			iflink = dev_get_iflink(dev);
> +		else
> +			iflink = dev->ifindex;
> +		rcu_read_unlock();
> +
> +		if (iflink == dev->ifindex)
>  			return IF_OPER_DOWN;
>  
>  		ASSERT_RTNL();

