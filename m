Return-Path: <netdev+bounces-226904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED80BBA60BE
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 16:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA67B7B3B03
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324F42E2EF9;
	Sat, 27 Sep 2025 14:45:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7883B1C8611;
	Sat, 27 Sep 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984354; cv=none; b=WbESKVh6uF0VPVboN891Y7jNqpASIzzmwO2oQ+1sHDu99pw7WaHFAEs0iTnrSnCn0J9aaoDv/uKkXUAeZZ1AmIQ+uVYj3nUnCZwoWHejEma9EcXKwRpFcbiq8ZkxGs276qEt4ukqZ9Whfn5sX6qszcMkzLeO7KOZxW5sbSdqUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984354; c=relaxed/simple;
	bh=AvSClpa4tRjfF43O5MFwzOpgYoxVcRx+jbVuWaKQcQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oMq8WJKUB5eaqBGSUqCMyOEDFluubUyZrGQauy+BiuZMa00dxbf9psOP9XKybO1bqlLZTcQJ6rZUF9l4LaH5SGepVBJr3Fg72LzlhZ87fL8e3K0gnSvzApoo1q2cpuSYwu4epkdd+S9hD90zvdC2/of0BRtSNB/g2azHM5F5BAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [106.117.80.134])
	by mtasvr (Coremail) with SMTP id _____wC3XtSB+NdoleJ8Ag--.13291S3;
	Sat, 27 Sep 2025 22:45:22 +0800 (CST)
Received: from ubuntu.localdomain (unknown [106.117.80.134])
	by mail-app3 (Coremail) with SMTP id zS_KCgBnZ2p8+NdoaxTsAg--.18898S2;
	Sat, 27 Sep 2025 22:45:20 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	UNGLinuxDriver@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net] net: mscc: ocelot: Fix use-after-free caused by cyclic delayed work
Date: Sat, 27 Sep 2025 22:45:14 +0800
Message-Id: <20250927144514.8847-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBnZ2p8+NdoaxTsAg--.18898S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMCAWjW7HwBugBYsO
X-CM-DELIVERINFO: =?B?OWmg+wXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR1/dpcS36kBujFFbf/g16HVhdRHTl3utrt7ReXwf4HBF1FQ+/QHQ3Q6S8zxprYJ0JLKc3
	yuu2dtIitZo7RMBbty97uAkSEVnqxsNk+cUquD/spDqClwEYYyMfzpoP9dJxZw==
X-Coremail-Antispam: 1Uk129KBj93XoWxCw1kuFy5GF4rJw48JF4xGrX_yoW7Jry3p3
	y5K3y7Cw48Xr4UJFs0vr40qw15KFnYkFsrJr4xZrWUC3WrJr15XF18tFWY9FZ8GrZ8ZFyS
	va1DZ392yas0yabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

The origin code calls cancel_delayed_work() in ocelot_stats_deinit()
to cancel the cyclic delayed work item ocelot->stats_work. However,
cancel_delayed_work() may fail to cancel the work item if it is already
executing. While destroy_workqueue() does wait for all pending work items
in the work queue to complete before destroying the work queue, it cannot
prevent the delayed work item from being rescheduled within the
ocelot_check_stats_work() function. This limitation exists because the
delayed work item is only enqueued into the work queue after its timer
expires. Before the timer expiration, destroy_workqueue() has no visibility
of this pending work item. Once the work queue appears empty,
destroy_workqueue() proceeds with destruction. When the timer eventually
expires, the delayed work item gets queued again, leading to the following
warning:

workqueue: cannot queue ocelot_check_stats_work on wq ocelot-switch-stats
WARNING: CPU: 2 PID: 0 at kernel/workqueue.c:2255 __queue_work+0x875/0xaf0
...
RIP: 0010:__queue_work+0x875/0xaf0
...
RSP: 0018:ffff88806d108b10 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000101 RCX: 0000000000000027
RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff88806d123e88
RBP: ffffffff813c3170 R08: 0000000000000000 R09: ffffed100da247d2
R10: ffffed100da247d1 R11: ffff88806d123e8b R12: ffff88800c00f000
R13: ffff88800d7285c0 R14: ffff88806d0a5580 R15: ffff88800d7285a0
FS:  0000000000000000(0000) GS:ffff8880e5725000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe18e45ea10 CR3: 0000000005e6c000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 ? kasan_report+0xc6/0xf0
 ? __pfx_delayed_work_timer_fn+0x10/0x10
 ? __pfx_delayed_work_timer_fn+0x10/0x10
 call_timer_fn+0x25/0x1c0
 __run_timer_base.part.0+0x3be/0x8c0
 ? __pfx_delayed_work_timer_fn+0x10/0x10
 ? rcu_sched_clock_irq+0xb06/0x27d0
 ? __pfx___run_timer_base.part.0+0x10/0x10
 ? try_to_wake_up+0xb15/0x1960
 ? _raw_spin_lock_irq+0x80/0xe0
 ? __pfx__raw_spin_lock_irq+0x10/0x10
 tmigr_handle_remote_up+0x603/0x7e0
 ? __pfx_tmigr_handle_remote_up+0x10/0x10
 ? sched_balance_trigger+0x1c0/0x9f0
 ? sched_tick+0x221/0x5a0
 ? _raw_spin_lock_irq+0x80/0xe0
 ? __pfx__raw_spin_lock_irq+0x10/0x10
 ? tick_nohz_handler+0x339/0x440
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

The following diagram reveals the cause of the above warning:

CPU 0 (remove)             | CPU 1 (delayed work callback)
mscc_ocelot_remove()       |
  ocelot_deinit()          | ocelot_check_stats_work()
    ocelot_stats_deinit()  |
      cancel_delayed_work()|   ...
                           |   queue_delayed_work()
      destroy_workqueue()  | (wait a time)
                           | __queue_work() //UAF

The above scenario actually constitutes a UAF vulnerability.

Replace cancel_delayed_work() with cancel_delayed_work_sync() to
ensure that the delayed work item is properly canceled and any
executing delayed work item completes before the workqueue is
deallocated.

A deadlock concern was considered: ocelot_stats_deinit() is called
in a process context and is not holding any locks that the delayed
work item might also need. Therefore, the use of the _sync() variant
is safe here.

This bug was identified through static analysis. To reproduce the
issue and validate the fix, I simulated ocelot-switch device by
writing a kernel module and prepared the necessary resources for
the virtual ocelot-switch device's probe process. Then, removing
the virtual device will trigger the mscc_ocelot_remove() function,
which in turn destroys the workqueue.

Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/net/ethernet/mscc/ocelot_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_stats.c b/drivers/net/ethernet/mscc/ocelot_stats.c
index 545710dadcf5..d8ab789f6bea 100644
--- a/drivers/net/ethernet/mscc/ocelot_stats.c
+++ b/drivers/net/ethernet/mscc/ocelot_stats.c
@@ -1021,6 +1021,6 @@ int ocelot_stats_init(struct ocelot *ocelot)
 
 void ocelot_stats_deinit(struct ocelot *ocelot)
 {
-	cancel_delayed_work(&ocelot->stats_work);
+	cancel_delayed_work_sync(&ocelot->stats_work);
 	destroy_workqueue(ocelot->stats_queue);
 }
-- 
2.34.1


