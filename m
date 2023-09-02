Return-Path: <netdev+bounces-31803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0266579047C
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 02:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC891C2093A
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 00:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB58315A7;
	Sat,  2 Sep 2023 00:28:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85D7F
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 00:28:02 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856DE5C
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 17:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693614481; x=1725150481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mkYU8qnWBL1vln+cnRzuUev9jm41eI24VZIUD6vQ1m0=;
  b=g2VR03JkC5Twady9SBL8FNu4Mb+jrHmjBexxuEjAyRPAtD4FxG6rNiyc
   jqo/VkWxcZx3mzKoKv3/zKfjvJCR0LBpeo876HJa9GXpWK1xKWVzGqOiQ
   OXGethptf1jr4aS23i+hV4jumQGAY8zFr95ZhB3EnKzdGrAK/QuHbPJyo
   U=;
X-IronPort-AV: E=Sophos;i="6.02,221,1688428800"; 
   d="scan'208";a="354102173"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 00:27:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com (Postfix) with ESMTPS id 4DDA7805A0;
	Sat,  2 Sep 2023 00:27:58 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sat, 2 Sep 2023 00:27:48 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sat, 2 Sep 2023 00:27:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v1 net 1/4] af_unix: Fix data-races around user->unix_inflight.
Date: Fri, 1 Sep 2023 17:27:05 -0700
Message-ID: <20230902002708.91816-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

user->unix_inflight is changed under spin_lock(unix_gc_lock),
but too_many_unix_fds() reads it locklessly.

Let's annotate the write/read accesses to user->unix_inflight.

BUG: KCSAN: data-race in unix_attach_fds / unix_inflight

write to 0xffffffff8546f2d0 of 8 bytes by task 44798 on cpu 1:
 unix_inflight+0x157/0x180 net/unix/scm.c:66
 unix_attach_fds+0x147/0x1e0 net/unix/scm.c:123
 unix_scm_to_skb net/unix/af_unix.c:1827 [inline]
 unix_dgram_sendmsg+0x46a/0x14f0 net/unix/af_unix.c:1950
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

read to 0xffffffff8546f2d0 of 8 bytes by task 44814 on cpu 0:
 too_many_unix_fds net/unix/scm.c:101 [inline]
 unix_attach_fds+0x54/0x1e0 net/unix/scm.c:110
 unix_scm_to_skb net/unix/af_unix.c:1827 [inline]
 unix_dgram_sendmsg+0x46a/0x14f0 net/unix/af_unix.c:1950
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

value changed: 0x000000000000000c -> 0x000000000000000d

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 44814 Comm: systemd-coredum Not tainted 6.4.0-11989-g6843306689af #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014

Fixes: 712f4aad406b ("unix: properly account for FDs passed over unix sockets")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Willy Tarreau <w@1wt.eu>
---
 net/unix/scm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/unix/scm.c b/net/unix/scm.c
index e9dde7176c8a..6ff628f2349f 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -64,7 +64,7 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
 	}
-	user->unix_inflight++;
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
 	spin_unlock(&unix_gc_lock);
 }
 
@@ -85,7 +85,7 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
 	}
-	user->unix_inflight--;
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
 	spin_unlock(&unix_gc_lock);
 }
 
@@ -99,7 +99,7 @@ static inline bool too_many_unix_fds(struct task_struct *p)
 {
 	struct user_struct *user = current_user();
 
-	if (unlikely(user->unix_inflight > task_rlimit(p, RLIMIT_NOFILE)))
+	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
 		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
 	return false;
 }
-- 
2.30.2


