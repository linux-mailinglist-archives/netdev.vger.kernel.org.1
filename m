Return-Path: <netdev+bounces-31804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0C479047D
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 02:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC241C20B40
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 00:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0BD17CB;
	Sat,  2 Sep 2023 00:28:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE187F
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 00:28:17 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1230CE5C
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 17:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693614496; x=1725150496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jj3+uXp0A6E1JfjuAb2X+P6dIAxPSww4H33bpYhE7EE=;
  b=e4otzdIVRxjY28cfyJZNTIWjsBF7O9gFMfXb0cRZdjngL4v3W2JeMkz6
   8OU5SXfwXcZofEKNPLxkm8HCRsMHhDB3OEdW5Zi7VxWJ2y2+/RLdihZc4
   EMeI73zh8QTecrjkRuUsEZf4RAcwf22/oWmKR+iBZ8CNCvivbkcaSckdl
   U=;
X-IronPort-AV: E=Sophos;i="6.02,221,1688428800"; 
   d="scan'208";a="26572138"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 00:28:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 1657540D68;
	Sat,  2 Sep 2023 00:28:13 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sat, 2 Sep 2023 00:28:12 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sat, 2 Sep 2023 00:28:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>, Pavel Emelyanov <xemul@openvz.org>
Subject: [PATCH v1 net 2/4] af_unix: Fix data-race around unix_tot_inflight.
Date: Fri, 1 Sep 2023 17:27:06 -0700
Message-ID: <20230902002708.91816-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

unix_tot_inflight is changed under spin_lock(unix_gc_lock), but
unix_release_sock() reads it locklessly.

Let's use READ_ONCE() for unix_tot_inflight.

Note that the writer side was marked by commit 9d6d7f1cb67c ("af_unix:
annote lockless accesses to unix_tot_inflight & gc_in_progress")

BUG: KCSAN: data-race in unix_inflight / unix_release_sock

write (marked) to 0xffffffff871852b8 of 4 bytes by task 123 on cpu 1:
 unix_inflight+0x130/0x180 net/unix/scm.c:64
 unix_attach_fds+0x137/0x1b0 net/unix/scm.c:123
 unix_scm_to_skb net/unix/af_unix.c:1832 [inline]
 unix_dgram_sendmsg+0x46a/0x14f0 net/unix/af_unix.c:1955
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0x148/0x160 net/socket.c:747
 ____sys_sendmsg+0x4e4/0x610 net/socket.c:2493
 ___sys_sendmsg+0xc6/0x140 net/socket.c:2547
 __sys_sendmsg+0x94/0x140 net/socket.c:2576
 __do_sys_sendmsg net/socket.c:2585 [inline]
 __se_sys_sendmsg net/socket.c:2583 [inline]
 __x64_sys_sendmsg+0x45/0x50 net/socket.c:2583
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

read to 0xffffffff871852b8 of 4 bytes by task 4891 on cpu 0:
 unix_release_sock+0x608/0x910 net/unix/af_unix.c:671
 unix_release+0x59/0x80 net/unix/af_unix.c:1058
 __sock_release+0x7d/0x170 net/socket.c:653
 sock_close+0x19/0x30 net/socket.c:1385
 __fput+0x179/0x5e0 fs/file_table.c:321
 ____fput+0x15/0x20 fs/file_table.c:349
 task_work_run+0x116/0x1a0 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x174/0x180 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1a/0x30 kernel/entry/common.c:297
 do_syscall_64+0x4b/0x90 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 4891 Comm: systemd-coredum Not tainted 6.4.0-rc5-01219-gfa0e21fa4443 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014

Fixes: 9305cfa4443d ("[AF_UNIX]: Make unix_tot_inflight counter non-atomic")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Pavel Emelyanov <xemul@openvz.org>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 86930a8ed012..3e8a04a13668 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -680,7 +680,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	 *	  What the above comment does talk about? --ANK(980817)
 	 */
 
-	if (unix_tot_inflight)
+	if (READ_ONCE(unix_tot_inflight))
 		unix_gc();		/* Garbage collect fds */
 }
 
-- 
2.30.2


