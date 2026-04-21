Return-Path: <netdev+bounces-280275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC1PLqMG6Gl2EQIAu9opvQ
	(envelope-from <netdev+bounces-280275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 01:22:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ABC4408BA
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 01:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE714312AFD7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 23:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5A3A3E82;
	Tue, 21 Apr 2026 23:16:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC63A1D1B
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813400; cv=none; b=UG85BT4+zSl1rYXjnFJfT+lxXmhpQUT2+bijLfxGwBIl2pD/r/ZOcrkCcErDtxTOx3+8cKpfu8jO/nLUgayAF2xqvwP4dsVl0MoESvoaQJP2uNVwLaQGQ99ku6EUXsAkT49+ewjLKMnGrRrvWwl0ikwF8dYSvaDZhdL+JYFhZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813400; c=relaxed/simple;
	bh=jjNhiuEj7FQvPAjmnCV8hzKyi+/dVYWBPhagpVQW8YA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WwenfhkgflXBdYT+gHcVKgM7fWe3/9MGxgSC/MjgtxkJHCveR4QxUUp/9GKZoYpaK/1r+q15xQXTxmQ4zrnBRc8D2MsuPht3nMKz8COQF3p5geExK0I4Z9930tpYZ82nr2zQhrPq+iUistRgePZbW4do48qdyePKGqPvFhk5bpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6948eac3522so5121741eaf.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 16:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813389; x=1777418189;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpWp0L8twdDIkkTdSHW3HMynYG72MHcZF+132o+rNOc=;
        b=AN1lrF5fEZMmTXczdOtJ0ROP+kmGbsrFZcb9fbLhqhmuldbJ/8jcwoZNi4EO8c2lsQ
         yqstgli3xT0WRq7V/F/wA4+F3JyPP8l55e8hPgp7JhoX3sjLg3T967WKo4pMi8E5X2d/
         4OT8Y+VOWTcZHMQNtrt41goc53GIp3JTMDdjXTri2k/uJXahrGLOZtSVjaPE3n+pHiWu
         B8xQyE9e2brm52lALuxiqVxom9+hodkxJalzQJPtZZRlJX6bPIF5pEzVf1jlZb7U/qp5
         xv+kDG35ZXMqc4YkkLOx4N661bMlmvoFZ2HtIhOTZQNDCC3+cQVGT/wgCnjIsujRGNgC
         tJWg==
X-Forwarded-Encrypted: i=1; AFNElJ+aVwOqXzdjKEnFIfzSZl6B+VVfmxpjJSpcD6OHJQN7OGPACk2Mg7f2oGJn2J1GqWa2i6voHjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6UJyiiooHi6Bx3zsU3EvRgsvAfS7e9QdEIPerSQDQMeprM9R
	8owbLbk/+xMHpRaqwzKIpAmUJQhUXrOuF0kOipDh3LjJZl+JDxIBt4qAbQ/Ww9nC9iQyb4qYwOG
	gqo9RYG4uK/9YnHWIMtyrU6dNOFUAMoW6ymmXuqxm4tv4bROZCrl6hPQyYJ8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3098:b0:694:8e29:a920 with SMTP id
 006d021491bc7-6948e29ac68mr4612704eaf.39.1776813388947; Tue, 21 Apr 2026
 16:16:28 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:16:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e8054c.a00a0220.9259.0016.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in pn_socket_sendmsg
From: syzbot <syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com>
To: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=354b135d724a721f];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-280275-lists,netdev=lfdr.de,706f5eb79044e686c794];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,syzkaller.appspot.com:url,googlegroups.com:email,storage.googleapis.com:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 17ABC4408BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    97e797263a5e Add linux-next specific files for 20260420
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=111f5702580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=354b135d724a721f
dashboard link: https://syzkaller.appspot.com/bug?extid=706f5eb79044e686c794
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bbf4ce580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152051ba580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bfe08255b02b/disk-97e79726.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70874e341331/vmlinux-97e79726.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68352f7fca94/bzImage-97e79726.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com

netlink: 'syz.0.17': attribute type 2 has an invalid length.
------------[ cut here ]------------
kernel BUG at net/phonet/socket.c:213!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6014 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
RIP: 0010:pn_socket_sendmsg+0x240/0x250 net/phonet/socket.c:421
Code: cc cc cc e8 c2 0c d2 00 89 d9 80 e1 07 fe c1 38 c1 0f 8c 04 ff ff ff 48 89 df e8 bb d3 be f7 e9 f7 fe ff ff e8 c1 5a 55 f7 90 <0f> 0b 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffffc900050d7ba0 EFLAGS: 00010293
RAX: ffffffff8a6fa75f RBX: 0000000000000000 RCX: ffff888031b91ec0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900050d7c58 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1f9e8df R12: dffffc0000000000
R13: ffff88805c7b5ec0 R14: ffff888034fecec0 R15: 1ffff92000a1af78
FS:  00007f347ac666c0(0000) GS:ffff888125a62000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f347b5f7680 CR3: 000000003d362000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
 __sock_sendmsg net/socket.c:812 [inline]
 __sys_sendto+0x402/0x590 net/socket.c:2280
 __do_sys_sendto net/socket.c:2287 [inline]
 __se_sys_sendto net/socket.c:2283 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2283
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f347b5cd04e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007f347ac64e88 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f347ac666c0 RCX: 00007f347b5cd04e
RDX: 0000000000000020 RSI: 00007f347ac65000 RDI: 0000000000000006
RBP: 0000000000000000 R08: 00007f347ac64f04 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
R13: 00007f347ac64f58 R14: 00007f347ac65000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
RIP: 0010:pn_socket_sendmsg+0x240/0x250 net/phonet/socket.c:421
Code: cc cc cc e8 c2 0c d2 00 89 d9 80 e1 07 fe c1 38 c1 0f 8c 04 ff ff ff 48 89 df e8 bb d3 be f7 e9 f7 fe ff ff e8 c1 5a 55 f7 90 <0f> 0b 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffffc900050d7ba0 EFLAGS: 00010293
RAX: ffffffff8a6fa75f RBX: 0000000000000000 RCX: ffff888031b91ec0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900050d7c58 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1f9e8df R12: dffffc0000000000
R13: ffff88805c7b5ec0 R14: ffff888034fecec0 R15: 1ffff92000a1af78
FS:  00007f347ac666c0(0000) GS:ffff888125a62000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f347b5f7680 CR3: 000000003d362000 CR4: 00000000003526f0


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

