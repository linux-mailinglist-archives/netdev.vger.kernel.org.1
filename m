Return-Path: <netdev+bounces-140738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169339B7C6C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B44B21392
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDEA19F121;
	Thu, 31 Oct 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtVep8SJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF377483
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383719; cv=none; b=h54nlhM+Gezz9c//UVBbrt2pJ/eSZ7sti8EQAD2/ccjSSup1wZKGtzPbzeZm43rOTFYrYYY/3RkNzE0lD1vHcigDPbrk+M577owH/oV0loxl/dtDVxv6JpruPJVizaL3U5HKmvJIR8KyS5hnjguMdGNaVijoONVasB6bz38JiBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383719; c=relaxed/simple;
	bh=GNTLcIDFm+zq3H2ohorkYovzdb7O8XSlEBCPAd6IQMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNr5p96jcv7Kbbm4ph6eRUe8x7DwGwnqZz6b8OYR9DGmwvn16oi/t6dB1q3o2yJqUUMB9hQAecrbC5r99FcyHeKG+BHE51tkxQvLLSni3TqefT/Mesjw+QoOkmlKkoQ9YNmZBvqW8Vky+dCZdW99ZbIJIBC6zAjrQzfi3Z5kVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MtVep8SJ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso3621339a12.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730383715; x=1730988515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F38pONsR0NSmqh6o0LCuhYWWefsVGgY/5VJduMM0+/A=;
        b=MtVep8SJ7T5NCg4mewdRCk4qDeoMDyDYXdpNa4b+Xmj4aJum/3I51GGkHBOpJLLD+V
         f6tiae0UvwKyztgHD6yfTUZpSgDQ6uqgg6SunEDsrh26kWMvVTgSnyRRYNt85ttd18Dw
         qbQ3ea4lQWRTubujZdB2Iebr7Us8kY/MDmZ9eXB/NJluIgfYG8eRshFYtzRpDwq5n7tQ
         fvIibYxD22JE3XIifjg3ukRNOOf5/q9fQFn+Vvw2QsNwpENIMV1X7tkMiBg1WJMqkgf8
         4DBKjIG0PUtx2z+Rmicfc0Uiikq8R5SKo1N6aPsiMGnN+SiHcjMtkPkFj8CJMsucLu6B
         KdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730383715; x=1730988515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F38pONsR0NSmqh6o0LCuhYWWefsVGgY/5VJduMM0+/A=;
        b=Jc7CavtTujbM26Bi0DfiIt3pYZmA6w7Wkru8HVJcwnXYDVaE22J45ixS6WI2ilf3U5
         FMNRJk3ZpiwghSNRXFilJVSxzh/zkFCs+FaK4EjPB7jjHpZmv0n34kTVfRNq94beS8e2
         3jDBRy9WRSeh9SWbz20Xf/Pbt+A99hG8CUexAOyTOKt6oxhSWli06/jiI41igTQ6pKKw
         nyEACaUD6LfWRom4KUHVTKkdr318QzV/hW70ddw/fPTo++8M/TgrsXarus8TwdITGQTj
         lbP3Gq3SYIAS3a/FTQsJ9kQcRXKakA94iTsOLz1wleC+defJ1+HdhzhDe6a4pJy+ZBjf
         NRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUor7C3wu0NNfKQ900uHzzSdJcQIer/u83rqP3jAQVb+GSrvSC5opjtzEkF4wk4S9d8okuD5ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISDlBOF1dMHOhVUcp1WbszsBBzMrlR8zl3ihuillP9XPfrPau
	8mxR48S/omReGY6HixgUR8OQjZFlEF/hLLW654GB8ZeL3TiV5LTs+rGJ2grkqTghulr+/qCtNP4
	Vx85BajqB+0OxEmWc8hYe352rBeK53mom0r5B
X-Google-Smtp-Source: AGHT+IFuR2VfhsDLHd9RI5W/l/yK5frQLTYWZLBf3IWVb5SIDxZadJB89XF+cTTTnuLdJZDsO1KC2H0KpvK3yPMSgW0=
X-Received: by 2002:a05:6402:440e:b0:5cb:6715:3498 with SMTP id
 4fb4d7f45d1cf-5ceabee80f2mr3249842a12.3.1730383714352; Thu, 31 Oct 2024
 07:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031122344.2148586-1-wangliang74@huawei.com>
In-Reply-To: <20241031122344.2148586-1-wangliang74@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 31 Oct 2024 15:08:20 +0100
Message-ID: <CANn89i+KL0=p2mchoZCOsZ1YoF9xhoUoubkub6YyLOY2wpSJtg@mail.gmail.com>
Subject: Re: [RFC PATCH net] net: fix data-races around sk->sk_forward_alloc
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 1:06=E2=80=AFPM Wang Liang <wangliang74@huawei.com>=
 wrote:
>
> Syzkaller reported this warning:

Was this a public report ?

> [   65.568203][    C0] ------------[ cut here ]------------
> [   65.569339][    C0] WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 =
inet_sock_destruct+0x1c5/0x1e0
> [   65.575017][    C0] Modules linked in:
> [   65.575699][    C0] CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainte=
d 6.12.0-rc5 #26
> [   65.577086][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.15.0-1 04/01/2014
> [   65.577094][    C0] RIP: 0010:inet_sock_destruct+0x1c5/0x1e0
> [   65.577100][    C0] Code: 24 12 4c 89 e2 5b 48 c7 c7 98 ec bb 82 41 5c=
 e9 d1 18 17 ff 4c 89 e6 5b 48 c7 c7 d0 ec bb 82 41 5c e9 bf 18 17 ff 0f 0b=
 eb 83 <0f> 0b eb 97 0f 0b eb 87 0f 0b e9 68 ff ff ff 66 66 2e 0f 1f 84 00
> [   65.577107][    C0] RSP: 0018:ffffc9000008bd90 EFLAGS: 00010206
> [   65.577113][    C0] RAX: 0000000000000300 RBX: ffff88810b172a90 RCX: 0=
000000000000007
> [   65.577117][    C0] RDX: 0000000000000002 RSI: 0000000000000300 RDI: f=
fff88810b172a00
> [   65.577120][    C0] RBP: ffff88810b172a00 R08: ffff888104273c00 R09: 0=
000000000100007
> [   65.577123][    C0] R10: 0000000000020000 R11: 0000000000000006 R12: f=
fff88810b172a00
> [   65.577125][    C0] R13: 0000000000000004 R14: 0000000000000000 R15: f=
fff888237c31f78
> [   65.577131][    C0] FS:  0000000000000000(0000) GS:ffff888237c00000(00=
00) knlGS:0000000000000000
> [   65.592485][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   65.592489][    C0] CR2: 00007ffc63fecac8 CR3: 000000000342e000 CR4: 0=
0000000000006f0
> [   65.592491][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [   65.592492][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [   65.592495][    C0] Call Trace:
> [   65.596277][    C0]  <TASK>
> [   65.598171][    C0]  ? __warn+0x88/0x130
> [   65.598874][    C0]  ? inet_sock_destruct+0x1c5/0x1e0
> [   65.598879][    C0]  ? report_bug+0x18e/0x1a0
> [   65.598883][    C0]  ? handle_bug+0x53/0x90
> [   65.598886][    C0]  ? exc_invalid_op+0x18/0x70
> [   65.598888][    C0]  ? asm_exc_invalid_op+0x1a/0x20
> [   65.598893][    C0]  ? inet_sock_destruct+0x1c5/0x1e0
> [   65.598897][    C0]  __sk_destruct+0x2a/0x200
> [   65.604664][    C0]  rcu_do_batch+0x1aa/0x530
> [   65.605450][    C0]  ? rcu_do_batch+0x13b/0x530
> [   65.605456][    C0]  rcu_core+0x159/0x2f0
> [   65.605466][    C0]  handle_softirqs+0xd3/0x2b0
> [   65.607689][    C0]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [   65.607695][    C0]  run_ksoftirqd+0x25/0x30
> [   65.607699][    C0]  smpboot_thread_fn+0xdd/0x1d0
> [   65.610152][    C0]  kthread+0xd3/0x100
> [   65.610158][    C0]  ? __pfx_kthread+0x10/0x10
> [   65.610160][    C0]  ret_from_fork+0x34/0x50
> [   65.610170][    C0]  ? __pfx_kthread+0x10/0x10
> [   65.610172][    C0]  ret_from_fork_asm+0x1a/0x30
> [   65.610181][    C0]  </TASK>
> [   65.610182][    C0] ---[ end trace 0000000000000000 ]---
>
> Its possible that two threads call tcp_v6_do_rcv()/sk_forward_alloc_add()
> concurrently when sk->sk_state =3D=3D TCP_LISTEN with sk->sk_lock unlocke=
d,
> which triggers a data-race around sk->sk_forward_alloc:
> tcp_v6_rcv
>     tcp_v6_do_rcv
>         skb_clone_and_charge_r
>             sk_rmem_schedule
>                 __sk_mem_schedule
>                     sk_forward_alloc_add()
>             skb_set_owner_r
>                 sk_mem_charge
>                     sk_forward_alloc_add()
>         __kfree_skb
>             skb_release_all
>                 skb_release_head_state
>                     sock_rfree
>                         sk_mem_uncharge
>                             sk_forward_alloc_add()
>                             sk_mem_reclaim
>                                 // set local var reclaimable
>                                 __sk_mem_reclaim
>                                     sk_forward_alloc_add()
>
> In this syzkaller testcase, two threads call tcp_v6_do_rcv() with
> skb->truesize=3D768, the sk_forward_alloc changes like this:
>  (cpu 1)             | (cpu 2)             | sk_forward_alloc
>  ...                 | ...                 | 0
>  __sk_mem_schedule() |                     | +4096 =3D 4096
>                      | __sk_mem_schedule() | +4096 =3D 8192
>  sk_mem_charge()     |                     | -768  =3D 7424
>                      | sk_mem_charge()     | -768  =3D 6656
>  ...                 |    ...              |
>  sk_mem_uncharge()   |                     | +768  =3D 7424
>  reclaimable=3D7424    |                     |
>                      | sk_mem_uncharge()   | +768  =3D 8192
>                      | reclaimable=3D8192    |
>  __sk_mem_reclaim()  |                     | -4096 =3D 4096
>                      | __sk_mem_reclaim()  | -8192 =3D -4096 !=3D 0
>
> Add lock around tcp_v6_do_rcv() in tcp_v6_rcv() will have some the
> performance impacts, only add lock when opt_skb clone occurs. In some
> scenes, tcp_v6_do_rcv() is embraced by sk->sk_lock, add
> TCP_SKB_CB(skb)->sk_lock_capability to avoid re-locking.
>
> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  include/net/tcp.h   |  3 ++-
>  net/ipv6/tcp_ipv6.c | 21 ++++++++++++++++-----
>  2 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d1948d357dad..110a23dda1eb 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -961,7 +961,8 @@ struct tcp_skb_cb {
>         __u8            txstamp_ack:1,  /* Record TX timestamp for ack? *=
/
>                         eor:1,          /* Is skb MSG_EOR marked? */
>                         has_rxtstamp:1, /* SKB has a RX timestamp       *=
/
> -                       unused:5;
> +                       sk_lock_capability:1, /* Avoid re-lock flag */
> +                       unused:4;
>         __u32           ack_seq;        /* Sequence number ACK'd        *=
/
>         union {
>                 struct {

Oh the horror, this is completely wrong and unsafe anyway.

TCP listen path MUST be lockless, and stay lockless.

Ask yourself : Why would a listener even hold a pktoptions in the first pla=
ce ?

Normally, each request socket can hold an ireq->pktopts (see in
tcp_v6_init_req())

The skb_clone_and_charge_r() happen later in tcp_v6_syn_recv_sock()

The correct fix is to _not_ call skb_clone_and_charge_r() for a
listener socket, of course, this never made _any_ sense.

The following patch should fix both TCP  and DCCP, and as a bonus make
TCP SYN processing faster
for listeners requesting these IPV6_PKTOPTIONS things.

diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index da5dba120bc9a55c5fd9d6feda791b0ffc887423..d6649246188d72b3df6c7475077=
9b7aa5910dcb7
100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -618,7 +618,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct
sk_buff *skb)
           by tcp. Feel free to propose better solution.
                                               --ANK (980728)
         */
-       if (np->rxopt.all)
+       if (np->rxopt.all && sk->sk_state !=3D DCCP_LISTEN)
                opt_skb =3D skb_clone_and_charge_r(skb, sk);

        if (sk->sk_state =3D=3D DCCP_OPEN) { /* Fast path */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d71ab4e1efe1c6598cf3d3e4334adf0881064ce9..e643dbaec9ccc92eb2d9103baf1=
85c957ad1dd2e
100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1605,25 +1605,12 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *=
skb)
         *      is currently called with bh processing disabled.
         */

-       /* Do Stevens' IPV6_PKTOPTIONS.
-
-          Yes, guys, it is the only place in our code, where we
-          may make it not affecting IPv4.
-          The rest of code is protocol independent,
-          and I do not like idea to uglify IPv4.
-
-          Actually, all the idea behind IPV6_PKTOPTIONS
-          looks not very well thought. For now we latch
-          options, received in the last packet, enqueued
-          by tcp. Feel free to propose better solution.
-                                              --ANK (980728)
-        */
-       if (np->rxopt.all)
-               opt_skb =3D skb_clone_and_charge_r(skb, sk);

        if (sk->sk_state =3D=3D TCP_ESTABLISHED) { /* Fast path */
                struct dst_entry *dst;

+               if (np->rxopt.all)
+                       opt_skb =3D skb_clone_and_charge_r(skb, sk);
                dst =3D rcu_dereference_protected(sk->sk_rx_dst,
                                                lockdep_sock_is_held(sk));

@@ -1656,13 +1643,13 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *=
skb)
                                if (reason)
                                        goto reset;
                        }
-                       if (opt_skb)
-                               __kfree_skb(opt_skb);
                        return 0;
                }
        } else
                sock_rps_save_rxhash(sk, skb);

+       if (np->rxopt.all)
+               opt_skb =3D skb_clone_and_charge_r(skb, sk);
        reason =3D tcp_rcv_state_process(sk, skb);
        if (reason)
                goto reset;

