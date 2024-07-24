Return-Path: <netdev+bounces-112766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD22393B18E
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FAAAB23847
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3879A158D78;
	Wed, 24 Jul 2024 13:25:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B015688F
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827524; cv=none; b=l1m5VoGLWFIRd83H9YZj01q1b6KGCino1fWHQ2ykcDSTLFhOQbYiBgKAd/5YmyAASTP4pVn8IS1nJqI8HhCMYpL4KkJvtsnR3SImG9yrNcGa9oKwPL6clZnR/CWMTEEFZuPxKXitCVtT0KWQi1om0x6KHuf09XB9BOzAuLDNc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827524; c=relaxed/simple;
	bh=226Pu+LdubcWGNuYRcAyscL3L7yuYh9PPJchhM8cxHY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j17PK///ZQvRz/jn/Xnlsr4Z+R7NP/m704dz57E9O7AuDPg37OfHtWBZT/yVWYV1YHJkof/n1D7tDA0dcJiMH/A/K8vaD1ses5mjD3TM5a+2NvY6GtkvG4YP2vFI5YUdVNIHtsDKBJqk56jGsuOB0eZkKUE4/DeFE5NbQKU2CL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8179585c68cso1133326139f.2
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 06:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721827522; x=1722432322;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8aJyBqmGjbh6hqusD0fxX8YC/ZQTHXXXfgBMyi26+uw=;
        b=bNsmUpkDeRlLOnMxnuwjxcuB3LLfpCVIi/4PbsSSN8a2rZpE176JTXV4u9eSyCy/FR
         iqbBdvQBrASUcM6rBE/2G8tCWUMtg3z9QxRKjhp7TL12o3ZtsGsoQ9a5xtpah7rIzv8l
         3VBmXvuWJwIJjmWQCwf6NUS7bu8IYWfGwwf9vWANb+zquPKHp8cMQyTXPx3OWWgGa5JW
         iJBB0WGgnMyxTAp6xBHkvv52+0e4y0LuALBPepwkA2B1GCAlhDIE19vAbm8Y8oyIeCfk
         V3CuHzQoa+E7bGJrZE2Vj0WLI02dPHDV5chipV+wKtLcofBduywNozwpVr1bilmyrG1u
         Y59g==
X-Forwarded-Encrypted: i=1; AJvYcCX6VZebm/d8qyQJGuUCILAIA7stiP9eszPJGo1YTDcc7jlX/MlZULQFHfX+Q2hwewJluJwL2XCHbN4ORZxX/DQemHCVbQ++
X-Gm-Message-State: AOJu0YweFm5YdqzFpX3mVqXSogWRsrLjWjhaw1On9sA2GuK5ZqAgWKnK
	N3klryxeBynG5htlP6Z6wT+IPGCScX2sCUxp0Ok3jGubetYiugMtAxEIblYc/xjGr3wHU5b2QsI
	QGVOdIEwNYVIRtE5SZW/wzrJmFs7Csl0IsWTGWe01XDzv2bpreAL2xY8=
X-Google-Smtp-Source: AGHT+IHVJhxFIMXgDWD/IqpwHOvjeHvWzcgPZ0uFKP2cpcs8NmjpajBKF/ecqh+NCT7tZMr96gr7t/YTYLhmeLal46Y2EtiEWReo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8507:b0:4b7:c9b5:6765 with SMTP id
 8926c6da1cb9f-4c28a4de736mr211626173.5.1721827521811; Wed, 24 Jul 2024
 06:25:21 -0700 (PDT)
Date: Wed, 24 Jul 2024 06:25:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd69c7061dfe35d2@google.com>
Subject: [syzbot] [bluetooth?] WARNING: ODEBUG bug in hci_release_dev (2)
From: syzbot <syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7e78951a8b8 Merge tag 'net-6.11-rc0' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=105a2f31980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d1cf7c29e32ce12
dashboard link: https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c208b51873e/disk-d7e78951.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/adec146cf41c/vmlinux-d7e78951.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52f09b8f7356/bzImage-d7e78951.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888042b68978 object type: timer_list hint: hci_cmd_timeout+0x0/0x1e0
WARNING: CPU: 0 PID: 12907 at lib/debugobjects.c:518 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:515
Modules linked in:
CPU: 0 PID: 12907 Comm: syz-executor Not tainted 6.10.0-syzkaller-09703-gd7e78951a8b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:515
Code: e8 1b 7f 42 fd 4c 8b 0b 48 c7 c7 c0 72 20 8c 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 db 5b 9e fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 fc 35 f8 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc9000e6bf838 EFLAGS: 00010282
RAX: da48afca993a8400 RBX: ffffffff8bccb720 RCX: ffff888030a8da00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8c207440 R08: ffffffff815565a2 R09: fffffbfff1c39f60
R10: dffffc0000000000 R11: fffffbfff1c39f60 R12: 0000000000000000
R13: ffffffff8c207358 R14: dffffc0000000000 R15: ffff888042b68978
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0d8f907a6c CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:990 [inline]
 debug_check_no_obj_freed+0x45b/0x580 lib/debugobjects.c:1020
 slab_free_hook mm/slub.c:2202 [inline]
 slab_free mm/slub.c:4464 [inline]
 kfree+0x10f/0x360 mm/slub.c:4585
 hci_release_dev+0x1525/0x16b0 net/bluetooth/hci_core.c:2760
 bt_host_release+0x83/0x90 net/bluetooth/hci_sysfs.c:94
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 vhci_release+0x8b/0xd0 drivers/bluetooth/hci_vhci.c:667
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:222
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:877
 do_group_exit+0x207/0x2c0 kernel/exit.c:1026
 __do_sys_exit_group kernel/exit.c:1037 [inline]
 __se_sys_exit_group kernel/exit.c:1035 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1035
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbfd8775b59
Code: Unable to access opcode bytes at 0x7fbfd8775b2f.
RSP: 002b:00007ffda750f638 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fbfd87e4a82 RCX: 00007fbfd8775b59
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
RBP: 00007fbfd87e4a94 R08: 00007ffda750d3d7 R09: 0000000000000bb8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
R13: 0000000000000bb8 R14: 000000000003e8dd R15: 000000000003e8ae
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

