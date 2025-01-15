Return-Path: <netdev+bounces-158530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B37DA12654
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5433A51A9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02533824A0;
	Wed, 15 Jan 2025 14:42:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032986350
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952144; cv=none; b=XZqB1HlMEKPD5PX6QhEet3juhCWUmfODbrn6x+Ez2oVz3b0xX5t5pdAnSp0m40oEIp+rfS9096SnUXb2/NW5iURodMe2KWpFogSAUsGdnpMBTWNO/aer9yVBOKydBWo6zxbbkZs8DfK5D7458f8d3j5aife568Tpj8boXo0/4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952144; c=relaxed/simple;
	bh=gPhXu1f/aQfXmtaIYa76rsDYZbA8/d5Vdc9kIoNldho=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NeLTBhQ0V3V4bzKz0yW6T/AK3k3QAAskWVPCTb3UGyvzNG2Dp38wRIRkvCweh66JF4jppRcv09sxSGV9JcFDQInZNh5nNXGUH4rSIzkBnnd6WA/m0ZNSVevloQh066qSZEIp7azWnnBho0vJ7eXFwUNxX8zgvFX8vAltT+09J8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so50299275ab.0
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 06:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736952142; x=1737556942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Aq1XPHVLhl3TEuqQQiepF4ogH9ZaP83SQKgVRW3BJ4=;
        b=hke7q+wP/eEZfQoJHrCKBi1vXdAEGL9ZwTJrjIUq0/o/318hELzfxMpbunEDRZQcCx
         m1ymxwwMdYW87d+JMfEubQEpZSKP2KSH1zXmxYkJSnTQ6XdTVx+nXMy5NEVVjqGS7dFO
         7mnYGHeLNv11q/JsJU4PRSuCwxi7AIYSCd9hATVwKzd92WqqbZ3oel6oD0l39aUcuTBI
         Xd9HJf26A8crE5Pbf4m885oJMP2PuUg7eP9DNVzUdxMgKXlpiZATeEQ1uwB+MmA/eqPo
         46AL33jpXiHQMC8aCJB8Bdr6Yoc5rziPshJfhssNBDXGRs3iGtp9pHaRFWv58LmG4app
         PnXg==
X-Forwarded-Encrypted: i=1; AJvYcCXOvenSfj1m5SCT7EDE7sIJatNuUpYKtUPR/Y33iOc1YxGA7QXzqPdsjmIP37DbLwnW7WiRb9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE8jgETDbEeBbjkXywXvTNfoUzuNqPr2M/zrQtICuTr/B1dB1s
	0D9AX03ariRGuG/oyzZGW6Y269IUj8CPsbej8YRno0mktqooZiTwg/eaWZ3MO7N3q1fR60x45NF
	ioB8YMwxRjh/6LfcMTP938PBZDQbSNQLHciZNo5sEFgK4/IS3tMlWf6U=
X-Google-Smtp-Source: AGHT+IFxN05eS9i7pmSOzSMUIYLoO4Gt/abnlpLlTwcE3hqlJszQe2CL2OHYUYHueyHAMdhpqp9T3z3ezTsKBj2sjj7t8bmwTLZM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ad:b0:3ce:8ed9:ca81 with SMTP id
 e9e14a558f8ab-3ce8ed9ce12mr6229405ab.5.1736952142253; Wed, 15 Jan 2025
 06:42:22 -0800 (PST)
Date: Wed, 15 Jan 2025 06:42:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6787c94e.050a0220.20d369.0019.GAE@google.com>
Subject: [syzbot] [net?] WARNING in nsim_udp_tunnel_set_port
From: syzbot <syzbot+2e5de9e3ab986b71d2bf@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    63676eefb7a0 Merge tag 'sched_ext-for-6.13-rc5-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1336e418580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
dashboard link: https://syzkaller.appspot.com/bug?extid=2e5de9e3ab986b71d2bf
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cfb1c4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ac4edf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ba5dd9f6cf65/disk-63676eef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/290bc4e6d798/vmlinux-63676eef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/561f22e07925/bzImage-63676eef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e5de9e3ab986b71d2bf@syzkaller.appspotmail.com

------------[ cut here ]------------
entry already in use
WARNING: CPU: 1 PID: 5869 at drivers/net/netdevsim/udp_tunnels.c:26 nsim_udp_tunnel_set_port+0x2d3/0x390 drivers/net/netdevsim/udp_tunnels.c:26
Modules linked in:
CPU: 1 UID: 0 PID: 5869 Comm: syz-executor227 Not tainted 6.13.0-rc5-syzkaller-00161-g63676eefb7a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:nsim_udp_tunnel_set_port+0x2d3/0x390 drivers/net/netdevsim/udp_tunnels.c:26
Code: c3 cc cc cc cc e8 dd a0 ca fa 44 89 f7 e8 85 38 b8 fa e9 ee fd ff ff e8 cb a0 ca fa 90 48 c7 c7 e0 7f 0a 8c e8 fe 66 8b fa 90 <0f> 0b 90 90 4c 8d 73 04 41 bf f0 ff ff ff e9 fa fe ff ff e8 c5 10
RSP: 0018:ffffc90003fffab8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffc90003fffbb0 RCX: ffffffff815a1789
RDX: ffff8880301d5a00 RSI: ffffffff815a1796 RDI: 0000000000000001
RBP: ffff8880744cc000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000017c10002 R15: 0000000000000000
FS:  0000555579af3380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5ac84532b0 CR3: 000000001decc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udp_tunnel_nic_device_sync_one net/ipv4/udp_tunnel_nic.c:225 [inline]
 udp_tunnel_nic_device_sync_by_port net/ipv4/udp_tunnel_nic.c:246 [inline]
 __udp_tunnel_nic_device_sync.part.0+0x935/0xed0 net/ipv4/udp_tunnel_nic.c:289
 __udp_tunnel_nic_device_sync net/ipv4/udp_tunnel_nic.c:283 [inline]
 __udp_tunnel_nic_reset_ntf+0x3c1/0x520 net/ipv4/udp_tunnel_nic.c:581
 udp_tunnel_nic_reset_ntf include/net/udp_tunnel.h:377 [inline]
 nsim_udp_tunnels_info_reset_write+0xc2/0x110 drivers/net/netdevsim/udp_tunnels.c:117
 full_proxy_write+0xfb/0x1b0 fs/debugfs/file.c:356
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5ac83d0df9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc834f88c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f5ac83d0df9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f5ac841e1fa R09: 00007f5ac841e1fa
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ac841e453
R13: 0000000000000001 R14: 00007ffc834f8900 R15: 0000000000000000
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

