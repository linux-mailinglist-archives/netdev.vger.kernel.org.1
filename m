Return-Path: <netdev+bounces-117777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C94594F263
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB3E281C26
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8707187323;
	Mon, 12 Aug 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCt89cgk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72953186295;
	Mon, 12 Aug 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478747; cv=none; b=TWy3n1RZiRTT9GsFSNh0maPjfJ0cY25FlsxRLadh89qfAcvFjSJUkre0kGUJxKwMif+ZRw7smU9VW3J3+NO4O1hOEJu3dF1OAQEDmwUlxn3GDqkhIEhl2dndNrE332frL8TUUK73X8+pDKshKsBsJStv9UqSnrjdUCPiszsC8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478747; c=relaxed/simple;
	bh=frzS/aHm5VA9TIrOS8VWHyLLQx6PC/h1Pbt6Q1VlcEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcXASHDQb6CpGntSEj/NmTH0vKqZ8qkZseSyWG4hR6Pdq5Wo3XAMVQD/SpgkxzrhpQ6maAFb3nX74f/dww/5T4yJsqMXRM5cafXhBgxTI40H5EA6XyYTI3CPYgBfPeF30/mIphNpO3NqxZy4j2hZGvRrxrJfEY8XHF0w+/Jft/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCt89cgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211C3C4AF0D;
	Mon, 12 Aug 2024 16:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723478747;
	bh=frzS/aHm5VA9TIrOS8VWHyLLQx6PC/h1Pbt6Q1VlcEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCt89cgkcUtxbLSoQ0CdTdSdiR1I6LG08Ri65kjhxXhaLmiDckoTreTX17Q8NWM3S
	 DKFNgbRwQAvrJdPmzYzVXEFsmwNWBqpKpVNIKimbjl3HgXIpXHnmh2wHPJiT4EzMQj
	 GbuNr8nLCZ1/hNBAGf39TDY6FutgGVbKUl78QX7JpvzUZb/ex8zQ6NZsIWm8Xo+Nck
	 ywO4zkw9Gt65D6F1yT4fZ9x81FgCmkCr/VMMlu7Nf5LoccvEj3mRQlYBAnndXwWEOK
	 hG1DgomQT5RU+3hXHIStbHkOhb0IfBu1cqKoFfrix5pm/w6uFGTpkwltxzvCLufKt4
	 O9xwbbtTG5Elg==
Date: Mon, 12 Aug 2024 17:05:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Daniel Kaehn <kaehndan@gmail.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 0/6] dt-bindings: add serial-peripheral-props.yaml
Message-ID: <20240812-borax-coming-c1d36272eab4@spud>
References: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t2c4tmW/pTswK+f0"
Content-Disposition: inline
In-Reply-To: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>


--t2c4tmW/pTswK+f0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 08:17:03PM +0200, Krzysztof Kozlowski wrote:
> Hi,
>=20
> Add serial-peripheral-props.yaml for devices being connected over
> serial/UART.
>=20
> Maybe the schema should be rather called serial-common-props.yaml? Or
> serial-device-common-props.yaml?
>=20
> Dependencies/merging - Devicetree tree?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Entire patchset should be taken via one tree, preferably Rob's
> Devicetree because of context/hunk dependencies and dependency on
> introduced serial-peripheral-props.yaml file.

The whole idea seems reasonable to me, but I question whether it is
worth tagging it if Rob's gonna be the one applying it.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--t2c4tmW/pTswK+f0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZroy0wAKCRB4tDGHoIJi
0gZwAPsHEotRe8E8aoh94BQjbYy7hCdbThvD/gmgsp1hB7+4XwD+IRh/n/brLbFT
vFkmgJw6itiKcyKJAzQ0mdJN5iux5QM=
=1pSD
-----END PGP SIGNATURE-----

--t2c4tmW/pTswK+f0--

