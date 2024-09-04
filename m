Return-Path: <netdev+bounces-125156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0600096C1C8
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED37B2D0C3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0411DC184;
	Wed,  4 Sep 2024 15:02:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4EA1DA2FE
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462150; cv=none; b=OIOi7aY2ih7NSRez5Y7rbXdiWeiSHh3W6oPW1f125Rq2JPYseua9+GWDBIo2OWQIx97klyyChErxSGuZ9Qt2T+P1cO/xcb/zT0wyjY2e/y0zPKwoqpuW9bJV1rQhg7n9nb6gZtuWlasAylkWCQ0HoWmnkTlmqSbWubjSY8dJblY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462150; c=relaxed/simple;
	bh=iTJV5McgusjA6ShqfvVXH9/5WnfRq7gapkxISn4dHb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TiC30Ovtees6zBwdaTn5xcTRBYG27Q7bPGCURbmoJ0wnjPPy4HJWbFQ8/TMxQ0ogqzp18dAgZ/tihHh7Yc7H53GqU0eV+WvMypxBNn3hNAcvHyIRuK0qWlotFj7k/qkcaN/AZ1kqPcBjdAlGXKMnsvKcmNPjY21tLL+JRzeibb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-qQkQWiZtNt-KaEHgUGKf_A-1; Wed,
 04 Sep 2024 11:02:18 -0400
X-MC-Unique: qQkQWiZtNt-KaEHgUGKf_A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03D9319776A6;
	Wed,  4 Sep 2024 15:02:06 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 092D319560BD;
	Wed,  4 Sep 2024 15:01:36 +0000 (UTC)
Date: Wed, 4 Sep 2024 17:01:34 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v6 12/25] ovpn: implement packet processing
Message-ID: <Zth2Trqbn73QDnLn@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-13-antonio@openvpn.net>
 <ZtXOw-NcL9lvwWa8@hog>
 <ae23ac0f-2ff9-4396-9033-617dc60221eb@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ae23ac0f-2ff9-4396-9033-617dc60221eb@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-09-04, 14:07:23 +0200, Antonio Quartulli wrote:
> Hi,
>=20
> On 02/09/2024 16:42, Sabrina Dubroca wrote:
> > 2024-08-27, 14:07:52 +0200, Antonio Quartulli wrote:
> > > +/* this swap is not atomic, but there will be a very short time fram=
e where the
> >=20
> > Since we're under a mutex, I think we might get put to sleep for a
> > not-so-short time frame.
> >=20
> > > + * old_secondary key won't be available. This should not be a big de=
al as most
> >=20
> > I could be misreading the code, but isn't it old_primary that's
> > unavailable during the swap? rcu_replace_pointer overwrites
> > cs->primary, so before the final assign, both slots contain
> > old_secondary?
>=20
> Right. The comment is not correct.
>=20
> cs->secondary (old_secondary, that is the newest key) is what is probably
> being used by the other peer for sending traffic.

Right, thanks. I was getting confused about the key slots and which
key was the newest.

If the peer has already started sending with the newest key, no
problem. If we're swapping keys before our peer (or we're on a slow
network and the peer's packets get delayed), we'll still be receiving
packets encrypted with the old key.


> Therefore old_secondary is what is likely to be needed.
>=20
> However, this is pure speculation and may not be accurate.

I can think of a few possibilities if this causes too many unwanted
drops:

 - use a linked list of keys, set the primary instead of swapping, and
   let delete remove the unused key(s) by ID instead of slot

 - decouple the TX and RX keys, which also means you don't really need
   to swap keys (swap for the TX key becomes "set primary", swap on RX
   can become a noop since you check both slots for the correct keyid)
   -- and here too delete becomes based on key ID

 - if cs->mutex becomes a spinlock, take it in the datapath when
   looking up keys. this will make sure we get a consistent view of
   the keys state.

 - come up with a scheme to let the datapath retry the key lookup if
   it didn't find the key it wanted (maybe something like a seqcount,
   or maybe taking the lock and retrying if the lookup failed)

I don't know if options 1 and 2 are possible based on how openvpn (the
protocol and the userspace application) models keys, but they seem a
bit "cleaner" on the datapath side (no locking, no retry). But they
require a different API.

Do you have the same problem in the current userspace implementation?


> The fact that we could sleep before having completed the swap sounds like
> something we want to avoid.
> Maybe I should convert this mutex to a spinlock. Its usage is fairly
> contained anyway.

I think it would make sense. It's only being held for very short
periods, just to set/swap a few pointers.


> FTR: this restructuring is the result of having tested encryption/decrypt=
ion
> with pcrypt: sg, that is passed to the crypto code, was initially allocat=
ed
> on the stack, which was obviously not working for async crypto.
> The solution was to make it part of the skb CB area, so that it can be
> carried around until crypto is done.

I see. I thought this patch looked less familiar than the others :)

An alternative to using the CB is what IPsec does: allocate a chunk of
memory for all its temporary needs (crypto req, sg, iv, anything else
it needs during async crypto) and carve the pointers/small chunks out
of it. See esp_alloc_tmp in net/ipv4/esp4.c.  (I'm just mentioning
that for reference/curiosity, not asking that you change ovpn)


> This patch was basically re-written after realizing that the async crypto
> path was not working as expected, therefore sorry if there were some "kin=
da
> obvious" mistakes.

And I completely missed some of those issues in previous reviews.

> Thanks a lot for your review.

Cheers, and thanks for your patience.

--=20
Sabrina


