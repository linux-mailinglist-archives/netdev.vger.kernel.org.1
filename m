Return-Path: <netdev+bounces-121006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F1095B649
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D5428149D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879426AC1;
	Thu, 22 Aug 2024 13:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183771C9EC4
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332769; cv=none; b=hnITTM8jhTi+BJeiMB/pI2Z69fcFeI6jiN8jEBwI5TO6eqZhvijmkWLAdSd06NvagH2gyc6W4YNSVc3bOAxx8fl8aw51fs4ecUVt9BgVXSSG3jpHgm5q+YCsiwFM6vNCwvOKmsYolNQ/ZH/L67vFUT+WWEAut16YYH+MbUJfd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332769; c=relaxed/simple;
	bh=D9cK9uxNc2DTmMy1nRI557QSzFuh3VCn2aBMNFQhG2s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=beVGXdrFWfMWbwqARxzR5nSxu0TxwxDRYgWjINy0vOSC6IXDq6llJ4MjD90RSo2yb9SoWqUzQN8lrzv+70sYqhOSFHfv0jn3tvCZlVqeA0KGbrDvNbPuWaDtJcky+ge3HDZKFb4P7bGazRiyewxFqYeVNPTbJlVIsx6s6U040uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d2ceca837so9303165ab.2
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 06:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724332767; x=1724937567;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OiweJPU3v8cK3ex6a+klsO0dVK70QTWG1SHf6umFjdQ=;
        b=RfGHG0QqCns3hkTtw/0xAhiS3Rg1SS4TlQBKqfxTcDvPMvXqC0wGW12D/9/YoPs0Am
         FWmjdIVBjVOKvLCMw2mP6THktAHFQSlOcoG2yAQ4rXw+R3mPDiuYe648nVH25yqWIOdq
         Wb2uYVmbWKmxE1VvwyZViwVJK/dm9yRf3CQWo94OC3Wz/WZZebpoPNnMw6eIEykW+vJg
         Vud3KNez9KLY1OvlstGpTqvmWc9NswnpC47+0wsz3mTEAVr6CaQQHk6GVHrXt1BbnBM4
         79S872NxNN/S/4ebiwDEheSBx60JdGgXYYF4qJbk7ocKy1thtdgU5XML8aueC2ylmLNH
         dJZA==
X-Forwarded-Encrypted: i=1; AJvYcCUjugO3a7KcfwhA4Ajt7Xhex0JLyBTfqH0RZaPNntCbI2SNAp5bgh3blDod64h/jMRUJaVrN74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXVONt4opCvhdgi9pyJCl8u5uZ9gWrX6FjJsl8IgbWBP2Rw7E
	x+hqJwzaBbnzqJs/Nx8TSGr1UpeBRDhhmMF62YysxsGTq3ebHvZFlW4Tcob8lLEPFuoyzQsN9TS
	K8CKTlrSU7e6OG1EKT3t88G76Y8pf6JV1B1lRsBCc0vgEJYsrS9DRPl0=
X-Google-Smtp-Source: AGHT+IE3lFUcUO93ZsOVuNmmaL3DvmvZ4QiZ6RcvZDG7fyA03QgA475t8D+4JtyKFOVE3KZkO/7fktBrZ7PfvAJNtVkGtfZQMxzr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:396:ec3b:df63 with SMTP id
 e9e14a558f8ab-39d6c3c7f86mr3171705ab.4.1724332767278; Thu, 22 Aug 2024
 06:19:27 -0700 (PDT)
Date: Thu, 22 Aug 2024 06:19:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001187a706204582bb@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in sock_map_close (2)
From: syzbot <syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, jchapman@katalix.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d785ed945de6 net: wwan: t7xx: PCIe reset rescan
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d43b05980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=8dbe3133b840c470da0e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13621239980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12378c33980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9b04b4f2471c/disk-d785ed94.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2db64580639d/vmlinux-d785ed94.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04e43f8b9f9b/bzImage-d785ed94.xz

The issue was bisected to:

commit 4a4cd70369f162f819b7855b0eabcb2db21f01f4
Author: James Chapman <jchapman@katalix.com>
Date:   Mon Jul 29 15:38:04 2024 +0000

    l2tp: don't set sk_user_data in tunnel socket

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157a0791980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=177a0791980000
console output: https://syzkaller.appspot.com/x/log.txt?x=137a0791980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com
Fixes: 4a4cd70369f1 ("l2tp: don't set sk_user_data in tunnel socket")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5225 at net/core/sock_map.c:1699 sock_map_close+0x399/0x3d0 net/core/sock_map.c:1699
Modules linked in:
CPU: 0 UID: 0 PID: 5225 Comm: syz-executor110 Not tainted 6.11.0-rc3-syzkaller-00508-gd785ed945de6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:sock_map_close+0x399/0x3d0 net/core/sock_map.c:1699
Code: 48 89 df e8 e9 a3 5a f8 4c 8b 23 eb 05 e8 8f 5e f3 f7 e8 ba ea ff ff 4c 89 ef e8 82 e1 da ff e9 47 ff ff ff e8 78 5e f3 f7 90 <0f> 0b 90 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc900035b7b10 EFLAGS: 00010293
RAX: ffffffff89a02af8 RBX: ffffffff95312d30 RCX: ffff88802424da00
RDX: 0000000000000000 RSI: ffffffff8c0ad560 RDI: ffffffff8c606900
RBP: 0000000000000000 R08: ffffffff937328e7 R09: 1ffffffff26e651c
R10: dffffc0000000000 R11: fffffbfff26e651d R12: ffffffff89a02760
R13: ffff88802fc0a800 R14: dffffc0000000000 R15: ffffffff89a02791
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff975386110 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:882
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff97530ad09
Code: Unable to access opcode bytes at 0x7ff97530acdf.
RSP: 002b:00007ffc8457e748 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff97530ad09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007ff9753852b0 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007ff9753852b0
R13: 0000000000000000 R14: 00007ff975385d00 R15: 00007ff9752dbf60
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

