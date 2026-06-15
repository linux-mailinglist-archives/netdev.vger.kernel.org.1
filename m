Return-Path: <netdev+bounces-299347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rv5wNaqpL2ocEQUAu9opvQ
	(envelope-from <netdev+bounces-299347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:28:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C6D684346
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:28:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299347-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299347-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD3C23003981
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B43F3BE146;
	Mon, 15 Jun 2026 07:28:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FE36655C
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:28:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508520; cv=none; b=qstjrL3ZvHrmaZTCBrmoCIOc6rW+q0OpWzPSYPDwol2FeWJZaDjg0PIaUlz1tQjdsM9A7WhjJK3g9gTHdfQRYdioH6/8bphtWV+PhMz0wbBEJItd71MFLT436aIutemoi9LJiw8t2LNKc8j+m+6ANLuPGHd3HaCBe8vZ1RMxI+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508520; c=relaxed/simple;
	bh=8lpEyypN30gWNikBRixhQnFqfMFEC+3s1f9GVjm67GU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z+QYUYTdotxt4B1jlubO5vqz+7brG2iqVisfBzgygt5zwOXa4HxNRnxpAtolqwEPolWcChieqq3dbGP6Su/ZZTkVyRD6jI2/ngbNZ2Mrn3rNBTVjTqiTIoHHqqr/rucNfpycPQxjyrEVObBO3lUqoHejnET8+6SFbFkVQ8+RWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-69de11bef3dso4380206eaf.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 00:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781508517; x=1782113317;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3z+zv4CdVXSRoO/fwCBnamP3Uf88pmxkrNhNxMB/FU=;
        b=Gq5I8KgKVf9ovBrDUXpZFe878g0hgmUFfM3bi8pdpRKjCNiTDGnTqzKYxJlW8I/4pM
         wEbS4ZoCCnHhAoDlNTqa39MzBFpYX0pvEcklZQj5W0iVnWR59diG7mjSWhNcSv8PLFOa
         An2P2rQAMR/g38d5OSE+5K97nOoTro5ZD2d80FLko7heOetNST301d5fNEBID1JweiQb
         hosBq2Ebr6pL0DDrWlYTvCAGAOvLXq/WhRC897sO9xlStnEGR1aT1s81QJzMORqZfuJH
         PFSF7bFDvhM2kB4QEX8nl4kfjwFUuShhP86IDsro0cLleyWOjygMg1iktm1ZHmhTiNFG
         wmSg==
X-Forwarded-Encrypted: i=1; AFNElJ+zGiXBRYCVyrB9vO57BuvlBj78RLUlcIfKK3CzRAXVwU6MjKHwd41avTd2FimY10hq02665Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVQr9jolih75jh4RIyW676/bELxdNPKYeCQPQp4AjMa+SY5AL
	qR/z9kAIQgJS7mpicFDS1L3XpDaY4Ut/IHexxb9BJobUmfhj0RJEXuip+NUrgJILsJdjUcSrs0H
	rmPXa6LJ8d2pDsQFdX20YI7jb0Pfok3JSHMl0faeUyRbn+8Rx2vN5fKlCJr8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4d0a:b0:69d:c62a:f33d with SMTP id
 006d021491bc7-69edc6e9ffdmr8403761eaf.33.1781508517632; Mon, 15 Jun 2026
 00:28:37 -0700 (PDT)
Date: Mon, 15 Jun 2026 00:28:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2fa9a5.8812e0fc.3c3fa4.0019.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in __ethtool_get_link_ksettings
From: syzbot <syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a0842261b62cdea8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-299347-lists,netdev=lfdr.de,9bb8bd77f3966641f298];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,goo.gl:url,googlegroups.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email,syzkaller.appspotmail.com:from_mime];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70C6D684346

Hello,

syzbot found the following issue on:

HEAD commit:    2319688890d9 geneve: Fix off-by-one comparing with GRO_LEG..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=169064ae580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0842261b62cdea8
dashboard link: https://syzkaller.appspot.com/bug?extid=9bb8bd77f3966641f298
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/51d0476acca3/disk-23196888.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b1b6c54f1f5/vmlinux-23196888.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c69ec4023055/bzImage-23196888.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com

netlink: 'syz.1.3070': attribute type 10 has an invalid length.
netlink: 40 bytes leftover after parsing attributes in process `syz.1.3070'.
============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.1.3070/18201 is trying to acquire lock:
ffff888079ea6e18 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2837 [inline]
ffff888079ea6e18 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff888079ea6e18 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: __ethtool_get_link_ksettings+0x109/0x250 net/ethtool/ioctl.c:463

but task is already holding lock:
ffff888079ea6e18 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2837 [inline]
ffff888079ea6e18 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff888079ea6e18 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: do_setlink+0x3d4/0x4670 net/core/rtnetlink.c:3117
and the lock comparison function returns 0:

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev_instance_lock_key#3);
  lock(&dev_instance_lock_key#3);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.1.3070/18201:
 #0: ffffffff8fdc1540 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8fdc1540 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8fdc1540 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_setlink+0x6a7/0xb20 net/core/rtnetlink.c:3527
 #1: ffff888079ea6e18 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2837 [inline]
 #1: ffff888079ea6e18 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 #1: ffff888079ea6e18 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: do_setlink+0x3d4/0x4670 net/core/rtnetlink.c:3117

stack backtrace:
CPU: 0 UID: 0 PID: 18201 Comm: syz.1.3070 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x24bf/0x2cd0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x19d/0x1590 kernel/locking/mutex.c:820
 netdev_lock include/linux/netdevice.h:2837 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 __ethtool_get_link_ksettings+0x109/0x250 net/ethtool/ioctl.c:463
 __team_port_change_send+0x245/0x560 drivers/net/team/team_core.c:3095
 __team_port_change_check drivers/net/team/team_core.c:3139 [inline]
 team_port_change_check+0x82/0x1d0 drivers/net/team/team_core.c:3160
 team_device_event+0x487/0x570 drivers/net/team/team_core.c:3181
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
 call_netdevice_notifiers net/core/dev.c:2302 [inline]
 __dev_notify_flags+0x1aa/0x310 net/core/dev.c:9791
 netif_change_flags+0xde/0x1b0 net/core/dev.c:9820
 dev_change_flags+0x128/0x260 net/core/dev_api.c:68
 vlan_device_event+0x1b4e/0x1f00 net/8021q/vlan.c:494
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
 call_netdevice_notifiers net/core/dev.c:2302 [inline]
 __dev_notify_flags+0x1aa/0x310 net/core/dev.c:9791
 netif_change_flags+0xde/0x1b0 net/core/dev.c:9820
 do_setlink+0xdd6/0x4670 net/core/rtnetlink.c:3207
 rtnl_setlink+0x77d/0xb20 net/core/rtnetlink.c:3537
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7068
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x9b9/0xa20 net/socket.c:2699
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2753
 __sys_sendmsg net/socket.c:2785 [inline]
 __do_sys_sendmsg net/socket.c:2790 [inline]
 __se_sys_sendmsg net/socket.c:2788 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2788
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f50af59ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50b0467028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f50af815fa0 RCX: 00007f50af59ce59
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007f50af632d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f50af816038 R14: 00007f50af815fa0 R15: 00007ffee67f33e8
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

