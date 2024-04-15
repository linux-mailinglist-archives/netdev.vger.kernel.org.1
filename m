Return-Path: <netdev+bounces-88124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547648A5DAE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 00:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD801F21561
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 22:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D0157A5C;
	Mon, 15 Apr 2024 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KbZmjZ+I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3F156877
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713219683; cv=none; b=oc6Uy5+xl85NCW+VoZeqQcFIRqI6BeY6UuukFn5+ZkAvKAG4ir4XXN8iB1BNX/OlrwFAjxB71vwZgHzpgZdZO+4AV8NpkDUWoXulpwiZ7/RWC7Gh7+A3THjCX+1tczuB81kQJx1/O2wRpBZEcrrg0kdPZBRmBXzU2WVsR9RLdVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713219683; c=relaxed/simple;
	bh=hbJOiQQpN3UDR3lLMeXoC1zUKb91DNydxbm8q6EdOGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bI6BJwIIcNAR9XIHnNKtCCDDL0ti4+qsjAfsXE9Ek4HTYLualQhyuIivXP/K1ZEB7uwdmBMDjA+m8cbUgwXltHYta2mpE1fpwAJ0FQRrPnThS/d5FAiP4aCO8TAEr10v7R5DuReTEjMVWQP/iaS6jSjzHYX3Ta6MSysBFsVKB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KbZmjZ+I; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713219682; x=1744755682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QnmyPwUrh3piNZGp8bSCPPwglKyIZo3s9DxKu4PA88Q=;
  b=KbZmjZ+Ibl2Laq2M+j0oaEuBdwq436eL7yvO55A2YHIV5vayI4BuenNG
   nGgmbkdJ1nSQKv/LQq0jSia6jf4SVjzGceQSbeRpuN5V1zkW0PhkTHkuo
   9SCWDFXmqtFyGl7wnfTbdXJ/Upkn4Zp6RpFdV6cAGujk/ALjPdxlzCQcI
   c=;
X-IronPort-AV: E=Sophos;i="6.07,204,1708387200"; 
   d="scan'208";a="288791228"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:21:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:58974]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.38:2525] with esmtp (Farcaster)
 id b572284f-d6c7-4751-9809-1c36b63ad3b0; Mon, 15 Apr 2024 22:21:19 +0000 (UTC)
X-Farcaster-Flow-ID: b572284f-d6c7-4751-9809-1c36b63ad3b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:21:19 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:21:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v1 net 1/5] sit: Pull header after checking skb->protocol in sit_tunnel_xmit().
Date: Mon, 15 Apr 2024 15:20:37 -0700
Message-ID: <20240415222041.18537-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller crafted a GSO packet of ETH_P_8021AD + ETH_P_NSH and sent it
over sit0.

After nsh_gso_segment(), skb->data - skb->head was 138, on the other
hand, skb->network_header was 128.

Later, sit_tunnel_xmit() called pskb_inet_may_pull() for the skb, and
it caused underflow and triggered the warning in pskb_may_pull_reason().

  pskb_network_may_pull(skb, nhlen)
  `- pskb_may_pull(skb, skb_network_offset(skb) + nhlen)

  -> skb_network_offset(skb) + nhlen
   = skb_network_offset(skb) + 0 (because skb->protocol is not IPv4/IPv6)
   = skb_network_header(skb) - skb->data
   = skb->head + skb->network_header - skb->data
   = 128 - 138
   = -10

Let's check skb->protocol before pulling the next header in
sit_tunnel_xmit().

WARNING: CPU: 1 PID: 5300 at include/linux/skbuff.h:2740 pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
WARNING: CPU: 1 PID: 5300 at include/linux/skbuff.h:2740 pskb_may_pull include/linux/skbuff.h:2756 [inline]
WARNING: CPU: 1 PID: 5300 at include/linux/skbuff.h:2740 pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
WARNING: CPU: 1 PID: 5300 at include/linux/skbuff.h:2740 pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
WARNING: CPU: 1 PID: 5300 at include/linux/skbuff.h:2740 sit_tunnel_xmit+0x1080/0x1fd8 net/ipv6/sit.c:1068
Modules linked in:
CPU: 1 PID: 5300 Comm: syz-executor.5 Not tainted 6.8.0-12821-g537c2e91d354-dirty #11
Hardware name: linux,dummy-virt (DT)
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
pc : pskb_may_pull include/linux/skbuff.h:2756 [inline]
pc : pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
pc : pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
pc : sit_tunnel_xmit+0x1080/0x1fd8 net/ipv6/sit.c:1068
lr : pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
lr : pskb_may_pull include/linux/skbuff.h:2756 [inline]
lr : pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
lr : pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
lr : sit_tunnel_xmit+0x1080/0x1fd8 net/ipv6/sit.c:1068
sp : ffff8000aa017260
x29: ffff8000aa0173e0 x28: ffff00000cd0c000 x27: ffff000046200080
x26: ffff700015402e64 x25: 00000000fffffff6 x24: 1fffe00009835b7f
x23: dfff800000000000 x22: ffff00004c1adbf4 x21: ffff00004c1adbf8
x20: ffff00004c1adb40 x19: 1fffe00009835b7e x18: ffff800086d72d10
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 1fffe0000a15c217 x13: 0000000000000000 x12: ffff8000aa017320
x11: 0000000000040000 x10: 0000000000000b86 x9 : ffff8000a2639000
x8 : 0000000000000b87 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000aa016c98 x4 : ffff800086d8b120 x3 : ffff800083f7f7d4
x2 : 0000000000000001 x1 : 00000000fffffff6 x0 : 0000000000000000
Call trace:
 pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
 pskb_may_pull include/linux/skbuff.h:2756 [inline]
 pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
 pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
 sit_tunnel_xmit+0x1080/0x1fd8 net/ipv6/sit.c:1068
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
 net/ipv6/sit.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 655c9b1a19b8..b83c28369d46 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1065,14 +1065,17 @@ static netdev_tx_t sit_tunnel_xmit__(struct sk_buff *skb,
 static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
-	if (!pskb_inet_may_pull(skb))
-		goto tx_err;
-
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+			goto tx_err;
+
 		sit_tunnel_xmit__(skb, dev, IPPROTO_IPIP);
 		break;
 	case htons(ETH_P_IPV6):
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
+			goto tx_err;
+
 		ipip6_tunnel_xmit(skb, dev);
 		break;
 #if IS_ENABLED(CONFIG_MPLS)
-- 
2.30.2


