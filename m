Return-Path: <netdev+bounces-63230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F3582BE23
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBA61F23578
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2C35D90A;
	Fri, 12 Jan 2024 10:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F01E5D8E7
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bef3fcd7a0so238076439f.0
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 02:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705054228; x=1705659028;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TKo76irnEUdU7WN5xl7b2O529KOu1eHCJEMQU5RtK0=;
        b=IFTNfELyrX953KKpq/pJNAch9bigROTaNb4Q/W7rpTZZchGOSRxOHgBUKQ2c5fdfND
         8g8BdftLScm5HNj6C1d3X9jvmovi7tH2rQaZIDjI5VCZ9ksgHiADBSXN8j8/9GJ/aP3f
         kjnR8uhAFT/NKRZFGZtfMNyL7dwXLhC88ew5PP0Nh6zgT2fEe36/8Zu7RPIWTCCUQnja
         XWSoScbRWfEJzndFSXmlPpQCkFWPWqbKZpWMq17H5dJhh6595XfrJEMgD/882VmJRUbX
         58QZGHyH6CHhwUBmgY4SeUdSwVrAnLQYXa4QfMA7D6C+A1BOKNmTOvpeaGVFJLhKB6Y5
         zJ0Q==
X-Gm-Message-State: AOJu0Yx0VIWNyT02W9rjNxGcRer2qNXIPog09ApifzT1V4Fju5EChe6j
	bz72NRodE99NIUljahLjEbIIGZomnsEtTX9rmexe6SHCq70v
X-Google-Smtp-Source: AGHT+IFYlkwUZF7iWBpEFLMrhGPggO5xDR5ggg0ZW1XzJN8HWr/s4Bk//00UTS/9dvR3xzw/J7WGBYdzTYBkoF3oPxLStnLz6XIO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1381:b0:46e:6732:763e with SMTP id
 w1-20020a056638138100b0046e6732763emr25023jad.5.1705054228827; Fri, 12 Jan
 2024 02:10:28 -0800 (PST)
Date: Fri, 12 Jan 2024 02:10:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1d657060ebcdf1d@google.com>
Subject: [syzbot] [wireguard?] KCSAN: data-race in wg_packet_handshake_receive_worker
 / wg_packet_rx_poll (7)
From: syzbot <syzbot+97d9596e4ae0572c9825@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5db8752c3b81 Merge tag 'vfs-6.8.iov_iter' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1540e665e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7a01358d18c37d5
dashboard link: https://syzkaller.appspot.com/bug?extid=97d9596e4ae0572c9825
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0636ecefd856/disk-5db8752c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc253e77814b/vmlinux-5db8752c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/63071c2b09b4/bzImage-5db8752c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97d9596e4ae0572c9825@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in wg_packet_handshake_receive_worker / wg_packet_rx_poll

read-write to 0xffff88812def3390 of 8 bytes by interrupt on cpu 1:
 update_rx_stats drivers/net/wireguard/receive.c:23 [inline]
 wg_packet_consume_data_done drivers/net/wireguard/receive.c:412 [inline]
 wg_packet_rx_poll+0xbd3/0xf00 drivers/net/wireguard/receive.c:474
 __napi_poll+0x60/0x3b0 net/core/dev.c:6536
 napi_poll net/core/dev.c:6605 [inline]
 net_rx_action+0x32b/0x750 net/core/dev.c:6738
 __do_softirq+0xc4/0x279 kernel/softirq.c:553
 do_softirq+0x5e/0x90 kernel/softirq.c:454
 __local_bh_enable_ip+0x64/0x70 kernel/softirq.c:381
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
 _raw_spin_unlock_bh+0x36/0x40 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:367 [inline]
 wg_packet_decrypt_worker+0x6c5/0x700 drivers/net/wireguard/receive.c:499
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2700
 worker_thread+0x525/0x730 kernel/workqueue.c:2781
 kthread+0x1d7/0x210 kernel/kthread.c:388
 ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

read-write to 0xffff88812def3390 of 8 bytes by task 8602 on cpu 0:
 update_rx_stats drivers/net/wireguard/receive.c:23 [inline]
 wg_receive_handshake_packet drivers/net/wireguard/receive.c:198 [inline]
 wg_packet_handshake_receive_worker+0x4b9/0x5e0 drivers/net/wireguard/receive.c:213
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2700
 worker_thread+0x525/0x730 kernel/workqueue.c:2781
 kthread+0x1d7/0x210 kernel/kthread.c:388
 ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

value changed: 0x000000000000079c -> 0x00000000000007ec

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 8602 Comm: kworker/0:0 Tainted: G        W          6.7.0-syzkaller-00119-g5db8752c3b81 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: wg-kex-wg1 wg_packet_handshake_receive_worker
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

