Return-Path: <netdev+bounces-98698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828778D21D1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9C31C225D9
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5912172BA6;
	Tue, 28 May 2024 16:42:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140061FC5
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914547; cv=none; b=L3H0HMLxTGbuvhTAuibUHLiUCCiFudnZBJ4TXmPlHjIyUNImq2WFL9e1+HPB154F/8QzidinX+pXFLTZ8LJKU4bNCrK26TMH/gGz4flhzPIG+5vaJuWLdcNigReVd6TAKo12lRM54xnpJC4aGmZKn1XBqu8q3YiNVK4aGP7uDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914547; c=relaxed/simple;
	bh=r77EEZQHNk+zUic2RqBuNB6TM41RA9kTkcOsRrDZtss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g2UTpLIunvIStWA51XCcBci+7PNHfrMnYYW+soO0ABcXVqKkORteaTjUVhar0fckbSsjGd7xEgH5Oft56m1doYfI/ujafX5k1M8dI6s794m6hiZv0KraRlJCPTDSEJr5PzxIW93Cy2MhVDGdafNXjmpHZu7N1dPFKdYwvwSUjqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-ocEPECmUNj2NoymEZeie6Q-1; Tue,
 28 May 2024 12:42:19 -0400
X-MC-Unique: ocEPECmUNj2NoymEZeie6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7ECDC29AA382;
	Tue, 28 May 2024 16:42:18 +0000 (UTC)
Received: from hog (unknown [10.39.192.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 43A702026D68;
	Tue, 28 May 2024 16:42:17 +0000 (UTC)
Date: Tue, 28 May 2024 18:42:16 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 15/24] ovpn: implement peer lookup logic
Message-ID: <ZlYJaIvXY3nuNd98@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-16-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-16-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 03:16:28 +0200, Antonio Quartulli wrote:
> +static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
> +{
> +=09struct rt6_info *rt =3D (struct rt6_info *)skb_rtable(skb);

skb_rt6_info?

> +
> +=09if (!rt || !(rt->rt6i_flags & RTF_GATEWAY))
> +=09=09return ipv6_hdr(skb)->daddr;
> +
> +=09return rt->rt6i_gateway;
> +}
> +
> +/**
> + * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
> + * @head: list head to search
> + * @addr: VPN IPv4 to use as search key
> + *
> + * Return: the peer if found or NULL otherwise

The doc for all those ovpn_peer_get_* functions could indicate that on
success, a reference on the peer is held.


[...]
> +static struct ovpn_peer *ovpn_peer_get_by_vpn_addr6(struct hlist_head *h=
ead,
> +=09=09=09=09=09=09    struct in6_addr *addr)
> +{
> +=09struct ovpn_peer *tmp, *peer =3D NULL;
> +=09int i;
> +
> +=09rcu_read_lock();
> +=09hlist_for_each_entry_rcu(tmp, head, hash_entry_addr6) {
> +=09=09for (i =3D 0; i < 4; i++) {
> +=09=09=09if (addr->s6_addr32[i] !=3D
> +=09=09=09    tmp->vpn_addrs.ipv6.s6_addr32[i])
> +=09=09=09=09continue;
> +=09=09}

ipv6_addr_equal

[...]
> +=09default:
> +=09=09return NULL;
> +=09}
> +
> +=09index =3D ovpn_peer_index(ovpn->peers.by_transp_addr, &ss, sa_len);
> +=09head =3D &ovpn->peers.by_transp_addr[index];

Maybe worth adding a get_bucket helper (with a better name :)) instead
of ovpn_peer_index, since all uses of ovpn_peer_index are followed by
a "head =3D TBL[index]" (or direct use in some hlist iterator), but the
index itself is not used later on, only the bucket.

> +
> +=09rcu_read_lock();
> +=09hlist_for_each_entry_rcu(tmp, head, hash_entry_transp_addr) {
> +=09=09found =3D ovpn_peer_transp_match(tmp, &ss);
> +=09=09if (!found)

nit: call ovpn_peer_transp_match directly and drop the found variable

> +=09=09=09continue;
> +
> +=09=09if (!ovpn_peer_hold(tmp))
> +=09=09=09continue;
> +
> +=09=09peer =3D tmp;
> +=09=09break;
> +=09}
> +=09rcu_read_unlock();
> =20
>  =09return peer;
>  }
> @@ -303,10 +427,28 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2p(st=
ruct ovpn_struct *ovpn,
> =20
>  struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer=
_id)
>  {
> -=09struct ovpn_peer *peer =3D NULL;
> +=09struct ovpn_peer *tmp, *peer =3D NULL;
> +=09struct hlist_head *head;
> +=09u32 index;
> =20
>  =09if (ovpn->mode =3D=3D OVPN_MODE_P2P)
> -=09=09peer =3D ovpn_peer_get_by_id_p2p(ovpn, peer_id);
> +=09=09return ovpn_peer_get_by_id_p2p(ovpn, peer_id);
> +
> +=09index =3D ovpn_peer_index(ovpn->peers.by_id, &peer_id, sizeof(peer_id=
));
> +=09head =3D &ovpn->peers.by_id[index];
> +
> +=09rcu_read_lock();
> +=09hlist_for_each_entry_rcu(tmp, head, hash_entry_id) {
> +=09=09if (tmp->id !=3D peer_id)
> +=09=09=09continue;
> +
> +=09=09if (!ovpn_peer_hold(tmp))
> +=09=09=09continue;

Can there ever be multiple peers with the same id? (ie, is it worth
continuing the loop if this fails? the same question probably applies
to ovpn_peer_get_by_transp_addr as well)


> +=09=09peer =3D tmp;
> +=09=09break;
> +=09}
> +=09rcu_read_unlock();
> =20
>  =09return peer;
>  }
> @@ -328,6 +470,11 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_s=
truct *ovpn,
>  =09=09=09=09       struct sk_buff *skb)
>  {
>  =09struct ovpn_peer *tmp, *peer =3D NULL;
> +=09struct hlist_head *head;
> +=09sa_family_t sa_fam;
> +=09struct in6_addr addr6;
> +=09__be32 addr4;
> +=09u32 index;
> =20
>  =09/* in P2P mode, no matter the destination, packets are always sent to
>  =09 * the single peer listening on the other side
> @@ -338,15 +485,123 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn=
_struct *ovpn,
>  =09=09if (likely(tmp && ovpn_peer_hold(tmp)))
>  =09=09=09peer =3D tmp;
>  =09=09rcu_read_unlock();
> +=09=09return peer;
> +=09}
> +
> +=09sa_fam =3D skb_protocol_to_family(skb);
> +
> +=09switch (sa_fam) {
> +=09case AF_INET:
> +=09=09addr4 =3D ovpn_nexthop_from_skb4(skb);
> +=09=09index =3D ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr4,
> +=09=09=09=09=09sizeof(addr4));
> +=09=09head =3D &ovpn->peers.by_vpn_addr[index];
> +
> +=09=09peer =3D ovpn_peer_get_by_vpn_addr4(head, &addr4);
> +=09=09break;
> +=09case AF_INET6:
> +=09=09addr6 =3D ovpn_nexthop_from_skb6(skb);
> +=09=09index =3D ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr6,
> +=09=09=09=09=09sizeof(addr6));
> +=09=09head =3D &ovpn->peers.by_vpn_addr[index];
> +
> +=09=09peer =3D ovpn_peer_get_by_vpn_addr6(head, &addr6);

The index -> head -> peer code is identical in get_by_dst and
get_by_src, it could be stuffed into ovpn_peer_get_by_vpn_addr{4,6}.

> +=09=09break;
>  =09}
> =20
>  =09return peer;
>  }


[snip the _rt4 variant, comments apply to both]
> +/**
> + * ovpn_nexthop_from_rt6 - look up the IPv6 nexthop for the given destin=
ation

I'm a bit confused by this talk about "destination" when those two
functions are then used with the source address from the packet, from
a function called "get_by_src".

> + * @ovpn: the private data representing the current VPN session
> + * @dst: the destination to be looked up
> + *
> + * Looks up in the IPv6 system routing table the IO of the nexthop to be=
 used

"the IO"?

> + * to reach the destination passed as argument. IF no nexthop can be fou=
nd, the
> + * destination itself is returned as it probably has to be used as nexth=
op.
> + *
> + * Return: the IP of the next hop if found or the dst itself otherwise

"the dst" tends to refer to a dst_entry, maybe "or @dst otherwise"?
(though I'm not sure that's valid kdoc)

(also for ovpn_nexthop_from_rt4)

> + */
> +static struct in6_addr ovpn_nexthop_from_rt6(struct ovpn_struct *ovpn,
> +=09=09=09=09=09     struct in6_addr dst)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +=09struct dst_entry *entry;
> +=09struct rt6_info *rt;
> +=09struct flowi6 fl =3D {
> +=09=09.daddr =3D dst,
> +=09};
> +
> +=09entry =3D ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &=
fl,
> +=09=09=09=09=09=09NULL);
> +=09if (IS_ERR(entry)) {
> +=09=09net_dbg_ratelimited("%s: no route to host %pI6c\n", __func__,
> +=09=09=09=09    &dst);
> +=09=09/* if we end up here this packet is probably going to be
> +=09=09 * thrown away later
> +=09=09 */
> +=09=09return dst;
> +=09}
> +
> +=09rt =3D container_of(entry, struct rt6_info, dst);

dst_rt6_info(entry)

> +
> +=09if (!(rt->rt6i_flags & RTF_GATEWAY))
> +=09=09goto out;
> +
> +=09dst =3D rt->rt6i_gateway;
> +out:
> +=09dst_release((struct dst_entry *)rt);
> +#endif
> +=09return dst;
> +}
> +
>  struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_struct *ovpn,
>  =09=09=09=09       struct sk_buff *skb)
>  {
>  =09struct ovpn_peer *tmp, *peer =3D NULL;
> +=09struct hlist_head *head;
> +=09sa_family_t sa_fam;
> +=09struct in6_addr addr6;
> +=09__be32 addr4;
> +=09u32 index;
> =20
>  =09/* in P2P mode, no matter the destination, packets are always sent to
>  =09 * the single peer listening on the other side
> @@ -357,6 +612,28 @@ struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_s=
truct *ovpn,
>  =09=09if (likely(tmp && ovpn_peer_hold(tmp)))
>  =09=09=09peer =3D tmp;
>  =09=09rcu_read_unlock();
> +=09=09return peer;
> +=09}
> +
> +=09sa_fam =3D skb_protocol_to_family(skb);
> +
> +=09switch (sa_fam) {

nit:
=09switch (skb_protocol_to_family(skb))
seems a bit more readable to me (also in ovpn_peer_get_by_dst) - and
saves you from reverse xmas tree complaints (sa_fam should have been
after addr6)

> +=09case AF_INET:
> +=09=09addr4 =3D ovpn_nexthop_from_rt4(ovpn, ip_hdr(skb)->saddr);
> +=09=09index =3D ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr4,
> +=09=09=09=09=09sizeof(addr4));
> +=09=09head =3D &ovpn->peers.by_vpn_addr[index];
> +
> +=09=09peer =3D ovpn_peer_get_by_vpn_addr4(head, &addr4);
> +=09=09break;
> +=09case AF_INET6:
> +=09=09addr6 =3D ovpn_nexthop_from_rt6(ovpn, ipv6_hdr(skb)->saddr);
> +=09=09index =3D ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr6,
> +=09=09=09=09=09sizeof(addr6));
> +=09=09head =3D &ovpn->peers.by_vpn_addr[index];
> +
> +=09=09peer =3D ovpn_peer_get_by_vpn_addr6(head, &addr6);
> +=09=09break;
>  =09}
> =20
>  =09return peer;
> --=20
> 2.43.2
>=20
>=20

--=20
Sabrina


