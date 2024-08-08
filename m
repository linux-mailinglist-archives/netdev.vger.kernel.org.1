Return-Path: <netdev+bounces-116755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D767F94B9A8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4E4B20F59
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DDE146D55;
	Thu,  8 Aug 2024 09:27:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82957146A93
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109234; cv=none; b=NIXiJZMXQx3XY8Bt/eN35QeIyzCzsNPJkH+9uotJANKuuuCOLOhZT8PcNaxF68uAHJBqNAFp8bPXAEJ+WWt02/szcTefnCqszvrpuDGULt0gdGv9zFGW7uGpgP1pmMuH0P9Lyq//ctdNkY54ToHB7bNwsqbX4VKYgFOdNigmSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109234; c=relaxed/simple;
	bh=ofUY4fHIGHwdbuyxuBH2E8l/Uy3Hr0R9eHchYytkqEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=urlK+IgCYt7ExBku6tVCmf2b0DTUpXBrrb07uhk8ZuYtlvM8kw7OV3haBY2pLkVOLS4xLnbewoTxSE0PQgjF6qKYBrerjzW1P7lM4siXUf4zjWYLoEqbfUU0SJE9j5LavpYECq9N3hjlyDAR19TcsdBHb5Gy8K14Qt3Xy+qBv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-vsmIdODnMQWKDx5fFfq-Vw-1; Thu,
 08 Aug 2024 05:27:01 -0400
X-MC-Unique: vsmIdODnMQWKDx5fFfq-Vw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 283ED1977006;
	Thu,  8 Aug 2024 09:27:00 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1BF71955F30;
	Thu,  8 Aug 2024 09:26:56 +0000 (UTC)
Date: Thu, 8 Aug 2024 11:26:54 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, devel@linux-ipsec.org,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <ZrSPXqJlck_DCnTi@hog>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org>
 <Zq__9Z4ckXNdR-Ec@hog>
 <ZrIJ0d6x3pTslQKn@gauss3.secunet.de>
 <m2jzgsnm3l.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <m2jzgsnm3l.fsf@ja-home.int.chopps.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-07, 15:40:14 -0400, Christian Hopps wrote:
>=20
> Steffen Klassert <steffen.klassert@secunet.com> writes:
>=20
> > On Mon, Aug 05, 2024 at 12:25:57AM +0200, Sabrina Dubroca wrote:
> > >=20
> > > > +/**
> > > > + * skb_copy_bits_seq - copy bits from a skb_seq_state to kernel bu=
ffer
> > > > + * @st: source skb_seq_state
> > > > + * @offset: offset in source
> > > > + * @to: destination buffer
> > > > + * @len: number of bytes to copy
> > > > + *
> > > > + * Copy @len bytes from @offset bytes into the source @st to the d=
estination
> > > > + * buffer @to. `offset` should increase (or be unchanged) with eac=
h subsequent
> > > > + * call to this function. If offset needs to decrease from the pre=
vious use `st`
> > > > + * should be reset first.
> > > > + *
> > > > + * Return: 0 on success or a negative error code on failure
> > > > + */
> > > > +static int skb_copy_bits_seq(struct skb_seq_state *st, int offset,=
 void *to,
> > > > +=09=09=09     int len)
> > >=20
> > > Probably belongs in net/core/skbuff.c, although I'm really not
> > > convinced copying data around is the right way to implement the type
> > > of packet splitting IPTFS does (which sounds a bit like a kind of
> > > GSO).
> >=20
> > I tried to come up with a 'GSO like' variant of this when I did the
> > initial review last year at the IPsec workshop. But it turned out
> > that things will get even more complicated as they are now.
> > We did some performance tests and it was quite compareable to
> > tunnel mode, so for a first implementation I'd be ok with the
> > copy variant.

Ok.

> > > And there are helpers in net/core/skbuff.c (such as
> > > pskb_carve/pskb_extract) that seem to do similar things to what you
> > > need here, without as much data copying.
> >=20
> > In case we have helpers that will fit here, we should use them of
> > course.
>=20
> FWIW, The reason I didn't use pskb_extract() rather than the simple
> iptfs_copy_create_frag() is because pskb_extract uses skb_clone on
> the original skb then pskb_carve() to narrow the (copied) data
> pointers to a subset of the original. The new skb data is read-only
> which does not work for us.
>=20
> Each of these new skbs are IP-TFS tunnel packets and as such we need
> to push and write IPTFS+ESP+IP+Ethernet headers on them. In order to
> make pskb_extract()s skbs writable we would have to allocate new
> buffer space and copy the data turning them into a writeable skb
> buffer, and now we're doing something more complex and more cpu
> intensive to arrive back to what iptfs_copy_create_frag() did simply
> and straight-forwardly to begin with.

That only requires the header to be writeable, not the full packet,
right? I doubt it would actually be more cpu/memory intensive.

--=20
Sabrina


