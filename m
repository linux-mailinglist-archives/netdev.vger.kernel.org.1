Return-Path: <netdev+bounces-212152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED03B1E735
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9871C20B2A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD859274FE5;
	Fri,  8 Aug 2025 11:24:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1E274B5A
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652274; cv=none; b=XqNFcVHWg8L3QlU2xJrS3H+B2X0SKk+jQusv6QtT4KlLwCm2WkDjiK45Qs0k+qpow2tZQB3kxtIzd+FMCmwiNxDljXfXnlkfxfTYfwl6OweCZKqCeZ76wKPYovnmoe9yrCQn2S0CSOwe6Hio+AKadE39Eq0S3q3dX+GqqSqeSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652274; c=relaxed/simple;
	bh=zmdaemnzI6Dweo/PE+lpJKXaYs9qBfUp7ZJH2qFe46o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uCz8Is652dhh9QA6JmzmHBBEvlS22yXDK0qYZoR7rApa5JOkMS6C1E/2MKo1qfer0xkkUPlgEHo6AwDb9Die/yWajpLwcgq8JVk2sAQjYF0BLwMNLP576YrIz7/QJJG6zIP4nlHDaX368HL2CSfldTUa8QKEilrfpWgTvLJHWk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e3ef736a78so43398525ab.0
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 04:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652271; x=1755257071;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uIUGDiVBEDnqS5buaD8/8+TR/c5UVNJJj0BUK+zU5c=;
        b=lc2/feGmaudCk5ZbxyfWE1w0DrzJIapIpKcJCNBW93w+egprtDh2hcsi8jX/yZyznP
         rPbi91DPgeTvkCD4s+wY0vSHi+fBsFjd9ZsUJqs7F9hPc6VN6TlSRlciNbDn0WQ739wM
         4Y3czhCRxvqob5GEX9pRQhfMNw96/Xtvu3iLVJ/LPomfHF16DjTCHAR2rA5A0PDbKTC+
         P9PT7YwVg6ZgH2dO0sQi02O8VAHAKZUifOVO8wJBNsIT8aIpTxVB7iz64Oxg3GweJNks
         tmu1WLxt/NZIpDpN8cG47+NmcLgu60TK6+atGVVsBCNq04CHGsWcMxPs2n0cavc13l1d
         rq2A==
X-Forwarded-Encrypted: i=1; AJvYcCW7IhpCXKAPkwg+LMJdadJ4chelDqCWS9HL706BGsVAryfB29192n5xrcQ5dTUFkWHw1P/YjZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRasg48vi5GHbfva5P+XZ/6VCGYl98PDOAVT//8v8Sa9D7TM67
	VM1321D6R6esPhJERyMgnB3Wodz2r8L98Y/Xi/xyFhVBmQM3m5evXZiBvgAfYEc4ZkkK/Rx36+X
	HyvouFNyPctn2g5zF5MoyG16VgCs2KLOBsy2+UXzdBTNf+XDe2LltNEI+GKg=
X-Google-Smtp-Source: AGHT+IH6IsH6YZeuvtQQE7tRPQJFSp+r4/taKPwvfvWUv2+BNPSKtSSP2mG/JBrssv/9onz01Az0+fpaid1bcPRnSDzs+hdsXdiv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180a:b0:3e3:d1ef:83f9 with SMTP id
 e9e14a558f8ab-3e5330abcc0mr42119435ab.6.1754652270983; Fri, 08 Aug 2025
 04:24:30 -0700 (PDT)
Date: Fri, 08 Aug 2025 04:24:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6895de6e.050a0220.7f033.005d.GAE@google.com>
Subject: [syzbot] [net?] WARNING: ODEBUG bug in __sk_destruct (3)
From: syzbot <syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7abc678e3084 Merge tag 'pmdomain-v6.16-rc2' of git://git.k..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=11b0a4f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12b5044868deb866
dashboard link: https://syzkaller.appspot.com/bug?extid=d199b52665b6c3069b94
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a20f22580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12af2f22580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8a9fc2a6bfdf/disk-7abc678e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29375cef95f6/vmlinux-7abc678e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8148ffc5b47b/bzImage-7abc678e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88807dcf7668 object type: work_struct hint: kcm_tx_work+0x0/0x180 net/kcm/kcmsock.c:-1
WARNING: CPU: 0 PID: 6293 at lib/debugobjects.c:615 debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Modules linked in:
CPU: 0 UID: 0 PID: 6293 Comm: syz.0.87 Not tainted 6.16.0-rc6-syzkaller-g7abc678e3084 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Code: 4c 89 ff e8 e7 b7 5b fd 4d 8b 0f 48 c7 c7 a0 95 e2 8b 48 8b 34 24 4c 89 ea 89 e9 4d 89 f0 41 54 e8 da 93 bd fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 c7 85 db 0a 48 83 c4 08 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc900021efb30 EFLAGS: 00010296
RAX: f0e2d1323eb60c00 RBX: dffffc0000000000 RCX: ffff88802699da00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa6c R12: ffffffff8a9e4d50
R13: ffffffff8be29720 R14: ffff88807dcf7668 R15: ffffffff8b89dd60
FS:  00007f6914e486c0(0000) GS:ffff888125c23000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6914e47f98 CR3: 00000000288b8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x3a2/0x470 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2312 [inline]
 slab_free mm/slub.c:4643 [inline]
 kmem_cache_free+0x113/0x400 mm/slub.c:4745
 sk_prot_free net/core/sock.c:2284 [inline]
 __sk_destruct+0x4d2/0x660 net/core/sock.c:2381
 kcm_release+0x528/0x5c0 net/kcm/kcmsock.c:1731
 __sock_release net/socket.c:647 [inline]
 sock_close+0xc0/0x240 net/socket.c:1391
 __fput+0x44c/0xa70 fs/file_table.c:465
 fput_close_sync+0x119/0x200 fs/file_table.c:570
 __do_sys_close fs/open.c:1589 [inline]
 __se_sys_close fs/open.c:1574 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1574
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6913f8e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6914e48038 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007f69141b6160 RCX: 00007f6913f8e9a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f6914010d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f69141b6160 R15: 00007ffe8d790a18
 </TASK>


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

