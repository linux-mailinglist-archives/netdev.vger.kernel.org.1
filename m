Return-Path: <netdev+bounces-248254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392B8D05DF1
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 20:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 564103011ED5
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC032A3D7;
	Thu,  8 Jan 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCqYy7uP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288BA320CA6
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900797; cv=none; b=ml97jP9DVLIPXNQesO4HtUAaqn7Hj73QsW7mZ94EQeAUv71r7BFc/aY3fiMmzqx5PXURsG9nuXChUyEQ4GTqL0E5uQ6fON6TY1IPgZ/glXaXcEroSRd0b4bf2lsd5LU/vvU/r0E8dk88kiT08k/3PgEhRCJaoxAs+i83vDn6BfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900797; c=relaxed/simple;
	bh=NPuELo9Qfy+E4iLiKZcDDU5DxTWXdm48FHqdM4oWnmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEBxd/s4ynWp4B9Bhrt3EoXLjm4N0uu5R4Quv5EHL/tytgZV1KXXQxe2RWYafZkfCLahsVwZ+jwBL19udrvK5YDMqsVr2QMuWdBgnYhyOtNLehQXujKg4Ao6XeSh0Oq6RVSBUol499fvBlJZF6TZpj6oiBfqzAtGqCRIvtFl/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCqYy7uP; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed7024c8c5so28383221cf.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 11:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767900795; x=1768505595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmgF7mbd9iMZ9f2CGpfMBZvZcivhSSGriEqIFUudbo8=;
        b=LCqYy7uPmqzWBwib9VhPUDKzilo8L749bPTHoh89GixcCaxnFGRJgxBIMK4n37PqPL
         MBruS9VhwyKvuP3Np2TM5igWYC+JGjDbZVauU3gbf2egDZP0D7zcZdbumRNwQVaDcGmT
         34vL6QluAtzCapAdJy5dW4jCQY8ttoU8okKxf0CDJDykefHusOlgC9CY/IsgUTKrFmsF
         msKFTw/5+FZ88X067KTc2/IHPdtB39IvLNniCNVClCz5nU2EhxgdVvmP09ozaO3f52Qe
         RJgDUvb4gOcDSUmgMaxe+bgkBT6HUWV5UC3NsUCwoWxLp8eKKC8yev62wD+WNkR3y121
         oocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767900795; x=1768505595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmgF7mbd9iMZ9f2CGpfMBZvZcivhSSGriEqIFUudbo8=;
        b=sLxL5toggVKBFPFlvLGlwFsTXrvbEPvqaOH1Md4bM6rvM++vCsFak3STdYRiNtVhVF
         6ZLh1jtWq9aZRbNBjJvM1ZbECybbi5Tpuhs3ASoctFs0p31Maaadrlr28J7B98F6kR/Q
         jMECOr07POKh6jcTiwpygdt9z3QrNQ668yxgHwXKpJOdYVIaGigRHAgmBvtwdndskFJ8
         FxukI/s0aTwO6UuZijVRcsEvq3BwjfWHvUUWtz9yG4uszvga1Z9dwS3jVlblptKBAly7
         Z8mfcdudiEhlT4a8kJi0bUsN+MrUW8+OGE22LDWW+vXAbwqq/cqImtJoTzOMwjjZ2fpn
         JSFw==
X-Gm-Message-State: AOJu0Yz2kBLgPBhRfuSfP80+qW2XEiG6bioQmAwKpoUb4lrXp34lDOKb
	PeqY63PF5Kfr0YJ9OxGEaVI2lblUuQzjt6Ps9hMTmKv5wk01dd2C84EU+B3u51QzL6754XHN9oQ
	2XBmncXktASDMSu35aBIpnaQC3qI8AjP2RDlr4bVD
X-Gm-Gg: AY/fxX5O5sLlfGTr9YTOovvIySMQ7QtWu7Y4yjZxOAFoB9wdnPM9kJSC5+bEBRXo1d0
	SuDGcLXlSDXQugzJqP4MPqjKqIFXOL0+EDn1PPGJVNi73aOnMrarDo3Q9o3PSR2HwLnWoVflWQo
	tWGBpJWpJIwhK5GCVoAOKL/sLRS5IrelQmI/OadZwJAhQjK6m1oALM1s//qfVsX62umGwZDr75z
	mGaxzDYsp5pAiVieAj6uFQb3p6Wl7TDwtXeXxAvKYvIvTk8fsQ0l+YRtgtUKzRQVrhJzdQ=
X-Google-Smtp-Source: AGHT+IFtAOdcKw3NzabHT6MTquOGsAno6bfAdMIuPmf3zW3U5k80soJu0Hrc3gNn/18pWtUhnFUfVy6Bt8632ZUuo8Q=
X-Received: by 2002:a05:622a:19a0:b0:4ed:6e70:1ac4 with SMTP id
 d75a77b69052e-4ffb4a3e8bcmr103838901cf.42.1767900794688; Thu, 08 Jan 2026
 11:33:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+x2LGnBJES1y0HWQC2xVo__53_QHFYjuSs7s6+ShNBtw@mail.gmail.com>
 <20260108191930.145655-1-boudewijn@delta-utec.com>
In-Reply-To: <20260108191930.145655-1-boudewijn@delta-utec.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Jan 2026 20:33:03 +0100
X-Gm-Features: AQt7F2rj5uDBdzoWDA9ik_OyV8lySmb61QcdZLmu53-nw79qasVCEgzuhYmids4
Message-ID: <CANn89iKnnVJGCCmsiDZ4CqYJKjEWN3PREwaVXLzOBWqDKhOxtA@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: Fix use-after-free in macvlan_common_newlink
To: Boudewijn van der Heide <boudewijn@delta-utec.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 8:19=E2=80=AFPM Boudewijn van der Heide
<boudewijn@delta-utec.com> wrote:
>
> Hi Eric,
>
> Thanks for the patch, I agree it improves safety for source-entry deletio=
n.
>
> However, I believe it does not fix the specific KASAN report from syzbot,
> which indicates a UAF on the struct macvlan_port itself, not a source ent=
ry.
>

It completely fixes the problem.

Crash occurs in

            if (entry->vlan->flags & MACVLAN_FLAG_NODST)

because entry->vlan has been freed already :

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in macvlan_forward_source+0x512/0x630
drivers/net/macvlan.c:436
Read of size 2 at addr ffff888029fb8dfc by task syz.1.2073/14062

CPU: 0 UID: 0 PID: 14062 Comm: syz.1.2073 Not tainted syzkaller #0 PREEMPT(=
full)
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 10/25/2025
Call Trace:
<TASK>
dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
print_address_description mm/kasan/report.c:378 [inline]
print_report+0xca/0x240 mm/kasan/report.c:482
kasan_report+0x118/0x150 mm/kasan/report.c:595
macvlan_forward_source+0x512/0x630 drivers/net/macvlan.c:436
macvlan_handle_frame+0x1ba/0x12e0 drivers/net/macvlan.c:495
__netif_receive_skb_core+0x95f/0x2f90 net/core/dev.c:6024
__netif_receive_skb_one_core net/core/dev.c:6135 [inline]
__netif_receive_skb+0x72/0x380 net/core/dev.c:6250
netif_receive_skb_internal net/core/dev.c:6336 [inline]
netif_receive_skb+0x1bb/0x750 net/core/dev.c:6395
tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
tun_get_user+0x2aa3/0x3dc0 drivers/net/tun.c:1953
tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
new_sync_write fs/read_write.c:593 [inline]
vfs_write+0x5c9/0xb30 fs/read_write.c:686
ksys_write+0x145/0x250 fs/read_write.c:738
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f90edf8e1ff
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54
24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007f90eedb6000 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f90ee1e6180 RCX: 00007f90edf8e1ff
RDX: 000000000000004e RSI: 0000200000000180 RDI: 00000000000000c8
RBP: 00007f90ee013f91 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000004e R11: 0000000000000293 R12: 0000000000000000
R13: 00007f90ee1e6218 R14: 00007f90ee1e6180 R15: 00007ffd5dc50558
</TASK>

Allocated by task 13998:
kasan_save_stack mm/kasan/common.c:56 [inline]
kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
__kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
kasan_kmalloc include/linux/kasan.h:262 [inline]
__do_kmalloc_node mm/slub.c:5657 [inline]
__kvmalloc_node_noprof+0x5d5/0x920 mm/slub.c:7134
alloc_netdev_mqs+0xa6/0x11b0 net/core/dev.c:11997
vti6_init_net+0x104/0x370 net/ipv6/ip6_vti.c:1146
ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
setup_net+0x110/0x330 net/core/net_namespace.c:446
copy_net_ns+0x3e3/0x570 net/core/net_namespace.c:581
create_new_namespaces+0x3e7/0x6a0 kernel/nsproxy.c:130
unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:226
ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3171
__do_sys_unshare kernel/fork.c:3242 [inline]
__se_sys_unshare kernel/fork.c:3240 [inline]
__x64_sys_unshare+0x38/0x50 kernel/fork.c:3240
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 13998:
kasan_save_stack mm/kasan/common.c:56 [inline]
kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
poison_slab_object mm/kasan/common.c:252 [inline]
__kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
kasan_slab_free include/linux/kasan.h:234 [inline]
slab_free_hook mm/slub.c:2540 [inline]
slab_free mm/slub.c:6668 [inline]
kfree+0x1c0/0x660 mm/slub.c:6876
vti6_init_net+0x2e2/0x370 net/ipv6/ip6_vti.c:1168
ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
setup_net+0x110/0x330 net/core/net_namespace.c:446
copy_net_ns+0x3e3/0x570 net/core/net_namespace.c:581
create_new_namespaces+0x3e7/0x6a0 kernel/nsproxy.c:130
unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:226
ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3171
__do_sys_unshare kernel/fork.c:3242 [inline]
__se_sys_unshare kernel/fork.c:3240 [inline]
__x64_sys_unshare+0x38/0x50 kernel/fork.c:3240
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888029fb8000
which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3580 bytes inside of
freed 4096-byte region [ffff888029fb8000, ffff888029fb9000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29fb8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88803317c501
anon flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813ffb0500 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000000f5000000 ffff88803317c501
head: 00fff00000000040 ffff88813ffb0500 0000000000000000 dead000000000001
head: 0000000000000000 0000000000040004 00000000f5000000 ffff88803317c501
head: 00fff00000000003 ffffea0000a7ee01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEM=
ALLOC),
pid 11169, tgid 11169 (modprobe), ts 207829820236, free_ts
207789169305
set_page_owner include/linux/page_owner.h:32 [inline]
post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
prep_new_page mm/page_alloc.c:1854 [inline]
get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3915
__alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
alloc_slab_page mm/slub.c:3075 [inline]
allocate_slab+0x86/0x3b0 mm/slub.c:3248
new_slab mm/slub.c:3302 [inline]
___slab_alloc+0xf2b/0x1960 mm/slub.c:4656
__slab_alloc+0x65/0x100 mm/slub.c:4779
__slab_alloc_node mm/slub.c:4855 [inline]
slab_alloc_node mm/slub.c:5251 [inline]
__do_kmalloc_node mm/slub.c:5656 [inline]
__kvmalloc_node_noprof+0x6b6/0x920 mm/slub.c:7134
seq_buf_alloc fs/seq_file.c:38 [inline]
seq_read_iter+0x202/0xe20 fs/seq_file.c:210
proc_reg_read_iter+0x1b7/0x280 fs/proc/inode.c:299
new_sync_read fs/read_write.c:491 [inline]
vfs_read+0x55a/0xa30 fs/read_write.c:572
ksys_read+0x145/0x250 fs/read_write.c:715
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 11127 tgid 11119 stack trace:
reset_page_owner include/linux/page_owner.h:25 [inline]
free_pages_prepare mm/page_alloc.c:1395 [inline]
__free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
__folio_put+0x21b/0x2c0 mm/swap.c:112
folio_put include/linux/mm.h:1612 [inline]
put_page include/linux/mm.h:1681 [inline]
do_exit+0x183b/0x2310 kernel/exit.c:1002
do_group_exit+0x21c/0x2d0 kernel/exit.c:1112
get_signal+0x1285/0x1340 kernel/signal.c:3034
arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
__exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
exit_to_user_mode_loop+0x87/0x4f0 kernel/entry/common.c:75
__exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inl=
ine]
syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
do_syscall_64+0x2d0/0xf80 arch/x86/entry/syscall_64.c:100
entry_SYSCALL_64_after_hwframe+0x77/0x7f




> The report shows the freed object is in kmalloc-cg-4k (size 4096):
>
> The buggy address belongs to the object at ffff888030eda000
> which belongs to the cache kmalloc-cg-4k of size 4096
>
> struct macvlan_port fits this size (due to the large hash tables),
> whereas struct macvlan_source_entry is much smaller.
> The crash happens at offset 3580, which corresponds to the vlan_source_ha=
sh array inside the port:
>
> The race occurs in the register_netdevice() error path in macvlan_common_=
newlink():
>
> 1. netdev_rx_handler_register() succeeds
> 2. register_netdevice() fails.
> 3. macvlan_port_destroy() is called, performing a synchronous kfree(port)=
.
>
> If a packet arrives during step 3,
> macvlan_handle_frame() accesses port->vlan_source_hash (via macvlan_forwa=
rd_source),
> after it is freed.
>
> My patch restores the kfree_rcu behavior for the port (removed in 2016).
> I believe both fixes are needed: yours for the source entries, and mine f=
or the port itself.

I do not think your patch is needed.

Let's wait after my patch is merged, we will see if new syzbot reports
are found.

