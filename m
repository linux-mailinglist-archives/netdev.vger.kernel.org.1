Return-Path: <netdev+bounces-155650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54625A0343A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E321F18848F0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696F2E634;
	Tue,  7 Jan 2025 00:55:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023D208A9
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736211333; cv=none; b=EEZPKGYWdSaoaE5U68bs55kAC5dunYivTuGcT9alHuuo36Gl8nDN2/tWofcpqCMY1jrNPADMFn+Lpzp9sg70HQjDZXM8uIYzWS9RcYW2yDq3K8M51JFlxQCfkb3HFXyiRQrq6alF/283sG+F9kw+GA5EXRYpaBFNVbYO+NWyRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736211333; c=relaxed/simple;
	bh=6L8eG7oPQY2rXstitMfTV6wW5LiPbEq6PqlUMNPIwIg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KJQNVk0nONgs+lMr+dTrFIYBkEN7gVGuWqi402xZM396nI0Z1C6OzqHY81b0QIKmPqo8CAEGvLHO+vvMMCfxEEMepCurbN6Gdt08TDgP5rY7gGWF9StxSIR5shXayN+usAOBIlst7buDb1hZgITVvMseUxsxHF58oTOf7wT6sg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so131153055ab.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 16:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736211330; x=1736816130;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQ/X4xns8g51wRzf+Gr0d+rxgMTSl4NRMzPMoSCmUyc=;
        b=gHx6VqOjbSzk2QBHCFYJhd8tBeDOzAM2ETSdgEoSBmuVO6mzxiL2tnCXslmTr5ZVOW
         AHB/2xCVpNkDRD4/tLt38ou7L99sn5DOuSwDRkPmpXQpkleB+AWCPxPDSXa04zUF3eMe
         EanhZl34j3q/cUuldkgYAsunxBcWwwhRx4SDjdzgBsIvIYpKbc8JHD5pvrd84DJowIz4
         IfIVueKlghzFZ/YgX2lQEVHb3b8SZC1s+p4Y7F7lF9BnAkwLY0xLuvn1akekUIXZHZl7
         RFujbIg2NnkViDk/YGjskkkZdNp1gIHZaLL3EdfrsvErneRSFJrmkb3YFEHQOpD57dIP
         z/xw==
X-Forwarded-Encrypted: i=1; AJvYcCVCroEYOPixS9dlVttdMbHC28IgzvFFTW7BmflNTpznuX3KYmggBRf9iIMOj4p/eqLl48hQFG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqunClL7oAQ6kVf1jp0c+wJBYoHEOnod1hUVKRCMOajFT9gBKq
	VK2NuPCrgpkvNPGQj2b569kzE5N6S+EDwotZP8uhch1lAJPCktO8NGI/bPoq7MqXkpVMRdKWrEb
	H7vSNll+CNSy8LU9DvEcNwD/JR+wPRklmIjr4T2eEl5yI0v1aFzdU5XI=
X-Google-Smtp-Source: AGHT+IHBeNqk2lHHEUCTWTeeNPNVXZdTgTPBAFQ7ants6e0QK3fMVX53lkEFnIzHY4Bd0FR4mng11fvlcIahq6GypuS48AaYpITd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3201:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3c2d1aa2b75mr497678895ab.1.1736211329546; Mon, 06 Jan 2025
 16:55:29 -0800 (PST)
Date: Mon, 06 Jan 2025 16:55:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677c7b81.050a0220.3b3668.00f3.GAE@google.com>
Subject: [syzbot] [net?] WARNING in max_vclocks_store
From: syzbot <syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0bc21e701a6f MAINTAINERS: Remove Olof from SoC maintainers
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162d16c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
dashboard link: https://syzkaller.appspot.com/bug?extid=94d20db923b9f51be0df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133f76df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d198b0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ddf8c394b52/disk-0bc21e70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1f9219449bc/vmlinux-0bc21e70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd6fd63b12da/bzImage-0bc21e70.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5824 at mm/page_alloc.c:4729 __alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4729
Modules linked in:
CPU: 0 UID: 0 PID: 5824 Comm: syz-executor276 Not tainted 6.13.0-rc5-syzkaller-00012-g0bc21e701a6f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4729
Code: 24 2c 00 00 00 00 89 cd 0f 84 8b f9 ff ff 8b 34 24 48 89 da 8b 7c 24 08 e8 de b2 fe ff e9 69 f9 ff ff c6 05 c4 6c 16 0e 01 90 <0f> 0b 90 31 db e9 9f f3 ff ff 89 14 24 e8 6f a4 0c 00 8b 14 24 e9
RSP: 0018:ffffc900038778d8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000016 RDI: 0000000000040dc0
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000001 R12: 0000000000000016
R13: 0000000000040dc0 R14: 1ffff9200070ef2f R15: ffff88802f8ae7f0
FS:  0000555559c97480(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f29b5b130d0 CR3: 00000000751b4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x84/0x1b0 mm/slub.c:4243
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4270
 __do_kmalloc_node mm/slub.c:4286 [inline]
 __kmalloc_noprof.cold+0xc/0x63 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kmalloc_array_noprof include/linux/slab.h:946 [inline]
 max_vclocks_store+0x212/0x390 drivers/ptp/ptp_sysfs.c:299
 dev_attr_store+0x55/0x80 drivers/base/core.c:2439
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f29b5a9c179
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff7b40a938 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f29b5a9c179
RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 00007fff7b40a970 R15: 0000000000000001
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

