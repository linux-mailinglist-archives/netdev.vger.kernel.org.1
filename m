Return-Path: <netdev+bounces-99192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09138D3FCA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 22:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916491F22F97
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8680F16F29E;
	Wed, 29 May 2024 20:46:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8F3D97F
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015567; cv=none; b=kC3RFdYwSa1YFAMabpWM4OI5BNcWjaewtnUUVDuNNGx0rRheQlL9VS9hSvzE0GdheldU8ix4UibvTzxcHGAKawA8QHWtjle1f6QKKVKmcqoFYaiwhpIPhzEGiQGc+VgAwW7+FnDDz2sCWIxiZkExWpfaFUUkhiaQWZsOi8om5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015567; c=relaxed/simple;
	bh=M5sXVEwxFh4MT1g7z55ZKHKdvceLx+gsGFGXz/8GoLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=drVMlYM3EnhezSNOaQBc2a25ew1b1X7jBOfTj82StpQnxjqcPlMUqvYuvR0uGve4PF/SnZzUZW1Z7jZVy1XniuB2EJYK7UWCESaUXBPwB5Z5rijMLmAdHIiHDXlC0sQXGXaJ0lxEXbawuVmHk0oIkqp+KiPqOLhZKlcpoxdyU/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-jeZe-M8JM8WLMCs9IE5uBQ-1; Wed, 29 May 2024 16:45:55 -0400
X-MC-Unique: jeZe-M8JM8WLMCs9IE5uBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BA0F8058DF;
	Wed, 29 May 2024 20:45:54 +0000 (UTC)
Received: from hog (unknown [10.39.192.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ECDF3C15BB9;
	Wed, 29 May 2024 20:45:52 +0000 (UTC)
Date: Wed, 29 May 2024 22:45:51 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 14/24] ovpn: implement multi-peer support
Message-ID: <ZleT__qb4fI6_mV8@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-15-antonio@openvpn.net>
 <ZlXtyn2Sgk_W8h92@hog>
 <de937f69-b5ae-4d4f-b16a-e18fa70a8e7b@openvpn.net>
 <ZldG5PNlvAkJ4fat@hog>
 <8252647b-0301-4f14-bdc7-208e9779fc2f@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8252647b-0301-4f14-bdc7-208e9779fc2f@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-29, 22:15:27 +0200, Antonio Quartulli wrote:
> On 29/05/2024 17:16, Sabrina Dubroca wrote:
> > 2024-05-28, 21:41:15 +0200, Antonio Quartulli wrote:
> > > On 28/05/2024 16:44, Sabrina Dubroca wrote:
> > > > Hi Antonio, I took a little break but I'm looking at your patches
> > > > again now.
> > >=20
> > > Thanks Sabrina! Meanwhile I have been working on all your suggested c=
hanges.
> > > Right now I am familiarizing with the strparser.
> >=20
> > Cool :)
> >=20
> > > > 2024-05-06, 03:16:27 +0200, Antonio Quartulli wrote:
> > > > > +=09index =3D ovpn_peer_index(ovpn->peers.by_id, &peer->id, sizeo=
f(peer->id));
> > > > > +=09hlist_add_head_rcu(&peer->hash_entry_id, &ovpn->peers.by_id[i=
ndex]);
> > > > > +
> > > > > +=09if (peer->vpn_addrs.ipv4.s_addr !=3D htonl(INADDR_ANY)) {
> > > > > +=09=09index =3D ovpn_peer_index(ovpn->peers.by_vpn_addr,
> > > > > +=09=09=09=09=09&peer->vpn_addrs.ipv4,
> > > > > +=09=09=09=09=09sizeof(peer->vpn_addrs.ipv4));
> > > > > +=09=09hlist_add_head_rcu(&peer->hash_entry_addr4,
> > > > > +=09=09=09=09   &ovpn->peers.by_vpn_addr[index]);
> > > > > +=09}
> > > > > +
> > > > > +=09hlist_del_init_rcu(&peer->hash_entry_addr6);
> > > >=20
> > > > Why are hash_entry_transp_addr and hash_entry_addr6 getting a
> > > > hlist_del_init_rcu() call, but not hash_entry_id and hash_entry_add=
r4?
> > >=20
> > > I think not calling del_init_rcu on hash_entry_addr4 was a mistake.
> > >=20
> > > Calling del_init_rcu on addr4, addr6 and transp_addr is needed to put=
 them
> > > in a known state in case they are not hashed.
> >=20
> > hlist_del_init_rcu does nothing if node is not already on a list.
>=20
> Mh you're right. I must have got confused for some reason.
> Those del_init_rcu can go then.
>=20
> >=20
> > > While hash_entry_id always goes through hlist_add_head_rcu, therefore
> > > del_init_rcu is useless (to my understanding).
> >=20
> > I'm probably missing something about how this all fits together. In
> > patch 19, I see ovpn_nl_set_peer_doit can re-add a peer that is
> > already added (but I'm not sure why, since you don't allow changing
> > the addresses, so it won't actually be re-hashed).
>=20
> Actually it's not a "re-add", but the intent is to "update" a peer that
> already exists. However, some fields are forbidden from being updated, li=
ke
> the address.
>=20
> [NOTE: I found some issue with the "peer update" logic in
> ovpn_nl_set_peer_doit and it's being changed a bit]
>=20
> >=20
> > I don't think doing a 2nd add of the same element to peers.by_id (or
> > any of the other hashtables) is correct, so I'd say you need
> > hlist_del_init_rcu for all of them.
>=20
> This is exactly the bug I mentioned above: we should not go through the a=
dd
> again. Ideally we should just update the fields and be done with it, with=
out
> re-hashing the object.

Ok, if you only call ovpn_peer_add for new peers, this looks fine and
the hlist_del_init_rcu can all be removed as you said.

Thanks.

--=20
Sabrina


