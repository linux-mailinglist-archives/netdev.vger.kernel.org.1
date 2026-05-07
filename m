Return-Path: <netdev+bounces-285450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFvaMnXQ/GlhTwAAu9opvQ
	(envelope-from <netdev+bounces-285450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:48:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5573A4ED0EC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61E0E30C2F40
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1152F44D00A;
	Thu,  7 May 2026 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkv6slKm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA33EFD39;
	Thu,  7 May 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175780; cv=none; b=PjQ4ndnEeVcwYkn+9C7HVC+/t3Tp2/vZlQi2kRmcnDxsq5KQ8ZdgX2cP+nQvwuzvO0KUxo2xveIx5QKm1vFsOsOwjHg/vv6vrTGjus+yjq2rF/oQnbnZQ86RUU58zuI/yT2WN5QHYmwB06WLOC4ztCUvZD2T5wUpkeFYXR1b+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175780; c=relaxed/simple;
	bh=Hdn4fgFuvQvR+BcNGi93NiwRUkK+Dd4Y63XEjaXRKw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luMd4EOyLR4520oFh0dUcJwdR8Wrrgk/yYj3hX95DERFqtOqNt6KKxvCnmqF449v4OqDJdUs7JSfkMpj1Bt/0DVTLid1LlnjjQThsU8L6qBFAcnX+9yf080VTUwRiVYNKmTokbicnvUsVAbYOYHqFef0tovai7CR4tHwz6fpDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkv6slKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02438C2BCC4;
	Thu,  7 May 2026 17:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778175779;
	bh=Hdn4fgFuvQvR+BcNGi93NiwRUkK+Dd4Y63XEjaXRKw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkv6slKm5dDmlFDare54WePGajFEFla4RICXDY9tA7CbCdkZr1K9DDGNZzizOPhkQ
	 xw+dnscnNv8ATDBpxd60UsgJnAfhyhldBfBayLDyw+XEKyJqFvH3Ihp5+CPpwASXt/
	 AC0x+hkl5PlY96HEC3JpQZ4FC2Uxh+jLe2xeM7Ny+zPeh1RrddlHWJBtalL38NXjNe
	 +2NzmCWIcoaMNPdkevFW2hMoF99WjNw7PNHMn+JJ6ejP5n7jgNuwfY2a61wfJ3GdL7
	 RUhwTBpO8lDWeLgMFCJH85fEdtt9z6OVvFMyvN22+NvZ20vCcYuNv6j78B2+bWJFYv
	 aGVPmvjdQKW5A==
Date: Thu, 7 May 2026 18:42:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v3 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 jhb100 sgmii rx clk
Message-ID: <20260507-annotate-cleat-52614476a8f7@spud>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
 <20260507094115.8355-4-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="emyOGXNpEJM9Td6n"
Content-Disposition: inline
In-Reply-To: <20260507094115.8355-4-minda.chen@starfivetech.com>
X-Rspamd-Queue-Id: 5573A4ED0EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285450-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--emyOGXNpEJM9Td6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 05:41:13PM +0800, Minda Chen wrote:
> jhb100 SGMII interface tx/rx mac clock is split and require to
> set clock rate in 10M/100M/1000M speed. So dts need to add a
> new rx clock in code, dts and dt binding doc.
> So in jhb100 SGMII interface contain 6 clocks, RMII/RGMII
> interface still contail 5 clocks.

Why is this not being done in the commit adding the jhb100 in the first
place?

>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 42 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.=
yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> index 06aeaa0f6f00..af160a8dedb8 100644
> --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> @@ -39,20 +39,18 @@ properties:
>      maxItems: 1
> =20
>    clocks:
> +    minItems: 5
>      items:
>        - description: GMAC main clock
>        - description: GMAC AHB clock
>        - description: PTP clock
>        - description: TX clock
>        - description: GTX clock
> +      - description: SGMII RX clock
> =20
>    clock-names:
> -    items:
> -      - const: stmmaceth
> -      - const: pclk
> -      - const: ptp_ref
> -      - const: tx
> -      - const: gtx
> +    minItems: 5
> +    maxItems: 6
> =20
>    starfive,tx-use-rgmii-clk:
>      description:
> @@ -99,6 +97,18 @@ allOf:
>            minItems: 2
>            maxItems: 2
> =20
> +        clocks:
> +          minItems: 5
> +          maxItems: 5

This can just be "maxItems: 5", since minItems is set outside the
conditional to 5.

> +
> +        clock-names:
> +          items:
> +            - const: stmmaceth
> +            - const: pclk
> +            - const: ptp_ref
> +            - const: tx
> +            - const: gtx
> +
>          resets:
>            maxItems: 1
> =20
> @@ -111,6 +121,26 @@ allOf:
>            contains:
>              const: starfive,jh7110-dwmac
>      then:
> +      properties:
> +        clocks:
> +          minItems: 5
> +          maxItems: 6

Remove these constraints, since they don't do anything more than the
outside ones do.

> +
> +        clock-names:
> +          oneOf:
> +            - items:
> +                - const: stmmaceth
> +                - const: pclk
> +                - const: ptp_ref
> +                - const: tx
> +                - const: gtx
> +            - items:
> +                - const: stmmaceth
> +                - const: pclk
> +                - const: ptp_ref
> +                - const: tx
> +                - const: gtx
> +                - const: sgmii_rx

Can't you just leave this list outside the conditional section, and add
the extra item to the end? The only difference appears to be the
sgmii_rx clock, and it's at the end.

I'm also not really convinced that this flexibility is required, unless
there are some controllers on the platform that do not support sgmii.

pw-bot: changes-requested

Cheers,
Conor.

>        if:
>          properties:
>            compatible:
> --=20
> 2.17.1
>=20

--emyOGXNpEJM9Td6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafzPHgAKCRB4tDGHoIJi
0qWPAP48Jg7iBluYVxnNt04nxXmKXO247a10w2+hLujxSn9HWgEA9gbP8K+wMHbv
4T0T79bjT/5vtx7DKuvOy2+uUcAKtAE=
=2Yti
-----END PGP SIGNATURE-----

--emyOGXNpEJM9Td6n--

