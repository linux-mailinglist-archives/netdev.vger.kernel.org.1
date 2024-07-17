Return-Path: <netdev+bounces-111935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD552934356
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 22:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7171C20D7D
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18271822FF;
	Wed, 17 Jul 2024 20:41:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261E1CAA6
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248868; cv=none; b=hyUkxg0bWjRg8EWs/o4I81Ed4AleOzQYbNtwWfeCPTiB48h+8TgPySy6Fqbanpa90NaGW6rZk3i0ax7mIebx3F+06PMszOJVafZHuh9spGT4dJy5uhbtnOe+3+qjFa3mw7ALhziSTMbC17ES4Mf8H9tv+DQwW8sofGZ3XxY257U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248868; c=relaxed/simple;
	bh=Nm8WxNhGYoNcgfGb8mLUsrNgoj5wteTX3g7fUCYB2WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=G4xuzRtWsY1832TxDJlJHCM/o+ZwoQFS+0L4kgYxfE7UA24C6ygQN43t7r6Da7BtwgaazoVBYK+FYvyQ8KrEcplQMM+vSqYtuKDA76PDvhWDupzNFJgnLC2YopHXb30b0pge/++ISZ9w7ShdMuixDmc5OiGTZSp82ZUO+N/Cq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-ggNPWAUJNlSVbS3zzx6-iQ-1; Wed,
 17 Jul 2024 16:41:02 -0400
X-MC-Unique: ggNPWAUJNlSVbS3zzx6-iQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36B2319560B4;
	Wed, 17 Jul 2024 20:40:59 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 441FB19560AA;
	Wed, 17 Jul 2024 20:40:55 +0000 (UTC)
Date: Wed, 17 Jul 2024 22:40:53 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 17/25] ovpn: implement keepalive mechanism
Message-ID: <ZpgsVYT3wR8HgPZ7@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-18-antonio@openvpn.net>
 <ZpU15_ZNAV5ysnCC@hog>
 <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-07-17, 17:30:17 +0200, Antonio Quartulli wrote:
> Hi,
>=20
> On 15/07/2024 16:44, Sabrina Dubroca wrote:
> > 2024-06-27, 15:08:35 +0200, Antonio Quartulli wrote:
> > > +/**
> > > + * ovpn_xmit_special - encrypt and transmit an out-of-band message t=
o peer
> > > + * @peer: peer to send the message to
> > > + * @data: message content
> > > + * @len: message length
> > > + *
> > > + * Assumes that caller holds a reference to peer
> > > + */
> > > +static void ovpn_xmit_special(struct ovpn_peer *peer, const void *da=
ta,
> > > +=09=09=09      const unsigned int len)
> > > +{
> > > +=09struct ovpn_struct *ovpn;
> > > +=09struct sk_buff *skb;
> > > +
> > > +=09ovpn =3D peer->ovpn;
> > > +=09if (unlikely(!ovpn))
> > > +=09=09return;
> > > +
> > > +=09skb =3D alloc_skb(256 + len, GFP_ATOMIC);
> >=20
> > Where is that 256 coming from?
>=20
> "Reasonable number" which should be enough[tm] to hold the entire packet.

Ok, let's go with that for now, unless someone else wants you to
change it.

> > > +=09if (unlikely(!skb))
> > > +=09=09return;
> >=20
> > Failure to send a keepalive should probably have a counter, to help
> > users troubleshoot why their connection dropped.
> > (can be done later unless someone insists)
>=20
> This will be part of a more sophisticated error counting that I will
> introduce later on.

Cool, thanks.


> > > +/**
> > > + * ovpn_peer_keepalive_set - configure keepalive values for peer
> > > + * @peer: the peer to configure
> > > + * @interval: outgoing keepalive interval
> > > + * @timeout: incoming keepalive timeout
> > > + */
> > > +void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u=
32 timeout)
> > > +{
> > > +=09u32 delta;
> > > +
> > > +=09netdev_dbg(peer->ovpn->dev,
> > > +=09=09   "%s: scheduling keepalive for peer %u: interval=3D%u timeou=
t=3D%u\n",
> > > +=09=09   __func__, peer->id, interval, timeout);
> > > +
> > > +=09peer->keepalive_interval =3D interval;
> > > +=09if (interval > 0) {
> > > +=09=09delta =3D msecs_to_jiffies(interval * MSEC_PER_SEC);
> > > +=09=09mod_timer(&peer->keepalive_xmit, jiffies + delta);
> >=20
> > Maybe something to consider in the future: this could be resetting a
> > timer that was just about to go off to a somewhat distant time in the
> > future. Not sure the peer will be happy about that (and not consider
> > it a timeout).
>=20
> Normally this timer is only set upon connection, or maybe upon some futur=
e
> parameter exchange. In both cases we can assume the connection is alive, =
so
> this case should not scare us.
>=20
> But thanks for pointing it out

Ok, I was thinking about updates while the connection is fully
established. If it's only done during setup, it shouldn't be a
problem.


> > > +/**
> > > + * ovpn_peer_keepalive_recv_reset - reset keepalive timeout
> > > + * @peer: peer for which the timeout should be reset
> > > + *
> > > + * To be invoked upon reception of an authenticated packet from peer=
 in order
> > > + * to report valid activity and thus reset the keepalive timeout
> > > + */
> > > +static inline void ovpn_peer_keepalive_recv_reset(struct ovpn_peer *=
peer)
> > > +{
> > > +=09u32 delta =3D msecs_to_jiffies(peer->keepalive_timeout * MSEC_PER=
_SEC);
> > > +
> > > +=09if (unlikely(!delta))
> > > +=09=09return;
> > > +
> > > +=09mod_timer(&peer->keepalive_recv, jiffies + delta);
> >=20
> > This (and ovpn_peer_keepalive_xmit_reset) is going to be called for
> > each packet. I wonder how well the timer subsystem deals with one
> > timer getting updated possibly thousands of time per second.
> >=20
>=20
> May it even introduce some performance penalty?

That's what I was worried about, yes.

I asked Paolo, he suggested checking that we're actually doing any
change to the timer:

   if (new_timeout_time !=3D old_timeout_time)
       mod_timer(...)

This would reduce the update frequency to one per jiffy, which should
be acceptable.

> Maybe we should get rid of the timer object and introduce a periodic (1s)
> worker which checks some last_recv timestamp on every known peer?
> What do you think?

That should work, or the workqueue like Eyal is saying.

--=20
Sabrina


