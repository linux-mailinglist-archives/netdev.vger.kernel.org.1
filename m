Return-Path: <netdev+bounces-125497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E36296D65A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF3E1F22578
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8675F1957F8;
	Thu,  5 Sep 2024 10:47:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63D14F117
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533242; cv=none; b=SYREuzpMiRK0JrznAfC2Tm+dtUT2JrJdSZZoUMgTs2Mrqf1uY6VUNy/FPSTsk7EkaAn3MgdG+pfnyAswYCZz20rWgYQVbUlgLKvjuO480MkjxIRL3cNcYVoqCi+AamqHmRz/91p5WTRLKdhC99GIW47LCg5oxG+yI2Ja4Ghyr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533242; c=relaxed/simple;
	bh=hoHYjZuSR784CY/bOpCCb74SkGwjVjpecUXa2xQ4Z+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TyyUKyAqWZPaue9p8Wj9G3XzFEG9Tjl7jMo+XBxwnsdgyc0iG7cyqAuj8yJGK2qv33IPa8TXN5CUI6hlyD8nynqWvYKb5dskwi7TtbxnFjCZRKqUCuISgGw/YLenKyHjdhxZvArXuklrE13PZFsMkN/cC6QpLRz+Yq3/8QAJYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-lcFVOz9rNGGoBC84sa8wcw-1; Thu,
 05 Sep 2024 06:47:11 -0400
X-MC-Unique: lcFVOz9rNGGoBC84sa8wcw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 852911955BF8;
	Thu,  5 Sep 2024 10:47:09 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 573411955F44;
	Thu,  5 Sep 2024 10:47:05 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:47:04 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v6 15/25] ovpn: implement multi-peer support
Message-ID: <ZtmMKDPZzsFdbTpq@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-16-antonio@openvpn.net>
 <Ztcf88I1epYlIYGS@hog>
 <79b087fc-1e73-4ce5-82cb-b309326ae78e@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <79b087fc-1e73-4ce5-82cb-b309326ae78e@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-09-05, 10:02:58 +0200, Antonio Quartulli wrote:
> On 03/09/2024 16:40, Sabrina Dubroca wrote:
> > 2024-08-27, 14:07:55 +0200, Antonio Quartulli wrote:
> > >   static int ovpn_net_init(struct net_device *dev)
> > >   {
> > >   =09struct ovpn_struct *ovpn =3D netdev_priv(dev);
> > > +=09int i, err =3D gro_cells_init(&ovpn->gro_cells, dev);
> >=20
> > I'm not a fan of "hiding" the gro_cells_init call up here. I'd prefer
> > if this was done just before the corresponding "if (err)".
>=20
> I am all with you, but I remember in the past something complaining about
> "variable declared and then re-assigned right after".
>=20
> But maybe this is not the case anymore.

If you had something like:

=09int err;

=09err =3D -EINVAL;

sure, it would make sense to combine them.

>=20
> Will move the initialization down.

Thanks.


> > > +
> > > +=09=09spin_lock_init(&ovpn->peers->lock_by_id);
> > > +=09=09spin_lock_init(&ovpn->peers->lock_by_vpn_addr);
> > > +=09=09spin_lock_init(&ovpn->peers->lock_by_transp_addr);
> >=20
> > What's the benefit of having 3 separate locks instead of a single lock
> > protecting all the hashtables?
>=20
> The main reason was to avoid a deadlock - I thought I had added a comment
> about it...

Ok.

I could have missed it, I'm not looking at the comments much now that
I'm familiar with the code.

> The problem was a deadlock between acquiring peer->lock and
> ovpn->peers->lock in float() and in then opposite sequence in peers_free(=
).
> (IIRC this happens due to ovpn_peer_reset_sockaddr() acquiring peer->lock=
)

I don't see a problem with ovpn_peer_reset_sockaddr, but ovpn_peer_put
can be called with lock_by_id held and then take peer->lock (in
ovpn_peer_release), which would be the opposite order to
ovpn_peer_float if the locks were merged (peer->lock then
lock_by_transp_addr).

This should be solvable with a single lock by delaying the bind
cleanup via call_rcu instead of doing it immediately with
ovpn_peer_release (after that delay, nothing should be using
peer->bind anymore, since we have no reference and no more
rcu_read_lock sections that could have found peer, so we can free
immediately and no need to take peer->lock). And it's I think a bit
more "correct" wrt RCU rules, since at ovpn_peer_put time, even with
refcount=3D0, we could have a reader still using the peer and deciding
to update its bind (not the case with how ovpn_peer_float is called,
since we have a reference on the peer).

(This could be completely wrong and/or make no sense at all :))

But I'm not going to insist on this, you can keep the separate locks.


> Splitting the larger peers->lock allowed me to avoid this scenario, becau=
se
> I don't need to jump through any hoop to coordinate access to different
> hashtables.
>=20
> >=20
> > > +
> > > +=09=09for (i =3D 0; i < ARRAY_SIZE(ovpn->peers->by_id); i++) {
> > > +=09=09=09INIT_HLIST_HEAD(&ovpn->peers->by_id[i]);
> > > +=09=09=09INIT_HLIST_HEAD(&ovpn->peers->by_vpn_addr[i]);
> > > +=09=09=09INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_transp_addr[i],
> > > +=09=09=09=09=09      i);
> > > +=09=09}
> > > +=09}
> > > +
> > > +=09return 0;
> > >   }
> >=20
> > > +static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_pe=
er *peer)
> > > +{
> > > +=09struct sockaddr_storage sa =3D { 0 };
> > > +=09struct hlist_nulls_head *nhead;
> > > +=09struct sockaddr_in6 *sa6;
> > > +=09struct sockaddr_in *sa4;
> > > +=09struct hlist_head *head;
> > > +=09struct ovpn_bind *bind;
> > > +=09struct ovpn_peer *tmp;
> > > +=09size_t salen;
> > > +
> > > +=09spin_lock_bh(&ovpn->peers->lock_by_id);
> > > +=09/* do not add duplicates */
> > > +=09tmp =3D ovpn_peer_get_by_id(ovpn, peer->id);
> > > +=09if (tmp) {
> > > +=09=09ovpn_peer_put(tmp);
> > > +=09=09spin_unlock_bh(&ovpn->peers->lock_by_id);
> > > +=09=09return -EEXIST;
> > > +=09}
> > > +
> > > +=09hlist_add_head_rcu(&peer->hash_entry_id,
> > > +=09=09=09   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
> > > +=09=09=09=09=09      sizeof(peer->id)));
> > > +=09spin_unlock_bh(&ovpn->peers->lock_by_id);
> > > +
> > > +=09bind =3D rcu_dereference_protected(peer->bind, true);
> > > +=09/* peers connected via TCP have bind =3D=3D NULL */
> > > +=09if (bind) {
> > > +=09=09switch (bind->remote.in4.sin_family) {
> > > +=09=09case AF_INET:
> > > +=09=09=09sa4 =3D (struct sockaddr_in *)&sa;
> > > +
> > > +=09=09=09sa4->sin_family =3D AF_INET;
> > > +=09=09=09sa4->sin_addr.s_addr =3D bind->remote.in4.sin_addr.s_addr;
> > > +=09=09=09sa4->sin_port =3D bind->remote.in4.sin_port;
> > > +=09=09=09salen =3D sizeof(*sa4);
> > > +=09=09=09break;
> > > +=09=09case AF_INET6:
> > > +=09=09=09sa6 =3D (struct sockaddr_in6 *)&sa;
> > > +
> > > +=09=09=09sa6->sin6_family =3D AF_INET6;
> > > +=09=09=09sa6->sin6_addr =3D bind->remote.in6.sin6_addr;
> > > +=09=09=09sa6->sin6_port =3D bind->remote.in6.sin6_port;
> > > +=09=09=09salen =3D sizeof(*sa6);
> > > +=09=09=09break;
> > > +=09=09default:
> >=20
> > And remove from the by_id hashtable? Or is that handled somewhere that
> > I missed (I don't think ovpn_peer_unhash gets called in that case)?
>=20
> No we don't call unhash in this case as we assume the adding just failed
> entirely.
>=20
> I will add the removal before returning the error (moving the add below t=
he
> switch would extend the locked area too much.)

I don't think setting a few variables would be too much to do under
the lock (and it would address the issues in my 2nd reply to this
patch).

--=20
Sabrina


