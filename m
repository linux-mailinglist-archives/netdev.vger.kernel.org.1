Return-Path: <netdev+bounces-71813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F29D8552FF
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB16F29114E
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF213A27B;
	Wed, 14 Feb 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hTAsyhcv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419B171A2
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938007; cv=none; b=Lhm1hsIS42htrbxAnwQ0ZKOZm3f3LMd8Nfl9u1Mb0FpES0gSGGaXnVqdZiouJSy5Z5FdeZ8xD/2eytaaPGdGQIQVVyNytIHM1e1qWnWtHEK6+em5mGUndERYQV7peiclPls1PaPNDHyg68vNTFAuKVLAjdtw0LGvCPkbrbBB/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938007; c=relaxed/simple;
	bh=1edK4Wq+UJ1rIMPd9xsrnjjzW9KRJ9u1IPBGi7tMYXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t4C+7TJbuyO04BtrXfdYuFtlKQhy8dApu6CVRuJMMMTVc696KSJ02yvlvOjPG7elBgk18fPlg4ZDO7nqj2RGICcpq9ni0AlkPX5HNpGN2sLYKZUQVF8YU0deftycIC6h5h4OOyCTkD5aTfE+uJfqOmrx/aCksUI6M70DWAfnE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hTAsyhcv; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707938005; x=1739474005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iUbr/0ZpRN1hoOQRQFJIyBCXUdOOLBSlqfz4Ll5jQ7c=;
  b=hTAsyhcv8h7Wl9QrwHAcEXaxrBWvIubsxoSxmIxl7WYO+n8NDhHLgKZC
   ynKfD0dEXCwfptKKGVQBVATuh1XLU/k/Uw4mfNjr8BQukttT8QHoWQHRO
   4jeg9jDxQZXj1DQLNQfM9lvT2eNpFWHiXVqHhE0CMk2hOP0idi4dth18m
   8=;
X-IronPort-AV: E=Sophos;i="6.06,160,1705363200"; 
   d="scan'208";a="613094286"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:13:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:47481]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.174:2525] with esmtp (Farcaster)
 id 428a6395-8b4c-40ca-a248-86b93d56d7a1; Wed, 14 Feb 2024 19:13:21 +0000 (UTC)
X-Farcaster-Flow-ID: 428a6395-8b4c-40ca-a248-86b93d56d7a1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 19:13:21 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 19:13:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v3 net] dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().
Date: Wed, 14 Feb 2024 11:13:08 -0800
Message-ID: <20240214191308.98504-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported a warning [0] in inet_csk_destroy_sock() with no
repro.

  WARN_ON(inet_sk(sk)->inet_num && !inet_csk(sk)->icsk_bind_hash);

However, the syzkaller's log hinted that connect() failed just before
the warning due to FAULT_INJECTION.  [1]

When connect() is called for an unbound socket, we search for an
available ephemeral port.  If a bhash bucket exists for the port, we
call __inet_check_established() or __inet6_check_established() to check
if the bucket is reusable.

If reusable, we add the socket into ehash and set inet_sk(sk)->inet_num.

Later, we look up the corresponding bhash2 bucket and try to allocate
it if it does not exist.

Although it rarely occurs in real use, if the allocation fails, we must
revert the changes by check_established().  Otherwise, an unconnected
socket could illegally occupy an ehash entry.

Note that we do not put tw back into ehash because sk might have
already responded to a packet for tw and it would be better to free
tw earlier under such memory presure.

[0]:
WARNING: CPU: 0 PID: 350830 at net/ipv4/inet_connection_sock.c:1193 inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1193)
Modules linked in:
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1193)
Code: 41 5c 41 5d 41 5e e9 2d 4a 3d fd e8 28 4a 3d fd 48 89 ef e8 f0 cd 7d ff 5b 5d 41 5c 41 5d 41 5e e9 13 4a 3d fd e8 0e 4a 3d fd <0f> 0b e9 61 fe ff ff e8 02 4a 3d fd 4c 89 e7 be 03 00 00 00 e8 05
RSP: 0018:ffffc9000b21fd38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000009e78 RCX: ffffffff840bae40
RDX: ffff88806e46c600 RSI: ffffffff840bb012 RDI: ffff88811755cca8
RBP: ffff88811755c880 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000009e78 R11: 0000000000000000 R12: ffff88811755c8e0
R13: ffff88811755c892 R14: ffff88811755c918 R15: 0000000000000000
FS:  00007f03e5243800(0000) GS:ffff88811ae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f21000 CR3: 0000000112ffe001 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1193)
 dccp_close (net/dccp/proto.c:1078)
 inet_release (net/ipv4/af_inet.c:434)
 __sock_release (net/socket.c:660)
 sock_close (net/socket.c:1423)
 __fput (fs/file_table.c:377)
 __fput_sync (fs/file_table.c:462)
 __x64_sys_close (fs/open.c:1557 fs/open.c:1539 fs/open.c:1539)
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
RIP: 0033:0x7f03e53852bb
Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 43 c9 f5 ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 c9 f5 ff 8b 44
RSP: 002b:00000000005dfba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f03e53852bb
RDX: 0000000000000002 RSI: 0000000000000002 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000167c
R10: 0000000008a79680 R11: 0000000000000293 R12: 00007f03e4e43000
R13: 00007f03e4e43170 R14: 00007f03e4e43178 R15: 00007f03e4e43170
 </TASK>

[1]:
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 350833 Comm: syz-executor.1 Not tainted 6.7.0-12272-g2121c43f88f5 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
 should_fail_ex (lib/fault-inject.c:52 lib/fault-inject.c:153)
 should_failslab (mm/slub.c:3748)
 kmem_cache_alloc (mm/slub.c:3763 mm/slub.c:3842 mm/slub.c:3867)
 inet_bind2_bucket_create (net/ipv4/inet_hashtables.c:135)
 __inet_hash_connect (net/ipv4/inet_hashtables.c:1100)
 dccp_v4_connect (net/dccp/ipv4.c:116)
 __inet_stream_connect (net/ipv4/af_inet.c:676)
 inet_stream_connect (net/ipv4/af_inet.c:747)
 __sys_connect_file (net/socket.c:2048 (discriminator 2))
 __sys_connect (net/socket.c:2065)
 __x64_sys_connect (net/socket.c:2072)
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
RIP: 0033:0x7f03e5284e5d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007f03e4641cc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00000000004bbf80 RCX: 00007f03e5284e5d
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000004bbf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000b R14: 00007f03e52e5530 R15: 0000000000000000
 </TASK>

Reported-by: syzkaller <syzkaller@googlegroups.com>
Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v3:
  * Call inet_twsk_deschedule_put() with BH disabled

v2: https://lore.kernel.org/netdev/20240213214218.81786-1-kuniyu@amazon.com/
  * Unhash twsk from bhash/bhash2

v1: https://lore.kernel.org/netdev/20240209025409.27235-1-kuniyu@amazon.com/
---
 net/ipv4/inet_hashtables.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 93e9193df544..308ff34002ea 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1130,10 +1130,33 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	return 0;
 
 error:
+	if (sk_hashed(sk)) {
+		spinlock_t *lock = inet_ehash_lockp(hinfo, sk->sk_hash);
+
+		sock_prot_inuse_add(net, sk->sk_prot, -1);
+
+		spin_lock(lock);
+		sk_nulls_del_node_init_rcu(sk);
+		spin_unlock(lock);
+
+		sk->sk_hash = 0;
+		inet_sk(sk)->inet_sport = 0;
+		inet_sk(sk)->inet_num = 0;
+
+		if (tw)
+			inet_twsk_bind_unhash(tw, hinfo);
+	}
+
 	spin_unlock(&head2->lock);
 	if (tb_created)
 		inet_bind_bucket_destroy(hinfo->bind_bucket_cachep, tb);
-	spin_unlock_bh(&head->lock);
+	spin_unlock(&head->lock);
+
+	if (tw)
+		inet_twsk_deschedule_put(tw);
+
+	local_bh_enable();
+
 	return -ENOMEM;
 }
 
-- 
2.30.2


