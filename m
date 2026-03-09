Return-Path: <netdev+bounces-265679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB3FF1MLr2lzMQIAu9opvQ
	(envelope-from <netdev+bounces-265679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:02:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF30F23E233
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 396943045915
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0D63ED127;
	Mon,  9 Mar 2026 17:57:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FDD3ED5A9
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079049; cv=none; b=g8BRnNLusKf/yNLK2lxcJ0xWseASTIA4sN9cxbS4krhhQznm6kA3NLBhx++VhEPoGm1y6AGQopScFx6kb58LUyZGhY6Yt/JMG1lAJYbGeozi/ilAh0a58ZENZcwFa9oB0+IkXmh8CYhrLxAD+5ObJRZb9QGZeMPrS8hkXP93hvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079049; c=relaxed/simple;
	bh=n4XBpiqCf7QMLD1zz58FosrDYhHggZnE3j7pilr7UO8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KKVKIAJDHPX8fFVmnkDpLmXLjqg7Omj3rlSq7Nhs0Ymf1TxklxgRhJ/l+ucDAuaR/w5CCFB/BKl67y2w+V0HHEXuglbMi98oJlueQ257uCZW0b934hEXJ1Wj9xPoQ1gOA3qA1b9bf80f3hrDMQpF4TwW3m50c6rxEePHW5yE9I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-463a018f61bso52445492b6e.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 10:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079045; x=1773683845;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSKL8Gq0kuzwVgWvP9jSNZpSIUElF/SAaYbA0Teg7BM=;
        b=SoEkTnq2aoYKAdYcfUK0sqK2ZJsVEzwIncTZowCa7v6TPoortuBcaKwfvRUQ6zoiMb
         wU3IbY6rfEL0vRMwo4XHDQNihCm+0xHw0/DmYGdlib4cV1hYSZAr1lU8yQwRqDkiqpPH
         HrGFhVjsRtI7b+Chuoi6FHXwIhRDhrMK84e+egLDdU6b30gWoDQc1USY/z+8n3yoUDzD
         wjgIVUs6u6Cbqlx7TlKQ/b2QweJfTKu+6cnMgjkmzBY6jZpf1GRTcISYEpib3SpX33xI
         6lxiQkcwyHFIXvlbLtOz+62gGZxFZgjVbpFtWv1BN6L2n3Yml3M4cWU7/qFQu0IHxzXl
         hv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6eI90+T1icNQ50L5wc/igQQqUGZdBy9OHwtDjFyoTbWVyKQsv8tIVpWjh20l9Wlklkfbif0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBG0cr6F9AFsK5Lwc9MiPhr0AbNWLDdB06kb1C5OdJMhhoF53J
	eXKh/JNms/xXKBSTRrf+VnAL/uIZVNtgOsTGd7/srria8MO38prr3ZJSeEdZdr1Tfj/FI7HfDr1
	dYVCBGkqHn/sHemTGqQ0VLcPebwRU571//MICNPiQA3VLRVqE72MlA5+nx78=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d398:0:b0:67b:a543:dd38 with SMTP id
 006d021491bc7-67ba543f19bmr4030212eaf.58.1773079044974; Mon, 09 Mar 2026
 10:57:24 -0700 (PDT)
Date: Mon, 09 Mar 2026 10:57:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69af0a04.050a0220.310d8.002e.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_tdls_oper (3)
From: syzbot <syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EF30F23E233
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=779072223d02a312];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265679-lists,netdev=lfdr.de,56b6a844a4ea74487b7b];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,googlegroups.com:email,goo.gl:url,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    c113d5e32678 Merge branch 'net-spacemit-a-few-error-handli..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=171fc8ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=779072223d02a312
dashboard link: https://syzkaller.appspot.com/bug?extid=56b6a844a4ea74487b7b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1736875a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109fc8ba580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1a0aa684791/disk-c113d5e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d0461aed5ba/vmlinux-c113d5e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/05b26502bb1f/bzImage-c113d5e3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com

mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
------------[ cut here ]------------
is_zero_ether_addr(sdata->u.mgd.tdls_peer) || !ether_addr_equal(sdata->u.mgd.tdls_peer, peer)
WARNING: net/mac80211/tdls.c:1461 at ieee80211_tdls_oper+0x38f/0x680 net/mac80211/tdls.c:1460, CPU#1: syz.0.446/6497
Modules linked in:
CPU: 1 UID: 0 PID: 6497 Comm: syz.0.446 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:ieee80211_tdls_oper+0x38f/0x680 net/mac80211/tdls.c:1460
Code: 6f 01 00 00 e8 d2 d0 89 f6 eb 22 e8 cb d0 89 f6 4c 89 e2 eb 21 e8 c1 d0 89 f6 b8 bd ff ff ff e9 21 fe ff ff e8 b2 d0 89 f6 90 <0f> 0b 90 4c 8b 7c 24 08 48 8b 14 24 4d 8d a7 fa 1d 00 00 4c 89 e0
RSP: 0018:ffffc90003187320 EFLAGS: 00010293
RAX: ffffffff8b3bc8be RBX: dffffc0000000000 RCX: ffff8880295bdb80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff888030ce0187 R09: 1ffff1100619c030
R10: dffffc0000000000 R11: ffffed100619c031 R12: ffff8880688addfe
R13: ffff8880688acdc0 R14: 1ffff1100d115afe R15: 0000000000000000
FS:  0000555589322500(0000) GS:ffff888125561000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000021c0 CR3: 00000000682a6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rdev_tdls_oper net/wireless/rdev-ops.h:945 [inline]
 nl80211_tdls_oper+0x270/0x470 net/wireless/nl80211.c:13748
 genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc82559c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffce312b098 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc825815fa0 RCX: 00007fc82559c799
RDX: 0000000000000050 RSI: 0000200000000240 RDI: 0000000000000005
RBP: 00007fc825632bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc825815fac R14: 00007fc825815fa0 R15: 00007fc825815fa0
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

