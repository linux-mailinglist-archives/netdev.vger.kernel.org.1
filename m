Return-Path: <netdev+bounces-268049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDz+MM66t2mpUgEAu9opvQ
	(envelope-from <netdev+bounces-268049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:09:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E547A295FA2
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0979D300AD4F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9203559D3;
	Mon, 16 Mar 2026 08:09:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95DE34D90E
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648574; cv=none; b=tXxgQhboJFG4a1cuDOt5cWVDLzwhPley4qHK8SfNfj2LmJh2LtkT7uZ8i1pWCW7mTT17CQXh05oFd91/3gQveYw4keVSlmDSopicqgA3CX6BxE1Wv4zZymrdMOfzWbWEBYjEoBA/u5NHoV6MFshFL+pLUP+fxk1z06V2kMO6ILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648574; c=relaxed/simple;
	bh=thJD365okiqenSnQljJAGI+XKEWMc5ZNmCVmFSVYImM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VsoAl6sDZyEmgNwpDk7PvSLTbL1MVRGlAp9eAH9WkkF8P5+gGfspNIUeusfyPFGKLVQXpWXbA+el0TOb5yYjGKB8+nQ9C+vg5Ms0rabl5NR2g4h3YQtTpCXvi9uTwdEOLVcioXCO++dQWZp8NoL9vxxPC0n/uKeGKiY/cBDZVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-67bc5678917so38153656eaf.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 01:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773648572; x=1774253372;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFVik9JcxFFGQ9+gVQI6AOtVrNX2GuuPZE33BKs9lmM=;
        b=NPjCb3AzXMXI74sIOa+heXtTrK0W/IxvGHqfcRUZmHTdOZ+E+F4lbuX31hAU8sYVtS
         JknngdxlBWeWmosHsLRqgwQAi1zAsoERlTlx61XDm/hbekq0uVS7Rfk7aVPS43FiUSsm
         Z0dh/gL3kL4gV4EwO/n58wIPpvO8uZO/7kHwHFplM6zcrMZXBfc7eWT0P4lLFX6aI7un
         Um5ukGX68YPCVyaeQP52rIRrV8tx1FvFRd6x9bgTUXKIAQFL9quo/QlLZKtFfV5Gyjmn
         ufxjbYUqoreSTJFkL6zisG4lUhzdoJ7QyfC/0cBhpLoWXhNP4ec7dS0PwEsDHEPdAT2f
         9zxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqdmBSWJ+OmnwhaKNGbKWySjzEs+KB65wYs4TYi+ahIrp9OlT+HQo5hLzd5dnG33p9OCmauaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41hmysbPk+Mx1r406w5fK6jGwai52JwWoxhiTQV0i3Gg+qoKw
	COb75nkJgMk0ydzXJsRqVTChtqMvbrsQnuwEcBcXUv9f2Z42hkgeU5vo82WzfZV1CSJCsEkN1gO
	Jznkt1cN6mhBC3hFU6rAfHynEyl6sahXdQhv+uLCGZMRR+VtZozLFZMZ6MN8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1895:b0:67b:b718:1a44 with SMTP id
 006d021491bc7-67bda9ecb48mr8188993eaf.31.1773648571787; Mon, 16 Mar 2026
 01:09:31 -0700 (PDT)
Date: Mon, 16 Mar 2026 01:09:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b7babb.a00a0220.3b25d1.0024.GAE@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in mpoad_close
From: syzbot <syzbot+5ec223ccb83b24ef982f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=779072223d02a312];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-268049-lists,netdev=lfdr.de,5ec223ccb83b24ef982f];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email,storage.googleapis.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E547A295FA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    17edc4e820bf net: Convert move_addr_to_user() to scoped us..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b0d94a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=779072223d02a312
dashboard link: https://syzkaller.appspot.com/bug?extid=5ec223ccb83b24ef982f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8240a6a26b71/disk-17edc4e8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f03f846934c5/vmlinux-17edc4e8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18938471b971/bzImage-17edc4e8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ec223ccb83b24ef982f@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: lib/refcount.c:31 at refcount_warn_saturate+0x70/0x110 lib/refcount.c:31, CPU#1: syz.0.7057/31630
Modules linked in:
CPU: 1 UID: 0 PID: 31630 Comm: syz.0.7057 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/27/2026
RIP: 0010:refcount_warn_saturate+0x70/0x110 lib/refcount.c:31
Code: c6 00 28 f0 8e e8 10 13 17 fd 83 fb 01 7e 22 83 fb 02 74 39 83 fb 03 74 47 83 fb 04 75 68 e8 77 0d 17 fd 48 8d 3d 30 70 6d 0b <67> 48 0f b9 3a eb 66 85 db 74 3e 83 fb 01 75 4c e8 5b 0d 17 fd 48
RSP: 0018:ffffc9000cbdfb08 EFLAGS: 00010293
RAX: ffffffff84ae8bf9 RBX: 0000000000000004 RCX: ffff88804b5e9e80
RDX: 0000000000000000 RSI: ffffffff8ef02800 RDI: ffffffff901bfc30
RBP: ffffc9000cbdfc60 R08: ffff88804b5e9e80 R09: 0000000000000005
R10: 0000000000000004 R11: 0000000000000000 R12: f8f8f8f8f8f8f8f8
R13: dffffc0000000000 R14: ffff888034116668 R15: 0000000000000001
FS:  00005555772e8500(0000) GS:ffff888125565000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3d7900 CR3: 0000000083d7e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:461 [inline]
 refcount_dec include/linux/refcount.h:476 [inline]
 ref_tracker_free+0x6fc/0x840 lib/ref_tracker.c:298
 netdev_tracker_free include/linux/netdevice.h:4423 [inline]
 netdev_put include/linux/netdevice.h:4440 [inline]
 dev_put include/linux/netdevice.h:4466 [inline]
 mpoad_close+0x1fc/0x3e0 net/atm/mpc.c:889
 vcc_destroy_socket net/atm/common.c:181 [inline]
 vcc_release+0x10f/0x580 net/atm/common.c:205
 __sock_release net/socket.c:656 [inline]
 sock_close+0xc3/0x240 net/socket.c:1448
 __fput+0x44f/0xa70 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe20d19c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd9bdb8748 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fe20d417da0 RCX: 00007fe20d19c799
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fe20d417da0 R08: 0000000000000006 R09: 0000000000000000
R10: 00007fe20d417cb0 R11: 0000000000000246 R12: 00000000000f3cad
R13: 00007fe20d41627c R14: 00000000000f3ac2 R15: 00007ffd9bdb8850
 </TASK>
----------------
Code disassembly (best guess), 5 bytes skipped:
   0:	e8 10 13 17 fd       	call   0xfd171315
   5:	83 fb 01             	cmp    $0x1,%ebx
   8:	7e 22                	jle    0x2c
   a:	83 fb 02             	cmp    $0x2,%ebx
   d:	74 39                	je     0x48
   f:	83 fb 03             	cmp    $0x3,%ebx
  12:	74 47                	je     0x5b
  14:	83 fb 04             	cmp    $0x4,%ebx
  17:	75 68                	jne    0x81
  19:	e8 77 0d 17 fd       	call   0xfd170d95
  1e:	48 8d 3d 30 70 6d 0b 	lea    0xb6d7030(%rip),%rdi        # 0xb6d7055
* 25:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2a:	eb 66                	jmp    0x92
  2c:	85 db                	test   %ebx,%ebx
  2e:	74 3e                	je     0x6e
  30:	83 fb 01             	cmp    $0x1,%ebx
  33:	75 4c                	jne    0x81
  35:	e8 5b 0d 17 fd       	call   0xfd170d95
  3a:	48                   	rex.W


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

