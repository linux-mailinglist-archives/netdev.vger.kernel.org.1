Return-Path: <netdev+bounces-189451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25605AB234D
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598DB1BA591C
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25813222589;
	Sat, 10 May 2025 10:23:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB90259C
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746872613; cv=none; b=nHJFlo80Bcc/h1rF46eMapBsWkks+/8QqpP1WtPrdcJGOnQLebcrMhxNLd4u3NNNROmCB9eNyLqE1j2/og5hDy8QsoGZNvQbN5hILHoW9IszOSnVx+IoBdHWm+jfDGHVGyOOK75WwPUsNgfSP8kbh+vWNw4yjVsHrEsw8AbnzZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746872613; c=relaxed/simple;
	bh=q0wisZRt5L9pgCrLCML8CY8UvzsBCAeD/nP6yE4p5bY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WJSM//Rmii+/2DC/pT4UDzZDGej9JjGVeo4+cclWOzAIWWPTbZX8Ki2R/f/Tnmmwzqpwh72bniVdOI2R6gFZ9XiqRdF5ymMv9jXUriu9wpuDI1eJ+qIohroPaEkoHWMhMXivK1ucF5vvP7JFO2Woxo2jcrFM49vwGaceOAYZ9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3da779063a3so34024495ab.3
        for <netdev@vger.kernel.org>; Sat, 10 May 2025 03:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872610; x=1747477410;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ME2pcLTIWfFJQpkjnq7laYhtteo6YmR7jL8iYdx3Li0=;
        b=E6JIEHKov0EPp61NIXwZyTRQPEoVX5bW1NjT0gGlU8q37Mj2L4ex0CKdh1vq8joqh/
         5j76EzVfj3Fx4mu0Jkdgwbadh9jiE6eDsYM2B7JTOBzsWIpA86KVuPnewJfjlvSNYmRX
         siYpJV9wzkfXqZ2ZrhPmLbLU9oD006EL13t8t9MBYywQAkIv+aBofnZuDGMWuJScRteC
         EWysGmRjzgvR0iKn/f8kf7Qbv8JUbLjEyFkC8HC6v9LYRR3Wn+e9Ey9wi0Ue5BLed0go
         nEiVih7B0eY6TZEJT8dLo7IbP3pr6ZrSFRZbp7qpCycer88l4RXksqPapE3C0TLtWOjm
         +HQg==
X-Forwarded-Encrypted: i=1; AJvYcCVveTMZP2NL3TtEpqzT+RpEY8tfTwxhfSxiS/ieAIglJsXenLn2gqDQHc+PLpU6rPFubxk0Otk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU4a6s8uGlIXRElKN7CBTqXJGJEA+sGf2ehvrgXBJbK0uephp3
	EzGjvNSqCTLg5k4v8P//nWLWMRc2VKq+YiSc6FF/lwlsLq5KiOCVetAejVbmahC8DyqbgmfiG7c
	iRaboLn0ElHpM9uLH8KV2FqBH5eMxKNshF5Iu6AhnE0o95EU/f4Fyuio=
X-Google-Smtp-Source: AGHT+IE3kICTyrVLQUUUSYgkh0Ms303NZQ2PftYdffS42SfBgyOrUm0wsE8sLG569ASRtLgT2wKNruVCdhqJ9aKfE5sWbepAQ3eg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2489:b0:3da:6f46:5c1a with SMTP id
 e9e14a558f8ab-3da7e1e1b12mr79953545ab.2.1746872610474; Sat, 10 May 2025
 03:23:30 -0700 (PDT)
Date: Sat, 10 May 2025 03:23:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681f2922.050a0220.f2294.0005.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_drv_port_add
From: syzbot <syzbot+1e4a7dc1542addfca0a5@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c69f8884904 Merge tag 'bcachefs-2025-05-08' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b5d8f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b353fce507849ee
dashboard link: https://syzkaller.appspot.com/bug?extid=1e4a7dc1542addfca0a5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f122d34f751/disk-9c69f888.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2f2b90345ca/vmlinux-9c69f888.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90cead75be18/bzImage-9c69f888.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e4a7dc1542addfca0a5@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffffffffffee8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD e184067 P4D e184067 PUD e186067 PMD 0 
Oops: Oops: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 19500 Comm: syz.0.2769 Tainted: G     U              6.15.0-rc5-syzkaller-00136-g9c69f8884904 #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:580 [inline]
RIP: 0010:__mutex_lock+0x159/0xb90 kernel/locking/mutex.c:746
Code: 00 8b 35 9a 09 48 0f 85 f6 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 60 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 93 07 00 00 <48> 3b 5b 60 0f 85 e0 01 00 00 bf 01 00 00 00 e8 43 0d 1e f6 48 8d
RSP: 0018:ffffc9000407fa50 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: fffffffffffffe88 RCX: 1ffffffff35654bc
RDX: 1fffffffffffffdd RSI: 0000000000000000 RDI: fffffffffffffee8
RBP: ffffc9000407fb90 R08: ffffffff870eaaa4 R09: 0000000000000000
R10: ffffc9000407fba8 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc9000407fad0 R14: 0000000000000000 R15: 1ffff9200080ff54
FS:  00007ff6196956c0(0000) GS:ffff8881249ec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffee8 CR3: 000000005fcee000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nsim_drv_port_add+0x54/0x1a0 drivers/net/netdevsim/dev.c:1710
 new_port_store+0x129/0x170 drivers/net/netdevsim/bus.c:79
 dev_attr_store+0x55/0x80 drivers/base/core.c:2440
 sysfs_kf_write+0xef/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x351/0x510 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x5ba/0x1180 fs/read_write.c:684
 ksys_write+0x12a/0x240 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff61878e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff619695038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ff6189b5fa0 RCX: 00007ff61878e969
RDX: 0000000000000001 RSI: 0000200000000500 RDI: 0000000000000003
RBP: 00007ff618810ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff6189b5fa0 R15: 00007ffde1b77968
 </TASK>
Modules linked in:
CR2: fffffffffffffee8
---[ end trace 0000000000000000 ]---
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:580 [inline]
RIP: 0010:__mutex_lock+0x159/0xb90 kernel/locking/mutex.c:746
Code: 00 8b 35 9a 09 48 0f 85 f6 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 60 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 93 07 00 00 <48> 3b 5b 60 0f 85 e0 01 00 00 bf 01 00 00 00 e8 43 0d 1e f6 48 8d
RSP: 0018:ffffc9000407fa50 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: fffffffffffffe88 RCX: 1ffffffff35654bc
RDX: 1fffffffffffffdd RSI: 0000000000000000 RDI: fffffffffffffee8
RBP: ffffc9000407fb90 R08: ffffffff870eaaa4 R09: 0000000000000000
R10: ffffc9000407fba8 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc9000407fad0 R14: 0000000000000000 R15: 1ffff9200080ff54
FS:  00007ff6196956c0(0000) GS:ffff8881249ec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffee8 CR3: 000000005fcee000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	8b 35 9a 09 48 0f    	mov    0xf48099a(%rip),%esi        # 0xf4809a0
   6:	85 f6                	test   %esi,%esi
   8:	75 29                	jne    0x33
   a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  11:	fc ff df
  14:	48 8d 7b 60          	lea    0x60(%rbx),%rdi
  18:	48 89 fa             	mov    %rdi,%rdx
  1b:	48 c1 ea 03          	shr    $0x3,%rdx
  1f:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  23:	0f 85 93 07 00 00    	jne    0x7bc
* 29:	48 3b 5b 60          	cmp    0x60(%rbx),%rbx <-- trapping instruction
  2d:	0f 85 e0 01 00 00    	jne    0x213
  33:	bf 01 00 00 00       	mov    $0x1,%edi
  38:	e8 43 0d 1e f6       	call   0xf61e0d80
  3d:	48                   	rex.W
  3e:	8d                   	.byte 0x8d


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

