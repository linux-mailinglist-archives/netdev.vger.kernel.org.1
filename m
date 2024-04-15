Return-Path: <netdev+bounces-88127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8A28A5DB1
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 00:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A528D281140
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 22:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1757B157A68;
	Mon, 15 Apr 2024 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eyHSlLAN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A7156877
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713219766; cv=none; b=eZ9lkWa4ycJ9EZSre1rjU6XgKA+o3Lf3Lblp/sS0XjG2CFlMN5BOTR89wZ0MbUBFeG+TitBCTo356O2f/yt1PSU5nAkzyi6PFb5WX7G2Cz1wxTqLrxYlv435W2M4aLoi5XLe4w+nKU0+IpyCjrui1En0B1tr2lKnyTd6GFJtyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713219766; c=relaxed/simple;
	bh=SgDDhxiWD1mgii/Sd8sTubUx4noIOM44a0I611D3L08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBJCKSe4kItCI8WWEq+PjsI5NwXj49bf7qBDjAkqkGSL0OJgiyHTxQfgEzyEzR6CRqJ7CieuqSaKrUUgU6A4bTp29GNcjIG7puKreLziaz5guZr1nWiO9E7qzzAZke5BXZm5y/qjuq9/cnLdoyTQbBOtLtZNK6Pk1z4VJM0C/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eyHSlLAN; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713219765; x=1744755765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zyw70dU/8zaiuuCf5rMIDkyoi35UeTutjUjbg7r79Zk=;
  b=eyHSlLANu+TNU26lo5bvEjvrscNy8zssPxGR1K6PxrGcYj8VpHfE9wJm
   oCpEYRGQ2vQgNgnPhUZ0WMJxrlA70lNf2Ct30E7/dPZQk3BesOo2muDdx
   9S0TAnqYhtCCcpD08BQeoIak+Jfzu6rrEfwHMab8cGoGaEsplK5nE2sGv
   I=;
X-IronPort-AV: E=Sophos;i="6.07,204,1708387200"; 
   d="scan'208";a="647808591"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:22:42 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:6278]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.244:2525] with esmtp (Farcaster)
 id b11cb1f2-b035-4a89-a4aa-847cf84a2f73; Mon, 15 Apr 2024 22:22:40 +0000 (UTC)
X-Farcaster-Flow-ID: b11cb1f2-b035-4a89-a4aa-847cf84a2f73
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:22:34 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:22:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v1 net 4/5] ipip: Pull header after checking skb->protocol in ipip_tunnel_xmit().
Date: Mon, 15 Apr 2024 15:20:40 -0700
Message-ID: <20240415222041.18537-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller demonstrated the underflow in pskb_network_may_pull()
by sending a crafted VLAN packet over the tunnel device.

Let's check skb->protocol before pulling the next header in
ipip_tunnel_xmit().

WARNING: CPU: 0 PID: 4406 at include/linux/skbuff.h:2740 pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
WARNING: CPU: 0 PID: 4406 at include/linux/skbuff.h:2740 pskb_may_pull include/linux/skbuff.h:2756 [inline]
WARNING: CPU: 0 PID: 4406 at include/linux/skbuff.h:2740 pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
WARNING: CPU: 0 PID: 4406 at include/linux/skbuff.h:2740 pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
WARNING: CPU: 0 PID: 4406 at include/linux/skbuff.h:2740 ipip_tunnel_xmit+0x2d4/0x430 net/ipv4/ipip.c:281
Modules linked in:
CPU: 0 PID: 4406 Comm: syz-executor.1 Not tainted 6.8.0-12821-g537c2e91d354-dirty #11
Hardware name: linux,dummy-virt (DT)
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
pc : pskb_may_pull include/linux/skbuff.h:2756 [inline]
pc : pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
pc : pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
pc : ipip_tunnel_xmit+0x2d4/0x430 net/ipv4/ipip.c:281
lr : pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
lr : pskb_may_pull include/linux/skbuff.h:2756 [inline]
lr : pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
lr : pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
lr : ipip_tunnel_xmit+0x2d4/0x430 net/ipv4/ipip.c:281
sp : ffff8000a82673f0
x29: ffff8000a82673f0 x28: ffff00000fc24140 x27: ffff00006ab166ba
x26: 1fffe00001f8483e x25: dfff800000000000 x24: ffff00003b898080
x23: 0000000000000000 x22: 00000000fffffff6 x21: ffff00000fc241f4
x20: ffff00000fc24140 x19: ffff000046206000 x18: ffff800086d72d10
x17: 00000000008a008a x16: 008a4f8900000000 x15: 0000000000000001
x14: 1ffff00011028fbc x13: 0000000000000004 x12: 0000000000000001
x11: 0000000000040000 x10: 0000000000000f68 x9 : ffff80008d25a000
x8 : 0000000000000f69 x7 : ffff8000800477bc x6 : ffff8000800479b8
x5 : ffff0000687ca948 x4 : ffff8000a8267028 x3 : ffff800083f7f890
x2 : 0000000000000001 x1 : 00000000fffffff6 x0 : 0000000000000000
Call trace:
 pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
 pskb_may_pull include/linux/skbuff.h:2756 [inline]
 pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
 pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
 ipip_tunnel_xmit+0x2d4/0x430 net/ipv4/ipip.c:281
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
 net/ipv4/ipip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index f2696eaadbe6..3f96364d65fd 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -278,11 +278,11 @@ static netdev_tx_t ipip_tunnel_xmit(struct sk_buff *skb,
 	const struct iphdr  *tiph = &tunnel->parms.iph;
 	u8 ipproto;
 
-	if (!pskb_inet_may_pull(skb))
-		goto tx_error;
-
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+			goto tx_error;
+
 		ipproto = IPPROTO_IPIP;
 		break;
 #if IS_ENABLED(CONFIG_MPLS)
-- 
2.30.2


