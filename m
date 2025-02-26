Return-Path: <netdev+bounces-169714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 170C9A45567
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980E61892562
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3120C02C;
	Wed, 26 Feb 2025 06:18:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1616DEB1
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550703; cv=none; b=oe1hXEVIgLIuteqAbC1uyUmoiab3iI5qTryGrkd2nKY06B+s6YiAk5Py7cS3ZsXbVop0NHoy0tQ+yqyXgHCLVUkbo5AHrKWSKNr+VDId7MZuHLWWd0nTlG3V/b1PjXan/YLvHDBAeM3eqKjv/NVvKpi1yscJBvu3U6NuT30r3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550703; c=relaxed/simple;
	bh=JryWq7WV8uNmBfkhQojR45hf3u/Eku7l7OsIR6FXLt4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BcxLkbn0NNwO3XZtfzPqAld4Cmq3VR//vnai6VroYeZoGuWHE9YDFzCtoDWyuRsS1RamF+dHAUJTD6ONM4x9zRkPh2dQf86CbMSpaQ7UWuf2tnm/BahUbUO1RHHVIzPB+PUr05yzY8HEMWwgR7fd+tRY7t4WSiy79EV1CNyRudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d2a6b4b2dbso119252275ab.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 22:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740550701; x=1741155501;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KkxgE/b/3yDI6a3ezLAF95DWpHfHSO/kSkJ/250V8Pw=;
        b=Og86SMXEYRQ15Ds2x0QVCzYF6n+8/jEcWpg/Ozgvb300+Ea/ihffOQjKAahKP97ruL
         pfWd39BdAW4caf9EwsZVqwavTSkJg5tfg4ifcG1oKeM6NqNKjWa4MMZT1VZU9Syg611y
         H4XJwDwBruWO1aCepBxxUQJGtqYwqgrwA3o8sAluX4LEnMn/bfK/qGlqT1ySyt4jLxBg
         mGX870t4EI7Tt8p98HFZZzpLaF9FmopZC+Xb0ol/7rNUBBg6S7NGT7dwKePzV7iPkHIH
         q3oCNwTwiLZsUJbwWPj3JhnKEnmlokMW5MD86wtki4g5JMxJDBTx414w6pDEdmTq3EsE
         dkNA==
X-Forwarded-Encrypted: i=1; AJvYcCVFs6cZmxYhtyFH9VxVfR1FMifxwkHy9VkVEe6Oq7HenfIiAf3Q27OYbR+8SPmF/IpRZ0hCM/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjq3uxBya9VwhdrudOMVDd/L2BavwS2KNk6fVVLTOPLbP0oHX
	s36esrak8cIgS0lDTZR8lka1lAsvOthLyoT8ZEdv5K1xbmODXOTy8f+iztdRRAn6GCpCttFG8uL
	BCMVNWI5iWNb/MwknXJxKu0VNh3LIfrPqqF80d4CzFyRuxGMiTRBgegU=
X-Google-Smtp-Source: AGHT+IFdIux2xCtFwI+X+/UDsvvVlScy23UF65J2zNj1GVC4lv0CCjLGdoMoDNbuKgtiI8OrR3OPi0YijYbRJGd/OibgL9Kcz2RE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8f:0:b0:3d0:405d:e94f with SMTP id
 e9e14a558f8ab-3d3d1f90759mr21788395ab.17.1740550700768; Tue, 25 Feb 2025
 22:18:20 -0800 (PST)
Date: Tue, 25 Feb 2025 22:18:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67beb22c.050a0220.2eba0.0049.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_send_cmd (2)
From: syzbot <syzbot+d04bd412c1b0e2f36647@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    28b04731a38c MAINTAINERS: fix DWMAC S32 entry
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15507ae4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=d04bd412c1b0e2f36647
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e10163bfe6ac/disk-28b04731.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0bb611c3bfe3/vmlinux-28b04731.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c3fd8dd5fabb/bzImage-28b04731.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d04bd412c1b0e2f36647@syzkaller.appspotmail.com

Bluetooth: MGMT ver 1.23
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6674 at kernel/workqueue.c:2257 __queue_work+0xcd3/0xf50 kernel/workqueue.c:2256
Modules linked in:
CPU: 1 UID: 0 PID: 6674 Comm: syz.2.227 Not tainted 6.14.0-rc3-syzkaller-00154-g28b04731a38c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:__queue_work+0xcd3/0xf50 kernel/workqueue.c:2256
Code: ff e8 e1 af 38 00 90 0f 0b 90 e9 b2 fe ff ff e8 d3 af 38 00 eb 13 e8 cc af 38 00 eb 0c e8 c5 af 38 00 eb 05 e8 be af 38 00 90 <0f> 0b 90 48 83 c4 60 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc9001b5ef6c8 EFLAGS: 00010087
RAX: ffffffff81890ac4 RBX: ffff888028dc8000 RCX: 0000000000080000
RDX: ffffc9000bf59000 RSI: 000000000003158c RDI: 000000000003158d
RBP: 0000000000000000 R08: ffffffff8188ff24 R09: 0000000000000000
R10: ffffc9001b5ef7a0 R11: fffff520036bdef5 R12: ffff888027d1c800
R13: ffff888027d1c9c0 R14: dffffc0000000000 R15: 0000000000000008
FS:  00007f93037aa6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c381f89 CR3: 000000007d25a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 hci_send_cmd+0xb6/0x180 net/bluetooth/hci_core.c:3048
 set_link_security+0x606/0x820 net/bluetooth/mgmt.c:1909
 hci_mgmt_cmd+0xa1f/0xf10 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:733
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1137
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xacf/0xd10 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f930298d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f93037aa038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9302ba5fa0 RCX: 00007f930298d169
RDX: 0000000000000007 RSI: 0000400000000000 RDI: 0000000000000008
RBP: 00007f9302a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9302ba5fa0 R15: 00007ffeb82b7bb8
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

