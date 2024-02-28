Return-Path: <netdev+bounces-75557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50FC86A7AF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 05:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D922891A3
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 04:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1820DC4;
	Wed, 28 Feb 2024 04:53:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002320323
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 04:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709095998; cv=none; b=Apq9iNomxMQg/xat8TprHRbuxddmTCcB0icSma7ihH8NaNhKwnbhmq/Vo3GcXvAwO6mu0pWM/JPy3vqbVAPYX1a1zCtfbWniXNXeh++moFfIUN4wvkXp+tUlyZG38/dY0QY2tUnxgJSWYNEPq3irv15J15ClHOjRgz2e3KymJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709095998; c=relaxed/simple;
	bh=wZmkdZbXJo1h2ax0tDtCwbt9EHwto6bbJWngD1zBDe0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kkwZTVB2tLK5Pl8mlxtoJhFNuDuVNiL5L8QO0ti5PXxtVL0zvuP14e7uQ8H8AcT4BrdgkGfl80LGw1CTjLwPKE6f3ZAVSbl6D+7PhsPEiGkhsaVXmE9kiiFi21umQARlZYqzpNL/I5mqa8VcprxErExPDVBiwld08nZdkp6M4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365067c1349so43325125ab.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 20:53:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709095996; x=1709700796;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLp1bsry9uAqXzf4BDbA5DbOjqtNpJoqrZgoXxy1hjA=;
        b=VCDTQ6vNwyQx4myF+l0Wjd40e0mAs2grd8WB0/tMoAAwMZy+OJHY9OK0gZaCDyVppM
         tdVS64fyenQN5xkn7KY8SOEO98QmsJZUIKs0joTfBGLUEKYiQNZBsUmPqYGT6J+YWkon
         dTnsbfjPg7mWEwG0UKJ78o+eSYuPfyU4pm+PxGIV3Z4148PRmTuNCwdICevh/wJbqsFI
         hmNr9Wj99Nl9f+geRy6I5akW8Zchd6M/A9AVUdghzedTB2xogjvznYn+SEsaTYujEP9s
         tclfhljPdQKdJsmByQKnlRICzb5BH+rqmAxRruDems0BPcbRRyK1QvdHi7Jr8hcEduGR
         G6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH85m1oG6xDfWtycrkYKlwRvDsfEyvISlP3piJWPF/dKvcusNu6E6uo25bOSsfMkfXcWtlWiw+d5g6CPTWbWArYczGAN2x
X-Gm-Message-State: AOJu0YyWY8Qawwb8mysTlpQtmBuEwp+o6gvJ+3dzVdgwBeTkw5LZqtR+
	yUT3u9DffLGAs/n946qAvgYTDg9USrOJjxLiqOvLdgE5EYCqkelPQzmwkn/+c4C4cDh15RAI3OS
	AhrWooBT8PhYv5/VBT4XV5oIyuES54wTjJ2jZhvVYORZGeEXdG8yl7Fw=
X-Google-Smtp-Source: AGHT+IFKtGl7Hrq3wGX5AY1HvUoLSLPZ95MyV08N+LxrKQn3KHztGVxS791I4R0OlCFYcsJAIYR5hY09FiCWWVY9XWIsmPkPw0Mc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:365:424a:73db with SMTP id
 a8-20020a056e02180800b00365424a73dbmr848046ilv.4.1709095996307; Tue, 27 Feb
 2024 20:53:16 -0800 (PST)
Date: Tue, 27 Feb 2024 20:53:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf4687061269eb1b@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_conn_del
From: syzbot <syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, william.xuanziyang@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    603c04e27c3e Merge tag 'parisc-for-6.8-rc6' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12d065aa180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
dashboard link: https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17960122180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d70222180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ffe1f52b2e32/disk-603c04e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76775e0b335d/vmlinux-603c04e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8cd3c1c87eef/bzImage-603c04e2.xz

The issue was bisected to:

commit 181a42edddf51d5d9697ecdf365d72ebeab5afb0
Author: Ziyang Xuan <william.xuanziyang@huawei.com>
Date:   Wed Oct 11 09:57:31 2023 +0000

    Bluetooth: Make handle of hci_conn be unique

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1357945c180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10d7945c180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1757945c180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")

------------[ cut here ]------------
ida_free called for id=8192 which is not allocated.
WARNING: CPU: 1 PID: 5074 at lib/idr.c:525 ida_free+0x370/0x420 lib/idr.c:525
Modules linked in:
CPU: 1 PID: 5074 Comm: syz-executor104 Not tainted 6.8.0-rc5-syzkaller-00278-g603c04e27c3e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:ida_free+0x370/0x420 lib/idr.c:525
Code: 10 42 80 3c 28 00 74 05 e8 8d 4b 9b f6 48 8b 7c 24 40 4c 89 fe e8 a0 89 17 00 90 48 c7 c7 80 cd c5 8c 89 de e8 21 32 fd f5 90 <0f> 0b 90 90 eb 3d e8 45 27 39 f6 49 bd 00 00 00 00 00 fc ff df 4d
RSP: 0018:ffffc900039ef920 EFLAGS: 00010246
RAX: 59cbf4b1e8f11a00 RBX: 0000000000002000 RCX: ffff88802da20000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900039efa18 R08: ffffffff81577ab2 R09: 1ffff110172a51a2
R10: dffffc0000000000 R11: ffffed10172a51a3 R12: ffffc900039ef960
R13: dffffc0000000000 R14: ffff88801e3ec0a0 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78fc079f08 CR3: 000000002db8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hci_conn_cleanup net/bluetooth/hci_conn.c:157 [inline]
 hci_conn_del+0x7c0/0xcb0 net/bluetooth/hci_conn.c:1188
 hci_conn_hash_flush+0x18e/0x240 net/bluetooth/hci_conn.c:2646
 hci_dev_close_sync+0x9ab/0xff0 net/bluetooth/hci_sync.c:4954
 hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
 hci_unregister_dev+0x1e3/0x4e0 net/bluetooth/hci_core.c:2739
 vhci_release+0x83/0xd0 drivers/bluetooth/hci_vhci.c:674
 __fput+0x429/0x8a0 fs/file_table.c:376
 task_work_run+0x24e/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa2c/0x2740 kernel/exit.c:871
 do_group_exit+0x206/0x2c0 kernel/exit.c:1020
 __do_sys_exit_group kernel/exit.c:1031 [inline]
 __se_sys_exit_group kernel/exit.c:1029 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1029
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f78fc021449
Code: Unable to access opcode bytes at 0x7f78fc02141f.
RSP: 002b:00007ffd8ebe2238 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f78fc021449
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007f78fc0ad2b0 R08: ffffffffffffffb0 R09: 000000ff00ff4650
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f78fc0ad2b0
R13: 0000000000000000 R14: 00007f78fc0add00 R15: 00007f78fbfef4e0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

