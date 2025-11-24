Return-Path: <netdev+bounces-241103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB20C7F3C9
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3608E4E265E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DD9231A32;
	Mon, 24 Nov 2025 07:46:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C21A295
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970387; cv=none; b=OlbF+K2o9ZMboaDDW6qarJON13kLNAbAAJtms/ZYhNIJVgs9Gk4BGGxmSCuTGrULhNjxIPc41GKas4W5ciiKhbbifa0GziNlIRislI/wf8WTxiy6+mV+7lX8bTuOArab9IeFJE1Psp0J+uk+y6y0VNdRaE+jmYaltdaOQBo4vp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970387; c=relaxed/simple;
	bh=aI0efZ98/dHpLAfgdgRaca5judbHaOifB5yQ80Cwb3I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ANExnSjQLbsNXNrYauDYso98SKTmDixTYsIEQsCfTdYHOGmSEfsre+jGDnzkeqMrU64UeRDYp65X1ziXXXsfplXSN3fEijChSFgpsx9drkVsV8dXVwL19ID/oK+3S5x3tj33xTQcsZD16ShKje3IohXbzIRDs3O6oqymawU8hQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-4348db9e727so34304485ab.2
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 23:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970384; x=1764575184;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUF0FuYeplt8OAmp7Jv18Hg0BCHJKahXy427+kdtEYQ=;
        b=jQ8scxUlVAROAmVhrdBukuVO3J0zO8s8bCR8Tzlvw/nJOi8VdYHiU+UtGKWoHg3iKq
         5SeeCJOt7GWSfWZdZpr9u27SaWiW7a6mar49zwRlOcad1cGDKU8mGHQbzQeu9N4eANtv
         CWxnZKAs0FChwlO58teP21JoPsCs2KP49/gwBbcCf7Lz4eDeqDg+H9RFzCkgquhqLRl8
         qEmmJF5zGXnRoBVC0yjSYHCoRw2XjB5M9GZWFaAp+bhun/EshelfYSGKFTyERCy9YpAG
         6UFJxv36rtcbYVg9awN6QzxyUTaFkSN0KBNEFXUxg9Ih/9FUAb2Y3Hip9incNWpwJmE9
         lYxA==
X-Forwarded-Encrypted: i=1; AJvYcCWFtaV5WNqUM8G+D/F9AZtizduUaplWPSFhBBRm1Tlr2Ju0kod0Ml5gwavU3RgxcKpnhLMJz2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxotVBkK+KR7lMkLrBjgnxrNV2dzxC3+2WSCmij94C0baMaNQam
	0083KrnUyJBOIxCrdy7h0poA+CGs3EWO1ns1EZ5iBHDSH7knRepkVFSWCgx86ZuhXDx3egU5467
	qlgQ7CCUWbsiKZnGDRaqbdW2v3onQVdVn/j+eqm9fZg8SeNr907kmAmN6/p4=
X-Google-Smtp-Source: AGHT+IGDo5fPpPrWJ+/TGggB6tbpgjyH8VsN7o2hzR04EgAhSMgRmLaDKBsH5HBnrh854neqrOEhXTYOcOAKs4KOtbfGYrPGVs2V
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:433:2091:8a86 with SMTP id
 e9e14a558f8ab-435b8c25befmr90993185ab.6.1763970384660; Sun, 23 Nov 2025
 23:46:24 -0800 (PST)
Date: Sun, 23 Nov 2025 23:46:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69240d50.a70a0220.d98e3.007d.GAE@google.com>
Subject: [syzbot] [net?] [virt?] [kvm?] BUG: soft lockup in vsock_loopback_work
From: syzbot <syzbot+c3a176bfafbec366d774@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e7c375b18160 Merge tag 'vfs-6.18-rc7.fixes' of gitolite.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121cfb42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c473789166ef75a5
dashboard link: https://syzkaller.appspot.com/bug?extid=c3a176bfafbec366d774
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-e7c375b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/474d6d613c09/vmlinux-e7c375b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9cfbda18d15c/zImage-e7c375b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3a176bfafbec366d774@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 460s! [kworker/1:6:18885]
Modules linked in:
CPU: 1 UID: 0 PID: 18885 Comm: kworker/1:6 Not tainted syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
Workqueue: vsock-loopback vsock_loopback_work
PC is at arch_spin_lock arch/arm/include/asm/spinlock.h:74 [inline]
PC is at do_raw_spin_lock include/linux/spinlock.h:187 [inline]
PC is at __raw_spin_lock_bh include/linux/spinlock_api_smp.h:127 [inline]
PC is at _raw_spin_lock_bh+0x40/0x58 kernel/locking/spinlock.c:178
LR is at get_lock_parent_ip include/linux/ftrace.h:1102 [inline]
LR is at preempt_latency_start kernel/sched/core.c:5775 [inline]
LR is at preempt_count_add+0x12c/0x150 kernel/sched/core.c:5800
pc : [<81a6de50>]    lr : [<8028fe9c>]    psr: 80000013
sp : df9cdda8  ip : df9cdd80  fp : df9cddbc
r10: 846a8b70  r9 : 83c92c05  r8 : 838f5400
r7 : 829faaf0  r6 : 85b91880  r5 : 85b91970  r4 : 85b91970
r3 : 00000008  r2 : 00000009  r1 : 00000000  r0 : 00000000
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 848af1c0  DAC: 00000000
Call trace: 
[<81a6de10>] (_raw_spin_lock_bh) from [<8155efe8>] (spin_lock_bh include/linux/spinlock.h:356 [inline])
[<81a6de10>] (_raw_spin_lock_bh) from [<8155efe8>] (lock_sock_nested+0x1c/0x48 net/core/sock.c:3723)
 r5:85b91970 r4:85b91880
[<8155efcc>] (lock_sock_nested) from [<819eaefc>] (lock_sock include/net/sock.h:1679 [inline])
[<8155efcc>] (lock_sock_nested) from [<819eaefc>] (virtio_transport_recv_pkt+0x350/0xa4c net/vmw_vsock/virtio_transport_common.c:1631)
 r5:8ddf7780 r4:85b918e4
[<819eabac>] (virtio_transport_recv_pkt) from [<819eb7b4>] (vsock_loopback_work+0xf4/0x128 net/vmw_vsock/vsock_loopback.c:133)
 r10:846a8b70 r9:83c92c05 r8:829faaf0 r7:00000000 r6:00000000 r5:df9cde98
 r4:8ddf7780
[<819eb6c0>] (vsock_loopback_work) from [<802785a0>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3263)
 r8:838f5400 r7:ddde3d80 r6:83c92c00 r5:82c3de40 r4:830cf000
[<802783ec>] (process_one_work) from [<802791e8>] (process_scheduled_works kernel/workqueue.c:3346 [inline])
[<802783ec>] (process_one_work) from [<802791e8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3427)
 r10:61c88647 r9:838f5400 r8:830cf02c r7:82804d40 r6:ddde3d80 r5:ddde3da0
 r4:830cf000
[<80278fec>] (worker_thread) from [<8028020c>] (kthread+0x12c/0x280 kernel/kthread.c:463)
 r10:00000000 r9:830cf000 r8:80278fec r7:dfb79e60 r6:8db08900 r5:838f5400
 r4:00000001
[<802800e0>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdf9cdfb0 to 0xdf9cdff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802800e0
 r4:849cc940
Sending NMI from CPU 1 to CPUs 0:


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

