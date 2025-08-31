Return-Path: <netdev+bounces-218583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F8EB3D5C6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 01:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A617A7A4B9D
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 23:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EB64207A;
	Sun, 31 Aug 2025 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="vY9FTTFa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A728F5
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756683026; cv=none; b=Z31AAOx3tUD9/u4bUMKanoBHK3+UQ2FWZpqnzzqVMC+OsqrDWn5GAnycPD2WDH5qQ7WIU112i1tacoq/EIr9QXQl4oC+HeqWZTIxIM+JlVve0i9yng2Egp8Yw6XKbz1MkxjoOW4UPYXdu/tE1YzguQ1WQKHHSFEPWTtqB/Nkekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756683026; c=relaxed/simple;
	bh=qewsVzKD2wxym8DMn5vjv/aIQGXGioHtk0OM6HQYnrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFVF2guMoZfZkADJRkyqJDlD1FNK48IbLnkKoxkmmg2q2L5uHjZGVwuv1o77e2s8IWz7Ot3Qbc+o7r+0AwRFsAhcGo9yM7he1c/YleZqRoHWTOvCPrtj4U1/93T9WElKulyalW9iV2ZOZVG6WIOIpwcB8mbgvns/pUG/fTVuy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=vY9FTTFa; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aPWISOlPVvPgcRh1wYUr+X2rIrZKdbjqxewIfVB6gX0=; t=1756683024; x=1757547024; 
	b=vY9FTTFaGJopIvC4Okd1tzNjxaBTjiMmJIVBiEjOQ4rJPdD8nG+adlsFff3MaZTM6aIoVyZtIEj
	GZkilaB59CHS7mJmumfQRwR6JwffBvmWZnq8VsD7CYROHfRzzZ0Mfb1w9Ajt35mt6VQWyYyevISEV
	vF2s8MZhxi4FQKBOncSRloIcsRwvKU0DNbO1ultaLkNrVKX1ps4zXD5Y1zaVQCg6BzQgS4FQzXexV
	10G1dA4ZMB/rOVe02Mc5vvP2pqt/LFtKT99wdipCZccDm5yRM2Nho9yreR0vp2iWJSb8dZSsfcGy4
	2aCP71JvblhbO2u4eHdbRjvPr+XfG9SJou2g==;
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42050)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1usrV2-00039x-I6
	for netdev@vger.kernel.org; Sun, 31 Aug 2025 16:30:17 -0700
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-437f7046a7fso847721b6e.0
        for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 16:30:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz6NcqJeqZl2kWXHp2lOdxllBt2lEtmUB4BvFj/oT23MmhUO6Hu
	EuFYCyPwrzlJZEnYlzNbA0+nAfcJBKwYAw9vECgSVaqrnnBwJWV8UAR2625ghNQ+rVuz3onGWUD
	4LUUQvWRen0OqlxnETxjMVb1P3HqqAKo=
X-Google-Smtp-Source: AGHT+IGX1X/HlxXltgt6ZD6beQ85lzBVVQAKa5/uyAam3jnssiIjWkwAsWryBgc4rwwqcoevolGWVGd/4kDlf6MzrxU=
X-Received: by 2002:a05:6808:178e:b0:437:e490:6a17 with SMTP id
 5614622812f47-437f610b64dmr2816225b6e.16.1756683015871; Sun, 31 Aug 2025
 16:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-7-ouster@cs.stanford.edu>
 <180be553-8297-4802-972f-d73f30da365a@redhat.com>
In-Reply-To: <180be553-8297-4802-972f-d73f30da365a@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Sun, 31 Aug 2025 16:29:40 -0700
X-Gmail-Original-Message-ID: <CAGXJAmyLPOaTJ9Dap-CZ9XT=K8LpnjCJCveNh4B_pvqHELeqjg@mail.gmail.com>
X-Gm-Features: Ac12FXwjioRq2txVnqlmVqV484qR_7uA_pn_foC0Uz3x9m9uToqeUYySlC7czjA
Message-ID: <CAGXJAmyLPOaTJ9Dap-CZ9XT=K8LpnjCJCveNh4B_pvqHELeqjg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 06/15] net: homa: create homa_sock.h and homa_sock.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 365f6f5e44d6f8db2699abaf9e884e33

On Tue, Aug 26, 2025 at 3:11=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:

> > +/**
> > + * homa_sock_init() - Constructor for homa_sock objects. This function
> > + * initializes only the parts of the socket that are owned by Homa.
> > + * @hsk:    Object to initialize. The Homa-specific parts must have be=
en
> > + *          initialized to zeroes by the caller.
> > + *
> > + * Return: 0 for success, otherwise a negative errno.
> > + */
> > +int homa_sock_init(struct homa_sock *hsk)
> > +{
> > +    ...
> > +     /* Pick a default port. Must keep the socktab locked from now
> > +      * until the new socket is added to the socktab, to ensure that
> > +      * no other socket chooses the same port.
> > +      */
> > +     spin_lock_bh(&socktab->write_lock);
> > +     starting_port =3D hnet->prev_default_port;
> > +     while (1) {
> > +             hnet->prev_default_port++;
> > +             if (hnet->prev_default_port < HOMA_MIN_DEFAULT_PORT)
> > +                     hnet->prev_default_port =3D HOMA_MIN_DEFAULT_PORT=
;
> > +             other =3D homa_sock_find(hnet, hnet->prev_default_port);
> > +             if (!other)
> > +                     break;
> > +             sock_put(&other->sock);
> > +             if (hnet->prev_default_port =3D=3D starting_port) {
> > +                     spin_unlock_bh(&socktab->write_lock);
> > +                     hsk->shutdown =3D true;
> > +                     hsk->homa =3D NULL;
> > +                     result =3D -EADDRNOTAVAIL;
> > +                     goto error;
> > +             }
>
> You likely need to add a cond_resched here (releasing and re-acquiring
> the lock as needed)

Done.

> Do all the above initialization steps need to be done under the socktab
> lock?

No; I have now reorganized to minimize the amount of time the socktab
lock is held. Socket creation is a pretty rare event in Homa
(typically once per process) so this optimization probably doesn't
matter much...

> > +int homa_sock_bind(struct homa_net *hnet, struct homa_sock *hsk,
> > +                u16 port)
> > +{
> > +     ...
> > +     owner =3D homa_sock_find(hnet, port);
> > +     if (owner) {
> > +             sock_put(&owner->sock);
>
> homa_sock_find() is used is multiple places to check for port usage. I
> think it would be useful to add a variant of such helper not
> incremention the socket refcount.

It's only used this way in 2 places, both in this file. The
alternatives (either add another parameter to homa_sock_find or create
a separate method homa_port_in_use) both seem like they would add more
complexity than the current approach. My preference is to leave it as
is. If you feel strongly about this, let me know which option you
prefer and I'll implement it (note also that adding another parameter
to homa_sock_find would be awkward because it could result in a socket
being returned without its reference count incremented, meaning that
it isn't really safe for the caller to use it; I worry that this will
lead people to write buggy code).

> > +/**
> > + * homa_sock_wait_wmem() - Block the thread until @hsk's usage of tx
> > + * packet memory drops below the socket's limit.
> > + * @hsk:          Socket of interest.
> > + * @nonblocking:  If there's not enough memory, return -EWOLDBLOCK ins=
tead
> > + *                of blocking.
> > + * Return: 0 for success, otherwise a negative errno.
> > + */
> > +int homa_sock_wait_wmem(struct homa_sock *hsk, int nonblocking)
> > +{
> > +     long timeo =3D hsk->sock.sk_sndtimeo;
> > +     int result;
> > +
> > +     if (nonblocking)
> > +             timeo =3D 0;
> > +     set_bit(SOCK_NOSPACE, &hsk->sock.sk_socket->flags);
> > +     result =3D wait_event_interruptible_timeout(*sk_sleep(&hsk->sock)=
,
> > +                             homa_sock_wmem_avl(hsk) || hsk->shutdown,
> > +                             timeo);
> > +     if (signal_pending(current))
> > +             return -EINTR;
> > +     if (result =3D=3D 0)
> > +             return -EWOULDBLOCK;
> > +     return 0;
> > +}
>
> Perhaps you could use sock_wait_for_wmem() ?

sock_wait_for_wmem is not accessible to modules (it's declared "static").

> > diff --git a/net/homa/homa_sock.h b/net/homa/homa_sock.h
>
> > +/**
> > + * struct homa_sock - Information about an open socket.
> > + */
> > +struct homa_sock {
> > +     ...
> > +
> > +     /**
> > +      * @homa: Overall state about the Homa implementation. NULL
> > +      * means this socket was never initialized or has been deleted.
> > +      */
> > +     struct homa *homa;
> > +
> > +     /**
> > +      * @hnet: Overall state specific to the network namespace for
> > +      * this socket.
> > +      */
> > +     struct homa_net *hnet;
>
> Both the above should likely be removed

What is the motivation for removing them? The homa field can be
accessed through hnet, so I suppose it could be removed, but that will
result in extra instructions (both time and icache space) every time
it is accessed (and there are a bunch of accesses). hnet is more
expensive to remove: it can be accessed through the socket, but the
code path is longer, which, again, wastes time and icache space.

> > +     /**
> > +      * @client_rpc_buckets: Hash table for fast lookup of client RPCs=
.
> > +      * Modifications are synchronized with bucket locks, not
> > +      * the socket lock.
> > +      */
> > +     struct homa_rpc_bucket client_rpc_buckets[HOMA_CLIENT_RPC_BUCKETS=
];
> > +
> > +     /**
> > +      * @server_rpc_buckets: Hash table for fast lookup of server RPCs=
.
> > +      * Modifications are synchronized with bucket locks, not
> > +      * the socket lock.
> > +      */
> > +     struct homa_rpc_bucket server_rpc_buckets[HOMA_SERVER_RPC_BUCKETS=
];
>
> The above 2 array are quite large, and should be probably allocated
> separately.

What's the benefit of doing multiple allocations? The individual
arrays will still be 16KB, which isn't exactly small. Is there general
advice on how to decide whether large objects should be split up into
smaller ones?

> > +/**
> > + * homa_sock_wakeup_wmem() - Invoked when tx packet memory has been fr=
eed;
> > + * if memory usage is below the limit and there are tasks waiting for =
memory,
> > + * wake them up.
> > + * @hsk:   Socket of interest.
> > + */
> > +static inline void homa_sock_wakeup_wmem(struct homa_sock *hsk)
> > +{
> > +     if (test_bit(SOCK_NOSPACE, &hsk->sock.sk_socket->flags) &&
> > +         homa_sock_wmem_avl(hsk)) {
> > +             clear_bit(SOCK_NOSPACE, &hsk->sock.sk_socket->flags);
> > +             wake_up_interruptible_poll(sk_sleep(&hsk->sock), EPOLLOUT=
);
>
> Can hsk be orphaned at this point? I think so.

I don't think so. This function is invoked only from homa_rpc_reap,
and I don't believe homa_rpc_reap can be invoked once a socket is
orphaned (that would be problematic on its own). Also, as part of
socket shutdown all RPCs are deleted and homa_rpc_reap is invoked to
free their resources, so it will wake up anyone waiting for wmem. By
the time socket cleanup has completed (a) there are no RPCs, and (b)
there should be no-one waiting for wmem.

Do you have a particular pathway in mind by which
homa_sock_wakeup_wmem could be invoked after a socket has been
orphaned?

-John-

