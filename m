Return-Path: <netdev+bounces-244686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F26ECBC708
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 05:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90B23300925E
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 04:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025202D77E6;
	Mon, 15 Dec 2025 04:03:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B30A29BDB1
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765771421; cv=none; b=u3qVsuBG2McMMpp6ivqbW/45CdZM+G0133vnhDy9iQSZZBxHaUnHdJ+sXaQYeumYtzZQ8qTzQlNaiT3ZfAgWYhEvLafx8CwX3cKrtfNqd7AKeFrzPV/yztU0TvlwYocD1pTSVgJda37X4IDDJ7pvlncro7kWxSRE7u7y7BQnk3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765771421; c=relaxed/simple;
	bh=rwoF+WpieHw/5tdj/KlFRevZ/13XeLEp1pLGyDW7534=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L2WeuUGobw3wAjgP0OzyOIxkeMX8CDgF5KVrW428UbH+hRvsWujl06KCWpWAOnpsUhBQdY/OkRhooDnlo2nu/fm2cJWu1m6p2qP2oEs+yI2ZpcevmdG7SBC3vUKXB/f+ZDValqRU7X6sC+TAhLzZCSOGI8e/nu5XluIovgFDaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7c7046514a2so3161392a34.0
        for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 20:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765771419; x=1766376219;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmfiToVqYEdoGnP02QZ7kBOEjbLn+XKul7lu1OSqyBE=;
        b=ZiG8wBIYlJkfnMMnkDORRITp1CHZX6CRmtFVufY6kwCtujBVvr2p6W0EZ9TIJTLtOG
         3gtZclIYZUwQwfA9ut22NksVMmkXOd173mRHBA3QSFuVpbrFJKskq3aP+M8AzW2PtCuF
         Lr5KB8sRGq1ZtST5GhLRE9xwWgL6Vs6v4oODGh41v8DR4hf2H3GUH7NdR79s+aydiavj
         1yGtksVXP773tm06t2LI8GRRJqqmviByzsTqjQrgrXo7tWrnujVeMGJ6AKFhVGR4zajx
         Fh7W8utClrygutmT8gmUVhP7ThF1qFd0IWGfyx8tCpiRwGTa2zYaquys050mjxrYIv4e
         kAUw==
X-Forwarded-Encrypted: i=1; AJvYcCWnsSmDRgTyht1+2uHBT00Bgg7et3LXkbLKb0wT3ReMNERlEsJUMOHAEWgjUIh2fNhbQxNByjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHe7KKLqexpLbs0ckWSA0l5U7ZWtzY6o55dXoN59AAkzGvgCG
	wIBn5CiiUrHkuuPhj5yp2BMvL/ILwg69tijbHtX0JmrfYXrmMpnDOonzf/kbQ2Cxf2hBxfgfMb+
	ZXXtgHmirU5u1SsxT+82W4AA6pwt2VmcAGcJ/1n4GApSoYzeuW3BNqIOJ8N0=
X-Google-Smtp-Source: AGHT+IF2vR0wcOITyycAoR9eiF3AvPDKMTzvhSTJ47P//qdt0ubo+nngiXW/6EmPeDnCg5LEquFKztzjePggC4UjwsKLqnuS7io0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a1:b0:659:9a49:8dec with SMTP id
 006d021491bc7-65b45225e82mr4312883eaf.46.1765771419323; Sun, 14 Dec 2025
 20:03:39 -0800 (PST)
Date: Sun, 14 Dec 2025 20:03:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693f889b.a70a0220.104cf0.0333.GAE@google.com>
Subject: [syzbot] [libertas?] [usb?] WARNING in usb_tx_block
From: syzbot <syzbot+67969ab6a2551c27f71b@syzkaller.appspotmail.com>
To: libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d358e5254674 Merge tag 'for-6.19/dm-changes' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=116b511a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53f37db573e619b
dashboard link: https://syzkaller.appspot.com/bug?extid=67969ab6a2551c27f71b
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156b511a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17278d92580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/584561f65dc7/disk-d358e525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b9b8f5af8d1/vmlinux-d358e525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b2313fb12366/bzImage-d358e525.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67969ab6a2551c27f71b@syzkaller.appspotmail.com

------------[ cut here ]------------
URB ffff888114e55c00 submitted while active
WARNING: drivers/usb/core/urb.c:380 at 0x0, CPU#0: kworker/0:1/10
Modules linked in:
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: events request_firmware_work_func
RIP: 0010:usb_submit_urb+0x15a3/0x1970 drivers/usb/core/urb.c:380
Code: 4b 03 00 00 48 8b 04 24 48 8b 90 b0 00 00 00 eb 91 bb ed ff ff ff e9 07 f3 ff ff e8 97 f5 c5 fc 48 8d 3d 50 45 f0 05 48 89 de <67> 48 0f b9 3a bb f0 ff ff ff e9 e9 f2 ff ff e8 79 f5 c5 fc 0f 1f
RSP: 0018:ffffc900000af8d0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888114e55c00 RCX: ffffffff8427b986
RDX: ffff888101ab1d40 RSI: ffff888114e55c00 RDI: ffffffff8aaa3c30
RBP: ffff888114e55c00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: ffff888101ab27e8 R12: 00000000c0030300
R13: 0000000000000010 R14: ffff888105a92000 R15: ffff88811ecda000
FS:  0000000000000000(0000) GS:ffff888268bf5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056311e50a970 CR3: 0000000114500000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 usb_tx_block+0x241/0x2e0 drivers/net/wireless/marvell/libertas/if_usb.c:436
 if_usb_issue_boot_command drivers/net/wireless/marvell/libertas/if_usb.c:766 [inline]
 if_usb_prog_firmware+0x570/0x10c0 drivers/net/wireless/marvell/libertas/if_usb.c:859
 lbs_fw_loaded drivers/net/wireless/marvell/libertas/firmware.c:23 [inline]
 helper_firmware_cb drivers/net/wireless/marvell/libertas/firmware.c:80 [inline]
 helper_firmware_cb+0x1f8/0x2e0 drivers/net/wireless/marvell/libertas/firmware.c:64
 request_firmware_work_func+0x13c/0x250 drivers/base/firmware_loader/main.c:1152
 process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x74f/0xa30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
----------------
Code disassembly (best guess):
   0:	4b 03 00             	rex.WXB add (%r8),%rax
   3:	00 48 8b             	add    %cl,-0x75(%rax)
   6:	04 24                	add    $0x24,%al
   8:	48 8b 90 b0 00 00 00 	mov    0xb0(%rax),%rdx
   f:	eb 91                	jmp    0xffffffa2
  11:	bb ed ff ff ff       	mov    $0xffffffed,%ebx
  16:	e9 07 f3 ff ff       	jmp    0xfffff322
  1b:	e8 97 f5 c5 fc       	call   0xfcc5f5b7
  20:	48 8d 3d 50 45 f0 05 	lea    0x5f04550(%rip),%rdi        # 0x5f04577
  27:	48 89 de             	mov    %rbx,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	bb f0 ff ff ff       	mov    $0xfffffff0,%ebx
  34:	e9 e9 f2 ff ff       	jmp    0xfffff322
  39:	e8 79 f5 c5 fc       	call   0xfcc5f5b7
  3e:	0f                   	.byte 0xf
  3f:	1f                   	(bad)


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

