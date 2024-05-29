Return-Path: <netdev+bounces-98960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3B8D33BA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0770287DB2
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D53916D31A;
	Wed, 29 May 2024 09:52:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A3E167DAB;
	Wed, 29 May 2024 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976365; cv=none; b=pMOaWYHGbFzVTUMT2/8ue5jTpylUbX5wZF8VVuSyM1htKs3dy/pXuQJOsm8XbCx5KzOT05jQ9n4ssyAeuqN5XzJ6P0rMkaK++53u106qGjDwdmnyfXg0YbxDdJPsZwBctk/fyhYC+3kzZZNnmK3U17mkIhkY/NdKawbHSNRI2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976365; c=relaxed/simple;
	bh=DIW2Z5bfGmlHm1iu3bJA4B6td7X95z9Shz8Ueh5bupk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AE91oBf6SW5njqK5MCUJxhal8QBa9Qhh4eejfoymxA/pC5MvrHJJuBC0+JBUeZdSNPFMG7XmgTqd2JeHqJD/LtDJc60jGZr2E3aonmrstPKjBN11QmeowpzlVkIB1Vv1rXz+vOAcaFfH8mEfsaWrns/TeFCxJ0YMiUEcgEuraT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Vq4NV3r77zPnbK;
	Wed, 29 May 2024 17:49:30 +0800 (CST)
Received: from canpemm500007.china.huawei.com (unknown [7.192.104.62])
	by mail.maildlp.com (Postfix) with ESMTPS id 41CF518007E;
	Wed, 29 May 2024 17:52:40 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 29 May
 2024 17:52:39 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maheshb@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net v2] ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound
Date: Wed, 29 May 2024 17:56:33 +0800
Message-ID: <20240529095633.613103-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)

Raw packet from PF_PACKET socket ontop of an IPv6-backed ipvlan device will
hit WARN_ON_ONCE() in sk_mc_loop() through sch_direct_xmit() path.

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
 ? __warn (kernel/panic.c:693)
 ? sk_mc_loop (net/core/sock.c:760)
 ? report_bug (lib/bug.c:201 lib/bug.c:219)
 ? handle_bug (arch/x86/kernel/traps.c:239)
 ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
 ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
 ? sk_mc_loop (net/core/sock.c:760)
 ip6_finish_output2 (net/ipv6/ip6_output.c:83 (discriminator 1))
 ? nf_hook_slow (net/netfilter/core.c:626)
 ip6_finish_output (net/ipv6/ip6_output.c:222)
 ? __pfx_ip6_finish_output (net/ipv6/ip6_output.c:215)
 ipvlan_xmit_mode_l3 (drivers/net/ipvlan/ipvlan_core.c:602) ipvlan
 ipvlan_start_xmit (drivers/net/ipvlan/ipvlan_main.c:226) ipvlan
 dev_hard_start_xmit (net/core/dev.c:3594)
 sch_direct_xmit (net/sched/sch_generic.c:343)
 __qdisc_run (net/sched/sch_generic.c:416)
 net_tx_action (net/core/dev.c:5286)
 handle_softirqs (kernel/softirq.c:555)
 __irq_exit_rcu (kernel/softirq.c:589)
 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043)

The warning triggers as this:
packet_sendmsg
   packet_snd //skb->sk is packet sk
      __dev_queue_xmit
         __dev_xmit_skb //q->enqueue is not NULL
             __qdisc_run
               sch_direct_xmit
                 dev_hard_start_xmit
                   ipvlan_start_xmit
                      ipvlan_xmit_mode_l3 //l3 mode
                        ipvlan_process_outbound //vepa flag
                          ipvlan_process_v6_outbound
                            ip6_local_out
                                __ip6_finish_output
                                  ip6_finish_output2 //multicast packet
                                    sk_mc_loop //sk->sk_family is AF_PACKET

Call ip{6}_local_out() with NULL sk in ipvlan as other tunnels to fix this.

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v2: relocate Fixes tag
---
 drivers/net/ipvlan/ipvlan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 2d5b021b4ea6..fef4eff7753a 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -439,7 +439,7 @@ static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 
-	err = ip_local_out(net, skb->sk, skb);
+	err = ip_local_out(net, NULL, skb);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
@@ -494,7 +494,7 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 
 	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 
-	err = ip6_local_out(dev_net(dev), skb->sk, skb);
+	err = ip6_local_out(dev_net(dev), NULL, skb);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
-- 
2.34.1


