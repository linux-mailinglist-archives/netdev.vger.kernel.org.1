Return-Path: <netdev+bounces-280766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iECuAeIe6mntuQIAu9opvQ
	(envelope-from <netdev+bounces-280766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:30:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A7F452E9D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73BAB303AF2F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1BF3F0ABB;
	Thu, 23 Apr 2026 13:23:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D73F0A83
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776950615; cv=none; b=J75vLRVzvjqzbIcR4GwL5gcnTs8gvmoyiGjYu2BiEbMyEsRr4tPQSABC8b9X44yk4ujMgKhVqAxDtWs/7hgSKA+0YXFcmBUHOTzf/d7qPtp/Jwbm9kjaPxfCENPbryz1dji+S98FOiva1ykBUE/hBgMU0B2T0a3iER5esz1esAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776950615; c=relaxed/simple;
	bh=kxR5kZe+RhUT1YsIZ7iRg17j5v51ZEPQ/oI9VX4dRiw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NccprhFQ50/oVy60JYkO3ajSRMSd/zgqbXtkN0ZCW31llZ71kXjsu5FMZBNX3zrjaluRHVGnWlUbrrR+0aATmitlcxLiq0lHGZwgivjd1sFM1Noe+U6w39TPl3y2UctuPpsZi+p8aq/2Qdr+4GXMJAbitkr/Xf/7rBcZMx7fM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7dccc707d36so4152013a34.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 06:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776950613; x=1777555413;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZIEEV94aBlR3Ds7V+JNZozyuyfwHjuccKFw4gC7tm8=;
        b=OR9wAisxC/WigSuHVWG2RZ845E4Sp+yTVq/qKsyuDusLNsuY3lU2MgsxdffyOGAVIc
         O2M9pRX6NqiElnRVvA7BW+1UjT3bk81C7r5broylzw3R0HCE0nS+OINCcdODfxjxiT1u
         5O6A/HOoTMyjcPCJ2cu7AZCHCatx3PGI2FRaA+skXY9PiHGTcdcGpjXG/WUt0Yff4zbk
         ABzM5fmZgOIpQ4I90jajS/G2oJBMhegktz/s/JARq6tK6IFAnLGH5VrxJmQ8VShsr9sx
         qylB5Sm2rYvEpjGrQEVSVJuPqGiMxVIh5UlLMANTXYteDIAZydwyK5qOr9I0x01TEGgM
         4mpg==
X-Forwarded-Encrypted: i=1; AFNElJ8V9U3aa9aOqnzrLQa8zXVM9n5oYlC0vkGjl3mBJsK1rMhbgnTEgy++YWcKxfA5wX5CczMQLnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfRRibgWuVfPlKMMZ4+8FCgD0dARF8WRtaBfKrJK8nB70LFiw8
	yafNmoHU5UDb/Gfs+H9lEfxkKOt7hhgu9ue6nhLCoY1wfKUUcgAs9ZoBRPysNlOI6q4FEE6JCXg
	vk+h5cFvKiFabmnTZSw1/NzN0reI29uHj1KDxV7EVIJKdGQkd8Rya5a7pbQ4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:62a:b0:67e:2e4d:6c75 with SMTP id
 006d021491bc7-69462f084a4mr15429094eaf.41.1776950612826; Thu, 23 Apr 2026
 06:23:32 -0700 (PDT)
Date: Thu, 23 Apr 2026 06:23:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ea1d54.a00a0220.9259.0027.GAE@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in sk_common_release (2)
From: syzbot <syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3e19fa1907a3dfda];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280766-lists,netdev=lfdr.de,8c9eede336e3a843750e];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,googlegroups.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,goo.gl:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:server fail];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 74A7F452E9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    2a4c0c11c019 Merge tag 's390-7.1-1' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142dff16580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e19fa1907a3dfda
dashboard link: https://syzkaller.appspot.com/bug?extid=8c9eede336e3a843750e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2a4c0c11.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2702dddfd186/vmlinux-2a4c0c11.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51878be8732c/bzImage-2a4c0c11.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xf4/0x130 lib/refcount.c:28, CPU#1: syz.8.4131/20639
Modules linked in:
CPU: 1 UID: 0 PID: 20639 Comm: syz.8.4131 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:refcount_warn_saturate+0xf4/0x130 lib/refcount.c:28
Code: cc e8 60 a7 0f fd 48 8d 3d 99 d0 ec 0b 67 48 0f b9 3a e8 4f a7 0f fd 5b 5d e9 48 27 a4 06 e8 43 a7 0f fd 48 8d 3d 8c d0 ec 0b <67> 48 0f b9 3a e8 32 a7 0f fd 5b 5d c3 cc cc cc cc e8 26 a7 0f fd
RSP: 0018:ffffc90003aaf120 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880368a2280 RCX: ffffffff84f9d30b
RDX: ffff888061e04a00 RSI: ffffffff84f9d39d RDI: ffffffff90e6a430
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000004
R10: 0000000000000003 R11: 0000000000000000 R12: ffff8880368a2280
R13: ffffffff8a0c6f20 R14: 0000000000000000 R15: 0000000000000018
FS:  00007fd377c686c0(0000) GS:ffff8880d63db000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33023ffc CR3: 00000000308a1000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:400 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 sock_put include/net/sock.h:2009 [inline]
 sk_common_release+0x260/0x370 net/core/sock.c:4024
 inet_release+0xed/0x200 net/ipv4/af_inet.c:442
 __sock_release net/socket.c:722 [inline]
 sock_release+0x91/0x1c0 net/socket.c:750
 rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
 rxe_sock_put+0xae/0x130 drivers/infiniband/sw/rxe/rxe_net.c:639
 rxe_net_del+0x83/0x120 drivers/infiniband/sw/rxe/rxe_net.c:660
 rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
 nldev_dellink+0x289/0x3c0 drivers/infiniband/core/nldev.c:1849
 rdma_nl_rcv_msg+0x392/0x6f0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2cb/0x410 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
 __sys_sendmsg+0x170/0x220 net/socket.c:2784
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd376d9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd377c68028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fd377016090 RCX: 00007fd376d9c819
RDX: 0000000000000004 RSI: 0000200000004680 RDI: 0000000000000003
RBP: 00007fd376e32c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd377016128 R14: 00007fd377016090 R15: 00007ffe66f5e6c8
 </TASK>
----------------
Code disassembly (best guess):
   0:	cc                   	int3
   1:	e8 60 a7 0f fd       	call   0xfd0fa766
   6:	48 8d 3d 99 d0 ec 0b 	lea    0xbecd099(%rip),%rdi        # 0xbecd0a6
   d:	67 48 0f b9 3a       	ud1    (%edx),%rdi
  12:	e8 4f a7 0f fd       	call   0xfd0fa766
  17:	5b                   	pop    %rbx
  18:	5d                   	pop    %rbp
  19:	e9 48 27 a4 06       	jmp    0x6a42766
  1e:	e8 43 a7 0f fd       	call   0xfd0fa766
  23:	48 8d 3d 8c d0 ec 0b 	lea    0xbecd08c(%rip),%rdi        # 0xbecd0b6
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e8 32 a7 0f fd       	call   0xfd0fa766
  34:	5b                   	pop    %rbx
  35:	5d                   	pop    %rbp
  36:	c3                   	ret
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	e8 26 a7 0f fd       	call   0xfd0fa766


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

