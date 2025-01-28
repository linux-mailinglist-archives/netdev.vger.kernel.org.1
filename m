Return-Path: <netdev+bounces-161242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88155A202A7
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 01:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C672B3A7144
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ACB175AB;
	Tue, 28 Jan 2025 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="lHN3ZxZU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067081B7F4
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024891; cv=none; b=kxO6C1j6W+STvfyaCAMtX7pqj9+nCHqu+Ro8OlVnNjwZfyYO1gw7QwRHR4YGafVY4TVs4XOuFZTmMsW6wkMYcmbkq4gYLQO9P2lxiHlhXmtxfRJF2aLADGWMKOIsLWDhd3zlvyKt7wVeN0GkGce6zsl6ipWD5OV1O/uvPcynpvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024891; c=relaxed/simple;
	bh=LEnVxpH/2fY9vJxYhzd/a+GoP5mBWuN8v8dtEI8pGZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhVJUQeIRlpYQdQDhwRKkSwXBiKBJPCZ/l0QnV7z3SycSRRGK0nCHmmyQjfy42JflwLxr9NL6YYYY6YcyIsgH1knEfwYrQcK3w711DpVB/1s5u5fumSOyyNpsjOw0MkDKVQgd5aOClmOX1ugMK+7aKlag1ENMuKCiusdPFIqlmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=lHN3ZxZU; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6tmmy19F6AzfhKR6EPxKADccWBPRLVBt/1EXh81BxxY=; t=1738024890; x=1738888890; 
	b=lHN3ZxZUR9CLGWc9PhPAr/qHuHo72OHsjcDJ2qg6jQj41Kk/K0rogTJ7N/lvvrcsbhUYpHDTE+E
	xmcCuQQcWU/uWn9sSysYN5Uc374ZmmMy4Uscys/I+sFFF4Oq86x/kI0JWUJtIbiAbEp/AUJUNAHdN
	115ZBye0nJL8JqZTNHbSB1qP4WOhrEGc2s6j+fuFLu1IafoeNceRsxricoxZHSbv11N8uAJTcqgJj
	ONIMRy9qaS59tPlR4iIGnqwFCVIUH+ORW5K6FqxHyiG74bsclCVWvvyW4Cb6wHf8L1zffcSobZ7U6
	I9pkdBczgN+fASp7jn91tgsva049kA6u2+bQ==;
Received: from mail-oi1-f169.google.com ([209.85.167.169]:54493)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tcZfQ-0005wg-BK
	for netdev@vger.kernel.org; Mon, 27 Jan 2025 16:41:29 -0800
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ebbe804913so1310147b6e.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 16:41:24 -0800 (PST)
X-Gm-Message-State: AOJu0YwolHfzH+zpyj6arfYge03QO4YOezNTU3G+4rOD65yEdz3k2fGb
	zVYQKBlWkgFonZ3V4B+8HsYXj1QMzf4i9KAr8oU+NgFUUE0ubxl7H7vaE7bnGMFqVVNCxlcN4IG
	1O/pr3OZKHF6ZPl+mhudhET+qn00=
X-Google-Smtp-Source: AGHT+IHD+1A6+NZM5u6RKkmlZSq2dXRy5ngg5sFgSTgLjS0fqOznTbEugwAogKRSaVMuixKSQEwKaHQ3ERy+aMcu5Ks=
X-Received: by 2002:a05:6871:418e:b0:29e:61cd:d3b2 with SMTP id
 586e51a60fabf-2b1c0c884c1mr24168926fac.38.1738024883701; Mon, 27 Jan 2025
 16:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-8-ouster@cs.stanford.edu>
 <028f492f-41db-4c70-9527-cf0db03da4df@redhat.com>
In-Reply-To: <028f492f-41db-4c70-9527-cf0db03da4df@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 27 Jan 2025 16:40:47 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxqoPw8iTH0Bt4z5V2feM8rekDDOJapek4eyMuLJhUAtA@mail.gmail.com>
X-Gm-Features: AWEUYZkNCi_8KkvFj8SugK58hR4ofuGeEMc5Vuy_cuOEl1xusuJaLCKLgNb82bM
Message-ID: <CAGXJAmxqoPw8iTH0Bt4z5V2feM8rekDDOJapek4eyMuLJhUAtA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/12] net: homa: create homa_sock.h and homa_sock.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 67ee7b1d5b70e1524ccfaed85eb513af

On Thu, Jan 23, 2025 at 11:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> > +struct homa_sock *homa_socktab_next(struct homa_socktab_scan *scan)
> > +{
> > +     struct homa_socktab_links *links;
> > +     struct homa_sock *hsk;
> > +
> > +     while (1) {
> > +             while (!scan->next) {
> > +                     struct hlist_head *bucket;
> > +
> > +                     scan->current_bucket++;
> > +                     if (scan->current_bucket >=3D HOMA_SOCKTAB_BUCKET=
S)
> > +                             return NULL;
> > +                     bucket =3D &scan->socktab->buckets[scan->current_=
bucket];
> > +                     scan->next =3D (struct homa_socktab_links *)
> > +                                   rcu_dereference(hlist_first_rcu(buc=
ket));
>
> The only caller for this function so far is not under RCU lock: you
> should see a splat here if you build and run this code with:
>
> CONFIG_LOCKDEP=3Dy
>
> (which in turn is highly encouraged)

Strange... I have had CONFIG_LOCKDEP enabled for a while now, but for
some reason I didn't see a flag for that. In any case, all of the
callers to homa_socktab_next now hold the RCU lock (I fixed this
during my scan of RCU usage in response to one of your earlier
messages for this patch series).

> > +             }
> > +             links =3D scan->next;
> > +             hsk =3D links->sock;
> > +             scan->next =3D (struct homa_socktab_links *)
> > +                             rcu_dereference(hlist_next_rcu(&links->ha=
sh_links));
>
> homa_socktab_links is embedded into the home sock; if the RCU protection
> is released and re-acquired after a homa_socktab_next() call, there is
> no guarantee links/hsk are still around and the above statement could
> cause UaF.

There is code in homa_sock_unlink to deal with this: it makes a pass
over all of the active scans, and if the "next" field in any
homa_socktab_scan refers to the socket being deleted, it updates the
"next" field to refer to the next socket after the one being deleted.
Thus the "next" fields are always valid, even in the face of socket
deletion.

> This homa_socktab things looks quite complex. A simpler implementation
> could use a simple RCU list _and_ acquire a reference to the hsk before
> releasing the RCU lock.

I agree that this is complicated. But I can't see a simpler solution.
The problem is that we need to iterate through all of the sockets and
release the RCU lock at some points during the iteration. The problem
isn't preserving the current hsk; it's preserving the validity of the
pointer to the next one also. I don't fully understand what you're
proposing above; if you can make it a bit more precise I'll see if it
solves all the problems I'm aware of and does it in a simpler way.

> > +int homa_sock_init(struct homa_sock *hsk, struct homa *homa)
> > +{
> > +     struct homa_socktab *socktab =3D homa->port_map;
> > +     int starting_port;
> > +     int result =3D 0;
> > +     int i;
> > +
> > +     spin_lock_bh(&socktab->write_lock);
>
> A single contended lock for the whole homa sock table? Why don't you use
> per bucket locks?

Creating a socket is a very rare operation: it happens roughly once in
the lifetime of each application. Thus per bucket locks aren't
necessary. Homa is very different from TCP in this regard.

> [...]
> > +struct homa_rpc_bucket {
> > +     /**
> > +      * @lock: serves as a lock both for this bucket (e.g., when
> > +      * adding and removing RPCs) and also for all of the RPCs in
> > +      * the bucket. Must be held whenever manipulating an RPC in
> > +      * this bucket. This dual purpose permits clean and safe
> > +      * deletion and garbage collection of RPCs.
> > +      */
> > +     spinlock_t lock;
> > +
> > +     /** @rpcs: list of RPCs that hash to this bucket. */
> > +     struct hlist_head rpcs;
> > +
> > +     /**
> > +      * @id: identifier for this bucket, used in error messages etc.
> > +      * It's the index of the bucket within its hash table bucket
> > +      * array, with an additional offset to separate server and
> > +      * client RPCs.
> > +      */
> > +     int id;
>
> On 64 bit arches this struct will have 2 4-bytes holes. If you reorder
> the field:
>         spinlock_t lock;
>         int id;
>         struct hlist_head rpcs;
>
> the struct size will decrease by 8 bytes.

Done. I wasn't aware that spinlock_t is so tiny.

> > +struct homa_sock {
> > +     /* Info for other network layers. Note: IPv6 info (struct ipv6_pi=
nfo
> > +      * comes at the very end of the struct, *after* Homa's data, if t=
his
> > +      * socket uses IPv6).
> > +      */
> > +     union {
> > +             /** @sock: generic socket data; must be the first field. =
*/
> > +             struct sock sock;
> > +
> > +             /**
> > +              * @inet: generic Internet socket data; must also be the
> > +              first field (contains sock as its first member).
> > +              */
> > +             struct inet_sock inet;
> > +     };
>
> Why adding this union? Just
>         struct inet_sock inet;
> would do.

It's not technically necessary, but it allows code to refer to the
struct sock as hsk->sock rather than hsk->inet.sk (saves me having to
visit struct inet to remember the field name for the struct sock). Not
a big deal, I'll admit...

-John-

