Return-Path: <netdev+bounces-289061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FFVEL0OC2pN/gQAu9opvQ
	(envelope-from <netdev+bounces-289061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:06:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9478F56D444
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C71930038E8
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F298C33C18E;
	Mon, 18 May 2026 13:01:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D123126DF
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109286; cv=none; b=frirsVNe7/6Tg5BDZ3YYy550Q/AYYRp/NeC/zFtqBtt53YWZ9ygmO38yGD2zsz2dpYDzOtSwKs1u3tZcZKLC8ul4DGPRVBOFDFaC3DLhZ1TuysK1mf2T+LemES2lHn4u31r+WRwHYzapyDTl2ZtLTCItEwaxKdue1ef+yR4JYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109286; c=relaxed/simple;
	bh=lLl6RY6caPM3rOvfBqXkbSVRHfr3cxYaeRWdxt5n5hE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Rag4LwfSCAvZf3dq075kc/TeYZeAfUsOLMemSf0AaIOuy5gwNu0yUrPdf8Vjg0/b6e3lR9k+f7ASEdBGDqwNwMtkL79AEkyzljElLf53X0k+Y80nB4AQegROl951/OZvNQDpa51NGz8ku95SmYDilDwh2R2pqTFRN6P9fBrDP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7dccdbdf5c2so2641364a34.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109284; x=1779714084;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15XVrlqFLSsUnhnxXxSwCW7nrZfhUDLDuTiL9dFIkEs=;
        b=NwEgnvrD7ogMRSkdYb0oFxXwASW8QeLcDb5FRIKov0yHR4syDkZq+CEUS4muXjTE9d
         lTjq7QwURPOJkRvZATvSV1kDtMMsSUXDCC9hS5gRd7bXok2w/IyhMfpeJXxqgqvVJNRh
         CDlmjOCrnzkXBiHG75+DRUbHNsp2gZ9ukNYyunONBGrfM6yCcmUGG6K7G7h5J5wPo+aN
         bF7oW7FIkdd9lSqwB5MsrLmx6tlAVLv5k/hSSE83eK4UFNVARLqDbM8Q3iogJEMpLvl/
         j0UMJGzyBxIKuV99aJrKSXDcrPcZnW63NZpQctZECPw/+NzZGpKLh9LYjcc1/4aVFo59
         00BA==
X-Forwarded-Encrypted: i=1; AFNElJ+mB5UkumvdDRWLnmYJNwDP04e+SaGa6o+ZSgmxet/aS6LrFFLFqIvSPIEPuuEKDyjivgGaFxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/0XNmSHz3eOVZRZojdEacuAq6eMi+NhPYiUIoVmy9hoRj6Sc
	PxVpMug0/sqpYIlaj8Z8rfxYpxUk87d4BT0LJp6Pz5yc8TdcrOnm3uYl19W15po4y+D8r9CsWta
	pJhlmKRmP2rnoRCNSx1szfDJfE/T/2+wyzQ+CXL2cTyXGVBojJqfHgkNepx4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:d17:b0:7dc:cd0b:58af with SMTP id
 46e09a7af769-7e4f2a2d671mr9973331a34.6.1779109283951; Mon, 18 May 2026
 06:01:23 -0700 (PDT)
Date: Mon, 18 May 2026 06:01:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0b0da3.050a0220.175f0c.0000.GAE@google.com>
Subject: [syzbot] [bridge?] WARNING in br_fill_linkxstats
From: syzbot <syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9478F56D444
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-289061-lists,netdev=lfdr.de,a35f9259d08f907c06e6];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    627ac78f2741 ipv6: addrconf: bail out of dad_failure when ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1074102e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035
dashboard link: https://syzkaller.appspot.com/bug?extid=a35f9259d08f907c06e6
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/81fff4bdde96/disk-627ac78f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b0352468dcd/vmlinux-627ac78f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6db18d47dfe4/bzImage-627ac78f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com

------------[ cut here ]------------
diff > ((u16)~0U)
WARNING: ./include/net/netlink.h:2265 at nla_nest_end include/net/netlink.h:2265 [inline], CPU#1: syz.2.5599/27626
WARNING: ./include/net/netlink.h:2265 at br_fill_linkxstats+0x9e7/0xae0 net/bridge/br_netlink.c:1910, CPU#1: syz.2.5599/27626
Modules linked in:
CPU: 1 UID: 0 PID: 27626 Comm: syz.2.5599 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:nla_nest_end include/net/netlink.h:2265 [inline]
RIP: 0010:br_fill_linkxstats+0x9e7/0xae0 net/bridge/br_netlink.c:1910
Code: b6 bd 08 48 3b 84 24 60 01 00 00 75 33 44 89 f0 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 50 8f 30 01 cc e8 0a 1b 49 f7 90 <0f> 0b 90 e9 bc fe ff ff e8 fc 1a 49 f7 90 0f 0b 90 e9 53 ff ff ff
RSP: 0018:ffffc9000d04f160 EFLAGS: 00010287
RAX: ffffffff8a7ca956 RBX: 0000000000013550 RCX: 0000000000080000
RDX: ffffc90010069000 RSI: 0000000000006616 RDI: 0000000000006617
RBP: ffffc9000d04f310 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff92001a09e40 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f437e58c6c0(0000) GS:ffff88812537a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7ecf36ab4c CR3: 000000003d060000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rtnl_fill_statsinfo+0x541/0x26f0 net/core/rtnetlink.c:6018
 rtnl_stats_get+0x4b6/0x6d0 net/core/rtnetlink.c:6340
 rtnetlink_rcv_msg+0x77e/0xbe0 net/core/rtnetlink.c:7018
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f437d79ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f437e58c028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f437da16090 RCX: 00007f437d79ce59
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 000000000000000a
RBP: 00007f437d832d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f437da16128 R14: 00007f437da16090 R15: 00007ffe687b3418
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

