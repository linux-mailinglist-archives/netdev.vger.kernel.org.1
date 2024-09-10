Return-Path: <netdev+bounces-127024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE8F973AB7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EA21C20EB7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8D9198851;
	Tue, 10 Sep 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="smLECJZQ"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17E196C86;
	Tue, 10 Sep 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980218; cv=none; b=PrIULx6CxHpeHCW9B+jlrtwJzBz2/LoyCwI7M3l99lkvVEdGG1SgGGtGDrtolbrtyUGVcByocTvWz1z5UyGonyNHGnvSzNJrpQwNNQyX6M4TdYesrgS+wu/OPOiHALVdDhbo4cokTN/CoCNVJvHhL1Nr9ShGJhofYqe8nG4vUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980218; c=relaxed/simple;
	bh=bd9B/iiCBDYvrIKqhelsWDM+scicB0QNH3hNjDy4MyM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=sUff7gYIYuN/BGH+04w6imEPZWeinzd/BjhTPirCWbiKUnc1XSJz/DxFEXRfRFEmFtEMZAmrfDOFtuU52c0gBGAu39pQ1//ievcF2eSD3tdzgzbPekDee2l/171EBHr0ABg7ybPXtPsel1r/OjADojDr/qVq3iBwqLyTaRSQHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=smLECJZQ; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725980211; bh=DkR2scrRl85rOk3J1IqiLzPP9fGrojFncSkHxO3DImU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=smLECJZQ39FUdTqPFGbR9Fdr9A8kGvWcnVJm+eUB4C08muoyBjoVzQnRe9t0azBLS
	 UVt4LFTlSJSgHsvQXJBMq9b9IupL8BIED714sczsduQ4ucO5e+4/+tNiHLdPtbfHnF
	 aOMpN15tcbtx+RG3K+htFnGRMMALUQVlPLlQwWws=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id CA824AC7; Tue, 10 Sep 2024 22:50:40 +0800
X-QQ-mid: xmsmtpt1725979840tw3h2u1gb
Message-ID: <tencent_CF67CC46D7D2DBC677898AEEFBAECD0CAB06@qq.com>
X-QQ-XMAILINFO: MRw/zKT/0BpPvSVxJsMNcxbWyRsb1t7Qu9/32f1GytIOWQx6MlITciGAaY3O/I
	 /wgRy53NuugE6RzCKSxHPrRDOERfnsfDmMPLlm7ao20zGuqISpJV/4ZcC1XWFWeiQ+KnKK0xSuzR
	 Ncc7Yw5GL6nui+Eoj83dNDBFI9zA2PGlWjhWoUG72P+uVtuZVq0uHT/4wn4tVQ4FbCLetByj492d
	 KaR1UY3ha08pAJ+Dr8HB7KadWHST9rSCQEHi8BQYAKCatJ69JUM0oc646OX4GPKELniWMj0CDphM
	 D3WBEp9NgYE+xrVzQEW8h1B3DGkCOfC/0p8IWAhnaejn5YrN61b9Tu+0/8ocSv0JlK+8S23yTYPY
	 8/oZB6zlUcg2lO36apnwjl7gYkhhNiTeLO+m0JIFIzDnSxwGdWmssYlEd+pyIjJzhmT49+jCZAXU
	 Hb4YC9cPKfRan4DQWGTX0jeRucf9PvRJzKTsgxUlyULq14S+cvQpEf8nfFNGfpxr8jOs929nTfXt
	 DDeuEpPv8fMhT4ACJXPlBYlOJEC2lskK8cO8bgnhrzq0gBWaXLv/XR1MHhJ0aZaA0kvoqTTiCwjm
	 nZbdprhcfYpAKBuW/O8k4Ahml//wjPimLR4WpdkKYy0yKNdN7i1SrNAORNM64r7lmsstRMoNFwUS
	 GnEYIK1IglSQikvR2+kllrszhFkOKOCQj/+nFcH+AN/AT7wyhhVp62pu1OItZMBCY+o538p9f94h
	 F851+6d2HyhOrcCg3KKIHnNumv3twdm1t9kkcsUGhhAQRAhOvdAHfKbkTQmjeKGCARJXjiUaXJhx
	 KPlEJMA6FAJazWPD3BOJBeyDdXNjxHMCpfvckxdJuTUjRjqfw3Po4zGHkKJVH5FWgOkM3RLLJq27
	 RkIXjLtdiR75Ynli62bp9vbkBy2n2XuKlBtU8+39dgtf+22uGLvjoA2At7E0HJHsWrhP5/DO+Qam
	 cgj2V7zyM=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c229849f5b6c82eba3c2@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH net] net: hsr: Fix null-ptr-deref in hsr_proxy_announce
Date: Tue, 10 Sep 2024 22:50:40 +0800
X-OQ-MSGID: <20240910145039.2878172-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <0000000000000d402f0621c44c87@google.com>
References: <0000000000000d402f0621c44c87@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NULL pointer is interlink, return by hsr_port_get_hsr(), before using it,
it is necessary to add a null pointer check.

[Syzbot reported]
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.11.0-rc6-syzkaller-00180-g4c8002277167 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: netns cleanup_net
RIP: 0010:send_hsr_supervision_frame+0x37/0xa90 net/hsr/hsr_device.c:290
Code: 53 48 83 ec 38 48 89 54 24 30 49 89 f7 49 89 fd 48 bb 00 00 00 00 00 fc ff df e8 54 a0 f9 f5 49 8d 6d 18 48 89 e8 48 c1 e8 03 <80> 3c 18 00 74 08 48 89 ef e8 7b e6 60 f6 48 8b 6d 00 4d 89 fc 49
RSP: 0018:ffffc90000007a70 EFLAGS: 00010206
RAX: 0000000000000003 RBX: dffffc0000000000 RCX: ffff88801ced3c00
RDX: 0000000000000100 RSI: ffffc90000007b40 RDI: 0000000000000000
RBP: 0000000000000018 R08: ffffffff8b995013 R09: 1ffffffff283c908
R10: dffffc0000000000 R11: ffffffff8b99ec30 R12: ffff888065030e98
R13: 0000000000000000 R14: ffff888065030cf0 R15: ffffc90000007b40
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f76c4f21cf8 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 hsr_proxy_announce+0x23a/0x4c0 net/hsr/hsr_device.c:420
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 
Fixes: 5f703ce5c98 ("net: hsr: Send supervisory frames to HSR network with ProxyNodeTable data")
Reported-by: syzbot+c229849f5b6c82eba3c2@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/hsr/hsr_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index ac56784c327..c4a06ee6fb9 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -414,6 +414,9 @@ static void hsr_proxy_announce(struct timer_list *t)
 	 * of SAN nodes stored in ProxyNodeTable.
 	 */
 	interlink = hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
+	if (!interlink)
+		goto out;
+
 	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
 		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
 			continue;
@@ -428,6 +431,7 @@ static void hsr_proxy_announce(struct timer_list *t)
 		mod_timer(&hsr->announce_proxy_timer, jiffies + interval);
 	}
 
+out:	
 	rcu_read_unlock();
 }
 
-- 
2.43.0


