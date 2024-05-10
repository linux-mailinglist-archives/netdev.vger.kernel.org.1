Return-Path: <netdev+bounces-95470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B848C2559
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0E31F22477
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7729612BF1E;
	Fri, 10 May 2024 13:02:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC43376
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346124; cv=none; b=F9OEP2FQkdAhP2sG64xLP2fMNARtKMaNs8Dx9+EB2B4DL/sLqcNM6ruXnQncwfKGLhy4X0F8S41JpDhTCQUpOKn7t74n0j+IE90ZGBwwwpFOW71VniqTtYbNZcaomIWyPxb35LTnw1+Aam0DNq08KcGURbf1T9smRCtUqN4AKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346124; c=relaxed/simple;
	bh=dJJK13wqYeLudKo2I1tbYUEwXhFeFilHIHtEgkte7NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nfc9EK60ltdGZ8ODHEu5YW5ghLe/bGbgq5auv7neE7PaKrNbwQJgXR/R6bBhdMeXKpWT3pftB1UrAEL+QNjkCNKuF05ZgoqRSa2mIKdmM/fittEWAUSmE+wndk+tCh9d/PQ//PBVeXP8qs7VJKNECILntVSCiBNeeuvTzAIJ4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-owx1hISkOYKlDMYR2PxTQw-1; Fri, 10 May 2024 09:01:53 -0400
X-MC-Unique: owx1hISkOYKlDMYR2PxTQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4C848029F5;
	Fri, 10 May 2024 13:01:51 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EB6E2044201;
	Fri, 10 May 2024 13:01:50 +0000 (UTC)
Date: Fri, 10 May 2024 15:01:49 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 09/24] ovpn: implement basic TX path (UDP)
Message-ID: <Zj4avXMEhJ_7OIAf@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-10-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-10-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 03:16:22 +0200, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index a420bb45f25f..36cfb95edbf4 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -28,6 +30,12 @@ int ovpn_struct_init(struct net_device *dev)
> =20
>  =09spin_lock_init(&ovpn->lock);
> =20
> +=09ovpn->crypto_wq =3D alloc_workqueue("ovpn-crypto-wq-%s",
> +=09=09=09=09=09  WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0,
> +=09=09=09=09=09  dev->name);
> +=09if (!ovpn->crypto_wq)
> +=09=09return -ENOMEM;
> +
>  =09ovpn->events_wq =3D alloc_workqueue("ovpn-events-wq-%s", WQ_MEM_RECLA=
IM,
>  =09=09=09=09=09  0, dev->name);
>  =09if (!ovpn->events_wq)
>  =09=09return -ENOMEM;

This will leak crypto_wq on failure. You need to roll back all
previous changes when something fails (also if you move all this stuff
into ndo_init).

> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index 659df320525c..f915afa260c3 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -22,9 +23,12 @@
>   * @id: unique identifier
>   * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
>   * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
> + * @encrypt_work: work used to process outgoing packets
> + * @decrypt_work: work used to process incoming packets

nit: Only encrypt_work is used in this patch, decrypt_work is for RX


> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index 4b7d96a13df0..f434da76dc0a 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> +/**
> + * ovpn_udp4_output - send IPv4 packet over udp socket
> + * @ovpn: the openvpn instance
> + * @bind: the binding related to the destination peer
> + * @cache: dst cache
> + * @sk: the socket to send the packet over
> + * @skb: the packet to send
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +static int ovpn_udp4_output(struct ovpn_struct *ovpn, struct ovpn_bind *=
bind,
> +=09=09=09    struct dst_cache *cache, struct sock *sk,
> +=09=09=09    struct sk_buff *skb)
> +{
> +=09struct rtable *rt;
> +=09struct flowi4 fl =3D {
> +=09=09.saddr =3D bind->local.ipv4.s_addr,
> +=09=09.daddr =3D bind->sa.in4.sin_addr.s_addr,
> +=09=09.fl4_sport =3D inet_sk(sk)->inet_sport,
> +=09=09.fl4_dport =3D bind->sa.in4.sin_port,
> +=09=09.flowi4_proto =3D sk->sk_protocol,
> +=09=09.flowi4_mark =3D sk->sk_mark,
> +=09};
> +=09int ret;
> +
> +=09local_bh_disable();
> +=09rt =3D dst_cache_get_ip4(cache, &fl.saddr);
> +=09if (rt)
> +=09=09goto transmit;
> +
> +=09if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr,
> +=09=09=09=09=09RT_SCOPE_HOST))) {
> +=09=09/* we may end up here when the cached address is not usable
> +=09=09 * anymore. In this case we reset address/cache and perform a
> +=09=09 * new look up

What exactly are you trying to guard against here? The ipv4 address
used for the last packet being removed from the device/host? I don't
see other tunnels using dst_cache doing this kind of thing (except
wireguard).

> +=09=09 */
> +=09=09fl.saddr =3D 0;
> +=09=09bind->local.ipv4.s_addr =3D 0;
> +=09=09dst_cache_reset(cache);
> +=09}
> +
> +=09rt =3D ip_route_output_flow(sock_net(sk), &fl, sk);
> +=09if (IS_ERR(rt) && PTR_ERR(rt) =3D=3D -EINVAL) {
> +=09=09fl.saddr =3D 0;
> +=09=09bind->local.ipv4.s_addr =3D 0;
> +=09=09dst_cache_reset(cache);
> +
> +=09=09rt =3D ip_route_output_flow(sock_net(sk), &fl, sk);

Why do you need to repeat the lookup? And why only for ipv4, but not
for ipv6?

> +=09}
> +
> +=09if (IS_ERR(rt)) {
> +=09=09ret =3D PTR_ERR(rt);
> +=09=09net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
> +=09=09=09=09    ovpn->dev->name, &bind->sa.in4, ret);
> +=09=09goto err;
> +=09}
> +=09dst_cache_set_ip4(cache, &rt->dst, fl.saddr);

Overall this looks a whole lot like udp_tunnel_dst_lookup, except for:
 - 2nd lookup
 - inet_confirm_addr/dst_cache_reset

(and there's udp_tunnel6_dst_lookup for ipv6)

--=20
Sabrina


