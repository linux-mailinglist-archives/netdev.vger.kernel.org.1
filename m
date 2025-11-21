Return-Path: <netdev+bounces-240796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1678FC7A927
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6036342525
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5875F33C50B;
	Fri, 21 Nov 2025 15:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354D314D2F
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738973; cv=none; b=g4BkVIIF9X4aG4q1+sJEbJmqbAxWWiZOlwEUP4zYacVsP1dL4I/OXJNb/0r5p3Uw60mfutg43GoqNJRPNt3VJ58JlmqcFdNoMBk/G3rIq0Y4WUWm2us9prs6zkh62mO9eqPcg+RmdBbLUD5LJJlFKJsVwjBSLKxI9AujiUXVXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738973; c=relaxed/simple;
	bh=bxa6VZON7cSk2oq9NS/86o6L0QmgUzgtEI0wBYgGTO4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MAregxBA9AX8Oa3VIm15DkOWDIqiTdvRZeDWm3YuyK9qGzT2/2b8VYUxEXzzuGuMMe2SGuLoOsvPlljG1RJoP2xzqP86fMbOuSjqjvsbKcCrySUQndSEcr2rzIs6RLcHN54riuGtuQXQxzhY/DcnsuhSjgwKsNj+25dMgJJVcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-4330f62ef60so20145975ab.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 07:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763738971; x=1764343771;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHJv7XUxlxqmqZsZZNhFmIn3h8MichNwFsBa+hW0lLg=;
        b=k5HyTrW971epAOBVj5fS676UxWSlPm7NplZB7k5IFuaGxMg2rDNVhkE3j5Wjo2uRAW
         xqi1a8LqUIQXrCWEVIM62lHtMCko/IZS0tW7SNXco4XW7iNLIrjZuvdk0SMEt4gJSlmM
         xAtc0ilGwDOw2CfuFabP1HI0k9iadp/3PYFf5xC8svGTck7k45A/50wc3WnQVbqLE8cu
         ig0+eIow3bCNBYmT9MBt9eYnCHtJhzWfYluxGNZ1UySauqd5GVvezEAt4U7mjaDiBvoc
         k+I4OxWlR1F566zLOBBXGDk5wAes4apLSktZH/XAEJVEcNekGvUwEDBws5S0TSC9TcC4
         lNnA==
X-Forwarded-Encrypted: i=1; AJvYcCWdED5MBeV7NjXV1glM7YbM5o0tFugow6HS2nCVozcJb9oGWxgVESs2NIpzsSD3omoATpAA6DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJxTf30ZXGC3XofHVNwRIunoUpc7P73hPYntEyFxMl6ptcTxR
	mC4VgHIOwMqrgbQOY3APH8SLNT70NaROx7MQYWSAoWr6FVjqhKQYU/4g1lT2f0MAd1OCUl2EL9/
	2ckEYXNGO+ER822E4SCrrEh+Xj7G7OCiKdWT9oGY555QoYjFlchaeKUVpaos=
X-Google-Smtp-Source: AGHT+IHwQ/wLN9AT8VbaHXLI/mc8KYaBB8oWx9sX7RVh5SaaDxRKOAWCYEnF2AIy3drJq/ZTyTo2Df1C+NPawzooEwgPJchrN+LW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:258d:b0:433:810c:db1 with SMTP id
 e9e14a558f8ab-435b8eb43f6mr19551835ab.20.1763738970847; Fri, 21 Nov 2025
 07:29:30 -0800 (PST)
Date: Fri, 21 Nov 2025 07:29:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6920855a.a70a0220.2ea503.0058.GAE@google.com>
Subject: [syzbot] [net?] WARNING in em_nbyte_match
From: syzbot <syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8e621c9a3375 Merge tag 'net-6.18-rc7' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=135a0e92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14b6a9313e132a6b
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a497f02c389d86ef16
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e83658580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149b4484580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd46b2cfa172/disk-8e621c9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/55fd403d139a/vmlinux-8e621c9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f79c45db6fe5/bzImage-8e621c9a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com

syzkaller0: entered promiscuous mode
syzkaller0: entered allmulticast mode
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6013 at ./include/linux/skbuff.h:3071 skb_transport_header include/linux/skbuff.h:3071 [inline]
WARNING: CPU: 0 PID: 6013 at ./include/linux/skbuff.h:3071 tcf_get_base_ptr include/net/pkt_cls.h:539 [inline]
WARNING: CPU: 0 PID: 6013 at ./include/linux/skbuff.h:3071 em_nbyte_match+0x2d8/0x3f0 net/sched/em_nbyte.c:43
Modules linked in:
CPU: 0 UID: 0 PID: 6013 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:skb_transport_header include/linux/skbuff.h:3071 [inline]
RIP: 0010:tcf_get_base_ptr include/net/pkt_cls.h:539 [inline]
RIP: 0010:em_nbyte_match+0x2d8/0x3f0 net/sched/em_nbyte.c:43
Code: 31 c0 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 8d 08 e4 01 cc e8 a7 a7 5a f8 90 0f 0b 90 e9 de fe ff ff e8 99 a7 5a f8 90 <0f> 0b 90 e9 f7 fd ff ff 89 d1 80 e1 07 fe c1 38 c1 0f 8c 71 fd ff
RSP: 0018:ffffc900038fefd8 EFLAGS: 00010293
RAX: ffffffff89655c27 RBX: ffff88803039f3c0 RCX: ffff88802f1d0000
RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
RBP: 000000000000ffff R08: ffff88802f1d0000 R09: 0000000000000003
R10: 0000000000000002 R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff11006073e8e R14: ffff8880301e5580 R15: 1ffff1100603cab0
FS:  00005555576be500(0000) GS:ffff88812613b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002280 CR3: 0000000062390000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tcf_em_match net/sched/ematch.c:494 [inline]
 __tcf_em_tree_match+0x1ac/0x770 net/sched/ematch.c:520
 tcf_em_tree_match include/net/pkt_cls.h:512 [inline]
 basic_classify+0x115/0x2d0 net/sched/cls_basic.c:50
 tc_classify include/net/tc_wrapper.h:197 [inline]
 __tcf_classify net/sched/cls_api.c:1764 [inline]
 tcf_classify+0x4cf/0x1140 net/sched/cls_api.c:1860
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
RIP: 0033:0x7f02b7d8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef050ec08 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f02b7fe5fa0 RCX: 00007f02b7d8f749
RDX: 0000000000000004 RSI: 00002000000000c0 RDI: 0000000000000007
RBP: 00007f02b7e13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f02b7fe5fa0 R14: 00007f02b7fe5fa0 R15: 0000000000000003
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

