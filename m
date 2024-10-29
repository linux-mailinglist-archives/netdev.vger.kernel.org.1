Return-Path: <netdev+bounces-139779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1885A9B40F3
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 04:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B46CB21B30
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0417DE2D;
	Tue, 29 Oct 2024 03:17:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54058FC0B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171848; cv=none; b=PE1/SDccWSwSM6/HzZ++TU9JvLam1WwpYs7+CiCfCLx8EbhWzLI4WdxaQG4P4a1q6DiW+torSeXGxDl3b2okG7QgRnz6Bg3enbf4zgk9Y76HIghhQkRJ4H0MSpRCfxgrswTrWzIE/a0BBE8S3ui0dr5aarogblSxisaSHeDGuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171848; c=relaxed/simple;
	bh=OwfSmkkVyCvraqQFejhw+w9tO/CJpKxcARE/C273ZGM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=COnMuRvYt3nrH/S6eFuE3TuKyh8JKJGy2HyMzuB+Dub9jQgqFYZPwQ7TQ7ozyvXGkRm0gs1wE3VHOztzujXaJ9YvowtdMrbzg0tdsry/j2bZt5I95wGbhawHfSofRUoWDOfXCR1La7e/bfQWImVS2ovTOSzvy2C+GwwMtmb0z78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b2aee1a3so46670195ab.1
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 20:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730171845; x=1730776645;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Ml5xdrk/GoPF1iZ/ESHoejXkMsJvq1MYGagAZX4ZA=;
        b=G75Ak+/2fQUf3Mxv134u86bpaDetIZtS3noWPoTtVcu4fukMMYn+KpC6pZKfkj/YYS
         +q/BSPlr8aV+FfE0/DyJHPDPW+R4ruDWzE5G/fGBuupCeCKO9EUuy9r1Ranj81ZRI1Wp
         xH18JZ3ex81Wls8c9txAeBDlNqC8e5N67RqLcYNUmkYQ98ZYoPW9p48NnCwv1kYCMTGy
         Rpn3FWiy5n+BntfhaE5BeO0O20/1gZDhcIaPcLzdDIuzbC+789MuAT3FGYyi6kmCmJZa
         o5tGrFHIxneBty7xREJzOkd7MT5dIiLVhS6KiOVxmxNyWUwNLyC6uT+R2fGdhBr1Tf4o
         5oZg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Y08kkdwZnNZSBmb+hkoq5tXGaH72M83kAN/6ryNV201k41qVFCfPWGAzsv48pHQlBe4ts3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrS859+XcPY1U/ybcyWFPbV7vSY5m2ha7U24ejAonpM1CH02S7
	VuonheQtKvVRk7CITVdw8UFE4KCfOFVZl8vY95rneeRsNnbyUqs7Ucy7rXkWy/YvXMAhy/+lRwz
	kHoo6xi68GrcdpIZ9UCRMA3S+VFAe+bkyqL9zwJG3/MHsyeQLpvNL+lA=
X-Google-Smtp-Source: AGHT+IH3tPT/58yajoM3oZAvZdllgr5kIVgqKBYc73Y6XyAyLZrKhpPJXZj2rMy3bZn2SB9xgGRbfyqStG5gMgStWcgS66VVCDYA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:3a3:445d:f711 with SMTP id
 e9e14a558f8ab-3a4ed1c2ea6mr104166235ab.0.1730171845559; Mon, 28 Oct 2024
 20:17:25 -0700 (PDT)
Date: Mon, 28 Oct 2024 20:17:25 -0700
In-Reply-To: <671cedcb.050a0220.2b8c0f.01b1.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672053c5.050a0220.11b624.04bb.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in __rate_control_send_low (3)
From: syzbot <syzbot+34463a129786910405dd@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b5abbf612092 Merge branch 'mptcp-sched-fix-some-lock-issues'
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f0ee40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a76ebb980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f0ee40580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d59668d3a54/disk-b5abbf61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5c6420513b58/vmlinux-b5abbf61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ba41cff1dda/bzImage-b5abbf61.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34463a129786910405dd@syzkaller.appspotmail.com

------------[ cut here ]------------
no supported rates for sta (null) (0xffffffff, band 0) in rate_mask 0xfff with flags 0x40
WARNING: CPU: 0 PID: 0 at net/mac80211/rate.c:385 __rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc4-syzkaller-00172-gb5abbf612092 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Code: 8b 14 24 0f 85 de 01 00 00 8b 0a 48 c7 c7 00 71 2a 8d 48 8b 74 24 10 44 89 f2 44 8b 44 24 1c 44 8b 4c 24 0c e8 08 a8 1e f6 90 <0f> 0b 90 90 e9 71 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c db
RSP: 0018:ffffc90000007520 EFLAGS: 00010246
RAX: 81ccced86469a000 RBX: 000000000000000c RCX: ffffffff8e694640
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88802eeb5a28 R08: ffffffff8155d402 R09: fffffbfff1cf9fe0
R10: dffffc0000000000 R11: fffffbfff1cf9fe0 R12: 0000000000000800
R13: 000000000000000c R14: 00000000ffffffff R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5c64b9bde3 CR3: 0000000034822000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rate_control_send_low+0x1a8/0x770 net/mac80211/rate.c:405
 rate_control_get_rate+0x20e/0x5e0 net/mac80211/rate.c:921
 ieee80211_beacon_get_finish+0x49e/0x870 net/mac80211/tx.c:5253
 ieee80211_beacon_get_ap+0x14e8/0x1990 net/mac80211/tx.c:5356
 __ieee80211_beacon_get+0x109e/0x15c0 net/mac80211/tx.c:5452
 ieee80211_beacon_get_tim+0xb4/0x320 net/mac80211/tx.c:5594
 ieee80211_beacon_get include/net/mac80211.h:5607 [inline]
 mac80211_hwsim_beacon_tx+0x39d/0x850 drivers/net/wireless/virtual/mac80211_hwsim.c:2311
 __iterate_interfaces+0x222/0x510 net/mac80211/util.c:774
 ieee80211_iterate_active_interfaces_atomic+0xd8/0x170 net/mac80211/util.c:810
 mac80211_hwsim_beacon+0xd4/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2345
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1772
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:112
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 c0 d7 03 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 35 b2 a3 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffffff8e607ca8 EFLAGS: 00000246
RAX: ffffffff8e694640 RBX: ffff888020ee0864 RCX: 0000000000013f11
RDX: 0000000000000001 RSI: ffff888020ee0800 RDI: ffff888020ee0864
RBP: 000000000003a9b8 R08: ffff8880b8637e9b R09: 1ffff110170c6fd3
R10: dffffc0000000000 R11: ffffffff8bc719c0 R12: ffff88801ef8c000
R13: 0000000000000001 R14: 0000000000000001 R15: ffffffff8f12e1c0
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:702
 cpuidle_enter_state+0x109/0x470 drivers/cpuidle/cpuidle.c:264
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:385
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:230 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:326
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
 rest_init+0x2dc/0x300 init/main.c:747
 start_kernel+0x47f/0x500 init/main.c:1105
 x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x147
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	65 48 8b 04 25 c0 d7 	mov    %gs:0x3d7c0,%rax
  10:	03 00
  12:	48 f7 00 08 00 00 00 	testq  $0x8,(%rax)
  19:	75 10                	jne    0x2b
  1b:	66 90                	xchg   %ax,%ax
  1d:	0f 00 2d 35 b2 a3 00 	verw   0xa3b235(%rip)        # 0xa3b259
  24:	f3 0f 1e fa          	endbr64
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  37:	00 00
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

