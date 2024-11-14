Return-Path: <netdev+bounces-145039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4959C92E3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139CA1F21EA8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E132B1A7AF6;
	Thu, 14 Nov 2024 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDxJHMbh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2FEEDE;
	Thu, 14 Nov 2024 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614781; cv=none; b=IS/oPUIX7HtlMWJID0YSGZcIUY2v3oIecZXojk+IPiL2WV6Es/qmoQjWX45tIdpu/GhQAVHQ9IrEZQD66caXkiDzGUQtbky/h8/Svq0tYXF6yEe2OYRE2v85mFTtKV06hRe51HvePQdm9rmGyuiNbH0SpjXx0V9Q6EDDciTaoPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614781; c=relaxed/simple;
	bh=+qErtJSAtXbxwYe6icG0dLk6au77bP2XR4LohEja7Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qukZFJLLVqamR30b3saq7e799G4OIRea7clcQuQ7IrYjZCH9MCr5h+MiD57FGG3KX3pZHL7z6R2MPVQ+eirTGjWguf+LN1S/4Hv/DqTiLf4v/I9txWtMEFzuIUq3ihulmynBPKhZl6HlBEP6rbiH9zwQ6dut8oK6eH2RXQDpLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDxJHMbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ACBC4CECD;
	Thu, 14 Nov 2024 20:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614781;
	bh=+qErtJSAtXbxwYe6icG0dLk6au77bP2XR4LohEja7Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDxJHMbhx68G8JfrXELVLvUwb2oPsOD5P423u74SIvbwZ4LnpJNiBD2f6Eio70YTc
	 4gJ4+KHh5ZhwmMvCnPIr00MukmusQKmx3XIplqN3GaW6/Zgj0iADc59D/VJt6E2Fpa
	 rwqwow/QLOjr627VYQSSmoo70MEYaTnaiLngpls5ZMA7ZtohH/YROhEmrpLbgBYIBX
	 M2Bm7UHx+onpc4PwnON55gjKsIAL4JMC+fOAshMBVWttr881a+QVz/LkSflY7lrZwO
	 wTiv3mL+rV4+/sctWfWA+EueB8SgWd4x+Q8rVlq+Qc+oBBkoP0sONT04qf0PpvmIBf
	 v31dNt2XqA9WQ==
Date: Thu, 14 Nov 2024 20:06:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Russell King <linux@armlinux.org.uk>, jacob.e.keller@intel.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 8/8] dt-bindings: net: sparx5: document RGMII
 MAC delays
Message-ID: <20241114-liquefy-chasing-a85e284f14b9@spud>
References: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
 <20241113-sparx5-lan969x-switch-driver-4-v2-8-0db98ac096d1@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eNDowPgtkxFgCrJx"
Content-Disposition: inline
In-Reply-To: <20241113-sparx5-lan969x-switch-driver-4-v2-8-0db98ac096d1@microchip.com>


--eNDowPgtkxFgCrJx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:11:16PM +0100, Daniel Machon wrote:
> The lan969x switch device supports two RGMII port interfaces that can be
> configured for MAC level rx and tx delays.
>=20
> Document two new properties {rx,tx}-internal-delay-ps. Make them
> required properties, if the phy-mode is one of: rgmii, rgmii_id,
> rgmii-rxid or rgmii-txid. Also specify accepted values.
>=20
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
>  .../bindings/net/microchip,sparx5-switch.yaml        | 20 ++++++++++++++=
++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switc=
h.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> index dedfad526666..a3f2b70c5c77 100644
> --- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> @@ -129,6 +129,26 @@ properties:
>              minimum: 0
>              maximum: 383
> =20
> +        allOf:
> +          - if:
> +              properties:
> +                phy-mode:
> +                  contains:
> +                    enum:
> +                      - rgmii
> +                      - rgmii-rxid
> +                      - rgmii-txid
> +                      - rgmii-id
> +            then:
> +              properties:
> +                rx-internal-delay-ps:
> +                  enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
> +                tx-internal-delay-ps:
> +                  enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]

Properties should be define at the top level and constrained in the
if/then parts. Please move the property definitions out, and just leave
the required: bit here.

> +              required:
> +                - rx-internal-delay-ps
> +                - tx-internal-delay-ps

You've got no else, so these properties are valid even for !rgmii?

> +
>          required:
>            - reg
>            - phys

Additionally, please move the conditional bits below the required
property list.

Cheers,
Conor.

--eNDowPgtkxFgCrJx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZYNwAKCRB4tDGHoIJi
0tseAQDj+4EzZBz0Olii65irqWB4dSvXcjEhBM44bZwOPV01VQD/VdnzMjewFP1O
G21peKsEaCjo/s/xbOGZESYTlDp/mw0=
=RG0u
-----END PGP SIGNATURE-----

--eNDowPgtkxFgCrJx--

