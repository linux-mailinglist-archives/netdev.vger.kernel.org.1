Return-Path: <netdev+bounces-296185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yZUXJ9gQJWqdDAIAu9opvQ
	(envelope-from <netdev+bounces-296185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 08:34:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E2A64EF33
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 08:34:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296185-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296185-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 317C3300D32F
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 06:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1228640B;
	Sun,  7 Jun 2026 06:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC82571D7
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 06:33:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780814014; cv=none; b=H84gQoh7rLtJH1DjMW0c/HZioEmXLJBag059oAS75jiwhTuM8UiBTKv+UvnWCE5XGEIhXXOWuCfPWwnYpgQeRwyXERTkNPUlFJ9K+bbE/em2kMrFtirZeTmIO1JaQE6HkzysuQfHKGRBS+VuI5KB9l5ZnHwxiRXUHzxucB+ZU4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780814014; c=relaxed/simple;
	bh=UMr5FMnYWkanLZ/Jc8Z9Nz1h8XihtB/2zR4M1WZ8icg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EjB6trespKi46z5b21e69XxYI17eou/BBdpLvDE6cOZvnFX877Xd7v28GqraE658f4/VPupUh58+xR/+7MGIBYkKUdjZLBWPb5kyfkOxldQe9ljQslGmtK5fbP5LcqmdIY3icPDJX2122He3iqCGU+ueRg1KP0T801shSjMnU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-69e3464b1afso4703868eaf.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 23:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780814012; x=1781418812;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6fHmm8iEbnH+I5IfhLkxKM674mSo16ZCKnZDZT2OUA=;
        b=COewtk3+UDDtYYJ1yNFuWJmGe53HZKHDI1MhGEd2cp55GCmjpEOkZp46+0JaL8EQMH
         H93AvO1rmxeyU7IrQ/LIlrp6fE/iNg7Wrm5u2yuauPTdT/V+OdzbRR+xp9k5OmUPBSsl
         jZEJ7PGsOjdpIPhK4an7OY1cpM/aXBQ0snu1/uLrSRN7nuNh1qFS9EUhBZ01d21hQD9b
         5xlVs4Yu4F2fQcAeBESrA6XsfsbWl184+PCbItRQYivUfeNrc8SaKojRK+sJerCeXKoe
         tPYgBwSLAWRCLq4dkZu7hQfh4cTmXk3Ih7iQcWRUXMy1zX8qBuchV7NOMQtn0+IzoXa2
         Rpaw==
X-Forwarded-Encrypted: i=1; AFNElJ8o1bEKEXtcQxC28H0w+MyCh9Kv9s/vX9B/svBjDFpnoMMZWbRdronZNA8ZJ8m1DgNF7E4lnjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9tVcYned2IOIbd6uOOQZU43rWE/jydxIhBvABhjncohphyK/1
	nSkIzcC4iCfD/DH1L6OizUte+fguvnUla6zxqsGhpJXNX2ezWZKHb1Y+J+K8roqzBYiZ0hibKKE
	U5pJT8s/KTK37Y5lDU1iGQ9EIDWgWdQQhGbeLNRCo1FdUAk2v1QH+z7Ixtss=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1609:b0:69e:8976:77d9 with SMTP id
 006d021491bc7-69e897678c5mr1012559eaf.40.1780814012129; Sat, 06 Jun 2026
 23:33:32 -0700 (PDT)
Date: Sat, 06 Jun 2026 23:33:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2510bc.39669fcc.33b062.000c.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in sit_tunnel_xmit
From: syzbot <syzbot+6eb9ca986d80f6f88cf9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=65472e27d1590a04];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-296185-lists,netdev=lfdr.de,6eb9ca986d80f6f88cf9];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28E2A64EF33

Hello,

syzbot found the following issue on:

HEAD commit:    c93952cc0034 Merge branch 'intel-wired-lan-driver-updates-..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16b1eb7e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65472e27d1590a04
dashboard link: https://syzkaller.appspot.com/bug?extid=6eb9ca986d80f6f88cf9
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae72ddffba02/disk-c93952cc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9090edc4303/vmlinux-c93952cc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/403385dab708/bzImage-c93952cc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6eb9ca986d80f6f88cf9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ipv6_get_dsfield include/net/dsfield.h:24 [inline]
BUG: KASAN: slab-use-after-free in ipip6_tunnel_xmit net/ipv6/sit.c:1021 [inline]
BUG: KASAN: slab-use-after-free in sit_tunnel_xmit+0x19b5/0x1b80 net/ipv6/sit.c:1072
Read of size 2 at addr ffff88801bba9760 by task syz.0.1430/10890

CPU: 0 UID: 0 PID: 10890 Comm: syz.0.1430 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 ipv6_get_dsfield include/net/dsfield.h:24 [inline]
 ipip6_tunnel_xmit net/ipv6/sit.c:1021 [inline]
 sit_tunnel_xmit+0x19b5/0x1b80 net/ipv6/sit.c:1072
 __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
 netdev_start_xmit include/linux/netdevice.h:5377 [inline]
 xmit_one net/core/dev.c:3888 [inline]
 dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3904
 __dev_queue_xmit+0x14d9/0x3950 net/core/dev.c:4870
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x3c81/0x4fb0 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x672/0x710 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff06c39ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff06d1e8028 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007ff06c615fa0 RCX: 00007ff06c39ce59
RDX: 000000000000fc13 RSI: 0000200000000280 RDI: 0000000000000005
RBP: 00007ff06c432d6f R08: 0000000000000000 R09: 000000000000002f
R10: 0000000000000800 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff06c616038 R14: 00007ff06c615fa0 R15: 00007ffe13a440e8
 </TASK>

Allocated by task 10890:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_node_noprof+0x384/0x690 mm/slub.c:4951
 kmalloc_reserve net/core/skbuff.c:613 [inline]
 __alloc_skb+0x27d/0x7d0 net/core/skbuff.c:713
 alloc_skb include/linux/skbuff.h:1385 [inline]
 alloc_skb_with_frags+0xc8/0x760 net/core/skbuff.c:6766
 sock_alloc_send_pskb+0x878/0x990 net/core/sock.c:3002
 packet_alloc_skb net/packet/af_packet.c:2932 [inline]
 packet_snd net/packet/af_packet.c:3025 [inline]
 packet_sendmsg+0x315a/0x4fb0 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x672/0x710 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 10890:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kfree+0x1c5/0x640 mm/slub.c:6566
 skb_kfree_head net/core/skbuff.c:1075 [inline]
 skb_free_head net/core/skbuff.c:1087 [inline]
 pskb_expand_head+0x458/0x1390 net/core/skbuff.c:2335
 skb_header_unclone include/linux/skbuff.h:2087 [inline]
 iptunnel_handle_offloads+0x362/0x630 net/ipv4/ip_tunnel_core.c:185
 ipip6_tunnel_xmit net/ipv6/sit.c:960 [inline]
 sit_tunnel_xmit+0x92a/0x1b80 net/ipv6/sit.c:1072
 __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
 netdev_start_xmit include/linux/netdevice.h:5377 [inline]
 xmit_one net/core/dev.c:3888 [inline]
 dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3904
 __dev_queue_xmit+0x14d9/0x3950 net/core/dev.c:4870
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x3c81/0x4fb0 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x672/0x710 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801bba96c0
 which belongs to the cache skbuff_small_head of size 704
The buggy address is located 160 bytes inside of
 freed 704-byte region [ffff88801bba96c0, ffff88801bba9980)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1bba8
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801f2ad8c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800130013 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801f2ad8c0 dead000000000100 dead000000000122
head: 0000000000000000 0000000800130013 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5003, tgid 5003 (udevd), ts 31613474311, free_ts 31513004909
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x22d/0x280 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x2593/0x2610 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5221
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x339/0x3d0 mm/slub.c:7272
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x321/0x720 mm/slub.c:4652
 alloc_from_pcs mm/slub.c:4750 [inline]
 slab_alloc_node mm/slub.c:4884 [inline]
 kmem_cache_alloc_node_noprof+0x441/0x690 mm/slub.c:4951
 kmalloc_reserve net/core/skbuff.c:613 [inline]
 __alloc_skb+0x27d/0x7d0 net/core/skbuff.c:713
 netlink_sendmsg+0x5d4/0xb40 net/netlink/af_netlink.c:1874
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5001 tgid 5001 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1397 [inline]
 __free_frozen_pages+0xc1c/0xd30 mm/page_alloc.c:2938
 __slab_free+0x274/0x2c0 mm/slub.c:5613
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_noprof+0x2bc/0x650 mm/slub.c:4906
 lsm_file_alloc security/security.c:171 [inline]
 security_file_alloc+0x34/0x310 security/security.c:2406
 init_file+0x90/0x2b0 fs/file_table.c:184
 alloc_empty_file+0x74/0x1d0 fs/file_table.c:266
 path_openat+0x10f/0x3860 fs/namei.c:4844
 do_file_open+0x23e/0x4a0 fs/namei.c:4887
 do_sys_openat2+0x113/0x200 fs/open.c:1364
 do_sys_open fs/open.c:1370 [inline]
 __do_sys_openat fs/open.c:1386 [inline]
 __se_sys_openat fs/open.c:1381 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1381
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88801bba9600: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88801bba9680: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff88801bba9700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff88801bba9780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801bba9800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

