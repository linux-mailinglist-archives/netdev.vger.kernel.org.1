Return-Path: <netdev+bounces-220489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F024DB46594
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7ABA1786D5
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 21:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461272F1FF5;
	Fri,  5 Sep 2025 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Xaea9Ygw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942C2F28F0
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107985; cv=none; b=UTSzjcFYAZsy5PyuZDnwn35qF0o0RwLSYKGZzWDXAfQiuP1SgpK3JN4u9hVl88UVdoQltDgNalHIEShH2rsM2R7PqxN2I2m08GOCL7n36AxVb9GIP4gwJhxOBQ9uy3XjPKzUX0p6SWXijVJXap7OgBh0Y66IlWkMcDC3iHFNi8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107985; c=relaxed/simple;
	bh=0DA4pgXerKYiZ8T9P9268FLSCmngT97yHHzENfDQs10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbFRtmiBArH5jEN+y0w+ejD6gtN+9uyD7aoTxslTZsk6D4oj9oHA0byGqOTp6dMKuNtam3e0eeyM9K6Oqy4mUBJZ/knZC2JtXBn5tNKu540UBQuFkITfTE6DtCkYcaT5G3zf0zWbM7qHHjbkF612FDTu/dDa6NR970g9MsU3qrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Xaea9Ygw; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tjqTxFzcvjvlbMlPNZxUHe9ttP1UU9TUHZEAEx9gBPQ=; t=1757107983; x=1757971983; 
	b=Xaea9YgwioEp7LcNRxp6UEJA1YDdcrSmoHmocnML4MBqLQCUm/CHyYdhq4o31Nt8X0XCMo5vk19
	c0XytfiR2q/H8cBTxK39WZ8C4XOuh2RhUVJJCLJ+N/xfKhtM2NRep4izJ9LYciKM78fiKTKmPaI3X
	7eDKFaNwv7TeGM2yVIw/ut4+DQeztRbHFRE5EGv4TvUk9M0ufVGELm3O9KdXwqrD0Qu42wkpii2QU
	xqAoGTgrBbTP5yr4uVkiwma2nC6+bBO0Igxox57ZO8M1VYs5zUuWfOevdnH88U9rGnB7V33S30+3D
	MHNjt04shx1y9/5ejFOCMxVjrz+EXomuA9KQ==;
Received: from mail-oa1-f41.google.com ([209.85.160.41]:43316)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uue3D-0001dh-52
	for netdev@vger.kernel.org; Fri, 05 Sep 2025 14:32:56 -0700
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-31d8778ce02so1293523fac.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 14:32:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YzfkI8hNayEOtFDOFQ5g9XBrsWGPYFrtRIhDQht2rJEirVjaB2Y
	/O2MFSpGoP9XT1bAVcb4IMSjBa9+a7rKeTdjmH5xBZaLcUmAKPRVUemc7HajoYSh5Luf4DZsyQ8
	Nb41FCLsq2tTsV1Jx0n3GTK00UaifleA=
X-Google-Smtp-Source: AGHT+IH2czz2woW5ksDeqZfDL+YXM++WGeQgenz5ZW3uNFgUO891iE+pYA5+1yuC1WJaVbJEWK4kPsXb3dMaqhKafI0=
X-Received: by 2002:a05:6870:4586:b0:2ef:1c81:f2fd with SMTP id
 586e51a60fabf-31f3bc0183emr2710216fac.16.1757107974494; Fri, 05 Sep 2025
 14:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-13-ouster@cs.stanford.edu>
 <CANn89iJ26WjmTBrEKwMJbQCKWYFmz2h25T+kOgLASXPvsDR1BQ@mail.gmail.com>
In-Reply-To: <CANn89iJ26WjmTBrEKwMJbQCKWYFmz2h25T+kOgLASXPvsDR1BQ@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 5 Sep 2025 14:32:18 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzUFH8RcgGf6tz=BCh_VBQXTg4o7M3HSthdRjD7_eHKoQ@mail.gmail.com>
X-Gm-Features: Ac12FXyeN54F-KpuHqjhgyLn2omUfFt58n0N012i8GyGP53Gnp9z9NPPPQVkHes
Message-ID: <CAGXJAmzUFH8RcgGf6tz=BCh_VBQXTg4o7M3HSthdRjD7_eHKoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 12/15] net: homa: create homa_incoming.c
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: cb5916722246bf80bd9488153e8e2604

On Tue, Sep 2, 2025 at 12:19=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
> >
> > +/**
> > + * homa_message_in_init() - Constructor for homa_message_in.
> > + * @rpc:          RPC whose msgin structure should be initialized. The
> > + *                msgin struct is assumed to be zeroes.
> > + * @length:       Total number of bytes in message.
> > + * Return:        Zero for successful initialization, or a negative er=
rno
> > + *                if rpc->msgin could not be initialized.
> > + */
> > +int homa_message_in_init(struct homa_rpc *rpc, int length)
> > +       __must_hold(rpc->bucket->lock)
> > +{
> > +       int err;
> > +
> > +       if (length > HOMA_MAX_MESSAGE_LENGTH)
> > +               return -EINVAL;
> > +
> > +       rpc->msgin.length =3D length;
> > +       skb_queue_head_init(&rpc->msgin.packets);
>
> Do you need the lock, or can you use __skb_queue_head_init() here for cla=
rity ?

No need for the lock. I hadn't realized that I should then use a
different initializer. I have now switched to __skb_queue_head_init
(and added to the documentation for packets).

> > +               if (n =3D=3D 0) {
> > +                       atomic_andnot(RPC_PKTS_READY, &rpc->flags);
>
> All networking uses clear_bit() instead...

I have switched everywhere.

> > +               n =3D 0;
>
> > +               atomic_or(APP_NEEDS_LOCK, &rpc->flags);
> > +               homa_rpc_lock(rpc);
> > +               atomic_andnot(APP_NEEDS_LOCK, &rpc->flags);
>
> This construct would probably need a helper.

Done, here and elsewhere.

> > +
> > +done:
> > +       kfree_skb(skb);
>
>
> Please double check all your kfree_skb() vs consume_skb()
>
> perf record -a -e skb:kfree_skb  sleep 60
> vs
> perf record -a -e skb:consume_skb  sleep 60
>
> As a bonus, you can use kfree_skb_reason(skb, some_reason) for future
> bug hunting

I wasn't aware of the consume_skb/kfree_skb_reason pattern. I've
checked all uses of kfree_skb and converted to consume_skb where
appropriate. The code also uses kfree_skb_reason wherever there is an
appropriate reason code.

-John-

