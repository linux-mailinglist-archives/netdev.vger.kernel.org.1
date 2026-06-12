Return-Path: <netdev+bounces-298801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vu3nA8mDLGrrRwQAu9opvQ
	(envelope-from <netdev+bounces-298801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:10:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A3867CAA8
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:10:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298801-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298801-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EB9530EA3D2
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D81A39A06C;
	Fri, 12 Jun 2026 22:10:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4465395D86
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 22:10:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302214; cv=none; b=gyEQ/RmL+8A58qAhnVdiwqRcxQsi2ADRwv+AkiG6kgR7OlQlD9BnqAd4AtyBHxac8v772LuLKLbxROVGbDvn8YZlsbgQUio0gdrY3E6e5ibwf8ByHVeNmu4yUH78m38DBNsxqBI3hJ4MSdKDj57N4LVss+veYBFPVsP9p2/RUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302214; c=relaxed/simple;
	bh=ktDJ37hZzdDqYp2UKKDN3CY2hhJA5scnC2EENECQ8oU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KjIkKvdREUbSMAXlBFb94COEyWXCQoOqbAUfq0vJvhwZ/vkXTBqQdB0AcqasO3eGFsRITSjccwI5VaWv3m2SYJ/xjZSgUMkA6rZp+ILLyyGg9CR5fnhi2LCNKN0ZJm0HvGkei0ckmhfxxnqK9ZjVWMcUtVPrYrLFiViUBhXRIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-48651d7d55fso1640021b6e.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 15:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781302212; x=1781907012;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOXfUgUCVkiAGlnZ3O8tZBJZjmy7q3zIDCpedOitVB4=;
        b=swoukq1KsCZt4YtyUNbhsDF8j36wZZogbzQgqTKwbF2aJDwESEh3847SMZg8XEPkVv
         lmo3MlH+9nnUcQuCeOerCc8N3f5WeDea4N7XNJTmz0MvFOGOSD0uvFB7VpkucgbC76nC
         Bv7yxFX9LpGFYPRcCVsoL67SZr2GqZxLXhhrPHPjExwe4jHyJ2e/TCyQk2gIM9xeJJJ7
         jPKcG71w1zWEc2R2dtujkvcIe+6/nhDnrii9TZklV1104psoTJX7CVD4gTAY16XQXHEv
         jy8Eytldwjjyxk62y1eeLs4I8c/hZT3ZdvPIk6ZLMDH+vSaHRYW0EPIbFc0NGz1uvZBn
         BSPw==
X-Forwarded-Encrypted: i=1; AFNElJ+GmvB/fTD0KsYNqFu8thovb3Hyni6INsyJVP3bX63wmglBhsVrOFy+yBDKwlB5H1s18KySHNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywKP2fDMwaCSmBzTp6rELbnwQrwmgeV+8nhNjlzZaOrtn1bfk+
	bBprUu/WJyUCi0icFCyse2qDgTGXcpHolBsDCvXQJlX8Ixhqo1B6692oVYWh/vlupAjCpgGVZ5y
	z60d0zvD26SPUrLZidj2tkSb3cF/HNed15JmViSAbj8dQzGgrAwKNEmGNh5k=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6f85:b0:479:faac:1fbf with SMTP id
 5614622812f47-4872f2f6a43mr3621597b6e.2.1781302212004; Fri, 12 Jun 2026
 15:10:12 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:10:11 -0700
In-Reply-To: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2c83c3.428ffe26.258b27.015f.GAE@google.com>
Subject: [syzbot ci] Re: tcp: opportunistic loopback splice for BPF-paired sockets
From: syzbot ci <syzbot+cibd4edd60e2329298@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, cwang@multikernel.io, hemanthmalla@gmail.com, 
	jakub@cloudflare.com, jiayuan.chen@linux.dev, john.fastabend@gmail.com, 
	netdev@vger.kernel.org, xiyou.wangcong@gmail.com, zijianzhang@bytedance.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298801-lists,netdev=lfdr.de,cibd4edd60e2329298];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:cwang@multikernel.io,m:hemanthmalla@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:xiyou.wangcong@gmail.com,m:zijianzhang@bytedance.com,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,m:johnfastabend@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,multikernel.io,gmail.com,cloudflare.com,linux.dev,bytedance.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlegroups.com:email,googlesource.com:url,syzkaller.appspotmail.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72A3867CAA8

syzbot ci has tested the following series

[v1] tcp: opportunistic loopback splice for BPF-paired sockets
https://lore.kernel.org/all/20260612011452.134466-1-xiyou.wangcong@gmail.com
* [RFC PATCH bpf-next 1/5] tcp_bpf: add bpf_sock_splice_pair kfunc for opportunistic loopback splice
* [RFC PATCH bpf-next 2/5] tcp_bpf: busy-poll the splice ring before parking the receiver
* [RFC PATCH bpf-next 3/5] selftests/bpf: add tcp_splice basic round-trip test
* [RFC PATCH bpf-next 4/5] bpf: allow SO_BUSY_POLL in bpf_setsockopt()
* [RFC PATCH bpf-next 5/5] selftests/bpf: set SO_BUSY_POLL from the tcp_splice sockops prog

and found the following issues:
* WARNING: suspicious RCU usage in tcp_bpf_recvmsg
* WARNING: suspicious RCU usage in tcp_bpf_splice_sendmsg

Full report is available here:
https://ci.syzbot.org/series/7c43d5ae-cb19-4b2b-96ad-f7f0806ac63c

***

WARNING: suspicious RCU usage in tcp_bpf_recvmsg

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      30dee2c176e7954f63d1fa3e52d172f30beb9bfb
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/09e43fc4-ebab-492e-b1de-15bb86aa4588/config
syz repro: https://ci.syzbot.org/findings/79db1500-f71c-4550-8525-89bf06044d60/syz_repro

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
net/ipv4/tcp_bpf.c:883 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz.0.17/5822.

stack backtrace:
CPU: 1 UID: 0 PID: 5822 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 sk_psock_is_spliced net/ipv4/tcp_bpf.c:883 [inline]
 tcp_bpf_recvmsg+0x1780/0x1980 net/ipv4/tcp_bpf.c:405
 sock_recvmsg_nosec+0xee/0x140 net/socket.c:1137
 ____sys_recvmsg+0x3e3/0x4a0 net/socket.c:2916
 ___sys_recvmsg+0x215/0x590 net/socket.c:2960
 do_recvmmsg+0x334/0x800 net/socket.c:3055
 __sys_recvmmsg net/socket.c:3129 [inline]
 __do_sys_recvmmsg net/socket.c:3152 [inline]
 __se_sys_recvmmsg net/socket.c:3145 [inline]
 __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3145
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1af799ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1af87bc028 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f1af7c15fa0 RCX: 00007f1af799ce59
RDX: 0000000000000002 RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007f1af7a32d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010051 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1af7c16038 R14: 00007f1af7c15fa0 R15: 00007ffdef205588
 </TASK>


***

WARNING: suspicious RCU usage in tcp_bpf_splice_sendmsg

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      30dee2c176e7954f63d1fa3e52d172f30beb9bfb
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/09e43fc4-ebab-492e-b1de-15bb86aa4588/config
syz repro: https://ci.syzbot.org/findings/8144de7d-1a2e-454e-ab17-08d1c6586df2/syz_repro

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
net/ipv4/tcp_bpf.c:883 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz.2.19/5817.

stack backtrace:
CPU: 0 UID: 0 PID: 5817 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 sk_psock_is_spliced net/ipv4/tcp_bpf.c:883 [inline]
 tcp_bpf_splice_sendmsg+0x1165/0x1490 net/ipv4/tcp_bpf.c:897
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x80a/0x9f0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmmsg+0x27c/0x4e0 net/socket.c:2841
 __do_sys_sendmmsg net/socket.c:2868 [inline]
 __se_sys_sendmmsg net/socket.c:2865 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2865
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd1c339ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd1c42e3028 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fd1c3615fa0 RCX: 00007fd1c339ce59
RDX: 0000000000000001 RSI: 0000200000001000 RDI: 0000000000000003
RBP: 00007fd1c3432d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000004008005 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd1c3616038 R14: 00007fd1c3615fa0 R15: 00007ffdcdbac378
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

