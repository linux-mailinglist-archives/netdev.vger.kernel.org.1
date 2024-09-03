Return-Path: <netdev+bounces-124582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D8996A0E4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3C8B25442
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E9E13CFB7;
	Tue,  3 Sep 2024 14:41:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1701CA69B
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374469; cv=none; b=RK8zMsUukg41hdkhqH6TuVURIItmj3N8/rv2MoCQmS2aSNFHPre8xfIBzHL8FtiW1r1BGsUj9eogAex72e5UCCKPhANOLZRpHvx4tP6OlLGx447iKdVv6i9URRWh0sphF6u6KzCYxy5y8XCtk1lvz5mD9jigxxYGsWoWZWe9XVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374469; c=relaxed/simple;
	bh=+N8hbF82W5QTh9lVUNwvyWWlB744ujW5pME7E9y0Xr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ax/W3XwBmfM2uGW77onvvQ8s7QsiRBrqN9l7lReePdHo4Z5htkglJr5ZGlkke7k1xNtYweRTc8acXrxAx0W/HiypBERArBNY6qKYJ1oJHZ3IrHATEcHsf2JrfDyq3tQolGnSYp/Ypv/WlpNZplQMtGuCtbWh05Y+5DGwL120yAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-3IpdjyXQMKGdRWhQuItClg-1; Tue,
 03 Sep 2024 10:40:58 -0400
X-MC-Unique: 3IpdjyXQMKGdRWhQuItClg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DF8B1955D4B;
	Tue,  3 Sep 2024 14:40:56 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A205D19560A3;
	Tue,  3 Sep 2024 14:40:53 +0000 (UTC)
Date: Tue, 3 Sep 2024 16:40:51 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v6 15/25] ovpn: implement multi-peer support
Message-ID: <Ztcf88I1epYlIYGS@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-16-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240827120805.13681-16-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-27, 14:07:55 +0200, Antonio Quartulli wrote:
>  static int ovpn_net_init(struct net_device *dev)
>  {
>  =09struct ovpn_struct *ovpn =3D netdev_priv(dev);
> +=09int i, err =3D gro_cells_init(&ovpn->gro_cells, dev);

I'm not a fan of "hiding" the gro_cells_init call up here. I'd prefer
if this was done just before the corresponding "if (err)".

> +=09struct in_device *dev_v4;
> =20
> -=09return gro_cells_init(&ovpn->gro_cells, dev);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (ovpn->mode =3D=3D OVPN_MODE_MP) {
> +=09=09dev_v4 =3D __in_dev_get_rtnl(dev);
> +=09=09if (dev_v4) {
> +=09=09=09/* disable redirects as Linux gets confused by ovpn
> +=09=09=09 * handling same-LAN routing.
> +=09=09=09 * This happens because a multipeer interface is used as
> +=09=09=09 * relay point between hosts in the same subnet, while
> +=09=09=09 * in a classic LAN this would not be needed because the
> +=09=09=09 * two hosts would be able to talk directly.
> +=09=09=09 */
> +=09=09=09IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
> +=09=09=09IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) =3D false;
> +=09=09}
> +
> +=09=09/* the peer container is fairly large, therefore we dynamically
> +=09=09 * allocate it only when needed
> +=09=09 */
> +=09=09ovpn->peers =3D kzalloc(sizeof(*ovpn->peers), GFP_KERNEL);
> +=09=09if (!ovpn->peers)

missing gro_cells_destroy

> +=09=09=09return -ENOMEM;
> +
> +=09=09spin_lock_init(&ovpn->peers->lock_by_id);
> +=09=09spin_lock_init(&ovpn->peers->lock_by_vpn_addr);
> +=09=09spin_lock_init(&ovpn->peers->lock_by_transp_addr);

What's the benefit of having 3 separate locks instead of a single lock
protecting all the hashtables?

> +
> +=09=09for (i =3D 0; i < ARRAY_SIZE(ovpn->peers->by_id); i++) {
> +=09=09=09INIT_HLIST_HEAD(&ovpn->peers->by_id[i]);
> +=09=09=09INIT_HLIST_HEAD(&ovpn->peers->by_vpn_addr[i]);
> +=09=09=09INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_transp_addr[i],
> +=09=09=09=09=09      i);
> +=09=09}
> +=09}
> +
> +=09return 0;
>  }

> +static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *=
peer)
> +{
> +=09struct sockaddr_storage sa =3D { 0 };
> +=09struct hlist_nulls_head *nhead;
> +=09struct sockaddr_in6 *sa6;
> +=09struct sockaddr_in *sa4;
> +=09struct hlist_head *head;
> +=09struct ovpn_bind *bind;
> +=09struct ovpn_peer *tmp;
> +=09size_t salen;
> +
> +=09spin_lock_bh(&ovpn->peers->lock_by_id);
> +=09/* do not add duplicates */
> +=09tmp =3D ovpn_peer_get_by_id(ovpn, peer->id);
> +=09if (tmp) {
> +=09=09ovpn_peer_put(tmp);
> +=09=09spin_unlock_bh(&ovpn->peers->lock_by_id);
> +=09=09return -EEXIST;
> +=09}
> +
> +=09hlist_add_head_rcu(&peer->hash_entry_id,
> +=09=09=09   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
> +=09=09=09=09=09      sizeof(peer->id)));
> +=09spin_unlock_bh(&ovpn->peers->lock_by_id);
> +
> +=09bind =3D rcu_dereference_protected(peer->bind, true);
> +=09/* peers connected via TCP have bind =3D=3D NULL */
> +=09if (bind) {
> +=09=09switch (bind->remote.in4.sin_family) {
> +=09=09case AF_INET:
> +=09=09=09sa4 =3D (struct sockaddr_in *)&sa;
> +
> +=09=09=09sa4->sin_family =3D AF_INET;
> +=09=09=09sa4->sin_addr.s_addr =3D bind->remote.in4.sin_addr.s_addr;
> +=09=09=09sa4->sin_port =3D bind->remote.in4.sin_port;
> +=09=09=09salen =3D sizeof(*sa4);
> +=09=09=09break;
> +=09=09case AF_INET6:
> +=09=09=09sa6 =3D (struct sockaddr_in6 *)&sa;
> +
> +=09=09=09sa6->sin6_family =3D AF_INET6;
> +=09=09=09sa6->sin6_addr =3D bind->remote.in6.sin6_addr;
> +=09=09=09sa6->sin6_port =3D bind->remote.in6.sin6_port;
> +=09=09=09salen =3D sizeof(*sa6);
> +=09=09=09break;
> +=09=09default:

And remove from the by_id hashtable? Or is that handled somewhere that
I missed (I don't think ovpn_peer_unhash gets called in that case)?

> +=09=09=09return -EPROTONOSUPPORT;
> +=09=09}
> +

--=20
Sabrina


