Return-Path: <netdev+bounces-106580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6601916E6E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0622F1C2157B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AAC175573;
	Tue, 25 Jun 2024 16:51:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55954171084
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334287; cv=none; b=tp8dXuPUAI0YS/T4YY9etnCQLmMsnPniKVcyeZLHntfFyMjnpYlydEzZvNTT9zQmjSfqslMD7NEg0eUQHdnxJhT5kv5sqsNSQtMZ2DM2gEWxsMlXGivfbcCjA3wkdMa6m/9eCkG+Aa/Pvtfg1/e7qWs+oixyb6jB61+mg5Urn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334287; c=relaxed/simple;
	bh=hThZ+RFVoxyMkNAWVybtk0i9weWZe+dFc/kczNKAsgY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a0ZWetBwyXWdzvCT11BuSIUxVgoRFkANhvdcWFoHeWGXunej74w23/q+1le0AJWisrxuZklQGZhviC/z+Dx8Tt846XIQ2M/yaQXNZO+A2kJJjH4FHsYZVTKqL+IDAuaHrr1UDiHuGqsIP0FRKx9DKp5XU301gjPp4PRivfadzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7f3ca3c713bso43430739f.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334285; x=1719939085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHp1O3EhJGK+PrVVPs13f5sNR0z5bKZAYNSLqaK360Y=;
        b=YntoiIAon8AoANSKIzwmey7R5JLQDLwrCXTj0i4qdgJErIbdKOysObQF6ysJ4PFuVo
         ZG6VYijJHd/XakX1IwAKuUXOaSkpgBBzTXZ7qYDt1NSRFco35SX5JHOPgqdcsebHFgFs
         WFrR5IjNjemtYFeGUMeAHEcnQ6QwJuWmK963z9F1bcPHv2s1G1Sga6urQSbWn5kIT1mg
         REQEE+Bvhr6flYjpakPZEkLS/P+QuTyN+Jm+IPtng40HCSS+PJfnl4Cig0NoZvwyFtnk
         cJ6wUYqxdQPKDCH8Opm/w+6EBueDteYcAp3muzjv4UtLqk2B41B3uh/Sk/aLHiKDtjwC
         zL+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXN+xVdXoCUZ476sdWC9xt2BHkbdLbodZDo3PqYSe5mGCKakWlAowkFZEVg3Xbhur95DsIh3efZG8WvxNi1gy85LiPv8L9a
X-Gm-Message-State: AOJu0YzIwSJThaxrN0MN47eNP6lwd+htZU//+vluyruYbvakY+lXlxQI
	LeaRxKG30jQHv8n+Fw3xndAbcqyiajg/CCj0c3sJoSeCZxfv4qgqaypZMEo6iiIhL0s8+nOal1J
	tWL8iFjHn6nyIoBFHhaalQk0vFub1mNWleZNccPNvyFugJ1ZxAvW1b4M=
X-Google-Smtp-Source: AGHT+IHDcP8UX2acLFsuANl6yO/jrKXIJSn8sTiT6O6QnF0dGobBcO5EgvtPSO0sbrjKE/eWKdta/fVSm1+blyULvAqcPkLzuOes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8b13:b0:4b9:ace4:3504 with SMTP id
 8926c6da1cb9f-4b9efc41ad0mr304400173.4.1719334285541; Tue, 25 Jun 2024
 09:51:25 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:51:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000571681061bb9b5ad@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in bpf_lwt_seg6_adjust_srh
From: syzbot <syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	dsahern@kernel.org, eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bf2468f9afba Merge branch 'locking-introduce-nested-bh-loc..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13cb0aea980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=608a2acde8c5a101d07d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12eaa3ea980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15eff72e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3b564f7e07c/disk-bf2468f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd47135279ed/vmlinux-bf2468f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ccb81d174cf6/bzImage-bf2468f9.xz

The issue was bisected to:

commit d1542d4ae4dfdc47c9b3205ebe849ed23af213dd
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Jun 20 13:22:02 2024 +0000

    seg6: Use nested-BH locking for seg6_bpf_srh_states.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10311e2a980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12311e2a980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14311e2a980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com
Fixes: d1542d4ae4df ("seg6: Use nested-BH locking for seg6_bpf_srh_states.")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5091 at net/core/filter.c:6579 ____bpf_lwt_seg6_adjust_srh net/core/filter.c:6579 [inline]
WARNING: CPU: 0 PID: 5091 at net/core/filter.c:6579 bpf_lwt_seg6_adjust_srh+0x877/0xb30 net/core/filter.c:6568
Modules linked in:
CPU: 0 PID: 5091 Comm: syz-executor570 Not tainted 6.10.0-rc4-syzkaller-00891-gbf2468f9afba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:____bpf_lwt_seg6_adjust_srh net/core/filter.c:6579 [inline]
RIP: 0010:bpf_lwt_seg6_adjust_srh+0x877/0xb30 net/core/filter.c:6568
Code: bf 80 33 f8 eb 05 e8 b8 80 33 f8 48 c7 c0 f2 ff ff ff e9 d1 fc ff ff e8 a7 80 33 f8 48 63 c3 e9 c4 fc ff ff e8 9a 80 33 f8 90 <0f> 0b 90 4d 85 f6 0f 85 0e f9 ff ff e9 46 fa ff ff e8 83 80 33 f8
RSP: 0018:ffffc900034a77a0 EFLAGS: 00010293
RAX: ffffffff8962a486 RBX: 0000000000000000 RCX: ffff888017fdda00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900034a78d8 R08: ffffffff89629d8b R09: 1ffffffff1f5b52d
R10: dffffc0000000000 R11: ffffffffa00007d0 R12: 0000000000000000
R13: ffff8880b943d060 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055555b006380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564def260000 CR3: 00000000775ec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_2088341bddeddc1d+0x40/0x42
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 bpf_test_run+0x4f0/0xa90 net/bpf/test_run.c:432
 bpf_prog_test_run_skb+0xafa/0x13b0 net/bpf/test_run.c:1081
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4313
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5728
 __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5815
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f541c355529
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca122c488 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffca122c658 RCX: 00007f541c355529
RDX: 0000000000000050 RSI: 00000000200002c0 RDI: 000000000000000a
RBP: 00007f541c3c8610 R08: 0000000000000000 R09: 00007ffca122c658
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffca122c648 R14: 0000000000000001 R15: 0000000000000001
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

