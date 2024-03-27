Return-Path: <netdev+bounces-82499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD89688E6B9
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795831F279A0
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88812FF72;
	Wed, 27 Mar 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2qJj6nOX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0013B585
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545817; cv=none; b=KkcHBNy5fbRQir6Qj5LG/QcLLF0Mo/yWxzMqsIc+xu3tqHobUeeaQe5p4kfO0U5OhbbRIWZBLSYfZ9CzLMRLMJVyRElrMdi+HW06Kz5+RyRHpEDYmCjUQcJHbyJUZKsHVAhmz3o9xAxdPeVV6qFUU+4upv6K9Q9cbX6KWplL3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545817; c=relaxed/simple;
	bh=NUuhQhmOT4BJOEOVGhRuJgEf6iymsBvMBb4n+CTJCfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrV+kjc4wakOcgIddaw6qlJRqrqp6iuGCafKcmnTdARkN3HE+1XFRR9kQalLv5II7Ca2XnFRNIQZ5y/b/3s/v0sFbNPPlOSGgBJVaSO+Nscec2wXwg5dYj3osmWmfBzfMGsDnWaOYOU7HCZnQ4xtxfn6xV3kOEJ7+osUL/yra6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2qJj6nOX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so11569a12.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545814; x=1712150614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXpBC5xhA/Mkd4QMPrHDdNQc3kv36QtfiU0hU6FzjVY=;
        b=2qJj6nOX2zcmS/gw7oCpgOadpLH0TdJb/9iwGHdpgyG31JFKqfIFijb1Jm7fSRy4J7
         rkz8QBR3gL+VGi8U7QZKoFJZ67I5mTMgiLNg34SmqlZeVSg+QkUsfZXgAwTNylQIhQQX
         jd1L8DpeqFuw30KXxs8FrOpi9WQNt9eZmBm/J9YsRy8jjA9TMkGjGsuZ19JzOtpJrYUf
         AvuLwsJUAIwUzj0gDrkTlKsIC/hMd5zziOR6WsVHAoEK2hxVmg+zY1ZFVm4ODGPu80g5
         0Q001ob2DfbLSsMiFdU9bymJXQHXpZ58VCxHk+Z1HnrC36CJ6uPLKBuF9hJ5jv5K2k6K
         HQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545814; x=1712150614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXpBC5xhA/Mkd4QMPrHDdNQc3kv36QtfiU0hU6FzjVY=;
        b=kqw77Xbn85OFn8PUPynhAuS/p+o2n9MJ44BQtrAjsfBq6H6zZc06UNMMn7bZGfxhnD
         RyYQsnRYeXjbG8F/PX3MxnRq5hr9YaRGW+OYA/ECE5xx9wUZakKf5XUqmQFWwOElNBxq
         Zw2I12fmUbQOUkXhtfgNGn73mIosRoS294BPaDdBr02iFzZxjb1rZC/3Fs2qHN+me879
         PBYKmGGnnODBTB5JGTffpX2qk+DCuA+JfAwSJGs5v+GZ7prCnVXMT9jtePZCMncGDbR7
         WBgddssmeyAQNRRh9MGPa3jkO+uwwrdgBro+Xn6G1YCaRy9AwjcHDoOpgUOTxgnBf1VK
         59yw==
X-Forwarded-Encrypted: i=1; AJvYcCWpV0AzIDmC+vaRat8pxiVG4RiRBVBShTfSG3l7ioH257OSFfdCAQobfg4bIMBCJPSCqia5+iE0eIx+JpRjqaEuhxZ6ojTh
X-Gm-Message-State: AOJu0Yw+1Rf8pILljtAmdNsu5+QlOqQ0a6+Xs+duodsPKrVkL/d7/0fe
	DMeXwbPOlHFqE6yrdVJ5vGVlT8ij6WAdVcyrpRW3MSev8kMrqqwOoetsHIXAhoWwZq7316Sqzfk
	Berg0HHc94q7HKeq0PQP1JJIFLfPXFVWqu19l
X-Google-Smtp-Source: AGHT+IF2Ri0BD1QOgpENtxdIwhgfBC/3WoM3Q2FYlhrUCSrmWzQSCjSYZOygsWi8hDYKs4p9mrJv+92qk+G4ClZJjz0=
X-Received: by 2002:aa7:d1cf:0:b0:56b:fc63:5551 with SMTP id
 g15-20020aa7d1cf000000b0056bfc635551mr72428edp.3.1711545813967; Wed, 27 Mar
 2024 06:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326230319.190117-1-jhs@mojatatu.com>
In-Reply-To: <20240326230319.190117-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 Mar 2024 14:23:20 +0100
Message-ID: <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 12:03=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> When the mirred action is used on a classful egress qdisc and a packet is
> mirrored or redirected to self we hit a qdisc lock deadlock.
> See trace below.
>
> [..... other info removed for brevity....]
> [   82.890906]
> [   82.890906] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   82.890906] WARNING: possible recursive locking detected
> [   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G        W
> [   82.890906] --------------------------------------------
> [   82.890906] ping/418 is trying to acquire lock:
> [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> __dev_queue_xmit+0x1778/0x3550
> [   82.890906]
> [   82.890906] but task is already holding lock:
> [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> __dev_queue_xmit+0x1778/0x3550
> [   82.890906]
> [   82.890906] other info that might help us debug this:
> [   82.890906]  Possible unsafe locking scenario:
> [   82.890906]
> [   82.890906]        CPU0
> [   82.890906]        ----
> [   82.890906]   lock(&sch->q.lock);
> [   82.890906]   lock(&sch->q.lock);
> [   82.890906]
> [   82.890906]  *** DEADLOCK ***
> [   82.890906]
> [..... other info removed for brevity....]
>
> Example setup (eth0->eth0) to recreate
> tc qdisc add dev eth0 root handle 1: htb default 30
> tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
>      action mirred egress redirect dev eth0
>
> Another example(eth0->eth1->eth0) to recreate
> tc qdisc add dev eth0 root handle 1: htb default 30
> tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
>      action mirred egress redirect dev eth1
>
> tc qdisc add dev eth1 root handle 1: htb default 30
> tc filter add dev eth1 handle 1: protocol ip prio 2 matchall \
>      action mirred egress redirect dev eth0
>
> We fix this by adding a per-cpu, per-qdisc recursion counter which is
> incremented the first time a root qdisc is entered and on a second attemp=
t
> enter the same root qdisc from the top, the packet is dropped to break th=
e
> loop.
>
> Reported-by: renmingshuai@huawei.com
> Closes: https://lore.kernel.org/netdev/20240314111713.5979-1-renmingshuai=
@huawei.com/
> Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net_tx_action()")
> Fixes: e578d9c02587 ("net: sched: use counter to break reclassify loops")
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  include/net/sch_generic.h |  2 ++
>  net/core/dev.c            |  9 +++++++++
>  net/sched/sch_api.c       | 12 ++++++++++++
>  net/sched/sch_generic.c   |  2 ++
>  4 files changed, 25 insertions(+)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index cefe0c4bdae3..f9f99df037ed 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -125,6 +125,8 @@ struct Qdisc {
>         spinlock_t              busylock ____cacheline_aligned_in_smp;
>         spinlock_t              seqlock;
>
> +       u16 __percpu            *xmit_recursion;
> +
>         struct rcu_head         rcu;
>         netdevice_tracker       dev_tracker;
>         /* private data */
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9a67003e49db..2b712388c06f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3789,6 +3789,13 @@ static inline int __dev_xmit_skb(struct sk_buff *s=
kb, struct Qdisc *q,
>         if (unlikely(contended))
>                 spin_lock(&q->busylock);

This could hang here (busylock)


>
> +       if (__this_cpu_read(*q->xmit_recursion) > 0) {
> +               __qdisc_drop(skb, &to_free);
> +               rc =3D NET_XMIT_DROP;
> +               goto free_skb_list;
> +       }


I do not think we want to add yet another cache line miss and
complexity in tx fast path.

I think that mirred should  use a separate queue to kick a transmit
from the top level.

(Like netif_rx() does)

Using a softnet.xmit_qdisc_recursion (not a qdisc-per-cpu thing),
would allow mirred to bypass this additional queue
in most cases.

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cb37817d6382c29117afd8ce54db6dba94f8c930..62ba5ef554860496ee928f7ed6b=
7c3ea46b8ee1d
100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3217,7 +3217,8 @@ struct softnet_data {
 #endif
        /* written and read only by owning cpu: */
        struct {
-               u16 recursion;
+               u8 recursion;
+               u8 qdisc_recursion;
                u8  more;
 #ifdef CONFIG_NET_EGRESS
                u8  skip_txqueue;
diff --git a/net/core/dev.c b/net/core/dev.c
index 9a67003e49db87f3f92b6c6296b3e7a5ca9d9171..7ac59835edef657e9558d4d4fc0=
a76b171aace93
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4298,7 +4298,9 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
net_device *sb_dev)

        trace_net_dev_queue(skb);
        if (q->enqueue) {
+               __this_cpu_inc(softnet_data.xmit.qdisc_recursion);
                rc =3D __dev_xmit_skb(skb, q, dev, txq);
+               __this_cpu_dec(softnet_data.xmit.qdisc_recursion);
                goto out;
        }

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 5b38143659249e66718348e0ec4ed3c7bc21c13d..0f5f02e6744397d33ae2a72670b=
a7131aaa6942e
100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -237,8 +237,13 @@ tcf_mirred_forward(bool at_ingress, bool
want_ingress, struct sk_buff *skb)
 {
        int err;

-       if (!want_ingress)
-               err =3D tcf_dev_queue_xmit(skb, dev_queue_xmit);
+       if (!want_ingress) {
+               if (__this_cpu_read(softnet_data.xmit.qdisc_recursion)) {
+                       // Queue to top level, or drop
+               } else {
+                       err =3D tcf_dev_queue_xmit(skb, dev_queue_xmit);
+               }
+       }
        else if (!at_ingress)
                err =3D netif_rx(skb);
        else

