Return-Path: <netdev+bounces-97929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081FA8CE29F
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 10:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B80283166
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 08:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1073D128375;
	Fri, 24 May 2024 08:49:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2115A84E03;
	Fri, 24 May 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540591; cv=none; b=aTxsanzdwqxyv47YmoMTR2Wz88b0yWzQEV9mKWgwrU+rgQQ9nmcm2MCMV4AMRDUOqD/Xor5Iu40W8yI130p0cqQ8+8UwaVsEJTH/n4toDNh/v9BR5bEw8HctUtQHp0lUmw9GGlnVBeEk6S+LjjSNKVUqCvH/6bpdgNVtjGvJwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540591; c=relaxed/simple;
	bh=+fyQmmBghd4ru55U3wBh/VC//Mi2k+SSW6qveTaC+5s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XBlValNcdrq3p+/OTmyB216es0IEYYjfuCKZuMYSVGmmypWFoO5fAEvbjCVg/1pUFF7Y1pm6bXVHujPM0oFyWwxQXlfDBzW8A6ve8eQdDOXMV5lb3p11rmlN82SwdFfci2pzlEHFWpVYbFeIdjzUu8NXrpKqhrajWKMPvhufqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VlzCh4RbFz2Cj36;
	Fri, 24 May 2024 16:46:08 +0800 (CST)
Received: from canpemm500007.china.huawei.com (unknown [7.192.104.62])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FB891A0188;
	Fri, 24 May 2024 16:49:39 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 16:49:38 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>,
	<jiri@resnulli.us>, <yuehaibing@huawei.com>, <hannes@stressinduktion.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net/sched: Add xmit_recursion level in sch_direct_xmit()
Date: Fri, 24 May 2024 16:51:08 +0800
Message-ID: <20240524085108.1430317-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)

packet from PF_PACKET socket ontop of an IPv6-backed ipvlan device will hit
WARN_ON_ONCE() in sk_mc_loop() through sch_direct_xmit() path while ipvlan
device has qdisc queue.

WARNING: CPU: 2 PID: 0 at net/core/sock.c:775 sk_mc_loop+0x2d/0x70
Modules linked in: sch_netem ipvlan rfkill cirrus drm_shmem_helper sg drm_kms_helper
CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted 6.9.0+ #279
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:sk_mc_loop+0x2d/0x70
Code: fa 0f 1f 44 00 00 65 0f b7 15 f7 96 a3 4f 31 c0 66 85 d2 75 26 48 85 ff 74 1c
RSP: 0018:ffffa9584015cd78 EFLAGS: 00010212
RAX: 0000000000000011 RBX: ffff91e585793e00 RCX: 0000000002c6a001
RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff91e589c0f000
RBP: ffff91e5855bd100 R08: 0000000000000000 R09: 3d00545216f43d00
R10: ffff91e584fdcc50 R11: 00000060dd8616f4 R12: ffff91e58132d000
R13: ffff91e584fdcc68 R14: ffff91e5869ce800 R15: ffff91e589c0f000
FS:  0000000000000000(0000) GS:ffff91e898100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f788f7c44c0 CR3: 0000000008e1a000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 ? __warn+0x83/0x130
 ? sk_mc_loop+0x2d/0x70
 ? report_bug+0x18e/0x1a0
 ? handle_bug+0x3c/0x70
 ? exc_invalid_op+0x18/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? sk_mc_loop+0x2d/0x70
 ip6_finish_output2+0x31e/0x590
 ? nf_hook_slow+0x43/0xf0
 ip6_finish_output+0x1f8/0x320
 ? __pfx_ip6_finish_output+0x10/0x10
 ipvlan_xmit_mode_l3+0x22a/0x2a0 [ipvlan]
 ipvlan_start_xmit+0x17/0x50 [ipvlan]
 dev_hard_start_xmit+0x8c/0x1d0
 sch_direct_xmit+0xa2/0x390
 __qdisc_run+0x66/0xd0
 net_tx_action+0x1ca/0x270
 handle_softirqs+0xd6/0x2b0
 __irq_exit_rcu+0x9b/0xc0
 sysvec_apic_timer_interrupt+0x75/0x90
 </IRQ>

Fixes: f60e5990d9c1 ("ipv6: protect skb->sk accesses from recursive dereference inside the stack")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/netdevice.h | 17 +++++++++++++++++
 net/core/dev.h            | 17 -----------------
 net/sched/sch_generic.c   |  8 +++++---
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d20c6c99eb88..7c0c9e9b045e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3261,6 +3261,23 @@ static inline int dev_recursion_level(void)
 	return this_cpu_read(softnet_data.xmit.recursion);
 }
 
+#define XMIT_RECURSION_LIMIT	8
+static inline bool dev_xmit_recursion(void)
+{
+	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
+			XMIT_RECURSION_LIMIT);
+}
+
+static inline void dev_xmit_recursion_inc(void)
+{
+	__this_cpu_inc(softnet_data.xmit.recursion);
+}
+
+static inline void dev_xmit_recursion_dec(void)
+{
+	__this_cpu_dec(softnet_data.xmit.recursion);
+}
+
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index b7b518bc2be5..49345ad7350b 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -149,21 +149,4 @@ static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
 struct napi_struct *napi_by_id(unsigned int napi_id);
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 
-#define XMIT_RECURSION_LIMIT	8
-static inline bool dev_xmit_recursion(void)
-{
-	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
-			XMIT_RECURSION_LIMIT);
-}
-
-static inline void dev_xmit_recursion_inc(void)
-{
-	__this_cpu_inc(softnet_data.xmit.recursion);
-}
-
-static inline void dev_xmit_recursion_dec(void)
-{
-	__this_cpu_dec(softnet_data.xmit.recursion);
-}
-
 #endif
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 2a637a17061b..74d9b43b7767 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -339,11 +339,13 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
 
 	if (likely(skb)) {
 		HARD_TX_LOCK(dev, txq, smp_processor_id());
-		if (!netif_xmit_frozen_or_stopped(txq))
+		if (!netif_xmit_frozen_or_stopped(txq)) {
+			dev_xmit_recursion_inc();
 			skb = dev_hard_start_xmit(skb, dev, txq, &ret);
-		else
+			dev_xmit_recursion_dec();
+		} else {
 			qdisc_maybe_clear_missed(q, txq);
-
+		}
 		HARD_TX_UNLOCK(dev, txq);
 	} else {
 		if (root_lock)
-- 
2.34.1


