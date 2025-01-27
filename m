Return-Path: <netdev+bounces-161054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA71A1D0A5
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 06:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A09B3A5D9E
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 05:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497B72AE72;
	Mon, 27 Jan 2025 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="DxkZX3sm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49225A63B
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 05:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737955396; cv=none; b=aw/2rq0wDjigEtk7KCFjyVk8ZRy75rdRwQ9ZX55Z+c6cT2sbAisHqwYib+Ewxj9MPuHHF6xz9qp4zDpiH1vaqNeVnsWavMxzxC1ojRhshpoHjh4RH71G5y4zqmTXbC0uGJIrnaC1Yrr1Db8d9hM2QfyaPEW3lJ8wrChfGAeZ0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737955396; c=relaxed/simple;
	bh=AmDxp7qiOuA5tEC5Sg51Iq5XEkpLb+0DkemIG/5qP9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isXrPU7YPmIHuMED2IerAfb6aKiH0Mr0WtD6D2bYaKbIPLaUBa1jWwC7HOCenPlBrx0SdDrma3rPolYqUk6oZoHzWrYmWJAPkJoYYmgbVmt6jV9MrxVxb8DZRR/bDHLCchix5UH6PXejY1BXKPFhmlzCVn/wtlJTrZO8KEuV9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=DxkZX3sm; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sPlMq7LTx4qAjXHcZIzNhNTMkQ9GYBYFVtbQKm0eXIU=; t=1737955394; x=1738819394; 
	b=DxkZX3smf5nABX67WqvhZ81OKUd5KJY+LPMlANrJhrefL33bA/nSTK9snxWKLhD/iX9exKuGWaB
	x+BY0MgzL6c5VLjKAn0hEf4f43duof+U6CYrZakaqmjzomWlxv1wTQvz4FCHVHAgQPOqUwWsr/Ek3
	E0efGNYbvljBmkiZJFQ3rGbqBl+NBjqHchGbb38XQpXota/C91oTYWL787xbpzTvMGAC8hAaFa72C
	5cMRGXDI9llI4fFqcYrmPwxIuCtWQYCOK/qU81Oy9zRDrEaPUjZWI3G9ONXHVxwAaxZWkCLclxTxQ
	/KX1dieDBvCenii2dEfSU3Qd95uFafjxOWdA==;
Received: from mail-oo1-f42.google.com ([209.85.161.42]:49272)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tcHab-0003Li-2N
	for netdev@vger.kernel.org; Sun, 26 Jan 2025 21:23:13 -0800
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f2dee7d218so1792278eaf.2
        for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 21:23:13 -0800 (PST)
X-Gm-Message-State: AOJu0YxWRMTO+yv07SeC7aYqe2+DoteBRqQ1/KMTy/VxKCygTevHDhqH
	OexE37+u9Tf2i7WeDqWdlFwP5fjovNm7KnmCiCY7u78KwBlEmipb2xxOZ/90KCVxOvH8EFnv/69
	SfiWLpHikL0pYtnhABKrm8qKKSqw=
X-Google-Smtp-Source: AGHT+IF9e++3skpoyUuvs0xxs+IYc2+l05NWu88tvLhgi8Gw7foFCkLOAQOpQFOtbERs1q98lsnjArBAlrFqN+Lu3Io=
X-Received: by 2002:a05:6870:6ecc:b0:297:24ad:402f with SMTP id
 586e51a60fabf-2b1c0a731aamr20756608fac.12.1737955392470; Sun, 26 Jan 2025
 21:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-6-ouster@cs.stanford.edu>
 <1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com>
In-Reply-To: <1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Sun, 26 Jan 2025 21:22:38 -0800
X-Gmail-Original-Message-ID: <CAGXJAmwyp6tSO4KT_NSHKHSnUn-GSzSN=ucfjnBuXbg8uiw2pg@mail.gmail.com>
X-Gm-Features: AWEUYZlnpDLdiJ8qy8aC-341k1Ntu7ZrspQ5pbMxWlwLrF4APAD5deKZIxZgnQ4
Message-ID: <CAGXJAmwyp6tSO4KT_NSHKHSnUn-GSzSN=ucfjnBuXbg8uiw2pg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and homa_rpc.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: bd27203d7a2d5412f70ab6183b407a6c

On Thu, Jan 23, 2025 at 6:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
> ...
> How many RPCs should concurrently exist in a real server? with 1024
> buckets there could be a lot of them on each/some list and linear search
> could be very expansive. And this happens with BH disabled.

Server RPCs tend to be short-lived, so my best guess is that the
number of concurrent server RPCs will be relatively small (maybe a few
hundred?). But this is just a guess: I won't know for sure until I can
measure Homa in production use. If the number of concurrent RPCs turns
out to be huge then we'll have to find a different solution.

> > +
> > +     /* Initialize fields that don't require the socket lock. */
> > +     srpc =3D kmalloc(sizeof(*srpc), GFP_ATOMIC);
>
> You could do the allocation outside the bucket lock, too and avoid the
> ATOMIC flag.

In many cases this function will return an existing RPC so there won't
be any need to allocate; I wouldn't want to pay the allocation
overhead in that case. I could conceivably check the offset in the
packet and pre-allocate if the offset is zero (in this case it's
highly unlikely that there will be an existing RPC). But this is
starting to feel complicated so I'm not sure it's worth doing (and
there are many other places where GFP_ATOMIC is unavoidable, so fixing
just one place may not make much difference). homa_rpc objects are
about 500 bytes, so not super huge. I'm inclined to leave this as is
and consider a more complex approach only if problems arise in
practice.

> > + * homa_rpc_free() - Destructor for homa_rpc; will arrange for all res=
ources
> > + * associated with the RPC to be released (eventually).
> > + * @rpc:  Structure to clean up, or NULL. Must be locked. Its socket m=
ust
> > + *        not be locked.
> > + */
> > +void homa_rpc_free(struct homa_rpc *rpc)
> > +     __acquires(&rpc->hsk->lock)
> > +     __releases(&rpc->hsk->lock)
>
> The function name is IMHO misleading. I expect homa_rpc_free() to
> actually free the memory allocated for the rpc argument, including the
> rpc struct itself.

That's a fair point. I have bitten the bullet and renamed it to homa_rpc_en=
d.

> > +                     if (rpc->msgin.length >=3D 0) {
> > +                             while (1) {
> > +                                     struct sk_buff *skb;
> > +
> > +                                     skb =3D skb_dequeue(&rpc->msgin.p=
ackets);
> > +                                     if (!skb)
> > +                                             break;
> > +                                     kfree_skb(skb);
>
> You can use:
>                                         rx_free+=3D skb_queue_len(&rpc->m=
sgin.packets);
>                                         skb_queue_purge(&rpc->msgin.packe=
ts);

Done.

> > +/**
> > + * homa_find_client_rpc() - Locate client-side information about the R=
PC that
> > + * a packet belongs to, if there is any. Thread-safe without socket lo=
ck.
> > + * @hsk:      Socket via which packet was received.
> > + * @id:       Unique identifier for the RPC.
> > + *
> > + * Return:    A pointer to the homa_rpc for this id, or NULL if none.
> > + *            The RPC will be locked; the caller must eventually unloc=
k it
> > + *            by invoking homa_rpc_unlock.
>
> Why are using this lock schema? It looks like it adds quite a bit of
> complexity. The usual way of handling this kind of hash lookup is do the
> lookup locklessly, under RCU, and eventually add a refcnt to the
> looked-up entity - homa_rpc - to ensure it will not change under the
> hood after the lookup.

I considered using RCU for this, but the time period for RCU
reclamation is too long (10's - 100's of ms, if I recall correctly).
Homa needs to handle a very high rate of RPCs, so this would result in
too much accumulated memory (in particular, skbs don't get reclaimed
until the RPC is reclaimed).

The caller must have a lock on the homa_rpc anyway, so RCU wouldn't
save the overhead of acquiring a lock. The reason for putting the lock
in the hash table instead of the homa_rpc is that this makes RPC
creation/deletion atomic with respect to lookups. The lock was
initially in the homa_rpc, but that led to complex races with hash
table insertion/deletion. This is explained in sync.txt, but of course
you don't have that (yet).

This approach is unusual, but it has worked out really well. Before
implementing this approach I had what seemed like a never-ending
stream of synchronization problems over the socket hash tables; each
"fix" introduced new problems. Once I implemented this, all the
problems went away and the code has been very stable ever since
(several years now).

> > + */
> > +struct homa_rpc *homa_find_client_rpc(struct homa_sock *hsk, __u64 id)
> > +     __acquires(&crpc->bucket->lock)
> > +{
> > +     struct homa_rpc_bucket *bucket =3D homa_client_rpc_bucket(hsk, id=
);
> > +     struct homa_rpc *crpc;
> > +
> > +     homa_bucket_lock(bucket, id, __func__);
> > +     hlist_for_each_entry_rcu(crpc, &bucket->rpcs, hash_links) {
>
> Why are you using the RCU variant? I don't see RCU access for rpcs.

I have no idea why that uses RCU (maybe leftover from a long-ago
version that did actually use RCU?). I'll take it out. After seeing
this, I decided to review all of the RCU usage in Homa and I have
found and fixed several other problems and/or unnecessary uses of RCU.

-John-

