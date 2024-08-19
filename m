Return-Path: <netdev+bounces-119565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443E956420
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67931F22881
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A314D15699E;
	Mon, 19 Aug 2024 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4YzpOlfx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3C38DD2
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051425; cv=none; b=NAzGolt3R7RdwF+4m85ALlPeRFYsMugX6eqTMVLV/ArTg9KGwvG2JSp2qx6ma9ZkiJnYgKmtC4wR8D/kc7QopQZ7RU5QVJ6UJ2co/AfFpZBgsykNeXBwnxuf3ilK4RHzln8VE7v08JHtZv2Klo+HFqlNNI9R68252If/FNRT958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051425; c=relaxed/simple;
	bh=bCaS+omOPi9iw7kfAs9oBqaZ/E7viSLNfzjiVrYZzfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGM+nUA97p0e3X+/etfuYqdvyrJM+HiCtdOOH3yBoNo3UOae36ZzVfO8ta0PgbYvikSiFB3OgZGAXj4ViqYvpE9lYbyARWEuh1MHtBMyxaohUa46p2dWHO1EDbRsPmNCGPI6owdwvBpAyq7oPFgfMdEgiz3wwu5/DaNoZGPvLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4YzpOlfx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff2f2so2745839a12.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724051422; x=1724656222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWImHFjLhh/h1x+WXnUcUovxTkXsX9ZBQjBPwsVhK+U=;
        b=4YzpOlfxCXkHc0sQmv+TEQX7sPf/ci+NWQy1v5gFOI+Fa6kOvdsl6DC1MXU/aE91pe
         plR5HemTKTsXWwCYbfl8KSSnXWWHc/oYE4RWplAwi73FR0w1WWbrY0W9xpnWHWRO9UOv
         Zo/sIazmi8IG0EMy7eHZJ1uK5EsB9H85zQN0qiGqvgVBDlB1nQaBPMotLcwzIEYsXK6c
         qZIemSXkKoubbitG8NYDvARCBtRW7aH3tMAqQvCU5nf/FRmcvXoEAeNFyOGwUNniAaZu
         VNUHc1PlQZSeNbksF7zJt56fclKoeUIkBZxpP2Xh1LmcOEH3bSTE9a561fYdhY5WAge/
         +UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724051422; x=1724656222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWImHFjLhh/h1x+WXnUcUovxTkXsX9ZBQjBPwsVhK+U=;
        b=chAFlPZpLSzfM2Yl93oRoICy5Of1idQD9VKgppLvt+osqEU40l8+YJunGSya+m4n5E
         VU9JLcdu86fQcYy/43ofr6tTnE+UXTkz+mwufvtAN7FrvV/FUMkrAOoDuMbGewKF/Oti
         HZhXwSYzAfWFJOg9EEXoVCNYEJE8btzqkGmVmyoyekI3wc7fnvxoNkEgb6P/k57ENiAH
         P7EGSMd3T7iwiYyQuS4RztQMmXdOw6G+80i7hY/7ejIHlIrJNuzTNp7XU3zUEths3Ntp
         s++uBjNk1/BkctqTcKRDshrcDAOHFoNjkB09QKdTyZ5s3XMty1WxjW2DszcJbYVpfGLJ
         pVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbgnv42gEGy3tiK6+t/wdBpix4P0MlmAmvbVPtOuC+cSk3xNE3O/U4ksEgs/z6sxl4hn5PP+kZmuuA8GETbMbYj+51CTTf
X-Gm-Message-State: AOJu0YyG4qfOPFsb//oTjqFggmZ6yp2TWIbvytstO7mgey/JKR0y8vyv
	NBa4VkQNL/2Ifj28HMpVbFC/Qy8i77l2shb0YIykJLeWfpuPyS8GRszmAkM8RoSaDbmTqfvGPZy
	vW03493jFJ6/KIHJmFuXdGf5eDzr+q1weNgFb
X-Google-Smtp-Source: AGHT+IFHcKe1Utra4ajjjMRIFQkt37fdHsHw7eeFFOjBoi6oQASla5g5CNFWY6eftHbtboFZpDK8heSkSUibcTarCtY=
X-Received: by 2002:a05:6402:254e:b0:5be:daba:8bc5 with SMTP id
 4fb4d7f45d1cf-5bedaba8e8emr4566913a12.16.1724051421386; Mon, 19 Aug 2024
 00:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKrymDQmBrbVbRa_GsyBPv59dPvB6TdjkuWsfzwyUk45-YbReQ@mail.gmail.com>
In-Reply-To: <CAKrymDQmBrbVbRa_GsyBPv59dPvB6TdjkuWsfzwyUk45-YbReQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 09:10:08 +0200
Message-ID: <CANn89i+tGgQsPxtqFFK8Wdn1AcbWz_ygKfOqExwju7F02+RpHQ@mail.gmail.com>
Subject: Re: general protection fault in qdisc_reset
To: =?UTF-8?B?6rmA66+87ISx?= <ii4gsp@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 9:04=E2=80=AFAM =EA=B9=80=EB=AF=BC=EC=84=B1 <ii4gsp=
@gmail.com> wrote:
>
> Hi,
>
> I have been fuzzing Linux 6.10.0-rc3 with Syzkaller and found.


Please do not fuzz old rc kernels, this will avoid finding issues that
were already fixed.

For instance, this problem has been fixed two months ago

commit bab4923132feb3e439ae45962979c5d9d5c7c1f1
Author: Yunseong Kim <yskelg@gmail.com>
Date:   Tue Jun 25 02:33:23 2024 +0900

    tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset()



>
> kernel config: https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9=
cf284390e34fa9b17542c9/config_v6.10.0_rc3
> C repro: https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9cf2843=
90e34fa9b17542c9/repro.cprog
> repro syscall steps: https://github.com/ii4gsp/etc/blob/main/200767fee68b=
8d90c9cf284390e34fa9b17542c9/repro.prog
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000026: 0000 [#1] PREEMPT SMP KASAN NOPTI
> audit: type=3D1400 audit(1723346247.508:9): avc:  denied  { kernel } for =
 pid=3D227 comm=3D"syz-executor166" scontext=3Dsystem_u:system_r:kernel_t:s=
0 tcontext=3Dsystem_u:system_r:kernel_t:s0 tclass=3Dperf_event permissive=
=3D1
> KASAN: null-ptr-deref in range [0x0000000000000130-0x0000000000000137]
> CPU: 0 PID: 227 Comm: syz-executor166 Not tainted 6.10.0-rc3-00021-g2ef59=
71ff345 #1
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-de=
bian-1.16.3-2 04/01/2014
> RIP: 0010:strlen+0x1e/0xa0 lib/string.c:402
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 b8 00 00 00 00 0=
0 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 <0f> b6 04 02 48=
 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 80 7d 00 00
> RSP: 0018:ffff888008b5f708 EFLAGS: 00010292
> RAX: dffffc0000000000 RBX: ffffffffabcde7c0 RCX: ffffffffa9d3584d
> RDX: 0000000000000026 RSI: ffffffffabcde7c0 RDI: 0000000000000130
> RBP: 0000000000000130 R08: 0000000000000000 R09: fffffbfff57c50aa
> R10: ffffffffabe28557 R11: 0000000000000000 R12: ffffffffabcde980
> R13: dffffc0000000000 R14: ffff888001e32428 R15: 0000000000000130
> FS:  00005555772cf380(0000) GS:ffff88806d200000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005555772cfca8 CR3: 000000000da8e006 CR4: 0000000000370ef0
> Call Trace:
>  <TASK>
>  trace_event_get_offsets_qdisc_reset include/trace/events/qdisc.h:77 [inl=
ine]
>  perf_trace_qdisc_reset+0xf5/0x6a0 include/trace/events/qdisc.h:77
>  trace_qdisc_reset include/trace/events/qdisc.h:77 [inline]
>  qdisc_reset+0x3e1/0x550 net/sched/sch_generic.c:1029
>  dev_reset_queue+0x80/0x120 net/sched/sch_generic.c:1306
>  dev_deactivate_many+0x41f/0x830 net/sched/sch_generic.c:1375
>  __dev_close_many+0x129/0x2e0 net/core/dev.c:1543
>  __dev_close net/core/dev.c:1568 [inline]
>  __dev_change_flags+0x3dc/0x5a0 net/core/dev.c:8779
>  dev_change_flags+0x8e/0x160 net/core/dev.c:8853
>  devinet_ioctl+0xcbf/0x1a30 net/ipv4/devinet.c:1177
>  inet_ioctl+0x350/0x3b0 net/ipv4/af_inet.c:1003
>  packet_ioctl+0xa8/0x230 net/packet/af_packet.c:4256
>  sock_do_ioctl+0x119/0x2a0 net/socket.c:1222
>  sock_ioctl+0x3eb/0x630 net/socket.c:1341
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>  __x64_sys_ioctl+0x162/0x1e0 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8b72ae3c0d
> Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe6b571178 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8b72ae3c0d
> RDX: 0000000020000200 RSI: 0000000000008914 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f8b72b7bcc8 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:strlen+0x1e/0xa0 lib/string.c:402
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 b8 00 00 00 00 0=
0 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 <0f> b6 04 02 48=
 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 80 7d 00 00
> RSP: 0018:ffff888008b5f708 EFLAGS: 00010292
> RAX: dffffc0000000000 RBX: ffffffffabcde7c0 RCX: ffffffffa9d3584d
> RDX: 0000000000000026 RSI: ffffffffabcde7c0 RDI: 0000000000000130
> RBP: 0000000000000130 R08: 0000000000000000 R09: fffffbfff57c50aa
> R10: ffffffffabe28557 R11: 0000000000000000 R12: ffffffffabcde980
> R13: dffffc0000000000 R14: ffff888001e32428 R15: 0000000000000130
> FS:  00005555772cf380(0000) GS:ffff88806d200000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005555772cfca8 CR3: 000000000da8e006 CR4: 0000000000370ef0
> ----------------
> Code disassembly (best guess):
>    0: 90                   nop
>    1: 90                   nop
>    2: 90                   nop
>    3: 90                   nop
>    4: 90                   nop
>    5: 90                   nop
>    6: 90                   nop
>    7: 90                   nop
>    8: 90                   nop
>    9: 90                   nop
>    a: 90                   nop
>    b: 90                   nop
>    c: f3 0f 1e fa           endbr64
>   10: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
>   17: fc ff df
>   1a: 55                   push   %rbp
>   1b: 48 89 fa             mov    %rdi,%rdx
>   1e: 48 89 fd             mov    %rdi,%rbp
>   21: 53                   push   %rbx
>   22: 48 c1 ea 03           shr    $0x3,%rdx
>   26: 48 83 ec 08           sub    $0x8,%rsp
> * 2a: 0f b6 04 02           movzbl (%rdx,%rax,1),%eax <-- trapping instru=
ction
>   2e: 48 89 fa             mov    %rdi,%rdx
>   31: 83 e2 07             and    $0x7,%edx
>   34: 38 d0                 cmp    %dl,%al
>   36: 7f 04                 jg     0x3c
>   38: 84 c0                 test   %al,%al
>   3a: 75 50                 jne    0x8c
>   3c: 80 7d 00 00           cmpb   $0x0,0x0(%rbp)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Thanks,
>
> ii4gsp

