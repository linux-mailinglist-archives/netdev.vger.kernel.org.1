Return-Path: <netdev+bounces-181365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3501A84ABB
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245083AD774
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172571EB5EA;
	Thu, 10 Apr 2025 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kZoqSJHE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4CD1EF37E
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305037; cv=none; b=lTaKUY6iY1c1z150Xo7CfLvNgatYACh9MBGpc3b77zF/PH7ug54qwyEcXs/26qzfbI4+TrxLWUYD7v+8CnaAVhpvCUWlOSlPJDgfTt6mc0tjsswQacmXPrh+wItBd6a7qnEGxrxLNNlhkAYSSR7nDL6voBpzim+ScbSGm5D006g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305037; c=relaxed/simple;
	bh=NTVg1Pf2sus4dzCdskeSCFm8q1/vDs0hx63J0cnGCls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8kJ8ahOwekEqjRC5PLGlVlnzWNUDSHRMC//asT9NiLZceIWs6hktcxmUTebSImqroMKitBtqc0WEZzqodXmjM65jydQ5M6wLXO/Stng6e23gOnG5zsW+MCgtBUEAh8ZMY3dqo0Sn4SpE2NPDAjPKflaWlBaduQibYTDvXBRwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kZoqSJHE; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744305035; x=1775841035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vMMgNS2bICtmft8NnTJ70RQYHVNYQN7XkuLmNd+dPzM=;
  b=kZoqSJHE8m0D1p2OhundEeh97k4TQVrb4cocapojs2ijkpAXP2FESs47
   UeDfIFww2Oi2wFKDzsp9HCnPe9d7AlThmlfEO0tCVQg238aFekuGD2S6v
   IlRi6k7eMKlD37QlXnD5a7rZ5DaJW98uIEAEkpoNHeUamQPnz2dED/h80
   A=;
X-IronPort-AV: E=Sophos;i="6.15,202,1739836800"; 
   d="scan'208";a="394808059"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 17:10:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:52049]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id 4a5483d2-9828-41c3-aedb-3769c55430ac; Thu, 10 Apr 2025 17:10:31 +0000 (UTC)
X-Farcaster-Flow-ID: 4a5483d2-9828-41c3-aedb-3769c55430ac
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 17:10:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 17:10:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <hramamurthy@google.com>, <jdamato@fastly.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 6/8] netdev: depend on netdev->lock for xdp features
Date: Thu, 10 Apr 2025 10:10:01 -0700
Message-ID: <20250410171019.62128-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408195956.412733-7-kuba@kernel.org>
References: <20250408195956.412733-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue,  8 Apr 2025 12:59:53 -0700
> Writes to XDP features are now protected by netdev->lock.
> Other things we report are based on ops which don't change
> once device has been registered. It is safe to stop taking
> rtnl_lock, and depend on netdev->lock instead.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 7ef9b0191936..8c58261de969 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -38,6 +38,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
>  	u64 xdp_rx_meta = 0;
>  	void *hdr;
>  
> +	netdev_assert_locked(netdev); /* note: rtnl_lock may not be held! */

syzkaller reported splats in register_netdevice() and
unregister_netdevice_many_notify().

In register_netdevice(), some devices cannot use
netdev_assert_locked().

In unregister_netdevice_many_notify(), maybe we need to
hold ops lock in UNREGISTER as you initially suggested.
Now do_setlink() deadlock does not happen.


register_netdevice:

WARNING: CPU: 1 PID: 4014 at ./include/net/netdev_lock.h:17 netdev_assert_locked include/net/netdev_lock.h:17 [inline]
WARNING: CPU: 1 PID: 4014 at ./include/net/netdev_lock.h:17 netdev_nl_dev_fill+0x4e8/0x628 net/core/netdev-genl.c:41
Modules linked in:
CPU: 1 UID: 0 PID: 4014 Comm: syz.2.1132 Not tainted 6.14.0-13344-ga9843689e2de #27 PREEMPT  796b8818af72d9451c8904a331bb7c0385e61b12
Hardware name: linux,dummy-virt (DT)
pstate: 81400005 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : netdev_assert_locked include/net/netdev_lock.h:17 [inline]
pc : netdev_nl_dev_fill+0x4e8/0x628 net/core/netdev-genl.c:41
lr : netdev_assert_locked include/net/netdev_lock.h:17 [inline]
lr : netdev_nl_dev_fill+0x4e8/0x628 net/core/netdev-genl.c:41
sp : ffff80008d1274a0
x29: ffff80008d1274b0 x28: 1ffff00010bed1b5 x27: 1fffe000038dd021
x26: ffff800085f68000 x25: dfff800000000000 x24: dfff800000000000
x23: ffff80008d127510 x22: 0000000000000000 x21: ffff80008d127510
x20: ffff00001c6e8000 x19: ffff00001b9fc640 x18: 0000000000000000
x17: 4d45545359534255 x16: 5300302d78742f73 x15: 0000000000000001
x14: 1fffe00003abf9dc x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000080000 x10: 0000000000067d91 x9 : ffff80008ecb7000
x8 : 0000000000067d92 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : ffff8000832814c4
x2 : ffff80008d127510 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 netdev_assert_locked include/net/netdev_lock.h:17 [inline] (P)
 netdev_nl_dev_fill+0x4e8/0x628 net/core/netdev-genl.c:41 (P)
 netdev_genl_dev_notify+0x168/0x370 net/core/netdev-genl.c:102
 netdev_genl_netdevice_event+0x98/0xc0 net/core/netdev-genl.c:-1
 notifier_call_chain+0x1ac/0x4c8 kernel/notifier.c:85
 raw_notifier_call_chain+0x48/0x68 kernel/notifier.c:453
 call_netdevice_notifiers_info net/core/dev.c:2235 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:2273 [inline]
 call_netdevice_notifiers+0xd8/0x150 net/core/dev.c:2287
 register_netdevice+0x1170/0x1620 net/core/dev.c:11109
 register_netdev+0x84/0xb0 net/core/dev.c:11188
 loopback_net_init+0x70/0x168 drivers/net/loopback.c:218
 ops_init+0x31c/0x558 net/core/net_namespace.c:138
 setup_net+0x21c/0x7f0 net/core/net_namespace.c:364
 copy_net_ns+0x2b0/0x4b8 net/core/net_namespace.c:518
 create_new_namespaces+0x324/0x608 kernel/nsproxy.c:110
 copy_namespaces+0x3d4/0x448 kernel/nsproxy.c:179
 copy_process+0x1350/0x3230 kernel/fork.c:2432
 kernel_clone+0x18c/0x6e8 kernel/fork.c:2844
 __do_sys_clone kernel/fork.c:2987 [inline]
 __se_sys_clone kernel/fork.c:2955 [inline]
 __arm64_sys_clone+0x100/0x140 kernel/fork.c:2955
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x90/0x278 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x13c/0x250 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x54/0x70 arch/arm64/kernel/syscall.c:151
 el0_svc+0x4c/0xa8 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x1a0 arch/arm64/kernel/entry.S:600
irq event stamp: 3880
hardirqs last  enabled at (3879): [<ffff800084532260>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (3879): [<ffff800084532260>] _raw_spin_unlock_irqrestore+0x48/0xc0 kernel/locking/spinlock.c:194
hardirqs last disabled at (3880): [<ffff80008450fa94>] el1_dbg+0x24/0x50 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (2984): [<ffff800083268488>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (2984): [<ffff800083268488>] release_sock+0x158/0x1c0 net/core/sock.c:3721
softirqs last disabled at (2982): [<ffff800083268370>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (2982): [<ffff800083268370>] release_sock+0x40/0x1c0 net/core/sock.c:3710


unregister_netdevice_many_notify:

WARNING: CPU: 1 PID: 230 at ./include/net/netdev_lock.h:17 netdev_assert_locked include/net/netdev_lock.h:17 [inline]
WARNING: CPU: 1 PID: 230 at ./include/net/netdev_lock.h:17 netdev_nl_dev_fill+0x4e8/0x628 net/core/netdev-genl.c:41
Modules linked in:
CPU: 1 UID: 0 PID: 230 Comm: kworker/u8:4 Not tainted 6.14.0-13344-ga9843689e2de #27 PREEMPT  796b8818af72d9451c8904a331bb7c0385e61b12
Hardware name: linux,dummy-virt (DT)
Workqueue: netns cleanup_net
pstate: 81400005 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : netdev_assert_locked include/net/netdev_lock.h:17 [inline]
pc : netdev_nl_dev_fill+0x4e8/0x628 net/core/netdev-genl.c:41
lr : netdev_assert_locked include/net/netdev_lock.h:17 [inline]
lr : netdev_nl_dev_fill+0x4e8/0x628 net/core/netdev-genl.c:41
sp : ffff80008d027790
x29: ffff80008d0277a0 x28: 1ffff00010bed1b5 x27: 1fffe00018db0021
x26: ffff800085f68000 x25: dfff800000000000 x24: dfff800000000000
x23: ffff80008d027800 x22: 0000000000000000 x21: ffff80008d027800
x20: ffff0000c6d80000 x19: ffff0000c91f3c80 x18: 0000000000000000
x17: ffff800080297454 x16: ffff8000833ddf10 x15: 0000000000000001
x14: 1fffe00000f651dc x13: 0000000000000000 x12: 0000000000000000
x11: ffff600000f651dd x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c7009d00 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : ffff8000832814c4
x2 : ffff80008d027800 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 netdev_assert_locked include/net/netdev_lock.h:17 [inline] (P)
 netdev_nl_dev_fill+0x4e8/0x628 net/core/netdev-genl.c:41 (P)
 netdev_genl_dev_notify+0x168/0x370 net/core/netdev-genl.c:102
 netdev_genl_netdevice_event+0x98/0xc0 net/core/netdev-genl.c:-1
 notifier_call_chain+0x1ac/0x4c8 kernel/notifier.c:85
 raw_notifier_call_chain+0x48/0x68 kernel/notifier.c:453
 call_netdevice_notifiers_info net/core/dev.c:2235 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:2273 [inline]
 call_netdevice_notifiers net/core/dev.c:2287 [inline]
 unregister_netdevice_many_notify+0xf40/0x1c98 net/core/dev.c:12035
 unregister_netdevice_many+0x34/0x50 net/core/dev.c:12099
 cleanup_net+0x540/0x968 net/core/net_namespace.c:649
 process_one_work+0x744/0x13e0 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x928/0xe98 kernel/workqueue.c:3400
 kthread+0x4dc/0x638 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
irq event stamp: 526602
hardirqs last  enabled at (526601): [<ffff800084532260>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (526601): [<ffff800084532260>] _raw_spin_unlock_irqrestore+0x48/0xc0 kernel/locking/spinlock.c:194
hardirqs last disabled at (526602): [<ffff80008450fa94>] el1_dbg+0x24/0x50 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (526394): [<ffff80008332274c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (526394): [<ffff80008332274c>] netif_addr_unlock_bh include/linux/netdevice.h:4809 [inline]
softirqs last  enabled at (526394): [<ffff80008332274c>] dev_mc_flush+0x1bc/0x208 net/core/dev_addr_lists.c:1037
softirqs last disabled at (526392): [<ffff800083322ca8>] local_bh_disable+0x10/0x40 include/linux/bottom_half.h:19

