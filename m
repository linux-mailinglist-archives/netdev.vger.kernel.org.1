Return-Path: <netdev+bounces-64614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B41835F3C
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2BA1B2712E
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E943A1CF;
	Mon, 22 Jan 2024 10:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F403A1A4
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918224; cv=none; b=Js7v+t7yKUyY1pcxCx1aq/s5cmTtuk6P3ACHqMx7/k/VDomHG93rxsoOXk0xSCfM/y+i7RHUnlw1C5DYUKv/IYal44jeLTnt79XFts8S2aJU+g2fUXeBn34ElxHPTuY8V2cOt2nbbubi3cteRlP1AnyMg4Jg1JfpE0G45Y7ao1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918224; c=relaxed/simple;
	bh=Xs02bXOHEtBherwX1MdNe+78dbMb/VhrNGWB5lDYz0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dg/Dm4H6ZH99zxFj6rI2QnjLpT9rfS4Tiwb5XPW1BK1/iiGjmfdPNXXwTM27lssDxAp9l8KXI83BCwoGVSXpYEbmXxrnnE1LkjRCRhaakXCDluP/Y5PcIN3be2CUYIxbJp3L4s2NV76hwSCAFh7/Q8GEfMckjtoObUVdQP/jUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TJQtd1gRJz1xmZr;
	Mon, 22 Jan 2024 18:09:29 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D0241402CB;
	Mon, 22 Jan 2024 18:10:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 18:10:18 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <shaozhengchao@huawei.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
Subject: [PATCH net] ipv6: init the accept_queue's spinlocks in inet6_create
Date: Mon, 22 Jan 2024 18:20:01 +0800
Message-ID: <20240122102001.2851701-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)

In commit 198bc90e0e73("tcp: make sure init the accept_queue's spinlocks
once"), the spinlocks of accept_queue are initialized only when socket is
created in the inet4 scenario. The locks are not initialized when socket
is created in the inet6 scenario. The kernel reports the following error:
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
Call Trace:
<TASK>
	dump_stack_lvl (lib/dump_stack.c:107)
	register_lock_class (kernel/locking/lockdep.c:1289)
	__lock_acquire (kernel/locking/lockdep.c:5015)
	lock_acquire.part.0 (kernel/locking/lockdep.c:5756)
	_raw_spin_lock_bh (kernel/locking/spinlock.c:178)
	inet_csk_listen_stop (net/ipv4/inet_connection_sock.c:1386)
	tcp_disconnect (net/ipv4/tcp.c:2981)
	inet_shutdown (net/ipv4/af_inet.c:935)
	__sys_shutdown (./include/linux/file.h:32 net/socket.c:2438)
	__x64_sys_shutdown (net/socket.c:2445)
	do_syscall_64 (arch/x86/entry/common.c:52)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
RIP: 0033:0x7f52ecd05a3d
Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
ff 73 01 c3 48 8b 0d ab a3 0e 00 f7 d8 64 89 01 48
RSP: 002b:00007f52ecf5dde8 EFLAGS: 00000293 ORIG_RAX: 0000000000000030
RAX: ffffffffffffffda RBX: 00007f52ecf5e640 RCX: 00007f52ecd05a3d
RDX: 00007f52ecc8b188 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f52ecf5de20 R08: 00007ffdae45c69f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f52ecf5e640
R13: 0000000000000000 R14: 00007f52ecc8b060 R15: 00007ffdae45c6e0

Fixes: 198bc90e0e73 ("tcp: make sure init the accept_queue's spinlocks once")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/ipv6/af_inet6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 13a1833a4df5..959bfd9f6344 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -199,6 +199,9 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	if (INET_PROTOSW_REUSE & answer_flags)
 		sk->sk_reuse = SK_CAN_REUSE;
 
+	if (INET_PROTOSW_ICSK & answer_flags)
+		inet_init_csk_locks(sk);
+
 	inet = inet_sk(sk);
 	inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
 
-- 
2.34.1


