Return-Path: <netdev+bounces-259445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFMNEVsGl2kWtwIAu9opvQ
	(envelope-from <netdev+bounces-259445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 13:47:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4834B15EAC3
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 13:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 517EF3015899
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26FF30BB80;
	Thu, 19 Feb 2026 12:47:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7229232549E;
	Thu, 19 Feb 2026 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505236; cv=none; b=KYu/UAHPUz4cxykeUQyUdxOTMqAZ3N0LPx2Hse4em7+gSAI51VnmxRY+iFiqRRe7plN6tl0JW+3ec7MbE/Tvn7sKHLfqkDbTyrCg6SFqCRauOKMmm594eLDuW1zE4a8BEoP66lp/zHMdQE3a5ivIJSyfT/Cq3cqNuay76DBWANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505236; c=relaxed/simple;
	bh=mQfYg9NSAHTeK900iLMcrRSQ5v+Qpu2cCZ21kYqMhic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TShJ7g0OSE8KS2PvoY+6TARZVSVHiDDbdrpEKUFdeahDfHzEqcJYxt6R88xyCQxAxB894xhkBWj3ee3ypMK+aKPuHrFifOd8fboOLDu0Qz9+hZxhbr8+ZL7IwoVyD+7a/gxUVViSX16XHlwIr6ExCRmBLqxR6dMRQ2LGY6iABOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.18.79])
	by mtasvr (Coremail) with SMTP id _____wDn7VEzBpdpJNXCAA--.25819S3;
	Thu, 19 Feb 2026 20:46:44 +0800 (CST)
Received: from ubuntu.localdomain (unknown [218.12.18.79])
	by mail-app3 (Coremail) with SMTP id zS_KCgBHSWwuBpdpQ8dKBg--.41083S2;
	Thu, 19 Feb 2026 20:46:42 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kevin.curtis@farsite.co.uk,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net] net: wan: farsync: Fix use-after-free bugs caused by unfinished tasklets
Date: Thu, 19 Feb 2026 20:46:37 +0800
Message-Id: <20260219124637.72578-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBHSWwuBpdpQ8dKBg--.41083S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwYHAWmWFggBKgA8s1
X-CM-DELIVERINFO: =?B?zaqsKgXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR1zEltBcmylrpStgRg1rf41SCVEefaMrEZEZGt+jAKGCSGVKomGclygUyIahAa5OYjXgz
	JJLQ1wXn7s6o5WA1cuJbe7CMdXN57FLLllTvMWPIi25tfpAfBJsFVs3Fx8myig==
X-Coremail-Antispam: 1Uk129KBj93XoWxKryruryUWw17Ww1kZFyDtwc_yoW7Cw17pa
	nxArWxCrW8Jryjqr47Jr48Gr18JFWDAa4UKrW8Cr12v3Wrur15tr1UJF45Zr1UKrWrAFy7
	J3ZxJrWUKr1UJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
	vjxU7xwIDUUUU
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259445-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[zju.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[duoming@zju.edu.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zju.edu.cn:mid,zju.edu.cn:email]
X-Rspamd-Queue-Id: 4834B15EAC3
X-Rspamd-Action: no action

When the FarSync T-series card is being detached, the fst_card_info is
deallocated in fst_remove_one(). However, the fst_tx_task or fst_int_task
may still be running or pending, leading to use-after-free bugs when the
already freed fst_card_info is accessed in fst_process_tx_work_q() or
fst_process_int_work_q().

A typical race condition is depicted below:

CPU 0 (cleanup)           | CPU 1 (tasklet)
                          | fst_start_xmit()
fst_remove_one()          |   tasklet_schedule()
  unregister_hdlc_device()|
                          | fst_process_tx_work_q() //handler
  kfree(card) //free      |   do_bottom_half_tx()
                          |     card-> //use

The following KASAN trace was captured:

==================================================================
 BUG: KASAN: slab-use-after-free in do_bottom_half_tx+0xb88/0xd00
 Read of size 4 at addr ffff88800aad101c by task ksoftirqd/3/32
 ...
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x55/0x70
  print_report+0xcb/0x5d0
  ? do_bottom_half_tx+0xb88/0xd00
  kasan_report+0xb8/0xf0
  ? do_bottom_half_tx+0xb88/0xd00
  do_bottom_half_tx+0xb88/0xd00
  ? _raw_spin_lock_irqsave+0x85/0xe0
  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  ? __pfx___hrtimer_run_queues+0x10/0x10
  fst_process_tx_work_q+0x67/0x90
  tasklet_action_common+0x1fa/0x720
  ? hrtimer_interrupt+0x31f/0x780
  handle_softirqs+0x176/0x530
  __irq_exit_rcu+0xab/0xe0
  sysvec_apic_timer_interrupt+0x70/0x80
 ...

 Allocated by task 41 on cpu 3 at 72.330843s:
  kasan_save_stack+0x24/0x50
  kasan_save_track+0x17/0x60
  __kasan_kmalloc+0x7f/0x90
  fst_add_one+0x1a5/0x1cd0
  local_pci_probe+0xdd/0x190
  pci_device_probe+0x341/0x480
  really_probe+0x1c6/0x6a0
  __driver_probe_device+0x248/0x310
  driver_probe_device+0x48/0x210
  __device_attach_driver+0x160/0x320
  bus_for_each_drv+0x101/0x190
  __device_attach+0x198/0x3a0
  device_initial_probe+0x78/0xa0
  pci_bus_add_device+0x81/0xc0
  pci_bus_add_devices+0x7e/0x190
  enable_slot+0x9b9/0x1130
  acpiphp_check_bridge.part.0+0x2e1/0x460
  acpiphp_hotplug_notify+0x36c/0x3c0
  acpi_device_hotplug+0x203/0xb10
  acpi_hotplug_work_fn+0x59/0x80
 ...

 Freed by task 41 on cpu 1 at 75.138639s:
  kasan_save_stack+0x24/0x50
  kasan_save_track+0x17/0x60
  kasan_save_free_info+0x3b/0x60
  __kasan_slab_free+0x43/0x70
  kfree+0x135/0x410
  fst_remove_one+0x2ca/0x540
  pci_device_remove+0xa6/0x1d0
  device_release_driver_internal+0x364/0x530
  pci_stop_bus_device+0x105/0x150
  pci_stop_and_remove_bus_device+0xd/0x20
  disable_slot+0x116/0x260
  acpiphp_disable_and_eject_slot+0x4b/0x190
  acpiphp_hotplug_notify+0x230/0x3c0
  acpi_device_hotplug+0x203/0xb10
  acpi_hotplug_work_fn+0x59/0x80
 ...

 The buggy address belongs to the object at ffff88800aad1000
  which belongs to the cache kmalloc-1k of size 1024
 The buggy address is located 28 bytes inside of
  freed 1024-byte region
 The buggy address belongs to the physical page:
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xaad0
 head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 flags: 0x100000000000040(head|node=0|zone=1)
 page_type: f5(slab)
 raw: 0100000000000040 ffff888007042dc0 dead000000000122 0000000000000000
 raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
 head: 0100000000000040 ffff888007042dc0 dead000000000122 0000000000000000
 head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
 head: 0100000000000003 ffffea00002ab401 00000000ffffffff 00000000ffffffff
 head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff88800aad0f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88800aad0f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >ffff88800aad1000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff88800aad1080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88800aad1100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================

Fix this by ensuring that both fst_tx_task and fst_int_task are properly
canceled before the fst_card_info is released. Add tasklet_kill() in
fst_remove_one() to synchronize with any pending or running tasklets.
Since unregister_hdlc_device() stops data transmission and reception,
and fst_disable_intr() prevents further interrupts, it is appropriate
to place tasklet_kill() after these calls.

The bugs were identified through static analysis. To reproduce the issue
and validate the fix, a FarSync T-series card was simulated in QEMU and
delays(e.g., mdelay()) were introduced within the tasklet handler to
increase the likelihood of triggering the race condition.

Fixes: 2f623aaf9f31 ("net: farsync: Fix kmemleak when rmmods farsync")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/net/wan/farsync.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
index 5b01642ca44..6b2d1e63855 100644
--- a/drivers/net/wan/farsync.c
+++ b/drivers/net/wan/farsync.c
@@ -2550,6 +2550,8 @@ fst_remove_one(struct pci_dev *pdev)
 
 	fst_disable_intr(card);
 	free_irq(card->irq, card);
+	tasklet_kill(&fst_tx_task);
+	tasklet_kill(&fst_int_task);
 
 	iounmap(card->ctlmem);
 	iounmap(card->mem);
-- 
2.34.1


