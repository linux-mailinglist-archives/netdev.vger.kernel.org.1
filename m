Return-Path: <netdev+bounces-109976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE8C92A8E4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44EF1C21646
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBDF1482E0;
	Mon,  8 Jul 2024 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CKC4ON2M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B079FD
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462846; cv=none; b=tt23Kk83hHw+LqBsqj0PzCjxm4pXb2pH1Y2SENQa6ttXU3+RktGpCr/10nCLf8+qMca4/uUn46vsG48RlurWT3ngNmc1Ij3H5YXZB3pvcpMieMTOrRdshkFzdEHbfaUcDKgHZ4ac60KVZ1xXU+UsjMw5vp8VeChxnjY2CzHIGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462846; c=relaxed/simple;
	bh=Ewa5KhI4UiK/8z/bwwDSrgDkpRioDs72o+Lm3LkEmXw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWvz94XW4u5BVRuwAnGC1JTVoTLcKWInbBLFTkZ2iOGqummpp0YRT0S/NmZIQd0lXnFiSZTtcPm9G9kN/5yEAeqQhgZi8Lm3XMTLgA/meQpi06Y7BN0kvWDeWXBTxA3324yt5z3ixyTlWwavbY0qMBzL2P3nu7mPiUuA4B5jxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CKC4ON2M; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720462845; x=1751998845;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3LoOUiSPmljmOOHtNkZS2d52AxVG6GYRIgzkRSFc59Y=;
  b=CKC4ON2MnYyAIRLFlPTJtCs6NgNY6IVq49ZhbtjIs57WqT12iZlpBoXe
   FuPE3IY0t6bh7IpFcc1j7R1jOUi0XM3Gjsj/u7A1rqyj+txpL94AHDGy9
   65DVlKKHoM49N/s4l3D6LbAaJZwDE+RosUZLK2e01xagJqnDo8zWvgrvl
   0=;
X-IronPort-AV: E=Sophos;i="6.09,192,1716249600"; 
   d="scan'208";a="412973946"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:20:40 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:40298]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.52:2525] with esmtp (Farcaster)
 id 40a36ad4-5740-4624-b05a-14a44fa342c8; Mon, 8 Jul 2024 18:20:39 +0000 (UTC)
X-Farcaster-Flow-ID: 40a36ad4-5740-4624-b05a-14a44fa342c8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 18:20:35 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 18:20:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v1 net] udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
Date: Mon, 8 Jul 2024 11:20:23 -0700
Message-ID: <20240708182023.93979-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller triggered the warning [0] in udp_v4_early_demux().

In udp_v4_early_demux(), we do not touch the refcount of the looked-up
sk and use sock_pfree() as skb->destructor, so we check SOCK_RCU_FREE
to ensure that the sk is safe to access during the RCU grace period.

Currently, SOCK_RCU_FREE is flagged for a bound socket after being put
into the hash table.  Moreover, the SOCK_RCU_FREE check is done too
early in udp_v4_early_demux(), so there could be a small race window:

  CPU1                                 CPU2
  ----                                 ----
  udp_v4_early_demux()                 udp_lib_get_port()
  |                                    |- hlist_add_head_rcu()
  |- sk = __udp4_lib_demux_lookup()    |
  |- DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
                                       `- sock_set_flag(sk, SOCK_RCU_FREE)

In practice, sock_pfree() is called much later, when SOCK_RCU_FREE
is most likely propagated for other CPUs; otherwise, we will see
another warning of sk refcount underflow, but at least I didn't.

Technically, moving sock_set_flag(sk, SOCK_RCU_FREE) before
hlist_add_{head,tail}_rcu() does not guarantee the order, and we
must put smp_mb() between them, or smp_wmb() there and smp_rmb()
in udp_v4_early_demux().

But it's overkill in the real scenario, so I just put smp_mb() only under
CONFIG_DEBUG_NET to silence the splat.  When we see the refcount underflow
warning, we can remove the config guard.

Another option would be to remove DEBUG_NET_WARN_ON_ONCE(), but this could
make future debugging harder without the hints in udp_v4_early_demux() and
udp_lib_get_port().

[0]:
WARNING: CPU: 0 PID: 11198 at net/ipv4/udp.c:2599 udp_v4_early_demux+0x481/0xb70 net/ipv4/udp.c:2599
Modules linked in:
CPU: 0 PID: 11198 Comm: syz-executor.1 Not tainted 6.9.0-g93bda33046e7 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:udp_v4_early_demux+0x481/0xb70 net/ipv4/udp.c:2599
Code: c5 7a 15 fe bb 01 00 00 00 44 89 e9 31 ff d3 e3 81 e3 bf ef ff ff 89 de e8 2c 74 15 fe 85 db 0f 85 02 06 00 00 e8 9f 7a 15 fe <0f> 0b e8 98 7a 15 fe 49 8d 7e 60 e8 4f 39 2f fe 49 c7 46 60 20 52
RSP: 0018:ffffc9000ce3fa58 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8318c92c
RDX: ffff888036ccde00 RSI: ffffffff8318c2f1 RDI: 0000000000000001
RBP: ffff88805a2dd6e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0001ffffffffffff R12: ffff88805a2dd680
R13: 0000000000000007 R14: ffff88800923f900 R15: ffff88805456004e
FS:  00007fc449127640(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc449126e38 CR3: 000000003de4b002 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 <TASK>
 ip_rcv_finish_core.constprop.0+0xbdd/0xd20 net/ipv4/ip_input.c:349
 ip_rcv_finish+0xda/0x150 net/ipv4/ip_input.c:447
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_rcv+0x16c/0x180 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core+0xb3/0xe0 net/core/dev.c:5624
 __netif_receive_skb+0x21/0xd0 net/core/dev.c:5738
 netif_receive_skb_internal net/core/dev.c:5824 [inline]
 netif_receive_skb+0x271/0x300 net/core/dev.c:5884
 tun_rx_batched drivers/net/tun.c:1549 [inline]
 tun_get_user+0x24db/0x2c50 drivers/net/tun.c:2002
 tun_chr_write_iter+0x107/0x1a0 drivers/net/tun.c:2048
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x76f/0x8d0 fs/read_write.c:590
 ksys_write+0xbf/0x190 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x41/0x50 fs/read_write.c:652
 x64_sys_call+0xe66/0x1990 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4b/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7fc44a68bc1f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 e9 cf f5 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 3c d0 f5 ff 48
RSP: 002b:00007fc449126c90 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004bc050 RCX: 00007fc44a68bc1f
RDX: 0000000000000032 RSI: 00000000200000c0 RDI: 00000000000000c8
RBP: 00000000004bc050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000032 R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc44a5ec530 R15: 0000000000000000
 </TASK>

Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 189c9113fe9a..1a05cc3d2b4f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -326,6 +326,12 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 			goto fail_unlock;
 		}
 
+		sock_set_flag(sk, SOCK_RCU_FREE);
+
+		if (IS_ENABLED(CONFIG_DEBUG_NET))
+			/* for DEBUG_NET_WARN_ON_ONCE() in udp_v4_early_demux(). */
+			smp_mb();
+
 		sk_add_node_rcu(sk, &hslot->head);
 		hslot->count++;
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
@@ -342,7 +348,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 		hslot2->count++;
 		spin_unlock(&hslot2->lock);
 	}
-	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	error = 0;
 fail_unlock:
 	spin_unlock_bh(&hslot->lock);
-- 
2.30.2


