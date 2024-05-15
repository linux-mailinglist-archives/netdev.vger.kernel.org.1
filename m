Return-Path: <netdev+bounces-96590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7728C690E
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7771C2100A
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ACC155730;
	Wed, 15 May 2024 14:56:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F25C8EF
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784965; cv=none; b=HvCZc2p7a4q1WJPT4RvrNLxIGn9GN/4M47c3sqE0nI2LyGhGr4wx4mFlbq/sMSj8CXlnjSKJWbKE9L5VijNOtncPN1Ccy+4qtjY3RF7/pywcEp8CAzmYgjD3cT68ajR4Ea2ew9oVSEC6S6hfrh/Od7y2TEqlQNcU4pDuIBrAXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784965; c=relaxed/simple;
	bh=DFMKzg8vdG22kegRKB3JF5okMkshbZ52JRDhPdf289M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u488bnvK+mk78XWYZcywp1YwhXjjmooaUbZlVSBRsBS2+JNG1IODn1rKHC3drsVc1q2FGKLlzVFJGkb+EXvhhQwGJBDIAWQ25aHtXuM3z74STA59+T5srQKgnLTG/93K9hsngwzEy1+He0sfaIsQwv+rX1lABPgsWXJtSSNzHXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-2JX7tYKdMoKGhuQx3yS0Ag-1; Wed,
 15 May 2024 10:55:52 -0400
X-MC-Unique: 2JX7tYKdMoKGhuQx3yS0Ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8727E29AC00B;
	Wed, 15 May 2024 14:55:51 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 537C540C6CB6;
	Wed, 15 May 2024 14:55:50 +0000 (UTC)
Date: Wed, 15 May 2024 16:55:49 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 13/24] ovpn: implement TCP transport
Message-ID: <ZkTM9b8oU8Rw31Qp@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-14-antonio@openvpn.net>
 <ZkIosadLULByXFKc@hog>
 <73433bdf-763b-4023-8cb9-ffd9487744e0@openvpn.net>
 <ZkMnpy3_T8YO3eHD@hog>
 <2ddf759d-378f-475c-8fc1-30c6e83c2d14@openvpn.net>
 <ZkSMPeSSS4VZxHrf@hog>
 <6de315a7-8ef1-4b5d-8adc-fcfae26f6f88@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6de315a7-8ef1-4b5d-8adc-fcfae26f6f88@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-15, 14:54:49 +0200, Antonio Quartulli wrote:
> On 15/05/2024 12:19, Sabrina Dubroca wrote:
> > 2024-05-15, 00:11:28 +0200, Antonio Quartulli wrote:
> > > On 14/05/2024 10:58, Sabrina Dubroca wrote:
> > > > > > The UDP code differentiates "socket already owned by this inter=
face"
> > > > > > from "already taken by other user". That doesn't apply to TCP?
> > > > >=20
> > > > > This makes me wonder: how safe it is to interpret the user data a=
s an object
> > > > > of type ovpn_socket?
> > > > >=20
> > > > > When we find the user data already assigned, we don't know what w=
as really
> > > > > stored in there, right?
> > > > > Technically this socket could have gone through another module wh=
ich
> > > > > assigned its own state.
> > > > >=20
> > > > > Therefore I think that what UDP does [ dereferencing ((struct ovp=
n_socket
> > > > > *)user_data)->ovpn ] is probably not safe. Would you agree?
> > > >=20
> > > > Hmmm, yeah, I think you're right. If you checked encap_type =3D=3D
> > > > UDP_ENCAP_OVPNINUDP before (sk_prot for TCP), then you'd know it's
> > > > really your data. Basically call ovpn_from_udp_sock during attach i=
f
> > > > you want to check something beyond EBUSY.
> > >=20
> > > right. Maybe we can leave with simply reporting EBUSY and be done wit=
h it,
> > > without adding extra checks and what not.
> >=20
> > I don't know. What was the reason for the EALREADY handling in udp.c
> > and the corresponding refcount increase in ovpn_socket_new?
>=20
> it's just me that likes to be verbose when doing error reporting.

With the "already owned by this interface" message? Sure, I get that.

> But eventually the exact error is ignored and we release the reference. F=
rom
> netlink.c:
>=20
> 342                 peer->sock =3D ovpn_socket_new(sock, peer);
> 343                 if (IS_ERR(peer->sock)) {
> 344                         sockfd_put(sock);
> 345                         peer->sock =3D NULL;
> 346                         ret =3D -ENOTSOCK;
>=20
> so no added value in distinguishing the two cases.

But ovpn_socket_new currently turns EALREADY into a valid result, so
we won't go through the error hanadling here. That's the part I'm
unclear about.

--=20
Sabrina


