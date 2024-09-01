Return-Path: <netdev+bounces-124006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF2496758C
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 10:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017271C20F7F
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 08:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F68143887;
	Sun,  1 Sep 2024 08:24:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8AF1420B0
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725179069; cv=none; b=KTK7C6X/WEzG/R2cN0GnC53g1KA5p4ElinB799Tn4vkpYyhdOlF8Vjqi8C9PZIR14kE9xHlUk9+jGA2zU7j/8RAr5xqM2mCtwmqZgh8Js1wWVtqVEUQSq/3GZRf4Okfve3OTDnQMmoSWGd3ShSHtaajU5riDJ1FGWAX6VDyU3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725179069; c=relaxed/simple;
	bh=VfJXLi/eYBS644okY+ARvvRY/DXHIZL5ktcbxHrOGM8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oNxXoH2v+nDCahK6oLZ/Ljb0pU5bpT3u1slA4/Z4DOzjhOv9rWcsq8/rxoLZfxQCye+hpBdCL0GSAmWHSzrT7Y48Jt8UntupDu6IRYAC235cj+jK6f/8HJi3UQAUEeL5cPtmM3PtMA+tJNvq1LpdlTCg3Gp/Ae0iVsT2dO6USfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a29c9d39dso178666039f.2
        for <netdev@vger.kernel.org>; Sun, 01 Sep 2024 01:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725179067; x=1725783867;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6oQUvwwPMAkmGzaNGxf9cx+QHwwYGucQ4Fcb6+88Jk=;
        b=XDr2hHt9KntgaPjF+OcmiECNt+OYGKMlHLIPFQEtlFNt0Hq53e9g6Bi6LBLIDgUbPH
         XQW/sJTg3St72Jd53Uw2SsJm8HW6YytNV5plxuCEtSGSy4KGEkzpx8oAp693bGAZXn9m
         cBmEN2/4X/wsXke9rCtJ9RRJJ78QodZLuGG21vvHFT9huqpMZb2aTAGICxTp9qOxJJrg
         z/hGDJnN+GqNqs+sLX9CduWE3pOsM7bsKh/HFsBctyXFPojRbX+jMGK4oAwlcJ60dy19
         2qPYDcB+VEDrCQQl+lx3cFd88bMC/xSdJrLgE9JZe58+tGyOG3BYAgLcL00nH5HY4+bZ
         gKWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM/nSWM0ZALcQ3JI67gSCkSp2hgMTqLE+iWGB6VbjhYaYkhwPtHmE7VHsPxwb4nMRKqH2LbKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxccfstFVgjp6pMX169cKJrbmU2qMOr17QopzgHulZAMenAFiI3
	XysfDWJ0+8IFfvX6IC5Qr/JyktMUyigXJS0xTBwWMmOM+swF6XVmHfpZXlh/aTOspot5juE/Uvn
	p1vfbLX+aU08WuFKHzU/JfxYwd8YBZ33dYsveQJVgr6c635mGlamYSBg=
X-Google-Smtp-Source: AGHT+IGuK0Oea3g2cY2ppVno8G3XqkBupzbqQOjuxONfqw7esT5UgZxMFvngCGPVCxfclxjvmJPjJQ2N3urTMrvioHQYZD+qAg1V
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a6:b0:4ce:54dc:fa44 with SMTP id
 8926c6da1cb9f-4d017d788fbmr413786173.1.1725179067112; Sun, 01 Sep 2024
 01:24:27 -0700 (PDT)
Date: Sun, 01 Sep 2024 01:24:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000782b4706210a8dcd@google.com>
Subject: [syzbot] [bluetooth?] BUG: corrupted list in mgmt_pending_remove
From: syzbot <syzbot+cc0cc52e7f43dc9e6df1@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe1910f9337b tcp_bpf: fix return value of tcp_bpf_sendmsg()
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=171d6f7b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=cc0cc52e7f43dc9e6df1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb37d16e2860/disk-fe1910f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/315198aa296e/vmlinux-fe1910f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3e6fb9fa8a4/bzImage-fe1910f9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc0cc52e7f43dc9e6df1@syzkaller.appspotmail.com

list_del corruption, ffff88802943da00->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 7763 Comm: syz.0.694 Not tainted 6.11.0-rc5-syzkaller-00151-gfe1910f9337b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 71 64 fc 06 90 0f 0b 48 c7 c7 c0 90 60 8c 4c 89 fe e8 5f 64 fc 06 90 0f 0b 48 c7 c7 20 91 60 8c 4c 89 fe e8 4d 64 fc 06 90 <0f> 0b 48 c7 c7 80 91 60 8c 4c 89 fe e8 3b 64 fc 06 90 0f 0b 48 c7
RSP: 0018:ffffc9000492fb58 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 5f038e50b22bff00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8174013c R09: 1ffff92000925f0c
R10: dffffc0000000000 R11: fffff52000925f0d R12: dffffc0000000000
R13: dffffc0000000000 R14: dead000000000100 R15: ffff88802943da00
FS:  00007fb7679de6c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc967a2fc0 CR3: 00000000437dc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 mgmt_pending_remove+0x26/0x1a0 net/bluetooth/mgmt_util.c:314
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 mgmt_index_removed+0xe6/0x340 net/bluetooth/mgmt.c:9395
 hci_sock_bind+0xcce/0x1150 net/bluetooth/hci_sock.c:1307
 __sys_bind_socket net/socket.c:1833 [inline]
 __sys_bind+0x23d/0x2f0 net/socket.c:1857
 __do_sys_bind net/socket.c:1865 [inline]
 __se_sys_bind net/socket.c:1863 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1863
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb767f79eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb7679de038 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007fb768116058 RCX: 00007fb767f79eb9
RDX: 0000000000000006 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007fb767fe793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb768116058 R15: 00007fffd1ff2828
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 71 64 fc 06 90 0f 0b 48 c7 c7 c0 90 60 8c 4c 89 fe e8 5f 64 fc 06 90 0f 0b 48 c7 c7 20 91 60 8c 4c 89 fe e8 4d 64 fc 06 90 <0f> 0b 48 c7 c7 80 91 60 8c 4c 89 fe e8 3b 64 fc 06 90 0f 0b 48 c7
RSP: 0018:ffffc9000492fb58 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 5f038e50b22bff00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8174013c R09: 1ffff92000925f0c
R10: dffffc0000000000 R11: fffff52000925f0d R12: dffffc0000000000
R13: dffffc0000000000 R14: dead000000000100 R15: ffff88802943da00
FS:  00007fb7679de6c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f773e8e8178 CR3: 00000000437dc000 CR4: 00000000003506f0
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

