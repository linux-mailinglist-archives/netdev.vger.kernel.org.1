Return-Path: <netdev+bounces-110076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABCE92AE77
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C490282994
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 03:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32344C94;
	Tue,  9 Jul 2024 03:12:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5C3D966
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 03:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494742; cv=none; b=bVseeitUe4wZpW6+A1pfV0CfSIDeC2haPOWOt8qhcRr9bBiFkOGj175xgBG5s5JZoTs6096tdPZQOgODdQGC1RDEbvvTCTHva44uNmParBPuLZ6x70iozbySjXyTbkt0oTbmkUBaIb20esSNs/tMn/r/unIGebD+xkudlsD8Q6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494742; c=relaxed/simple;
	bh=XFZV0Qc4ElXWa6xsPTH1q6tmPFm4bZl/59yAA5SYUPo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MnppUO3lDuyetjeSaEQJtTT8zuX5nMbmIgsi940lbPUfrj5wPuiYJ+YqvwBUrquKjmBFqGcJsTzwpwmBr6C+w7EcCed48ckCqblvslr7GYoUsm6AucxqXZh7+PgbLbJvisb4ZxER3fxNFaXVzwyfhCCW/bMH3qFLNrqGCORi7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f6218c0d68so584709839f.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 20:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720494740; x=1721099540;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTcOd6S5hjqJaw4entfORyAfTyoeoPtGdQQtiW3Xu+0=;
        b=m4122yAHbvkcSuXbV1vxkH4vpWJKXWldA7ZfBfA4Ixe4ztsNejIE9s8d/4/PF19F41
         Bro9V2St/hQA01n+irJO628CHIzTTVbX/8wb3XfykJckbj5xG4D9rE2c6PCkJXl2n7Ih
         NDaPYojusxnwqsodhWf1vyAEBCmNI7X5zwgsNOc3utDfXiqNrxPUEdLRLKLpeVDzWtU1
         Nl705z4fx9DZ2p8r/4VxMYoySnh1QIUivDCweSqRdDEvf/sBshFqNWtynBCvMm6c1EPW
         C9fvxIDcPhG/L8oimofuckgGbowezu421Gn0CA3/PZRzmIjyjre68c1WdqTNP7JRPas/
         tbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGLvqfCR6Tj2Vc2Dgxo9q2wMufGY92YfstTTfkef+/Laf6ghdXOEUdkiFRRF1Em5fVIEnY3dhUwQLxaHB35KUgxiM6PTYu
X-Gm-Message-State: AOJu0YzKP0hrxdpqROVgl9PF5hjpyTVXhU+6HN/rgQwO6TAKHF4g2syn
	fj6jI6KaPeoDZIwhpfDVsAhsbvHp9tOGO1DU7oTAtVjW2NYEz38gwPQnWUsMqQ7TiM4JPaZY7/U
	3wiRX4H6NIopGRBx1dD8C7Tb0V9HaFdBK51barCpcARtSv3cq4hKaQ50=
X-Google-Smtp-Source: AGHT+IHCkPwdiq/I65r8mVNNcFB5ddKi+JZqFLSl5kiqL1VBKN+R733LItz1xqfogQGSn+L11xbxyKAqT0hOIRtszNm6L5WoOluE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d85:b0:7fc:dfb0:4e52 with SMTP id
 ca18e2360f4ac-80006d99988mr10069739f.4.1720494739840; Mon, 08 Jul 2024
 20:12:19 -0700 (PDT)
Date: Mon, 08 Jul 2024 20:12:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce6fdb061cc7e5b2@google.com>
Subject: [syzbot] [batman?] BUG: soft lockup in batadv_iv_send_outstanding_bat_ogm_packet
From: syzbot <syzbot+572f6e36bc6ee6f16762@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    795c58e4c7fc Merge tag 'trace-v6.10-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bf7976980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c950e46ec3ea637a
dashboard link: https://syzkaller.appspot.com/bug?extid=572f6e36bc6ee6f16762
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/393fdf1d08dd/disk-795c58e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/724001a1b4be/vmlinux-795c58e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ede352392b0/bzImage-795c58e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+572f6e36bc6ee6f16762@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 143s! [kworker/u8:8:2833]
Modules linked in:
irq event stamp: 1708674
hardirqs last  enabled at (1708673): [<ffffffff81e178c0>] ___slab_alloc+0x870/0x1870 mm/slub.c:3577
hardirqs last disabled at (1708674): [<ffffffff8ae84a1e>] sysvec_apic_timer_interrupt+0xe/0xb0 arch/x86/kernel/apic/apic.c:1043
softirqs last  enabled at (1708660): [<ffffffff8aa82f2d>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (1708660): [<ffffffff8aa82f2d>] batadv_iv_ogm_queue_add net/batman-adv/bat_iv_ogm.c:661 [inline]
softirqs last  enabled at (1708660): [<ffffffff8aa82f2d>] batadv_iv_ogm_schedule_buff+0x97d/0x1500 net/batman-adv/bat_iv_ogm.c:833
softirqs last disabled at (1708658): [<ffffffff8aa82ee3>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (1708658): [<ffffffff8aa82ee3>] batadv_iv_ogm_queue_add net/batman-adv/bat_iv_ogm.c:639 [inline]
softirqs last disabled at (1708658): [<ffffffff8aa82ee3>] batadv_iv_ogm_schedule_buff+0x933/0x1500 net/batman-adv/bat_iv_ogm.c:833
CPU: 0 PID: 2833 Comm: kworker/u8:8 Not tainted 6.10.0-rc6-syzkaller-00069-g795c58e4c7fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:kfence_alloc include/linux/kfence.h:127 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3986 [inline]
RIP: 0010:kmem_cache_alloc_noprof+0x1bd/0x2f0 mm/slub.c:4009
Code: 5d 41 5e 41 5f 5d e9 2d aa 2e 09 31 c9 e9 71 ff ff ff 41 8b 44 24 08 a8 82 0f 84 5b ff ff ff a8 08 41 0f 45 de e9 50 ff ff ff <8b> 05 fd b8 f4 0b 85 c0 0f 85 c0 fe ff ff 4c 89 e7 44 89 f6 44 89
RSP: 0018:ffffc90009717840 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000002120 RCX: 0000000000000000
RDX: 1ffffffff1bace70 RSI: 0000000000000028 RDI: ffff88802ba3b3c4
RBP: ffffc90009717888 R08: 00000000ffffffff R09: ffff8880250de500
R10: 0000000000000000 R11: 0000000000000004 R12: ffff88801544f8c0
R13: 0000000000002120 R14: 0000000000000028 R15: 00000000250de500
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f64bd0ce2d8 CR3: 000000006623e000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 fill_pool+0x26b/0x5d0 lib/debugobjects.c:168
 debug_objects_fill_pool lib/debugobjects.c:615 [inline]
 __debug_object_init+0xf7/0x480 lib/debugobjects.c:627
 __init_work+0x4c/0x60 kernel/workqueue.c:678
 batadv_iv_ogm_aggregate_new+0x2dd/0x4a0 net/batman-adv/bat_iv_ogm.c:584
 batadv_iv_ogm_queue_add net/batman-adv/bat_iv_ogm.c:670 [inline]
 batadv_iv_ogm_schedule_buff+0x99b/0x1500 net/batman-adv/bat_iv_ogm.c:833
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:868 [inline]
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:861 [inline]
 batadv_iv_send_outstanding_bat_ogm_packet+0x31e/0x8d0 net/batman-adv/bat_iv_ogm.c:1712
 process_one_work+0x9c8/0x1b40 kernel/workqueue.c:3248
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x6c8/0xf30 kernel/workqueue.c:3409
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

