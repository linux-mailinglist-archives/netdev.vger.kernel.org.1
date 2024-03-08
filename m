Return-Path: <netdev+bounces-78838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D38876B9E
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 21:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01B91F219D1
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 20:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375B05C908;
	Fri,  8 Mar 2024 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="b/JyQnBS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF02D60B
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929008; cv=none; b=BeaOSsmNqft+FCrYKGV/SJCzAC7Z5X23V0ym4syp0ca75IvT4Z50MVShzU3kJ2ZJIsGLbkvO066d4iH+GXw5FMuSBNThHTX8omECALMVvaJv0ujK/RaZOF7O30MJ+3pLPk0exo3x/gWPk1ol40dvx8ittXUb5s38GQ6R+HW0ft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929008; c=relaxed/simple;
	bh=+YVPtHBycN+AACDBDEEPd5k2bzqKA/tM049GyTjwCPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KyYY2PMd51+13ebH1Cdaw7ZETFEJPL7NZSrUhKKKF/13ipLljVp2SZJcdplEHoFoosYmkpsLaM700G6LlXpuwXvp9hdjoGy6grutnkgU1U7uRhylg3GrvUMDnfhVPTj3fSs9dRgz3zWU7U0mQCKWWQZQ68eNA0Pek1XSC8md1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=b/JyQnBS; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709929007; x=1741465007;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BSiIJtxrSs8MQyvnltFH0+eYKG9vt1JnFCd8FMWdc8c=;
  b=b/JyQnBSoChjb9qRZH9Fdt0Y4sxsEjfIGCb5N2mdzW2gOQJrc2UwK2ZV
   Fmk42BRgPSa41Vh7YL8EoI6ai/RiwQGQaTOoRlrPcDxzkLQVkSCgpdI7E
   yafM6ZcSM1VHklpCPGUVUEzJoX2741frjPR129VDENzjQ6S9PpqSY/RBb
   0=;
X-IronPort-AV: E=Sophos;i="6.07,110,1708387200"; 
   d="scan'208";a="402624537"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 20:16:46 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:2788]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.36:2525] with esmtp (Farcaster)
 id bfc32c47-d585-42e7-9a1d-e6afd55206fa; Fri, 8 Mar 2024 20:16:45 +0000 (UTC)
X-Farcaster-Flow-ID: bfc32c47-d585-42e7-9a1d-e6afd55206fa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 20:16:41 +0000
Received: from 88665a182662.ant.amazon.com.com (10.142.235.16) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 20:16:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>,
	<syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com>
Subject: [PATCH v1 net] tcp: Fix refcnt handling in __inet_hash_connect().
Date: Fri, 8 Mar 2024 12:16:23 -0800
Message-ID: <20240308201623.65448-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzbot reported a warning in sk_nulls_del_node_init_rcu().

The commit 66b60b0c8c4a ("dccp/tcp: Unhash sk from ehash for tb2 alloc
failure after check_estalblished().") tried to fix an issue that an
unconnected socket occupies an ehash entry when bhash2 allocation fails.

In such a case, we need to revert changes done by check_established(),
which does not hold refcnt when inserting socket into ehash.

So, to revert the change, we need to __sk_nulls_add_node_rcu() instead
of sk_nulls_add_node_rcu().

Otherwise, sock_put() will cause refcnt underflow and leak the socket.

[0]:
WARNING: CPU: 0 PID: 23948 at include/net/sock.h:799 sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
Modules linked in:
CPU: 0 PID: 23948 Comm: syz-executor.2 Not tainted 6.8.0-rc6-syzkaller-00159-gc055fc00c07b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
Code: e8 7f 71 c6 f7 83 fb 02 7c 25 e8 35 6d c6 f7 4d 85 f6 0f 95 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 1b 6d c6 f7 90 <0f> 0b 90 eb b2 e8 10 6d c6 f7 4c 89 e7 be 04 00 00 00 e8 63 e7 d2
RSP: 0018:ffffc900032d7848 EFLAGS: 00010246
RAX: ffffffff89cd0035 RBX: 0000000000000001 RCX: 0000000000040000
RDX: ffffc90004de1000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 1ffff1100439ac26 R08: ffffffff89ccffe3 R09: 1ffff1100439ac28
R10: dffffc0000000000 R11: ffffed100439ac29 R12: ffff888021cd6140
R13: dffffc0000000000 R14: ffff88802a9bf5c0 R15: ffff888021cd6130
FS:  00007f3b823f16c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b823f0ff8 CR3: 000000004674a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __inet_hash_connect+0x140f/0x20b0 net/ipv4/inet_hashtables.c:1139
 dccp_v6_connect+0xcb9/0x1480 net/dccp/ipv6.c:956
 __inet_stream_connect+0x262/0xf30 net/ipv4/af_inet.c:678
 inet_stream_connect+0x65/0xa0 net/ipv4/af_inet.c:749
 __sys_connect_file net/socket.c:2048 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2072
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f3b8167dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3b823f10c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f3b817abf80 RCX: 00007f3b8167dda9
RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f3b823f1120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000b R14: 00007f3b817abf80 R15: 00007ffd3beb57b8
 </TASK>

Reported-by: syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=12c506c1aae251e70449
Fixes: 66b60b0c8c4a ("dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_hashtables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 308ff34002ea..4e470f18487f 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1136,7 +1136,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		sock_prot_inuse_add(net, sk->sk_prot, -1);
 
 		spin_lock(lock);
-		sk_nulls_del_node_init_rcu(sk);
+		__sk_nulls_del_node_init_rcu(sk);
 		spin_unlock(lock);
 
 		sk->sk_hash = 0;
-- 
2.30.2


