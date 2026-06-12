Return-Path: <netdev+bounces-298462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4yUoBZqeK2prAQQAu9opvQ
	(envelope-from <netdev+bounces-298462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:52:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A304D676CEB
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:52:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298462-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298462-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0261D3003D3E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD66637E310;
	Fri, 12 Jun 2026 05:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2D13793A9
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 05:52:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781243544; cv=none; b=loJbIy/Rttp15P1fh2qry/48sDnuSH47ehQ2FnwzSCvb+lUbEXSHTmTKeFLMxl6YvSIBm9INHKBxUQAgv35HzqiiMvUgwHazfd+MChsOoR1UhGpSKw6p0PPa8Z6HoXBpdGUp3nNQTtKufPIfnh7fGgYm1+9Kxt7dMIgju/CYWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781243544; c=relaxed/simple;
	bh=oJIJaa+O4wOVvyYdQH6BqJuHIPEKaAXPQ/R22GOt//s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CXLRxGZnnFTDzXyn/MKt5/Al4OFY5SbIQaYSkTLhYB66/raHA/hbsb+q+psaOpl5Yiyyn3i0Y6zDlCtW9Ms9qiPIaIPiH4qzChZaFXijjhI6DYXqy15KjI8vVzQh0HfOg+GSAVoZqIwf73Pfn5BqE/dCa+Msfs205dgwGkhrLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-43d197b99b8so1212135fac.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 22:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781243542; x=1781848342;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sDv0jgw8CQFtr8pABadNiCnrd2MCCO5azBbnZKTICs=;
        b=DG8Q+IebnPwavkXmEWIl/9ckk/xYe9545xrnvCcoC9BfyBZy4ycO0sVYvsRPwoqL0z
         C97KtxzTPlCeQI8m15GOwQG74bkOVkN5F6mdZjpDZr/z/zduq3wTHK1o623eQEz0kvwo
         UqIohzWctXxYNafkWx79RWf1QQ+eSUFARo1KBJeq1CXrQjs2t3Yy4ShLgujrPIAYoeKG
         1LpAgHIJV9c1NAVwXHh+skVN/Btcyv4EYsILaWMO09771qKgB5LCUePyp4qIouQq3My9
         YmNHgb+0LzRj/Bazv0/Il7DALKRG51GvgZ7949KTzpzDkUTbJTxWSBcGi0av2xciCFio
         stqw==
X-Forwarded-Encrypted: i=1; AFNElJ/5tun4bTLFJ/PgDSH0GP065hgSViAsCbIZbNOxZumATHQ/hJrY/rXXMAoRn6SLGqHdTxB68fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+GWgG4t84dcp26xQa7bhLBS3JSaf0CtjxVriTOjlrciytR62
	ODoCw0mgx0scH2wTC7y/ntqGo0IbC9FtzFTSIIjRfsQYu2w6C1nqpEVTMYvaRy57ceANldF1z55
	jx/hKoYQvB2eXLuXrICIAMuZERGgFErHHRKBmSARd0Bhi8Yj3DoZ8KBCv3E8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:603:b0:696:6f52:95f8 with SMTP id
 006d021491bc7-69edc5d46e9mr1022071eaf.3.1781243542111; Thu, 11 Jun 2026
 22:52:22 -0700 (PDT)
Date: Thu, 11 Jun 2026 22:52:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2b9e96.99669fcc.12a77b.0006.GAE@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in xfrm_lookup_with_ifid / xfrm_policy_delete
From: syzbot <syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f571f22917457cd8];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:steffen.klassert@secunet.com,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298462-lists,netdev=lfdr.de,d85ba1c732720b9a4097];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,storage.googleapis.com:url,googlegroups.com:email,goo.gl:url,appspotmail.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A304D676CEB

Hello,

syzbot found the following issue on:

HEAD commit:    2b414a95b8f7 Merge tag 's390-7.1-5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1085b3d2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f571f22917457cd8
dashboard link: https://syzkaller.appspot.com/bug?extid=d85ba1c732720b9a4097
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a2bc12f628f8/disk-2b414a95.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/97ba8f79b58e/vmlinux-2b414a95.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b78d4c1c5145/bzImage-2b414a95.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in xfrm_lookup_with_ifid / xfrm_policy_delete

read-write to 0xffff888134a45934 of 4 bytes by interrupt on cpu 0:
 __xfrm_policy_unlink net/xfrm/xfrm_policy.c:2340 [inline]
 xfrm_policy_delete+0x1f7/0x240 net/xfrm/xfrm_policy.c:2360
 xfrm_policy_timer+0x280/0x4d0 net/xfrm/xfrm_policy.c:419
 call_timer_fn+0x3b/0x240 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x415/0x5f0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0x31/0x70 kernel/time/timer.c:2405
 handle_softirqs+0xb9/0x280 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x42/0xd0 kernel/softirq.c:735
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0x74/0x80 arch/x86/kernel/apic/apic.c:1061
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
 kcsan_setup_watchpoint+0x404/0x410 kernel/kcsan/core.c:705
 instrument_read_write include/linux/instrumented.h:56 [inline]
 atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1301 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
 do_raw_spin_lock include/linux/spinlock.h:187 [inline]
 __raw_spin_lock include/linux/spinlock_api_smp.h:159 [inline]
 _raw_spin_lock+0x4a/0xa0 kernel/locking/spinlock.c:158
 spin_lock include/linux/spinlock.h:342 [inline]
 d_alloc_parallel+0xab/0xce0 fs/dcache.c:2679
 __lookup_slow+0x96/0x260 fs/namei.c:1900
 lookup_slow+0x3c/0x60 fs/namei.c:1932
 walk_component fs/namei.c:2278 [inline]
 lookup_last fs/namei.c:2785 [inline]
 path_lookupat+0x2f7/0x500 fs/namei.c:2809
 filename_lookup+0x190/0x390 fs/namei.c:2838
 vfs_statx+0x96/0x170 fs/stat.c:353
 vfs_fstatat+0x118/0x170 fs/stat.c:373
 __do_sys_newfstatat fs/stat.c:538 [inline]
 __se_sys_newfstatat+0x55/0x3e0 fs/stat.c:532
 __x64_sys_newfstatat+0x55/0x70 fs/stat.c:532
 x64_sys_call+0x2c64/0x3020 arch/x86/include/generated/asm/syscalls_64.h:263
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888134a45934 of 4 bytes by task 9151 on cpu 1:
 xfrm_lookup_with_ifid+0x5b4/0x1590 net/xfrm/xfrm_policy.c:3225
 xfrm_lookup+0x38/0x50 net/xfrm/xfrm_policy.c:3327
 icmpv6_route_lookup+0x10b/0x3e0 net/ipv6/icmp.c:381
 icmp6_send+0xc63/0x1100 net/ipv6/icmp.c:793
 icmpv6_param_prob_reason+0x32/0x50 net/ipv6/icmp.c:848
 ip6_tlvopt_unknown net/ipv6/exthdrs.c:94 [inline]
 ip6_parse_tlv+0xf70/0x1080 net/ipv6/exthdrs.c:-1
 ipv6_parse_hopopts+0x1e5/0x320 net/ipv6/exthdrs.c:1084
 ip6_rcv_core+0x8e9/0xab0 net/ipv6/ip6_input.c:321
 ipv6_list_rcv+0x11f/0x2a0 net/ipv6/ip6_input.c:378
 __netif_receive_skb_list_ptype net/core/dev.c:6245 [inline]
 __netif_receive_skb_list_core+0x3b0/0x500 net/core/dev.c:6292
 __netif_receive_skb_list net/core/dev.c:6344 [inline]
 netif_receive_skb_list_internal+0x47d/0x5f0 net/core/dev.c:6435
 netif_receive_skb_list+0x33/0x1c0 net/core/dev.c:6487
 xdp_recv_frames net/bpf/test_run.c:269 [inline]
 xdp_test_run_batch net/bpf/test_run.c:350 [inline]
 bpf_test_run_xdp_live+0x104c/0x1360 net/bpf/test_run.c:379
 bpf_prog_test_run_xdp+0x57b/0xa10 net/bpf/test_run.c:1430
 bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4742
 __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6292
 __do_sys_bpf kernel/bpf/syscall.c:6387 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6385 [inline]
 __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6385
 x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000001 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 9151 Comm: syz.7.9538 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
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

