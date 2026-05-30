Return-Path: <netdev+bounces-293310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAufICuGGmrN5AgAu9opvQ
	(envelope-from <netdev+bounces-293310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 08:39:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8708860B769
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 08:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E0A83021670
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B0937CD33;
	Sat, 30 May 2026 06:39:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99DF37CD30
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780123170; cv=none; b=DSOQfQpUTZ2Lw/eQ1vA9gYnsZ7mfCCpekLcKaMf9AGeYpZELOmvo7tbrWNeJyQMtuzLWM3ih+i7tyK8QL5JBCEH0S69IkRYBDfn+CyGiPe5sBzzhoHRMo85+ZNC8rZvP73OPJei2aUgH4FVnV8M23qUm2nHSkvwkGApjGti/ZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780123170; c=relaxed/simple;
	bh=syTcwifVYKHymnjmk+HLWfK3MgN68nevTT6x7bKVS9w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j02shAulzC7LmpZuXCdiOV86klp01G43ELo56pJ/3/SusQSPuldC+xHs56+FyM9MwNBJQsAnVCzrD/sqeJm8bIffKt7cbHCxmbZU1BpP9L+MNu1afVs7HB7+rnKgJdWV0Kdwm+DImXVu7XuGNnvyA8ijW3P3KwzButhYTaJk4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7dcd7302f00so3578534a34.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 23:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780123166; x=1780727966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JAKFsRo+eBSAOxTVyhrdDzSE7ZqUOrRDxhcBURVJ8Xg=;
        b=GuU5enNLWGTNGBmxy4TF8zU/anWnuuJF/5JZK3B3PtbVyrlpplw27a3NRYvPkG4wd9
         sjEdHCjKcpH3pdH+wc1zf7/danDRy6dUJbRAkr/rBvWDc3yCChUpLKbjniKCZ3Rp8ojs
         by1ngOVcGslPcDRiU9ILC7yZk2ocBT0VSwr90o1ZRrD+Ngli4T1QGVOsswYcz3Ff+EBy
         4wzWNI8co/10Rn2gxRg6loksmOvYxvhHaB7eNSL2cD/EaDqacH6k67JhlvxgZIOI/J8+
         J7r2hLl2mcru+YHaK2CHN7H5mVMnMgXdYEePDznF3krDPwM263uPAsZ/OK684qDyz1p7
         27Tw==
X-Forwarded-Encrypted: i=1; AFNElJ8VROUewzcHYatTxmgWSIz5C7v6IK6oj4EjcK+QIMRXHXejynRcYpOUXjpJ2ZYe5ULU55QWCPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztiM3p3mSa7ATOpiFtGPJFrVKsLbEDDQZqhWu2HK1wusBwZo5m
	fUDOXzbWUNplXnFQQfzrurzFZbYYKueeML75x+axSVfwgybOcN95FUS5sBtSBw75LUIo7BoP7Ak
	zS4q+MGN64Je2dfIXEQlO3fmodTo4W6fLqGmfKJ7sjpYr1yAbWw2um9rTSdk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:20b:b0:69d:e459:2d98 with SMTP id
 006d021491bc7-69e103d475fmr1137621eaf.46.1780123166575; Fri, 29 May 2026
 23:39:26 -0700 (PDT)
Date: Fri, 29 May 2026 23:39:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1a861e.b111c304.35cd64.0016.GAE@google.com>
Subject: [syzbot] [net?] WARNING in hsr_addr_is_self
From: syzbot <syzbot+652670cf249077eb498b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f2e8ebfec4636d32];
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
	TAGGED_FROM(0.00)[bounces-293310-lists,netdev=lfdr.de,652670cf249077eb498b];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,syzkaller.appspot.com:url,storage.googleapis.com:url,goo.gl:url]
X-Rspamd-Queue-Id: 8708860B769
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    1d5dcaa3bd65 Merge tag 'probes-fixes-v7.1-rc3' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119dae36580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2e8ebfec4636d32
dashboard link: https://syzkaller.appspot.com/bug?extid=652670cf249077eb498b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5b889cdb98bd/disk-1d5dcaa3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8953fddf953a/vmlinux-1d5dcaa3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d6e5ef98b3f1/bzImage-1d5dcaa3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+652670cf249077eb498b@syzkaller.appspotmail.com

------------[ cut here ]------------
HSR: No self node
WARNING: net/hsr/hsr_framereg.c:39 at hsr_addr_is_self+0x211/0x3f0 net/hsr/hsr_framereg.c:39, CPU#0: syz.4.16848/17220
Modules linked in:
CPU: 0 UID: 0 PID: 17220 Comm: syz.4.16848 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:hsr_addr_is_self+0x211/0x3f0 net/hsr/hsr_framereg.c:39
Code: 33 2f 41 0f b7 dd 89 ee 09 de 31 ff e8 c8 b4 c6 f6 09 dd 74 54 e8 0f b0 c6 f6 31 ed eb 53 e8 06 b0 c6 f6 48 8d 3d 2f 50 9c 04 <67> 48 0f b9 3a 31 ed eb 42 e8 c1 13 1f 00 89 c5 31 ff 89 c6 e8 96
RSP: 0018:ffffc900041c70e0 EFLAGS: 00010283
RAX: ffffffff8afdc6ca RBX: ffffffff8afdc4e6 RCX: 0000000000080000
RDX: ffffc90010493000 RSI: 0000000000000948 RDI: ffffffff8f9a1700
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc900041c71e8 R11: fffff52000838e3f R12: dffffc0000000000
R13: ffff888041f9e3c0 R14: ffff888086ee3802 R15: 0000000000000000
FS:  00007f6fe985d6c0(0000) GS:ffff888126176000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f80bd437dac CR3: 0000000025096000 CR4: 00000000003526f0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000002
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 check_local_dest net/hsr/hsr_forward.c:592 [inline]
 fill_frame_info net/hsr/hsr_forward.c:728 [inline]
 hsr_forward_skb+0xa11/0x2a80 net/hsr/hsr_forward.c:739
 hsr_dev_xmit+0x253/0x370 net/hsr/hsr_device.c:236
 __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
 netdev_start_xmit include/linux/netdevice.h:5377 [inline]
 xmit_one net/core/dev.c:3888 [inline]
 dev_hard_start_xmit+0x2df/0x860 net/core/dev.c:3904
 __dev_queue_xmit+0x1428/0x3900 net/core/dev.c:4870
 neigh_output include/net/neighbour.h:556 [inline]
 ip_finish_output2+0xcec/0x10b0 net/ipv4/ip_output.c:237
 ip_send_skb net/ipv4/ip_output.c:1510 [inline]
 ip_push_pending_frames+0x8b/0x110 net/ipv4/ip_output.c:1530
 raw_sendmsg+0x1547/0x1a50 net/ipv4/raw.c:659
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x7da/0x9c0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x1c3/0x2a0 net/socket.c:2787
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6feb62ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6fe985d028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f6feb8a6090 RCX: 00007f6feb62ce59
RDX: 0000000000000000 RSI: 0000200000000000 RDI: 0000000000000004
RBP: 00007f6feb6c2d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6feb8a6128 R14: 00007f6feb8a6090 R15: 00007ffcf01cc488
 </TASK>
----------------
Code disassembly (best guess):
   0:	33 2f                	xor    (%rdi),%ebp
   2:	41 0f b7 dd          	movzwl %r13w,%ebx
   6:	89 ee                	mov    %ebp,%esi
   8:	09 de                	or     %ebx,%esi
   a:	31 ff                	xor    %edi,%edi
   c:	e8 c8 b4 c6 f6       	call   0xf6c6b4d9
  11:	09 dd                	or     %ebx,%ebp
  13:	74 54                	je     0x69
  15:	e8 0f b0 c6 f6       	call   0xf6c6b029
  1a:	31 ed                	xor    %ebp,%ebp
  1c:	eb 53                	jmp    0x71
  1e:	e8 06 b0 c6 f6       	call   0xf6c6b029
  23:	48 8d 3d 2f 50 9c 04 	lea    0x49c502f(%rip),%rdi        # 0x49c5059
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	31 ed                	xor    %ebp,%ebp
  31:	eb 42                	jmp    0x75
  33:	e8 c1 13 1f 00       	call   0x1f13f9
  38:	89 c5                	mov    %eax,%ebp
  3a:	31 ff                	xor    %edi,%edi
  3c:	89 c6                	mov    %eax,%esi
  3e:	e8                   	.byte 0xe8
  3f:	96                   	xchg   %eax,%esi


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

