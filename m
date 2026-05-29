Return-Path: <netdev+bounces-293276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPa3IHkNGmos1AgAu9opvQ
	(envelope-from <netdev+bounces-293276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 00:04:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8551609254
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 00:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4D230459F4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB23B584F;
	Fri, 29 May 2026 22:03:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D273A7843
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780092211; cv=none; b=cvR6eTmtHCoCBDSl5CzGcjJDhoXkmm6/YNIXTFxa83dxiqYFH4Hsuo+QoIsIfd+krQ2inrVnjU1PvtaSL4dF2q4pm1v33l0lsL4sd7NOgALwhb7uCirn7GzOZFrsY6gw4VOi4oFuxAciP4Y5t8VRk7jjURnuwWDsn1goYuYwQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780092211; c=relaxed/simple;
	bh=WBh84XvDFCDTp0jtOC8GoKOBGcG6wnkhv2ySk+w/k1Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uXIV150VRYrOarWEMWez2DYgqUnzTZaUNXAJ4WfVhTh/Dj9ITaZ4t2a6RQ7pfuqrwQRAjKa0hvO2fnq9crg2Z51ACVNwUXXlNHLwxpdyx1kKpjT0vQqg5cuHfjMIwVO8eKTmU0bQsBuJA+GaSXNMG+ZUZpjuI5Utw+S0ZC9PyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-69d941fbbe1so7158559eaf.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 15:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780092209; x=1780697009;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nle5VR30MGwzjCS7xNPIw56/zDSpD+G661c/PI8W4E=;
        b=Egn2h3FgkhlWypT/u7vPemJILDvB2F3a3wWIJ1DhEV50w6PhMmT/2tnJOx3qiHpb0V
         pf5GCc76F89xcFLj2Xx6dtZ2856X7b3ogNlr5zyvH2t6PFwJt56MQI7BHUnUV09vNBNW
         oo6n8crorQ9W79+9T7DeagzbZv98cgJ48hlwJEQlU1KlAI1Kj2/QvNHghYuOhhMfZzVM
         I9Q0eDetP201e6VPeJKXWKI9NtD2WRGQv2CKP0kW5Mx9aq/qD0FUr2ULcSffX8mFh5zQ
         QRMrOrjSepSCGMaW9VQQv59HW5f6xWwOEFqxltip0di9RjsZ0yCwbHQ+INpYbxRGjhUR
         BzDg==
X-Forwarded-Encrypted: i=1; AFNElJ8/JdeboF1dxfwRA1OkrD3tipjtz0l52FS6JMY+D61GvxR1JlyrC6gngufYnhnBcDF0aZreJP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6JoGI4JK7Y0ncf4ysPr/slpLztrgECdvBgBDWiWTW9ifadFyQ
	cTQD3aMUPQ1y6qU2LAs/miGIne/s/wiYKxZnQfElt6tLL+F74nkQFxfC2oAq77vB40qK1BzZbNt
	UaQd65aD99QGM727FR36ERgEbQTmR0nmtbg1r06SmN378TVaMk+TlYxWNxto=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2906:b0:69e:b8:ffe7 with SMTP id
 006d021491bc7-69e105ca1e7mr640156eaf.58.1780092208851; Fri, 29 May 2026
 15:03:28 -0700 (PDT)
Date: Fri, 29 May 2026 15:03:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1a0d30.0a9e871e.332604.0009.GAE@google.com>
Subject: [syzbot] [net?] BUG: sleeping function called from invalid context in netif_rx_mode_run
From: syzbot <syzbot+b54df935b5872a351231@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a834c6344141a58b];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-293276-lists,netdev=lfdr.de,b54df935b5872a351231];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,storage.googleapis.com:url,goo.gl:url]
X-Rspamd-Queue-Id: C8551609254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    4b4362973b6f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14a4c62e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a834c6344141a58b
dashboard link: https://syzkaller.appspot.com/bug?extid=b54df935b5872a351231
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f69f86c90ee5/disk-4b436297.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79fa7b33aaab/vmlinux-4b436297.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef080156d0de/Image-4b436297.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b54df935b5872a351231@syzkaller.appspotmail.com

netlink: 28 bytes leftover after parsing attributes in process `syz.8.1045'.
vlan2: left promiscuous mode
geneve0: left promiscuous mode
BUG: sleeping function called from invalid context at net/core/dev_addr_lists.c:1262
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 13679, name: syz.8.1045
preempt_count: 201, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz.8.1045/13679:
 #0: ffff800089b97600 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffff800089b97600 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock+0x38/0x10c net/core/rtnetlink.c:341
 #1: ffff0000d6170e58 (&br->lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:348 [inline]
 #1: ffff0000d6170e58 (&br->lock){+.-.}-{3:3}, at: br_port_slave_changelink+0x40/0x15c net/bridge/br_netlink.c:1212
Preemption disabled at:
[<ffff8000857ffa50>] spin_lock_bh include/linux/spinlock.h:348 [inline]
[<ffff8000857ffa50>] br_port_slave_changelink+0x40/0x15c net/bridge/br_netlink.c:1212
CPU: 0 UID: 0 PID: 13679 Comm: syz.8.1045 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 __might_resched+0x350/0x4ac kernel/sched/core.c:9163
 __might_sleep+0x84/0xdc kernel/sched/core.c:9092
 netif_rx_mode_run+0x124/0xb64 net/core/dev_addr_lists.c:1262
 netif_rx_mode_sync+0x2c/0xbc net/core/dev_addr_lists.c:1428
 dev_set_promiscuity+0x110/0x1fc net/core/dev_api.c:289
 br_port_clear_promisc net/bridge/br_if.c:135 [inline]
 br_manage_promisc+0x2c0/0x33c net/bridge/br_if.c:172
 nbp_update_port_count+0xf8/0x148 net/bridge/br_if.c:242
 br_port_flags_change+0x60/0xa8 net/bridge/br_if.c:747
 br_setport+0xac4/0x1230 net/bridge/br_netlink.c:1000
 br_port_slave_changelink+0x134/0x15c net/bridge/br_netlink.c:1213
 rtnl_changelink net/core/rtnetlink.c:3793 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3973 [inline]
 rtnl_newlink+0xf80/0x113c net/core/rtnetlink.c:4110
 rtnetlink_rcv_msg+0x66c/0x9c8 net/core/rtnetlink.c:6996
 netlink_rcv_skb+0x22c/0x410 net/netlink/af_netlink.c:2550
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:7023
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x610/0x800 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x63c/0x920 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg+0xc8/0x138 net/socket.c:802
 ____sys_sendmsg+0x418/0x70c net/socket.c:2698
 ___sys_sendmsg+0x198/0x224 net/socket.c:2752
 __sys_sendmsg+0x160/0x214 net/socket.c:2784
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2787
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:740
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:759
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
geneve0: entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state


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

