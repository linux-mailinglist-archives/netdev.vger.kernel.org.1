Return-Path: <netdev+bounces-116878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9CF94BEF7
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665531C21FEF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC97F18C909;
	Thu,  8 Aug 2024 14:01:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB68829AF
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125718; cv=none; b=pCcAMzpMg7XYv5sgLab4pf+ibYAnMEhcjbBFLahs/IvPnXDyqdZ+jnk8QpmaWA3YRYXVhwbtD63zrk75Y1q8lDDDA8NJyT8MG335KF4AY2sCfTS0nnNYgKlRi+bKzyAWBVVGI06jlc2LfyVxXq2MRWqbWkIsd1GVJ+zjXLrmDS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125718; c=relaxed/simple;
	bh=pK8C2d/hFPmQtxaA7bYDGr6SmPP5uxagi3esRFMN2Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JcfVF/bQ0/09LZs2wRScX7SaSP7jxKlhU4ERLfGGwzO0aPYsIyLxAYDJbkrZWT5kf1rm4TI9CSAFnZG/KqR341VfTY5JFtliFQ5ChtuowjCvWty5wIlKIT41Qwto7CHZLHV3Twvhc52rJFzRwViWmEOTGvjQXDKh0Iz1q9a8bL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-mrF9dL8OOCu9l0qX3ROsAA-1; Thu,
 08 Aug 2024 10:01:51 -0400
X-MC-Unique: mrF9dL8OOCu9l0qX3ROsAA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79A421955BCF;
	Thu,  8 Aug 2024 14:01:49 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57D7019560A3;
	Thu,  8 Aug 2024 14:01:46 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:01:44 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <ZrTPyM3V7JKca6SZ@hog>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org>
 <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org>
 <ZrHjByjZnnDgjvfo@hog>
 <m2le1aouzf.fsf@ja-home.int.chopps.org>
 <ZrIDfN2uFpktGJYD@hog>
 <m2a5hnnsw8.fsf@ja-home.int.chopps.org>
 <ZrTH665G9b3P054t@hog>
 <3BAC517C-C896-489F-A7E8-DE5046E38073@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3BAC517C-C896-489F-A7E8-DE5046E38073@chopps.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-08, 09:35:04 -0400, Christian Hopps wrote:
>=20
>=20
> > On Aug 8, 2024, at 09:28, Sabrina Dubroca <sd@queasysnail.net> wrote:
> >=20
> > 2024-08-08, 07:30:13 -0400, Christian Hopps wrote:
> >>=20
> >> Sabrina Dubroca <sd@queasysnail.net> writes:
> >>=20
> >>> 2024-08-06, 04:54:53 -0400, Christian Hopps wrote:
> >>>>=20
> >>>> Sabrina Dubroca <sd@queasysnail.net> writes:
> >>>>=20
> >>>>> 2024-08-04, 22:33:05 -0400, Christian Hopps wrote:
> >>>>>>>> +/* 1) skb->head should be cache aligned.
> >>>>>>>> + * 2) when resv is for L2 headers (i.e., ethernet) we want the =
cacheline to
> >>>>>>>> + * start -16 from data.
> >>>>>>>> + * 3) when resv is for L3+L2 headers IOW skb->data points at th=
e IPTFS payload
> >>>>>>>> + * we want data to be cache line aligned so all the pushed head=
ers will be in
> >>>>>>>> + * another cacheline.
> >>>>>>>> + */
> >>>>>>>> +#define XFRM_IPTFS_MIN_L3HEADROOM 128
> >>>>>>>> +#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)
> >>>>>>>=20
> >>>>>>> How did you pick those values?
> >>>>>>=20
> >>>>>> That's what the comment is talking to. When reserving space for L2=
 headers we
> >>>>>> pick 64 + 16 (a 2^(<=3D6) cacheline + 16 bytes so the the cachelin=
e should start
> >>>>>> -16 from where skb->data will point at.
> >>>>>=20
> >>>>> Hard-coding the x86 cacheline size is not a good idea. And what's t=
he
> >>>>> 16B for? You don't know that it's enough for the actual L2 headers.
> >>>>=20
> >>>> I am not hard coding the x86 cacheline. I am picking 64 as the large=
st cacheline that this is optimized for, it also works for smaller cachelin=
es.
> >>>=20
> >>> At least use SMP_CACHE_BYTES then?
> >>=20
> >> Right, I have changed this work with L1_CACHE_BYTES value.
> >>=20
> >>>> 16B is to allow for the incredibly common 14B L2 header to fit.
> >>>=20
> >>> Why not use skb->dev->needed_headroom, like a bunch of tunnels are
> >>> already doing? No guessing required. ethernet is the most common, but
> >>> there's no reason to penalize other protocols when the information is
> >>> available.
> >>=20
> >> We can't use `skb->dev->needed_headroom`, b/c `skb->dev` is not
> >> correct for the new packets. `skb->dev` is from the received IPTFS
> >> tunnel packet. The skb being created here are the inner user packets
> >> leaving the tunnel, so they have an L3 header (thus why we are only
> >> making room for L2 header). They are being handed to gro receive and
> >> still have to be routed to their correct destination interface/dev.
> >=20
> > You're talking about RX now. You're assuming the main use-case is an
> > IPsec GW that's going to send the decapped packets out on another
> > ethernet interface? (or at least, that's that's a use-case worth
> > optimizing for)
> >=20
> > What about TX? Is skb->dev->needed_headroom also incorrect there?
> >=20
> > Is iptfs_alloc_skb's l3resv argument equivalent to a RX/TX switch?
>=20
> Exactly right. When we are generating IPTFS tunnel packets we need
> to add all the L3+l2 headers, and in that case we pass l3resv =3D
> true.

Could you add a little comment alongside iptfs_alloc_skb? It would
help make sense of the sizes you're choosing and how they fit the use
of those skbs (something like "l3resv=3Dtrue is used on TX, because we
need to reserve L2+L3 headers. On RX, we only need L2 headers because
[reason why we need L2 headers].").

And if skb->dev->needed_headroom is correct in the TX case, I'd still
prefer (skb->dev->needed_headroom + <some space for l3>) to a fixed 128.

--=20
Sabrina


