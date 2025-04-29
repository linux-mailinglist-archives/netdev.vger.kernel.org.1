Return-Path: <netdev+bounces-186628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A3DA9FF30
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 03:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6117E5A6536
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978761DC745;
	Tue, 29 Apr 2025 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TZbvVVXg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8521D6DDC
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745891204; cv=none; b=Dv70MNUj0WeYQmbIpfus0Om2nigto/lntcudywxeuqw8c/LMxUbUNAolZnjPjWAvvmFy4SA5Ei3fsMpFfFIan43SaDhNJKfxM4If6yDztBfu2mbK+vFMNbXXpIjLW3DTEjWOomtJYb6icAdVO9Bgjiqio9KBdGQERkokz+Vy2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745891204; c=relaxed/simple;
	bh=zfaJV5u4MAPEW1ZoNS1RM1QMiAnFtRmEQKUYp++vUlc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eqN2Zh2oz9cyoi1n1bU/lBSxsl41RrICN5XNTm5VRuD/V8fTCy+tOydjdJKO82mQQSxsMT7dKqBsbGocdglze1nNLXMUhd03JyJbtD/gc/kuSG8pWKs8DrvY5Em0ZOI+6MjYWl/Te84ih2rrrMaBz6ybDaueA+aldUaB3So2R28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TZbvVVXg; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745891203; x=1777427203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZVX8UQfGeh/C6bl0EaZvdi3kR7z2h6M2qFap9qAt98o=;
  b=TZbvVVXgI6O+37dCkkSk5RQeHLD4oWI1UH4DIAHQI/2v4Wy6ywLdKK26
   ZLyevYFN2jJDpU5bgP7TdoBA/Jnvc0jzXersaiRNa3yGCh9CUiQemewaR
   OlKMj+uG3zRpQj7QK+YtR/5Ea5fhz/6nayfpJfw8omqmCAP3jhWnzwXaK
   4=;
X-IronPort-AV: E=Sophos;i="6.15,247,1739836800"; 
   d="scan'208";a="819876726"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 01:46:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:56373]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.114:2525] with esmtp (Farcaster)
 id 433a2511-4689-4a67-a485-b492b6a7bd6e; Tue, 29 Apr 2025 01:46:37 +0000 (UTC)
X-Farcaster-Flow-ID: 433a2511-4689-4a67-a485-b492b6a7bd6e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 01:46:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.170.247) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 01:46:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>, Yi Lai <yi1.lai@linux.intel.com>
Subject: [PATCH v1 net-next] ipv6: Restore fib6_config validation for SIOCADDRT.
Date: Mon, 28 Apr 2025 18:46:14 -0700
Message-ID: <20250429014624.61938-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
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
---
 net/ipv6/route.c | 97 +++++++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d0351e95d916..4c1e86e968f8 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4496,6 +4496,53 @@ void rt6_purge_dflt_routers(struct net *net)
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
+	if (cfg->fc_nh_id &&  cfg->fc_src_len) {
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
@@ -4533,6 +4580,10 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 
 	switch (cmd) {
 	case SIOCADDRT:
+		err = fib6_config_validate(&cfg, NULL);
+		if (err)
+			break;
+
 		/* Only do the default setting of fc_metric in route adding */
 		if (cfg.fc_metric == 0)
 			cfg.fc_metric = IP6_RT_PRIO_USER;
@@ -5267,48 +5318,6 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -5703,6 +5712,10 @@ static int inet6_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = fib6_config_validate(cfg, extack);
+	if (err)
+		return err;
+
 	if (cfg.fc_metric == 0)
 		cfg.fc_metric = IP6_RT_PRIO_USER;
 
-- 
2.49.0


