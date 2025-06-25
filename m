Return-Path: <netdev+bounces-201248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D476AE8964
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B334A805F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA42C1587;
	Wed, 25 Jun 2025 16:13:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF382BDC3F
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868009; cv=none; b=TNXZB45IVMjCbQZiTja61QwRXtkhyJ0EiyJ1VVFiCuQK2YB14l4sAtup/vj4PX+tmyCjDZkpzYfG++B3k1fN9DGehO+DRT/iJ/QFnfitbgQw4hXcONAnnwGP/VqT2uSRCVTZQM/9Ndkly6lkH9so0rXdPtAJu5FMdOs9YWG9Qmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868009; c=relaxed/simple;
	bh=WT7ivMV9qqeQwMyuD6mdADCPzfCCXz2Dy8zS7veJoMs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rmESF45Ghl6EIr/JpB6XdT8QNGWHgxn1XE1oCtHO7/CpJiX/TZ2homFoGhcEf91wXx2PGo4OGp0JSmDVg4aFjsJn7hbU3I3b94U9JfbGODP6PVZky9P3kKshMNwPwNf/VhbjKEqfE+BKmTMvmUpe0wXt723WBwX1BMrIXZ2dzLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddce213201so1081105ab.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750868007; x=1751472807;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skryBwueoVvpqeh7d4a3noBeWswe7fbsQ/e6Mb6+Dhg=;
        b=AkLp9eUsKeKpzffV8qBscrkGMaGD8heuZ8LBxtTOfQo/oIhpHcpQkFzFcL+G6coE8D
         klzCVyucXP+iw3bINUTIB40R1jbRupxYvuJLsDt5MgLTI+xL8HVtYbuZ4LinDd63o5Rd
         WBYoJK2R5Jq3MLpW3k8nBRUBX5XyEPLbdv05R4lDEy4bgGBMnvevGD309NeKkJfJlrO3
         VF1JwqURjaJJpgy63Oaem9kg2QKE2A84Dm3hxbkDdzoHvRRimzcMzsRl2B/GRShQ6k0l
         25RFzrSc1eWFGA9nch2fPq47taGSy4lHgYhrdFAl4HKGyU0P+Zu0nTRBNYKJQfTqVTLq
         BrmA==
X-Forwarded-Encrypted: i=1; AJvYcCWT1n4PEqozF6XDPJg6aQQlDc0iHTMdu2ugiDJy/Fsz47L9YLVw2PNng/34DNAMJZep5QtPOwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuvlcw2MTrCBQjVNRI0UKnGpUJao0n89Wry76PkbnfSP/Q4/P2
	fYcd4oykYQ9GwZAGgiFWTcYQdHtEojl0hBgFnlZJYPONaz12gGtqwVzh1wwcpydpZKMSS/yyGQf
	rH/y7eXoDf6CjQFx9ukdaYoKdY2qr1gkNcI13DVaYZV8apMApTPYqlhdKMBU=
X-Google-Smtp-Source: AGHT+IHEz0cNg0RdHPrZ5I5pzxpMHNh8tbp3gQEx4kycm9WGHRLb0EAHML2SkO+hC86Kl93MyXmubTW2rKIIYeVrG3p/J+gYps7h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1889:b0:3dc:7b3d:6a45 with SMTP id
 e9e14a558f8ab-3df3e0b23dbmr3533975ab.0.1750868006912; Wed, 25 Jun 2025
 09:13:26 -0700 (PDT)
Date: Wed, 25 Jun 2025 09:13:26 -0700
In-Reply-To: <683265d3.a70a0220.253bc2.0079.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685c2026.a00a0220.34b642.00c6.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in ah6_output
From: syzbot <syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9caca6ac0e26 bnxt: properly flush XDP redirect lists
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16254f0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
dashboard link: https://syzkaller.appspot.com/bug?extid=01b0667934cdceb4451c
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1252bdd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1715d182580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b5b575608bd0/disk-9caca6ac.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5c5f5f06115c/vmlinux-9caca6ac.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d833e4fd921e/bzImage-9caca6ac.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com

------------[ cut here ]------------
memcpy: detected field-spanning write (size 40) of single field "&top_iph->saddr" at net/ipv6/ah6.c:439 (size 16)
WARNING: CPU: 0 PID: 5841 at net/ipv6/ah6.c:439 ah6_output+0xece/0x1510 net/ipv6/ah6.c:439
Modules linked in:
CPU: 0 UID: 0 PID: 5841 Comm: syz-executor125 Not tainted 6.16.0-rc2-syzkaller-00179-g9caca6ac0e26 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:ah6_output+0xece/0x1510 net/ipv6/ah6.c:439
Code: ff e8 e6 09 91 f7 c6 05 d6 c0 5b 05 01 90 b9 10 00 00 00 48 c7 c7 60 64 a0 8c 4c 89 f6 48 c7 c2 c0 66 a0 8c e8 73 b4 54 f7 90 <0f> 0b 90 90 e9 ab fe ff ff e8 c4 14 37 01 48 8b 4c 24 28 80 e1 07
RSP: 0018:ffffc900041a70a0 EFLAGS: 00010246
RAX: 6316bcc3c9618000 RBX: ffff888030ed5808 RCX: ffff888079c1da00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffc900041a7230 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa9ec R12: dffffc0000000000
R13: 1ffff92000834e34 R14: 0000000000000028 R15: 0000000000000030
FS:  000055556d6c9380(0000) GS:ffff888125c51000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe027d09e9c CR3: 0000000074d90000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xfrm_output_one net/xfrm/xfrm_output.c:555 [inline]
 xfrm_output_resume+0x2c55/0x6170 net/xfrm/xfrm_output.c:590
 __xfrm6_output+0x2eb/0x1070 net/ipv6/xfrm6_output.c:103
 NF_HOOK_COND include/linux/netfilter.h:306 [inline]
 xfrm6_output+0x1c6/0x4f0 net/ipv6/xfrm6_output.c:108
 ip6_send_skb+0x1d5/0x390 net/ipv6/ip6_output.c:1982
 l2tp_ip6_sendmsg+0x12ee/0x17c0 net/l2tp/l2tp_ip6.c:661
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x19c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1b7b30bc79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdde4e6fd8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1b7b30bc79
RDX: 0000000000000800 RSI: 0000200000000540 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

