Return-Path: <netdev+bounces-100346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159488D8AB9
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 22:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379C1B2201A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990AD13B28D;
	Mon,  3 Jun 2024 20:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9746A4
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445432; cv=none; b=Qtjhv46v0P3UUl0WgkkDiCi+pKz6uDb+EERjGJ70q/eN11Yxf41ATj6OFjqlf4M6fWu6b00WtwryxkDXyCOkCX29FAWjTG79d4+PACLsxs6Mh4OF7DGXPJHm7/NgsKpQ7m6gue0Vz9toe5pVDliZJ3P/OHHZUG/YedK+goQCuE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445432; c=relaxed/simple;
	bh=COezhxMiO8LnS0x8wTsMoUdadFNcncWfGAUM+9NxZog=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F+RvSFhu9Qw2HN2km1jY/U8z00hF85TU0U70KGWSVad+P/5y8gSnQqRnkOwTrrR6N+VjgW477bYVH1HCwPlN0cSRYkKYAftt0CBVs04Rc7msd+FAdeGMtXW26KktEiTSbhnEBywiUeWBY2FFCQWBYD4pZ11/f9zWZ+UMguyDF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-374a53fc682so2209385ab.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 13:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717445430; x=1718050230;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxRzCjBuECTU/sGdLd303oZWSW5TcR632p/Z3UX+gTY=;
        b=ceow0RJLlDO+GP68PJThNJi6Fhw/+SkboxIw+0xMBcpn9U4n2net+YfHap8P/T5e+8
         msqKf2E6/10I57DAzjAkKULwGxyE0hlPoUq80k8HLTqcyz8eY98rGPYiFE2a5sgBKfPo
         44EiejiZu4KJ6C5TDNUZ8GIxMaXV52rcOXKY3VyMiSIc2bDzKXLBvmZ7tsgDw64zPu2N
         XmmtI4YDOinVoPruQJ2l9s4hxtud7nXfwwn0MhZLhnp3S2KjhL1f7+MgsWjNog9yBbpa
         fiZXHm14ZYxeZ7XPN4aM7WQlrR+laljboWz6n+kCR4kIdhiEx1D35exp02uUCkg1uvwV
         TrOA==
X-Forwarded-Encrypted: i=1; AJvYcCVB975vQwuqJ5ZdHWeXpD8LM4+Rm7ngY4gEjEbR+yndc9s7uGShPHvvokLPYMRwQ+cHPHVApJU7mXUI638rTMwd2Ua/ChZB
X-Gm-Message-State: AOJu0YwIj18j6PqcZnglsrz3AopZcy1NWZZJ4/42KbZlqUNmMI3Ewf7a
	HkPcoJzD/ZTnPETIFNbyQRzt5GpgJKnrw9z1DL4yG0kxYvGpxpnaVnKK1Uf57BzbIz2eCuU3D7H
	gWT3261yADEAcS7Zw30+4PuRfNXAKPTttqCsH3M/MFT6vB3guG0CaVeY=
X-Google-Smtp-Source: AGHT+IFX+KKg3oKONbyQzVmFLWqIVs0DRPg5yyoHhYHtggyd0Ky/+/iWLVV+zxSEIQg6etSdqe77BQkmhAviC8++//jbkb6LTYKy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c4:b0:373:fed2:d934 with SMTP id
 e9e14a558f8ab-3748b96aa5amr9970465ab.1.1717445430249; Mon, 03 Jun 2024
 13:10:30 -0700 (PDT)
Date: Mon, 03 Jun 2024 13:10:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca9a81061a01ec20@google.com>
Subject: [syzbot] [net?] KASAN: global-out-of-bounds Read in __hw_addr_add_ex
From: syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7932b172ac7e Revert "riscv: mm: accelerate pagefault when ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=138db30c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71e27a66e3476b52
dashboard link: https://syzkaller.appspot.com/bug?extid=91161fe81857b396c8a0
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-7932b172.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/484dae64ac53/vmlinux-7932b172.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0917f9215e08/Image-7932b172.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in memcmp+0xc0/0xca lib/string.c:676
Read of size 1 at addr ffffffff8905f080 by task syz-executor.1/3813

CPU: 1 PID: 3813 Comm: syz-executor.1 Not tainted 6.10.0-rc1-syzkaller-g7932b172ac7e #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000f6f8>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:129
[<ffffffff85c29e64>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:135
[<ffffffff85c83b6c>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff85c83b6c>] dump_stack_lvl+0x122/0x196 lib/dump_stack.c:114
[<ffffffff85c341cc>] print_address_description mm/kasan/report.c:377 [inline]
[<ffffffff85c341cc>] print_report+0x288/0x596 mm/kasan/report.c:488
[<ffffffff8091ed98>] kasan_report+0xec/0x118 mm/kasan/report.c:601
[<ffffffff80920be2>] __asan_report_load1_noabort+0x12/0x1a mm/kasan/report_generic.c:378
[<ffffffff85c00d1e>] memcmp+0xc0/0xca lib/string.c:676
[<ffffffff84a203e2>] __hw_addr_add_ex+0xee/0x676 net/core/dev_addr_lists.c:88
[<ffffffff84a233e2>] __dev_mc_add net/core/dev_addr_lists.c:867 [inline]
[<ffffffff84a233e2>] dev_mc_add+0xac/0x108 net/core/dev_addr_lists.c:885
[<ffffffff84bb54ee>] mrp_init_applicant+0xe8/0x56e net/802/mrp.c:873
[<ffffffff8578898e>] vlan_mvrp_init_applicant+0x26/0x30 net/8021q/vlan_mvrp.c:57
[<ffffffff8577ec66>] register_vlan_dev+0x1b4/0x922 net/8021q/vlan.c:170
[<ffffffff8577f922>] register_vlan_device net/8021q/vlan.c:277 [inline]
[<ffffffff8577f922>] vlan_ioctl_handler+0x54e/0x956 net/8021q/vlan.c:621
[<ffffffff84952e12>] sock_ioctl+0x1f6/0x61a net/socket.c:1305
[<ffffffff80a0f314>] vfs_ioctl fs/ioctl.c:51 [inline]
[<ffffffff80a0f314>] __do_sys_ioctl fs/ioctl.c:907 [inline]
[<ffffffff80a0f314>] __se_sys_ioctl fs/ioctl.c:893 [inline]
[<ffffffff80a0f314>] __riscv_sys_ioctl+0x186/0x1d6 fs/ioctl.c:893
[<ffffffff8000e200>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:90
[<ffffffff85c85e24>] do_trap_ecall_u+0x14c/0x214 arch/riscv/kernel/traps.c:330
[<ffffffff85ca872c>] ret_from_exception+0x0/0x64 arch/riscv/kernel/entry.S:112

The buggy address belongs to the variable:
 vlan_mrp_app+0x60/0x3e80

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8925f
flags: 0xffe000000002000(reserved|node=0|zone=0|lastcpupid=0x7ff)
raw: 0ffe000000002000 ff1c0000002497c8 ff1c0000002497c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8905ef80: f9 f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff8905f000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffff8905f080: f9 f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
                   ^
 ffffffff8905f100: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 00
 ffffffff8905f180: f9 f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


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

