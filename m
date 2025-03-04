Return-Path: <netdev+bounces-171810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93974A4EC4C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94AF37AF451
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23124C097;
	Tue,  4 Mar 2025 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RVXqlQ1X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E723312E
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113901; cv=none; b=A+HLfEy/QIroePiYnQLMGlKeJm+/9tH4aw6Fdb4ziq2A/FhOYoyMDWmdbVYHCrglZAiFaYn4fRXOyaRTzaRJX+2JUcZ8w117f0ggpI787yf/ySdCJFwrZb1kojqXFg7mzN+yfb1EI0GExIVwvhOymtQF+aQlauusEgEL/fsjvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113901; c=relaxed/simple;
	bh=K0vyVBX/z7m/nfeOw5UU6Bxl77dBF/zTNNadpikEYcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oz/YPNvEKV7NF7vvcW2ca/85/3Rn/WRVJ+zaSrIKfyrdyGoXrdW05LWrcHafgnx0Mkx6Dk3BpKZmvSSCWD9U0/IMIh/bWRpFg2Z4U+j6xRjAM4zMMSoE+ZUpgplJU2ucgVxGoolsnLekoA7CrZxhIbFaaAkIiU+mLaWdusC4ktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RVXqlQ1X; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741113900; x=1772649900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o0DhpsMqRpOcwyYJ3EoKux1Tln8wF3CkGJUTydued30=;
  b=RVXqlQ1XGoLRttmW8h5ZLsta9CEC1qsgMoomGPjIneBE+Xm/6grqiXsi
   qFvqyqX7PQ5O0hqMVCUzMxAH1KHpD5A9F+pEwRhtOLsmtVfjJSMo9ue4q
   W1FvAU8xC2Gy8vf/+nAVMFDgVpuwcvGE7POTaBUKLZeqxMnPdeI0tBeYD
   0=;
X-IronPort-AV: E=Sophos;i="6.14,220,1736812800"; 
   d="scan'208";a="804199508"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:44:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:9736]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.48:2525] with esmtp (Farcaster)
 id 3bbc151f-e2de-4ab7-ad72-253d82848251; Tue, 4 Mar 2025 18:44:51 +0000 (UTC)
X-Farcaster-Flow-ID: 3bbc151f-e2de-4ab7-ad72-253d82848251
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 18:44:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.149.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 18:44:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+3f18ef0f7df107a3f6a0@syzkaller.appspotmail.com>
Subject: Re: [PATCH net-next] inet: fix lwtunnel_valid_encap_type() lock imbalance
Date: Tue, 4 Mar 2025 10:44:05 -0800
Message-ID: <20250304184408.9444-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304125918.2763514-1-edumazet@google.com>
References: <20250304125918.2763514-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue,  4 Mar 2025 12:59:18 +0000
> After blamed commit rtm_to_fib_config() now calls
> lwtunnel_valid_encap_type{_attr}() without RTNL held,
> triggering an unlock balance in __rtnl_unlock,
> as reported by syzbot [1]
> 
> IPv6 and rtm_to_nh_config() are not yet converted.
> 
> Add a temporary @rtnl_is_held parameter to lwtunnel_valid_encap_type()
> and lwtunnel_valid_encap_type_attr().
> 
> While we are at it replace the two rcu_dereference()
> in lwtunnel_valid_encap_type() with more appropriate
> rcu_access_pointer().
> 
> [1]
> syz-executor245/5836 is trying to release lock (rtnl_mutex) at:
>  [<ffffffff89d0e38c>] __rtnl_unlock+0x6c/0xf0 net/core/rtnetlink.c:142
> but there are no more locks to release!
> 
> other info that might help us debug this:
> no locks held by syz-executor245/5836.
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 5836 Comm: syz-executor245 Not tainted 6.14.0-rc4-syzkaller-00873-g3424291dd242 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   print_unlock_imbalance_bug+0x25b/0x2d0 kernel/locking/lockdep.c:5289
>   __lock_release kernel/locking/lockdep.c:5518 [inline]
>   lock_release+0x47e/0xa30 kernel/locking/lockdep.c:5872
>   __mutex_unlock_slowpath+0xec/0x800 kernel/locking/mutex.c:891
>   __rtnl_unlock+0x6c/0xf0 net/core/rtnetlink.c:142
>   lwtunnel_valid_encap_type+0x38a/0x5f0 net/core/lwtunnel.c:169
>   lwtunnel_valid_encap_type_attr+0x113/0x270 net/core/lwtunnel.c:209
>   rtm_to_fib_config+0x949/0x14e0 net/ipv4/fib_frontend.c:808
>   inet_rtm_newroute+0xf6/0x2a0 net/ipv4/fib_frontend.c:917
>   rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
>   netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
>   netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>   netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>   sock_sendmsg_nosec net/socket.c:709 [inline]
> 
> Fixes: 1dd2af7963e9 ("ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.")
> Reported-by: syzbot+3f18ef0f7df107a3f6a0@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67c6f87a.050a0220.38b91b.0147.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I completely missed this, thank you!
I'll post v6 and nexthop series after this is merged.

