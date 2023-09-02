Return-Path: <netdev+bounces-31805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA36D79047E
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 02:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B8E2819F6
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 00:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E88217C8;
	Sat,  2 Sep 2023 00:28:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D07F
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 00:28:44 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6726FE65
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 17:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693614523; x=1725150523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E6Ajmj+CRMUodnV113kmcURCRRcKOZYC2WgwcjByro4=;
  b=eM36KGRptKxl7dqVq5OsqvPeB7JpaZYjDiaIqfCdMpYRKQN6BCWSae2N
   C5xT/gLBmAjyUVDB1E/kEGLP6iIWhgfuiP5lQXCWz3N8PuT5u+jPhrop4
   pED7nldypQ/0LWRTLoVeSWALcnNkl69Lb1DvDAkJm620fLPLeY4bZ+OxK
   Y=;
X-IronPort-AV: E=Sophos;i="6.02,221,1688428800"; 
   d="scan'208";a="236730479"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 00:28:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id B42E4A0979;
	Sat,  2 Sep 2023 00:28:37 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sat, 2 Sep 2023 00:28:36 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sat, 2 Sep 2023 00:28:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v1 net 3/4] af_unix: Fix data-races around sk->sk_shutdown.
Date: Fri, 1 Sep 2023 17:27:07 -0700
Message-ID: <20230902002708.91816-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230902002708.91816-1-kuniyu@amazon.com>
References: <20230902002708.91816-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.14]
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk->sk_shutdown is changed under unix_state_lock(sk), but
unix_dgram_sendmsg() calls two functions to read sk_shutdown locklessly.

  sock_alloc_send_pskb
  `- sock_wait_for_wmem

Let's use READ_ONCE() there.

Note that the writer side was marked by commit e1d09c2c2f57 ("af_unix:
Fix data races around sk->sk_shutdown.").

BUG: KCSAN: data-race in sock_alloc_send_pskb / unix_release_sock

write (marked) to 0xffff8880069af12c of 1 bytes by task 1 on cpu 1:
 unix_release_sock+0x75c/0x910 net/unix/af_unix.c:631
 unix_release+0x59/0x80 net/unix/af_unix.c:1053
 __sock_release+0x7d/0x170 net/socket.c:654
 sock_close+0x19/0x30 net/socket.c:1386
 __fput+0x2a3/0x680 fs/file_table.c:384
 ____fput+0x15/0x20 fs/file_table.c:412
 task_work_run+0x116/0x1a0 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x174/0x180 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1a/0x30 kernel/entry/common.c:297
 do_syscall_64+0x4b/0x90 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

read to 0xffff8880069af12c of 1 bytes by task 28650 on cpu 0:
 sock_alloc_send_pskb+0xd2/0x620 net/core/sock.c:2767
 unix_dgram_sendmsg+0x2f8/0x14f0 net/unix/af_unix.c:1944
 unix_seqpacket_sendmsg net/unix/af_unix.c:2308 [inline]
 unix_seqpacket_sendmsg+0xba/0x130 net/unix/af_unix.c:2292
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0x148/0x160 net/socket.c:748
 ____sys_sendmsg+0x4e4/0x610 net/socket.c:2494
 ___sys_sendmsg+0xc6/0x140 net/socket.c:2548
 __sys_sendmsg+0x94/0x140 net/socket.c:2577
 __do_sys_sendmsg net/socket.c:2586 [inline]
 __se_sys_sendmsg net/socket.c:2584 [inline]
 __x64_sys_sendmsg+0x45/0x50 net/socket.c:2584
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

value changed: 0x00 -> 0x03

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 28650 Comm: systemd-coredum Not tainted 6.4.0-11989-g6843306689af #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index d3c7b53368d2..e3da7eae9338 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2747,7 +2747,7 @@ static long sock_wait_for_wmem(struct sock *sk, long timeo)
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 		if (refcount_read(&sk->sk_wmem_alloc) < READ_ONCE(sk->sk_sndbuf))
 			break;
-		if (sk->sk_shutdown & SEND_SHUTDOWN)
+		if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 			break;
 		if (sk->sk_err)
 			break;
@@ -2777,7 +2777,7 @@ struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
 			goto failure;
 
 		err = -EPIPE;
-		if (sk->sk_shutdown & SEND_SHUTDOWN)
+		if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 			goto failure;
 
 		if (sk_wmem_alloc_get(sk) < READ_ONCE(sk->sk_sndbuf))
-- 
2.30.2


