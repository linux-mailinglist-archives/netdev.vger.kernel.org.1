Return-Path: <netdev+bounces-280175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN0yEMyZ52kV+QEAu9opvQ
	(envelope-from <netdev+bounces-280175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:37:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC86C43CCF0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76B2D302BA05
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1F2BE644;
	Tue, 21 Apr 2026 15:34:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A729BD91
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785665; cv=none; b=GObMDBYiDV+5EJJCRdkeGe7XM+n7J+K4hQ0isqDsgsV1SzXQR5mhbe4Qyx7up4VM4xxwTtorlCqj1ImxRs4Q30KCE24bYRKrSWR3j5xD7eC0DwMX2V0rA2eaoVsU/JbPa3Osv9lItbOlR1Vle7amXyh8H2HpsycJJ9zJVeYqcv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785665; c=relaxed/simple;
	bh=rZArWJHmRxt1om2wMFT5MbRr454f6XOP0FkgvXszVdc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FcnBkQVZz8aG2uv3JTyzvLpSy06jORsO7SWblvW/F1gCcvC3dYdeI/Bod9fa7FHjrGSpYozQpuAjlNCqrotMsz2ItGe6Nd34/IBPZCuxUZr0o3GtlsLcNkUFm8c+tjFLnOLVgXl3qfDXPKkad9zCFp/B8IYBmd9IEwhz+erDFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-42c06895be6so3599337fac.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776785662; x=1777390462;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wy8SfbKEgZbWh8Ix/2J0vDXqxb5Y/5n9Sl1yQnlcfBM=;
        b=NgQJJakc7z1aYofiK4AXwuaxtRhi6TnYtu4gSaU+yQKHlczW8SL0w62+iszQI3aUE/
         lMCDz85rzfcBYR6+DC/Cbcaej39do2wKUeAFBDjGnFt5nbMvtSpy2ikyemBIC878Jwu/
         tgO3454v0Rt/WulqxiQp09CKETm1fX6PmABmgwoKu/3qP6MY52iiogrPR63mC0t5ql7A
         UCTPOQuQWv2pSFbydnTmzP9vdBb/AfQz8J9/kxKEH2zSdIMpKA8X7e6Q2AvNYoujM5WR
         SrAUObsN0mNcdNluFBzz1Nd82W0YuRcpL8mRYiFLKN7h11/1WhDIiKPTRv0ioPJO29ul
         bGPw==
X-Forwarded-Encrypted: i=1; AFNElJ8b/6IaY6AveLbHZ76URX2som1lUW3qnwXSmr0VGMLnI0eaIVtVhMrGAj69XqrNr09K/AyXf1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEkk2T5LdM9DwEanUKiS4aF5Zda/BD6IMLrcaLFs1SHDI0kk8
	+lYnUE7o3lJHmnwM5Q5oebpUyKWVcvAr+bx0OEfdP9w9GOZyILMekg8tgwdntCUlpPM7Lk/+h37
	eiehyN0imJA6xW+5VFSr/TxxO9Zgy2rWY+KdkfWc6RzdOTHr5uNILqbKUMxM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c90:b0:688:6d55:195 with SMTP id
 006d021491bc7-69462f2f14fmr10770363eaf.57.1776785662586; Tue, 21 Apr 2026
 08:34:22 -0700 (PDT)
Date: Tue, 21 Apr 2026 08:34:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e798fe.050a0220.24bfd3.0033.GAE@google.com>
Subject: [syzbot] [sctp?] WARNING: refcount bug in sctp_association_hold
From: syzbot <syzbot+61bdf856ff699245c643@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=507c1c0a12a79510];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,vger.kernel.org,gmail.com,redhat.com,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280175-lists,netdev=lfdr.de,61bdf856ff699245c643];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,appspotmail.com:email,googlegroups.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goo.gl:url,syzkaller.appspot.com:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: AC86C43CCF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    c1f49dea2b8f Merge tag 'mm-hotfixes-stable-2026-04-19-00-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15de0e6a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=507c1c0a12a79510
dashboard link: https://syzkaller.appspot.com/bug?extid=61bdf856ff699245c643
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c1f49dea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98ce9fed1a97/vmlinux-c1f49dea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b02e163ec959/bzImage-c1f49dea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61bdf856ff699245c643@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x111/0x130 lib/refcount.c:25, CPU#0: swapper/0/0
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:refcount_warn_saturate+0x111/0x130 lib/refcount.c:25
Code: 06 e8 e3 e8 11 fd 48 8d 3d 8c d6 ef 0b 67 48 0f b9 3a e8 d2 e8 11 fd 5b 5d c3 cc cc cc cc e8 c6 e8 11 fd 48 8d 3d 7f d6 ef 0b <67> 48 0f b9 3a e8 b5 e8 11 fd 5b 5d e9 0e de a2 06 48 89 df e8 a6
RSP: 0000:ffffc90000007bd8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888075d2e004 RCX: ffffffff84f6dc0b
RDX: ffffffff8e4955c0 RSI: ffffffff84f6dcba RDI: ffffffff90e6b340
RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000004
R10: 0000000000000002 R11: 0000000000000000 R12: ffff888075d2e004
R13: 0000000000000002 R14: ffff88804fd3cbd0 R15: ffff888050620000
FS:  0000000000000000(0000) GS:ffff8880970ee000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000080066018 CR3: 000000004c3cc000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 __refcount_add include/linux/refcount.h:289 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 sctp_association_hold+0x9f/0xb0 net/sctp/associola.c:843
 sctp_generate_timeout_event+0x292/0x3f0 net/sctp/sm_sideeffect.c:284
 call_timer_fn+0x19a/0x640 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x75f/0xaf0 kernel/time/timer.c:2374
 __run_timer_base kernel/time/timer.c:2386 [inline]
 __run_timer_base kernel/time/timer.c:2378 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2395
 run_timer_softirq+0x1a/0x50 kernel/time/timer.c:2405
 handle_softirqs+0x1ea/0xa00 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1061
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:steal_cookie_task kernel/sched/core.c:6401 [inline]
RIP: 0010:sched_core_balance+0x3fd/0xea0 kernel/sched/core.c:6422
Code: 7e 48 48 89 4c 24 40 e8 61 df c2 09 48 8b 4c 24 40 e9 3a 01 00 00 49 8d 7f 48 e8 4e df c2 09 e8 79 76 3a 00 fb 80 7c 24 30 00 <0f> 85 92 00 00 00 8d 4d 01 48 63 d1 49 39 d4 73 48 83 f9 08 74 41
RSP: 0000:ffffffff8e407b80 EFLAGS: 00000246
RAX: 000000000046d04f RBX: ffff88802b23b3c8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8df51613 RDI: ffffffff8c1c0200
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: dffffc0000000000 R14: ffff88802b33b380 R15: ffff88802b23b380
 do_balance_callbacks kernel/sched/core.c:5017 [inline]
 __balance_callbacks+0x21d/0x6e0 kernel/sched/core.c:5073
 __schedule+0x31b9/0x6820 kernel/sched/core.c:7191
 schedule_idle+0x54/0x80 kernel/sched/core.c:7308
 do_idle+0x2dd/0x590 kernel/sched/idle.c:381
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:451
 rest_init+0x251/0x260 init/main.c:762
 start_kernel+0x484/0x490 init/main.c:1220
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x12b/0x130 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x148
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e8 e3 e8 11 fd       	call   0xfd11e8e8
   5:	48 8d 3d 8c d6 ef 0b 	lea    0xbefd68c(%rip),%rdi        # 0xbefd698
   c:	67 48 0f b9 3a       	ud1    (%edx),%rdi
  11:	e8 d2 e8 11 fd       	call   0xfd11e8e8
  16:	5b                   	pop    %rbx
  17:	5d                   	pop    %rbp
  18:	c3                   	ret
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	e8 c6 e8 11 fd       	call   0xfd11e8e8
  22:	48 8d 3d 7f d6 ef 0b 	lea    0xbefd67f(%rip),%rdi        # 0xbefd6a8
* 29:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2e:	e8 b5 e8 11 fd       	call   0xfd11e8e8
  33:	5b                   	pop    %rbx
  34:	5d                   	pop    %rbp
  35:	e9 0e de a2 06       	jmp    0x6a2de48
  3a:	48 89 df             	mov    %rbx,%rdi
  3d:	e8                   	.byte 0xe8
  3e:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)


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

