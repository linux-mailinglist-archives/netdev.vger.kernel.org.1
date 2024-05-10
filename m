Return-Path: <netdev+bounces-95388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5863E8C2222
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD4E1F217F6
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A67EEF8;
	Fri, 10 May 2024 10:30:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976C2233B
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337054; cv=none; b=VAkNKx8mpyuiC0E57bM8OH3E1ryDdV8BePub/Gwo5jiXQRW3F/ZG4qGSD9GlrMHXI7bjnNpNaXrwcaXOCXH/kryKHiCESu0T8hmFdjw/ANM0Qkt0bOP9UMO4Q1Qa546k3hiIhY+w37MSzH+SvkKocXyr5YJYFyMoAH+Siwzm2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337054; c=relaxed/simple;
	bh=Qtu8qyzGZ60/dE9N/8kVfBI9gCFDdX4n+RccsWMkZaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pinTr+Jg761NBaZyJABypNnHq1sxRwK0oaCAtP7fs1Tw0Cg4B+T1gCsdsPvtOaF+Nj9zr/Ix/DBTN9GKtnjFBtafcBkZekfzhvZDRHaD+TgXWjod8x8lsgQqSQSYXpMcFcuwjbNT3iVxyQG+2zWcm3pzCiwTL2jPTIucbGVVCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-7jvuyYW8NgiiLcaMDYelbg-1; Fri,
 10 May 2024 06:30:41 -0400
X-MC-Unique: 7jvuyYW8NgiiLcaMDYelbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FD6C29AA39D;
	Fri, 10 May 2024 10:30:40 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CF57205588E;
	Fri, 10 May 2024 10:30:38 +0000 (UTC)
Date: Fri, 10 May 2024 12:30:37 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
Message-ID: <Zj33TTI5081ejbfs@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net>
 <ZjujHw6eglLEIbxA@hog>
 <60cae774-b60b-4a4b-8645-91eb6f186032@openvpn.net>
 <ZjzJ5Hm8hHnE7LR9@hog>
 <7254c556-8fe9-484c-9dc8-f55c30b11776@openvpn.net>
 <ZjzbDpEW5iVqW8oA@hog>
 <04558c43-6b7d-4076-a6eb-d60222a292fc@openvpn.net>
 <786914f6-325c-4452-8d71-292ffb59a298@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <786914f6-325c-4452-8d71-292ffb59a298@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-09, 16:53:42 +0200, Antonio Quartulli wrote:
>=20
>=20
> On 09/05/2024 16:36, Antonio Quartulli wrote:
> > On 09/05/2024 16:17, Sabrina Dubroca wrote:
> > > 2024-05-09, 15:44:26 +0200, Antonio Quartulli wrote:
> > > > On 09/05/2024 15:04, Sabrina Dubroca wrote:
> > > > > > > > +void ovpn_peer_release(struct ovpn_peer *peer)
> > > > > > > > +{
> > > > > > > > +=C2=A0=C2=A0=C2=A0 call_rcu(&peer->rcu, ovpn_peer_release_=
rcu);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * ovpn_peer_delete_work - work scheduled to
> > > > > > > > release peer in process context
> > > > > > > > + * @work: the work object
> > > > > > > > + */
> > > > > > > > +static void ovpn_peer_delete_work(struct work_struct *work=
)
> > > > > > > > +{
> > > > > > > > +=C2=A0=C2=A0=C2=A0 struct ovpn_peer *peer =3D container_of=
(work, struct ovpn_peer,
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 delete_work);
> > > > > > > > +=C2=A0=C2=A0=C2=A0 ovpn_peer_release(peer);
> > > > > > >=20
> > > > > > > Does call_rcu really need to run in process context?
> > > > > >=20
> > > > > > Reason for switching to process context is that we have to invo=
ke
> > > > > > ovpn_nl_notify_del_peer (that sends a netlink event to
> > > > > > userspace) and the
> > > > > > latter requires a reference to the peer.
> > > > >=20
> > > > > I'm confused. When you say "requires a reference to the peer", do=
 you
> > > > > mean accessing fields of the peer object? I don't see why this
> > > > > requires ovpn_nl_notify_del_peer to to run from process context.
> > > >=20
> > > > ovpn_nl_notify_del_peer sends a netlink message to userspace and
> > > > I was under
> > > > the impression that it may block/sleep, no?
> > > > For this reason I assumed it must be executed in process context.
> > >=20
> > > With s/GFP_KERNEL/GFP_ATOMIC/, it should be ok to run from whatever
> > > context. Firing up a workqueue just to send a 100B netlink message
> > > seems a bit overkill.
> >=20
> > Oh ok, I thought the send could be a problem too.
> >=20
> > Will test with GFP_ATOMIC then. Thanks for the hint.
>=20
> I am back and unfortunately we also have (added by a later patch):
>=20
>  294         napi_disable(&peer->napi);
>  295         netif_napi_del(&peer->napi);

Do you need the napi instance to be per peer, or can it be per
netdevice? If it's per netdevice you can clean it up in
->priv_destructor.

> that need to be executed in process context.
> So it seems I must fire up the worker anyway..

I hope with can simplify all that logic. There's some complexity
that's unavoidable in this kind of driver, but maybe not as much as
you've got here.

--=20
Sabrina


