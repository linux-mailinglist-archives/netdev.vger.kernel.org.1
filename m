Return-Path: <netdev+bounces-40140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AFC7C5EC2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735802823BC
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C391B26E;
	Wed, 11 Oct 2023 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KH29gk5Z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3B12E5E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 20:54:49 +0000 (UTC)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC3990
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697057688; x=1728593688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oEloGmFKqAgJCSh9AaY4V/PrmKqrOQkY9/IFb62kMBk=;
  b=KH29gk5ZmA5h7Jfwc7DeREe6WIY/ZT2qDfSHmAmiqSu9Lq63lbO3ooDP
   mRI212gDceY4j0KttAZb6da923yEV4rBvtn9kUNnAOhHkpUDp4JhNxm1k
   qduDm1BqG8ODlVL8NSNeQb5kodZGXkNLYNT247fGJ3Vh/guZbQzHqf4ZI
   Q=;
X-IronPort-AV: E=Sophos;i="6.03,217,1694736000"; 
   d="scan'208";a="677836809"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 20:54:39 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id E56E780FCB;
	Wed, 11 Oct 2023 20:54:38 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 11 Oct 2023 20:54:38 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 11 Oct 2023 20:54:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dmitryk@qwilt.com>
CC: <edumazet@google.com>, <netdev@vger.kernel.org>, <slavas@qwilt.com>,
	<kuniyu@amazon.com>
Subject: Re: kernel BUG at net/ipv4/tcp_output.c:2642 with kernel 5.19.0-rc2 and newer
Date: Wed, 11 Oct 2023 13:54:28 -0700
Message-ID: <20231011205428.81550-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAAvCjhhxBHL63O4s4ufhU7-rptJgX1LM7zEDGeQ9zGP+9Am2kA@mail.gmail.com>
References: <CAAvCjhhxBHL63O4s4ufhU7-rptJgX1LM7zEDGeQ9zGP+9Am2kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.187.170.62]
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dmitry Kravkov <dmitryk@qwilt.com>
Date: Wed, 11 Oct 2023 23:20:10 +0300
> On Wed, Oct 11, 2023 at 5:02 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Oct 11, 2023 at 12:28 PM Dmitry Kravkov <dmitryk@qwilt.com> wrote:
> > >
> > > Hi,
> > >
> > > In our try to upgrade from 5.10 to 6.1 kernel we noticed stable crash
> > > in kernel that bisected to this commit:
> > >
> > > commit 849b425cd091e1804af964b771761cfbefbafb43
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:   Tue Jun 14 10:17:34 2022 -0700
> > >
> > >     tcp: fix possible freeze in tx path under memory pressure
> > >
> > >     Blamed commit only dealt with applications issuing small writes.
> > >
> > >     Issue here is that we allow to force memory schedule for the sk_buff
> > >     allocation, but we have no guarantee that sendmsg() is able to
> > >     copy some payload in it.
> > >
> > >     In this patch, I make sure the socket can use up to tcp_wmem[0] bytes.
> > >
> > >     For example, if we consider tcp_wmem[0] = 4096 (default on x86),
> > >     and initial skb->truesize being 1280, tcp_sendmsg() is able to
> > >     copy up to 2816 bytes under memory pressure.
> > >
> > >     Before this patch a sendmsg() sending more than 2816 bytes
> > >     would either block forever (if persistent memory pressure),
> > >     or return -EAGAIN.
> > >
> > >     For bigger MTU networks, it is advised to increase tcp_wmem[0]
> > >     to avoid sending too small packets.
> > >
> > >     v2: deal with zero copy paths.
> > >
> > >     Fixes: 8e4d980ac215 ("tcp: fix behavior for epoll edge trigger")
> > >     Signed-off-by: Eric Dumazet <edumazet@google.com>
> > >     Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> > >     Reviewed-by: Wei Wang <weiwan@google.com>
> > >     Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > >     Signed-off-by: David S. Miller <davem@davemloft.net>
> > >
> > > This happens in a pretty stressful situation when two 100Gb (E810 or
> > > ConnectX6) ports transmit above 150Gbps that most of the data is read
> > > from disks. So it appears that the system is constantly in a memory
> > > deficit. Apparently reverting the patch in 6.1.38 kernel eliminates
> > > the crash and system appears stable at delivering 180Gbps
> > >
> > > [ 2445.532318] ------------[ cut here ]------------
> > > [ 2445.532323] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > [ 2445.532334] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > [ 2445.550934] CPU: 61 PID: 109767 Comm: nginx Tainted: G S         OE

It seems 3rd party module is loaded.

Just curious if it is possible to reproduce the issue without
out-of-tree modules.


> > >     5.19.0-rc2+ #21
> > > [ 2445.560127] ------------[ cut here ]------------
> > > [ 2445.560565] Hardware name: Cisco Systems Inc
> > > UCSC-C220-M6N/UCSC-C220-M6N, BIOS C220M6.4.2.1g.0.1121212157
> > > 11/21/2021
> > > [ 2445.560571] RIP: 0010:tcp_write_xmit+0x70b/0x830
> > > [ 2445.561221] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > [ 2445.561821] Code: 84 0b fc ff ff 0f b7 43 32 41 39 c6 0f 84 fe fb
> > > ff ff 8b 43 70 41 39 c6 0f 82 ff 00 00 00 c7 43 30 01 00 00 00 e9 e6
> > > fb ff ff <0f> 0b 8b 74 24 20 8b 85 dc 05 00 00 44 89 ea 01 c8 2b 43 28
> > > 41 39
> > > [ 2445.561828] RSP: 0000:ffffc110ed647dc0 EFLAGS: 00010246
> > > [ 2445.561832] RAX: 0000000000000000 RBX: ffff9fe1f8081a00 RCX: 00000000000005a8
> > > [ 2445.561833] RDX: 000000000000043a RSI: 000002389172f8f4 RDI: 000000000000febf
> > > [ 2445.561835] RBP: ffff9fe5f864e900 R08: 0000000000000000 R09: 0000000000000100
> > > [ 2445.561836] R10: ffffffff9be060d0 R11: 000000000000000e R12: ffff9fe5f864e901
> > > [ 2445.561837] R13: 0000000000000001 R14: 00000000000005a8 R15: 0000000000000000
> > > [ 2445.561839] FS:  00007f342530c840(0000) GS:ffff9ffa7f940000(0000)
> > > knlGS:0000000000000000
> > > [ 2445.561842] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 2445.561844] CR2: 00007f20ca4ed830 CR3: 00000045d976e005 CR4: 0000000000770ee0
> > > [ 2445.561846] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [ 2445.561847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [ 2445.561849] PKRU: 55555554
> > > [ 2445.561853] Call Trace:
> > > [ 2445.561858]  <TASK>
> > > [ 2445.564202] ------------[ cut here ]------------
> > > [ 2445.568007]  ? tcp_tasklet_func+0x120/0x120
> > > [ 2445.569107] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > [ 2445.569608]  tcp_tsq_handler+0x7c/0xa0
> > > [ 2445.569627]  tcp_pace_kick+0x19/0x60
> > > [ 2445.569632]  __run_hrtimer+0x5c/0x1d0
> > > [ 2445.572264] ------------[ cut here ]------------
> > > [ 2445.574287] ------------[ cut here ]------------
> > > [ 2445.574292] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > [ 2445.582581]  __hrtimer_run_queues+0x7d/0xe0
> > > --
> > > --
> > >
> > > --
> > > --
> > >
> > > Dmitry Kravkov     Software  Engineer
> > > Qwilt | Mobile: +972-54-4839923 | dmitryk@qwilt.com
> >
> > Hi Dmitry, thanks for the report.
> >
> > Can you post content of /proc/sys/net/ipv4/tcp_wmem and
> > /proc/sys/net/ipv4/tcp_rmem ?
> Thank you, Eric
> 
> # cat /proc/sys/net/ipv4/tcp_wmem
> 786432 1048576 6291456
> # cat /proc/sys/net/ipv4/tcp_rmem
> 4096 87380 6291456
> 
> >
> > Are you using memcg ?
> No
> >
> > Can you try the following patch ?
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 3f66cdeef7decb5b5d2b84212c623781b8ce63db..d74b197e02e94aa2f032f2c3971969e604abc7de
> > 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1286,6 +1286,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct
> > msghdr *msg, size_t size)
> >                 continue;
> >
> >  wait_for_space:
> > +               tcp_remove_empty_skb(sk);
> >                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> >                 if (copied)
> >                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
> 
> 
> The patched kernel crashed in the same manner:
> [ 2214.154278] kernel BUG at net/ipv4/tcp_output.c:2642!


