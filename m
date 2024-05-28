Return-Path: <netdev+bounces-98649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3AE8D1F22
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D005B2242B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EAA17085E;
	Tue, 28 May 2024 14:44:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34616F902
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907479; cv=none; b=D28crbMpqIp6ty5G9aNZdF4Trezz/rN3juK5tzwfL2/xug5U6dV4dvq9NGfm3oj6jQv8KMMKBGFdU18ZQ+++uWYsrgVUPwnuki5CJT/7N79acQEr9bWD39VPvvBnCSH5NkQBC55tMwu/7FFuX/WTej7l3Y5u1vsErs+agOKXigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907479; c=relaxed/simple;
	bh=KI3QvaFOUEjACZ0yaQFu9Bx2+Kk2Kk9w1tycHCCbkb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BKmozfkWn7XkrFZG7wXely9RvR/xe+9DqmPBx6mgFd1wrMZXCb08aUS6v6TCUaaTPtFG2IICCMXaavlh7ej0yzK0qP5M6qmrYkVj0D+0R04PZajuCMDEfer1sJckJWRy8du2KPG08fJNx/3NAeb0eBEKH5E4Y9oqdy9y8fe2tFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-yJVetVuONH26v4gi1RbL8w-1; Tue,
 28 May 2024 10:44:31 -0400
X-MC-Unique: yJVetVuONH26v4gi1RbL8w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1BC729AA39D;
	Tue, 28 May 2024 14:44:28 +0000 (UTC)
Received: from hog (unknown [10.39.192.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 887B540005B;
	Tue, 28 May 2024 14:44:27 +0000 (UTC)
Date: Tue, 28 May 2024 16:44:26 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 14/24] ovpn: implement multi-peer support
Message-ID: <ZlXtyn2Sgk_W8h92@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-15-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-15-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Antonio, I took a little break but I'm looking at your patches
again now.

2024-05-06, 03:16:27 +0200, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.=
h
> index 7414c2459fb9..58166fdeac63 100644
> --- a/drivers/net/ovpn/ovpnstruct.h
> +++ b/drivers/net/ovpn/ovpnstruct.h
> @@ -31,6 +35,12 @@ struct ovpn_struct {
>  =09spinlock_t lock; /* protect writing to the ovpn_struct object */
>  =09struct workqueue_struct *crypto_wq;
>  =09struct workqueue_struct *events_wq;
> +=09struct {
> +=09=09DECLARE_HASHTABLE(by_id, 12);
> +=09=09DECLARE_HASHTABLE(by_transp_addr, 12);
> +=09=09DECLARE_HASHTABLE(by_vpn_addr, 12);

Those are really big. I guess for large servers they make sense, but
you're making clients hold 98kB in memory that they're not going to use.

Maybe they could be dynamically sized, but I think struct peers should
be allocated on demand (only for mode =3D=3D MP) if you want this size.

> +=09=09spinlock_t lock; /* protects writes to peers tables */
> +=09} peers;
>  =09struct ovpn_peer __rcu *peer;
>  =09struct list_head dev_list;
>  };
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index 99a2ae42a332..38a89595dade 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -361,6 +362,91 @@ struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_s=
truct *ovpn,
>  =09return peer;
>  }
> =20
> +/**
> + * ovpn_peer_add_mp - add per to related tables in a MP instance
                             ^
                             s/per/peer/

> + * @ovpn: the instance to add the peer to
> + * @peer: the peer to add
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *=
peer)
> +{
[...]
> +=09index =3D ovpn_peer_index(ovpn->peers.by_id, &peer->id, sizeof(peer->=
id));
> +=09hlist_add_head_rcu(&peer->hash_entry_id, &ovpn->peers.by_id[index]);
> +
> +=09if (peer->vpn_addrs.ipv4.s_addr !=3D htonl(INADDR_ANY)) {
> +=09=09index =3D ovpn_peer_index(ovpn->peers.by_vpn_addr,
> +=09=09=09=09=09&peer->vpn_addrs.ipv4,
> +=09=09=09=09=09sizeof(peer->vpn_addrs.ipv4));
> +=09=09hlist_add_head_rcu(&peer->hash_entry_addr4,
> +=09=09=09=09   &ovpn->peers.by_vpn_addr[index]);
> +=09}
> +
> +=09hlist_del_init_rcu(&peer->hash_entry_addr6);

Why are hash_entry_transp_addr and hash_entry_addr6 getting a
hlist_del_init_rcu() call, but not hash_entry_id and hash_entry_addr4?

> +=09if (memcmp(&peer->vpn_addrs.ipv6, &in6addr_any,
> +=09=09   sizeof(peer->vpn_addrs.ipv6))) {

!ipv6_addr_any(&peer->vpn_addrs.ipv6)

> +=09=09index =3D ovpn_peer_index(ovpn->peers.by_vpn_addr,
> +=09=09=09=09=09&peer->vpn_addrs.ipv6,
> +=09=09=09=09=09sizeof(peer->vpn_addrs.ipv6));
> +=09=09hlist_add_head_rcu(&peer->hash_entry_addr6,
> +=09=09=09=09   &ovpn->peers.by_vpn_addr[index]);
> +=09}
> +

--=20
Sabrina


