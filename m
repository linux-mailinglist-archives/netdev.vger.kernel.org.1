Return-Path: <netdev+bounces-144348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F259C6C48
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E028F1F213EA
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC81FB759;
	Wed, 13 Nov 2024 10:03:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C370F1FB884
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492207; cv=none; b=dSCtjyEx71GrtAQq/SmuxxGm7gjWHu1Qk4NyNgQiEArEZip/WrLKJufj34R0OeRtz4dLAqSAAARzMeTuF29aDbsqDI0cplZ7oWFqSboRmXkqfvxygBH//l65xIpHIJOi0JmLuupjXSPEO/7Xc6V9vukx4G1MQsqOrMixFmG8kSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492207; c=relaxed/simple;
	bh=wsdwC3CS6Hd8xHiLIAPYBss7Mnv9WRYVickFvP64SOU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eCB/P1X26WFoQk1XcW9RMiR/iSgNvqOEF8etE2EJQXW1wDG52PwH+7H+d/Pn6xz+ErJ0Ne5UuJE7fHK0OcvKD3JZaS7eGPBR63mt214XDPEaOcC1vL8x+9ChYGdppauffE5Zx4YsQ5c93b+EYaFRRNH8WS8OVZKdQmAT99duRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a71bdd158aso423485ab.1
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492205; x=1732097005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGwSr4FzZWJcuo3AWm+R4LEyOz9xOpfNp/jKix3RJZU=;
        b=G1ugZkcdzH7YST+ax1kVZJ1JwQQltHghe9dCN7SESXSSVtygMLwLpX3YsX4abUF3KB
         4m8XulwvPnBG9iDhSoEItfgno8xYft8I7M84HYJbscD9Ho9emuWcdS2kQORYRwHmVo7M
         Zsk0LJZkey/f1mEwFnRuWqnTj3tBIssvik91ilDBy3akwxChs8MdcO3nvvTfOaCY7j6i
         Fd5vl8yQ6vaw71D2Hic8NpWOv9y6B4qk0NqxzV1UF7X9mTYCGnpx4uZ5/+agY0rsI8uX
         gsWW02UlPC49lrZj3wMMZqO34oiYf05jFyR5JAyd1CJAn1+qIcG4WEMLdnH11Otx9HSg
         9IVw==
X-Forwarded-Encrypted: i=1; AJvYcCV31Ia5bVDSg/X24ySQL3TsMuUYvxwnNt9aftYrAnADg2yM094TZ5dSRDJmFtjRmwEiqYC4yLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM10dYcz1VgFk5NmLa6MinRfuDh5alp29IPhcLdcIkLEXfujL5
	rHp51mdvTAsCsWSb/a7kql+e3jQWOIuwQyrRP3jCZVWFQsiVD8yQybk+aW/04d/+EmPNpi77/LL
	x0GK917jpEC8zouhQBbrn2lCQM+Ig7QpmTfS9FfCge+hsbKurLg1ew9w=
X-Google-Smtp-Source: AGHT+IHhDLkTrVT18M9FC5IesYfllKbhptcngWt2H3ROIa8ndTrDYfl9yr8GeXAqbjxFAWY69hQMzxSX75OLnXOZqhgTI56Q0LwK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1:b0:3a2:6cd7:3250 with SMTP id
 e9e14a558f8ab-3a6f19c1b01mr218864055ab.10.1731492204891; Wed, 13 Nov 2024
 02:03:24 -0800 (PST)
Date: Wed, 13 Nov 2024 02:03:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734796c.050a0220.2a2fcc.0007.GAE@google.com>
Subject: [syzbot] [net?] WARNING in netlink_ack_tlv_fill
From: syzbot <syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4861333b4217 bonding: add ESP offload features when slaves..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f26ea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea5200d154f868aa
dashboard link: https://syzkaller.appspot.com/bug?extid=d4373fa8042c06cefa84
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d19e30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1733c35f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4263c9834cd5/disk-4861333b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14c4f9ec4615/vmlinux-4861333b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6cc8fe1b802d/bzImage-4861333b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5845 at net/netlink/af_netlink.c:2210 netlink_ack_tlv_fill+0x1a8/0x560 net/netlink/af_netlink.c:2209
Modules linked in:
CPU: 1 UID: 0 PID: 5845 Comm: syz-executor685 Not tainted 6.12.0-rc6-syzkaller-01230-g4861333b4217 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:netlink_ack_tlv_fill+0x1a8/0x560 net/netlink/af_netlink.c:2209
Code: 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 0d 48 89 df e8 db b3 2a f8 48 8b 4c 24 10 4c 8b 3b 4d 39 fd 73 2c e8 c9 ed c0 f7 90 <0f> 0b 90 49 bf 00 00 00 00 00 fc ff df e9 9f 00 00 00 e8 b1 ed c0
RSP: 0018:ffffc90003b47780 EFLAGS: 00010293
RAX: ffffffff89d3ec97 RBX: ffff88807d437718 RCX: ffff888030185a00
RDX: 0000000000000000 RSI: 00000000ffffffde RDI: 0000000000000000
RBP: ffffc90003b47850 R08: ffffffff89d3ec3c R09: 0000000000000074
R10: 6f702064656c6961 R11: 6620657475626972 R12: 1ffff92000768ef4
R13: ffff88803169461c R14: ffffc90003b479c0 R15: ffff888031694620
FS:  0000555569f6a380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066abb0 CR3: 0000000079386000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netlink_dump_done+0x513/0x970 net/netlink/af_netlink.c:2250
 netlink_dump+0x91f/0xe10 net/netlink/af_netlink.c:2351
 netlink_recvmsg+0x6bb/0x11d0 net/netlink/af_netlink.c:1983
 sock_recvmsg_nosec net/socket.c:1051 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1073
 __sys_recvfrom+0x246/0x3d0 net/socket.c:2267
 __do_sys_recvfrom net/socket.c:2285 [inline]
 __se_sys_recvfrom net/socket.c:2281 [inline]
 __x64_sys_recvfrom+0xde/0x100 net/socket.c:2281
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff37dd17a79
Code: ff e8 cb 01 00 00 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 11 66 07 00 00 41 89 ca 74 1c 45 31 c9 45 31 c0 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 67 c3 66 0f 1f 44 00 00 55 48 83 ec 20 48 89
RSP: 002b:00007ffda0631f18 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 00007ffda0631fa4 RCX: 00007ff37dd17a79
RDX: 0000000000001000 RSI: 00007ffda0631f90 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffda0631f90
R13: 00007ffda0633178 R14: 0000000000000001 R15: 0000000000000001
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

