Return-Path: <netdev+bounces-261296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDMhOPspoGlrfwQAu9opvQ
	(envelope-from <netdev+bounces-261296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:09:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078611A4DA7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67A2A3008D0A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DA3338599;
	Thu, 26 Feb 2026 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMwXjfJR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1470C336EF7;
	Thu, 26 Feb 2026 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104183; cv=none; b=QkF2MCbZPyoRMnwKTlze1HIS34WAiu93qhIcvjFQAmQOeQ0+BJtIJgcKB4Fjt9OkaZAHfCYZcPXhIcurxR1WdE6YJeKO0hbguWEFjj17VyLN9uuGwaBoUZ0/Z3YrFgkfx1/zHzFHKrXilEn+j6ZrzvX1AN30zOt+UVxT0g8DBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104183; c=relaxed/simple;
	bh=Kc3y4vF5C5ht3a1XMvsgWskMHYvLykSYzITc23T1NDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3ogPpjlAgkNTrM4SGDdteBmafvXXC4T4DLMUwRRnlXti99S5M7FcDZmGVXx3jJa8Fww6NESlIhEZRQg7PT4prv07HA//p/CkzSUvk/OvU9mJYHlXfrlcfEYrRmfKaKWiRuS4/SoOWJ7ZNFmNt8ipjLpHTMmStuJquhj6ZWRMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMwXjfJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE57C116C6;
	Thu, 26 Feb 2026 11:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772104182;
	bh=Kc3y4vF5C5ht3a1XMvsgWskMHYvLykSYzITc23T1NDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lMwXjfJRiBEVT78l5CXkOIawXNBob9Tdyzc3m9YFg/yr5NW3jo4xUaZtWPHv/0yac
	 /Hly1F07PxVhWGDQNVpxeu2kGBaCqUkT2niVyH2Y51jDtlazKYy4ZzF0zT64lhSV5o
	 LqftKpjqtq5SNHLyEZNtnrjab3+k7UHOZzkEAVCuK6S/GvLCFQcQA2x2unfm1lRdd+
	 3dnowboT25KCF+kAVqUMa4lMBCn4RSwnSPU6Qw/z3VOAKkQZVJulE82qq1AlLjkWcv
	 UStRFoipY7jmgC/3t5JHneFEUpm8fXDGBS6hTpKTLLiA2ZFH/pDkKky4e68MHVo1Z4
	 9KfmULnHylmTw==
Date: Thu, 26 Feb 2026 11:09:35 +0000
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Neil Armstrong <narmstrong@baylibre.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 1/8] riscv: dts: microchip: add tsu clock to
 macb on mpfs
Message-ID: <20260226-untimely-overcoat-a335a7016adc@spud>
References: <20260226-snowshoe-amusable-6716d4ddea11@spud>
 <20260226-briskly-severity-69c2988e8dc8@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HXcvzNaRR2Bb/QYt"
Content-Disposition: inline
In-Reply-To: <20260226-briskly-severity-69c2988e8dc8@spud>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261296-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,baylibre.com,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 078611A4DA7
X-Rspamd-Action: no action


--HXcvzNaRR2Bb/QYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 11:03:16AM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> In increment mode, the tsu clock for the macb is provided separately to
> the pck, usually the same clock as the reference to the rtc provided by
> an off-chip oscillator. pclk is 150 MHz typically, and the reference is
> either 100 MHz or 125 MHz, so having the tsu clock is required for
> correct rate selection.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/Makefile.orig | 26 +++++++++++++++++++++

Of course I noticed this only after sending, but this patch isn't for
net anyway so it's kinda moot and I could fix it myself on application
or in the likely v3.

--HXcvzNaRR2Bb/QYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaAp7wAKCRB4tDGHoIJi
0uBQAP0Sp42MPDxWXYk+ByvyugQefv2Lt1layvBUVWDkCGvzLwD6A8UBJsHEysQT
QWWCpEpvz0l96P/zT0bSG3dWzXFJhQI=
=Mz+3
-----END PGP SIGNATURE-----

--HXcvzNaRR2Bb/QYt--

