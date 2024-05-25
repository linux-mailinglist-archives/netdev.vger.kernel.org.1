Return-Path: <netdev+bounces-98055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0068CEDC1
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 05:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAF61C209DB
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 03:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C2617C9;
	Sat, 25 May 2024 03:41:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89DAD25;
	Sat, 25 May 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716608507; cv=none; b=dai6dQ7d3OFPzo6WxZEImxv29t7zeeC3ccGwg1mpZpLZ0ZQsL9uG1F7/CYU1slMxma+Ec5Fpo4hHdZh8EUNnGoM9+t0rziCp0LndQHC5VMRLnhNYzrlliY53MI0lzXippWlkVtkwGQytvmBMVUUdSfI+vyCXHCOdHZ95i4zduMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716608507; c=relaxed/simple;
	bh=2TGCDEyhBPglEtC27Vub6VPtL/Rs/yRHv5FhWC5j5+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q5GHAZMqG3SOPrPesoGDhKNJSFbkcJjTkZKrUv3jjXIHEzMHoUbtBHtiKsJvd8Q3jmL43ILDq/bxw7WxtxO3gWhXFp8dVRVPXbBhwcQwjXwt1Uf/Crz40IetHYN8Z45uDCMbZPrye+BW5EOLYrobzQTkbwi5ALbgjZou9rANDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VmSKc3YdhzxQ1M;
	Sat, 25 May 2024 11:37:56 +0800 (CST)
Received: from canpemm500007.china.huawei.com (unknown [7.192.104.62])
	by mail.maildlp.com (Postfix) with ESMTPS id DEE6014022E;
	Sat, 25 May 2024 11:41:40 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 25 May
 2024 11:41:40 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <hannes@stressinduktion.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net] ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound
Date: Sat, 25 May 2024 11:42:31 +0800
Message-ID: <20240525034231.2498827-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Fixes: f60e5990d9c1 ("ipv6: protect skb->sk accesses from recursive dereference inside the stack")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
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


