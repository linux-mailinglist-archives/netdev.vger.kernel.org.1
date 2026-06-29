Return-Path: <netdev+bounces-302554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o0TaFv1CQmrp2wkAu9opvQ
	(envelope-from <netdev+bounces-302554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:03:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A23E96D89B9
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:03:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302554-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302554-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8994300C022
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AE4392C2A;
	Mon, 29 Jun 2026 09:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664E30FC1A
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:53:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726805; cv=none; b=RAlsDGmgLitMnwhywh6h7+hC4uRdn3gVCxAy3xPe6ho4lSmj4XWNlFwbVpTfh3djj78IJvqzH3/YCA784ofusKJY39Ciyl+z6NIgUs3CuG7GTVTFTLm6UAo5Pcar6riKzitSjsGJq3fSbms7aiYKSrxUXGSnLO4UTPM7dhmiRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726805; c=relaxed/simple;
	bh=EeAtNXFftreVObAkoFRjv6jWjUd6N8FSqqOBu4hG4BQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bk9YEWPHc3chf/1TTTKzNFWX4VIz2cCSCp0peGgpYcr6/opuh+05hWsWog74npUx0Y5LQkYzBN5Eg7Zzx0ZnOJWzRGEIFFtPoih0PHb6TlGRp8DjMEO1SSU9xFFn+f140sAEcneXVq2U8wNaVFmStwtHWZ1rknVEe8+4mXGZY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-48f680bda84so5037217b6e.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726803; x=1783331603;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwymUYCwEopcwvNdbgWdE3V4iVchDza5/5toUHvwG2c=;
        b=LDGdDbeszmVKLEhv//vBpvLDS/Ck1QqeYX5mEK7pE70b+XNNr+98zrD0piPh3vrUd8
         /wQ/4r8NMZXl9lncl6AAjgRw+i7qykZAT1Xh+GRiNJye6IEjnCGR2oMCDEzdAsM6O9ww
         wymCa8rWnuEuatqEpDLSZDjKvbFxAb8VM1zKNO9GF3w0k9ogCjSIW9qmulVvW6Z7rpjj
         iTCj0Oa3//ElEJKa7LQLBSYsCU8hNYwYFlLjgQ0gJP1jdRfRmlxkcf6XRW76DXom7Yer
         2ctp0EP4QpK3WWKVf8EpxCHGS8xesVMSIxyQ6usctcCMsgJdRTYcGlqsJDRFepU4dKxZ
         PSrw==
X-Forwarded-Encrypted: i=1; AFNElJ/0gyvnqdRJs6oaNoAOaGabxDWpMXHJYa5EDs8F6vNoOktWc8FQHlLO0dhZMYUT7UNpdqQdDAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCj9yBt72+z6XjMLNgFgTPnL36oXuycAmmnaF0mY5uK/vqMzRf
	GpID360LXsfEqbGPr6GkBWnsr2mp1HugqsRULjIEpEirSyCCXjKIsyiL0lKONNcSvuQMfVLmdJa
	DYwqIaGJ0W7vzHn+2FSPA74FOvlr1wdO47Q6O7fquAj5pF+jpKNRsviiE+F8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:ec2:b0:491:3ade:8b9e with SMTP id
 5614622812f47-4921801d78fmr13471084b6e.36.1782726803455; Mon, 29 Jun 2026
 02:53:23 -0700 (PDT)
Date: Mon, 29 Jun 2026 02:53:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a424093.34acba0d.134e3f.00b1.GAE@google.com>
Subject: [syzbot] [wpan?] general protection fault in ieee802154_release_queue
From: syzbot <syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302554-lists,netdev=lfdr.de,36256deb69a588e9290e];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,goo.gl:url,googlegroups.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url,syzkaller.appspotmail.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:alex.aring@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wpan@vger.kernel.org,m:miquel.raynal@bootlin.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:stefan@datenfreihafen.org,m:syzkaller-bugs@googlegroups.com,m:alexaring@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,bootlin.com,redhat.com,datenfreihafen.org,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A23E96D89B9

Hello,

syzbot found the following issue on:

HEAD commit:    b85966adbf5d Merge tag 'net-next-7.2' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17ac7046580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544
dashboard link: https://syzkaller.appspot.com/bug?extid=36256deb69a588e9290e
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d65306d96573/disk-b85966ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef43139aab0e/vmlinux-b85966ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26d4d1ab67c3/bzImage-b85966ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000043: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0xdead000000000218-0xdead00000000021f]
CPU: 1 UID: 0 PID: 15064 Comm: syz.4.2289 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:ieee802154_wake_queue net/mac802154/util.c:34 [inline]
RIP: 0010:ieee802154_release_queue+0x1b0/0x380 net/mac802154/util.c:83
Code: 42 80 3c 30 00 74 08 4c 89 e7 e8 8b f4 d0 f6 4d 8b 2c 24 4d 39 e5 0f 84 d6 00 00 00 4d 8d bd 18 01 00 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ff e8 61 f4 d0 f6 49 8b 2f 48 85 ed 74
RSP: 0018:ffffc90005f3f0d0 EFLAGS: 00010802
RAX: 1bd5a00000000043 RBX: ffff88802a41a760 RCX: 0000000000080000
RDX: ffffc90007f8c000 RSI: 000000000001e208 RDI: 000000000001e209
RBP: ffff88802a43c018 R08: ffffffff903116f7 R09: 1ffffffff20622de
R10: dffffc0000000000 R11: fffffbfff20622df R12: ffff88802a41a770
R13: dead000000000100 R14: dffffc0000000000 R15: dead000000000218
FS:  00007f6a783b06c0(0000) GS:ffff88812537c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8924187cc0 CR3: 00000000a6c7a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee802154_xmit_complete+0x11d/0x290 net/mac802154/util.c:140
 hwsim_hw_xmit+0x1571/0x1620 drivers/net/ieee802154/mac802154_hwsim.c:288
 drv_xmit_async net/mac802154/driver-ops.h:16 [inline]
 ieee802154_tx+0x26d/0x510 net/mac802154/tx.c:89
 ieee802154_hot_tx net/mac802154/tx.c:207 [inline]
 ieee802154_subif_start_xmit+0x110/0x190 net/mac802154/tx.c:239
 __netdev_start_xmit include/linux/netdevice.h:5387 [inline]
 netdev_start_xmit include/linux/netdevice.h:5396 [inline]
 xmit_one net/core/dev.c:3889 [inline]
 dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3905
 sch_direct_xmit+0x257/0x4c0 net/sched/sch_generic.c:372
 __dev_xmit_skb net/core/dev.c:4211 [inline]
 __dev_queue_xmit+0x1754/0x37f0 net/core/dev.c:4833
 dev_queue_xmit include/linux/netdevice.h:3436 [inline]
 dgram_sendmsg+0x709/0xe30 net/ieee802154/socket.c:689
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x9b9/0xa20 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmmsg+0x273/0x4d0 net/socket.c:2827
 __do_sys_sendmmsg net/socket.c:2854 [inline]
 __se_sys_sendmmsg net/socket.c:2851 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2851
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6a7759ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6a783b0028 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f6a77815fa0 RCX: 00007f6a7759ce59
RDX: 0000000004000050 RSI: 00002000000196c0 RDI: 000000000000000d
RBP: 00007f6a77632e6f R08: 0000000000000000 R09: 0000000000000000
R10: 000000000400c010 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6a77816038 R14: 00007f6a77815fa0 R15: 00007ffe3e47cbf8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ieee802154_wake_queue net/mac802154/util.c:34 [inline]
RIP: 0010:ieee802154_release_queue+0x1b0/0x380 net/mac802154/util.c:83
Code: 42 80 3c 30 00 74 08 4c 89 e7 e8 8b f4 d0 f6 4d 8b 2c 24 4d 39 e5 0f 84 d6 00 00 00 4d 8d bd 18 01 00 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ff e8 61 f4 d0 f6 49 8b 2f 48 85 ed 74
RSP: 0018:ffffc90005f3f0d0 EFLAGS: 00010802
RAX: 1bd5a00000000043 RBX: ffff88802a41a760 RCX: 0000000000080000
RDX: ffffc90007f8c000 RSI: 000000000001e208 RDI: 000000000001e209
RBP: ffff88802a43c018 R08: ffffffff903116f7 R09: 1ffffffff20622de
R10: dffffc0000000000 R11: fffffbfff20622df R12: ffff88802a41a770
R13: dead000000000100 R14: dffffc0000000000 R15: dead000000000218
FS:  00007f6a783b06c0(0000) GS:ffff88812537c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8924187cc0 CR3: 00000000a6c7a000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
   5:	74 08                	je     0xf
   7:	4c 89 e7             	mov    %r12,%rdi
   a:	e8 8b f4 d0 f6       	call   0xf6d0f49a
   f:	4d 8b 2c 24          	mov    (%r12),%r13
  13:	4d 39 e5             	cmp    %r12,%r13
  16:	0f 84 d6 00 00 00    	je     0xf2
  1c:	4d 8d bd 18 01 00 00 	lea    0x118(%r13),%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ff             	mov    %r15,%rdi
  34:	e8 61 f4 d0 f6       	call   0xf6d0f49a
  39:	49 8b 2f             	mov    (%r15),%rbp
  3c:	48 85 ed             	test   %rbp,%rbp
  3f:	74                   	.byte 0x74


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

