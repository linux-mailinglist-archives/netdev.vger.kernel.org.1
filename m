Return-Path: <netdev+bounces-149564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352679E63DC
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 03:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58C2188394C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22DD14A09F;
	Fri,  6 Dec 2024 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tRVeGt0f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939113B79F
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450849; cv=none; b=VUSNLmKkN4ghDuTs8SJSr6mJXj2mHxZe/Pj2YqZ51x7lFQd6S8wcpSUT66IEsQ3qYXL5phaM00tyAns7g+yLvEkAkgBtD5M/w9CL4POX6Ebrj6aXldgZvRa/hBHSfJTBvrumjjpDvL6IHMN7CWMIQ/1fTN/WO8eWPdER2vJVvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450849; c=relaxed/simple;
	bh=4VzjYslEHfynkwuNZ3P3wOYfaaU4vjyO/FAVGsqHtro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mxTCdWXPo54+ICK+6X09jrAWVAjBLD5w1puHZHDCM6K2jU2eHjVnKofKBP5rJ4+rqa3YqiE/6AJfodAefhQVDKYpejBGiZrBNFF8++s8+jc3DEvAszAif2DFAw0m5fhfpcvbbCblnu6IuUGtZaGL7CYoemSC1B6utF6+D++i9NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tRVeGt0f; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733450847; x=1764986847;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1l+bJp5cTo/3R7qWh0Hqdxug6VgPf9jTuapx1tPPfJs=;
  b=tRVeGt0ffjF4bY3t70oXxCxyvGXWKD/uHvkqP76NEcy+otWyXnUPF7B8
   5bBTq21VBGQ/sMKHRTDmH3bB0ewoI3zGDqyIEDoFalHcEQ5L0JdbM7foq
   0fjVumSlTiBKZDlPFtS7z91Kb4n6xpv5374jX6ScZuo+b/X6f9iHfLaD6
   E=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="47105363"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 02:07:23 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:12403]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.181:2525] with esmtp (Farcaster)
 id 19132c41-4ea2-4b55-bc96-d96b711b84de; Fri, 6 Dec 2024 02:07:23 +0000 (UTC)
X-Farcaster-Flow-ID: 19132c41-4ea2-4b55-bc96-d96b711b84de
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 02:07:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.5.90) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 02:07:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman
	<horms@kernel.org>
CC: Menglong Dong <menglong8.dong@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v1 net] ip: Return drop reason if in_dev is NULL in ip_route_input_rcu().
Date: Fri, 6 Dec 2024 11:07:15 +0900
Message-ID: <20241206020715.80207-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported a warning in __sk_skb_reason_drop().

Commit 61b95c70f344 ("net: ip: make ip_route_input_rcu() return
drop reasons") missed a path where -EINVAL is returned.

Then, the cited commit started to trigger the warning with the
invalid error.

Let's fix it by returning SKB_DROP_REASON_NOT_SPECIFIED.

[0]:
WARNING: CPU: 0 PID: 10 at net/core/skbuff.c:1216 __sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
WARNING: CPU: 0 PID: 10 at net/core/skbuff.c:1216 sk_skb_reason_drop+0x97/0x1b0 net/core/skbuff.c:1241
Modules linked in:
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.12.0-10686-gbb18265c3aba #10 1c308307628619808b5a4a0495c4aab5637b0551
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: wg-crypt-wg2 wg_packet_decrypt_worker
RIP: 0010:__sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
RIP: 0010:sk_skb_reason_drop+0x97/0x1b0 net/core/skbuff.c:1241
Code: 5d 41 5c 41 5d 41 5e e9 e7 9e 95 fd e8 e2 9e 95 fd 31 ff 44 89 e6 e8 58 a1 95 fd 45 85 e4 0f 85 a2 00 00 00 e8 ca 9e 95 fd 90 <0f> 0b 90 e8 c1 9e 95 fd 44 89 e6 bf 01 00 00 00 e8 34 a1 95 fd 41
RSP: 0018:ffa0000000007650 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000000ffff RCX: ffffffff83bc3592
RDX: ff110001002a0000 RSI: ffffffff83bc34d6 RDI: 0000000000000007
RBP: ff11000109ee85f0 R08: 0000000000000001 R09: ffe21c00213dd0da
R10: 000000000000ffff R11: 0000000000000000 R12: 00000000ffffffea
R13: 0000000000000000 R14: ff11000109ee86d4 R15: ff11000109ee8648
FS:  0000000000000000(0000) GS:ff1100011a000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020177000 CR3: 0000000108a3d006 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 <IRQ>
 kfree_skb_reason include/linux/skbuff.h:1263 [inline]
 ip_rcv_finish_core.constprop.0+0x896/0x2320 net/ipv4/ip_input.c:424
 ip_list_rcv_finish.constprop.0+0x1b2/0x710 net/ipv4/ip_input.c:610
 ip_sublist_rcv net/ipv4/ip_input.c:636 [inline]
 ip_list_rcv+0x34a/0x460 net/ipv4/ip_input.c:670
 __netif_receive_skb_list_ptype net/core/dev.c:5715 [inline]
 __netif_receive_skb_list_core+0x536/0x900 net/core/dev.c:5762
 __netif_receive_skb_list net/core/dev.c:5814 [inline]
 netif_receive_skb_list_internal+0x77c/0xdc0 net/core/dev.c:5905
 gro_normal_list include/net/gro.h:515 [inline]
 gro_normal_list include/net/gro.h:511 [inline]
 napi_complete_done+0x219/0x8c0 net/core/dev.c:6256
 wg_packet_rx_poll+0xbff/0x1e40 drivers/net/wireguard/receive.c:488
 __napi_poll.constprop.0+0xb3/0x530 net/core/dev.c:6877
 napi_poll net/core/dev.c:6946 [inline]
 net_rx_action+0x9eb/0xe30 net/core/dev.c:7068
 handle_softirqs+0x1ac/0x740 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0x48/0x80 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xed/0x110 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:367 [inline]
 wg_packet_decrypt_worker+0x3ba/0x580 drivers/net/wireguard/receive.c:499
 process_one_work+0x940/0x1a70 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x639/0xe30 kernel/workqueue.c:3391
 kthread+0x283/0x350 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>

Fixes: 82d9983ebeb8 ("net: ip: make ip_route_input_noref() return drop reasons")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e5603e84b20d..0fbec3509618 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2478,7 +2478,8 @@ ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		int our = 0;
 
 		if (!in_dev)
-			return -EINVAL;
+			return reason;
+
 		our = ip_check_mc_rcu(in_dev, daddr, saddr,
 				      ip_hdr(skb)->protocol);
 
-- 
2.39.5 (Apple Git-154)


