Return-Path: <netdev+bounces-94930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D15D8C106D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5441C20BDB
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF5115279B;
	Thu,  9 May 2024 13:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2F14A62A
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261587; cv=none; b=KHoxTJ9uJcwZdAwDq65iyrMFC+eLhytI6zsnZLjKOKjP868C8xAT8kbQjVUKDxmRRbgnoL37pOS79zBCTEg/T517dyRPlK152MP9T83WjiQ7juhEWzVW7NJN1msjBsLoRJNNjLqJjo08lAX+vaIMk1IOVvpTkcghtwlt1fPyqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261587; c=relaxed/simple;
	bh=t27OOztjwI27LyDpR52PwYOrlrbv9JGIoAkEKg1BCkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c7Lk7OW23fgz5AYrW5svO6dKdGUyuLs6M63LOj0Io4FEpCNhLu4VqMlOCvYVa3TiOnueZLy8b2lcXLyNXRrnPhpOFq2auZ319s/+5fY/E8yu06kWOPwHmu44FwnCp6l8gaKh00RBnLvtuQAxlIc3n+2/ZrJm2ZvSlLfAeXU6PSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-JZZP_wTcP5ivedMqqU7guw-1; Thu, 09 May 2024 09:32:53 -0400
X-MC-Unique: JZZP_wTcP5ivedMqqU7guw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 952BC805912;
	Thu,  9 May 2024 13:32:52 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E60B40004D;
	Thu,  9 May 2024 13:32:51 +0000 (UTC)
Date: Thu, 9 May 2024 15:32:50 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 08/24] ovpn: introduce the ovpn_socket object
Message-ID: <ZjzQgog9NfFiR6CP@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-9-antonio@openvpn.net>
 <ZjuyIOK6BY3r9YCI@hog>
 <53dc5388-630f-47e1-a6c1-6c3bb91ee2ac@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <53dc5388-630f-47e1-a6c1-6c3bb91ee2ac@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-08, 22:38:58 +0200, Antonio Quartulli wrote:
> On 08/05/2024 19:10, Sabrina Dubroca wrote:
> > 2024-05-06, 03:16:21 +0200, Antonio Quartulli wrote:
> > > diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> > > new file mode 100644
> > > index 000000000000..a4a4d69162f0
> > > --- /dev/null
> > > +++ b/drivers/net/ovpn/socket.c
> > [...]
> > > +
> > > +/* Finalize release of socket, called after RCU grace period */
> >=20
> > kref_put seems to call ovpn_socket_release_kref without waiting, and
> > then that calls ovpn_socket_detach immediately as well. Am I missing
> > something?
>=20
> hmm what do we need to wait for exactly? (Maybe I am missing something)
> The ovpn_socket will survive a bit longer thanks to kfree_rcu.

The way I read this comment, it says that ovpn_socket_detach will be
called after one RCU grace period, but I don't see where that grace
period would come from.

    ovpn_socket_put -> kref_put(release=3Dovpn_socket_release_kref) ->
      ovpn_socket_release_kref -> ovpn_socket_detach

No grace period here.

Or am I misinterpreting the comment? There will be a grace period
caused by kfree_rcu before the ovpn_socket is actually freed, is that
what the comment means?

> > > +static void ovpn_socket_detach(struct socket *sock)
> > > +{
> > > +=09if (!sock)
> > > +=09=09return;
> > > +
> > > +=09sockfd_put(sock);
> > > +}
> >=20

--=20
Sabrina


