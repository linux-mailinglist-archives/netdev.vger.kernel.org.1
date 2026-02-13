Return-Path: <netdev+bounces-258670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M5KMMyEj2mRRQEAu9opvQ
	(envelope-from <netdev+bounces-258670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:08:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC1A13950B
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 936613021D3A
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8DF250BEC;
	Fri, 13 Feb 2026 20:08:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0CE22B8B6
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013320; cv=none; b=cuA9Yh75xYwR/4d6nO7I7HONuDPpjVF7NeRY5brI+5/xX1bBi2OEdVvTG0ZH8UDZsy416G2AGF75nrxSdwB/L5Q4q5qvuifBo7xzr7AsEXl4CpDKZl+1KRQockwwl3Nj/xG8QYMG97fdUSGrNhy9CLKlv8BZhlHmLj1VdJK/adA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013320; c=relaxed/simple;
	bh=xTB7sH0UgoI0oig2MnPZOdk4Bj/196XD3K+gIDrZcic=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tave9ExMbV26jIhwjckrqNby++BHaQbuox+Ed04iEKBE8sjYrEY8PnbhWRiGBxpOVxDTWkTYnpl276//vL32V6XGWFuydqnBt+GvRsvxu/VJ/j02OX4MGr8itugeGhs3mJP7D9JruvnffHvpYGWt21qOehLYFK+SD2SREIABRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4c2b7f4caso6440164a34.2
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 12:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771013318; x=1771618118;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhuQe4f7M6VD4cjyPrpcBfIfQ3nvgLjNmNSh/F4yxXI=;
        b=AnDf+t7OgwYV1Ks6VA8KdbxhvFghF/4Qa+J3heO+nFjyD/V5QxBJ5Yn2dxWgafY1x6
         byD+5ptwNOW+D3SGQ6FiYFLS1bfO1uJclxOxkvjNLUYoO0Jh9diMP4fckFNy6+s1B2ba
         A7qMHLRO1Qldc9CgocI3llnoPgQVNiYMS1K8NuJyDNF9B1Tb37WL3RYtkJZ5QkvG9zrN
         wo/7rcre+J26stfuXvI7aGXed3snALKzIVjwLgAcOyAUeXQn+ypdzkGw60dPORcL8ANZ
         pvP36F2EBQdEKMZdsMGtJbv8Sg6yDP30w4c3LY9HYwy/Ihhikb6a0s7rrW27TB5Sj7PS
         aUHg==
X-Forwarded-Encrypted: i=1; AJvYcCVSOPVVnn7DEWHBQ6FjMd/a/ReX6WrCnITg6uo7xvdkK4RSbRCIT6phLXp6NJlyJHpA9v9tv3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK1VggIIY6we90Q2NwC79vndCf+Z3W4KgcgT33XxU070DtY3r3
	f3Pl5ADgOhVxU2QEh8pzq8uXlqUpxJXu0rGOltGDbmUTlw3/doSvJwEyC1Fuf6E3tfH10fucThf
	wo3e7rqC4N8paZpn6U9vuoKTUSB9SDIj8WwhE3KquQmNDC/PkA4FPIkwQjm8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:228a:b0:663:d58:63f9 with SMTP id
 006d021491bc7-6785b1c2238mr329362eaf.42.1771013318207; Fri, 13 Feb 2026
 12:08:38 -0800 (PST)
Date: Fri, 13 Feb 2026 12:08:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698f84c6.a70a0220.2c38d7.00cb.GAE@google.com>
Subject: [syzbot] [net?] WARNING in inet_sock_destruct (6)
From: syzbot <syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=22c34f040954bbd1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258670-lists,netdev=lfdr.de,5b3b7e51dda1be027b7a];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 3AC1A13950B
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    192c0159402e Merge tag 'powerpc-7.0-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b8cc02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22c34f040954bbd1
dashboard link: https://syzkaller.appspot.com/bug?extid=5b3b7e51dda1be027b7a
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1316a15a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14140ffa580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-192c0159.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d1c911c7a5b8/vmlinux-192c0159.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f9d4cfbb614a/bzImage-192c0159.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com

------------[ cut here ]------------
sk->sk_forward_alloc
WARNING: net/ipv4/af_inet.c:157 at inet_sock_destruct+0x653/0x800 net/ipv4/af_inet.c:157, CPU#0: ksoftirqd/0/15
Modules linked in:
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:inet_sock_destruct+0x653/0x800 net/ipv4/af_inet.c:157
Code: b4 4f ff e9 06 fd ff ff e8 aa 25 10 f8 90 0f 0b 90 e9 35 fe ff ff e8 9c 25 10 f8 90 0f 0b 90 e9 c5 fe ff ff e8 8e 25 10 f8 90 <0f> 0b 90 e9 04 ff ff ff e8 80 25 10 f8 90 0f 0b 90 e9 65 fe ff ff
RSP: 0018:ffffc90000127bb0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888100796300 RCX: ffffffff89f71e97
RDX: ffff88801dec4900 RSI: ffffffff89f71f92 RDI: ffff88801dec4900
RBP: 0000000000000090 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000090 R11: 00000000000075f9 R12: ffff888100796300
R13: ffff888100796390 R14: ffffffff81ed1d7d R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8880d65b3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe39b75ff4 CR3: 000000000e396000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __sk_destruct+0x85/0xbb0 net/core/sock.c:2350
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2869
 handle_softirqs+0x1ea/0x910 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1063 [inline]
 run_ksoftirqd+0x38/0x60 kernel/softirq.c:1055
 smpboot_thread_fn+0x3d3/0xaa0 kernel/smpboot.c:160
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

