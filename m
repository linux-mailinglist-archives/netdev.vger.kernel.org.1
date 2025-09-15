Return-Path: <netdev+bounces-223053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70979B57C3B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B11171176
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902DC3054C4;
	Mon, 15 Sep 2025 13:02:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA27302153;
	Mon, 15 Sep 2025 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941334; cv=none; b=l6N3WHTL8Kg5i0yH84+N2heXAZIsJeAubSJQd/+sPCrI3sfai8A/8k1OOqlerfeVyrunnaSTK21DEHTGOt8NB+RKdulrxXrtj3jy9a1E9ksbbf13DRvB3x3sj3f7eLbsjVrZOWHrkX3P1d2Qy/D/usJh0DB65N151iF3Xj5dcRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941334; c=relaxed/simple;
	bh=gGcVx0h19oVpdrzLf5vypiYgGjeeuj4oSq5m3ICnSzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TcVrMAI1OsQstFPG35yUcpaNs1DsRUF9hfrqqVd7L4ndRYqbw8oDxsU7/+H1TUdQrtk/4+ohiHDSDakEvRlaTo1VpNY5B/0mv9757hvBdpBSyxbIbU17tZzUeyI7vb+tUxRDk0Vb8h2iMs49Hoe0zr4aeWm7VwYxV5sPmwLfGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [106.117.96.180])
	by mtasvr (Coremail) with SMTP id _____wA38FY1DshouWw4Ag--.6642S3;
	Mon, 15 Sep 2025 21:01:43 +0800 (CST)
Received: from ubuntu.localdomain (unknown [106.117.96.180])
	by mail-app2 (Coremail) with SMTP id zC_KCgBnfkIyDshooan+AQ--.39635S2;
	Mon, 15 Sep 2025 21:01:41 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	bbhushan2@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	gakula@marvell.com,
	sgoutham@marvell.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net] octeontx2-pf: Fix use-after-free bugs in otx2_sync_tstamp()
Date: Mon, 15 Sep 2025 21:01:36 +0800
Message-Id: <20250915130136.42586-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBnfkIyDshooan+AQ--.39635S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwYKAWjHGnsMaABgsE
X-CM-DELIVERINFO: =?B?UTu7fQXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR13CxzN3cNJud0D/Kep4GKTmAQHqGBIdwgfOjnCakh/A1oqRkI3uY692KNQSXkfz8m2b2
	AUTErYJCXs72Q01+xI0LpIMoSBbMD/KDjpdGlz/ro06lpk2dE4CHEAB1Gpf1IQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxGw1xtF4fKFWrtFWfKr45Jwc_yoWrJrWUp3
	y5u345Aw15Jrn3JrsrJF409F1kJan5t34rWwn29rs3XFs3Gr1UXa45KF409F15GrWkAFZ3
	Aas8trZ3XFn5t3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU801v3UUUUU==

The original code uses cancel_delayed_work() in otx2_ptp_destroy(), which
does not guarantee that the delayed work item 'synctstamp_work' has fully
completed if it was already running. This leads to use-after-free scenarios
where otx2_ptp is deallocated by otx2_ptp_destroy(), while synctstamp_work
remains active and attempt to dereference otx2_ptp in otx2_sync_tstamp().

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

Fixes: 2958d17a8984 ("octeontx2-pf: Add support for ptp 1-step mode on CN10K silicon")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
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


