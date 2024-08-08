Return-Path: <netdev+bounces-116868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450B94BE82
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE89C282868
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3A418DF6D;
	Thu,  8 Aug 2024 13:28:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47BB1487C8
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123705; cv=none; b=CjYTqcun8LE3Pz0vP1yMRPFABXpSRPInudeMbS6dqemKq8GdlH3ggKN4rSXbXekc4H5pGiDrUBOX/kZCSwmB9QTFNHIHOJL3JZNERMryq0UjtKx154gnS1NHn3cdrnqVsPlcyuvswl6aEzdKvVi4JJ13mMe4H9scSrNwlpzi5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123705; c=relaxed/simple;
	bh=iEyhy3FJD6Jt8YgBSL/N9nw3B8UtcTri3Y4l/sD1JNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bprPSXGzPscjx3iH+ggN7AscECIn2YropQdWYYqIxt1GN9N1vPIvuYC7ND8ZE38XF2VR1INCHMedYOHC5ymWwELqkL2NGU0dOAjB+wf3KXwSntDnjfE9bw0qLlL/tfXubNaI5OhgONnbcJq8J+CXZltI77T2i7bQP7pJmITVXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-PLe8yKLYOoK10rHgKJQX5Q-1; Thu,
 08 Aug 2024 09:28:18 -0400
X-MC-Unique: PLe8yKLYOoK10rHgKJQX5Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B5E11955D5C;
	Thu,  8 Aug 2024 13:28:16 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2B4C300018D;
	Thu,  8 Aug 2024 13:28:13 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:28:11 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <ZrTH665G9b3P054t@hog>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org>
 <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org>
 <ZrHjByjZnnDgjvfo@hog>
 <m2le1aouzf.fsf@ja-home.int.chopps.org>
 <ZrIDfN2uFpktGJYD@hog>
 <m2a5hnnsw8.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <m2a5hnnsw8.fsf@ja-home.int.chopps.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-08, 07:30:13 -0400, Christian Hopps wrote:
>=20
> Sabrina Dubroca <sd@queasysnail.net> writes:
>=20
> > 2024-08-06, 04:54:53 -0400, Christian Hopps wrote:
> > >=20
> > > Sabrina Dubroca <sd@queasysnail.net> writes:
> > >=20
> > > > 2024-08-04, 22:33:05 -0400, Christian Hopps wrote:
> > > > > > > +/* 1) skb->head should be cache aligned.
> > > > > > > + * 2) when resv is for L2 headers (i.e., ethernet) we want t=
he cacheline to
> > > > > > > + * start -16 from data.
> > > > > > > + * 3) when resv is for L3+L2 headers IOW skb->data points at=
 the IPTFS payload
> > > > > > > + * we want data to be cache line aligned so all the pushed h=
eaders will be in
> > > > > > > + * another cacheline.
> > > > > > > + */
> > > > > > > +#define XFRM_IPTFS_MIN_L3HEADROOM 128
> > > > > > > +#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)
> > > > > >
> > > > > > How did you pick those values?
> > > > >
> > > > > That's what the comment is talking to. When reserving space for L=
2 headers we
> > > > > pick 64 + 16 (a 2^(<=3D6) cacheline + 16 bytes so the the cacheli=
ne should start
> > > > > -16 from where skb->data will point at.
> > > >
> > > > Hard-coding the x86 cacheline size is not a good idea. And what's t=
he
> > > > 16B for? You don't know that it's enough for the actual L2 headers.
> > >=20
> > > I am not hard coding the x86 cacheline. I am picking 64 as the larges=
t cacheline that this is optimized for, it also works for smaller cacheline=
s.
> >=20
> > At least use SMP_CACHE_BYTES then?
>=20
> Right, I have changed this work with L1_CACHE_BYTES value.
>=20
> > > 16B is to allow for the incredibly common 14B L2 header to fit.
> >=20
> > Why not use skb->dev->needed_headroom, like a bunch of tunnels are
> > already doing? No guessing required. ethernet is the most common, but
> > there's no reason to penalize other protocols when the information is
> > available.
>=20
> We can't use `skb->dev->needed_headroom`, b/c `skb->dev` is not
> correct for the new packets. `skb->dev` is from the received IPTFS
> tunnel packet. The skb being created here are the inner user packets
> leaving the tunnel, so they have an L3 header (thus why we are only
> making room for L2 header). They are being handed to gro receive and
> still have to be routed to their correct destination interface/dev.

You're talking about RX now. You're assuming the main use-case is an
IPsec GW that's going to send the decapped packets out on another
ethernet interface? (or at least, that's that's a use-case worth
optimizing for)

What about TX? Is skb->dev->needed_headroom also incorrect there?

Is iptfs_alloc_skb's l3resv argument equivalent to a RX/TX switch?

> 16 handles the general common case an ethernet device being the
> destination, if it's not correct after routing, nothing is broken,
> it just means that we may or may not achieve this maximal cache
> locality (but we still might e.g., if its destined to a GRE tunnel
> then we are looking at a bunch more headers so they and the existing
> L3 header will occupy 2 cachelines anyway). Again, this is a best
> effort thing.

Ok.

--=20
Sabrina


