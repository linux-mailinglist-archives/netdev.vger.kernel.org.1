Return-Path: <netdev+bounces-253461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHnDC3BZd2maeQEAu9opvQ
	(envelope-from <netdev+bounces-253461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:09:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B2A88076
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 397433005154
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373C6333452;
	Mon, 26 Jan 2026 12:09:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55630334C27
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429355; cv=none; b=t7dgW2Oc66oGEdmHhw3nvW8uQuBj3gfdRycA2MlGDsvyzL8n73a/vWAwigbN+2faGhtS19uOjtiiI7JDbyUYYNrn6+kGSVKNnaM+INLjep/DpdbQHioCNiNP5q9cK/5iC8hwVOgo9JC+oQ0jfKHmDB5pRMQILtUUuqnYuYJxDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429355; c=relaxed/simple;
	bh=8sVhi95iusNpdq7SuHzJH30Rj0RohTmyUdc7BKv9ehM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ZSngE1BufNUma3/FDJg5LIKcazJHOYJRvGU/mjGID51qjJ3F3yRLN3Gpz5KRLygjp4h36CPerf4w3WBNseorYUIuvW93ZctlobQGSr6fq1eZhe6r/O0av/YUoIUx82v4T93OC1FhbF3t8J27hh0NO6vQWuxkZwR3y0LiJtL7qQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-45ee72d15f7so889151b6e.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 04:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769429352; x=1770034152;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fN3mzOANncLakW4602fzvUe0cqvv/BA4EDPzO+qp9G0=;
        b=ZsSZ8WNEuVq1cjrbQ9UXOSFSMHTo/f4HGtODdknwR+4Q9p323FT35GtsjoOhH6JEw3
         YgERvKrg3JGCOO61dilKGOUW95kyogRydzEdFrMKeP79to/QQvHdrX6oj2T5KMwBB/Fp
         wldPwqg0QAWB09f6gQ2kWFDaLapHBt9XdLcL9Ffz5a0VUiXHCMTLeN9ZHjjg9ouVXqCJ
         LnkWE6wnL1HOo8g/vK7Xr9MAj4WvS36CpUcCc7XHE1ko+isxzQNRWvGei6G88o18twhy
         72EMivsPlR0K5vPrIvXiwK+PL3z8j8H7x0L/dJiJUsT+5Y8kMd6EDOnTdq2hyObHgKaF
         xi5A==
X-Forwarded-Encrypted: i=1; AJvYcCUiQbmkrubJHPEv0aHBVAIrICICm4PyLfJQd0qeZmbyyhProviyPdcvr9p8sN/FEqueeFdNswc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5k2nUSF3fvqXs+4bhjYL/YfLdeInu0WAfVbgJ78oosnDZHL3S
	iLVTRPwY7KQDx+H0FRvtt0dtct7prIhD7rWcInqz7M2bnsu5HQtFJzsGm2ymtuDp9CTXoCoR8bd
	Yt47wUQ3ugjCeg4VHf7fZVBYLy3pYqe/t1xMzQQip9EwJDU971fPb2t+p0Ao=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:448e:b0:662:c6ea:ceb0 with SMTP id
 006d021491bc7-662e03dcc93mr1438813eaf.26.1769429352208; Mon, 26 Jan 2026
 04:09:12 -0800 (PST)
Date: Mon, 26 Jan 2026 04:09:12 -0800
In-Reply-To: <20260126071359.2693214-1-kuniyu@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69775968.050a0220.226181.001c.GAE@google.com>
Subject: [syzbot ci] Re: nfc: nci: Fix race between rfkill and nci_unregister_device().
From: syzbot ci <syzbot+ci823f35d4b6c8165c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, ilane@ti.com, 
	kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzbot@syzkaller.appspotmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253461-lists,netdev=lfdr.de,ci823f35d4b6c8165c];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,ti.com,gmail.com,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzbot.org:url,googlesource.com:url]
X-Rspamd-Queue-Id: 49B2A88076
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] nfc: nci: Fix race between rfkill and nci_unregister_device().
https://lore.kernel.org/all/20260126071359.2693214-1-kuniyu@google.com
* [PATCH v1 net] nfc: nci: Fix race between rfkill and nci_unregister_device().

and found the following issue:
KASAN: slab-use-after-free Read in nci_unregister_device

Full report is available here:
https://ci.syzbot.org/series/1b1f8783-f1b1-4eaf-8140-aeb610bb4b90

***

KASAN: slab-use-after-free Read in nci_unregister_device

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      1742272bd3fae6362301d0f11eb9db9030348afc
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/f8117535-23ea-4dd0-8208-c2a71b5d6f69/config
C repro:   https://ci.syzbot.org/findings/0d078d52-d526-410a-b2a3-55b7b314bf59/c_repro
syz repro: https://ci.syzbot.org/findings/0d078d52-d526-410a-b2a3-55b7b314bf59/syz_repro

==================================================================
BUG: KASAN: slab-use-after-free in nci_unregister_device+0x123/0x230 net/nfc/nci/core.c:1320
Read of size 8 at addr ffff888113d56628 by task syz.0.17/5980

CPU: 1 UID: 0 PID: 5980 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 nci_unregister_device+0x123/0x230 net/nfc/nci/core.c:1320
 virtual_ncidev_close+0x56/0x90 drivers/nfc/virtual_ncidev.c:168
 __fput+0x44f/0xa70 fs/file_table.c:468
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2b7/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f148199acb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4e2266c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f1481c17da0 RCX: 00007f148199acb9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f1481c17da0 R08: 0000000000000006 R09: 0000000000000000
R10: 00007f1481c17cb0 R11: 0000000000000246 R12: 0000000000012770
R13: 00007f1481c1609c R14: 00000000000124bb R15: 00007f1481c16090
 </TASK>

Allocated by task 13:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5657 [inline]
 __kmalloc_node_track_caller_noprof+0x558/0x7f0 mm/slub.c:5768
 alloc_dr drivers/base/devres.c:119 [inline]
 devm_kmalloc+0x7f/0x300 drivers/base/devres.c:864
 devm_kzalloc include/linux/device/devres.h:54 [inline]
 nci_core_conn_create_rsp_packet net/nfc/nci/rsp.c:282 [inline]
 nci_rsp_packet+0x894/0x3200 net/nfc/nci/rsp.c:384
 nci_rx_work+0x1f8/0x3f0 net/nfc/nci/core.c:1551
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
 worker_thread+0x89f/0xd90 kernel/workqueue.c:3421
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Freed by task 5980:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kfree+0x1be/0x650 mm/slub.c:6882
 release_nodes drivers/base/devres.c:506 [inline]
 devres_release_all+0x1b2/0x240 drivers/base/devres.c:535
 device_del+0x736/0x8f0 drivers/base/core.c:3893
 nfc_unregister_device+0x19c/0x330 net/nfc/core.c:1188
 nci_unregister_device+0x42/0x230 net/nfc/nci/core.c:1306
 virtual_ncidev_close+0x56/0x90 drivers/nfc/virtual_ncidev.c:168
 __fput+0x44f/0xa70 fs/file_table.c:468
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2b7/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888113d56600
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 40 bytes inside of
 freed 128-byte region [ffff888113d56600, ffff888113d56680)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888113d56900 pfn:0x113d56
flags: 0x17ff00000000200(workingset|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000200 ffff888100041a00 ffff888100040648 ffffea00044fbf90
raw: ffff888113d56900 000000000010000c 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5277, tgid 5277 (udevadm), ts 29935854573, free_ts 29929951093
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x228/0x280 mm/page_alloc.c:1884
 prep_new_page mm/page_alloc.c:1892 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3945
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5240
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3a0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xd82/0x1760 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __kmalloc_cache_noprof+0x40d/0x6e0 mm/slub.c:5775
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 kernfs_get_open_node fs/kernfs/file.c:543 [inline]
 kernfs_fop_open+0x7b5/0xca0 fs/kernfs/file.c:718
 do_dentry_open+0x7ce/0x1420 fs/open.c:962
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:4637 [inline]
 path_openat+0x3486/0x3e20 fs/namei.c:4796
 do_filp_open+0x22d/0x490 fs/namei.c:4823
 do_sys_openat2+0x12f/0x220 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
page last free pid 5277 tgid 5277 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xbb0/0xd10 mm/page_alloc.c:2973
 __slab_free+0x2ce/0x320 mm/slub.c:6008
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_noprof+0x3c2/0x7e0 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kernfs_fop_write_iter+0x158/0x540 fs/kernfs/file.c:329
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x61d/0xb90 fs/read_write.c:686
 ksys_write+0x150/0x270 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888113d56500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888113d56580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888113d56600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888113d56680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888113d56700: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
==================================================================


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

