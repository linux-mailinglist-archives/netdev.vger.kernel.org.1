Return-Path: <netdev+bounces-258826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBerFHCCkmnuuQEAu9opvQ
	(envelope-from <netdev+bounces-258826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 03:35:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB59140A97
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 03:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 429BA3002306
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 02:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C35285CAD;
	Mon, 16 Feb 2026 02:35:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E22BE02A
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 02:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771209325; cv=none; b=dp6MjrKNqNzCuk9aQHmAyuPWLIBFvVshL45PRdWZs1QgGFuDaqX5BLCj4Dx9MVUtxFwp8d/VK/x6/zvFkW6jb6faGDByoLTZvz9gk5p3td+le2dFIHWrcRK2EpPd/G+KVGbIPD93yrzGPk328kwxQmeXBYRgY9ORsZgQ4n7naa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771209325; c=relaxed/simple;
	bh=GQEa7gJOW5rm5wKgZzMmOJ1EY4oQtylppNdd5D0uh0M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Czek1CBUhjt5XaBljLMIK7aQq11FpYsVOSo/pwMS7uiSoECIu9kxmS4fV6Uaa35XcJrqi33QV0krNFbBakg9YMQjAhVsI98o9k71hEkzHrnBxTvp607sGogFhVAupnuv1bMSr30b3FLmNeUt3URP5gdos/FGGY88xU8lJyQIiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-66308f16ea1so26042151eaf.2
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 18:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771209322; x=1771814122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tF2VkkMzIBb059BR0PiOY7oxzQUj5OpQiGpI7pnAT4w=;
        b=DVQyiY6B9VnwzsVzb6KeZ2TXgJ2EhYkz4C8qD5QUJw0GChsrXJeRT4CjlFvK/TBpMF
         RDFoXiCMnaquW8RLhPP3pUgS6WSngLmY8Rm6QE+2CoWo+DbjslMdJ7WU3E4h2bfS6G4X
         ANPrPQ1bIjHtR4JkdsEztldNI7qb+OcPlaCyk97Uc1ciI4qddaMz8Kci8r/7YFB0f+XU
         1gaOLJNCZSzCkSHXJAtoDU/YqMTOP/xPLQr6B6pRJviEO9K9zjtXzo7ycLs03JgnefJ7
         2smbLiHqr/A3eND+Z37HB/u+ao/iQytBTVxQHLnOumIw5Lrhs/shnPrIWSf/IvHQx0xV
         CgaA==
X-Forwarded-Encrypted: i=1; AJvYcCWjEDsktRcDWCNED0WWaw5CFLyFdyZ/mUC3oOVPEgI3KWHNDIsXC+SotyfuRgvkmrsmjAkYVq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYj4mhMDFM6ht0O/i99z9GnaSsZG45MrCDbd9Q2r/6eGfab56
	l0n5xPeB7QdETGGLo+L9Zv7xG0xE9+Bm8T6pb97CY6gO0z/abOn3bKQeeLuXEkwgGPYl1kYvKQz
	z6MO3ACSiMFLi0H4ConQSCbg+Sq46YRJQ/7uz+Hi7wAAVpqUQcjmdrvpzGDs=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d550:0:b0:678:afd1:9fb6 with SMTP id
 006d021491bc7-678afd1a48emr2596730eaf.69.1771209322111; Sun, 15 Feb 2026
 18:35:22 -0800 (PST)
Date: Sun, 15 Feb 2026 18:35:22 -0800
In-Reply-To: <68c95a83.050a0220.3c6139.0e5c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6992826a.050a0220.340abe.0587.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in lec_arp_clear_vccs
From: syzbot <syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=17f5c46dd78c01cf];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258826-lists,netdev=lfdr.de,72e3ea390c305de0e259];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAB59140A97
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17972ffa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17f5c46dd78c01cf
dashboard link: https://syzkaller.appspot.com/bug?extid=72e3ea390c305de0e259
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1756015a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145a2722580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05288cb3a544/disk-37a93dd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b208672ebc8/vmlinux-37a93dd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb0ca59bc74a/bzImage-37a93dd5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 8024 Comm: syz.3.396 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:lec_arp_clear_vccs+0xad/0x380 net/atm/lec.c:1263
Code: e8 03 80 3c 28 00 74 08 4c 89 e7 e8 5d f6 62 f7 4c 89 74 24 18 49 8b 2c 24 4c 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 ef e8 35 f6 62 f7 4d 8b 75 00 4d 8d a7 30
RSP: 0018:ffffc9000cc67bc8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88807efa2400 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8c2764e0 RDI: ffff88807efa2400
RBP: ffff888057c3c000 R08: ffffffff8ef0f2f3 R09: 1ffffffff1de1e5e
R10: dffffc0000000000 R11: fffffbfff1de1e5f R12: ffff88803352e650
R13: 0000000000000000 R14: ffff88807efa2430 R15: ffff88803352e000
FS:  0000555590f50500(0000) GS:ffff8881254b0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef315f148 CR3: 00000000722fa000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lec_vcc_close net/atm/lec.c:2183 [inline]
 lec_push+0x3cb/0x19d0 net/atm/lec.c:594
 vcc_destroy_socket net/atm/common.c:183 [inline]
 vcc_release+0x15f/0x580 net/atm/common.c:205
 __sock_release net/socket.c:662 [inline]
 sock_close+0xc3/0x240 net/socket.c:1455
 __fput+0x44f/0xa70 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f005119bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff437a3bc8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f0051417da0 RCX: 00007f005119bf79
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f0051417da0 R08: 00007f0051416128 R09: 0000000000000000
R10: 000000000003fd6c R11: 0000000000000246 R12: 000000000002c374
R13: 00007f0051415fac R14: 000000000002c122 R15: 00007fff437a3cd0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lec_arp_clear_vccs+0xad/0x380 net/atm/lec.c:1263
Code: e8 03 80 3c 28 00 74 08 4c 89 e7 e8 5d f6 62 f7 4c 89 74 24 18 49 8b 2c 24 4c 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 ef e8 35 f6 62 f7 4d 8b 75 00 4d 8d a7 30
RSP: 0018:ffffc9000cc67bc8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88807efa2400 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8c2764e0 RDI: ffff88807efa2400
RBP: ffff888057c3c000 R08: ffffffff8ef0f2f3 R09: 1ffffffff1de1e5e
R10: dffffc0000000000 R11: fffffbfff1de1e5f R12: ffff88803352e650
R13: 0000000000000000 R14: ffff88807efa2430 R15: ffff88803352e000
FS:  0000555590f50500(0000) GS:ffff8881254b0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef315f148 CR3: 00000000722fa000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	e8 03 80 3c 28       	call   0x283c8008
   5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   9:	89 e7                	mov    %esp,%edi
   b:	e8 5d f6 62 f7       	call   0xf762f66d
  10:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
  15:	49 8b 2c 24          	mov    (%r12),%rbp
  19:	4c 89 e8             	mov    %r13,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 ef             	mov    %r13,%rdi
  33:	e8 35 f6 62 f7       	call   0xf762f66d
  38:	4d 8b 75 00          	mov    0x0(%r13),%r14
  3c:	4d                   	rex.WRB
  3d:	8d                   	.byte 0x8d
  3e:	a7                   	cmpsl  %es:(%rdi),%ds:(%rsi)
  3f:	30                   	.byte 0x30


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

