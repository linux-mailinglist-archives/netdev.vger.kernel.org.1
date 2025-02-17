Return-Path: <netdev+bounces-167103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2FA38D5E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 21:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020ED171ACA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8223872E;
	Mon, 17 Feb 2025 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LITA1zbb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D6E237180
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824670; cv=none; b=t5Bz9n51yTrlaSUv+ngiIthwmd05ccsg5qEaSDimklKKvgblD8LN7qhoudv+xIVjnqMwhrnI8GyJgqHMJfzDCBvo3DKGalXVvB3I61hcFlJxvg1y3wECIiHHsVOeCvBXOo38XcrhPjttiO4fK+VWsEm1QMdBknqmX88MiF11ibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824670; c=relaxed/simple;
	bh=y+eeQLw6tWb4YJfER5yehml1r/QwCRnPRoa3hlavJ8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxDWefn/9qwSBr0oFiccoiT8euRj1LQnN68NjlXQH0QUFlYVZszSkoR/TXiJlXslNZRkS7LcF61uy4Ag63GFWUlX35KcvtAmv6pIz7OUxEJMmmccfLrmVeJ87R64jl0Y39sByMRP1bgeHaASmcVzF1KVsnVFix5HV7GC00F5UYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LITA1zbb; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739824668; x=1771360668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iz4BmU3qHiNsDSHiVRjqdOu7sU4SUHD6akAVwCBLZsQ=;
  b=LITA1zbbtQ60u8++v3zGLY0CY2ua6riFPoD+KlQtRNlMHw2q322jpFTy
   SubSkSrxKgP+LowX/KmtzdPtJdkjeCkEOqDyTmqgaa4gOIEQC0JNNkdFh
   5PozYk0bi54somNV7DFbKxaqpTDd1qLLr4/8b/POaQiIDvLuJJmknaT55
   s=;
X-IronPort-AV: E=Sophos;i="6.13,293,1732579200"; 
   d="scan'208";a="409391087"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 20:37:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:22578]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.176:2525] with esmtp (Farcaster)
 id a68df436-98fb-4cf6-9713-252ad1a8d5f8; Mon, 17 Feb 2025 20:37:42 +0000 (UTC)
X-Farcaster-Flow-ID: a68df436-98fb-4cf6-9713-252ad1a8d5f8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 20:37:42 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Feb 2025 20:37:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Brad Spengler <spender@grsecurity.net>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, "Harald
 Welte" <laforge@gnumonks.org>
Subject: [PATCH v1 net 1/2] gtp: Suppress list corruption splat in gtp_net_exit_batch_rtnl().
Date: Mon, 17 Feb 2025 12:37:04 -0800
Message-ID: <20250217203705.40342-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250217203705.40342-1-kuniyu@amazon.com>
References: <20250217203705.40342-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Brad Spengler reported the list_del() corruption splat in
gtp_net_exit_batch_rtnl(). [0]

Commit eb28fd76c0a0 ("gtp: Destroy device along with udp socket's netns
dismantle.") added the for_each_netdev() loop in gtp_net_exit_batch_rtnl()
to destroy devices in each netns as done in geneve and ip tunnels.

However, this could trigger ->dellink() twice for the same device during
->exit_batch_rtnl().

Say we have two netns A & B and gtp device B that resides in netns B but
whose UDP socket is in netns A.

  1. cleanup_net() processes netns A and then B.

  2. gtp_net_exit_batch_rtnl() finds the device B while iterating
     netns A's gn->gtp_dev_list and calls ->dellink().

  [ device B is not yet unlinked from netns B
    as unregister_netdevice_many() has not been called. ]

  3. gtp_net_exit_batch_rtnl() finds the device B while iterating
     netns B's for_each_netdev() and calls ->dellink().

gtp_dellink() cleans up the device's hash table, unlinks the dev from
gn->gtp_dev_list, and calls unregister_netdevice_queue().

Basically, calling gtp_dellink() multiple times is fine unless
CONFIG_DEBUG_LIST is enabled.

Let's remove for_each_netdev() in gtp_net_exit_batch_rtnl() and
delegate the destruction to default_device_exit_batch() as done
in bareudp.

[0]:
list_del corruption, ffff8880aaa62c00->next (autoslab_size_M_dev_P_net_core_dev_11127_8_1328_8_S_4096_A_64_n_139+0xc00/0x1000 [slab object]) is LIST_POISON1 (ffffffffffffff02) (prev is 0xffffffffffffff04)
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 UID: 0 PID: 1804 Comm: kworker/u8:7 Tainted: G                T   6.12.13-grsec-full-20250211091339 #1
Tainted: [T]=RANDSTRUCT
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:[<ffffffff84947381>] __list_del_entry_valid_or_report+0x141/0x200 lib/list_debug.c:58
Code: c2 76 91 31 c0 e8 9f b1 f7 fc 0f 0b 4d 89 f0 48 c7 c1 02 ff ff ff 48 89 ea 48 89 ee 48 c7 c7 e0 c2 76 91 31 c0 e8 7f b1 f7 fc <0f> 0b 4d 89 e8 48 c7 c1 04 ff ff ff 48 89 ea 48 89 ee 48 c7 c7 60
RSP: 0018:fffffe8040b4fbd0 EFLAGS: 00010283
RAX: 00000000000000cc RBX: dffffc0000000000 RCX: ffffffff818c4054
RDX: ffffffff84947381 RSI: ffffffff818d1512 RDI: 0000000000000000
RBP: ffff8880aaa62c00 R08: 0000000000000001 R09: fffffbd008169f32
R10: fffffe8040b4f997 R11: 0000000000000001 R12: a1988d84f24943e4
R13: ffffffffffffff02 R14: ffffffffffffff04 R15: ffff8880aaa62c08
RBX: kasan shadow of 0x0
RCX: __wake_up_klogd.part.0+0x74/0xe0 kernel/printk/printk.c:4554
RDX: __list_del_entry_valid_or_report+0x141/0x200 lib/list_debug.c:58
RSI: vprintk+0x72/0x100 kernel/printk/printk_safe.c:71
RBP: autoslab_size_M_dev_P_net_core_dev_11127_8_1328_8_S_4096_A_64_n_139+0xc00/0x1000 [slab object]
RSP: process kstack fffffe8040b4fbd0+0x7bd0/0x8000 [kworker/u8:7+netns 1804 ]
R09: kasan shadow of process kstack fffffe8040b4f990+0x7990/0x8000 [kworker/u8:7+netns 1804 ]
R10: process kstack fffffe8040b4f997+0x7997/0x8000 [kworker/u8:7+netns 1804 ]
R15: autoslab_size_M_dev_P_net_core_dev_11127_8_1328_8_S_4096_A_64_n_139+0xc08/0x1000 [slab object]
FS:  0000000000000000(0000) GS:ffff888116000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000748f5372c000 CR3: 0000000015408000 CR4: 00000000003406f0 shadow CR4: 00000000003406f0
Stack:
 0000000000000000 ffffffff8a0c35e7 ffffffff8a0c3603 ffff8880aaa62c00
 ffff8880aaa62c00 0000000000000004 ffff88811145311c 0000000000000005
 0000000000000001 ffff8880aaa62000 fffffe8040b4fd40 ffffffff8a0c360d
Call Trace:
 <TASK>
 [<ffffffff8a0c360d>] __list_del_entry_valid include/linux/list.h:131 [inline] fffffe8040b4fc28
 [<ffffffff8a0c360d>] __list_del_entry include/linux/list.h:248 [inline] fffffe8040b4fc28
 [<ffffffff8a0c360d>] list_del include/linux/list.h:262 [inline] fffffe8040b4fc28
 [<ffffffff8a0c360d>] gtp_dellink+0x16d/0x360 drivers/net/gtp.c:1557 fffffe8040b4fc28
 [<ffffffff8a0d0404>] gtp_net_exit_batch_rtnl+0x124/0x2c0 drivers/net/gtp.c:2495 fffffe8040b4fc88
 [<ffffffff8e705b24>] cleanup_net+0x5a4/0xbe0 net/core/net_namespace.c:635 fffffe8040b4fcd0
 [<ffffffff81754c97>] process_one_work+0xbd7/0x2160 kernel/workqueue.c:3326 fffffe8040b4fd88
 [<ffffffff81757195>] process_scheduled_works kernel/workqueue.c:3407 [inline] fffffe8040b4fec0
 [<ffffffff81757195>] worker_thread+0x6b5/0xfa0 kernel/workqueue.c:3488 fffffe8040b4fec0
 [<ffffffff817782a0>] kthread+0x360/0x4c0 kernel/kthread.c:397 fffffe8040b4ff78
 [<ffffffff814d8594>] ret_from_fork+0x74/0xe0 arch/x86/kernel/process.c:172 fffffe8040b4ffb8
 [<ffffffff8110f509>] ret_from_fork_asm+0x29/0xc0 arch/x86/entry/entry_64.S:399 fffffe8040b4ffe8
 </TASK>
Modules linked in:

Fixes: eb28fd76c0a0 ("gtp: Destroy device along with udp socket's netns dismantle.")
Reported-by: Brad Spengler <spender@grsecurity.net>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Harald Welte <laforge@gnumonks.org>
---
 drivers/net/gtp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index d64740bf44ed..b7b46c5e6399 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2481,11 +2481,6 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
 	list_for_each_entry(net, net_list, exit_list) {
 		struct gtp_net *gn = net_generic(net, gtp_net_id);
 		struct gtp_dev *gtp, *gtp_next;
-		struct net_device *dev;
-
-		for_each_netdev(net, dev)
-			if (dev->rtnl_link_ops == &gtp_link_ops)
-				gtp_dellink(dev, dev_to_kill);
 
 		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
 			gtp_dellink(gtp->dev, dev_to_kill);
-- 
2.39.5 (Apple Git-154)


