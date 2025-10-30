Return-Path: <netdev+bounces-234518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D182EC22871
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 23:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7958B34C209
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 22:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE870314D2A;
	Thu, 30 Oct 2025 22:14:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005C33556B
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862470; cv=none; b=DCV7OTH/TcTxK9q105FBprjdJWM3pDQXJ31FX/A3VaZVaXNpVb0y8VmCmYAExDxuaR28naw3pVteR9csgOvV3aKFQYXdGBA3bpKTbt1i0I03MUjUKJV7ciZWRDMeY0l9TO1sgAf1CqA/S0zK7H3C0tAo0itqGmS8SVvHbqheMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862470; c=relaxed/simple;
	bh=6fYhdpG1Ub6R9qOagykrSkOktoB2nv95+eCVFHUdUDA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E1D44tmwTKbsVcDTkZdMfGKhESGRN+YPV0ASIPEULskl1O6kvEuB4yE2mExw5tXmQCpYbHme/yVq5JJQBYTnoA3FNr9+Q5LZsHC2UW0Zuqd0jkm+0O7bvkCM0oWrPVQyMR1ajerclQ2TCgxPrt/nIi06TwmiWciFfDry6GB/D/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4330ba63227so7199895ab.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 15:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761862468; x=1762467268;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjmADPwuhiKknh1al6I//g5+o5h7/YHoGsWoDdA3Xik=;
        b=eqx0RE6ycYfePaGQgEmVImRW91G3OaVTx5WTSve7pznXvIDzP7MCGB+PwFQwDyEkpY
         gPMAu1l8EapzpIbGy+eJwoc6zoeZfbwYyVH10PijUUTL4GhgcidxuGoWGtiRCJbtXECU
         waZAzE2CY3GmV2yVC/ZXNC3VUKJy1CzGK/phXNJS4FzeBCVKduGvBQF03Z9fgWq7T3SD
         p8gi1d3rjapC9+AH8Rh6Af5vGCZ3dCF+Ns2W0HQVngWsJ7HGgoeQ/wtW7BrVdO8QuxH2
         RV1IS1AalON9WVdkdGn1JKzYNsu+w6WSYAL9f0CKE/Scy0R0MebqMhFLX+vBGG4hhlY0
         DHyg==
X-Forwarded-Encrypted: i=1; AJvYcCUKypxSEqU/Jii9w1T0bZ2VqWib0AzllF7KbrpWLIKsVBbMOl+uqavWcfDkNXuKtgG7fRDpIx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/dkgY+ZpPSK2tvi+8dS+vWeknw4v3YOOjp3USachZ2MNdQVB
	w415LqmSpH0JmHT3CWS3NIHbxdyEuPXowRM6OJgAuKQs42MOYjCu8itki3kj4D7jBdo0VEzdHFU
	ZwPOBWJTJIz2gW3e75G+nm20+JCSM0v5vpT+G64G8oq8d1VE81X3gQeOxUOw=
X-Google-Smtp-Source: AGHT+IGAQ2hv/3RdL9/kZOY1zexofp89sFzf/nb96X1J0QOY8Q6zTb5XyloQXj89LQY1BlLeIVqIvTewXF86vR9c7m43HfKNRZYV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aab:b0:42f:a4d7:ebac with SMTP id
 e9e14a558f8ab-4330bd94293mr25707765ab.4.1761862468057; Thu, 30 Oct 2025
 15:14:28 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:14:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6903e344.050a0220.32483.022d.GAE@google.com>
Subject: [syzbot] [net?] BUG: corrupted list in team_priority_option_set (6)
From: syzbot <syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dcb6fa37fd7b Linux 6.18-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1596ac92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=609c87dcb0628493
dashboard link: https://syzkaller.appspot.com/bug?extid=422806e5f4cce722a71f
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dcb6fa37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/61176fd888a1/vmlinux-dcb6fa37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84e7e9924c22/bzImage-dcb6fa37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com

futex_wake_op: syz.0.2928 tries to shift op by -1; fix this program
 non-paged memory
list_del corruption, ffff888058bea080->prev is LIST_POISON2 (dead000000000122)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:59!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 21246 Comm: syz.0.2928 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__list_del_entry_valid_or_report+0x13e/0x200 lib/list_debug.c:59
Code: 48 c7 c7 e0 71 f0 8b e8 30 08 ef fc 90 0f 0b 48 89 ef e8 a5 02 55 fd 48 89 ea 48 89 de 48 c7 c7 40 72 f0 8b e8 13 08 ef fc 90 <0f> 0b 48 89 ef e8 88 02 55 fd 48 89 ea 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000d49f370 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff888058bea080 RCX: ffffc9002817d000
RDX: 0000000000000000 RSI: ffffffff819becc6 RDI: 0000000000000005
RBP: dead000000000122 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff888039e9c230
R13: ffff888058bea088 R14: ffff888058bea080 R15: ffff888055461480
FS:  00007fbbcfe6f6c0(0000) GS:ffff8880d6d0a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3afcb0 CR3: 00000000382c7000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:132 [inline]
 __list_del_entry include/linux/list.h:223 [inline]
 list_del_rcu include/linux/rculist.h:178 [inline]
 __team_queue_override_port_del drivers/net/team/team_core.c:826 [inline]
 __team_queue_override_port_del drivers/net/team/team_core.c:821 [inline]
 team_queue_override_port_prio_changed drivers/net/team/team_core.c:883 [inline]
 team_priority_option_set+0x171/0x2f0 drivers/net/team/team_core.c:1534
 team_option_set drivers/net/team/team_core.c:376 [inline]
 team_nl_options_set_doit+0x8ae/0xe60 drivers/net/team/team_core.c:2653
 genl_family_rcv_msg_doit+0x209/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2630
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2684
 __sys_sendmsg+0x16d/0x220 net/socket.c:2716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbbcef8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbbcfe6f038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fbbcf1e5fa0 RCX: 00007fbbcef8efc9
RDX: 0000000000040000 RSI: 0000200000000200 RDI: 0000000000000004
RBP: 00007fbbcf011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbbcf1e6038 R14: 00007fbbcf1e5fa0 R15: 00007fffa3594408
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x13e/0x200 lib/list_debug.c:59
Code: 48 c7 c7 e0 71 f0 8b e8 30 08 ef fc 90 0f 0b 48 89 ef e8 a5 02 55 fd 48 89 ea 48 89 de 48 c7 c7 40 72 f0 8b e8 13 08 ef fc 90 <0f> 0b 48 89 ef e8 88 02 55 fd 48 89 ea 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000d49f370 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff888058bea080 RCX: ffffc9002817d000
RDX: 0000000000000000 RSI: ffffffff819becc6 RDI: 0000000000000005
RBP: dead000000000122 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff888039e9c230
R13: ffff888058bea088 R14: ffff888058bea080 R15: ffff888055461480
FS:  00007fbbcfe6f6c0(0000) GS:ffff8880d6a0a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcb8535e5c CR3: 00000000382c7000 CR4: 0000000000352ef0


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

