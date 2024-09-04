Return-Path: <netdev+bounces-124984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E896B7F0
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495F52829A1
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C81CC16B;
	Wed,  4 Sep 2024 10:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF77198825
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444632; cv=none; b=Dl0y4fhzZD6CJIePLtU4b1nA+56AaWkKdl/POT2zUk+mrEs5/S0oY5r7DEdBLZ7cXM4CLAPc0xIaPyQvHPJIknL1joAordNgqccVJjt2C7j53mCm5itfHHEcWZXzs/qADNS1fP5mfv2dHrUtqTb0+1yKlGWT2Ycucz7UJYROY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444632; c=relaxed/simple;
	bh=u9mZsVtqkdXLo107nQuoszBoSxTC0cFLnaoMWqENT24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XwR2TyiKRxowGCG+TXK2TVTqlVY9wbv+bxzFHtlqSElhGvs6bw2/c5HRyKOMXk46UWapbpvL8ofFJ1v5Qq9E1JU7d/g3Ie4NVAgfj3fx6Qd3zMPA6cglkMmQf9LHSiJeEFyo0u1TRxdhVyXHxiSkz+mO4CpUx+EvuROdpRJ0rjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-tRILbNW6Mdiw5EvOLlf65w-1; Wed,
 04 Sep 2024 06:10:18 -0400
X-MC-Unique: tRILbNW6Mdiw5EvOLlf65w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EACA19560AF;
	Wed,  4 Sep 2024 10:10:17 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1D8219560AB;
	Wed,  4 Sep 2024 10:10:13 +0000 (UTC)
Date: Wed, 4 Sep 2024 12:10:11 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v6 15/25] ovpn: implement multi-peer support
Message-ID: <ZtgyA744W7QkXXnX@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-16-antonio@openvpn.net>
 <Ztcf88I1epYlIYGS@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Ztcf88I1epYlIYGS@hog>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-09-03, 16:40:51 +0200, Sabrina Dubroca wrote:
> 2024-08-27, 14:07:55 +0200, Antonio Quartulli wrote:
> > +static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer=
 *peer)
> > +{
> > +=09struct sockaddr_storage sa =3D { 0 };
> > +=09struct hlist_nulls_head *nhead;
> > +=09struct sockaddr_in6 *sa6;
> > +=09struct sockaddr_in *sa4;
> > +=09struct hlist_head *head;
> > +=09struct ovpn_bind *bind;
> > +=09struct ovpn_peer *tmp;
> > +=09size_t salen;
> > +
> > +=09spin_lock_bh(&ovpn->peers->lock_by_id);
> > +=09/* do not add duplicates */
> > +=09tmp =3D ovpn_peer_get_by_id(ovpn, peer->id);
> > +=09if (tmp) {
> > +=09=09ovpn_peer_put(tmp);
> > +=09=09spin_unlock_bh(&ovpn->peers->lock_by_id);
> > +=09=09return -EEXIST;
> > +=09}
> > +
> > +=09hlist_add_head_rcu(&peer->hash_entry_id,
> > +=09=09=09   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
> > +=09=09=09=09=09      sizeof(peer->id)));
> > +=09spin_unlock_bh(&ovpn->peers->lock_by_id);
> > +
> > +=09bind =3D rcu_dereference_protected(peer->bind, true);

What protects us here? We just released lock_by_id and we're not
holding peer->lock.

> > +=09/* peers connected via TCP have bind =3D=3D NULL */
> > +=09if (bind) {
> > +=09=09switch (bind->remote.in4.sin_family) {
> > +=09=09case AF_INET:
> > +=09=09=09sa4 =3D (struct sockaddr_in *)&sa;
> > +
> > +=09=09=09sa4->sin_family =3D AF_INET;
> > +=09=09=09sa4->sin_addr.s_addr =3D bind->remote.in4.sin_addr.s_addr;
> > +=09=09=09sa4->sin_port =3D bind->remote.in4.sin_port;
> > +=09=09=09salen =3D sizeof(*sa4);
> > +=09=09=09break;
> > +=09=09case AF_INET6:
> > +=09=09=09sa6 =3D (struct sockaddr_in6 *)&sa;
> > +
> > +=09=09=09sa6->sin6_family =3D AF_INET6;
> > +=09=09=09sa6->sin6_addr =3D bind->remote.in6.sin6_addr;
> > +=09=09=09sa6->sin6_port =3D bind->remote.in6.sin6_port;
> > +=09=09=09salen =3D sizeof(*sa6);
> > +=09=09=09break;
> > +=09=09default:
>=20
> And remove from the by_id hashtable? Or is that handled somewhere that
> I missed (I don't think ovpn_peer_unhash gets called in that case)?

ovpn_nl_set_peer_doit does:

=09=09ret =3D ovpn_peer_add(ovpn, peer);
=09=09if (ret < 0) {
[...]
=09=09/* release right away because peer is not really used in any
=09=09 * context
=09=09 */
=09=09ovpn_peer_release(peer);
=09=09kfree(peer);


But if we fail at this stage, the peer was published in the by_id
hashtable and could be used.

Although AFAICT, ovpn can never create a bind with family !=3D
AF_INET{,6}, so this is not a real issue -- in that case I guess a
DEBUG_NET_WARN_ON_ONCE with a comment that this should never happen
would be acceptable (but I'd still remove the peer from by_id and go
through the proper release path instead of direct kfree in
ovpn_nl_set_peer_doit). Otherwise, you'd have to reorder things in
this function so that all failures are handled before the peer is
added to any hashtable.

> > +=09=09=09return -EPROTONOSUPPORT;
> > +=09=09}
> > +

--=20
Sabrina


