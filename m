Return-Path: <netdev+bounces-88125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2EB8A5DAF
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 00:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED0F284CAC
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 22:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0677157A61;
	Mon, 15 Apr 2024 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P2FG6+b4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A44157A45
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713219709; cv=none; b=QKkgUwPYHLIq8XMDQm9G05V/qD5vGsoPsyTVc+w7mKpq/mCNRDZZ5ZeGmshJSD8TrCp6VrgNiR1k0qp9onag7VYGQTgP1RtvZdZZ05CuG8lP0tVB6cd8BNfI/y7jq2jh4EtmS0OEASeZGU7kKXymlZId+blAFWEVBW+G5rS7eio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713219709; c=relaxed/simple;
	bh=U0WlCd8qyzm3tVZvqvCve2MhSQ7qFGdHOYgusQ8tTGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGgYjLd8RmNgTxVL+R71Jx14ONPivTb3fbW63+QCNLW/la8CWzDveSJpj8EevQaXFt7RZv3q/IocnbDZBxJMGaoz9H3R/oQOrLZb72Mfk5MlToYsrUjN/Vokl0waGsi7CYtSH4dusYAW8cbUV1tp/W6ozfXp/7emWLEnURdjQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=P2FG6+b4; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713219708; x=1744755708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zoa+doGoCmceiJSYQYuf6AonrWT64swiuttQPFu2cwA=;
  b=P2FG6+b4v1VOSfFW5c/hxXyvccGHv1chifmcFi7TwI//PRcATZP2XdPM
   BcGC9/PwoZPk4IIt2kVycqrBf+HO3TqQirNtJHYBqA5ChoCbV5wHUUKtt
   dtRA4cmtrKdHsCgOxqJDRG6gobvnjUQJaXQIf5oLXJyyho7z/NogIWRWL
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,204,1708387200"; 
   d="scan'208";a="81411484"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:21:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:58673]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.81:2525] with esmtp (Farcaster)
 id 5ae9efaa-dbe2-4716-9d0b-e0dd4c89fde0; Mon, 15 Apr 2024 22:21:46 +0000 (UTC)
X-Farcaster-Flow-ID: 5ae9efaa-dbe2-4716-9d0b-e0dd4c89fde0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:21:44 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:21:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v1 net 2/5] vti: Pull header after checking skb->protocol in vti_tunnel_xmit().
Date: Mon, 15 Apr 2024 15:20:38 -0700
Message-ID: <20240415222041.18537-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240415222041.18537-1-kuniyu@amazon.com>
References: <20240415222041.18537-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller demonstrated the underflow in pskb_network_may_pull()
by sending a crafted VLAN packet over the tunnel device.

Let's check skb->protocol before pulling the next header in
vti_tunnel_xmit().

WARNING: CPU: 1 PID: 4534 at include/linux/skbuff.h:2740 pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
WARNING: CPU: 1 PID: 4534 at include/linux/skbuff.h:2740 pskb_may_pull include/linux/skbuff.h:2756 [inline]
WARNING: CPU: 1 PID: 4534 at include/linux/skbuff.h:2740 pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
WARNING: CPU: 1 PID: 4534 at include/linux/skbuff.h:2740 pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
WARNING: CPU: 1 PID: 4534 at include/linux/skbuff.h:2740 vti_tunnel_xmit+0xd48/0x14b4 net/ipv4/ip_vti.c:283
Modules linked in:
CPU: 1 PID: 4534 Comm: syz-executor.1 Not tainted 6.8.0-12821-g537c2e91d354-dirty #11
Hardware name: linux,dummy-virt (DT)
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
pc : pskb_may_pull include/linux/skbuff.h:2756 [inline]
pc : pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
pc : pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
pc : vti_tunnel_xmit+0xd48/0x14b4 net/ipv4/ip_vti.c:283
lr : pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
lr : pskb_may_pull include/linux/skbuff.h:2756 [inline]
lr : pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
lr : pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
lr : vti_tunnel_xmit+0xd48/0x14b4 net/ipv4/ip_vti.c:283
sp : ffff8000a99372a0
x29: ffff8000a99373e0 x28: ffff00000d188838 x27: ffff700015326e64
x26: ffff000061930080 x25: dfff800000000000 x24: ffff8000a9937320
x23: 0000000000000000 x22: ffff00000d188834 x21: 00000000fffffff6
x20: ffff00000d188780 x19: ffff000017580000 x18: ffff800086d72d10
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 1fffe000029ce017 x13: 0000000000000000 x12: 0000000000000001
x11: 0000000000040000 x10: 0000000000000b7f x9 : ffff80008a3fa000
x8 : 0000000000000b80 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a9936c98 x4 : ffff800086d8b120 x3 : ffff800083f7f7d4
x2 : 0000000000000001 x1 : 00000000fffffff6 x0 : 0000000000000000
Call trace:
 pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
 pskb_may_pull include/linux/skbuff.h:2756 [inline]
 pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
 pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
 vti_tunnel_xmit+0xd48/0x14b4 net/ipv4/ip_vti.c:283
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x1a0/0x370 net/core/dev.c:3547
 __dev_queue_xmit+0x12e8/0x2b04 net/core/dev.c:4335
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 packet_xmit+0x6c/0x31c net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3081 [inline]
 packet_sendmsg+0x3818/0x4e50 net/packet/af_packet.c:3113
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x324/0x470 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2199
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x30/0x78 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Reported-by: syzkaller <syzkaller@googlegroups.com>
Fixes: cb9f1b783850 ("ip: validate header length on virtual device xmit")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/ip_vti.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index ee587adb169f..8070d0c440f6 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -280,17 +280,20 @@ static netdev_tx_t vti_tunnel_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct flowi fl;
 
-	if (!pskb_inet_may_pull(skb))
-		goto tx_err;
-
 	memset(&fl, 0, sizeof(fl));
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+			goto tx_err;
+
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET);
 		break;
 	case htons(ETH_P_IPV6):
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
+			goto tx_err;
+
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET6);
 		break;
-- 
2.30.2


