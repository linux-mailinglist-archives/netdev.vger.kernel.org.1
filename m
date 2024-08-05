Return-Path: <netdev+bounces-115816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA568947E0C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795931F23461
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BABF15C133;
	Mon,  5 Aug 2024 15:24:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5B15B984
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871456; cv=none; b=ur4CtwQurEJ/qAzd3YWOMpoASK3pkDXxm1puGZhpZelfL3O7e+aQEK+fwacXRIn0DHhP2qzW/YWu0huxdzPLVJ6YMzF/WNuRmHlbLyqCDkbm0kBn+EujSd2o4iS63z15m0KqxGwthYogVjnAHvOg/62JrokkeHhCX+teUWB948Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871456; c=relaxed/simple;
	bh=kPdjs2s6gKRkknYIL8b561xalIcy0R+0OIhs7JfTB5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GatrHZL9p2ny+/i08wCFoIQ9i/2UWbhwrI085amhMkRxS+89jpXsLxoBdjzNWAZ/u84Kc128plHgnDYXhn7eX3FhscoCNOrNmGj94tkUxZjXWBD3fr6wzE/smUbJHzAzmV9e2mSvUWyKZFSUwTP12Pt/YUc5VdgOMdkpPaSQX8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardanger.blackshift.org; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardanger.blackshift.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f27:f000:3ddb:5b7b:31ab:901c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature ECDSA (P-384)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id A0C445E347A
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 15:17:05 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 622FE31732E
	for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 15:17:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BFBE131731F;
	Mon, 05 Aug 2024 15:17:01 +0000 (UTC)
Received: from localhost (hardanger.blackshift.org [local])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTPA id 8588bc23;
	Mon, 5 Aug 2024 15:17:01 +0000 (UTC)
Date: Mon, 5 Aug 2024 17:17:01 +0200
From: Marc Kleine-Budde <frogger@hardanger.blackshift.org>
To: pierre-henry.moussay@microchip.com
Cc: Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] dt-bindings: can: mpfs: add PIC64GX CAN
 compatibility
Message-ID: <t5y22ttkimghgy5xdyit2ib4pif43zhxet7igyukfiahzwnkeh@u66ad7hogcw6>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
 <20240725121609.13101-2-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b35o3dtbvyih3krm"
Content-Disposition: inline
In-Reply-To: <20240725121609.13101-2-pierre-henry.moussay@microchip.com>


--b35o3dtbvyih3krm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.07.2024 13:15:53, pierre-henry.moussay@microchip.com wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX CAN is compatible with the MPFS CAN driver, so we just update
> bindings

As Conor already pointed out, you should point out that the CAN
hardware/IP core on the pic64gx is compatible with the one on the mpfs.

regards,
Marc

>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml     | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can=
=2Eyaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> index 01e4d4a54df6..1219c5cb601f 100644
> --- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> @@ -15,7 +15,11 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: microchip,mpfs-can
> +    oneOf:
> +      - items:
> +          - const: microchip,pic64gx-can
> +          - const: microchip,mpfs-can
> +      - const: microchip,mpfs-can
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.30.2
>=20

--b35o3dtbvyih3krm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaw7OoACgkQKDiiPnot
vG8KWwf9EwEl+GJxZhqXSqMi+9A2lzBcW67k0Y+18ClUlOp89drW9X3spMvI7gym
EmrFl3C+HwXtsUZh4JCFA0YL56LPYfvoRis5w+mccAxEW1RrTGefiAl98A/Y+sjH
81U4tt5dhcZyZ8Zmj4aBG0u0G1xSb2mJTm2OaNZCMtscoFuUhA5bXQYFoM2GHL5W
L9bRBIND+4/vWZZO3bAaAev062ur00po+tyvY5UZh+aaSGwcznYonOaln4ntyb2Y
4DhwNyAqcIN8gqgaBCAa3UOeTet031dUlEIRhSf2nCARW3mCmzyZ3DOXYzD0fBio
YUS5NzjEYD+ZxdwqFOEFcVevulPyFw==
=kS9R
-----END PGP SIGNATURE-----

--b35o3dtbvyih3krm--


