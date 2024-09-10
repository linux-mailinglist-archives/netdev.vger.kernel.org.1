Return-Path: <netdev+bounces-126987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D197383A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256661F268F7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6F218F2DB;
	Tue, 10 Sep 2024 13:05:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870118C00D
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973503; cv=none; b=atIQuR7IEluTeaqItlB3hxyqWdu5BZzf/36w3uGKqccq1t0yW4J2yiZlaegnw9t0gcobS82OZhEOpsKekkcTjr83zCQV1U5IO8QgN/DeNwEm4JNIIz0RLxJHW/+7K6uS1dSJUiyEHIh3xiaL87Hyp6XxlDkdpjyfaqphEs6C4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973503; c=relaxed/simple;
	bh=6fWKj8HqwxHsRae/yL8d0HlW2VK44EGrAuOcLNU+fu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HuDnzgSs2fCMVNs5v3/ZLC7pMW4sxM+Lmv8Eqp1J2eB7WuJ36TJJxeRFmWxNCbn8fdueehzF9qiETf+pJhCHveOVMZLMBojtnO1x0nUMG901JmvkOT35w5+udJZ5/x64TIs/6P+muq8BT6b/uE8EVFQMYVWGTT2DfdUcFNgR9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-pF7oHThnNUmdGij1hb9gGQ-1; Tue,
 10 Sep 2024 09:04:52 -0400
X-MC-Unique: pF7oHThnNUmdGij1hb9gGQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 173A21955D58;
	Tue, 10 Sep 2024 13:04:51 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61BBD1956086;
	Tue, 10 Sep 2024 13:04:48 +0000 (UTC)
Date: Tue, 10 Sep 2024 15:04:45 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v6 12/25] ovpn: implement packet processing
Message-ID: <ZuBD7TWOQ7huO7_7@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-13-antonio@openvpn.net>
 <ZtXOw-NcL9lvwWa8@hog>
 <ae23ac0f-2ff9-4396-9033-617dc60221eb@openvpn.net>
 <Zth2Trqbn73QDnLn@hog>
 <9ab97386-b83d-484e-8e6d-9f67a325669d@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9ab97386-b83d-484e-8e6d-9f67a325669d@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-09-06, 15:19:08 +0200, Antonio Quartulli wrote:
> On 04/09/2024 17:01, Sabrina Dubroca wrote:
> > 2024-09-04, 14:07:23 +0200, Antonio Quartulli wrote:
> > > On 02/09/2024 16:42, Sabrina Dubroca wrote:
> > > > 2024-08-27, 14:07:52 +0200, Antonio Quartulli wrote:
> > I can think of a few possibilities if this causes too many unwanted
> > drops:
> >=20
> >   - use a linked list of keys, set the primary instead of swapping, and
> >     let delete remove the unused key(s) by ID instead of slot
> >=20
> >   - decouple the TX and RX keys, which also means you don't really need
> >     to swap keys (swap for the TX key becomes "set primary", swap on RX
> >     can become a noop since you check both slots for the correct keyid)
> >     -- and here too delete becomes based on key ID
> >=20
> >   - if cs->mutex becomes a spinlock, take it in the datapath when
> >     looking up keys. this will make sure we get a consistent view of
> >     the keys state.
> >=20
> >   - come up with a scheme to let the datapath retry the key lookup if
> >     it didn't find the key it wanted (maybe something like a seqcount,
> >     or maybe taking the lock and retrying if the lookup failed)
> >=20
> > I don't know if options 1 and 2 are possible based on how openvpn (the
> > protocol and the userspace application) models keys, but they seem a
> > bit "cleaner" on the datapath side (no locking, no retry). But they
> > require a different API.
>=20
> After chewing over all these ideas I think we can summarize the requireme=
nts
> as follows:
>=20
> * PRIMARY and SECONDARY in the API is just an abstraction for "KEY FOR TX=
"
> and "THE OTHER KEY";
> * SWAP means "mark for TX the key that currently was not marked";
> * we only need a pointer to the key for TX;
> * key for RX is picked up by key ID;
>=20
> Therefore, how about having an array large enough to store all key IDs (m=
ax
> ID is 7):

Right, I forgot about that. For 8 keys, sure, array sounds ok. MACsec
has only 4 and I also implemented it as an array
(include/net/macsec.h: macsec_{tx,rx}_sc, sa array).

> * array index is the key ID (fast lookup on RX);
> * upon SET_KEY we store the provided keys and erase the rest;

I'm not sure about erasing the rest. If you're installing the
secondary ("next primary") key, you can't just erase the current
primary? ("erase the rest" also means you'd only ever have one key in
the array, which contradicts your last item in this list)

> * upon SET_KEY we store in a new field the index/ID of the PRIMARY (fast
> lookup on TX), namely primary_id;
> * upon SWAP we just save in primary_id the "other" index/ID;

I'm confused by these two. Both SET_KEY and SWAP modify the primary_id?

> * at any given time we will have only two keys in the array.

This needs to be enforced in the SET_KEY implementation, otherwise
SWAP will have inconsistent effects.


> It's pretty much like your option 1 and 2, but using an array
> indexed by key ID.

Are you decoupling TX and RX keys (so that they can be installed
independently) in this proposal? I can't really tell, the array could
be key pairs or separate.


> The concept of slot is a bit lost, but it is not important as long as we =
can
> keep the API and its semantics the same.

Would it be a problem for userspace to keep track of key IDs, and use
that (instead of slots) to communicate with the kernel? Make
setkey/delkey be based on keyid, and replace swap with a set_tx
operation which updates the current keyid for TX. That would seem like
a better API, especially for the per-ID array you're proposing
here. The concept of slots would be almost completely lost (only
"current tx key" is left, which is similar to the "primary slot").
(it becomes almost identical to the way MACsec does things, except
possibly that in MACsec the TX and RX keys are not paired at all, so
you can install/delete a TX key without touching any RX key)


Maybe you can also rework the current code to look a bit like this
array-based proposal, and not give up the notion of slots, if that's
something strongly built into the core of openvpn:

- primary/secondary in ovpn_crypto_state become slots[2]
- add a one-bit "primary" reference, used to look into the slots array
- swap just flips that "primary" bit
- TX uses slots[primary]
- RX keeps inspecting both slots (now slot[0] and slot[1] instead of
  primary/secondary) looking for the correct keyid
- setkey/delkey still operate on primary/secondary, but need to figure
  out whether slot[0] or slot[1] is primary/secondary based on
  ->primary

It's almost identical to the current code (and API), except you don't
need to reassign any pointers to swap keys, so it should avoid the
rekey issue.

--=20
Sabrina


