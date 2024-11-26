Return-Path: <netdev+bounces-147449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D75A9D997E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0476B164122
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8801D5CC2;
	Tue, 26 Nov 2024 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OtNNtoPF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68871B87D0
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630843; cv=none; b=MoTzBrli69eUYo0UteDjyRJUuraAMe41kv0I5Vmxc2kOo0zq5+0JZ/Zx32x3Jerfmolw3yQmeJK9+jAAOI9D+L6KaQUuv1aUvhIZ4Fo6zyYDC47eoL6YQLRxLb8rxjMz1zktaY88mdUt2QIA/WOZPMmDtpwIDiKkXZgXDowKcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630843; c=relaxed/simple;
	bh=vua1C6GGzzbASnTWZANM1CjWWn8u/EORClFt5ck2PaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2n6pZKNjNg45yGMC4s2cuiP/zV63MuZKCsbLrcFroNNTRd5AtVJn9ncUYDSN5pDxIE0+gMvvdBq/9v+KfFaufPoFJ2xbwoJvQDAztsiv3sU3LDwnTlwboqDEd3ICPDRS+Tm9zgSDw0Us0iuvJeUk2iK9RQFQWC6NWRZRKYa7cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OtNNtoPF; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732630841; x=1764166841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MZ1y179F67rVp8/Tylhz2F0JkhrkiCrx7BS+CGyUd94=;
  b=OtNNtoPFQbtZg+Kshe4qcT5s6J3ZkeUYUCEfpG9PxlMk0dclcBrqThkj
   D2LyJyHuRzVx51aAKibmXe2+scBzhG+sxcsK3TXdMe3HX8UmRko2+bDYA
   RC2vkUn1U/XxjuKQSqazURvqqUBV8G4knIs9O+6RfnYWBbctkIdfbNneU
   4=;
X-IronPort-AV: E=Sophos;i="6.12,186,1728950400"; 
   d="scan'208";a="148095317"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 14:20:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:2299]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.54:2525] with esmtp (Farcaster)
 id 05215d66-fee9-4f9c-a133-46ca22fc0f74; Tue, 26 Nov 2024 14:20:39 +0000 (UTC)
X-Farcaster-Flow-ID: 05215d66-fee9-4f9c-a133-46ca22fc0f74
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 26 Nov 2024 14:20:39 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.66) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 26 Nov 2024 14:20:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <ebiederm@xmission.com>, <jmaloy@redhat.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>,
	<tipc-discussion@lists.sourceforge.net>, <ying.xue@windriver.com>,
	<erik.hugne@ericsson.com>
Subject: Re: [PATCH v1 net] tipc: Fix use-after-free of kernel socket in cleanup_bearer().
Date: Tue, 26 Nov 2024 23:20:31 +0900
Message-ID: <20241126142031.11397-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iLXk2BRLWuyvEsxOVqRBo2qbuOydv33xfKAe54M9tKPUA@mail.gmail.com>
References: <CANn89iLXk2BRLWuyvEsxOVqRBo2qbuOydv33xfKAe54M9tKPUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Nov 2024 11:53:07 +0100
> On Tue, Nov 26, 2024 at 7:14 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > syzkaller reported a use-after-free of kernel UDP socket in
> > cleanup_bearer() without repro. [0][1]
> >
> > When bearer_disable() calls tipc_udp_disable(), cleanup of the kernel
> > UDP socket is deferred by work calling cleanup_bearer().
> >
> > Since the cited commit, however, the socket's netns might not be alive
> > when the work is executed, resulting in use-after-free.
> >
> > Let's hold netns for the kernel UDP socket when created.
> >
> > Note that we can't call get_net() before scheduling the work and call
> > put_net() in cleanup_bearer() because bearer_disable() could be called
> > from pernet_operations.exit():
> >
> >   tipc_exit_net
> >   `- tipc_net_stop
> >      `- tipc_bearer_stop
> >         `- bearer_disable
> >
> > [0]:
> > ref_tracker: net notrefcnt@000000009b3d1faf has 1/1 users at
> >      sk_alloc+0x438/0x608
> >      inet_create+0x4c8/0xcb0
> >      __sock_create+0x350/0x6b8
> >      sock_create_kern+0x58/0x78
> >      udp_sock_create4+0x68/0x398
> >      udp_sock_create+0x88/0xc8
> >      tipc_udp_enable+0x5e8/0x848
> >      __tipc_nl_bearer_enable+0x84c/0xed8
> >      tipc_nl_bearer_enable+0x38/0x60
> >      genl_family_rcv_msg_doit+0x170/0x248
> >      genl_rcv_msg+0x400/0x5b0
> >      netlink_rcv_skb+0x1dc/0x398
> >      genl_rcv+0x44/0x68
> >      netlink_unicast+0x678/0x8b0
> >      netlink_sendmsg+0x5e4/0x898
> >      ____sys_sendmsg+0x500/0x830
> >
> > [1]:
> > BUG: KMSAN: use-after-free in udp_hashslot include/net/udp.h:85 [inline]
> > BUG: KMSAN: use-after-free in udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.c:1979
> >  udp_hashslot include/net/udp.h:85 [inline]
> >  udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.c:1979
> >  sk_common_release+0xaf/0x3f0 net/core/sock.c:3820
> >  inet_release+0x1e0/0x260 net/ipv4/af_inet.c:437
> >  inet6_release+0x6f/0xd0 net/ipv6/af_inet6.c:489
> >  __sock_release net/socket.c:658 [inline]
> >  sock_release+0xa0/0x210 net/socket.c:686
> >  cleanup_bearer+0x42d/0x4c0 net/tipc/udp_media.c:819
> >  process_one_work kernel/workqueue.c:3229 [inline]
> >  process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
> >  worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
> >  kthread+0x531/0x6b0 kernel/kthread.c:389
> >  ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
> >
> > Uninit was created at:
> >  slab_free_hook mm/slub.c:2269 [inline]
> >  slab_free mm/slub.c:4580 [inline]
> >  kmem_cache_free+0x207/0xc40 mm/slub.c:4682
> >  net_free net/core/net_namespace.c:454 [inline]
> >  cleanup_net+0x16f2/0x19d0 net/core/net_namespace.c:647
> >  process_one_work kernel/workqueue.c:3229 [inline]
> >  process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
> >  worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
> >  kthread+0x531/0x6b0 kernel/kthread.c:389
> >  ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
> >
> > CPU: 0 UID: 0 PID: 54 Comm: kworker/0:2 Not tainted 6.12.0-rc1-00131-gf66ebf37d69c #7 91723d6f74857f70725e1583cba3cf4adc716cfa
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > Workqueue: events cleanup_bearer
> >
> > Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> > I'll remove this ugly hack by clearner API in the next cycle.
> > see:
> > https://lore.kernel.org/netdev/20241112001308.58355-1-kuniyu@amazon.com/
> > ---
> >  net/tipc/udp_media.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> > index 439f75539977..10986b283ac8 100644
> > --- a/net/tipc/udp_media.c
> > +++ b/net/tipc/udp_media.c
> > @@ -673,6 +673,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
> >         struct nlattr *opts[TIPC_NLA_UDP_MAX + 1];
> >         u8 node_id[NODE_ID_LEN] = {0,};
> >         struct net_device *dev;
> > +       struct sock *sk;
> >         int rmcast = 0;
> >
> >         ub = kzalloc(sizeof(*ub), GFP_ATOMIC);
> > @@ -792,6 +793,12 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
> >         if (err)
> >                 goto free;
> >
> > +       sk = ub->ubsock->sk;
> > +       __netns_tracker_free(net, &sk->ns_tracker, false);
> > +       sk->sk_net_refcnt = 1;
> > +       get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> > +       sock_inuse_add(net, 1);
> > +
> >         return 0;
> 
> I think 'kernel sockets' were not refcounted to allow the netns to be removed.
> 
> Otherwise, what would tipc_bearer_stop() be needed ?

Interestingly, the delayed cleanup exists since the udp media support
was added in d0f91938bede2, and it's 2 months earlier than 26abe14379f8
that drops netns refcnt for kernel sockets.

So I thought the udp bearer did not assume bearer_disable() was called
from the __net_exit path, it could be simply wrong though.

At least, the __net_exit path works for other media types.

@Erik Hugne, do you remember any context above ?


> 
> tipc_exit_net(struct net *net)  // can only be called when all refcnt
> have been released
>  -> tipc_net_stop()
>   -> tipc_bearer_stop()
>     -> bearer_disable()
>      -> tipc_udp_disable()
>        -> INIT_WORK(&ub->work, cleanup_bearer); schedule_work(&ub->work);
> 

