Return-Path: <netdev+bounces-223865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FE1B7DE35
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303632A7472
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 06:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AF9239085;
	Wed, 17 Sep 2025 06:39:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2435D137932;
	Wed, 17 Sep 2025 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091174; cv=none; b=sYbOtEsFc/WdcL95GwggX3lrIAHxk/ujnYx0P4AbikE9hP37stuaTBn2HmPfSZpNcspGcZNTcR+uavdZCrpPNsBvmtjpiRA5Yi0gGJihaVx9j4kL15jzydulotSZ8w7ydtV8iZ9piJ4KYldpEtJgRyKcn64sRRg2g5vUxGhGSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091174; c=relaxed/simple;
	bh=nwn3Ln4XsRKJAo3XtNQr2a3ITfICHvKXmczYHSVAtww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b8bwvZE8BMvPvLffqXgvQzC7HmRr04S0CZ6CJnKUUILoVJ8OFiAik1oGXmZkaMMXp6RYgo1clmzshDi9uRJULl3A2J1U1EUxrqJ4g2Yk6VX8C4EnK8uU4jkPEiy6WHbwpuUkv7ZscKDFCoRJmeLCUFRQX+K8jFYB0DTb9Zl94Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [106.117.98.100])
	by mtasvr (Coremail) with SMTP id _____wCnrwOIV8poo+lCAg--.13924S3;
	Wed, 17 Sep 2025 14:39:05 +0800 (CST)
Received: from ubuntu.localdomain (unknown [106.117.98.100])
	by mail-app4 (Coremail) with SMTP id zi_KCgDXbIKCV8poEuDoAQ--.46016S2;
	Wed, 17 Sep 2025 14:39:03 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	richardcochran@gmail.com,
	naveenm@marvell.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2 net] octeontx2-pf: Fix use-after-free bugs in otx2_sync_tstamp()
Date: Wed, 17 Sep 2025 14:38:53 +0800
Message-Id: <20250917063853.24295-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgDXbIKCV8poEuDoAQ--.46016S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQMAWjJvXsG9gAWsL
X-CM-DELIVERINFO: =?B?enZ52gXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR131FE3wBtlILXmPZxD8pDyC02ccIf/9fDDg6eoYLJDkfkwCYjU3+iOBFXlFG9IYNFiPp
	K+ldc1nqAuJEq/mrvVuurBTRxM8HF4AQVNStdriUEDQmUyGmK1ud4Y6B1ao51g==
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4DGF15ArW8Aw48Wr13Jrc_yoWrAr1Up3
	y5C345Awn8Ars3Jrs7JF40vF1kJan5t34UWrn2gr4fZws3Wr1UXa48KF4F93WUGrWkAFZ3
	Aas8JrZ3XFn5tabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7xwIDUUUU

The original code relies on cancel_delayed_work() in otx2_ptp_destroy(),
which does not ensure that the delayed work item synctstamp_work has fully
completed if it was already running. This leads to use-after-free scenarios
where otx2_ptp is deallocated by otx2_ptp_destroy(), while synctstamp_work
remains active and attempts to dereference otx2_ptp in otx2_sync_tstamp().
Furthermore, the synctstamp_work is cyclic, the likelihood of triggering
the bug is nonnegligible.

A typical race condition is illustrated below:

CPU 0 (cleanup)           | CPU 1 (delayed work callback)
otx2_remove()             |
  otx2_ptp_destroy()      | otx2_sync_tstamp()
    cancel_delayed_work() |
    kfree(ptp)            |
                          |   ptp = container_of(...); //UAF
                          |   ptp-> //UAF

This is confirmed by a KASAN report:

BUG: KASAN: slab-use-after-free in __run_timer_base.part.0+0x7d7/0x8c0
Write of size 8 at addr ffff88800aa09a18 by task bash/136
...
Call Trace:
 <IRQ>
 dump_stack_lvl+0x55/0x70
 print_report+0xcf/0x610
 ? __run_timer_base.part.0+0x7d7/0x8c0
 kasan_report+0xb8/0xf0
 ? __run_timer_base.part.0+0x7d7/0x8c0
 __run_timer_base.part.0+0x7d7/0x8c0
 ? __pfx___run_timer_base.part.0+0x10/0x10
 ? __pfx_read_tsc+0x10/0x10
 ? ktime_get+0x60/0x140
 ? lapic_next_event+0x11/0x20
 ? clockevents_program_event+0x1d4/0x2a0
 run_timer_softirq+0xd1/0x190
 handle_softirqs+0x16a/0x550
 irq_exit_rcu+0xaf/0xe0
 sysvec_apic_timer_interrupt+0x70/0x80
 </IRQ>
...
Allocated by task 1:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x7f/0x90
 otx2_ptp_init+0xb1/0x860
 otx2_probe+0x4eb/0xc30
 local_pci_probe+0xdc/0x190
 pci_device_probe+0x2fe/0x470
 really_probe+0x1ca/0x5c0
 __driver_probe_device+0x248/0x310
 driver_probe_device+0x44/0x120
 __driver_attach+0xd2/0x310
 bus_for_each_dev+0xed/0x170
 bus_add_driver+0x208/0x500
 driver_register+0x132/0x460
 do_one_initcall+0x89/0x300
 kernel_init_freeable+0x40d/0x720
 kernel_init+0x1a/0x150
 ret_from_fork+0x10c/0x1a0
 ret_from_fork_asm+0x1a/0x30

Freed by task 136:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3a/0x60
 __kasan_slab_free+0x3f/0x50
 kfree+0x137/0x370
 otx2_ptp_destroy+0x38/0x80
 otx2_remove+0x10d/0x4c0
 pci_device_remove+0xa6/0x1d0
 device_release_driver_internal+0xf8/0x210
 pci_stop_bus_device+0x105/0x150
 pci_stop_and_remove_bus_device_locked+0x15/0x30
 remove_store+0xcc/0xe0
 kernfs_fop_write_iter+0x2c3/0x440
 vfs_write+0x871/0xd70
 ksys_write+0xee/0x1c0
 do_syscall_64+0xac/0x280
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
...

Replace cancel_delayed_work() with cancel_delayed_work_sync() to ensure
that the delayed work item is properly canceled before the otx2_ptp is
deallocated.

This bug was initially identified through static analysis. To reproduce
and test it, I simulated the OcteonTX2 PCI device in QEMU and introduced
artificial delays within the otx2_sync_tstamp() function to increase the
likelihood of triggering the bug.

Fixes: 2958d17a8984 ("octeontx2-pf: Add support for ptp 1-step mode on CN10K silicon")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Describe how the issue was discovered and how the patch was tested.

 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
index e52cc6b1a26c..dedd586ed310 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
@@ -491,7 +491,7 @@ void otx2_ptp_destroy(struct otx2_nic *pfvf)
 	if (!ptp)
 		return;
 
-	cancel_delayed_work(&pfvf->ptp->synctstamp_work);
+	cancel_delayed_work_sync(&pfvf->ptp->synctstamp_work);
 
 	ptp_clock_unregister(ptp->ptp_clock);
 	kfree(ptp);
-- 
2.34.1


