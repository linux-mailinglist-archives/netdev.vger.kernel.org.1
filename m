Return-Path: <netdev+bounces-99143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670268D3D05
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE84280F91
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AC2180A90;
	Wed, 29 May 2024 16:42:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E68C1C6B2
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000943; cv=none; b=syEngX4+b8X7o4TbX5u0zwvvF5Ad/dWW9gt+H7ezZJqNS9w+eQpbBHBekhlNXBSOT/HaSazivfN9ZjBWNxdCu6VJKcr94AX1WtqPM56rJ22kRHfMGKlYkV+q8Vt0FgslF+1uRLuF7equxId33TiY2Y/g2O2TSAMB02KY/NTjM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000943; c=relaxed/simple;
	bh=vWH9hSQXnCEAzsKzxpcy0bLy/fvnSoiqPZRq1/X9IEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YPNeGwn+Z90Yj9b7Cc6g5sVlUJdlulejyDA8NkRjZsVwbhCexSSJxAM+h+oHqIUDBhIlIa6EP7x3Igft+IBII6PDnuoMLOCOQJoGfXWRJf0H7BEslmJTYG9VlCQyqTwhobG3/4gtHr05PMi70Qr7Cssn5Smz/9T3kZ7s4jdIqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-Lgz0Y3seMiOGtl9ZcwfcNQ-1; Wed, 29 May 2024 12:42:15 -0400
X-MC-Unique: Lgz0Y3seMiOGtl9ZcwfcNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F380800CA2;
	Wed, 29 May 2024 16:42:14 +0000 (UTC)
Received: from hog (unknown [10.39.192.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3203DC15BB1;
	Wed, 29 May 2024 16:42:13 +0000 (UTC)
Date: Wed, 29 May 2024 18:42:12 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 15/24] ovpn: implement peer lookup logic
Message-ID: <Zlda5GcgKd9Y9O_o@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-16-antonio@openvpn.net>
 <ZlYJaIvXY3nuNd98@hog>
 <75ff57a6-dcd8-47f7-99bf-f46a1daee4b0@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <75ff57a6-dcd8-47f7-99bf-f46a1daee4b0@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-28, 22:09:37 +0200, Antonio Quartulli wrote:
> On 28/05/2024 18:42, Sabrina Dubroca wrote:
> > 2024-05-06, 03:16:28 +0200, Antonio Quartulli wrote:
> > > @@ -303,10 +427,28 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2=
p(struct ovpn_struct *ovpn,
> > >   struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32=
 peer_id)
> > >   {
> > > -=09struct ovpn_peer *peer =3D NULL;
> > > +=09struct ovpn_peer *tmp, *peer =3D NULL;
> > > +=09struct hlist_head *head;
> > > +=09u32 index;
> > >   =09if (ovpn->mode =3D=3D OVPN_MODE_P2P)
> > > -=09=09peer =3D ovpn_peer_get_by_id_p2p(ovpn, peer_id);
> > > +=09=09return ovpn_peer_get_by_id_p2p(ovpn, peer_id);
> > > +
> > > +=09index =3D ovpn_peer_index(ovpn->peers.by_id, &peer_id, sizeof(pee=
r_id));
> > > +=09head =3D &ovpn->peers.by_id[index];
> > > +
> > > +=09rcu_read_lock();
> > > +=09hlist_for_each_entry_rcu(tmp, head, hash_entry_id) {
> > > +=09=09if (tmp->id !=3D peer_id)
> > > +=09=09=09continue;
> > > +
> > > +=09=09if (!ovpn_peer_hold(tmp))
> > > +=09=09=09continue;
> >=20
> > Can there ever be multiple peers with the same id? (ie, is it worth
> > continuing the loop if this fails? the same question probably applies
> > to ovpn_peer_get_by_transp_addr as well)
>=20
> Well, not at the same time, but theoretically we could re-use the ID of a
> peer that is being released (i.e. still in the list but refcnt at 0) beca=
use
> it won't be returned by this lookup.
>=20
> This said, I truly believe it's impossible for a peer to have refcnt 0 an=
d
> still being in the list:
> Either
> * delete on the peer was not yet called, thus peer is in the list and the
> last reference wasn't yet dropped
> * delete on the peer was called, thus peer cannot be in the list anymore =
and
> refcnt may or may not be 0...

Ok, thanks. Let's just keep this code.


> > > +/**
> > > + * ovpn_nexthop_from_rt6 - look up the IPv6 nexthop for the given de=
stination
> >=20
> > I'm a bit confused by this talk about "destination" when those two
> > functions are then used with the source address from the packet, from
> > a function called "get_by_src".
>=20
> well, in my brain a next hop can exists only when I want to reach a certa=
in
> destination. Therefore, at a low level, the terms nextop and destination
> always need to go hand in hand.
>=20
> This said, when implementing RPF (Reverse Path Filtering) I need to imagi=
ne
> that I want to route to the source IP of the incoming packet. If the next=
hop
> I looked up matches the peer the packet came from, then everything is fin=
e.
>=20
> makes sense?

Yeah, that's fair.

>=20
> [FTR I have already renamed/changed get_by_src into check_by_src, because=
 I
> don't need to truly extract a peer and get a reference, but I only need t=
o
> perform the aforementioned comparison.]

Ok.

> > > + * @ovpn: the private data representing the current VPN session
> > > + * @dst: the destination to be looked up
> > > + *
> > > + * Looks up in the IPv6 system routing table the IO of the nexthop t=
o be used
> >=20
> > "the IO"?
>=20
> typ0: "the IP"
>=20
> >=20
> > > + * to reach the destination passed as argument. IF no nexthop can be=
 found, the
> > > + * destination itself is returned as it probably has to be used as n=
exthop.
> > > + *
> > > + * Return: the IP of the next hop if found or the dst itself otherwi=
se
> >=20
> > "the dst" tends to refer to a dst_entry, maybe "or @dst otherwise"?
>=20
> it refers to @dst (the function argument). That's basically the case wher=
e
> the destination is "onlink" and thus it is the nexthop (basically the
> destination is the connected peer).

I understand that, it's just the wording "the dst" that I'm
nitpicking. s/dst/addr/ would help easily-confused people like me (for
both "the dst" and my confusion with source vs destination in
caller/callee), but I can live with this.

--=20
Sabrina


