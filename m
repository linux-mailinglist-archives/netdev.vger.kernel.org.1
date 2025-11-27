Return-Path: <netdev+bounces-242415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D1C903CC
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 22:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B986A3AB831
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9157E324B23;
	Thu, 27 Nov 2025 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WL4I38OF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGQj9Oyb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE0325733
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279826; cv=none; b=QjOyzFNIQeXGWoIVS+EunEyx3gTl6OKKVSgATpamPLQuHKr2jP+AekKsbviOiJ8CZuCCRUH+Ef8xaiFoEzhPRzhUMNzML4uBnuh9k9kv0hgV9JYcsZoLbKkw4Y6Qe3OwHaLwcH0Ar4P8W0aHFJPaqH/ri4dI5hbCywg6Nwe2Drs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279826; c=relaxed/simple;
	bh=dKCTAF3OQ9c79iM6Fcrqv2VNGjHQ0c4NaNhbGlfjOJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLKlpwCQf9Q4SnGfhwn9riPXn367czNVc2IbKxgG2Ap8RAerylcPp9haDRUBYZL5WBKLtxeo5nzZnI7zbDfdEZ7tR5zK43URtQlTQn9zhMdYV6VYyx6jtj5dk1OlQdFyyIjcmlv17V2pecMRLLFJD09p0/HYYS+oCj9Rmmcgogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WL4I38OF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGQj9Oyb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764279823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rmd+WwZSNaXrPoCe94WZRqaNLCd4FVEQ1XchwHB+HkI=;
	b=WL4I38OFwR4v395Sg7bj7QLZsckaEDUTI0mKCCC6IGzbrYvB8JNWDfar7Xhb9S7UvLHQ3Y
	2bMlNhrrQmsLMbVLQ+ReV3gmJUW+kkVfYSMFWiQYohKGemt47SxQ59P4/DajjctLQ/L0MC
	ElyT6fdR6rY7pAUr1Cd62h7XJkHHeBY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-G633FYtCMFSBagsY6Uu9eQ-1; Thu, 27 Nov 2025 16:43:41 -0500
X-MC-Unique: G633FYtCMFSBagsY6Uu9eQ-1
X-Mimecast-MFC-AGG-ID: G633FYtCMFSBagsY6Uu9eQ_1764279820
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779da35d27so12942775e9.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764279820; x=1764884620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rmd+WwZSNaXrPoCe94WZRqaNLCd4FVEQ1XchwHB+HkI=;
        b=WGQj9OybijnQJjTCQhiNi9EKj0Z35gYQ+b0vTdjh4np/fXMs9Rd/iwNOXotJTRA3Xy
         AqPQI8Tkwhh/ku4s/pctYvk70Et03duMrS0chcqFCwpoXMLW5zOASg2utwmnhEqUpWgE
         Y7dV59hbeq1QS2UAjd/oJtwMsfGSTzvU2c5E9mmmKF3L9sUDvixkJ8NywCd9jzrIkVlq
         PchScEzg2L2gCjyPVHECFqCm8HxrpaLr1ezfr4fZ/n7vZDItc2z72sFnBlFXHMKKLzIu
         +/qyLedqTsBOyeriHjuChPTrIWksSzjWPvk5qjrV35iXYlWRAtIzM7DGSSa1Tk9YgBl8
         bJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764279820; x=1764884620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rmd+WwZSNaXrPoCe94WZRqaNLCd4FVEQ1XchwHB+HkI=;
        b=X+N1TQErFPzehc1W/AIufY3kNXjd7s3w5trFiFoRVYSbH+01ZukAgt7mCDxt4J3TAb
         mADsw94diXAhmJGhNFl0K/H+OwM8bWd1wL/Z0pN8sXO19JALtQBtEZdCTc1W3LBdkUx0
         fapiv7WXsLumNqls3ZSSMJtWd0GH7/CMuJ1KZEzy4For0+QvQSnq9T8HgTXI88t/HJEq
         Gceud+ettm2FmoWoAdyWvM+VvgKhH8iKGA6Vd263xFX2HyZz/cfuA9Kwu5qtSFd5sR/h
         TQKd9eaCg89o0gXvgZ31stpI1h2mpB9PsaCZ4zK++rUajuyAo/nOfd4o+vO2JV4tk4le
         9vbg==
X-Forwarded-Encrypted: i=1; AJvYcCWhGx9cXJMh7NlSROn+kRsJl/3/DDAbvtrP3Sslu9MfPuviELummuYa9EyM9IcaweqmTqvCR9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+0bt7ulb03gj18e5uzGL99SvLFDDbmudmLduSK3GArJY6dty
	Cum94kc5YKCYahnNWpxB7/5qwwGScEzrZH6I3BnkGCxSkMYNT9DccUl2DwTvRZ8s+sj9z3B0qrc
	4zH183WOO2xE0LjwWycGDMgmj20cDY9zCrPidnXXF6EoQnm8Z4uObEu0h3g==
X-Gm-Gg: ASbGncsYJPN9Qf73cjh9lywav+oAPQvk+BFK+bmcSOBU8HKh1FjUsDVTf+n2nJd38Qt
	sHwts4D3pcgLn04S1uh8eW6gDZN2ghXzpN9n6KGjLuWzBUw6NEt8hMC3NLdhs5OST18a5E4Fard
	nUbGDASEK15a6+/1Eym/Eyg2aviN2JCtnkvSjdrlobgoqLYlqxQRZGLNQmy6WpwF7jSqWLIN4tP
	LXe9cmzUZOu8K/D/eqpU+QKefEZmU71Np79aukGGkATQ3oI2WpsJSRCRzqBR9wbbV2P2ftLtYW1
	FhvV0qBnUtK0aFaplqWXpXSjDxVnBypdr6U0EwBuxBiAdXDrbcn7lymw2+ipxJKYkcw9mgqeiRZ
	IiZdi8jaDsQCabv4NhfnQ+QLHI/WCd5cgeNUdNOfwcbrA+VAaxPulOn/fZA==
X-Received: by 2002:a05:600c:1c92:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-47904b2c2c5mr138281705e9.33.1764279819998;
        Thu, 27 Nov 2025 13:43:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXXf6/SEipU5bJNSwYKqmwwhxS5tmX7Fw0FrTg/n4XP0erG5YTHWaveZPn5EnBOq/Xs9zVKA==
X-Received: by 2002:a05:600c:1c92:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-47904b2c2c5mr138281525e9.33.1764279819573;
        Thu, 27 Nov 2025 13:43:39 -0800 (PST)
Received: from localhost (net-37-119-153-93.cust.vodafonedsl.it. [37.119.153.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052def4bsm73764995e9.13.2025.11.27.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 13:43:38 -0800 (PST)
Date: Thu, 27 Nov 2025 22:43:37 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
	fw@strlen.de, horms@kernel.org
Subject: Re: [PATCH net-next,v2 00/16] Netfilter updates for net-next
Message-ID: <aSjGCWTaL4z47foL@lore-desk>
References: <20251126205611.1284486-1-pablo@netfilter.org>
 <4362bcbe-4e82-4198-955f-e64b3ff2d9c9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EblDO+RRdf3PTIXa"
Content-Disposition: inline
In-Reply-To: <4362bcbe-4e82-4198-955f-e64b3ff2d9c9@redhat.com>


--EblDO+RRdf3PTIXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 11/26/25 9:55 PM, Pablo Neira Ayuso wrote:
> > v2: - Move ifidx to avoid adding a hole, per Eric Dumazet.
> >     - Update pppoe xmit inline patch description, per Qingfang Deng.
> >=20
> > -o-
> >=20
> > Hi,
> >=20
> > The following batch contains Netfilter updates for net-next:
> > =20
> > 1) Move the flowtable path discovery code to its own file, the
> >    nft_flow_offload.c mixes the nf_tables evaluation with the path
> >    discovery logic, just split this in two for clarity.
> > =20
> > 2) Consolidate flowtable xmit path by using dev_queue_xmit() and the
> >    real device behind the layer 2 vlan/pppoe device. This allows to
> >    inline encapsulation. After this update, hw_ifidx can be removed
> >    since both ifidx and hw_ifidx now point to the same device.
> > =20
> > 3) Support for IPIP encapsulation in the flowtable, extend selftest
> >    to cover for this new layer 3 offload, from Lorenzo Bianconi.
> > =20
> > 4) Push down the skb into the conncount API to fix duplicates in the
> >    conncount list for packets with non-confirmed conntrack entries,
> >    this is due to an optimization introduced in d265929930e2
> >    ("netfilter: nf_conncount: reduce unnecessary GC").
> >    From Fernando Fernandez Mancera.
> > =20
> > 5) In conncount, disable BH when performing garbage collection=20
> >    to consolidate existing behaviour in the conncount API, also
> >    from Fernando.
> > =20
> > 6) A matching packet with a confirmed conntrack invokes GC if
> >    conncount reaches the limit in an attempt to release slots.
> >    This allows the existing extensions to be used for real conntrack
> >    counting, not just limiting new connections, from Fernando.
> > =20
> > 7) Support for updating ct count objects in nf_tables, from Fernando.
> > =20
> > 8) Extend nft_flowtables.sh selftest to send IPv6 TCP traffic,
> >    from Lorenzo Bianconi.
> > =20
> > 9) Fixes for UAPI kernel-doc documentation, from Randy Dunlap.
> >=20
> > Please, pull these changes from:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git n=
f-next-25-11-26
> >=20
> > Thanks.
>=20
> The AI review tool found a few possible issue on this PR:
>=20
> https://netdev-ai.bots.linux.dev/ai-review.html?id=3Dfd5a6706-c2f8-4cf2-a=
220-0c01492fdb90
>=20
> I'm still digging the report, but I think that at least first item
> reported (possibly wrong ifidx used in nf_flow_offload_ipv6_hook() by
> patch "netfilter: flowtable: consolidate xmit path") makes sense.
>=20
> I *think* that at least for that specific point it would be better to
> follow-up on net (as opposed to a v3 and possibly miss the cycle), but
> could you please have a look at that report, too?

I think in nf_flow_offload_ipv6_hook() for the FLOW_OFFLOAD_XMIT_NEIGH case=
 we
should use tuplehash->tuple.ifidx instead of tuplehash->tuple.out.ifidx.
Something like:

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table=
_ip.c
index e128b0fe9a7b..78883343e5d6 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -951,7 +951,7 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *s=
kb,
 	switch (tuplehash->tuple.xmit_type) {
 	case FLOW_OFFLOAD_XMIT_NEIGH:
 		rt =3D dst_rt6_info(tuplehash->tuple.dst_cache);
-		xmit.outdev =3D dev_get_by_index_rcu(state->net, tuplehash->tuple.out.if=
idx);
+		xmit.outdev =3D dev_get_by_index_rcu(state->net, tuplehash->tuple.ifidx);
 		if (!xmit.outdev) {
 			flow_offload_teardown(flow);
 			return NF_DROP;

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Paolo
>=20
>=20

--EblDO+RRdf3PTIXa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaSjGCQAKCRA6cBh0uS2t
rHAnAQDTPmgITwQ6I0gwRXEIuZKeRAKwNbahXOTN1EM4nOJnIQEA0QfH9dBh3sWp
5TZW9Zlm5fmfK3f7QxbQMpMAwG2xrQs=
=lpni
-----END PGP SIGNATURE-----

--EblDO+RRdf3PTIXa--


