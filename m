Return-Path: <netdev+bounces-13165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4285973A875
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02507281A37
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4646720681;
	Thu, 22 Jun 2023 18:44:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343121E536
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:44:16 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1569212B
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687459449; x=1718995449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AgBQefGFwiZppyqLjlVGIe0EPvM5IvzMlgy2UaXiFAo=;
  b=AMctFRuM8/TmK0cRWQHdAZUVxEXE5j7w07JBEONWdjT1nd4+BJwTJcDg
   LFJJtn9u6xFqWxA/9C9ZyiUgJXw6qqFlmpTzCwfGx02h1xsUn7fRqVGUZ
   uOC7/jObJBIYiEQV++NjKGZSV2goIrfillFr4hb3nDoffIv19XvWnGY2k
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,149,1684800000"; 
   d="scan'208";a="340487259"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 18:44:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 7DDC060B83;
	Thu, 22 Jun 2023 18:44:04 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Jun 2023 18:44:04 +0000
Received: from 88665a182662.ant.amazon.com (10.111.86.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Jun 2023 18:44:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Christian Brauner <brauner@kernel.org>, Alexander Mikhalitsyn
	<alexander@mihalicyn.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v2 net-next] af_unix: Call scm_recv() only after scm_set_cred().
Date: Thu, 22 Jun 2023 11:43:51 -0700
Message-ID: <20230622184351.91544-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.111.86.59]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzkaller hit a WARN_ON_ONCE(!scm->pid) in scm_pidfd_recv().

In unix_stream_read_generic(), if there is no skb in the queue, we could
bail out the do-while loop without calling scm_set_cred():

  1. No skb in the queue
  2. sk is non-blocking
       or
     shutdown(sk, RCV_SHUTDOWN) is called concurrently
       or
     peer calls close()

If the socket is configured with SO_PASSCRED or SO_PASSPIDFD, scm_recv()
would populate cmsg with garbage.

Let's not call scm_recv() unless there is skb to receive.

WARNING: CPU: 1 PID: 3245 at include/net/scm.h:138 scm_pidfd_recv include/net/scm.h:138 [inline]
WARNING: CPU: 1 PID: 3245 at include/net/scm.h:138 scm_recv.constprop.0+0x754/0x850 include/net/scm.h:177
Modules linked in:
CPU: 1 PID: 3245 Comm: syz-executor.1 Not tainted 6.4.0-rc5-01219-gfa0e21fa4443 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:scm_pidfd_recv include/net/scm.h:138 [inline]
RIP: 0010:scm_recv.constprop.0+0x754/0x850 include/net/scm.h:177
Code: 67 fd e9 55 fd ff ff e8 4a 70 67 fd e9 7f fd ff ff e8 40 70 67 fd e9 3e fb ff ff e8 36 70 67 fd e9 02 fd ff ff e8 8c 3a 20 fd <0f> 0b e9 fe fb ff ff e8 50 70 67 fd e9 2e f9 ff ff e8 46 70 67 fd
RSP: 0018:ffffc90009af7660 EFLAGS: 00010216
RAX: 00000000000000a1 RBX: ffff888041e58a80 RCX: ffffc90003852000
RDX: 0000000000040000 RSI: ffffffff842675b4 RDI: 0000000000000007
RBP: ffffc90009af7810 R08: 0000000000000007 R09: 0000000000000013
R10: 00000000000000f8 R11: 0000000000000001 R12: ffffc90009af7db0
R13: 0000000000000000 R14: ffff888041e58a88 R15: 1ffff9200135eecc
FS:  00007f6b7113f640(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b7111de38 CR3: 0000000012a6e002 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 <TASK>
 unix_stream_read_generic+0x5fe/0x1f50 net/unix/af_unix.c:2830
 unix_stream_recvmsg+0x194/0x1c0 net/unix/af_unix.c:2880
 sock_recvmsg_nosec net/socket.c:1019 [inline]
 sock_recvmsg+0x188/0x1d0 net/socket.c:1040
 ____sys_recvmsg+0x210/0x610 net/socket.c:2712
 ___sys_recvmsg+0xff/0x190 net/socket.c:2754
 do_recvmmsg+0x25d/0x6c0 net/socket.c:2848
 __sys_recvmmsg net/socket.c:2927 [inline]
 __do_sys_recvmmsg net/socket.c:2950 [inline]
 __se_sys_recvmmsg net/socket.c:2943 [inline]
 __x64_sys_recvmmsg+0x224/0x290 net/socket.c:2943
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3f/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f6b71da2e5d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007f6b7113ecc8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00000000004bc050 RCX: 00007f6b71da2e5d
RDX: 0000000000000007 RSI: 0000000020006600 RDI: 000000000000000b
RBP: 00000000004bc050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000120 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f6b71e03530 R15: 0000000000000000
 </TASK>

Fixes: 5e2ff6704a27 ("scm: add SO_PASSPIDFD and SCM_PIDFD")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Target to net-next (v1 was marked as ChangesRequested maybe
    due to one of the blamed commits is not in net.git)

  * Update changelog to clarify skb is not in the queue

v1: https://lore.kernel.org/netdev/20230620000009.9675-1-kuniyu@amazon.com/
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 73c61a010b01..f9d196439b49 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2826,7 +2826,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	} while (size);
 
 	mutex_unlock(&u->iolock);
-	if (state->msg)
+	if (state->msg && check_creds)
 		scm_recv(sock, state->msg, &scm, flags);
 	else
 		scm_destroy(&scm);
-- 
2.30.2


