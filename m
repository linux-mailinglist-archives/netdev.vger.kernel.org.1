Return-Path: <netdev+bounces-71949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0E285597A
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E2E1F2C631
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C707539A;
	Thu, 15 Feb 2024 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="km7+/mdt"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FD17C8
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707967303; cv=none; b=hAlPLLVasb3p/E16I/sX+HRKkSXUDekQeiE1p41v/rx05XUwh980HaA+0E6m6t/K9rJImZq6RWYACzutLkeaS+ZiXWYXjlKXKADmoHM+FHHHaIjio9B9X0HqYdK2p+Cbb92AQ2qTTSkaTf1rcemlK+Bj52oMGsO6lmXCWx8nDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707967303; c=relaxed/simple;
	bh=Xa52XuBXwKlCT2MkEldQpbvh49LWo0PRdij5X46u1xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjFTopA129JwvSsrGkxPa7ZLXEPdk0LKXdQw1tNQ8Pph/1ZeIdZi+PdaqZv/8bv0eUVpnre5Indj/Jvqy7lk3efXweD+Hrs3Io6/jTEGnBGJSoSORmSUUYqnB3p6iE5m0qAUKqAiWx4gUtxCuLtfQA67cb5dB/Ky51QgAdUpOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=km7+/mdt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202312; t=1707967298;
	bh=rnHzf92yD4uRsRd2oNfSkrp/j4ljgooR97ufYJoihTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=km7+/mdtUturf0JEDib2mhpriuePD2lnkLnhhVHnw8iC6ZcwiY6YjcWcsoDL3LEFk
	 byiXMy0cPgiD7H3hi4RPWWnDEwq516k8HlIxw/tmNM9F5E6fSldegVIcQ7fCYxbTud
	 +9tDMEBtbd4HYl2qQDcaM9H9FtlaDVlKD7ORk9FfWVpTvNsOW3nIWMokTYDnDTRf5b
	 tu5hQHrcyZUxZduLQqn3ffIFnCMIlk5EO1xJFGwMa+j2m3ex65D1pnlJa7crf7UzUI
	 rAVr0Yrl3Ib4pggbnMaJlxzNlJUZuBzpzi3dYVA6AeuocutwQjCwlwuWo+qp7uhhGT
	 +246rVggEAalw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4Tb0hy47pQz4x0m; Thu, 15 Feb 2024 14:21:38 +1100 (AEDT)
Date: Thu, 15 Feb 2024 14:16:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, passt-dev@passt.top,
	sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
	jmaloy@redhat.com, netdev@vger.kernel.org, davem@davemloft.net,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
Message-ID: <Zc2CCXkGnrdnm_Bh@zatzit>
References: <20240209221233.3150253-1-jmaloy@redhat.com>
 <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
 <Zcv8mjlWE7F9Of93@zatzit>
 <CANn89iL4L_J4G4+3qoetv2n9m8xaE6KK0jASmOnJsjYR_DefeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rHD/BlOAYP5VsFOW"
Content-Disposition: inline
In-Reply-To: <CANn89iL4L_J4G4+3qoetv2n9m8xaE6KK0jASmOnJsjYR_DefeA@mail.gmail.com>


--rHD/BlOAYP5VsFOW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 04:41:14AM +0100, Eric Dumazet wrote:
> On Wed, Feb 14, 2024 at 12:34=E2=80=AFAM David Gibson
> <david@gibson.dropbear.id.au> wrote:
> >
> >
> > > BTW I see the man pages say SO_PEEK_OFF is "is currently supported
> > > only for unix(7) sockets"
> >
> > Yes, this patch is explicitly aiming to change that.
>=20
> I was pointing out that UDP is supposed to support it already, since 2016,
> the manpage should mention UDP already.

Oh, sorry, I misunderstood.  I tend to forget about this applied to
datagram sockets, since we have no use for that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rHD/BlOAYP5VsFOW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmXNgggACgkQzQJF27ox
2Ge33A//XmkPlSIoJt/V0GJTQJvVTFLl57CdQQNpl5jBAvASFAZNCUWPelEMRDwy
jQxd+BqGZ87sG6oiPjJftHrnOOGxFBrE4uqKLdA9Hscgbb2AbF2+lH86vxOduRjZ
sBkVzWy4NxfGicEk1vWqwknrrUPkzl3UyKkQa8hHtoHNn0otwRCY2x6QsbJJmhS5
xv4QTZNH+deZjAse45iXCZRyggfvk/OdWVZFIPVAfi3RB+zhSfSbYv8D/2w0XZXP
khFvNJhm/eNjrMgt+HsGqaXGrd3UfjqIOF4GtQWSkoeaDwh4u5Yst3a6w0Vl/83c
oB04VPxReO9XNPpp80q1VEPq/FJzNEg55Q4SrsP4hcAiTvGk6WhC1dJG40raBNrC
PlFSvgqgrwrTjfrvpbpeYOFJZc11+mHKvmqFonjymje3sXiSDgGZNKabRom55nvy
DdSkBY3QvsqxSLFXrABegovoz0uwdkN0Hu+I9mJbQNvaX4TZd5HlwvhtHNB/ruhN
SGTTbJzwS/H67q/9Owx0yrLElMvXsT/pmLIvUGa8ywH3zslyML/+sLcr9PFIxKam
atrIvE8y3FMql72Fg7TeHnNR0TJFSqroXSZN25XrxVDAQvGEvHvVPNb+DPYDfm/G
eia/ZqUN7Sv7lM5bt+Xxhp93XZDofew8F95dht63dZnEDOaa1C4=
=mJEX
-----END PGP SIGNATURE-----

--rHD/BlOAYP5VsFOW--

