Return-Path: <netdev+bounces-97168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B518C9AF3
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 12:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3804C1F21649
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9E142044;
	Mon, 20 May 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f77A5jqj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81D1EA67
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199506; cv=none; b=el9xgRxW4MZLkT9sunGaqN3zpTcsa1DTPW69xzR6mJeAbahZSQZOxEICYD9jTWsmSu48pddTzjstpF3nP+ATwmiSzI978X6MFepLr5KEVUZ35y1LbZpakAHootVdZ2OHSpOuBY/vV76bhBjYftLiSszg+/6SsnWafMzLBTeNk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199506; c=relaxed/simple;
	bh=oiDaKRoUtICjYZslGN/4Ldn861PCdrMGRQ+QfopV+jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnV5mBIf2LDrqsKXU6frZUPO5t7d6C+YyEv08Rt+eaVLa45rtp5uAauuCd1Wyvg9xNbbluUrd89NDG/xyFTaHoqMzQVibzCRACus5lty0ZsvtM8HZj1v1X80MAyf2uZAzk7/8c4Kdl9BOV17QRQ6zS1kPWfVNqqCCicpkFXdFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f77A5jqj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716199503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9HQQLcPWzaqUGkC9nCDOvkj5OQLS3KXzzaU4mTKKha4=;
	b=f77A5jqj2Q379W1aEDMEPqmEpVXf43iQT1hcHVgOPpEl6u8y8KE8EwMPdImnk66HnK69a/
	8Ri+MXs2ky/dFWLNpuler8CCCCNlTOh3xZhZtWi86GQVQ0Fe4O3dLBlhwmuE2va2jQTyQV
	OapeucgspNLlQxYhN5UDB3lnEdByvZs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-jAQ7S4t5Mp6W-sSjwM8Qvg-1; Mon,
 20 May 2024 06:05:00 -0400
X-MC-Unique: jAQ7S4t5Mp6W-sSjwM8Qvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC2F93813BCD;
	Mon, 20 May 2024 10:04:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5107B7412;
	Mon, 20 May 2024 10:04:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH net] tcp: ensure sk_showdown is 0 for listening sockets
Date: Mon, 20 May 2024 12:04:47 +0200
Message-ID: <8db98a8fbf2ac673b355651852093579a913f3f1.1716199422.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

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

Listener sockets are supposed to have a zero sk_shutdown, as the
accepted children will inherit such field.

Invoking shutdown() before entering the listener status allows
violating the above constraint.

After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for
TCP_SYN_RECV sockets"), the above causes the child to reach the accept
syscall in FIN_WAIT1 status.

Address the issue explicitly by clearing sk_shutdown at listen time.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/490
Fixes: 1da177e4c3fu ("Linux-2.6.12-rc2")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note: the issue above reports an MPTCP reproducer, but I can reproduce
the issue even using plain TCP sockets only.
---
 net/ipv4/inet_connection_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 3b38610958ee..dab723fea0cc 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1269,6 +1269,8 @@ int inet_csk_listen_start(struct sock *sk)
 
 	reqsk_queue_alloc(&icsk->icsk_accept_queue);
 
+	/* closed sockets can have non zero sk_shutdown */
+	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk->sk_ack_backlog = 0;
 	inet_csk_delack_init(sk);
 
-- 
2.43.2


