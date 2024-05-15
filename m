Return-Path: <netdev+bounces-96523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D208C64E9
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A88D1C23435
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6986B5CDF2;
	Wed, 15 May 2024 10:20:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E85FB8B
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715768403; cv=none; b=OxMd2tL7MgygmY2TYDyWzgmbnJ+lBGTQbgmjnPykXABHyaFLZqhH34lIkcZs+Tq7Vwv9z4izSrS+QkjNFKMeuMJQDwD3+I7TcKy1JoMGtdNZuUkjPiTgOqey6yoeTcXYxBgdhBkyssjPsw+LB+zG1KR5yLjaJvGK7Xbgx0OSOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715768403; c=relaxed/simple;
	bh=bZaAouL6m20iRsGJzAAx8tWwH2MJjIaZojEmDYcJEbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OnW/39NRvd+MRQDcdienIkejVj9eQVo3K907UlZ/Y3pyVbvGw6ZZhZF3cx4Zb/fHBktCnGVpNL+4262AyTEnGvuMD2CWBRY3jbG8FOSt5it/11xdmXobSq323jKyODKca+lLwxj5NhlnD1WttWyi6yrqkN4EOAizVcOOdOBGdPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-tCmo3yy5M3q_6Aeiy1DYtA-1; Wed,
 15 May 2024 06:19:44 -0400
X-MC-Unique: tCmo3yy5M3q_6Aeiy1DYtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B9DD1C0512F;
	Wed, 15 May 2024 10:19:44 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AF6443C27;
	Wed, 15 May 2024 10:19:42 +0000 (UTC)
Date: Wed, 15 May 2024 12:19:41 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 13/24] ovpn: implement TCP transport
Message-ID: <ZkSMPeSSS4VZxHrf@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-14-antonio@openvpn.net>
 <ZkIosadLULByXFKc@hog>
 <73433bdf-763b-4023-8cb9-ffd9487744e0@openvpn.net>
 <ZkMnpy3_T8YO3eHD@hog>
 <2ddf759d-378f-475c-8fc1-30c6e83c2d14@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2ddf759d-378f-475c-8fc1-30c6e83c2d14@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-15, 00:11:28 +0200, Antonio Quartulli wrote:
> On 14/05/2024 10:58, Sabrina Dubroca wrote:
> > > > The UDP code differentiates "socket already owned by this interface=
"
> > > > from "already taken by other user". That doesn't apply to TCP?
> > >=20
> > > This makes me wonder: how safe it is to interpret the user data as an=
 object
> > > of type ovpn_socket?
> > >=20
> > > When we find the user data already assigned, we don't know what was r=
eally
> > > stored in there, right?
> > > Technically this socket could have gone through another module which
> > > assigned its own state.
> > >=20
> > > Therefore I think that what UDP does [ dereferencing ((struct ovpn_so=
cket
> > > *)user_data)->ovpn ] is probably not safe. Would you agree?
> >=20
> > Hmmm, yeah, I think you're right. If you checked encap_type =3D=3D
> > UDP_ENCAP_OVPNINUDP before (sk_prot for TCP), then you'd know it's
> > really your data. Basically call ovpn_from_udp_sock during attach if
> > you want to check something beyond EBUSY.
>=20
> right. Maybe we can leave with simply reporting EBUSY and be done with it=
,
> without adding extra checks and what not.

I don't know. What was the reason for the EALREADY handling in udp.c
and the corresponding refcount increase in ovpn_socket_new?


> > > > > +int __init ovpn_tcp_init(void)
> > > > > +{
> > > > > +=09/* We need to substitute the recvmsg and the sock_is_readable
> > > > > +=09 * callbacks in the sk_prot member of the sock object for TCP
> > > > > +=09 * sockets.
> > > > > +=09 *
> > > > > +=09 * However sock->sk_prot is a pointer to a static variable an=
d
> > > > > +=09 * therefore we can't directly modify it, otherwise every soc=
ket
> > > > > +=09 * pointing to it will be affected.
> > > > > +=09 *
> > > > > +=09 * For this reason we create our own static copy and modify w=
hat
> > > > > +=09 * we need. Then we make sk_prot point to this copy
> > > > > +=09 * (in ovpn_tcp_socket_attach())
> > > > > +=09 */
> > > > > +=09ovpn_tcp_prot =3D tcp_prot;
> > > >=20
> > > > Don't you need a separate variant for IPv6, like TLS does?
> > >=20
> > > Never did so far.
> > >=20
> > > My wild wild wild guess: for the time this socket is owned by ovpn, w=
e only
> > > use callbacks that are IPvX agnostic, hence v4 vs v6 doesn't make any
> > > difference.
> > > When this socket is released, we reassigned the original prot.
> >=20
> > That seems a bit suspicious to me. For example, tcpv6_prot has a
> > different backlog_rcv. And you don't control if the socket is detached
> > before being closed, or which callbacks are needed. Your userspace
> > client doesn't use them, but someone else's might.
> >=20
> > > > > +=09ovpn_tcp_prot.recvmsg =3D ovpn_tcp_recvmsg;
> > > >=20
> > > > You don't need to replace ->sendmsg as well? The userspace client i=
s
> > > > not expected to send messages?
> > >=20
> > > It is, but my assumption is that those packets will just go through t=
he
> > > socket as usual. No need to be handled by ovpn (those packets are not
> > > encrypted/decrypted, like data traffic is).
> > > And this is how it has worked so far.
> > >=20
> > > Makes sense?
> >=20
> > Two things come to mind:
> >=20
> > - userspace is expected to prefix the messages it inserts on the
> >    stream with the 2-byte length field? otherwise, the peer won't be
> >    able to parse them out of the stream
>=20
> correct. userspace sends those packets as if ovpn is not running, therefo=
re
> this happens naturally.

ok.


> > - I'm not convinced this would be safe wrt kernel writing partial
> >    messages. if ovpn_tcp_send_one doesn't send the full message, you
> >    could interleave two messages:
> >=20
> >    +------+-------------------+------+--------+----------------+
> >    | len1 | (bytes from msg1) | len2 | (msg2) | (rest of msg1) |
> >    +------+-------------------+------+--------+----------------+
> >=20
> >    and the RX side would parse that as:
> >=20
> >    +------+-----------------------------------+------+---------
> >    | len1 | (bytes from msg1) | len2 | (msg2) | ???? | ...
> >    +------+-------------------+---------------+------+---------
> >=20
> >    and try to interpret some random bytes out of either msg1 or msg2 as
> >    a length prefix, resulting in a broken stream.
>=20
> hm you are correct. if multiple sendmsg can overlap, then we might be in
> troubles, but are we sure this can truly happen?

What would prevent this? The kernel_sendmsg call in ovpn_tcp_send_one
could send a partial message, and then what would stop userspace from
sending its own message during the cond_resched from ovpn_tcp_tx_work?

> > The stream format looks identical to ESP in TCP [1] (2B length prefix
> > followed by the actual message), so I think the espintcp code (both tx
> > and rx, except for actual protocol parsing) should look very
> > similar. The problems that need to be solved for both protocols are
> > pretty much the same.
>=20
> ok, will have a look. maybe this will simplify the code even more and we
> will get rid of some of the issues we were discussing above.

I doubt dealing with possible interleaving will make the code simpler,
but I think it has to be done.

--=20
Sabrina


