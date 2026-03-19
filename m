Return-Path: <netdev+bounces-269579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG+GLfQyvGnxuQIAu9opvQ
	(envelope-from <netdev+bounces-269579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:31:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4312D007F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C0373036610
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A283EE1FD;
	Thu, 19 Mar 2026 17:27:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A93EF0C9
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941245; cv=none; b=Hq1kJ4KdWFORmtf2p6x6+TN13USq5OMXXI/2BJjBItu0TVyaIpZofVuw4rbCxFGOoug8WaEbrnQsCQsbsGrwXoghWdlLLWLilMoyB9gtbPGwqg0bkljvBttiMfvYYSjXFSuwjQg4zndVN9CL+XUn9zzP8o9TjtkPu8YRTg0LtnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941245; c=relaxed/simple;
	bh=mnhZAQ2WTA9U0Tz1dprJ+7Ue4IXMoLBP4eJmGkwYA0c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IGwXdwEtktcJL3Q0X1GTAE62heeSVvVnBXuU+l1y//M0bWGn6J7NRj4HsbSXdfkpT+bma+DjnMoG6vKw/I0xZZyHNAkhpREzQe0E6esra9cZM7y/svnda04rrxnOcESSk0Mw2caZC6y6yOA4Swibny7z6bxDh305C9DsT1BMYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-415e1ea16b4so12248164fac.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 10:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773941240; x=1774546040;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PSG3ejNRrlnw9XOugg9Tq/1P/fmevmevXBXVs3hffk=;
        b=CaK9HY4L+4fRgjsLzxC2q/8uL3Pl2wbWB5Zb0yw/gPdoaIDNUkHY74YlEZ0CSEDDpv
         aI+kqXkzvwFLg6gWiB1q5c7KMjtx/30PlXKn0V0h3PIHsS3/DhpFvM2v5S07sr8UWOXf
         2kfIFjMRacKYxMuqBTlWHopMuyh27BW9eZ/TvyzZwXxrDFWvHCSeVKbWoaPTpzVRDOTl
         8nCdhrc2Aa3hPrDTgfwiMn6l0CIeQVIfygTECnnSzwcir6Ku8lTd5XI06M2EETD+vRBu
         k/V6r8Q+ksivRoRBhcQ8Xew5hzrsQFSbLBWavramGK2iMHpsaayHwdyNyUuec+HC7sNS
         ectg==
X-Forwarded-Encrypted: i=1; AJvYcCVhzxdbDd2TOdNNAS+AEwz1AW517KzBF78vozC3h0EK9D+QdetVNWBh2XsBPO/MSGcNl1ym1mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3er4N3nfleYRvo83j5bzeTOLDJNHN3A47vXt16wKFAqgpjrm/
	BKBd+Zmb2EXc9s5YK/ZQjQxkj3bIw795MKotcy32FABtRPkg1CVUl0RCLOuFL/TXfSo09EV+4L8
	dlFFYKQUSMBfYuAFfeU7CMFa1TX9aQui/YEpy3GszvYCZ4qtRS8J2IEm3wqQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2291:b0:672:7c0d:5607 with SMTP id
 006d021491bc7-67c22ecae21mr230743eaf.26.1773941240062; Thu, 19 Mar 2026
 10:27:20 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:27:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bc31f8.050a0220.18f14c.0050.GAE@google.com>
Subject: [syzbot] [wireguard?] KCSAN: data-race in wg_expired_retransmit_handshake
 / wg_packet_send_queued_handshake_initiation (4)
From: syzbot <syzbot+4ca9a7b9d61b76d0177c@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6b32b22d8934c136];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269579-lists,netdev=lfdr.de,4ca9a7b9d61b76d0177c];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.074];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,goo.gl:url,googlegroups.com:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5F4312D007F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    5ee8dbf54602 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123477e6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b32b22d8934c136
dashboard link: https://syzkaller.appspot.com/bug?extid=4ca9a7b9d61b76d0177c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dacfe44e33b2/disk-5ee8dbf5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10e825a65a06/vmlinux-5ee8dbf5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b2fe6914587d/bzImage-5ee8dbf5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ca9a7b9d61b76d0177c@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in wg_expired_retransmit_handshake / wg_packet_send_queued_handshake_initiation

read to 0xffff88810b667808 of 4 bytes by interrupt on cpu 0:
 wg_expired_retransmit_handshake+0x2a/0x160 drivers/net/wireguard/timers.c:46
 call_timer_fn+0x3b/0x2a0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x426/0x620 kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0x31/0x70 kernel/time/timer.c:2404
 handle_softirqs+0xb9/0x2a0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x39/0xc0 kernel/softirq.c:723
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0x74/0x80 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
 native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
 pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:62
 arch_safe_halt arch/x86/kernel/process.c:766 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x3b/0x60 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0xcd/0x230 kernel/sched/idle.c:332
 cpu_startup_entry+0x24/0x30 kernel/sched/idle.c:430
 rest_init+0xee/0xf0 init/main.c:760
 start_kernel+0x49a/0x4c0 init/main.c:1210
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0xfc/0x100 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x147

write to 0xffff88810b667808 of 4 bytes by interrupt on cpu 1:
 wg_packet_send_queued_handshake_initiation+0x32/0x180 drivers/net/wireguard/send.c:59
 wg_expired_new_handshake+0x26/0x30 drivers/net/wireguard/timers.c:104
 call_timer_fn+0x3b/0x2a0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x426/0x620 kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0x31/0x70 kernel/time/timer.c:2404
 handle_softirqs+0xb9/0x2a0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x39/0xc0 kernel/softirq.c:723
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0x74/0x80 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
 native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
 pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:62
 arch_safe_halt arch/x86/kernel/process.c:766 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x3b/0x60 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0xcd/0x230 kernel/sched/idle.c:332
 cpu_startup_entry+0x24/0x30 kernel/sched/idle.c:430
 start_secondary+0x95/0xa0 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x147

value changed: 0x00000002 -> 0x00000003

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
==================================================================


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

