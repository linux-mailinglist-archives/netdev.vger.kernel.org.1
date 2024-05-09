Return-Path: <netdev+bounces-94912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62C8C1011
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7081C20A9B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69435146D7B;
	Thu,  9 May 2024 13:04:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0621474DF
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259888; cv=none; b=g8nHdCWwF/6j8Trp9wx+Atb1UoZM+vsKL5ybLqT2Y0LEHgpvYRyV+vQFGIapAzCJR6unxvG8u2ON+MqlK5gGhZo3LRtvPGAz4uF0A4gkjpTzuke5u4bxWc2Ws6R9qa081K6T/uCim4ssVlUgQJqHnLfWZh0fBvqNVTQMhV6Fak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259888; c=relaxed/simple;
	bh=fkidsUROL6ZVKOJxX1PvP0foVYArCHvoFlrucyU4ktA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZdxiY+h65xQxd1I9lw8hGBipXykLEheW1eBszl6QY1UcWzWUOWssQwf36Mhb/rwj65lx4XVyOjWnS7VqP9N8+Gh70iD2tI8GMD26PKMkBSWv2pJTjq+8ALB1u7ZQd9zAqho7SAzPxxuoA+R5dOKN14GIG5ljK/qMiNTrLFT+CI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-RZo9Hn7mMf62_BPLiBjB1g-1; Thu, 09 May 2024 09:04:39 -0400
X-MC-Unique: RZo9Hn7mMf62_BPLiBjB1g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98501185A78E;
	Thu,  9 May 2024 13:04:38 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 81DFA100046E;
	Thu,  9 May 2024 13:04:37 +0000 (UTC)
Date: Thu, 9 May 2024 15:04:36 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
Message-ID: <ZjzJ5Hm8hHnE7LR9@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net>
 <ZjujHw6eglLEIbxA@hog>
 <60cae774-b60b-4a4b-8645-91eb6f186032@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <60cae774-b60b-4a4b-8645-91eb6f186032@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-08, 22:31:51 +0200, Antonio Quartulli wrote:
> On 08/05/2024 18:06, Sabrina Dubroca wrote:
> > 2024-05-06, 03:16:20 +0200, Antonio Quartulli wrote:
> > > diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstr=
uct.h
> > > index ee05b8a2c61d..b79d4f0474b0 100644
> > > --- a/drivers/net/ovpn/ovpnstruct.h
> > > +++ b/drivers/net/ovpn/ovpnstruct.h
> > > @@ -17,12 +17,19 @@
> > >    * @dev: the actual netdev representing the tunnel
> > >    * @registered: whether dev is still registered with netdev or not
> > >    * @mode: device operation mode (i.e. p2p, mp, ..)
> > > + * @lock: protect this object
> > > + * @event_wq: used to schedule generic events that may sleep and tha=
t need to be
> > > + *            performed outside of softirq context
> > > + * @peer: in P2P mode, this is the only remote peer
> > >    * @dev_list: entry for the module wide device list
> > >    */
> > >   struct ovpn_struct {
> > >   =09struct net_device *dev;
> > >   =09bool registered;
> > >   =09enum ovpn_mode mode;
> > > +=09spinlock_t lock; /* protect writing to the ovpn_struct object */
> >=20
> > nit: the comment isn't really needed since you have kdoc saying the sam=
e thing
>=20
> True, but checkpatch.pl (or some other script?) was still throwing a
> warning, therefore I added this comment to silence it.

Ok, then I guess the comment (and the other one below) can stay. That
sounds like a checkpatch.pl bug.

> > > +=09struct workqueue_struct *events_wq;
> > > +=09struct ovpn_peer __rcu *peer;
> > >   =09struct list_head dev_list;
> > >   };
> > > diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> > > new file mode 100644
> > > index 000000000000..2948b7320d47
> > > --- /dev/null
> > > +++ b/drivers/net/ovpn/peer.c
> > [...]
> > > +/**
> > > + * ovpn_peer_free - release private members and free peer object
> > > + * @peer: the peer to free
> > > + */
> > > +static void ovpn_peer_free(struct ovpn_peer *peer)
> > > +{
> > > +=09ovpn_bind_reset(peer, NULL);
> > > +
> > > +=09WARN_ON(!__ptr_ring_empty(&peer->tx_ring));
> >=20
> > Could you pass a destructor to ptr_ring_cleanup instead of all these WA=
RNs?
>=20
> hmm but if we remove the WARNs then we lose the possibility to catch
> potential bugs, no? rings should definitely be empty at this point.

Ok, I haven't looked deep enough into how all the parts interact to
understand that. The refcount bump around the tx_ring loop in
ovpn_encrypt_work() takes care of that? Maybe worth a comment "$RING
should be empty at this point because of XYZ" (for each of the rings).

> Or you think I should just not care and free any potentially remaining it=
em?

Whether you WARN or not, any remaining item is going to be leaked. I'd
go with WARN (or maybe DEBUG_NET_WARN_ON_ONCE) and free remaining
items. It should never happen but seems easy to deal with, so why not
handle it?

> > > +void ovpn_peer_release(struct ovpn_peer *peer)
> > > +{
> > > +=09call_rcu(&peer->rcu, ovpn_peer_release_rcu);
> > > +}
> > > +
> > > +/**
> > > + * ovpn_peer_delete_work - work scheduled to release peer in process=
 context
> > > + * @work: the work object
> > > + */
> > > +static void ovpn_peer_delete_work(struct work_struct *work)
> > > +{
> > > +=09struct ovpn_peer *peer =3D container_of(work, struct ovpn_peer,
> > > +=09=09=09=09=09      delete_work);
> > > +=09ovpn_peer_release(peer);
> >=20
> > Does call_rcu really need to run in process context?
>=20
> Reason for switching to process context is that we have to invoke
> ovpn_nl_notify_del_peer (that sends a netlink event to userspace) and the
> latter requires a reference to the peer.

I'm confused. When you say "requires a reference to the peer", do you
mean accessing fields of the peer object? I don't see why this
requires ovpn_nl_notify_del_peer to to run from process context.

> For this reason I thought it would be safe to have ovpn_nl_notify_del_pee=
r
> and call_rcu invoked by the same context.
>=20
> If I invoke call_rcu in ovpn_peer_release_kref, how can I be sure that th=
e
> peer hasn't been free'd already when ovpn_nl_notify_del_peer is executed?

Put the ovpn_nl_notify_del_peer call before the call_rcu, it will
access the peer and then once that's done call_rcu will do its job?


> > > +/**
> > > + * ovpn_peer_del_p2p - delete peer from related tables in a P2P inst=
ance
> > > + * @peer: the peer to delete
> > > + * @reason: reason why the peer was deleted (sent to userspace)
> > > + *
> > > + * Return: 0 on success or a negative error code otherwise
> > > + */
> > > +static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
> > > +=09=09=09     enum ovpn_del_peer_reason reason)
> > > +{
> > > +=09struct ovpn_peer *tmp;
> > > +=09int ret =3D -ENOENT;
> > > +
> > > +=09spin_lock_bh(&peer->ovpn->lock);
> > > +=09tmp =3D rcu_dereference(peer->ovpn->peer);
> > > +=09if (tmp !=3D peer)
> > > +=09=09goto unlock;
> >=20
> > How do we recover if all those objects got out of sync? Are we stuck
> > with a broken peer?
>=20
> mhhh I don't fully get the scenario you are depicting.
>=20
> In P2P mode there is only peer stored (reference is saved in ovpn->peer)
>=20
> When we want to get rid of it, we invoke ovpn_peer_del_p2p().
> The check we are performing here is just about being sure that we are
> removing the exact peer we requested to remove (and not some other peer t=
hat
> was still floating around for some reason).

But it's the right peer because it's the one the caller decided to get
rid of.  How about DEBUG_NET_WARN_ON_ONCE(tmp !=3D peer) and always
releasing the peer?

> > And if this happens during interface deletion, aren't we leaking the
> > peer memory here?
>=20
> at interface deletion we call
>=20
> ovpn_iface_destruct -> ovpn_peer_release_p2p ->
> ovpn_peer_del_p2p(ovpn->peer)
>=20
> so at the last step we just ask to remove the very same peer that is
> curently stored, which should just never fail.

But that's not what the test checks for. If ovpn->peer->ovpn !=3D ovpn,
the test in ovpn_peer_del_p2p will fail. That's "objects getting out
of sync" in my previous email. The peer has a bogus back reference to
its ovpn parent, but it's ovpn->peer nevertheless.

--=20
Sabrina


