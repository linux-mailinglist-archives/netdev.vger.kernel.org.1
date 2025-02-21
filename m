Return-Path: <netdev+bounces-168476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264FEA3F1D3
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053163AB9D6
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC63205AC4;
	Fri, 21 Feb 2025 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdaAdtIt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713A1C1F2F;
	Fri, 21 Feb 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133261; cv=none; b=JyWIHv0JV40BZsawuP3CjIjxY8/+V7Obs2Ucy7HyjY3M/W8MNgl0ITIr8eF5Fhs5mhb51agRBOafoPDk2W9ehAG47PTqy+AW+U9XYLcsHZpC+LLK2Ovy2PG4E7bLigaa1MNz2jE92eW+yvcBK8WoLF8lFzPdRmlp4ReAxtmghJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133261; c=relaxed/simple;
	bh=fUVaLTqcC5c+bm4iIiTWH4PyCaBTZWkrdFfnT7KKx9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTvrJ9EIBrATUblnhgscMf/QYLq3XDQ9u5mrFvrXze3pYOoY0LzlBIe39DiFEGyHAcCu8Peka4hFUOx500M1nHufevoOyKDHhgjvT/34BUNuG+ZLKPQ0LJx1mxczesDGw8Q5CP/wYYrzUl7bQ5jMySJsYJo1+mnx8xrXntHAgWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdaAdtIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BFCC4CEE6;
	Fri, 21 Feb 2025 10:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740133261;
	bh=fUVaLTqcC5c+bm4iIiTWH4PyCaBTZWkrdFfnT7KKx9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdaAdtItOplD992wbpZNI3he2hf6xVYugM2PYF5rEGymF/G5YrQns0JZopipOO9MM
	 BoNF1OqMpjKsgq8VvcxReJithgND9W34P13mPh5P4EwMGhY6+NE1F2lakfBcXct+zx
	 VenyyKva/dTsHfQ9823wnEpvA+rUYgRZyyT21q3eb5CXVCpGLLCDEiKBu7aX1Hlzvq
	 bA3jWyMQU0fuqalK/8WChGN9CJ+VQsqQDYySlWlNJBkbe7Jnu0v8cQQGTodqdafr/Q
	 ef4u4VHGdwvWGcdRx7GFsIolkSZeJQsRok04div7TK/9JCvm+rvcfF5FzbkB0bFWeV
	 2FOQ9nNoMGgew==
Date: Fri, 21 Feb 2025 11:20:58 +0100
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
	upstream@airoha.com
Subject: Re: [PATCH net-next v5 05/15] net: airoha: Move DSA tag in DMA
 descriptor
Message-ID: <Z7hTilouR44BUuHb@lore-desk>
References: <20250217-airoha-en7581-flowtable-offload-v5-0-28be901cb735@kernel.org>
 <20250217-airoha-en7581-flowtable-offload-v5-5-28be901cb735@kernel.org>
 <20250220142535.584b0423@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5YB+kcl4xBIiQadY"
Content-Disposition: inline
In-Reply-To: <20250220142535.584b0423@kernel.org>


--5YB+kcl4xBIiQadY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 17 Feb 2025 14:01:09 +0100 Lorenzo Bianconi wrote:
> > +static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *=
dev)
> > +{
> > +#if IS_ENABLED(CONFIG_NET_DSA)
> > +	struct ethhdr *ehdr;
> > +	struct dsa_port *dp;
> > +	u8 xmit_tpid;
> > +	u16 tag;
> > +
> > +	if (!netdev_uses_dsa(dev))
> > +		return 0;
> > +
> > +	dp =3D dev->dsa_ptr;
> > +	if (IS_ERR(dp))
> > +		return 0;
> > +
> > +	if (dp->tag_ops->proto !=3D DSA_TAG_PROTO_MTK)
> > +		return 0;
> > +
> > +	if (skb_ensure_writable(skb, ETH_HLEN))
> > +		return 0;
>=20
> skb_cow_head() is a lot cheaper (for TCP)

ack, I will fix it in v6

>=20
> > +	ehdr =3D (struct ethhdr *)skb->data;
> > +	tag =3D be16_to_cpu(ehdr->h_proto);
> > +	xmit_tpid =3D tag >> 8;
>=20
> > @@ -2390,8 +2498,10 @@ static int airoha_probe(struct platform_device *=
pdev)
> >  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> >  		struct airoha_gdm_port *port =3D eth->ports[i];
> > =20
> > -		if (port && port->dev->reg_state =3D=3D NETREG_REGISTERED)
> > +		if (port && port->dev->reg_state =3D=3D NETREG_REGISTERED) {
> > +			airoha_metadata_dst_free(port);
> >  			unregister_netdev(port->dev);
>=20
> Looks a tiny bit reversed, isn't it?
> First unregister the netdev, then free its metadata.

ack, I will fix it in v6

>=20
> > +		}
> >  	}
> >  	free_netdev(eth->napi_dev);
> >  	platform_set_drvdata(pdev, NULL);
> > @@ -2416,6 +2526,7 @@ static void airoha_remove(struct platform_device =
*pdev)
> >  			continue;
> > =20
> >  		airoha_dev_stop(port->dev);
> > +		airoha_metadata_dst_free(port);
> >  		unregister_netdev(port->dev);
>=20
> same here

ack, I will fix it in v6

Regards,
Lorenzo

>=20
> >  	}
> >  	free_netdev(eth->napi_dev);

--5YB+kcl4xBIiQadY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ7hTigAKCRA6cBh0uS2t
rCeUAQCB/2t2Wdyb4IQv5rKQRZKe1GYUM3uFFfEksdbnFdyb0gD/ZY1D+76DwjUj
DnnmpDydOAQ+1nCYsY5EaOgWAq9p5Qg=
=cQbl
-----END PGP SIGNATURE-----

--5YB+kcl4xBIiQadY--

