Return-Path: <netdev+bounces-197560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46216AD9308
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D6316728F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF6622A4E4;
	Fri, 13 Jun 2025 16:44:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D5223DCC
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833080; cv=none; b=qXb51iEZWJfKDVFBLYK/Jh80ttFrslxlttxw+A1u0C/35Oj/AJjGbyqVzE6zGle8sF4o5wpsCkhmxgTRvVqGE+LzEf9QyJ9/vYXqoeNk6QJh2eyRRtHBtzMMFvcP+ACBglnnk0Mk7eaXwDhleNGeVS0f/y6pZH2+H30SWfk0p8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833080; c=relaxed/simple;
	bh=r7qQKEx8Bs/vEO2/ZvJIvxTm3r9PYSaliMfR9QFkUaM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IpA0T0GYfMRw/0sLE3eoizV8RLqYFB/M0js6XU22C44d3Lvw0OijKBbIhqhjzyXdCbkuMAmWLi+Qg3awT/QJxejmetDA57qlwwG8MUZVT0cn95ShOYFg6rAJxTbES5tsv8yHGYDERU/VWnxZK1AdlgtKWvcohbQQ8sQkRkgKLHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86cff1087deso526356139f.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 09:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749833077; x=1750437877;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUWyrXZ9+k7DvMBTzMjpAiIqdpXMDVWGB3TGXjg/3go=;
        b=leV7rm+sQ+IN1XW5fEPcpoxo0lzk3y+imGgr7U8vHoOSi/SJrkB+tRxuHOvBD7+KmE
         0FUGFPO7SHPHsvt/H6zfInRe9MatoQlvYIX8djeVFyY61I6+xLE3mX+J9eGGGdByGDzt
         H+gePPSNPytz3+IO6kwN89EI/P6jBx1o7GOeVPOXv7DiXVaPTWVVjb04HfIgMCG6mv7o
         3TiA1msjilSUjmYv2/ICbe5WQblNPOpcW9qLipbCA83yNtBRfir3JZ7s5UlcECnmKDWM
         L5NX7EmsNR7Q2mK0aksnxhQUftfDusPcHKSRbWi9hQ/3DZ3dZoECzUmT2S/+FwH/Thz0
         7wkg==
X-Forwarded-Encrypted: i=1; AJvYcCUcujaITUzk/sbmiJegj7YqAdwgNZH3POW9miNMbIx8D6uty01yJ19ywQY7j81qRdzUwUCUSsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBJwdd/enw3x4OCstJjXKX8yoIX7d8d/PhXzVhMU5fxa6RvX9
	ZWRS460TO4DzU7sPaICzzI0Yqr7UkYnVafFUYL9XwNONJtuyYlWSC467hKuEzn1qugjIDdxulnz
	+8i0TCIBuMj9qYx6VK/qmVyOcGiPD36Qy2nvzpXaddmOow0xZF9ie4TJJ3cI=
X-Google-Smtp-Source: AGHT+IHl+6VE44ikwCAKlGs96ipfefRKXfSHqUgXZOAH9TRgJUJDCMsI+1/7pKEAgZuqSGYv2WPtsLjL01zPUrG3djAxbGRHR6GR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2583:b0:3dd:edef:894c with SMTP id
 e9e14a558f8ab-3de07cc0d80mr4157355ab.14.1749833077617; Fri, 13 Jun 2025
 09:44:37 -0700 (PDT)
Date: Fri, 13 Jun 2025 09:44:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684c5575.a00a0220.279073.0013.GAE@google.com>
Subject: [syzbot] [net?] WARNING in taprio_get_start_time (2)
From: syzbot <syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b549faa950e6 Merge branch 'net-bcmasp-add-support-for-gro'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1003d10c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c07f08ee4bcfb276
dashboard link: https://syzkaller.appspot.com/bug?extid=398e1ee4ca2cac05fddb
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f82898e05e9/disk-b549faa9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df2850948ac5/vmlinux-b549faa9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d4c1db8f02d/bzImage-b549faa9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 11372 at net/sched/sch_taprio.c:1223 taprio_get_start_time+0x15e/0x190 net/sched/sch_taprio.c:1223
Modules linked in:
CPU: 1 UID: 0 PID: 11372 Comm: syz.0.1394 Not tainted 6.16.0-rc1-syzkaller-00189-gb549faa950e6 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:taprio_get_start_time+0x15e/0x190 net/sched/sch_taprio.c:1223
Code: 42 80 3c 28 00 74 08 48 89 df e8 5d bd 9d f8 4c 89 23 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d e9 99 ef e2 01 cc e8 e3 44 3a f8 90 <0f> 0b 90 b8 f2 ff ff ff eb e0 44 89 e9 80 e1 07 80 c1 03 38 c1 0f
RSP: 0018:ffffc9000478eee8 EFLAGS: 00010287
RAX: ffffffff89861a0d RBX: ffffc9000478efd8 RCX: 0000000000080000
RDX: ffffc9000f4da000 RSI: 0000000000000c35 RDI: 0000000000000c36
RBP: 0000000000000000 R08: ffffffff8fa10ef7 R09: 1ffffffff1f421de
R10: dffffc0000000000 R11: ffffffff81679c10 R12: 184898a57a6335ad
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f0656dd56c0(0000) GS:ffff888125d52000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000010000 CR3: 000000006029c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 taprio_change+0x2da5/0x3f60 net/sched/sch_taprio.c:1938
 taprio_init+0x959/0xbd0 net/sched/sch_taprio.c:2112
 qdisc_create+0x7ac/0xea0 net/sched/sch_api.c:1333
 __tc_modify_qdisc net/sched/sch_api.c:1758 [inline]
 tc_modify_qdisc+0x1426/0x2010 net/sched/sch_api.c:1822
 rtnetlink_rcv_msg+0x779/0xb70 net/core/rtnetlink.c:6953
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0658f8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0656dd5038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f06591b6160 RCX: 00007f0658f8e929
RDX: 0000000000000000 RSI: 00002000000007c0 RDI: 000000000000000e
RBP: 00007f0659010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f06591b6160 R15: 00007ffc8579ea48
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

