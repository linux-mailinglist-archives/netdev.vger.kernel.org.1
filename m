Return-Path: <netdev+bounces-287481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLnNA3A6BGoqFgIAu9opvQ
	(envelope-from <netdev+bounces-287481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:46:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5851852FE2C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C6D13013B51
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB833DB635;
	Wed, 13 May 2026 08:46:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27A3E3C75
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661996; cv=none; b=tFMnakU9ny0en6KOjNbgCwhqu0HJN0xbmMAXJbC9s+9FJLWk+EJ4t2NF0xNXLC8zqwCxszKEz1ryQ/qq8MErp1zFc00w0HhIUZpjptbJEo6OEr6u1FHYOX6j12bR48XCjfyuam/Tpdq9jhR4YZ8lC47bZXvedcPwGbnjILoJrJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661996; c=relaxed/simple;
	bh=PyEIBIxmz3giPUp3x32NzdQIix779nXG1mrMvVkCPy0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q3cS91+X8T6c5k9AmnfXHuX1TOpM61ZscOcw0a+Y1hP88bYdYnSU3oMtM/MjQVyXp4vxM7zguTHQrvIFQcUMmtfKNgirPJ5UBSfTQuizX1S2R+z8hdIVk2kTL7+aFZ3pIlDCAtzOeheguyXBY7imT1cyu47P+2D4ybRPUmKNji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7dcda4880efso1683874a34.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 01:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661993; x=1779266793;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzuatPOb18GIRgLXk8GLq927I0Y+J1KKrLrVWO103Zs=;
        b=O9g4BD6clBUbk2sFJLVGafJKl7hchRlhUYRnwZehEgkJSIQ5FC6Lu5vpF068s/lIh+
         WudxtwLHG7Txhe6MVNPwMq9NqCQVjAT43z0cteAgOPMgP5qAQ8eRf7R8kpkY7fQX5ptb
         jHGmW7gC642E88hjxdLVx1W+s05PEaN3D49o2oowiSzv3oHNMXpubPxaZRrKJ+56YwOh
         0gxTNPVhPkrL+U14asLngo7vA/3tIy2V2exSCNmbzIz36+buRIcKQJi54+jamn/IwELz
         m7XbecIpTrFv6959zo4SQEaG52FCZwriXn6jQW6Fh37iBE1Z64wMhW95ojWSWOhe8Zh/
         GLfg==
X-Forwarded-Encrypted: i=1; AFNElJ8vveQwj6ghrHefWroUaCurmOKTmbxi1RJ0e/cL0kf0HaQ8HJcevZ4iBmpc4+IlR3foft2MG/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZ/eKydYkKdA9685N8s+Xnu1QLlITawpQ0L1qitmZUAEHvDwQ
	Np7BQ4fbaUBX9IoOpvHwh0/0U8EWP8sCoTghW701IRDdxA9SBBG5sNManETegsPGrnFuH3pGcp+
	r7cI9cHpf5r4R+Ml+882CITiparnnY3yQq51ie49iAEHxngsb/w+s0zntA80=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2113:b0:69b:5486:e85 with SMTP id
 006d021491bc7-69b78dd8399mr1219958eaf.36.1778661993613; Wed, 13 May 2026
 01:46:33 -0700 (PDT)
Date: Wed, 13 May 2026 01:46:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a043a69.170a0220.1fd042.0004.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in rlb_choose_channel (2)
From: syzbot <syzbot+1db58dbbccbf93c65c83@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5851852FE2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_FROM(0.00)[bounces-287481-lists,netdev=lfdr.de,1db58dbbccbf93c65c83];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,goo.gl:url,storage.googleapis.com:url,googlegroups.com:email,syzkaller.appspot.com:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    c21b90f77687 x86/CPU/AMD: Prevent improper isolation of sh..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ec7dba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=1db58dbbccbf93c65c83
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2f3edabe3b67/disk-c21b90f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/539b63753e79/vmlinux-c21b90f7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e6e7cbc4ca/bzImage-c21b90f7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1db58dbbccbf93c65c83@syzkaller.appspotmail.com

ip6_tunnel: ip6tnl1 xmit: Local address not yet configured!
ip6_tunnel: ip6tnl1 xmit: Local address not yet configured!
============================================
WARNING: possible recursive locking detected
syzkaller #0 Tainted: G             L     
--------------------------------------------
kworker/u8:3/47 is trying to acquire lock:
ffff88807a618e98 (&bond->mode_lock){+.-.}-{3:3}, at: spin_lock include/linux/spinlock.h:342 [inline]
ffff88807a618e98 (&bond->mode_lock){+.-.}-{3:3}, at: rlb_choose_channel+0x37/0x19a0 drivers/net/bonding/bond_alb.c:562

but task is already holding lock:
ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:348 [inline]
ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: rlb_update_rx_clients drivers/net/bonding/bond_alb.c:466 [inline]
ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: bond_alb_monitor+0xe8a/0x17e0 drivers/net/bonding/bond_alb.c:1618

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&bond->mode_lock);
  lock(&bond->mode_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

7 locks held by kworker/u8:3/47:
 #0: ffff8880516b7140 ((wq_completion)bond5#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3277 [inline]
 #0: ffff8880516b7140 ((wq_completion)bond5#2){+.+.}-{0:0}, at: process_scheduled_works+0xa35/0x1860 kernel/workqueue.c:3385
 #1: ffffc90000b77c40 ((work_completion)(&(&bond->alb_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3278 [inline]
 #1: ffffc90000b77c40 ((work_completion)(&(&bond->alb_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa70/0x1860 kernel/workqueue.c:3385
 #2: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #2: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: bond_alb_monitor+0xf8/0x17e0 drivers/net/bonding/bond_alb.c:1546
 #3: ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:348 [inline]
 #3: ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: rlb_update_rx_clients drivers/net/bonding/bond_alb.c:466 [inline]
 #3: ffff88807ffa0e98 (&bond->mode_lock){+.-.}-{3:3}, at: bond_alb_monitor+0xe8a/0x17e0 drivers/net/bonding/bond_alb.c:1618
 #4: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #4: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #4: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: arp_xmit+0x23/0x270 net/ipv4/arp.c:663
 #5: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #5: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: rcu_read_lock_bh include/linux/rcupdate.h:891 [inline]
 #5: ffffffff8e95cdc0 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x2b6/0x3950 net/core/dev.c:4791
 #6: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #6: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #6: ffffffff8e95cd60 (rcu_read_lock){....}-{1:3}, at: bond_start_xmit+0xb4/0x1900 drivers/net/bonding/bond_main.c:5591

stack backtrace:
CPU: 0 UID: 0 PID: 47 Comm: kworker/u8:3 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: bond5 bond_alb_monitor
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
 rlb_choose_channel+0x37/0x19a0 drivers/net/bonding/bond_alb.c:562
 rlb_arp_xmit drivers/net/bonding/bond_alb.c:680 [inline]
 bond_xmit_alb_slave_get+0x1071/0x20a0 drivers/net/bonding/bond_alb.c:1493
 bond_alb_xmit+0x24/0x40 drivers/net/bonding/bond_alb.c:1528
 __bond_start_xmit drivers/net/bonding/bond_main.c:5569 [inline]
 bond_start_xmit+0x6a2/0x1900 drivers/net/bonding/bond_main.c:5593
 __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
 netdev_start_xmit include/linux/netdevice.h:5377 [inline]
 xmit_one net/core/dev.c:3888 [inline]
 dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3904
 __dev_queue_xmit+0x14d9/0x3950 net/core/dev.c:4870
 NF_HOOK+0x33a/0x3c0 include/linux/netfilter.h:-1
 arp_xmit+0x16c/0x270 net/ipv4/arp.c:665
 rlb_update_client+0x2a8/0x6b0 drivers/net/bonding/bond_alb.c:455
 rlb_update_rx_clients drivers/net/bonding/bond_alb.c:473 [inline]
 bond_alb_monitor+0xf6a/0x17e0 drivers/net/bonding/bond_alb.c:1618
 process_one_work kernel/workqueue.c:3302 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3385
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3466
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

