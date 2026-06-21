Return-Path: <netdev+bounces-300869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2npUA4iDN2rdOQcAu9opvQ
	(envelope-from <netdev+bounces-300869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 08:24:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 540466AA4C6
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 08:24:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300869-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300869-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48E6C301ECFE
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 06:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFAA25B0A6;
	Sun, 21 Jun 2026 06:23:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0E925B086
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 06:23:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782023012; cv=none; b=fgnUNX+EYS35dpGFtNo5G0wfCqGgrmlxkG9b/RiXRI9dwOkl3HT+l0gFCW8jTAAacqXysqSHJZVwTNRZvTL/pWBfADjlJn+KWaVX1YfpWYHvl+55y30JQqtNppScYtL7fsvJ80yMOkP+DvqJEgGJeIvg5WGIV9eSBsYB2PVMDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782023012; c=relaxed/simple;
	bh=fvPdvbKCHNcGq7TIENzOt+l3XxV5oS+AG7cJr0UOi0s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IufqCJozQYQC8PE48+jFCViwzPPMSvytMcGN9B2iKrwJ6fiogXjSykSWPBNpdZPP/TAsJZSKuUEgKlZaasuqSUS1I0gavrms2/wmpG+k3ji5A0OebM8NLBkwAVUvC9LfbOuU13Gcaj4vRu3IGHXyLy3wWYeHvUwG6/e7ROiawPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-48638da0e05so3883233b6e.3
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 23:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782023010; x=1782627810;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xXO7vuOsbMc3EQf6yQWVfMfKDoPfeW5bIr0yXwy+es=;
        b=Ui2Az3r1Iw4qynerIuu5IttxzrEHeOECG2pP4a72peDGOwwupykCh6t/mJuaylbyM/
         Vx3zQimQmoCG0IvA690uOD8djZfhQtVvvRUeyQy8NwmwEBwka5R3cAiYX/SRiu615Ezq
         qmX5e3aXA4y+WayQqZX9/7klhFkmGD7V2edCCy7d6p+6F1Rbnw1A/BzY4XgYi6qxtCpS
         6ANh80L7M8Tqc6yIbVwwmsN3M8rsB7QZPh2on2aQSznxGLvsvXTt0nSHTAsJtaRWuAqi
         pPQgTA1/YK9W1NDs4+5LT2j6LNTeQUYfD/Wf89/YqkIPcjlEDWJbxJ6dYyqm7rYhEvU7
         kFlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bx9SxYCeszKWAxRQlgzb36ey9B+CxNuJaRbvEZsiGsptLr1OfxffljWtkp3uasdX8kSYJZdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa/Ndj2Uuq7epGzNC3Uc5InDlXRKFgmyIdbwzhR9Pf8t3D2ZK7
	kKtCiH8kcBR5GBRfPzOX9DaSNnOgQgv6TJnjcYfSZwKwASFhkgCQ9XaR5IXfanG3jK2pGiGhfVO
	FlNULGwXCCwyO32PSzkz+6f4/BolWPiLlupdbTSn5fA4kK/T5u7eeU97GHog=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f14:b0:489:6f90:2f45 with SMTP id
 5614622812f47-489aeaa6809mr8700295b6e.1.1782023010490; Sat, 20 Jun 2026
 23:23:30 -0700 (PDT)
Date: Sat, 20 Jun 2026 23:23:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a378362.5c48295d.477b4.003e.GAE@google.com>
Subject: [syzbot] [nbd?] WARNING in nbd_add_socket
From: syzbot <syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com>
To: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:josef@toxicpanda.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nbd@other.debian.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300869-lists,netdev=lfdr.de,6b85d1e39a5b8ed9a954];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlegroups.com:email,storage.googleapis.com:url,syzkaller.appspotmail.com:from_mime,goo.gl:url];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 540466AA4C6

Hello,

syzbot found the following issue on:

HEAD commit:    b85966adbf5d Merge tag 'net-next-7.2' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=101f6d56580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544
dashboard link: https://syzkaller.appspot.com/bug?extid=6b85d1e39a5b8ed9a954
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13584aae580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fd7b7a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/780edcc3cc37/disk-b85966ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/967dd18c7ecd/vmlinux-b85966ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf9fa92c90ff/bzImage-b85966ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com

netlink: 3936 bytes leftover after parsing attributes in process `syz.0.25'.
------------[ cut here ]------------
!sock_allow_reclassification(sk)
WARNING: drivers/block/nbd.c:1249 at nbd_reclassify_socket drivers/block/nbd.c:1249 [inline], CPU#0: syz.0.25/5992
WARNING: drivers/block/nbd.c:1249 at nbd_add_socket+0xf35/0x12c0 drivers/block/nbd.c:1293, CPU#0: syz.0.25/5992
Modules linked in:

CPU: 0 UID: 0 PID: 5992 Comm: syz.0.25 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:nbd_reclassify_socket drivers/block/nbd.c:1249 [inline]
RIP: 0010:nbd_add_socket+0xf35/0x12c0 drivers/block/nbd.c:1293
Code: f7 e8 6f b5 20 fc bf e0 01 00 00 49 03 3e 48 c7 c6 40 02 55 8c e8 2b a8 1b fb b8 f0 ff ff ff e9 b2 fd ff ff e8 ac 60 b5 fb 90 <0f> 0b 90 e9 16 f8 ff ff e8 5e 2e 97 05 44 89 e9 80 e1 07 fe c1 38
RSP: 0018:ffffc90002ef7160 EFLAGS: 00010293

RAX: ffffffff86109574 RBX: 1ffff1100651ddb9 RCX: ffff888020b68000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002ef7250 R08: ffff888035af2bdf R09: 1ffff11006b5e57b
R10: dffffc0000000000 R11: ffffed1006b5e57c R12: ffff8880328eec00
R13: 1ffff920005dee38 R14: dffffc0000000000 R15: 0000000000000001
FS:  00007fcc9d5dd6c0(0000) GS:ffff88812527c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f81a8ab50f0 CR3: 0000000078780000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nbd_genl_connect+0x133d/0x1c10 drivers/block/nbd.c:2254
 genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x9b9/0xa20 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcc9df9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcc9d5dd028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fcc9e216090 RCX: 00007fcc9df9ce59
RDX: 0000000000004040 RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007fcc9e032d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcc9e216128 R14: 00007fcc9e216090 R15: 00007ffc8f827678
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

