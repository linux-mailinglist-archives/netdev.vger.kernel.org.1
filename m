Return-Path: <netdev+bounces-19245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77DA75A08C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A671C21123
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489FC22EF5;
	Wed, 19 Jul 2023 21:27:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A981BB20
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:27:29 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812301FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689802048; x=1721338048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UKF+dmgAqe1NzqEYO3fDjim7CwwaaiSugVC2QjTnhdE=;
  b=FyTkr42jLS6NJ688Kqo4FAqZXgDoUbheqwIP/dDZInlofBtNCAImmS6c
   qKq0rDBGD7CDnV9ytDE0xIDeYwUBUqe7P6sMs4D/G4gGXCxW4KoZSvAmP
   Y1goFxVzrmLoEHY9lrXHHKP8Rk4Cd9T4cbZZwawrRzQ1QeE0CqfnmBIXk
   c=;
X-IronPort-AV: E=Sophos;i="6.01,216,1684800000"; 
   d="scan'208";a="17394660"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 21:27:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id 162B1635D7;
	Wed, 19 Jul 2023 21:27:21 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 21:27:21 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 21:27:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gustavoars@kernel.org>,
	<keescook@chromium.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <leitao@debian.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: RE: [PATCH v1 net 2/2] af_packet: Fix warning of fortified memcpy() in packet_getname().
Date: Wed, 19 Jul 2023 14:27:09 -0700
Message-ID: <20230719212709.63492-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <64b8525db522_2831cb294d@willemb.c.googlers.com.notmuch>
References: <64b8525db522_2831cb294d@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.39]
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
	T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 19 Jul 2023 17:15:09 -0400
> Kuniyuki Iwashima wrote:
> > syzkaller found a warning in packet_getname() [0], where we try to
> > copy 16 bytes to sockaddr_ll.sll_addr[8].
> > 
> > Some devices (ip6gre, vti6, ip6tnl) have 16 bytes address expressed
> > by struct in6_addr.
> 
> Some are even larger. MAX_ADDR_LEN == 32. I think Infiniband may use
> that?

Exactly, I didn't know that.


>  
> > The write seems to overflow, but actually not since we use struct
> > sockaddr_storage defined in __sys_getsockname().
> 
> Which gives _K_SS_MAXSIZE == 128, minus offsetof(struct sockaddr_ll, sll_addr).
> 
> For fun, there is another caller. getsockopt SO_PEERNAME also calls
> sock->ops->getname, with a buffer hardcoded to 128. Should probably
> use sizeof(sockaddr_storage) for documentation, at least.
> 
> .. and I just noticed that that was attempted, but not completed
> https://lore.kernel.org/lkml/20140928135545.GA23220@type.youpi.perso.aquilenet.fr/

Yes, acutally my first draft had the diff below, but I dropped it
because packet_getname() does not call memcpy() for SO_PEERNAME at
least, and same for getpeername().

And interestingly there was a revival thread.
https://lore.kernel.org/netdev/20230719084415.1378696-1-leitao@debian.org/

I can include this in v2 if needed.
What do you think ?

---8<---
diff --git a/net/core/sock.c b/net/core/sock.c
index 9370fd50aa2c..f1e887c3115f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1815,14 +1815,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_PEERNAME:
 	{
-		char address[128];
+		struct sockaddr_storage address;
 
-		lv = sock->ops->getname(sock, (struct sockaddr *)address, 2);
+		lv = sock->ops->getname(sock, (struct sockaddr *)&address, 2);
 		if (lv < 0)
 			return -ENOTCONN;
 		if (lv < len)
 			return -EINVAL;
-		if (copy_to_sockptr(optval, address, len))
+		if (copy_to_sockptr(optval, &address, len))
 			return -EFAULT;
 		goto lenout;
 	}
---8<---

Thanks!


> 
> > 
> > To avoid the warning, we need to let __fortify_memcpy_chk() know the
> > actual buffer size.
> > 
> > Another option would be to use strncpy() and limit the copied length
> > to sizeof(sll_addr), but it will return the partial address and might
> > break an application that passes sockaddr_storage to getsockname().
> 
> Yeah, that would break stuff.
>  
> > [0]:
> > memcpy: detected field-spanning write (size 16) of single field "sll->sll_addr" at net/packet/af_packet.c:3604 (size 8)
> > WARNING: CPU: 0 PID: 255 at net/packet/af_packet.c:3604 packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
> > Modules linked in:
> > CPU: 0 PID: 255 Comm: syz-executor750 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #4
> > Hardware name: linux,dummy-virt (DT)
> > pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
> > lr : packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
> > sp : ffff800089887bc0
> > x29: ffff800089887bc0 x28: ffff000010f80f80 x27: 0000000000000003
> > x26: dfff800000000000 x25: ffff700011310f80 x24: ffff800087d55000
> > x23: dfff800000000000 x22: ffff800089887c2c x21: 0000000000000010
> > x20: ffff00000de08310 x19: ffff800089887c20 x18: ffff800086ab1630
> > x17: 20646c6569662065 x16: 6c676e697320666f x15: 0000000000000001
> > x14: 1fffe0000d56d7ca x13: 0000000000000000 x12: 0000000000000000
> > x11: 0000000000000000 x10: 0000000000000000 x9 : 3e60944c3da92b00
> > x8 : 3e60944c3da92b00 x7 : 0000000000000001 x6 : 0000000000000001
> > x5 : ffff8000898874f8 x4 : ffff800086ac99e0 x3 : ffff8000803f8808
> > x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
> > Call trace:
> >  packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
> >  __sys_getsockname+0x168/0x24c net/socket.c:2042
> >  __do_sys_getsockname net/socket.c:2057 [inline]
> >  __se_sys_getsockname net/socket.c:2054 [inline]
> >  __arm64_sys_getsockname+0x7c/0x94 net/socket.c:2054
> >  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
> >  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
> >  el0_svc_common+0x134/0x240 arch/arm64/kernel/syscall.c:139
> >  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
> >  el0_svc+0x2c/0x7c arch/arm64/kernel/entry-common.c:647
> >  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
> >  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> > 
> > Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/packet/af_packet.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 85ff90a03b0c..5eef94a32a4f 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -3601,7 +3601,10 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
> >  	if (dev) {
> >  		sll->sll_hatype = dev->type;
> >  		sll->sll_halen = dev->addr_len;
> > -		memcpy(sll->sll_addr, dev->dev_addr, dev->addr_len);
> > +
> > +		/* Let __fortify_memcpy_chk() know the actual buffer size. */
> > +		memcpy(((struct sockaddr_storage *)sll)->__data +
> > +		       offsetof(struct sockaddr_ll, sll_addr), dev->dev_addr, dev->addr_len);
> >  	} else {
> >  		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
> >  		sll->sll_halen = 0;
> > -- 
> > 2.30.2


