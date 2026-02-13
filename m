Return-Path: <netdev+bounces-258684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id w+nnFQWjj2mqSAEAu9opvQ
	(envelope-from <netdev+bounces-258684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 23:17:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2488139BFC
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 23:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C18C43004914
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D732830ACFB;
	Fri, 13 Feb 2026 22:17:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A282FC02F
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771021056; cv=none; b=LyPvWCx3WTCaqz2HKbM9jQmCwTI5YLcHy1cqscxfqxNaoKy8mTPycNa1wXAcMiEO9PRsBaIvXzQ1oW88LWtvJfXgN/J5WLI6lntKgbikatnbnjV3OPtSQ8njnJQwj7cPOnlOuhgGmOEKVM0NfqyS3cfgj9SCMHpH3oxf8XCV7wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771021056; c=relaxed/simple;
	bh=1DDCj1TA2rW1TMXxauVPw3Us56ynp/7idGRVAz/CKh8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S3QE7OJjdGL+G0xHUR9QM02h1L2mzEap5WQcTvT5IfKwetk4amxUVLbTDaMyFBkHaevy4fPerbvadnpEqDkYlqldZeG7snlZ6vhE+rPwttnlRO9oDVPxynQnxEXcPdeBh3IS3nDhmNQbG+zF/txZHbUzYe9TdRuuCjkMmvnWyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67792d46a05so7584497eaf.1
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 14:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771021054; x=1771625854;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8HJ47+9p4PuTuc5TPH2mXar9WAAqXbe2n3lnWHS7dg=;
        b=rwXoUn5vmT78htFhidOEOgCgKSadnd1eIEUa+0El8BR5Cz5yb+zn7B+SyfT4ovWA9t
         4Ov8kB+56E1F+dRjP8KMO0YuHGLjQO2SA3KV93LUlYL6J0DfDhntf+YPkvMw/tTiiqP1
         FLcBvMOhpuC2z00W0gPXM6UcSg2qUf7TYhaQMGNxvbBPEcunBGlt3k8WGwiwhPCl28sG
         4KspoTu6dHN8xeFdsdJJYQIX5ZXOI+s2hSCJ6zSnEyQYsDZwlR0Th/obKquT+mVJ3ZL/
         4yAfI0o7dMzGu5be9tMDyhBkixb1bUxVIR5ptEDTNKjDvM8nBl6oFjjG5fXsUw9HjAz2
         VxnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPWAjs/El9GZ5Sv6qLqt6NkNHxLXmzxo2es4TERmyCgoAG6cPBDULfO+LNRaDxvEguBzq0ZPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK60vGwohKrS05DE1+amJ2mRVys3SnKUEsFOBn5Pxfph6DsDrX
	FEBLkKhcuPWvgdbUwVhj94HJUkGS/guv/xlZBg99vIXAzo5EzFpgIMiu6YyE1NhduVlrAnV1BoA
	MMQBjlXn9MKgwcM47oWTxOQVawKKg/qNiLNwsQGz0DMtHCy4uOgkFUnfivVI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ec46:0:b0:65d:33de:1c56 with SMTP id
 006d021491bc7-6776978dc3fmr1329805eaf.64.1771021054419; Fri, 13 Feb 2026
 14:17:34 -0800 (PST)
Date: Fri, 13 Feb 2026 14:17:34 -0800
In-Reply-To: <68b7284f.050a0220.3db4df.01d7.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698fa2fe.a70a0220.3c8f9c.0076.GAE@google.com>
Subject: Re: [syzbot] [hams?] WARNING: ODEBUG bug in __run_timers (3)
From: syzbot <syzbot+7287222a6d88bdb559a7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f71c66df48515cc1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258684-lists,netdev=lfdr.de,7287222a6d88bdb559a7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,storage.googleapis.com:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: A2488139BFC
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    cee73b1e840c Merge tag 'riscv-for-linus-7.0-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15eae15a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f71c66df48515cc1
dashboard link: https://syzkaller.appspot.com/bug?extid=7287222a6d88bdb559a7
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f68722580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114c6b3a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-cee73b1e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/075d9080a7b6/vmlinux-cee73b1e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/98697e710988/bzImage-cee73b1e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7287222a6d88bdb559a7@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff8880375c4c90 object type: timer_list hint: rose_t0timer_expiry+0x0/0x150 include/linux/skbuff.h:2928
WARNING: lib/debugobjects.c:612 at debug_print_object+0x18e/0x2a0 lib/debugobjects.c:612, CPU#3: swapper/3/0
Modules linked in:
CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:debug_print_object+0x19b/0x2a0 lib/debugobjects.c:612
Code: b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 4f 48 8d 3d 72 78 ee 0b 41 56 48 8b 14 dd 60 ec 1a 8c 4c 89 e6 <67> 48 0f b9 3a 58 83 05 9c 48 e4 0b 01 48 83 c4 18 5b 5d 41 5c 41
RSP: 0018:ffffc900006f8a38 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffffffff8c1aeba0 RSI: ffffffff8c1ae7c0 RDI: ffffffff90e333c0
RBP: 0000000000000001 R08: ffff8880375c4c90 R09: ffffffff8bb2c880
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8c1ae7c0
R13: ffffffff8bb2c8c0 R14: ffffffff8a6eed50 R15: ffffc900006f8b38
FS:  0000000000000000(0000) GS:ffff8880d668b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4962e00ff8 CR3: 000000003801e000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x4da/0x630 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2601 [inline]
 slab_free mm/slub.c:6082 [inline]
 kfree+0x343/0x670 mm/slub.c:6399
 rose_neigh_put include/net/rose.h:166 [inline]
 rose_timer_expiry+0x53f/0x630 net/rose/rose_timer.c:183
 call_timer_fn+0x19a/0x590 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x757/0xac0 kernel/time/timer.c:2373
 __run_timer_base kernel/time/timer.c:2385 [inline]
 __run_timer_base kernel/time/timer.c:2377 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2394
 run_timer_softirq+0x1a/0x50 kernel/time/timer.c:2404
 handle_softirqs+0x1ea/0x910 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xef/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:63
Code: 0e 91 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 83 ed 2a 00 fb f4 <e9> 3c 34 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffc90000197df0 EFLAGS: 00000202
RAX: 0000000000128aa1 RBX: ffff88801ee8a480 RCX: ffffffff8b80ac75
RDX: 0000000000000000 RSI: ffffffff8de6b9c0 RDI: ffffffff8c1adaa0
RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed100d4e6755
R10: ffff88806a733aab R11: 0000000000000000 R12: ffffed1003dd1490
R13: 0000000000000003 R14: ffffffff90d8d0d0 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:73 [inline]
 default_idle+0x9/0x10 arch/x86/kernel/process.c:767
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x35b/0x4b0 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x148
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
  16:	48 8d 3d 72 78 ee 0b 	lea    0xbee7872(%rip),%rdi        # 0xbee788f
  1d:	41 56                	push   %r14
  1f:	48 8b 14 dd 60 ec 1a 	mov    -0x73e513a0(,%rbx,8),%rdx
  26:	8c
  27:	4c 89 e6             	mov    %r12,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	58                   	pop    %rax
  30:	83 05 9c 48 e4 0b 01 	addl   $0x1,0xbe4489c(%rip)        # 0xbe448d3
  37:	48 83 c4 18          	add    $0x18,%rsp
  3b:	5b                   	pop    %rbx
  3c:	5d                   	pop    %rbp
  3d:	41 5c                	pop    %r12
  3f:	41                   	rex.B


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

