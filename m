Return-Path: <netdev+bounces-109283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E49927AE0
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 18:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B091F21C25
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61EB1B29BB;
	Thu,  4 Jul 2024 16:13:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4C1B1519
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720109602; cv=none; b=fr66Va6/92PPwIAAa0fjhN0s/da/3fsSvFhUCiT7YPgUCefP43mL7tdLvHKdJMVDufB10OvupKQp3LrI0EuXxkCGaWZ21EDNvC+NJJcONRDFdcPcDk8MQii1XB/50zuBZUB/zckQ+h9dxWAoN45gIWgCLSuPob+j0dIr+er4AGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720109602; c=relaxed/simple;
	bh=4QjYLfJVyImFUoKwKPIy+6dWdloquBbwpCeQrDug9iE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LZtIhExwQIGuUGdYU2i53P8aZEk0T7UGc0tft0kYy2eNGMICw/JFtVwxCM9tQJIld8Fsr6iOWSLC5A/bcfB5tbjYzC2xzPmZ55a4Wx/s0HqtCvSsf9iTACnt8ozmRRJZ+qwxH6ewRYG6RvvonlvikpzdOvXiFpluePEv2/a97No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3d2fd6ad6so102918539f.1
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 09:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720109600; x=1720714400;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JkLRJaVGSvxzwX/6c15AFLcSKJOZ/j1pGXRKCFDsnM=;
        b=RO/cpdrzbsIthUdwv11P3P5PMAcZ7VucX/AKIQ+jo3BJW8RcxcrXPwGvH/e5PryFaw
         Zuz0lCzd3R+6T8Yb0YL0fIj3toeUxdIvx2UbUCjtkeDJ3P9d3q/rNz2tr6kuFmx018fC
         ukDy9jYjl9GauWz7pKpR6PjZp4Cj6Ssj9gfmLEQz27TS7c4PW+klaFXvEZj0O6jdzJhP
         W7+oF9HxJFxGFZTEGQoifESciDa/pu1sxbEmkMTyvAQnJUwb9BbUFZcQejGDpI3jZnHR
         TEiYJUqCKv682+6k6cqEUSMhiN3SG9qkKnw+KFc1AN0Lpr6Jfr+QUnf5BsOaS0HOuOqQ
         duFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSs53kcMhGwOx4/4snN4Mtm+Q1y/o2Qrv1FfXZboyI1ZYou5D+D0N8jSbRvTsEOsuGUxQfL8vfExKqErpakOU+0Q35Fob2
X-Gm-Message-State: AOJu0YyQGkonZ7gh/2/DKXo35ZAk0evYukfzWpkNkgh9ywIaSuCK+Azw
	kYmU2HOLiftQJUTAUKxqLgxslrE9Gc+SrFwxQSD0i7MS+uW3X+ugyRXNgyBPYez1jnO9vekSU/R
	4pxxbcen4k5+gFdXZQdjqsvmchsu87mVFyVqpOf5zC56WQQRcoAX9e7E=
X-Google-Smtp-Source: AGHT+IGH3WghRcHc6hLYn+8f8KA9NjI0oap4Ts0XFXyvBVeIrxlY9W33UeFBWWpjKc5P61R72PcDlcy6Zjdw+LKC7ULz6BrQF8Cp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:851b:b0:4b9:ae81:23b5 with SMTP id
 8926c6da1cb9f-4bf61ad5526mr170943173.5.1720109600424; Thu, 04 Jul 2024
 09:13:20 -0700 (PDT)
Date: Thu, 04 Jul 2024 09:13:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b550fc061c6e39dc@google.com>
Subject: [syzbot] [bluetooth?] WARNING: locking bug in sco_conn_del (2)
From: syzbot <syzbot+b6f83101e2618cad8952@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    30972a4ea092 Merge branch 'ethtool-track-custom-rss-contex..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14eb0e99980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=b6f83101e2618cad8952
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/458f07c1af9a/disk-30972a4e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6eceffae70b2/vmlinux-30972a4e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a758c1301d32/bzImage-30972a4e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6f83101e2618cad8952@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 5099 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 5099 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4773 [inline]
WARNING: CPU: 1 PID: 5099 at kernel/locking/lockdep.c:232 __lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Modules linked in:
CPU: 1 PID: 5099 Comm: syz-executor Not tainted 6.10.0-rc5-syzkaller-01115-g30972a4ea092 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4773 [inline]
RIP: 0010:__lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Code: 00 00 83 3d 6e 8d 3b 0e 00 75 23 90 48 c7 c7 e0 b9 ca 8b 48 c7 c6 80 bc ca 8b e8 98 e2 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc900040a77b0 EFLAGS: 00010046
RAX: 97fa0832cfe68200 RBX: 0000000000000d48 RCX: ffff88802d3f8000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000000000000f R08: ffffffff81585802 R09: 1ffff110172a519a
R10: dffffc0000000000 R11: ffffed10172a519b R12: 0000000000000001
R13: ffff88802d3f8000 R14: 000000000000000f R15: ffff88802d3f8b78
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020bf2000 CR3: 000000007fd84000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 lock_sock_nested+0x48/0x100 net/core/sock.c:3543
 lock_sock include/net/sock.h:1607 [inline]
 sco_conn_del+0x104/0x310 net/bluetooth/sco.c:203
 hci_disconn_cfm include/net/bluetooth/hci_core.h:1985 [inline]
 hci_conn_hash_flush+0xff/0x240 net/bluetooth/hci_conn.c:2584
 hci_dev_close_sync+0x911/0xf70 net/bluetooth/hci_sync.c:5062
 hci_dev_do_close net/bluetooth/hci_core.c:556 [inline]
 hci_unregister_dev+0x1db/0x4e0 net/bluetooth/hci_core.c:2760
 vhci_release+0x83/0xd0 drivers/bluetooth/hci_vhci.c:666
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa27/0x27e0 kernel/exit.c:874
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 __do_sys_exit_group kernel/exit.c:1034 [inline]
 __se_sys_exit_group kernel/exit.c:1032 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4b3c975b99
Code: Unable to access opcode bytes at 0x7f4b3c975b6f.
RSP: 002b:00007fff7905f008 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4b3c975b99
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
RBP: 00007f4b3c9d28f0 R08: 00007fff7905cda7 R09: 000000000001fc63
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000001fc63 R14: 0000000000000000 R15: 00007fff7905f8c0
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

