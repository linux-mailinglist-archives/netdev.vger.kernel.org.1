Return-Path: <netdev+bounces-154547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B219FE8DC
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 17:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0787B161416
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D67D1AA792;
	Mon, 30 Dec 2024 16:04:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F4A1A2544
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735574664; cv=none; b=ryZuLZ9ma+7JKP/SGEJnvwXIJeV/ANgh/BW3WMcgQoaqpnbZfLENiVzzEfEYKw9jrQ/TyFRguiumCtl21VKaag/1syJhFV0eN50y6upEvoqxmXYYiW5oSl8VrMJcHYSqIjaCEvyePG+/2kGkGNHXQUMxI4c5pwP9yOkekKgVYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735574664; c=relaxed/simple;
	bh=wd36mO7nuJq1Hvq5OnzEDNbvFOXcdplE4Gl5ei/AtvQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=krUwa+cyEPZf1PVpjv1GLZ70+yIYkM1bqcp/6420JrFUQUvLzhIw5fS8CXnkicmgE+GbjEYfyQoa9P/4YXgY55etWPuEqjbeQsmq9XS8YUBlxGL5aw3TzeMl/r8tbtk+8fY9CbEcihpF1zhgmJYcRG4YLDVjuAuHb13z/Cp3Khw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a814c7d58eso95828525ab.1
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735574662; x=1736179462;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4SqP1mRyJuqLHAyT0Lb0x4dvBUoils4DhrgwLw8rVOw=;
        b=QZdKVm5rxPvs7G0mpgcVGdTN6LaO0eQEJ1LvlBOnRYUMTugL0RSTCJqEUidVWQrrq1
         aQsV6LoDKbeQYsVllfxxYHYhSmigskRg+x3Xwq6nW5QF4z7jKPgE2CcJCuMLCFM8Pzhi
         2e+h9roWdHi5Tb6rwVdNVNrUdtYQ8iwILcTMwoDEsF/U0X4YFp6jFEtyZEdrrYRj6Xfj
         zqdrsusxhx4H72naFn7Vl0LjUODh0V7IPv64o7W6PNaRzl47XaT4Yw0eznvo5kjlKQJ7
         z4K21CUf9RWeXVhz61qILgLSY60k4Ltk1CA1s+PvD8dQwGm9Nf7AoPXpej6wdMvw3+S7
         fyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvIArlGRDT5FQsNLgm1egqfEntBNRzOAu1x+gYtjM3wB36ucOMa+HHQf9zc9FD0XTlkxHCI2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YykKmf3Z1zs01MGW/PTcI4FvEkXN45TJlSp4qQrCf32pbRRtvbE
	MEwySfNqKnEM5meIGXK0j6vV7vmOmM0k+zPvgtBIzR6jmLtoLT96gI53+eY/USLRLZ1GWiFxe/j
	VWOngCmWM/wqUl88IZerPL91t9AA26OXuVyxGHZuYzJutOEijz+mBpac=
X-Google-Smtp-Source: AGHT+IGodUTmxHx2k+KAeEnLFQxRUg+YpRv3EDU119QPpYilK7LlhDEWkZhh+hU5BqUzTcGqBLbUpy+7AAmdjjvc3XZnkoNt0ZBZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:3a7:d792:d6c0 with SMTP id
 e9e14a558f8ab-3c2d5918a9bmr347161595ab.20.1735574661671; Mon, 30 Dec 2024
 08:04:21 -0800 (PST)
Date: Mon, 30 Dec 2024 08:04:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6772c485.050a0220.2f3838.04c5.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in vlan_get_protocol_dgram
From: syzbot <syzbot+74f70bb1cb968bf09e4f@syzkaller.appspotmail.com>
To: chengen.du@canonical.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemb@google.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d6ef8b40d075 Merge tag 'sound-6.13-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1707badf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d269ef41b9262400
dashboard link: https://syzkaller.appspot.com/bug?extid=74f70bb1cb968bf09e4f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d492c4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170810b0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e695f9ff89ad/disk-d6ef8b40.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/28ff2bace4a0/vmlinux-d6ef8b40.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f25dce4c24ee/bzImage-d6ef8b40.xz

The issue was bisected to:

commit 79eecf631c14e7f4057186570ac20e2cfac3802e
Author: Chengen Du <chengen.du@canonical.com>
Date:   Sat Jul 13 11:47:35 2024 +0000

    af_packet: Handle outgoing VLAN packets without hardware offloading

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15ebd2f8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17ebd2f8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13ebd2f8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74f70bb1cb968bf09e4f@syzkaller.appspotmail.com
Fixes: 79eecf631c14 ("af_packet: Handle outgoing VLAN packets without hardware offloading")

skbuff: skb_under_panic: text:ffffffff8a8ccd05 len:29 put:14 head:ffff88807fc8e400 data:ffff88807fc8e3f4 tail:0x11 end:0x140 dev:<NULL>
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:206!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5892 Comm: syz-executor883 Not tainted 6.13.0-rc4-syzkaller-00054-gd6ef8b40d075 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0b 8d 48 c7 c6 86 d5 25 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 5a 69 79 f7 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc900038d7638 EFLAGS: 00010282
RAX: 0000000000000087 RBX: dffffc0000000000 RCX: 609ffd18ea660600
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88802483c8d0 R08: ffffffff817f0a8c R09: 1ffff9200071ae60
R10: dffffc0000000000 R11: fffff5200071ae61 R12: 0000000000000140
R13: ffff88807fc8e400 R14: ffff88807fc8e3f4 R15: 0000000000000011
FS:  00007fbac5e006c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbac5e00d58 CR3: 000000001238e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 skb_push+0xe5/0x100 net/core/skbuff.c:2636
 vlan_get_protocol_dgram+0x165/0x290 net/packet/af_packet.c:585
 packet_recvmsg+0x948/0x1ef0 net/packet/af_packet.c:3552
 sock_recvmsg_nosec net/socket.c:1033 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1055
 ____sys_recvmsg+0x1c6/0x480 net/socket.c:2803
 ___sys_recvmsg net/socket.c:2845 [inline]
 do_recvmmsg+0x426/0xab0 net/socket.c:2940
 __sys_recvmmsg net/socket.c:3014 [inline]
 __do_sys_recvmmsg net/socket.c:3037 [inline]
 __se_sys_recvmmsg net/socket.c:3030 [inline]
 __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3030
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbac5e66569
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbac5e00218 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007fbac5ef0358 RCX: 00007fbac5e66569
RDX: 0000000000000001 RSI: 0000000020000480 RDI: 0000000000000003
RBP: 00007fbac5ef0350 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010022 R11: 0000000000000246 R12: 00007fbac5ebd074
R13: 83a88896d4b9b107 R14: 07c6c9333d389ca9 R15: 0400000000000179
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0b 8d 48 c7 c6 86 d5 25 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 5a 69 79 f7 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc900038d7638 EFLAGS: 00010282
RAX: 0000000000000087 RBX: dffffc0000000000 RCX: 609ffd18ea660600
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88802483c8d0 R08: ffffffff817f0a8c R09: 1ffff9200071ae60
R10: dffffc0000000000 R11: fffff5200071ae61 R12: 0000000000000140
R13: ffff88807fc8e400 R14: ffff88807fc8e3f4 R15: 0000000000000011
FS:  00007fbac5e006c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbac5e00d58 CR3: 000000001238e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

