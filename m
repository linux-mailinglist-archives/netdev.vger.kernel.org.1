Return-Path: <netdev+bounces-247219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E69CF5F25
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 00:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D98B300BFA1
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 23:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B54F2D3ECF;
	Mon,  5 Jan 2026 23:13:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7563A1E6D
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767654807; cv=none; b=faIrHYxi+98OlhSw1gEICf+hfSYDMSHhqG/wBDpAfa6ya9LuF6lggE/AoJfLVWW9qWzbHakyhZBZipQD0hiEv3r+U+rrEBLZqJ/4XYxvf0h0PJCezcraNj2UMQloFPGlaciy7F9Lp00MKXIR6qsuq4xB/WDs1JKfkp5J+T8TL74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767654807; c=relaxed/simple;
	bh=6M6Ords2iBMktIWzFvHth89TMT9gBF/9t6DtdXzp3TE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LflxiPfJP2bsSK1gU+e4N4uVSFaHx4JSILsE20HyC5+XM9VWO2Xc5StWgI1IQdqdVp6Dyc3omIosKe8IwBKiRmI/vF4qPnYwoV4PuNgS54TthFa3ALWbkbW74vV+Oy44jdx9FswInW6Ry+Ta7HW/hohomyJb4docn2AgwGdNUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-455ecc3689aso797806b6e.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 15:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767654804; x=1768259604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWq7HAirp8i7+S9f/l8O6fkkjpH0ekGDQYByySXDfOU=;
        b=FZUbWQdBrLLuq31hprLuS0EbMT2ZPwsQsahKR/guCQsdtGg5AuBXw30PYML2USJCtn
         ApBr5jqZhGRgSzQAuQ3h1QBqryyrdqkKNLJEr1xTIrlBEKdTyNyp9XHZfUohvLxGchs1
         ZmLOPT7ZH19b1mCcHn49B7O/1PyOJCxobWJW01ScWkN64wvy1mw0S8NUtLvKPuV4gXYu
         DkZjrOPoEpHFQVIyv9CPto99V2b+S46B2HSsiZhlbsmkg3HZgRM6Fwt17IiCasy+9B3O
         3d3dTXE/7ogz54skuiXV9YMaSTvZl5yzoOFIj4mMutJ4N3wL2aVvzjXXXCstfL8Y47cF
         nmXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd9t+SczrD6reoZ6Gn3eNPd+Wa1et6i0oKnwvaTXjfW84+VWr8MoBCE5MPmi6scqfouYASdJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxGGXbkoZHpBFWeu0HRxHicH26tCbm9HAPbE5jDD4X14pS9Cu
	lXlqQ6mERI858F8AensAENwcppeLU3t7pXW1v0H34zq7QDYo3gbtaZvUJgh85QF9K17z+bAC7ME
	kv+/dyOgbSDUs6lVKXugvj+prJ3K9aHe332ePMi5F4CP1TEe6ru4/QVCW92c=
X-Google-Smtp-Source: AGHT+IHaJZBYo4KstYwCd+SdHH13Y+EoW0OtcEn4HscFu9YplZzTv6kedyHmMDO4GAOzksmhM5x45ghRXDOJbBrOD05YK4c016zS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c91:b0:65b:2a2c:2601 with SMTP id
 006d021491bc7-65f47a69f79mr590246eaf.61.1767654804693; Mon, 05 Jan 2026
 15:13:24 -0800 (PST)
Date: Mon, 05 Jan 2026 15:13:24 -0800
In-Reply-To: <0000000000002ad5ee05e03568f4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695c4594.050a0220.318c5c.0133.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task can't die in vlan_ioctl_handler
From: syzbot <syzbot+6db61674290152a463a0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	keescook@chromium.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	william.xuanziyang@huawei.com, zhudi21@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c303e8b86d9d dt-bindings: net: mscc-miim: add microchip,la..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a4ae9a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=6db61674290152a463a0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13795efc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fab8b6d30f06/disk-c303e8b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/362169306abb/vmlinux-c303e8b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd793d32e1aa/bzImage-c303e8b8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6db61674290152a463a0@syzkaller.appspotmail.com

INFO: task dhcpcd:5493 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:25208 pid:5493  tgid:5493  ppid:1      task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x149b/0x4fd0 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 vlan_ioctl_handler+0xd0/0x650 net/8021q/vlan.c:579
 sock_ioctl+0x610/0x790 net/socket.c:1339
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcf8811e378
RSP: 002b:00007ffdc6aa60d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00005605e1c82ba0 RCX: 00007fcf8811e378
RDX: 00007ffdc6aa60e0 RSI: 0000000000008982 RDI: 000000000000000f
RBP: 00007ffdc6aa60e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00005605e1ddbd40 R14: 00007ffdc6aa6b30 R15: 00005605e1c82ba0
 </TASK>
INFO: task kworker/u8:16:6446 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:16   state:D stack:25336 pid:6446  tgid:6446  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x149b/0x4fd0 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 addrconf_dad_work+0x112/0x14b0 net/ipv6/addrconf.c:4194
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
INFO: task syz-executor:6457 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22392 pid:6457  tgid:6457  ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x149b/0x4fd0 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 new_device_store+0x12c/0x6f0 drivers/net/netdevsim/bus.c:184


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

