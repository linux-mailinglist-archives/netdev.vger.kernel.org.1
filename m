Return-Path: <netdev+bounces-228226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D58BC52B0
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 15:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFA0A4E42CF
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B29C28313D;
	Wed,  8 Oct 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujgc4Vgx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BED2820DB
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929570; cv=none; b=DRO8cMlyRHbZrfn8nMGPh82XS+5Fc/eBylAcpDomHzKGuUiU+gZrfjzn+dNGyZJ+A9KPVISILPhNQpiq+pz2kNe4J7h54HxZcxrWFdyaMxSfmtXbojE/NwdEQaIIBUQCOH6tPh2H++VvoGnuYZR5u7PavnO2UBLyc6C2md0fUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929570; c=relaxed/simple;
	bh=uD0fsM6U3se/luO9t3897ROnhJ9ki+QjdE7VMtEm1oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtd3PNF64VKDGHo/O2cEHVqMiGJ6ncUWG5XwXH9gKW79om8TSNVd5SycQwRX14DxSaOqcJRv9Prh++TMNKbmbbGHTSrjmaiQwEitk1vgTUx7x6YVSfPZASWJ0NlcMnppIhD4VqVNyOegdEh+Jlj/rrzZ+JGSKNK4pHyng7fAV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujgc4Vgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3AEC4CEF4;
	Wed,  8 Oct 2025 13:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759929569;
	bh=uD0fsM6U3se/luO9t3897ROnhJ9ki+QjdE7VMtEm1oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ujgc4VgxNm8/Q48WW9Y3hj+4AWBmhOjhQrmFHnROwG9xtX/hscnPhK2zyXNw0M4un
	 8XZb8D2yUX72xcvqEBx60J3KCqNDbco4ANCpBKyTrd3VD0luf0rylj6rQ6quynAHNZ
	 3ZAFIlkDmZNmNusckGQ0q/6p0cpjX1VDX1VoBH8z9f8lXAE3Sp64An4Zq1WpC2WQ4d
	 51y8kGWVWFqolA4MmqoUHKLMZwl9hAPfwtq2lZX+OjHbP23n8mxIabnE5m5MKST3fT
	 3WLQC7nBvBUsyIRO/9TAfwGPyBqRVStD4XCJa9Q7nVbl3XrI8Q/7T4FiwXZQUOggBr
	 QCl0ohwZtkT8w==
Date: Wed, 8 Oct 2025 15:19:27 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>,
	Daniel Pawlik <pawlik.dan@gmail.com>,
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH net] net: mtk: wed: add dma mask limitation and GFP_DMA32
 for device with more than 4GB DRAM
Message-ID: <aOZk35XuJmLwCvZY@lore-desk>
References: <20251008-wed-4g-ram-limitation-v1-1-16fe55e1d042@kernel.org>
 <20251008123731.GR3060232@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xv+5q7pi86ls0BfX"
Content-Disposition: inline
In-Reply-To: <20251008123731.GR3060232@horms.kernel.org>


--xv+5q7pi86ls0BfX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Oct 08, 2025 at 12:48:05PM +0200, Lorenzo Bianconi wrote:
> > From: Rex Lu <rex.lu@mediatek.com>
> >=20
> > Limit tx/rx buffer address to 32-bit address space for board with more
> > than 4GB DRAM.
> >=20
>=20
> Hi Lorenzo, Rex, all,

Hi Simon,

>=20
> As a fix for net a Fixes tag should probably go here.
> > Tested-by: Daniel Pawlik <pawlik.dan@gmail.com>
> > Tested-by: Matteo Croce <teknoraver@meta.com>
> > Signed-off-by: Rex Lu <rex.lu@mediatek.com>
> > Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> ...
>=20
> > @@ -2426,6 +2426,10 @@ mtk_wed_attach(struct mtk_wed_device *dev)
> >  	dev->version =3D hw->version;
> >  	dev->hw->pcie_base =3D mtk_wed_get_pcie_base(dev);
> > =20
> > +	ret =3D dma_set_mask_and_coherent(hw->dev, DMA_BIT_MASK(32));
> > +	if (ret)
> > +		return ret;
>=20
> I think 'goto out' is needed here to avoid leaking hw_lock.

right, I will fix it in v2.

Regards,
Lorenzo

>=20
> > +
> >  	if (hw->eth->dma_dev =3D=3D hw->eth->dev &&
> >  	    of_dma_is_coherent(hw->eth->dev->of_node))
> >  		mtk_eth_set_dma_device(hw->eth, hw->dev);
> >=20
>=20
> --=20
> pw-bot: changes-requested

--xv+5q7pi86ls0BfX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaOZk3gAKCRA6cBh0uS2t
rOnvAP0fwQEDHk1NkJRLOBUd4bCOkD1SsS4bO/focUB/2eArjAD+LYJXD5hGGb8J
Wo+bKo/93KpLDi+VEbwbSzyiyMI8agk=
=jr+9
-----END PGP SIGNATURE-----

--xv+5q7pi86ls0BfX--

