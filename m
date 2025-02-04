Return-Path: <netdev+bounces-162381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B726CA26B43
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 06:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FD23A585A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 05:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673D158558;
	Tue,  4 Feb 2025 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLAvFNQz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137343D81
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 05:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738646361; cv=none; b=fBEeIFI8+xswcYlIfxODbA3NAUP/XEdhgrs2s0Q5YJmZ7eW+/iJwyxX3JGFvx8R6dICozRVE1mDpyrozDCRpfARuWg7qO4TOlKCgwBWFG7nTqkIU4xu2WUu0s33K9riAcgh1Qeg8cXnmcafgSncarVAOnMtPJUeY9s9Zg1Jz454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738646361; c=relaxed/simple;
	bh=BabUlG1w/Uvvkr2rQLq7gACTxHOaGwHILz0sPBL6caM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzFnRDUX7wqR96DKt3nB0594ziqD3kjemnCuL91jUz5skSUi83LfzYWTIol+ppo8kzEz0T+6Lgh1/ArKWvo36k9aWORA1yllmLDv/gDf/yyFfpT2x/RgU33EtjQEFaaYS7ogjf2VIqnit3RIcIuSZzYNPR9Rua2j9bt5lKSzmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLAvFNQz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso6466925a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 21:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738646357; x=1739251157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS2AXbCrkcZlckwxkcxg8BiUzkM+wUQxwhyu5eBVRB0=;
        b=aLAvFNQzXnMv0M8R5q1/B3epLL75kDFhgRnAuRfGKjyCPNdm8mZBPIxUhTCOOyFAEI
         DI8omkNTpYd8VFVgBoHE+Vgfc3qaRlJqQZkA9+EJ1AW8uvV/9leQWOdleJaGfjKTfl9W
         dirmadVCsxDe3ufI3/4ehRCArRpJMna5oTr4GEmidepxyc1YMUL+J1akzlZpUiFyFFuY
         S9xMasGZ1jg2A/p4l3c0RlTI8zCDrtioLdE3mqTlBQxGwXAus+mZgO8hydR4g7uiatUN
         kFuXQQNTx+aLmjCSb3kwfOMo80l8R65I9L1INKMh7Hn4yR2bVSHlxaJDEjxWUIOHHkod
         1mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738646357; x=1739251157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS2AXbCrkcZlckwxkcxg8BiUzkM+wUQxwhyu5eBVRB0=;
        b=U5Ls88Kx9Uyp3z1Y43fjLzx8cBB7ydsva0HngMeEpRekBbOITHEc3IeWLP8lC11ZPr
         GL0CPbK/+U2Iwx8tb0RZDc57VfWzerLuTMJXyK3GDw1o5SKu5VX2aQuu+809q3MajWUz
         qOV7w/SZ90jp7MBT8BafB+HES7AJ/mBCm6gOcOh6jePLCtnYuBjaGPsbVKWdiavpKnHH
         w4FqGqMOAKPVOMtehv5VEjFp4O4FIplZfNtiViiIhKUuGZ/h49x1MsXYZ3k2ckg3KFzj
         RWcr8MGyy1BoZK+CTg8klFjSlKFlDFEpwf5HVMxTYk7Xo7D/gNDhcqphwqk+dUwMCWuW
         0GTA==
X-Forwarded-Encrypted: i=1; AJvYcCWsYxrZHwkhwW3Jj536VAPs/bgSmcJ+1aH3naEdyzV05t2ZYmBGljkibYvScFmQwwq9S2LICPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgT1KY8tRbl/FADsNpZIQ3E/AVS6EXscu4qK8Zmf4rVBMAT/A
	cdfx2p8bl7Bq7TpTIC6fG92aiLcL8zR9Apg/iYPgzG6ajhM99/AAGCa/URc4KiYxYDq0lbuYdLD
	n7Vl/INRTA3dBDsLJHur03weL9WTDEOGnqjyq
X-Gm-Gg: ASbGnctOvCEOBUhAxCoFQJyL0G5BoX1ueoeMpIBw/bbJThHho+AT9hpUYQa5GGvL7L3
	urcU15Fte9FoHTyub0aUmG23h3rpD2GsCYGOuubtLooEII9RaqY9UJ6yvkJwXtFEz9QkG1w==
X-Google-Smtp-Source: AGHT+IGwlrudS8Cf+HkidGhPIZvHUYp1aGwZJdpOTBhkKupt9M9lb2SkVVUevfi5j63KzTzojlqTAk1nnvA1SpvTSY8=
X-Received: by 2002:a05:6402:90c:b0:5d0:d84c:abb3 with SMTP id
 4fb4d7f45d1cf-5dc5efebf52mr22770552a12.26.1738646357018; Mon, 03 Feb 2025
 21:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SY8P300MB0421FF8BC82A17CA7A892675A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY8P300MB0421FF8BC82A17CA7A892675A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 06:19:06 +0100
X-Gm-Features: AWEUYZn57D_FZdrpb5sZek8UfwoK-Do5rEL6z936qAXW2KYP4UvN03gO4gUpbq4
Message-ID: <CANn89i+NLXpzsCCT=aJDji9Bkq34-bMBzu4vuPRnoCdL+VhOdQ@mail.gmail.com>
Subject: Re: general protection fault in __fib6_drop_pcpu_from [CVE-2024-40905
 Incomplete fix]
To: YAN KANG <kangyan91@outlook.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 5:27=E2=80=AFAM YAN KANG <kangyan91@outlook.com> wro=
te:
>
> Dear developers and maintainers,
>
> I found a new kernel UAF  bug titiled "general protection fault in __fib6=
_drop_pcpu_from" while using modified syzkaller fuzzing tool. I Itested it =
on the latest Linux upstream version (6.13.0-rc1), and it was able to be tr=
iggered many times .
>
>
> After preliminary analysis, I found CVE-2024-40905 vlunerability maybe fi=
xed incomplete.
> https://lore.kernel.org/linux-cve-announce/2024071208-CVE-2024-40905-44f9=
@gregkh/T/
> I am sure that this security patch is apply to linux 6.13.
>
>

Yes, I have syzbot reports pointing to the issue.

Do you have a fix already ?

I have been waiting, because I think the bug is caused by a per-cpu
data mangling,
not necessarily in network layers.

Unfortunately, KASAN does not have per-cpu data support I think.

> In function __fib6_drop_pcpu_from  (/net/ipv6/ip6_fib.c)
> crashing code:
> ppcpu_rt =3D per_cpu_ptr(fib6_nh->rt6i_pcpu, cpu); //fib6_nh->rt6i_pcpu i=
s dangling
> pcpu_rt =3D READ_ONCE(*ppcpu_rt); // Crash here
>
> rootcause of concurrent-UAF:
> The crash occurs because fib6_nh->rt6i_pcpu is accessed after being freed=
.
> The problematic code path appears to be:
> void fib6_nh_release(struct fib6_nh *fib6_nh)  (/net/ipv6/route.c)
> {
>        =E2=80=A6=E2=80=A6
>         fib6_nh_release_dsts(fib6_nh);   //pcpu_rt =3D xchg(ppcpu_rt, NUL=
L);
>         free_percpu(fib6_nh->rt6i_pcpu);
>        // MISSING: fib6_nh->rt6i_pcpu =3D NULL;
>
> After free_percpu() is called, rt6i_pcpu becomes a dangling pointer. Subs=
equent accesses to it in __fib6_drop_pcpu_from() via per_cpu_ptr() will tri=
gger use-after-free.
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: yan kang <kangyan91@outlook.com>
> Reported-by: yue sun <samsun1006219@gmail.com
>
>
> I hope it helps.
> Best regards
> yan kang
>
> Kernel crash log is listed below.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> crash log
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> batman_adv: batadv0: Removing interface: batadv_slave_1
> veth1_macvtap: left promiscuous mode
> veth0_macvtap: left promiscuous mode
> veth1_vlan: left promiscuous mode
> veth0_vlan: left promiscuous mode
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000012: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
> CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.13.0-rc1-00003-gd4=
774759e15b-dirty #87
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Workqueue: netns cleanup_net
> RIP: 0010:__fib6_drop_pcpu_from.part.0+0x18e/0x570 net/ipv6/ip6_fib.c:980
> Code: c2 48 c1 ea 03 80 3c 2a 00 0f 85 8a 03 00 00 4c 8b 38 4d 85 ff 74 2=
e e8 80 0c ca f7 49 8d bf 90 00 00 00 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f=
 85 7c 03 00 00 49 8b 87 90 00 00 00 48 3b 04 24 0f
> RSP: 0018:ffffc900000defb8 EFLAGS: 00010207
> RAX: 0000000000000012 RBX: 0000000000000000 RCX: 1ffffffff1b0cb7c
> RDX: ffff88801cee2500 RSI: ffffffff89ceb460 RDI: 0000000000000096
> RBP: dffffc0000000000 R08: 0000000000000000 R09: fffffbfff2d8a198
> R10: 0000000000000000 R11: 0000000000000000 R12: fffffbfff1b0cc71
> R13: ffff88810669a8c8 R14: ffffed1020cd3524 R15: 0000000000000006
> FS:  0000000000000000(0000) GS:ffff888062800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6eecc57000 CR3: 0000000024d02000 CR4: 0000000000752ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  __fib6_drop_pcpu_from net/ipv6/ip6_fib.c:1023 [inline]
>  fib6_drop_pcpu_from net/ipv6/ip6_fib.c:1024 [inline]
>  fib6_purge_rt+0x888/0xa80 net/ipv6/ip6_fib.c:1035
>  fib6_del_route net/ipv6/ip6_fib.c:1995 [inline]
>  fib6_del+0xa63/0x17f0 net/ipv6/ip6_fib.c:2040
>  fib6_clean_node+0x3a1/0x5d0 net/ipv6/ip6_fib.c:2202
>  fib6_walk_continue+0x450/0x860 net/ipv6/ip6_fib.c:2124
>  fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2172
>  fib6_clean_tree+0xdb/0x120 net/ipv6/ip6_fib.c:2252
>  __fib6_clean_all+0x105/0x2d0 net/ipv6/ip6_fib.c:2268
>  rt6_sync_down_dev net/ipv6/route.c:4908 [inline]
>  rt6_disable_ip+0x80a/0xa10 net/ipv6/route.c:4913
>  addrconf_ifdown.isra.0+0x12e/0x1ba0 net/ipv6/addrconf.c:3877
>  addrconf_notify+0x109/0x1a60 net/ipv6/addrconf.c:3800
>  notifier_call_chain+0xba/0x450 kernel/notifier.c:85
>  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
>  call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
>  call_netdevice_notifiers net/core/dev.c:2048 [inline]
>  dev_close_many+0x33d/0x690 net/core/dev.c:1589
>  unregister_netdevice_many_notify+0x47a/0x1d30 net/core/dev.c:11494
>  unregister_netdevice_many net/core/dev.c:11584 [inline]
>  default_device_exit_batch+0x740/0x980 net/core/dev.c:12067
>  ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
>  cleanup_net+0x5b3/0xb60 net/core/net_namespace.c:632
>  process_one_work+0x99f/0x1bb0 kernel/workqueue.c:3229
>  process_scheduled_works kernel/workqueue.c:3310 [inline]
>  worker_thread+0x66e/0xe80 kernel/workqueue.c:3391
>  kthread+0x2c7/0x3b0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__fib6_drop_pcpu_from.part.0+0x18e/0x570 net/ipv6/ip6_fib.c:980
> Code: c2 48 c1 ea 03 80 3c 2a 00 0f 85 8a 03 00 00 4c 8b 38 4d 85 ff 74 2=
e e8 80 0c ca f7 49 8d bf 90 00 00 00 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f=
 85 7c 03 00 00 49 8b 87 90 00 00 00 48 3b 04 24 0f
> RSP: 0018:ffffc900000defb8 EFLAGS: 00010207
> RAX: 0000000000000012 RBX: 0000000000000000 RCX: 1ffffffff1b0cb7c
> RDX: ffff88801cee2500 RSI: ffffffff89ceb460 RDI: 0000000000000096
> RBP: dffffc0000000000 R08: 0000000000000000 R09: fffffbfff2d8a198
> R10: 0000000000000000 R11: 0000000000000000 R12: fffffbfff1b0cc71
> R13: ffff88810669a8c8 R14: ffffed1020cd3524 R15: 0000000000000006
> FS:  0000000000000000(0000) GS:ffff888062800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6eecc57000 CR3: 0000000024d02000 CR4: 0000000000752ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> PKRU: 55555554
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0:   48 c1 ea 03             shr    $0x3,%rdx
>    4:   80 3c 2a 00             cmpb   $0x0,(%rdx,%rbp,1)
>    8:   0f 85 8a 03 00 00       jne    0x398
>    e:   4c 8b 38                mov    (%rax),%r15
>   11:   4d 85 ff                test   %r15,%r15
>   14:   74 2e                   je     0x44
>   16:   e8 80 0c ca f7          call   0xf7ca0c9b
>   1b:   49 8d bf 90 00 00 00    lea    0x90(%r15),%rdi
>   22:   48 89 f8                mov    %rdi,%rax
>   25:   48 c1 e8 03             shr    $0x3,%rax
> * 29:   80 3c 28 00             cmpb   $0x0,(%rax,%rbp,1) <-- trapping in=
struction
>   2d:   0f 85 7c 03 00 00       jne    0x3af
>   33:   49 8b 87 90 00 00 00    mov    0x90(%r15),%rax
>   3a:   48 3b 04 24             cmp    (%rsp),%rax
>   3e:   0f                      .byte 0xf

