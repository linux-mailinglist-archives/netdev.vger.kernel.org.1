Return-Path: <netdev+bounces-266735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNQ4EXWzsWnbEgAAu9opvQ
	(envelope-from <netdev+bounces-266735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:24:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B85472688C0
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 777ED3007E3E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA503E1CE5;
	Wed, 11 Mar 2026 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh0syDTu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753635FF6B;
	Wed, 11 Mar 2026 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253421; cv=none; b=u4s5JXU47EZnKCQiVg56+pnpnnc5oe3eTV+CpA15cbMKlyD2peUd/F9ZiUSNW+WiZ4U3BKRKyJeXET/RyC+VQKj8ZSRZyStJyNENNmDqVBlBJpL4hpU1rfvn9z73KNC9tVUNYrsaK4Luqz465qgw+3EZYkemo6GEIUlEBhNA5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253421; c=relaxed/simple;
	bh=ocjt5vwimI3OcRNQ9GJF62QrRGoM9nphmFiMncx99d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugi1ue+C667ACXj9AO1oOBPYdOZFCFZg8A4Pg1uaDEkT8TKFollZHlGS9WiikuSvpfmQjfUYSkBZTX6VEWGGMmEfTUcXASFXZ063GS7Gl6FdgpKjyuN3BwyO0Vde6IdLK40qfNE3PDS8fcXWp/bXmsmpKNWO++ssc6bqgkMo/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh0syDTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09ABC4CEF7;
	Wed, 11 Mar 2026 18:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773253421;
	bh=ocjt5vwimI3OcRNQ9GJF62QrRGoM9nphmFiMncx99d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jh0syDTuPGlCIJcW+M03biC9MD1BSrWIP3A2NTEUP1JrpKu0XGWIvH8BHRdDVrLYn
	 3H2pp19smANQGCSPcgA1+V6gOhXv5krWlLsv+qhHxaqH1A4sD7e4zyowAt0o5534el
	 NuqXR7txtu53ez9Cu5oPWoXaRoZP5LI6O6Ll47c1DjH1HkjdymQzGpT5Y36IClDnKa
	 z46tVvR9JXE6445EiXgQwHrITSwr95F8gdCYXu2ECyl00avt+ez7zJ3I2v81AGgLWH
	 G0sPyTeSzy3JScSirykSHS9TfGB0x2lCRL8lak2vEYkhrZs8a8MlFJ/cJtRalK0EHi
	 teSkdUvbeM6ow==
Date: Wed, 11 Mar 2026 18:23:33 +0000
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
Message-ID: <20260311-scorebook-comfy-95dd9c18e713@spud>
References: <20260310-moneyless-dispense-7bce14b16388@spud>
 <20260310-sneak-handclap-c150d8f1236b@spud>
 <20260311-horned-dexterous-caribou-3a46fb@quoll>
 <20260311-rival-kerosene-81d12381d120@spud>
 <8f6eb4f0-50b7-4894-b990-98563f1e6b3b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YXCI42bSO6w3ujPD"
Content-Disposition: inline
In-Reply-To: <8f6eb4f0-50b7-4894-b990-98563f1e6b3b@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-266735-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B85472688C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--YXCI42bSO6w3ujPD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 07:10:09PM +0100, Krzysztof Kozlowski wrote:
> On 11/03/2026 19:08, Conor Dooley wrote:
> > On Wed, Mar 11, 2026 at 08:00:54AM +0100, Krzysztof Kozlowski wrote:
> >> On Tue, Mar 10, 2026 at 05:17:10PM +0000, Conor Dooley wrote:
> >>> From: Conor Dooley <conor.dooley@microchip.com>
> >>>
> >>> Ryan added cdns,refclk-ext with the intent of decoupling the source of
> >>> the reference clock on sama7g5 (and related platforms) from the
> >>> compatible. Unfortunately, the default for sama7g5-emac is an external
> >>> reference clock, so this property had no effect there, so that
> >>> compatibility with older devicetrees is preserved.
> >>> Replace cdns,refclk-ext with one that supports both default states and
> >>> therefore is usable for sama7g5-emac.
> >>>
> >>> For now, limit it to only the platforms that have USRIO controlled
> >>> reference clock selection, but this could be generalised in the futur=
e.
> >>>
> >>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >>> ---
> >>>  .../devicetree/bindings/net/cdns,macb.yaml    | 39 ++++++++++++++++-=
--
> >>>  1 file changed, 34 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/D=
ocumentation/devicetree/bindings/net/cdns,macb.yaml
> >>> index cb14c35ba9969..a492357570edd 100644
> >>> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> >>> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> >>> @@ -120,12 +120,14 @@ properties:
> >>>    power-domains:
> >>>      maxItems: 1
> >>> =20
> >>> -  cdns,refclk-ext:
> >>> -    type: boolean
> >>
> >> This is already an implemented ABI, so you cannot drop it even if some
> >> devices works fine on default. Instead please deprecate it and keep
> >> drivers backwards compatible for whoever is using it.
> >=20
> > The driver still will support it for those devices, but I don't see any
> > value in keeping the property about, even deprecated, when it doesn't
> > work properly. If you insist that it be kept and marked deprecated, it
>=20
> There cannot be an undocumented ABI, so if driver has it, it must stay
> in the bindings.

Right that's something I should have considered.
I'll keep it so.

> > needs conditional rules to only permit it on devices that it actually
> > does something. I'm surprised you even considered that I would drop
> > support for it from the driver!
>=20
> Commit msg suggested it is no-op, thus could be dropped without having
> impact?

Nah, it's not an NOP. Commit message maybe reads that way because I was
trying to avoid mentioning the driver implementation details. I think I
could do a better job talking about sama7g5-emac versus sama7g5-gem in
the commit message, which would show that the current property has a use
case, just not as broad as it was intended to be.

The existing property was added along with a driver change that modified
sama7g5-emac which had a default of external to default to internal instead,
and the property could be used to switch to external. sama7g5-gem had a
default of internal, so this change was done to make things uniform and
allow a single property to work for both devices.
That driver change was reverted to maintain backwards compatibility, so
the property became useless on sama7g5-emac, and there's currently no
way to make that device use an internal reference.

What I am doing here is probably what cdns,refclk-ext should have been
originally, but when the driver's defaults got reverted the whole series
probably should have been reverted so that Ryan could try again with a
new approach. Instead, the property went into a release but only works
on sama7g5-gem.


--YXCI42bSO6w3ujPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabGzJQAKCRB4tDGHoIJi
0vCKAQD8vsxMfMy5RvKzSgT1fRpIcjv03CKilR+jGFr3/HLlTgEA64rdr8VMBJs4
eFowRGumLH0nAesDGQeGPAGCeLfVvQg=
=Z2PE
-----END PGP SIGNATURE-----

--YXCI42bSO6w3ujPD--

