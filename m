Return-Path: <netdev+bounces-292340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cII+C1IJF2pB2AcAu9opvQ
	(envelope-from <netdev+bounces-292340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:10:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A465E69B6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD59A301D6B6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C94421EFB;
	Wed, 27 May 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpXGPHSR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B5391E7F;
	Wed, 27 May 2026 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894262; cv=none; b=KYq3IAXKqJaipYG1Mvot5KGWOH5KGVT+sgeLIZKnHqDTjyjjPn7fM2omYwYLZobE//TG6s9CVAtlYwwsSND6oCWFQgCXJdbhRTlTBK13k56WbpCXguvlP4+WQZYIzHDUD1XBTCmtcDwoEkm9LaqoD2fLyAfMPbn6kt+yi2I5QuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894262; c=relaxed/simple;
	bh=w6HEAKDEa/0wh0FF4gSgd6z4Oa58mB2ADj+cSP4aDco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a25OxqW1rloD/1eAauRbkZbQ8W6uBp+m+hi4Y609JvngFIXLSWuNZ6fxqq/Smq/gZLajBvgADc4ZtnlHfE/3ObVICjFDJ4QTQs4dvsRgG9Uvw+IjQrDGlYwXdi2VKs5oBpheJivp+8IPfOkLoq0rPefOybWF2Ti8zw7pDX1BCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpXGPHSR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4009E1F000E9;
	Wed, 27 May 2026 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894261;
	bh=a46lvhu6W/RpCNjdFT7r/z68fKZ90kPPzD8qS3/JgWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PpXGPHSRypEOdaf6ZIyJEwZ49vb53BHCzIcFQMZ3cnohZ1eePvtKzm/lWcnFETZRp
	 Sw+AgW7Pc6ulkKTbnyXQsRu3/yu9FwbQPX+HU9tvp5r9ef1+HM632t3r7kumToKdxI
	 28Pr1FQC6DKDuA5GQ1+OeQOz+sWHvHiVj9sOpqAPjFfqqj+aLKZcG4i2tKYAjdiVrS
	 mcJOM+0SjZzTpEHUbjGiF26/GmTKTOpLTkXO9Iik0LzFkftWI3TgyKkQbea44/3MHn
	 lLJGUoWo9nsakTSty7dAKmg0l81Bm0MUUNPgc0uBQWuwLBLvp8T+rwk6YCU6IjJn+F
	 2pJmRUTZXcutQ==
Date: Wed, 27 May 2026 16:04:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Luke Howard <lukeh@padl.com>
Cc: netdev@vger.kernel.org, Kieran Tyrrell <kieran@sienda.com>,
	Max Hunter <max@huntershome.org>,
	Cedric Jehasse <cedric.jehasse@luminex.be>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] dt-bindings: net: dsa: mv88e6xxx: add
 mv88e6xxx-avb-mode property
Message-ID: <20260527-supplier-lively-a2b353dbd9ec@spud>
References: <cover.1779841530.git.lukeh@padl.com>
 <f0a4fc5e6918040b2c9a72da46a8cdcb43ed5049.1779841530.git.lukeh@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xYHcgdxXuADpqvpC"
Content-Disposition: inline
In-Reply-To: <f0a4fc5e6918040b2c9a72da46a8cdcb43ed5049.1779841530.git.lukeh@padl.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292340-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,sienda.com,huntershome.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,padl.com:email]
X-Rspamd-Queue-Id: 73A465E69B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--xYHcgdxXuADpqvpC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 10:42:52AM +1000, Luke Howard wrote:
> Add the vendor-specific marvell,mv88e6xxx-avb-mode property for adding
> stricter handling of frames with non-AVB frame priorities and destination
> addresses.
>=20
> Signed-off-by: Luke Howard <lukeh@padl.com>
> ---
>  .../bindings/net/dsa/marvell,mv88e6xxx.yaml   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.=
yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> index 19ae600e93394..1a01810e7682c 100644
> --- a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> @@ -97,6 +97,32 @@ properties:
>      required:
>        - compatible
> =20
> +  marvell,mv88e6xxx-avb-mode:

"marvell,avb-mode" should be sufficient here.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Marvell MV88E6xxx switches that support Audio Video Bridging /
> +      Time-Sensitive Networking (AVB/TSN) traffic prioritization can have
> +      ports configured in one of several modes. These modes control the
> +      handling of frames with non-AVB frame priorities and destination
> +      addresses.

I've got no idea if this is a valid thing to make a property for, but I
really don't like this things being integers when there's some pretty
clear strings you could use instead: standard, enhanced and secure.

Also, you're missing a default, which is required for optional
properties.

Cheers,
Conor.

pw-bot: changes-requested

> +    oneOf:
> +      - description:
> +          Standard Mode. Frames whose priority is mapped to an AVB
> +          traffic class (TC) are considered AVB frames; other frames are
> +          considered legacy (non-AVB).
> +        const: 0
> +      - description:
> +          Enhanced Mode. Frames whose priority is mapped to an AVB TC
> +          and for which a static FDB or MDB entry exists are considered
> +          AVB frames. Frames with an AVB TC but no matching FDB or MDB
> +          entry are dropped. AVB MDB entries can be added using the
> +          MDB_FLAGS_STREAM_RESERVED netlink flag.
> +        const: 1
> +      - description:
> +          Secure Mode. As Enhanced Mode, but the matching FDB or MDB
> +          entry must also have the source port's bit set.
> +        const: 2
> +
>  allOf:
>    - $ref: dsa.yaml#/$defs/ethernet-ports
> =20
> --=20
> 2.43.0
>=20
>=20

--xYHcgdxXuADpqvpC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahcH8AAKCRB4tDGHoIJi
0tpmAQCdbyrMQr253jKZGFi9LjCh/XGHHrnhQW7fWQ0zZYZHHAEAm+XYmWHHJo7D
jFIQa8rcebfVk6MTevQ8GF8oeQeQdwI=
=myjT
-----END PGP SIGNATURE-----

--xYHcgdxXuADpqvpC--

