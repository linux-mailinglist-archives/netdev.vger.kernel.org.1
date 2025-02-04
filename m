Return-Path: <netdev+bounces-162574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E76A27424
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A203AA354
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85F20DD41;
	Tue,  4 Feb 2025 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbXpbfji"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298320D4FB
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738678084; cv=none; b=JbKIqgvkcFD5fkaL9WzoPgLH7Flx/lr2JvlVbUg24hUCKMvOAbRfYdGklyZKDwTAbXKhY2pwTKBLxuPH4ZL5hStHVgaxPRuywy+Q3/+AsL7DfyZVWE2jdBkW/V50WSXHYtxiylY6Gk9ES13RkkiFHpD4hTZadhrzoZTGGtYf3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738678084; c=relaxed/simple;
	bh=fL3XWh/ozCzZICcphKPh1XD7XlmBcAz/fuimvBySrgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvZ9l6H5+NlAwl2LlapbUKcV9MQrN0bwOkorniguGMGeUm7w5TkRqpU02vPzChl05nWbOTu5thT9RRiSzl3HXEtApFQ62n0BoLbvRWqv7m6tDZTGbcDF4Xr+IoVtAwegDZbQeR2oCcLzqtVe3d7cAGpVEbShqECXJFUsZOwF1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GbXpbfji; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso10370878a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 06:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738678081; x=1739282881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++D6QLSUEGWvkVYrBbitn1vHngwwZ1AtE7nCYF0vxXo=;
        b=GbXpbfjixnGlcP5Of0rE6wKNZ3ViL0SISTWNcaMSrqi2yxXsUcTwbWFldVbXNZbyHH
         5t7r6YECr9gaHVZDTBABwIS8oujSBjEXKKZB1/AbRI6qpPGHILm7/7RuJ0iCf3ptbw5e
         aEc+9SR2ppsKPoSTiNzJVa2l8xNvFJHAPpZozoFy0pZFWu7BH/PNzGt5exSfJGqRS+dp
         IWPxnXYzFT2Sz8/hqJ1Vv4dDePDYhKr0YjdkhifhjTQi9x11JD0oCfpfKN5BROsu7dQH
         RCq7i3USlDE3f/zDO/GmgnGeuiVuCnoI+DEDSmKnMWx+KACOdhq11Z7abefiG77UXkCX
         SuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738678081; x=1739282881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++D6QLSUEGWvkVYrBbitn1vHngwwZ1AtE7nCYF0vxXo=;
        b=Fa4fATDvbaUtr7cv3T/AE04Az3o4GYAezl8SJ8+mQbzglB5v19GIyERZdzIkzbn0wQ
         78s0agac2+3c4XeXb7aQewnlDKxcewiZ8N9uUrH3pV0T96WXto5aXZplgZevFP5vF/hO
         YXZJs30Ll9gYrzI9MaVSETLknVEDEDLKzR0cc2oj0oz/H+cjhOb4x5Jg4bX4C5wwTWzj
         bm53lMLeq8N3O23HxNFbAhwseK+WjsyHWQD5ze+tuqnHVIn7sI6vOGzV4i/U+VK8UaMX
         2ZwyTEihjOmXRgiVbNwLsaY9K0bNEpCo6i5ltduHtRbfOamaCejSAZrTFVT0NjQOmoF6
         Lw6w==
X-Forwarded-Encrypted: i=1; AJvYcCWAsWlJ8XH7jhY1vxEpkXZmSF/vGUYrOAYHv+SZJ53MB21RoPtT/c/weuXqgScxwNXKTI1pT5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfVvn/Rzf6bN/0U/cTsG0Y9M8SJJZwMik7+0AvfcJOdX7gL+ZX
	WD8Wnoh0DhFvLZccMei+1RHvvHOHTrv4gKbw2yReG/HnjmBLF1D9TE/0TdL/fQauyKFEtXd2J4C
	8+OCcTPHSoyG+LmDZji4L259GRp2VdVo2HhX9
X-Gm-Gg: ASbGncu0IR904cSH2OuGdSBPAv1XWPKELA6T4Xx/+oKp7NokzYkHFwVxrdjjs3YJMS4
	xo15Z1yTOM1ockX8kOct7iXHVD7pT4Rm2aTNT1y3ljPQ5REvYra8y7H2e5/Xh+3FqkmSdhg==
X-Google-Smtp-Source: AGHT+IERFbIos817j2O9FTP2sAFSkrtDVw3uk34X+CMqBVlpTLuNUuPXmOedWi5UhUP9WLTQsVg57OoVgovmLqEfruo=
X-Received: by 2002:a05:6402:1d55:b0:5db:f40f:1a5f with SMTP id
 4fb4d7f45d1cf-5dcc15d5c17mr3415831a12.15.1738678080778; Tue, 04 Feb 2025
 06:08:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SY7P300MB04319CA459D5B313D33AF259A1F42@SY7P300MB0431.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY7P300MB04319CA459D5B313D33AF259A1F42@SY7P300MB0431.AUSP300.PROD.OUTLOOK.COM>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 15:07:49 +0100
X-Gm-Features: AWEUYZmbc_iaqGY7FaZHEGI6Sjt85KbkO0wakZbhDTd-5t6laSKj9fp8orGFEwg
Message-ID: <CANn89iKCqR_wid4+g65Mx6jVTAuqJcKOocMCs09-7J+knSAKoQ@mail.gmail.com>
Subject: Re: general protection fault in ip6_pol_route
To: YAN KANG <kangyan91@outlook.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 2:47=E2=80=AFPM YAN KANG <kangyan91@outlook.com> wro=
te:
>
> Dear maintainers,
>
> I found a kernel  bug titiled "general protection fault in ip6_pol_route"=
 while using modified syzkaller fuzzing tool. I Itested it on the latest Li=
nux upstream version (6.13.0-rc7) .
>
>
> After preliminary analysis, the rootcause may be in ip6_pol_route functio=
n  net/ipv6/route.c
>     res is a stack object.    [1]
>     fib6_select_path(net, &res, fl6, oif, false, skb, strict)  call  may =
initialize res->nh.[2]
>     rt =3D rt6_get_pcpu_route( &res);   [3]
>            pcpu_rt =3D this_cpu_read(*res->nh->rt6i_pcpu); // *res->nh is=
 NULL, crash
>
>    in [2], res->nh can be initialized in several ways,possibly one of whi=
ch initializes it to NULL.
>
>  Unfortunately, I don't have any reproducer for this bug yet.
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: yan kang <kangyan91@outlook.com>
> Reported-by: yue sun <samsun1006219@gmail.com
>
>

This is a dup of a syzbot report under investigation.

Unless you have a repro and/or a patch, I would recommend you not
sending these fuzzer reports anymore.

Releasing such reports without a fix is an obvious security risk.

Thank you.


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
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000013: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000098-0x000000000000009f]
> CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.13.0-rc7-00003-gd4=
774759e15b-dirty #87
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Workqueue: ipv6_addrconf addrconf_dad_work
> RIP: 0010:rt6_get_pcpu_route net/ipv6/route.c:1411 [inline]
> RIP: 0010:ip6_pol_route+0x3be/0x1210 net/ipv6/route.c:2264
> Code: f7 4d 85 f6 0f 84 40 03 00 00 e8 3d 8f cb f7 49 8d be 98 00 00 00 4=
c 89 f3 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84=
 c0 74 08 3c 03 0f 8e 1a 0d 00 00 45 8b ae 98 00 00
> RSP: 0018:ffffc900001e87d0 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: 0000000000000004 RCX: ffffffff89cd3195
> RDX: 0000000000000013 RSI: ffffffff89cd31a3 RDI: 000000000000009c
> RBP: ffff88812a010000 R08: 0000000000000001 R09: ffff888110288000
> R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000080
> R13: ffffc900001e8b20 R14: 0000000000000004 R15: ffffc900001e8860
> FS:  0000000000000000(0000) GS:ffff888135e00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc23d35b344 CR3: 000000010570e000 CR4: 0000000000752ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  pol_lookup_func include/net/ip6_fib.h:616 [inline]
>  fib6_rule_lookup+0x538/0x720 net/ipv6/fib6_rules.c:117
>  ip6_route_input_lookup net/ipv6/route.c:2300 [inline]
>  ip6_route_input+0x66e/0xc20 net/ipv6/route.c:2596
>  ip6_rcv_finish_core.constprop.0+0x1aa/0x5e0 net/ipv6/ip6_input.c:66
>  ip6_rcv_finish net/ipv6/ip6_input.c:77 [inline]
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  NF_HOOK include/linux/netfilter.h:308 [inline]
>  ipv6_rcv+0x1e7/0x690 net/ipv6/ip6_input.c:309
>  __netif_receive_skb_one_core+0x12e/0x1f0 net/core/dev.c:5672
>  __netif_receive_skb+0x1d/0x150 net/core/dev.c:5785
>  process_backlog+0x319/0x1460 net/core/dev.c:6117
>  __napi_poll.constprop.0+0xb6/0x540 net/core/dev.c:6877
>  napi_poll net/core/dev.c:6946 [inline]
>  net_rx_action+0x9d2/0xe30 net/core/dev.c:7068
>  handle_softirqs+0x1bf/0x850 kernel/softirq.c:554
>  do_softirq kernel/softirq.c:455 [inline]
>  do_softirq+0xac/0xe0 kernel/softirq.c:442
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
>  local_bh_enable include/linux/bottom_half.h:33 [inline]
>  rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
>  __dev_queue_xmit+0x1b98/0x4160 net/core/dev.c:4461
>  dev_queue_xmit include/linux/netdevice.h:3168 [inline]
>  neigh_resolve_output net/core/neighbour.c:1514 [inline]
>  neigh_resolve_output+0x58e/0x900 net/core/neighbour.c:1494
>  neigh_output include/net/neighbour.h:539 [inline]
>  ip6_finish_output2+0xae5/0x1ec0 net/ipv6/ip6_output.c:141
>  __ip6_finish_output net/ipv6/ip6_output.c:215 [inline]
>  ip6_finish_output+0x713/0x1230 net/ipv6/ip6_output.c:226
>  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
>  ip6_output+0x203/0x550 net/ipv6/ip6_output.c:247
>  dst_output include/net/dst.h:450 [inline]
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ndisc_send_skb+0xa65/0x1c70 net/ipv6/ndisc.c:511
>  ndisc_send_ns+0xb5/0x130 net/ipv6/ndisc.c:669
>  addrconf_dad_work+0xd3a/0x1610 net/ipv6/addrconf.c:4303
>  process_one_work+0x99f/0x1bb0 kernel/workqueue.c:3229
>  process_scheduled_works kernel/workqueue.c:3310 [inline]
>  worker_thread+0x66e/0xe80 kernel/workqueue.c:3391
>  kthread+0x2c7/0x3b0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:rt6_get_pcpu_route net/ipv6/route.c:1411 [inline]
> RIP: 0010:ip6_pol_route+0x3be/0x1210 net/ipv6/route.c:2264
> Code: f7 4d 85 f6 0f 84 40 03 00 00 e8 3d 8f cb f7 49 8d be 98 00 00 00 4=
c 89 f3 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84=
 c0 74 08 3c 03 0f 8e 1a 0d 00 00 45 8b ae 98 00 00
> RSP: 0018:ffffc900001e87d0 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: 0000000000000004 RCX: ffffffff89cd3195
> RDX: 0000000000000013 RSI: ffffffff89cd31a3 RDI: 000000000000009c
> RBP: ffff88812a010000 R08: 0000000000000001 R09: ffff888110288000
> R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000080
> R13: ffffc900001e8b20 R14: 0000000000000004 R15: ffffc900001e8860
> FS:  0000000000000000(0000) GS:ffff888135e00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc23d35b344 CR3: 000000010570e000 CR4: 0000000000752ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> PKRU: 55555554
> ----------------
> Code disassembly (best guess):
>    0:   f7 4d 85 f6 0f 84 40    testl  $0x40840ff6,-0x7b(%rbp)
>    7:   03 00                   add    (%rax),%eax
>    9:   00 e8                   add    %ch,%al
>    b:   3d 8f cb f7 49          cmp    $0x49f7cb8f,%eax
>   10:   8d be 98 00 00 00       lea    0x98(%rsi),%edi
>   16:   4c 89 f3                mov    %r14,%rbx
>   19:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   20:   fc ff df
>   23:   48 89 fa                mov    %rdi,%rdx
>   26:   48 c1 ea 03             shr    $0x3,%rdx
> * 2a:   0f b6 04 02             movzbl (%rdx,%rax,1),%eax <-- trapping in=
struction
>   2e:   84 c0                   test   %al,%al
>   30:   74 08                   je     0x3a
>   32:   3c 03                   cmp    $0x3,%al
>   34:   0f 8e 1a 0d 00 00       jle    0xd54
>   3a:   45                      rex.RB
>   3b:   8b                      .byte 0x8b
>   3c:   ae                      scas   %es:(%rdi),%al
>   3d:   98                      cwtl

