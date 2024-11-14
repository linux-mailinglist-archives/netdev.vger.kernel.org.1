Return-Path: <netdev+bounces-145001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2049C915C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0773B2548D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF46217BEB7;
	Thu, 14 Nov 2024 17:04:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E674757EA
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603868; cv=none; b=Uu+xcBo+pk9+79/4nQDTheZfShmisOgJqeHkuP+kRQ6Zs0erYP6L0hay+dSgvAL3mRJoJQiOjRT2gpussIQ45wuKFJQL3YNxZVIcX76fjr228sDEhfBD5e389bfCL2IgEcjvu4G//WzTUmXPR9e8bWz79sDDbXofuVwWIoRY3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603868; c=relaxed/simple;
	bh=E4Gu0GdLFo1+Zezjda792lmrck7dWGTLGV696hio58c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pDASbgzUK0FbyUAgiuLPAC0d/9I81bb6wdc+dJXEqDCqOeLCHzrpCdW/77SzhkmP1lsI2FjNYIvQaSQNkphxtilZm8or0TDHLq0iOs3CDuZD/ZOAoFwok7maV6vDBvXsruflNHnKtnoFXGBXs8T6H4oCtGH3fsX8Fv08i5ehE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83abb2b6d42so84174239f.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603866; x=1732208666;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCO4+P4QVyx+tLjBloCWsv4xEmws5gF5C66XONteBtI=;
        b=k8sC/yW2myhcvIl04KYlo8fVd6vua6/Os36MS+mDZoAHgJJyaxmJ5K9bULxQfUoy1I
         0sDfyBtkDHkz2u8mSToWZW33aornNrHM8p7+rGQkOC1dICnDLAxbtAtAGFHy2ybBP/uS
         SrZ6QoosZ4dIOSovk/XNbgcGckJa0PciamQC6VLdETG2HjUi3B6d+QH1mOyhCTGJ3VvY
         uOCskVM7F1foE2Wpvc7Kk2DsBeu745QfU5g+51ejwwS8vn9xfxcLiTr9b/eIqileB+/Q
         SVWrOj7h16M1dpPBCDC1NjFeMy+v+8T+yC3XqC/gRNccDA2GH9gf+5Bif1Tym0EFov95
         +4fw==
X-Forwarded-Encrypted: i=1; AJvYcCVqBa7BIsP7AOFplShrZjj2Cb+2GlL6M9+6PbPmcvs/ymGUwyjG0Skxv0pkHLGBQoZx4fBuhjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvcVgmAkGG5v5gMFH2eNHQ8g8rE5bXVvsiCOKU12280sLezNgF
	1ou48raNuv6wPjHJUZecP7mnE4UgzaKpQw2U2CLCGFnImGbo/35ViKWq+tMLZH3w+5m1xDG054x
	0MAubIg2VIM060HxYG74vsQAlAPhq+Vw2S1MIYr/DeogAlMBmi+nzZOU=
X-Google-Smtp-Source: AGHT+IEveP6B+40mgim/WP2jcRpUflbQMLB11+F7Oy3bRcN61GF0UEhTArjg5chJIWyuJ3OTcLUK892eo8qxI6pagbbIZLaK8pYT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a6:b0:3a4:e4d0:9051 with SMTP id
 e9e14a558f8ab-3a71578e2d8mr81031775ab.24.1731603864857; Thu, 14 Nov 2024
 09:04:24 -0800 (PST)
Date: Thu, 14 Nov 2024 09:04:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67362d98.050a0220.1324f8.009b.GAE@google.com>
Subject: [syzbot] [net?] BUG: corrupted list in nsim_bpf_destroy_prog
From: syzbot <syzbot+f57a59b585e797d8c9b8@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    252e01e68241 selftests: net: add netlink-dumps to .gitignore
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=157ce35f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
dashboard link: https://syzkaller.appspot.com/bug?extid=f57a59b585e797d8c9b8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2459f940e3b8/disk-252e01e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b3823596aaa/vmlinux-252e01e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf011fb97648/bzImage-252e01e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f57a59b585e797d8c9b8@syzkaller.appspotmail.com

list_del corruption. prev->next should be ffff8880334808a8, but was ffff88805f2f43c0. (prev=ffff88805f2f43c0)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.12.0-rc6-syzkaller-00169-g252e01e68241 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: events bpf_prog_free_deferred
RIP: 0010:__list_del_entry_valid_or_report+0x11b/0x140 lib/list_debug.c:62
Code: 00 07 90 0f 0b 48 c7 c7 a0 0d 61 8c 4c 89 fe e8 0b 8f 00 07 90 0f 0b 48 c7 c7 00 0e 61 8c 4c 89 fe 48 89 d9 e8 f6 8e 00 07 90 <0f> 0b 48 c7 c7 80 0e 61 8c 4c 89 fe 4c 89 f1 e8 e1 8e 00 07 90 0f
RSP: 0018:ffffc900000d7a00 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88805f2f43c0 RCX: 67b0c67390e66700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900000d7b38 R08: ffffffff8174a18c R09: fffffbfff1cf9fd0
R10: dffffc0000000000 R11: fffffbfff1cf9fd0 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88805f2f43c0 R15: ffff8880334808a8
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c38e396 CR3: 000000006435a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 nsim_bpf_destroy_prog+0xd9/0x1f0 drivers/net/netdevsim/bpf.c:281
 __bpf_prog_offload_destroy kernel/bpf/offload.c:113 [inline]
 bpf_prog_dev_bound_destroy+0x2aa/0x590 kernel/bpf/offload.c:392
 bpf_prog_free_deferred+0x3c5/0x710 kernel/bpf/core.c:2796
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x11b/0x140 lib/list_debug.c:62
Code: 00 07 90 0f 0b 48 c7 c7 a0 0d 61 8c 4c 89 fe e8 0b 8f 00 07 90 0f 0b 48 c7 c7 00 0e 61 8c 4c 89 fe 48 89 d9 e8 f6 8e 00 07 90 <0f> 0b 48 c7 c7 80 0e 61 8c 4c 89 fe 4c 89 f1 e8 e1 8e 00 07 90 0f
RSP: 0018:ffffc900000d7a00 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88805f2f43c0 RCX: 67b0c67390e66700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900000d7b38 R08: ffffffff8174a18c R09: fffffbfff1cf9fd0
R10: dffffc0000000000 R11: fffffbfff1cf9fd0 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88805f2f43c0 R15: ffff8880334808a8
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8c75d062d8 CR3: 0000000064358000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

