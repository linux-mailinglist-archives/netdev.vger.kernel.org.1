Return-Path: <netdev+bounces-170151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD1A477F0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4B3165145
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 08:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE098224B08;
	Thu, 27 Feb 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRkxdmgo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D39223715;
	Thu, 27 Feb 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645425; cv=none; b=OG6QmdFelcE6ZHGXqy/CuRa+VQJLV95rfaPRqZOKL9DDFsz45NtL5L6o7Z7FmjewDXVBxkgiewneHCbmBrUFD6tOQ/VvdqdAyWekxISGn1ujXgsgZn2cZsjHRQ6uGLa+Sd1bOErHeuf/3cA/bMgZEA+x/64ZArEwTWr+9pPi4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645425; c=relaxed/simple;
	bh=nRbj/Wkfu4NpdGGUja9RSPwp1X8dZdVwrbBMJ/2V0wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhqazh9M7j9FRI2rGT+32HN0mRt1XglRK3vCYhBhcA7P2+vnSm2Li0Ftoq9I1wSN80tSi441w7rk/TcfFzh91eaD+cb88/Z7qVk/l0CmX3ASJjNXW7NcwttNFnmP0xEy/h3VamLfYUf2JerbkSwfTN4U1hcUltxI263dA7yIEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRkxdmgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9A9C4CEDD;
	Thu, 27 Feb 2025 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740645425;
	bh=nRbj/Wkfu4NpdGGUja9RSPwp1X8dZdVwrbBMJ/2V0wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRkxdmgokJlBe27n3RIU7ojbt+6jpjnxlL94eKr6TcvXAyZXXYLS+rBDbVJVjv5BR
	 MZB6qyjZyrvjqgzO1hlFGzXr/ZK6e8Zj7Kx/AmDypMr3NuJOiPYeFSCJDJBtL1rAKi
	 hU6iqYEbfpEh/YnEyctlqDgGjTODN3TYzh/YFVfimCs1ECvUBd6RA2+QbPpAuPtaOV
	 LcwHnGjmBAtamEYnvRcabR4R+9O/oZM1rUOm4EFoU99TPGg9E03ouiJfb0FYqe580S
	 2BQWn7cwGorXReTMdyhVlMgOiAVab+nE6XCa2lpFYoYQeRhl0oYSsURKDKlg2PBnTE
	 mYXL0AK8kNe1Q==
Date: Thu, 27 Feb 2025 09:37:02 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	upstream@airoha.com, Sayantan Nandy <sayantan.nandy@airoha.com>
Subject: Re: [PATCH net-next v7 13/15] net: airoha: Introduce flowtable
 offload support
Message-ID: <Z8AkLpF1svgNfXNu@lore-desk>
References: <20250224-airoha-en7581-flowtable-offload-v7-0-b4a22ad8364e@kernel.org>
 <20250224-airoha-en7581-flowtable-offload-v7-13-b4a22ad8364e@kernel.org>
 <20250226194310.03398da0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3EJw5ixjEJCaV9I4"
Content-Disposition: inline
In-Reply-To: <20250226194310.03398da0@kernel.org>


--3EJw5ixjEJCaV9I4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 24 Feb 2025 12:25:33 +0100 Lorenzo Bianconi wrote:
> > +	foe_size =3D PPE_NUM_ENTRIES * sizeof(struct airoha_foe_entry);
> > +	ppe->foe =3D dmam_alloc_coherent(eth->dev, foe_size, &ppe->foe_dma,
> > +				       GFP_KERNEL | __GFP_ZERO);
>=20
> dmam_alloc_coherent() always zeros the memory, the GFP_ZERO is not necess=
ary

ack, I will fix it.

Regards,
Lorenzo

--3EJw5ixjEJCaV9I4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ8AkLgAKCRA6cBh0uS2t
rHkvAQDr0fPTwe5MsGWTZebtC+cvgeqIcwk+UMbKIk75G9QRHQEAyMgTUip42VH/
4sD9pimv2XO4Yc7c3UHDupHqbjzpkQw=
=h8X6
-----END PGP SIGNATURE-----

--3EJw5ixjEJCaV9I4--

