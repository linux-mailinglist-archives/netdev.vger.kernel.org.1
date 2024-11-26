Return-Path: <netdev+bounces-147456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573539D9A03
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173F7282F40
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F241D5ADA;
	Tue, 26 Nov 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zBjXJGjx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BACA17C7B1
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632902; cv=none; b=ft4IUKfPUC3pd+omsGrBWnEpcDpauJDu0haXsj01iX1Bv7m7yi+84ibT34TG98L4+X5mXqfS+XuxhXlOD1wAgl6IRUzU3lGoCkYjcG/0E3QID+O3gC++wUaRlUQ3faPvZEV6zuC7ijx9FaiG4NGzrw7w5zeSSkqd9RcjYM+7hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632902; c=relaxed/simple;
	bh=Vgk5vMztpuW39B3/RJIEbB8yW9MZkMS+0PiPPkccvMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8GwHtJix4YavmmQoYnjwUx3wIwsuA95cc41ofLn0AAFKvNbC1OOeHn88jjNqp07ntmmsYR7pypgNAO1egogYBIIsU3LRAI4QIKA0mOnngKu7COhpxRfErZPHfcjGs/1kzTOM5xfUeT6dEi3zWKlNvGkts/6+1DYtGlF8rO5J2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zBjXJGjx; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffb5b131d0so32906691fa.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 06:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732632898; x=1733237698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1AZA8FM+l5iP0RJpernJtbbqPv2FiJBaVBY47mpJaAY=;
        b=zBjXJGjx5E2BEZjOtl65SSnm7emaMs193Q0e0Z93t/fKubN4hObil24qogGR6YqxYe
         unD7HJxjqIbnyXs/EElA5j2wlNmgiyt88YOi9ngyyxrKCtvE1Rf/45k5tzfUDp+svrK+
         36Kw19j+9stn8AOFTRnm0X3+g18orOhvkqrpMEktv0c3R5xs/EFU9MmaF3hTFMqXGohN
         AYQZYEcCtCi2/06Kl2H9VVMTyMKVSl3aGKbf24aiB3n8vSw++WLpbqFXFxAFCBZineOU
         GpbsrxZaBwSjPXysFa5jWEY3RV0fwn7ABtA/H9U3nYZHlb+WSw9TtY1HAeiBMudFF01m
         iLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732632898; x=1733237698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AZA8FM+l5iP0RJpernJtbbqPv2FiJBaVBY47mpJaAY=;
        b=s8VFpPt0kBi5t2DitXxT1R+perMae1rBVNRqPth8185Qg+uIocEpfsJEoqFuP7D2w6
         GrmmeXqd1ixt520649uMB1PkMQrf51Uwpq0367ZlU1mRDC72gXtkdu/eD1pOEIRqvH5i
         6a1J7q+6XhpuIzG971SoLxWjOb6Xw6u916tS8ZIDJJjj9R3T4s6o6IM7tnqUUh3jafHU
         ScGQuyu2vHPBl15p3jnKrUmNDq5oOrhaHcC9QQ2+DdnnM65V0DYuu8cTo8YO4+twbrmY
         ySbx8w6+9JEHnoFSc/6K7LPD2aOATgmMJDtOPM+Fjae2Gni6glNN2ip/K76XP4yfXtKQ
         VDJw==
X-Forwarded-Encrypted: i=1; AJvYcCXspBBwmCmGXYRRhkd9uGK+bccXIBg/MZfpCnlrnnZvfBiUmeu65IRteR60bJSJ/DOMVi2QaVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76c6+vW/Xq0xn3jFDVOxHXdKi4UcurLVaMlve1ym+kFqrxECL
	uo8mT2SwqBnEp09LMMm9g/ftdMs7OwFwY2CGDdcI7Vvpl3nawZlLwFx9SolABK1N40mD32jWkFF
	1TipKbpIEbacIWgJCFcwSXK7S4A4XRU4OrXDl
X-Gm-Gg: ASbGncs0IAAWW76z25yMkCrTO22IfRJqldhbA43Tr5DKlpH0sX6EwbdEFOGuysTiU9D
	PXP47uNvPRGZYfUJk51a5d1ZXAY4x/QdqIhtCecjYsjR62ODgiA1EvQPmCI3gow==
X-Google-Smtp-Source: AGHT+IHUPBesqwnsXJbLIg1jWqwUB9wb3vfXmxC1R6SB/byhyRlV7jiJBkOzEnG/DW6tW+JBN+8ZZXoPv4wuScUQORI=
X-Received: by 2002:a2e:7a0e:0:b0:2ff:a928:a23e with SMTP id
 38308e7fff4ca-2ffa928a3ebmr66489181fa.25.1732632897325; Tue, 26 Nov 2024
 06:54:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6745e035.050a0220.1286eb.001b.GAE@google.com>
In-Reply-To: <6745e035.050a0220.1286eb.001b.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 26 Nov 2024 15:54:46 +0100
Message-ID: <CACT4Y+azwfrE3uz6A5ZErov5YN2LYBN5KrsymBerT36VU8qzBA@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in xfrm_state_find
To: syzbot <syzbot+5f9f31cb7d985f584d8e@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 15:50, syzbot
<syzbot+5f9f31cb7d985f584d8e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7758b206117d Merge tag 'tracefs-v6.12-rc6' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17cb2e30580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0b2fb415081f288
> dashboard link: https://syzkaller.appspot.com/bug?extid=5f9f31cb7d985f584d8e
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/85d17d41a04f/disk-7758b206.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4c5dbadde61f/vmlinux-7758b206.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/63b589fd77fc/bzImage-7758b206.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5f9f31cb7d985f584d8e@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in __xfrm_state_lookup_all net/xfrm/xfrm_state.c:1045 [inline]
> BUG: KASAN: slab-out-of-bounds in xfrm_state_find+0x6578/0x68c0 net/xfrm/xfrm_state.c:1288
> Read of size 8 at addr ffff88802e87a6c0 by task syz.2.4311/22836
>
> CPU: 1 UID: 0 PID: 22836 Comm: syz.2.4311 Not tainted 6.12.0-rc6-syzkaller-00099-g7758b206117d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0xc3/0x620 mm/kasan/report.c:488
>  kasan_report+0xd9/0x110 mm/kasan/report.c:601
>  __xfrm_state_lookup_all net/xfrm/xfrm_state.c:1045 [inline]
>  xfrm_state_find+0x6578/0x68c0 net/xfrm/xfrm_state.c:1288

If I am reading the code correctly,
net->xfrm.xfrm_state_hash_generation seqlock will ensure that
xfrm_state_find will retry on hash table resize, but it does ensure
consistency between the table pointer and size, so xfrm_state_find
still does out-of-bounds access, which can cause e.g. paging fault
before we retry.

A possible way to solve this is to collect all table data (pointers,
size masks, etc) into a single struct and publish a pointer to a new
struct atomically. Then xfrm_state_find can read a consistent copy of
all fields (either old or new). Then we also don't need the seqlock,
just rcu for lifetime protection.




>  xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2507 [inline]
>  xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2558 [inline]
>  xfrm_resolve_and_create_bundle+0x4bc/0x3650 net/xfrm/xfrm_policy.c:2852
>  xfrm_lookup_with_ifid+0x259/0x1df0 net/xfrm/xfrm_policy.c:3186
>  xfrm_lookup net/xfrm/xfrm_policy.c:3315 [inline]
>  xfrm_lookup_route+0x3b/0x200 net/xfrm/xfrm_policy.c:3326
>  ip6_dst_lookup_flow+0x15c/0x1d0 net/ipv6/ip6_output.c:1265
>  rawv6_sendmsg+0xd5a/0x43d0 net/ipv6/raw.c:898
>  inet_sendmsg+0x119/0x140 net/ipv4/af_inet.c:853
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg net/socket.c:744 [inline]
>  ____sys_sendmsg+0x98c/0xc90 net/socket.c:2607
>  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
>  __sys_sendmmsg+0x1a1/0x450 net/socket.c:2747
>  __do_sys_sendmmsg net/socket.c:2776 [inline]
>  __se_sys_sendmmsg net/socket.c:2773 [inline]
>  __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2773
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f64b277e719
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f64b3632038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
> RAX: ffffffffffffffda RBX: 00007f64b2936058 RCX: 00007f64b277e719
> RDX: 0000000000000021 RSI: 0000000020000480 RDI: 000000000000000e
> RBP: 00007f64b27f139e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f64b2936058 R15: 00007ffe9a51e4e8
>  </TASK>
>
> Allocated by task 5916:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:257 [inline]
>  __do_kmalloc_node mm/slub.c:4264 [inline]
>  __kmalloc_noprof+0x1e8/0x400 mm/slub.c:4276
>  kmalloc_noprof include/linux/slab.h:882 [inline]
>  kzalloc_noprof include/linux/slab.h:1014 [inline]
>  xfrm_hash_alloc+0xd1/0x100 net/xfrm/xfrm_hash.c:21
>  xfrm_hash_resize+0x8c/0x22a0 net/xfrm/xfrm_state.c:168
>  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
>  process_scheduled_works kernel/workqueue.c:3310 [inline]
>  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> The buggy address belongs to the object at ffff88802e87a600
>  which belongs to the cache kmalloc-128 of size 128
> The buggy address is located 64 bytes to the right of
>  allocated 128-byte region [ffff88802e87a600, ffff88802e87a680)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802e87a900 pfn:0x2e87a
> anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000000 ffff88801b041a00 0000000000000000 dead000000000001
> raw: ffff88802e87a900 000000008010000f 00000001f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5825, tgid 5825 (syz-executor), ts 54933774480, free_ts 54907017929
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
>  prep_new_page mm/page_alloc.c:1545 [inline]
>  get_page_from_freelist+0xf7d/0x2d10 mm/page_alloc.c:3457
>  __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
>  alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
>  alloc_slab_page mm/slub.c:2412 [inline]
>  allocate_slab mm/slub.c:2578 [inline]
>  new_slab+0x2c9/0x410 mm/slub.c:2631
>  ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
>  __slab_alloc_node mm/slub.c:3961 [inline]
>  slab_alloc_node mm/slub.c:4122 [inline]
>  __kmalloc_cache_noprof+0x2b4/0x300 mm/slub.c:4290
>  kmalloc_noprof include/linux/slab.h:878 [inline]
>  __hw_addr_create net/core/dev_addr_lists.c:60 [inline]
>  __hw_addr_add_ex+0x3c8/0x7c0 net/core/dev_addr_lists.c:118
>  __dev_mc_add net/core/dev_addr_lists.c:867 [inline]
>  dev_mc_add+0xb6/0x110 net/core/dev_addr_lists.c:885
>  igmp6_group_added+0x395/0x480 net/ipv6/mcast.c:681
>  __ipv6_dev_mc_inc+0x72a/0xc10 net/ipv6/mcast.c:950
>  ipv6_add_dev+0xb04/0x13f0 net/ipv6/addrconf.c:471
>  addrconf_notify+0x53e/0x19c0 net/ipv6/addrconf.c:3655
>  notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
>  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
> page last free pid 58 tgid 58 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1108 [inline]
>  free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
>  __put_partials+0x14c/0x170 mm/slub.c:3145
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
>  kasan_slab_alloc include/linux/kasan.h:247 [inline]
>  slab_post_alloc_hook mm/slub.c:4085 [inline]
>  slab_alloc_node mm/slub.c:4134 [inline]
>  kmem_cache_alloc_node_noprof+0x153/0x310 mm/slub.c:4186
>  __alloc_skb+0x2b1/0x380 net/core/skbuff.c:668
>  alloc_skb include/linux/skbuff.h:1322 [inline]
>  nlmsg_new include/net/netlink.h:1015 [inline]
>  rtmsg_ifinfo_build_skb+0x81/0x280 net/core/rtnetlink.c:4099
>  rtmsg_ifinfo_event net/core/rtnetlink.c:4141 [inline]
>  rtmsg_ifinfo_event net/core/rtnetlink.c:4131 [inline]
>  rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4150
>  netdev_state_change net/core/dev.c:1380 [inline]
>  netdev_state_change+0x12f/0x150 net/core/dev.c:1371
>  linkwatch_do_dev+0x12b/0x160 net/core/link_watch.c:177
>  __linkwatch_run_queue+0x233/0x690 net/core/link_watch.c:234
>  linkwatch_event+0x8f/0xc0 net/core/link_watch.c:277
>  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
>  process_scheduled_works kernel/workqueue.c:3310 [inline]
>  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>
> Memory state around the buggy address:
>  ffff88802e87a580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88802e87a600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff88802e87a680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                                            ^
>  ffff88802e87a700: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
>  ffff88802e87a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller-bugs/6745e035.050a0220.1286eb.001b.GAE%40google.com.

