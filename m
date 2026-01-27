Return-Path: <netdev+bounces-253699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBwsHLM+eGkzpAEAu9opvQ
	(envelope-from <netdev+bounces-253699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:27:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A1E8FD9C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C997301A39A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF463233F4;
	Tue, 27 Jan 2026 04:27:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A31F2B8D
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769488048; cv=none; b=m6Jr5CrtZXCuNjve3R6s5OqlSSKrpcD+yLQuMmxrYkCd/jUlGq//AAh94JliTdGQHQvMKuKGbrJ8INA0djv3stJ+6YQZNgkWzbxWot+pEBOVGCqS+E2xl2qFS2mMQ5QaLMl+knW/51vYYQ2ZJzI+VBx5JWCtShDuUkogXffThWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769488048; c=relaxed/simple;
	bh=YuFUtxbGs8XoO6mBjA0KxEddLWHuYp+dvmesQhy1vNk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gha7gd/y3s75E4US7STZUOACuORA5S/9kLK4BGBeNf3Uv3plyFRD0yDYFHRKSu3OW98T1eRqDNi5FChB0ROGPaxKIBckpStTsE92+KZhxIdxojqvXFmBje2nm1F87SsFbpBdY5I29bQ33FsQUEZIB5q2+cHBcGZcYpuwLnBusUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-45c91358254so14100890b6e.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 20:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769488046; x=1770092846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGPXctGzCvQhO6o5zNaSG+4khA0zm/mQn3hOs7bG9JY=;
        b=L+LzT3yX7u6ac/nQrzv4i3s0bvwYOptMUwIh+mwxOtHMLBXtfXThR+zDRtxIRLvPOz
         BhyvKIK5+wL2FjHjFiwnw2zXJIyhEzmXoISA6E7/WDcUk6XFcy+9/EY0hPfiCAhE4F3p
         uerJqE9NBXEYF+D76JVEQ2t56qp3OJQkU/OtxYJ4Lbu0m8XalUSPE/xJi67rVvjeYKsT
         gs2E2UY0OqUZ7Qt//vDyOueZ7z/DrpgtauM37sL3BdpJGZ+u0Z2EJMMBubZP25rmN3gl
         99dZxvXbXS56W5COXiSqfjU+0Z3g4jnqMCuDsJV9Nz/wGqt1wkQWkZjDSxyH978TscQV
         JGdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0IT1XuoiLs/+Wa8WhwK5Ckz8PqP+D37FK19TQ9te7W4WfAIi9wckKoHDj5Ng2pct763hg5xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/V3xgiQhCpGxWfI0rsp7/MCCKv+CS7+Llnvp4og+JRUW7OI/
	rCme/1oWkBR/r/1s5njnswKqyZt49KQt1ko9uUcdaKjW+3SJb3KRhOpyzPG6YcPMCf55kF+nY3X
	UlqKJEZfn1vmC5+GLUqdwzE3wdfxwR7v/7oJPp/1YjExrmOuokTYCzIIKV+I=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1998:b0:65b:5745:6123 with SMTP id
 006d021491bc7-662f202860emr291800eaf.16.1769488045785; Mon, 26 Jan 2026
 20:27:25 -0800 (PST)
Date: Mon, 26 Jan 2026 20:27:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69783ead.050a0220.c9109.0013.GAE@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in fib_table_lookup /
 fib_table_lookup (4)
From: syzbot <syzbot+d24f940f770afda885cf@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-253699-lists,netdev=lfdr.de,d24f940f770afda885cf];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,storage.googleapis.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: B6A1E8FD9C
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    fcb70a56f4d8 Merge tag 'vfs-6.19-rc8.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c8a05a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183
dashboard link: https://syzkaller.appspot.com/bug?extid=d24f940f770afda885cf
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f09fa28d6094/disk-fcb70a56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7b2aaa28bcd/vmlinux-fcb70a56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa72cf9601a0/bzImage-fcb70a56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d24f940f770afda885cf@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in fib_table_lookup / fib_table_lookup

write to 0xffff88811b06a7fa of 1 bytes by task 4167 on cpu 0:
 fib_alias_accessed net/ipv4/fib_lookup.h:32 [inline]
 fib_table_lookup+0x361/0xd60 net/ipv4/fib_trie.c:1565
 fib_lookup include/net/ip_fib.h:390 [inline]
 ip_route_output_key_hash_rcu+0x378/0x1380 net/ipv4/route.c:2814
 ip_route_output_key_hash net/ipv4/route.c:2705 [inline]
 __ip_route_output_key include/net/route.h:169 [inline]
 ip_route_output_flow+0x65/0x110 net/ipv4/route.c:2932
 udp_sendmsg+0x13c3/0x15d0 net/ipv4/udp.c:1450
 inet_sendmsg+0xac/0xd0 net/ipv4/af_inet.c:859
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x53a/0x600 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmmsg+0x185/0x320 net/socket.c:2735
 __do_sys_sendmmsg net/socket.c:2762 [inline]
 __se_sys_sendmmsg net/socket.c:2759 [inline]
 __x64_sys_sendmmsg+0x57/0x70 net/socket.c:2759
 x64_sys_call+0x1e28/0x3000 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811b06a7fa of 1 bytes by task 4168 on cpu 1:
 fib_alias_accessed net/ipv4/fib_lookup.h:31 [inline]
 fib_table_lookup+0x338/0xd60 net/ipv4/fib_trie.c:1565
 fib_lookup include/net/ip_fib.h:390 [inline]
 ip_route_output_key_hash_rcu+0x378/0x1380 net/ipv4/route.c:2814
 ip_route_output_key_hash net/ipv4/route.c:2705 [inline]
 __ip_route_output_key include/net/route.h:169 [inline]
 ip_route_output_flow+0x65/0x110 net/ipv4/route.c:2932
 udp_sendmsg+0x13c3/0x15d0 net/ipv4/udp.c:1450
 inet_sendmsg+0xac/0xd0 net/ipv4/af_inet.c:859
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x53a/0x600 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmmsg+0x185/0x320 net/socket.c:2735
 __do_sys_sendmmsg net/socket.c:2762 [inline]
 __se_sys_sendmmsg net/socket.c:2759 [inline]
 __x64_sys_sendmmsg+0x57/0x70 net/socket.c:2759
 x64_sys_call+0x1e28/0x3000 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00 -> 0x01

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 4168 Comm: syz.4.206 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
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

