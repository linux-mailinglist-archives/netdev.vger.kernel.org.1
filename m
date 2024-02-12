Return-Path: <netdev+bounces-70918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCC78510CB
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 11:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25781B24D49
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EA11BC47;
	Mon, 12 Feb 2024 10:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEB2C840
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733587; cv=none; b=En+XrOHAWlNX3Tydezm00Ihj2NUVwfnnWWGKvXkjQAdiaUQJKIDVzmisQV+QPdyOxFTFfOZTgBcEpg3TnhjcSntksR1i3qPCQoTJs1J98tRaLQAZD3g8NrgXSjV0aCLHQn9c+TtOfDbtHhwVUJAYZVaITavHWbfAfV2Bf/FLlm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733587; c=relaxed/simple;
	bh=hgJkpOUwtfmr9Ijzr7liYopCApaSzSfsm4RU1NOld+E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Oq9UVIu5+ZXCEFzJG1cIRChWT1ilGQy4tCjY7cLPhnC3u3jOnLUDd5FbyOfq4Tel5CopIm0FeAv8jGpSc1ups4B/ov2NKcnb7e7FeV7eFfZ4skgx14SzCbIePbt0d/xZ6tuSl5FP4WRaU+v268f+K4v37v9b+gpWV1aEZVliwM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363ee8646b2so19712105ab.2
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 02:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733584; x=1708338384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+S1KVrX9I5Ts209Z1QyzWipPgFBmpJGS9brjneXDxOs=;
        b=Cid8QAJnUB24tQCVw/H+lRpTqlbuy2fdJfkc6hxH71k25+QwQ8HWwEg4AZ9yc5LtVI
         114RooU846kMAW7vGnkR5+O3PxXSJKdoH/vHli27y0NfB0RCt2rGyhZVu5JKvWDapbHx
         9PvDQNUUYyC6Dk8qUqsI/SdVT67ECI+9BQW9PtcbVnkAeSjKjn9zTDf/JlwLRcJdFxXt
         CAtngaHhqEKvOxNifXbsIGpW6xDUdRtYstKPzw5uzMY0aap1LSaLDPmKda9I1HD9jHEq
         s50sds78ev8cNjQibGU0JJ9wV8V7IsEnxpJKhYdDQZ8ljgQTWd89/moLl2V4s9S2zXiO
         becw==
X-Forwarded-Encrypted: i=1; AJvYcCWdMSQOp05DSLJkpl73yEZKilXTu/LVpl9a0g65C8nTdq12z/Tb79SlOyPG+jT8vVZzNdpcsA83HaywFe9dswQJrx1Oy/C1
X-Gm-Message-State: AOJu0YwBVSvt+SFMnBlU3t2vSyqA0MKy6kfynQiP7SqLjf2EcmUgLQZl
	F4Ys+bt+na45sVRtitM2oMxS0TECkTHLXvTR4nJqHV587u0+y6ka0f+VxCxP4F4oWrHZkp7ps29
	vWHgg4Lj1DCc75c13ZalYuSFDS1ObURqf5Kb5MPysC7jv816Zoj5iKlY=
X-Google-Smtp-Source: AGHT+IFocCpxDhklmIVXj6a6DiahtPX5mvpPE6Y9X0Lw7VbxCcJzYqa3K4GYh97gZ0Y1dhU/YVjfyE6WDJEtfFxp0EAOQ/3lB0g2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8e:b0:363:cb3c:f304 with SMTP id
 w14-20020a056e021c8e00b00363cb3cf304mr574998ill.4.1707733584584; Mon, 12 Feb
 2024 02:26:24 -0800 (PST)
Date: Mon, 12 Feb 2024 02:26:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae28ce06112cb52e@google.com>
Subject: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
From: syzbot <syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    41bccc98fb79 Linux 6.8-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14200118180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=451a1e62b11ea4a6
dashboard link: https://syzkaller.appspot.com/bug?extid=a6a4b5bb3da165594cff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0772069e29cf/disk-41bccc98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/659d3f0755b7/vmlinux-41bccc98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7780a45c3e51/Image-41bccc98.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [syz-executor.0:28718]
Modules linked in:
irq event stamp: 45929391
hardirqs last  enabled at (45929390): [<ffff8000801d9dc8>] __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
hardirqs last disabled at (45929391): [<ffff80008ad57108>] __el1_irq arch/arm64/kernel/entry-common.c:499 [inline]
hardirqs last disabled at (45929391): [<ffff80008ad57108>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:517
softirqs last  enabled at (2040): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (2040): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (2052): [<ffff80008aacbc40>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (2052): [<ffff80008aacbc40>] batadv_tt_local_resize_to_mtu+0x60/0x154 net/batman-adv/translation-table.c:3949
CPU: 1 PID: 28718 Comm: syz-executor.0 Not tainted 6.8.0-rc2-syzkaller-g41bccc98fb79 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : should_resched arch/arm64/include/asm/preempt.h:79 [inline]
pc : __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:388
lr : __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
sp : ffff80009a0670b0
x29: ffff80009a0670c0 x28: ffff70001340ce60 x27: ffff80009a0673d0
x26: ffff00011e860290 x25: ffff0000d08a9f08 x24: 0000000000000001
x23: 1fffe00023d4d3c1 x22: dfff800000000000 x21: ffff80008aacbf98
x20: 0000000000000202 x19: ffff00011ea69e08 x18: ffff80009a066800
x17: 77656e2074696620 x16: ffff80008031ffc8 x15: 0000000000000001
x14: 1fffe0001ba5a290 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000040000 x10: 0000000000000003 x9 : 0000000000000000
x8 : 0000000002bcd3ae x7 : ffff80008aacbe30 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : ffff80008aecd7e0 x0 : ffff80012545c000
Call trace:
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:49 [inline]
 __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:386
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
 _raw_spin_unlock_bh+0x3c/0x4c kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_tt_local_purge+0x264/0x2e8 net/batman-adv/translation-table.c:1356
 batadv_tt_local_resize_to_mtu+0xa0/0x154 net/batman-adv/translation-table.c:3956
 batadv_update_min_mtu+0x74/0xa4 net/batman-adv/hard-interface.c:651
 batadv_netlink_set_mesh+0x50c/0x1078 net/batman-adv/netlink.c:500
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0x874/0xb6c net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2543
 genl_rcv+0x38/0x50 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x65c/0x898 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x83c/0xb20 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x56c/0x840 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x26c/0x33c net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2674
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2-syzkaller-g41bccc98fb79 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:51
lr : default_idle_call+0xf8/0x128 kernel/sched/idle.c:103
sp : ffff80008ebe7cd0
x29: ffff80008ebe7cd0 x28: dfff800000000000 x27: 1ffff00011d7cfa8
x26: ffff80008ec6d000 x25: 0000000000000000 x24: 0000000000000001
x23: 1ffff00011d8da74 x22: ffff80008ec6d3a0 x21: 0000000000000000
x20: ffff80008ec94e00 x19: ffff8000802cff08 x18: 1fffe000367ff796
x17: ffff80008ec6d000 x16: ffff8000802cf7cc x15: 0000000000000001
x14: 1fffe00036801310 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : 0000000000000000
x8 : 0000000000bf0413 x7 : ffff800080461668 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008ad5af48
x2 : 0000000000000000 x1 : ffff80008aecd7e0 x0 : ffff80012543a000
Call trace:
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
 arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:49
 cpuidle_idle_call kernel/sched/idle.c:170 [inline]
 do_idle+0x1f0/0x4e8 kernel/sched/idle.c:312
 cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:410
 rest_init+0x2dc/0x2f4 init/main.c:730
 start_kernel+0x0/0x4e8 init/main.c:827
 start_kernel+0x3e8/0x4e8 init/main.c:1072
 __primary_switched+0xb4/0xbc arch/arm64/kernel/head.S:523


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

