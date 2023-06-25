Return-Path: <netdev+bounces-13827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D221373D1FC
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 18:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF761C208DA
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149726AC0;
	Sun, 25 Jun 2023 16:14:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073EA2596
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 16:14:04 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D405E4C
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687709641; x=1719245641;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7P61KV5zCQp+Lux636Oc8S5rquZtEXbkeGVCz9s1X4c=;
  b=Yh+X1gNhyg3RcS2R7q19gYLGTG1/tzS0sX2vPcxrpqLf41VpgYEu5+kP
   LpMPgTt/a3glNzK7+vXt0wO5F3uPln+DWuf59cCfBkxpdbLZjdxr70Q04
   Xp3IkD29ZfKHL6xmSRtjnKanujYQPIYuFNz6E/n8KAUNqXr2e+sQoqtIE
   U=;
X-IronPort-AV: E=Sophos;i="6.01,157,1684800000"; 
   d="scan'208";a="343083891"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 16:13:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 9AA5640D5D;
	Sun, 25 Jun 2023 16:13:56 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 25 Jun 2023 16:13:49 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 25 Jun 2023 16:13:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com>
Subject: [PATCH v1 net] netlink: Add sock_i_ino_irqsaved() for __netlink_diag_dump().
Date: Sun, 25 Jun 2023 09:13:34 -0700
Message-ID: <20230625161334.51672-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.27]
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot reported a warning in __local_bh_enable_ip(). [0]

Commit 8d61f926d420 ("netlink: fix potential deadlock in
netlink_set_err()") converted read_lock(&nl_table_lock) to
read_lock_irqsave() in __netlink_diag_dump() to prevent a deadlock.

However, __netlink_diag_dump() calls sock_i_ino() that uses
read_lock_bh() and read_unlock_bh().  read_unlock_bh() finally
enables BH even though it should stay disabled until the following
read_unlock_irqrestore().

Using read_lock() in sock_i_ino() would trigger a lockdep splat
in another place that was fixed in commit f064af1e500a ("net: fix
a lockdep splat"), so let's add another function that would be safe
to use under BH disabled.

[0]:
WARNING: CPU: 0 PID: 5012 at kernel/softirq.c:376 __local_bh_enable_ip+0xbe/0x130 kernel/softirq.c:376
Modules linked in:
CPU: 0 PID: 5012 Comm: syz-executor487 Not tainted 6.4.0-rc7-syzkaller-00202-g6f68fc395f49 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__local_bh_enable_ip+0xbe/0x130 kernel/softirq.c:376
Code: 45 bf 01 00 00 00 e8 91 5b 0a 00 e8 3c 15 3d 00 fb 65 8b 05 ec e9 b5 7e 85 c0 74 58 5b 5d c3 65 8b 05 b2 b6 b4 7e 85 c0 75 a2 <0f> 0b eb 9e e8 89 15 3d 00 eb 9f 48 89 ef e8 6f 49 18 00 eb a8 0f
RSP: 0018:ffffc90003a1f3d0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000201 RCX: 1ffffffff1cf5996
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff8805c6f3
RBP: ffffffff8805c6f3 R08: 0000000000000001 R09: ffff8880152b03a3
R10: ffffed1002a56074 R11: 0000000000000005 R12: 00000000000073e4
R13: dffffc0000000000 R14: 0000000000000002 R15: 0000000000000000
FS:  0000555556726300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 000000007c646000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sock_i_ino+0x83/0xa0 net/core/sock.c:2559
 __netlink_diag_dump+0x45c/0x790 net/netlink/diag.c:171
 netlink_diag_dump+0xd6/0x230 net/netlink/diag.c:207
 netlink_dump+0x570/0xc50 net/netlink/af_netlink.c:2269
 __netlink_dump_start+0x64b/0x910 net/netlink/af_netlink.c:2374
 netlink_dump_start include/linux/netlink.h:329 [inline]
 netlink_diag_handler_dump+0x1ae/0x250 net/netlink/diag.c:238
 __sock_diag_cmd net/core/sock_diag.c:238 [inline]
 sock_diag_rcv_msg+0x31e/0x440 net/core/sock_diag.c:269
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2547
 sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x71c/0x900 net/socket.c:2503
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2557
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2586
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5303aaabb9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7506e548 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5303aaabb9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007f5303a6ed60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5303a6edf0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Fixes: 8d61f926d420 ("netlink: fix potential deadlock in netlink_set_err()")
Reported-by: syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5da61cf6a9bc1902d422
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/sock.h |  1 +
 net/core/sock.c    | 11 +++++++++++
 net/netlink/diag.c |  2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 6f428a7f3567..48bda71a8c99 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2101,6 +2101,7 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 
 kuid_t sock_i_uid(struct sock *sk);
 unsigned long sock_i_ino(struct sock *sk);
+unsigned long sock_i_ino_bh_disabled(struct sock *sk);
 
 static inline kuid_t sock_net_uid(const struct net *net, const struct sock *sk)
 {
diff --git a/net/core/sock.c b/net/core/sock.c
index 6e5662ca00fe..99ae761ec592 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2561,6 +2561,17 @@ unsigned long sock_i_ino(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_i_ino);
 
+unsigned long sock_i_ino_bh_disabled(struct sock *sk)
+{
+	unsigned long ino;
+
+	read_lock(&sk->sk_callback_lock);
+	ino = sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_ino : 0;
+	read_unlock(&sk->sk_callback_lock);
+	return ino;
+}
+EXPORT_SYMBOL(sock_i_ino_bh_disabled);
+
 /*
  * Allocate a skb from the socket's send buffer.
  */
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index 4143b2ea4195..e11af5514cc9 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -168,7 +168,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				 NETLINK_CB(cb->skb).portid,
 				 cb->nlh->nlmsg_seq,
 				 NLM_F_MULTI,
-				 sock_i_ino(sk)) < 0) {
+				 sock_i_ino_bh_disabled(sk)) < 0) {
 			ret = 1;
 			break;
 		}
-- 
2.30.2


