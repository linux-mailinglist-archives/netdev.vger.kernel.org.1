Return-Path: <netdev+bounces-281836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIbFAEao8GltWwEAu9opvQ
	(envelope-from <netdev+bounces-281836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:29:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA3A484D9E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1A0A300493B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF58425CEB;
	Tue, 28 Apr 2026 12:29:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535542B722
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379388; cv=none; b=IqXu/9ng/xM0qJL+RAkEiCM2Goi3i0fucN3HHtQi45a2h+8SAFEwvEBKV837BbS9L3ZHrM/E18HF23b75sGzAExXrDBZpAgUBEzrjlng+uRR0X+HIKSfz2ritbOY6355Y9QdpAfEmcpUJorCGAjy6R7ude3r2SXT1Zpc1Rr4KC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379388; c=relaxed/simple;
	bh=BpKYgqgoPcmex95ofP37wS4aTAznDCBrr7bwmeZTyvc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BafIEaLU//V/JAmrBRxtuADZQRwLqpf+QguiX8c2RBRqTcgNb8CTbFfa8v8dW8iBHK9Wzb/o4MnwZ503X4IIvSG+1W7lFYK7fXnrPBZEg3j6lenAGxnYd5/CdO7qXGSx79ln8tyL5dUuQnXWbizJhEjYkKsmyvBDFrtnwp1HcKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7d4c7afa9e0so18255238a34.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777379376; x=1777984176;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8y1mrO+gkJ4EfUY/lmq0BivnyMSCXPMiVnw44kHfGI=;
        b=QEtNRz1WATND2GBLQHWdafACkkoK0UjjDxlEXSzNTiyHlgQzrMCT2H4o4W3NM5VEx+
         mbSyN5McnxlVQgDX9habygCcm2JK+dTfF7slEbQvcH9HKheau1aXt8+PTqPnfiaFxqIA
         it0a7IZLWLCO8omugy8AmBa8pFDAVqxs6PdlLqnJs1tWiPmdN8F9VJvwRTKb2viItlJG
         8xG1puff3VlVA4zslAR4LH3cgXuVnq2/vrtiMAas408Xuubg+Yt9MnBZwlcY7RfLySbT
         b4krsqiKXP6uF36Zw9W5IaXYPNuD4l6vVQCjiG1VXmHoaT3OzgdyXutVynnbKD4WfL6z
         gViA==
X-Forwarded-Encrypted: i=1; AFNElJ8+fAWo7k8oRlX9k+biuDCuOBDOjSFceYqTDKrVNWPweBGLSbhb23dxTROQ2wAgg+mpJ8Wi1HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwscklfzEsArC8JAT8d3++U/oGambUY5TnnETlpk5iOtScSFf
	TqpY+IqfGp/+6/BqRVyfpc60TpR4PKd7n2RSAnfhx7pSCrqvZAr6MCZ/SB5N6wWlYae6bQI9URx
	l3PX0CC6QuXpi5z/ZlNrcw54CfXe+TGU4ZaijYJJxOotABlFtUqOKsGBerys=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f034:b0:696:2674:8a15 with SMTP id
 006d021491bc7-6965cb619e8mr1213476eaf.42.1777379375814; Tue, 28 Apr 2026
 05:29:35 -0700 (PDT)
Date: Tue, 28 Apr 2026 05:29:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f0a82f.050a0220.3aadc4.0000.GAE@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in bond_3ad_get_active_agg_info /
 bond_3ad_state_machine_handler (3)
From: syzbot <syzbot+9bb2ff2a4ab9e17307e1@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DDA3A484D9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2e40c0f41e01837e];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-281836-lists,netdev=lfdr.de,9bb2ff2a4ab9e17307e1];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,goo.gl:url,storage.googleapis.com:url,syzkaller.appspot.com:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]

Hello,

syzbot found the following issue on:

HEAD commit:    3b3bea6d4b9c Merge tag 'cgroup-for-7.1-rc1-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109b2348580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e40c0f41e01837e
dashboard link: https://syzkaller.appspot.com/bug?extid=9bb2ff2a4ab9e17307e1
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64fa98e0b2e5/disk-3b3bea6d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f60f0974e1aa/vmlinux-3b3bea6d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/46e55233d5b4/bzImage-3b3bea6d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bb2ff2a4ab9e17307e1@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device bond11
==================================================================
BUG: KCSAN: data-race in bond_3ad_get_active_agg_info / bond_3ad_state_machine_handler

write to 0xffff88813cf5c4b0 of 8 bytes by task 36 on cpu 0:
 ad_port_selection_logic drivers/net/bonding/bond_3ad.c:1659 [inline]
 bond_3ad_state_machine_handler+0x9d5/0x2d60 drivers/net/bonding/bond_3ad.c:2569
 process_one_work kernel/workqueue.c:3302 [inline]
 process_scheduled_works+0x4f0/0x9c0 kernel/workqueue.c:3385
 worker_thread+0x58a/0x780 kernel/workqueue.c:3466
 kthread+0x22a/0x280 kernel/kthread.c:436
 ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

read to 0xffff88813cf5c4b0 of 8 bytes by task 22063 on cpu 1:
 __bond_3ad_get_active_agg_info drivers/net/bonding/bond_3ad.c:2858 [inline]
 bond_3ad_get_active_agg_info+0x8c/0x230 drivers/net/bonding/bond_3ad.c:2881
 bond_fill_info+0xe0f/0x10f0 drivers/net/bonding/bond_netlink.c:853
 rtnl_link_info_fill net/core/rtnetlink.c:906 [inline]
 rtnl_link_fill+0x1d7/0x4e0 net/core/rtnetlink.c:927
 rtnl_fill_ifinfo+0xf8e/0x1380 net/core/rtnetlink.c:2168
 rtmsg_ifinfo_build_skb+0x11c/0x1b0 net/core/rtnetlink.c:4453
 rtmsg_ifinfo_event net/core/rtnetlink.c:4486 [inline]
 rtmsg_ifinfo+0x6d/0x110 net/core/rtnetlink.c:4495
 __dev_notify_flags+0x76/0x390 net/core/dev.c:9790
 netif_change_flags+0xac/0xd0 net/core/dev.c:9823
 do_setlink+0x905/0x2950 net/core/rtnetlink.c:3180
 rtnl_group_changelink net/core/rtnetlink.c:3813 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3981 [inline]
 rtnl_newlink+0xf55/0x1400 net/core/rtnetlink.c:4109
 rtnetlink_rcv_msg+0x64b/0x720 net/core/rtnetlink.c:6995
 netlink_rcv_skb+0x123/0x220 net/netlink/af_netlink.c:2550
 rtnetlink_rcv+0x1c/0x30 net/core/rtnetlink.c:7022
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x5a8/0x680 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x5c8/0x6f0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x563/0x5b0 net/socket.c:2698
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2787
 x64_sys_call+0x194c/0x3020 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000000 -> 0xffff88813cf5c400

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 22063 Comm: syz.0.31122 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
==================================================================
8021q: adding VLAN 0 to HW filter on device bond12
8021q: adding VLAN 0 to HW filter on device bond13
8021q: adding VLAN 0 to HW filter on device bond14
bridge0: port 1(batadv1) entered blocking state
bridge0: port 1(batadv1) entered listening state
8021q: adding VLAN 0 to HW filter on device batadv1
8021q: adding VLAN 0 to HW filter on device eth0
8021q: adding VLAN 0 to HW filter on device eth1
8021q: adding VLAN 0 to HW filter on device eth2
8021q: adding VLAN 0 to HW filter on device eth3
vlan0: left promiscuous mode
bond15: left promiscuous mode
bridge13: left promiscuous mode
vlan0: left allmulticast mode
bond15: left allmulticast mode
bridge13: left allmulticast mode
ipip0: left promiscuous mode
8021q: adding VLAN 0 to HW filter on device bond16
8021q: adding VLAN 0 to HW filter on device bond0


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

