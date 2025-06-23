Return-Path: <netdev+bounces-200268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D87DAE409E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3AB716CBBF
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33F246BCF;
	Mon, 23 Jun 2025 12:36:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CAC2459FF
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682189; cv=none; b=G73ywAiNT73vl/KQx9bHXRZXWijg+6KgvyCzDTzi8Z71hb7Bdmftc0q9V8uVBX7fA0b+oFyz68/Muxm+7IUyZJmQSbQJRs55GGHW8OeFAJQ8u8S2moDqxQCmUpHf97VjyLkf78FBldMoWa9MMALaUz0Fk1LMpFwIik9Bhb2Je5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682189; c=relaxed/simple;
	bh=I94hyQyD/qKXs1D3uD4NdBsilxac862akXLbKXvNFLk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IRnR+TYu9qj9ONemGquu0VKIaINHLYHp5TkMfDetG8r08NapwpQcd8B33NC0wWgAF+iZlcNugr9NbiVZoX/XxLEknzVugB6rGQsLmDFUpjohIjy3Kvb09+wVNDbjONzCzayVhcFuxF7Q32nP3V//qSG/oQbZXNGYsi1Anp/AJe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so41781565ab.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 05:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750682187; x=1751286987;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lckP2yk9BWndyCy1qwAHEv9eAD3uVxRbyKNvTUYHF1A=;
        b=A6NeUmehDMGu+pK4JFmX/bX2EZpNPdANJZHbue5QJO9wEfuoTHe415sMWJuepOXypT
         TptSztUnZFH5xUqaKaAkAHsN1ll8EDsk5lxFc3y+1gcBoyCQbUS+rm6ezxiuJkNTv5R9
         TlzKJwEGhYOobuM29Kn9Va6LK2owkQcs7nnrDR0Nr4aBEMzMIvBtSdHT6VoveivkP0HK
         bjzJTWCvlrq9uZ2lSg0a80CFCTBmwnKV5xu8+3dvvxByjsrXKlC4YdAmnDPIhKLAA3ba
         quldGiZPEzuPjS8gsnjHiK5/6RI0+Ss87AqaMJnoXRj1src12cowCiNeSA8hjCLM1Hgt
         Gkcg==
X-Forwarded-Encrypted: i=1; AJvYcCXrm2Wj4d4gfFvJFSKevFtAb5+Xpl0zvEeUHm+b1CGwbvk5ND5402WlcPXRjuJCVZchfs1Vkwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpLsdaB86N6Vjuu7UE1+RiP+LNsD79nglFID51X8fiUBUBMO7d
	fwFj7L804tdskPj8v5A5qddPs5ox/5NPw2DprofUm27Ucpa3+MRGffyMoVxqdwa/YJBVdFJ0G/O
	mUToIdofEqh2G8bsLWQ04G4+FjlM++9XZQqFIwt74d9/VI659g5XFVIfN6Fs=
X-Google-Smtp-Source: AGHT+IHYd0s5sUElagbhJyUuV1IzLCihPj/5gGq7jGwxTdrS1pjcrM3DCWD1UjunEB0OgthYNtBFU54G4rZXb/yR2BjHMEjEJ15U
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b83:b0:3dd:c4ed:39c0 with SMTP id
 e9e14a558f8ab-3de38c159a7mr159435025ab.1.1750682186978; Mon, 23 Jun 2025
 05:36:26 -0700 (PDT)
Date: Mon, 23 Jun 2025 05:36:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68594a4a.a00a0220.34b642.0009.GAE@google.com>
Subject: [syzbot] [net?] WARNING in qdisc_tree_reduce_backlog
From: syzbot <syzbot+0a5453a1b326f68c4302@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    739a6c93cc75 Merge tag 'nfsd-6.16-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15302dd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4130f4d8a06c3e71
dashboard link: https://syzkaller.appspot.com/bug?extid=0a5453a1b326f68c4302
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-739a6c93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3c3204516e7/vmlinux-739a6c93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4396a9588ad1/bzImage-739a6c93.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a5453a1b326f68c4302@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 14934 at net/sched/sch_api.c:809 qdisc_tree_reduce_backlog+0x2d1/0x5a0 net/sched/sch_api.c:809
Modules linked in:
CPU: 1 UID: 0 PID: 14934 Comm: syz.0.2492 Not tainted 6.16.0-rc2-syzkaller-00318-g739a6c93cc75 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:qdisc_tree_reduce_backlog+0x2d1/0x5a0 net/sched/sch_api.c:809
Code: fc 3e f8 45 85 f6 75 25 e8 6c 01 3f f8 44 8b 7c 24 14 31 ff 45 09 e7 44 89 fe e8 9a fc 3e f8 45 85 ff 75 6d e8 50 01 3f f8 90 <0f> 0b 90 e8 47 01 3f f8 8b 34 24 4c 89 ef e8 0c fa ff ff 49 89 c7
RSP: 0018:ffffc90006ebf290 EFLAGS: 00010293
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff897d1af6
RDX: ffff88802dc5c880 RSI: ffffffff897d1b00 RDI: 0000000000000005
RBP: 00000000000affe0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888037efe000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f66590096c0(0000) GS:ffff8880d6853000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000080 CR3: 00000000473da000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000800000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 qdisc_purge_queue include/net/sch_generic.h:982 [inline]
 qdisc_replace include/net/sch_generic.h:1232 [inline]
 tbf_graft+0x1dd/0x800 net/sched/sch_tbf.c:570
 qdisc_graft+0x341/0x17c0 net/sched/sch_api.c:1210
 __tc_modify_qdisc net/sched/sch_api.c:1766 [inline]
 tc_modify_qdisc+0xf48/0x2130 net/sched/sch_api.c:1822
 rtnetlink_rcv_msg+0x3c6/0xe90 net/core/rtnetlink.c:6953
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f665818e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6659009038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f66583b6160 RCX: 00007f665818e929
RDX: 0000000000004000 RSI: 0000200000000280 RDI: 0000000000000005
RBP: 00007f6658210b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f66583b6160 R15: 00007ffeeab8d708
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

