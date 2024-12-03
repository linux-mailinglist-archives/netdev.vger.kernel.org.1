Return-Path: <netdev+bounces-148623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F99E2A16
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE9428448C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140DA1FBEA5;
	Tue,  3 Dec 2024 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4QbEINUQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0B1FA840
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248585; cv=none; b=HV/X6YSWQIlGWJ27qlVrnUg9CIywXR6cHNSd7kfSEv3n6l8L/oNbVYFsS4Ju730Drq/GjFCFLPa7OIlq/rRBrZKousoFijLCpGoFQ8qVrnzcUiPTwQ94zIpWAbmJUStNwRghwifkNMd5kkwANahYucI+FbL2F+hb84VDHq3Q3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248585; c=relaxed/simple;
	bh=wWGzw/UlH111Tq8S1ToGbRIJH5sDACGSsQIvVAIfQVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+0YVaNWqtFc0zXibXtEnqwarBmPZBxlhjeKUDm3bkivGSGJPZYKENPKl9lavbGVAnQ4VFk/FAKQ95igwVoDLFI+jvdS/dtK3goIRMfPDhjpvWrmsHnp6bQJtOPpq1G3Fphdqv/O3uMsrArZP8Pj+3suwr7RO3DvGe6xi+qbqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4QbEINUQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa549d9dffdso936893966b.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733248581; x=1733853381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2xxYYbaGgBgN1yXahKuxHkveEA2xh24PRMyvstmqN0=;
        b=4QbEINUQ6MUM2txmNTa63+18GySEIujtYlJKrhYdE0S7HdF6b4THgho+2/eYAwrCIG
         GY6mVrJnFlxCJ8V3bew4DMfqgNtHDrXwn2AoxxiCwaLDLhBMvlEZjRzVtg1KUw8SIRJz
         w2zhXSsS51+HRoFTWikUGMPj/2mO55hJCKXo8cbMCLTZuRUjOzwzuvqxrsYZ+4/x/4kq
         rCqxBQ2t8V8fomKUtTfOyY9QRUTqqwimbTFxiaaaVigu8aw8IaTugw9vER/2Vikbr5n4
         rCwyMUXr5TSGtDeGZMLmokcfmoDQ4qF03f7NoaftsbmSyRsgvups80RsJTKUyU25aV5b
         JSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733248581; x=1733853381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2xxYYbaGgBgN1yXahKuxHkveEA2xh24PRMyvstmqN0=;
        b=lcqWlvZ99ey/XRXQoIJ7/5s/d20P0dJOkR9Qfy4CSKzyKJHI8N3sRn57wiS/eseaPS
         6Wr1FbG6RQOicd9HYknsEJJ9PBRuwehjIKWvidmfuNLV/gv3i8QdwpoqzDI2xL6sQssj
         TsMVpXbcSwhQnZjRfzEwIk6cvdUhjWWLcQ6bHpaGwfuL4LWQ6cIbTUa/H8UMbKoI1sSx
         BnY+BSjEEghVIcuUXA6dXKMIsbU0/mJQHOvlK8blx4P/wK2M1DiKCIxGxtPnS+wncdUU
         cnZMOTJ7AcbSaFLHNBuSMSfhWWrYjSRPcJYNYrHEDT65B2sJq5FFfoJN1ByG1u92z4Hw
         8BgA==
X-Forwarded-Encrypted: i=1; AJvYcCWQO2ZyhuaDNs36ND5Sr+kHrXG3wsLbz1eLXRcocsJpDAf8cFDPODUli9EBbKPYJqh9Pzzds1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YztHp2IBqSx7XUFw6VcQjy9Et9oQwZBdorBm9O9lNOAj0xxlvy0
	jkf2tvrecLjgB8Wht1+BagoS0N2ABCJmbyMLaA/v+1HhNa64uyqyCID1fevEBoACzZ8dv2s6cm7
	DT+Hs3zngDDMVFL/vH6Oth2QyxkGzfhAY6Qx8
X-Gm-Gg: ASbGncvUZyQLxEgmiVZf5ErdcNmrRE576vXF2g+xF3fJjrT0mwWfoEZLybTKm0RLAW8
	EUTH0uchJls1rkmjJc+4wwkVKFqO3s17I
X-Google-Smtp-Source: AGHT+IF03iLHydGq78gTyyzQR9T0ju5O6V53D5QvOQge9Cakt2MdYt4UeIDzZbjgNoa/3FhMrYMlII1oDlJnHnWphY4=
X-Received: by 2002:a17:906:c10c:b0:aa5:2a57:1779 with SMTP id
 a640c23a62f3a-aa5f7f4ace8mr298967166b.59.1733248580808; Tue, 03 Dec 2024
 09:56:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203170933.2449307-1-edumazet@google.com> <20241203173718.owpsc6h2kmhdvhy4@skbuf>
In-Reply-To: <20241203173718.owpsc6h2kmhdvhy4@skbuf>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Dec 2024 18:56:09 +0100
Message-ID: <CANn89iKpzA=5iam--u8A+GR8F+YZ5DNRdbVk=KniMwgdZWrnuQ@mail.gmail.com>
Subject: Re: [PATCH net] net: avoid potential UAF in default_operstate()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 6:37=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> Hi Eric,
>
> On Tue, Dec 03, 2024 at 05:09:33PM +0000, Eric Dumazet wrote:
> > syzbot reported an UAF in default_operstate() [1]
> >
> > Issue is a race between device and netns dismantles.
> >
> > After calling __rtnl_unlock() from netdev_run_todo(),
> > we can not assume the netns of each device is still alive.
> >
> > Make sure the device is not in NETREG_UNREGISTERED state,
> > and add an ASSERT_RTNL() before the call to
> > __dev_get_by_index().
> >
> > We might move this ASSERT_RTNL() in __dev_get_by_index()
> > in the future.
> >
> > [1]
> >
> > BUG: KASAN: slab-use-after-free in __dev_get_by_index+0x5d/0x110 net/co=
re/dev.c:852
> > Read of size 8 at addr ffff888043eba1b0 by task syz.0.0/5339
> >
> > CPU: 0 UID: 0 PID: 5339 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-1029=
6-gaaf20f870da0 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >  <TASK>
> >   __dump_stack lib/dump_stack.c:94 [inline]
> >   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >   print_address_description mm/kasan/report.c:378 [inline]
> >   print_report+0x169/0x550 mm/kasan/report.c:489
> >   kasan_report+0x143/0x180 mm/kasan/report.c:602
> >   __dev_get_by_index+0x5d/0x110 net/core/dev.c:852
> >   default_operstate net/core/link_watch.c:51 [inline]
> >   rfc2863_policy+0x224/0x300 net/core/link_watch.c:67
> >   linkwatch_do_dev+0x3e/0x170 net/core/link_watch.c:170
> >   netdev_run_todo+0x461/0x1000 net/core/dev.c:10894
> >   rtnl_unlock net/core/rtnetlink.c:152 [inline]
> >   rtnl_net_unlock include/linux/rtnetlink.h:133 [inline]
> >   rtnl_dellink+0x760/0x8d0 net/core/rtnetlink.c:3520
> >   rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6911
> >   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2541
> >   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
> >   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
> >   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
> >   sock_sendmsg_nosec net/socket.c:711 [inline]
> >   __sock_sendmsg+0x221/0x270 net/socket.c:726
> >   ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
> >   ___sys_sendmsg net/socket.c:2637 [inline]
> >   __sys_sendmsg+0x269/0x350 net/socket.c:2669
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f2a3cb80809
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f2a3d9cd058 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 00007f2a3cd45fa0 RCX: 00007f2a3cb80809
> > RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000008
> > RBP: 00007f2a3cbf393e R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 00007f2a3cd45fa0 R15: 00007ffd03bc65c8
> >  </TASK>
>
> In the future could you please trim irrelevant stuff from dumps like this=
?

I prefer the full output, it can be very useful. It is relevant to me at le=
ast.

>
> >
> > Allocated by task 5339:
> >   kasan_save_stack mm/kasan/common.c:47 [inline]
> >   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> >   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
> >   kasan_kmalloc include/linux/kasan.h:260 [inline]
> >   __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
> >   kmalloc_noprof include/linux/slab.h:901 [inline]
> >   kmalloc_array_noprof include/linux/slab.h:945 [inline]
> >   netdev_create_hash net/core/dev.c:11870 [inline]
> >   netdev_init+0x10c/0x250 net/core/dev.c:11890
> >   ops_init+0x31e/0x590 net/core/net_namespace.c:138
> >   setup_net+0x287/0x9e0 net/core/net_namespace.c:362
> >   copy_net_ns+0x33f/0x570 net/core/net_namespace.c:500
> >   create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
> >   unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
> >   ksys_unshare+0x57d/0xa70 kernel/fork.c:3314
> >   __do_sys_unshare kernel/fork.c:3385 [inline]
> >   __se_sys_unshare kernel/fork.c:3383 [inline]
> >   __x64_sys_unshare+0x38/0x40 kernel/fork.c:3383
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 12:
> >   kasan_save_stack mm/kasan/common.c:47 [inline]
> >   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
> >   poison_slab_object mm/kasan/common.c:247 [inline]
> >   __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
> >   kasan_slab_free include/linux/kasan.h:233 [inline]
> >   slab_free_hook mm/slub.c:2338 [inline]
> >   slab_free mm/slub.c:4598 [inline]
> >   kfree+0x196/0x420 mm/slub.c:4746
> >   netdev_exit+0x65/0xd0 net/core/dev.c:11992
> >   ops_exit_list net/core/net_namespace.c:172 [inline]
> >   cleanup_net+0x802/0xcc0 net/core/net_namespace.c:632
> >   process_one_work kernel/workqueue.c:3229 [inline]
> >   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
> >   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> >   kthread+0x2f0/0x390 kernel/kthread.c:389
> >   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > The buggy address belongs to the object at ffff888043eba000
> >  which belongs to the cache kmalloc-2k of size 2048
> > The buggy address is located 432 bytes inside of
> >  freed 2048-byte region [ffff888043eba000, ffff888043eba800)
> >
> > The buggy address belongs to the physical page:
> > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43=
eb8
> > head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > flags: 0x4fff00000000040(head|node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> > page_type: f5(slab)
> > raw: 04fff00000000040 ffff88801ac42000 dead000000000122 000000000000000=
0
> > raw: 0000000000000000 0000000000080008 00000001f5000000 000000000000000=
0
> > head: 04fff00000000040 ffff88801ac42000 dead000000000122 00000000000000=
00
> > head: 0000000000000000 0000000000080008 00000001f5000000 00000000000000=
00
> > head: 04fff00000000003 ffffea00010fae01 ffffffffffffffff 00000000000000=
00
> > head: 0000000000000008 0000000000000000 00000000ffffffff 00000000000000=
00
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c=
0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC)=
, pid 5339, tgid 5338 (syz.0.0), ts 69674195892, free_ts 69663220888
> >   set_page_owner include/linux/page_owner.h:32 [inline]
> >   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >   prep_new_page mm/page_alloc.c:1564 [inline]
> >   get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
> >   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >   alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
> >   alloc_slab_page+0x6a/0x140 mm/slub.c:2408
> >   allocate_slab+0x5a/0x2f0 mm/slub.c:2574
> >   new_slab mm/slub.c:2627 [inline]
> >   ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
> >   __slab_alloc+0x58/0xa0 mm/slub.c:3905
> >   __slab_alloc_node mm/slub.c:3980 [inline]
> >   slab_alloc_node mm/slub.c:4141 [inline]
> >   __do_kmalloc_node mm/slub.c:4282 [inline]
> >   __kmalloc_noprof+0x2e6/0x4c0 mm/slub.c:4295
> >   kmalloc_noprof include/linux/slab.h:905 [inline]
> >   sk_prot_alloc+0xe0/0x210 net/core/sock.c:2165
> >   sk_alloc+0x38/0x370 net/core/sock.c:2218
> >   __netlink_create+0x65/0x260 net/netlink/af_netlink.c:629
> >   __netlink_kernel_create+0x174/0x6f0 net/netlink/af_netlink.c:2015
> >   netlink_kernel_create include/linux/netlink.h:62 [inline]
> >   uevent_net_init+0xed/0x2d0 lib/kobject_uevent.c:783
> >   ops_init+0x31e/0x590 net/core/net_namespace.c:138
> >   setup_net+0x287/0x9e0 net/core/net_namespace.c:362
> > page last free pid 1032 tgid 1032 stack trace:
> >   reset_page_owner include/linux/page_owner.h:25 [inline]
> >   free_pages_prepare mm/page_alloc.c:1127 [inline]
> >   free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
> >   __slab_free+0x31b/0x3d0 mm/slub.c:4509
> >   qlink_free mm/kasan/quarantine.c:163 [inline]
> >   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
> >   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
> >   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
> >   kasan_slab_alloc include/linux/kasan.h:250 [inline]
> >   slab_post_alloc_hook mm/slub.c:4104 [inline]
> >   slab_alloc_node mm/slub.c:4153 [inline]
> >   kmem_cache_alloc_node_noprof+0x1d9/0x380 mm/slub.c:4205
> >   __alloc_skb+0x1c3/0x440 net/core/skbuff.c:668
> >   alloc_skb include/linux/skbuff.h:1323 [inline]
> >   alloc_skb_with_frags+0xc3/0x820 net/core/skbuff.c:6612
> >   sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2881
> >   sock_alloc_send_skb include/net/sock.h:1797 [inline]
> >   mld_newpack+0x1c3/0xaf0 net/ipv6/mcast.c:1747
> >   add_grhead net/ipv6/mcast.c:1850 [inline]
> >   add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
> >   mld_send_initial_cr+0x228/0x4b0 net/ipv6/mcast.c:2234
> >   ipv6_mc_dad_complete+0x88/0x490 net/ipv6/mcast.c:2245
> >   addrconf_dad_completed+0x712/0xcd0 net/ipv6/addrconf.c:4342
> >  addrconf_dad_work+0xdc2/0x16f0
> >   process_one_work kernel/workqueue.c:3229 [inline]
> >   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
> >
> > Memory state around the buggy address:
> >  ffff888043eba080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff888043eba100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff888043eba180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                      ^
> >  ffff888043eba200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff888043eba280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >
> > Fixes: 8c55facecd7a ("net: linkwatch: only report IF_OPER_LOWERLAYERDOW=
N if iflink is actually down")
> > Reported-by: syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/674f3a18.050a0220.48a03.0041.GAE=
@google.com/T/#u
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> > Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> >  net/core/link_watch.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/link_watch.c b/net/core/link_watch.c
> > index ab150641142aa1545c71fc5d3b11db33c70cf437..1b4d39e38084272269a5150=
3c217fc1e5a1326eb 100644
> > --- a/net/core/link_watch.c
> > +++ b/net/core/link_watch.c
> > @@ -45,9 +45,14 @@ static unsigned int default_operstate(const struct n=
et_device *dev)
> >               int iflink =3D dev_get_iflink(dev);
> >               struct net_device *peer;
> >
> > -             if (iflink =3D=3D dev->ifindex)
> > +             /* If called from netdev_run_todo()/linkwatch_sync_dev(),
> > +              * dev_net(dev) can be already freed, and RTNL is not hel=
d.
> > +              */
> > +             if (dev->reg_state =3D=3D NETREG_UNREGISTERED ||
> > +                 iflink =3D=3D dev->ifindex)
> >                       return IF_OPER_DOWN;
> >
> > +             ASSERT_RTNL();
> >               peer =3D __dev_get_by_index(dev_net(dev), iflink);
> >               if (!peer)
> >                       return IF_OPER_DOWN;
> > --
> > 2.47.0.338.g60cca15819-goog
> >
>
> Thanks for submitting a patch, the issue makes sense.
>
> Question: is the rtnl_mutex actually held in the problematic case though?
> The netdev_run_todo() call path is:

As explained in the comment, RTNL is not held in this case :

 /* If called from netdev_run_todo()/linkwatch_sync_dev(),
 * dev_net(dev) can be already freed, and RTNL is not held.
 */

In the future, we might change default_operstate() to use dev_get_by_index_=
rcu()
and not rely on RTNL anymore, but after this patch, the ASSERT_RTNL() is fi=
ne.


>
>         __rtnl_unlock();                                                <=
- unlocks
>
>         /* Wait for rcu callbacks to finish before next phase */
>         if (!list_empty(&list))
>                 rcu_barrier();
>
>         list_for_each_entry_safe(dev, tmp, &list, todo_list) {
>                 if (unlikely(dev->reg_state !=3D NETREG_UNREGISTERING)) {
>                         netdev_WARN(dev, "run_todo but not unregistering\=
n");
>                         list_del(&dev->todo_list);
>                         continue;
>                 }
>
>                 WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);

// reg_state is set to NETREG_UNREGISTERING

>                 linkwatch_sync_dev(dev);                                <=
- asserts
>         }
>
> And on the same note: does linkwatch not have a chance to run also,
> concurrently with us, in this timeframe? Could we not catch the
> dev->reg_state in NETREG_UNREGISTERING?

I guess we can add a READ_ONCE() on many dev->reg_state reads.

The race should not matter for linkwatch, if the device is going away.

