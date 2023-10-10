Return-Path: <netdev+bounces-39401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683607BF066
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 03:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6791C209F3
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 01:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF7B38E;
	Tue, 10 Oct 2023 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K7Ze4QqH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FD621
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 01:38:31 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6F4B6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 18:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696901910; x=1728437910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wcI43Cu1sf+bjI2t73oR3IKD0vh1EBzNfOGzYwwBj+o=;
  b=K7Ze4QqHyaE4OnWuhE0vetIHq7QmSXwEwMNxuUTM13+Dz0XFb2ag5NHp
   pQLqpsUuCMXR9hU9igU5paGEku03bxP3dAgjAOQhxoVZEp/6HXXqZ0Tfr
   56Yjbif2cV4Sq0UAAN+fqn3pyT86+vqBE4b3b9L1Hl9KN6fQyKA3vH1mS
   A=;
X-IronPort-AV: E=Sophos;i="6.03,211,1694736000"; 
   d="scan'208";a="244473430"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:38:28 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id 77E7B40D42;
	Tue, 10 Oct 2023 01:38:27 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 01:38:26 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 01:38:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com>
Subject: [PATCH v1 net] tcp: Fix listen() warning with v4-mapped-v6 address.
Date: Mon, 9 Oct 2023 18:38:14 -0700
Message-ID: <20231010013814.70571-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.12]
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot reported a warning [0] introduced by commit c48ef9c4aed3 ("tcp: Fix
bind() regression for v4-mapped-v6 non-wildcard address.").

After the cited commit, a v4 socket's address matches the corresponding
v4-mapped-v6 tb2 in inet_bind2_bucket_match_addr(), not vice versa.

During X.X.X.X -> ::ffff:X.X.X.X order bind()s, the second bind() uses
bhash and conflicts properly without checking bhash2 so that we need not
check if a v4-mapped-v6 sk matches the corresponding v4 address tb2 in
inet_bind2_bucket_match_addr().  However, the repro shows that we need
to check that in a no-conflict case.

The repro bind()s two sockets to the 2-tuples using SO_REUSEPORT and calls
listen() for the first socket:

  from socket import *

  s1 = socket()
  s1.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
  s1.bind(('127.0.0.1', 0))

  s2 = socket(AF_INET6)
  s2.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
  s2.bind(('::ffff:127.0.0.1', s1.getsockname()[1]))

  s1.listen()

The second socket should belong to the first socket's tb2, but the second
bind() creates another tb2 bucket because inet_bind2_bucket_find() returns
NULL in inet_csk_get_port() as the v4-mapped-v6 sk does not match the
corresponding v4 address tb2.

  bhash2[] -> tb2(::ffff:X.X.X.X) -> tb2(X.X.X.X)

Then, listen() for the first socket calls inet_csk_get_port(), where the
v4 address matches the v4-mapped-v6 tb2 and WARN_ON() is triggered.

To avoid that, we need to check if v4-mapped-v6 sk address matches with
the corresponding v4 address tb2 in inet_bind2_bucket_match().

The same checks are needed in inet_bind2_bucket_addr_match() too, so we
can move all checks there and call it from inet_bind2_bucket_match().

Note that now tb->family is just an address family of tb->(v6_)?rcv_saddr
and not of sockets in the bucket.  This could be refactored later by
defining tb->rcv_saddr as tb->v6_rcv_saddr.s6_addr32[3] and prepending
::ffff: when creating v4 tb2.

[0]:
WARNING: CPU: 0 PID: 5049 at net/ipv4/inet_connection_sock.c:587 inet_csk_get_port+0xf96/0x2350 net/ipv4/inet_connection_sock.c:587
Modules linked in:
CPU: 0 PID: 5049 Comm: syz-executor288 Not tainted 6.6.0-rc2-syzkaller-00018-g2cf0f7156238 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:inet_csk_get_port+0xf96/0x2350 net/ipv4/inet_connection_sock.c:587
Code: 7c 24 08 e8 4c b6 8a 01 31 d2 be 88 01 00 00 48 c7 c7 e0 94 ae 8b e8 59 2e a3 f8 2e 2e 2e 31 c0 e9 04 fe ff ff e8 ca 88 d0 f8 <0f> 0b e9 0f f9 ff ff e8 be 88 d0 f8 49 8d 7e 48 e8 65 ca 5a 00 31
RSP: 0018:ffffc90003abfbf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888026429100 RCX: 0000000000000000
RDX: ffff88807edcbb80 RSI: ffffffff88b73d66 RDI: ffff888026c49f38
RBP: ffff888026c49f30 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff9260f200
R13: ffff888026c49880 R14: 0000000000000000 R15: ffff888026429100
FS:  00005555557d5380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 0000000025754000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inet_csk_listen_start+0x155/0x360 net/ipv4/inet_connection_sock.c:1256
 __inet_listen_sk+0x1b8/0x5c0 net/ipv4/af_inet.c:217
 inet_listen+0x93/0xd0 net/ipv4/af_inet.c:239
 __sys_listen+0x194/0x270 net/socket.c:1866
 __do_sys_listen net/socket.c:1875 [inline]
 __se_sys_listen net/socket.c:1873 [inline]
 __x64_sys_listen+0x53/0x80 net/socket.c:1873
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3a5bce3af9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1a1c79e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3a5bce3af9
RDX: 00007f3a5bce3af9 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f3a5bd565f0 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Fixes: c48ef9c4aed3 ("tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.")
Reported-by: syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=71e724675ba3958edb31
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_hashtables.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index c32f5e28758b..598c1b114d2c 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -149,8 +149,14 @@ static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
 					 const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb2->family)
-		return false;
+	if (sk->sk_family != tb2->family) {
+		if (sk->sk_family == AF_INET)
+			return ipv6_addr_v4mapped(&tb2->v6_rcv_saddr) &&
+				tb2->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
+
+		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
+			sk->sk_v6_rcv_saddr.s6_addr32[3] == tb2->rcv_saddr;
+	}
 
 	if (sk->sk_family == AF_INET6)
 		return ipv6_addr_equal(&tb2->v6_rcv_saddr,
@@ -819,19 +825,7 @@ static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,
 	    tb->l3mdev != l3mdev)
 		return false;
 
-#if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb->family) {
-		if (sk->sk_family == AF_INET)
-			return ipv6_addr_v4mapped(&tb->v6_rcv_saddr) &&
-				tb->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
-
-		return false;
-	}
-
-	if (sk->sk_family == AF_INET6)
-		return ipv6_addr_equal(&tb->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
-#endif
-	return tb->rcv_saddr == sk->sk_rcv_saddr;
+	return inet_bind2_bucket_addr_match(tb, sk);
 }
 
 bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const struct net *net,
-- 
2.30.2


