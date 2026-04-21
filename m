Return-Path: <netdev+bounces-280176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CWNCMqa52lj+QEAu9opvQ
	(envelope-from <netdev+bounces-280176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:42:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C3743CE3A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B28F1305B28D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A262D8DC4;
	Tue, 21 Apr 2026 15:35:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8DB2D877B
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785736; cv=none; b=D6WcEr6Uhb0nDLr1XVK0OsVC4Jb/mEZSmGRaPGkXAmI6wd+cUqR3DLCvv3vxa6OaQ9ozNSdoI4SyITS3uPe1zkVd5woECby2Kcf1E4im8XwSz9AwI8sshOgV3lJ3UUkBsx0Td2hc3pUswhogu+7egAj4CE3ppUxZTjKnnZDIz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785736; c=relaxed/simple;
	bh=ONz262nZvHvEg1/NeRsSSEzdyhKAAtn6sRX6wRpZ4K4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kcBoj5XVicgMDfhfZ1B2JdFrPy+/ytC407JPlFvgVs0pSiSKQ3WS8ixn45f2Yqxv7I16XplnWxeJUtJiCJUsahS/YrX+Lq0l46P6WuJe2xVy3JrL1B36IpD13D4XS7dJRJ4JmmtgQ5kB0x8WDk7cz9IWfnHKlnR9qVL+GI+PeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7dcc8912143so3696073a34.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776785732; x=1777390532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aatkEaaCAqTNSI9UEPH2e59YLZz0ncVhPDdHHrU/4F0=;
        b=ExH0ZXcy+u56lMPCD22yGSVl6ePlWxOACq5huGzunz9a0uET5yIUo3Pze2lAZXX9KB
         V1CGOELidjm2OA2HzIyte9GzYxVtgIdfWrN2pMhbP3v07oMopnUNK3J7xKmeq6FxBqW8
         0jWt5gVTMAUBSTW2n2/hSeNAw1IYvQx66zFEAHKfrCkFA/UOSP5QAMujsFMaLNALVDkP
         LP4e6Tg4YX/uwKZP9udX4hPDsRyWpqLL6S+78KR9HJMZM1bsYiBwHl/XYqePzC+5AnsV
         0QL6vM2cKNm6kL6A5zPgowb4VLVEygU8EgDnLKHOXDnzYU1VL/gVGQdPm/IaBTIKwziQ
         xh0A==
X-Forwarded-Encrypted: i=1; AFNElJ+LRj60/N/Lml848bzO/Wuk1a7EcFHh1a71Ql8AiqK6MUwQBNM0wGIEfiM6dkBnTimCo5xj4bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRt+eODGzUt1hyzg8RVwHTZ/HUbIwViRJc7tQdjL6M20r36Hpo
	fSSd6kCD41ar3Sqsdy4C88GcLkh9hhnpfS1rjne5R6sI/r0d1cIrMQL3ERHRkrbrQu2Zsin5e/T
	ZJFoOXhzNUcq09bB1hSHfZEMFUUSmCpuahzAsb670LY9EyPjd6pd4bNvwfyU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1b07:b0:67b:b0bd:8bd2 with SMTP id
 006d021491bc7-69462f710eemr11161284eaf.59.1776785731841; Tue, 21 Apr 2026
 08:35:31 -0700 (PDT)
Date: Tue, 21 Apr 2026 08:35:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e79943.a00a0220.17a17.0019.GAE@google.com>
Subject: [syzbot] [net?] BUG: spinlock already unlocked in lec_atm_close
From: syzbot <syzbot+49a9c7b281bb147f8eb3@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=95729ed00549063a];
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
	TAGGED_FROM(0.00)[bounces-280176-lists,netdev=lfdr.de,49a9c7b281bb147f8eb3];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,goo.gl:url,googlegroups.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 31C3743CE3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    1f5ffc672165 Fix mismerge of the arm64 / timer-core interr..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12b85906580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95729ed00549063a
dashboard link: https://syzkaller.appspot.com/bug?extid=49a9c7b281bb147f8eb3
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b552538b97f/disk-1f5ffc67.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/724a3a1d69d7/vmlinux-1f5ffc67.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea684969e2c2/bzImage-1f5ffc67.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49a9c7b281bb147f8eb3@syzkaller.appspotmail.com

BUG: spinlock already unlocked on CPU#0, syz.2.25/6044
 lock: 0xffff888032ea0ea0, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
CPU: 0 UID: 0 PID: 6044 Comm: syz.2.25 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 spin_bug kernel/locking/spinlock_debug.c:78 [inline]
 debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
 do_raw_spin_unlock+0x143/0x210 kernel/locking/spinlock_debug.c:141
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:177 [inline]
 _raw_spin_unlock_irqrestore+0x23/0x80 kernel/locking/spinlock.c:198
 spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
 lec_arp_destroy net/atm/lec.c:1543 [inline]
 lec_atm_close+0x976/0x9e0 net/atm/lec.c:497
 vcc_destroy_socket net/atm/common.c:181 [inline]
 vcc_release+0x10f/0x580 net/atm/common.c:205
 svc_release+0x6c/0xd0 net/atm/svc.c:95
 __sock_release net/socket.c:722 [inline]
 sock_close+0xc3/0x240 net/socket.c:1514
 __fput+0x44f/0xa60 fs/file_table.c:510
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 get_signal+0x11eb/0x1330 kernel/signal.c:2811
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:328 [inline]
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1af9f9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1afae30028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f1afa215fa0 RCX: 00007f1af9f9c819
RDX: 0000000000000000 RSI: 00000000000061d0 RDI: 0000000000000005
RBP: 00007f1afa032c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1afa216038 R14: 00007f1afa215fa0 R15: 00007ffdc6f7add8
 </TASK>
------------[ cut here ]------------
pvqspinlock: lock 0xffff888032ea0ea0 has corrupted value 0x0!
WARNING: kernel/locking/qspinlock_paravirt.h:506 at __pv_queued_spin_unlock_slowpath+0x1a5/0x270 kernel/locking/qspinlock_paravirt.h:504, CPU#0: syz.2.25/6044
Modules linked in:
CPU: 0 UID: 0 PID: 6044 Comm: syz.2.25 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
RIP: 0010:__pv_queued_spin_unlock_slowpath+0x1ce/0x270 kernel/locking/qspinlock_paravirt.h:504
Code: 04 48 89 df be 04 00 00 00 e8 4e 58 7b f6 48 89 d8 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 87 00 00 00 8b 13 4c 89 f7 48 89 de <67> 48 0f b9 3a eb 98 48 c7 c7 30 c8 82 8e 4c 89 f6 4c 89 fa e8 f9
RSP: 0018:ffffc90005087920 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff888032ea0ea0 RCX: ffffffff8bb5d542
RDX: 0000000000000000 RSI: ffff888032ea0ea0 RDI: ffffffff90357220
RBP: 1ffff110065d41d5 R08: ffff888032ea0ea3 R09: 1ffff110065d41d4
R10: dffffc0000000000 R11: ffffed10065d41d5 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffffff90357220 R15: ffff888032ea0ea8
FS:  00007f1afae306c0(0000) GS:ffff888125245000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1994be92f8 CR3: 000000007abce000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __raw_callee_save___pv_queued_spin_unlock_slowpath+0x15/0x30
 .slowpath+0x9/0x18
 pv_queued_spin_unlock arch/x86/include/asm/paravirt-spinlock.h:40 [inline]
 queued_spin_unlock arch/x86/include/asm/paravirt-spinlock.h:72 [inline]
 do_raw_spin_unlock+0xf5/0x210 kernel/locking/spinlock_debug.c:142
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:177 [inline]
 _raw_spin_unlock_irqrestore+0x23/0x80 kernel/locking/spinlock.c:198
 spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
 lec_arp_destroy net/atm/lec.c:1543 [inline]
 lec_atm_close+0x976/0x9e0 net/atm/lec.c:497
 vcc_destroy_socket net/atm/common.c:181 [inline]
 vcc_release+0x10f/0x580 net/atm/common.c:205
 svc_release+0x6c/0xd0 net/atm/svc.c:95
 __sock_release net/socket.c:722 [inline]
 sock_close+0xc3/0x240 net/socket.c:1514
 __fput+0x44f/0xa60 fs/file_table.c:510
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 get_signal+0x11eb/0x1330 kernel/signal.c:2811
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:328 [inline]
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1af9f9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1afae30028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f1afa215fa0 RCX: 00007f1af9f9c819
RDX: 0000000000000000 RSI: 00000000000061d0 RDI: 0000000000000005
RBP: 00007f1afa032c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1afa216038 R14: 00007f1afa215fa0 R15: 00007ffdc6f7add8
 </TASK>
----------------
Code disassembly (best guess):
   0:	04 48                	add    $0x48,%al
   2:	89 df                	mov    %ebx,%edi
   4:	be 04 00 00 00       	mov    $0x4,%esi
   9:	e8 4e 58 7b f6       	call   0xf67b585c
   e:	48 89 d8             	mov    %rbx,%rax
  11:	48 c1 e8 03          	shr    $0x3,%rax
  15:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
  1a:	84 c0                	test   %al,%al
  1c:	0f 85 87 00 00 00    	jne    0xa9
  22:	8b 13                	mov    (%rbx),%edx
  24:	4c 89 f7             	mov    %r14,%rdi
  27:	48 89 de             	mov    %rbx,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb 98                	jmp    0xffffffc9
  31:	48 c7 c7 30 c8 82 8e 	mov    $0xffffffff8e82c830,%rdi
  38:	4c 89 f6             	mov    %r14,%rsi
  3b:	4c 89 fa             	mov    %r15,%rdx
  3e:	e8                   	.byte 0xe8
  3f:	f9                   	stc


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

