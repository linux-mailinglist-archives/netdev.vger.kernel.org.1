Return-Path: <netdev+bounces-94945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A68C111D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DD5283747
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3076D15E1F8;
	Thu,  9 May 2024 14:18:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71615278C
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264281; cv=none; b=OTSqva8SOpwgYmqQ+d0Ljs1eEZWmhFvQeJVAf1r0MsiKQaqjSVISwDwIGgCg2YgzrvStSTXel0fXYYHMAlf0qTHm9ajJ62DCaPaNmsBvdG+0b+mHY2EbNRwq9ToIQPUhVWdJvrv8lbWLVSpuu/3hJE96ea7apaZLVI0zsQUeomo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264281; c=relaxed/simple;
	bh=KgiEfqwPoyuWa65cSMjwVibefhjUCI1UXYy7qhArogE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PS9skaR6NssgQhZg72HtqkyqoaSITQpqCTbO/g0wuZMvg+iM1KeSW9LzYOcGhCQRe+HBxLfSnfW+n12f0uJWmFPGTh6NQMRBLQJThcKD86jaJMyOCeTSz1JenWtH1rwZXX/gSR2w/Fu2lEVGdDy8lRydEedHx91j+c1FMNTu6eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-QSD4TzXeM8uZ_vEXLMebSQ-1; Thu, 09 May 2024 10:17:53 -0400
X-MC-Unique: QSD4TzXeM8uZ_vEXLMebSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8297F185A78E;
	Thu,  9 May 2024 14:17:52 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B345208256D;
	Thu,  9 May 2024 14:17:51 +0000 (UTC)
Date: Thu, 9 May 2024 16:17:50 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
Message-ID: <ZjzbDpEW5iVqW8oA@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net>
 <ZjujHw6eglLEIbxA@hog>
 <60cae774-b60b-4a4b-8645-91eb6f186032@openvpn.net>
 <ZjzJ5Hm8hHnE7LR9@hog>
 <7254c556-8fe9-484c-9dc8-f55c30b11776@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7254c556-8fe9-484c-9dc8-f55c30b11776@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-09, 15:44:26 +0200, Antonio Quartulli wrote:
> On 09/05/2024 15:04, Sabrina Dubroca wrote:
> > > > > +void ovpn_peer_release(struct ovpn_peer *peer)
> > > > > +{
> > > > > +=09call_rcu(&peer->rcu, ovpn_peer_release_rcu);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * ovpn_peer_delete_work - work scheduled to release peer in pro=
cess context
> > > > > + * @work: the work object
> > > > > + */
> > > > > +static void ovpn_peer_delete_work(struct work_struct *work)
> > > > > +{
> > > > > +=09struct ovpn_peer *peer =3D container_of(work, struct ovpn_pee=
r,
> > > > > +=09=09=09=09=09      delete_work);
> > > > > +=09ovpn_peer_release(peer);
> > > >=20
> > > > Does call_rcu really need to run in process context?
> > >=20
> > > Reason for switching to process context is that we have to invoke
> > > ovpn_nl_notify_del_peer (that sends a netlink event to userspace) and=
 the
> > > latter requires a reference to the peer.
> >=20
> > I'm confused. When you say "requires a reference to the peer", do you
> > mean accessing fields of the peer object? I don't see why this
> > requires ovpn_nl_notify_del_peer to to run from process context.
>=20
> ovpn_nl_notify_del_peer sends a netlink message to userspace and I was un=
der
> the impression that it may block/sleep, no?
> For this reason I assumed it must be executed in process context.

With s/GFP_KERNEL/GFP_ATOMIC/, it should be ok to run from whatever
context. Firing up a workqueue just to send a 100B netlink message
seems a bit overkill.



> This said, I have a question regarding DEBUG_NET_WARN_ON_ONCE: it prints
> something only if CONFIG_DEBUG_NET is enabled.
> Is this the case on standard desktop/server distribution? Otherwise how a=
re
> we going to get reports from users?

That's pretty much why I'm suggesting to use it. For those things that
should really never happen, I think letting developers find them
during testing (or syzbot when it gets to your driver) is enough. I'm
not convinced getting a stack trace from a user without any ability to
reproduce is that useful.

But if you or someone else really want some WARN_ONs, I can live with
that.

> > > > And if this happens during interface deletion, aren't we leaking th=
e
> > > > peer memory here?
> > >=20
> > > at interface deletion we call
> > >=20
> > > ovpn_iface_destruct -> ovpn_peer_release_p2p ->
> > > ovpn_peer_del_p2p(ovpn->peer)
> > >=20
> > > so at the last step we just ask to remove the very same peer that is
> > > curently stored, which should just never fail.
> >=20
> > But that's not what the test checks for. If ovpn->peer->ovpn !=3D ovpn,
> > the test in ovpn_peer_del_p2p will fail. That's "objects getting out
> > of sync" in my previous email. The peer has a bogus back reference to
> > its ovpn parent, but it's ovpn->peer nevertheless.
> >=20
>=20
> Oh thanks for explaining that.
>=20
> Ok, my assumption is that "ovpn->peer->ovpn !=3D ovpn" can never be true.
>=20
> Peers are created within the context of one ovpn object and are never
> exposed to other ovpns.
>=20
> I hope it makes sense.

Ok, so this would indicate that something has gone badly wrong. Is it
really worth checking for that (or maybe just during development)?

--=20
Sabrina


