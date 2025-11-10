Return-Path: <netdev+bounces-237146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27884C461E3
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E460A1885957
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175BC307486;
	Mon, 10 Nov 2025 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lDEn1IiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACD273F9
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772811; cv=none; b=O17xzk3yvwAmZvXXFvsEEGgsQ2HGQ53T5xexvNGCVf8bZQW3bG8m19fDVlwaU/a30QiiEbqQlE6flgUz8fFBl3PDnDWR6+NpX0HVLMJ8FEGrsfNHGEd3YHyVYzyO9+VZn9VDMOMIplJUuFVXrinXCI9mk9z9j6ZiZHScgvQEfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772811; c=relaxed/simple;
	bh=/jUpBnUkxmAdbYaJkKyc6YlPMjaSQv8ZF79+I1M/FCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejHWXRjY8cTvKyvEf9G3lZ6zCREOSl2BXq4m8W8kmbUFLhAWOpazblFKnB8jCt7w11Z2cj5f5K5Ai1ZJCc9YeybXuh/JdnSwYZ8QXWblAbrB19gZcATiLmpvpwiN6szILqMHIIPattbSj2GUrB6SbBVY47s5ZtfUMuyDGUq3Q0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lDEn1IiD; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88246676008so15090486d6.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 03:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762772806; x=1763377606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZlDwF1uZo+6iYVM/WU/KP07QPOLCz1d2Q7NhIAKrgQ=;
        b=lDEn1IiD1iJSspe/h7oRsmkWm5uvUB8/Xk+Ekt4hnDC1QDvoIYp7DK3DZ6n2pTzKRP
         HYSvsSecaMvCkA59ILp4BeSWb92ZFqKQADnG0Z2SDBrai97Qkz7KGfcQO/isNcgMr+dd
         3R58af6ij/w3zmpsTPdpukGLEmte1xEws9apkNPfL92Auh++D54QHZn2cAboKBa4T+VQ
         CCpbIhS4qc8rTFEGTchokdAelIImN6OXHNuAWZF+ZuUpg0X6pO83F8992Y2o/05kXZMl
         ITDF/9ZmbUiMttT1XOemwV+g2909jnMj91TbqXE482XrVRK/sJZ2+W3sNAXrGheGqJzz
         oGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772806; x=1763377606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZlDwF1uZo+6iYVM/WU/KP07QPOLCz1d2Q7NhIAKrgQ=;
        b=M+QZzHFnTci3wydOghv3jVskzdjj/+eHcqtgUfAmpTrYNYcU8HDmDNvvCI2kNntVqz
         fz/4DYbo3vIUlbedLS/fMgKWZgiE3yrCGfjrLE3p9UNzBNm/T9Rt/KpsyRtmrBFRdTX2
         p/Q4OQHwKg5L/ky6cv0i/ztM76QPDF5L/y6hcznuha14S7No+gRtLtnJE6NFz1MtARkt
         HMs3ZAeI6QpAwhZGrcObGxhqFaJikYN/AWV25AOZUkyuMW7FLY/trnUliD8GtOWu/mj5
         ltdkV5/46TqIJ1I+H7ElVUXe2VaxRWhZNnxLv/Jy/NKSUBTqD5DwgXHpsZcnx7QPXvXa
         yGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8kC+RzXE1HBEZ5di2tUkkjRc6GTtKjrVu6UBubq0wjgZrYAcdt1ukwKACP28BzB2yIyv1aGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF3AsliAO20oWOXJwNA53VtssRHLebMeKz2uiwPSCa11RmsSi3
	5nIoVpyGpFPFCZ0WSx5YgKwAUSk3DoXAfUw+F7BSactcGfkjpSZLC13CElr07QWocVFxC945InB
	P4I+3ehN8lsqeCWkQ/hqxunDO60K8kbSSjXF2Kkj7
X-Gm-Gg: ASbGncuNWkrVTpIS8ZAkeDywt0Yd7kQHJZ7o87diAKS0xDH+UB2JOnnL6fWkOdodHMJ
	ZqUWKuaf82iv9fR6ioWjDfvhhNd6nwluzwEr5cxDSCLHBSCpbZno7FEYjarOLa4SEo/8RySEMJ4
	elHZYNbXUOQlZUvWI/ogLaAa84OzZrJNxoLicNQsUwHGzSc2tL6YfwOdTtL18bwwIQkD+dcsEnW
	M5u7MQX5rs0PTMRIeOJud/0Qb1cHz1zp6+RfYjXq66ggVWKgFirZvXDoDYpvvHoYmWsd9WI//1C
	9SaPDkU=
X-Google-Smtp-Source: AGHT+IErfuHZa8wEPzyF9Cfy8fvRXDoa9eur3IHCDQmPWqEk3WbCIWP2YxTN/9nJraiIUoW/zqhDmYZzy+VjBUVoXeE=
X-Received: by 2002:a05:6214:528a:b0:80a:7bd3:e61d with SMTP id
 6a1803df08f44-882386c6c3fmr111087866d6.34.1762772803767; Mon, 10 Nov 2025
 03:06:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109161215.2574081-1-edumazet@google.com> <cb568e91-9114-4e9a-ba88-eb4fc3772690@kernel.org>
In-Reply-To: <cb568e91-9114-4e9a-ba88-eb4fc3772690@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Nov 2025 03:06:32 -0800
X-Gm-Features: AWmQ_bl7N7tZUVqrLGviAHPvf1_xcfaibwkZ2ZuZWsBBQCupUNH0Kxu2PL9Fssw
Message-ID: <CANn89iJtEhs=sGsRF+NATcLL9-F8oKWxN_2igJehP8RvZjT-Lg@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 2:36=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 09/11/2025 17.12, Eric Dumazet wrote:
> > After commit 100dfa74cad9 ("inet: dev_queue_xmit() llist adoption")
> > I started seeing many qdisc requeues on IDPF under high TX workload.
> >
> > $ tc -s qd sh dev eth1 handle 1: ; sleep 1; tc -s qd sh dev eth1 handle=
 1:
> > qdisc mq 1: root
> >   Sent 43534617319319 bytes 268186451819 pkt (dropped 0, overlimits 0 r=
equeues 3532840114)
> >   backlog 1056Kb 6675p requeues 3532840114
> > qdisc mq 1: root
> >   Sent 43554665866695 bytes 268309964788 pkt (dropped 0, overlimits 0 r=
equeues 3537737653)
> >   backlog 781164b 4822p requeues 3537737653
> >
> > This is caused by try_bulk_dequeue_skb() being only limited by BQL budg=
et.
> >
> > perf record -C120-239 -e qdisc:qdisc_dequeue sleep 1 ; perf script
> > ...
> >   netperf 75332 [146]  2711.138269: qdisc:qdisc_dequeue: dequeue ifinde=
x=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D=
1292 skbaddr=3D0xff378005a1e9f200
> >   netperf 75332 [146]  2711.138953: qdisc:qdisc_dequeue: dequeue ifinde=
x=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D=
1213 skbaddr=3D0xff378004d607a500
> >   netperf 75330 [144]  2711.139631: qdisc:qdisc_dequeue: dequeue ifinde=
x=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D=
1233 skbaddr=3D0xff3780046be20100
> >   netperf 75333 [147]  2711.140356: qdisc:qdisc_dequeue: dequeue ifinde=
x=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D=
1093 skbaddr=3D0xff37800514845b00
> >   netperf 75337 [151]  2711.141037: qdisc:qdisc_dequeue: dequeue ifinde=
x=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D=
1353 skbaddr=3D0xff37800460753300
> >   netperf 75337 [151]  2711.141877: qdisc:qdisc_dequeue: dequeue ifinde=
x=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D=
1367 skbaddr=3D0xff378004e72c7b00
> >   netperf 75330 [144]  2711.142643: qdisc:qdisc_dequeue: dequeue ifinde=
x=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D=
1202 skbaddr=3D0xff3780045bd60000
> > ...
> >
> > This is bad because :
> >
> > 1) Large batches hold one victim cpu for a very long time.
> >
> > 2) Driver often hit their own TX ring limit (all slots are used).
> >
> > 3) We call dev_requeue_skb()
> >
> > 4) Requeues are using a FIFO (q->gso_skb), breaking qdisc ability to
> >     implement FQ or priority scheduling.
> >
> > 5) dequeue_skb() gets packets from q->gso_skb one skb at a time
> >     with no xmit_more support. This is causing many spinlock games
> >     between the qdisc and the device driver.
> >
> > Requeues were supposed to be very rare, lets keep them this way.
> >
> > Limit batch sizes to /proc/sys/net/core/dev_weight (default 64) as
> > __qdisc_run() was designed to use.
> >
> > Fixes: 5772e9a3463b ("qdisc: bulk dequeue support for qdiscs with TCQ_F=
_ONETXQUEUE")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> > Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > ---
> >   net/sched/sch_generic.c | 17 ++++++++++-------
> >   1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index d9a98d02a55fc361a223f3201e37b6a2b698bb5e..852e603c17551ee719bf1c5=
61848d5ef0699ab5d 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -180,9 +180,10 @@ static inline void dev_requeue_skb(struct sk_buff =
*skb, struct Qdisc *q)
> >   static void try_bulk_dequeue_skb(struct Qdisc *q,
> >                                struct sk_buff *skb,
> >                                const struct netdev_queue *txq,
> > -                              int *packets)
> > +                              int *packets, int budget)
> >   {
> >       int bytelimit =3D qdisc_avail_bulklimit(txq) - skb->len;
> > +     int cnt =3D 0;
>
> You patch makes perfect sense, that we want this budget limit.
>
> But: Why isn't bytelimit saving us?

BQL can easily grow
/sys/class/net/eth1/queues/tx-XXX/byte_queue_limits/limit to quite big
values with MQ high speed devices.

Each TX queue is usually serviced with RR, meaning that some of them
can get a long standing queue.


tjbp26:/home/edumazet# ./super_netperf 200 -H tjbp27 -l 100 &
[1] 198996

tjbp26:/home/edumazet# grep .
/sys/class/net/eth1/queues/tx-*/byte_queue_limits/limit
/sys/class/net/eth1/queues/tx-0/byte_queue_limits/limit:116826
/sys/class/net/eth1/queues/tx-10/byte_queue_limits/limit:84534
/sys/class/net/eth1/queues/tx-11/byte_queue_limits/limit:342924
/sys/class/net/eth1/queues/tx-12/byte_queue_limits/limit:433302
/sys/class/net/eth1/queues/tx-13/byte_queue_limits/limit:409254
/sys/class/net/eth1/queues/tx-14/byte_queue_limits/limit:434112
/sys/class/net/eth1/queues/tx-15/byte_queue_limits/limit:68304
/sys/class/net/eth1/queues/tx-16/byte_queue_limits/limit:65610
/sys/class/net/eth1/queues/tx-17/byte_queue_limits/limit:65772
/sys/class/net/eth1/queues/tx-18/byte_queue_limits/limit:69822
/sys/class/net/eth1/queues/tx-19/byte_queue_limits/limit:440634
/sys/class/net/eth1/queues/tx-1/byte_queue_limits/limit:70308
/sys/class/net/eth1/queues/tx-20/byte_queue_limits/limit:304824
/sys/class/net/eth1/queues/tx-21/byte_queue_limits/limit:497856
/sys/class/net/eth1/queues/tx-22/byte_queue_limits/limit:70308
/sys/class/net/eth1/queues/tx-23/byte_queue_limits/limit:535408
/sys/class/net/eth1/queues/tx-24/byte_queue_limits/limit:79419
/sys/class/net/eth1/queues/tx-25/byte_queue_limits/limit:70170
/sys/class/net/eth1/queues/tx-26/byte_queue_limits/limit:1595568
/sys/class/net/eth1/queues/tx-27/byte_queue_limits/limit:579108
/sys/class/net/eth1/queues/tx-28/byte_queue_limits/limit:430578
/sys/class/net/eth1/queues/tx-29/byte_queue_limits/limit:647172
/sys/class/net/eth1/queues/tx-2/byte_queue_limits/limit:345492
/sys/class/net/eth1/queues/tx-30/byte_queue_limits/limit:612392
/sys/class/net/eth1/queues/tx-31/byte_queue_limits/limit:344376
/sys/class/net/eth1/queues/tx-3/byte_queue_limits/limit:154740
/sys/class/net/eth1/queues/tx-4/byte_queue_limits/limit:60588
/sys/class/net/eth1/queues/tx-5/byte_queue_limits/limit:71970
/sys/class/net/eth1/queues/tx-6/byte_queue_limits/limit:70308
/sys/class/net/eth1/queues/tx-7/byte_queue_limits/limit:695454
/sys/class/net/eth1/queues/tx-8/byte_queue_limits/limit:101760
/sys/class/net/eth1/queues/tx-9/byte_queue_limits/limit:65286

Then if we send many small packets in a row, limit/pkt_avg_len can go
to arbitrary values.

Thanks.

>
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>
> >       while (bytelimit > 0) {
> >               struct sk_buff *nskb =3D q->dequeue(q);
> > @@ -193,8 +194,10 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
> >               bytelimit -=3D nskb->len; /* covers GSO len */
> >               skb->next =3D nskb;
> >               skb =3D nskb;
> > -             (*packets)++; /* GSO counts as one pkt */
> > +             if (++cnt >=3D budget)
> > +                     break;
> >       }
> > +     (*packets) +=3D cnt;
> >       skb_mark_not_on_list(skb);
> >   }
> >
> > @@ -228,7 +231,7 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc =
*q,
> >    * A requeued skb (via q->gso_skb) can also be a SKB list.
> >    */
> >   static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
> > -                                int *packets)
> > +                                int *packets, int budget)
> >   {
> >       const struct netdev_queue *txq =3D q->dev_queue;
> >       struct sk_buff *skb =3D NULL;
> > @@ -295,7 +298,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q,=
 bool *validate,
> >       if (skb) {
> >   bulk:
> >               if (qdisc_may_bulk(q))
> > -                     try_bulk_dequeue_skb(q, skb, txq, packets);
> > +                     try_bulk_dequeue_skb(q, skb, txq, packets, budget=
);
> >               else
> >                       try_bulk_dequeue_skb_slow(q, skb, packets);
> >       }
> > @@ -387,7 +390,7 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qd=
isc *q,
> >    *                          >0 - queue is not empty.
> >    *
> >    */
> > -static inline bool qdisc_restart(struct Qdisc *q, int *packets)
> > +static inline bool qdisc_restart(struct Qdisc *q, int *packets, int bu=
dget)
> >   {
> >       spinlock_t *root_lock =3D NULL;
> >       struct netdev_queue *txq;
> > @@ -396,7 +399,7 @@ static inline bool qdisc_restart(struct Qdisc *q, i=
nt *packets)
> >       bool validate;
> >
> >       /* Dequeue packet */
> > -     skb =3D dequeue_skb(q, &validate, packets);
> > +     skb =3D dequeue_skb(q, &validate, packets, budget);
> >       if (unlikely(!skb))
> >               return false;
> >
> > @@ -414,7 +417,7 @@ void __qdisc_run(struct Qdisc *q)
> >       int quota =3D READ_ONCE(net_hotdata.dev_tx_weight);
> >       int packets;
> >
> > -     while (qdisc_restart(q, &packets)) {
> > +     while (qdisc_restart(q, &packets, quota)) {
> >               quota -=3D packets;
> >               if (quota <=3D 0) {
> >                       if (q->flags & TCQ_F_NOLOCK)
>

