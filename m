Return-Path: <netdev+bounces-217661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB9EB3975E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEA7460445
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DC42E7BDC;
	Thu, 28 Aug 2025 08:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B603F205E2F
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370676; cv=none; b=H5X5BnUwgMMSec1fqS3vPsBZYQtRJ98AUM4uCi7h95lNgcaCbyD2QmJ0POrCBaSuu04GwKoPxEoSxEG2zup/s/cONJ35ofS0efzgEwfxio7bGOvSHf/FxoEmFP4iwdi7hU45L5ZeVj9CB+jfW2cv6auHA610GbM3Hx6wm70M5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370676; c=relaxed/simple;
	bh=tc5Jp/vbgM3UElv10x5lQdr8BkU0uq3COkrbKPH+DuA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MupyZZIbXhICmfnZXlWmUowgeOPUv1QrPcED6qA4/mUh531CWt5EwuUCOa8Eoayg0e1/TUQfP9LQjUpEGtghNmxkK3Lf+OTcHR953rt2ACc05xXkwAOCVQQ+ZPxbiOkacgbdH6u7hC4/PCLu/IPLGu5JLkvESzzH+a7iCk5W1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e5d398a961so18697435ab.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 01:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756370673; x=1756975473;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEaRHR9x8AfgcIS5oggNn/wUR7qBXtDnUWv4Q6q3658=;
        b=E/SlEQvwQR89b+Wb8iACk3ygOpjGiFk/T68AuBXlJj6kjibS44qUWi+y7QpVKP3QVj
         iWxH1TJpFYXc2lxByP46Hr9nsiuWGD39dSd33nN7wxFFt9uELPUtjnNJep4TciAurDT/
         bDWSU2roX7K9rLc9A9f8UPRzbx3rHiymTd4rngmXhwCwmPC8prNGi3MO4557cmZ3Ku4j
         FINlcc2jRxJqapLmKwMf8T2VV4prD6cHe0+tgO5PaVqD883ZH2vwxXRKB1gNwVTWwhkj
         Gd8tyc8GO4vT1zA7fR0aSLEKMbmHA0kjSSYjyK/vLVHhJEE3iPX9xOcR+gPWydgpXsWp
         ph4g==
X-Forwarded-Encrypted: i=1; AJvYcCXhH+vQvPx9gbYzF8gGjCcSG2mFAAdcro2zZAalePu8ukc+Sy7AzPJbhHyTPqRETydf1XXUsqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lEek3nhbOJofXfRE5fMIOwvCKRC2i6K/VsHUq0dvUeMR+bps
	gQTXhp5Tk3Ocm6ZIeLoyN+54LkDZXHJx8O3705VuBSrwn7MshG1q1t+Hz3oKVbq8ZxaAo8/5rlh
	Fc/ZJoluwpZMid0bz34ELpCxvotd1J8HVZNILsENojUbVdSjzv6oXppOVENQ=
X-Google-Smtp-Source: AGHT+IFk/PBEHUuVoL3zr6oIlFjeQJcDOXoUuC8fgSakp1rygQsPwT7SYJLqY0eX/NIOhlp1NQureEoar3tl3pfIslfHe8Hs1Xho
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170f:b0:3f1:aba6:6ecf with SMTP id
 e9e14a558f8ab-3f1aba670cbmr9504615ab.17.1756370672899; Thu, 28 Aug 2025
 01:44:32 -0700 (PDT)
Date: Thu, 28 Aug 2025 01:44:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b016f0.a00a0220.1337b0.0004.GAE@google.com>
Subject: [syzbot] [block?] INFO: task hung in queue_limits_commit_update_frozen
From: syzbot <syzbot+f272bbfbf8498ddadea5@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bd2902e0bcac Merge branch 'locking-fixes-for-fbnic-driver'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13bfdef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=292f3bc9f654adeb
dashboard link: https://syzkaller.appspot.com/bug?extid=f272bbfbf8498ddadea5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/866cb9f09108/disk-bd2902e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/05ea2ff5b4f0/vmlinux-bd2902e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b499ed83474/bzImage-bd2902e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f272bbfbf8498ddadea5@syzkaller.appspotmail.com

INFO: task syz.0.4146:17611 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.4146      state:D stack:26152 pid:17611 tgid:17609 ppid:14724  task_flags:0x480140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 blk_mq_freeze_queue_wait+0xf4/0x170 block/blk-mq.c:190
 blk_mq_freeze_queue include/linux/blk-mq.h:934 [inline]
 queue_limits_commit_update_frozen+0x5d/0x3e0 block/blk-settings.c:554
 nbd_set_size+0x47e/0x6a0 drivers/block/nbd.c:374
 nbd_genl_size_set+0x2eb/0x3c0 drivers/block/nbd.c:2058
 nbd_genl_reconfigure+0x409/0x1870 drivers/block/nbd.c:2361
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcc6338ebe9
RSP: 002b:00007fcc6417e038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fcc635b5fa0 RCX: 00007fcc6338ebe9
RDX: 0000000024002800 RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007fcc63411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcc635b6038 R14: 00007fcc635b5fa0 R15: 00007fffb3ba9178
 </TASK>
INFO: task syz.4.4151:17620 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.4151      state:D stack:26056 pid:17620 tgid:17619 ppid:14195  task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f23fbd90a7c
RSP: 002b:00007f23fccd4ec0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f23fccd4fc0 RCX: 00007f23fbd90a7c
RDX: 0000000000000028 RSI: 00007f23fccd5010 RDI: 0000000000000007
RBP: 0000000000000000 R08: 00007f23fccd4f14 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000007
R13: 00007f23fccd4f68 R14: 00007f23fccd5010 R15: 0000000000000000
 </TASK>
INFO: task syz.1.4155:17634 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.4155      state:D stack:28488 pid:17634 tgid:17633 ppid:14472  task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5a14d90a7c
RSP: 002b:00007f5a15c6fec0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f5a15c6ffc0 RCX: 00007f5a14d90a7c
RDX: 0000000000000020 RSI: 00007f5a15c70010 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007f5a15c6ff14 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000004
R13: 00007f5a15c6ff68 R14: 00007f5a15c70010 R15: 0000000000000000
 </TASK>
INFO: task syz.3.4158:17642 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.4158      state:D stack:26968 pid:17642 tgid:17641 ppid:15125  task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1752d90a7c
RSP: 002b:00007f1753c0fec0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f1753c0ffc0 RCX: 00007f1752d90a7c
RDX: 0000000000000020 RSI: 00007f1753c10010 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007f1753c0ff14 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000004
R13: 00007f1753c0ff68 R14: 00007f1753c10010 R15: 0000000000000000
 </TASK>
INFO: task syz.2.4168:17666 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.4168      state:D stack:27144 pid:17666 tgid:17665 ppid:13741  task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdb72390a7c
RSP: 002b:00007fdb731d0ec0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fdb731d0fc0 RCX: 00007fdb72390a7c
RDX: 0000000000000020 RSI: 00007fdb731d1010 RDI: 0000000000000007
RBP: 0000000000000000 R08: 00007fdb731d0f14 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000007
R13: 00007fdb731d0f68 R14: 00007fdb731d1010 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:17670 blocked for more than 145 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22760 pid:17670 tgid:17670 ppid:1      task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2824f90a7c
RSP: 002b:00007ffedef93660 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f2825ce4620 RCX: 00007f2824f90a7c
RDX: 0000000000000020 RSI: 00007f2825ce4670 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007ffedef936b4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000005
R13: 00007ffedef93708 R14: 00007f2825ce4670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:17680 blocked for more than 145 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22760 pid:17680 tgid:17680 ppid:1      task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f50ecf90a7c
RSP: 002b:00007ffcc2e16c30 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f50edce4620 RCX: 00007f50ecf90a7c
RDX: 0000000000000020 RSI: 00007f50edce4670 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007ffcc2e16c84 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000005
R13: 00007ffcc2e16cd8 R14: 00007f50edce4670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:17682 blocked for more than 145 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21296 pid:17682 tgid:17682 ppid:1      task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc4b6b90a7c
RSP: 002b:00007ffcd1b6f180 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fc4b78e4620 RCX: 00007fc4b6b90a7c
RDX: 0000000000000020 RSI: 00007fc4b78e4670 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007ffcd1b6f1d4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000005
R13: 00007ffcd1b6f228 R14: 00007fc4b78e4670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:17698 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22760 pid:17698 tgid:17698 ppid:1      task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0225b90a7c
RSP: 002b:00007ffc5f620490 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f02268e4620 RCX: 00007f0225b90a7c
RDX: 0000000000000020 RSI: 00007f02268e4670 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007ffc5f6204e4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000005
R13: 00007ffc5f620538 R14: 00007f02268e4670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:17700 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22760 pid:17700 tgid:17700 ppid:1      task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2a8d190a7c
RSP: 002b:00007ffe6f054da0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f2a8dee4620 RCX: 00007f2a8d190a7c
RDX: 0000000000000020 RSI: 00007f2a8dee4670 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007ffe6f054df4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000005
R13: 00007ffe6f054e48 R14: 00007f2a8dee4670 R15: 0000000000000000
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: 53 e7 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d f3 86 0e 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c2
RAX: 165a988fa3d66b00 RBX: ffffffff819683b8 RCX: 165a988fa3d66b00
RDX: 0000000000000001 RSI: ffffffff8be33660 RDI: ffffffff819683b8
RBP: ffffc90000197f20 R08: ffff8880b8732f9b R09: 1ffff110170e65f3
R10: dffffc0000000000 R11: ffffed10170e65f4 R12: ffffffff8fa38530
R13: 0000000000000001 R14: 0000000000000001 R15: 1ffff110039d6b40
FS:  0000000000000000(0000) GS:ffff888125d1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005590b4744fb0 CR3: 000000000df36000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x147
 </TASK>


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

