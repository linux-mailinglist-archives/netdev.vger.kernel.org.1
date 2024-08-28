Return-Path: <netdev+bounces-122733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD5F9625AC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D6B1C22AD3
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971FA16F900;
	Wed, 28 Aug 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAy9xtd4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62B16A935;
	Wed, 28 Aug 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843612; cv=none; b=KRVSLC9WT8S03tXSxxxjQ5fX/N/zb+5wAZ1l/1T/xivacq03b11OAZSMxsK2n+XQ2QdGnh2bVHUqO28gRXH4LxIY5kTvXas0OlY5SbjhIo19nzvh40Cw33IWJNR9iKW3MBCthSKgVizbGf5cazIud4y/LldsUHAPRe/+1a60rPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843612; c=relaxed/simple;
	bh=deDpS1aspw9+N200elRaeUv7cFSqpIfI++0lWoCD/ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXp3XrF83NOnmky//6GJ5ti3P2qxoYATugAyNvIDlFQ7fpmmOCKXDnjvsg4MuDlIhRhJxXjsbGI5FlkZYvFEf14bjhY4JlScg2JHFDKrmRmqwoUl6CkwsKuOHRHpCmz66TzLDE44nnPufLyqWm1UWSu0oGojy+9TAmME6QSd0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAy9xtd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D16DC98EC6;
	Wed, 28 Aug 2024 11:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724843610;
	bh=deDpS1aspw9+N200elRaeUv7cFSqpIfI++0lWoCD/ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAy9xtd44qgrEX0I1Icqvv2wT3D+O2qPSLDxehKxsREd8/LeD5x4I8K8GJsmuIuFt
	 /sHYr3flLotbCiri9t1bjDC0LEI8BfUG8JOenCtG13ZOSvJGf+buNQZ1uuN+3fgo7P
	 krr7qDGAz2GK/racreQaFmW8gIz3QPx3OUBZBy5wFuD0E6t981PKvaB4ptcjar2+Su
	 bsSDhnBMBDV8FkW/pjeKhhTKS+oKmrC6/aj/Hu/QZkA8BhdmSegb5oBy56Tgnr0i1/
	 vNoo57KVy+eredz8ly8x60bqrlb8Brd9LyTlI3IXeSgIdjRNT53kcPN4sUTX3EO6QX
	 0ms62ckz8sfTA==
Date: Wed, 28 Aug 2024 12:13:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: microchip: Use standard regmap locking
Message-ID: <f0021a00-bc3b-4278-b4b7-29ead8e39f6a@sirena.org.uk>
References: <20240822-net-dsa-microchip-regmap-locking-v1-1-d557073b883c@kernel.org>
 <36f312eb-150e-4497-84f0-6bfbaab16d9b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZoE1yP+8aFZckdOY"
Content-Disposition: inline
In-Reply-To: <36f312eb-150e-4497-84f0-6bfbaab16d9b@redhat.com>
X-Cookie: You are number 6!  Who is number one?


--ZoE1yP+8aFZckdOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 02:54:52PM +0200, Paolo Abeni wrote:
> On 8/22/24 21:53, Mark Brown wrote:
> > For unclear reasons the ksz drivers use custom regmap locking which is
> > simply a wrapper around a standard mutex.
>=20
> According to the commit introducing such lock,
> 013572a236ef53cbd1e315e0acf2ee632cc816d4
> the ksz driver family one regmap per register width (8/16/32), accessing =
the
> same set of registers.
>=20
> The locking implemented with the code removed here allows serializing
> operations using different register widths.

This really could use a comment somewhere.

--ZoE1yP+8aFZckdOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbPBlUACgkQJNaLcl1U
h9B4AQf/QULpPvWgsB2LPLQvLjIY0N4dZ3gVg0VvX1wYaor4BiSOdwEOfBGeH37r
jfXy9N2hAm3WYxjRDUpSe3EHUEzRMT10pZFA39L69+etsLVc/Ycqjp2OeSax00Fg
4OvVgMUFNlvllhk6Rc6vBEmGVHKfReedcDBymh3bIYjQBTynAwQN4NlRVJ2gAJdy
PwA8TGH+sYOvNzK4KWkB+UvDQTBPlHk1GMPYdu264fJlTprkcTVqvHH2PHcILMux
U9Ajn/Klkt2ZlK+BWrfO24t7KtrbyVQqDk2IHGF+BifVX2vIA20iUKUfUI3RL9Ps
ncjRqoEokOVOGlSSVyuuiHqYeYRP7Q==
=xUWu
-----END PGP SIGNATURE-----

--ZoE1yP+8aFZckdOY--

