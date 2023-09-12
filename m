Return-Path: <netdev+bounces-33377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD1279DA0C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 22:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55ACB1C20E06
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C43FE6;
	Tue, 12 Sep 2023 20:31:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F71F172
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 20:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9548C433C8;
	Tue, 12 Sep 2023 20:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694550670;
	bh=gudZcBaqnl426kAV6MNSRsYK1Axm1IWzlVfqa3uKptk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdkXcZajEgvwdmh6Oer7umwSnUQ6YKcmqxg3zd75FUCXxZexXPpjOHG3LqM57cpVh
	 m1eybH6eNqUEZGiSFfLPc2DrcHOA62dFhgSOzrhyrmp3iMFF05P/FRM3zf/DLUkJ9E
	 Mx+E4zR/5iypgN+eIjPjHp06i2/Y5+trCxAnq5bY9AVCgR2Z1HQTCzgLgcNQAEerkY
	 0RbISuFsUvmpzTHNjoyuXvpK3PIa0cRHmUmxmx5WXtOgiCKFPt19ntwAzS6UwlX441
	 1bbD/3Bia4NFwJ7ISdahNUt3VhqMtkCQFNSG7wg73gwNNCt1+ikZZZbQ0ejQkYCTTs
	 EgXAzEN3+Khqg==
Date: Tue, 12 Sep 2023 22:31:06 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: do not assume offload
 callbacks are always set
Message-ID: <ZQDKit5A6JWb+KD5@lore-desk>
References: <cedc0a98fb419f3d520a38271628e5d35a01be97.1694507095.git.lorenzo@kernel.org>
 <20230912180635.GM401982@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MAb77/pLmcwH2xgD"
Content-Disposition: inline
In-Reply-To: <20230912180635.GM401982@kernel.org>


--MAb77/pLmcwH2xgD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Sep 12, 2023 at 10:26:07AM +0200, Lorenzo Bianconi wrote:
> > Check if wlan.offload_enable and wlan.offload_disable callbacks are set
> > in mtk_wed_flow_add/mtk_wed_flow_remove since mt7996 will not rely
> > on them.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Hi Lorenzo,
>=20
> It's not not a big deal from my perspective, but
> I do wonder if these mediatek patches could have been a series.
>=20
> > ---
> >  drivers/net/ethernet/mediatek/mtk_wed.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethe=
rnet/mediatek/mtk_wed.c
> > index 94376aa2b34c..d8cd59f44401 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> > @@ -1718,6 +1718,9 @@ int mtk_wed_flow_add(int index)
> >  	if (!hw || !hw->wed_dev)
> >  		return -ENODEV;
> > =20
> > +	if (!hw->wed_dev->wlan.offload_enable)
> > +		return 0;
>=20
> A little further down in this function it is assumed that hw->wed_dev may
> be NULL, a check made under a lock no less. But it is dereferenced
> unconditionally here without a lock. This doesn't seem right one way or
> another.
>=20
> As flagged by Smatch.

Hi Simon,

you are right. I will fix it in v2.

Regards,
Lorenzo

>=20
> > +
> >  	if (hw->num_flows) {
> >  		hw->num_flows++;
> >  		return 0;
> > @@ -1747,6 +1750,9 @@ void mtk_wed_flow_remove(int index)
> >  	if (!hw)
> >  		return;
> > =20
> > +	if (!hw->wed_dev->wlan.offload_disable)
> > +		return;
> > +
> >  	if (--hw->num_flows)
> >  		return;
> > =20
> > --=20
> > 2.41.0
> >=20
> >=20

--MAb77/pLmcwH2xgD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQDKigAKCRA6cBh0uS2t
rO3jAP9r5y6+GByDHJXGpRX80Bk9V1RYRGxj4AxmAqyVmEGauAD/RKcnp36oBqfc
0XxmDeotlcg8OsVRvZpBOe1bhOPtwg4=
=DUwI
-----END PGP SIGNATURE-----

--MAb77/pLmcwH2xgD--

