Return-Path: <netdev+bounces-296355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wsyhDs8zJmqUTQIAu9opvQ
	(envelope-from <netdev+bounces-296355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 05:15:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6C0652680
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 05:15:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b="cv+Ph/FX";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296355-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296355-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A4933001D47
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 03:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64B1347FFE;
	Mon,  8 Jun 2026 03:15:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA2347500;
	Mon,  8 Jun 2026 03:15:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780888524; cv=none; b=M8SMB++00khXUPw4Fj/0kywkYLM3YASFhJZlU8n9NL8JVPT08jcQGbd36GkjgToeftRyiT4wDKbJM+68HeZLHm3lpxLDnSSIh30EqHhFoEl9Eg0aSeg10WeIWnX+dGlyUbZ/0CbHYMq4ppgiKAUHx6B3cDRdrVDbVFFociiGPmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780888524; c=relaxed/simple;
	bh=TjX6iBnQjVhvvsZ7mDP+mvTZ7ze4RuE2HmNN4ecrVG4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sGD8D0uNRCr34fVUgExRWde37vwwSB0FOWcnXwZ77Dae2ltsgf8/gN+lxLZVk35pX5sEVtC4OfoVUtdtSfMEfaCG3UQ3NtpbYdy1H4FWc/e5FJfD/TK6Fcebl7PDbNucB86isMVUxVcmi+A8nJFljvSycU3hYiUsJEmm4JpgWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cv+Ph/FX; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+AUqm8IASLg6wXd019rBFythi5pBjq/sjGvkDAtM9eE=;
	b=cv+Ph/FX4DXvKIQlO7B1p6f9WYzJs833yE5DYbwFtBS5CklcqQthaQcrpA7ThlcBm2rOViex6
	HTiaCoYGFJzFZWlhgrDuX8e/hY/EuXMdQd0jK9p6ftNFMGx7qqnj4UMIsfCdYIfHxp9lQzwnCs9
	vW0s4UJ+g0IzKArRhwshk3I=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gYcQR2WYmz1T4hb;
	Mon,  8 Jun 2026 11:06:55 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 29D3840537;
	Mon,  8 Jun 2026 11:15:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Jun
 2026 11:15:12 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <sashal@kernel.org>, <horms@kernel.org>,
	<ruanjinjie@huawei.com>, <jiayuan.chen@shopee.com>, <kartikey406@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6.6] net: atm: net: atm: Fix "init active" ODEBUG warning for delayed_work timer
Date: Mon, 8 Jun 2026 11:14:58 +0800
Message-ID: <20260608031458.2895690-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-296355-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sashal@kernel.org,m:horms@kernel.org,m:ruanjinjie@huawei.com,m:jiayuan.chen@shopee.com,m:kartikey406@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,huawei.com,shopee.com,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[ruanjinjie@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruanjinjie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huawei.com:mid,huawei.com:dkim,huawei.com:from_mime,huawei.com:email,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C6C0652680

In linux mainline, the net atm related code has been removed, but
the stable code has the following bug.

In lecd_attach(), when an interface is reused via the 'else' path,
the driver unconditionally invokes lec_arp_init(priv) to re-initialize
the ARP subsystem tracking states.

Inside lec_arp_init(), INIT_DELAYED_WORK() is invoked to set up
priv->lec_arp_work, which internally triggers timer_setup() to initialize
the embedded 'struct timer_list' within the delayed_work container.
However, if the interface is being reused and its delayed work
remains pending or active from a previous session, re-initializing
the running timer embedded in the work item corrupts the debug objects
tracking logic, generating a fatal "ODEBUG: init active" warning.

Fix this by shifting the lec_arp_init(priv) call exclusively into the 'if'
block where the net_device is initially allocated via alloc_etherdev(),
ensuring that the embedded timer and delayed work lifecycle are established
only once per device instance.

	1. With DEBUG_OBJECTS_TIMERS config off:

	lec:lec_atm_close: lec0: Shut down!
	==================================================================
	BUG: KASAN: wild-memory-access in __run_timers.part.0+0x410/0x618
	Write of size 8 at addr dead00000000012a by task test_1/428

	CPU: 1 PID: 428 Comm: test_1 Not tainted 6.6.142 #2
	Hardware name: linux,dummy-virt (DT)
	Call trace:
	 dump_backtrace+0x9c/0x128
	 show_stack+0x20/0x38
	 dump_stack_lvl+0x78/0xc8
	 print_report+0x244/0x278
	 kasan_report+0x84/0xd0
	 __asan_store8+0x68/0xc0
	 __run_timers.part.0+0x410/0x618
	 run_timer_softirq+0x64/0xc0
	 handle_softirqs+0x198/0x518
	 __do_softirq+0x1c/0x28
	 ____do_softirq+0x18/0x30
	 call_on_irq_stack+0x30/0x48
	 do_softirq_own_stack+0x24/0x38
	 __irq_exit_rcu+0x188/0x198
	 irq_exit_rcu+0x18/0x30
	 el1_interrupt+0x4c/0xb0
	 el1h_64_irq_handler+0x18/0x28
	 el1h_64_irq+0x78/0x80
	 percpu_counter_add_batch+0x190/0x220
	 set_pte_range+0x128/0x348
	 finish_fault+0x330/0x408
	 do_read_fault+0x1b8/0x2d0
	 do_pte_missing+0x210/0x2e0
	 handle_pte_fault+0x13c/0x380
	 __handle_mm_fault+0x2cc/0x4a0
	 handle_mm_fault+0x148/0x3b8
	 faultin_page+0x90/0x168
	 __get_user_pages+0x154/0x3c0
	 populate_vma_page_range+0xf0/0x150
	 __mm_populate+0x12c/0x268
	 vm_mmap_pgoff+0x1c8/0x238
	 ksys_mmap_pgoff+0x54/0x278
	 __arm64_sys_mmap+0x8c/0xb8
	 invoke_syscall+0x64/0x178
	 el0_svc_common.constprop.0+0x80/0x150
	 do_el0_svc+0x3c/0x58
	 el0_svc+0x34/0xe8
	 el0t_64_sync_handler+0x13c/0x158
	 el0t_64_sync+0x188/0x190
	==================================================================
	Disabling lock debugging due to kernel taint
	Unable to handle kernel paging request at virtual address dead00000000012a
	Mem abort info:
	  ESR = 0x0000000096000044
	  EC = 0x25: DABT (current EL), IL = 32 bits
	  SET = 0, FnV = 0
	  EA = 0, S1PTW = 0
	  FSC = 0x04: level 0 translation fault
	Data abort info:
	  ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
	  CM = 0, WnR = 1, TnD = 0, TagAccess = 0
	  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
	[dead00000000012a] address between user and kernel address ranges
	Internal error: Oops: 0000000096000044 [#1] SMP

	2. With DEBUG_OBJECTS_TIMERS config on:

	ODEBUG: init active (active state 0) object: 00000000348135aa object type: timer_list hint: lec_arp_check_expire+0x0/0x360 [lec]
	WARNING: CPU: 1 PID: 413 at lib/debugobjects.c:515 debug_print_object+0xf4/0x130
	Modules linked in: lec atm cfg80211 rfkill 8021q garp stp mrp llc
	CPU: 1 PID: 413 Comm: test Tainted: G        W          6.6.142 #1
	Hardware name: linux,dummy-virt (DT)
	pstate: 60002005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	pc : debug_print_object+0xf4/0x130
	lr : debug_print_object+0xf4/0x130
	sp : ffff800081fe7780
	pmr_save: 000000e0
	x29: ffff800081fe7780 x28: ffff800081fe7860 x27: ffffae4adfb0c9c0
	x26: ffff800081fe7888 x25: ffffae4ad3c24938 x24: ffffae4adf909ca0
	x23: 0000000000000000 x22: ffffae4adfb0c580 x21: ffffae4adfb0be20
	x20: ffff0e66c9062a98 x19: ffffae4ae0eb7988 x18: 000000001251fe40
	x17: 626f206161353331 x16: 3834333030303030 x15: 303030203a746365
	x14: 6a626f2029302065 x13: 0000000000000001 x12: ffff61cd1267112b
	x11: 1fffe1cd1267112a x10: ffff61cd1267112a x9 : dfff800000000000
	x8 : 00009e32ed98eed6 x7 : ffff0e6893388953 x6 : 0000000000000001
	x5 : ffff0e6893388950 x4 : ffff0e6893388950 x3 : 0000000000000000
	x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0e66d17f6040
	Call trace:
	 debug_print_object+0xf4/0x130
	 __debug_object_init+0x1f0/0x348
	 debug_object_init+0x24/0x30
	 init_timer_key+0x3c/0x170
	 lecd_attach+0x130/0x448 [lec]
	 lane_ioctl+0x104/0x158 [lec]
	 do_vcc_ioctl+0x140/0x7f8 [atm]
	 vcc_ioctl+0x1c/0x30 [atm]
	 svc_ioctl+0x17c/0x2c0 [atm]
	 sock_do_ioctl+0xc0/0x188
	 sock_ioctl+0x1cc/0x478
	 __arm64_sys_ioctl+0xd8/0x128
	 invoke_syscall+0x64/0x178
	 el0_svc_common.constprop.0+0x80/0x150
	 do_el0_svc+0x3c/0x58
	 el0_svc+0x34/0xe8
	 el0t_64_sync_handler+0x13c/0x158
	 el0t_64_sync+0x188/0x190

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org#4.19.x
Cc: gregkh@linuxfoundation.org
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 net/atm/lec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index d8ab96962579..7f5a531b964c 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -773,12 +773,12 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
 		}
 
 		priv = netdev_priv(dev_lec[i]);
+		lec_arp_init(priv);
 	} else {
 		priv = netdev_priv(dev_lec[i]);
 		if (rcu_access_pointer(priv->lecd))
 			return -EADDRINUSE;
 	}
-	lec_arp_init(priv);
 	priv->itfnum = i;	/* LANE2 addition */
 	rcu_assign_pointer(priv->lecd, vcc);
 	vcc->dev = &lecatm_dev;
-- 
2.34.1


