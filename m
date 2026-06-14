Return-Path: <netdev+bounces-299239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jFqTB6TbLmrj4wQAu9opvQ
	(envelope-from <netdev+bounces-299239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 18:49:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEDA681961
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 18:49:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299239-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299239-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 448BF300361E
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC812E7BB6;
	Sun, 14 Jun 2026 16:49:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BC28C869
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 16:49:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455777; cv=none; b=Do99xFQTfHNMclldd/vxLDl3nQjKECFvwv2rFZq0qSAmpOvRaIBJ3UK+7RttP89ia6G/OB1J3HppeoD4PLMn/+5XJMRfrLPxi/VilIyEUlJRyV0tCPA5uxXbEIjPIlEncJTWsVZvqf+btw01wYiRFyp7RpSpDHEr+hY9nxSN64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455777; c=relaxed/simple;
	bh=Rbmqlh5X77XiKIehBbP7xpfKX9im+AeF0mpBH1PsugI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rnVot8Ro/vGmGudiZTTvry0aLPwCnfIy9NNYbTiIzVfegqc9JX8uQvvZKXiRKku09OTBZFpgpgCUv2XFD2KjrVOWEc581IY4vSwPF2N0hvYWukT3mwYTbiToRWE1e2x5qHb++pN/POsVN16rOifE56bqLe9T8do9hRF7Tl+B+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-48576b535b6so2652744b6e.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 09:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781455774; x=1782060574;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKQe3tHQuohfTiUdhggcYhl3bqm+NLkjvqbPDTnfoNI=;
        b=hCV0wRYrKh0NzXLOhyHreytCpwIe1zrFBWlt3uZzkYYus++UHzKwn0TzorQOUDlLC8
         A9b73bVq+K9jE5nvW7rIRCkLfU0OhBdLHghJdQDQyQhhXGdgg7yJP04qSQYw8guSTqOl
         O9avOsHxVaqucvwMW9eTnoa4ysgiPZ6ilfSU0YexR4gCFPkaJWRPtJe7n9bJ294QXod5
         hGyxHgzm/ylCbx5O9adaJGUK0G4KwKlMgV6zY2b65D+eiL/2DP1mE3dJttJWfTLGo3SJ
         ChuKAZVgYCCFbTm86crLTFQ2ediAEsAZXX63Ngor+nLnbDvVvgtPvVdVEUhZnrXgTpLe
         ut2A==
X-Forwarded-Encrypted: i=1; AFNElJ8d0QmgJtwwJ5oJGYSec+Er+Nmf+aKhkpoEXbZaFMY3J/euScANiTFbhry6vq7YcVk8xvoCUSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhN0/kiblysqAGf8HKBhJ0nDGdeTwXvhvm6t/B5fXTr/3DEDB
	JLYWBoTJfjdfEJHAX4HDhgWkfH3LSFLj+4BjsleCVEfoIjiG4gCEWijgUr5cUuY8F7kRc/hdW6Y
	D5QrX0n2dAsAtMs/kpjWeY7k7rIBEzz4j0PukPOYyPa9rQLo3vIuprE8lYGY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:16a7:b0:467:819:dc61 with SMTP id
 5614622812f47-48741ab5ca9mr4772348b6e.23.1781455774706; Sun, 14 Jun 2026
 09:49:34 -0700 (PDT)
Date: Sun, 14 Jun 2026 09:49:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2edb9e.8812e0fc.3c3fa4.0014.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in __ieee80211_start_scan (2)
From: syzbot <syzbot+f961b9f94edbc266f1f8@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=65472e27d1590a04];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299239-lists,netdev=lfdr.de,f961b9f94edbc266f1f8];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,storage.googleapis.com:url,vger.kernel.org:from_smtp,googlegroups.com:email,appspotmail.com:email,goo.gl:url,syzkaller.appspotmail.com:from_mime,syzkaller.appspot.com:url];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BEDA681961

Hello,

syzbot found the following issue on:

HEAD commit:    627366c51145 ptp: ocp: fix resource freeing order
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1114f186580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65472e27d1590a04
dashboard link: https://syzkaller.appspot.com/bug?extid=f961b9f94edbc266f1f8
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fdf7eb944feb/disk-627366c5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab07a79e10f6/vmlinux-627366c5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/270e46d829a1/bzImage-627366c5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f961b9f94edbc266f1f8@syzkaller.appspotmail.com

------------[ cut here ]------------
!ieee80211_prep_hw_scan(sdata)
WARNING: net/mac80211/scan.c:879 at __ieee80211_start_scan+0x1336/0x1d40 net/mac80211/scan.c:879, CPU#0: syz.0.5003/24116
Modules linked in:
CPU: 0 UID: 0 PID: 24116 Comm: syz.0.5003 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:__ieee80211_start_scan+0x1336/0x1d40 net/mac80211/scan.c:879
Code: 06 90 e8 bd 74 b0 f6 48 83 fd 09 0f 84 41 07 00 00 83 fd 03 0f 84 3f 07 00 00 e8 25 6f b0 f6 e9 d5 f2 ff ff e8 1b 6f b0 f6 90 <0f> 0b 90 e9 0d fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 53 fa
RSP: 0018:ffffc9000674f170 EFLAGS: 00010293
RAX: ffffffff8b154795 RBX: ffff888053bf8e40 RCX: ffff888079661f00
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffff88804acc3024 R08: ffffffff903034f7 R09: 1ffffffff206069e
R10: dffffc0000000000 R11: fffffbfff206069f R12: ffff88804acc3060
R13: dffffc0000000000 R14: ffff88805c5a0f20 R15: ffff88805c5a2a88
FS:  00007fe61492d6c0(0000) GS:ffff8881252a0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe613987cc0 CR3: 0000000075924000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rdev_scan+0x147/0x300 net/wireless/rdev-ops.h:467
 nl80211_trigger_scan+0x1aa1/0x1f50 net/wireless/nl80211.c:11046
 genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2555
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1899
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2699
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2753
 __sys_sendmsg net/socket.c:2785 [inline]
 __do_sys_sendmsg net/socket.c:2790 [inline]
 __se_sys_sendmsg net/socket.c:2788 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2788
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe61399ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe61492d028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe613c15fa0 RCX: 00007fe61399ce59
RDX: 0000000004000000 RSI: 0000200000000900 RDI: 0000000000000003
RBP: 00007fe61492d090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fe613c16038 R14: 00007fe613c15fa0 R15: 00007fff3acb29d8
 </TASK>


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

