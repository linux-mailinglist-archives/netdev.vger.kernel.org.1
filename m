Return-Path: <netdev+bounces-97357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5AE8CAFD9
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 16:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417C81F24059
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C1F446B4;
	Tue, 21 May 2024 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FefC6kaI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E941E502
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300073; cv=none; b=Z+cGxH9uvmNjSBF6kZphebjSo7ANgTbj6SVPrYANF+yAn0pCssTzYRq/DrzeNwqWgPVMWup8Jn+5hm78hcW/LsRwDySs3hfp9fFa3Y2cB4gSRenVSQB7u32zY4ARad3egSnZN6TkigZp+RWxDzOlyTAa9QZwRoVLir8XFDp1/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300073; c=relaxed/simple;
	bh=aBsu+Y0gpqN7NBpsioSfS4gBmoWh/3+7Jc43XwGr2Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeUwgiqDNp/OyKroASgk60Ezu4+qdsyFPYSrOIXHgIHREgCxA3mB89UOYyQ9W6uK0aHlBMH9MzEJxjF+vDcNrw01FG00mkwERS3c0++wtq72ZrfsiB/eEcQOGzQtXyOe9bpTfWt29H6003eOjXS5B4cJnAhaLLm0qK2psuI2NEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FefC6kaI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716300070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+v113Fn8mMOE49mTX4a3emzSSdREfscVQ6BqHGmf620=;
	b=FefC6kaIoLmObLjFnCzNzE891Bq836A0k56WzQHhvUKhdlCtWNONg6uYyK5TCRHHArGGlY
	op5kcpDMHtWhXkSHaK3mZUxxlMm74f3thUHvTsKU4QI+/kBKrShUcoI13L7Dl5O02cr3xz
	9MxlA1B3c6aWmTronaqO4nYCzJmVU3o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-QwkE_b-tNHqiLO0fZUVyQw-1; Tue, 21 May 2024 10:01:07 -0400
X-MC-Unique: QwkE_b-tNHqiLO0fZUVyQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7F218025F9;
	Tue, 21 May 2024 14:01:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FD2D200A35C;
	Tue, 21 May 2024 14:01:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Christoph Paasch <cpaasch@apple.com>,
	Neal Cardwell <ncardwell@google.com>
Subject: [PATCH v2 net] net: relax socket state check at accept time.
Date: Tue, 21 May 2024 16:01:00 +0200
Message-ID: <23ab880a44d8cfd967e84de8b93dbf48848e3d8c.1716299669.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Christoph reported the following splat:

WARNING: CPU: 1 PID: 772 at net/ipv4/af_inet.c:761 __inet_accept+0x1f4/0x4a0
Modules linked in:
CPU: 1 PID: 772 Comm: syz-executor510 Not tainted 6.9.0-rc7-g7da7119fe22b #56
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:__inet_accept+0x1f4/0x4a0 net/ipv4/af_inet.c:759
Code: 04 38 84 c0 0f 85 87 00 00 00 41 c7 04 24 03 00 00 00 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ec b7 da fd <0f> 0b e9 7f fe ff ff e8 e0 b7 da fd 0f 0b e9 fe fe ff ff 89 d9 80
RSP: 0018:ffffc90000c2fc58 EFLAGS: 00010293
RAX: ffffffff836bdd14 RBX: 0000000000000000 RCX: ffff888104668000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff836bdb89 R09: fffff52000185f64
R10: dffffc0000000000 R11: fffff52000185f64 R12: dffffc0000000000
R13: 1ffff92000185f98 R14: ffff88810754d880 R15: ffff8881007b7800
FS:  000000001c772880(0000) GS:ffff88811b280000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb9fcf2e178 CR3: 00000001045d2002 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 inet_accept+0x138/0x1d0 net/ipv4/af_inet.c:786
 do_accept+0x435/0x620 net/socket.c:1929
 __sys_accept4_file net/socket.c:1969 [inline]
 __sys_accept4+0x9b/0x110 net/socket.c:1999
 __do_sys_accept net/socket.c:2016 [inline]
 __se_sys_accept net/socket.c:2013 [inline]
 __x64_sys_accept+0x7d/0x90 net/socket.c:2013
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x58/0x100 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x4315f9
Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 ab b4 fd ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdb26d9c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
RAX: ffffffffffffffda RBX: 0000000000400300 RCX: 00000000004315f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000006e1018 R08: 0000000000400300 R09: 0000000000400300
R10: 0000000000400300 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000040cdf0 R14: 000000000040ce80 R15: 0000000000000055
 </TASK>

The reproducer invokes shutdown() before entering the listener status.
After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for
TCP_SYN_RECV sockets"), the above causes the child to reach the accept
syscall in FIN_WAIT1 status.

Eric noted we can relax the existing assertion in __inet_accept()

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/490
Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - relax the existing check instead of clearing sk_shutdown at listen
   time
   https://lore.kernel.org/netdev/8db98a8fbf2ac673b355651852093579a913f3f1.1716199422.git.pabeni@redhat.com/

Note: I considered replacing the WARN_ON with WARN_ON_ONCE but we expect
it should never trigger, and hopefully we will get rid of it on net-next,
so I opted to avoid extra changes
---
 net/ipv4/af_inet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 44564d009e95..86cce7e9c2d1 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -758,7 +758,9 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
 	sock_rps_record_flow(newsk);
 	WARN_ON(!((1 << newsk->sk_state) &
 		  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
-		  TCPF_CLOSE_WAIT | TCPF_CLOSE)));
+		   TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 |
+		   TCPF_CLOSING | TCPF_CLOSE_WAIT |
+		   TCPF_CLOSE)));
 
 	if (test_bit(SOCK_SUPPORT_ZC, &sock->flags))
 		set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
-- 
2.43.2


