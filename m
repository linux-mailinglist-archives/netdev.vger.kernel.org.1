Return-Path: <netdev+bounces-145791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A59D0EB6
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802472811A6
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37F0194C62;
	Mon, 18 Nov 2024 10:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C6192D80
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926306; cv=none; b=cK170925zg1vuDLIxJ8ljtgqFHRuBguYVdY+aO7DAmgcxcBT0/WKZNFYKIlLJIy5x6EHoZza7Lz0x9s+39y97oWfBXP/EUSJ6TIG5w2vhV90r+Fh1Zc5Wca+2aKiKsvSbj/dDqGjYU7ptb1WWTcYgJsI9ccKqPFm5M4x9LUw5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926306; c=relaxed/simple;
	bh=CV0m8hWlTFP6hrBpjHl9QHaq9B9avV5kZpp/Vx453YU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZOhbFs2xp4noc32X1q+WMHKSgtcvniMEBLhL2xOYNCjyKiHnK08zXKDUa8+S9kYgymBZ3jUmm+Nl0r5afGnuAE/WLShYgDXGHCOH6x/HUd+EnzKe2uDmnXpa87/TJAwVdIUX78+XQeVh1miLlJG8IZXixTJ5+InT3f0emvm0h7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so49867335ab.2
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 02:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926304; x=1732531104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RL++3rvcYxgggNcQ8+ApKeS+QpSbKdlpAd9n4OjKSQA=;
        b=haF681FUOG+oboUk8S+UXvybmRIIJtGIBGS4rOIqWRvE3y+ukXrKaKFUQx2dxv0efi
         LCLgGZcUDTgJtmJQ2XWko3i+5xsNZVB4Zu2L1JVTfuc3IJcKLajcjfGNNeDpG8mpeuZr
         cx0xOT5ekzHdGuNPZRqTm1dPLeb7tSVU6mjYJNK3ZQuQGleVnq935ZRslVFUgxlDU/Hk
         75tN293AjVPiUh5DoG4uDUYYBZMw9e5WerkWoGN9ddFJ5tz+59olRfXI6fPupiEMqQbe
         1+9E1Zk9/oe6uN0Qk5DzpBSjHALCKG8LB9GzDk6tkHLIn8y/cC8i5C8ZE0BT3DJVAZNK
         U4mw==
X-Forwarded-Encrypted: i=1; AJvYcCWmtBctPvP7PZSh5K7/e6866S1VyNd1/zWay9whyxdCjvouDxty+6X9h+0KGpI0lQLxu+zr1E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXu4nITdumzPbiACOMhcgmcuGDMkz5Slzia7r9AgcCJy1NWmc
	6eokRFXTvU8M735sKOLSw/XopiZs2bkTD2DYQw0CIHTMSATYs/YxM32/s3kQjjLjon7Ag2EQ9Gs
	7MeZxqbfOBr53M6AsFoAwQz2spMh6J6L7lVJT45qNfABaMMkpMb2dFlY=
X-Google-Smtp-Source: AGHT+IGMdlr8SMb6RQRTSk2flR90ojGRKtuDztYbZGssrp0D1N4IVIgWk2QPaYQVMa50/9g40CBDkhM8cRE33CL2oT9T6ei4E/5h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:3a7:6f0f:122e with SMTP id
 e9e14a558f8ab-3a76f0f1b1bmr6888215ab.10.1731926304304; Mon, 18 Nov 2024
 02:38:24 -0800 (PST)
Date: Mon, 18 Nov 2024 02:38:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b1920.050a0220.87769.002b.GAE@google.com>
Subject: [syzbot] [tipc?] general protection fault in tipc_topsrv_exit_net (2)
From: syzbot <syzbot+2f6f00fd43edc2129fa5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1148735f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3a3896a92fb300b
dashboard link: https://syzkaller.appspot.com/bug?extid=2f6f00fd43edc2129fa5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f7fdf3a28c09/disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37016caab507/vmlinux-2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee15f845ad51/bzImage-2d5404ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f6f00fd43edc2129fa5@syzkaller.appspotmail.com

bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 6899 Comm: kworker/u8:11 Not tainted 6.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: netns cleanup_net
RIP: 0010:__lock_acquire+0xe1/0x3ce0 kernel/locking/lockdep.c:5065
Code: d0 7c 08 84 d2 0f 85 96 14 00 00 8b 0d 10 58 f5 0e 85 c9 0f 84 dd 0d 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 02 2d 00 00 49 8b 04 24 48 3d 20 a7 79 93 0f 84
RSP: 0018:ffffc90003da78d8 EFLAGS: 00010016
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000003 RSI: 1ffff920007b4f2d RDI: 0000000000000018
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff905f808f R11: 0000000000000000 R12: 0000000000000018
R13: 0000000000000018 R14: 0000000000000000 R15: ffff88807bdd0000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2441c0 CR3: 000000007bc68000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
 put_pwq_unlocked kernel/workqueue.c:1662 [inline]
 put_pwq_unlocked kernel/workqueue.c:1655 [inline]
 destroy_workqueue+0x5dd/0xaa0 kernel/workqueue.c:5883
 tipc_topsrv_work_stop net/tipc/topsrv.c:653 [inline]
 tipc_topsrv_stop net/tipc/topsrv.c:717 [inline]
 tipc_topsrv_exit_net+0x2a4/0x3b0 net/tipc/topsrv.c:730
 ops_exit_list+0xb3/0x180 net/core/net_namespace.c:173
 cleanup_net+0x5b7/0xb40 net/core/net_namespace.c:626
 process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xe1/0x3ce0 kernel/locking/lockdep.c:5065
Code: d0 7c 08 84 d2 0f 85 96 14 00 00 8b 0d 10 58 f5 0e 85 c9 0f 84 dd 0d 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 02 2d 00 00 49 8b 04 24 48 3d 20 a7 79 93 0f 84
RSP: 0018:ffffc90003da78d8 EFLAGS: 00010016
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000003 RSI: 1ffff920007b4f2d RDI: 0000000000000018
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff905f808f R11: 0000000000000000 R12: 0000000000000018
R13: 0000000000000018 R14: 0000000000000000 R15: ffff88807bdd0000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2441c0 CR3: 000000007bc68000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	d0 7c 08 84          	sarb   -0x7c(%rax,%rcx,1)
   4:	d2 0f                	rorb   %cl,(%rdi)
   6:	85 96 14 00 00 8b    	test   %edx,-0x74ffffec(%rsi)
   c:	0d 10 58 f5 0e       	or     $0xef55810,%eax
  11:	85 c9                	test   %ecx,%ecx
  13:	0f 84 dd 0d 00 00    	je     0xdf6
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 02 2d 00 00    	jne    0x2d36
  34:	49 8b 04 24          	mov    (%r12),%rax
  38:	48 3d 20 a7 79 93    	cmp    $0xffffffff9379a720,%rax
  3e:	0f                   	.byte 0xf
  3f:	84                   	.byte 0x84


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

