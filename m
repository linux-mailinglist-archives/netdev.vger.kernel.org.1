Return-Path: <netdev+bounces-280765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHkDMMke6mntuQIAu9opvQ
	(envelope-from <netdev+bounces-280765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:29:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1DD452E78
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E3753009B2E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1D13F0AA7;
	Thu, 23 Apr 2026 13:23:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A623F0755
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776950615; cv=none; b=MRvBm4sAPIYXTZAVgRZjF4A3yGizm7IsCCcchzX2Dr5mdSJKMJKFoNRGSQfGbmRLS3R1FtK55hO7Q+3fhWV3Lq18tNMJN0gPZcH6FMxWzyYuUb22FaZ7kPVFj4lCaBgT6Dc7BxxrAFfKuD0ymwdhMnOxlSH31mdO89Lryd6PCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776950615; c=relaxed/simple;
	bh=63ShA8NK9kpnaJH+jLi3Lq4me0eshFWuqt1ONUPqAFQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yir5r7XzkJTswq4VkLGT5SUEjmWS/7eGD5c+2CaYw353lgS89uMAjnhEhi7HzE9JAa2vq0K/8YG/O7Ye9jF6dgP4hN1budI4SLbVOjlxfxZ6tGxQ97s0dVftDJD9eTp/WzzLfRPHs5VTq3bH5MaLyTnNFx3zhoklzoOImPOxadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6949ebccfcdso2887267eaf.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 06:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776950612; x=1777555412;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3RxVIZmQIvR1MLx6j1nb0GzLH5yhyU+E4PLS8iiTg4=;
        b=lIUuWJgj+xXsM3Z2LIiTaDYJHt3m3l1SJRjNFF3uM5r5LgXOawLT4AEFmVe9pjCIsV
         MDA5pDCK2Kp/hNJIZnE+rmy28sZ6Dplq0sSQYt8PnxcttX1oNxPYDB8ZuMJtrA2zKOMB
         Jp1Xv7YjVFmcFmiSMR5Hw2cnPAmocxiNq8Ceg2btuy00DKdsv6zjcR1UjrlcyY6PhAB+
         gFRMkJ1XXxmqxWfB6RWZ1QqQnzPAwrTHKxBSFniLApxZuTYp2lGss6EPtw8vMTm1EAA8
         9oJ3vO5gcE0d3VAY3vkOx1X0Vy5ddsuavKYSX7/p/2Hn6+WWYhlUti+BlYFmo/4PRU8G
         PPkw==
X-Forwarded-Encrypted: i=1; AFNElJ9+6GSoImoESrrTaCrudVtdqQPDVt96Hnsx3SRqKuNGf7uNgM5VXRhr917q5SD8NDZFu/4Z4dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSef+7tUnfB6azujryIMf2OdRJ1E6HldMbklQZ0HxoaYb04NPb
	7pUUoN5pqN9Czn0Ka5CmobIuTQuJjQseA2M/ITzlDtNTP4TeLmAvbg9YJrWjWivG6SysuGCj4Xc
	g9gdcjRcAyXkyxrcFfdiu+XimbwxPGAtLh9KsSoT0Z41GmRCha8bwPviMCDQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e90c:0:b0:694:8b4d:5f8f with SMTP id
 006d021491bc7-6948b4d61b9mr9352920eaf.57.1776950612565; Thu, 23 Apr 2026
 06:23:32 -0700 (PDT)
Date: Thu, 23 Apr 2026 06:23:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ea1d54.a00a0220.9259.0026.GAE@google.com>
Subject: [syzbot] [hams?] WARNING: ODEBUG bug in rose_release
From: syzbot <syzbot+b091c5774423d1319a22@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3e19fa1907a3dfda];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280765-lists,netdev=lfdr.de,b091c5774423d1319a22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,storage.googleapis.com:url,goo.gl:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:server fail];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 0E1DD452E78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    2a4c0c11c019 Merge tag 's390-7.1-1' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12df3702580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e19fa1907a3dfda
dashboard link: https://syzkaller.appspot.com/bug?extid=b091c5774423d1319a22
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2a4c0c11.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2702dddfd186/vmlinux-2a4c0c11.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51878be8732c/bzImage-2a4c0c11.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b091c5774423d1319a22@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88803f4d2090 object type: timer_list hint: rose_t0timer_expiry+0x0/0x150 include/linux/skbuff.h:2942
WARNING: lib/debugobjects.c:629 at debug_print_object+0x18e/0x2a0 lib/debugobjects.c:629, CPU#2: syz.1.11287/7248
Modules linked in:
CPU: 2 UID: 0 PID: 7248 Comm: syz.1.11287 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:debug_print_object+0x19b/0x2a0 lib/debugobjects.c:629
Code: b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 4f 48 8d 3d f2 18 e4 0b 41 56 48 8b 14 dd c0 33 1c 8c 4c 89 e6 <67> 48 0f b9 3a 58 83 05 0c c5 d9 0b 01 48 83 c4 18 5b 5d 41 5c 41
RSP: 0018:ffffc90005ba7808 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffffffff8c1c3300 RSI: ffffffff8c1c2f20 RDI: ffffffff90e6aac0
RBP: 0000000000000001 R08: ffff88803f4d2090 R09: ffffffff8bb2c6e0
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8c1c2f20
R13: ffffffff8bb2c720 R14: ffffffff8a84b230 R15: ffffc90005ba7908
FS:  0000000000000000(0000) GS:ffff8880d64db000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555594c2f9e8 CR3: 0000000039419000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1116 [inline]
 debug_check_no_obj_freed+0x4da/0x630 lib/debugobjects.c:1146
 slab_free_hook mm/slub.c:2620 [inline]
 slab_free mm/slub.c:6246 [inline]
 kfree+0x3d0/0x6c0 mm/slub.c:6561
 rose_neigh_put include/net/rose.h:166 [inline]
 rose_neigh_put include/net/rose.h:160 [inline]
 rose_release+0x60b/0x740 net/rose/af_rose.c:658
 __sock_release+0xb3/0x260 net/socket.c:722
 sock_close+0x1c/0x30 net/socket.c:1514
 __fput+0x3ff/0xb50 fs/file_table.c:510
 task_work_run+0x150/0x240 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x8d2/0x2a60 kernel/exit.c:975
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1117
 get_signal+0x1ec7/0x21e0 kernel/signal.c:3037
 arch_do_signal_or_restart+0x91/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x4a0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x706/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: eccb:0xe4a421182f13d611
Code: Unable to access opcode bytes at 0xe4a421182f13d5e7.
RSP: 002b:00007fb92f11ff58 EFLAGS: 00000756 ORIG_RAX: d1d66dbfed01019b
RAX: 2bf9e1987c1988ee RBX: 6f67a894836fe1f3 RCX: ed0b474b2b46640f
RDX: fb381f0b5e12d2ce RSI: 401aaa756d8c34aa RDI: 30b9ec15aecde911
RBP: 532828f82bbb556c R08: dbce39d105fdbf88 R09: ae9ea378b9c9fbc7
R10: 33740f3b8630618c R11: 2450ade207355af5 R12: 0a61688f027fb1a4
R13: 339c71c774e61334 R14: 28baed4a0483d193 R15: 7c1f9cf2b758efdc
 </TASK>
----------------
Code disassembly (best guess):
   0:	b8 00 00 00 00       	mov    $0x0,%eax
   5:	00 fc                	add    %bh,%ah
   7:	ff                   	lcall  (bad)
   8:	df 48 89             	fisttps -0x77(%rax)
   b:	fa                   	cli
   c:	48 c1 ea 03          	shr    $0x3,%rdx
  10:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  14:	75 4f                	jne    0x65
  16:	48 8d 3d f2 18 e4 0b 	lea    0xbe418f2(%rip),%rdi        # 0xbe4190f
  1d:	41 56                	push   %r14
  1f:	48 8b 14 dd c0 33 1c 	mov    -0x73e3cc40(,%rbx,8),%rdx
  26:	8c
  27:	4c 89 e6             	mov    %r12,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	58                   	pop    %rax
  30:	83 05 0c c5 d9 0b 01 	addl   $0x1,0xbd9c50c(%rip)        # 0xbd9c543
  37:	48 83 c4 18          	add    $0x18,%rsp
  3b:	5b                   	pop    %rbx
  3c:	5d                   	pop    %rbp
  3d:	41 5c                	pop    %r12
  3f:	41                   	rex.B


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

