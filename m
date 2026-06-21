Return-Path: <netdev+bounces-300884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QUwcF7MBOGoZXAcAu9opvQ
	(envelope-from <netdev+bounces-300884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 17:22:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BE86AB2B6
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 17:22:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300884-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300884-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 525093002B38
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB1E24677B;
	Sun, 21 Jun 2026 15:22:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17581A681B
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 15:22:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782055344; cv=none; b=u9fMnaRfU8boLB3GvcfD8THtMBfcsx4uEhn1W/AP3RjP8ZYbdEcwOu6rD6NClUFKcDnQ6rk7eV0yNWyvsba6MMrRnms00dqwgKfhdWxTbRkpoS9qtEelEc8hhqqaZdGLg//rNwQrmYylaHy5r/Ha8or+xXQ7nSWJJVzmwaNRMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782055344; c=relaxed/simple;
	bh=D2OmoX80EYpVzzXyMB72P0LcdjZpUs2n/dCeYvAiXF4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AHLYSTpA3LhPVtodbne7KKB+dtE9dGSBHNUc6nMFyYGnxmlUj13pDp1v/vsTA3YbtGlRzIW05g2kb5NTRJW3PInhOAOgxMSAmilxvk/Ju3eDrCVrOkhj4i8T60AWiHiASImsq0rjj3kd5ri/iVnUqKwRm14yFtv+68abFYnPiPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-486e64c8edeso5086252b6e.2
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 08:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782055342; x=1782660142;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OP66+xdliyDeoTsReAwv3VQOuWo7JhOPBGVl6ta4HM=;
        b=IO/I13nXeYJXR2JTj5dPcel/vZjjnT5meA9ShL9QXhSv9wrf5TjFhuOD0H5f6pMJik
         l91fka2fHc1AsZkW4KJdkfwqOp70yzwQAdkaA7KGx714HzP9u2qaprBcyFj6hqwsKtt8
         clZcyt86LSwEz6dhJqUaTGZxBsTEo9vSHIhAG7yrtZDT+k9h0/ZmUUjtysfGbH4gLy9M
         GDJLmcP5MFuP6M/u2iE/LB5EeFPvqJcOnBMeHZMQ+gGf8YwnrjjS6SeXEuo2/TDXuMEJ
         6tJEzj9uOm46TVXbflIi+1Z9Wo9Fhz6MBqfQm2xD8gLdgg0dA+8KSS/1xWyq0W8kDObR
         U81Q==
X-Forwarded-Encrypted: i=1; AFNElJ+2n5PV605qIG+nveYl5uy2W0U2gkNQUsiMXZf3dWSqjDy9O6RrmhLl0i6y8HLgkuBtvSWdids=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvUxWXzOGBJPBZ2ogyBy1RyolW3oYDVEzI2YaSty9crTxmAL38
	7GJ6aJgsUwl5MG6hhGciip86je8ZVU1wWEmdfEs8oUL/L2QayhjF1BMxX0sUYdqAHVkAHQpGxto
	2T6XLhGwFrovqU4ql+BaGY12cPk/cpfKkMlutiQNG3jyxDTv2y97Mffz2RMc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1795:b0:487:5d0c:67e4 with SMTP id
 5614622812f47-489ab88ced3mr8804122b6e.0.1782055341741; Sun, 21 Jun 2026
 08:22:21 -0700 (PDT)
Date: Sun, 21 Jun 2026 08:22:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3801ad.713c5d62.148f7.0007.GAE@google.com>
Subject: [syzbot] [net?] WARNING in __ethtool_get_link_ksettings
From: syzbot <syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6c414e1864e61ef6];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300884-lists,netdev=lfdr.de,09da62a8b78959ceb8bb];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,goo.gl:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8BE86AB2B6

Hello,

syzbot found the following issue on:

HEAD commit:    4fa3f5fabb30 Add linux-next specific files for 20260616
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1039ffec580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c414e1864e61ef6
dashboard link: https://syzkaller.appspot.com/bug?extid=09da62a8b78959ceb8bb
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf5b803a695d/disk-4fa3f5fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47871e7c589e/vmlinux-4fa3f5fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53cd9ef32a2b/bzImage-4fa3f5fa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com

netlink: 'syz.3.4736': attribute type 10 has an invalid length.
------------[ cut here ]------------
rtmutex deadlock detected
WARNING: kernel/locking/rtmutex.c:1698 at rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:1698, CPU#0: syz.3.4736/19861
Modules linked in:
CPU: 0 UID: 0 PID: 19861 Comm: syz.3.4736 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:1698
Code: 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 85 81 00 00 00 48 89 f7 e8 16 40 01 00 48 8d 3d 3f 2f 5d 04 <67> 48 0f b9 3a 4c 8d 3d 00 00 00 00 65 48 8b 1d 13 2d 42 07 4c 8d
RSP: 0018:ffffc90003d760f0 EFLAGS: 00010286
RAX: 0000000080000000 RBX: 00000000ffffffdd RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8baa3a60 RDI: ffffffff8f8fd220
RBP: ffffc90003d762a0 R08: ffffffff8f8c5ff7 R09: 1ffffffff1f18bfe
R10: dffffc0000000000 R11: fffffbfff1f18bff R12: 1ffff920007aec2c
R13: ffffffff8b329d22 R14: ffff88805dbb1008 R15: dffffc0000000000
FS:  00007fd5506ae6c0(0000) GS:ffff888125ed3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000003cd08000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1760 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1787 [inline]
 rt_mutex_slowlock+0x73c/0x780 kernel/locking/rtmutex.c:1827
 __rt_mutex_lock kernel/locking/rtmutex.c:1842 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 netdev_lock include/linux/netdevice.h:2846 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 __ethtool_get_link_ksettings+0x109/0x250 net/ethtool/ioctl.c:463
 bond_update_speed_duplex drivers/net/bonding/bond_main.c:801 [inline]
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3982 [inline]
 bond_netdev_event+0x643/0xf80 drivers/net/bonding/bond_main.c:4089
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2289 [inline]
 call_netdevice_notifiers net/core/dev.c:2303 [inline]
 __dev_notify_flags+0x1aa/0x310 net/core/dev.c:9792
 netif_change_flags+0xde/0x1b0 net/core/dev.c:9821
 dev_change_flags+0x128/0x260 net/core/dev_api.c:68
 vlan_device_event+0x1b4e/0x1f00 net/8021q/vlan.c:494
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2289 [inline]
 call_netdevice_notifiers net/core/dev.c:2303 [inline]
 netif_open+0x10f/0x190 net/core/dev.c:1730
 dev_open+0x101/0x220 net/core/dev_api.c:202
 bond_enslave+0xeb2/0x3b70 drivers/net/bonding/bond_main.c:2089
 do_set_master+0x563/0x720 net/core/rtnetlink.c:3012
 do_setlink+0xe7b/0x4670 net/core/rtnetlink.c:3214
 rtnl_changelink net/core/rtnetlink.c:3841 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4014 [inline]
 rtnl_newlink+0x15c2/0x1bd0 net/core/rtnetlink.c:4151
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7068
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:785
 __sock_sendmsg net/socket.c:800 [inline]
 ____sys_sendmsg+0x565/0x870 net/socket.c:2702
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2756
 __sys_sendmsg net/socket.c:2788 [inline]
 __do_sys_sendmsg net/socket.c:2793 [inline]
 __se_sys_sendmsg net/socket.c:2791 [inline]
 __x64_sys_sendmsg+0x1b7/0x290 net/socket.c:2791
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd55245ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd5506ae028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fd5526d5fa0 RCX: 00007fd55245ce59
RDX: 0000000000008084 RSI: 0000200000000600 RDI: 0000000000000003
RBP: 00007fd5524f2d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd5526d6038 R14: 00007fd5526d5fa0 R15: 00007ffdbadd34a8
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	41 57                	push   %r15
   b:	41 56                	push   %r14
   d:	41 55                	push   %r13
   f:	41 54                	push   %r12
  11:	53                   	push   %rbx
  12:	83 ff dd             	cmp    $0xffffffdd,%edi
  15:	0f 85 81 00 00 00    	jne    0x9c
  1b:	48 89 f7             	mov    %rsi,%rdi
  1e:	e8 16 40 01 00       	call   0x14039
  23:	48 8d 3d 3f 2f 5d 04 	lea    0x45d2f3f(%rip),%rdi        # 0x45d2f69
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	4c 8d 3d 00 00 00 00 	lea    0x0(%rip),%r15        # 0x36
  36:	65 48 8b 1d 13 2d 42 	mov    %gs:0x7422d13(%rip),%rbx        # 0x7422d51
  3d:	07
  3e:	4c                   	rex.WR
  3f:	8d                   	.byte 0x8d


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

