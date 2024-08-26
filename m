Return-Path: <netdev+bounces-121959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A23795F61B
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84741B20D2E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E1719342E;
	Mon, 26 Aug 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6Qzr18S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894A153812;
	Mon, 26 Aug 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688590; cv=none; b=rQXt+u5ajr1FNkGLeIPHsF2woiY83swEtV5O+1OytFPGbYNabxDNDmISiWmpSeQAqaibBXh+LHf1cOV9HLbJAWnXKboyt2QajX7EajgWN28d1BJCX/pWxQ1neivG95dS9AeuKznXhODojgABndjTmWEqmgLqzCKa7U8615sAFt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688590; c=relaxed/simple;
	bh=PgVuv+2ugVeGTH07IgetYbovxINZB9KbgAWUegNwC2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDw90NAEJGmylkEGPHPK0ugEE0DG6fBkakcFHyvVIOZ4Fm7IXXtW5zo/FZwheXflZ+Llr5YuxqW/0YbtzRc8xoQBJHBSnareSI7O8gZ074oEOIE1WAtjj8clBbufWrV17Ao3BwGt1jD1aLi2uNB2R3mHd+Fx+r52vstWaUZqmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6Qzr18S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE29DC52FC1;
	Mon, 26 Aug 2024 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688590;
	bh=PgVuv+2ugVeGTH07IgetYbovxINZB9KbgAWUegNwC2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6Qzr18ST56e+ZIkNrKXLmV9BBHjlh82KJr9E5OOI/86EGF9gml8uPYnZnw7rIZ2N
	 uQ0Dafk4rwC/2Fc7HsUC0ncaGxD+QreYUc6nElo1zGhSuvpBFOgkwNHLGRBmDQhMMs
	 61IAGvFe9NCNiNceBHFBfjvU19CnWf2r63ed8Jl8lKszZiE2I3Vhh6zo5kM1cBaVCb
	 JZuhkHPJwI1qnxSDCPHVLXaWlqpBhKktrwtu+t1KTejkdgYwNG2NpHT0em0b07KdZf
	 rNMDePdjavcn8mu7cr7YfE15Z8ImlswG5K20o7Yc2EB+rAhiGmlPLb/KTlMWRcGF5D
	 RGh99qNKNGSeQ==
Date: Mon, 26 Aug 2024 17:09:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: lorforlinux@beagleboard.org, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: net: ti,cc1352p7: Add
 bootloader-backdoor-gpios
Message-ID: <20240826-pristine-domelike-d995db6f2561@spud>
References: <20240825-beagleplay_fw_upgrade-v3-0-8f424a9de9f6@beagleboard.org>
 <20240825-beagleplay_fw_upgrade-v3-1-8f424a9de9f6@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/DPLpm0pp++ZNJeN"
Content-Disposition: inline
In-Reply-To: <20240825-beagleplay_fw_upgrade-v3-1-8f424a9de9f6@beagleboard.org>


--/DPLpm0pp++ZNJeN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 10:17:05PM +0530, Ayush Singh wrote:
> bootloader-backdoor-gpio (along with reset-gpio) is used to enable
> bootloader backdoor for flashing new firmware.
>=20
> The pin and pin level to enable bootloader backdoor is configured using
> the following CCFG variables in cc1352p7:
> - SET_CCFG_BL_CONFIG_BL_PIN_NO
> - SET_CCFG_BL_CONFIG_BL_LEVEL
>=20
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--/DPLpm0pp++ZNJeN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsyoxwAKCRB4tDGHoIJi
0thAAQDPuuwJz0rQ4CLBxjUEwzs+xJQjaSdCxpCtp2ypSXeDfgD/QDkE2GTbcD51
HY+44h0CGH+wJznOESsbSYLni8+60wM=
=7Rz+
-----END PGP SIGNATURE-----

--/DPLpm0pp++ZNJeN--

