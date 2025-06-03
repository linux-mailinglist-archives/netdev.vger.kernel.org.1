Return-Path: <netdev+bounces-194799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41289ACCA2B
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 17:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F40F1888EB4
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A51B1537DA;
	Tue,  3 Jun 2025 15:30:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA89A944
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964640; cv=none; b=k6tXbj1Qc5D9aaGNLcqiKjYlTtIfW1vl8Btp3DrfTcITErt/YVtZ3xWRnY6RvWXN4FJ7z/RiBY5vkMc72Ohr8a9PAbGGOiBbRyr/8FUECyEVXegGOWI2eFTFWjNhnGzg5U4f49KBMk0ikrh7rDAH5kUsz7tDqaWO41iLIhihOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964640; c=relaxed/simple;
	bh=NgVzIKrV+vT373R7pPrBdnfQ+JbPy3LNrhvewfBlpoY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J7GaAnKEw2DjydDi7EZxjcbl6CzvNXT8wtEm+w/LLahHLetDCNn8Yv7lrlTqortgjiYA9yWv166MmdnMcHJjJxm6eDwwoMvxF/G+ciheWHTjaxCFXBWqxgQ5JhfQiS8cuY2ddMt0qd63a9e+95UbsC289sf0/f+UZKi/wW0u2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddb62de753so17001085ab.1
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 08:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748964637; x=1749569437;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdTk/4XrBAuy39KbJJeOpNDNYb42O4c1octVwjpyi+Q=;
        b=plIlzb3hZc7+vGyIDVAQgezzzdjwtkB2zm2/U/1SPtO++8soTB+7rU4SID+HvLBv4r
         iXCPe0QIssBUjnGBXgPF8nsEEN5+zS2dJwoKAwG9EukxTFFfZDSlVSaf0eIXtF9yZbuk
         VgRHbHVHVcUXyltynS25Bl9QpIlc+ADh1h1DnXV8sRrx+Bxx0nW4C4cL5Zb/yr8MouO3
         exHlpVA6AOs3HjN6RT2Ucu6ElMVrhJUanT/QPccNhQ8NRI0CuV3SvpFX2vIQvEFX6Yzl
         TtnSo3lzgePIX204OxA0yrH4TLRNMvygUocxJ+eznLgoJbPBfb5oX12sjh3QfZ4Hr3Iy
         sMWg==
X-Forwarded-Encrypted: i=1; AJvYcCV78pX6qRLCNUkKtWnKXsB8HrMN+lxf6B985mYhQ/uKdgbbR0JsRPeofIcxoYP6M+aYCGHayq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1RvEPIzC8U2EG+23Nru7HAtIa+8TNRlG8Y5vXBnnMpjgXt5o6
	9FY14R7j/pBXkInH5IMGg740lOZRhb88cFAbmycYxV0ZGRq9rPlMEUCWh11tjIMZ8NAJbB2lJRX
	NXnOtjzczszT7PP9btDpeFNMwhcQb1bWdrUtt/GUWhnK/7xE4qbwAHcsUFe4=
X-Google-Smtp-Source: AGHT+IESbnyBV6XlZCYt+k5zSHtdsO6KCiniIvtH0ta7Xbqbk/5TT2jaD91TWXYrgk1NsjL2k1R75FSVdCdjnt23EuWSv+mFTJwy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2287:b0:3dc:8a53:c9c4 with SMTP id
 e9e14a558f8ab-3dda3342b6cmr117953985ab.6.1748964634098; Tue, 03 Jun 2025
 08:30:34 -0700 (PDT)
Date: Tue, 03 Jun 2025 08:30:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683f151a.050a0220.55ceb.0014.GAE@google.com>
Subject: [syzbot] [net?] WARNING in napi_disable
From: syzbot <syzbot+406cbe754deca9aeaa82@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7fa1af5b33e Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14c71170580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89c13de706fbf07a
dashboard link: https://syzkaller.appspot.com/bug?extid=406cbe754deca9aeaa82
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da97ad659b2c/disk-d7fa1af5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/659e123552a8/vmlinux-d7fa1af5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6ec5dbf4643e/Image-d7fa1af5.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+406cbe754deca9aeaa82@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 6666 at kernel/locking/mutex.c:580 __mutex_lock_common+0x1650/0x2190 kernel/locking/mutex.c:580
Modules linked in:
CPU: 0 UID: 0 PID: 6666 Comm: kworker/u8:4 Not tainted 6.15.0-rc7-syzkaller-gd7fa1af5b33e #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: netns cleanup_net
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock_common+0x1650/0x2190 kernel/locking/mutex.c:580
lr : __mutex_lock_common+0x1650/0x2190 kernel/locking/mutex.c:580
sp : ffff80009bb27560
x29: ffff80009bb27720 x28: dfff800000000000 x27: ffff80009bb27640
x26: ffff700013764ec8 x25: 0000000000000000 x24: ffff80009bb27680
x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff0000d446ccd2 x18: 1fffe0003386aa76
x17: 0000000000000000 x16: ffff80008ad27e48 x15: ffff700011e740c0
x14: 1ffff00011e740c0 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011e740c0 x10: 0000000000ff0100 x9 : 120a1682c186fb00
x8 : 120a1682c186fb00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009bb26eb8 x4 : ffff80008f415ba0 x3 : ffff800080548ef0
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 __mutex_lock_common+0x1650/0x2190 kernel/locking/mutex.c:580 (P)
 __mutex_lock kernel/locking/mutex.c:746 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:798
 netdev_lock include/linux/netdevice.h:2751 [inline]
 napi_disable+0x4c/0x84 net/core/dev.c:7238
 gro_cells_destroy+0xf4/0x374 net/core/gro_cells.c:116
 ip_tunnel_dev_free+0x20/0x38 net/ipv4/ip_tunnel.c:1102
 netdev_run_todo+0xb44/0xd24 net/core/dev.c:11300
 rtnl_unlock+0x14/0x20 net/core/rtnetlink.c:157
 cleanup_net+0x574/0x9c0 net/core/net_namespace.c:650
 process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
irq event stamp: 1642461
hardirqs last  enabled at (1642461): [<ffff80008addfa48>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (1642461): [<ffff80008addfa48>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (1642460): [<ffff80008addf878>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (1642460): [<ffff80008addf878>] _raw_spin_lock_irqsave+0x2c/0x7c kernel/locking/spinlock.c:162
softirqs last  enabled at (1641216): [<ffff800089102264>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (1641216): [<ffff800089102264>] netif_addr_unlock_bh include/linux/netdevice.h:4804 [inline]
softirqs last  enabled at (1641216): [<ffff800089102264>] dev_mc_flush+0x1b0/0x1f4 net/core/dev_addr_lists.c:1037
softirqs last disabled at (1641214): [<ffff800089102794>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address ffff0000d446ccd2
KASAN: maybe wild-memory-access in range [0xfffc0006a2366690-0xfffc0006a2366697]
Mem abort info:
  ESR = 0x0000000096000021
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x21: alignment fault
Data abort info:
  ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000002079fa000
[ffff0000d446ccd2] pgd=0000000000000000, p4d=180000023ffff403, pud=180000023f41b403, pmd=180000023f378403, pte=006800011446c707
Internal error: Oops: 0000000096000021 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6666 Comm: kworker/u8:4 Tainted: G        W           6.15.0-rc7-syzkaller-gd7fa1af5b33e #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: netns cleanup_net
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lse__cmpxchg_case_acq_64 arch/arm64/include/asm/atomic_lse.h:272 [inline]
pc : __cmpxchg_case_acq_64 arch/arm64/include/asm/cmpxchg.h:121 [inline]
pc : __cmpxchg_acq arch/arm64/include/asm/cmpxchg.h:169 [inline]
pc : raw_atomic64_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:4181 [inline]
pc : raw_atomic64_try_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:4299 [inline]
pc : raw_atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-long.h:1482 [inline]
pc : atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4458 [inline]
pc : __mutex_trylock_common+0x178/0x258 kernel/locking/mutex.c:112
lr : instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
lr : atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4457 [inline]
lr : __mutex_trylock_common+0x16c/0x258 kernel/locking/mutex.c:112
sp : ffff80009bb27480
x29: ffff80009bb27500 x28: ffff0000d9f59e80 x27: ffff80009bb274a0
x26: 1ffff00013764e94 x25: dfff800000000000 x24: ffff0000d9f59e80
x23: 1ffff00012dee370 x22: ffff80008f32136c x21: ffff0000d9f59e80
x20: ffff0000d446ccd2 x19: 0000000000000000 x18: 1fffe0003386aa76
x17: 0000000000000000 x16: ffff800080514f0c x15: 0000000000000001
x14: 1ffff00013764e98 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700013764e99 x10: dfff800000000000 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000001 x6 : ffff8000890d4c0c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080515078
x2 : 0000000000000001 x1 : 0000000000000008 x0 : 0000000000000001
Call trace:
 __lse__cmpxchg_case_acq_64 arch/arm64/include/asm/atomic_lse.h:272 [inline] (P)
 __cmpxchg_case_acq_64 arch/arm64/include/asm/cmpxchg.h:121 [inline] (P)
 __cmpxchg_acq arch/arm64/include/asm/cmpxchg.h:169 [inline] (P)
 raw_atomic64_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:4181 [inline] (P)
 raw_atomic64_try_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:4299 [inline] (P)
 raw_atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-long.h:1482 [inline] (P)
 atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4458 [inline] (P)
 __mutex_trylock_common+0x178/0x258 kernel/locking/mutex.c:112 (P)
 __mutex_trylock kernel/locking/mutex.c:135 [inline]
 __mutex_lock_common+0x1e8/0x2190 kernel/locking/mutex.c:604
 __mutex_lock kernel/locking/mutex.c:746 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:798
 netdev_lock include/linux/netdevice.h:2751 [inline]
 napi_disable+0x4c/0x84 net/core/dev.c:7238
 gro_cells_destroy+0xf4/0x374 net/core/gro_cells.c:116
 ip_tunnel_dev_free+0x20/0x38 net/ipv4/ip_tunnel.c:1102
 netdev_run_todo+0xb44/0xd24 net/core/dev.c:11300
 rtnl_unlock+0x14/0x20 net/core/rtnetlink.c:157
 cleanup_net+0x574/0x9c0 net/core/net_namespace.c:650
 process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
Code: 941c570a f94023e9 d503201f aa0903e8 (c8e87e95) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	941c570a 	bl	0x715c28
   4:	f94023e9 	ldr	x9, [sp, #64]
   8:	d503201f 	nop
   c:	aa0903e8 	mov	x8, x9
* 10:	c8e87e95 	casa	x8, x21, [x20] <-- trapping instruction


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

