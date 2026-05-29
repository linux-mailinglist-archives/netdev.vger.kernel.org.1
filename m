Return-Path: <netdev+bounces-293028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFvbFEhDGWqNuAgAu9opvQ
	(envelope-from <netdev+bounces-293028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:42:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CFB5FEB10
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91E97300909C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD934AB14;
	Fri, 29 May 2026 07:41:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC263AA182
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040511; cv=none; b=nsdUzGiTJ6VdhhRAJiYGK7A6QjcwlILwiu1BVe/R4uB40msZ3sygovGEWWGpiksq91sz8UnpHdI/mJHQ36qMOU0NOj1EO1y1g+iVqUWucgiNezPKiIDVM7J64lkxpIyyiDrwMtIj93I197i7P4vBXsw4AC8pqlFROeDHmUNPoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040511; c=relaxed/simple;
	bh=v8lpAgJb46vLgcg89RxO89NRdtB7MxHrPeaH5wlG62k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WIZlC3iVQ8uoIqnb0cz2Kmew9vx/UA+sm4bstm/fRASsG0FE3Ejpj2fixS43zdraNnWmj7jRTOiHM2HTymJmb+y52B83Q1a9dwB3qmQN6nj0RauMImWNuljED3u1okoXpKufrcmKuMpUMwAJn0DRA2XaY7Q11imyITqpGSbOjnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-69d874805ebso8748870eaf.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 00:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780040509; x=1780645309;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbaUUegfi4a7R/I5V0EItJ9xoA+CDR/TMitNk0PNxus=;
        b=IL3aHR7qZMsD+pCm1/SI3DiC5cjpsRFXghLQOl+g2nX138pa+acimz37pQmYYR5hE6
         Ya/LQJJs4fY61qcAmu4ma1LN1bB1yCmP602q7+NRPUbEMpq3EB6lg6JpyQhutub501SB
         tCl93tmGCO4WIWDuFHflF78AjARgR/71Yh3eVlIChNiQX+n1xDUO+yC0+Cho4P+zzWW6
         FLzYqJw/YNkFG9mQRsKkeKT/Qgb8pusIOw+bNwv1vzFZ2TwtxEodsRlmlz7zLA+Mo9NN
         vRm7MUylhLRobSuHyK4N9MhWt0kJDZD0jK9ak25P+Slnve9vA6pn+iqQ2CxGTlb2zAK2
         nVFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oYpA6rYfNMvJ+9wBmdk/vGplUw+T/p4eLfM2PtcXu55cDeF2qP41I5o7BPemKY6M9mGDjlFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrwi/WsdQSmM9j3f21WbOWOMF7j3vJHAKNsT4RSo0zi6StrR5h
	Kk+hlERmTWTMrfUEQ2xUX+MnFiB7VzxW7a7XrGQmkm8tRto2/SrCJFp2hMJfG++a2WvDukJQsmo
	U9gzDWBDquyR3l3T8xUdQlQ3nyCe+sy6g9xsxnmRs9gkvZjWkDjrk6MjLuNQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1b15:b0:69d:6ce6:7437 with SMTP id
 006d021491bc7-69e03f1ee3emr1080162eaf.19.1780040508819; Fri, 29 May 2026
 00:41:48 -0700 (PDT)
Date: Fri, 29 May 2026 00:41:48 -0700
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a19433c.5099cdd9.8e407.0000.GAE@google.com>
Subject: [syzbot ci] Re: net: ethtool: let ops locked drivers run without rtnl_lock
From: syzbot ci <syzbot+ci7bc98d66cbeccac1@syzkaller.appspotmail.com>
To: andrew@lunn.ch, danieller@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, ernis@linux.microsoft.com, haiyangz@microsoft.com, 
	horms@kernel.org, idosch@nvidia.com, joshwash@google.com, 
	kory.maincent@bootlin.com, kuba@kernel.org, linux@armlinux.org.uk, 
	maxime.chevallier@bootlin.com, michael.chan@broadcom.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf.kernel@gmail.com, 
	tariqt@nvidia.com, willemb@google.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-293028-lists,netdev=lfdr.de,ci7bc98d66cbeccac1];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,nvidia.com,davemloft.net,google.com,linux.microsoft.com,microsoft.com,kernel.org,bootlin.com,armlinux.org.uk,broadcom.com,vger.kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F1CFB5FEB10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot ci has tested the following series

[v1] net: ethtool: let ops locked drivers run without rtnl_lock
https://lore.kernel.org/all/20260528231637.251822-1-kuba@kernel.org
* [PATCH net-next 01/14] net: ethtool: cmis_cdb: hold instance lock for ops locked devices
* [PATCH net-next 02/14] net: ethtool: make sure __ethtool_get_link_ksettings() is ops-locked
* [PATCH net-next 03/14] net: ethtool: serialize broadcast notification sequence allocation
* [PATCH net-next 04/14] net: ethtool: relax ethnl_req_get_phydev() locking assertion
* [PATCH net-next 05/14] net: ethtool: make dev->hwprov ops-protected
* [PATCH net-next 06/14] net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops
* [PATCH net-next 07/14] net: ethtool: optionally skip rtnl_lock on Netlink path for SET ops
* [PATCH net-next 08/14] net: ethtool: optionally skip rtnl_lock in cable test handlers
* [PATCH net-next 09/14] net: ethtool: optionally skip rtnl_lock in ethnl_tsinfo_dumpit()
* [PATCH net-next 10/14] net: ethtool: optionally skip rtnl_lock in ethnl_act_module_fw_flash()
* [PATCH net-next 11/14] net: ethtool: optionally skip rtnl_lock in RSS context handlers
* [PATCH net-next 12/14] net: ethtool: ioctl: concentrate the locking
* [PATCH net-next 13/14] net: ethtool: optionally skip rtnl_lock on IOCTL path
* [PATCH net-next 14/14] docs: net: ethtool: document ops-locked drivers and op_needs_rtnl

and found the following issue:
possible deadlock in __ethtool_get_link_ksettings

Full report is available here:
https://ci.syzbot.org/series/ada8852f-9efd-4b85-87aa-2f5d8fe16040

***

possible deadlock in __ethtool_get_link_ksettings

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      9a82e387e27a4422a0d2d9d644180b7bd913e85a
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/2968208d-6483-4d38-be45-de68d3b94775/config
syz repro: https://ci.syzbot.org/findings/d8670aa1-9241-49be-8108-cdbed56dd4a5/syz_repro

dummy0: entered promiscuous mode
bridge0: port 3(dummy0) entered blocking state
bridge0: port 3(dummy0) entered forwarding state
============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.1.28/5852 is trying to acquire lock:
ffff888115f78dc8 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2833 [inline]
ffff888115f78dc8 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff888115f78dc8 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: __ethtool_get_link_ksettings+0x12b/0x290 net/ethtool/ioctl.c:462

but task is already holding lock:
ffff888115f78dc8 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2833 [inline]
ffff888115f78dc8 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff888115f78dc8 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: do_setlink+0x3d2/0x45a0 net/core/rtnetlink.c:3117
and the lock comparison function returns 0:

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev_instance_lock_key#3);
  lock(&dev_instance_lock_key#3);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.1.28/5852:
 #0: ffffffff8fdd2d80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8fdd2d80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8fdd2d80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_setlink+0x6bb/0xb40 net/core/rtnetlink.c:3527
 #1: ffff888115f78dc8 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2833 [inline]
 #1: ffff888115f78dc8 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 #1: ffff888115f78dc8 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: do_setlink+0x3d2/0x45a0 net/core/rtnetlink.c:3117

stack backtrace:
CPU: 0 UID: 0 PID: 5852 Comm: syz.1.28 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
 netdev_lock include/linux/netdevice.h:2833 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 __ethtool_get_link_ksettings+0x12b/0x290 net/ethtool/ioctl.c:462
 port_cost+0xc0/0x3a0 net/bridge/br_if.c:39
 br_port_carrier_check+0x12d/0x3f0 net/bridge/br_if.c:80
 br_device_event+0x65c/0x970 net/bridge/br.c:101
 notifier_call_chain+0x1ad/0x3d0 kernel/notifier.c:85
 __dev_notify_flags+0x248/0x310 net/core/dev.c:9804
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9819
 do_setlink+0xfa5/0x45a0 net/core/rtnetlink.c:3207
 rtnl_setlink+0x792/0xb40 net/core/rtnetlink.c:3537
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:7062
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f087ad9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f087bc25028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f087b015fa0 RCX: 00007f087ad9ce59
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000000004
RBP: 00007f087ae32d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f087b016038 R14: 00007f087b015fa0 R15: 00007ffcefdf0348
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

