Return-Path: <netdev+bounces-218885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A0AB3EF3C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB22073EF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF748246BD8;
	Mon,  1 Sep 2025 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Nb/2m7qv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185417A2EB
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756757495; cv=none; b=ja8zvg38ylC8W5xnupNU/mCa7FJN5PPrwOtcfEk+g/PGs1XCYOJL0SPUiD3QLN9/wy5D2mnEx66dJ3v8mNaooyspbNlhoE/Pib515fg2W/nq3PVMo8082GqejCQFrDvsGuhX9njq6ctFVTEkw9mb4apLmQtnzIuVYNSKkemm9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756757495; c=relaxed/simple;
	bh=JMdYRLzsfN2jApDAmMZg9zshoUjTBntMjX5zyDzeXhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKgskzYtLVA476TmYfXDcsc4EiN6uYj9UaW5eYaMBbfpTWfgKbTrQ8kRdiI/qp4H8nvjLZQ7EWAdhVk5VYCtWjU4W5MLcOMl9Jfjvs8OAThA5NELTZm1iPlVH4gWM+PC7WJOvPwQC3DUbpN0cbKxjHqA2Vg7J4FCycLg7qU9Ox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Nb/2m7qv; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BKNQGUbsQEq8mNl20DkZOUO9Oeh9xOUAig5E1TN2vzQ=; t=1756757493; x=1757621493; 
	b=Nb/2m7qvb6wOQls0nS2+igtV5/XLmSKg9R1GDdUwR6hUuH9IoGv8zKCTZGxqqmbbhH90EatoKHS
	FqjdYIbYCiWJ5iHgSGmzGnwWLLBqbgSND7Q0KfWuuccFE21TbEP17tP7DJvApHLpZG1KNwPnl4FMV
	i5AsDPjGKH1WqDixEgGbcV0eLGaGgiftF21peZqwf95SMMzCOerJsFsPVQLoxaA8CB+tqqtDo6xJj
	buNZsWQQGVl8WWRHKyyONd7Q2Z7UxwwwQO7fEYPotm/B0CxN/QAWedrMC2nuO7ZLVZBbaDNDT1Us1
	21FG61SAzB3R9/W0UtfWFmhyB6Qig7oioJKQ==;
Received: from mail-oi1-f176.google.com ([209.85.167.176]:61682)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1utAsF-0003pn-VW
	for netdev@vger.kernel.org; Mon, 01 Sep 2025 13:11:33 -0700
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-43813108e3dso70477b6e.2
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 13:11:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YyHt/vGYbRJCd9B7wFCtFjqdhoB2yputTr1WwEeI8TwC88+soqv
	PQgULPBs3jVUmvD2zUKDetwsIg+vzv6xCCZ9qXI9QFryUImAdb/lgJE3yqnFwjKxmMgWqid1s/K
	I8vFMzH6hN9bmVROga6j1FVQkToE+nFQ=
X-Google-Smtp-Source: AGHT+IGYPVY3t7JE3jJb12gqOkbjFAtL5CQKyz/tF3bhCnauP5iF9YQzb5ySR93+zNmr566q4RwOrJBEkq9G/wZmqqs=
X-Received: by 2002:a05:6808:219e:b0:437:aebb:cba1 with SMTP id
 5614622812f47-437f7cd8839mr4059555b6e.14.1756757491272; Mon, 01 Sep 2025
 13:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-10-ouster@cs.stanford.edu>
 <7d7516a6-07b7-4882-9da2-2c192ef43039@redhat.com>
In-Reply-To: <7d7516a6-07b7-4882-9da2-2c192ef43039@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 1 Sep 2025 13:10:55 -0700
X-Gmail-Original-Message-ID: <CAGXJAmydvaiY+0RNXLU-hdh1tYcTvUrvcuxWZTxsHbmWeTRSxw@mail.gmail.com>
X-Gm-Features: Ac12FXxvsSwIwn17mpOMePybSg1cPJuCn0XQh4QzFYUZr4VAjTR1oWKFq82_LVA
Message-ID: <CAGXJAmydvaiY+0RNXLU-hdh1tYcTvUrvcuxWZTxsHbmWeTRSxw@mail.gmail.com>
Subject: Re: [PATCH net-next v15 09/15] net: homa: create homa_rpc.h and homa_rpc.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: a12ca69960b22c421725509683a310dc

On Tue, Aug 26, 2025 at 4:31=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/18/25 10:55 PM, John Ousterhout wrote:
> > +/**
> > + * homa_rpc_reap() - Invoked to release resources associated with dead
> > + * RPCs for a given socket.
> > + * @hsk:      Homa socket that may contain dead RPCs. Must not be lock=
ed by the
> > + *            caller; this function will lock and release.
> > + * @reap_all: False means do a small chunk of work; there may still be
> > + *            unreaped RPCs on return. True means reap all dead RPCs f=
or
> > + *            hsk.  Will busy-wait if reaping has been disabled for so=
me RPCs.
> > + *
> > + * Return: A return value of 0 means that we ran out of work to do; ca=
lling
> > + *         again will do no work (there could be unreaped RPCs, but if=
 so,
> > + *         they cannot currently be reaped).  A value greater than zer=
o means
> > + *         there is still more reaping work to be done.
> > + */
> > +int homa_rpc_reap(struct homa_sock *hsk, bool reap_all)
> > +{
> > +     /* RPC Reaping Strategy:
> > +      *
> > +      * (Note: there are references to this comment elsewhere in the
> > +      * Homa code)
> > +      *
> > +      * Most of the cost of reaping comes from freeing sk_buffs; this =
can be
> > +      * quite expensive for RPCs with long messages.
> > +      *
> > +      * The natural time to reap is when homa_rpc_end is invoked to
> > +      * terminate an RPC, but this doesn't work for two reasons. First=
,
> > +      * there may be outstanding references to the RPC; it cannot be r=
eaped
> > +      * until all of those references have been released. Second, reap=
ing
> > +      * is potentially expensive and RPC termination could occur in
> > +      * homa_softirq when there are short messages waiting to be proce=
ssed.
> > +      * Taking time to reap a long RPC could result in significant del=
ays
> > +      * for subsequent short RPCs.
> > +      *
> > +      * Thus Homa doesn't reap immediately in homa_rpc_end. Instead, d=
ead
> > +      * RPCs are queued up and reaping occurs in this function, which =
is
> > +      * invoked later when it is less likely to impact latency. The
> > +      * challenge is to do this so that (a) we don't allow large numbe=
rs of
> > +      * dead RPCs to accumulate and (b) we minimize the impact of reap=
ing
> > +      * on latency.
> > +      *
> > +      * The primary place where homa_rpc_reap is invoked is when threa=
ds
> > +      * are waiting for incoming messages. The thread has nothing else=
 to
> > +      * do (it may even be polling for input), so reaping can be perfo=
rmed
> > +      * with no latency impact on the application.  However, if a mach=
ine
> > +      * is overloaded then it may never wait, so this mechanism isn't =
always
> > +      * sufficient.
> > +      *
> > +      * Homa now reaps in two other places, if reaping while waiting f=
or
> > +      * messages isn't adequate:
> > +      * 1. If too may dead skbs accumulate, then homa_timer will call
> > +      *    homa_rpc_reap.
> > +      * 2. If this timer thread cannot keep up with all the reaping to=
 be
> > +      *    done then as a last resort homa_dispatch_pkts will reap in =
small
> > +      *    increments (a few sk_buffs or RPCs) for every incoming batc=
h
> > +      *    of packets . This is undesirable because it will impact Hom=
a's
> > +      *    performance.
> > +      *
> > +      * During the introduction of homa_pools for managing input
> > +      * buffers, freeing of packets for incoming messages was moved to
> > +      * homa_copy_to_user under the assumption that this code wouldn't=
 be
> > +      * on the critical path. However, there is evidence that with
> > +      * fast networks (e.g. 100 Gbps) copying to user space is the
> > +      * bottleneck for incoming messages, and packet freeing takes abo=
ut
> > +      * 20-25% of the total time in homa_copy_to_user. So, it may even=
tually
> > +      * be desirable to remove packet freeing out of homa_copy_to_user=
.
>
> See skb_attempt_defer_free()

I wasn't previously aware of this. It looks useful, but unfortunately
its symbol isn't currently EXPORTed so Homa can't use it. I submitted
a patch to export that symbol, but that patch was rejected because the
patch didn't also include a use of the symbol.

I'm going to wait until this series is accepted, then submit a smaller
patch that adds the EXPORT and uses it in Homa (or maybe I'll wait
until I upstream Homa's GRO support, as Eric suggested).

> > +      */
> > +#define BATCH_MAX 20
> > +     struct homa_rpc *rpcs[BATCH_MAX];
> > +     struct sk_buff *skbs[BATCH_MAX];
>
> A lot of bytes on the stack, and a quite large batch. You should probaly
> decrease it.

I have reduced the batch size to 10. Note also that this is a
"near-leaf" function, so it should be safe for it to have a larger
footprint than Homa functions that invoke the IP/driver stack, which
presumably takes a lot of stack space.

> Also it still feel suspect the need for just another tx free strategy on
> top of the several existing caches.

I wasn't able to identify an existing cache mechanism that could meet
Homa's needs (and given the association Homa introduces between skb's
and RPCs, which are Homa-specific, it seems unlikely that any existing
mechanism would work for Homa). But, if you have something in mind
that you think might work for Homa, let me know and I'll take a look.

> > +             homa_sock_wakeup_wmem(hsk);
>
> Here num_rpcs can be zero, and you can have spurius wake-ups

I agree that num_rpcs can be zero, but homa_sock_wakeup_wmem won't
actually perform a wakeup unless (a) there are tasks waiting and (b)
there is available memory. So I don't see how there can be a spurious
wakeup. Is there something I'm missing?

> > +static inline void homa_rpc_hold(struct homa_rpc *rpc)
> > +{
> > +     atomic_inc(&rpc->refs);
>
> `refs` should be a reference_t, since is uses as such.

Done.

-John-

