Return-Path: <netdev+bounces-266732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JgSNKqvsWmzEQAAu9opvQ
	(envelope-from <netdev+bounces-266732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:08:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9402686BF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1BD6306375E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A13E6DD1;
	Wed, 11 Mar 2026 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqifVIMz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1A276058;
	Wed, 11 Mar 2026 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252520; cv=none; b=jOGSXKuu9EWnasM/dw/0ue2V7UffHr9OsAjpHNgXZGNygshw0sE1r14QS+sl3CGCr9RyR1+atUjfjhOGeMdAQDoJZt2IqDFxhMhZI3nvdwyQpiqeY+qFJ0HgxOjd7I07mZlsXrt3/p9qPXk/ezAyOPHxLUcvNWmfT6tfGrPBbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252520; c=relaxed/simple;
	bh=XawCcOA4Jr7tFQ8sqhyB8MmvC3bH5pq//7zAxd0ijr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSTSWh+Y93f/iMlDHItcf40dGwtl/iZsyY1gaMcGzLvrAnkUeCUa/XDfY73Z2mlFxDGLMGhrvbWhklB8TB7xY4QGY7U0tgYh+sYN01pn0539xZ2M6+I8UahyGKDrY9pLiUMkIZJLa1uum/ZvP6X1rZk9/SvdkD9cvRwCblA+MPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqifVIMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96420C4CEF7;
	Wed, 11 Mar 2026 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773252519;
	bh=XawCcOA4Jr7tFQ8sqhyB8MmvC3bH5pq//7zAxd0ijr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqifVIMzkcLUNr5eejYjS4DCibDuyB1iPk/MbTV0vH9WPWCHf4nVLPCk6Xo7++oLY
	 8omBpNuWrxXeaC6IqZ117GSz4cPM6ltPSe4ELb7YtUGIqzV/TrTYUy8TYb9dudvoBc
	 b15x3U1yfssSmQtQFCd5VUcN66HFXisy4feR4VujfMbbR0OCvygTm1hupxKL2ClVz/
	 MwHvNzRHKx9c9AFurFEiCcwN5pBgx3yYXABVw3MZ6UCIjPZrC7scuqKhT9XqCvVEph
	 hv3CJ3lP+c4XWN/NbHemPNkwC6CnF+hNc4lrq9VI1bX1m7kTpfjsv8cUzxuPAVthuc
	 eU2fEtiVemVcQ==
Date: Wed, 11 Mar 2026 18:08:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
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
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com
Subject: Re: [PATCH net-next v3 03/10] dt-bindings: net: cdns,macb: replace
 cdns,refclk-ext with cdns,refclk-source
Message-ID: <20260311-rival-kerosene-81d12381d120@spud>
References: <20260310-moneyless-dispense-7bce14b16388@spud>
 <20260310-sneak-handclap-c150d8f1236b@spud>
 <20260311-horned-dexterous-caribou-3a46fb@quoll>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CzbrZhLK2nJ/Peoo"
Content-Disposition: inline
In-Reply-To: <20260311-horned-dexterous-caribou-3a46fb@quoll>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266732-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 3E9402686BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--CzbrZhLK2nJ/Peoo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 08:00:54AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Mar 10, 2026 at 05:17:10PM +0000, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Ryan added cdns,refclk-ext with the intent of decoupling the source of
> > the reference clock on sama7g5 (and related platforms) from the
> > compatible. Unfortunately, the default for sama7g5-emac is an external
> > reference clock, so this property had no effect there, so that
> > compatibility with older devicetrees is preserved.
> > Replace cdns,refclk-ext with one that supports both default states and
> > therefore is usable for sama7g5-emac.
> >=20
> > For now, limit it to only the platforms that have USRIO controlled
> > reference clock selection, but this could be generalised in the future.
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../devicetree/bindings/net/cdns,macb.yaml    | 39 ++++++++++++++++---
> >  1 file changed, 34 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Doc=
umentation/devicetree/bindings/net/cdns,macb.yaml
> > index cb14c35ba9969..a492357570edd 100644
> > --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > @@ -120,12 +120,14 @@ properties:
> >    power-domains:
> >      maxItems: 1
> > =20
> > -  cdns,refclk-ext:
> > -    type: boolean
>=20
> This is already an implemented ABI, so you cannot drop it even if some
> devices works fine on default. Instead please deprecate it and keep
> drivers backwards compatible for whoever is using it.

The driver still will support it for those devices, but I don't see any
value in keeping the property about, even deprecated, when it doesn't
work properly. If you insist that it be kept and marked deprecated, it
needs conditional rules to only permit it on devices that it actually
does something. I'm surprised you even considered that I would drop
support for it from the driver!

> > +  cdns,refclk-source:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum:
> > +      - internal
> > +      - external
> >      description:
> > -      This selects if the REFCLK for RMII is provided by an external s=
ource.
> > -      For RGMII mode this selects if the 125MHz REF clock is provided =
by an external
> > -      source.
> > +      Select whether or not the refclk for RGMII or RMII is provided b=
y an
> > +      internal or external source. The default is device specific.
>=20
> Best regards,
> Krzysztof
>=20

--CzbrZhLK2nJ/Peoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabGvoAAKCRB4tDGHoIJi
0qYJAP9SsPtMLqsKLk3++GjsX/sVhVG2+UVwOXE5GD+tJz8eDQD+PEe3Z/ZeEbTq
g6twAbUPHM0gSKmKvD9509m1+an2Egs=
=PWoT
-----END PGP SIGNATURE-----

--CzbrZhLK2nJ/Peoo--

