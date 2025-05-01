Return-Path: <netdev+bounces-187190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D84AA592E
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 02:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CFD1BC7EBE
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072CE1E51F5;
	Thu,  1 May 2025 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Yt+RBKzN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CE19F421
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746060832; cv=none; b=N/TdnoI/EtHO0mJ03380lFVxdYd0mRwPUNScbIUofCKap8BURV6mm8VPlykd5ogSFUyON59EVP56+57K+5j488OsoL5oE/dNJyyNxMa4RC5OfDABCy6sUg0J97KWNa2snyfKVTAJ3csnyZTwdRxxtUshMULkijPeRakUDcyO+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746060832; c=relaxed/simple;
	bh=ZRu3q5MMfT5fSITpleNqz011dnF6yI7JCdBXvXMYmpM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BSyMLnRKUqqvfvdBvdZDLjQ9UPEruBSuKgiV94Wiotwv9SX0VahJ4aShGuIc3CRlJLJREnwXXMbRgJrrJwmBEATYi+KwZVDrTyO8Gg19IHCbyNq3UI8QisbFxWNGO9UKBNW77f3ge4f6IeREjmqHESFBTSdIxuRlXhYY8HfkNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Yt+RBKzN; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746060832; x=1777596832;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WYdnddClgS06MYwceBL2xXH+2KSBvas2qDlbFXF2Rvw=;
  b=Yt+RBKzNgvXq68rY3Bu+AzmMrYrQV177asGiFycG2nWxrXS5tdVDnyJB
   zQmCNl4H8wytosLhX4Tqc4VZqPFgMY2vF320XygaWHCd48rkfThDkoKck
   pyKbXvNDJHSERvNGu2NnAt65gcgDORhwpoMcbbarUo2eJQFvZZ9SxZt+f
   c=;
X-IronPort-AV: E=Sophos;i="6.15,253,1739836800"; 
   d="scan'208";a="487913752"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 00:53:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:59685]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.21:2525] with esmtp (Farcaster)
 id 04dfc699-4646-480e-8411-36d9c8e1a05f; Thu, 1 May 2025 00:53:47 +0000 (UTC)
X-Farcaster-Flow-ID: 04dfc699-4646-480e-8411-36d9c8e1a05f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 00:53:46 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 00:53:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>, Yi Lai <yi1.lai@linux.intel.com>
Subject: [PATCH v2 net-next] ipv6: Restore fib6_config validation for SIOCADDRT.
Date: Wed, 30 Apr 2025 17:53:29 -0700
Message-ID: <20250501005335.53683-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported out-of-bounds read in ipv6_addr_prefix(),
where the prefix length was over 128.

The cited commit accidentally removed some fib6_config
validation from the ioctl path.

Let's restore the validation.

[0]:
BUG: KASAN: slab-out-of-bounds in ip6_route_info_create (./include/net/ipv6.h:616 net/ipv6/route.c:3814)
Read of size 1 at addr ff11000138020ad4 by task repro/261

CPU: 3 UID: 0 PID: 261 Comm: repro Not tainted 6.15.0-rc3-00614-g0d15a26b247d #87 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:123)
 print_report (mm/kasan/report.c:409 mm/kasan/report.c:521)
 kasan_report (mm/kasan/report.c:636)
 ip6_route_info_create (./include/net/ipv6.h:616 net/ipv6/route.c:3814)
 ip6_route_add (net/ipv6/route.c:3902)
 ipv6_route_ioctl (net/ipv6/route.c:4523)
 inet6_ioctl (net/ipv6/af_inet6.c:577)
 sock_do_ioctl (net/socket.c:1190)
 sock_ioctl (net/socket.c:1314)
 __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:906 fs/ioctl.c:892 fs/ioctl.c:892)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f518fb2de5d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007fff14f38d18 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f518fb2de5d
RDX: 00000000200015c0 RSI: 000000000000890b RDI: 0000000000000003
RBP: 00007fff14f38d30 R08: 0000000000000800 R09: 0000000000000800
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff14f38e48
R13: 0000000000401136 R14: 0000000000403df0 R15: 00007f518fd3c000
 </TASK>

Fixes: fa76c1674f2e ("ipv6: Move some validation from ip6_route_info_create() to rtm_to_fib6_config().")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: Yi Lai <yi1.lai@linux.intel.com>
Closes: https://lore.kernel.org/netdev/aBAcKDEFoN%2FLntBF@ly-workstation/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
v2:
  * Remove extra space in a condition
  * Fix build failure

v1: https://lore.kernel.org/netdev/20250429014624.61938-1-kuniyu@amazon.com/
---
 net/ipv6/route.c | 97 +++++++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index aa6b45bd3515..44300962230b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4503,6 +4503,53 @@ void rt6_purge_dflt_routers(struct net *net)
 	rcu_read_unlock();
 }
 
+static int fib6_config_validate(struct fib6_config *cfg,
+				struct netlink_ext_ack *extack)
+{
+	/* RTF_PCPU is an internal flag; can not be set by userspace */
+	if (cfg->fc_flags & RTF_PCPU) {
+		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_PCPU");
+		goto errout;
+	}
+
+	/* RTF_CACHE is an internal flag; can not be set by userspace */
+	if (cfg->fc_flags & RTF_CACHE) {
+		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_CACHE");
+		goto errout;
+	}
+
+	if (cfg->fc_type > RTN_MAX) {
+		NL_SET_ERR_MSG(extack, "Invalid route type");
+		goto errout;
+	}
+
+	if (cfg->fc_dst_len > 128) {
+		NL_SET_ERR_MSG(extack, "Invalid prefix length");
+		goto errout;
+	}
+
+#ifdef CONFIG_IPV6_SUBTREES
+	if (cfg->fc_src_len > 128) {
+		NL_SET_ERR_MSG(extack, "Invalid source address length");
+		goto errout;
+	}
+
+	if (cfg->fc_nh_id && cfg->fc_src_len) {
+		NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
+		goto errout;
+	}
+#else
+	if (cfg->fc_src_len) {
+		NL_SET_ERR_MSG(extack,
+			       "Specifying source address requires IPV6_SUBTREES to be enabled");
+		goto errout;
+	}
+#endif
+	return 0;
+errout:
+	return -EINVAL;
+}
+
 static void rtmsg_to_fib6_config(struct net *net,
 				 struct in6_rtmsg *rtmsg,
 				 struct fib6_config *cfg)
@@ -4540,6 +4587,10 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 
 	switch (cmd) {
 	case SIOCADDRT:
+		err = fib6_config_validate(&cfg, NULL);
+		if (err)
+			break;
+
 		/* Only do the default setting of fc_metric in route adding */
 		if (cfg.fc_metric == 0)
 			cfg.fc_metric = IP6_RT_PRIO_USER;
@@ -5274,48 +5325,6 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	if (newroute) {
-		/* RTF_PCPU is an internal flag; can not be set by userspace */
-		if (cfg->fc_flags & RTF_PCPU) {
-			NL_SET_ERR_MSG(extack, "Userspace can not set RTF_PCPU");
-			goto errout;
-		}
-
-		/* RTF_CACHE is an internal flag; can not be set by userspace */
-		if (cfg->fc_flags & RTF_CACHE) {
-			NL_SET_ERR_MSG(extack, "Userspace can not set RTF_CACHE");
-			goto errout;
-		}
-
-		if (cfg->fc_type > RTN_MAX) {
-			NL_SET_ERR_MSG(extack, "Invalid route type");
-			goto errout;
-		}
-
-		if (cfg->fc_dst_len > 128) {
-			NL_SET_ERR_MSG(extack, "Invalid prefix length");
-			goto errout;
-		}
-
-#ifdef CONFIG_IPV6_SUBTREES
-		if (cfg->fc_src_len > 128) {
-			NL_SET_ERR_MSG(extack, "Invalid source address length");
-			goto errout;
-		}
-
-		if (cfg->fc_nh_id &&  cfg->fc_src_len) {
-			NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
-			goto errout;
-		}
-#else
-		if (cfg->fc_src_len) {
-			NL_SET_ERR_MSG(extack,
-				       "Specifying source address requires IPV6_SUBTREES to be enabled");
-			goto errout;
-		}
-#endif
-	}
-
 	err = 0;
 errout:
 	return err;
@@ -5710,6 +5719,10 @@ static int inet6_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = fib6_config_validate(&cfg, extack);
+	if (err)
+		return err;
+
 	if (cfg.fc_metric == 0)
 		cfg.fc_metric = IP6_RT_PRIO_USER;
 
-- 
2.49.0


