Return-Path: <netdev+bounces-235740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD460C34700
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 09:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446EC3BE595
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BEA2566E2;
	Wed,  5 Nov 2025 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj4R6jbm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CDA2135D7
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330710; cv=none; b=V0tiMneGstpYH/nPlmZb23CnkdzZE8DcVdZB+/ZB5nfGBGbyc2t4EKwJVItuDL7vK1ltOeIqGsO+uY6zI3sNqW+z740xrsVIU2QLcbxC3pndzNCLHCStqOMyFAeofg4s0kTakK+1i8cXOGKn4P+7PM0eAo7vC30KoktTQCDZN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330710; c=relaxed/simple;
	bh=6dm2AKzAebown1VDbZeg2XcaDBZxitJGUDcB4OCfOSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpWIwP5gW2BmxF/7ptuh3EEG3ZsPBnK5Tob0VSLZWzUL3eWnsI+p+vOflKPj2R7Oel2j89z26RtWuxDeCiujmp8yP6pXB/DPQu2aJKQOFAvwpD4Vls7OnH6y/XeE7ouON9K/SkEyUUAsMEFMEHMTEPhr6PjtUCJ/I+F1hQLJoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj4R6jbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC00C4CEF8;
	Wed,  5 Nov 2025 08:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762330710;
	bh=6dm2AKzAebown1VDbZeg2XcaDBZxitJGUDcB4OCfOSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mj4R6jbmdeurLRtVZDcDkzqUdRr+Gc1azx+5dE8nELWTapqWHnFWY19NgW7t1r/QV
	 bb9lTheuUfK/V+i7acJlOTc754Jwlw2YxSnEQGbkmWqGi1yvvrg890JUZH26GnPlfO
	 PTaIcKPL1gtbpntu4A7bn1sE+/3+EDkt2sUDw698vwXQFx9kUtj5Nx796THHRuIAyq
	 EMr+jX9CVzPyq6ZSJvekb52iIAPkREpXkJZd/zzTeOh41DtpnMTAEP3DPWmNc4K/Pu
	 RSbdzcc89+v+cKZyGR08dp8RSoi7E3RJwIkM3RY66yb6V6nxu1keCW4+agmgvUXSui
	 DnQ0AakHat1Kw==
Date: Wed, 5 Nov 2025 09:18:27 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next 1/2] net: airoha: Add the capability to consume
 out-of-order DMA tx descriptors
Message-ID: <aQsIUzZOJxMV5UDP@lore-desk>
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
 <20251103-airoha-tx-linked-list-v1-1-baa07982cc30@kernel.org>
 <20251104183028.7412aba6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hS5bIEDocn2WJRXk"
Content-Disposition: inline
In-Reply-To: <20251104183028.7412aba6@kernel.org>


--hS5bIEDocn2WJRXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 04, Jakub Kicinski wrote:
> On Mon, 03 Nov 2025 11:27:55 +0100 Lorenzo Bianconi wrote:
> > +		__list_del_entry(&e->list);
> > +		list_add_tail(&e->list, &tx_list);
>=20
> list_move_tail()

ack, I will fix it in v2.

>=20
> > +		e->skb =3D i ? NULL : skb;
> > +		e->dma_addr =3D addr;
> > +		e->dma_len =3D len;
> > +
> > +		e =3D list_first_entry(&q->tx_list, struct airoha_queue_entry,
> > +				     list);
> > +		index =3D e - q->entry;
> > =20
> >  		val =3D FIELD_PREP(QDMA_DESC_LEN_MASK, len);
> >  		if (i < nr_frags - 1)
>=20
> > @@ -2029,10 +2020,14 @@ static netdev_tx_t airoha_dev_xmit(struct sk_bu=
ff *skb,
> >  	return NETDEV_TX_OK;
> > =20
> >  error_unmap:
> > -	for (i--; i >=3D 0; i--) {
> > -		index =3D (q->head + i) % q->ndesc;
> > -		dma_unmap_single(dev->dev.parent, q->entry[index].dma_addr,
> > -				 q->entry[index].dma_len, DMA_TO_DEVICE);
> > +	while (!list_empty(&tx_list)) {
> > +		e =3D list_first_entry(&tx_list, struct airoha_queue_entry,
> > +				     list);
> > +		__list_del_entry(&e->list);
> > +		dma_unmap_single(dev->dev.parent, e->dma_addr, e->dma_len,
> > +				 DMA_TO_DEVICE);
> > +		e->dma_addr =3D 0;
> > +		list_add_tail(&e->list, &q->tx_list);
>=20
> and here

ack, I will fix it in v2.

Regards,
Lorenzo

--hS5bIEDocn2WJRXk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQsIUwAKCRA6cBh0uS2t
rPJkAP4yzuHDQ7sWyCbkzqc+ZXYnrez5YP0v+l941SBgBN0fegD/TwBE8obRX0zg
zcgzcaEMDgJ/ETRCP9t2SZonYUps0Qk=
=lBxi
-----END PGP SIGNATURE-----

--hS5bIEDocn2WJRXk--

