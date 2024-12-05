Return-Path: <netdev+bounces-149239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17F09E4DB9
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C2816232C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 06:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C744157A5C;
	Thu,  5 Dec 2024 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuYvWex6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38112239181
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381238; cv=none; b=MNBtZ6AvDsSiCd1Dd6o4HiOOc1iHg7O2+L/GQggl7N52y3akhv1pNzRTVcdh07k6ZdOSsEtHn8Lj5sdYU8ynsQaXEREWMHRmUCK+yeM6kMSpYRX02ZxV3SjewjaeIaekL5IGGxxRDyx2lj2PpsXEg1ub8jtc7NkWyAr5pKBJJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381238; c=relaxed/simple;
	bh=il2ak3DurLjNoayuxJO8Ha2GVCBOMAARTM/9WcSGnus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsZa0/R3npBCsVhG+65KO/YJKfeen/+fkD9zEyaymKmtxvr1keS1NVhcp8IzYNHdvrYcMx5W4lLNCANIROloUlPD9aW8NNEiZ4Xq2fDuV/0woedNRAc71vs/jRmYyEAepm/BYv9DQPNXYYJ7aKpTzwNgHp6oa0wyICK/d4ISxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuYvWex6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so2973470a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 22:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733381234; x=1733986034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIbM8yyuIjQ7TPP4tduZTnLsEM2lMJ4H7jUjCi0GB50=;
        b=XuYvWex6u4nmqzw1G6tvIkMuBMncrZEpLBtCiX3iRHhXM3GIMrwKoHd+a86ix4O/D0
         JHtv75NruZTpNKJNeNtKyOQcqDpA9SDfecJA4i5s8hRB9wTOe6vpcqC93KJrqSDC//4b
         yFWM8BFqIf54V6j5/NJk+FsSYduFE3eQ6yM57+C+0Al9K8dkPtlxQJVkTm5HcMG/obIk
         HL648/kACW9PlyVeJ+D3x7pd6YtBbOKi5W3zZVgjhCT0WvR6BNctvtB0G/OZsX5llCvU
         4mzGHTEQM0VkYtucywOM+/TKVQknL4xlEXdGeZ47CXkBKU0zCYeAV+x97MSq6jQDWiHA
         T4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733381234; x=1733986034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIbM8yyuIjQ7TPP4tduZTnLsEM2lMJ4H7jUjCi0GB50=;
        b=ZFnoxo82Q05Yi8WojVWy+aVPwgGKKCNKz7mB099Pci+wvUK7qxVZbNYKKOvToz4fyI
         yR3qkiBtomvrMO82WpR+K+QftCcr8uUlFFT+3PlRN6TQ0OwZZwpOlKcF6R+vqo4YSc82
         mDVLHqggLqtEB17EK2V8+YiL/9Mbe5F5BDYv+GG5xYzenZIO+5xo4LVYpjEF0btoevI5
         BOJ+Uu70b41m2NXPkfXCFqDhSeZKVv26ABUlqKx82dd5mdvTANbjhwNEkbxltCRox4hq
         5bYTVnyWahdJSMmwomFBrdTIEnHthjKWOvi1gdQ3wxcFO18QFMlYEjOUzKaFPDA8kmoj
         loQg==
X-Forwarded-Encrypted: i=1; AJvYcCXGsqhkiitjjGM8ioA/xXXS+vtz/Jm6tRm2LYrM3JklLl2Wwl5w0q+TDDapliRPjH3xW0c8aag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnY1qb4dCTm2NWlqMBBFA3zt21XbpEDKThGPZkka8x7yKEEgoT
	A3iCJZ4cDEt098k1zlBgNi8NwcocNuJBCu1++SFS35aHxPo2d3jgf2OHv77zzViazYv07qDY/Hk
	BIDMykr9NbvmlKgaQOqv8ED43Juyga/krfpk1
X-Gm-Gg: ASbGncv+bkhYx1iGpFvaGOFPD+o8rRzexrR2GmUX2XFVBk3pjfPnAf1f3raWINewgMK
	lOyxsDnAKJ9rPLIai1SGi96em4NPtLAE=
X-Google-Smtp-Source: AGHT+IEwwMDv2TlR52fSSc/U0RGJdLG5C0zipyVbQTD/laui3bigKrQed3TEiAaFLTYHz6iMxgDi5qrT7+z+hklegA8=
X-Received: by 2002:a05:6402:518d:b0:5d0:b61a:89c9 with SMTP id
 4fb4d7f45d1cf-5d124f7ecefmr1667837a12.5.1733381234384; Wed, 04 Dec 2024
 22:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ee75faa926b2446b8302ee5fc30e129d2df73b90.1732810228.git.pabeni@redhat.com>
 <Z1FGZtZMg3hYpqvx@ly-workstation>
In-Reply-To: <Z1FGZtZMg3hYpqvx@ly-workstation>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Dec 2024 07:47:03 +0100
Message-ID: <CANn89iLxUA5Td3TviC_VzN_grzwAPRrfOO7tY0v+c4661XiM-w@mail.gmail.com>
Subject: Re: [PATCH net] ipmr: fix build with clang and DEBUG_NET disabled.
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 7:22=E2=80=AFAM Lai, Yi <yi1.lai@linux.intel.com> wr=
ote:
>
> On Thu, Nov 28, 2024 at 05:18:04PM +0100, Paolo Abeni wrote:
> > Sasha reported a build issue in ipmr::
> >
> > net/ipv4/ipmr.c:320:13: error: function 'ipmr_can_free_table' is not \
> >       needed and will not be emitted \
> >       [-Werror,-Wunneeded-internal-declaration]
> >    320 | static bool ipmr_can_free_table(struct net *net)
> >
> > Apparently clang is too smart with BUILD_BUG_ON_INVALID(), let's
> > fallback to a plain WARN_ON_ONCE().
> >
> > Reported-by: Sasha Levin <sashal@kernel.org>
> > Closes: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.1=
1-25635-g6813e2326f1e/testrun/26111580/suite/build/test/clang-nightly-lkftc=
onfig/details/
> > Fixes: 11b6e701bce9 ("ipmr: add debug check for mr table cleanup")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/ipv4/ipmr.c  | 2 +-
> >  net/ipv6/ip6mr.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> > index 383ea8b91cc7..c5b8ec5c0a8c 100644
> > --- a/net/ipv4/ipmr.c
> > +++ b/net/ipv4/ipmr.c
> > @@ -437,7 +437,7 @@ static void ipmr_free_table(struct mr_table *mrt)
> >  {
> >       struct net *net =3D read_pnet(&mrt->net);
> >
> > -     DEBUG_NET_WARN_ON_ONCE(!ipmr_can_free_table(net));
> > +     WARN_ON_ONCE(!ipmr_can_free_table(net));
> >
> >       timer_shutdown_sync(&mrt->ipmr_expire_timer);
> >       mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
> > diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> > index 4147890fe98f..7f1902ac3586 100644
> > --- a/net/ipv6/ip6mr.c
> > +++ b/net/ipv6/ip6mr.c
> > @@ -416,7 +416,7 @@ static void ip6mr_free_table(struct mr_table *mrt)
> >  {
> >       struct net *net =3D read_pnet(&mrt->net);
> >
> > -     DEBUG_NET_WARN_ON_ONCE(!ip6mr_can_free_table(net));
> > +     WARN_ON_ONCE(!ip6mr_can_free_table(net));
> >
> >       timer_shutdown_sync(&mrt->ipmr_expire_timer);
> >       mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC=
 |
> > --
> > 2.45.2
> >
>
> Hi Paolo Abeni,
>
> Greetings!
>
> I used Syzkaller and found that there is WARNING in ip6mr_free_table in l=
inux v6.13-rc1.
>
> After bisection and the first bad commit is:
> "
> f6d7695b5ae22092fa2cc42529bb7462f7e0c4ad ipmr: fix build with clang and D=
EBUG_NET disabled
> "
>
> Please help take a look if the WARNING is triggerd expectedly. I hope fol=
lowing records can be insightful for you.
>

Hi there

Probably fixed already in net tree with :

50b94204446e1215af081fd713d7d566d9258e35 ipmr: tune the
ipmr_can_free_table() checks.

Thank you

> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr=
_free_table
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr=
_free_table/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr=
_free_table/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr=
_free_table/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr=
_free_table/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr=
_free_table/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241204_20=
2439_ip6mr_free_table/bzImage_2b2d5f55fa44b37555edcdbbaf3acdb821e456a5
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/241204_202439_ip6mr=
_free_table/2b2d5f55fa44b37555edcdbbaf3acdb821e456a5_dmesg.log
>
> "
> [  106.095480] ------------[ cut here ]------------
> [  106.096382] WARNING: CPU: 1 PID: 682 at net/ipv6/ip6mr.c:419 ip6mr_fre=
e_table+0xc6/0x130
> [  106.098015] Modules linked in:
> [  106.098454] CPU: 1 UID: 0 PID: 682 Comm: repro Not tainted 6.12.0+ #1
> [  106.099311] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/4
> [  106.100953] RIP: 0010:ip6mr_free_table+0xc6/0x130
> [  106.101605] Code: 40 0d 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 4=
8 c1 ea 03 80 3c 02 00 75 5e 48 83 bb 40 0d 00 00 f
> [  106.104018] RSP: 0018:ffff88801743fb88 EFLAGS: 00010293
> [  106.104940] RAX: 0000000000000000 RBX: ffff88802d009c40 RCX: ffffffff8=
558ee4f
> [  106.105887] RDX: ffff888021640000 RSI: ffffffff8558ee86 RDI: ffff88802=
d00a980
> [  106.106817] RBP: ffff88801743fba0 R08: 0000000000000000 R09: ffffed100=
5a013b0
> [  106.107758] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88801=
0796000
> [  106.108813] R13: 0000000000000001 R14: dead000000000100 R15: dffffc000=
0000000
> [  106.109755] FS:  00007ff3dcab1640(0000) GS:ffff88806c500000(0000) knlG=
S:0000000000000000
> [  106.110877] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  106.111660] CR2: 00007f8030792008 CR3: 00000000215c2006 CR4: 000000000=
0770ef0
> [  106.112614] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  106.113549] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  106.114482] PKRU: 55555554
> [  106.114856] Call Trace:
> [  106.115201]  <TASK>
> [  106.115502]  ? show_regs+0x6d/0x80
> [  106.115996]  ? __warn+0xf3/0x380
> [  106.116499]  ? report_bug+0x25e/0x4b0
> [  106.117014]  ? ip6mr_free_table+0xc6/0x130
> [  106.117652]  ? report_bug+0x2cb/0x4b0
> [  106.118211]  ? ip6mr_free_table+0xc6/0x130
> [  106.118784]  ? ip6mr_free_table+0xc7/0x130
> [  106.119362]  ? handle_bug+0xf1/0x190
> [  106.119890]  ? exc_invalid_op+0x3c/0x80
> [  106.120461]  ? asm_exc_invalid_op+0x1f/0x30
> [  106.121089]  ? ip6mr_free_table+0x8f/0x130
> [  106.121706]  ? ip6mr_free_table+0xc6/0x130
> [  106.122336]  ? ip6mr_free_table+0xc6/0x130
> [  106.122919]  ? ip6mr_free_table+0xc6/0x130
> [  106.123499]  ip6mr_rules_exit+0x12a/0x260
> [  106.124076]  ip6mr_net_exit_batch+0x5d/0xb0
> [  106.124677]  ? __pfx_ip6mr_net_exit_batch+0x10/0x10
> [  106.125382]  ? __pfx_ip6mr_net_exit+0x10/0x10
> [  106.126033]  ops_exit_list+0x132/0x190
> [  106.126619]  setup_net+0x502/0x840
> [  106.127143]  ? __pfx_setup_net+0x10/0x10
> [  106.127725]  ? __pfx_down_read_killable+0x10/0x10
> [  106.128444]  ? __mutex_init+0xfd/0x140
> [  106.129024]  copy_net_ns+0x2bb/0x6e0
> [  106.129537]  create_new_namespaces+0x403/0xb40
> [  106.130171]  unshare_nsproxy_namespaces+0xca/0x200
> [  106.130858]  ksys_unshare+0x482/0xae0
> [  106.131439]  ? __pfx_ksys_unshare+0x10/0x10
> [  106.132113]  ? __audit_syscall_entry+0x39c/0x500
> [  106.132827]  __x64_sys_unshare+0x3a/0x50
> [  106.133432]  x64_sys_call+0xd3e/0x2140
> [  106.134007]  do_syscall_64+0x6d/0x140
> [  106.134574]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  106.135333] RIP: 0033:0x7ff3dc83ee5d
> [  106.135873] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 8
> [  106.138484] RSP: 002b:00007ff3dcab0ca8 EFLAGS: 00000297 ORIG_RAX: 0000=
000000000110
> [  106.139569] RAX: ffffffffffffffda RBX: 00007ff3dcab1640 RCX: 00007ff3d=
c83ee5d
> [  106.140603] RDX: 00007ff3dc83ee5d RSI: 0000000000000000 RDI: 000000006=
4040280
> [  106.141608] RBP: 00007ff3dcab0d60 R08: 0000000100000001 R09: 000000000=
0000000
> [  106.142538] R10: 0000000100000001 R11: 0000000000000297 R12: 00007ff3d=
cab1640
> [  106.143474] R13: 0000000000000006 R14: 00007ff3dc89f560 R15: 000000000=
0000000
> [  106.144466]  </TASK>
> [  106.144784] irq event stamp: 50463
> [  106.145252] hardirqs last  enabled at (50471): [<ffffffff814615c5>] __=
up_console_sem+0x95/0xb0
> [  106.146386] hardirqs last disabled at (50478): [<ffffffff814615aa>] __=
up_console_sem+0x7a/0xb0
> [  106.147514] softirqs last  enabled at (50120): [<ffffffff8128cc8e>] __=
irq_exit_rcu+0x10e/0x170
> [  106.148727] softirqs last disabled at (50107): [<ffffffff8128cc8e>] __=
irq_exit_rcu+0x10e/0x170
> [  106.149948] ---[ end trace 0000000000000000 ]---
> [  106.158499] ------------[ cut here ]------------
> [  106.159167] WARNING: CPU: 1 PID: 682 at net/ipv4/ipmr.c:440 ipmr_rules=
_exit+0x14b/0x1d0
> [  106.160449] Modules linked in:
> [  106.160933] CPU: 1 UID: 0 PID: 682 Comm: repro Tainted: G        W    =
      6.12.0+ #1
> [  106.162053] Tainted: [W]=3DWARN
> [  106.162492] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/4
> [  106.164206] RIP: 0010:ipmr_rules_exit+0x14b/0x1d0
> [  106.164915] Code: df 48 c1 ea 03 80 3c 02 00 75 7b 48 c7 83 08 08 00 0=
0 00 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc 6
> [  106.167497] RSP: 0018:ffff88801743fbc0 EFLAGS: 00010293
> [  106.168432] RAX: 0000000000000000 RBX: ffff88802d009c40 RCX: ffffffff8=
5369a4b
> [  106.169436] RDX: ffff888021640000 RSI: ffffffff85369abb RDI: 000000000=
0000005
> [  106.170449] RBP: ffff88801743fbe8 R08: 0000000000000000 R09: ffffed100=
5a013b0
> [  106.171462] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88802=
1756000
> [  106.172592] R13: 0000000000000001 R14: ffff88802d00a448 R15: ffff88802=
d009c40
> [  106.173605] FS:  00007ff3dcab1640(0000) GS:ffff88806c500000(0000) knlG=
S:0000000000000000
> [  106.174742] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  106.175568] CR2: 00007f0c14691000 CR3: 00000000215c2006 CR4: 000000000=
0770ef0
> [  106.176685] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  106.177702] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  106.178717] PKRU: 55555554
> [  106.179131] Call Trace:
> [  106.179469]  <TASK>
> [  106.179770]  ? show_regs+0x6d/0x80
> [  106.180294]  ? __warn+0xf3/0x380
> [  106.180761]  ? report_bug+0x25e/0x4b0
> [  106.181302]  ? ipmr_rules_exit+0x14b/0x1d0
> [  106.181925]  ? report_bug+0x2cb/0x4b0
> [  106.182491]  ? ipmr_rules_exit+0x14b/0x1d0
> [  106.183111]  ? ipmr_rules_exit+0x14c/0x1d0
> [  106.183726]  ? handle_bug+0xf1/0x190
> [  106.184315]  ? exc_invalid_op+0x3c/0x80
> [  106.184915]  ? asm_exc_invalid_op+0x1f/0x30
> [  106.185567]  ? ipmr_rules_exit+0xdb/0x1d0
> [  106.186177]  ? ipmr_rules_exit+0x14b/0x1d0
> [  106.186793]  ? ipmr_rules_exit+0x14b/0x1d0
> [  106.187429]  ipmr_net_exit_batch+0x5d/0xb0
> [  106.188045]  ? __pfx_ipmr_net_exit_batch+0x10/0x10
> [  106.188778]  ? __pfx_ipmr_net_exit+0x10/0x10
> [  106.189423]  ops_exit_list+0x132/0x190
> [  106.190020]  setup_net+0x502/0x840
> [  106.190549]  ? __pfx_setup_net+0x10/0x10
> [  106.191142]  ? __pfx_down_read_killable+0x10/0x10
> [  106.191845]  ? __mutex_init+0xfd/0x140
> [  106.192461]  copy_net_ns+0x2bb/0x6e0
> [  106.193024]  create_new_namespaces+0x403/0xb40
> [  106.193706]  unshare_nsproxy_namespaces+0xca/0x200
> [  106.194427]  ksys_unshare+0x482/0xae0
> [  106.195001]  ? __pfx_ksys_unshare+0x10/0x10
> [  106.195648]  ? __audit_syscall_entry+0x39c/0x500
> [  106.196384]  __x64_sys_unshare+0x3a/0x50
> [  106.196988]  x64_sys_call+0xd3e/0x2140
> [  106.197555]  do_syscall_64+0x6d/0x140
> [  106.198120]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  106.198870] RIP: 0033:0x7ff3dc83ee5d
> [  106.199409] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 8
> [  106.202011] RSP: 002b:00007ff3dcab0ca8 EFLAGS: 00000297 ORIG_RAX: 0000=
000000000110
> [  106.203093] RAX: ffffffffffffffda RBX: 00007ff3dcab1640 RCX: 00007ff3d=
c83ee5d
> [  106.204126] RDX: 00007ff3dc83ee5d RSI: 0000000000000000 RDI: 000000006=
4040280
> [  106.205144] RBP: 00007ff3dcab0d60 R08: 0000000100000001 R09: 000000000=
0000000
> [  106.206160] R10: 0000000100000001 R11: 0000000000000297 R12: 00007ff3d=
cab1640
> [  106.207175] R13: 0000000000000006 R14: 00007ff3dc89f560 R15: 000000000=
0000000
> [  106.208253]  </TASK>
> [  106.208592] irq event stamp: 51871
> [  106.209097] hardirqs last  enabled at (51879): [<ffffffff814615c5>] __=
up_console_sem+0x95/0xb0
> [  106.210317] hardirqs last disabled at (51886): [<ffffffff814615aa>] __=
up_console_sem+0x7a/0xb0
> [  106.211536] softirqs last  enabled at (51802): [<ffffffff8128cc8e>] __=
irq_exit_rcu+0x10e/0x170
> [  106.212814] softirqs last disabled at (51903): [<ffffffff8128cc8e>] __=
irq_exit_rcu+0x10e/0x170
> [  106.213954] ---[ end trace 0000000000000000 ]---
> "
>
> Regards,
> Yi Lai
>
> ---
>
> If you don't need the following environment to reproduce the problem or i=
f you
> already have one reproduced environment, please ignore the following info=
rmation.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v=
7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65=
 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,reado=
nly=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduc=
ed
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc =
has
>
> Fill the bzImage file into above start3.sh to load the target kernel in v=
m.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --e=
nable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install

