Return-Path: <netdev+bounces-147608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665079DA9DC
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 15:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBDB281BD5
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 14:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117A71EE017;
	Wed, 27 Nov 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osZSv+MK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E226AD0
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717846; cv=none; b=FWaGr9ZOmDeTRmgcSCME3ghkQ0CCLKKfDyScYyJa1PR61mPZveH2qXvj7S+pWCjCDg1osKUNOD1gVYKF8+bK5VSn0QZPUyC84mTlI3NO6AhgbZQd3M5ARp0nB7k6ohnHdva7ApSB4oUJ/H7+hruRE/iAl+RaV3meylJWgCmd2Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717846; c=relaxed/simple;
	bh=gabJc14qI98r3iYwf9OLwqwGgzoGMAk8qZ+OWAp7a4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzlkD/lzVBd8kcbsFiw6wy8yTaFE5PjLYrUmSZ9cYVyA96pMqFbak788Rdy1kJGRtOZhhYhnl499K6lxIA3njTeD8vzqU+LRlo/WV3yD5cBuod8ihMdcIodjFUEPODU/MZmf2wtwk/pYuOYq78+rDQIgCr5Qwz66MrUqAE6yphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osZSv+MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D59C4CECC;
	Wed, 27 Nov 2024 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732717845;
	bh=gabJc14qI98r3iYwf9OLwqwGgzoGMAk8qZ+OWAp7a4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=osZSv+MK7P629cZa/iC/EL/TQsCqaSRU1Sj8mkeTz41IFszj5YdPWAyxRHgKMnOY+
	 473+wmt1cgL0cg0TAp48mDlZrucyBA/FuFsahtFvLx3z3qyWgkFKG4ppYCrt81XBtQ
	 WqsArbOdL1+PM9hGfiuj/zeM+4Ey5OPqATt9rIRn9JiPKK9zYjVpYVK/99A7jAHdsR
	 tctUEvkHxo4+v4/D2ZLCdvmkirEgEkJXmppjJuVUpesSwPPmmhqzVEGlElJFPxA7Up
	 zAurm1NFEL303n0oiIyTDhV8vbuJKyZ5ZtxTIwHmXjKIt0TcsoX2JgAXOE6tlllQ8D
	 bd5wLtcNCYgnA==
Date: Wed, 27 Nov 2024 15:30:42 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Til Kaiser <mail@tk154.de>, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, netdev@vger.kernel.org,
	amcohen@nvidia.com, aleksander.lobakin@intel.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net] mediathek: mtk_eth_soc: fix netdev inside
 xdp_rxq_info
Message-ID: <Z0ctEh1TztEI-CqR@lore-desk>
References: <20241126134707.253572-1-mail@tk154.de>
 <20241126134707.253572-2-mail@tk154.de>
 <Z0YQYKgUyLt8w4va@lore-desk>
 <Z0cfOzsujtoxO422@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yv+pDc+w4AptjvEm"
Content-Disposition: inline
In-Reply-To: <Z0cfOzsujtoxO422@shredder>


--Yv+pDc+w4AptjvEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Nov 26, 2024 at 07:16:00PM +0100, Lorenzo Bianconi wrote:
> > > Currently, the network device isn't set inside the xdp_rxq_info
> > > of the mtk_rx_ring, which means that an XDP program attached to
> > > the Mediathek ethernet driver cannot retrieve the index of the
> > > interface that received the package since it's always 0 inside
> > > the xdp_md struct.
> > >=20
> > > This patch sets the network device pointer inside the
> > > xdp_rxq_info struct, which is later used to initialize
> > > the xdp_buff struct via xdp_init_buff.
> > >=20
> > > This was tested using the following eBPF/XDP program attached
> > > to a network interface of the mtk_eth_soc driver. As said before,
> > > ingress_ifindex always had a value of zero. After applying the
> > > patch, ingress_ifindex holds the correct interface index.
> > >=20
> > > 	#include <linux/bpf.h>
> > > 	#include <bpf/bpf_helpers.h>
> > >=20
> > > 	SEC("pass")
> > > 	int pass_func(struct xdp_md *xdp) {
> > >     		bpf_printk("ingress_ifindex: %u",
> > > 			xdp->ingress_ifindex);
> > >=20
> > > 		return XDP_PASS;
> > > 	}
> > >=20
> > > 	char _license[] SEC("license") =3D "GPL";
> > >=20
> > > Signed-off-by: Til Kaiser <mail@tk154.de>
> > > ---
> > >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/ne=
t/ethernet/mediatek/mtk_eth_soc.c
> > > index 53485142938c..9c6d4477e536 100644
> > > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > @@ -2069,6 +2069,7 @@ static int mtk_poll_rx(struct napi_struct *napi=
, int budget,
> > > =20
> > >  		netdev =3D eth->netdev[mac];
> > >  		ppe_idx =3D eth->mac[mac]->ppe_idx;
> > > +		ring->xdp_q.dev =3D netdev;
> >=20
> > I guess you can set it just before running xdp_init_buff(), but the cha=
nge is fine.
>=20
> Lorenzo, is it legitimate to change rxq->dev post registration like
> that?
>=20
> I am asking because we have a similar problem [1]. In our case we also
> register the rxq structure with a dummy netdev which is why XDP programs
> see an ifindex of 0.

to be honest I was thinking about it but I guess the dev pointer is just us=
ed
running the eBPF program.
@Jesper: any concern?

Regards,
Lorenzo

>=20
> Thanks
>=20
> [1] https://lore.kernel.org/netdev/ZzYR2ZJ1mGRq12VL@shredder/
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > > =20
> > >  		if (unlikely(test_bit(MTK_RESETTING, &eth->state)))
> > >  			goto release_desc;
> > > --=20
> > > 2.47.1
> > >=20
> > >=20
>=20
>=20

--Yv+pDc+w4AptjvEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ0ctEgAKCRA6cBh0uS2t
rEygAP9clpoCzhThCFaZot8B50da2ALETGsiEI0hQ/A87J2n2gD9E5JPWgbJQDRh
qIMZODxcS1ZmTnX5WTrLKjew8ZO25gw=
=Gt7l
-----END PGP SIGNATURE-----

--Yv+pDc+w4AptjvEm--

