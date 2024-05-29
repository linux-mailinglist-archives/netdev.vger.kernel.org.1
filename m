Return-Path: <netdev+bounces-99083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417EE8D3A83
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8441283BFE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727817F39F;
	Wed, 29 May 2024 15:17:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441A25740
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995841; cv=none; b=ASxv+TzEoo5PonWbGGfNux7xf4zy67ZZemFhfdHuncPaac2MYE1C6sp8t2BdmTP/fze3amJ2vnT/31k57ztcRED7XwteieBs65Ft7sWEHIU1QYV++Z6GyLqDDcR61GeWymWBRZgXaOXQLWuX0+FdbiSh+4x6rBSnB14nODyZdr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995841; c=relaxed/simple;
	bh=5Tot55mSfLVFDlcX/nm+bx2KdeGqnwdCXbP/Q2YluRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=b5gzICKlKTCB7bQAf/+t28/pro1UyxUpmKxjLEwXvwhsvfkTgiAvdhGcM7YuFwdnPmkRUKDp8ApLOt2T1bK9RuRSewUgdmm4rE+xbdFw+9OT1X0mBdlc3ioPWP3ueaiuTBn7xRZuPELiY9CGxkG1pr8S6cQ83GeqMIMcmDNV7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-1xImxtZUM8CMJ1wIzAibgg-1; Wed, 29 May 2024 11:16:55 -0400
X-MC-Unique: 1xImxtZUM8CMJ1wIzAibgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 685428058D1;
	Wed, 29 May 2024 15:16:54 +0000 (UTC)
Received: from hog (unknown [10.39.192.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D2AD3C27;
	Wed, 29 May 2024 15:16:52 +0000 (UTC)
Date: Wed, 29 May 2024 17:16:52 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 14/24] ovpn: implement multi-peer support
Message-ID: <ZldG5PNlvAkJ4fat@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-15-antonio@openvpn.net>
 <ZlXtyn2Sgk_W8h92@hog>
 <de937f69-b5ae-4d4f-b16a-e18fa70a8e7b@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <de937f69-b5ae-4d4f-b16a-e18fa70a8e7b@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-28, 21:41:15 +0200, Antonio Quartulli wrote:
> On 28/05/2024 16:44, Sabrina Dubroca wrote:
> > Hi Antonio, I took a little break but I'm looking at your patches
> > again now.
>=20
> Thanks Sabrina! Meanwhile I have been working on all your suggested chang=
es.
> Right now I am familiarizing with the strparser.

Cool :)

> > 2024-05-06, 03:16:27 +0200, Antonio Quartulli wrote:
> > > +=09index =3D ovpn_peer_index(ovpn->peers.by_id, &peer->id, sizeof(pe=
er->id));
> > > +=09hlist_add_head_rcu(&peer->hash_entry_id, &ovpn->peers.by_id[index=
]);
> > > +
> > > +=09if (peer->vpn_addrs.ipv4.s_addr !=3D htonl(INADDR_ANY)) {
> > > +=09=09index =3D ovpn_peer_index(ovpn->peers.by_vpn_addr,
> > > +=09=09=09=09=09&peer->vpn_addrs.ipv4,
> > > +=09=09=09=09=09sizeof(peer->vpn_addrs.ipv4));
> > > +=09=09hlist_add_head_rcu(&peer->hash_entry_addr4,
> > > +=09=09=09=09   &ovpn->peers.by_vpn_addr[index]);
> > > +=09}
> > > +
> > > +=09hlist_del_init_rcu(&peer->hash_entry_addr6);
> >=20
> > Why are hash_entry_transp_addr and hash_entry_addr6 getting a
> > hlist_del_init_rcu() call, but not hash_entry_id and hash_entry_addr4?
>=20
> I think not calling del_init_rcu on hash_entry_addr4 was a mistake.
>=20
> Calling del_init_rcu on addr4, addr6 and transp_addr is needed to put the=
m
> in a known state in case they are not hashed.

hlist_del_init_rcu does nothing if node is not already on a list.

> While hash_entry_id always goes through hlist_add_head_rcu, therefore
> del_init_rcu is useless (to my understanding).

I'm probably missing something about how this all fits together. In
patch 19, I see ovpn_nl_set_peer_doit can re-add a peer that is
already added (but I'm not sure why, since you don't allow changing
the addresses, so it won't actually be re-hashed).

I don't think doing a 2nd add of the same element to peers.by_id (or
any of the other hashtables) is correct, so I'd say you need
hlist_del_init_rcu for all of them.

--=20
Sabrina


