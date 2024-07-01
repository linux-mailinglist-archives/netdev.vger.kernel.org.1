Return-Path: <netdev+bounces-108299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9FD91EB95
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 01:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E1B1F2212E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 23:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375D173323;
	Mon,  1 Jul 2024 23:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE6502A9
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719878001; cv=none; b=oI15yDCdQpRr3JhceVPDoR/Ri8pXnAHF41vThABQ34uGO5GnzhNnL9SFeyUcrv2zy23yXWeQ98T8KzIkCPYRDjBuMXwKM+xaPpPBltCaKBbwmJcCvZrGZa/h+p1RoLVYWfcEd1zZvqhPWmMpjeqnvrzxH5JfyCjVkRYOAzSTI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719878001; c=relaxed/simple;
	bh=PY2FAyPkvPGdHRXhpBQW569AJiePHyIVLAqLrk23LYo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eWchAeToHmPdEVFj8KA7WKCRk+MnTPMBcc2IUvDZK6zWwPMNyk75+OU0bhGyCZRvRcoj4QxhFFIEbQehR/rHQxkaiZR6m1KEvC2B0XzQRKG+HnnMFvCbpJYj/inGiqmzVfWOTJA28JNdBnUwxQmA8qnGkhBfEooUNa+AQ1ujHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ec0802fd0dso414508339f.0
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 16:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719877999; x=1720482799;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KaI/LO8DSIptlZVh7gM3/Uo8GPtDaJ/F+a6tBBbt6ow=;
        b=g3sXO8a0W6NSTRIuDRU/5XLueKmZUV4gk3isteXhvKoAhPEoeiikw+kn6/gncgbkLH
         QFCEHnBq0Sw/YEGQBStI1BdxOqCji0FVG+NBx8Eptqc7eZ4KedME4I4JcBCg+rB+Ro1H
         9mxlyiv2G7ZGQxI58LIA/Mlc7Wu2HwPmyXTxevhhKR2q/PqI/FV2U2AavkmbER/kF+Wf
         WYKqih0gkOfPfj6AYOqa5330p1KfUBPH518raiWN2V9iMIGnaoi/w8R7Yzevd4KRZnyO
         g1vvPWPN0yWWzjKyq+RGRlpkySDTa6bDmk8kgJBoDiHlFdUgIlVxAy/vXuvvxXA+rumH
         mfRg==
X-Forwarded-Encrypted: i=1; AJvYcCXdTPawZfQPcrHQfHRnlf+lIR+GDwkoHketlyPOsKidxN0S/Zk8i8zLBSnG1nbI+FB8xnWW8Uxaa/CD4QBK+uTloEsZSm3T
X-Gm-Message-State: AOJu0YyF9+38QG2aUreRqPTKkX5YkvkOX7WXjvJxaMye151Cn1tFQobO
	jQZ8rkuRv2UOHd3j0XvVXF8HJVSM0gGsA3KPWLs8IvugXOH2ytDvCdSVTU6R7ClPXYQsEeThVqY
	bV2yC2Hx9NEnu6wd4ddpkUGevxgM6RI5TLDSe+dnJ4xspPXBp1lU7R2Q=
X-Google-Smtp-Source: AGHT+IHYYMxefTUx0j/nVT23EjKfahCClX/zg25CWwLrdKau/tYn5C+kDh8Fx3kRiqxdkGD0qYChZjdeDyFCtboyZXEXVd6QOltM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd85:0:b0:375:9f67:6e7d with SMTP id
 e9e14a558f8ab-37cd2ed93bemr6559925ab.4.1719877999357; Mon, 01 Jul 2024
 16:53:19 -0700 (PDT)
Date: Mon, 01 Jul 2024 16:53:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000357ea9061c384d6d@google.com>
Subject: [syzbot] [bpf?] [net?] general protection fault in xdp_do_redirect
From: syzbot <syzbot+0b5c75599f1d872bea6f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    642a16ca7994 Add linux-next specific files for 20240627
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147914c6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba15715f73169384
dashboard link: https://syzkaller.appspot.com/bug?extid=0b5c75599f1d872bea6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ed10c6e9be/disk-642a16ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f2ca81ede1c4/vmlinux-642a16ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af14c94fa854/bzImage-642a16ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b5c75599f1d872bea6f@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 0 UID: 60928 PID: 8680 Comm: syz.1.877 Not tainted 6.10.0-rc5-next-20240627-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:xdp_do_redirect+0x63/0xb40 net/core/filter.c:4423
Code: c3 08 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 ec 04 91 f8 4c 8b 23 4d 8d 74 24 38 4c 89 f3 48 c1 eb 03 <42> 0f b6 04 2b 84 c0 0f 85 fc 07 00 00 41 8b 2e 89 ee 83 e6 02 31
RSP: 0018:ffffc9001600f828 EFLAGS: 00010202
RAX: 1ffff110033f1301 RBX: 0000000000000007 RCX: 0000000000040000
RDX: ffffc9000ac74000 RSI: 0000000000000204 RDI: 0000000000000205
RBP: ffffc9001600f9b0 R08: 0000000000000005 R09: ffffffff866b25e9
R10: 0000000000000005 R11: ffff888019f88000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000038 R15: ffffc9001600faf0
FS:  00007fe5bc2366c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2411f23000 CR3: 000000005d692000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tun_xdp_act+0xe9/0xb70 drivers/net/tun.c:1626
 tun_build_skb drivers/net/tun.c:1716 [inline]
 tun_get_user+0x346d/0x4560 drivers/net/tun.c:1819
 tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe5bb3746df
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 8b 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 8c 02 00 48
RSP: 002b:00007fe5bc236010 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe5bb503fa0 RCX: 00007fe5bb3746df
RDX: 000000000000003e RSI: 0000000020000280 RDI: 00000000000000c8
RBP: 00007fe5bb3f6756 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000003e R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe5bb503fa0 R15: 00007ffe2c314948
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:xdp_do_redirect+0x63/0xb40 net/core/filter.c:4423
Code: c3 08 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 ec 04 91 f8 4c 8b 23 4d 8d 74 24 38 4c 89 f3 48 c1 eb 03 <42> 0f b6 04 2b 84 c0 0f 85 fc 07 00 00 41 8b 2e 89 ee 83 e6 02 31
RSP: 0018:ffffc9001600f828 EFLAGS: 00010202
RAX: 1ffff110033f1301 RBX: 0000000000000007 RCX: 0000000000040000
RDX: ffffc9000ac74000 RSI: 0000000000000204 RDI: 0000000000000205
RBP: ffffc9001600f9b0 R08: 0000000000000005 R09: ffffffff866b25e9
R10: 0000000000000005 R11: ffff888019f88000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000038 R15: ffffc9001600faf0
FS:  00007fe5bc2366c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2411f23000 CR3: 000000005d692000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	c3                   	ret
   1:	08 18                	or     %bl,(%rax)
   3:	00 00                	add    %al,(%rax)
   5:	48 89 d8             	mov    %rbx,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  11:	74 08                	je     0x1b
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 ec 04 91 f8       	call   0xf8910507
  1b:	4c 8b 23             	mov    (%rbx),%r12
  1e:	4d 8d 74 24 38       	lea    0x38(%r12),%r14
  23:	4c 89 f3             	mov    %r14,%rbx
  26:	48 c1 eb 03          	shr    $0x3,%rbx
* 2a:	42 0f b6 04 2b       	movzbl (%rbx,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 fc 07 00 00    	jne    0x833
  37:	41 8b 2e             	mov    (%r14),%ebp
  3a:	89 ee                	mov    %ebp,%esi
  3c:	83 e6 02             	and    $0x2,%esi
  3f:	31                   	.byte 0x31


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

