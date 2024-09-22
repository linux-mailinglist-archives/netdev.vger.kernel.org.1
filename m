Return-Path: <netdev+bounces-129197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D615A97E2D0
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 19:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AFF1F215C9
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4462B9C6;
	Sun, 22 Sep 2024 17:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA533F7
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727027182; cv=none; b=uAa/RwcpmCIaoM+SujtbleOufe4edw6KcdIQFYbJ/uTZRa/yE9qh1/c9B5m9FXzuAoRRMgqYCl70iluJe6jayoXzIM/tnS90zqRZYW+yXyh2z6uhV+xSBuCVlKnYhM2GhQtbElmeTdeViqI9G7+yoOs1yxCYG7OPc1979kqMG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727027182; c=relaxed/simple;
	bh=Q+bddzHwkK2Nu9MCTXdGS7cq3kWB67sECu1dEG+PJ1U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l/5/TWK3uJH6xBySVBGhAnHY4TtHSpIGvxJP7zz1Qk3v9D1r9S0cvKu+l+NNIyj+mJICqbuTjkKk5IqxxwV/Nnt329SndF9AXDSlrJjHhPJ87T61IhwCfb7aLRi08qVeUSS9Hhye8+7/R+mL4DZEOauPuxqYrFLCtSZ6jU0xIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cdb4971b9so375183639f.2
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 10:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727027179; x=1727631979;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GZGILpo84C84oDf7lkUCqjURmbaY/I1uZq6HFexLnc=;
        b=lElWEypjclh1QgpVvk7QJcVNenchpXBqcQKW0MRaJ/zherYJV4Fqt2X177srQ7XVYv
         UvG3zeVHvjlzxp6ykR95s2buCbTt8kPIAiHnNnTxVLkcBSe6PeOwpVuWpzi1PaqwuT9g
         0Qy2jZ91ZQBiMDhcoGuyo5e+9Tqyi4pqthcbIsIsrczVOR3sxZwFl3Y2i1uZ21gqv1Xg
         JiPnBoUAm41n2Q2n9eXU+UqU6aWNvkBEW1wJz+7pyWrfErWWPy0aUi+8mOTvOOAlAo0R
         1MBbujN34Lqi0YE2VLGDC/+DnW7fmS2T/PNgSt1FroVDkcgopqTzTZHilAhHrZhbya24
         EiIg==
X-Forwarded-Encrypted: i=1; AJvYcCVcuakYv5yc3M15RTs579OiH7YutHlEMO3m9Po5AuscvfXYzeYUm6fuC0dwav2T1CUt552dwyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8hTC0tVXGBk8mhjZgJtaN2z7xg87d2kfLJJQvJbaOUpjrbs/a
	YhEA5iemEicOxFvU7be15+jOmLQ3rwb1/NvGCsXjyiu6rBc+PxdWc2PVhB1gmYfXf13GkFshEqZ
	mHHUhryt68UR7C2XER7KTU28kN+xFj1C+f8awIA3iaC9GzqubRlWD/aw=
X-Google-Smtp-Source: AGHT+IFcOunlSgil0zRZA616kW6EiJ6VF1dWpASBC+DfN7Xk2mvbx2FjMY46Q68DrtilSDAJsZYv+GIdnhU33JEJ7FYAJ2GevKys
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:3a0:98ab:7957 with SMTP id
 e9e14a558f8ab-3a0c8d29354mr62490705ab.24.1727027179595; Sun, 22 Sep 2024
 10:46:19 -0700 (PDT)
Date: Sun, 22 Sep 2024 10:46:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f057eb.050a0220.a27de.0004.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: kernel-infoleak in move_addr_to_user (7)
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=172c4107980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547de13ee0a4d284
dashboard link: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d7c19f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c81c27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d83fc781c223/disk-88264981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ed4c5969fba/vmlinux-88264981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/76a67bd894be/bzImage-88264981.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _inline_copy_to_user include/linux/uaccess.h:180 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _inline_copy_to_user include/linux/uaccess.h:180 [inline]
 _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:209 [inline]
 move_addr_to_user+0x28b/0x400 net/socket.c:292
 ____sys_recvmsg+0x232/0x620 net/socket.c:2829
 ___sys_recvmsg+0x223/0x840 net/socket.c:2864
 do_recvmmsg+0x4f6/0xfd0 net/socket.c:2958
 __sys_recvmmsg net/socket.c:3037 [inline]
 __do_sys_recvmmsg net/socket.c:3060 [inline]
 __se_sys_recvmmsg net/socket.c:3053 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3053
 x64_sys_call+0x2e5d/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 packet_recvmsg+0x176a/0x2500 net/packet/af_packet.c:3585
 sock_recvmsg_nosec+0x22f/0x2b0 net/socket.c:1052
 ____sys_recvmsg+0x541/0x620 net/socket.c:2820
 ___sys_recvmsg+0x223/0x840 net/socket.c:2864
 do_recvmmsg+0x4f6/0xfd0 net/socket.c:2958
 __sys_recvmmsg net/socket.c:3037 [inline]
 __do_sys_recvmmsg net/socket.c:3060 [inline]
 __se_sys_recvmmsg net/socket.c:3053 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3053
 x64_sys_call+0x2e5d/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 eth_header_parse+0xb8/0x110 net/ethernet/eth.c:204
 dev_parse_header include/linux/netdevice.h:3158 [inline]
 packet_rcv+0xefc/0x2050 net/packet/af_packet.c:2253
 dev_queue_xmit_nit+0x114b/0x12a0 net/core/dev.c:2347
 xmit_one net/core/dev.c:3584 [inline]
 dev_hard_start_xmit+0x17d/0xa20 net/core/dev.c:3604
 __dev_queue_xmit+0x3576/0x55e0 net/core/dev.c:4424
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]
 __bpf_tx_skb net/core/filter.c:2152 [inline]
 __bpf_redirect_common net/core/filter.c:2196 [inline]
 __bpf_redirect+0x148c/0x1610 net/core/filter.c:2203
 ____bpf_clone_redirect net/core/filter.c:2475 [inline]
 bpf_clone_redirect+0x37e/0x500 net/core/filter.c:2447
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:2010
 __bpf_prog_run512+0xc5/0xf0 kernel/bpf/core.c:2253
 bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 bpf_test_run+0x546/0xd20 net/bpf/test_run.c:433
 bpf_prog_test_run_skb+0x182f/0x24d0 net/bpf/test_run.c:1094
 bpf_prog_test_run+0x6b1/0xac0 kernel/bpf/syscall.c:4320
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5735
 __do_sys_bpf kernel/bpf/syscall.c:5824 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5822 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5822
 x64_sys_call+0x2cce/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4092 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4187
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
 skb_ensure_writable+0x496/0x520 net/core/skbuff.c:6214
 __bpf_try_make_writable net/core/filter.c:1677 [inline]
 bpf_try_make_writable net/core/filter.c:1683 [inline]
 bpf_try_make_head_writable net/core/filter.c:1691 [inline]
 ____bpf_clone_redirect net/core/filter.c:2469 [inline]
 bpf_clone_redirect+0x1c5/0x500 net/core/filter.c:2447
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:2010
 __bpf_prog_run512+0xc5/0xf0 kernel/bpf/core.c:2253
 bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 bpf_test_run+0x546/0xd20 net/bpf/test_run.c:433
 bpf_prog_test_run_skb+0x182f/0x24d0 net/bpf/test_run.c:1094
 bpf_prog_test_run+0x6b1/0xac0 kernel/bpf/syscall.c:4320
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5735
 __do_sys_bpf kernel/bpf/syscall.c:5824 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5822 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5822
 x64_sys_call+0x2cce/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 12-17 of 20 are uninitialized
Memory access of size 20 starts at ffff88812112fa48
Data copied to user address 0000000020000ac0

CPU: 0 UID: 0 PID: 5234 Comm: syz-executor312 Not tainted 6.11.0-syzkaller-08481-g88264981f208 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

