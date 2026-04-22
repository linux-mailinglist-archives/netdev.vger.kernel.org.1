Return-Path: <netdev+bounces-280387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LkOIB6u6GkhOwIAu9opvQ
	(envelope-from <netdev+bounces-280387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:16:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DC44527A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC633026AA9
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F37373BE0;
	Wed, 22 Apr 2026 11:16:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5A299944
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856589; cv=none; b=GPu8Vnomsd4nGBMFU/n831OfFH1EYWkv45gczRp/QlrIdmoySKzJDfIq5IAWITmBXn5woS4Z3e3QGKFXKIfuJWh78n8pZmfBIMKfcX7xZ9fgIf9/9INtKECq+Cs6wLnIjbdoax9onZYq1hEqw6p3OEVu2vfvrYS33MDh8eCKzVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856589; c=relaxed/simple;
	bh=SKKptLqbJS7k72M/W2XTOx6QxmRkRMDm/kj4srV2Dqs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ty8KphKURBnPKeA32TtSsllkmyYs2MUQhjLEf/b7pAZQU/uBdAlM+1Iug6FquEBlCXXdeaceikDz/ajPvGA+O4Lp4WpOwqNCxuRe8oiYddgHQeQErqkrddduWkRPkCzU/JdnMMpeywSaWEPZPKxSjBMaTOD/dlPsTlbk9Gafg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-42fd2dfd64bso42845fac.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 04:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776856587; x=1777461387;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2AtJwEHDyg54b3ezDGtVvhMEJTnf9lJtI4gODuWrqI=;
        b=oQuzq3HlKioVKaNJtKcWwPycOO4+1faKLvRlRZwKv1WiGiN80JLQ3zr9Fkzlf5eLCK
         7GjnJEIHCbJUTO1DOzd2qng5yXGTYHLPiQI+UFi04kEBeEkg37lw5Ab7pqEFB+uumizC
         coznqcP7AEXcZgzMs+j5bkIKe7X/vKsml/IYKHdBL+/QRdzOJfAFs6xJ5tjhSDqbe4EY
         KmY09OC8+KnWxSZ/PYmmjwG4jMFre3jc6WPbBs3mkR16BUhc0TtpUi/NL1N+agfHCydz
         lUioxblW9aGAcJ5h7wgV9RuP+xfzlcbuNXcJ8fSnafdHnNrQKSinzxfovd6Cr1O+FQeF
         Zwlw==
X-Forwarded-Encrypted: i=1; AFNElJ/G3PpHxijLNbMk9gBefwedek2T2DlMIdOVZL7XGDOludb6dZbahu9LeW+swyNywnfeJuMjWFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMcmNIo89BunbPWv6oB51wlxj/rMjZ6YjyiqckjhkNaO4zCkL
	Dcd8gpZRCRgAxLW3AM5TzQWAQI5+cHHCEE6e+CAOn6A6RKmB82Bu/KheFnPYFEcLuokQwqQFQGh
	pES2gKdPqzUgeHonQut8UCYiPfQqSO1kYpXDE2yn7KRHpCmSC8m52XJRmfYM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1743:b0:685:d435:1471 with SMTP id
 006d021491bc7-69462e21d8cmr11849305eaf.10.1776856587132; Wed, 22 Apr 2026
 04:16:27 -0700 (PDT)
Date: Wed, 22 Apr 2026 04:16:27 -0700
In-Reply-To: <69e79944.a00a0220.17a17.001a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e8ae0b.050a0220.24bfd3.0040.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in pn_socket_autobind
From: syzbot <syzbot+b3c0e6a240078433c42b@syzkaller.appspotmail.com>
To: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3e19fa1907a3dfda];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280387-lists,netdev=lfdr.de,b3c0e6a240078433c42b];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,googlegroups.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D14DC44527A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot has found a reproducer for the following issue on:

HEAD commit:    6596a02b2078 Merge tag 'drm-next-2026-04-22' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ca74ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e19fa1907a3dfda
dashboard link: https://syzkaller.appspot.com/bug?extid=b3c0e6a240078433c42b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17330cce580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107ed1ba580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6596a02b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e78cc4623b5/vmlinux-6596a02b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ae78b19bafa/bzImage-6596a02b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3c0e6a240078433c42b@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/phonet/socket.c:213!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6116 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
RIP: 0010:pn_socket_autobind+0x14c/0x170 net/phonet/socket.c:202
Code: 00 00 00 00 48 8b 44 24 58 65 48 2b 05 55 4d 47 09 75 2a 48 83 c4 60 89 d8 5b 5d 41 5c 41 5d e9 1a f8 d0 00 e8 15 78 3c f7 90 <0f> 0b e8 cd 30 aa f7 eb 9e e8 26 31 aa f7 e9 6c ff ff ff e8 7c b8
RSP: 0018:ffffc90003d5fa30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8acd028a
RDX: ffff88802b48ca00 RSI: ffffffff8acd02cb RDI: ffff88802b48ca00
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff920007abf46
R13: dffffc0000000000 R14: 1ffff920007abf61 R15: ffffc90003d5fe48
FS:  00007f523dc816c0(0000) GS:ffff8880d62db000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdf9b231e9c CR3: 000000004a755000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 pn_socket_sendmsg+0x43/0xe0 net/phonet/socket.c:421
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
 __sys_sendmsg+0x170/0x220 net/socket.c:2784
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f523cd9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f523dc81028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f523d015fa0 RCX: 00007f523cd9c819
RDX: 0000000004044004 RSI: 0000200000000200 RDI: 000000000000000a
RBP: 00007f523ce32c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f523d016038 R14: 00007f523d015fa0 R15: 00007ffe40f56cd8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
RIP: 0010:pn_socket_autobind+0x14c/0x170 net/phonet/socket.c:202
Code: 00 00 00 00 48 8b 44 24 58 65 48 2b 05 55 4d 47 09 75 2a 48 83 c4 60 89 d8 5b 5d 41 5c 41 5d e9 1a f8 d0 00 e8 15 78 3c f7 90 <0f> 0b e8 cd 30 aa f7 eb 9e e8 26 31 aa f7 e9 6c ff ff ff e8 7c b8
RSP: 0018:ffffc90003d5fa30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8acd028a
RDX: ffff88802b48ca00 RSI: ffffffff8acd02cb RDI: ffff88802b48ca00
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff920007abf46
R13: dffffc0000000000 R14: 1ffff920007abf61 R15: ffffc90003d5fe48
FS:  00007f523dc816c0(0000) GS:ffff8880d62db000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdf9b231e9c CR3: 000000004a755000 CR4: 0000000000352ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

