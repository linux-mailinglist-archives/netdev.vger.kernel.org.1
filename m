Return-Path: <netdev+bounces-188831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEE9AAF095
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7977A17D6AD
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D30199920;
	Thu,  8 May 2025 01:23:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68A7082D
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667429; cv=none; b=KBPUmAvmNlJ+5gSKXJSxO37W03zdGcyEhpEuEUhGvNQQZ5j4UwVopLApe/tVr56Ma+CI6KD4BlOoFh4Yq+Xom65v73heAa3GeMhFTH15Pe2GtCTZiAL2fF91i3BoTMX0nFQbfUNE2aGebPEPTomkYYQ8TPEqv6BrDgPRWGlr0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667429; c=relaxed/simple;
	bh=0wiN+b01chfenhkxqa6KglcTyGN4fkzpt+a/MaFBwoI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dHlnYvg9njmgJzImN9loCV3n9qkNeMTl78/U7TMzurA9LyTuqpqeVfv2sSpsfAvn+OrQ2RKBdUWiWsAW9p1upJFMGfEMbkGmIAOlVZhFNvh3jx0XqAS6AoX2tSCKAFFMyiGuUmRWK6EFsi0d7qhDUiPVOMukAokRP8Ol+tRg33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d6c613bd79so4481985ab.2
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 18:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746667425; x=1747272225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cn8+n2YqlG5ZBXqPKVrPe58LSo1TU9Oq9C5LLD1Jamg=;
        b=tciHdJDFfRbRiVmKI+dDK50SQ8Em4+4Qu/oA/PNAArIu4FJR41izgP/SAGRLBaGqWO
         gTC40mReYOhn0NkOIB85zVzDxo2nNqLoyiXnCI56TJ4lufqBcHmBOxJiXNjjwusdyiL2
         4+BbaGZ5WvM2c9lQP16RZZ/wgSkOo+yh1h1doI5NvXJZ1DMZz1nDCqAvTTcQ93kHir1d
         kp00Cd/1n6316OXVCLv/b2zQxY1TZmCYJf64Rs/KTlxxthTz+oWX9+Nb+YPaR9EVposu
         /Ou7ZG1D9xQeRgci3gZEFVHbwhZ8aeR4cZEF4cQiUechpmWjvV2cG6uiPfVP5vUey4c4
         X7MA==
X-Forwarded-Encrypted: i=1; AJvYcCWyQXzUJP7W1p4s93m5Kuih7ALArZK03lO3wUQIRWyt1QIeGdx5spOMynJw2YD5993wr6P+R24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRmmUJrfyzKZXJ/NnVDQJxIO5etUgeh39EhDir+HlJCipZOF1c
	/f2Xyb+d/8syIrKlxA8k1ly5b0TA01RpPivNTEBkZz6T28BUX5tUvKSueFlDCgzzgimD47zhujq
	OfO8TLBdB079s69WW2QvQd7OvuvunAJyWznh5VipoNuc8AB0VoAk3BIo=
X-Google-Smtp-Source: AGHT+IEmNr9VhBMrKMt6vjigLUzXWMdwhbB11J/yL4hhgUZepHx4nXVAD/95nrtEsEo5svIIo2WpKIrPXBsjLu5oqgwVCMBJToZl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194b:b0:3d8:20fb:f060 with SMTP id
 e9e14a558f8ab-3da738ed7c6mr64668425ab.4.1746667425480; Wed, 07 May 2025
 18:23:45 -0700 (PDT)
Date: Wed, 07 May 2025 18:23:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681c07a1.050a0220.a19a9.007c.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in mld_clear_delrec
From: syzbot <syzbot+888c7330963d4b45da35@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92a09c47464d Linux 6.15-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b23b68580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b39cb28b0a399ed3
dashboard link: https://syzkaller.appspot.com/bug?extid=888c7330963d4b45da35
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bb9b7be3962f/disk-92a09c47.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d4048c02a409/vmlinux-92a09c47.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1a81e88c04e/bzImage-92a09c47.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+888c7330963d4b45da35@syzkaller.appspotmail.com

veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
Oops: general protection fault, probably for non-canonical address 0xdffffc001ffee000: 0000 [#1] SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x00000000fff70000-0x00000000fff70007]
CPU: 0 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted 6.15.0-rc5-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: netns cleanup_net
RIP: 0010:mld_clear_delrec+0x2a6/0x640 net/ipv6/mcast.c:838
Code: 20 00 0f 85 91 03 00 00 49 8b 5d 28 49 c7 45 28 00 00 00 00 48 85 db 75 37 e9 d4 00 00 00 e8 21 86 96 f7 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 39 03 00 00 48 8b 2b 48 8d 7b 30 48 89 de e8
RSP: 0018:ffffc900001275f8 EFLAGS: 00010206
RAX: 000000001ffee000 RBX: 00000000fff70000 RCX: ffffffff8a24ad36
RDX: ffff88801ca80000 RSI: ffffffff8a24accf RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888033bf3c00 R14: ffff88805babf000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881249df000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f87f8f59348 CR3: 000000000e180000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ipv6_mc_destroy_dev+0x49/0x690 net/ipv6/mcast.c:2842
 addrconf_ifdown.isra.0+0x13ef/0x1a90 net/ipv6/addrconf.c:3997
 addrconf_notify+0x220/0x19e0 net/ipv6/addrconf.c:3777
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 unregister_netdevice_many_notify+0xf9a/0x26f0 net/core/dev.c:11982
 unregister_netdevice_many net/core/dev.c:12046 [inline]
 default_device_exit_batch+0x853/0xaf0 net/core/dev.c:12538
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
 cleanup_net+0x5c1/0xb30 net/core/net_namespace.c:654
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mld_clear_delrec+0x2a6/0x640 net/ipv6/mcast.c:838
Code: 20 00 0f 85 91 03 00 00 49 8b 5d 28 49 c7 45 28 00 00 00 00 48 85 db 75 37 e9 d4 00 00 00 e8 21 86 96 f7 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 39 03 00 00 48 8b 2b 48 8d 7b 30 48 89 de e8
RSP: 0018:ffffc900001275f8 EFLAGS: 00010206
RAX: 000000001ffee000 RBX: 00000000fff70000 RCX: ffffffff8a24ad36
RDX: ffff88801ca80000 RSI: ffffffff8a24accf RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888033bf3c00 R14: ffff88805babf000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888124adf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe3317d4800 CR3: 000000000e180000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	20 00                	and    %al,(%rax)
   2:	0f 85 91 03 00 00    	jne    0x399
   8:	49 8b 5d 28          	mov    0x28(%r13),%rbx
   c:	49 c7 45 28 00 00 00 	movq   $0x0,0x28(%r13)
  13:	00
  14:	48 85 db             	test   %rbx,%rbx
  17:	75 37                	jne    0x50
  19:	e9 d4 00 00 00       	jmp    0xf2
  1e:	e8 21 86 96 f7       	call   0xf7968644
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 39 03 00 00    	jne    0x36e
  35:	48 8b 2b             	mov    (%rbx),%rbp
  38:	48 8d 7b 30          	lea    0x30(%rbx),%rdi
  3c:	48 89 de             	mov    %rbx,%rsi
  3f:	e8                   	.byte 0xe8


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

