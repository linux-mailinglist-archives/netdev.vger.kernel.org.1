Return-Path: <netdev+bounces-98425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CE38D1601
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5361F22A31
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E3D13AD0D;
	Tue, 28 May 2024 08:12:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F14CB2B
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883951; cv=none; b=VcHWPwfiF/KRkoPD4N38Ni2Kh6S31Zl5I4Q1+EsM0d24Qy/MgX/mPhznepCBbCS/EDRUElvpRtumEdCXL6EeDl+YqQeurFZZFndC+GAsvZpYpvRw+g4SK+clhnLIUOP5g9rq9b6A2E04ekwtv14BGpXbnOA55YZJIESfUR3YDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883951; c=relaxed/simple;
	bh=E5wpARPOeWcZieWnbOuZFu6eAepgeitTQOwRq5hBp3Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fOkqLFe25Px9UBe2rrFokXTxe0QySPy2jJbBN29+iJwVxdbC8/W6Gn/G9xmhZ+x9KBD8qQZfnyx4bi6cR/c7jfdF68hVPj19ZNF3ITR5aYTCKpaRl4wSRQYO5pQ8OTLFfMLWWg3sUwG4aOAxeEwcZso6CbUq5txbUeYvWR67jqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ead5f29d93so47144739f.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 01:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716883949; x=1717488749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHXvlX7qAyTn+H51EMXOxrRoGdZhF+XnYUadlZmocHE=;
        b=t+mZleF8bY2K8HCjfHJ6uIKCYOQbFrKOC+7omsKThIruyvmyIzfBZqmgctCM1lRe/N
         Sm9HRuAkLUHEcSS4djGgS7Fa9gnGXpYDzyus/OwV0By9ZbYHWcEjQM8nqTShrpQwZr+Y
         n9399S/yCocwzL1q6uxX0p8uuw5BwxCjeI6KiicEnnPovBnDXaH8JXSsbE3brNVwiIsc
         C/L4opQjuvPlYO3N65IKLd7m+TXOwS8NlCfgQk3w2wyoQ7MMiAvr/5XIRmCaElHG5ukb
         O0BxMyWCODvDfuBrfjbqyKgzPHyTdSZfhihruTnbQ2mSmbkspWEkDOfOBK+ufv1BgNxB
         sqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL5YF9Xh9oWU0ffmg6tj40n+eMcgVRb9uiBZ9yJDjA/pLK1ZpZ/HYZmoqEGy0GfmCaNVRrOFTntVYM40dKrVa4J3NapNv3
X-Gm-Message-State: AOJu0YyteEgqt3fdz20BCZLyhx4XotZLj8ewO5dCzMgU83CZrmM3USOq
	H7blfOpFK8xWDOg7Q100C4W3DCqZUQCoplIyTJ8U3I393X3AjJgBmjeHThVIyQvptg281tYz1vl
	mfqyBCraqIEMCBETcvmaTzoiKsJbxFxld3gKKb54Gds5JL87LQPl8BO0=
X-Google-Smtp-Source: AGHT+IF1aY6wXkcH0AVuwQqpdzip/3mGvajVyF0qU2zn2qnC6b/UOTHc5r63xQTD9fuWTbAItUHIQcTuhlQGUmXTvdkMCQoIcd3r
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d05:b0:7de:e2d3:20ba with SMTP id
 ca18e2360f4ac-7e8c1ada968mr58944939f.0.1716883948971; Tue, 28 May 2024
 01:12:28 -0700 (PDT)
Date: Tue, 28 May 2024 01:12:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e635ba06197f31f2@google.com>
Subject: [syzbot] [net?] [virt?] upstream boot error: KMSAN: uninit-value in receive_buf
From: syzbot <syzbot+c5336dcd1b741349d27a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jasowang@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1526be58980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d66c5ffb962c9d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=c5336dcd1b741349d27a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b89e8eae93a7/disk-8f6a15f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4e90ba9ba00/vmlinux-8f6a15f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/534e2e1e43eb/bzImage-8f6a15f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c5336dcd1b741349d27a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in receive_mergeable drivers/net/virtio_net.c:1839 [inline]
BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd0 drivers/net/virtio_net.c:1955
 receive_mergeable drivers/net/virtio_net.c:1839 [inline]
 receive_buf+0x25e3/0x5fd0 drivers/net/virtio_net.c:1955
 virtnet_receive drivers/net/virtio_net.c:2259 [inline]
 virtnet_poll+0xd1c/0x23c0 drivers/net/virtio_net.c:2362
 __napi_poll+0xe7/0x980 net/core/dev.c:6721
 napi_poll net/core/dev.c:6790 [inline]
 net_rx_action+0x82a/0x1850 net/core/dev.c:6906
 handle_softirqs+0x1d8/0x810 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0x68/0x120 kernel/softirq.c:637
 irq_exit_rcu+0x12/0x20 kernel/softirq.c:649
 common_interrupt+0x94/0xa0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693
 native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
 arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
 acpi_safe_halt+0x25/0x30 drivers/acpi/processor_idle.c:112
 acpi_idle_do_entry+0x22/0x40 drivers/acpi/processor_idle.c:573
 acpi_idle_enter+0xa1/0xc0 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0xcb/0x250 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x7f/0xf0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x551/0x750 kernel/sched/idle.c:332
 cpu_startup_entry+0x65/0x80 kernel/sched/idle.c:430
 rest_init+0x1e8/0x260 init/main.c:747
 start_kernel+0x92c/0xa70 init/main.c:1103
 x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x98/0xa0 arch/x86/kernel/head64.c:488
 common_startup_64+0x12c/0x137

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4683
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof+0x1bf/0x1e0 mm/mempolicy.c:2336
 skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2920
 virtnet_rq_alloc+0x43/0xbb0 drivers/net/virtio_net.c:882
 add_recvbuf_mergeable drivers/net/virtio_net.c:2110 [inline]
 try_fill_recv+0x3f0/0x2f50 drivers/net/virtio_net.c:2155
 virtnet_open+0x1cc/0xb00 drivers/net/virtio_net.c:2434
 __dev_open+0x546/0x6f0 net/core/dev.c:1472
 __dev_change_flags+0x309/0x9a0 net/core/dev.c:8780
 dev_change_flags+0x8e/0x1d0 net/core/dev.c:8852
 devinet_ioctl+0x13ec/0x22c0 net/ipv4/devinet.c:1177
 inet_ioctl+0x4bd/0x6d0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0xb7/0x540 net/socket.c:1222
 sock_ioctl+0x727/0xd70 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:893
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:893
 x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


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

