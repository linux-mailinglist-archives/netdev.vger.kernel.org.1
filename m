Return-Path: <netdev+bounces-266739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMqBKqi0sWnbEgAAu9opvQ
	(envelope-from <netdev+bounces-266739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:30:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F782689FB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1006306C535
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B93E8C7A;
	Wed, 11 Mar 2026 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtP4RQTQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1C2E8DEF;
	Wed, 11 Mar 2026 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253659; cv=none; b=kXggo96UfhuIAlt8xxIs+drvA8W61+QY4RPxxoPsWfeP/nizJorgihN842d0/wWMp/0xis4UHCbTjWonulFIzT1u7mEhV8hL3CBERSgO5xUUb30588MwpXFLtO+jaMeiisHaqdSvYwM/+LERveZCBprvT9+Oi7aGpPvtb4e0G5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253659; c=relaxed/simple;
	bh=psbKm+JUIEOmVDxhlExsmkrYZCYiynHWiEWJ93E/oIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAqeevxI1FdPfuyeOse365ZqX4NnHQPue4ItrYvE7vBlzrBRLBGT4mG+9zn51N0UgGnyrHYurNPxQD+NJkqdHMK4sK/81JEQKEAuQZgN3PxnzQ2EuSW7JaW63HCwntBgmY01wDYXUUBL5WXx4qvEwTjqd84D2e9MPNQCsqQnMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtP4RQTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B17C4CEF7;
	Wed, 11 Mar 2026 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773253659;
	bh=psbKm+JUIEOmVDxhlExsmkrYZCYiynHWiEWJ93E/oIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtP4RQTQjVcXurfV+HjrB/RNKkQfN96ZR2NDOGYO/rWtfTDgc72vOznc27235rL3p
	 Af0Op11P45Yz/5cL7zb05FEaBhxV9zavR8QnZs4JAYo77juxoWuhjlRLxNHDlANyu8
	 M3Nm65Uyd/xRrfUs+XTOxwD6O8w5TSAiKPeZESb1iyzN/kcaaJX10YdAzppPRZYQkf
	 pdXoaR4z6MeiiIDkcv5wHa1+VfhxrgMXIPloVu+uneoxAql8gLnBtF3mTP5208WD4M
	 VEuiFNi0u2Mm39h+aUbKQBp91Nrlutd0dNIxnGoD6uXRAHdBpKUHy4R207/CZBo71+
	 GngxM7FZnMPZg==
Date: Wed, 11 Mar 2026 18:27:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: cdns,macb: add a
 compatible for Microchip pic64hpsc
Message-ID: <20260311-quickstep-helmet-ea7f37444cfc@spud>
References: <20260310212202.3991199-1-charles.perry@microchip.com>
 <20260310212202.3991199-2-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LzxDbwZaErEq3HMU"
Content-Disposition: inline
In-Reply-To: <20260310212202.3991199-2-charles.perry@microchip.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266739-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58F782689FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--LzxDbwZaErEq3HMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 02:22:00PM -0700, Charles Perry wrote:
> Add "microchip,pic64hpsc-gem" for "PIC64-HPSC" and
> "microchip,pic64hx-gem" for "PIC64HX", compatible with the former.
>=20
> The generic compatible "cdns,gem" works but offers limited features.
> Keep it as a fallback.
>=20
> The GEM IPs within pic64hpsc have their MDIO controllers
> unconnected from any physical pin. Add a check to prevent adding PHYs
> under the GEM node.
>=20
> Signed-off-by: Charles Perry <charles.perry@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../devicetree/bindings/net/cdns,macb.yaml    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Docum=
entation/devicetree/bindings/net/cdns,macb.yaml
> index cb14c35ba996..b934abd98e20 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -70,6 +70,14 @@ properties:
>                - microchip,sama7d65-gem   # Microchip SAMA7D65 gigabit et=
hernet interface
>            - const: microchip,sama7g5-gem # Microchip SAMA7G5 gigabit eth=
ernet interface
> =20
> +      - items:
> +          - const: microchip,pic64hpsc-gem # Microchip PIC64-HPSC
> +          - const: cdns,gem
> +      - items:
> +          - const: microchip,pic64hx-gem   # Microchip PIC64HX
> +          - const: microchip,pic64hpsc-gem # Microchip PIC64-HPSC
> +          - const: cdns,gem
> +
>    reg:
>      minItems: 1
>      items:
> @@ -196,6 +204,17 @@ allOf:
>        required:
>          - phys
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,p64h-gem
> +    then:
> +      patternProperties:
> +        "^ethernet-phy@[0-9a-f]$": false
> +      properties:
> +        mdio: false
> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.47.3
>=20

--LzxDbwZaErEq3HMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabG0FgAKCRB4tDGHoIJi
0vz+AQCTLDRkNbEjSXGxX44BY5pz1csSJ4nSQ+q9irleZdC0PgEApg7yHBTlVlQU
IdAb5Z+z9AzJHBfwC4qIO8pr2q+/Ewc=
=opRa
-----END PGP SIGNATURE-----

--LzxDbwZaErEq3HMU--

