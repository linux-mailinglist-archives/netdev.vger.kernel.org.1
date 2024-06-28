Return-Path: <netdev+bounces-107629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7AC91BC22
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4641F24123
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE38154420;
	Fri, 28 Jun 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCjyulV9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69221459EF;
	Fri, 28 Jun 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568974; cv=none; b=ON2MNT0X/zOiM82ilCwl0Ayu8T4sL2BwFZmVgbszvezaRgM9qBjYgJdwyQ3tAZOvisRTZq5ThfziaGiMDt0zQB7KIn+/3fh6QUpBFm8N2uyJUP1rtIpAJUKBlGfiCweM25rCV6NoBdJl009xW341IBiFmG6FhAK4WvnYg7GQEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568974; c=relaxed/simple;
	bh=jiFPVUfAcIKMn6WDI6i9qyP/OgFfM/mlIX6tdgddFhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2lY/nnjdYmkLZEuFp1cEvalz2ZMMH+J+8chzxepDYX7Q/p8dL7MR76cvXIkPZcXfrX6NyeZN/I7UH3Xd1J2PPhAwu29/zzyyrzBCjXEQ0tC7zY8zIDFdZUW4mXO9NN55r+661BclNZl59ueiABUEk6phut0uQO4uDyUOrhkNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCjyulV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A78C116B1;
	Fri, 28 Jun 2024 10:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719568974;
	bh=jiFPVUfAcIKMn6WDI6i9qyP/OgFfM/mlIX6tdgddFhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCjyulV93M6kXUjwpAQW00s6xkQM5L5wKVKBDUyUYbWwX5PzLtpU8RX9NDuNH7bhO
	 cgS1QMsyhzjMyqU2sMhCo2Nm+MNdwQSjqYiXWzbtvquIZlIo9NK+Um5xoU6DJq8sNm
	 3unmeiYihlJi1bRIPCNvK2+pKc34CP0///31HWmDscm3ljzrOuXmDzKSso6HepwVHi
	 yp/cS5UPruLGCqotCGzJbb4KKuBG8DARGs6HxEeSZBZE8WAW9lkeX8RQYXFxy5ZZ8e
	 Wtw+YWgmxA0WbzCZcikXrZMKLH5Q+vhUSpwddxFZdyCx59dI0e8D8fuX+XNZyEOM0X
	 EN8CxergqwRPg==
Date: Fri, 28 Jun 2024 12:02:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <Zn6KSozhjs66srE4@lore-desk>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
 <20240626201835.GD3104@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e+3Eo9XAQAJ7OiV8"
Content-Disposition: inline
In-Reply-To: <20240626201835.GD3104@kernel.org>


--e+3Eo9XAQAJ7OiV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Jun 23, 2024 at 06:19:57PM +0200, Lorenzo Bianconi wrote:
> > Add airoha_eth driver in order to introduce ethernet support for
> > Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> > en7581-evb networking architecture is composed by airoha_eth as mac
> > controller (cpu port) and a mt7530 dsa based switch.
> > EN7581 mac controller is mainly composed by Frame Engine (FE) and
> > QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> > functionalities are supported now) while QDMA is used for DMA operation
> > and QOS functionalities between mac layer and the dsa switch (hw QoS is
> > not available yet and it will be added in the future).
> > Currently only hw lan features are available, hw wan will be added with
> > subsequent patches.
> >=20
> > Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Hi Lorenzo,
>=20
> Some minor nits from my side.

Hi Simon,

thx for the review.

>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/e=
thernet/mediatek/airoha_eth.c
>=20
> ...
>=20
> > +#define airoha_fe_rr(eth, offset)		airoha_rr((eth)->fe_regs, (offset))
> > +#define airoha_fe_wr(eth, offset, val)		airoha_wr((eth)->fe_regs, (off=
set), (val))
> > +#define airoha_fe_rmw(eth, offset, mask, val)	airoha_rmw((eth)->fe_reg=
s, (offset), (mask), (val))
> > +#define airoha_fe_set(eth, offset, val)		airoha_rmw((eth)->fe_regs, (o=
ffset), 0, (val))
> > +#define airoha_fe_clear(eth, offset, val)	airoha_rmw((eth)->fe_regs, (=
offset), (val), 0)
> > +
> > +#define airoha_qdma_rr(eth, offset)		airoha_rr((eth)->qdma_regs, (offs=
et))
> > +#define airoha_qdma_wr(eth, offset, val)	airoha_wr((eth)->qdma_regs, (=
offset), (val))
> > +#define airoha_qdma_rmw(eth, offset, mask, val)	airoha_rmw((eth)->qdma=
_regs, (offset), (mask), (val))
> > +#define airoha_qdma_set(eth, offset, val)	airoha_rmw((eth)->qdma_regs,=
 (offset), 0, (val))
> > +#define airoha_qdma_clear(eth, offset, val)	airoha_rmw((eth)->qdma_reg=
s, (offset), (val), 0)
>=20
> nit: Please consider line-wrapping the above so lines are 80 columns wide
>      or less, which is still preferred in Networking code.
>=20
>      Flagged by checkpatch.pl --max-line-length=3D80

ack, I will fix it in v4.

>=20
> ...
>=20
> > +static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
> > +				   struct net_device *dev)
> > +{
> > +	struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > +	struct airoha_eth *eth =3D netdev_priv(dev);
> > +	int i, qid =3D skb_get_queue_mapping(skb);
> > +	u32 nr_frags, msg0 =3D 0, msg1;
> > +	u32 len =3D skb_headlen(skb);
> > +	struct netdev_queue *txq;
> > +	struct airoha_queue *q;
> > +	void *data =3D skb->data;
> > +	u16 index;
> > +
> > +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL)
> > +		msg0 |=3D FIELD_PREP(QDMA_ETH_TXMSG_TCO_MASK, 1) |
> > +			FIELD_PREP(QDMA_ETH_TXMSG_UCO_MASK, 1) |
> > +			FIELD_PREP(QDMA_ETH_TXMSG_ICO_MASK, 1);
> > +
> > +	/* TSO: fill MSS info in tcp checksum field */
> > +	if (skb_is_gso(skb)) {
> > +		if (skb_cow_head(skb, 0))
> > +			goto error;
> > +
> > +		if (sinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
> > +			tcp_hdr(skb)->check =3D cpu_to_be16(sinfo->gso_size);
>=20
> Probably we could do better with an appropriate helper - perhaps
> there is one I couldn't find one - but I think you need a cast here
> to keep Sparse happy.
>=20
> Something like this (completely untested!):
>=20
> 			tcp_hdr(skb)->check =3D
> 				(__force __sum16)cpu_to_be16(sinfo->gso_size);
>=20
> ...

ack, I will fix it in v4.

>=20
> > +static int airoha_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	struct net_device *dev;
> > +	struct airoha_eth *eth;
> > +	int err;
> > +
> > +	dev =3D devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*eth),
> > +				      AIROHA_NUM_TX_RING, AIROHA_NUM_RX_RING);
> > +	if (!dev) {
> > +		dev_err(&pdev->dev, "alloc_etherdev failed\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	eth =3D netdev_priv(dev);
> > +	eth->net_dev =3D dev;
> > +
> > +	err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > +	if (err) {
> > +		dev_err(&pdev->dev, "failed configuring DMA mask\n");
> > +		return err;
> > +	}
> > +
> > +	eth->fe_regs =3D devm_platform_ioremap_resource_byname(pdev, "fe");
> > +	if (IS_ERR(eth->fe_regs))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(eth->fe_regs),
> > +				     "failed to iomap fe regs\n");
> > +
> > +	eth->qdma_regs =3D devm_platform_ioremap_resource_byname(pdev, "qdma0=
");
> > +	if (IS_ERR(eth->qdma_regs))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(eth->qdma_regs),
> > +				     "failed to iomap qdma regs\n");
> > +
> > +	eth->rsts[0].id =3D "fe";
> > +	eth->rsts[1].id =3D "pdma";
> > +	eth->rsts[2].id =3D "qdma";
> > +	err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev,
> > +						    ARRAY_SIZE(eth->rsts),
> > +						    eth->rsts);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "failed to get bulk reset lines\n");
> > +		return err;
> > +	}
> > +
> > +	eth->xsi_rsts[0].id =3D "xsi-mac";
> > +	eth->xsi_rsts[1].id =3D "hsi0-mac";
> > +	eth->xsi_rsts[2].id =3D "hsi1-mac";
> > +	eth->xsi_rsts[3].id =3D "hsi-mac";
> > +	eth->xsi_rsts[4].id =3D "xfp-mac";
> > +	err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev,
> > +						    ARRAY_SIZE(eth->xsi_rsts),
> > +						    eth->xsi_rsts);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "failed to get bulk xsi reset lines\n");
> > +		return err;
> > +	}
> > +
> > +	spin_lock_init(&eth->irq_lock);
> > +	eth->irq =3D platform_get_irq(pdev, 0);
> > +	if (eth->irq < 0) {
> > +		dev_err(&pdev->dev, "failed reading irq line\n");
>=20
> Coccinelle says:
>=20
> .../airoha_eth.c:1698:2-9: line 1698 is redundant because platform_get_ir=
q() already prints an error
>=20
> ...

ack, I will fix it in v4.

>=20
> > +const struct of_device_id of_airoha_match[] =3D {
> > +	{ .compatible =3D "airoha,en7581-eth" },
> > +	{ /* sentinel */ }
> > +};
>=20
> of_airoha_match appears to only be used in this file.
> If so, it should be static.
>=20
> Flagged by Sparse.

ack, I will fix it in v4.

>=20
> > +
> > +static struct platform_driver airoha_driver =3D {
> > +	.probe =3D airoha_probe,
> > +	.remove_new =3D airoha_remove,
> > +	.driver =3D {
> > +		.name =3D KBUILD_MODNAME,
> > +		.of_match_table =3D of_airoha_match,
> > +	},
> > +};
> > +module_platform_driver(airoha_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
> > +MODULE_DESCRIPTION("Ethernet driver for Airoha SoC");
>=20
> > diff --git a/drivers/net/ethernet/mediatek/airoha_eth.h b/drivers/net/e=
thernet/mediatek/airoha_eth.h
> > new file mode 100644
> > index 000000000000..f7b984be4d60
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mediatek/airoha_eth.h
> > @@ -0,0 +1,793 @@
> > +// SPDX-License-Identifier: GPL-2.0
>=20
> The correct SPDX header comment style for .h (but not .c) files is /* ...=
  */
>=20
> https://docs.kernel.org/6.9/process/license-rules.html#license-identifier=
-syntax
>=20
> Flagged by checkpatch

ack, I will fix it in v4.

Regards,
Lorenzo

>=20
> ...

--e+3Eo9XAQAJ7OiV8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZn6KSgAKCRA6cBh0uS2t
rGJ8AQD3G9lp8IHykdYv3sLwTWr49MR1p7EkrSS0nfbzZa7TtgD/XjGBC7a09mAF
1MaemfHggrjMVX0/U39CmwLK7kYJBw0=
=oLs8
-----END PGP SIGNATURE-----

--e+3Eo9XAQAJ7OiV8--

