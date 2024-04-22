Return-Path: <netdev+bounces-90023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DBC8AC8A9
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE4F1C208C2
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8B1BF33;
	Mon, 22 Apr 2024 09:16:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33866537F5
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777410; cv=none; b=YpUxg7TjQV0A5DxubX5XbI2w2mJBL2s9fCnOc+PibWUqDUrDj74+Dgcr2ARnT4fNZXBU/f8rbK6qPdVptwKFsPQlPoKrL8O2UPQrcN9xetzfP9bAb6hqbeV25yQEmgKm5X7CYAmdNIsRsV4M4KoyUgjcnd6MktreNOY6mVvea/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777410; c=relaxed/simple;
	bh=0Q7XZMdWBQ0oWBsSGnUV5fnIg6r94Lo2Iy3iTGZ7M9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k+nqbQDsAdh29S01P2R2aaxql6VvEPGQBy3kSKNGBkU8JnLxScLI5B2Zpx18zCUecmq88OyViICNWXDxFtHD1hyvfOaKE95fZKeOhJur8CiDDr91NH+Kba9qV835XMxGzoF7ggNpos7KP4QS/5MBXZbMbNCBubYXQmOxXoWd4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-uNNZDHtMNeW27Wstzkbz6w-1; Mon,
 22 Apr 2024 05:16:35 -0400
X-MC-Unique: uNNZDHtMNeW27Wstzkbz6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 240821C3F0F0;
	Mon, 22 Apr 2024 09:16:35 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D7A544048;
	Mon, 22 Apr 2024 09:16:32 +0000 (UTC)
Date: Mon, 22 Apr 2024 11:16:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony@phenome.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v10 1/3] xfrm: Add Direction to
 the SA in or out
Message-ID: <ZiYq729Q1AF2Xq8M@hog>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
 <Zh0b3gfnr99ddaYM@hog>
 <Zh4kYUjvDtUq69-h@Antony2201.local>
 <Zh44gO885KtSjBHC@hog>
 <ZiWNh-Hz9TYWVofO@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZiWNh-Hz9TYWVofO@Antony2201.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-22, 00:04:55 +0200, Antony Antony wrote:
> Hi Sabrina,
>=20
> On Tue, Apr 16, 2024 at 10:36:16AM +0200, Sabrina Dubroca wrote:
> > 2024-04-16, 09:10:25 +0200, Antony Antony wrote:
> > > On Mon, Apr 15, 2024 at 02:21:50PM +0200, Sabrina Dubroca via Devel w=
rote:
> > > > 2024-04-11, 11:40:59 +0200, Antony Antony wrote:
> > > > > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > > > > index 6346690d5c69..2455a76a1cff 100644
> > > > > --- a/net/xfrm/xfrm_device.c
> > > > > +++ b/net/xfrm/xfrm_device.c
> > > > > @@ -253,6 +253,12 @@ int xfrm_dev_state_add(struct net *net, stru=
ct xfrm_state *x,
> > > > >  =09=09return -EINVAL;
> > > > >  =09}
> > > > >=20
> > > > > +=09if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir =3D=3D XFRM_=
SA_DIR_OUT) ||
> > > > > +=09    (!(xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir =3D=3D XF=
RM_SA_DIR_IN)) {
> > > > > +=09=09NL_SET_ERR_MSG(extack, "Mismatched SA and offload directio=
n");
> > > > > +=09=09return -EINVAL;
> > > > > +=09}
> > > >=20
> > > > It would be nice to set x->dir to match the flag, but then I guess =
the
> > > > validation in xfrm_state_update would fail if userspaces tries an
> > > > update without providing XFRMA_SA_DIR. (or not because we already w=
ent
> > > > through this code by the time we get to xfrm_state_update?)
> > >=20
> > > this code already executed from xfrm_state_construct.
> > > We could set the in flag in xuo when x->dir =3D=3D XFRM_SA_DIR_IN, le=
t me think=20
> > > again.  May be we can do that later:)
> >=20
> > I mean setting x->dir, not setting xuo, ie adding something like this
> > to xfrm_dev_state_add:
> >=20
> >     x->dir =3D xuo->flags & XFRM_OFFLOAD_INBOUND ? XFRM_SA_DIR_IN : XFR=
M_SA_DIR_OUT;
> >=20
> > xuo will already be set correctly when we're using offload, and won't
> > be present if we're not.
>=20
> Updating with older tools may fail validation. For instance, if a user cr=
eates
> an SA using an older iproute2 with offload and XFRM_OFFLOAD_INBOUND flag=
=20
> set, the kernel sets x->dir =3D XFRM_SA_DIR_IN. Then, if the user wants t=
o=20
> update this SA using the same older iproute2, which doesn't allow setting=
=20
> dir, the update will fail.

I'm not sure it would, since as you said xfrm_state_construct would
have set x->dir based on XFRM_OFFLOAD_INBOUND. But if that's the case,
then that can be added later, because it would not change any behavior.

> However, as I proposed, if SA dir "in" and offload is enabled, the kernel
> could set xuo->flags &=3D XFRM_OFFLOAD_INBOUND to avoid double typing.

Do you mean in iproute?

On the kernel side, xuo has to be provided when offloading, and the
meaning of (xuo->flags & XFRM_OFFLOAD_INBOUND) is well defined (0 =3D
out, !0 =3D in). xuo->flags & XFRM_OFFLOAD_INBOUND =3D=3D 0 with SA_DIR =3D=
=3D
IN must remain an invalid config.


> > > And also this looks like a general cleanup up to me. I wonder how Ste=
ffen=20
> > > would add such a check for the upcoming PCPU attribute! Should that b=
e=20
> > > prohibited DELSA or XFRM_MSG_FLUSHSA or DELSA?
> >=20
> > IMO, new attributes should be rejected in any handler that doesn't use
> > them. That's not a general cleanup because it's a new attribute, and
> > the goal is to allow us to decide later if we want to use that
> > attribute in DELSA etc. Maybe in one year, we want to make DELSA able
> > to match on SA_DIR. If we don't reject SA_DIR from DELSA now, we won't
> > be able to do that. That's why I'm insisting on this.
>=20
> I have implemented a method to reject in v11, even though it is not my=20
> preference:) My argument xfrm has no precedence of limiting unused=20
> attributes in most types. We are not enforcing on all attributes such as=
=20
> upcoming PCPU.

I'll ask Steffen to enforce it there as well :)
I think it's a mistake that old netlink APIs were too friendly to invalid i=
nput.

--=20
Sabrina


