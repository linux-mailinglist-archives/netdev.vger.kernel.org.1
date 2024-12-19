Return-Path: <netdev+bounces-153338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56F29F7B56
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36F21893473
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA222576A;
	Thu, 19 Dec 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsyKcFLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA4225411;
	Thu, 19 Dec 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611426; cv=none; b=SI9c56inUfLxOUyAFBP7D7RXEAAGBv3rCjWj1PGrE7mLKvvyZD8IvLcUPoIZjP/S8sn80weWZZh4lqIcjw6Uh/7tboem/b6jJGZiBE+FyrHhVfSzZnfN6/6QVFmp0e9t9dKN44wDR52JxHV00mwRWwBOfv140PRdDOXzsTjA+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611426; c=relaxed/simple;
	bh=AwwQ6fljEH73DExXdfvc73SBZroGrk/hLyQPr/R626Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpdLe2C2KA2X/YjcTWjy2ajKDh/i+6Rv3/5ZUznPaJCXQx9qq6dc3tPEymCIIbqjehuBtvb+Ck+Dq9tpWesAdlIEY9DaFFsgMIyW+JtZIrUDlOMgGXlNX0icKc12QNYVPevKP2soQAaxy/C5tlJpnqya1xTvB1NtEgduY4G4zBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsyKcFLz; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-300479ca5c6so8158511fa.3;
        Thu, 19 Dec 2024 04:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734611423; x=1735216223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CSrGUH3NrD18LyCEhcV9StUyvJblY2gP/yLohuQHeo=;
        b=JsyKcFLzwtItZW+OfdbU/Pt8iCLooeS97C7v44E/CrwVwNpatJd9c85EZcDH0tzxs/
         Xvj2R3eg2MYIYdwm0s+G4v1kqm00tK1lZtYD5K51KatTlkgc1Cgscy8FqvxrmOiVDnRp
         SMQUjBWnLGLofHODgFwNNK+obXp7vEMmhYD9mRMDQeQEtGAposBtPDHaEyDpDZ6rYjt+
         TXLSLOBBHngkhjRYfRsvue0HzfHW6N0ZMoqHoTb58bi9XTL2ZQ+r7u9GVzi8hLkwLNHf
         R/RnZ+PNNwkJPhCeDhoFUY+ku5pGwjpZFJ4l94pl88ouq6osk5ioPh1c6wKiVfvITGt0
         nhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611423; x=1735216223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CSrGUH3NrD18LyCEhcV9StUyvJblY2gP/yLohuQHeo=;
        b=qGZ8fx7ta0tUWknRqCiJFV59M+AgB8bWKsWRa/j0+xfAlJz3M0JbFmz0d5DRASyx29
         PtYBTGcC5XG9+sV/b+YVO8DfkKd2N6Uo5y0/vfRNV1thF+v/UZ14diNpUQKXFySNuq4V
         gIeLVXfRmfs9Xg0NGqf+0zenmzQu/jSQaDbjDuLJcwKw9Gh1aATUEmbqz1/xD7aNpW4L
         AuOZftHZmWDMyzzXjlPexBj+dZV8CvxxctfCnmipkwkzJvBWKBoLyfG4vBOjgOnapAxK
         qlBFARR3EcAaknubZpr6c5zk99nxKYohudieeHHLhSHF0ooGZ66X6RLh/m2e6/sWAxGM
         E/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUkPNfVcWE4MnJ4WOr0L4IaWyjYZk7pjjwQTgYjSQNjfivWp/TpXrHl3cxlA2/qRhy8uTtoQ7UoHTU3KTY=@vger.kernel.org, AJvYcCXLpTSxjQfByga4EmjPeBS4oyMtKSR0BpMDGs7CH89WQ93IgARggBE7Ij6oM/tZkOkwy/71UVRo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2x0ZwRAAXvPf5l3fBFzZZ41zKpVETzGFBy1VhOYbGg/lMTI/a
	ncAy5gZy8q7D98iL4yyMXZy/HRZyGNaTVE0ORw0Q317LEmg84KOvHm2pBoa89VXXnFhuvq0u3ff
	U4WLDY0khLb22IB02EhzWF8tuidY=
X-Gm-Gg: ASbGncuGntsnbuemVtxUdLAbHS8DoT5JSsP8s7NQrac39t3KQU7Ewcs3ZFfUlpS3yIv
	C9caJNlEbomXvF/7YfI8efff8XYDx4bYKa4eBcg==
X-Google-Smtp-Source: AGHT+IE4JpIEKfJNH3pXnP+ZnARBHTULfSNB6E1995L0VRqbBETfN7RtqZem1NeHDWTS4AQo+YDv2Y7et78j924kwFQ=
X-Received: by 2002:a2e:b893:0:b0:300:3a15:8f22 with SMTP id
 38308e7fff4ca-3044db138b8mr24653961fa.21.1734611422264; Thu, 19 Dec 2024
 04:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219121828.2120780-1-gal@nvidia.com>
In-Reply-To: <20241219121828.2120780-1-gal@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 19 Dec 2024 13:30:10 +0100
Message-ID: <CAFULd4YHFFKBzaF28f8n3z8WcOzom1WUe_hfRBx0ehhCpT9xnQ@mail.gmail.com>
Subject: Re: [PATCH] percpu: Remove intermediate variable in PERCPU_PTR()
To: Gal Pressman <gal@nvidia.com>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 1:18=E2=80=AFPM Gal Pressman <gal@nvidia.com> wrote=
:
>
> The intermediate variable in the PERCPU_PTR() macro results in a kernel
> panic on boot [1] due to a compiler bug seen when compiling the kernel
> (+ KASAN) with gcc 11.3.1, but not when compiling with latest gcc
> (v14.2)/clang(v18.1).
>
> To solve it, remove the intermediate variable (which is not needed) and
> keep the casting that resolves the address space checks.
>
> [1]
>   Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000003: 0000 [#1] SMP KASAN
>   KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>   CPU: 0 UID: 0 PID: 547 Comm: iptables Not tainted 6.13.0-rc1_external_t=
ested-master #1
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-g=
f21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:nf_ct_netns_do_get+0x139/0x540
>   Code: 03 00 00 48 81 c4 88 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 4d=
 8d 75 08 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 =
84 c0 74 08 3c 03 0f 8e 27 03 00 00 41 8b 45 08 83 c0
>   RSP: 0018:ffff888116df75e8 EFLAGS: 00010207
>   RAX: dffffc0000000000 RBX: 1ffff11022dbeebe RCX: ffffffff839a2382
>   RDX: 0000000000000003 RSI: 0000000000000008 RDI: ffff88842ec46d10
>   RBP: 0000000000000002 R08: 0000000000000000 R09: fffffbfff0b0860c
>   R10: ffff888116df75e8 R11: 0000000000000001 R12: ffffffff879d6a80
>   R13: 0000000000000016 R14: 000000000000001e R15: ffff888116df7908
>   FS:  00007fba01646740(0000) GS:ffff88842ec00000(0000) knlGS:00000000000=
00000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000055bd901800d8 CR3: 00000001205f0003 CR4: 0000000000172eb0
>   Call Trace:
>    <TASK>
>    ? die_addr+0x3d/0xa0
>    ? exc_general_protection+0x144/0x220
>    ? asm_exc_general_protection+0x22/0x30
>    ? __mutex_lock+0x2c2/0x1d70
>    ? nf_ct_netns_do_get+0x139/0x540
>    ? nf_ct_netns_do_get+0xb5/0x540
>    ? net_generic+0x1f0/0x1f0
>    ? __create_object+0x5e/0x80
>    xt_check_target+0x1f0/0x930
>    ? textify_hooks.constprop.0+0x110/0x110
>    ? pcpu_alloc_noprof+0x7cd/0xcf0
>    ? xt_find_target+0x148/0x1e0
>    find_check_entry.constprop.0+0x6c0/0x920
>    ? get_info+0x380/0x380
>    ? __virt_addr_valid+0x1df/0x3b0
>    ? kasan_quarantine_put+0xe3/0x200
>    ? kfree+0x13e/0x3d0
>    ? translate_table+0xaf5/0x1750
>    translate_table+0xbd8/0x1750
>    ? ipt_unregister_table_exit+0x30/0x30
>    ? __might_fault+0xbb/0x170
>    do_ipt_set_ctl+0x408/0x1340
>    ? nf_sockopt_find.constprop.0+0x17b/0x1f0
>    ? lock_downgrade+0x680/0x680
>    ? lockdep_hardirqs_on_prepare+0x284/0x400
>    ? ipt_register_table+0x440/0x440
>    ? bit_wait_timeout+0x160/0x160
>    nf_setsockopt+0x6f/0xd0
>    raw_setsockopt+0x7e/0x200
>    ? raw_bind+0x590/0x590
>    ? do_user_addr_fault+0x812/0xd20
>    do_sock_setsockopt+0x1e2/0x3f0
>    ? move_addr_to_user+0x90/0x90
>    ? lock_downgrade+0x680/0x680
>    __sys_setsockopt+0x9e/0x100
>    __x64_sys_setsockopt+0xb9/0x150
>    ? do_syscall_64+0x33/0x140
>    do_syscall_64+0x6d/0x140
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   RIP: 0033:0x7fba015134ce
>   Code: 0f 1f 40 00 48 8b 15 59 69 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff=
 ff eb b1 0f 1f 00 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00 f0 =
ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 21
>   RSP: 002b:00007ffd9de6f388 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
>   RAX: ffffffffffffffda RBX: 000055bd9017f490 RCX: 00007fba015134ce
>   RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000004
>   RBP: 0000000000000500 R08: 0000000000000560 R09: 0000000000000052
>   R10: 000055bd901800e0 R11: 0000000000000246 R12: 000055bd90180140
>   R13: 000055bd901800e0 R14: 000055bd9017f498 R15: 000055bd9017ff10
>    </TASK>
>   Modules linked in: xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addr=
type iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_regist=
ry overlay zram zsmalloc mlx4_ib mlx4_en mlx4_core rpcrdma rdma_ucm ib_uver=
bs ib_iser libiscsi scsi_transport_iscsi fuse ib_umad rdma_cm ib_ipoib iw_c=
m ib_cm ib_core
>   ---[ end trace 0000000000000000 ]---
>
> Fixes: dabddd687c9e ("percpu: cast percpu pointer in PERCPU_PTR() via uns=
igned long")
> Closes: https://lore.kernel.org/all/7590f546-4021-4602-9252-0d525de35b52@=
nvidia.com
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  include/linux/percpu-defs.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index 35842d1e3879..573adb643d90 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -222,8 +222,7 @@ do {                                                 =
                       \
>
>  #define PERCPU_PTR(__p)                                                 =
       \
>  ({                                                                     \
> -       unsigned long __pcpu_ptr =3D (__force unsigned long)(__p);       =
 \
> -       (typeof(*(__p)) __force __kernel *)(__pcpu_ptr);                \
> +       (typeof(*(__p)) __force __kernel *)((__force unsigned long)(__p))=
; \
>  })
>
>  #ifdef CONFIG_SMP
> --
> 2.40.1
>

