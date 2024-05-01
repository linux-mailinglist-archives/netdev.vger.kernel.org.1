Return-Path: <netdev+bounces-92772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5098B8C71
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 17:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C382815AF
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E3A12F37C;
	Wed,  1 May 2024 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUS7XWhb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D751F176
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575977; cv=none; b=f3wt+ey8HUegP3GGhx89BHkiCTA4b+5lDm/+YJr7XyY2BOQcwwyO5drw8OVYCbD6S4TaxtjnbtwP2S8byzoR4D51m7CYyY2J4kd9N3Ok7LLkKQmc5iXIqSWGdX5s3lARVimrQzS6YhSGUGcXGYUKtaAGNk+QFWx+2FgYmDjhkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575977; c=relaxed/simple;
	bh=guct/nIvs52wbGMo/0gdXtH/sMaIOnNOV287mpX6xMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sENI3tXKvs+tfsP1GjBHlBnO4yozz0EyO2ZigOuppsIHXr9W4649NY3m1sQMrDu2GNoD9W4JaYgUzaB88BYAvVMRKNDYFHMzY5jKfg/nIKHQOSB5Smd/v4xv2gDBzVeuGlGtBo4BJ6cka2s1zo3/t6AezwwCcnJDezMr6ocHHd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUS7XWhb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso1343a12.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714575974; x=1715180774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RG6cIszogylDndqYVzO0atWyZ6Q82DP/0ycA6kQw5xo=;
        b=OUS7XWhboARnQ7Gk2nF+/BGKlYw76dnyBJXcqrpI/kh+v4Rp1T/LB2YxW5BBnk9AoD
         8guiWcgnUiAjJi4TqsXHw7Xg7y4qfJKOxVt9rRGukd7vTce2dyPIIsQ669k39RCHhQ5c
         fQNFb6nxURWNZ6HJ3+I4ouW9M0whP24K72YouXk2vFAyCNQDiE42KpTuniAiiUZBIQU7
         /Uo8K2KUFKtyyoYxPHZwhYy1JAxMOflOIonnGap+1XY5DW6z4K67tcK5qt55D+AlV6m6
         84XxDiGBWKh1hkbn+eWWRjsaeJka49n+b69ndTGxsLitVp4kSrn7VW8h1TzO++F9hwMd
         nAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575974; x=1715180774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RG6cIszogylDndqYVzO0atWyZ6Q82DP/0ycA6kQw5xo=;
        b=SfOX9ewm50VYDbT9Vd1qhgMxGOUxXDLLmNXIkIcjDEP6G6FkCrmjW7rSrASUtur3GK
         /yQ/4WmACL0fvjUXZxpR0PBHoG7Ld/7LxoCTklTSaKlZe9tDGgeurIKOMyX6QDh4r6yX
         eM/Q9Z/GaEpJ6jBXEmjKLtaFq/ORku56GNH4Z+YT6k9C4k3dN/rhTSIgzVOg1bRn5A6B
         49PDcxFrRkR6QRJh7RHNkWYSi76OjpDP+IcB/LWroMVPwMSc/lMwUj30nq18upCQhsEm
         ZzBpMYV6OXbmF9ILgbngeN+DSJ2/5ISR3aflgakgbHF9wkuPOzOADPWp+9U+XYjgMWSC
         oR3w==
X-Gm-Message-State: AOJu0YwFq7iz5gr/y/q0erFE+KYBrAE4T6nT0dibIHwCP6YTvd3dUNVu
	iKJJ2VsmiLy8J1kyU8GD7sSeSFNTRrr33ckbDleGVtwJ/7gvkw2nLRtxGA5O9Bi9b77ahcGnF/8
	c2VYdYjC9f6MZ9GHMLCw5YJblbgUl52iDt0qT
X-Google-Smtp-Source: AGHT+IHnF5qSOqepmxO0mX9bf4IEfXbOO5mVRtyIJPFvSnnJDnfaaYAxxy+dRkGgBTJ4Div9lEqS0eulxpRROVt1NS4=
X-Received: by 2002:aa7:d759:0:b0:572:a33d:437f with SMTP id
 a25-20020aa7d759000000b00572a33d437fmr211384eds.2.1714575973713; Wed, 01 May
 2024 08:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430084253.3272177-1-cascardo@igalia.com> <CANn89iJpp7AA=bb_BnYFskWVjf61hd1AgPmU-4ZGOUZQhsYgJA@mail.gmail.com>
 <ZjD5qm3mxdY/iebH@quatroqueijos.cascardo.eti.br>
In-Reply-To: <ZjD5qm3mxdY/iebH@quatroqueijos.cascardo.eti.br>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 May 2024 17:05:59 +0200
Message-ID: <CANn89iK0nCQFgA_2UaN4857fQKip0tsraCEQGhF=h8RJKKJnPw@mail.gmail.com>
Subject: Re: [PATCH] net: fix out-of-bounds access in ops_init
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:01=E2=80=AFPM Thadeu Lima de Souza Cascardo
<cascardo@igalia.com> wrote:
>
> On Tue, Apr 30, 2024 at 11:13:51AM +0200, Eric Dumazet wrote:
> > On Tue, Apr 30, 2024 at 10:43=E2=80=AFAM Thadeu Lima de Souza Cascardo
> > <cascardo@igalia.com> wrote:
> > >
> > > net_alloc_generic is called by net_alloc, which is called without any
> > > locking. It reads max_gen_ptrs, which is changed under pernet_ops_rws=
em. It
> > > is read twice, first to allocate an array, then to set s.len, which i=
s
> > > later used to limit the bounds of the array access.
> > >
> > > It is possible that the array is allocated and another thread is
> > > registering a new pernet ops, increments max_gen_ptrs, which is then =
used
> > > to set s.len with a larger than allocated length for the variable arr=
ay.
> > >
> > > Fix it by delaying the allocation to setup_net, which is always calle=
d
> > > under pernet_ops_rwsem, and is called right after net_alloc.
> > >
> > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> >
> > Good catch !
> >
> > Could you provide a Fixes: tag ?
> >
>
> Sorry I didn't include it at first. That would be:
>
> Fixes: 073862ba5d24 ("netns: fix net_alloc_generic()")
>
> > Have you considered reading max_gen_ptrs once in net_alloc_generic() ?
> > This would make the patch a little less complicated.
> >
>
> It would look like this "v2" below.
>
> One of the things that may have crossed my mind is that in case of a race=
, and
> max_gen_ptrs is incremented before setup_net is called, it would have to =
be
> reallocated anyway. Though this would be uncommon, that gave me the idea =
to
> implement the solution as I submitted. It seemed easier to get right, ins=
tead
> of messing around the memory model. :-)
>
> But even if there is a race and we get the value wrong, setup_net will
> reallocate it, so it should all be fine as long as we use the same value =
for
> the generic_size calculation and s.len.
>
> And when I read commit 073862ba5d24 ("netns: fix net_alloc_generic()"), i=
t
> presented one possible issue with my first solution: in case a net_init
> call triggers access to a net ptr that has not been allocated, it may cau=
se
> an issue. Thought I noticed later fixes in caif that may be related to
> this: it should not be possible to a subsystem to try to access its net p=
tr
> if it has not been initialized yet. And ops_init will only be called when
> there is enough room in struct net_generic, that is, net_assign_generic h=
as
> been called.
>
> The only problem is that I cannot easily test that this fixes the issue. =
My
> tests for the first version involved adding a delay between the two reads
> of max_gen_ptrs and checking they were the same while forcing its
> increment.
>
> This has been observed in the field, though, with a KASAN splat:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in ops_init (/mnt/host/source/src/third_pa=
rty/kernel/v5.15/net/core/net_namespace.c:0 /mnt/host/source/src/third_part=
y/kernel/v5.15/net/core/net_namespace.c:129)
> Write of size 8 at addr ffff888131bd25b8 by task imageloader/4373
>
> CPU: 0 PID: 4373 Comm: imageloader Tainted: G     U            5.15.148-l=
ockdep-21779-gb0a9bfb0a013 #1 db9ffbffbb2de989c984242ceea60881c9a62dd6
> Hardware name: Google Uldren/Uldren, BIOS Google_Uldren.15217.439.0 01/08=
/2024
> Call Trace:
> <TASK>
> dump_stack_lvl (/mnt/host/source/src/third_party/kernel/v5.15/lib/dump_st=
ack.c:107 (discriminator 2))
> print_address_description (/mnt/host/source/src/third_party/kernel/v5.15/=
mm/kasan/report.c:240 (discriminator 6))
> kasan_report (/mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/repo=
rt.c:426 (discriminator 6) /mnt/host/source/src/third_party/kernel/v5.15/mm=
/kasan/report.c:442)
> ops_init (/mnt/host/source/src/third_party/kernel/v5.15/net/core/net_name=
space.c:0 /mnt/host/source/src/third_party/kernel/v5.15/net/core/net_namesp=
ace.c:129)
> setup_net (/mnt/host/source/src/third_party/kernel/v5.15/net/core/net_nam=
espace.c:329)
> copy_net_ns (/mnt/host/source/src/third_party/kernel/v5.15/net/core/net_n=
amespace.c:473)
> create_new_namespaces (/mnt/host/source/src/third_party/kernel/v5.15/kern=
el/nsproxy.c:110)
> unshare_nsproxy_namespaces (/mnt/host/source/src/third_party/kernel/v5.15=
/kernel/nsproxy.c:226 (discriminator 2))
> ksys_unshare (/mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c=
:3116)
> __x64_sys_unshare (/mnt/host/source/src/third_party/kernel/v5.15/kernel/f=
ork.c:3190 /mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3188=
 /mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3188)
> do_syscall_64 (/mnt/host/source/src/third_party/kernel/v5.15/arch/x86/ent=
ry/common.c:55 /mnt/host/source/src/third_party/kernel/v5.15/arch/x86/entry=
/common.c:93)
> entry_SYSCALL_64_after_hwframe (/mnt/host/source/src/third_party/kernel/v=
5.15/arch/x86/entry/entry_64.S:118)
> RIP: 0033:0x7a7494514457
> Code: 73 01 c3 48 8b 0d c1 a9 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d 91 a9 0b 00 f7 d8 64 89 01 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RSP: 002b:00007fff243cde08 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
> RAX: ffffffffffffffda RBX: 0000599532577fe0 RCX: 00007a7494514457
> RDX: 0000000000000000 RSI: 00007a7494a0f38d RDI: 0000000040000000
> RBP: 00007fff243cdea0 R08: 0000000000000000 R09: 0000599532578a00
> R10: 0000000000044000 R11: 0000000000000206 R12: 00007fff243ce190
> R13: 00005995325748f0 R14: 0000000000000000 R15: 00007fff243ce221
> </TASK>
>
> Allocated by task 4373:
> stack_trace_save (/mnt/host/source/src/third_party/kernel/v5.15/kernel/st=
acktrace.c:123)
> kasan_save_stack (/mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/=
common.c:39)
> __kasan_kmalloc (/mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/c=
ommon.c:46 /mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/common.c:=
434 /mnt/host/source/src/third_party/kernel/v5.15/mm/kasan/common.c:513 /mn=
t/host/source/src/third_party/kernel/v5.15/mm/kasan/common.c:522)
> __kmalloc (/mnt/host/source/src/third_party/kernel/v5.15/include/linux/ka=
san.h:264 /mnt/host/source/src/third_party/kernel/v5.15/mm/slub.c:4407)
> copy_net_ns (/mnt/host/source/src/third_party/kernel/v5.15/net/core/net_n=
amespace.c:75 /mnt/host/source/src/third_party/kernel/v5.15/net/core/net_na=
mespace.c:401 /mnt/host/source/src/third_party/kernel/v5.15/net/core/net_na=
mespace.c:460)
> create_new_namespaces (/mnt/host/source/src/third_party/kernel/v5.15/kern=
el/nsproxy.c:110)
> unshare_nsproxy_namespaces (/mnt/host/source/src/third_party/kernel/v5.15=
/kernel/nsproxy.c:226 (discriminator 2))
> ksys_unshare (/mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c=
:3116)
> __x64_sys_unshare (/mnt/host/source/src/third_party/kernel/v5.15/kernel/f=
ork.c:3190 /mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3188=
 /mnt/host/source/src/third_party/kernel/v5.15/kernel/fork.c:3188)
> do_syscall_64 (/mnt/host/source/src/third_party/kernel/v5.15/arch/x86/ent=
ry/common.c:55 /mnt/host/source/src/third_party/kernel/v5.15/arch/x86/entry=
/common.c:93)
> entry_SYSCALL_64_after_hwframe (/mnt/host/source/src/third_party/kernel/v=
5.15/arch/x86/entry/entry_64.S:118)
>
> The buggy address belongs to the object at ffff888131bd2500
> which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 184 bytes inside of
> 192-byte region [ffff888131bd2500, ffff888131bd25c0)
> The buggy address belongs to the page:
> page:000000009a3f4539 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x131bd2
> flags: 0x8000000000000200(slab|zone=3D2)
> raw: 8000000000000200 0000000000000000 dead000000000122 ffff888100043000
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
> ffff888131bd2480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff888131bd2500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff888131bd2580: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
> ^
> ffff888131bd2600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff888131bd2680: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> From 32bb3d9ac830410cc5f8228580f2e2b9e6307069 Mon Sep 17 00:00:00 2001
> From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Date: Mon, 29 Apr 2024 11:56:44 -0300
> Subject: [PATCH] net: fix out-of-bounds access in ops_init
>
> net_alloc_generic is called by net_alloc, which is called without any
> locking. It reads max_gen_ptrs, which is changed under pernet_ops_rwsem. =
It
> is read twice, first to allocate an array, then to set s.len, which is
> later used to limit the bounds of the array access.
>
> It is possible that the array is allocated and another thread is
> registering a new pernet ops, increments max_gen_ptrs, which is then used
> to set s.len with a larger than allocated length for the variable array.
>
> Fix it by reading max_gen_ptrs only once in net_alloc_generic. If
> max_gen_ptrs is later incremented, it will be caught in net_assign_generi=
c.
>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Fixes: 073862ba5d24 ("netns: fix net_alloc_generic()")
> ---
>  net/core/net_namespace.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index f0540c557515..4a4f0f87ee36 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -70,11 +70,13 @@ DEFINE_COOKIE(net_cookie);
>  static struct net_generic *net_alloc_generic(void)
>  {
>         struct net_generic *ng;
> -       unsigned int generic_size =3D offsetof(struct net_generic, ptr[ma=
x_gen_ptrs]);
> +       unsigned int generic_size;
> +       unsigned int gen_ptrs =3D READ_ONCE(max_gen_ptrs);
> +       generic_size =3D offsetof(struct net_generic, ptr[gen_ptrs]);
>
>         ng =3D kzalloc(generic_size, GFP_KERNEL);
>         if (ng)
> -               ng->s.len =3D max_gen_ptrs;
> +               ng->s.len =3D gen_ptrs;
>
>         return ng;
>  }
> @@ -1307,7 +1309,12 @@ static int register_pernet_operations(struct list_=
head *list,
>                 if (error < 0)
>                         return error;
>                 *ops->id =3D error;
> -               max_gen_ptrs =3D max(max_gen_ptrs, *ops->id + 1);
> +               /*
> +                * This does not require READ_ONCE as writers will take
> +                * pernet_ops_rwsem. But WRITE_ONCE is needed to protect
> +                * net_alloc_generic.
> +                */
> +               WRITE_ONCE(max_gen_ptrs, max(max_gen_ptrs, *ops->id + 1))=
;
>         }
>         error =3D __register_pernet_operations(list, ops);
>         if (error) {
> --
> 2.34.1
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

I think you have to post this patch in the conventional way, so that
patchwork can catch up.

Thanks.

