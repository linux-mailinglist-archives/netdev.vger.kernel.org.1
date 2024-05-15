Return-Path: <netdev+bounces-96638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 122658C6D4F
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 22:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F741F2277B
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C8113FD85;
	Wed, 15 May 2024 20:35:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316792E851
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805328; cv=none; b=KvIiPCGBFGD66PmNOwhwu3KTgs9tR9OnvUMrrYuGEDDDoRo4eFI9kAmQ+6HsR821Ox5EUI2e6RVDJs++jn//TazrTzvi89FUODMp30bJGxo7pvt8yHNV+6Rm5DVtPxC/eFQQDYzMcnpn/burumUGg7TMt7g53caRTm4EPloriEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805328; c=relaxed/simple;
	bh=ypsoGZ6HpWBm99Zp40HoXW6TWH5wt5S/x/kA1DwyRhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sL8ds1CKA3DcfXt7S+YUqb75p/b9R2ztdamf4LonvkplknTty8ZlzDNMUN4p4tfNU4ZdxfqeEb0WbuzsZpta1CmRAT2t2T0vjsE5G/K4NeYxdvhP736OncnAaK7/rckdNM3a4GEFDWzic5UkNaGZj98NaRZVir19U/gcrmXHXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-oS4laTtMPteFKc2CJ7cQKQ-1; Wed,
 15 May 2024 16:35:20 -0400
X-MC-Unique: oS4laTtMPteFKc2CJ7cQKQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FD441C4C380;
	Wed, 15 May 2024 20:35:20 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DBED2401405;
	Wed, 15 May 2024 20:35:18 +0000 (UTC)
Date: Wed, 15 May 2024 22:35:17 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 13/24] ovpn: implement TCP transport
Message-ID: <ZkUchRbw3APzvlpe@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-14-antonio@openvpn.net>
 <ZkIosadLULByXFKc@hog>
 <73433bdf-763b-4023-8cb9-ffd9487744e0@openvpn.net>
 <ZkMnpy3_T8YO3eHD@hog>
 <2ddf759d-378f-475c-8fc1-30c6e83c2d14@openvpn.net>
 <ZkSMPeSSS4VZxHrf@hog>
 <6de315a7-8ef1-4b5d-8adc-fcfae26f6f88@openvpn.net>
 <ZkTM9b8oU8Rw31Qp@hog>
 <7a3909c1-818d-4701-b3b3-012976db7a34@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7a3909c1-818d-4701-b3b3-012976db7a34@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-15, 21:44:44 +0200, Antonio Quartulli wrote:
> On 15/05/2024 16:55, Sabrina Dubroca wrote:
> > 2024-05-15, 14:54:49 +0200, Antonio Quartulli wrote:
> > > On 15/05/2024 12:19, Sabrina Dubroca wrote:
> > > > 2024-05-15, 00:11:28 +0200, Antonio Quartulli wrote:
> > > > > On 14/05/2024 10:58, Sabrina Dubroca wrote:
> > > > > > > > The UDP code differentiates "socket already owned by this i=
nterface"
> > > > > > > > from "already taken by other user". That doesn't apply to T=
CP?
> > > > > > >=20
> > > > > > > This makes me wonder: how safe it is to interpret the user da=
ta as an object
> > > > > > > of type ovpn_socket?
> > > > > > >=20
> > > > > > > When we find the user data already assigned, we don't know wh=
at was really
> > > > > > > stored in there, right?
> > > > > > > Technically this socket could have gone through another modul=
e which
> > > > > > > assigned its own state.
> > > > > > >=20
> > > > > > > Therefore I think that what UDP does [ dereferencing ((struct=
 ovpn_socket
> > > > > > > *)user_data)->ovpn ] is probably not safe. Would you agree?
> > > > > >=20
> > > > > > Hmmm, yeah, I think you're right. If you checked encap_type =3D=
=3D
> > > > > > UDP_ENCAP_OVPNINUDP before (sk_prot for TCP), then you'd know i=
t's
> > > > > > really your data. Basically call ovpn_from_udp_sock during atta=
ch if
> > > > > > you want to check something beyond EBUSY.
> > > > >=20
> > > > > right. Maybe we can leave with simply reporting EBUSY and be done=
 with it,
> > > > > without adding extra checks and what not.
> > > >=20
> > > > I don't know. What was the reason for the EALREADY handling in udp.=
c
> > > > and the corresponding refcount increase in ovpn_socket_new?
> > >=20
> > > it's just me that likes to be verbose when doing error reporting.
> >=20
> > With the "already owned by this interface" message? Sure, I get that.
> >=20
> > > But eventually the exact error is ignored and we release the referenc=
e. From
> > > netlink.c:
> > >=20
> > > 342                 peer->sock =3D ovpn_socket_new(sock, peer);
> > > 343                 if (IS_ERR(peer->sock)) {
> > > 344                         sockfd_put(sock);
> > > 345                         peer->sock =3D NULL;
> > > 346                         ret =3D -ENOTSOCK;
> > >=20
> > > so no added value in distinguishing the two cases.
> >=20
> > But ovpn_socket_new currently turns EALREADY into a valid result, so
> > we won't go through the error hanadling here. That's the part I'm
> > unclear about.
>=20
> you're right. I had forgotten a little but important detail.
>=20
> With UDP OpenVPN creates one socket and uses it for all peers.
> With TCP we forcefully need one socket per client.
>=20
> Consequently, when a UDP socket is found to be used by our own instance, =
 we
> can happily increase the refcounter and use it as if it was free (we are
> just attaching it to yet another peer).
>=20
> In TCP this is not possible, so the socket must be unused, otherwise we
> can't attach it.
>=20
> I hope it makes sense.

Yes, thanks. This behavior should be documented (for example, by
putting exactly what you just wrote in a comment above
ovpn_socket_new).

So for TCP you just need the existing check and EBUSY return. For UDP,
you need the EALREADY check, but with an extra encap_type test before
looking at the contents of the sk_user_data.

--=20
Sabrina


