Return-Path: <netdev+bounces-298678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZlnJHVMQLGrHKgQAu9opvQ
	(envelope-from <netdev+bounces-298678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:57:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C79A567A036
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:57:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298678-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298678-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C737530D6552
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FFF36EA8B;
	Fri, 12 Jun 2026 13:56:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B6365A13
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:56:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272588; cv=none; b=sRXV5ExB3VBABwy0R6KokQDAamm5X1UDy6zN05p7xQI+bfUI9DVxpawDtLg0bEZXZqIv+pKQV7iLbbEjBZfumyaTa7mw2HcEWAipAkdLK7a2zbrhNm+cXVA1QFrrHZu5q4rAGGJ4xYb/d5JMbR4cAOF8lrkNpdsQSz9ltcwHOso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272588; c=relaxed/simple;
	bh=dohIcJP/qi9b9gxxHEP5SAOtj2NkNb55hBAIymCiwfM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bRWjJqPfFxu1oxjmNZzjiq4N5sNs6cREHMqAz+zrffy7cdokiLKsdaqiL991KyOu2CM1z1Kiy8ddjM3prxreGYHTr79APEtmDgvLU7PJY0A/ecl0shsYCqO3PTW1NU0FyFw/hex2cJ4HyJIP6fsl5qG7TPLCIPQzGiAScSIh7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-69e78907328so1527184eaf.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272583; x=1781877383;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1SW7fXwQmu6JdBSc8q4w3zNut+7p/uyIY+/9nMnflEE=;
        b=azCoj7/BykqZXqVsmS8QkLk/NT9tdnQ0A/pZLk7Uc6HCCgRMjaUImpS5mZbBLcCY81
         PY8m3OUImq5OAXoV4VPOMMN7h+B1zD5+8xdKBekzbcMUzR2N3glLaMqCdl2CXJSrgh/O
         +dPALcrVPpDNn1mchVUOnIxqVmMtNvAUsjN40qfInL+cPr1u6vl07DCuZb2wy6NdGj11
         Ifn/sL/KPqB+pBXj+k3W61uhkua4no/nwG506xUURCrCHCwTH5vO3PuacyyLJ5eehp6A
         XMHNPd8ADfNB5fUBBpcY/B2T3rYXVNcMr2dcQq7b8m9OesJ9oBESA/cfdBlRYnP5zN5P
         Irgg==
X-Forwarded-Encrypted: i=1; AFNElJ8opCumcAzmg8aAONGjblrIcLmle+UqjqKhpvJHouXIyR2XRIaNqiZU3lr55w/ddScH1NZjGDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq0++r+j5/3NDKf+xlGPZMVWztQvG3b2RHMgq4UM3Sbzg16eJP
	IPjVi/o4BHYkRb9EP8k43u2vAps8/ZqtYvyNeo+KVuHOJTSixdCX19ZWJQLFy60uvd36bUPKeYC
	s+ZqbKbVCg1evtjUxVcAfQCnDt+NJ6q0R8Sm17LJkJbv3SKYI7TWf/E3uZcA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ae8:b0:69d:5b59:2414 with SMTP id
 006d021491bc7-69edc798a18mr1679828eaf.42.1781272583564; Fri, 12 Jun 2026
 06:56:23 -0700 (PDT)
Date: Fri, 12 Jun 2026 06:56:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2c1007.428ffe26.258b27.015d.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in ipvlan_hard_header (4)
From: syzbot <syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298678-lists,netdev=lfdr.de,64ec81389cbad56a8c35];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,goo.gl:url,vger.kernel.org:from_smtp,storage.googleapis.com:url,syzkaller.appspotmail.com:from_mime];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C79A567A036

Hello,

syzbot found the following issue on:

HEAD commit:    bd3a4795d574 selftests: tls: add test for data loss on sma..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17536696580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=64ec81389cbad56a8c35
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/efddfca22ce3/disk-bd3a4795.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c9f1136a96cb/vmlinux-bd3a4795.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a69d66d7068f/bzImage-bd3a4795.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in dev_hard_header include/linux/netdevice.h:3472 [inline]
BUG: KASAN: slab-use-after-free in ipvlan_hard_header+0xa2/0x120 drivers/net/ipvlan/ipvlan_main.c:385
Read of size 8 at addr ffff88807926c010 by task syz-executor/27530

CPU: 0 UID: 0 PID: 27530 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 dev_hard_header include/linux/netdevice.h:3472 [inline]
 ipvlan_hard_header+0xa2/0x120 drivers/net/ipvlan/ipvlan_main.c:385
 dev_hard_header include/linux/netdevice.h:3475 [inline]
 tipc_l2_send_msg+0x31f/0x400 net/tipc/bearer.c:514
 tipc_bearer_xmit_skb+0x2b3/0x400 net/tipc/bearer.c:575
 tipc_disc_timeout+0x595/0x6f0 net/tipc/discover.c:338
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x22a/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1061
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:csd_lock_wait kernel/smp.c:342 [inline]
RIP: 0010:smp_call_function_many_cond+0xfcf/0x13d0 kernel/smp.c:892
Code: 79 45 8b 2e 44 89 ee 83 e6 01 31 ff e8 7a 05 0c 00 41 83 e5 01 49 bd 00 00 00 00 00 fc ff df 75 07 e8 25 01 0c 00 eb 37 f3 90 <43> 0f b6 04 2c 84 c0 75 10 41 f7 06 01 00 00 00 74 1e e8 0a 01 0c
RSP: 0018:ffffc900052ef560 EFLAGS: 00000293
RAX: ffffffff81b9ab26 RBX: ffff8880b863c148 RCX: ffff888064b0bd80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900052ef688 R08: ffffffff9030a3f7 R09: 1ffffffff206147e
R10: dffffc0000000000 R11: fffffbfff206147f R12: 1ffff110170e8169
R13: dffffc0000000000 R14: ffff8880b8740b48 R15: 0000000000000001
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1057
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:46 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x5c3/0x10b0 arch/x86/mm/tlb.c:1451
 dup_mmap+0x17a2/0x1d90 mm/mmap.c:1905
 dup_mm kernel/fork.c:1534 [inline]
 copy_mm+0x13b/0x4a0 kernel/fork.c:1586
 copy_process+0x1f1c/0x4450 kernel/fork.c:2262
 kernel_clone+0x284/0x8f0 kernel/fork.c:2723
 __do_sys_clone kernel/fork.c:2864 [inline]
 __se_sys_clone kernel/fork.c:2848 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2848
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35bc5c5852
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffc036866c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffc036866c0 RCX: 00007f35bc5c5852
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffc0368684c R08: 0000000000000000 R09: 0000000000000001
R10: 00005555868a97d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 00000000000cc36e R15: 00007ffc036868a0
 </TASK>

Allocated by task 17236:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5295 [inline]
 __kvmalloc_node_noprof+0x528/0x8a0 mm/slub.c:6828
 alloc_netdev_mqs+0xa8/0x1210 net/core/dev.c:12026
 rtnl_create_link+0x31f/0xd70 net/core/rtnetlink.c:3672
 rtnl_newlink_create+0x277/0xb70 net/core/rtnetlink.c:3854
 __rtnl_newlink net/core/rtnetlink.c:3995 [inline]
 rtnl_newlink+0x166a/0x1bb0 net/core/rtnetlink.c:4110
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6996
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x672/0x710 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 28096:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6246 [inline]
 kfree+0x1c5/0x640 mm/slub.c:6561
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x228/0x560 lib/kobject.c:737
 netdev_run_todo+0xc75/0xde0 net/core/dev.c:11727
 rtnl_unlock net/core/rtnetlink.c:157 [inline]
 rtnl_net_unlock include/linux/rtnetlink.h:135 [inline]
 rtnl_dellink+0x6a7/0x820 net/core/rtnetlink.c:3602
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

The buggy address belongs to the object at ffff88807926c000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 16 bytes inside of
 freed 4096-byte region [ffff88807926c000, ffff88807926d000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79268
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802c4dcc01
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe35500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800040004 00000000f5000000 ffff88802c4dcc01
head: 00fff00000000040 ffff88813fe35500 dead000000000100 dead000000000122
head: 0000000000000000 0000000800040004 00000000f5000000 ffff88802c4dcc01
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5628, tgid 5628 (syz-executor), ts 81469147157, free_ts 54413861367
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x24ba/0x2540 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x339/0x3d0 mm/slub.c:7251
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x321/0x720 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 __kmalloc_cache_noprof+0x392/0x660 mm/slub.c:5410
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 snmp6_alloc_dev net/ipv6/addrconf.c:362 [inline]
 ipv6_add_dev+0x6aa/0x13a0 net/ipv6/addrconf.c:413
 addrconf_notify+0x771/0x1050 net/ipv6/addrconf.c:3662
 notifier_call_chain+0x1ad/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
 call_netdevice_notifiers net/core/dev.c:2301 [inline]
 register_netdevice+0x18c9/0x1ec0 net/core/dev.c:11458
 macvlan_common_newlink+0x127c/0x19e0 drivers/net/macvlan.c:1554
 rtnl_newlink_create+0x329/0xb70 net/core/rtnetlink.c:3864
 __rtnl_newlink net/core/rtnetlink.c:3995 [inline]
 rtnl_newlink+0x166a/0x1bb0 net/core/rtnetlink.c:4110
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6996
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
page last free pid 5347 tgid 5347 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0xbc7/0xd30 mm/page_alloc.c:2943
 __slab_free+0x274/0x2c0 mm/slub.c:5608
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4569 [inline]
 slab_alloc_node mm/slub.c:4898 [inline]
 kmem_cache_alloc_noprof+0x2bc/0x650 mm/slub.c:4905
 alloc_filename fs/namei.c:142 [inline]
 do_getname+0x2e/0x250 fs/namei.c:182
 getname include/linux/fs.h:2526 [inline]
 getname_maybe_null include/linux/fs.h:2533 [inline]
 class_filename_maybe_null_constructor include/linux/fs.h:2557 [inline]
 vfs_fstatat+0x45/0x170 fs/stat.c:368
 __do_sys_newfstatat fs/stat.c:538 [inline]
 __se_sys_newfstatat fs/stat.c:532 [inline]
 __x64_sys_newfstatat+0x151/0x200 fs/stat.c:532
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807926bf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807926bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807926c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88807926c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807926c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	79 45                	jns    0x47
   2:	8b 2e                	mov    (%rsi),%ebp
   4:	44 89 ee             	mov    %r13d,%esi
   7:	83 e6 01             	and    $0x1,%esi
   a:	31 ff                	xor    %edi,%edi
   c:	e8 7a 05 0c 00       	call   0xc058b
  11:	41 83 e5 01          	and    $0x1,%r13d
  15:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  1c:	fc ff df
  1f:	75 07                	jne    0x28
  21:	e8 25 01 0c 00       	call   0xc014b
  26:	eb 37                	jmp    0x5f
  28:	f3 90                	pause
* 2a:	43 0f b6 04 2c       	movzbl (%r12,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	75 10                	jne    0x43
  33:	41 f7 06 01 00 00 00 	testl  $0x1,(%r14)
  3a:	74 1e                	je     0x5a
  3c:	e8                   	.byte 0xe8
  3d:	0a 01                	or     (%rcx),%al
  3f:	0c                   	.byte 0xc


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

