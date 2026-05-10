Return-Path: <netdev+bounces-286383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEdvHaLYAGr5NQEAu9opvQ
	(envelope-from <netdev+bounces-286383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:12:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E13505EAC
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D47E300914A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125843290D8;
	Sun, 10 May 2026 19:12:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590031F9B4
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778440352; cv=none; b=FF2QVZPBv3N+q0+4OLb+aFFLTTFgooNU6GDSHAzLMY1vk93RbPNujzVvofhogkdDhp8+tX75RNJsEXDTRED46D/6k1BLDDydwE1s8Bm2hPGSmcJCU06rd1P7oNcqoJJb1mu2R2kklydertbPmI3FCNL2oH3IhsZySQrShS4GD7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778440352; c=relaxed/simple;
	bh=Bx+0pNy2Ty+hWNVPYsnY25MQJFZtyKgAPYo0ofZODIs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EbbvUH63uqHPgqsYeqcg+PKeEcCPgefR8arDC4POoi0LrnfLM0v4PRBi5gkY5Pi+A0Thq4PFndAWg3GWmdeYz0VX9E0+W79ANOFCHF5thKrVg4xOfycnaGt09rJWUUjmFwtmVNhs3XqmP+yOrHThjiZvfGQQYj02QJhnEQDr+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6961e8fa90bso6667411eaf.0
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 12:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778440349; x=1779045149;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gfa66knEcvo+E9up4DP46rmyT4IG3waBhwfz7wnWg6w=;
        b=DC4EH+MAwem/vGKTlFeSUH4RI92kV2ll3MppZHuENyhXJCZjlcbwGbeduwjyV32pr9
         CD4Oc2++Y1Yh+6wwzqSmmr2nP8ohPxWlCynPeqe/f/9rXxQ9Eb4XPmqqQZlAgrtknPWX
         ourN+Blo1Ff+2YJESQ1ILHhqXVlGGRFTu8VTBm7rfVX17DfXxNS6CaLcEp0OEmvyzZkZ
         B0IvT3vyduxoE4UzJ5Fck0+8KwjPCOwZZ0QiLL/YoqQPMNzUSQWxawk0cdebR3kTpG5q
         khVqaS0IUYbhu0G1sfywD/JoXNAAHF0R7SVowGEcpQ650K9rzvoT2QKzj1b9THk8l+Mo
         Pi4A==
X-Forwarded-Encrypted: i=1; AFNElJ/3ELHRDlj6U2zUwSLkFEaI1uBBzJdaB5vU2c/HpA2KR7ZvQVO/CwAZLjEkhYpJYENSVwnsCWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuXS1Oh44HGVndRPQtvT1RgYc9xQVy7KZnu2IrBbf4z7+elTEF
	QhcKLDveVhDNQbn9MkISg1u6vS+HoqsyB+/jbQEcIBffyShwMdtsqhrFze74H8brczheqBsAsWZ
	0RmgKBLIQh20+2GDB7GJqFUXEw1d4ZH9hYUKTWdey7vpwLwJZKnloF3JAWZU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ec49:0:b0:694:a37c:4e84 with SMTP id
 006d021491bc7-69998cd7cbbmr11211100eaf.27.1778440349305; Sun, 10 May 2026
 12:12:29 -0700 (PDT)
Date: Sun, 10 May 2026 12:12:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a00d89d.170a0220.1c0296.0217.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in sch_direct_xmit (6)
From: syzbot <syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C3E13505EAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0];
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
	TAGGED_FROM(0.00)[bounces-286383-lists,netdev=lfdr.de,9bda1b9fbb7fbdf9b62b];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,storage.googleapis.com:url,appspotmail.com:email,goo.gl:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    70390501d194 Merge tag 'x86-urgent-2026-05-09' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14367b26580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b59e732db8bb/disk-70390501.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a24c73fee07/vmlinux-70390501.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b831aa6e43b0/bzImage-70390501.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com

erspan1: entered allmulticast mode
bond30: (slave erspan1): making interface the new active one
erspan1: entered promiscuous mode
============================================
WARNING: possible recursive locking detected
syzkaller #0 Tainted: G             L     
--------------------------------------------
syz.5.14453/13056 is trying to acquire lock:
ffff88806da6ed58 (&qdisc_xmit_lock_key#4){+.-.}-{3:3}, at: spin_lock include/linux/spinlock.h:342 [inline]
ffff88806da6ed58 (&qdisc_xmit_lock_key#4){+.-.}-{3:3}, at: __netif_tx_lock include/linux/netdevice.h:4781 [inline]
ffff88806da6ed58 (&qdisc_xmit_lock_key#4){+.-.}-{3:3}, at: sch_direct_xmit+0x15f/0x4c0 net/sched/sch_generic.c:370

but task is already holding lock:
ffff8880518f1158 (&qdisc_xmit_lock_key#4){+.-.}-{3:3}, at: spin_lock include/linux/spinlock.h:342 [inline]
ffff8880518f1158 (&qdisc_xmit_lock_key#4){+.-.}-{3:3}, at: __netif_tx_lock include/linux/netdevice.h:4781 [inline]
ffff8880518f1158 (&qdisc_xmit_lock_key#4){+.-.}-{3:3}, at: sch_direct_xmit+0x15f/0x4c0 net/sched/sch_generic.c:370

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&qdisc_xmit_lock_key#4);
  lock(&qdisc_xmit_lock_key#4);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

10 locks held by syz.5.14453/13056:
 #0: ffffffff90326358 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff90326358 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff90326358 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8fdcfe80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8fdcfe80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8fdcfe80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x883/0x1bb0 net/core/rtnetlink.c:4109
 #2: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #2: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: rcu_read_lock_bh include/linux/rcupdate.h:891 [inline]
 #2: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x2b6/0x3950 net/core/dev.c:4791
 #3: ffff888076850228 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#5){+...}-{3:3}, at: spin_trylock include/linux/spinlock.h:354 [inline]
 #3: ffff888076850228 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#5){+...}-{3:3}, at: qdisc_run_begin include/net/sch_generic.h:205 [inline]
 #3: ffff888076850228 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#5){+...}-{3:3}, at: __dev_xmit_skb net/core/dev.c:4196 [inline]
 #3: ffff888076850228 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#5){+...}-{3:3}, at: __dev_queue_xmit+0x11a6/0x3950 net/core/dev.c:4831
 #4: ffff8880518f1158 (&qdisc_xmit_lock_key#4){+.-.}-{3:3}, at: spin_lock include/linux/spinlock.h:342 [inline]
 #4: ffff8880518f1158 (&qdisc_xmit_lock_key#4){+.-.}-{3:3}, at: __netif_tx_lock include/linux/netdevice.h:4781 [inline]
 #4: ffff8880518f1158 (&qdisc_xmit_lock_key#4){+.-.}-{3:3}, at: sch_direct_xmit+0x15f/0x4c0 net/sched/sch_generic.c:370
 #5: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #5: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: ip_output+0x5b/0x450 net/ipv4/ip_output.c:433
 #6: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #6: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #6: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: ip_finish_output2+0x3c2/0x1070 net/ipv4/ip_output.c:230
 #7: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #7: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: arp_xmit+0x23/0x270 net/ipv4/arp.c:663
 #8: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #8: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: rcu_read_lock_bh include/linux/rcupdate.h:891 [inline]
 #8: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x2b6/0x3950 net/core/dev.c:4791
 #9: ffff888052941228 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#5){+...}-{3:3}, at: spin_trylock include/linux/spinlock.h:354 [inline]
 #9: ffff888052941228 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#5){+...}-{3:3}, at: qdisc_run_begin include/net/sch_generic.h:205 [inline]
 #9: ffff888052941228 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#5){+...}-{3:3}, at: __dev_xmit_skb net/core/dev.c:4196 [inline]
 #9: ffff888052941228 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#5){+...}-{3:3}, at: __dev_queue_xmit+0x11a6/0x3950 net/core/dev.c:4831

stack backtrace:
CPU: 0 UID: 0 PID: 13056 Comm: syz.5.14453 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:158
 spin_lock include/linux/spinlock.h:342 [inline]
 __netif_tx_lock include/linux/netdevice.h:4781 [inline]
 sch_direct_xmit+0x15f/0x4c0 net/sched/sch_generic.c:370
 __dev_xmit_skb net/core/dev.c:4209 [inline]
 __dev_queue_xmit+0x180f/0x3950 net/core/dev.c:4831
 NF_HOOK+0x33a/0x3c0 include/linux/netfilter.h:-1
 arp_xmit+0x16c/0x270 net/ipv4/arp.c:665
 arp_solicit+0xbe0/0xe40 net/ipv4/arp.c:392
 neigh_probe net/core/neighbour.c:1096 [inline]
 __neigh_event_send+0xf05/0x14d0 net/core/neighbour.c:1276
 neigh_event_send_probe include/net/neighbour.h:480 [inline]
 neigh_event_send include/net/neighbour.h:486 [inline]
 neigh_resolve_output+0x198/0x750 net/core/neighbour.c:1603
 neigh_output include/net/neighbour.h:556 [inline]
 ip_finish_output2+0xca9/0x1070 net/ipv4/ip_output.c:237
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0x29f/0x450 net/ipv4/ip_output.c:438
 iptunnel_xmit+0x621/0xd10 net/ipv4/ip_tunnel_core.c:97
 ip_tunnel_xmit+0x193a/0x1f20 net/ipv4/ip_tunnel.c:845
 __gre_xmit+0x19e/0x240 net/ipv4/ip_gre.c:491
 erspan_xmit+0xa41/0x14d0 net/ipv4/ip_gre.c:750
 __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
 netdev_start_xmit include/linux/netdevice.h:5377 [inline]
 xmit_one net/core/dev.c:3888 [inline]
 dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3904
 sch_direct_xmit+0x251/0x4c0 net/sched/sch_generic.c:372
 __dev_xmit_skb net/core/dev.c:4209 [inline]
 __dev_queue_xmit+0x180f/0x3950 net/core/dev.c:4831
 dev_queue_xmit include/linux/netdevice.h:3418 [inline]
 alb_send_lp_vid+0x348/0x550 drivers/net/bonding/bond_alb.c:949
 alb_send_learning_packets+0x12c/0x300 drivers/net/bonding/bond_alb.c:1012
 alb_fasten_mac_swap+0x639/0xf60 drivers/net/bonding/bond_alb.c:1076
 bond_alb_handle_active_change+0xc6d/0xf30 drivers/net/bonding/bond_alb.c:1774
 bond_change_active_slave+0x106e/0x35f0 drivers/net/bonding/bond_main.c:1305
 bond_select_active_slave+0x909/0xd40 drivers/net/bonding/bond_main.c:1375
 bond_enslave+0x2299/0x3c10 drivers/net/bonding/bond_main.c:2286
 do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2986
 rtnl_newlink_create+0x6af/0xb70 net/core/rtnetlink.c:3878
 __rtnl_newlink net/core/rtnetlink.c:3995 [inline]
 rtnl_newlink+0x166a/0x1bb0 net/core/rtnetlink.c:4110
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6996
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
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
RIP: 0033:0x7f6d6179cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6d62666028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f6d61a16090 RCX: 00007f6d6179cdd9
RDX: 0000000000000000 RSI: 00002000000000c0 RDI: 0000000000000004
RBP: 00007f6d61832d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6d61a16128 R14: 00007f6d61a16090 R15: 00007f6d61b3fa48
 </TASK>
bond30: (slave erspan1): Enslaving as an active interface with an up link


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

