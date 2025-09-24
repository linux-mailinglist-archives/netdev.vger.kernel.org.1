Return-Path: <netdev+bounces-225747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C2B97EF7
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC61D7AC1B1
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B811D6194;
	Wed, 24 Sep 2025 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTfEFEyV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28431C1F12
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674683; cv=none; b=JtQYRcXGJfR+GhE3NiIjIGhXlax2zhK+BmT4AEQSoS03QeCaZl1Tdjg09PGJa9ETzOsJ5au9BW3rxGdJkKcwzYfUU98W8IKPLQAlQD0144e+CyMhQgG3nwtcl929586SjDuSZ/Vzr1i1RXJPobV1wRCO8gLClsKf+hSkgPYeRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674683; c=relaxed/simple;
	bh=hTQr85kA0S/LcGQ2RwxI7Wl9/Jj+qgPic2qJeDq6syY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT4E2FtJUnEhw2b3lMDFADZymELdDC98BaiOj/V3nNpvTeZEx0gRsLqCIXhZ2ROv2sdI1Mhf/Vy++Vfzzjm6vzDIZFbb4oZIt3fiiXtUky4YErAv+WXk+VR6SI8PJh2fvu3Vo7p1MURNbmAyN1RGzgxHImiP46REsuOfl/BYhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTfEFEyV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77db1bcf4d3so4723425b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 17:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758674681; x=1759279481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WLtIHDcQkQtcLlEdHD9/cC+Edaj0vfwf0Q7QH/dx80A=;
        b=nTfEFEyVoP/Dj+wW5yiHZBa0HBrVVmxKo50AeTGiMBh0ktODXrdv/6tA/H3Y8OoUAf
         5D6OXqa7wkB2kQwWURVAZmpUPdr7koszZTllbxZBm9w6wbb+CNSje4jZOmoe6M/Np3UF
         5GbdYTkG8QnV1dNraAaGt8SxlD79CcPjfIzoCFibe+ebX8MxKJeqP9TlvbJoJObDw7FN
         pXkuzBdutG3UUIcz6RIB2pT+yyJQqMTdGtlWsUiFpyqU9HlOKLGGv0X15Ptlyev87T0v
         +TQYbNfiyfpv/vKdcKoX8I7iLhSO3Q3xRrYN/JB4oErlMl+TsdezdUR8VWbkWE2H1eCB
         LKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758674681; x=1759279481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLtIHDcQkQtcLlEdHD9/cC+Edaj0vfwf0Q7QH/dx80A=;
        b=A4u84VDYd3evImBHfac9kTzhi5eopylHJDmy1K8iREOWNkOpQXDNB2yh3PFtLSSCNJ
         8IdgQvtmscDhj7fklvknYV546OouCxH0Pndiis6pAzQCRKFdumYTHNrLKGgw5nS8UBIW
         LSePx07sXxjo0nfeIorkSXeoRts37Ni3JVniQqLf+DUURo8L6IDpD4Z15Cl6HT+v0S7R
         JSLyRL98CNPWenLCw3XTf0BBhc5DyPrbtzeszsgt0i0hxkL7GYRvdlD/zXLKkO/RZXse
         jJ9EghCj6LPf9XH+1jV+o6Vhk0BXgF2TZX3x9I5wwMXbSrpdiE3YAng7fh0FpBmL0BeF
         Nupw==
X-Forwarded-Encrypted: i=1; AJvYcCVMewen/Ji7RsJZ+jgKFopNPp7lKnbYDefVZh5jbBHbA1NFFRpxC1xEzAjWEohCbDEgyN4A3m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdOkXxnBN6mWkHQeU0tpLqtiowffnvaaldI4+8AhkdVgnhkt1M
	fj+BbEFeFoGn8gJM7RSa8q/ZHwUQeukg6t8SoTYa676LFUOrDm3MrLO6
X-Gm-Gg: ASbGnctrIvQsTyMIc3C5hoOcPCu0CTDWQcQD5oncI4X7iPgm9vvG81vD2ZLA9OMoSAC
	Iyh4tStPiueg83/+HNYrD8iTJr1uBf4JmhNTFArthtmA2MhHNZjNjzeWpL3Z3L0z86dqdjbdMRy
	+c2A1AhHWB5x0TCDgJNee7FMjl5wpdGWcP9rw/og1xOLzIVTLjXZZ/wna2NWeDqqchR6Q+8s0dM
	us3zOYq7vEKZpTqVD+GI8MPBtlMoUSidUF9vrFSnh4vdkmOjrxshMKkjpMjTNhH3MqYGpx7tLTN
	9fESw9+81gZgjKQCkhOAWNfejd1J0IRBB6beUz8dfvRF/EMtMGbwUw/xJPbknjVWjJW55keN3Hp
	+kSUsg6UYEWzxBWekIxcNCQ==
X-Google-Smtp-Source: AGHT+IEfy8cwUlwEqoTLvwbqDRFwZQ4ApyvIBg2trLwd2EtpSVJd0XNuI6VI+4IYR4D1mOyiYMVWqg==
X-Received: by 2002:a17:903:3bce:b0:24a:fab6:d15a with SMTP id d9443c01a7336-27cc185851emr45338285ad.20.1758674680650;
        Tue, 23 Sep 2025 17:44:40 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053090sm173462105ad.23.2025.09.23.17.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 17:44:39 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A2B9F4206928; Wed, 24 Sep 2025 07:44:37 +0700 (WIB)
Date: Wed, 24 Sep 2025 07:44:37 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next 2/3] net: dns_resolver: Move dns_query()
 explanation out of code block
Message-ID: <aNM-9aXWTXITUoDw@archie.me>
References: <20250922095647.38390-2-bagasdotme@gmail.com>
 <20250922095647.38390-4-bagasdotme@gmail.com>
 <20250923101456.GI836419@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e/SObf14umAK1Sg6"
Content-Disposition: inline
In-Reply-To: <20250923101456.GI836419@horms.kernel.org>


--e/SObf14umAK1Sg6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:14:56AM +0100, Simon Horman wrote:
> On Mon, Sep 22, 2025 at 04:56:47PM +0700, Bagas Sanjaya wrote:
> > Documentation for dns_query() is placed in the function's literal code
> > block snippet instead. Move it out of there.
> >=20
> > Fixes: 9dfe1361261b ("docs: networking: convert dns_resolver.txt to ReS=
T")
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>=20
> Thanks, this renders much better. In a browser at least.
>=20
> I've added a few comments below.
>=20
> > ---
> >  Documentation/networking/dns_resolver.rst | 45 +++++++++++------------
> >  1 file changed, 22 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/=
networking/dns_resolver.rst
> > index 5cec37bedf9950..329fb21d005ccd 100644
> > --- a/Documentation/networking/dns_resolver.rst
> > +++ b/Documentation/networking/dns_resolver.rst
> > @@ -64,44 +64,43 @@ before the more general line given above as the fir=
st match is the one taken::
> >  Usage
> >  =3D=3D=3D=3D=3D
> > =20
> > -To make use of this facility, one of the following functions that are
> > -implemented in the module can be called after doing::
> > +To make use of this facility, the appropriate header must be included =
first::
>=20
> Maybe: ..., first linux/dns_resolver.h must be included.
>=20
> > =20
> >  	#include <linux/dns_resolver.h>
> > =20
> > -     ::
> > +Then you can make queries by calling::
>=20
> Please use imperative mood:
>=20
> Then queries may be made by calling::
>=20
> > =20
> >  	int dns_query(const char *type, const char *name, size_t namelen,
> >  		     const char *options, char **_result, time_t *_expiry);
> > =20
> > -     This is the basic access function.  It looks for a cached DNS que=
ry and if
> > -     it doesn't find it, it upcalls to userspace to make a new DNS que=
ry, which
> > -     may then be cached.  The key description is constructed as a stri=
ng of the
> > -     form::
> > +This is the basic access function.  It looks for a cached DNS query an=
d if
> > +it doesn't find it, it upcalls to userspace to make a new DNS query, w=
hich
> > +may then be cached.  The key description is constructed as a string of=
 the
> > +form::
> > =20
> >  		[<type>:]<name>
> > =20
> > -     where <type> optionally specifies the particular upcall program t=
o invoke,
> > -     and thus the type of query to do, and <name> specifies the string=
 to be
> > -     looked up.  The default query type is a straight hostname to IP a=
ddress
> > -     set lookup.
> > +where <type> optionally specifies the particular upcall program to inv=
oke,
> > +and thus the type of query to do, and <name> specifies the string to be
>=20
> I think while we are here "to do" could be removed.
> But maybe that's just me.
>=20
> > +looked up.  The default query type is a straight hostname to IP address
> > +set lookup.
>=20
> ...

Thanks for the wording suggestions! I'll apply them in v2.

--=20
An old man doll... just what I always wanted! - Clara

--e/SObf14umAK1Sg6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaNM+8AAKCRD2uYlJVVFO
o4HMAQDXuiy9uvRj/S1nF52q1p1aOvS1r/UzKDM1nsCmxInzHAD8Ci/ndAcRhr6y
Ve14PdLZ8XDnj6wD7ILRGAAuaC7c3gA=
=eWVB
-----END PGP SIGNATURE-----

--e/SObf14umAK1Sg6--

