Return-Path: <netdev+bounces-164860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3616CA2F67F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9243218836CA
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACC92253B0;
	Mon, 10 Feb 2025 18:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD525B693
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211082; cv=none; b=i/6XCRroUFQHG8uicX+7zxda5n/TJtuW1tY6Yuk7SO6SAQoqr1GxeTlAGp0RoZHSdwZnPnwlaBQfw/XROf4sNaR8kN1ckziyl6P5GkKh2Bkdcn3zzlGpzo9Gq5vKXBGtl7N4GtaCdInOjVzbF8djqHkmg5Nthzrexkhtatrcr5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211082; c=relaxed/simple;
	bh=uGO1CdY++0LxTNG1UPJz1ESlgJkfuvMFfPrFf9UaGjY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EdgTOjBgR8mZfcvNpdE7AhXNGTbEuCTlGJCqQJmW2cvuN2Nw5spT42yb1nCY0CgGS5F6KBUVFlpeWEvvDl370B2IU2upd0dFshEOU39vglS3WSqmIJbIgMAQww2QSlpwX4uu01M/ogRWcvyHLf2difMVvxmY2z1I3XNL/2ze7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-855418e04e5so60270739f.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211079; x=1739815879;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuL72nu9kcv2bTXn3eChmkygmSBm5cQNmdbeFEmtP+E=;
        b=RZyLgtU3G6+uuWqZCFAnBMAhT+WNtYdUov5+L1NEQ0XKUzGCuqtb4iYJ8Nwm7WWOkr
         PH8OLllSJxwuqx3I1GZMV5ZTyKEh31UO/Oet/8ugG1eAxWA48N5fmGctzY4IJIjcIbp6
         TGmUhq+elIiD6415LaV/nqr+IBhmb8dht2bRW2dXt9zYv8p8CB9nZrrIi2OXtE0xw85w
         2+Xa0fb6ja/3oTpDwjRfc4evKwKQqX5b9a0KW5M2kxqil2lC8JGOa6E0eL1MoGHsK/ry
         ZEBZmQO86HwsvgNnHNps2UjEXQSx5IOoCz6HYCdZ/B60xSw6cpxYYWqD9KDqvcbLDzO0
         N58g==
X-Forwarded-Encrypted: i=1; AJvYcCUDPubTRoBt4iRwkXBdVVr8c8K7U8VzGB1HjbjFihUzsDuUfx3p/UnG1iiKB3Hrt8HwSYokVa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3i/S1ojmdf+uUpHyiQ7MsVJoUHmz1WM/vYY9XhN5XeX6MBGoh
	q8nydNQ5qNfzpctnx44z16y6OMVeJqEUJnEza/kBzAJB1C5ctJvvhYMdYVEeiY0bEDmVls2VX1f
	zWpxZ7pUruGdsoomb6lY4yML6nU4wjuOwFmiY8TZGBxbr6b27EiGCeV8=
X-Google-Smtp-Source: AGHT+IEEbNDtXVqnXaewfgLpfOm/xaG4kKq/xHWqN4CJ+FbBv6siCo/VcSMl6/DysKYcgKRoxVxLaSWsZcEoxPOh5qN1WDqi69RZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ce:b0:3d0:1bc4:77a0 with SMTP id
 e9e14a558f8ab-3d13da22469mr122217325ab.0.1739211079624; Mon, 10 Feb 2025
 10:11:19 -0800 (PST)
Date: Mon, 10 Feb 2025 10:11:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67aa4147.050a0220.3d72c.0055.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in arp_create (3)
From: syzbot <syzbot+3b1dd14b3a62374e75c7@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7ee983c850b4 Merge tag 'drm-fixes-2025-02-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127b61b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=147b7d49d83b8036
dashboard link: https://syzkaller.appspot.com/bug?extid=3b1dd14b3a62374e75c7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54ead761f64f/disk-7ee983c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/95e57de2a045/vmlinux-7ee983c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d24a612a8ac7/bzImage-7ee983c8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b1dd14b3a62374e75c7@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000016: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000000b0-0x00000000000000b7]
CPU: 1 UID: 0 PID: 3448 Comm: kworker/u8:9 Not tainted 6.14.0-rc1-syzkaller-00181-g7ee983c850b4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: bat_events batadv_bla_periodic_work
RIP: 0010:arp_create+0x46/0x910 net/ipv4/arp.c:554
Code: 49 89 ce 89 54 24 3c 89 74 24 30 89 fb 49 bd 00 00 00 00 00 fc ff df e8 18 e6 62 f7 49 8d be b4 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 db 05 00 00 45 0f b7 a6 b4 00 00 00 49
RSP: 0018:ffffc9000c3a7870 EFLAGS: 00010203
RAX: 0000000000000016 RBX: 0000000000000002 RCX: ffff888031bcbc00
RDX: 0000000000000000 RSI: 0000000000000806 RDI: 00000000000000b4
RBP: ffffc9000c3a79f0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52001874f30 R12: ffffc9000c3a7aa0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4b41e61fa8 CR3: 000000007e55a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 batadv_bla_send_claim+0x16f/0xea0 net/batman-adv/bridge_loop_avoidance.c:361
 batadv_bla_send_announce net/batman-adv/bridge_loop_avoidance.c:675 [inline]
 batadv_bla_periodic_work+0x5dc/0xaf0 net/batman-adv/bridge_loop_avoidance.c:1481
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:arp_create+0x46/0x910 net/ipv4/arp.c:554
Code: 49 89 ce 89 54 24 3c 89 74 24 30 89 fb 49 bd 00 00 00 00 00 fc ff df e8 18 e6 62 f7 49 8d be b4 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 db 05 00 00 45 0f b7 a6 b4 00 00 00 49
RSP: 0018:ffffc9000c3a7870 EFLAGS: 00010203
RAX: 0000000000000016 RBX: 0000000000000002 RCX: ffff888031bcbc00
RDX: 0000000000000000 RSI: 0000000000000806 RDI: 00000000000000b4
RBP: ffffc9000c3a79f0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52001874f30 R12: ffffc9000c3a7aa0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4b41e61fa8 CR3: 00000000348fa000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	49 89 ce             	mov    %rcx,%r14
   3:	89 54 24 3c          	mov    %edx,0x3c(%rsp)
   7:	89 74 24 30          	mov    %esi,0x30(%rsp)
   b:	89 fb                	mov    %edi,%ebx
   d:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  14:	fc ff df
  17:	e8 18 e6 62 f7       	call   0xf762e634
  1c:	49 8d be b4 00 00 00 	lea    0xb4(%r14),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 db 05 00 00    	jne    0x612
  37:	45 0f b7 a6 b4 00 00 	movzwl 0xb4(%r14),%r12d
  3e:	00
  3f:	49                   	rex.WB


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

