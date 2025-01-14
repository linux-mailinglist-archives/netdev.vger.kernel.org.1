Return-Path: <netdev+bounces-158153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A87A109D3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9265D7A59A4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6130A14D2BD;
	Tue, 14 Jan 2025 14:48:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34013A879
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866107; cv=none; b=pc7JOuSYo2+t3anEY98KMnMgr/cC5zv817Jl/+PfFUX08PmWWANtkoQ6hvHddYptqCKfiPHlI4A2k4s0cuMkpS2LO8ufur0++CIcvtF+XpSevmjeFbbsjAyGP1cRJ/hsc0s411DkATqL9g2DFuwlpptCkUDgWblm9WnaEigieh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866107; c=relaxed/simple;
	bh=GAqZTwhojEai05l143Q0cbWkRvqG76Uv+ZEGiMlQCI4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SuJTq2CVvZb4//QQv34paev4VPPlcDlhkxk6n+giASlVWvjj+mj1ur+wEM/sNdCVTNDGD2rGdW+E7tOjeYcqeXTQTUS4dXJ+c7VKDFkcy8hIUAXtShvZ+08j+gEC2X7yK6eZwCyF0gzYYqrhVo03NlHbosGH3bWSqTqsrg0CfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce7b6225aeso10829445ab.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 06:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736866105; x=1737470905;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdHuHYIHigI2HG/3al45TqM1nURPxcXiuyoRnE7jjfo=;
        b=ItU8n49nCcZdVCoj9RY76seunsNKtva335mnwMddDl69yPDLQuvNtdtfnI7EsXx4bK
         n286EZZcEn/luYMJlUOJqqJ9At9acuF2ugOxb9s6G3eN/cA7x5TNU7UP97o1ilLEyABP
         GMHj4FvSPNITPNSY4+S1DBydvnGeo2u31g0GP0Rm/AxrxT6a2QirDzRup+pdAPNbVbXp
         GnRQkIYIMKgHHIGK0RbLsKPEc7YIhjsgZABuDDTHGXxvOCFWn1l6odlWVTCY6S6gs12X
         EckVeqd8IyjAUrlcidNVg2+XQcqBK8lsAo3C2F7R1HlJCiil4/1Kh2mCOJNib400ceQ9
         TxEw==
X-Forwarded-Encrypted: i=1; AJvYcCXhfXTB/pAq7ncbcz17XofnSGrB/WynvoMNmjIZkP1geerJm/b22JiUBbU58CFQxghrLWCAcTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1cun+SIzI4hHpKI7dHOEQcJ2x5ucH48MUWY+Ll0BdLDrcFmQW
	EcbsO39Ae/4dKHu+kQ9uJmYj/BUqJKTcgBZDZ3U4L3+wuXkMtcLmGSkkjfRARONZ97TPTbJgY9V
	ZEo3w+uacDspqyrPcV8vpdPiBikZn75ruRkTyEv1fsNTu0O+1VAa2NTU=
X-Google-Smtp-Source: AGHT+IEK+4uzW1kPOyZV52DbWzrRwZj3WfUL2LiMZT5oP3XvaKnr5cH4TintgJz+F1kbQHWnI2HRAPbnMkQKg4dRGFUlONkDgWkb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe6:b0:3ce:568:b62a with SMTP id
 e9e14a558f8ab-3ce3a88ac9amr202241825ab.14.1736866103312; Tue, 14 Jan 2025
 06:48:23 -0800 (PST)
Date: Tue, 14 Jan 2025 06:48:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67867937.050a0220.216c54.007c.GAE@google.com>
Subject: [syzbot] [net?] [virt?] general protection fault in vsock_stream_has_data
From: syzbot <syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com>
To: bobby.eshleman@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux-foundation.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    25cc469d6d34 net: phy: micrel: use helper phy_disable_eee
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15faeef8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d50f1d63eac02308
dashboard link: https://syzkaller.appspot.com/bug?extid=71613b464c8ef17ab718
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e374b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1778d3c4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1a1fa1071012/disk-25cc469d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fcf28733f5e/vmlinux-25cc469d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed476a847c4e/bzImage-25cc469d.xz

The issue was bisected to:

commit 71dc9ec9ac7d3eee785cdc986c3daeb821381e20
Author: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Fri Jan 13 22:21:37 2023 +0000

    virtio/vsock: replace virtio_vsock_pkt with sk_buff

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102b1ef8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=122b1ef8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=142b1ef8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com
Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.13.0-rc6-syzkaller-00898-g25cc469d6d34 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: vsock-loopback vsock_loopback_work
RIP: 0010:vsock_stream_has_data+0x46/0x70 net/vmw_vsock/af_vsock.c:873
Code: 8d 9e 50 05 00 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 58 82 5c f6 48 8b 1b 48 83 c3 60 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 3b 82 5c f6 4c 8b 1b 4c 89 f7 5b
RSP: 0018:ffffc900000d7748 EFLAGS: 00010206
RAX: 000000000000000c RBX: 0000000000000060 RCX: ffff88801cac5a00
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888077bf08c0
RBP: ffff888077bf08c0 R08: ffff888077bf0927 R09: 1ffff1100ef7e124
R10: dffffc0000000000 R11: ffffed100ef7e125 R12: dffffc0000000000
R13: ffffffff8ffeb820 R14: ffff888077bf08c0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffca709b000 CR3: 000000007b69c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 virtio_transport_do_close+0x64/0x3d0 net/vmw_vsock/virtio_transport_common.c:1214
 virtio_transport_recv_disconnecting net/vmw_vsock/virtio_transport_common.c:1452 [inline]
 virtio_transport_recv_pkt+0x1755/0x2b10 net/vmw_vsock/virtio_transport_common.c:1661
 vsock_loopback_work+0x3e9/0x530 net/vmw_vsock/vsock_loopback.c:133
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vsock_stream_has_data+0x46/0x70 net/vmw_vsock/af_vsock.c:873
Code: 8d 9e 50 05 00 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 58 82 5c f6 48 8b 1b 48 83 c3 60 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 3b 82 5c f6 4c 8b 1b 4c 89 f7 5b
RSP: 0018:ffffc900000d7748 EFLAGS: 00010206
RAX: 000000000000000c RBX: 0000000000000060 RCX: ffff88801cac5a00
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888077bf08c0
RBP: ffff888077bf08c0 R08: ffff888077bf0927 R09: 1ffff1100ef7e124
R10: dffffc0000000000 R11: ffffed100ef7e125 R12: dffffc0000000000
R13: ffffffff8ffeb820 R14: ffff888077bf08c0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffca709b000 CR3: 00000000334b6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8d 9e 50 05 00 00    	lea    0x550(%rsi),%ebx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 58 82 5c f6       	call   0xf65c8274
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 60          	add    $0x60,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 3b 82 5c f6       	call   0xf65c8274
  39:	4c 8b 1b             	mov    (%rbx),%r11
  3c:	4c 89 f7             	mov    %r14,%rdi
  3f:	5b                   	pop    %rbx


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

