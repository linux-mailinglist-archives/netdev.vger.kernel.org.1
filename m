Return-Path: <netdev+bounces-280787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJczKZo06mkCwwIAu9opvQ
	(envelope-from <netdev+bounces-280787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:02:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD284540BE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 712C33004F14
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41435B12B;
	Thu, 23 Apr 2026 15:01:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79985285CA4
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956499; cv=none; b=JRJDQ6ukz90tUJo6X/mmKE1PeOwk/oZoznB1OQqrP92Kdz0sjCaWraPa20X7z/BthtoD8oNhievrCnQYK2p5nt99cRhwreG01bHyPY3ti6YJkFskP+VHRsCm6y4wL9nfcWcSzj8PMsPKdXKF82APMPd/4KAY6GMPDJ14MODOZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956499; c=relaxed/simple;
	bh=VHwVLlpsrWTqBP1abZwzFeNz30fIA/BRePwh2i8mCOg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JScbHRHRP/teq86CdJSdUWfGeebURgj8dVl8KG8i/77NgdcRVuMxJZ45rDngv5w12VoZapH1oe9SFQS/pbf26zBsFwaKOfnRRkN9/zwTrqxL1siMWJDiLDxlWoRD3l1kXJYhsk3xNxh+Ytvd87ZQrUnQtSa27t6vForsCKnGYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.216.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-354490889b6so10069041a91.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956498; x=1777561298;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAQRE7OtQqJHxCIaYW0UVulzAtpXqWFrLC5bRMtblss=;
        b=XqeJiPFojupqujKUfcyhgFuj/4NDgN0zctosHme8EEiKtFzyA8LB0U89CiFJSey8mj
         zkP7qTsaIP/RjlAj047aZGdUEX7f8ZPVZqBEVY5XOyOzgbrqEg0iyVwBxiG1+B1sQg+B
         GDz5BZFGqFP1gTdNcibXXQA6l/fH96CdAW2kCwX90Iwv2V/2qrdbb8YHOEcmD9C/1l2G
         ps75hYOJn8YTMOtj2tAKpV79tmQRYViwbawBb6Jw7dYYzKGprX4aQbpIj9by94IvK5W4
         T/MU0GLBSN+UKNJX95HxQvOR9VXoi9ntz2jzozqqto+O3+Z1XSM9hdRWkadKcL4jO4Ow
         QN8w==
X-Forwarded-Encrypted: i=1; AFNElJ/zyWz5C1qXI5GlMhSdKU9ZF6hk4cr6YlIFa0AfJ7dsHia9I+68rsfDQZhUr6BM8N0hypjg4l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1gDX6TcviwSXsbexII+Y9AUDtijc4YHDgRgLlunDT3jiXgfc
	dssx4EfLAueZSmJnBanaBBYB9sznEquEBkTxFg1UIn5Sja0Wz/GX6LJAhstq4d7AhPSbzMNET2i
	Cp7V/9MiC+ESzlnMKELF5agOuXnoklXAzSj8cDDVuKGvUJ79EMvUMkVGQlPU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90b:3504:b0:35f:b6a1:8d27 with SMTP id
 98e67ed59e1d1-3614046f76amr30409089a91.18.1776956495925; Thu, 23 Apr 2026
 08:01:35 -0700 (PDT)
Date: Thu, 23 Apr 2026 08:01:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ea344f.a00a0220.17a17.0040.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in kernel_sock_shutdown (4)
From: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3e19fa1907a3dfda];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RSPAMD_EMAILBL_FAIL(0.00)[syzkaller.googlegroups.com:query timed out];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280787-lists,netdev=lfdr.de,d8f76778263ab65c2b21];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,googlegroups.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email,goo.gl:url,syzkaller.appspot.com:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	MAILSPIKE_FAIL(0.00)[172.232.135.74:query timed out];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 0FD284540BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    6596a02b2078 Merge tag 'drm-next-2026-04-22' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d5acce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e19fa1907a3dfda
dashboard link: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6596a02b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e78cc4623b5/vmlinux-6596a02b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ae78b19bafa/bzImage-6596a02b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
CPU: 3 UID: 0 PID: 12652 Comm: syz.7.1709 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3785
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 33 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 1a 49 8b 44 24 68 89 ee 48 89 df 5b 5d 41 5c e9 46
RSP: 0018:ffffc9000566f180 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888058587240 RCX: 0000000000000000
RDX: 000000000000000d RSI: ffffffff895ced12 RDI: 0000000000000068
RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed1006d98945
R10: ffff888036cc4a2b R11: 0000003683c25c00 R12: 0000000000000000
R13: ffff88805c998000 R14: 0000000000000002 R15: 0000000000000018
FS:  00007f1306d976c0(0000) GS:ffff8880d65db000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1306d97d58 CR3: 00000000404f1000 CR4: 0000000000352ef0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000002
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:202
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
RIP: 0033:0x7f1305f9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1306d97028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1306216090 RCX: 00007f1305f9c819
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000003
RBP: 00007f1306032c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1306216128 R14: 00007f1306216090 R15: 00007ffd8ecad288
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3785
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 33 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 1a 49 8b 44 24 68 89 ee 48 89 df 5b 5d 41 5c e9 46
RSP: 0018:ffffc9000566f180 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888058587240 RCX: 0000000000000000
RDX: 000000000000000d RSI: ffffffff895ced12 RDI: 0000000000000068
RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed1006d98945
R10: ffff888036cc4a2b R11: 0000003683c25c00 R12: 0000000000000000
R13: ffff88805c998000 R14: 0000000000000002 R15: 0000000000000018
FS:  00007f1306d976c0(0000) GS:ffff8880d64db000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000317000 CR3: 00000000404f1000 CR4: 0000000000352ef0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000002
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	fc                   	cld
   1:	ff                   	lcall  (bad)
   2:	df 48 89             	fisttps -0x77(%rax)
   5:	fa                   	cli
   6:	48 c1 ea 03          	shr    $0x3,%rdx
   a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   e:	75 33                	jne    0x43
  10:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  17:	fc ff df
  1a:	4c 8b 63 20          	mov    0x20(%rbx),%r12
  1e:	49 8d 7c 24 68       	lea    0x68(%r12),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 1a                	jne    0x4a
  30:	49 8b 44 24 68       	mov    0x68(%r12),%rax
  35:	89 ee                	mov    %ebp,%esi
  37:	48 89 df             	mov    %rbx,%rdi
  3a:	5b                   	pop    %rbx
  3b:	5d                   	pop    %rbp
  3c:	41 5c                	pop    %r12
  3e:	e9                   	.byte 0xe9
  3f:	46                   	rex.RX


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

