Return-Path: <netdev+bounces-222829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D057FB5649D
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 05:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2F6189EF0E
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB458263F2D;
	Sun, 14 Sep 2025 03:44:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B972E413;
	Sun, 14 Sep 2025 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821451; cv=none; b=gW+6Y2aZP0yJs5LKDVCE4HAbpj5nvVzQYB1yCN6gXV6tx2xjSCqHFNLwyhtuxFiDD71/kge2MEapBcPotcQ6cAtI8R30YWnBqs3KGA0rE4s/NPSfiM9PxFFrOdYhvQltNvjXGS1lbI2u9V/sfqwTyz6msuuLiBrrI5y0lLyjg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821451; c=relaxed/simple;
	bh=c4+ZWB5wo1T3JP8VPm8oxCv+mOQqbv2EVOVSe01VDbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iUzKTs5Dk9OTo0NAueSwqmvMjG9O9w9vi/oxkz/Iecw+Zy2WpBXNLWRy2XCGeZJlGQH8qivwu9fEYw87bkQmUy/35qPEuqH35N80OQrLmLYdpXDX/8gor83hjR9EOQJ/CW4R3m6LSVPgma/dQKN1Kjb6LBv9savxfh3M9H+a8PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [106.117.96.180])
	by mtasvr (Coremail) with SMTP id _____wB3m7HtOcZoJCAwAg--.28452S3;
	Sun, 14 Sep 2025 11:43:42 +0800 (CST)
Received: from ubuntu.localdomain (unknown [106.117.96.180])
	by mail-app4 (Coremail) with SMTP id zi_KCgD3r4bqOcZouqXXAQ--.56038S2;
	Sun, 14 Sep 2025 11:43:41 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net] cnic: Fix use-after-free bugs in cnic_delete_task
Date: Sun, 14 Sep 2025 11:43:35 +0800
Message-Id: <20250914034335.35643-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgD3r4bqOcZouqXXAQ--.56038S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwYJAWjFyPoAhgADsX
X-CM-DELIVERINFO: =?B?vhlcyAXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR18YzsuFr6HJjVxf819+5wBRYB0GaNAlHtbW70tpbgArtekBruaqc8NZ9qG3bc+ts8aPF
	YynTZvYB1NJfsRtcxGk/yIOoBBDSoGBVijs/+hX3GKV9Rlm2W/alZAhtV75ZJQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxGw1xuw43CF43Jr4kWryrKrX_yoWrJw17p3
	y5W3yUArWUJr1Yqan7XF48XFn8Ca9Yy3srGrs7trZxZryYqry5JF1xKFWF9FWUCrWrAFyx
	Aw1jya9xZF9YkabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

The original code uses cancel_delayed_work() in cnic_cm_stop_bnx2x_hw(),
which does not guarantee that the delayed work item 'delete_task' has
fully completed if it was already running. Additionally, the delayed work
item is cyclic, flush_workqueue() in cnic_cm_stop_bnx2x_hw() could not
prevent the new incoming ones. This leads to use-after-free scenarios
where the cnic_dev is deallocated by cnic_free_dev(), while delete_task
remains active and attempt to dereference cnic_dev in cnic_delete_task().

A typical race condition is illustrated below:

CPU 0 (cleanup)            | CPU 1 (delayed work callback)
cnic_stop_hw()             | cnic_delete_task()
  cnic_cm_stop_bnx2x_hw()  |
    cancel_delayed_work()  |   queue_delayed_work()
    flush_workqueue()      |
                           | cnic_delete_task() //new instance
cnic_free_dev(dev)//free   |
                           |   dev = cp->dev; //use

This is confirmed by a KASAN report:

BUG: KASAN: slab-use-after-free in __run_timer_base.part.0+0x7d7/0x8c0
Write of size 8 at addr ffff88800c0a55f0 by task kworker/u16:2/63
...
Call Trace:
 <IRQ>
 dump_stack_lvl+0x55/0x70
 print_report+0xcf/0x610
 ? __run_timer_base.part.0+0x7d7/0x8c0
 kasan_report+0xb8/0xf0
 ? __run_timer_base.part.0+0x7d7/0x8c0
 __run_timer_base.part.0+0x7d7/0x8c0
 ? rcu_sched_clock_irq+0xa57/0x27d0
 ? __pfx___run_timer_base.part.0+0x10/0x10
 ? __update_load_avg_cfs_rq+0x5f0/0xa50
 ? _raw_spin_lock_irq+0x80/0xe0
 ? __pfx__raw_spin_lock_irq+0x10/0x10
 ? tmigr_next_groupevt+0x99/0x140
 tmigr_handle_remote_up+0x603/0x7e0
 ? __pfx_tmigr_handle_remote_up+0x10/0x10
 ? sched_balance_trigger+0x199/0x9f0
 ? sched_tick+0x221/0x5a0
 ? _raw_spin_lock_irq+0x80/0xe0
 ? timerqueue_add+0x21b/0x320
 ? tick_nohz_handler+0x199/0x440
 ? __pfx_tmigr_handle_remote_up+0x10/0x10
 __walk_groups.isra.0+0x42/0x150
 tmigr_handle_remote+0x1f4/0x2e0
 ? __pfx_tmigr_handle_remote+0x10/0x10
 ? ktime_get+0x60/0x140
 ? lapic_next_event+0x11/0x20
 ? clockevents_program_event+0x1d4/0x2a0
 ? hrtimer_interrupt+0x322/0x780
 handle_softirqs+0x16a/0x550
 irq_exit_rcu+0xaf/0xe0
 sysvec_apic_timer_interrupt+0x70/0x80
 </IRQ>
...
Allocated by task 141:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x7f/0x90
 cnic_alloc_dev.isra.0+0x40/0x310
 is_cnic_dev+0x795/0x11e0
 cnic_netdev_event+0xde/0xd30
 notifier_call_chain+0xc0/0x280
 register_netdevice+0xfb5/0x16c0
 register_netdev+0x1b/0x40
...
Freed by task 63:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3a/0x60
 __kasan_slab_free+0x3f/0x50
 kfree+0x137/0x370
 cnic_netdev_event+0x972/0xd30
...

Replace cancel_delayed_work() with cancel_delayed_work_sync() to ensure
that the delayed work item is properly canceled and any executing delayed
work has finished before the cnic_dev is deallocated.

Fixes: fdf24086f475 ("cnic: Defer iscsi connection cleanup")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/net/ethernet/broadcom/cnic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index a9040c42d2ff..73dd7c25d89e 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -4230,7 +4230,7 @@ static void cnic_cm_stop_bnx2x_hw(struct cnic_dev *dev)
 
 	cnic_bnx2x_delete_wait(dev, 0);
 
-	cancel_delayed_work(&cp->delete_task);
+	cancel_delayed_work_sync(&cp->delete_task);
 	flush_workqueue(cnic_wq);
 
 	if (atomic_read(&cp->iscsi_conn) != 0)
-- 
2.34.1


