Return-Path: <netdev+bounces-68797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC82848480
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 09:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B297F1C219AA
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356D94779F;
	Sat,  3 Feb 2024 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KHlnGdyV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6C39FF7
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706949196; cv=none; b=Fn/27hDg9wY4YWmThdik5VSRnOJ4MjdAPhE5oIaz8SQ0zQmtGVpuXg7S/h2jtukuLUbz1QmCVA4fcx88NX6A0giMiDKb4TLFwfJRlzm/K9FEmvbD8CVfPbdHuDU02EIxkg5VHhX3mKYntp/viRuu/L3Rx8YSG5303ZnPFSUB6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706949196; c=relaxed/simple;
	bh=4jxAoMY5MLzEme4c6FT8w8oncp1Z4g/gNll84W4xizk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DpeA+Fnf+pGm5RTgCc9F4yQWrW88pfAsgn/d1soBt895cX9MldChsxHt4N0lrBAuS7WxvDwB9gCmTpznMwJEd3RyQk0IjAjqqfrEtJyGmCTPgMkuzeP53P0cJsXWaQs+EKBS0oCjQmhGKxxbgIirOg7pwMxU/jDDa9I0lbTQyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KHlnGdyV; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706949194; x=1738485194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N/yUi3qVRI3xUfPJgmb5lxkbYHtE6ETHG5iC1zU9bV8=;
  b=KHlnGdyV3yoD1fEXWW8uWVm7OHyEaz/A4MrTPS8WunfAWz03dm7OjXrp
   J5ghzcw8fyZOv7FcJy9MEkFKoYGrU5a9XY8PXD7mQfSCrJY6aSHK7H15+
   Q65ZBaN3zyx1ve0wxm80XLKbdldj2tH0mLh9MhTqLm6HbLpAD4VO4Y8Hy
   I=;
X-IronPort-AV: E=Sophos;i="6.05,240,1701129600"; 
   d="scan'208";a="63406800"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 08:33:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:53878]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.186:2525] with esmtp (Farcaster)
 id 188ab82a-34b5-4ac8-b28c-7d5fdbe3b28b; Sat, 3 Feb 2024 08:33:12 +0000 (UTC)
X-Farcaster-Flow-ID: 188ab82a-34b5-4ac8-b28c-7d5fdbe3b28b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 08:33:12 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Sat, 3 Feb 2024 08:33:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com>
Subject: [PATCH v1 net] af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
Date: Sat, 3 Feb 2024 00:32:59 -0800
Message-ID: <20240203083259.99822-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzbot reported a warning [0] in __unix_gc() with a repro, which
creates a socketpair and sends one socket's fd to itself using the
peer.

  socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
  sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\360", iov_len=1}],
          msg_iovlen=1, msg_control=[{cmsg_len=20, cmsg_level=SOL_SOCKET,
                                      cmsg_type=SCM_RIGHTS, cmsg_data=[3]}],
          msg_controllen=24, msg_flags=0}, MSG_OOB|MSG_PROBE|MSG_DONTWAIT|MSG_ZEROCOPY) = 1

This forms a self-cyclic reference that GC should finally untangle
but does not due to lack of MSG_OOB handling, resulting in memory
leak.

Recently, commit 11498715f266 ("af_unix: Remove io_uring code for
GC.") removed io_uring's dead code in GC and revealed the problem.

The code was executed at the final stage of GC and unconditionally
moved all GC candidates from gc_candidates to gc_inflight_list.
That papered over the reported problem by always making the following
WARN_ON_ONCE(!list_empty(&gc_candidates)) false.

The problem has been there since commit 2aab4b969002 ("af_unix: fix
struct pid leaks in OOB support") added full scm support for MSG_OOB
while fixing another bug.

To fix this problem, we must call kfree_skb() for unix_sk(sk)->oob_skb
if the socket still exists in gc_candidates after purging collected skb.

Note that the leaked socket remained being linked to a global list, so
kmemleak also could not detect it.  We need to check /proc/net/protocol
to notice the unfreed socket.

[0]:
WARNING: CPU: 0 PID: 2863 at net/unix/garbage.c:345 __unix_gc+0xc74/0xe80 net/unix/garbage.c:345
Modules linked in:
CPU: 0 PID: 2863 Comm: kworker/u4:11 Not tainted 6.8.0-rc1-syzkaller-00583-g1701940b1a02 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound __unix_gc
RIP: 0010:__unix_gc+0xc74/0xe80 net/unix/garbage.c:345
Code: 8b 5c 24 50 e9 86 f8 ff ff e8 f8 e4 22 f8 31 d2 48 c7 c6 30 6a 69 89 4c 89 ef e8 97 ef ff ff e9 80 f9 ff ff e8 dd e4 22 f8 90 <0f> 0b 90 e9 7b fd ff ff 48 89 df e8 5c e7 7c f8 e9 d3 f8 ff ff e8
RSP: 0018:ffffc9000b03fba0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000b03fc10 RCX: ffffffff816c493e
RDX: ffff88802c02d940 RSI: ffffffff896982f3 RDI: ffffc9000b03fb30
RBP: ffffc9000b03fce0 R08: 0000000000000001 R09: fffff52001607f66
R10: 0000000000000003 R11: 0000000000000002 R12: dffffc0000000000
R13: ffffc9000b03fc10 R14: ffffc9000b03fc10 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005559c8677a60 CR3: 000000000d57a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x889/0x15e0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x12a0 kernel/workqueue.c:2787
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Reported-by: syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa3ef895554bdbfd1183
Fixes: 2aab4b969002 ("af_unix: fix struct pid leaks in OOB support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Given the commit disabling SCM_RIGHTS w/ io_uring was backporeted to
stable trees, we can backport this patch without commit 11498715f266,
so targeting net tree.
---
 net/unix/garbage.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2405f0f9af31..61f313d4a5dd 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -314,6 +314,15 @@ void unix_gc(void)
 	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
 
+	list_for_each_entry_safe(u, next, &gc_candidates, link) {
+		struct sk_buff *skb = u->oob_skb;
+
+		if (skb) {
+			u->oob_skb = NULL;
+			kfree_skb(skb);
+		}
+	}
+
 	spin_lock(&unix_gc_lock);
 
 	/* There could be io_uring registered files, just push them back to
-- 
2.30.2


