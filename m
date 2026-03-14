Return-Path: <netdev+bounces-267777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIfAC0eTtWnL2AAAu9opvQ
	(envelope-from <netdev+bounces-267777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:56:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6C828DFE7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E118C300D0FB
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AFA31F9A6;
	Sat, 14 Mar 2026 16:56:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544F51D432D
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507390; cv=none; b=jhUZYIXImffMzQ7aWjQp0jHcAhgZKty2oltu04MMLsLGiERW+CrBp1o9VGZLLcELxIl5h4WaYlcMUCrU7ANPIhTi76Pj8rVE9lj4Mbvb1/YufoDtXT2yk9TJ/SJA/RRfbVRVgJUMy3Q2B0lsP+W8JxOfZHRdPpoW3SeVDY6eTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507390; c=relaxed/simple;
	bh=xr+POcCpfs9cO0lUth94L1W+tqquTxdgvs052WUZgRM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DOl/i6T1yfRDd1d0DKWjoYLqpYsM5LV20Q1+53FA7bH6OT32rA5E9/I5k6myEQvJVA7reTIOFBcYKXTPhq/QsqAB0F0mkjnBpTmJn62e9jyl9nSOldBQzQ0Tjrz1LSimR4r9BLP9opH3fZ1j5q/8G84WMut0C2q8G/OjzxTcH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67bb57af478so48851451eaf.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 09:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773507388; x=1774112188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpjDYaQvLSGD+SaXbcF6rYQe3AXTGT0kjYEb1W1u5aE=;
        b=m7l5597lYcqWDNoFH6tEQZcNQmKGyueD3p+5PNSDqlJc3SzeGIE/+/809XcGpE4+gH
         ckDm+Uf3dmcmg79LibfWlvVrXEUhiA7WdYt/erOjpAgBo75UCIsfzLOOR3yVN5znxb1u
         VkRIcP+LF4xTb6VKjFF5VdRw74gaIHHA4x3dOoMwrzokDLUwSqOQ3Yn8A6X8PeqtNHlL
         pwJpbdHlctoLWm8dc306NFY3JvF8fpeEhOgKvQKd2oyNGDqmZSRVdYY+MhpeMV9xZ8Z1
         6R7qXlgoOzTDYXLxIV4LY96hgkoEHwD/VwyX9K6EHntWVcgJnfi/gmFWMFQNGl3sr2uz
         EFtg==
X-Forwarded-Encrypted: i=1; AJvYcCUX9+hZkq9KbWJeHGphKwpQ6vDrBfArEg5xMMUojYXWHOwG0x71M1x9QbcW8hFo5MB4pdhU1ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKceyYaaIqqtzsRWuHNBHmRIz2Hn663RYQcyeIIiLpcQF04uX
	HLimyOcXrs4qh4PDArPojBKTWcbsTyvv77bFRn1hHuZnEomVkmtbvD/A8AcE9J2tzwlR8qxDG9o
	Mr8/7yshqw6heJdJYO2gqPBw8yVxi5lmfno0IJR4xn2bwfdkP5zCBlTS6n/Y=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:178d:b0:67b:f13c:3fd2 with SMTP id
 006d021491bc7-67bf13c4351mr764556eaf.62.1773507388329; Sat, 14 Mar 2026
 09:56:28 -0700 (PDT)
Date: Sat, 14 Mar 2026 09:56:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b5933c.050a0220.248e02.00f2.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in pfkey_send_migrate
From: syzbot <syzbot+b518dfc8e021988fbd55@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=779072223d02a312];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-267777-lists,netdev=lfdr.de,b518dfc8e021988fbd55];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email,storage.googleapis.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 0A6C828DFE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    99600f79b28c mpls: add missing unregister_netdevice_notifi..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12291def980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=779072223d02a312
dashboard link: https://syzkaller.appspot.com/bug?extid=b518dfc8e021988fbd55
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15123c16580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1598434a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c7ebefcbe2a3/disk-99600f79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02ff03abfaec/vmlinux-99600f79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c74709d060b/bzImage-99600f79.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b518dfc8e021988fbd55@syzkaller.appspotmail.com

skbuff: skb_over_panic: text:ffffffff8a752120 len:392 put:16 head:ffff88802a4ad040 data:ffff88802a4ad040 tail:0x188 end:0x180 dev:<NULL>
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:214!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5984 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:214
Code: c7 60 24 dc 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 0e 55 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003a06bc0 EFLAGS: 00010286
RAX: 0000000000000088 RBX: dffffc0000000000 RCX: efbd12c4feea6d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000180 R08: ffffc90003a06927 R09: 1ffff92000740d24
R10: dffffc0000000000 R11: fffff52000740d25 R12: ffff8880312a6510
R13: ffff88802a4ad040 R14: ffff88802a4ad040 R15: 0000000000000188
FS:  000055555b534500(0000) GS:ffff888125461000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbef80720c0 CR3: 000000007ae2a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 skb_over_panic net/core/skbuff.c:219 [inline]
 skb_put+0x159/0x210 net/core/skbuff.c:2655
 skb_put_zero include/linux/skbuff.h:2788 [inline]
 set_ipsecrequest net/key/af_key.c:3532 [inline]
 pfkey_send_migrate+0x1270/0x2e50 net/key/af_key.c:3636
 km_migrate+0x155/0x260 net/xfrm/xfrm_state.c:2848
 xfrm_migrate+0x2140/0x2450 net/xfrm/xfrm_policy.c:4705
 xfrm_do_migrate+0x8ff/0xaa0 net/xfrm/xfrm_user.c:3150
 xfrm_user_rcv_msg+0x746/0xb20 net/xfrm/xfrm_user.c:3507
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3529
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
RIP: 0033:0x7fbef819c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe28231e98 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fbef8415fa0 RCX: 00007fbef819c799
RDX: 0000000000000000 RSI: 0000200000000380 RDI: 0000000000000004
RBP: 00007fbef8232c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbef8415fac R14: 00007fbef8415fa0 R15: 00007fbef8415fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:214
Code: c7 60 24 dc 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 0e 55 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003a06bc0 EFLAGS: 00010286
RAX: 0000000000000088 RBX: dffffc0000000000 RCX: efbd12c4feea6d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000180 R08: ffffc90003a06927 R09: 1ffff92000740d24
R10: dffffc0000000000 R11: fffff52000740d25 R12: ffff8880312a6510
R13: ffff88802a4ad040 R14: ffff88802a4ad040 R15: 0000000000000188
FS:  000055555b534500(0000) GS:ffff888125461000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbef80720c0 CR3: 000000007ae2a000 CR4: 00000000003526f0


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

