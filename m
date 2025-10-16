Return-Path: <netdev+bounces-229927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D01BE21A1
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B4C3A6EC2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6812B2EF65F;
	Thu, 16 Oct 2025 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfwktXLk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7819067C;
	Thu, 16 Oct 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602406; cv=none; b=tKKHRVvF1LRXBEj01UwE1M39/MeMMkvPjBon80BTOyEPgVmQVhnq7RA0r8JnQqDPIQUP9b5bEDXk4/m1mqcbV1cuOVmN+lgyfkp0IMhfN1dAohp4fn2iXPNGv9s1B8L/MUG+eJBKxMlKKS9JXH2/7Pk79h6SZHPwHIWMqrIj+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602406; c=relaxed/simple;
	bh=JRPlKX+eOfHCbEao1Pk+DQKZrPhLJMjawB7Jmn0nkuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXqxRV0FxcIhZPxXvpSSsS6fsmQSJdAOztF2D3EiupVf4SGQvNtZ2QqDGrTyBPqTRl+v62iSb+dZwSPmNjvcOzdULgNQ/qCtCERRgrMR6aKcCrzaBLztaCA72vPoPCWSa+WuF9Yg2tnQ8NK0/O2wzoUvQknuFON14m9QrBRuqbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfwktXLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B94C4CEF1;
	Thu, 16 Oct 2025 08:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760602404;
	bh=JRPlKX+eOfHCbEao1Pk+DQKZrPhLJMjawB7Jmn0nkuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfwktXLkYCPsutEN4IMLIXWbPx1m+L2Pl1atPbDyhlQX9pB1k+ZnjDZ/wA/P3xM8R
	 kZCQCiHgfvBb9xDNz7Prt6yHDUWZvQspwERNPPZEiS3CgAM0FHMlp2lXY79JBWFJA8
	 5YYTSXrTlx2OqiDhBZrneODysIG/64H2YrLHdpAySXZi4zllPE3BFuaDJTOW20/QOb
	 fb1tZNXuB6Qa2Hmwv3Bz5ikljnsPGEYX8irH4mli3cV1TPoKfhMUKgKUBpsaXOmuK3
	 R80BM53DWbzjr7BrqJPj2xsGT+r9PeGnzl0BhJtWXl5aP6KbKA0kmNpVemnXHlwwQj
	 yw7AhCajfDWVg==
Date: Thu, 16 Oct 2025 10:13:21 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] net: airoha: ppe: Configure SRAM PPE
 entries via the cpu
Message-ID: <aPCpIS1Hd4hIb20q@lore-desk>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-8-064855f05923@kernel.org>
 <aO_CFRYy6vXCQIS2@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vAW4T/rTlIVRq6th"
Content-Disposition: inline
In-Reply-To: <aO_CFRYy6vXCQIS2@horms.kernel.org>


--vAW4T/rTlIVRq6th
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Oct 15, 2025 at 09:15:08AM +0200, Lorenzo Bianconi wrote:
> > Introduce airoha_ppe_foe_commit_sram_entry routine in order to configure
> > the SRAM PPE entries directly via the CPU instead of using the NPU APIs.
> > This is a preliminary patch to enable netfilter flowtable hw offload for
> > AN7583 SoC.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/airoha/airoha_ppe.c | 30 +++++++++++++++++++++++-=
------
> >  1 file changed, 23 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/eth=
ernet/airoha/airoha_ppe.c
> > index fcfd2d8826a9c2f8f94f1962c2b2a69f67f7f598..0ee2e41489aaa9de9c1e99d=
242ee0bec11549750 100644
> > --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> > +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> > @@ -662,6 +662,27 @@ static bool airoha_ppe_foe_compare_entry(struct ai=
roha_flow_table_entry *e,
> >  	return !memcmp(&e->data.d, &hwe->d, len - sizeof(hwe->ib1));
> >  }
> > =20
> > +static int airoha_ppe_foe_commit_sram_entry(struct airoha_ppe *ppe, u3=
2 hash)
> > +{
> > +	struct airoha_foe_entry *hwe =3D ppe->foe + hash * sizeof(*hwe);
> > +	bool ppe2 =3D hash >=3D PPE_SRAM_NUM_ENTRIES;
> > +	u32 *ptr =3D (u32 *)hwe, val;
> > +	int i;
> > +
> > +	for (i =3D 0; i < sizeof(*hwe) / 4; i++)
> > +		airoha_fe_wr(ppe->eth, REG_PPE_RAM_ENTRY(ppe2, i), ptr[i]);
>=20
> I realise that a similar pattern it is already used elsewhere,
> but '4' seems somewhat magic here.

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> ...

--vAW4T/rTlIVRq6th
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPCpIQAKCRA6cBh0uS2t
rKdgAPsH0ww4Hrlelb1QuqnLD1TGZZFr8UF1MNUoTOTwV+4gHgD/UrxDeNf2dARc
ohcbUBc9rlkS5/IM2e7+vMYWUg5PBgA=
=J4PD
-----END PGP SIGNATURE-----

--vAW4T/rTlIVRq6th--

