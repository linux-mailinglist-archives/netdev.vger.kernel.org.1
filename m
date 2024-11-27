Return-Path: <netdev+bounces-147540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB02F9DA13F
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 04:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529851689DA
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 03:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6402012D773;
	Wed, 27 Nov 2024 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FUIa1A3O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528DA54F8C
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732679801; cv=none; b=iIChRdSTkh+GWP34cbq6+NpQ7FcRDlkkOv2OXcfDy79tm4lKbJ4FFBGZhtJXVoe5UE0yK2q4iZdQO0CkoW9x+YD9Gs1OCNLT+vCr7E4jjcKocR9TdSxdnM1NB1TvwLUw2/m1DH1poomW2MH59IaWGI2XnFCduviGpPhMCYMsHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732679801; c=relaxed/simple;
	bh=PaNiOQ+1Y1llF+08LdMfnXTo+F/NTwoNfZ0GyHEiPm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrvfY+2M0mMRIVwJ0PeWgvJbPGhtbheP5Gkui0dwE+/8KWUTtlqUTGpDF2P2Ek5FV66iecE6H39ORpnQPYMXFu9im1xm4/jVIbytAm0F/qXDU8Cw4Y3+HGQZZ3k6u8iKN/aWCDNF9yCnx2iONGj866kt2Ynx80cDErQVdzXCfcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FUIa1A3O; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732679800; x=1764215800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wpmI5qnkJKKN17EBVB0zn1TywJpQd8xry/xkjY8WYdo=;
  b=FUIa1A3O2ZaLXCDatRkMzSBycOdqQKpuv9u4p5EJSiUVWGVSvVkdyiuT
   RfppQrfEKw1pkcqHTfc6DZvEFA0gl85eZhoTZPH23yRI9pUHxhUBv5qjg
   cAtRq2moY+lpYm+1mwe2bAt16fEVTipV6iDmrZ5uBU3g6mWZC3thP+Pgj
   0=;
X-IronPort-AV: E=Sophos;i="6.12,188,1728950400"; 
   d="scan'208";a="446383007"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 03:56:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:14493]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.94:2525] with esmtp (Farcaster)
 id d7417364-098e-41f5-acb4-a8dc2688696c; Wed, 27 Nov 2024 03:56:35 +0000 (UTC)
X-Farcaster-Flow-ID: d7417364-098e-41f5-acb4-a8dc2688696c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 27 Nov 2024 03:56:34 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.13.144) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 27 Nov 2024 03:56:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ebiederm@xmission.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <erik.hugne@ericsson.com>,
	<jmaloy@redhat.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller@googlegroups.com>, <tipc-discussion@lists.sourceforge.net>,
	<ying.xue@windriver.com>
Subject: Re: [PATCH v1 net] tipc: Fix use-after-free of kernel socket in cleanup_bearer().
Date: Wed, 27 Nov 2024 12:56:27 +0900
Message-ID: <20241127035627.20546-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <871pyyq9k7.fsf@email.froward.int.ebiederm.org>
References: <871pyyq9k7.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 26 Nov 2024 09:49:44 -0600
> Kuniyuki Iwashima <kuniyu@amazon.com> writes:
> 
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Tue, 26 Nov 2024 11:53:07 +0100
> >> On Tue, Nov 26, 2024 at 7:14 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >> >
> >> > syzkaller reported a use-after-free of kernel UDP socket in
> >> > cleanup_bearer() without repro. [0][1]
> >> >
> >> > When bearer_disable() calls tipc_udp_disable(), cleanup of the kernel
> >> > UDP socket is deferred by work calling cleanup_bearer().
> >> >
> >> > Since the cited commit, however, the socket's netns might not be alive
> >> > when the work is executed, resulting in use-after-free.
> >> >
> >> > Let's hold netns for the kernel UDP socket when created.
> >> >
> >> > Note that we can't call get_net() before scheduling the work and call
> >> > put_net() in cleanup_bearer() because bearer_disable() could be called
> >> > from pernet_operations.exit():
> >> >
> >> >   tipc_exit_net
> >> >   `- tipc_net_stop
> >> >      `- tipc_bearer_stop
> >> >         `- bearer_disable
> >> >
> >> > [0]:
> >> > ref_tracker: net notrefcnt@000000009b3d1faf has 1/1 users at
> >> >      sk_alloc+0x438/0x608
> >> >      inet_create+0x4c8/0xcb0
> >> >      __sock_create+0x350/0x6b8
> >> >      sock_create_kern+0x58/0x78
> >> >      udp_sock_create4+0x68/0x398
> >> >      udp_sock_create+0x88/0xc8
> >> >      tipc_udp_enable+0x5e8/0x848
> >> >      __tipc_nl_bearer_enable+0x84c/0xed8
> >> >      tipc_nl_bearer_enable+0x38/0x60
> >> >      genl_family_rcv_msg_doit+0x170/0x248
> >> >      genl_rcv_msg+0x400/0x5b0
> >> >      netlink_rcv_skb+0x1dc/0x398
> >> >      genl_rcv+0x44/0x68
> >> >      netlink_unicast+0x678/0x8b0
> >> >      netlink_sendmsg+0x5e4/0x898
> >> >      ____sys_sendmsg+0x500/0x830
> >> >
> >> > [1]:
> >> > BUG: KMSAN: use-after-free in udp_hashslot include/net/udp.h:85 [inline]
> >> > BUG: KMSAN: use-after-free in udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.c:1979
> >> >  udp_hashslot include/net/udp.h:85 [inline]
> >> >  udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.c:1979
> >> >  sk_common_release+0xaf/0x3f0 net/core/sock.c:3820
> >> >  inet_release+0x1e0/0x260 net/ipv4/af_inet.c:437
> >> >  inet6_release+0x6f/0xd0 net/ipv6/af_inet6.c:489
> >> >  __sock_release net/socket.c:658 [inline]
> >> >  sock_release+0xa0/0x210 net/socket.c:686
> >> >  cleanup_bearer+0x42d/0x4c0 net/tipc/udp_media.c:819
> >> >  process_one_work kernel/workqueue.c:3229 [inline]
> >> >  process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
> >> >  worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
> >> >  kthread+0x531/0x6b0 kernel/kthread.c:389
> >> >  ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
> >> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
> >> >
> >> > Uninit was created at:
> >> >  slab_free_hook mm/slub.c:2269 [inline]
> >> >  slab_free mm/slub.c:4580 [inline]
> >> >  kmem_cache_free+0x207/0xc40 mm/slub.c:4682
> >> >  net_free net/core/net_namespace.c:454 [inline]
> >> >  cleanup_net+0x16f2/0x19d0 net/core/net_namespace.c:647
> >> >  process_one_work kernel/workqueue.c:3229 [inline]
> >> >  process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
> >> >  worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
> >> >  kthread+0x531/0x6b0 kernel/kthread.c:389
> >> >  ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
> >> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
> >> >
> >> > CPU: 0 UID: 0 PID: 54 Comm: kworker/0:2 Not tainted 6.12.0-rc1-00131-gf66ebf37d69c #7 91723d6f74857f70725e1583cba3cf4adc716cfa
> >> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >> > Workqueue: events cleanup_bearer
> >> >
> >> > Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
> >> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> >> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> >> > ---
> >> > I'll remove this ugly hack by clearner API in the next cycle.
> >> > see:
> >> > https://lore.kernel.org/netdev/20241112001308.58355-1-kuniyu@amazon.com/
> >> > ---
> >> >  net/tipc/udp_media.c | 7 +++++++
> >> >  1 file changed, 7 insertions(+)
> >> >
> >> > diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> >> > index 439f75539977..10986b283ac8 100644
> >> > --- a/net/tipc/udp_media.c
> >> > +++ b/net/tipc/udp_media.c
> >> > @@ -673,6 +673,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
> >> >         struct nlattr *opts[TIPC_NLA_UDP_MAX + 1];
> >> >         u8 node_id[NODE_ID_LEN] = {0,};
> >> >         struct net_device *dev;
> >> > +       struct sock *sk;
> >> >         int rmcast = 0;
> >> >
> >> >         ub = kzalloc(sizeof(*ub), GFP_ATOMIC);
> >> > @@ -792,6 +793,12 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
> >> >         if (err)
> >> >                 goto free;
> >> >
> >> > +       sk = ub->ubsock->sk;
> >> > +       __netns_tracker_free(net, &sk->ns_tracker, false);
> >> > +       sk->sk_net_refcnt = 1;
> >> > +       get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> >> > +       sock_inuse_add(net, 1);
> >> > +
> >> >         return 0;
> >> 
> >> I think 'kernel sockets' were not refcounted to allow the netns to be removed.
> >> 
> >> Otherwise, what would tipc_bearer_stop() be needed ?
> >
> > Interestingly, the delayed cleanup exists since the udp media support
> > was added in d0f91938bede2, and it's 2 months earlier than 26abe14379f8
> > that drops netns refcnt for kernel sockets.
> 
> Just for reference commit 26abe14379f8 ("net: Modify sk_alloc to not
> reference count the netns of kernel sockets.") doesn't ``drop'' the
> netns refcnt for kernel sockets.  It changes the code so the refcnt is
> not taken.  You will see in that commit a bunch of sk_change_net calls
> which if memory serves are where the refcnt was previously dropped.
> 
> > So I thought the udp bearer did not assume bearer_disable() was called
> > from the __net_exit path, it could be simply wrong though.
> >
> > At least, the __net_exit path works for other media types.
> 
> For the most part.  The network filesystem has been seeing similar
> issues lately.  I suspect there is something (maybe just syzkaller)
> that is making old bugs more likely to appear lately.

It's not only syzkaller.

For example, mounting CIFS in k8s pod uncovered one of the issue.


> 
> > @Erik Hugne, do you remember any context above ?
> >
> >
> >> 
> >> tipc_exit_net(struct net *net)  // can only be called when all refcnt
> >> have been released
> >>  -> tipc_net_stop()
> >>   -> tipc_bearer_stop()
> >>     -> bearer_disable()
> >>      -> tipc_udp_disable()
> >>        -> INIT_WORK(&ub->work, cleanup_bearer); schedule_work(&ub->work);
> >> 
> 
> That schedule_work definitely looks like it will start running after
> the network namespace and probably the entire kernel socket
> has been released.
> 
> Eric

