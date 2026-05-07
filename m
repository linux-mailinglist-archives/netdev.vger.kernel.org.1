Return-Path: <netdev+bounces-285140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJxLCIcM/Gm8KQAAu9opvQ
	(envelope-from <netdev+bounces-285140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:52:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D28C4E2BA5
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAF5530074F6
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 03:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F02E285C;
	Thu,  7 May 2026 03:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD322BE65F
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778125951; cv=none; b=N5g4RU35Llik1N63bZLYsfoOTGSlguPcHGQCD2eFohadzSuRnT9VPNM42hkQkBs+dFk70tGQ5MGM8EpBw2sb0xIgV26lxM9Hd2Jf+uKLiW78Jsq2atlvtiYGB0LTpV7thKMF7MTO1N+pGad+ZWw2cy6p3/A19eRKSqTgzlb+XU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778125951; c=relaxed/simple;
	bh=oMEUOwDU16568+OG0pwZfM+8KOgH72u9aq6R9tT6z/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sFk6H2eJKBNmZxNNAa9axCrrF6bosTdW2ncDEuSuUDu9ek0Ifxwy1+XVAGSt93zqFy5SWQU9cYctFaz3HGfjoANRRAjGtTyWT8Ux5hcVdl/iMUvrwNrKGYeoNDA173Qp1VRuSaLVLl/JjZoRZM/uZsrIkbxcHCVTvqqxuNdTJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7dbd4fe0e15so1030073a34.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 20:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778125948; x=1778730748;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0HSrMiYkrVuEd7IGCn11W+YArojUCdXH93mpX8mgVU=;
        b=mWUDkeQ+pceGOMCgP8aYqtlQwoEClfG/FQ2YqwJ/V0aQo7RHE/FUF7lMG8j33G/tl1
         N0WQN2jYlAIsZSPax+y4DpOWYh6oT0cl/ZwDuus2ZQOr10u1QoknufPhh6V42VkrvxsM
         XVZ0q7r3FgRb5/T3QLJJFpBB1nrxhUNzCJlSO1+CKWMhyTS9spvHUjl+0G8ARH77n8Z4
         wGJaF2VTBAQjLi8Lzu1iPzjxEukL0/4p5/G8lznL0Ow+D62zaeqjQMhBtSRtlhNeQPL3
         SABSVAKEA8MkFYBai2UcZlPjZMOTuLw0aYC5oZ/kkrnyrP2PADooT3jQnULpSF2Kj1Jh
         sliw==
X-Forwarded-Encrypted: i=1; AFNElJ8XWn9OrCQCKMjvjPgkMfh6M8f0pvFiorZQ4sYu6nIGBI75bXSBvnr9gGAp9Lf7AcIsMaBrpvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgwwRY0mZVr01wUFbvqSdHy6Bhp1Usam36ZyU6GU2XDH7VT1+J
	odTXtd1YYheETMwou0Nd2w1WSSY2g7pA2Lf74Tw512sqCzBskxm2RdhXSScfoOVaEHVmdHp9nsZ
	x+ZvfKF2wFOQZBKlelhnb3jvBDZ6XkD+FvBOJwo+K3hfPMqEcy/zKwEn00aQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:612:b0:696:7867:c3a6 with SMTP id
 006d021491bc7-69998ccbf4amr3573196eaf.25.1778125948663; Wed, 06 May 2026
 20:52:28 -0700 (PDT)
Date: Wed, 06 May 2026 20:52:28 -0700
In-Reply-To: <69ea344f.a00a0220.17a17.0040.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69fc0c7c.a00a0220.387fc1.0006.GAE@google.com>
Subject: Re: [syzbot] [rdma] general protection fault in kernel_sock_shutdown (4)
From: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, hdanton@sina.com, horms@kernel.org, 
	jgg@ziepe.ca, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1D28C4E2BA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a88880f0f312e277];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285140-lists,netdev=lfdr.de,d8f76778263ab65c2b21];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,googlegroups.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    735d2f48cada Add linux-next specific files for 20260506
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14f0e56a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a88880f0f312e277
dashboard link: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125c9f6c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166580ec580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e65b731bdb98/disk-735d2f48.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60db2f3d3f2f/vmlinux-735d2f48.xz
kernel image: https://storage.googleapis.com/syzbot-assets/55da282f7ab4/bzImage-735d2f48.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com

rdma_rxe: rxe_newlink: failed to add lo
Oops: gen[  127.022080][ T5982] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 1 UID: 0 PID: 5982 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:kernel_sock_shutdown+0x2a/0x70 net/socket.c:3803
Code: f3 0f 1e fa 41 57 41 56 41 54 53 89 f3 49 89 fe 49 bc 00 00 00 00 00 fc ff df e8 e1 25 c5 f8 4d 8d 7e 20 4c 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 ff e8 27 bf 2e f9 4d 8b 3f 49 83 c7 68
RSP: 0018:ffffc900015ef090 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000002 RCX: ffff88802dd89ec0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1007cc8979 R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000020
FS:  000055556d432500(0000) GS:ffff888125dca000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b34563fff CR3: 0000000042b1c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
 rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
 rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
 rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
 rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
 nldev_dellink+0x304/0x3d0 drivers/infiniband/core/nldev.c:1849
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6d7/0xa10 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x780/0x920 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
 sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
 __sock_sendmsg net/socket.c:812 [inline]
 ____sys_sendmsg+0x55c/0x870 net/socket.c:2716
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2770
 __sys_sendmsg net/socket.c:2802 [inline]
 __do_sys_sendmsg net/socket.c:2807 [inline]
 __se_sys_sendmsg net/socket.c:2805 [inline]
 __x64_sys_sendmsg+0x1c3/0x2a0 net/socket.c:2805
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f89172fcdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe8bf8c018 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8917575fa0 RCX: 00007f89172fcdd9
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000006
RBP: 00007f8917392d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8917575fac R14: 00007f8917575fa0 R15: 00007f8917575fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kernel_sock_shutdown+0x2a/0x70 net/socket.c:3803
Code: f3 0f 1e fa 41 57 41 56 41 54 53 89 f3 49 89 fe 49 bc 00 00 00 00 00 fc ff df e8 e1 25 c5 f8 4d 8d 7e 20 4c 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 ff e8 27 bf 2e f9 4d 8b 3f 49 83 c7 68
RSP: 0018:ffffc900015ef090 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000002 RCX: ffff88802dd89ec0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1007cc8979 R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000020
FS:  000055556d432500(0000) GS:ffff888125dca000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000042b1c000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	f3 0f 1e fa          	endbr64
   4:	41 57                	push   %r15
   6:	41 56                	push   %r14
   8:	41 54                	push   %r12
   a:	53                   	push   %rbx
   b:	89 f3                	mov    %esi,%ebx
   d:	49 89 fe             	mov    %rdi,%r14
  10:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  17:	fc ff df
  1a:	e8 e1 25 c5 f8       	call   0xf8c52600
  1f:	4d 8d 7e 20          	lea    0x20(%r14),%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ff             	mov    %r15,%rdi
  34:	e8 27 bf 2e f9       	call   0xf92ebf60
  39:	4d 8b 3f             	mov    (%r15),%r15
  3c:	49 83 c7 68          	add    $0x68,%r15


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

