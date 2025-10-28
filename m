Return-Path: <netdev+bounces-233419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B14DC12D06
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2BB84E82B1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404827B4E1;
	Tue, 28 Oct 2025 03:53:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEFB23ABA7
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623606; cv=none; b=etluQU7Y6hafzCd/tGObzpl0bAU46JHHQzi7t77oJFRkPo6biOSCY/sSokBvLK2+LUTEs+rIa2MrifCL9UscgV2UZdCDJY6mnJnTO4MEe+ljFkV3R2FjpsnxYQM0NRU+i7L/19rbfbbQd4ui97KB5izEvGmZQXU4z61KUffLadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623606; c=relaxed/simple;
	bh=BGfKneCMUyS4oSUG29yQM/57sQqS2wDe1Jj2Du9unS4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=acLDkugAqQ7dt0h+wdo6VpfpLkgymet1y+1oUfw4r6l8ptL1Tov4NtL8X9tT/2QFDSBc7x0oxOlOxofVI79fq4pHcG0jM85aeoWEoWZwA5xQscosCpZFl9dDtjlNx8QXdIFfNbSs7jMI0PBLwvqNHIZGzUMaKKCkJhau5YRxSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430c3232caeso68991175ab.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761623604; x=1762228404;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPF9uA0SkPbYWc15E/dLkMTWGNrtspthe0FjK2GIA/U=;
        b=cDpFRVZltYesSHHIxBmTh+prxVhbtWud+GlrLEcdwFl3NN/W0rmz4eXuJKvT7loPDL
         wFt7np6uA+KAa/YEnSGlmVZG4MSlaQPjkW7xKN7cSyfs3f7PsFRk/yCqslXr+jBhHzta
         SSkgKYXD1Yv7iL1p0ZiZ4qgQT0D5N1s7rHhJEGl6GLuMPZDecFV1jXQxfQ5VxAm1zEl7
         8FKzTbXsHzfdJ268HMvccSoxqG18+EjZ+nl+0IPMd2fTc2MS9iLabyLBlN/Cx1A5fXiZ
         jo6KMdHlfqEj6nzpkoZg35jvexJhTRtsfqObfyPqFTzBgInWe3j+/pycTmJHTRW6KOZ/
         nUlA==
X-Forwarded-Encrypted: i=1; AJvYcCXHrwdvBb/3adXjU3Q55d8DWqWCT90BH2Xq6h+DsG0t5YhWv615lYyVPeS2RVEktR68GP2oSmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjtZNjIuOhU6e8ueU7RuXp9YJlG4/88YAZrYr8+Ho4C/niXWv
	54zQRyrAO75Ixfar5vfUm/wU+er2EV9xpe0n/BChXT3F7Z5PdBcdmXY8OXq1XkKvbN3wajiIFnz
	r3+0W2rqP2h5lT9o4NxIvw+SsYGBA7RK8IsvGKHFU7Cn27fZCTcOzF8eVuLk=
X-Google-Smtp-Source: AGHT+IHOfTBfpyh97DuEFlCqdSRzNFAHSF3NNN9UxyM4rTuGy6a9+beHYa6z39G7USXhLbHXE1LgVyp+Zqbv17OvnSzYtTrwxzuJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2486:b0:42d:8b1c:5710 with SMTP id
 e9e14a558f8ab-4320f5fd34emr34927815ab.0.1761623603945; Mon, 27 Oct 2025
 20:53:23 -0700 (PDT)
Date: Mon, 27 Oct 2025 20:53:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69003e33.050a0220.32483.00e8.GAE@google.com>
Subject: [syzbot] [net?] WARNING in tcf_classify
From: syzbot <syzbot+87e1289a044fcd0c5f62@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dcb6fa37fd7b Linux 6.18-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1415a932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=87e1289a044fcd0c5f62
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/512513745f50/disk-dcb6fa37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3e1641b051d/vmlinux-dcb6fa37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fc4d570f537/bzImage-dcb6fa37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87e1289a044fcd0c5f62@syzkaller.appspotmail.com

RBP: 00007f20739f6090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f20759e6038 R14: 00007f20759e5fa0 R15: 00007f2075b0fa28
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 31392 at net/sched/cls_api.c:1869 tcf_classify+0xfd7/0x1140 net/sched/cls_api.c:1869
Modules linked in:
CPU: 0 UID: 0 PID: 31392 Comm: syz.8.7081 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:tcf_classify+0xfd7/0x1140 net/sched/cls_api.c:1869
Code: e8 03 42 0f b6 04 30 84 c0 0f 85 41 01 00 00 66 41 89 1f eb 05 e8 89 26 75 f8 bb ff ff ff ff e9 04 f9 ff ff e8 7a 26 75 f8 90 <0f> 0b 90 49 83 c5 44 4c 89 eb 49 c1 ed 03 43 0f b6 44 35 00 84 c0
RSP: 0018:ffffc9000b7671f0 EFLAGS: 00010293
RAX: ffffffff894addf6 RBX: 0000000000000002 RCX: ffff888025029e40
RDX: 0000000000000000 RSI: ffffffff8bbf05c0 RDI: ffffffff8bbf0580
RBP: 0000000000000000 R08: 00000000ffffffff R09: 1ffffffff1c0bfd6
R10: dffffc0000000000 R11: fffffbfff1c0bfd7 R12: ffff88805a90de5c
R13: ffff88805a90ddc0 R14: dffffc0000000000 R15: ffffc9000b7672c0
FS:  00007f20739f66c0(0000) GS:ffff88812613e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2d2a80 CR3: 0000000024e36000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 multiq_classify net/sched/sch_multiq.c:39 [inline]
 multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
 dev_qdisc_enqueue+0x4e/0x260 net/core/dev.c:4118
 __dev_xmit_skb net/core/dev.c:4214 [inline]
 __dev_queue_xmit+0xe83/0x3b50 net/core/dev.c:4729
 packet_snd net/packet/af_packet.c:3076 [inline]
 packet_sendmsg+0x3e33/0x5080 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f207578efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f20739f6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f20759e5fa0 RCX: 00007f207578efc9
RDX: 0000000000000004 RSI: 00002000000000c0 RDI: 0000000000000008
RBP: 00007f20739f6090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f20759e6038 R14: 00007f20759e5fa0 R15: 00007f2075b0fa28
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

