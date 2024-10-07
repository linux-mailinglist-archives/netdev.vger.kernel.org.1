Return-Path: <netdev+bounces-132842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCD699366E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06EBB226E8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B9C1DE2B6;
	Mon,  7 Oct 2024 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inGJXZWT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4F1D8E1F
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326622; cv=none; b=apqxdKStwYXxuGSAt+CgUjEalBIfsWBuw3Q8uRhGtB+6oi+Pbpocwft3Rs9bWRLRg3fHT/arf8nYQrNUNAz45vrpud8wW4w2geHYcYS0OMVswn2N8i7dVgLAxjQkO7lRlfEA9NFUZkmeymZU2yZuRhWa5KIVMapP4dzJTFItWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326622; c=relaxed/simple;
	bh=NT+L8lmi2A2y44+EY5KXfaITuLPeDEe7hPFLnR6h9dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNEwcao4mqlrLs+qudhan/DJuHoRlMBFh0OoL28IBHvQ6vsOB8FRa9RZ5R0CZGSlRWKEg1Bu1bGZv9f/dQj9w3FdxUwjUCZ+BV3OGupaarvE85ZDBaKCKjOAyHU0f30FfvxlJwpCzEJBP7dpywujQe8yP8EOyTnnwmdjLRwpMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inGJXZWT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9960371b62so96399466b.3
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 11:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728326618; x=1728931418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pipcQ6eQNZg79ZDxrsqTrMx1djjPQkGSQe3msTXBlJo=;
        b=inGJXZWTRUzh4ForlD+uELeDsoHl9DQCis+Fo0rQUtIpQwuyVfwk4E7A6T4nbfD1mR
         tE9HgIMvH2etTTrbUxa6F+f69Ad9bTS7p89DSZ/sRw6C6UTdzVHAMSUFwnQ5Iqw/eAE/
         FYypZu2Hq5kYrzWqPW7aCLVicMeCCahRAp5PpBhD22+1eiYQG63jX1ampvHRHF2Tt/31
         8T0W5Ivd91rQ72ZadI17peDYZ3LhH0JJo8W7wCkOj6n20MZtZ+IED4Tfa8jKUfOz+13c
         zQnZ2xmFjSMobnTOlEKLGY3fJ5aKlWS39FsyleRRaS3cpdOZdPW9e1y16uNODFfLl2pb
         Wgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326618; x=1728931418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pipcQ6eQNZg79ZDxrsqTrMx1djjPQkGSQe3msTXBlJo=;
        b=Y0Q3KMOG98sT8HVt0zjAH7cdpfX3Lc4KKP+oZ0fwXrDfbENbWlOkdzZxviv/pusUg2
         GYGn0/yDlxF1/52kHDt+QuyV9Z+1a2HlsQc0JYkSBTQ4Nj/LhIdwjdyV2jC/d3teF63y
         TaZGuLL4tKTP2tGwOvwRE7uYot6Q6IKDvDQYRPBO1eNzK5FrBSFGVKeA4f875uVkUla3
         aBAa/el4M5i4B6NovQ7aVb8Z+ebT1QPlolb8UkckF7b0ZE8ZFJUNfRbTbMiFjWQaIjCt
         ZvltjhtDWWJNeX6gdxSOS2zjt+EPhFQbKQ2DN7eRhkNcAmz8h9s5gj15PIgA+elXIbvf
         A4qw==
X-Forwarded-Encrypted: i=1; AJvYcCWxJ03oU2XOZjg334NKNAlGL7Jk3bUZiUlYSavbUEnjC9xg7btMpxvozM4yKXYOkswy5rGzPPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI94CtsZy9aJmbaiP4vpm9oJvCHIV5759oX6FZOPXgUEZff9Ce
	5b1jx/dWbE4fiVgb5YIsdf2CU88VjVPuLNHo3zTzeXDpUHapoo/vhxsY+eE27OvhcVGDaCCtx9p
	H8UhUcBOGVbsrezA6vTLkEStF/1pYd+cPSizz
X-Google-Smtp-Source: AGHT+IErBFL43d6HZyTuhLYD+ax4Hab/QCcpaeh5UAwr2wvJiArbXF59XKfSPY42a59RFrtnKRopsw8iF+sOc21NZiU=
X-Received: by 2002:a17:907:86a0:b0:a99:5985:bf39 with SMTP id
 a640c23a62f3a-a995985c1afmr385234966b.13.1728326617910; Mon, 07 Oct 2024
 11:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007184130.3960565-1-edumazet@google.com>
In-Reply-To: <20241007184130.3960565-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Oct 2024 20:43:24 +0200
Message-ID: <CANn89iLeTqHYwdy=X8Lg+Pe23cJeX2B862Un5wB09=gzaGNG3w@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: accept TCA_STAB only for root qdisc
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:41=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Most qdiscs maintain their backlog using qdisc_pkt_len(skb)
> on the assumption it is invariant between the enqueue()
> and dequeue() handlers.
>
> Unfortunately syzbot can crash a host rather easily using
> a TBF + SFQ combination, with an STAB on SFQ [1]
>
> We can't support TCA_STAB on arbitrary level, this would
> require to maintain per-qdisc storage.
>
> [1]
> [   88.796496] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [   88.798611] #PF: supervisor read access in kernel mode
> [   88.799014] #PF: error_code(0x0000) - not-present page
> [   88.799506] PGD 0 P4D 0
> [   88.799829] Oops: Oops: 0000 [#1] SMP NOPTI
> [   88.800569] CPU: 14 UID: 0 PID: 2053 Comm: b371744477 Not tainted 6.12=
.0-rc1-virtme #1117
> [   88.801107] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.16.3-debian-1.16.3-2 04/01/2014
> [   88.801779] RIP: 0010:sfq_dequeue (net/sched/sch_sfq.c:272 net/sched/s=
ch_sfq.c:499) sch_sfq
> [ 88.802544] Code: 0f b7 50 12 48 8d 04 d5 00 00 00 00 48 89 d6 48 29 d0 =
48 8b 91 c0 01 00 00 48 c1 e0 03 48 01 c2 66 83 7a 1a 00 7e c0 48 8b 3a <4c=
> 8b 07 4c 89 02 49 89 50 08 48 c7 47 08 00 00 00 00 48 c7 07 00
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f b7 50 12             movzwl 0x12(%rax),%edx
>    4:   48 8d 04 d5 00 00 00    lea    0x0(,%rdx,8),%rax
>    b:   00
>    c:   48 89 d6                mov    %rdx,%rsi
>    f:   48 29 d0                sub    %rdx,%rax
>   12:   48 8b 91 c0 01 00 00    mov    0x1c0(%rcx),%rdx
>   19:   48 c1 e0 03             shl    $0x3,%rax
>   1d:   48 01 c2                add    %rax,%rdx
>   20:   66 83 7a 1a 00          cmpw   $0x0,0x1a(%rdx)
>   25:   7e c0                   jle    0xffffffffffffffe7
>   27:   48 8b 3a                mov    (%rdx),%rdi
>   2a:*  4c 8b 07                mov    (%rdi),%r8               <-- trapp=
ing instruction
>   2d:   4c 89 02                mov    %r8,(%rdx)
>   30:   49 89 50 08             mov    %rdx,0x8(%r8)
>   34:   48 c7 47 08 00 00 00    movq   $0x0,0x8(%rdi)
>   3b:   00
>   3c:   48                      rex.W
>   3d:   c7                      .byte 0xc7
>   3e:   07                      (bad)
>         ...
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   4c 8b 07                mov    (%rdi),%r8
>    3:   4c 89 02                mov    %r8,(%rdx)
>    6:   49 89 50 08             mov    %rdx,0x8(%r8)
>    a:   48 c7 47 08 00 00 00    movq   $0x0,0x8(%rdi)
>   11:   00
>   12:   48                      rex.W
>   13:   c7                      .byte 0xc7
>   14:   07                      (bad)
>         ...
> [   88.803721] RSP: 0018:ffff9a1f892b7d58 EFLAGS: 00000206
> [   88.804032] RAX: 0000000000000000 RBX: ffff9a1f8420c800 RCX: ffff9a1f8=
420c800
> [   88.804560] RDX: ffff9a1f81bc1440 RSI: 0000000000000000 RDI: 000000000=
0000000
> [   88.805056] RBP: ffffffffc04bb0e0 R08: 0000000000000001 R09: 00000000f=
f7f9a1f
> [   88.805473] R10: 000000000001001b R11: 0000000000009a1f R12: 000000000=
0000140
> [   88.806194] R13: 0000000000000001 R14: ffff9a1f886df400 R15: ffff9a1f8=
86df4ac
> [   88.806734] FS:  00007f445601a740(0000) GS:ffff9a2e7fd80000(0000) knlG=
S:0000000000000000
> [   88.807225] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   88.807672] CR2: 0000000000000000 CR3: 000000050cc46000 CR4: 000000000=
00006f0
> [   88.808165] Call Trace:
> [   88.808459]  <TASK>
> [   88.808710] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/d=
umpstack.c:434)
> [   88.809261] ? page_fault_oops (arch/x86/mm/fault.c:715)
> [   88.809561] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:26 ./a=
rch/x86/include/asm/irqflags.h:87 ./arch/x86/include/asm/irqflags.h:147 arc=
h/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
> [   88.809806] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:62=
3)
> [   88.810074] ? sfq_dequeue (net/sched/sch_sfq.c:272 net/sched/sch_sfq.c=
:499) sch_sfq
> [   88.810411] sfq_reset (net/sched/sch_sfq.c:525) sch_sfq
> [   88.810671] qdisc_reset (./include/linux/skbuff.h:2135 ./include/linux=
/skbuff.h:2441 ./include/linux/skbuff.h:3304 ./include/linux/skbuff.h:3310 =
net/sched/sch_generic.c:1036)
> [   88.810950] tbf_reset (./include/linux/timekeeping.h:169 net/sched/sch=
_tbf.c:334) sch_tbf
> [   88.811208] qdisc_reset (./include/linux/skbuff.h:2135 ./include/linux=
/skbuff.h:2441 ./include/linux/skbuff.h:3304 ./include/linux/skbuff.h:3310 =
net/sched/sch_generic.c:1036)
> [   88.811484] netif_set_real_num_tx_queues (./include/linux/spinlock.h:3=
96 ./include/net/sch_generic.h:768 net/core/dev.c:2958)
> [   88.811870] __tun_detach (drivers/net/tun.c:590 drivers/net/tun.c:673)
> [   88.812271] tun_chr_close (drivers/net/tun.c:702 drivers/net/tun.c:351=
7)
> [   88.812505] __fput (fs/file_table.c:432 (discriminator 1))
> [   88.812735] task_work_run (kernel/task_work.c:230)
> [   88.813016] do_exit (kernel/exit.c:940)
> [   88.813372] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:58 (d=
iscriminator 4))
> [   88.813639] ? handle_mm_fault (./arch/x86/include/asm/irqflags.h:42 ./=
arch/x86/include/asm/irqflags.h:97 ./arch/x86/include/asm/irqflags.h:155 ./=
include/linux/memcontrol.h:1022 ./include/linux/memcontrol.h:1045 ./include=
/linux/memcontrol.h:1052 mm/memory.c:5928 mm/memory.c:6088)
> [   88.813867] do_group_exit (kernel/exit.c:1070)
> [   88.814138] __x64_sys_exit_group (kernel/exit.c:1099)
> [   88.814490] x64_sys_call (??:?)
> [   88.814791] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1=
) arch/x86/entry/common.c:83 (discriminator 1))
> [   88.815012] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:=
130)
> [   88.815495] RIP: 0033:0x7f44560f1975
>
> Fixes: 175f9c1bba9b ("Jussi Kivilinna <jussi.kivilinna@mbnet.fi>")

Copy/paste error, this should be :

Fixes: 175f9c1bba9b ("net_sched: Add size table for qdiscs")

> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/net/sch_generic.h | 1 -
>  net/sched/sch_api.c       | 7 ++++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 79edd5b5e3c9139cac0af251f95cc63e173d05f5..5d74fa7e694cc85be91dbf01f=
0876b9feaa29115 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -848,7 +848,6 @@ static inline void qdisc_calculate_pkt_len(struct sk_=
buff *skb,
>  static inline int qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>                                 struct sk_buff **to_free)
>  {
> -       qdisc_calculate_pkt_len(skb, sch);
>         return sch->enqueue(skb, sch, to_free);
>  }
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 74afc210527d237cca3b48166be5918f802eb326..2eefa4783879971c557ca3d98=
b74ac1218ea2bd1 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -593,7 +593,6 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb,
>                 pkt_len =3D 1;
>         qdisc_skb_cb(skb)->pkt_len =3D pkt_len;
>  }
> -EXPORT_SYMBOL(__qdisc_calculate_pkt_len);
>
>  void qdisc_warn_nonwc(const char *txt, struct Qdisc *qdisc)
>  {
> @@ -1201,6 +1200,12 @@ static int qdisc_graft(struct net_device *dev, str=
uct Qdisc *parent,
>                         return -EINVAL;
>                 }
>
> +               if (new &&
> +                   !(parent->flags & TCQ_F_MQROOT) &&
> +                   rcu_access_pointer(new->stab)) {
> +                       NL_SET_ERR_MSG(extack, "STAB not supported on a n=
on root");
> +                       return -EINVAL;
> +               }
>                 err =3D cops->graft(parent, cl, new, &old, extack);
>                 if (err)
>                         return err;
> --
> 2.47.0.rc0.187.ge670bccf7e-goog
>

