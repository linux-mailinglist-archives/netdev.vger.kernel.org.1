Return-Path: <netdev+bounces-199800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29519AE1D3D
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B864616B021
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2038528DB4A;
	Fri, 20 Jun 2025 14:25:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835830E857
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429543; cv=none; b=dpaR1kj7sLFRyAewh/9oHzwDGAYGtTyxaJH9dDU7lDtxQ2sTP6pdcBxg77m3Veh/Lcs4Ss935fOs6/+DjYbDR7JDMzJQn3KMJb5qm5M6GCTuvc941pkeg6GVhViw+/gOvUd1P20rSslaOTqp+yieBZvAkVqvWGP/wqL6Jd7IyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429543; c=relaxed/simple;
	bh=8HkaNlz/z1RF1iFtvf3rQwBjKFiBjnp+npALTuGZSxA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EwITRY50kqcZy5XUis0/VbXDSr4qRuzs0xajS2isAN3XvECPR+7V0ir8HM4RBDT7n5OnovRyiD1mGCZYzPLV2bUjQTKxWO0ZCUGKKLjGDB/VwszDLbwLiellqVrJkw7AveTjSlNJh+DAVD6SpEx6nkzfvursKiXH1/fDatvyxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-2e95bf2f61dso1129393fac.1
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 07:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750429540; x=1751034340;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIuYEzj3Bif6xHXQrRqNZNi2f01/mYgvrmDFs7Ux7OQ=;
        b=hp2ouTAT4lNibP+Tly0kqU2JKAcTk37GBpKMfjrhSNaBWMmtJlRA5uVEujVcLyWLcf
         zdOKXv4GrvwhNsPBWPKSQ1icUchI2eOGkNCFNKXjwVNJ1v58sx20TPddD9BrIdnKEfwQ
         GMqcPM9ARw6yaaE7YlxTmXaSmpv1xBR6IyoOVNOe77i7zBOcA6NUDs/EG+gG78jQqfdQ
         bhGDE/UGl+59240Mt7ziSE/cJDaB5wR2xlimFKcldmWx21/9/5KhZOl5NbgemRFX9nYu
         QfE9hrht2VKyQ/1r0Cu3Q+ytTMM96+Zb82VK835syEavutOTtQLZ2Ax1ivzVyQhHT8SY
         gOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzuhOq8NTOLxqN3+P4ldcWd1r+j8fDdbIak19/Ye40pNUvO0DHCrt2Rk1eOUAh+aPKNtePgS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwWtrtsQDgV7dSVgzSJ4e1DaKXC5gkCK+7gSJxoyIH69lwNZo
	ucZRz+gE9i6dN9BVVYapQfCCmItn9Hd36urF/cwbGGLNmbBft5Wda3vEtoOUYcMyRkvZotnhKb6
	soc0zhO2+49UxfbigrYAC9UZxI7h/dr1mcVsLxbTMtOM0UkVGC8Nww9WyxP0=
X-Google-Smtp-Source: AGHT+IEXiz8sVveXCQTPjG7tOrNybCKhuwdIDwWDwdtIv00EE8qa0rkZ3+oxvR+pBoU8uR5CxXxC7Y38HIFl91iYoZGmgbjOO0+w
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:3dd:b540:b795 with SMTP id
 e9e14a558f8ab-3de3954f063mr26936825ab.3.1750429529031; Fri, 20 Jun 2025
 07:25:29 -0700 (PDT)
Date: Fri, 20 Jun 2025 07:25:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68556f59.a00a0220.137b3.004e.GAE@google.com>
Subject: [syzbot] [net?] [ext4?] general protection fault in clip_push
From: syzbot <syzbot+1316233c4c6803382a8b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    41687a5c6f8b Merge tag 'spi-fix-v6.16-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ca5370580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
dashboard link: https://syzkaller.appspot.com/bug?extid=1316233c4c6803382a8b
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17365d0c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cff5d4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-41687a5c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c889133baca6/vmlinux-41687a5c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/288c0c860dbf/bzImage-41687a5c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ad66cd154f6a/mount_4.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10818182580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1316233c4c6803382a8b@syzkaller.appspotmail.com

EXT4-fs: Ignoring removed oldalloc option
EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
Oops: general protection fault, probably for non-canonical address 0xdffffc000000001c: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000000e0-0x00000000000000e7]
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor180 Not tainted 6.16.0-rc2-syzkaller-00162-g41687a5c6f8b #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:clip_push+0x6dd/0x760 net/atm/clip.c:197
Code: 20 8d aa 8c e8 e4 f6 5b fa 48 83 3d bc 23 64 0f 00 0f 85 94 f9 ff ff e8 a1 32 27 f7 48 8d bb e0 00 00 00 48 89 f8 48 c1 e8 03 <0f> b6 04 28 84 c0 75 3c 8b ab e0 00 00 00 49 8d bd 40 01 00 00 be
RSP: 0018:ffffc9000d4e7898 EFLAGS: 00010202
RAX: 000000000000001c RBX: 0000000000000000 RCX: ffff888000f3c880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000e0
RBP: dffffc0000000000 R08: ffffffff8fa110f7 R09: 1ffffffff1f4221e
R10: dffffc0000000000 R11: ffffffff8a9922e0 R12: ffffffff8a9922e0
R13: ffff888031799000 R14: ffff8880429ce180 R15: ffff888031799578
FS:  0000000000000000(0000) GS:ffff88808d251000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f074213de58 CR3: 000000003f358000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vcc_destroy_socket net/atm/common.c:183 [inline]
 vcc_release+0x15a/0x460 net/atm/common.c:205
 __sock_release net/socket.c:647 [inline]
 sock_close+0xc0/0x240 net/socket.c:1391
 __fput+0x44c/0xa70 fs/file_table.c:465
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6ad/0x22e0 kernel/exit.c:955
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1104
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f07420ea849
Code: Unable to access opcode bytes at 0x7f07420ea81f.
RSP: 002b:00007f074209f198 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007f07421716c8 RCX: 00007f07420ea849
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f07421716cc
RBP: 00007f07421716c0 R08: 65732f636f72702f R09: 65732f636f72702f
R10: 65732f636f72702f R11: 0000000000000246 R12: 00007f074213e56c
R13: 00007f074209f1a0 R14: 0031656c69662f2e R15: 0000200000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:clip_push+0x6dd/0x760 net/atm/clip.c:197
Code: 20 8d aa 8c e8 e4 f6 5b fa 48 83 3d bc 23 64 0f 00 0f 85 94 f9 ff ff e8 a1 32 27 f7 48 8d bb e0 00 00 00 48 89 f8 48 c1 e8 03 <0f> b6 04 28 84 c0 75 3c 8b ab e0 00 00 00 49 8d bd 40 01 00 00 be
RSP: 0018:ffffc9000d4e7898 EFLAGS: 00010202
RAX: 000000000000001c RBX: 0000000000000000 RCX: ffff888000f3c880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000e0
RBP: dffffc0000000000 R08: ffffffff8fa110f7 R09: 1ffffffff1f4221e
R10: dffffc0000000000 R11: ffffffff8a9922e0 R12: ffffffff8a9922e0
R13: ffff888031799000 R14: ffff8880429ce180 R15: ffff888031799578
FS:  0000000000000000(0000) GS:ffff88808d251000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f074213de58 CR3: 00000000403da000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	20 8d aa 8c e8 e4    	and    %cl,-0x1b177356(%rbp)
   6:	f6 5b fa             	negb   -0x6(%rbx)
   9:	48 83 3d bc 23 64 0f 	cmpq   $0x0,0xf6423bc(%rip)        # 0xf6423cd
  10:	00
  11:	0f 85 94 f9 ff ff    	jne    0xfffff9ab
  17:	e8 a1 32 27 f7       	call   0xf72732bd
  1c:	48 8d bb e0 00 00 00 	lea    0xe0(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	75 3c                	jne    0x6e
  32:	8b ab e0 00 00 00    	mov    0xe0(%rbx),%ebp
  38:	49 8d bd 40 01 00 00 	lea    0x140(%r13),%rdi
  3f:	be                   	.byte 0xbe


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

