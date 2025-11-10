Return-Path: <netdev+bounces-237157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22771C4646C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF623B61DD
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1603081CD;
	Mon, 10 Nov 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ak4gjOrL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nc0eUka3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D5309EF6
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774278; cv=none; b=alsn4yyc1FQqUNfhSHUCgdrmtbD9FyByKMdtFm4KydKHn6Qb4BB6Zo2fQABWkl6L8EOYv9DRNemtHE17IT2iA/ocOuQ+pOCOTN2uk8z3siIU7QtgoktAXd4Ed9q0pk1mgHD2m6vSGiU6R12wxWJsNfLtPIQYP24ImlV80ehxH08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774278; c=relaxed/simple;
	bh=87S5DFyVU6BSVlylM+77tmHV0zz3KORBA3y9xgcKd0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u5VPzZ6D653ETVlNnXZpjaWnVlRnUEqmgW6UxPk9zxpF1gbHwxEqXWH+Z2imvKzCAMuXgdlVW7rllhRu8ygGbOJVubKd4H+p9oClvqPV9u53laGONHdJDhjIfWU6O+aabyV+YEMZOOf7Tg8iBKX/8Uh2yVeGODqACcWVR5uRrrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ak4gjOrL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nc0eUka3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762774275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsnt7u38CRgeupP1Z44a3iDRSZcxegQ1k6nBVhc7Pvw=;
	b=Ak4gjOrL0w8BW8wvbRLqgPcqTntxQw6ozhfLQhNuO7nIARapY30DBUiip03SmXNhvqT2Jw
	CundY5gmbci9Bcf06jC681VZgItR8b+tDh4J2XsMfgd0CZH9BgGlT2Enwv0dNSoi9NUvIu
	devTzzPEJ0UldqyodR9jwWiLIvk3DRE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-1DOxrX8UOJS0HMY7Rxj7YA-1; Mon, 10 Nov 2025 06:31:13 -0500
X-MC-Unique: 1DOxrX8UOJS0HMY7Rxj7YA-1
X-Mimecast-MFC-AGG-ID: 1DOxrX8UOJS0HMY7Rxj7YA_1762774272
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-640ed3ad89bso4825854a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 03:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762774272; x=1763379072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsnt7u38CRgeupP1Z44a3iDRSZcxegQ1k6nBVhc7Pvw=;
        b=nc0eUka3RJRaXmYanQ+osRW779ZhU9BbXMn7pH08Qx78trCs3SoEZ1mUeQ2wgqV/M0
         TpIYAOELRjYI7Lw0sW+WuE6uFDd1u+Pf9MMUKzsN91du9fsITEuQXAtFpGe/dZcexBrJ
         MhLF8d9aPFn/y9vxOVOTB4jU6BX8iK4AjssYo/zviapgHyxZNc876cL0pUH5ifYvNgGM
         SKwUSvxNuIOMOG3+brP//KpamkUA7mqsXjcVkl2hgrR9tK6RKbQBpUIjYLHWpl4C3VSY
         PJMMMJfU5A4RvPWoAi60L+VTefRvH2Kx1rG33JDoMy+ro64Ac+UPP4B4cxQmvkS7N5yP
         yaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774272; x=1763379072;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zsnt7u38CRgeupP1Z44a3iDRSZcxegQ1k6nBVhc7Pvw=;
        b=E45gZ14CiFFtSEMJKIYLfkvxewA7A+ggdFiegy6dOHsZwj7A7rqbCO2DO3an3IuY7J
         oyNU0Fnaa5oKBy4wCn2DZmSAw8PENJEDtH3Y8cB82yproycHpN/FUF2GFNAOUX7F2DaW
         IBcSWUA8Mpmfltli27uOme/lsChaHOQR0N84yB0GMXwa8/DgTHnJ/7gFhT6sTrJFJjqf
         Uw5L9zyzEPyk118ycQWcYpPqG1yWLUY991gHNJ3MRAWTGeRhdDGBbD9yWzfWSiNfdWoc
         rsCb0V+QyHDRiijvtPK6j0re+K6R8OuqllaAeuyHs3bhu3Xs0bk1I3X0YpfO2gS8Hj2j
         mXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVyjpEtS+VhCjKYeYfune2auWSHjv3+05ZrwnJrQLfCrEpTuei+i+LGPzpWHX2s51xpakAFEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVDjYYUXxuxRdjZcfma8/QYf/tx2yR2Lg5bISoa2vo06yRSh9a
	GGuHqERy84qOF5jeO/YB3GthjnbqbYgVgx8bvRFIiRsDW4/jbLcs+SsAICbNK2V7YJ3m4hzWJt+
	MoxpBo+MSCf6gfAeVe5uk644s7sMXZzodbO0j7Hjnjo7kWqrlkATTtwVIVA==
X-Gm-Gg: ASbGncuxj0w/MzV6MQ22VHbqKjkgVIJnzTbO38u2amRDDjlM9DkPFj9i+F2PdzTJPXM
	7U1rr8nnWKMstnuN2eFuHSpssB8jo5Kz1qepetVflMpgVa9P1zCdBimCZP5wSd+xo/OCdo9jOG6
	ExqX0Ot6dc0NSUF+SgKpTUCLQDSr7B/Iu/MP6+FYPvy2rcPSOFiJZiTbpic05STSm0HDz97aGt9
	LQIDGc6EsOrbu1UjYylgiXEDKmFLNac36Hr7ITfpvwbqk9mmcar0HO0aBCDGu6E4W1/ICjna+s5
	uDNtB+KY1pYO63hUc2vAaUvrf7ikGdGBu/xiNzVpPXCMpWowi5iHR9OGJoq3rnnusUSIGoC8Kmc
	Lx413338jNAuQqodJ+GTOQt/CgA==
X-Received: by 2002:a05:6402:270e:b0:641:9aac:e4bd with SMTP id 4fb4d7f45d1cf-6419aaceeddmr1898191a12.26.1762774272400;
        Mon, 10 Nov 2025 03:31:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5uew1WZJ+227yjLb8Mn3p3mYcB/o7VHD1FPpXJf6kK5QZCwFi1NZ8PXnA41kUQu5huD0o0w==
X-Received: by 2002:a05:6402:270e:b0:641:9aac:e4bd with SMTP id 4fb4d7f45d1cf-6419aaceeddmr1898160a12.26.1762774271957;
        Mon, 10 Nov 2025 03:31:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64184b6c7e4sm3240586a12.24.2025.11.10.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:31:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2923532920C; Mon, 10 Nov 2025 12:31:08 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Jonas =?utf-8?Q?K=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki
 Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
In-Reply-To: <CANn89iL9XR=NA=_Bm-CkQh7KqOgC4f+pjCp+AiZ8B7zeiczcsA@mail.gmail.com>
References: <20251013145416.829707-1-edumazet@google.com>
 <20251013145416.829707-6-edumazet@google.com> <877bw1ooa7.fsf@toke.dk>
 <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
 <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
 <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
 <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com>
 <871pm7np2w.fsf@toke.dk>
 <ef601e55-16a0-4d3e-bd0d-536ed9dd29cd@tu-berlin.de>
 <CANn89iKDx52BnKZhw=hpCCG1dHtXOGx8pbynDoFRE0h_+a7JhQ@mail.gmail.com>
 <CANn89iKhPJZGWUBD0-szseVyU6-UpLWP11ZG0=bmqtpgVGpQaw@mail.gmail.com>
 <CANn89iL9XR=NA=_Bm-CkQh7KqOgC4f+pjCp+AiZ8B7zeiczcsA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 10 Nov 2025 12:31:08 +0100
Message-ID: <87seemm8eb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> On Sun, Nov 9, 2025 at 12:18=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
>>
>
>> I think the issue is really about TCQ_F_ONETXQUEUE :
>
> dequeue_skb() can only dequeue 8 packets at a time, then has to
> release the qdisc spinlock.

So after looking at this a bit more, I think I understand more or less
what's going on in the interaction between cake and your llist patch:

Basically, the llist patch moves the bottleneck from qdisc enqueue to
qdisc dequeue (in this setup that we're testing where the actual link
speed is not itself a bottleneck). Before, enqueue contends with dequeue
on the qdisc lock, meaning dequeue has no trouble keeping up, and the
qdisc never fills up.

With the llist patch, suddenly we're enqueueing a whole batch of packets
every time we take the lock, which means that dequeue can no longer keep
up, making it the bottleneck.

The complete collapse in throughput comes from the way cake deals with
unresponsive flows once the qdisc fills up: the BLUE part of its AQM
will drive up its drop probability to 1, where it will stay until the
flow responds (which, in this case, it never does).

Turning off the BLUE algorithm prevents the throughput collapse; there's
still a delta compared to a stock 6.17 kernel, which I think is because
cake is simply quite inefficient at dropping packets in an overload
situation. I'll experiment with a variant of the bulk dropping you
introduced to fq_codel and see if that helps. We should probably also
cap the drop probability of BLUE to something lower than 1.

The patch you sent (below) does not in itself help anything, but
lowering the constant to to 8 instead of 256 does help. I'm not sure
we want something that low, though; probably better to fix the behaviour
of cake, no?

-Toke

>> Perhaps we should not accept q->limit packets in the ll_list, but a
>> much smaller limit.
>
> I will test something like this
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 69515edd17bc6a157046f31b3dd343a59ae192ab..e4187e2ca6324781216c073de=
2ec20626119327a
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4185,8 +4185,12 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>         first_n =3D READ_ONCE(q->defer_list.first);
>         do {
>                 if (first_n && !defer_count) {
> +                       unsigned long total;
> +
>                         defer_count =3D atomic_long_inc_return(&q->defer_=
count);
> -                       if (unlikely(defer_count > q->limit)) {
> +                       total =3D defer_count + READ_ONCE(q->q.qlen);
> +
> +                       if (unlikely(defer_count > 256 || total >
> READ_ONCE(q->limit))) {
>                                 kfree_skb_reason(skb,
> SKB_DROP_REASON_QDISC_DROP);
>                                 return NET_XMIT_DROP;
>                         }


