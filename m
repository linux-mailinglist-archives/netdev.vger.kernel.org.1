Return-Path: <netdev+bounces-301904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pCnMKZjrPGq3uQgAu9opvQ
	(envelope-from <netdev+bounces-301904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:49:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 220246C3F62
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:49:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301904-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301904-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D32B300E2AE
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7399385D85;
	Thu, 25 Jun 2026 08:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A23859C3
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:49:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377366; cv=none; b=dRjItjd1UpPslyiovVZ7z6HTT8hpQzR+qjfTc7gJfBNM5lBHkxwIwLP82lH2QkZO+jYbi/YtCad8cQzuiotzZ61ZKzy77XUFv/1zuneMkkvLQ3n6QgRG54IwrjwxiJHd7mq8nSlJgIGZUIt30Vta1v7WD3JCSlCkvIz5Zg6PcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377366; c=relaxed/simple;
	bh=BGEn8tzajDI7dMs5lQdfbTKwuppjxLtH7uh8PWBeEE4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UIJoG93de7sLJvyOZNRog80kKINdFJIFoPT/B0lV+iRRABYfDGSSiqhv6j/UT0Cw/sA+JMRDXZXsI7WTA9PSPFtkgU0BBm1+ojAWhZCZ8W/acTRs/l2nKjVkcVrHV2CVGr/oslwGRt7p/QOyqbtenIV4mc4BdvgDHq3btobl6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-48687e7f161so2687651b6e.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377364; x=1782982164;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwBHjbDnk6TmHx0CyYLVT8LnDjM1iusgihZDKtpP2y8=;
        b=sAmMKreh19ownfcEOawkivXXhOnI5HcFe94qlvbmBAg3BezdCK/w5yuL07VNSD55BX
         HZH3gLRNjLU+rJXMysNj2NndA2XTiHnKq+fLtCB3D8ljkTcmv7TG6vVZRcG/wocGMMRF
         e3ih78vrXUbUQ4fnowciQ0XsEPLZ+CNDc5Pl2gvkobvJQUC2uiZRvIHjuq9tqm1xUSaS
         Ng9cP+3Rr0iqbLVs6x8WJqlDcmpvuKiYAmwHzCX119AL3frSMB2OJaS80owaFe+JRQtw
         48blr1oh3Vrd5nQ79aGSXe/kKvmQ2b8wpzApTdRWej+0yXk2gHcMUI3Mafhsvqz2/5c1
         tJtA==
X-Forwarded-Encrypted: i=1; AFNElJ+s/W2eh+hBh0D8CDKIQeFKpYDwab94J1FHnFoTVhrzYVfQ5LyVnM/8kdNMbV+44UoNiqoZzEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx52Z8KL47OK3tdNNVDooarFfsQk1ZfWdR40tLTxd+msFvEQar
	ghNv4WDtM+wsryJ4Jz4uE6yeFOWwXLhbnwKY8FyUvmRrUjML1dY+fW6HI9k7C36+22qbGnGQjwc
	LDovSllqrUFjIBAnV36APXxaLnzlI73espUzZcybGaC10T7pJz4VRb2aI7Ko=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c194:b0:48a:3452:e8ef with SMTP id
 5614622812f47-4921593f274mr1478989b6e.0.1782377364146; Thu, 25 Jun 2026
 01:49:24 -0700 (PDT)
Date: Thu, 25 Jun 2026 01:49:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3ceb94.43b4ff68.30a095.0004.GAE@google.com>
Subject: [syzbot] [net?] KASAN: stack-out-of-bounds Read in xfrm_state_find (6)
From: syzbot <syzbot+0ac4d84afe1066a1f3e9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9519196b0a0d47bc];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:steffen.klassert@secunet.com,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301904-lists,netdev=lfdr.de,0ac4d84afe1066a1f3e9];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,storage.googleapis.com:url,goo.gl:url,vger.kernel.org:from_smtp,googlegroups.com:email];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 220246C3F62

Hello,

syzbot found the following issue on:

HEAD commit:    a975094bf98c Merge tag 'exfat-for-7.2-rc1' of git://git.ke..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c0eba1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9519196b0a0d47bc
dashboard link: https://syzkaller.appspot.com/bug?extid=0ac4d84afe1066a1f3e9
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25ab9553b7ce/disk-a975094b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5498f6d5131a/vmlinux-a975094b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90c6fca52c8c/bzImage-a975094b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ac4d84afe1066a1f3e9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in jhash2 include/linux/jhash.h:138 [inline]
BUG: KASAN: stack-out-of-bounds in __xfrm6_addr_hash net/xfrm/xfrm_hash.h:16 [inline]
BUG: KASAN: stack-out-of-bounds in __xfrm6_daddr_saddr_hash net/xfrm/xfrm_hash.h:29 [inline]
BUG: KASAN: stack-out-of-bounds in __xfrm_dst_hash net/xfrm/xfrm_hash.h:95 [inline]
BUG: KASAN: stack-out-of-bounds in xfrm_state_find+0x590d/0x5ec0 net/xfrm/xfrm_state.c:1421
Read of size 4 at addr ffffc900061a7908 by task syz.8.4714/27393

CPU: 1 UID: 0 PID: 27393 Comm: syz.8.4714 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 jhash2 include/linux/jhash.h:138 [inline]
 __xfrm6_addr_hash net/xfrm/xfrm_hash.h:16 [inline]
 __xfrm6_daddr_saddr_hash net/xfrm/xfrm_hash.h:29 [inline]
 __xfrm_dst_hash net/xfrm/xfrm_hash.h:95 [inline]
 xfrm_state_find+0x590d/0x5ec0 net/xfrm/xfrm_state.c:1421
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2513 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2564 [inline]
 xfrm_resolve_and_create_bundle+0x7f3/0x3070 net/xfrm/xfrm_policy.c:2862
 xfrm_bundle_lookup net/xfrm/xfrm_policy.c:3097 [inline]
 xfrm_lookup_with_ifid+0x576/0x1b40 net/xfrm/xfrm_policy.c:3228
 xfrm_lookup net/xfrm/xfrm_policy.c:3327 [inline]
 xfrm_lookup_route+0x3c/0x1c0 net/xfrm/xfrm_policy.c:3338
 raw_sendmsg+0x110d/0x1a20 net/ipv4/raw.c:628
 sock_sendmsg_nosec+0x10e/0x180 net/socket.c:776
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feeebb9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feeeca26028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007feeebe15fa0 RCX: 00007feeebb9ce59
RDX: 000000000400c894 RSI: 0000200000000900 RDI: 0000000000000007
RBP: 00007feeebc32e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007feeebe16038 R14: 00007feeebe15fa0 R15: 00007fff5f12fac8
 </TASK>

The buggy address belongs to stack of task syz.8.4714/27393
 and is located at offset 328 in frame:
 raw_sendmsg+0x0/0x1a20 net/ipv4/raw.c:909

This frame has 5 objects:
 [32, 104) 'opt_copy_u'
 [144, 200) 'ipc'
 [240, 248) 'rt'
 [272, 328) 'fl4'
 [368, 392) 'rfv'

The buggy address belongs to a 8-page vmalloc region starting at 0xffffc900061a0000 allocated at copy_process+0x81b/0x42e0 kernel/fork.c:2110
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8b157
memcg:ffff88807cfe5e02
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 ffffea00022c55c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff88807cfe5e02
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x29c2(GFP_NOWAIT|__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_ZERO), pid 27358, tgid 27357 (syz.3.4705), ts 776904415615, free_ts 773990322016
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x21fa/0x2270 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_pages_mpol+0x212/0x380 mm/mempolicy.c:2490
 alloc_frozen_pages_noprof mm/mempolicy.c:2561 [inline]
 alloc_pages_noprof+0xac/0x2a0 mm/mempolicy.c:2581
 vm_area_alloc_pages mm/vmalloc.c:3667 [inline]
 __vmalloc_area_node mm/vmalloc.c:3892 [inline]
 __vmalloc_node_range_noprof+0x795/0x1730 mm/vmalloc.c:4082
 __vmalloc_node_noprof+0xc2/0x100 mm/vmalloc.c:4143
 alloc_thread_stack_node kernel/fork.c:359 [inline]
 dup_task_struct+0x28e/0x850 kernel/fork.c:929
 copy_process+0x81b/0x42e0 kernel/fork.c:2110
 kernel_clone+0x2d7/0x940 kernel/fork.c:2746
 __do_sys_clone kernel/fork.c:2887 [inline]
 __se_sys_clone kernel/fork.c:2871 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2871
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 27224 tgid 27224 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0xc1f/0xd10 mm/page_alloc.c:2950
 __slab_free+0x274/0x2c0 mm/slub.c:5672
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4610 [inline]
 slab_alloc_node mm/slub.c:4939 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0x312/0x750 mm/slub.c:5347
 _kmalloc_noprof include/linux/slab.h:973 [inline]
 tomoyo_realpath_from_path+0xef/0x640 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x229/0x470 security/tomoyo/file.c:776
 security_file_open+0xa9/0x240 security/security.c:2739
 do_dentry_open+0x4a0/0x1380 fs/open.c:924
 vfs_open+0x3b/0x340 fs/open.c:1079
 do_open fs/namei.c:4700 [inline]
 path_openat+0x2e44/0x3830 fs/namei.c:4859
 do_file_open+0x23e/0x4a0 fs/namei.c:4888
 do_sys_openat2+0x115/0x200 fs/open.c:1395
 do_sys_open fs/open.c:1401 [inline]
 __do_sys_openat fs/open.c:1417 [inline]
 __se_sys_openat fs/open.c:1412 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1412
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94

Memory state around the buggy address:
 ffffc900061a7800: 00 00 00 00 00 f2 f2 f2 f2 f2 00 00 00 00 00 00
 ffffc900061a7880: 00 f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00 00
>ffffc900061a7900: 00 f2 f2 f2 f2 f2 00 00 00 f3 f3 f3 f3 f3 f3 f3
                      ^
 ffffc900061a7980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900061a7a00: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
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

