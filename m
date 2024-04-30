Return-Path: <netdev+bounces-92475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446868B780F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C164228469C
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 14:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78EC17BB25;
	Tue, 30 Apr 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PsANw0TK"
X-Original-To: netdev@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046817967E
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485692; cv=none; b=Nhs9N6ruSUYsMUID8ijSSIBnWwigknLOqzenSnnKBjsi3ktrk/s/vdiIJK4DpHM1AEZ+LJN5fPJh1UHthYDx/MqxTMHFOOdi6h0V8wqGVBWZiEy3y9SfLtdORa1md3oAn+gtb6e025p2uWvsbiDB8lbOWAfMsAQsIe2hk2BzO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485692; c=relaxed/simple;
	bh=08sbIyLq/0BZHHtlFuVHchghe+EnKbPQBmmp356B0yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNC/kkdqJ/HJXgLYRIOuWPzTq/9zPvUQehzWkNZ/ew+QahGQobvAs42mc1GGlMbv9rFwDB0q2v34H/jCtpKE8qhV1I2VM03PGSoIKWwxPbfyLIOyXwbDtUhEGsrYyge6/oA0UceYtswi0vv8GA1NiUt0ooDUOHI9VyvJYi2ac18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PsANw0TK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d4OXAc72tM+OYN80ge3XsykvEqk70FKU+1pJrtcvhLI=; b=PsANw0TKutgG10TgqaoDY8o337
	zOc3stvBBhOx1abrXj5T09L8X2BufLJrXVem0HYa5XIyfOaSBKw1EKpzQfwCXVfplpRJcuXrG6myf
	zkFZ0GW6ShbaMtyRwZhO4+AqWu7EK7wfy79Zu52T+P+By7w5Ou2ic1c4JQ54y6SsPg0tPNm4G9eCg
	ElR35MOueJsAAr7WAafpnieskYUu/kw1b49mVwm3QDHWO60ivCyfwwDyPd5t0GYMypoZ5fbuNU03y
	uh4mwpxq6bQd1LH9+mR4bGfxxR9LLvDgAhP5cF7qLY1pgp8jF0mf8LdTjX0b3F8IX7062vgYBtEIN
	ymK5laLw==;
Received: from 179-125-79-232-dinamico.pombonet.net.br ([179.125.79.232] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1s1o2q-001nwW-J5; Tue, 30 Apr 2024 16:01:20 +0200
Date: Tue, 30 Apr 2024 11:01:14 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel-dev@igalia.com
Subject: Re: [PATCH] net: fix out-of-bounds access in ops_init
Message-ID: <ZjD5qm3mxdY/iebH@quatroqueijos.cascardo.eti.br>
References: <20240430084253.3272177-1-cascardo@igalia.com>
 <CANn89iJpp7AA=bb_BnYFskWVjf61hd1AgPmU-4ZGOUZQhsYgJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJpp7AA=bb_BnYFskWVjf61hd1AgPmU-4ZGOUZQhsYgJA@mail.gmail.com>

On Tue, Apr 30, 2024 at 11:13:51AM +0200, Eric Dumazet wrote:
> On Tue, Apr 30, 2024 at 10:43 AM Thadeu Lima de Souza Cascardo
> <cascardo@igalia.com> wrote:
> >
> > net_alloc_generic is called by net_alloc, which is called without any
> > locking. It reads max_gen_ptrs, which is changed under pernet_ops_rwsem. It
> > is read twice, first to allocate an array, then to set s.len, which is
> > later used to limit the bounds of the array access.
> >
> > It is possible that the array is allocated and another thread is
> > registering a new pernet ops, increments max_gen_ptrs, which is then used
> > to set s.len with a larger than allocated length for the variable array.
> >
> > Fix it by delaying the allocation to setup_net, which is always called
> > under pernet_ops_rwsem, and is called right after net_alloc.
> >
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
> Good catch !
> 
> Could you provide a Fixes: tag ?
> 

Sorry I didn't include it at first. That would be:

Fixes: 073862ba5d24 ("netns: fix net_alloc_generic()")

> Have you considered reading max_gen_ptrs once in net_alloc_generic() ?
> This would make the patch a little less complicated.
> 

It would look like this "v2" below.

One of the things that may have crossed my mind is that in case of a race, and
max_gen_ptrs is incremented before setup_net is called, it would have to be
reallocated anyway. Though this would be uncommon, that gave me the idea to
implement the solution as I submitted. It seemed easier to get right, instead
of messing around the memory model. :-)

But even if there is a race and we get the value wrong, setup_net will
reallocate it, so it should all be fine as long as we use the same value for
the generic_size calculation and s.len.

And when I read commit 073862ba5d24 ("netns: fix net_alloc_generic()"), it
presented one possible issue with my first solution: in case a net_init
call triggers access to a net ptr that has not been allocated, it may cause
an issue. Thought I noticed later fixes in caif that may be related to
this: it should not be possible to a subsystem to try to access its net ptr
if it has not been initialized yet. And ops_init will only be called when
there is enough room in struct net_generic, that is, net_assign_generic has
been called.

The only problem is that I cannot easily test that this fixes the issue. My
tests for the first version involved adding a delay between the two reads
of max_gen_ptrs and checking they were the same while forcing its
increment.

This has been observed in the field, though, with a KASAN splat:

==================================================================
BUG: KASAN: slab-out-of-bounds in ops_init (/mnt/host/source/src/third_party/kernel/v5.15/net/core/net_namespace.c:0 /mnt/host/source/src/third_party/kernel/v5.15/net/core/net_namespace.c:129) 
Write of size 8 at addr ffff888131bd25b8 by task imageloader/4373

CPU: 0 PID: 4373 Comm: imageloader Tainted: G     U            5.15.148-lockdep-21779-gb0a9bfb0a013 #1 db9ffbffbb2de989c984242ceea60881c9a62dd6
Hardware name: Google Uldren/Uldren, BIOS Google_Uldren.15217.439.0 01/08/2024
Call Trace:
<TASK>
dump_stack_lvl (/mnt/host/source/src/third_party/kernel/v5.15/lib/dump_stack.c:107 (discriminator 2)) 
print_address_description (/mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/report.c:240 (discriminator 6)) 
kasan_report (/mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/report.c:426 (discriminator 6) /mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/report.c:442) 
ops_init (/mnt/host/source/src/third_party/kernel/v5.15/net/core/net_namespace.c:0 /mnt/host/source/src/third_party/kernel/v5.15/net/core/net_namespace.c:129) 
setup_net (/mnt/host/source/src/third_party/kernel/v5.15/net/core/net_namespace.c:329) 
copy_net_ns (/mnt/host/source/src/third_party/kernel/v5.15/net/core/net_namespace.c:473) 
create_new_namespaces (/mnt/host/source/src/third_party/kernel/v5.15/kernel/nsproxy.c:110) 
unshare_nsproxy_namespaces (/mnt/host/source/src/third_party/kernel/v5.15/kernel/nsproxy.c:226 (discriminator 2)) 
ksys_unshare (/mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3116) 
__x64_sys_unshare (/mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3190 /mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3188 /mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3188) 
do_syscall_64 (/mnt/host/source/src/third_party/kernel/v5.15/arch/x86/entry/common.c:55 /mnt/host/source/src/third_party/kernel/v5.15/arch/x86/entry/common.c:93) 
entry_SYSCALL_64_after_hwframe (/mnt/host/source/src/third_party/kernel/v5.15/arch/x86/entry/entry_64.S:118) 
RIP: 0033:0x7a7494514457
Code: 73 01 c3 48 8b 0d c1 a9 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 a9 0b 00 f7 d8 64 89 01 48
All code
========

Code starting with the faulting instruction
===========================================
RSP: 002b:00007fff243cde08 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 0000599532577fe0 RCX: 00007a7494514457
RDX: 0000000000000000 RSI: 00007a7494a0f38d RDI: 0000000040000000
RBP: 00007fff243cdea0 R08: 0000000000000000 R09: 0000599532578a00
R10: 0000000000044000 R11: 0000000000000206 R12: 00007fff243ce190
R13: 00005995325748f0 R14: 0000000000000000 R15: 00007fff243ce221
</TASK>

Allocated by task 4373:
stack_trace_save (/mnt/host/source/src/third_party/kernel/v5.15/kernel/stacktrace.c:123) 
kasan_save_stack (/mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/common.c:39) 
__kasan_kmalloc (/mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/common.c:46 /mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/common.c:434 /mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/common.c:513 /mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/common.c:522) 
__kmalloc (/mnt/host/source/src/third_party/kernel/v5.15/include/linux/kasan.h:264 /mnt/host/source/src/third_party/kernel/v5.15/mm/slub.c:4407) 
copy_net_ns (/mnt/host/source/src/third_party/kernel/v5.15/net/core/net_namespace.c:75 /mnt/host/source/src/third_party/kernel/v5.15/net/core/net_namespace.c:401 /mnt/host/source/src/third_party/kernel/v5.15/net/core/net_namespace.c:460) 
create_new_namespaces (/mnt/host/source/src/third_party/kernel/v5.15/kernel/nsproxy.c:110) 
unshare_nsproxy_namespaces (/mnt/host/source/src/third_party/kernel/v5.15/kernel/nsproxy.c:226 (discriminator 2)) 
ksys_unshare (/mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3116) 
__x64_sys_unshare (/mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3190 /mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3188 /mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3188) 
do_syscall_64 (/mnt/host/source/src/third_party/kernel/v5.15/arch/x86/entry/common.c:55 /mnt/host/source/src/third_party/kernel/v5.15/arch/x86/entry/common.c:93) 
entry_SYSCALL_64_after_hwframe (/mnt/host/source/src/third_party/kernel/v5.15/arch/x86/entry/entry_64.S:118) 

The buggy address belongs to the object at ffff888131bd2500
which belongs to the cache kmalloc-192 of size 192
The buggy address is located 184 bytes inside of
192-byte region [ffff888131bd2500, ffff888131bd25c0)
The buggy address belongs to the page:
page:000000009a3f4539 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x131bd2
flags: 0x8000000000000200(slab|zone=2)
raw: 8000000000000200 0000000000000000 dead000000000122 ffff888100043000
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff888131bd2480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
ffff888131bd2500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888131bd2580: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
^
ffff888131bd2600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff888131bd2680: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
==================================================================


From 32bb3d9ac830410cc5f8228580f2e2b9e6307069 Mon Sep 17 00:00:00 2001
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 29 Apr 2024 11:56:44 -0300
Subject: [PATCH] net: fix out-of-bounds access in ops_init

net_alloc_generic is called by net_alloc, which is called without any
locking. It reads max_gen_ptrs, which is changed under pernet_ops_rwsem. It
is read twice, first to allocate an array, then to set s.len, which is
later used to limit the bounds of the array access.

It is possible that the array is allocated and another thread is
registering a new pernet ops, increments max_gen_ptrs, which is then used
to set s.len with a larger than allocated length for the variable array.

Fix it by reading max_gen_ptrs only once in net_alloc_generic. If
max_gen_ptrs is later incremented, it will be caught in net_assign_generic.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Fixes: 073862ba5d24 ("netns: fix net_alloc_generic()")
---
 net/core/net_namespace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index f0540c557515..4a4f0f87ee36 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -70,11 +70,13 @@ DEFINE_COOKIE(net_cookie);
 static struct net_generic *net_alloc_generic(void)
 {
 	struct net_generic *ng;
-	unsigned int generic_size = offsetof(struct net_generic, ptr[max_gen_ptrs]);
+	unsigned int generic_size;
+	unsigned int gen_ptrs = READ_ONCE(max_gen_ptrs);
+	generic_size = offsetof(struct net_generic, ptr[gen_ptrs]);
 
 	ng = kzalloc(generic_size, GFP_KERNEL);
 	if (ng)
-		ng->s.len = max_gen_ptrs;
+		ng->s.len = gen_ptrs;
 
 	return ng;
 }
@@ -1307,7 +1309,12 @@ static int register_pernet_operations(struct list_head *list,
 		if (error < 0)
 			return error;
 		*ops->id = error;
-		max_gen_ptrs = max(max_gen_ptrs, *ops->id + 1);
+		/*
+		 * This does not require READ_ONCE as writers will take
+		 * pernet_ops_rwsem. But WRITE_ONCE is needed to protect
+		 * net_alloc_generic.
+		 */
+		WRITE_ONCE(max_gen_ptrs, max(max_gen_ptrs, *ops->id + 1));
 	}
 	error = __register_pernet_operations(list, ops);
 	if (error) {
-- 
2.34.1


> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 2f5190aa2f15cec2e934ebee9c502fb426cf0d7d..dc198ce7e6aeabd8831be32f0a3b5bd1d0a77315
> 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -70,11 +70,12 @@ DEFINE_COOKIE(net_cookie);
>  static struct net_generic *net_alloc_generic(void)
>  {
>         struct net_generic *ng;
> -       unsigned int generic_size = offsetof(struct net_generic,
> ptr[max_gen_ptrs]);
> +       /* Paired with WRITE_ONCE() in register_pernet_operations() */
> +       unsigned int max = READ_ONCE(max_gen_ptrs);
> 
> -       ng = kzalloc(generic_size, GFP_KERNEL);
> +       ng = kzalloc(offsetof(struct net_generic, ptr[max]), GFP_KERNEL);
>         if (ng)
> -               ng->s.len = max_gen_ptrs;
> +               ng->s.len = max;
> 
>         return ng;
>  }
> @@ -1308,7 +1309,9 @@ static int register_pernet_operations(struct
> list_head *list,
>                 if (error < 0)
>                         return error;
>                 *ops->id = error;
> -               max_gen_ptrs = max(max_gen_ptrs, *ops->id + 1);
> +               /* Paired with READ_ONCE() in net_alloc_generic() */
> +               WRITE_ONCE(max_gen_ptrs,
> +                          max(max_gen_ptrs, *ops->id + 1));
>         }
>         error = __register_pernet_operations(list, ops);
>         if (error) {
> 

