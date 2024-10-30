Return-Path: <netdev+bounces-140372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DB39B6377
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72421F222B4
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7C1EABB7;
	Wed, 30 Oct 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4y2kprfe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED81E8859
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292927; cv=none; b=h6R/MRvs0icrO6unQhankTefZy6WkH7GX80T6+GJGEOuxkVzBp9gIWvphOCiZcikcK5nbnJ7bTNKYxbMws6+mW6+qCoS6RmAKfamAydBfOyNl3KBCCKr97yN6OhSS0dGP/r0EKWHzfh3L1+gE+WC6LpK6AOfdeSKtBnWTiqSjog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292927; c=relaxed/simple;
	bh=9HeikSnNtESYGfEHkL/7qmokgovZf7aQSZWo+XWMD84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oURihXyIuA0SBpqJBqJnstVZBmm0ID/IndaETLidKjuYbe7yPw2rWLPxEbVsrbNREvI7zAG8kz1X10kRANjHqkycrVmDCzAeXHMbaHQlU1XWhl5DKAASr56jCe8616QsplN8TgXwQHbhYPpmjrScu1LKeUrBM4ltBnl5KzHkbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4y2kprfe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so7695924a12.0
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730292922; x=1730897722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd0+WXgf+BWTWhA8jygsIOHrOH6t8SMTi55qCk7gJSk=;
        b=4y2kprfer19VK2xarO0dQHD72YsJUmoTupuYNeTg0Vf8Qv8MdEI7c0MokAkPJBy9xF
         xdT6XVQv/0Px8Jgmq3oYVaKRsj32YJyKl93+mji5fDLe26hpl7uBgEE44DNW3UrFrLND
         KmwkCQ90XpaNVor7Uy6bFdR2peMcscVSeT8neBxh9qiJE01cUjVZvYJtp58hgvg2XAEu
         YCA5B9u5xJsfqU3AT1a92E9YgD9TnKH+vSIbQKGdw+t5Acih9j1JR+iHcdQgGy4kYV7X
         Xo4A/Izq3FsOrHm/JHpoM5xgKLwufVKcywFfmB1Azxb9bQdRqC21BodeojUZZSP8CY0G
         CYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730292922; x=1730897722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd0+WXgf+BWTWhA8jygsIOHrOH6t8SMTi55qCk7gJSk=;
        b=AUKpXtJoGf3mZJB3TcnMQbejmiwBmHMQpAZ4BDRWO/LZnfusyi2eUPX4YxwuIY4N9C
         R1gMv9hNfDVQKzu8Y/XNHfjJpkzeb7GKPZ6GKVPI35SVsaDCj6+5P7vbFiRork3mXc3m
         mRRptJDnwHE6sZZ7XElyQ4IFJM7XaVYioaJr0CQpn36VaGxNEVLhMOwQ8v7vsmVbB3GT
         vHzcprDR4lK1IvEBM+SCLIEq/Mlv/MWll7vjK6IxTTOOwQYA/ie9uPHkWVeltYzK+zfg
         tV35Kt+YVKadyXXhNwN0+9BgmHoXr+GPnHPZ17OhQV0geNTP/pViK9oVpuAcvuD7uzDw
         SOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJBW0rvVs3zL/6YJ5gvPRrrQwmosW0RZu52BON3V2zbwuuhAHJkQP9L5Ry9jC7mrHI5WmZb+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIl3vP61Keo8260rZuHvHfl56xZpMgw//kAg5TtAWnp11nOitp
	iMBkTYXZ5xU7eTtsvotuW7zPoJUsz0VAecs++0eDCLPSDw+hAP33KwRWMVe7cP9ajTJ8IjfOhVh
	u+daFuQg8QnvZDqK/vP2k6/CKRduoFXogA0xQ
X-Google-Smtp-Source: AGHT+IFAptJsX2O9Az/I1ss64NYWqCPlrPAi6PzQMHPjp6B2tnwmHzxquTjrBDurcpyu96ID/8shmMEe4GTEqlZb9L4=
X-Received: by 2002:a05:6402:2114:b0:5c8:9f3c:ea01 with SMTP id
 4fb4d7f45d1cf-5cbbf8923a3mr12315247a12.2.1730292921659; Wed, 30 Oct 2024
 05:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029182703.2698171-1-csander@purestorage.com>
 <CANn89iLx-4dTB9fFgfrsXQ8oA0Z+TpBWNk4b91PPS1o=oypuBQ@mail.gmail.com> <CADUfDZrSUNu7nym9dC1_yFUqhC8tUPYjv-ZKHofU9Q8Uv4Jvhw@mail.gmail.com>
In-Reply-To: <CADUfDZrSUNu7nym9dC1_yFUqhC8tUPYjv-ZKHofU9Q8Uv4Jvhw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Oct 2024 13:55:07 +0100
Message-ID: <CANn89iKQ3g2+nSWaV3BWarpbneRCSoGSXdGP90PF7ScDu4ULEQ@mail.gmail.com>
Subject: Re: [PATCH] net: skip RPS if packet is already on target CPU
To: Caleb Sander <csander@purestorage.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:38=E2=80=AFPM Caleb Sander <csander@purestorage.c=
om> wrote:
>
> On Tue, Oct 29, 2024 at 12:02=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Tue, Oct 29, 2024 at 7:27=E2=80=AFPM Caleb Sander Mateos
> > <csander@purestorage.com> wrote:
> > >
> > > If RPS is enabled, all packets with a CPU flow hint are enqueued to t=
he
> > > target CPU's input_pkt_queue and process_backlog() is scheduled on th=
at
> > > CPU to dequeue and process the packets. If ARFS has already steered t=
he
> > > packets to the correct CPU, this additional queuing is unnecessary an=
d
> > > the spinlocks involved incur significant CPU overhead.
> > >
> > > In netif_receive_skb_internal() and netif_receive_skb_list_internal()=
,
> > > check if the CPU flow hint get_rps_cpu() returns is the current CPU. =
If
> > > so, bypass input_pkt_queue and immediately process the packet(s) on t=
he
> > > current CPU.
> > >
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> >
> > Current implementation was a conscious choice. This has been discussed
> > several times.
> >
> > By processing packets inline, you are actually increasing latencies of
> > packets queued to other cpus.
>
> Sorry, I wasn't aware of these prior discussions. I take it you are
> referring to threads like
> https://lore.kernel.org/netdev/20230322072142.32751-1-xu.xin16@zte.com.cn=
/T/
> ? I see what you mean about the latency penalty for packets that do
> require cross-CPU steering.
>
> Do you have an alternate suggestion for how to avoid the overhead of
> acquiring a spinlock for every packet? The atomic instruction in
> rps_lock_irq_disable() called from process_backlog() is consuming 5%
> of our CPU time. For our use case, we don't really want software RPS;
> we are expecting ARFS to steer all high-bandwidth traffic to the
> desired CPUs. We would happily turn off software RPS entirely if we
> could, which seems like it would avoid the concerns about higher
> latency for packets that need to be steering to a different CPU. But
> my understanding is that using ARFS requires RPS to be enabled
> (rps_sock_flow_entries set globally and rps_flow_cnt set on each
> queue), which enables these rps_needed static branches. Is that
> correct? If so, would you be open to adding a sysctl that disables
> software RPS and relies upon ARFS to do the packet steering?

A sysctl will not avoid the fundamental issue.
Why not instead address the past feedback ?
Can you test the following ?

diff --git a/net/core/dev.c b/net/core/dev.c
index c682173a76424d7dadcc8374aa5b11dff44a4b46..7a5a7f1a4b7c3cbd105ecfc0763=
77f25929729eb
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5842,6 +5842,21 @@ static int generic_xdp_install(struct
net_device *dev, struct netdev_bpf *xdp)
        return ret;
 }

+#ifdef CONFIG_RPS
+static bool net_must_use_backlog(int tcpu)
+{
+       if (tcpu < 0)
+               return false;
+       if (tcpu !=3D smp_processor_id())
+               return true;
+       /* target cpu is ourself. We must use our backlog
+        * if we have deferred IPI or packets.
+        */
+       return this_cpu_read(softnet_data.rps_ipi_list) !=3D NULL ||
+              this_cpu_read(softnet_data.input_pkt_queue.qlen) !=3D 0;
+}
+#endif
+
 static int netif_receive_skb_internal(struct sk_buff *skb)
 {
        int ret;
@@ -5857,7 +5872,7 @@ static int netif_receive_skb_internal(struct sk_buff =
*skb)
                struct rps_dev_flow voidflow, *rflow =3D &voidflow;
                int cpu =3D get_rps_cpu(skb->dev, skb, &rflow);

-               if (cpu >=3D 0) {
+               if (net_must_use_backlog(cpu)) {
                        ret =3D enqueue_to_backlog(skb, cpu, &rflow->last_q=
tail);
                        rcu_read_unlock();
                        return ret;
@@ -5890,7 +5905,7 @@ void netif_receive_skb_list_internal(struct
list_head *head)
                        struct rps_dev_flow voidflow, *rflow =3D &voidflow;
                        int cpu =3D get_rps_cpu(skb->dev, skb, &rflow);

-                       if (cpu >=3D 0) {
+                       if (net_must_use_backlog(cpu)) {
                                /* Will be handled, remove from list */
                                skb_list_del_init(skb);
                                enqueue_to_backlog(skb, cpu,
&rflow->last_qtail);

