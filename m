Return-Path: <netdev+bounces-280342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCarNRN+6GkILAIAu9opvQ
	(envelope-from <netdev+bounces-280342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:51:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76889443289
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DEAE3019768
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA10737472A;
	Wed, 22 Apr 2026 07:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DFC373BFE
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776844304; cv=none; b=Q3vPczrxHeolNL7D4/nvlZs+M257yGnSi3Q2WDAbS69JmWQp2f7ih8pmyw5N6nOi8wPAv+WdLRWztePSnB6O6wAso/uHQSGv9t55eP4XnPTHyWPaPKQxKzbFl1ugSAfTlZHGh6UDfxR0evpXLY6Sz4Cn5IMVn7J81+XBPbPXKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776844304; c=relaxed/simple;
	bh=uz50e6kKi+gecwJeLSmSi5WIe28Q/cThNyzOT4OhYug=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dXP3+vMQdWf462Vt13RuyNVhXvorWUYY/C3azO0rvqZJ7JKxSyWg/Spre2yf2aVKHmCHazJfbsIYvkFsFX4zbqOxcSMB/40kjzhTsXJ2GCfK4TTRqaQJAWVqEOI2yK01k1F6x+ZwnqdlAt1dca4RdXv0P8aUzoAprui0mV2VdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-695aebf3cc7so82044eaf.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776844302; x=1777449102;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmKoKlOtq5xFYibPDAhkTBUfGvIp8mpKFDyfn2VXSqo=;
        b=dR+wJWlM0AHRJt/lgDnDT1ZusKmS7QCz+qnM/O3IYJaWSzhAVnvyeX3D6MtI1camSH
         EDNACyM6SUIrZLSDsJTaHbRfSUwSWtnqzNayWvY2IATe58UYl5FJzqFcdiKAntiz1Rxo
         DBv2mlqc++oldIiTfyl3xZGgd6luPjK8+j2n0KteZF7OQXWffrK8N4/nTpAnsFaxF85/
         86RkxUlx9spaErWHc6XIIlOB1Mk+LgiEvCkHDqppqSbg3i8A4nxiahfW1S3/LpFL6ZwW
         seJvIw8mCd6MJe7r/kutK8GTU90YFfv4bdqIQ1MbF76vxSqcFYwXhLE37OSY4yFEItto
         Z0ww==
X-Forwarded-Encrypted: i=1; AFNElJ/ttN7nyTdG7e2Zp3/WiCzCt8CkrK0UAEQT96YxfsAobL+BdDR0CH5SqA8V4Tg/ZtQSbDGkbr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2zt48bzsfigcp2ZCwsAjwS+HYoOTbEVmwWH8vYCp02Aquc6eK
	CBcqvHiAzORYQNHoYcao0KThJXOv/pOvsIbFJrW2GPclOGQV/wC3QfHXYNq1Z2gHXmYyzgA6w1D
	Ztlo2KXUUic0vNVHYUBJF/JvMskhaFH2Rh7CVcCWwb8p1P42Tb4y85RGMV/o=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1743:b0:685:d435:1471 with SMTP id
 006d021491bc7-69462e21d8cmr11582809eaf.10.1776844302197; Wed, 22 Apr 2026
 00:51:42 -0700 (PDT)
Date: Wed, 22 Apr 2026 00:51:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e87e0e.a00a0220.9259.001b.GAE@google.com>
Subject: [syzbot] [atm?] general protection fault in atmtcp_ioctl
From: syzbot <syzbot+52bbaea57234493b6b17@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=95729ed00549063a];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280342-lists,netdev=lfdr.de,52bbaea57234493b6b17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.sourceforge.net,vger.kernel.org,googlegroups.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,googlegroups.com:email,goo.gl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 76889443289
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    1f5ffc672165 Fix mismerge of the arm64 / timer-core interr..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14b72c36580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95729ed00549063a
dashboard link: https://syzkaller.appspot.com/bug?extid=52bbaea57234493b6b17
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b552538b97f/disk-1f5ffc67.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/724a3a1d69d7/vmlinux-1f5ffc67.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea684969e2c2/bzImage-1f5ffc67.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52bbaea57234493b6b17@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 15453 Comm: syz.2.2407 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
RIP: 0010:atmtcp_attach drivers/atm/atmtcp.c:408 [inline]
RIP: 0010:atmtcp_ioctl+0x860/0xdf0 drivers/atm/atmtcp.c:477
Code: ff e9 b4 fb ff ff 4c 8d 63 20 4c 89 e0 48 c1 e8 03 80 3c 28 00 74 08 4c 89 e7 e8 cb 21 0b fb 4d 8b 24 24 4c 89 e0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 e7 e8 b2 21 0b fb 49 83 3c 24 00 0f 84 f0
RSP: 0018:ffffc9000f6b7c30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888037f2f000 RCX: ffffffff8bb4829e
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc9000f6b7b80
RBP: dffffc0000000000 R08: ffffc9000f6b7b87 R09: 1ffff92001ed6f70
R10: dffffc0000000000 R11: fffff52001ed6f71 R12: 0000000000000000
R13: 1ffff11006fe5e00 R14: ffff88808ac0d440 R15: ffff88803234e000
FS:  00007fd42b7c26c0(0000) GS:ffff888125345000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001944 CR3: 00000000358e6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 do_vcc_ioctl+0x36d/0x9d0 net/atm/ioctl.c:159
 sock_do_ioctl+0x101/0x320 net/socket.c:1313
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1434
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd42a99c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd42b7c2028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd42ac15fa0 RCX: 00007fd42a99c819
RDX: 0000000000000000 RSI: 0000000000006180 RDI: 0000000000000008
RBP: 00007fd42aa32c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd42ac16038 R14: 00007fd42ac15fa0 R15: 00007ffe8b9d1618
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:atmtcp_attach drivers/atm/atmtcp.c:408 [inline]
RIP: 0010:atmtcp_ioctl+0x860/0xdf0 drivers/atm/atmtcp.c:477
Code: ff e9 b4 fb ff ff 4c 8d 63 20 4c 89 e0 48 c1 e8 03 80 3c 28 00 74 08 4c 89 e7 e8 cb 21 0b fb 4d 8b 24 24 4c 89 e0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 e7 e8 b2 21 0b fb 49 83 3c 24 00 0f 84 f0
RSP: 0018:ffffc9000f6b7c30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888037f2f000 RCX: ffffffff8bb4829e
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc9000f6b7b80
RBP: dffffc0000000000 R08: ffffc9000f6b7b87 R09: 1ffff92001ed6f70
R10: dffffc0000000000 R11: fffff52001ed6f71 R12: 0000000000000000
R13: 1ffff11006fe5e00 R14: ffff88808ac0d440 R15: ffff88803234e000
FS:  00007fd42b7c26c0(0000) GS:ffff888125345000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3d9593 CR3: 00000000358e6000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	ff                   	ljmp   (bad)
   1:	e9 b4 fb ff ff       	jmp    0xfffffbba
   6:	4c 8d 63 20          	lea    0x20(%rbx),%r12
   a:	4c 89 e0             	mov    %r12,%rax
   d:	48 c1 e8 03          	shr    $0x3,%rax
  11:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  15:	74 08                	je     0x1f
  17:	4c 89 e7             	mov    %r12,%rdi
  1a:	e8 cb 21 0b fb       	call   0xfb0b21ea
  1f:	4d 8b 24 24          	mov    (%r12),%r12
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 e7             	mov    %r12,%rdi
  33:	e8 b2 21 0b fb       	call   0xfb0b21ea
  38:	49 83 3c 24 00       	cmpq   $0x0,(%r12)
  3d:	0f                   	.byte 0xf
  3e:	84 f0                	test   %dh,%al


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

