Return-Path: <netdev+bounces-141663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E151E9BBEE5
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F75628105E
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01901F5854;
	Mon,  4 Nov 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j9/Vkg45"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4701F584A
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752819; cv=none; b=rT8194rXdg5BUboeP+HCUEwP7ipCK9B3tcbjYJ4Ppm8ggQr49uD1VM8calIZGwzZ0WgJp8fubcgE4/O7wkVru8uuJ82hcKJ4fOMhS5kzcz1qK+osixdx1V17NLIniSTw9mePYAaUQEPOveiqFMnpodBUTiTAoWYUYW3ZdtAnUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752819; c=relaxed/simple;
	bh=qf8p+dLzG/OpvDN0DwjGbePuYHScU5swdvaefylRA5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QP6Kkryng5t4BTSMat9+v0gV5Xb0pf06sgPDDZfIiKN8M/Uv2bypxMedMS41onOoyTyDoMYwh2jMG3yX+rpuFRJP4MRNAmZFxfCLwVf4olWURlunU23wTMcN0KFc6bHN4rpPP+Pgowi5kz9/AnW0emwmBbYVNnoIie2JWGAK4gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=j9/Vkg45; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730752818; x=1762288818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NSxhmbX/7pkJ/tSnWEUTjcv5Gb3NL4JBAwI0XAndtQ=;
  b=j9/Vkg45n7UmNiiALz+f4hgcKoUV3h7QBoT9ziZ87KLDxgeUVcYFw1Cc
   2Lrlf3l8YspEheWfmcEpgteE++qBJpldfHhLw1aK2i8h2fN902RRZRpZI
   wKz3tYgNmM3OZBx2eQPZyjpobJf/1uIEL7mIPh5NCphCQIsBJzc913LXk
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,258,1725321600"; 
   d="scan'208";a="693002893"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 20:40:15 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:29573]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.102:2525] with esmtp (Farcaster)
 id d89a45f8-5c70-42c9-810c-fedfb0993820; Mon, 4 Nov 2024 20:40:14 +0000 (UTC)
X-Farcaster-Flow-ID: d89a45f8-5c70-42c9-810c-fedfb0993820
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 4 Nov 2024 20:40:10 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 4 Nov 2024 20:40:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <courmisch@gmail.com>, <davem@davemloft.net>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH net-next] phonet: do not call synchronize_rcu() from phonet_route_del()
Date: Mon, 4 Nov 2024 12:40:05 -0800
Message-ID: <20241104204005.86813-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241104152622.3580037-1-edumazet@google.com>
References: <20241104152622.3580037-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon,  4 Nov 2024 15:26:22 +0000
> Calling synchronize_rcu() while holding rcu_read_lock() is not
> permitted [1]

Thanks for catching this !

> 
> Move the synchronize_rcu() to route_doit().
> 
> [1]
> WARNING: suspicious RCU usage
> 6.12.0-rc5-syzkaller-01056-gf07a6e6ceb05 #0 Not tainted
> -----------------------------
> kernel/rcu/tree.c:4092 Illegal synchronize_rcu() in RCU read-side critical section!
> 
> other info that might help us debug this:
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by syz-executor427/5840:
>   #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>   #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>   #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: route_doit+0x3d6/0x640 net/phonet/pn_netlink.c:264
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 5840 Comm: syz-executor427 Not tainted 6.12.0-rc5-syzkaller-01056-gf07a6e6ceb05 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   lockdep_rcu_suspicious+0x226/0x340 kernel/locking/lockdep.c:6821
>   synchronize_rcu+0xea/0x360 kernel/rcu/tree.c:4089
>   phonet_route_del+0xc6/0x140 net/phonet/pn_dev.c:409
>   route_doit+0x514/0x640 net/phonet/pn_netlink.c:275
>   rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6790
>   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
>   netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
>   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>   sock_sendmsg_nosec net/socket.c:729 [inline]
>   __sock_sendmsg+0x221/0x270 net/socket.c:744
>   sock_write_iter+0x2d7/0x3f0 net/socket.c:1165
>   new_sync_write fs/read_write.c:590 [inline]
>   vfs_write+0xaeb/0xd30 fs/read_write.c:683
>   ksys_write+0x183/0x2b0 fs/read_write.c:736
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 17a1ac0018ae ("phonet: Don't hold RTNL for route_doit().")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Remi Denis-Courmont <courmisch@gmail.com>
> ---
>  net/phonet/pn_dev.c     |  4 +++-
>  net/phonet/pn_netlink.c | 10 ++++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
> index 19234d664c4fb537eba0267266efbb226cf103c3..578d935f2b11694fd1004c5f854ec344b846eeb2 100644
> --- a/net/phonet/pn_dev.c
> +++ b/net/phonet/pn_dev.c
> @@ -406,7 +406,9 @@ int phonet_route_del(struct net_device *dev, u8 daddr)
>  
>  	if (!dev)
>  		return -ENOENT;
> -	synchronize_rcu();
> +
> +	/* Note : our caller must call synchronize_rcu() */
> +
>  	dev_put(dev);

Are these synchronize_rcu() + dev_put() paired with rcu_read_lock()
and dev_hold() in phonet_route_output() ?

If so, we need to move dev_put() too or maybe we can remove
synchronize_rcu() here and replace rcu_read_lock() with
spin_lock(&routes->lock) in phonet_route_output().


>  	return 0;
>  }
> diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
> index ca1f04e4a2d9eb3b2a6d6cc5b299aee28d569b08..24930733ac572ed3ec5fd142d347c115346a28fa 100644
> --- a/net/phonet/pn_netlink.c
> +++ b/net/phonet/pn_netlink.c
> @@ -233,6 +233,7 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>  {
>  	struct net *net = sock_net(skb->sk);
>  	struct nlattr *tb[RTA_MAX+1];
> +	bool sync_needed = false;
>  	struct net_device *dev;
>  	struct rtmsg *rtm;
>  	u32 ifindex;
> @@ -269,16 +270,21 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		return -ENODEV;
>  	}
>  
> -	if (nlh->nlmsg_type == RTM_NEWROUTE)
> +	if (nlh->nlmsg_type == RTM_NEWROUTE) {
>  		err = phonet_route_add(dev, dst);
> -	else
> +	} else {
>  		err = phonet_route_del(dev, dst);
> +		if (!err)
> +			sync_needed = true;
> +	}
>  
>  	rcu_read_unlock();
>  
>  	if (!err)
>  		rtm_phonet_notify(net, nlh->nlmsg_type, ifindex, dst);
>  
> +	if (sync_needed)
> +		synchronize_rcu();
>  	return err;
>  }
>  
> -- 
> 2.47.0.163.g1226f6d8fa-goog

