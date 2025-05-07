Return-Path: <netdev+bounces-188767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC9AAE918
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B491BC8E03
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925328E578;
	Wed,  7 May 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="oSoaoRWy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1E28691
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642685; cv=none; b=XK8OyZJrXV56pMXoZ8kQLtaHOVxGtUKpG0f0CLIfmkC/lmJHZWtGrmClfYbk7EG2qTxTmgAXQtyKwR1gqZjgbDLncntKPbpkT/Xwk7nbqx0Ix22jkx/CMHQGI74xhBMxirO+FqKWfTTO8kR+hQxQ+DLi1M6WgsAQciUVZiNnmKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642685; c=relaxed/simple;
	bh=6t1d1Gzwy7iebpUaQ8Cpl4BBIcHaoGb/T0+NlYjyWvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rr9sPWtT552aOz3FlyZLhBNcHhT+BGmARgm2ZI2isdbSsYQTFaxWN8WvPZqBzic+wKnKtq2iPCxT9MxjDXAlKOzbFVa9vmE/ruj+BHMolT2qJ3lEqHTckbOaq8D99EGKmQmB7D9wFWboUrLl0eesDQV3DtFSlrBvPmT/1b9v0PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=oSoaoRWy; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tN53HCIIJhzXajQH5/ElqQ0nN2CthWDUKLODPrGYVQg=; t=1746642683; x=1747506683; 
	b=oSoaoRWypqfhv4K2s8XGMQpGIVf/eRNJS/9O0jHlJXGLC3XBrSt3Ms7FjioFGXsK44BVEYzdzOM
	1NE7Pfo7uliKJ4a/qXNIuMU1InUQdF9k++l27FWMsE2T6lW8QysxZFM4plmaATkMzS/jAXYRsOIv/
	mkIKVNHG8jI320t7M69O/8azhrbqradLo6yaBEfjzs2JtgzVP/K/BpA8dYApV9dGX5aJ+1ZRI6k1A
	dXsHP9aqfsVxzJzByDfm7icmW7ZAEW9wiZIuldBDaly8Zj7ve/cOr7ToH7Ys+Ea7orVylkO3sy7rN
	nmW8lzmpZl2VXD51T5ANZDl+7c4WmJ9KjGSg==;
Received: from mail-oi1-f173.google.com ([209.85.167.173]:57633)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uCjY4-0003C5-Ci
	for netdev@vger.kernel.org; Wed, 07 May 2025 11:31:17 -0700
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-401e77e5443so133310b6e.3
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 11:31:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YwsShh2+i/4QQ8EyE5VNnZgnfCun+pVepF7m0T1l34JHXvTLT2s
	HyjJY2BDdnGfRqAaSzvx1ybgbK9qvwTxqt9yFapleKqiA/62qeBJ7PH/xzd2fSiXRf0bIJY4M1+
	eJ41w1222MO69qXru0V6IyrDwH9Y=
X-Google-Smtp-Source: AGHT+IHDTUDGiLLlTrPeE6lTiEct90KCuO0Fgqjh5g+iz8x0qYzwJGEGAsIWt77eQ4Ip+lm5fuh8I2b+oHzKVCbojK0=
X-Received: by 2002:a05:6808:2f12:b0:401:e611:67c7 with SMTP id
 5614622812f47-40377fc39a7mr235154b6e.27.1746642675768; Wed, 07 May 2025
 11:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-7-ouster@cs.stanford.edu> <bd93f644-1d95-4b32-b4ef-9ee65256dcf4@redhat.com>
In-Reply-To: <bd93f644-1d95-4b32-b4ef-9ee65256dcf4@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 7 May 2025 11:30:40 -0700
X-Gmail-Original-Message-ID: <CAGXJAmxwZ7Vc1UFfNDxNKvhizL8ks0gw8GosiJkc66V+XUUWHw@mail.gmail.com>
X-Gm-Features: ATxdqUGBUX-PKo66OBtfOtkesYDHEYO5g9Fj6MpRs3jEI3zbiBRuWQZf4vBlFOw
Message-ID: <CAGXJAmxwZ7Vc1UFfNDxNKvhizL8ks0gw8GosiJkc66V+XUUWHw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 06/15] net: homa: create homa_sock.h and homa_sock.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: c60b979a28a2d81a4a414d3103ab9a8d

On Mon, May 5, 2025 at 9:46=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 5/3/25 1:37 AM, John Ousterhout wrote:

> > +     /* Initialize Homa-specific fields. */
> > +     spin_lock_bh(&socktab->write_lock);
> > +     atomic_set(&hsk->protect_count, 0);
> > +     spin_lock_init(&hsk->lock);
> > +     atomic_set(&hsk->protect_count, 0);
>
> Duplicate 'atomic_set(&hsk->protect_count, 0);' statement above

Oops; fixed now.

> > +     hsk->port =3D homa->prev_default_port;
> > +     hsk->inet.inet_num =3D hsk->port;
> > +     hsk->inet.inet_sport =3D htons(hsk->port);
>
> The above code looks like a bind() operation, but it's unclear why it's
> peformend at init time.

All Homa sockets are automatically assigned a port at creation time,
so there's no need for them to call bind in the common case where they
are being used for the client side only. Bind only needs to be called
if the application wants to use a well-known port number.

> > +     for (i =3D 0; i < HOMA_CLIENT_RPC_BUCKETS; i++) {
> > +             struct homa_rpc_bucket *bucket =3D &hsk->client_rpc_bucke=
ts[i];
> > +
> > +             spin_lock_init(&bucket->lock);
> > +             bucket->id =3D i;
> > +             INIT_HLIST_HEAD(&bucket->rpcs);
> > +     }
> > +     for (i =3D 0; i < HOMA_SERVER_RPC_BUCKETS; i++) {
> > +             struct homa_rpc_bucket *bucket =3D &hsk->server_rpc_bucke=
ts[i];
> > +
> > +             spin_lock_init(&bucket->lock);
> > +             bucket->id =3D i + 1000000;
> > +             INIT_HLIST_HEAD(&bucket->rpcs);
> > +     }
>
> I'm under the impression that using rhashtable for both the client and
> the server rpcs will deliver both more efficient memory usage and better
> performances.

I wasn't aware of rhashtable; I'll take a look.

> > +
> > +     tx_memory =3D refcount_read(&hsk->sock.sk_wmem_alloc);
> > +     if (tx_memory !=3D 1) {
> > +             pr_err("%s found sk_wmem_alloc %llu bytes, port %d\n",
> > +                     __func__, tx_memory, hsk->port);
> > +     }
>
> Just:
>         WARN_ON_ONCE(refcount_read(&sk->sk_wmem_alloc) !=3D 1);

Done (but this is a bit unsatisfying because it generates less useful
information in the log).

> > +/**
> > + * homa_sock_destroy() - Destructor for homa_sock objects. This functi=
on
> > + * only cleans up the parts of the object that are owned by Homa.
> > + * @hsk:       Socket to destroy.
> > + */
> > +void homa_sock_destroy(struct homa_sock *hsk)
> > +{
> > +     homa_sock_shutdown(hsk);
> > +     sock_set_flag(&hsk->inet.sk, SOCK_RCU_FREE);
>
> Why the flag is set only now and not at creation time?

No reason that I can think of; I've now moved it to creation time.
After asking ChatGPT about this flag, I'm no longer certain that Homa
needs it. Can you help me understand the conditions that would make
the flag necessary/unnecessary?

> [...]
> > +/**
> > + * struct homa_socktab - A hash table that maps from port numbers (eit=
her
> > + * client or server) to homa_sock objects.
> > + *
> > + * This table is managed exclusively by homa_socktab.c, using RCU to
> > + * minimize synchronization during lookups.
> > + */
> > +struct homa_socktab {
> > +     /**
> > +      * @write_lock: Controls all modifications to this object; not ne=
eded
> > +      * for socket lookups (RCU is used instead). Also used to
> > +      * synchronize port allocation.
> > +      */
> > +     spinlock_t write_lock;
> > +
> > +     /**
> > +      * @buckets: Heads of chains for hash table buckets. Chains
> > +      * consist of homa_sock objects.
> > +      */
> > +     struct hlist_head buckets[HOMA_SOCKTAB_BUCKETS];
> > +};
>
> This is probably a bit too large to be unconditionally allocated for
> each netns. You are probably better off with a global hash table, with
> the lookup key including the netns itself.

OK, will do.

> [...]
> > +/**
> > + * homa_sock_lock() - Acquire the lock for a socket.
> > + * @hsk:     Socket to lock.
> > + */
> > +static inline void homa_sock_lock(struct homa_sock *hsk)
> > +     __acquires(&hsk->lock)
> > +{
> > +     spin_lock_bh(&hsk->lock);
>
> I was wondering how the hsk socket lock could be nested under a
> spinlock... The above can't work, unless you prevent any core and
> inet-related operations on hsk sockets. That in turn means duplicate
> entirely a lot of code or preventing a lot of basic stuff from working
> on homa sockets.
>
> Home sockets are still inet ones. It's expected that SOL_SOCKET and
> SOL_IP[V6] socket options work on them (or at least could be implemented)=
.
>
> I think this point is very critical.

Can you provide an example of a specific situation that you think will
be problematic? My belief (hope?) is that Homa does not use any socket
operations that require the official socket lock. Homa implements
socket options using its own spinlock.

> Somewhat related: the patch order makes IMHO the review complex, because
> I often need to look to the following patches to get needed context.

Unfortunately I don't know how to fix this problem. I'm a bit
skeptical that it is even possible to understand this much code in a
purely linear fashion. If you have suggestions for how I can organize
the patches to make them easier to review, I'd be happy to hear them.
At the same time, it's been a struggle for me to extract these patches
cleanly from the full Homa source and evolve them while allowing
concurrent development of the full source; this has led to some of the
awkward chunks of code you have noticed.

-John-

