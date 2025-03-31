Return-Path: <netdev+bounces-178266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08920A762F5
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 11:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6131662D6
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D60E1D63F2;
	Mon, 31 Mar 2025 09:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE019AD23
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412227; cv=none; b=Lvj3Wz5kcfrCst0AD+vVhjCAwT/EOnrqBU8kbq0dNYqV8kR8XNpT4Q10m/luIs7L6iD6eQwtQ72LsLYDuE1DRAe7KCbfZfBbNQyn1OBWsKncCM2DZaE3EWDapIGApMa5FNmImQDGDZTwnfUwuM9yDzn7RUr5LNoa3a7v0LwIKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412227; c=relaxed/simple;
	bh=0Fp3Y5nHaVqfdk0s9zEmEU2EBx8pL1dRo6UL/IIA2Rk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lKbsrAYn0bSON3CVI6zAM7r/Mms3o5DgT5xpBV371pLAMcBrzPE2V7S88nddiR11xq1xfE3LmK00S8UPQci1qDIb1JzLcuUEr0kBJqyPB5UfXaooUAMe/pkGrcGX8hDkyizj2FVJmIFS/2wmE70Zh78MVU/8RMX5GRLsbZfAiTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d2b3882febso32918345ab.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 02:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743412225; x=1744017025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYJ5qslhquxdKXWOfBZbZNFTCfev/Er7026JBNDLSJU=;
        b=YgWqRFr4MpM42iG+4nTvyvlIuUgGJaABaQF5RjQqoUAB5MTbDAQAcbpZc93va9quuS
         bDbN4kw1SfQQXe+Vv4h4yzC0S1leLRZSV0gicxTFdQg40mfZJNrGJ2BaKCk7OqBe7yPi
         umxRv8hce8vridOt/LxUoKNJUnyDUMnHlVbVPFBX+o9/HlvvAvpQgO2E1UjHfXPVcghk
         kiT4xcHezmtiYvWHwZNKDQvHF1aGLc6dY7Q4yCNOFFQ4eXTcGx5JvJ4G6I0N9eAbpyPh
         hndGmKCTOI2cYms37OCVwZNtZOranMvhxS3Q2vvJE3jb8YPAC1fbv26DoHIWJlBleT4S
         gehw==
X-Forwarded-Encrypted: i=1; AJvYcCXFsk2K4P7J1TOFn1muV6O6PyQY2zRHk0dbHXzQUtZQrkU8Psf5aL5IzUNfYILdYBJNmnaucqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlBRoHNRbsM2NEpG/ZVN6+WiC3XVqRNAssk/aSIn5OHjQI2E3B
	ZzReIb8xpXU6T1znYoe22KpEbpYT63hWuDAS5vG340aFALB+b9liRgU9eZPgH4vU6EKNBCx+55C
	m3I53HLtC6Np/FHpJgv+BUzmCagXwovJuANzOB1NAxzalKAQxNZmFjjw=
X-Google-Smtp-Source: AGHT+IH7RCxgjWEkseAVDE0s/VYe7EUPYobaVOoeQjK4P+v5Gn9LH7UbN48xhkezAex7Vgupvtor+3aRgs01LfyeYkXc+aFCQOwM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1569:b0:3d3:ff09:432c with SMTP id
 e9e14a558f8ab-3d5e08ea12emr74159725ab.4.1743412225069; Mon, 31 Mar 2025
 02:10:25 -0700 (PDT)
Date: Mon, 31 Mar 2025 02:10:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ea5c01.050a0220.1547ec.012b.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in kernel_sock_shutdown (3)
From: syzbot <syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f8ec98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1635bf4c5557b92
dashboard link: https://syzkaller.appspot.com/bug?extid=fae49d997eb56fa7c74d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d197a4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/323a5d590eec/disk-d082ecbc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7c4b6e33fd9/vmlinux-d082ecbc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c518bbd55334/bzImage-d082ecbc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
CPU: 0 UID: 0 PID: 6092 Comm: syz.0.24 Not tainted 6.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3660
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 33 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 1a 49 8b 44 24 68 89 ee 48 89 df 5b 5d 41 5c ff e0
RSP: 0018:ffffc90002f27700 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888060d6f800 RCX: 0000000000000000
RDX: 000000000000000d RSI: ffffffff8925a602 RDI: 0000000000000068
RBP: 0000000000000002 R08: 0000000000000001 R09: fffffbfff2dd7dae
R10: ffffffff96ebed77 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888024c5ae00 R14: ffff888024c59e40 R15: 0000000000000000
FS:  00007f57dba706c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000062018000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:181
 sctp_udp_sock_stop+0xf5/0x160 net/sctp/protocol.c:937
 proc_sctp_do_udp_port+0x261/0x450 net/sctp/sysctl.c:553
 proc_sys_call_handler+0x3c6/0x5a0 fs/proc/proc_sysctl.c:601
 iter_file_splice_write+0x90f/0x10b0 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x18f/0x6c0 fs/splice.c:1164
 splice_direct_to_actor+0x346/0xa40 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x178/0x250 fs/splice.c:1233
 do_sendfile+0xafb/0xe40 fs/read_write.c:1363
 __do_sys_sendfile64 fs/read_write.c:1424 [inline]
 __se_sys_sendfile64 fs/read_write.c:1410 [inline]
 __x64_sys_sendfile64+0x1da/0x220 fs/read_write.c:1410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f57dab8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f57dba70038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f57dada6080 RCX: 00007f57dab8d169
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000003
RBP: 00007f57dac0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f57dada6080 R15: 00007ffea4fcc208
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3660
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 33 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 1a 49 8b 44 24 68 89 ee 48 89 df 5b 5d 41 5c ff e0
RSP: 0018:ffffc90002f27700 EFLAGS: 00010202

----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   c:	75 33                	jne    0x41
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	4c 8b 63 20          	mov    0x20(%rbx),%r12
  1c:	49 8d 7c 24 68       	lea    0x68(%r12),%rdi
  21:	48 89 fa             	mov    %rdi,%rdx
  24:	48 c1 ea 03          	shr    $0x3,%rdx
* 28:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2c:	75 1a                	jne    0x48
  2e:	49 8b 44 24 68       	mov    0x68(%r12),%rax
  33:	89 ee                	mov    %ebp,%esi
  35:	48 89 df             	mov    %rbx,%rdi
  38:	5b                   	pop    %rbx
  39:	5d                   	pop    %rbp
  3a:	41 5c                	pop    %r12
  3c:	ff e0                	jmp    *%rax


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

