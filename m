Return-Path: <netdev+bounces-95932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329558C3E0D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562A61C21220
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E141487D9;
	Mon, 13 May 2024 09:24:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18431474CF
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592258; cv=none; b=CpKDk6CF4ATiM7wqSqM1kSkeIjJHge7ZYDS4DewZvJ6zE5lpSfLsXn+QME6B7Zcvimhz/nxpQG44hJH2cVn3/qurP9rLnozX9PRvK4XL5AS6SpvcihTW25e26rbm5mZ5D8H4bxBw/WzMMZNtH4apTjkj55lrmDOnXCAPpPcCNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592258; c=relaxed/simple;
	bh=fMb35wN9wCty5L9eT0Thi3BHg9J64QSHtAOyOWIRYWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JvvO1lZN8CD+YI5P5ybrZWOz+DEyJ40bulkrmdWOjrS//yv58/eUjgsX96W7h4JMDaecZYyDEZq2jt59QypTg1HymaWaBYhlemdDEPMqYaVecGJRYNhBwLXRgf4QDJ0RWZ8PpTuIKhN0vJWkZxyPAXQqVeMif+d8lrOjvBLM7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-KnHhRPkgMUGdA4tB-Ok1vg-1; Mon,
 13 May 2024 05:24:06 -0400
X-MC-Unique: KnHhRPkgMUGdA4tB-Ok1vg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 145A529AA3BF;
	Mon, 13 May 2024 09:24:06 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F2D9340004B;
	Mon, 13 May 2024 09:24:04 +0000 (UTC)
Date: Mon, 13 May 2024 11:24:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 11/24] ovpn: implement packet processing
Message-ID: <ZkHcMw6p31m-ErqY@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-12-antonio@openvpn.net>
 <ZkCB2sFnpIluo3wm@hog>
 <d2733aaa-58fa-47da-a469-a848a6100759@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d2733aaa-58fa-47da-a469-a848a6100759@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-13, 09:14:39 +0200, Antonio Quartulli wrote:
> On 12/05/2024 10:46, Sabrina Dubroca wrote:
> > 2024-05-06, 03:16:24 +0200, Antonio Quartulli wrote:
> > > diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
> > > index c1f842c06e32..7240d1036fb7 100644
> > > --- a/drivers/net/ovpn/bind.c
> > > +++ b/drivers/net/ovpn/bind.c
> > > @@ -13,6 +13,7 @@
> > >   #include "ovpnstruct.h"
> > >   #include "io.h"
> > >   #include "bind.h"
> > > +#include "packet.h"
> > >   #include "peer.h"
> >=20
> > You have a few hunks like that in this patch, adding an include to a
> > file that is otherwise not being modified. That's odd.
>=20
> Argh. The whole ovpn was originall a single patch, which I the went and
> divided in smaller changes for easier review.
>=20
> As you may imagine this process is prone to mistakes like this, expeciall=
y
> when the number of patches is quite high...
>=20
> I will go through all the patches and clean them up from issues like this
> and like the one below..
>=20
> Sorry about that.

Yep, I understand.

> > > +struct ovpn_crypto_key_slot *
> > > +ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
> > > +{
> > > +=09return ovpn_aead_crypto_key_slot_init(kc->cipher_alg,
> > > +=09=09=09=09=09      kc->encrypt.cipher_key,
> > > +=09=09=09=09=09      kc->encrypt.cipher_key_size,
> > > +=09=09=09=09=09      kc->decrypt.cipher_key,
> > > +=09=09=09=09=09      kc->decrypt.cipher_key_size,
> > > +=09=09=09=09=09      kc->encrypt.nonce_tail,
> > > +=09=09=09=09=09      kc->encrypt.nonce_tail_size,
> > > +=09=09=09=09=09      kc->decrypt.nonce_tail,
> > > +=09=09=09=09=09      kc->decrypt.nonce_tail_size,
> > > +=09=09=09=09=09      kc->key_id);
> > > +}
> >=20
> > Why the wrapper? You could just call ovpn_aead_crypto_key_slot_init
> > directly.
>=20
> Mostly for ahestetic reasons, being the call very large.

But that wrapper doesn't really do anything.

In case my previous comment wasn't clear: I would keep the single
argument at the callsite (whether it's called _new or _init), and kill
the 10-args variant (it's too verbose and _very_ easy to mess up).


> > > @@ -132,7 +157,81 @@ int ovpn_recv(struct ovpn_struct *ovpn, struct o=
vpn_peer *peer,
> > >   static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff =
*skb)
> > >   {
> > > -=09return true;
> >=20
> > I missed that in the RX patch, true isn't an int :)
> > Were you intending this function to be bool like ovpn_encrypt_one?
> > Since you're not actually using the returned value in the caller, it
> > would be reasonable, but you'd have to convert all the <0 error values
> > to bool.
>=20
> Mhh let me think what's best and I wil make this uniform.

Yes please. If you can make the returns consistent (on success, one
returns true and the other returns 0), it would be nice.


> > > +=09ret =3D ptr_ring_produce_bh(&peer->netif_rx_ring, skb);
> > > +drop:
> > > +=09if (likely(allowed_peer))
> > > +=09=09ovpn_peer_put(allowed_peer);
> > > +
> > > +=09if (unlikely(ret < 0))
> > > +=09=09kfree_skb(skb);
> > > +
> > > +=09return ret;
> >=20
> > Mixing the drop/success returns looks kind of strange. This would be a
> > bit simpler:
> >=20
> > ovpn_peer_put(allowed_peer);
> > return ptr_ring_produce_bh(&peer->netif_rx_ring, skb);
> >=20
> > drop:
> > if (allowed_peer)
> >      ovpn_peer_put(allowed_peer);
> > kfree_skb(skb);
> > return ret;

Scratch that, it's broken (we'd leak the skb if ptr_ring_produce_bh
fails). Let's keep your version.

> Honestly I have seen this pattern fairly often (and implemented it this w=
ay
> fairly often).
>=20
> I presume it is mostly a matter of taste.

Maybe. As a reader I find it confusing to land into the "drop" label
on success and conditionally free the skb.

> The idea is: when exiting a function 90% of the code is shared between
> success and failure, therefore let's just write it once and simply add a =
few
> branches based on ret.

If it's 90%, yes. Here, it looked like very little common code.

> This way we have less code and if we need to chang somethig in the exit
> path, we can change it once only.
>=20
> A few examples:
> * https://elixir.bootlin.com/linux/v6.9-rc7/source/net/batman-adv/transla=
tion-table.c#L813
> * https://elixir.bootlin.com/linux/v6.9-rc7/source/net/batman-adv/routing=
.c#L269
> * https://elixir.bootlin.com/linux/v6.9-rc7/source/net/mac80211/scan.c#L1=
344
>=20
>=20
> ovpn code can be further simplified by setting skb to NULL in case of
> success (this way we avoid checking ret) and let ovpn_peer_put handle the
> case of peer =3D=3D NULL (we avoid the NULL check before calling it).

That won't be needed if you don't take a reference. Anyway,
netif_rx_ring will be gone if you switch to gro_cells, so that code is
likely to change.

--=20
Sabrina


