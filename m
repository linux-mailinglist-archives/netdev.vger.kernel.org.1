Return-Path: <netdev+bounces-258669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPI+KImEj2mRRQEAu9opvQ
	(envelope-from <netdev+bounces-258669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:07:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0E1394FC
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9CB83021D09
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691C11F9ECB;
	Fri, 13 Feb 2026 20:07:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3B339A8
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013253; cv=none; b=AewU97jjey5M+KMbB6fFRbugO/jeD+42mplgd9ha/61CDZmkRrI4VKQtXyBaZrNc4TyOJ8ycfKNPSct8/XhWyMpd9vEbviMFdXfxe0eLaits4FYir/z0i1pV/yx+mphdMv9/oHGTDp2H4jQLbEL/H612jsIlSKIf5l2EsmBq9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013253; c=relaxed/simple;
	bh=iPbUyrZ/cHAbPklt30x6GWKULBcZbziWIRRQ/1zzWOI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fqnn8uXgDSrp+fhe29pAG1+UKFgKE2vjfnOcjSE4fgr0eDa3iQ2u4MXCJIWqRLsCnuB7tfgru1gKHjfm/b+cObR0I6c4IgSkYX/01UIGvffjy6fSps2WsdTqhXXVTUIwLcXhFaLXa51V1A5f6n8cEN1EmW9d4tBj4fFfq65x2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4cb985fa3so2680833a34.2
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 12:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771013251; x=1771618051;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pz6Gedea6EkVqgMD44XOwHif99Mq0fIjgcN34vbFrM0=;
        b=I8pOebIAT3+I047qnixg/pbqMgEjQ46MKio7fPLdqPYTtEHTK1Vrsu1NvJxik2+7qr
         lCnd2K+NCfFUwoZoXOY5tMvX/gs7tXDaaSv7iyjm46CpnLvIG/t99cwIWON/MaYz0adh
         5nazlHjxR1j1nh/cmrEECvwg1I+dOMHl5IWfx1Vl93ZkON02F2Z6p+M/emmZyDpkIRnK
         niOJztj5G12bEP6QW1OUi8VRCe6BKZ8LiihJRes7yWHxd9gk/mFgcxm5wFgSe34I04h1
         +j0I5GZqJXlgzqF7mhRyPieTiGJyRGQ46GFGAJ2Vun4nQmQvh+7+Yd+QUCPyfyEKVehU
         snuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFMACCndsi7tLYImgmD79IkcvVzuk5qp9WKLyPs1mwstRaUGGtkly6ia/BE9o5xaRsbu2PmNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPLlfKvo5L/jxbgU7dk8caBH596ofGOPqv9zVRZiAsnsAF8Lq
	0nZZ/EMUmJ3DSkq2raLxePidrSqlOpLuYsaW+8e62IdkvcczfYmrXMeTy1vVM81mAwjf3CACkHU
	004HQQhuQHchXeKxWwCq6Psm3Ka1RYRzW3Q/yvludes49eUZsc+b2N7S9aeU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2912:b0:675:a8c0:93e9 with SMTP id
 006d021491bc7-67769f6da68mr1244026eaf.79.1771013250821; Fri, 13 Feb 2026
 12:07:30 -0800 (PST)
Date: Fri, 13 Feb 2026 12:07:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698f8482.a70a0220.2c38d7.00ca.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in ip_route_output_key_hash_rcu
From: syzbot <syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a1db0fea040c2a9f];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258669-lists,netdev=lfdr.de,334190e097a98a1b81bb];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: DFD0E1394FC
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    2eba5e05d9bc Merge tag 'loongarch-fixes-6.18-2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125498b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1db0fea040c2a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=334190e097a98a1b81bb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ebaa12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15848e92580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2eba5e05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea041b2f66b0/vmlinux-2eba5e05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a9a26c9a2a1c/bzImage-2eba5e05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffed1011ae5e00
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 5ffcd067 P4D 5ffcd067 PUD 2fff7067 PMD 0 
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5500 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__mkroute_output net/ipv4/route.c:2649 [inline]
RIP: 0010:ip_route_output_key_hash_rcu+0x12fc/0x23e0 net/ipv4/route.c:2875
Code: 4c 8b 35 2f ea bc 08 49 83 c7 38 4c 89 f8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ff e8 ce 38 75 f8 4d 03 37 4c 89 f0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 f7 e8 b6 38 75 f8 4d 8b 36 e8 9e 72 96 01
RSP: 0018:ffffc9000298e948 EFLAGS: 00010a06
RAX: 1ffff11011ae5e00 RBX: 0000000080000000 RCX: ffff888000bdc900
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffff888000bdc900 R09: 0000000000000003
R10: 0000000000000005 R11: 0000000000000000 R12: ffffc9000298ebd3
R13: 0000000000000000 R14: ffff88808d72f000 R15: ffff888036590158
FS:  000055556855e500(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed1011ae5e00 CR3: 0000000042bac000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ip_route_output_key_hash+0x174/0x280 net/ipv4/route.c:2705
 __ip_route_output_key include/net/route.h:169 [inline]
 ip_route_output_flow+0x2a/0x150 net/ipv4/route.c:2932
 ip_route_output_key include/net/route.h:179 [inline]
 sctp_v4_get_dst+0x3c7/0x1200 net/sctp/protocol.c:455
 sctp_transport_route+0x118/0x2f0 net/sctp/transport.c:448
 sctp_ootb_pkt_new+0x28b/0x3c0 net/sctp/sm_statefuns.c:6437
 sctp_sf_abort_violation+0x14b/0xc60 net/sctp/sm_statefuns.c:4771
 sctp_sf_violation_chunklen net/sctp/sm_statefuns.c:4830 [inline]
 sctp_sf_ootb+0x4df/0x7c0 net/sctp/sm_statefuns.c:-1
 sctp_do_sm+0x1e7/0x5a20 net/sctp/sm_sideeffect.c:1172
 sctp_endpoint_bh_rcv+0x591/0x7e0 net/sctp/endpointola.c:408
 sctp_rcv+0x11dc/0x1870 net/sctp/input.c:243
 ip_protocol_deliver_rcu+0x2e0/0x440 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:239
 NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
 NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6079 [inline]
 __netif_receive_skb+0x143/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
 tun_get_user+0x2b65/0x3e90 drivers/net/tun.c:1953
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbd9ab8e1ff
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007ffca504fd10 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fbd9ade5fa0 RCX: 00007fbd9ab8e1ff
RDX: 0000000000000032 RSI: 00002000000000c0 RDI: 00000000000000c8
RBP: 00007fbd9ac13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000032 R11: 0000000000000293 R12: 0000000000000000
R13: 00007fbd9ade5fa0 R14: 00007fbd9ade5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
CR2: ffffed1011ae5e00
---[ end trace 0000000000000000 ]---
RIP: 0010:__mkroute_output net/ipv4/route.c:2649 [inline]
RIP: 0010:ip_route_output_key_hash_rcu+0x12fc/0x23e0 net/ipv4/route.c:2875
Code: 4c 8b 35 2f ea bc 08 49 83 c7 38 4c 89 f8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ff e8 ce 38 75 f8 4d 03 37 4c 89 f0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 f7 e8 b6 38 75 f8 4d 8b 36 e8 9e 72 96 01
RSP: 0018:ffffc9000298e948 EFLAGS: 00010a06
RAX: 1ffff11011ae5e00 RBX: 0000000080000000 RCX: ffff888000bdc900
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffff888000bdc900 R09: 0000000000000003
R10: 0000000000000005 R11: 0000000000000000 R12: ffffc9000298ebd3
R13: 0000000000000000 R14: ffff88808d72f000 R15: ffff888036590158
FS:  000055556855e500(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed1011ae5e00 CR3: 0000000042bac000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	4c 8b 35 2f ea bc 08 	mov    0x8bcea2f(%rip),%r14        # 0x8bcea36
   7:	49 83 c7 38          	add    $0x38,%r15
   b:	4c 89 f8             	mov    %r15,%rax
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  16:	74 08                	je     0x20
  18:	4c 89 ff             	mov    %r15,%rdi
  1b:	e8 ce 38 75 f8       	call   0xf87538ee
  20:	4d 03 37             	add    (%r15),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 b6 38 75 f8       	call   0xf87538ee
  38:	4d 8b 36             	mov    (%r14),%r14
  3b:	e8 9e 72 96 01       	call   0x19672de


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

