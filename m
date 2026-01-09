Return-Path: <netdev+bounces-248363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F09D074D3
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 07:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 346FE301D642
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 06:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D02A270EDF;
	Fri,  9 Jan 2026 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6aAs86b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrK3w1UP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A927E1C5
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938572; cv=none; b=ZEoF2kenUh4tmAEwCcQ9/2ReBsT6OKrtdRlyOjKn1+oar7w+pgaxV1jjwmunFhxVpILXVgJFYHEst7bEFdI0s6NctUWIbe+wlm8dDh/ArRzSda49t2WXFIe8GqmWZkQZvhaifaugdDqxvMvhAxT0QTN0F9ak9KsrXPsp9eFV/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938572; c=relaxed/simple;
	bh=YnFTIdi4PfaMQlpxKfShCgMWDg6rF+C/fBvVfeSfgPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrsKipTQPICoy2YvZcbGqHRIvZvlzMU8vgOjRSB93rI5kax9j0rGIMRB+EhbynPIeBXF3CtCY4HCAlTga+e6EFmta00iQLsCVfs4ogaZp/OlhFVVHOObPYWrmTaQ7hxamClHK98a2Tabr9C8zoqsH1RApHgpqNA+iP78r4ajHYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6aAs86b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PrK3w1UP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767938569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2hMlpnvLYoRWhhofMpO/2lLV9HUsoZryYZGZueCrTY=;
	b=N6aAs86btc1DmiBBozEF8sQxt63bk5nLBlZORlmnwIcGI5NfvXIB1Kxa8Fapi6tZERfFMt
	UGuJ7zUIqVqRaoEzjQzo0Mkuun6JXG4Mjoh/g5MwiGAIr18PL1b7EhdKDdMDCZIbdy9Q48
	ZgirZbyJgDNOd84Femcd6zilNj7TZUk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-kc0rj589Mf-OG030mnNELA-1; Fri, 09 Jan 2026 01:02:48 -0500
X-MC-Unique: kc0rj589Mf-OG030mnNELA-1
X-Mimecast-MFC-AGG-ID: kc0rj589Mf-OG030mnNELA_1767938567
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b609c0f6522so6608386a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 22:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767938565; x=1768543365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2hMlpnvLYoRWhhofMpO/2lLV9HUsoZryYZGZueCrTY=;
        b=PrK3w1UPjzb9WuB2U1oPeUsMAk9KcERg7a5ePkxzn+32lVsRAvlg8gGld96wSnVS7O
         BpLnpYNJQohxuqlgA5i6eUHu3txMbxGjyGfp5SGDVqLmhXUj6pzo/dbyaB6wq+Y1aWvP
         EJS3nc11/cdkuc0SIfABglcxHQBiAeJ8GGcan6WuKzDQLwrUyFE6Ay/4TMpztfPoCzP8
         FofzgsCfmQ3PiRXH5bZ/T2kLDG7EihTeLQwIZdQefmOUJ2hTCrSAaCYk/b7BS6UDx/nj
         P6aciVnjRdTht9STN2Rw/pd4msaGzdUf+UA/LSJtMC86JH11O8TbCXAeUE9JUk9KGNW0
         W+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767938565; x=1768543365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p2hMlpnvLYoRWhhofMpO/2lLV9HUsoZryYZGZueCrTY=;
        b=JZKk0b5WaDfndeXpyVjkb8Kb/KIPXblA7C89X12nVzeA50fwg3i2fsTvKjeXNVWV5u
         S8WF/R9Wd9dQ/eGuJNeRXJXKSEzN2pQaGvXc/EqiP1o9uk8UZfjy2U+8RV1eAmYHabv6
         R0sgjdG1BdyKZsGDbotu1GwviSJimlv5cs8kd309ehTk/v9uUcqr739OliQACvzoh4oP
         hQ3v7R8RFU19aRGK9Fiwto+rp08lVajv5F6aVaKTPV5CKwlhPz/AY+5PDSDsWa/KeZXi
         XNsy/h8HcNZPuCsrP0iIS8Zfm0EDcIZgBF36XuVDU0CpsLCHiCdLYgmkZAj9Y8msU2K4
         o96A==
X-Forwarded-Encrypted: i=1; AJvYcCWXlXLn3hrPkj/C1pieaqo2yjg5YW20sM5BA1XSoSkGEhz463draDFfA6mODzoUsqUsqGYgMPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH//Qo7kt2yyqH6F7HogYiGik+L1y5AVfXDE5NT9wdWwBuiRay
	7gxQNQiZMjS9AfMcxrYwxYnwUSZsv0qnldEcmNVBcWxccozB4SOm7x0by5uIxaNHF19Mm9k4VrC
	8B0thZWqZwT6irD+J1LcQ3Lrx0UFgb78Xnzd5lQKGaaji8dzavi2n0KCQ4vagYr4vNzHx8kHoSA
	mdRNYrdp4ylR1f2J6+MZMPqN3iVe6IVaXy
X-Gm-Gg: AY/fxX4Mq29oYE225zxHf4SqCqVT2RMdEXbea64hl+EsLouOcodCTigyQXhdIiaw/lB
	GGqHLfAyOwnebb9VMqWQuhI7XIoSVAwSr1wKh/asSFAxR6ULV91GNPz8nceZ75JjI/BY/aG+oRS
	E34jBSF+fa/TCsLaz/uCsMZGb/Pn23X8RSnspcttJpXgA81/p4mZxuPRjhF3a0P3Q=
X-Received: by 2002:a05:6300:218a:b0:361:28dd:a9ff with SMTP id adf61e73a8af0-3898f991455mr7732756637.38.1767938564990;
        Thu, 08 Jan 2026 22:02:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrS63ctwaE/IB5vtnIB6hwxDOGodoN9HgUdD+0c8gMXe3jRJxxejS1yrmIdyI0s2U9RWy26VSaHfjh6vcmneo=
X-Received: by 2002:a05:6300:218a:b0:361:28dd:a9ff with SMTP id
 adf61e73a8af0-3898f991455mr7732725637.38.1767938564493; Thu, 08 Jan 2026
 22:02:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-4-simon.schippers@tu-dortmund.de> <CACGkMEuSiEcyaeFeZd0=RgNpviJgNvUDq_ctjeMLT5jZTgRkwQ@mail.gmail.com>
 <1e30464c-99ae-441e-bb46-6d0485d494dc@tu-dortmund.de>
In-Reply-To: <1e30464c-99ae-441e-bb46-6d0485d494dc@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jan 2026 14:02:32 +0800
X-Gm-Features: AQt7F2qdsvdsydCjiqne5rbrvnwgfREUOtYyZEbAt_1uB3BziRw5-zQdeYgLgS8
Message-ID: <CACGkMEtzD3ORJuJcc8VeqwASiGeVFdQmJowsK6PYVEF_Zkcn8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/8/26 04:38, Jason Wang wrote:
> > On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_ring_consum=
e()
> >> and wake the corresponding netdev subqueue when consuming an entry fre=
es
> >> space in the underlying ptr_ring.
> >>
> >> Stopping of the netdev queue when the ptr_ring is full will be introdu=
ced
> >> in an upcoming commit.
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index 1197f245e873..2442cf7ac385 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_queue *q,
> >>         return ret ? ret : total;
> >>  }
> >>
> >> +static void *tap_ring_consume(struct tap_queue *q)
> >> +{
> >> +       struct ptr_ring *ring =3D &q->ring;
> >> +       struct net_device *dev;
> >> +       void *ptr;
> >> +
> >> +       spin_lock(&ring->consumer_lock);
> >> +
> >> +       ptr =3D __ptr_ring_consume(ring);
> >> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1))=
) {
> >> +               rcu_read_lock();
> >> +               dev =3D rcu_dereference(q->tap)->dev;
> >> +               netif_wake_subqueue(dev, q->queue_index);
> >> +               rcu_read_unlock();
> >> +       }
> >> +
> >> +       spin_unlock(&ring->consumer_lock);
> >> +
> >> +       return ptr;
> >> +}
> >> +
> >>  static ssize_t tap_do_read(struct tap_queue *q,
> >>                            struct iov_iter *to,
> >>                            int noblock, struct sk_buff *skb)
> >> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
> >>                                         TASK_INTERRUPTIBLE);
> >>
> >>                 /* Read frames from the queue */
> >> -               skb =3D ptr_ring_consume(&q->ring);
> >> +               skb =3D tap_ring_consume(q);
> >>                 if (skb)
> >>                         break;
> >>                 if (noblock) {
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index 8192740357a0..7148f9a844a4 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct tun_struct =
*tun,
> >>         return total;
> >>  }
> >>
> >> +static void *tun_ring_consume(struct tun_file *tfile)
> >> +{
> >> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >> +       struct net_device *dev;
> >> +       void *ptr;
> >> +
> >> +       spin_lock(&ring->consumer_lock);
> >> +
> >> +       ptr =3D __ptr_ring_consume(ring);
> >> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1))=
) {
> >
> > I guess it's the "bug" I mentioned in the previous patch that leads to
> > the check of __ptr_ring_consume_created_space() here. If it's true,
> > another call to tweak the current API.
> >
> >> +               rcu_read_lock();
> >> +               dev =3D rcu_dereference(tfile->tun)->dev;
> >> +               netif_wake_subqueue(dev, tfile->queue_index);
> >
> > This would cause the producer TX_SOFTIRQ to run on the same cpu which
> > I'm not sure is what we want.
>
> What else would you suggest calling to wake the queue?

I don't have a good method in my mind, just want to point out its implicati=
ons.

>
> >
> >> +               rcu_read_unlock();
> >> +       }
> >
> > Btw, this function duplicates a lot of logic of tap_ring_consume() we
> > should consider to merge the logic.
>
> Yes, it is largely the same approach, but it would require accessing the
> net_device each time.

The problem is that, at least for TUN, the socket is loosely coupled
with the netdev. It means the netdev can go away while the socket
might still exist. That's why vhost only talks to the socket, not the
netdev. If we really want to go this way, here, we should at least
check the existence of tun->dev first.

>
> >
> >> +
> >> +       spin_unlock(&ring->consumer_lock);
> >> +
> >> +       return ptr;
> >> +}
> >> +
> >>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *=
err)
> >>  {
> >>         DECLARE_WAITQUEUE(wait, current);
> >>         void *ptr =3D NULL;
> >>         int error =3D 0;
> >>
> >> -       ptr =3D ptr_ring_consume(&tfile->tx_ring);
> >> +       ptr =3D tun_ring_consume(tfile);
> >
> > I'm not sure having a separate patch like this may help. For example,
> > it will introduce performance regression.
>
> I ran benchmarks for the whole patch set with noqueue (where the queue is
> not stopped to preserve the old behavior), as described in the cover
> letter, and observed no performance regression. This leads me to conclude
> that there is no performance impact because of this patch when the queue
> is not stopped.

Have you run a benchmark per patch? Or it might just be because the
regression is not obvious. But at least this patch would introduce
more atomic operations or it might just because the TUN doesn't
support burst so pktgen can't have the best PPS.

Thanks


>
> >
> >>         if (ptr)
> >>                 goto out;
> >>         if (noblock) {
> >> @@ -2131,7 +2152,7 @@ static void *tun_ring_recv(struct tun_file *tfil=
e, int noblock, int *err)
> >>
> >>         while (1) {
> >>                 set_current_state(TASK_INTERRUPTIBLE);
> >> -               ptr =3D ptr_ring_consume(&tfile->tx_ring);
> >> +               ptr =3D tun_ring_consume(tfile);
> >>                 if (ptr)
> >>                         break;
> >>                 if (signal_pending(current)) {
> >> --
> >> 2.43.0
> >>
> >
> > Thanks
> >
>


