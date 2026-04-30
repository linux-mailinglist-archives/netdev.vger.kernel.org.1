Return-Path: <netdev+bounces-282900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKvIJRh282mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:32:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88384A4D42
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE23E30864DC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700D42DFA5B;
	Thu, 30 Apr 2026 15:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D32E7657
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562748; cv=none; b=YFOjLoyhaW8PqhV7ddK8FUKaCLCDFrugn/IKUfdUtr25dc5cnTp5Po2uzkkGrrxVVppQFMHDzMfrKjKI2CYxfETcmKqig6ZqOSif/tV1cC84ZqFCZuUoiNAKI2sBTr0Rse5k+2tdkRZHQB18RLJMdssT+0a6V6nGR5A4LObsCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562748; c=relaxed/simple;
	bh=Jb+W/c8q5pIXe64yihqmRs2snXid3xrVWxzGQEqzGso=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CfUN/v1zwi/ZD9/350S+2RhcyNVedHW9eWsLPgBmvP6vbvuc/61C5CV45Yjri9HsCw98980h9qx2KxJF7x7qcGe1STxKqMJ17YYUAjkaatR56Mcb+YAk4WjLTw6QMT2+IDZN9p5zNfKGtQkFdvhHBMDa5jV4YfbKRphN/sO/qa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-415583a6862so1878953fac.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562745; x=1778167545;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rq2+BnD3PgSUbQ80h6yebk3lUMErj3s/YmUC1cmrT1w=;
        b=LaAAz3yelgJGfJW3xky0iiThtxHEHC1PL8ygOeMYCCQ9/Y6IC4KbPruKRrq/ZT3r1s
         phwFGKaNkOMNaLbW2dyKHqgKMkL/KBBneM01STRXaJIZpe9QrKSVkE/WhI4fGM4R8z5s
         1wsibmWdC534RE6gQFHQD3Elw76/CgjqDQPReWACb0Tq5mNDYsjmCgd5V6fZQ6xLfCsR
         CbR2QzGDjFAkUdwnni3ZL7Rh2UJpR1kt96EUgrEB1JONmFEqxxDMNGRMkuT5haiWg67u
         XfFzNujtL5hGecgz5G641keofjNeB6mYUTNCG0ozNcQvhJXEixUL5ySo/syhpUCUZj0u
         GBaA==
X-Forwarded-Encrypted: i=1; AFNElJ81bZ08dGYCvRgMwTFR3F0+pUgR5TZSWZjg93fxmfgcEORNDsWXugHBT4cWFOmdLAyS2EY8bPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf0r03CD3i4+3gGSbNubLLPlwFhytc0GNrgaCUQqVXwMYbhJUQ
	I8PPAIOnmSRXkAWjMhUCsK3utQiH2b033JTAVsBE/E33QAdJU8M4uYpyqkJH0n/G3TItbNKMNqL
	0A8KMlaYJU8orYaxYFM52cBbeRwoo3UA8fC6iw2L1thZB0DaXuyriv1K5jq4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2f08:b0:696:2b58:4ac0 with SMTP id
 006d021491bc7-6967bdc8fe6mr913952eaf.35.1777562745581; Thu, 30 Apr 2026
 08:25:45 -0700 (PDT)
Date: Thu, 30 Apr 2026 08:25:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f37479.170a0220.5f1b.0003.GAE@google.com>
Subject: [syzbot] [net?] WARNING in hci_sock_sendmsg
From: syzbot <syzbot+8fe47b0d0d2830a8d3be@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E88384A4D42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=fff2b12da07ad];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-282900-lists,netdev=lfdr.de,8fe47b0d0d2830a8d3be];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email,appspotmail.com:email,storage.googleapis.com:url]

Hello,

syzbot found the following issue on:

HEAD commit:    9974969c1403 Add linux-next specific files for 20260428
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16056b6c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fff2b12da07ad
dashboard link: https://syzkaller.appspot.com/bug?extid=8fe47b0d0d2830a8d3be
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/755177aac4cc/disk-9974969c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fe2f57d4e79e/vmlinux-9974969c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15b13a4a7518/bzImage-9974969c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fe47b0d0d2830a8d3be@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_tx_work on wq hci0
WARNING: kernel/workqueue.c:2298 at __queue_work+0xd67/0x1010 kernel/workqueue.c:2296, CPU#1: syz.0.23/5836
Modules linked in:
CPU: 1 UID: 0 PID: 5836 Comm: syz.0.23 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:__queue_work+0xd87/0x1010 kernel/workqueue.c:2296
Code: 01 00 00 4c 8d 35 49 c5 21 0e 4c 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ef e8 b3 f6 a0 00 49 8b 75 00 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 48 83 c4 58 5b 41 5c 41 5d 41 5e 41 5f 5d e9 11 48
RSP: 0018:ffffc90005817958 EFLAGS: 00010046
RAX: 1ffff11004a2198f RBX: 0000000000000008 RCX: 0000000000080000
RDX: ffff888037302968 RSI: ffffffff8a252410 RDI: ffffffff8faf47a0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1004a2198d R12: dffffc0000000000
R13: ffff88802510cc78 R14: ffffffff8faf47a0 R15: ffff888037302968
FS:  00007f2b3bbfe6c0(0000) GS:ffff888125dd8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c459547 CR3: 000000004410a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2432
 queue_work include/linux/workqueue.h:696 [inline]
 hci_sock_sendmsg+0xb3d/0xf40 net/bluetooth/hci_sock.c:-1
 sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
 __sock_sendmsg net/socket.c:812 [inline]
 sock_write_iter+0x308/0x410 net/socket.c:1269
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2b3d9acdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2b3bbfe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2b3dc25fa0 RCX: 00007f2b3d9acdd9
RDX: 0000000000000006 RSI: 0000200000000240 RDI: 0000000000000006
RBP: 00007f2b3da42d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2b3dc26038 R14: 00007f2b3dc25fa0 R15: 00007fffb59042a8
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	4c 8d 35 49 c5 21 0e 	lea    0xe21c549(%rip),%r14        # 0xe21c552
   9:	4c 89 e8             	mov    %r13,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  15:	74 08                	je     0x1f
  17:	4c 89 ef             	mov    %r13,%rdi
  1a:	e8 b3 f6 a0 00       	call   0xa0f6d2
  1f:	49 8b 75 00          	mov    0x0(%r13),%rsi
  23:	4c 89 f7             	mov    %r14,%rdi
  26:	4c 89 fa             	mov    %r15,%rdx
* 29:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2e:	48 83 c4 58          	add    $0x58,%rsp
  32:	5b                   	pop    %rbx
  33:	41 5c                	pop    %r12
  35:	41 5d                	pop    %r13
  37:	41 5e                	pop    %r14
  39:	41 5f                	pop    %r15
  3b:	5d                   	pop    %rbp
  3c:	e9                   	.byte 0xe9
  3d:	11                   	.byte 0x11
  3e:	48                   	rex.W


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

