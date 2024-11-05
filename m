Return-Path: <netdev+bounces-142048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517999BD377
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D611C221D3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5401DD0CB;
	Tue,  5 Nov 2024 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kJlLOpsv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6237815C144
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828179; cv=none; b=MChxgQJwA3igVzuimNDhLuTKvTkF7WJ5wJeKXBtdYxvJ+J839o4YfjNFlKsmEBcug4DoEkkg5z06VBMOj/0WARDhm261vZ+KkDmDp3bsbl8IS5slc+q11ZjXcpUIvHvWmHQpaQcKzT0lUanHEZvGvQaFaoHLZxFQU60zzO5brv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828179; c=relaxed/simple;
	bh=bxBoMfbZpeKH7kpFOMLlgBqaMGFuWuiMW/zhdUxfoQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Al1LEK0YqSb7bgiDv4wJm9GByMBtd9XjP27S9HQ6Y0m4aR/JTYxlkWTMpMgE1ceoEfi3bofHWqAVFUb5WKJ5UFnjJXo7WPSqfy/GrFaSe/iunVeMj1UWf0JlhImvtGy1xQwrvEYFwlvZIFCSzD5UP7F1K4fxBWjTm0csg1nZ7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kJlLOpsv; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730828178; x=1762364178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1oGp7M+HeMqjXE5TZoqIcevsrzZ9QTe6NwbZHYH2Kdg=;
  b=kJlLOpsv37JDXFrOksVSwRx1DDup66Bd6DhKYZVaQi7e1tVzZLGZAkoA
   jlS0SprHj/5kBT9LAaK9zh0146w5ntfLZK/HNfMmbhWkqwFfrLRxuVN1k
   OwlDN3N+q0bZhNvR12iuXe6nu8D6AW58I+mnMHaCH+sTFnI2CanSRcvjx
   w=;
X-IronPort-AV: E=Sophos;i="6.11,260,1725321600"; 
   d="scan'208";a="39187795"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 17:36:14 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:1244]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.170:2525] with esmtp (Farcaster)
 id 3d2dfe26-6a46-48ad-804b-b828d690ff38; Tue, 5 Nov 2024 17:36:13 +0000 (UTC)
X-Farcaster-Flow-ID: 3d2dfe26-6a46-48ad-804b-b828d690ff38
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 17:36:12 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 17:36:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <courmisch@gmail.com>, <davem@davemloft.net>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 net] phonet: do not call synchronize_rcu() from phonet_route_del()
Date: Tue, 5 Nov 2024 09:35:57 -0800
Message-ID: <20241105173557.43270-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105132645.654244-1-edumazet@google.com>
References: <20241105132645.654244-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue,  5 Nov 2024 13:26:45 +0000
> Calling synchronize_rcu() while holding rcu_read_lock() is not
> permitted [1]
> 
> Move the synchronize_rcu() + dev_put() to route_doit().
> 
> Alternative would be to not use rcu_read_lock() in route_doit().
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

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Remi Denis-Courmont <courmisch@gmail.com>
> ---
> v2: also move dev_put() to keep it after synchronize_rcu()
> 
>  net/phonet/pn_dev.c     |  5 +++--
>  net/phonet/pn_netlink.c | 12 ++++++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
> index 19234d664c4fb537eba0267266efbb226cf103c3..5c36bae37b8fa85d2e97bf11d099c6c8599dcc5f 100644
> --- a/net/phonet/pn_dev.c
> +++ b/net/phonet/pn_dev.c
> @@ -406,8 +406,9 @@ int phonet_route_del(struct net_device *dev, u8 daddr)
>  
>  	if (!dev)
>  		return -ENOENT;
> -	synchronize_rcu();
> -	dev_put(dev);
> +
> +	/* Note : our caller must call synchronize_rcu() and dev_put(dev) */
> +
>  	return 0;
>  }
>  
> diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
> index ca1f04e4a2d9eb3b2a6d6cc5b299aee28d569b08..b9043c92dc246f8c5c313b262eb3ec4afad47ecb 100644
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
> @@ -269,13 +270,20 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
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
> +	if (sync_needed) {
> +		synchronize_rcu();
> +		dev_put(dev);
> +	}
>  	if (!err)
>  		rtm_phonet_notify(net, nlh->nlmsg_type, ifindex, dst);
>  
> -- 
> 2.47.0.199.ga7371fff76-goog

