Return-Path: <netdev+bounces-141082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529CA9B96B7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82961B20F62
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7F71CCB4E;
	Fri,  1 Nov 2024 17:44:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193851CC178
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483066; cv=none; b=pSD6obQRFziLV8baRagSJR9TCRR5u+WNiTr0lp1hUdkYXivenIaR70RyJKKnt2Z2fxoAIUvANQvjZel4svYYiTelC1XhAm08/RTPXvDRUdRLPx8Big5qW3q9li+ZAAmwjIYNRdSPBOnbtJb3EFeLvL5tEY8V+dpB6T00BTYsbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483066; c=relaxed/simple;
	bh=XFgOzZU3vf3rVwV55k5ue676e5+F82mmlt+SInaASco=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BdY3iYzCZshypl+vo/47nifmVL47rn1dAygDMWoYls7F2XagHU2CI6Njh7gcNnZPmhwWra/2PLAkYxmJo8+o5oSyWH60LJ5D4IbNs9spF3FwC/cnCgSnYYWCt9qhFC+UoD5okD4evNLGnBj0KbXrS3zct3e+J/raTKgWedB2+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so22519895ab.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 10:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483064; x=1731087864;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZamgeEAq8LX/a7SW/p7J0rGhjfQLFTJ6EjCGeTjuEY=;
        b=tISLMUKfi6AMTcgrlQVX7TV3Yjh3LVu3R9JR9ewcyEyhOD8/L+giBRljVz1lFIhpsQ
         lUbvY4F8DOpjKyMB70Ys7LlnsJIkKICSH/Vd5XnAkPpzGDkk7/bbtdRm/pSr/QFFFWQN
         h+1sYFg8lKJcCNl3XTTMYKqFCSFS8eMIYRcOC5IlWpTyDji/1X7PNZRpOVacZu16bFKm
         9A9Z0Mx+XohBVSenyzslaAkuKD4Cy67dNul4Ue31E5tLqpA35OY/pUGsLH7Y7W4k+UK5
         09ueyCaGGACGvc5pQQSS7Jj/OM1kA/nY9j5DB5odYZUICmmCBsvoMNAbPAuUs7o/rEqB
         D9cA==
X-Forwarded-Encrypted: i=1; AJvYcCVZwaM7BiUwa7LngT+DTfzdH43n8dfb68M+eIoL1/9J7nmdJ3u23i4pBkSFheKlHXrZE2huZHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkFQ7DbCODez8BOIR5EVUpUOCXQuQzWk1Z5pOBwGgMP6j+iWw
	D0nlM2vPUwD1oAIEWEYM1EEAL+doKBUi2M8DvDaisEL3Zui3Quh9rHBsFZm7sE6AfumqTpwoeqQ
	iu9HVbjRwDOPM+wzX/QsS6SgrLhfqvHU6NHl9KKihMxiMo1ZixKfGpGM=
X-Google-Smtp-Source: AGHT+IFpQvM59ysMYop4UuShmqCEPokzs3FQ05DgVwej655ZYFGThHsNrBgohRjEF6+U5nvkOHvpbNy6GdFZLj0Vmymv3PPNAdtt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:3a0:90c7:f1b with SMTP id
 e9e14a558f8ab-3a6b031cfc9mr48470885ab.12.1730483064043; Fri, 01 Nov 2024
 10:44:24 -0700 (PDT)
Date: Fri, 01 Nov 2024 10:44:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67251378.050a0220.3c8d68.08cb.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in put_page (3)
From: syzbot <syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, hch@lst.de, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=131f2630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=71abe7ab2b70bca770fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1110d2a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153e5540580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz

The issue was bisected to:

commit e4e535bff2bc82bb49a633775f9834beeaa527db
Author: Ming Lei <ming.lei@redhat.com>
Date:   Thu Oct 24 05:00:15 2024 +0000

    iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1539b2a7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1339b2a7980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
Fixes: e4e535bff2bc ("iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages")

Oops: general protection fault, probably for non-canonical address 0xed2e87ee8f0cadc6: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x69745f7478656e30-0x69745f7478656e37]
CPU: 1 UID: 0 PID: 5869 Comm: syz-executor171 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:_compound_head include/linux/page-flags.h:242 [inline]
RIP: 0010:put_page+0x23/0x260 include/linux/mm.h:1552
Code: 90 90 90 90 90 90 90 55 41 57 41 56 53 49 89 fe 48 bd 00 00 00 00 00 fc ff df e8 d8 ae 0d f8 49 8d 5e 08 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74 08 48 89 df e8 5f e5 77 f8 48 8b 1b 48 89 de 48 83
RSP: 0018:ffffc90003f970a8 EFLAGS: 00010207
RAX: 0d2e8bee8f0cadc6 RBX: 69745f7478656e36 RCX: ffff8880306d3c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 69745f7478656e2e
RBP: dffffc0000000000 R08: ffffffff898706fd R09: 1ffffffff203a076
R10: dffffc0000000000 R11: fffffbfff203a077 R12: 0000000000000000
R13: ffff88807fd7a842 R14: 69745f7478656e2e R15: 69745f7478656e2e
FS:  0000555590726380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 0000000025350000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 skb_page_unref include/linux/skbuff_ref.h:43 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
 skb_release_data+0x483/0x8a0 net/core/skbuff.c:1119
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 kfree_skb include/linux/skbuff.h:1271 [inline]
 __ip_flush_pending_frames net/ipv4/ip_output.c:1538 [inline]
 ip_flush_pending_frames+0x12d/0x260 net/ipv4/ip_output.c:1545
 udp_flush_pending_frames net/ipv4/udp.c:829 [inline]
 udp_sendmsg+0x5d2/0x2a50 net/ipv4/udp.c:1302
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x1a6/0x270 net/socket.c:744
 sock_sendmsg+0x134/0x200 net/socket.c:767
 splice_to_socket+0xa10/0x10b0 fs/splice.c:889
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11b/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x561/0xe10 fs/read_write.c:1388
 __do_sys_sendfile64 fs/read_write.c:1455 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f17eb533ab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdeb190c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f17eb533ab9
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 00007f17eb5a65f0 R08: 0000000000000006 R09: 0000000000000006
R10: 0000020000023893 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:242 [inline]
RIP: 0010:put_page+0x23/0x260 include/linux/mm.h:1552
Code: 90 90 90 90 90 90 90 55 41 57 41 56 53 49 89 fe 48 bd 00 00 00 00 00 fc ff df e8 d8 ae 0d f8 49 8d 5e 08 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74 08 48 89 df e8 5f e5 77 f8 48 8b 1b 48 89 de 48 83
RSP: 0018:ffffc90003f970a8 EFLAGS: 00010207
RAX: 0d2e8bee8f0cadc6 RBX: 69745f7478656e36 RCX: ffff8880306d3c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 69745f7478656e2e
RBP: dffffc0000000000 R08: ffffffff898706fd R09: 1ffffffff203a076
R10: dffffc0000000000 R11: fffffbfff203a077 R12: 0000000000000000
R13: ffff88807fd7a842 R14: 69745f7478656e2e R15: 69745f7478656e2e
FS:  0000555590726380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 0000000025350000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	55                   	push   %rbp
   8:	41 57                	push   %r15
   a:	41 56                	push   %r14
   c:	53                   	push   %rbx
   d:	49 89 fe             	mov    %rdi,%r14
  10:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
  17:	fc ff df
  1a:	e8 d8 ae 0d f8       	call   0xf80daef7
  1f:	49 8d 5e 08          	lea    0x8(%r14),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 5f e5 77 f8       	call   0xf877e597
  38:	48 8b 1b             	mov    (%rbx),%rbx
  3b:	48 89 de             	mov    %rbx,%rsi
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

