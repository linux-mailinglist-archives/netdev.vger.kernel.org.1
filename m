Return-Path: <netdev+bounces-293306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDy9Odh7GmrW4ggAu9opvQ
	(envelope-from <netdev+bounces-293306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 07:55:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B8260B5EA
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 07:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D84F53004CB2
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 05:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C214825B0A3;
	Sat, 30 May 2026 05:55:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BD2222D0
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780120529; cv=none; b=TX+Pr1gvNuzgPMnm1zYFLYCfjn7uaUlf8h5u4s908VNOkHUNBmkqwuJAvBVcMLQazz8F3FeH5usEzYGwxgRgyXYb2iDo0oTqNGYW3cbs+Jum43e2cH9IAXa0WRj+ZFQjmjfON/bl1eCd2Md3wXkqMhXRBmZKV5tjguUNaDKtzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780120529; c=relaxed/simple;
	bh=EwrszXQ4S2FHDYbiBhzeDind2XSN+5k568R7ehjpp50=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KkL8e5b6ffB3oDA90ouHe/QGw6LrofbrnFamzSZdn9HNywH6F61SITlpKCWcP2c4XT+k+sjpHAWbRo/3+U4Wt+kOfg1pDkiFlP8tsVXQ+g1G99FoYIhKjGELmiJNzedQEB3QZFpHFvLqBLneDuRS8UwBxjA12j5CgRPj0JZEM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-69de11bef3dso4133043eaf.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 22:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780120527; x=1780725327;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1m7I++Q6yyoUoXwVe9qgrro1GQAwLd9tdhMu6xnQm7U=;
        b=mYvRug1aK4hLwmmsXq0+zvBssANPugLixM716w/JMNdp3gjfco5obon/nEPcpVomwx
         V2RVbE8ot8JreQRmBTdrn4HQfWEYIZxjef0wKGUpGPcapGL0YmNaQygFdr4HkYpZGwm/
         rxOsL1xSSf1BLYjLJRv4VUhaLlX4INvbD6nYzYJpmIBh7S8GBfp8edL/KP5vHiE64110
         zLglwC0A07TNoQozCoOYeJn5T4bMFKqkE6Rk3u8Sk+qVhXvAg41P5eeDOCyNgMNgI7eO
         xmFznvh+qq3YYto6bAdhhuSV14tWbC08mMeABE2LM2VRhbf0O2BXfVHRJEz2OGj55OU9
         VRwg==
X-Forwarded-Encrypted: i=1; AFNElJ/bef5PfKs/e3ilPm/YmV18HBbsWxvBfXfwjFVVRXKTeyxiQ+ERDHA1+bM0iLjjG5k2zIOCCfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTtPhBBVa/Nw56tXCL1RwACVyvXi6rpF2A+5+u62H5VV7SnLRt
	inw7muvk0/uRfHlzJ+J9hX5Nr/ukw4G1pA0bIVSqrYJke5XXU/OWP4lkGwIbiVDcKR2XB0z4jnh
	kb22zx+kh/GXXD0UNxuJLmCKOD9njMq675zseNw8i8/JpbJohfYtOyLlC6GA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c8a:b0:69d:ce78:79a0 with SMTP id
 006d021491bc7-69e105642f6mr1130878eaf.34.1780120527435; Fri, 29 May 2026
 22:55:27 -0700 (PDT)
Date: Fri, 29 May 2026 22:55:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1a7bcf.0a9e871e.332604.000b.GAE@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in __inet_csk_reqsk_queue_drop
From: syzbot <syzbot+e809069bc15f26300526@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=bd38685893011045];
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
	TAGGED_FROM(0.00)[bounces-293306-lists,netdev=lfdr.de,e809069bc15f26300526];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,storage.googleapis.com:url,appspotmail.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,googlegroups.com:email,syzkaller.appspot.com:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: E9B8260B5EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    eb3f4b7426cf Merge tag 'nfsd-7.1-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e5b673980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd38685893011045
dashboard link: https://syzkaller.appspot.com/bug?extid=e809069bc15f26300526
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e8630fd2e70/disk-eb3f4b74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a23f2a3eb2a/vmlinux-eb3f4b74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e102c22c34c3/bzImage-eb3f4b74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e809069bc15f26300526@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xb2/0x110 lib/refcount.c:28, CPU#0: ktimers/0/16
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:refcount_warn_saturate+0xb2/0x110 lib/refcount.c:28
Code: e4 7d d1 0a 67 48 0f b9 3a eb 4a e8 38 3d 23 fd 48 8d 3d e1 7d d1 0a 67 48 0f b9 3a eb 37 e8 25 3d 23 fd 48 8d 3d de 7d d1 0a <67> 48 0f b9 3a eb 24 e8 12 3d 23 fd 48 8d 3d db 7d d1 0a 67 48 0f
RSP: 0000:ffffc90000157948 EFLAGS: 00010246
RAX: ffffffff84a1301b RBX: 0000000000000003 RCX: ffff88801ca98000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffffffff8f72ae00
RBP: ffffffff99ae3b01 R08: ffff88801ca98000 R09: 0000000000000005
R10: 0000000000000100 R11: 0000000000000004 R12: ffff8880425ef568
R13: ffff8880425ef4f8 R14: ffff8880425ef578 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888126386000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b46710e9c CR3: 000000000dbb6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:400 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 reqsk_put include/net/request_sock.h:136 [inline]
 __inet_csk_reqsk_queue_drop+0x3ce/0x440 net/ipv4/inet_connection_sock.c:1007
 reqsk_timer_handler+0x651/0xdf0 net/ipv4/inet_connection_sock.c:1137
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x6a3/0x9f0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0x67/0x170 kernel/time/timer.c:2403
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1151
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	e4 7d                	in     $0x7d,%al
   2:	d1 0a                	rorl   $1,(%rdx)
   4:	67 48 0f b9 3a       	ud1    (%edx),%rdi
   9:	eb 4a                	jmp    0x55
   b:	e8 38 3d 23 fd       	call   0xfd233d48
  10:	48 8d 3d e1 7d d1 0a 	lea    0xad17de1(%rip),%rdi        # 0xad17df8
  17:	67 48 0f b9 3a       	ud1    (%edx),%rdi
  1c:	eb 37                	jmp    0x55
  1e:	e8 25 3d 23 fd       	call   0xfd233d48
  23:	48 8d 3d de 7d d1 0a 	lea    0xad17dde(%rip),%rdi        # 0xad17e08
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb 24                	jmp    0x55
  31:	e8 12 3d 23 fd       	call   0xfd233d48
  36:	48 8d 3d db 7d d1 0a 	lea    0xad17ddb(%rip),%rdi        # 0xad17e18
  3d:	67                   	addr32
  3e:	48                   	rex.W
  3f:	0f                   	.byte 0xf


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

