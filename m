Return-Path: <netdev+bounces-127408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F169697542F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86AD28364C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BB519F482;
	Wed, 11 Sep 2024 13:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65D187FFF
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061443; cv=none; b=JGUsPYtVPuO9041VY+51BqlmzptJgCVDcKVlmy6tp6BLY8mQjnl0Xt7w5aJHzaCL/p9B78U7I4TYqo1p+LRfLg7lMUi96BGmbL4I2CIuZ3e/FXijzqN0GyRbEsf1vNqJQnueOMyXRVZA/v3JRvvpWcNar/7H/L0WRW40XxwO6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061443; c=relaxed/simple;
	bh=U3iGLZgFJgHwvnFwHItQlDc9hxsqSqbXTyDmTayss54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=h/vlzvqk6L9jLzCQZo4SWxJD4MrpcUz3VdFG8ri5VFnKfJLfZMgVxZjSi8ZQfgZaFgKNJ5V+1vEzLo1VXOGBnHS5P5JtB31nihZmvBFF3GKPxybWQVzjIlVnCe6il9P1dgbXb37UmwfeiUoFhtBU1jrA5g7b4hti+19/9XgcG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-qMNi0CQNMq-f6MuM5H5drA-1; Wed,
 11 Sep 2024 09:30:27 -0400
X-MC-Unique: qMNi0CQNMq-f6MuM5H5drA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB02A1977009;
	Wed, 11 Sep 2024 13:30:18 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE71F1956088;
	Wed, 11 Sep 2024 13:30:15 +0000 (UTC)
Date: Wed, 11 Sep 2024 15:30:13 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v6 12/25] ovpn: implement packet processing
Message-ID: <ZuGbZTinqmoBsc6C@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-13-antonio@openvpn.net>
 <ZtXOw-NcL9lvwWa8@hog>
 <ae23ac0f-2ff9-4396-9033-617dc60221eb@openvpn.net>
 <Zth2Trqbn73QDnLn@hog>
 <9ab97386-b83d-484e-8e6d-9f67a325669d@openvpn.net>
 <ZuBD7TWOQ7huO7_7@hog>
 <af164160-6402-45f9-8ef3-d5a3ffd43452@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <af164160-6402-45f9-8ef3-d5a3ffd43452@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-09-11, 14:52:10 +0200, Antonio Quartulli wrote:
> On 10/09/2024 15:04, Sabrina Dubroca wrote:
> > 2024-09-06, 15:19:08 +0200, Antonio Quartulli wrote:
> > > Therefore, how about having an array large enough to store all key ID=
s (max
> > > ID is 7):
> >=20
> > Right, I forgot about that. For 8 keys, sure, array sounds ok. MACsec
> > has only 4 and I also implemented it as an array
> > (include/net/macsec.h: macsec_{tx,rx}_sc, sa array).
>=20
> thanks for the pointer!
>=20
> >=20
> > > * array index is the key ID (fast lookup on RX);
> > > * upon SET_KEY we store the provided keys and erase the rest;
> >=20
> > I'm not sure about erasing the rest. If you're installing the
> > secondary ("next primary") key, you can't just erase the current
> > primary? ("erase the rest" also means you'd only ever have one key in
> > the array, which contradicts your last item in this list)
> Yeah, my point is wrong.
> I fooled myself assuming SET_KEY would install two keys each time, but th=
is
> is not the case, so we can't "erase everything else".
>=20
> What we can do is:
> * if SET_KEY wants to install a key in PRIMARY, then we erase the key mar=
ked
> as "primary" and we mark the new one as such
> * if SET_KEY wants to install a key in SECONDARY, then we erase the key
> without any mark.

Ok, then the DEL_KEY op would not really be needed.

>=20
> This way we simulate writing into slots.
>=20
> >=20
> > > * upon SET_KEY we store in a new field the index/ID of the PRIMARY (f=
ast
> > > lookup on TX), namely primary_id;
>=20
> FTR: this is what "marking as primary" means
>=20
> > > * upon SWAP we just save in primary_id the "other" index/ID;
> >=20
> > I'm confused by these two. Both SET_KEY and SWAP modify the primary_id?
>=20
> Yes.
> SET_KEY may want to install a key in the primary slot: in that case the n=
ew
> key has to be marked as primary immediately.
> This normally happens only upon first SET_KEY after connection, when no
> other key exists.
>=20
> SWAP will switch primary_id to the other key ID.
>=20
> makes sense?

Yes, thanks, that fixes up all my confusion around setting primary_id.

> > > * at any given time we will have only two keys in the array.
> >=20
> > This needs to be enforced in the SET_KEY implementation, otherwise
> > SWAP will have inconsistent effects.
>=20
> yap. I hope what I wrote above about SET_KEY helps clarifying this part.
>=20
> >=20
> >=20
> > > It's pretty much like your option 1 and 2, but using an array
> > > indexed by key ID.
> >=20
> > Are you decoupling TX and RX keys (so that they can be installed
> > independently) in this proposal? I can't really tell, the array could
> > be key pairs or separate.
>=20
> I would not decouple TX and RX keys.
> Each array item should be the same as what we are now storing into each s=
lot
> (struct ovpn_crypto_key_slot *).
> I could use two arrays, instead of an array of slots, but that means
> changing way more logic and I don't see the benefit.

Avoid changing both keys every time when a link has very asymmetric
traffic. And the concept of a primary/secondary key makes no sense on
receive, all you need is keyids, and there's no need to swap slots,
which avoids the "key not available during SWAP" issue
entirely. Primary key only makes sense on TX.

But I'm guessing the keypair concept is also baked deep into openvpn.


> > > The concept of slot is a bit lost, but it is not important as long as=
 we can
> > > keep the API and its semantics the same.
> >=20
> > Would it be a problem for userspace to keep track of key IDs, and use
> > that (instead of slots) to communicate with the kernel? Make
> > setkey/delkey be based on keyid, and replace swap with a set_tx
> > operation which updates the current keyid for TX. That would seem like
> > a better API, especially for the per-ID array you're proposing
> > here. The concept of slots would be almost completely lost (only
> > "current tx key" is left, which is similar to the "primary slot").
> > (it becomes almost identical to the way MACsec does things, except
> > possibly that in MACsec the TX and RX keys are not paired at all, so
> > you can install/delete a TX key without touching any RX key)
> >=20
>=20
> unfortunately changing userspace that way is not currently viable.
> There are more components (and documentation) that attach to this slot
> abstraction.

I thought that might be the case. Too bad, it means we have to keep
the slots API and the kernel will be stuck with it forever (even if
some day userspace can manage key ids instead of slots).

> Hence my proposal to keep the API the same, but rework the internal for
> better implementation.

Yeah, that makes sense if you have that constraint imposed by the
existing userspace.

>=20
> >=20
> > Maybe you can also rework the current code to look a bit like this
> > array-based proposal, and not give up the notion of slots, if that's
> > something strongly built into the core of openvpn:
> >=20
> > - primary/secondary in ovpn_crypto_state become slots[2]
> > - add a one-bit "primary" reference, used to look into the slots array
> > - swap just flips that "primary" bit
> > - TX uses slots[primary]
> > - RX keeps inspecting both slots (now slot[0] and slot[1] instead of
> >    primary/secondary) looking for the correct keyid
> > - setkey/delkey still operate on primary/secondary, but need to figure
> >    out whether slot[0] or slot[1] is primary/secondary based on
> >    ->primary
> >=20
> > It's almost identical to the current code (and API), except you don't
> > need to reassign any pointers to swap keys, so it should avoid the
> > rekey issue.
>=20
> This approach sounds very close to what I was aiming for, but simpler
> because we have slots[2] instead of slots[8] (which means that primary_id
> can be just 'one-bit').

Yes.

> The only downside is that upon RX we have to check both keys.
> However I don't think this is an issue as we have just 2 keys at most.
>=20
> I could even optimize the lookup by starting always from the primary key,=
 as
> that's the one being used most of the time by the sender.

Nice.

> Ok, I will go with this approach you summarized here at the end.

Ok. I think it should be a pretty minimal set of changes on top of the
existing code, especially if you hide the primary/secondary accesses
in inline helpers.

--=20
Sabrina


