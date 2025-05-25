Return-Path: <netdev+bounces-193242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB23AC3253
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 05:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B361644DC
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 03:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4767E14884C;
	Sun, 25 May 2025 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBqru5jz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2772629;
	Sun, 25 May 2025 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748145154; cv=none; b=gr9Sxaf5O9RMHcwXOiJ9YMsU1/tFqZpSjDs2132znVjxeXM9VHeLUASocx4wuyn+uIRtTSI9I8fuvFmEzMUGcRmW26IBbmvNnr3tJCewRi1rZkyrRHP2ucTeaaFof4jeEiTqUOD6PKMQOPy3B6ZFDugdpp4TSPLEGbAbzM/Yxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748145154; c=relaxed/simple;
	bh=pHLVULE/I1fAdN8C6lYNaTg/sArg2xYUJqAANI/uVto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqSPlr2gRYueGzUswy1vPbBCy24O+L3bj0d8yRVsHwjwC0M2SdgAwxjAkyfj+pu0ihX1zo11OYq0tzGacisG6LBYHpvNL0x9bQTSFUcDr83GQ5gj1P7IBQ+Oej4TUF9G0FxXzLyGYXKLnCS9G2OWzGcVVdLMqVCYcrrOuHURemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBqru5jz; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d96d16b369so10812865ab.0;
        Sat, 24 May 2025 20:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748145151; x=1748749951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bPvy3X1tUJGOYPMJnEfmPJ0GVPke5vL+/ijzUX6vRs=;
        b=bBqru5jzAKYCjXrnRIfoO/WQBsAfNi9eFjNoJ2pE5+wfNj3PH3HfdxivfZjFf1SUnw
         mtqwphPmourklDmNNaBW6SvfKhgIXXvDQ3DfYmtJbLPcmOtk3f0cOhGlCPbBVijNCrRh
         7Yp/tLI4DW3J5RqrKPVf9+kKDrerYBMZZx48cr5jcXig7scyBUYDTGhnLvMNLX/qFap0
         pJvonZv9RNrFzy4OCreFsKRQG9dfQuJV8UvktuKC9VpZ+mj9ewNWhDImn34mKA9GYwD+
         tLjMGywms566SSGL4hVJjAN6eoRVnq/qYYyXrYUHzI/dMwudt/WRyjv31qw676QzVwVK
         nxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748145151; x=1748749951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bPvy3X1tUJGOYPMJnEfmPJ0GVPke5vL+/ijzUX6vRs=;
        b=lWhFuWYf5IwUfHbJ3TaD4E6QYyOYVMkC/RTP3/KhJ2oB5Vu+Feo0qX7x0wcDOda1VS
         mC9hbRU0i2mNwc+/TCWxCFbg8xcOA8T5r+Gsg7dm2mYjE8JsfJwEn0eqZ0JF1aTrh/Ws
         HyGRD21VMkSKR686DBEAmuDeabVRWBqudh0tJQTEoH9wX97DkJTPRwGhmJgDlU5p20ar
         tnEdeJxMSbDAmmxlTcUml0/je1dbavtSyxyR6DHcbtbSLArmnnCkLiw6CKU/UXvtQ4Sb
         voIKt1Ip0/qXkY5R3EopZp3gypr7SGQE95xG19uhTwkMGNqK1wnRV1iMwQf6Chm6CLjT
         1a8A==
X-Forwarded-Encrypted: i=1; AJvYcCV5CNtrqFQJq4HLM0CqR+hTx5WHGktwx7x3EXo4g07OXjnZo3rmU8BXx3/HUAvB1Y7vcw9YOgtEldPLqEA=@vger.kernel.org, AJvYcCXkdOGlnrUdcboOxwkV4B9rP7Q31rfUrJslUZ7XVui0HaJa4r89pHvlBX7t1yiBnV8pmX6V6BZ+@vger.kernel.org
X-Gm-Message-State: AOJu0YyHt8FEummaNUIOAhL8C8V+ox7oLBdXfAhsFDZcJ4M8eEfMcYhQ
	lJ7HirG/8B+1oLBstB2CPtkMhn1kOHoo8pd29mYVVIM1TeGbgv2MKsnzpogLJNEwM+iVYbThwFM
	vwOT40P0vXrjNTgzRxoN+CEuZAhUjNWw=
X-Gm-Gg: ASbGnctBTmMvUkzSgQ2USmysBnHJNjco7iuvsEPjY7bxTZ9y4i5zXlK1tEk6bhS2Gj/
	5uDvx1O99pKM7cpEr7eh0w121OBsa7qksffZv0poXkWUghFk50dK1kMrJlgWaPBi2f0sVH7cwbh
	6IvKjV4uKTy+qbItgo0ADsI2YTd+3inLRY
X-Google-Smtp-Source: AGHT+IHML8z+fBuAR5gSeQKnWfF6QyKfvKaLwPoxYEp9zEWpgn3R5AIjLcNCoDFERW2G/VaGqflZPrwXI1ZrWd439Q4=
X-Received: by 2002:a05:6e02:4413:20b0:3dd:74f3:a059 with SMTP id
 e9e14a558f8ab-3dd74f3a1d7mr5014185ab.16.1748145151426; Sat, 24 May 2025
 20:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-7-tj@kernel.org>
In-Reply-To: <20240130091300.2968534-7-tj@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 25 May 2025 11:51:55 +0800
X-Gm-Features: AX0GCFvMTnvD93mMCuhocC7VIYR-b_mSbMYR0FBqdB1w_EjU_WDhtkY7J00XsRM
Message-ID: <CAL+tcoCKqs1m4bAWTWv9aoQKs7ZpC5PXtMS2ooi6xEB6CbxN1w@mail.gmail.com>
Subject: Re: [PATCH 6/8] net: tcp: tsq: Convert from tasklet to BH workqueue
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, 
	netdev@vger.kernel.org, allen.lkml@gmail.com, kernel-team@meta.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 5:24=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
>
> This patch converts TCP Small Queues implementation from tasklet to BH
> workqueue.
>
> Semantically, this is an equivalent conversion and there shouldn't be any
> user-visible behavior changes. While workqueue's queueing and execution
> paths are a bit heavier than tasklet's, unless the work item is being que=
ued
> every packet, the difference hopefully shouldn't matter.
>
> My experience with the networking stack is very limited and this patch
> definitely needs attention from someone who actually understands networki=
ng.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [IPv4/=
IPv6])
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org (open list:NETWORKING [TCP])

Hi Tejun,

Sorry to revive the old thread! I noticed this change because I've
been doing an investigation around TSQ recently. I'm very cautious
about the change in the core/sensitive part of the networking area
because it might affect some corner cases beyond our limited test,
even though I've tested many rounds and no regression results
(including the latency between tcp_wfree and tcp_tsq_handler) show up.
My main concern is what the exact benefit/improvement it could bring
with the change applied since your BH workqueue commit[1] says the
tasklet mechanism has some flaws. I'd like to see if I can
reproduce/verify it.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/co=
mmit/?id=3D4cb1ef64609f9

Thanks,
Jason

> ---
>  include/net/tcp.h     |  2 +-
>  net/ipv4/tcp.c        |  2 +-
>  net/ipv4/tcp_output.c | 36 ++++++++++++++++++------------------
>  3 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index dd78a1181031..89f3702be47a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -324,7 +324,7 @@ extern struct proto tcp_prot;
>  #define TCP_DEC_STATS(net, field)      SNMP_DEC_STATS((net)->mib.tcp_sta=
tistics, field)
>  #define TCP_ADD_STATS(net, field, val) SNMP_ADD_STATS((net)->mib.tcp_sta=
tistics, field, val)
>
> -void tcp_tasklet_init(void);
> +void tcp_tsq_work_init(void);
>
>  int tcp_v4_err(struct sk_buff *skb, u32);
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1baa484d2190..d085ee5642fe 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4772,6 +4772,6 @@ void __init tcp_init(void)
>         tcp_v4_init();
>         tcp_metrics_init();
>         BUG_ON(tcp_register_congestion_control(&tcp_reno) !=3D 0);
> -       tcp_tasklet_init();
> +       tcp_tsq_work_init();
>         mptcp_init();
>  }
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index e3167ad96567..d11be6eebb6e 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1049,15 +1049,15 @@ static unsigned int tcp_established_options(struc=
t sock *sk, struct sk_buff *skb
>   * needs to be reallocated in a driver.
>   * The invariant being skb->truesize subtracted from sk->sk_wmem_alloc
>   *
> - * Since transmit from skb destructor is forbidden, we use a tasklet
> + * Since transmit from skb destructor is forbidden, we use a BH work ite=
m
>   * to process all sockets that eventually need to send more skbs.
> - * We use one tasklet per cpu, with its own queue of sockets.
> + * We use one work item per cpu, with its own queue of sockets.
>   */
> -struct tsq_tasklet {
> -       struct tasklet_struct   tasklet;
> +struct tsq_work {
> +       struct work_struct      work;
>         struct list_head        head; /* queue of tcp sockets */
>  };
> -static DEFINE_PER_CPU(struct tsq_tasklet, tsq_tasklet);
> +static DEFINE_PER_CPU(struct tsq_work, tsq_work);
>
>  static void tcp_tsq_write(struct sock *sk)
>  {
> @@ -1087,14 +1087,14 @@ static void tcp_tsq_handler(struct sock *sk)
>         bh_unlock_sock(sk);
>  }
>  /*
> - * One tasklet per cpu tries to send more skbs.
> - * We run in tasklet context but need to disable irqs when
> + * One work item per cpu tries to send more skbs.
> + * We run in BH context but need to disable irqs when
>   * transferring tsq->head because tcp_wfree() might
>   * interrupt us (non NAPI drivers)
>   */
> -static void tcp_tasklet_func(struct tasklet_struct *t)
> +static void tcp_tsq_workfn(struct work_struct *work)
>  {
> -       struct tsq_tasklet *tsq =3D from_tasklet(tsq,  t, tasklet);
> +       struct tsq_work *tsq =3D container_of(work, struct tsq_work, work=
);
>         LIST_HEAD(list);
>         unsigned long flags;
>         struct list_head *q, *n;
> @@ -1164,15 +1164,15 @@ void tcp_release_cb(struct sock *sk)
>  }
>  EXPORT_SYMBOL(tcp_release_cb);
>
> -void __init tcp_tasklet_init(void)
> +void __init tcp_tsq_work_init(void)
>  {
>         int i;
>
>         for_each_possible_cpu(i) {
> -               struct tsq_tasklet *tsq =3D &per_cpu(tsq_tasklet, i);
> +               struct tsq_work *tsq =3D &per_cpu(tsq_work, i);
>
>                 INIT_LIST_HEAD(&tsq->head);
> -               tasklet_setup(&tsq->tasklet, tcp_tasklet_func);
> +               INIT_WORK(&tsq->work, tcp_tsq_workfn);
>         }
>  }
>
> @@ -1186,11 +1186,11 @@ void tcp_wfree(struct sk_buff *skb)
>         struct sock *sk =3D skb->sk;
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         unsigned long flags, nval, oval;
> -       struct tsq_tasklet *tsq;
> +       struct tsq_work *tsq;
>         bool empty;
>
>         /* Keep one reference on sk_wmem_alloc.
> -        * Will be released by sk_free() from here or tcp_tasklet_func()
> +        * Will be released by sk_free() from here or tcp_tsq_workfn()
>          */
>         WARN_ON(refcount_sub_and_test(skb->truesize - 1, &sk->sk_wmem_all=
oc));
>
> @@ -1212,13 +1212,13 @@ void tcp_wfree(struct sk_buff *skb)
>                 nval =3D (oval & ~TSQF_THROTTLED) | TSQF_QUEUED;
>         } while (!try_cmpxchg(&sk->sk_tsq_flags, &oval, nval));
>
> -       /* queue this socket to tasklet queue */
> +       /* queue this socket to BH workqueue */
>         local_irq_save(flags);
> -       tsq =3D this_cpu_ptr(&tsq_tasklet);
> +       tsq =3D this_cpu_ptr(&tsq_work);
>         empty =3D list_empty(&tsq->head);
>         list_add(&tp->tsq_node, &tsq->head);
>         if (empty)
> -               tasklet_schedule(&tsq->tasklet);
> +               queue_work(system_bh_wq, &tsq->work);
>         local_irq_restore(flags);
>         return;
>  out:
> @@ -2623,7 +2623,7 @@ static bool tcp_small_queue_check(struct sock *sk, =
const struct sk_buff *skb,
>         if (refcount_read(&sk->sk_wmem_alloc) > limit) {
>                 /* Always send skb if rtx queue is empty or has one skb.
>                  * No need to wait for TX completion to call us back,
> -                * after softirq/tasklet schedule.
> +                * after softirq schedule.
>                  * This helps when TX completions are delayed too much.
>                  */
>                 if (tcp_rtx_queue_empty_or_single_skb(sk))
> --
> 2.43.0
>
>

