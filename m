Return-Path: <netdev+bounces-282200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E8PMGzBs8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:25:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6BF48E498
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43E713034DC0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6090937F740;
	Wed, 29 Apr 2026 02:25:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AA257849
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429545; cv=none; b=ImdR8uz0CmHmk1/KokFekHRTMxrIV3+K62xaMvJnbpTR9zDNVqL82ou/h68UMEsVinToA9kQ+r8/LnkWM/ncCEmHwQJh3KmdBooPd1EZUN5p6dFiEzcAFXsVXAJC0te3qV803IMPL2Q+BlhEsexy9AcRias+CTPZ9I5puU5O33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429545; c=relaxed/simple;
	bh=vgFToGvV8ikwg1TNP69hmHJFjdbf1VCoMhZ4s0Aj8Dw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q28agNeS5WdFohPZN9FLYovS8iDVKL4NB3Q9KynjIp/GxNR2XNnYqEmjm5lZ70qZwO3b0mQwLqmZs8u/DPWEkk7582+U9/tp7JnstCjZyEiSzbrigU3Jq7NdCS/wqt6lCddeVxUvlwO4tcufGLOOORwPr4UH49voTB8/896zPiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-695aebf3cc7so7935097eaf.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 19:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777429543; x=1778034343;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Wuf1uPr6EJz090SBkio4UZycSnIJX01CYea+KO7Xg8=;
        b=foEBFYluV9S1AVTn0wRMr30gaUo3+z1yKLtETYvAaF/fd1nOBuspgKmxrO4b7OFJvq
         YdJsQVwiOThb3TbfEpdXZK9AD6MxygbfzNbhxXhLi44EY1+e1EPW4kCQwFsQT75JQLyl
         4MCfRx6yxPa7I7l9e/8TmroduQPTI9kB3QFLoUDPlY/oF5F64hSSp+dLfC085WYQlQsp
         UHykZ6hRiCOsKRqk58oZGcTH+5DgTs6KapLWf1sfPjEOvUTBBcpZHXtNXWp4rLCjA+Hr
         TJ0/MTjd8Ybsyh4rkZo1QvAGFH+wpWBSwyfA6wvnHhiYEHzVrlQbtIXSQ5j0TqQT7+l5
         mUbg==
X-Forwarded-Encrypted: i=1; AFNElJ+se7/jP4FhKFUEtw+BnUhhV7CyYU9326g38Zjt9fdSCUKef54mdm6cAy7eKzHPR6uCmLHU2r0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QLFKu6ISOrcOrwmJjF/cQPyLKpamn8tWAijhvm9NFIfOd7aC
	45lBRaZVFkIfwpaOpVT5KzqEJjoKZV7WiWMtG4oEp0WebDl82O8MoYT31yO6l8ukGxD0I+ztQXK
	Qa41m+8AAbygKDQ17EwfBFoksekxzTOwC7rQZaOuJZmK+lslBGBziMobvAc0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee85:0:b0:694:9bdb:596b with SMTP id
 006d021491bc7-6965ca7da67mr3267644eaf.17.1777429542704; Tue, 28 Apr 2026
 19:25:42 -0700 (PDT)
Date: Tue, 28 Apr 2026 19:25:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f16c26.170a0220.34e5b8.0013.GAE@google.com>
Subject: [syzbot] [net?] WARNING: ODEBUG bug in lane_ioctl (3)
From: syzbot <syzbot+ca9d5686d06994c6547c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CB6BF48E498
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ca77bfc4078c8193];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
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
	TAGGED_FROM(0.00)[bounces-282200-lists,netdev=lfdr.de,ca9d5686d06994c6547c];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,

syzbot found the following issue on:

HEAD commit:    e728258debd5 Merge tag 'net-7.1-rc1' of git://git.kernel.o..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1752f702580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca77bfc4078c8193
dashboard link: https://syzkaller.appspot.com/bug?extid=ca9d5686d06994c6547c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16811c36580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128c52d2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24195bde5d1d/disk-e728258d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78131d1b0e14/vmlinux-e728258d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/836d0dd78c10/bzImage-e728258d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca9d5686d06994c6547c@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: init active (active state 0) object: ffff888077a60f78 object type: timer_list hint: lec_arp_check_expire+0x0/0xc90 net/atm/lec.c:-1
WARNING: lib/debugobjects.c:632 at debug_print_object lib/debugobjects.c:629 [inline], CPU#0: syz-executor253/5933
WARNING: lib/debugobjects.c:632 at __debug_object_init+0x2b1/0x4e0 lib/debugobjects.c:780, CPU#0: syz-executor253/5933
Modules linked in:
CPU: 0 UID: 0 PID: 5933 Comm: syz-executor253 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:debug_print_object lib/debugobjects.c:629 [inline]
RIP: 0010:__debug_object_init+0x30f/0x4e0 lib/debugobjects.c:780
Code: 3c 38 00 74 08 4c 89 ef e8 0e df 74 fd 4d 8b 4d 00 4c 89 f7 48 c7 c6 20 a7 28 8c 4c 89 e2 8b 4c 24 08 4c 8b 04 24 ff 74 24 10 <67> 48 0f b9 3a 48 83 c4 08 ff 05 8e 8c 77 0b 83 fd 03 75 3f 4c 8b
RSP: 0018:ffffc90003e278f8 EFLAGS: 00010246
RAX: 1ffffffff179e734 RBX: ffff888077a60f78 RCX: 0000000000000000
RDX: ffffffff8c28ab20 RSI: ffffffff8c28a720 RDI: ffffffff903e69a0
RBP: 0000000000000003 R08: ffff888077a60f78 R09: ffffffff8bcf4d00
R10: dffffc0000000000 R11: ffffffff81b236d0 R12: ffffffff8c28ab20
R13: ffffffff8bcf39a0 R14: ffffffff903e69a0 R15: dffffc0000000000
FS:  00007f3e1e8976c0(0000) GS:ffff888125213000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a602110fd8 CR3: 00000000753ea000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 debug_timer_init kernel/time/timer.c:788 [inline]
 debug_init kernel/time/timer.c:836 [inline]
 timer_init_key+0x41/0x2c0 kernel/time/timer.c:880
 lec_arp_init net/atm/lec.c:1274 [inline]
 lecd_attach net/atm/lec.c:781 [inline]
 lane_ioctl+0x1579/0x2220 net/atm/lec.c:1037
 do_vcc_ioctl+0x36d/0x9d0 net/atm/ioctl.c:159
 svc_ioctl+0x1f6/0x7d0 net/atm/svc.c:611
 sock_do_ioctl+0x101/0x320 net/socket.c:1313
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1434
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e1e8bf0d9
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3e1e897158 EFLAGS: 00000246
 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3e1e96fb48 RCX: 00007f3e1e8bf0d9
RDX: 0000000000000000 RSI: 00000000000061d0 RDI: 0000000000000005
RBP: 00007f3e1e96fb40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3e1e9413b0
R13: 0000000000000000 R14: 0000200000000040 R15: b635773f07ebbeef
 </TASK>
----------------
Code disassembly (best guess):
   0:	3c 38                	cmp    $0x38,%al
   2:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   6:	89 ef                	mov    %ebp,%edi
   8:	e8 0e df 74 fd       	call   0xfd74df1b
   d:	4d 8b 4d 00          	mov    0x0(%r13),%r9
  11:	4c 89 f7             	mov    %r14,%rdi
  14:	48 c7 c6 20 a7 28 8c 	mov    $0xffffffff8c28a720,%rsi
  1b:	4c 89 e2             	mov    %r12,%rdx
  1e:	8b 4c 24 08          	mov    0x8(%rsp),%ecx
  22:	4c 8b 04 24          	mov    (%rsp),%r8
  26:	ff 74 24 10          	push   0x10(%rsp)
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 83 c4 08          	add    $0x8,%rsp
  33:	ff 05 8e 8c 77 0b    	incl   0xb778c8e(%rip)        # 0xb778cc7
  39:	83 fd 03             	cmp    $0x3,%ebp
  3c:	75 3f                	jne    0x7d
  3e:	4c                   	rex.WR
  3f:	8b                   	.byte 0x8b


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

