Return-Path: <netdev+bounces-264010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDH7ILWDqGmgvQAAu9opvQ
	(envelope-from <netdev+bounces-264010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:10:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EECC7206F04
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CB34301F78B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502F43D3CFD;
	Wed,  4 Mar 2026 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy35ToS3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CA358D27;
	Wed,  4 Mar 2026 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772651212; cv=none; b=bC+JEodoy4PO6VwZYu7NSgfe4x2CIllz3nUBN4meWBReWjPKlUybEg579cZXWd1DMFeDWblFlv5g1bPxPSLKF7Sgq2jzuf5ExfEo8pfbREhrczRUzMMzGwB3KmH8qUmjdKcmOQ3FWgZh7zEeItzIeFSBESK8PtdUa6bW2GB00B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772651212; c=relaxed/simple;
	bh=ZBbz/4pMl66VuJ7NOaXWlWQQszEhPGX6Web3VLQthbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlsceU82PzdU43TvM4k12YGKxfvIVrbC8TfH+Z4Dg+jqG2WjRdcSB4/5u49mUSQycNnxykf1ScNW8zOvtCV+ygftxPQLGUU9BI9KIbAT1BbnbR5FCtGoeW+CVuqc6WAmu16cjSk9wnRP1iOm0nAb5tlnP6xnfYQy++z424G0/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy35ToS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43513C4CEF7;
	Wed,  4 Mar 2026 19:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772651211;
	bh=ZBbz/4pMl66VuJ7NOaXWlWQQszEhPGX6Web3VLQthbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xy35ToS3hhHn6tWBb2KpO0CcsE4iZ1ttiQDkmVr/Qz/bFh8s2d6TAk6Vt0HTF7EXe
	 kMXRhxJj6tGEI8vdrpPoleKeXsv2YFccT6gPZpivEoaqBjgxzHCq7NQJ5lpTd1FXg3
	 hoXiO/zDk7lKjfz9BSqbS7WfSDoKb+2I9mxCn2XmxU2KB9DzVhMym1rV4G+WsdVpAd
	 Ztve3mRG6zsd+JCAYljlWaZ8TEfJUb88SE+b/cm86OIIGzsCvxTYVPADvIioEl58CJ
	 UtUGKgaZjcMWR5OhioYLAcwfdDmr/xXlKsznTgEjH45X/YURlMXeqQyqLffr8ga5K9
	 ayzBoa3ZBzM7Q==
Date: Wed, 4 Mar 2026 19:06:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Message-ID: <20260304-capture-kissable-3bdfe389864b@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
 <20260303-disperser-clone-512efa99f26c@spud>
 <65fd5f46f1f996dd5f4df2de2efb52c8fa3575b3.camel@microchip.com>
 <20260304161457.l6tkxix6sgube3qc@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b6bV6EY6NMjXdDw4"
Content-Disposition: inline
In-Reply-To: <20260304161457.l6tkxix6sgube3qc@skbuf>
X-Rspamd-Queue-Id: EECC7206F04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264010-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,0.0.0.0:email,0.61.9.0:email]
X-Rspamd-Action: no action


--b6bV6EY6NMjXdDw4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 06:14:57PM +0200, Vladimir Oltean wrote:
> On Wed, Mar 04, 2026 at 05:10:11PM +0100, Jens Emil Schulz Ostergaard wro=
te:
> > On Tue, 2026-03-03 at 18:56 +0000, Conor Dooley wrote:
> > > On Tue, Mar 03, 2026 at 01:22:28PM +0100, Jens Emil Schulz =D8stergaa=
rd wrote:
> > > > +examples:
> > > > +  - |
> > > > +    soc {
> > > > +        #address-cells =3D <1>;
> > > > +        #size-cells =3D <0>;
> > > > +
> > > > +      ethernet-switch@0 {
> > > > +        reg =3D <0>;
> > >=20
> > > Also, this is an odd example, why are you at address 0 on a "soc" bus,
> > > which usually means that this device on an AXI/AHB bus, and 0 is very
> > > unusual for that. Obviously the example doesn't have to match the real
> > > user, but this stands out.
> > > I may have some follow up questions I think depending on your answer.
> >=20
> > The intended way to bind this driver is via a parent MFD driver which s=
ets
> > up the SPI register protocol, initiates regmaps and distributes them to=
 child
> > devices (like this DSA driver).
> >=20
> > Similar to mscc,vsc7512 in drivers/mfd/ocelot-spi.c.
> >=20
> > This MFD would be the soc node. All child nodes perform register IO over
> > spi, using the regmaps requested from this parent so I think the addres=
ses
> > on the bus are purely ornamental. Should I write the smallest register
> > address in all regions used by the DSA driver instead?
>=20
> They are not ornamental, they should be the same addresses you'd put if
> Linux had direct access to the SoC interconnect for MMIO, rather than to
> an SPI bridge to the SoC interconnect. Or at least I don't see why it
> wouldn't be that way.

I don't mind if they're made up addresses, but the example should be
realistic. 0 is likely not realistic, but if it was 0x4000_0000 when the
real thing is 0x8123_1234 then I don't really care. Since the parent is
not actually a soc bus, can't you just remove this fake parent entirely,
like the ocelot switch example does? Or insert something more genuine,
like:
spi {
  #address-cells =3D <1>;
  #size-cells =3D <0>;

  soc@0 {
    compatible =3D "microchip,lan96455s";
    reg =3D <0>;
    #address-cells =3D <1>;
    #size-cells =3D <1>;

    ethernet-switch@4000000 {
      reg =3D <4000000 44>;


--b6bV6EY6NMjXdDw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaiCxQAKCRB4tDGHoIJi
0pNbAP9uGOb02KpKec1SzZegVdL/v1K3XiSjnA1dmjqNkh21gwEAz6KT6TLUzASJ
fKWAfv4fQQ8yAChtiSlXCOIuW3RZkwU=
=MGus
-----END PGP SIGNATURE-----

--b6bV6EY6NMjXdDw4--

