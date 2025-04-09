Return-Path: <netdev+bounces-180769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1590EA826A6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514337A5175
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E40325F960;
	Wed,  9 Apr 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8EeP5AH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B4245024
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206484; cv=none; b=X3mexwE1zTQgb7WxMWst0Lga7HVqbuFheNFVdTPF0fUGkoPEO1qEJk7LbqGy9BjH/3HdE+Y6xmWdKc73aQ4hdi2/PEkGJ/sQfZPoiKqTa0sGTCf36g2sBOsJyfJv/OtNoZxMhMJ8kdgydFmWDWs5CquhDNSkKxgHTlUyc/3xLGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206484; c=relaxed/simple;
	bh=f2ydJJ2LvfQSJZ7sBLtOOcY5yLjYIu008xWioBAly+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SqckzsjgNPJO1nvMs64YhJLWCxA/AfIjjm71S+xmf4RG7FhoMo+8nsV+ERDNhQTANcNBAeYIEUqyYXUKphosVGkP95bjQDvVQFZsnnggOTwnva6nax5P22Bj8byqxCumANAuXyJHa5pp3HNQ1a/xslUJMKft/ilaFW8E4NrVr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8EeP5AH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744206481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2ydJJ2LvfQSJZ7sBLtOOcY5yLjYIu008xWioBAly+A=;
	b=X8EeP5AHpamJUxG92CCK7zkxRpikavXlsdxbKN4kFMXcyrBZqDI+GkTrzo86+erExhaYAb
	3xD8eXwSgbqx/H2FzX4e8HIViJXaDHMUyC3RfQaSRkDjHIHK40wDf6MsPL99njPC6EpSGf
	inrHdoX38sY1huO6CO/JU0vAQHgkgg8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-bpOlJMzPPQCoZUktfBvbRw-1; Wed, 09 Apr 2025 09:47:59 -0400
X-MC-Unique: bpOlJMzPPQCoZUktfBvbRw-1
X-Mimecast-MFC-AGG-ID: bpOlJMzPPQCoZUktfBvbRw_1744206478
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5495a1c0be4so3634852e87.2
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 06:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206477; x=1744811277;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2ydJJ2LvfQSJZ7sBLtOOcY5yLjYIu008xWioBAly+A=;
        b=IlLDFYAbJhEmAM5BRg3sT83JG2dr5v9PGh4A9RTcCfrcKGuhxsh6xd36xIrfqmbKrU
         X48Hm0CNnL7AMPAcR8cyIpXinDnF3oTzaa11IIJSjS9hW3PrYXKQQ2K5XOGjVT9Qv+48
         7gjwTVq7LdZgCj5SxTRUKv6tUOUOJOmn401QB5J30AXB/Bn+ODhqdfuB1eJbqf5NLni3
         VHNA4EWyn8qsrC60JdWoT484fdvnJLYv9QGl2CxL5o/4JA8FnKdHo138XjX7WRY7xLIq
         sThlWQHYaIwvMqhoZtTSOqXfAsv4lE2VQi0odxYPwWM2kHBFLIekf5bJyiZvSbRwE09S
         tiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcCxIuedeF70GRSf1IR4pNi3ZSS4Nl1Gaj8vO9ekspuNdFj23auvpMyNK0zgD+1PuxpeNU79Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamIUvyCpEURF7sXhCHO9+hg4MoQ0vuYCB6/HqSYxB02GELp2J
	tdg3qiLnF/Dwe7hwjyL+a23uJONGSYcP2FMYeeEoKf4zzw4W2IJM2YbaRwWVys41nzylJIzHmdn
	S3HoN/8jBTg4LBmIx3ljokgCQr5IubS6yHtwPbirGY9CVd8O1Anhreg==
X-Gm-Gg: ASbGncscSQmlBA2wMX543Urd+R5fDnlOioS9a9h6C4FqpNjEbyKvhigqhysDCGifC5o
	N211BoD4tQXpbaxjn4EyTE4tE392+bYj8BwzN/LuBx3N7LYsikuvcza7/4Ue9k5yUgSsBsrrtT7
	XdvBKD6dc76c5SdXI23fDHFhLmR10FGTYvnIv/DRP6/0WuB36+EcRGFLLHJMIWlFn/N2snclA1e
	PDDystB1SDS/VhJfiOYIefXhuFa5nECG+TivDo3Acjl8ZGkL0d6pAFugpirESMdPlukg44qlPZv
	YGRr7t1sGwbD3r5N5bC7jICCifK0GWnvGwKE
X-Received: by 2002:a05:6512:3193:b0:549:39ca:13fc with SMTP id 2adb3069b0e04-54c44572139mr802919e87.49.1744206477450;
        Wed, 09 Apr 2025 06:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM6DWIebjcMHoOZ7N0dj4SQTbS1OebuNprP9FBYlaYqKh4d8K6UdF9LncmFemeQcSlWldYZg==
X-Received: by 2002:a05:6512:3193:b0:549:39ca:13fc with SMTP id 2adb3069b0e04-54c44572139mr802912e87.49.1744206477007;
        Wed, 09 Apr 2025 06:47:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c4565f404sm142020e87.145.2025.04.09.06.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:47:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2F80E19920DE; Wed, 09 Apr 2025 15:47:55 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet
 <eric.dumazet@gmail.com>, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, edumazet@google.com
Cc: bpf@vger.kernel.org, tom@herbertland.com, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net-next V2 2/2] net: sched: generalize check for no-op
 qdisc
In-Reply-To: <e40c4f92-cc4f-49d2-9d7f-e2d88aeba873@kernel.org>
References: <174412623473.3702169.4235683143719614624.stgit@firesoul>
 <174412628464.3702169.81132659219041209.stgit@firesoul>
 <1ad134d3-4173-4d43-b2ad-0b2c5165bbc1@gmail.com>
 <e40c4f92-cc4f-49d2-9d7f-e2d88aeba873@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 09 Apr 2025 15:47:55 +0200
Message-ID: <87ikndv438.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 08/04/2025 17.47, Eric Dumazet wrote:
>>=20
>> On 4/8/25 5:31 PM, Jesper Dangaard Brouer wrote:
>>> Several drivers (e.g., veth, vrf) contain open-coded checks to determine
>>> whether a TX queue has a real qdisc attached - typically by testing if
>>> qdisc->enqueue is non-NULL.
>>>
>>> These checks are functionally equivalent to comparing the queue's qdisc
>>> pointer against &noop_qdisc (qdisc named "noqueue"). This equivalence
>>> stems from noqueue_init(), which explicitly clears the enqueue pointer
>>> for the "noqueue" qdisc. As a result, __dev_queue_xmit() treats the qdi=
sc
>>> as a no-op only when enqueue =3D=3D NULL.
>>>
>>> This patch introduces a common helper, qdisc_txq_is_noop() to standardi=
ze
>>> this check. The helper is added in sch_generic.h and replaces open-coded
>>> logic in both the veth and vrf drivers.
>>>
>>> This is a non-functional change.
>>>
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> ---
>>> =C2=A0 drivers/net/veth.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 14 +-------------
>>> =C2=A0 drivers/net/vrf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 3 +--
>>> =C2=A0 include/net/sch_generic.h |=C2=A0=C2=A0=C2=A0 7 ++++++-
>>> =C2=A0 3 files changed, 8 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>> index f29a0db2ba36..83c7758534da 100644
>>> --- a/drivers/net/veth.c
>>> +++ b/drivers/net/veth.c
>>> @@ -341,18 +341,6 @@ static bool veth_skb_is_eligible_for_gro(const=20
>>> struct net_device *dev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcv->featu=
res & (NETIF_F_GRO_FRAGLIST | NETIF_F_GRO_UDP_FWD));
>>> =C2=A0 }
>>> -/* Does specific txq have a real qdisc attached? - see noqueue_init() =
*/
>>> -static inline bool txq_has_qdisc(struct netdev_queue *txq)
>>> -{
>>> -=C2=A0=C2=A0=C2=A0 struct Qdisc *q;
>>> -
>>> -=C2=A0=C2=A0=C2=A0 q =3D rcu_dereference(txq->qdisc);
>>> -=C2=A0=C2=A0=C2=A0 if (q->enqueue)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>> -=C2=A0=C2=A0=C2=A0 else
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> -}
>>> -
>>> =C2=A0 static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_dev=
ice=20
>>> *dev)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct veth_priv *rcv_priv, *priv =3D ne=
tdev_priv(dev);
>>> @@ -399,7 +387,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb,=20
>>> struct net_device *dev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 txq =3D netdev_g=
et_tx_queue(dev, rxq);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!txq_has_qdisc(txq)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qdisc_txq_is_noop(txq))=
 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dev_kfree_skb_any(skb);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto drop;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>>> index 7168b33adadb..d4fe36c55f29 100644
>>> --- a/drivers/net/vrf.c
>>> +++ b/drivers/net/vrf.c
>>> @@ -349,9 +349,8 @@ static bool qdisc_tx_is_default(const struct=20
>>> net_device *dev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 txq =3D netdev_get_tx_queue(dev, 0);
>>> -=C2=A0=C2=A0=C2=A0 qdisc =3D rcu_access_pointer(txq->qdisc);
>>> -=C2=A0=C2=A0=C2=A0 return !qdisc->enqueue;
>>> +=C2=A0=C2=A0=C2=A0 return qdisc_txq_is_noop(txq);
>>> =C2=A0 }
>>> =C2=A0 /* Local traffic destined to local address. Reinsert the packet =
to rx
>>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>>> index d48c657191cd..eb90d5103371 100644
>>> --- a/include/net/sch_generic.h
>>> +++ b/include/net/sch_generic.h
>>> @@ -803,6 +803,11 @@ static inline bool qdisc_tx_changing(const struct=
=20
>>> net_device *dev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0 }
>>> +static inline bool qdisc_txq_is_noop(const struct netdev_queue *txq)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return (rcu_access_pointer(txq->qdisc) =3D=3D &noop=
_qdisc);
>>=20
>>=20
>> return (expression);
>>=20
>> ->
>>=20
>> return expression;
>>=20
>>=20
>> return rcu_access_pointer(txq->qdisc) =3D=3D &noop_qdisc;
>
> Will fix in next iteration.
>
>> I also feel this patch should come first in the series ?
>>=20
>
> To me it looks/feels wrong doing this before there are two users.
> With only the vrf driver, the changed looked unnecessary.
> The diff stats looks/feels wrong, when it's patch-1.

Generalising something in preparation for another user is pretty normal,
isn't it? Just write this in the commit message, like: "In preparation
for using this in more places, move the check for a noop qdisc from the
vrf driver into sch_generic.h" - or something like that?

-Toke


