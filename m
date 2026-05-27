Return-Path: <netdev+bounces-292351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wClILeYKF2pB2AcAu9opvQ
	(envelope-from <netdev+bounces-292351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:16:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF4A5E6B61
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 257A13058E37
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86782426D02;
	Wed, 27 May 2026 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtlMFHpX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0681427A;
	Wed, 27 May 2026 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894703; cv=none; b=EiYH3GAIhcg+5YSmq4UJDVej/3epQHIyfWuaLkV6o1xA7lZMonBCtpgtK1I1ovfayDeojswqpk+ZqXQXy3XNqoFwoi8+4DTAt/suX5IbxCm0fWDSw1POuCemmYSHq2Os/Ze5GPOQDVM3sTqESSM9aurN2Yj8YeGwMgsS5AJao1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894703; c=relaxed/simple;
	bh=rtfO5ujh7fvtxf8EwxH550DcHIe38LI9ALq52mY17DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQkQXkdxLqPvbqAuwuQ5PztQ5662vbqqv4RklRFZAyfpHp112T0pe8hK5CQG3obe7p38/5LTm70uamsf1HAVewXJ6N3U3R14JdClMqlkNhvQOiVwq4DHROR43W++OVqUNEbkIhGw81jTh+z9cOO/3Gqf9Slmdex+VFn5BovSBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtlMFHpX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D24B1F000E9;
	Wed, 27 May 2026 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894701;
	bh=YgZzYt5mfaIHlmQ0ek8+Zpuuv3uc5dxQ5CF0QVad7TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dtlMFHpXraCXx2iVSn0Rre9CcHTp/4h5x4x/PLuJTASXjPROnaYOWNHvKe7qVzX+n
	 DIdfdq3TOuQ+ibBvcMR+vEF7CZsoTtjTh+xdnMQ2c3wwT4osUd7OPW27MxmCSoFIOh
	 iZSgMKJ17c5GNI4eBMz3q6r3Byx5sg1lcqy5+EcG9hEQZgXPOTPgQk2Z2KJbNlDaeA
	 +XodYw3hrXVlPnVVJ9lxVTvFAQfGAmMATyrv5fTHU8/Qm8atzcCsYXPqFPeAxfw0VK
	 zkcTar5yyz8H1rajgbqoeeEGs9Fm9pjEmWVNr/7hI08riCOoqvej5cie36oc/F+3OX
	 0aXvnYcsRC3Rg==
Date: Wed, 27 May 2026 16:11:36 +0100
From: Conor Dooley <conor@kernel.org>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 01/10] dt-bindings: net: Add ADIN1140
Message-ID: <20260527-nearness-antacid-9f94a3f43abc@spud>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-1-37e5c8d4e0a0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6jZPRRWmjMQlxf91"
Content-Disposition: inline
In-Reply-To: <20260527-adin1140-driver-v2-1-37e5c8d4e0a0@analog.com>
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
	TAGGED_FROM(0.00)[bounces-292351-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,0.0.0.0:email,devicetree.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5EF4A5E6B61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--6jZPRRWmjMQlxf91
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 12:51:46AM +0300, Ciprian Regus via B4 Relay wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
>=20
> The ADIN1140 is a single port 10BASE-T1S Ethernet controller that
> includes both the MAC and a PHY in the same package.
>=20
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
>=20
> ---
> v2 changelog:
>  - Reorder the compatible entries in the dt schema (ad3306, adin1140).
>  - Removed "dt-bindings" from the commit title and message.
>  - Updated the DT example to use IRQ_TYPE_LEVEL_LOW instead of
>    IRQ_TYPE_EDGE_FALLING for the interrupt trigger condition.
>  - "implements" -> "tries to implement" in the description.
>  - Removed the MAINTAINERS entry, as it will be added in a later patch
>    in the series.
>  - Reordered as the first patch of the series
> ---
>  .../devicetree/bindings/net/adi,adin1140.yaml      | 69 ++++++++++++++++=
++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/adi,adin1140.yaml b/Do=
cumentation/devicetree/bindings/net/adi,adin1140.yaml
> new file mode 100644
> index 000000000000..518ff6b36c46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/adi,adin1140.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/adi,adin1140.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADI ADIN1140 10BASE-T1S MAC-PHY
> +
> +maintainers:
> +  - Ciprian Regus <ciprian.regus@analog.com>
> +
> +description: |
> +  The ADIN1140 (also called AD3306) is a low power single port

Can you explain what is going on here please?
Is "adin1140" (which I can find no information easily online for) the
exact same device as the ad3306 (which has an entry on your site)?

> +  10BASE-T1S MAC-PHY. It integrates an Ethernet PHY with a MAC
> +  and all the associated analog circuitry.
> +  The device tries to implement the Open Alliance TC6 10BASE-T1x MAC-PHY
> +  Serial Interface specification and is compliant with the
> +  IEEE 802.3cg-2019 Ethernet standard for 10 Mbps single pair
> +  Ethernet (SPE). The device has a 4-wire SPI interface for
> +  communication between the MAC and host processor.
> +
> +allOf:
> +  - $ref: /schemas/net/ethernet-controller.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad3306
> +      - adi,adin1140

Because if they are really two names for the same part, this compatible
setup makes no sense, as it means they have a different programming
models.

Thanks,
Conor.

> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 25000000
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Interrupt from the MAC-PHY for receive data available
> +      and error conditions
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-max-frequency
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        ethernet@0 {
> +            compatible =3D "adi,adin1140";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <23000000>;
> +
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <6 IRQ_TYPE_LEVEL_LOW>;
> +
> +            local-mac-address =3D [ 00 11 22 33 44 55 ];
> +        };
> +    };
>=20
> --=20
> 2.43.0
>=20
>=20

--6jZPRRWmjMQlxf91
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahcJqAAKCRB4tDGHoIJi
0qhLAP9kWEWAgNjViEjtK5sUkLrwsi9MX4d99T72d46+d9VWugD9Fmxa80q0mkV7
cv9vCA4xbSuUSKeY41ZUEuXqMLwztAE=
=sl5p
-----END PGP SIGNATURE-----

--6jZPRRWmjMQlxf91--

