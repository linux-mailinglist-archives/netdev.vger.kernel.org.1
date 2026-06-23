Return-Path: <netdev+bounces-301226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F85fDurTOWrtxwcAu9opvQ
	(envelope-from <netdev+bounces-301226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 02:31:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 997016B2FEA
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 02:31:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301226-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301226-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A553430094CC
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B31DF27F;
	Tue, 23 Jun 2026 00:31:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91FB384254
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 00:31:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174693; cv=none; b=mC1eiaFovj5LdXYd3jAe1Hivk4gCZ+Fiiuu3GMXWepQe5x1Gi6udfqV3pfeqNkZgxWAYu/Uh+ca+hBMtz7nCKd32h5BrX6i0HMl6uMDHNGS1fANqaiPYqAziqDMxvId8m23/OXsif5cECfT7SXKUPKblzmcJfH87ryAwTPe9KuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174693; c=relaxed/simple;
	bh=tPsn14wg4pQvRzndZkntFMUO9BcPQwk5crbrocr+XcI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lcO0rgudhhKl8t00YIFkvJe0QhaN5/BuaNXHFfIH49u64BTRrLGZqq/OHg0So/UsD2vA6H1MqtXXDHaRqFxuRJtdYEvM1K1T02Y5IryfUD5kKhEQi56Aa+QMtrRiKhZwKxJilKA5VGIyotd8Hyhtrgdn5I6pDTmRdKhXBE26vvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7e6f45ce9ceso6672980a34.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 17:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782174691; x=1782779491;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M03x7CztG1VuTqiJDQDg+ECVWcJAuoDUQmKrRkm3ZYQ=;
        b=ZDFYmuhBQWibV8CeTBXBI8HdrXsSlSLbH6kyY/9KxcfRuNRNyZd0/KjXFIESuJp3DN
         BtKWsdS0IdoGZ1JI+BCDDTYN7+W4eXF4ZL9WPD0cyHyNrePumPCj5ReOZq2p5qc6SwGy
         xecNCceCLm63Ry+sHA2GHfJx3f6VXDPtm7Qg46XGoyYiDr8P0QpboGAgQ41maH5DIUYx
         cNZF3fvLfUP/v+hNTqB0mF8LiweWHuOEHMHcnPjI43CJpstSIo3huplAa1qfaEHYpOw8
         EMh3tAPHqDZ3xiVu2GZneSPS4XLB0+APNwXQKhgD1D0FTMdfffyZLvxPTz1JqTg5CoWi
         ISqg==
X-Forwarded-Encrypted: i=1; AFNElJ+nC+08JTz/MxT4hEZS3PMu6PS3LmCB/OuVJNpIak9btDpQDOVXLmNKAUpUSDPRvf+yHRev5v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+YR/EqvVtpohi1mpBXkdttK4CrUhtxf+/isys+KsYbgvKjXr
	H+fu6muz4Tqv8DrC4mdO521uo51cc8zQ1xtmItu5tGJyRZm8R5kizDZ2dPEIDv/t7MRwzw7GhZ9
	6Xw2Q0b1ynWFxcIhQAJVgO4i1DXWnp8y+pO9LNiA6DaGYJXtFq9iLaN5NWKM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:11c9:b0:48b:9987:ba17 with SMTP id
 5614622812f47-48f62c24e11mr25421b6e.35.1782174690916; Mon, 22 Jun 2026
 17:31:30 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:31:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a39d3e2.ac26f6c2.9a9c4.0002.GAE@google.com>
Subject: [syzbot] [wpan?] KASAN: slab-use-after-free Read in hwsim_set_promiscuous_mode
From: syzbot <syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301226-lists,netdev=lfdr.de,4707bb8a43a42fca2b97];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,syzkaller.appspotmail.com:from_mime,goo.gl:url,storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,bootlin.com,redhat.com,datenfreihafen.org,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alex.aring@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wpan@vger.kernel.org,m:miquel.raynal@bootlin.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:stefan@datenfreihafen.org,m:syzkaller-bugs@googlegroups.com,m:alexaring@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 997016B2FEA

Hello,

syzbot found the following issue on:

HEAD commit:    b85966adbf5d Merge tag 'net-next-7.2' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16d3e3a1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544
dashboard link: https://syzkaller.appspot.com/bug?extid=4707bb8a43a42fca2b97
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d65306d96573/disk-b85966ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef43139aab0e/vmlinux-b85966ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26d4d1ab67c3/bzImage-b85966ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim0: left allmulticast mode
8021q: adding VLAN 0 to HW filter on device netdevsim0
8021q: adding VLAN 0 to HW filter on device netdevsim1
8021q: adding VLAN 0 to HW filter on device netdevsim2
8021q: adding VLAN 0 to HW filter on device netdevsim3
==================================================================
BUG: KASAN: slab-use-after-free in hwsim_set_promiscuous_mode+0x2b4/0x2e0 drivers/net/ieee802154/mac802154_hwsim.c:323
Read of size 1 at addr ffff88802adb1800 by task syz.0.303/7013

CPU: 1 UID: 0 PID: 7013 Comm: syz.0.303 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 hwsim_set_promiscuous_mode+0x2b4/0x2e0 drivers/net/ieee802154/mac802154_hwsim.c:323
 drv_set_promiscuous_mode+0x159/0x2e0 net/mac802154/driver-ops.h:127
 drv_start net/mac802154/driver-ops.h:195 [inline]
 mac802154_slave_open net/mac802154/iface.c:196 [inline]
 mac802154_wpan_open+0x196e/0x29f0 net/mac802154/iface.c:295
 __dev_open+0x46f/0x850 net/core/dev.c:1702
 __dev_change_flags+0x329/0x820 net/core/dev.c:9754
 netif_change_flags+0x7c/0x1b0 net/core/dev.c:9817
 do_setlink+0xdd6/0x4670 net/core/rtnetlink.c:3207
 rtnl_group_changelink net/core/rtnetlink.c:3855 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4023 [inline]
 rtnl_newlink+0x148e/0x1bd0 net/core/rtnetlink.c:4151
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7068
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x9b9/0xa20 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff94f19ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff9500a3028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff94f416090 RCX: 00007ff94f19ce59
RDX: 0000000000000000 RSI: 0000200000000180 RDI: 0000000000000008
RBP: 00007ff94f232d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff94f416128 R14: 00007ff94f416090 R15: 00007ffcb835f4f8
 </TASK>

Allocated by task 5605:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x318/0x660 mm/slub.c:5451
 _kmalloc_noprof include/linux/slab.h:969 [inline]
 _kzalloc_noprof include/linux/slab.h:1286 [inline]
 hwsim_update_pib+0x88/0x450 drivers/net/ieee802154/mac802154_hwsim.c:101
 hwsim_set_promiscuous_mode+0x196/0x2e0 drivers/net/ieee802154/mac802154_hwsim.c:323
 drv_set_promiscuous_mode+0x159/0x2e0 net/mac802154/driver-ops.h:127
 drv_start net/mac802154/driver-ops.h:195 [inline]
 mac802154_slave_open net/mac802154/iface.c:196 [inline]
 mac802154_wpan_open+0x196e/0x29f0 net/mac802154/iface.c:295
 __dev_open+0x46f/0x850 net/core/dev.c:1702
 __dev_change_flags+0x329/0x820 net/core/dev.c:9754
 netif_change_flags+0x7c/0x1b0 net/core/dev.c:9817
 do_setlink+0xdd6/0x4670 net/core/rtnetlink.c:3207
 rtnl_changelink net/core/rtnetlink.c:3841 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4014 [inline]
 rtnl_newlink+0x15c2/0x1bd0 net/core/rtnetlink.c:4151
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7068
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 __sys_sendto+0x626/0x6c0 net/socket.c:2252
 __do_sys_sendto net/socket.c:2259 [inline]
 __se_sys_sendto net/socket.c:2255 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2255
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 23:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2700 [inline]
 __rcu_free_sheaf_prepare+0x12d/0x2a0 mm/slub.c:2951
 rcu_free_sheaf+0x31/0x200 mm/slub.c:5909
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x78b/0x10a0 kernel/rcu/tree.c:2897
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1076
 smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88802adb1800
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 freed 64-byte region [ffff88802adb1800, ffff88802adb1840)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2adb1
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88813fe1b8c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 12, tgid 12 (kworker/u8:0), ts 8480159325, free_ts 7414718607
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x22d/0x280 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x24ae/0x2530 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5221
 alloc_slab_page mm/slub.c:3289 [inline]
 allocate_slab+0x74/0x5d0 mm/slub.c:3404
 new_slab mm/slub.c:3447 [inline]
 refill_objects+0x328/0x3c0 mm/slub.c:7241
 refill_sheaf mm/slub.c:2827 [inline]
 __pcs_replace_empty_main+0x2e0/0x6b0 mm/slub.c:4692
 alloc_from_pcs mm/slub.c:4790 [inline]
 slab_alloc_node mm/slub.c:4924 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0x464/0x750 mm/slub.c:5347
 _kmalloc_noprof include/linux/slab.h:973 [inline]
 _kzalloc_noprof include/linux/slab.h:1286 [inline]
 lsm_blob_alloc security/security.c:218 [inline]
 lsm_task_alloc security/security.c:270 [inline]
 security_task_alloc+0x4d/0x330 security/security.c:2785
 copy_process+0x1c57/0x42e0 kernel/fork.c:2269
 kernel_clone+0x2d7/0x940 kernel/fork.c:2745
 user_mode_thread+0x110/0x180 kernel/fork.c:2821
 call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:171
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
page last free pid 10 tgid 10 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1397 [inline]
 __free_frozen_pages+0xc0d/0xd20 mm/page_alloc.c:2938
 vfree+0x1fd/0x330 mm/vmalloc.c:3472
 delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3392
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88802adb1700: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88802adb1780: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88802adb1800: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff88802adb1880: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88802adb1900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


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

