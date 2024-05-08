Return-Path: <netdev+bounces-94675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD97E8C02AC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886B92827D4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF33A14A8C;
	Wed,  8 May 2024 17:11:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8881CA94
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188269; cv=none; b=nX6WDrRKlAT9Wub5ebIt/hfgJxa4I80FH0WU9Y6ZF4THiU1EXrWMioIhO4YKsSkttRtmsSIW3cmNip2oyw9Iqrqa4eAgleuBR0vNQspufszjNRfWaiEMVJ7f9RU1we8AZb5KiZlIMEeWB/a7HSErKx19vdmirxhLpZ7yMu8AXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188269; c=relaxed/simple;
	bh=E0FiSFliG8Bji2GDUslydM4/J8NGsMJGoeMJmTCNhb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i+n8Kk7Z3k59FLpaC0th6h06/vexJzdeOEReDo+3pPnEbpyaDvcTjtsqALNy2yDLt+IkHjx0WzNcPeNinKhTs6M3uPHcZ4wMff1jA89k/dyzfn+sVMmFBD3P1F4NYrj7tDGNJfbmbDnfWzR5D5qD18H4sBqClPXdK+pLP3P02Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-jXVq_McfOAW9h6O9n1-3kg-1; Wed, 08 May 2024 13:10:59 -0400
X-MC-Unique: jXVq_McfOAW9h6O9n1-3kg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FCA5101A551;
	Wed,  8 May 2024 17:10:58 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FC3A3C25;
	Wed,  8 May 2024 17:10:57 +0000 (UTC)
Date: Wed, 8 May 2024 19:10:56 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 08/24] ovpn: introduce the ovpn_socket object
Message-ID: <ZjuyIOK6BY3r9YCI@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-9-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-9-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 03:16:21 +0200, Antonio Quartulli wrote:
> This specific structure is used in the ovpn kernel module
> to wrap and carry around a standard kernel socket.
>=20
> ovpn takes ownership of passed sockets and therefore an ovpn
> specific objects is attathced to them for status tracking

typos:      object    attached


> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> new file mode 100644
> index 000000000000..a4a4d69162f0
> --- /dev/null
> +++ b/drivers/net/ovpn/socket.c
[...]
> +
> +/* Finalize release of socket, called after RCU grace period */

kref_put seems to call ovpn_socket_release_kref without waiting, and
then that calls ovpn_socket_detach immediately as well. Am I missing
something?

> +static void ovpn_socket_detach(struct socket *sock)
> +{
> +=09if (!sock)
> +=09=09return;
> +
> +=09sockfd_put(sock);
> +}

[...]
> +
> +/* Finalize release of socket, called after RCU grace period */

Did that comment get misplaced? It doesn't match the code.

> +static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *pee=
r)
> +{
> +=09int ret =3D -EOPNOTSUPP;
> +
> +=09if (!sock || !peer)
> +=09=09return -EINVAL;
> +
> +=09if (sock->sk->sk_protocol =3D=3D IPPROTO_UDP)
> +=09=09ret =3D ovpn_udp_socket_attach(sock, peer->ovpn);
> +
> +=09return ret;
> +}

> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> new file mode 100644
> index 000000000000..4b7d96a13df0
> --- /dev/null
> +++ b/drivers/net/ovpn/udp.c
[...]
> +
> +int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn=
)
> +{
> +=09struct ovpn_socket *old_data;
> +
> +=09/* sanity check */
> +=09if (sock->sk->sk_protocol !=3D IPPROTO_UDP) {
> +=09=09netdev_err(ovpn->dev, "%s: expected UDP socket\n", __func__);

Maybe use DEBUG_NET_WARN_ON_ONCE here since it's never expected to
actually happen? That would help track down (in test/debug setups) how
we ended up here.

> +=09=09return -EINVAL;
> +=09}
> +
> +=09/* make sure no pre-existing encapsulation handler exists */
> +=09rcu_read_lock();
> +=09old_data =3D rcu_dereference_sk_user_data(sock->sk);
> +=09rcu_read_unlock();
> +=09if (old_data) {
> +=09=09if (old_data->ovpn =3D=3D ovpn) {

You should stay under rcu_read_unlock if you access old_data's fields.

> +=09=09=09netdev_dbg(ovpn->dev,
> +=09=09=09=09   "%s: provided socket already owned by this interface\n",
> +=09=09=09=09   __func__);
> +=09=09=09return -EALREADY;
> +=09=09}
> +
> +=09=09netdev_err(ovpn->dev, "%s: provided socket already taken by other =
user\n",
> +=09=09=09   __func__);
> +=09=09return -EBUSY;
> +=09}
> +
> +=09return 0;
> +}

--=20
Sabrina


