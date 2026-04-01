Return-Path: <netdev+bounces-273799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H2/C1pszGmUSwYAu9opvQ
	(envelope-from <netdev+bounces-273799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:52:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CB43734B8
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D53E8304C619
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D61719067C;
	Wed,  1 Apr 2026 00:49:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46053D561
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004578; cv=none; b=GNHsFazbkUJxDc3N9KSgXsSACkZo03pbKdTbCt26AUkqAKv56g0whwEtn9+UsiVymbYt7JmY0EamvvIRwqmcBYQlelak9D/+51oRGc+cD+Q4PI0JUQecIl2rxz2BZxS/rUn5nawC85JI2Rydak7SvA76s/v5Z3OUdYHucnc0yak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004578; c=relaxed/simple;
	bh=f0/Ki9kd04MsHj/CxKsFJ8SgCuP0wMEIQVh2zPm6zHo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZfJTK8/DQufXAWvHAQNfnZdf2QwC4OUEJ06v4ZMSNQJ1HY5HJ2KFfKKCdvo+n++5xmThXqUa44Qy0PB/SLHJ7uMq6SHpMc1lNG/vDNdO2vHAT/2vBc/NSnzAPKDJX6w9tTu1UVnMoSakM1P5CkU+h+1ubb5aD9Bd4Vgk4186+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-40ea48ccbd2so2772739fac.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775004576; x=1775609376;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OW603Cxk894F3Ouf95KyFAztpwZtL3Wacj56EKyrEBA=;
        b=p8QaRA8tmzdHFt7TGNlRZBSps+LkFPE4vemAHwqWcGkuG7p/R2zhuni9KN80fQVKoH
         WFQ5RdAuFOnjXbPEQMpE7+xolh5tL5RG861Z/UwZ7koQiUZLRO4GQFDEUpEaqKnnRZv0
         NJo+a6OFJytskj/k5ti/TwSdBvCupr2tuLm43fUUQsJKODxbM5HvKOkkPycT2oAZLXsp
         g7iMuUNT4p1OjTP9T7lwycmA7mqH+VVo7UtY9L618iXyUp+v/WKOeJFQAS/ayG3m5Jyr
         l+VsXlzESjuGR77fOmvyixAQi69U8r25mAlUMGw6uLc2sLmx3yqVitKWoWu9Wm7Ch6H6
         hABQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiqqKwSbSlotEo6uVFHnE3GURO3trFpydTJb5XJxt3qt90QVT4vwqAuA6MXIRFh/eXntmucRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBr/itNyI1zunrXbtL+NV3CyP/AFjZv7b9xukM6vzE/vjzoHoB
	CQgPAJJQzHhu2bNSrCCD5jFBrbsYBVoz2cv7YL7vnNWusUGbqeAVc+tlVT/qN4xSS2vsZC7K1fR
	dXBfX7bgj82s/IF9EJ4l5TIdh9RK3+wRQWXa2RlQs4FflfbWpJ7CB5hitEUw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c94:b0:67e:36e9:79af with SMTP id
 006d021491bc7-67fabc05dd9mr833106eaf.17.1775004575699; Tue, 31 Mar 2026
 17:49:35 -0700 (PDT)
Date: Tue, 31 Mar 2026 17:49:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cc6b9f.a70a0220.128fd0.004b.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in
 sk_psock_verdict_data_ready (4)
From: syzbot <syzbot+2184232f07e3677fbaef@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=71d49d824b43a0d9];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,cloudflare.com,gmail.com,redhat.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-273799-lists,netdev=lfdr.de,2184232f07e3677fbaef];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,storage.googleapis.com:url,googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,goo.gl:url];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 80CB43734B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    cf0d9080c6f7 Merge branch 'net-hsr-subsystem-cleanups-and-..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10eab3d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71d49d824b43a0d9
dashboard link: https://syzkaller.appspot.com/bug?extid=2184232f07e3677fbaef
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4271eafdaa2c/disk-cf0d9080.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/984de2c215cb/vmlinux-cf0d9080.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e03ead684811/bzImage-cf0d9080.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2184232f07e3677fbaef@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in sk_psock_verdict_data_ready+0xec/0x590 net/core/skmsg.c:1278
Read of size 8 at addr ffff8880594da860 by task syz.4.1842/11013

CPU: 1 UID: 0 PID: 11013 Comm: syz.4.1842 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 sk_psock_verdict_data_ready+0xec/0x590 net/core/skmsg.c:1278
 unix_stream_sendmsg+0x8a3/0xe80 net/unix/af_unix.c:2482
 sock_sendmsg_nosec net/socket.c:721 [inline]
 __sock_sendmsg net/socket.c:736 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2585
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2639
 __sys_sendmsg net/socket.c:2671 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7facf899c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007facf9827028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007facf8c15fa0 RCX: 00007facf899c819
RDX: 0000000000000000 RSI: 0000200000000500 RDI: 0000000000000004
RBP: 00007facf8a32c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007facf8c16038 R14: 00007facf8c15fa0 R15: 00007ffd41b01c78
 </TASK>

Allocated by task 11013:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4538 [inline]
 slab_alloc_node mm/slub.c:4866 [inline]
 kmem_cache_alloc_lru_noprof+0x2b8/0x640 mm/slub.c:4885
 sock_alloc_inode+0x28/0xc0 net/socket.c:316
 alloc_inode+0x6a/0x1b0 fs/inode.c:347
 new_inode_pseudo include/linux/fs.h:3003 [inline]
 sock_alloc net/socket.c:631 [inline]
 __sock_create+0x12d/0x9d0 net/socket.c:1562
 sock_create net/socket.c:1656 [inline]
 __sys_socketpair+0x1c4/0x560 net/socket.c:1803
 __do_sys_socketpair net/socket.c:1856 [inline]
 __se_sys_socketpair net/socket.c:1853 [inline]
 __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1853
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kmem_cache_free+0x187/0x630 mm/slub.c:6295
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1063
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
 destroy_inode fs/inode.c:402 [inline]
 evict+0x95b/0xb10 fs/inode.c:870
 __dentry_kill+0x1a2/0x5e0 fs/dcache.c:670
 finish_dput+0xc9/0x480 fs/dcache.c:879
 __fput+0x691/0xa70 fs/file_table.c:477
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880594da840
 which belongs to the cache sock_inode_cache of size 1344
The buggy address is located 32 bytes inside of
 freed 1344-byte region [ffff8880594da840, ffff8880594dad80)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x594d8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880594dfe81
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888140af9dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800160016 00000000f5000000 ffff8880594dfe81
head: 00fff00000000040 ffff888140af9dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000800160016 00000000f5000000 ffff8880594dfe81
head: 00fff00000000003 ffffea0001653601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5827, tgid 5827 (syz-executor), ts 157169026983, free_ts 137999783832
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3481
 new_slab mm/slub.c:3539 [inline]
 refill_objects+0x331/0x3c0 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x2e6/0x730 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 kmem_cache_alloc_lru_noprof+0x37c/0x640 mm/slub.c:4885
 sock_alloc_inode+0x28/0xc0 net/socket.c:316
 alloc_inode+0x6a/0x1b0 fs/inode.c:347
 new_inode_pseudo include/linux/fs.h:3003 [inline]
 sock_alloc net/socket.c:631 [inline]
 __sock_create+0x12d/0x9d0 net/socket.c:1562
 sock_create net/socket.c:1656 [inline]
 __sys_socket_create net/socket.c:1693 [inline]
 __sys_socket+0xd6/0x1b0 net/socket.c:1740
 __do_sys_socket net/socket.c:1754 [inline]
 __se_sys_socket net/socket.c:1752 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1752
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 7484 tgid 7484 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 __slab_free+0x263/0x2b0 mm/slub.c:5573
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4538 [inline]
 slab_alloc_node mm/slub.c:4866 [inline]
 kmem_cache_alloc_noprof+0x2bc/0x650 mm/slub.c:4873
 vm_area_alloc+0x24/0x140 mm/vma_init.c:32
 __mmap_new_vma mm/vma.c:2517 [inline]
 __mmap_region mm/vma.c:2759 [inline]
 mmap_region+0x10eb/0x2240 mm/vma.c:2837
 do_mmap+0xc39/0x10c0 mm/mmap.c:559
 vm_mmap_pgoff+0x2c9/0x4f0 mm/util.c:581
 elf_map fs/binfmt_elf.c:400 [inline]
 elf_load+0x248/0x6a0 fs/binfmt_elf.c:423
 load_elf_interp+0x4ce/0xb60 fs/binfmt_elf.c:690
 load_elf_binary+0x1b2f/0x2980 fs/binfmt_elf.c:1255
 search_binary_handler fs/exec.c:1664 [inline]
 exec_binprm fs/exec.c:1696 [inline]
 bprm_execve+0x93d/0x1460 fs/exec.c:1748
 kernel_execve+0x844/0x930 fs/exec.c:1892
 call_usermodehelper_exec_async+0x20f/0x360 kernel/umh.c:109

Memory state around the buggy address:
 ffff8880594da700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880594da780: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff8880594da800: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                       ^
 ffff8880594da880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880594da900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

